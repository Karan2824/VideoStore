using System;
using System.Windows.Forms;

namespace VideoStore
{
    public partial class VideoRentalForm : Form
    {
        //create an instance of the Database Class
        private readonly Database _myDatabase = new Database();

        public VideoRentalForm()
        {
            InitializeComponent();
            LoadData(); // Load the DGV
        }

        private void LoadData()
        {
            //load datatable columns
            DisplayDataGridViewCustomers();
            DisplayDataGridViewMovies();
            DisplayDataGridViewRentals();
            DisplayDataGridViewTopCustomer();
            DisplayDataGridViewBestMovie();
        }

        private void DisplayDataGridViewTopCustomer()
        {
            dgvTopCustomer.DataSource = null; //Clear out all old data
            try
            {
                dgvTopCustomer.DataSource = _myDatabase.FillDgvTopCustomersWithTopCustomers(_myDatabase.CustId.ToString())
                    .DefaultView;
                //pass the datatable date to the DataGridView
                dgvTopCustomer.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        public void DisplayDataGridViewBestMovie()
        {
            dgvTopMovies.DataSource = null; //clear out old data.
            try
            {
                dgvTopMovies.DataSource = _myDatabase.FillDgvTopMoviesWithMostRentedMovies(_myDatabase.MovieId.ToString())
                    .DefaultView;
                //pass the datatable data to the DataGridView
                dgvTopMovies.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DisplayDataGridViewCustomers()
        {
            //Clear out the old data
            dgvCustomers.DataSource = null;
            try
            {
                //Pass the datatable to the DataGridView
                dgvCustomers.DataSource = _myDatabase.FillDgvCustomerWithCustomers();
                dgvCustomers.AutoResizeColumns(DataGridViewAutoSizeColumnsMode.AllCells);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DisplayDataGridViewMovies()
        {
            //Clear out the old data
            dgvMovies.DataSource = null;
            try
            {
                //Pass the datatable to the DataGridView
                dgvMovies.DataSource = _myDatabase.FillDgvMoviesWithMovies();
                dgvMovies.AutoResizeColumns(DataGridViewAutoSizeColumnsMode.AllCells);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DisplayDataGridViewRentals()
        {
            //Clear out the old data
            dgvRentals.DataSource = null;
            try
            {
                //Pass the datatable to the DataGridView

                dgvRentals.DataSource = _myDatabase.FillDgvRentalsWithCustomerAndMoviesRented(rbOutCurrently.Checked);
                dgvRentals.AutoResizeColumns(DataGridViewAutoSizeColumnsMode.AllCells);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void rbAllRented_CheckedChanged(object sender, EventArgs e)
        {
            LoadData();
        }

        private void rbOutCurrently_CheckedChanged(object sender, EventArgs e)
        {
            // If radio button out currently is checked return movies not returned
            LoadData();
        }

        // sends data from datagridview to the textboxes
        private void dgvCustomers_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // the cell clicks for the values in the row that you click on
            try
            {
                _myDatabase.CustId = (int)dgvCustomers.Rows[e.RowIndex].Cells[0].Value;
                lblCustID.Text = _myDatabase.CustId.ToString();
                txtFirstName.Text = dgvCustomers.Rows[e.RowIndex].Cells[1].Value.ToString();
                txtLastName.Text = dgvCustomers.Rows[e.RowIndex].Cells[2].Value.ToString();
                txtAddress.Text = dgvCustomers.Rows[e.RowIndex].Cells[3].Value.ToString();
                txtPhone.Text = dgvCustomers.Rows[e.RowIndex].Cells[4].Value.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        // sends data from datagridview to the textboxes
        private void dgvMovies_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // the cell clicks for the values in the row that you click on
            try
            {
                //NOTE I have changed the default table cell column positions to: Title =1, Genre =2, Rating =3, Year =4, Plot =5, Rental_Cost =6, Copies =7
                _myDatabase.MovieId = (int)dgvMovies.Rows[e.RowIndex].Cells[0].Value;
                lblMovieID.Text = _myDatabase.MovieId.ToString();
                txtTitle.Text = dgvMovies.Rows[e.RowIndex].Cells[1].Value.ToString();
                txtGenre.Text = dgvMovies.Rows[e.RowIndex].Cells[2].Value.ToString();
                txtYear.Text = dgvMovies.Rows[e.RowIndex].Cells[4].Value.ToString();
                txtRating.Text = dgvMovies.Rows[e.RowIndex].Cells[3].Value.ToString();
                txtPlot.Text = dgvMovies.Rows[e.RowIndex].Cells[5].Value.ToString();
                txtCopies.Text = dgvMovies.Rows[e.RowIndex].Cells[7].Value.ToString();
                txtRentalPrice.Text = dgvMovies.Rows[e.RowIndex].Cells[6].Value.ToString();
                txtRentalPrice.Text = @"$" + _myDatabase.GetRentalCost(txtYear.Text) + @".00";
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        //Sends data from data grid view to label
        private void dgvRentals_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                _myDatabase.Rmid = (int)dgvRentals.Rows[e.RowIndex].Cells[0].Value;
                lblRMID.Text = _myDatabase.Rmid.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        // Customers Add button
        private void btnAddCustomer_Click(object sender, EventArgs e)
        {
            if (txtFirstName.Text != string.Empty &&
                txtLastName.Text != string.Empty && txtAddress.Text != string.Empty && txtPhone.Text != string.Empty)
                MessageBox.Show(_myDatabase.AddOrUpdateCustomer(lblCustID.Text, txtFirstName.Text,
                    txtLastName.Text, txtAddress.Text, txtPhone.Text, btnAddCustomer.Text));
            else
                MessageBox.Show(@"Fill in Customer data!!");

            LoadData();
        }

        // Customers update button
        private void btnUpdateCustomer_Click(object sender, EventArgs e)
        {
            MessageBox.Show(_myDatabase.AddOrUpdateCustomer(lblCustID.Text, txtFirstName.Text,
                txtLastName.Text, txtAddress.Text, txtPhone.Text, btnUpdateCustomer.Text));
            LoadData();
        }

        // Customers delete button
        private void btnDeleteCustomer_Click(object sender, EventArgs e)
        {
            MessageBox.Show(_myDatabase.DeleteCustomer(lblCustID.Text, btnDeleteCustomer.Text));
            tabRentalSystem.SelectedIndex = 0;
            LoadData();
        }

        // Movies add button
        private void btnAddMovie_Click(object sender, EventArgs e)
        {
            MessageBox.Show(_myDatabase.AddOrUpdateMovie(lblMovieID.Text, txtTitle.Text, txtGenre.Text,
                txtYear.Text, txtRating.Text, txtPlot.Text, txtCopies.Text,
                btnAddMovie.Text));
            tabRentalSystem.SelectedIndex = 1;
            LoadData();
        }

        // movies update button
        private void btnUpdateMovie_Click(object sender, EventArgs e)
        {
            MessageBox.Show(_myDatabase.AddOrUpdateMovie(lblMovieID.Text, txtTitle.Text, txtGenre.Text,
                txtYear.Text, txtRating.Text, txtPlot.Text, txtCopies.Text,
                btnUpdateMovie.Text));
            tabRentalSystem.SelectedIndex = 1;
            LoadData();
        }

        // movies delete button
        private void btnDeleteMovie_Click(object sender, EventArgs e)
        {
            MessageBox.Show(_myDatabase.DeleteMovies(lblMovieID.Text, btnDeleteCustomer.Text));
            tabRentalSystem.SelectedIndex = 1;
            LoadData();
        }

        private void btnIssueMovie_Click(object sender, EventArgs e)
        {
            if (lblCustID.Text != @"0" && lblMovieID.Text != @"0")

            {
                _myDatabase.Today = DateTime.Now;
                MessageBox.Show(txtFirstName.Text + string.Empty + txtLastName.Text + @" Date: " + _myDatabase.Today +
                                @" " +
                                _myDatabase.IssueMovie(lblMovieID.Text, lblCustID.Text, _myDatabase.Today));

                tabRentalSystem.SelectedIndex = 2;
                LoadData();
            }
            else
            {
                MessageBox.Show(@"Please select a customer and movie");
            }

            LoadData();
            //reset customer fields
            lblCustID.Text = @"0";
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtPhone.Text = string.Empty;

            //reset movie fields
            lblMovieID.Text = @"0";
            txtTitle.Text = string.Empty;
            txtGenre.Text = string.Empty;
            txtYear.Text = string.Empty;
            txtRating.Text = string.Empty;
            txtPlot.Text = string.Empty;
            txtCopies.Text = string.Empty;
            txtRentalPrice.Text = string.Empty;
        }

        private void btnReturnMovie_Click(object sender, EventArgs e)
        {
            if (lblDateReturned.Text == string.Empty && lblRMID.Text != @"0")
                MessageBox.Show(@"Rental Id: " + lblRMID.Text + string.Empty +
                                _myDatabase.ReturnMovie(lblRMID.Text, _myDatabase.Today));
            else
                MessageBox.Show(@"Fail");
            LoadData();
            lblRMID.Text = @"0";
        }
    }
}