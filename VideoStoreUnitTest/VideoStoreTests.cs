using VideoStore;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data;

namespace VideoStoreUnitTest
{
    [TestClass]
    public class VideoStoreTests
    {
        //create an instance of the Database Class
        private readonly Database _myDatabase = new Database();

        //Testing the connection to the database is getting data
        [TestMethod]
        public void TestConnection()
        {
            Assert.IsInstanceOfType(_myDatabase.FillDgvCustomerWithCustomers(), typeof(DataTable));
        }

        //Testing the cost is $2 if the release year is more than 5 years ago
        [TestMethod]
        public void TestRentalCostOld()
        {
            var oldDate = DateTime.Today.AddYears(-6).Year.ToString();
            Assert.AreEqual(2, _myDatabase.GetRentalCost(oldDate));
        }

        //Testing the rental cost is $5 if thw release year is less than 5 years ago
        [TestMethod]
        public void TestRentalCostNew()
        {
            var newDate = DateTime.Today.AddYears(2).Year.ToString();
            Assert.AreEqual(5, _myDatabase.GetRentalCost(newDate));
        }
    }
}