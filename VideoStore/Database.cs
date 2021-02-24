using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace VideoStore
{
    public class Database
    {
        //Create connection and Command and an Adapter
        private readonly SqlCommand _command = new SqlCommand();
        private readonly SqlConnection _connection = new SqlConnection();
        private SqlDataAdapter _da = new SqlDataAdapter();

        // constructor sets the default upon loading the class
        public Database()
        {
            //change the connection string to your db
            var connectionString =
                @"Data Source=KARAN\SQLEXPRESS;Initial Catalog=VideoRental;Integrated Security=True";
            _connection.ConnectionString = connectionString;
            _command.Connection = _connection;
        }

        //PROPERTIES
        public int CustId { get; set; }

        public int MovieId { get; set; }
        public int Rmid { get; set; }
        public DateTime Today { get; set; }

        //Takes all data from Customers
        public DataTable FillDgvCustomerWithCustomers()
        {
            //Create a datatable
            var dt = new DataTable();
            using (_da = new SqlDataAdapter("SELECT * from Customer", _connection))
            {
                //Get results of query
                _connection.Open();
                //Fill the table from the Database
                _da.Fill(dt);
                //Close the connection
                _connection.Close();
            }

            return dt;
        }

        //Takes all data from Movies
        public DataTable FillDgvMoviesWithMovies()
        {
            //Create a datatable
            var dt = new DataTable();
            using (_da = new SqlDataAdapter("SELECT * from Movies", _connection))
            {
                //Get results of query
                _connection.Open();
                //Fill the table from the Database
                _da.Fill(dt);
                //Close the connection
                _connection.Close();
            }

            return dt;
        }

        //Takes all data from Rented Movies
        public DataTable FillDgvRentalsWithCustomerAndMoviesRented(bool outonly)
        {
            //create a datatable
            var dt = new DataTable();
            //If the radio button is pressed
            string sqlQuery;
            if (outonly)
                sqlQuery = "SELECT * FROM CustomersAndMoviesRented WHERE DateReturned IS NULL";
            else
                sqlQuery = "SELECT * FROM CustomersAndMoviesRented";
            using (_da = new SqlDataAdapter(sqlQuery, _connection))
            {
                //Get results of query
                _connection.Open();
                //Fill the table from the Database
                _da.Fill(dt);
                //Close the connection
                _connection.Close();
            }

            return dt;
        }

        //Fill TopCustomers with TopCustomers View method
        public DataTable FillDgvTopCustomersWithTopCustomers(string totalRented)
        {
            var dt = new DataTable();

            using (var objCommand =
                new SqlCommand(
                    "SELECT CustID, [First Name], [Last Name], [Total Rented] FROM TopCustomers ORDER BY [Total Rented] DESC",
                    _connection))
            {
                objCommand.Parameters.AddWithValue("@CustID", totalRented);
                _connection.Open();
                var reader = objCommand.ExecuteReader();
                if (reader.HasRows) dt.Load(reader);
                _connection.Close();
            }

            return dt;
        }

        //Fill TopMovies with TopMovies View method
        public DataTable FillDgvTopMoviesWithMostRentedMovies(string totalTimesRented) //get best selling movies method
        {
            var dt = new DataTable();
            using (var objCommand =
                new SqlCommand("SELECT MovieID, [Movie Title], [Total Times Rented] FROM MostRentedMovies",
                    _connection))
            {
                objCommand.Parameters.AddWithValue("@MovieID", totalTimesRented);
                _connection.Open();
                var reader = objCommand.ExecuteReader();
                if (reader.HasRows) dt.Load(reader);
                reader.Close();
                _connection.Close();
            }

            return dt;
        }

        public string AddOrUpdateCustomer(string custId, string firstName, string lastName, string address,
            string phone, string addOrUpdate)
        {
            try
            {
                //Add gets passed through the parameter
                if (addOrUpdate == "Add")
                    //Create a query and open a connection to SQL Server
                    using (var queryCommand = new SqlCommand(
                        "INSERT INTO Customer (FirstName, LastName, Address, Phone)" +
                        " VALUES (@FirstName, @LastName, @Address, @Phone)", _connection))
                    {
                        //use parameters to prevent SQL injections
                        queryCommand.Parameters.AddWithValue("@FirstName", firstName);
                        queryCommand.Parameters.AddWithValue("@LastName", lastName);
                        queryCommand.Parameters.AddWithValue("@Address", address);
                        queryCommand.Parameters.AddWithValue("@Phone", phone);
                        //create and open DB Connection
                        _connection.Open();
                        // add in the SQL
                        queryCommand.ExecuteNonQuery();
                        _connection.Close();
                    }

                // update gets passed through the parameter
                else if (addOrUpdate == "Update")
                    //Create a object and open a connection to SQL Server
                    using (var objCommand = new SqlCommand("UPDATE Customer" +
                                                           " set FirstName = @FirstName, LastName = @LastName, Address = @Address, Phone = @Phone " +
                                                           " where CustID = @CustID", _connection))
                    {
                        //use parameters to prevent SQL injections
                        objCommand.Parameters.AddWithValue("@FirstName", firstName);
                        objCommand.Parameters.AddWithValue("@LastName", lastName);
                        objCommand.Parameters.AddWithValue("@Address", address);
                        objCommand.Parameters.AddWithValue("@Phone", phone);
                        objCommand.Parameters.AddWithValue("@CustID", custId);
                        //create and open DB Connection
                        _connection.Open();
                        // add in the SQL
                        objCommand.ExecuteNonQuery();
                        _connection.Close();
                    }

                return addOrUpdate + " is Successful";
            }
            catch (Exception e)
            {
                //need to get it to close a second time it jumps the first connection.close if ExecuteNonQuery fails.
                _connection.Close();
                return " has failed with " + e;
            }
        }

        public string DeleteCustomer(string custId, string deleteCust)
        {
            try
            {
                //Delete gets passed through the parameter
                if (deleteCust == "Delete")
                {
                    //Create a object and open a connection to SQL Server
                    var queryCommand = new SqlCommand("DELETE FROM Customer" + " where CustID = @CustID", _connection);
                    //use parameters to prevent SQL injections
                    queryCommand.Parameters.AddWithValue("CustID", custId);
                    //create and open DB Connection
                    _connection.Open();
                    queryCommand.ExecuteNonQuery();
                    _connection.Close();
                }

                return " Successfully Deleted";
            }
            catch (Exception e)
            {
                //need to get it to close a second time it jumps the first connection.close if ExecuteNonQuery fails.
                _connection.Close();
                return " Failed " + e;
            }
        }

        public string AddOrUpdateMovie(string movieId, string title, string genre, string year, string rating,
            string plot, string copies, string addOrUpdate)
        {
            try
            {
                var rentalCost = GetRentalCost(year);

                //Add gets passed through the parameter
                if (addOrUpdate == "Add")
                {
                    //Create a object and open a connection to SQL Server
                    // this puts the parameters into the code so that the data in the text boxes is added to the database
                    var queryCommand = new SqlCommand(
                        "INSERT INTO Movies (Title, Genre, Year, Rating, Plot, Copies, Rental_Cost) " +
                        "VALUES  (@Title, @Genre, @Year, @Rating, @Plot, @Copies, @Rental_Cost)", _connection);

                    //use parameters to prevent SQL injections
                    queryCommand.Parameters.AddWithValue("@Title", title);
                    queryCommand.Parameters.AddWithValue("@Genre", genre);
                    queryCommand.Parameters.AddWithValue("@Year", year);
                    queryCommand.Parameters.AddWithValue("@Rating", rating);
                    queryCommand.Parameters.AddWithValue("@Plot", plot);
                    queryCommand.Parameters.AddWithValue("@Copies", copies);
                    queryCommand.Parameters.AddWithValue("@Rental_Cost", rentalCost);
                    //create and open DB Connection
                    _connection.Open();
                    queryCommand
                        .ExecuteNonQuery(); //use NonQuery as it doesn't return any data its only going up to the server
                    _connection.Close();
                }
                // Update gets passed through the parameter
                else if (addOrUpdate == "Update")
                {
                    //Create a object and open a connection to SQL Server
                    // this puts the parameters into the code so that the data in the text boxes is added to thedatabase
                    var queryCommand =
                        new SqlCommand(
                            "UPDATE Movies" +
                            " set Title = @Title, Genre = @Genre, Year = @Year, Rating = @Rating, Plot = @Plot, Copies = @Copies, Rental_Cost = @Rental_Cost" +
                            " where MovieID = @MovieID", _connection);
                    //use parameters to prevent SQL injections
                    queryCommand.Parameters.AddWithValue("@Title", title);
                    queryCommand.Parameters.AddWithValue("@Genre", genre);
                    queryCommand.Parameters.AddWithValue("@Year", year);
                    queryCommand.Parameters.AddWithValue("@Rating", rating);
                    queryCommand.Parameters.AddWithValue("@Plot", plot);
                    queryCommand.Parameters.AddWithValue("@Copies", copies);
                    queryCommand.Parameters.AddWithValue("@Rental_Cost", rentalCost);
                    queryCommand.Parameters.AddWithValue("@MovieID", movieId);
                    //create and open DB Connection
                    _connection.Open();
                    queryCommand
                        .ExecuteNonQuery(); //use NonQuery as it doesn't return any data its only going up to the server
                    _connection.Close(); // close connection to DB
                }

                return addOrUpdate + " Successful";
            }
            catch (Exception e)
            {
                //need to get it to close a second time it jumps the first connection.close if ExecuteNonQuery fails.
                _connection.Close();
                return " has failed with " + e;
            }
        }

        public string DeleteMovies(string movieId, string deleteMovie)
        {
            try
            {
                if (deleteMovie == "Delete")
                    //Create a object and open a connection to SQL Server
                    // this puts the parameters into the code so that the data in the text boxes is added to thedatabase
                    using (var objCommand =
                        new SqlCommand("DELETE FROM Movies" + " where MovieID = @MovieID", _connection))
                    {
                        // create params to prevent SQL injections
                        objCommand.Parameters.AddWithValue("@MovieID", movieId);
                        //create and open DB Connection
                        _connection.Open();
                        objCommand
                            .ExecuteNonQuery(); //use NonQuery as it doesn't return any data its only going up to the server
                        _connection.Close(); //close connection to DB
                    }

                return " Movie ID #" + movieId + " Successfully Deleted";
            }
            catch (Exception e)
            {
                // need to get it to close a second time if it jumps the first connection.close
                _connection.Close();
                MessageBox.Show(e.Message);
                return null;
            }
        }

        public string IssueMovie(string movieId, string custId, DateTime dateRented)
        {
            try
            {
                //Create a object and open a connection to SQL Server
                var query =
                    "INSERT INTO RentedMovies (MovieIDFK, CustIDFK, DateRented) VALUES (@MovieID, @CustID, @DateRented)";
                var queryCommand = new SqlCommand(query, _connection);
                // create params to prevent SQL injections
                queryCommand.Parameters.AddWithValue("@MovieID", movieId);
                queryCommand.Parameters.AddWithValue("@CustID", custId);
                queryCommand.Parameters.AddWithValue("@DateRented", dateRented);
                //create and open DB Connection
                _connection.Open();
                queryCommand
                    .ExecuteNonQuery(); //use NonQuery as it doesn't return any data its only going up to the server
                _connection.Close(); //close connection to the DB

                return " Movie Successfully Rented";
            }
            catch (Exception e)
            {
                // need to get it to close a second time if it jumps the first connection.close
                _connection.Close();
                return " failed " + e;
            }
        }

        public string ReturnMovie(string rmid, DateTime today)
        {
            try
            {
                Today = DateTime.Now;
                //Create a object and open a connection to SQL Server
                var query = "UPDATE RentedMovies" + " set DateReturned = @today" + " WHERE RMID = @RMID";
                var queryCommand = new SqlCommand(query, _connection);
                // create parameters to prevent SQL injections
                queryCommand.Parameters.AddWithValue("@RMID", rmid);
                queryCommand.Parameters.AddWithValue("@today", today);
                //create and open DB Connection
                _connection.Open();
                queryCommand
                    .ExecuteNonQuery(); //use NonQuery as it doesn't return any data its only going up to the server
                _connection.Close(); //close connection to DB

                return " Return is Successful";
            }
            catch (Exception e)
            {
                //need to get it to close a second time as it jumps the first connection.close if ExecuteNonQuery fails.
                _connection.Close();
                return "Return has Failed with " + e;
            }
        }

        public int GetRentalCost(string year)
        {
            //Rental cost is $2 if the release year is more than 5 years ago
            //otherwise its $5
            int target = Convert.ToInt16(year);
            int rentalCost;
            if (target > DateTime.Today.AddYears(-5).Year)
                rentalCost = 5;
            else
                rentalCost = 2;

            return rentalCost;
        }
    }
}