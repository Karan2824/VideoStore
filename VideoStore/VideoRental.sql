USE [VideoRental]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 19/2/2021 12:34:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RentedMovies]    Script Date: 19/2/2021 12:34:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentedMovies](
	[RMID] [int] IDENTITY(1,1) NOT NULL,
	[MovieIDFK] [int] NULL,
	[CustIDFK] [int] NULL,
	[DateRented] [datetime] NULL,
	[DateReturned] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 19/2/2021 12:34:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[Genre] [nvarchar](50) NULL,
	[Rating] [nvarchar](50) NULL,
	[Year] [nvarchar](255) NULL,
	[Plot] [ntext] NULL,
	[Rental_Cost] [money] NULL,
	[Copies] [nvarchar](50) NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomersAndMoviesRented]    Script Date: 19/2/2021 12:34:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomersAndMoviesRented]
AS
SELECT        TOP (100) PERCENT dbo.RentedMovies.RMID, dbo.RentedMovies.CustIDFK, dbo.RentedMovies.MovieIDFK, dbo.Movies.Title, dbo.RentedMovies.DateRented, dbo.RentedMovies.DateReturned
FROM            dbo.Customer INNER JOIN
                         dbo.RentedMovies ON dbo.Customer.CustID = dbo.RentedMovies.CustIDFK INNER JOIN
                         dbo.Movies ON dbo.RentedMovies.MovieIDFK = dbo.Movies.MovieID
GROUP BY dbo.RentedMovies.RMID, dbo.Movies.Title, dbo.RentedMovies.DateRented, dbo.RentedMovies.DateReturned, dbo.RentedMovies.CustIDFK, dbo.RentedMovies.MovieIDFK, dbo.Customer.CustID, dbo.Movies.MovieID
ORDER BY dbo.RentedMovies.DateRented
GO
/****** Object:  View [dbo].[MostRentedMovies]    Script Date: 19/2/2021 12:34:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MostRentedMovies]
AS
SELECT        TOP (1000000) dbo.RentedMovies.MovieIDFK AS MovieID, COUNT(dbo.RentedMovies.MovieIDFK) AS [Total Times Rented], dbo.Movies.Title AS [Movie Title]
FROM            dbo.Movies INNER JOIN
                         dbo.RentedMovies ON dbo.Movies.MovieID = dbo.RentedMovies.MovieIDFK INNER JOIN
                         dbo.CustomersAndMoviesRented ON dbo.RentedMovies.RMID = dbo.CustomersAndMoviesRented.RMID
GROUP BY dbo.Movies.Title, dbo.RentedMovies.MovieIDFK
ORDER BY [Total Times Rented] DESC
GO
/****** Object:  View [dbo].[TopCustomers]    Script Date: 19/2/2021 12:34:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TopCustomers]
AS
SELECT        TOP (100) PERCENT dbo.Customer.CustID, dbo.Customer.FirstName AS [First Name], dbo.Customer.LastName AS [Last Name], dbo.Customer.Phone, ISNULL
                             ((SELECT        COUNT(RMID) AS Expr1
                                 FROM            dbo.RentedMovies AS RentedMovies_1
                                 WHERE        (CustIDFK = dbo.Customer.CustID)), 0) AS [Total Rented]
FROM            dbo.Customer INNER JOIN
                         dbo.RentedMovies AS RentedMovies ON dbo.Customer.CustID = RentedMovies.CustIDFK
GROUP BY dbo.Customer.CustID, dbo.Customer.FirstName, dbo.Customer.LastName, dbo.Customer.Phone
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1, N'Clifton', N'Shelton', N'326 Academy Street', N'6722981')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (2, N'Lora ', N'Sherman', N'823 Church Street North', N'9564395')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (3, N'Dianne ', N'Shelton', N'484 4th Street North', N'2084708')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (4, N'Harlan ', N'Shields', N'111 Brook Lane', N'4434972')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (5, N'Bobbi ', N'Shannon', N'767 Route 17', N'7225220')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (6, N'Stan ', N'Short', N'875 Edgewood Drive', N'2615295')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (7, N'Leroy ', N'Shaw', N'936 Walnut Street', N'9245619')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (8, N'Tyson ', N'Shepherd', N'398 Pine Street', N'8346936')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (9, N'Laurel ', N'Short', N'955 Valley Drive', N'8406969')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (10, N'Therese ', N'Shepherd', N'226 Front Street South', N'9208849')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (11, N'Ulysses ', N'Shannon', N'529 2nd Avenue', N'5678883')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (12, N'Reuben ', N'Shaffer', N'570 Maiden Lane', N'6049232')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (13, N'Alberta ', N'Sharp', N'222 Route 1', N'5759347')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (14, N'Clara ', N'Shaw', N'807 Route 41', N'7739826')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (15, N'Hugh ', N'Silva', N'206 Main Street', N'8860054')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (16, N'Maxine ', N'Silva', N'305 Prospect Avenue', N'1371532')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (17, N'Shawn ', N'Simmons', N'130 Cooper Street', N'7642181')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (18, N'Van ', N'Singleton', N'775 Edgewood Drive', N'2582573')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (19, N'Ginger ', N'Simon', N'992 Holly Court', N'4053574')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (20, N'Laurence ', N'Simon', N'950 Maple Street', N'5374945')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (21, N'Brent ', N'Sims', N'276 Edgewood Drive', N'1166640')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (22, N'Faith ', N'Singleton', N'526 Virginia Avenue', N'7397034')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (23, N'Tina ', N'Simmons', N'864 Augusta Drive', N'5039366')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (24, N'Vanessa ', N'Sims', N'179 Mulberry Lane', N'3189437')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (25, N'Kyle ', N'Simpson', N'145 Amherst Street', N'7919511')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (26, N'Ellen ', N'Simpson', N'284 4th Street West', N'8419851')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (27, N'Reba ', N'Skinner', N'205 Creek Road', N'6646308')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (28, N'Pierre ', N'Skinner', N'713 Laurel Street', N'8139410')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (29, N'Lea ', N'Sloan', N'417 Chestnut Avenue', N'9980929')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (30, N'Maura ', N'Slater', N'997 Brookside Drive', N'8807197')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (31, N'James ', N'Smith', N'996 North Street', N'6483532')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (32, N'Benito ', N'Small', N'423 Aspen Drive', N'8504545')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (33, N'Mary ', N'Smith', N'747 19th Street', N'4628671')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (34, N'Marion ', N'Snyder', N'353 Orchard Avenue', N'5290108')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (35, N'Derrick ', N'Snyder', N'463 Summit Avenue', N'3000183')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (36, N'Adolfo ', N'Snow', N'584 1st Avenue', N'1426361')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (37, N'Maude ', N'Snow', N'156 Aspen Drive', N'4987086')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (38, N'Nina ', N'Soto', N'194 Route 2', N'8950939')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (39, N'Brianna ', N'Solomon', N'170 Oxford Road', N'3903502')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (40, N'Casey ', N'Soto', N'735 Mechanic Street', N'8994585')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (41, N'Vito ', N'Solomon', N'837 Railroad Avenue', N'7564841')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (42, N'Merrill ', N'Solis', N'623 Primrose Lane', N'6356176')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (43, N'Flossie ', N'Solis', N'608 Hilltop Road', N'9848984')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (44, N'Georgina ', N'Spears', N'894 Cherry Street', N'9151707')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (45, N'Kate ', N'Sparks', N'121 Adams Street', N'4742603')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (46, N'Derek ', N'Spencer', N'884 Academy Street', N'3712692')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (47, N'Liza ', N'Spence', N'120 Locust Street', N'3284008')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (48, N'Clay ', N'Sparks', N'121 Oak Avenue', N'8494860')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (49, N'Erich ', N'Spence', N'607 Cleveland Street', N'7488816')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (50, N'Cathy ', N'Spencer', N'149 Cross Street', N'1669859')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (51, N'Norris ', N'Stephenson', N'690 Sunset Drive', N'4220559')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (52, N'Gustavo ', N'Stokes', N'493 Linda Lane', N'9290724')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (53, N'Maricela ', N'Stout', N'767 Route 30', N'5991031')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (54, N'Dusty ', N'Stein', N'456 Cooper Street', N'8962750')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (55, N'Karl ', N'Stanley', N'370 Heritage Drive', N'6233475')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (56, N'Jamel ', N'Stout', N'661 Heritage Drive', N'3663709')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (57, N'Darrell ', N'Stephens', N'978 Railroad Street', N'9594260')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (58, N'Dianna ', N'Stokes', N'511 Country Club Drive', N'3424684')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (59, N'Ronnie ', N'Stone', N'961 Street Road', N'4315012')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (60, N'Corina ', N'Stanton', N'228 Sycamore Street', N'7515016')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (61, N'Charity ', N'Stephenson', N'889 Forest Street', N'1595456')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (62, N'Alice ', N'Stewart', N'849 Franklin Court', N'3665548')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (63, N'Monty ', N'Stafford', N'845 Heritage Drive', N'8595769')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (64, N'Gabriela ', N'Stafford', N'113 Virginia Avenue', N'1336779')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (65, N'Roderick ', N'Stevenson', N'579 Route 64', N'8476909')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (66, N'Coleen ', N'Stuart', N'789 Sycamore Lane', N'9347154')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (67, N'Ilene ', N'Stein', N'661 Garfield Avenue', N'7177459')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (68, N'Kareem ', N'Stark', N'788 Warren Street', N'7837590')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (69, N'Evan ', N'Steele', N'599 Elm Avenue', N'7657624')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (70, N'Elaine ', N'Stevens', N'766 Woodland Avenue', N'3067661')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (71, N'Ophelia ', N'Stark', N'222 Briarwood Drive', N'1588147')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (72, N'Joe ', N'Stewart', N'640 Buttonwood Drive', N'6968782')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (73, N'Frieda ', N'Strong', N'702 Amherst Street', N'1519153')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (74, N'Carmen ', N'Strong', N'389 Briarwood Drive', N'4299984')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (75, N'Virgil ', N'Sutton', N'759 Aspen Drive', N'4540061')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (76, N'Winifred ', N'Summers', N'730 Prospect Avenue', N'2140812')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (77, N'Jerald ', N'Summers', N'808 Ridge Road', N'6962296')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (78, N'Mallory ', N'Suarez', N'196 Park Street', N'9436127')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (79, N'Dawn ', N'Sullivan', N'712 Pin Oak Drive', N'8337102')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (80, N'Felicia ', N'Sutton', N'209 Delaware Avenue', N'9717774')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (81, N'Mike ', N'Sullivan', N'989 Hillside Drive', N'3319989')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (82, N'Erma ', N'Swanson', N'413 Briarwood Drive', N'6660191')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (83, N'Lacy ', N'Sweet', N'625 Cardinal Drive', N'3492839')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (84, N'Angeline ', N'Sweeney', N'845 Colonial Drive', N'6343179')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (85, N'Stacey ', N'Sweeney', N'892 State Street', N'4793661')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (86, N'Noel ', N'Swanson', N'148 8th Street', N'8906542')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (87, N'Merle ', N'Sykes', N'926 Colonial Drive', N'2117643')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (88, N'Willis ', N'Tate', N'614 Olive Street', N'7471018')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (89, N'Yvette ', N'Tate', N'112 Cypress Court', N'7343379')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (90, N'Thomas ', N'Taylor', N'496 Route 1', N'2934108')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (91, N'Mara ', N'Talley', N'475 Route 70', N'6185505')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (92, N'Dorothy ', N'Taylor', N'924 Jefferson Street', N'5136696')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (93, N'Diego ', N'Tanner', N'657 Morris Street', N'1756986')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (94, N'Carmela ', N'Tanner', N'765 Lafayette Avenue', N'5959838')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (95, N'Laverne ', N'Terrell', N'296 Country Lane', N'7414435')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (96, N'Ken ', N'Terry', N'823 Willow Street', N'5424913')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (97, N'Hillary ', N'Terrell', N'251 Schoolhouse Lane', N'7536401')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (98, N'Jennie ', N'Terry', N'861 Front Street South', N'3776862')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (99, N'Daniel ', N'Thomas', N'476 Lafayette Avenue', N'6460697')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (100, N'Johnathan ', N'Thornton', N'349 Main Street', N'3314891')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (101, N'Kenneth ', N'Thompson', N'444 Linden Street', N'9427942')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (102, N'Donna ', N'Thompson', N'653 Magnolia Avenue', N'6629019')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (103, N'Herschel ', N'Tillman', N'384 Ridge Road', N'5590493')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (104, N'Jordan ', N'Tillman', N'250 Creekside Drive', N'3469625')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (105, N'Whitney ', N'Todd', N'782 Magnolia Avenue', N'9360960')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (106, N'Bruce ', N'Torres', N'420 Durham Court', N'7095137')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (107, N'Robin ', N'Townsend', N'155 Forest Drive', N'3737531')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (108, N'Raphael ', N'Trevino', N'277 B Street', N'7772321')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (109, N'Lorene ', N'Tran', N'314 Fulton Street', N'6582416')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (110, N'Lina ', N'Travis', N'584 Prospect Avenue', N'9482962')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (111, N'Rachelle ', N'Trevino', N'389 Chapel Street', N'4994597')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (112, N'Elvis ', N'Trujillo', N'463 Chapel Street', N'9108226')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (113, N'Darnell ', N'Tran', N'572 Warren Avenue', N'3149663')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (114, N'Marjorie ', N'Tucker', N'982 North Street', N'2750610')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (115, N'Marie ', N'Turner', N'484 Clark Street', N'3543001')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (116, N'Nadine ', N'Tyler', N'917 Route 64', N'3928371')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (117, N'Jacklyn ', N'Tyson', N'420 Elm Street', N'1659887')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (118, N'Jimmie ', N'Vargas', N'875 Meadow Lane', N'8911141')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (119, N'Alejandro ', N'Vaughn', N'710 10th Street', N'2132249')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (120, N'Lamont ', N'Vazquez', N'971 19th Street', N'3382316')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (121, N'Abe ', N'Vaughan', N'854 7th Avenue', N'9883415')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (122, N'Christy ', N'Vargas', N'940 3rd Street', N'8413562')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (123, N'Celina ', N'Vang', N'457 Atlantic Avenue', N'1923803')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (124, N'Belinda ', N'Vaughn', N'616 Jefferson Court', N'1205032')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (125, N'Stacie ', N'Vazquez', N'494 Cooper Street', N'1395372')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (126, N'Concetta ', N'Valencia', N'629 Canterbury Road', N'6375435')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (127, N'Cecile ', N'Vance', N'694 Jackson Avenue', N'5997469')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (128, N'Branden ', N'Valentine', N'138 Buckingham Drive', N'1247591')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (129, N'Nathaniel ', N'Vasquez', N'947 Cross Street', N'1157952')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (130, N'Rae ', N'Valentine', N'356 Sycamore Lane', N'6188257')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (131, N'Omar ', N'Valdez', N'934 Ridge Road', N'6039049')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (132, N'Fidel ', N'Vance', N'224 Fulton Street', N'2499730')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (133, N'Barney ', N'Velez', N'763 Sycamore Street', N'2831970')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (134, N'Isabella ', N'Velazquez', N'462 Lawrence Street', N'5302712')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (135, N'Gavin ', N'Velasquez', N'132 Route 44', N'2085523')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (136, N'Beulah ', N'Vega', N'736 Church Street', N'9866208')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (137, N'Meagan ', N'Velez', N'961 Church Street', N'3986283')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (138, N'Aileen ', N'Velasquez', N'427 Adams Street', N'6539115')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (139, N'Rosetta ', N'Vincent', N'214 Pin Oak Drive', N'6102202')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (140, N'Dominique ', N'Villarreal', N'725 Route 6', N'5274881')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (141, N'Brigitte ', N'Vinson', N'581 Canal Street', N'1895817')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (142, N'Ismael ', N'Waters', N'257 Howard Street', N'9370044')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (143, N'Kelsey ', N'Wall', N'781 Canal Street', N'8250548')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (144, N'Troy ', N'Warren', N'567 Union Street', N'2651058')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (145, N'Stanley ', N'Wallace', N'800 2nd Street', N'9951988')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (146, N'Fannie ', N'Warner', N'122 2nd Street West', N'1562027')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (147, N'Malinda ', N'Waller', N'138 Circle Drive', N'2833004')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (148, N'Margie ', N'Wade', N'201 Highland Avenue', N'1153068')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (149, N'Colin ', N'Walton', N'769 Summit Avenue', N'5733279')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (150, N'Connie ', N'Wallace', N'214 Route 64', N'1243427')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (151, N'Ivy ', N'Walls', N'630 6th Street', N'7894400')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (152, N'Deborah ', N'Walker', N'128 Sycamore Drive', N'6214623')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (153, N'Bruno ', N'Walls', N'986 Main Street East', N'6104633')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (154, N'Millie ', N'Walter', N'523 Summer Street', N'4315508')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (155, N'Wayne ', N'Watson', N'985 Catherine Street', N'3175745')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (156, N'Cassandra ', N'Walters', N'532 Grand Avenue', N'3335950')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (157, N'Ty ', N'Walter', N'363 King Street', N'1876222')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (158, N'Shawn ', N'Ware', N'454 Cypress Court', N'4966252')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (159, N'Craig ', N'Washington', N'743 Route 100', N'2356293')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (160, N'Erwin ', N'Wall', N'467 Linden Street', N'7396621')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (161, N'Lynne ', N'Walton', N'182 Devon Court', N'6066734')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (162, N'Gale ', N'Waller', N'385 Wood Street', N'5057240')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (163, N'Theresa ', N'Watson', N'852 Route 41', N'5787245')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (164, N'Hubert ', N'Walsh', N'906 John Street', N'9527348')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (165, N'Terrance ', N'Watts', N'537 Park Street', N'1417405')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (166, N'Dolores ', N'Wagner', N'644 Oak Avenue', N'4117497')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (167, N'Jaime ', N'Wade', N'266 Henry Street', N'3517634')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (168, N'Shelly ', N'Watts', N'848 Woodland Road', N'4637941')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (169, N'Yvonne ', N'Watkins', N'338 Liberty Street', N'5498133')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (170, N'Horace ', N'Warner', N'210 Route 10', N'5808471')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (171, N'Junior ', N'Ware', N'424 Race Street', N'3898944')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (172, N'Ruby ', N'Washington', N'575 Cardinal Drive', N'3109887')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (173, N'Ted ', N'Welch', N'937 Route 32', N'4890076')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (174, N'Simone ', N'Weeks', N'144 Ivy Lane', N'2551714')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (175, N'Shane ', N'Weaver', N'716 Eagle Road', N'1241820')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (176, N'Yolanda ', N'Weaver', N'415 Catherine Street', N'7773376')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (177, N'Rosie ', N'Weber', N'458 Harrison Street', N'2735364')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (178, N'Edna ', N'West', N'351 Chestnut Avenue', N'6935937')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (179, N'Melvin ', N'Wells', N'736 Cedar Lane', N'5026500')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (180, N'Dale ', N'West', N'776 Canterbury Drive', N'9396879')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (181, N'Alfred ', N'Webb', N'155 Maple Street', N'5037962')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (182, N'Summer ', N'Weiss', N'674 Orange Street', N'4388857')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (183, N'Jarrod ', N'Whitehead', N'163 Academy Street', N'9762433')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (184, N'Madeleine ', N'Whitfield', N'714 Lawrence Street', N'9574771')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (185, N'Effie ', N'Whitaker', N'666 Maple Street', N'8995033')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (186, N'Betty ', N'White', N'513 Chestnut Street', N'3846092')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (187, N'Zelma ', N'Whitney', N'770 Church Street', N'7626756')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (188, N'Herminia ', N'Whitley', N'239 Market Street', N'4077893')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (189, N'Candy ', N'Whitehead', N'506 Grove Avenue', N'8067901')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (190, N'Leslie ', N'Wheeler', N'836 Columbia Street', N'9917943')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (191, N'Eldon ', N'Whitaker', N'627 Lexington Court', N'4688156')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (192, N'Lucy ', N'Wheeler', N'623 Devonshire Drive', N'9648792')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (193, N'Chester ', N'Williamson', N'199 Smith Street', N'9760118')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (194, N'Emil ', N'Wilcox', N'772 19th Street', N'5401501')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (195, N'Amparo ', N'Witt', N'308 Carriage Drive', N'4081895')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (196, N'Scotty ', N'Wiley', N'421 Lafayette Street', N'1801926')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (197, N'Helene ', N'Wiggins', N'938 Wall Street', N'2232377')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (198, N'Susan ', N'Wilson', N'600 Route 29', N'8542470')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (199, N'Robert ', N'Williams', N'395 Railroad Avenue', N'6322661')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (200, N'Marina ', N'Wilcox', N'451 Penn Street', N'8632959')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (201, N'Gordon ', N'Willis', N'413 Virginia Avenue', N'8463305')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (202, N'Marlon ', N'Wilkerson', N'361 Cottage Street', N'5543517')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (203, N'Abel ', N'Wilkins', N'761 Creek Road', N'2893869')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (204, N'Jimmie ', N'Winters', N'634 5th Street East', N'7934742')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (205, N'Taylor ', N'Wise', N'508 Virginia Avenue', N'1815713')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (206, N'Shanna ', N'Wiley', N'309 Columbia Street', N'1116975')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (207, N'Donovan ', N'Winters', N'792 Broad Street', N'6267103')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (208, N'Bernice ', N'Willis', N'610 Walnut Street', N'5088038')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (209, N'Lela ', N'Wilkins', N'525 Old York Road', N'8278221')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (210, N'Linda ', N'Williams', N'742 Sunset Drive', N'5318283')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (211, N'Doreen ', N'Wise', N'696 Creek Road', N'3768680')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (212, N'Reggie ', N'Wilkinson', N'276 Green Street', N'8408852')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (213, N'Cleo ', N'William', N'293 John Street', N'1249078')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (214, N'Gina ', N'Williamson', N'400 2nd Avenue', N'9499903')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (215, N'August ', N'Wiggins', N'993 Canterbury Road', N'8299987')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (216, N'Trenton ', N'Woodward', N'425 4th Street West', N'4531256')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (217, N'Florence ', N'Woods', N'169 Winding Way', N'6612410')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (218, N'Jillian ', N'Woodard', N'206 Main Street North', N'4003054')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (219, N'Buddy ', N'Woodard', N'163 5th Avenue', N'7823376')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (220, N'Inez ', N'Wolfe', N'452 Front Street South', N'7783390')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (221, N'Adele ', N'Wolf', N'207 Canterbury Road', N'1615124')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (222, N'Liz ', N'Workman', N'419 Grove Street', N'2246111')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (223, N'Letitia ', N'Wooten', N'677 Orange Street', N'4966632')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (224, N'Heath ', N'Wolf', N'144 Cedar Street', N'2569562')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (225, N'Grady ', N'Wong', N'657 Tanglewood Drive', N'5639814')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (226, N'Jamal ', N'Wyatt', N'420 Court Street', N'5552855')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (227, N'Natalia ', N'Wynn', N'345 Holly Drive', N'6864273')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (228, N'Goldie ', N'Wyatt', N'899 Crescent Street', N'6686062')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (229, N'Garrett ', N'Yates', N'816 Pheasant Run', N'6403719')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (230, N'Wilburn ', N'Yang', N'399 Roberts Road', N'9967967')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (231, N'Louisa ', N'Yang', N'405 Tanglewood Drive', N'9308033')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (232, N'Jose ', N'Young', N'952 Valley View Drive', N'6062487')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (233, N'Annabelle ', N'Zamora', N'649 Colonial Drive', N'5920188')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (234, N'Sophia ', N'Zimmerman', N'969 Glenwood Drive', N'5650703')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (235, N'Sophie ', N'Abbott', N'820 Lafayette Street', N'2815188')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (236, N'Rolando ', N'Abbott', N'820 Lafayette Street', N'3665770')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (237, N'Miles ', N'Acosta', N'702 Walnut Avenue', N'7967660')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (238, N'Juliette ', N'Acevedo', N'798 2nd Street', N'6909436')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (239, N'Adrienne ', N'Adkins', N'813 Laurel Lane', N'2901763')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (240, N'Raymond ', N'Adams', N'706 Fairway Drive', N'8163963')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (241, N'Wilson ', N'Adkins', N'503 Street Road', N'6254781')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (242, N'Kathleen ', N'Adams', N'858 Ivy Court', N'8739171')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (243, N'Verna ', N'Aguilar', N'987 Victoria Court', N'1846759')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (244, N'Luciano ', N'Aguirre', N'800 8th Street South', N'2997930')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (245, N'Kris ', N'Aguirre', N'800 8th Street South', N'1138502')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (246, N'Gil ', N'Alston', N'699 Pleasant Street', N'9700362')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (247, N'Gabriel ', N'Alvarez', N'580 Route 4', N'2310983')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (248, N'Aubrey ', N'Allison', N'675 2nd Street', N'9241352')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (249, N'Gilberto ', N'Alvarado', N'685 River Street', N'4441916')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (250, N'Osvaldo ', N'Alford', N'254 Meadow Lane', N'2572723')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (251, N'Chris ', N'Alexander', N'970 Eagle Road', N'5373981')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (252, N'Shirley ', N'Allen', N'765 Madison Court', N'6424142')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (253, N'Rosanne ', N'Alston', N'611 Canterbury Court', N'7815837')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (254, N'Charlene ', N'Alvarez', N'675 Highland Drive', N'2497065')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (255, N'Madelyn ', N'Alford', N'687 9th Street', N'2998184')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (256, N'Nettie ', N'Allison', N'257 Garden Street', N'3548558')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (257, N'Josefa ', N'Albert', N'111 Ann Street', N'9578858')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (258, N'Timothy ', N'Allen', N'152 Route 70', N'3699058')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (259, N'Diana ', N'Alexander', N'570 Williams Street', N'8189473')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (260, N'Chris ', N'Anthony', N'262 Cambridge Court', N'7831987')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (261, N'Ethan ', N'Anthony', N'181 Ridge Avenue', N'6404921')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (262, N'Ida ', N'Andrews', N'536 Clay Street', N'1875486')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (263, N'Herman ', N'Andrews', N'536 Clay Street', N'1875486')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (264, N'Christopher ', N'Anderson', N'390 Colonial Drive', N'8786641')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (265, N'Glen ', N'Armstrong', N'636 19th Street', N'3181526')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (266, N'Tim ', N'Arnold', N'405 Fieldstone Drive', N'8509820')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (267, N'Merlin ', N'Ashley', N'368 Jackson Street', N'7743065')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (268, N'Bernadine ', N'Ashley', N'697 Cobblestone Court', N'2787362')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (269, N'Isaiah ', N'Atkinson', N'977 Broad Street', N'7590729')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (270, N'Mayra ', N'Atkinson', N'906 Howard Street', N'7771649')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (271, N'Kristie ', N'Atkins', N'763 Union Street', N'1768268')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (272, N'Alma ', N'Austin', N'471 Park Street', N'1813291')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (273, N'Ramon ', N'Austin', N'450 Route 9', N'7645475')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (274, N'Theron ', N'Avery', N'227 Cedar Avenue', N'2431991')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (275, N'Elise ', N'Avila', N'698 5th Avenue', N'3964245')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (276, N'Allyson ', N'Avery', N'721 Ann Street', N'2477697')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (277, N'Stephan ', N'Ayala', N'632 Glenwood Avenue', N'4414609')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (278, N'Mavis ', N'Ayers', N'748 King Street', N'6575271')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (279, N'Addie ', N'Ayala', N'485 2nd Avenue', N'8377843')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (280, N'Rachel ', N'Barnes', N'174 Elmwood Avenue', N'4250549')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (281, N'Christie ', N'Ballard', N'878 5th Street North', N'2100677')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (282, N'Rene ', N'Bates', N'169 Route 2', N'8640857')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (283, N'Jodi ', N'Barber', N'737 Cambridge Court', N'3590893')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (284, N'Mandy ', N'Barton', N'145 Glenwood Drive', N'9340929')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (285, N'Lynnette ', N'Baird', N'342 Walnut Avenue', N'9690978')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (286, N'Devon ', N'Baxter', N'310 Spring Street', N'7891142')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (287, N'Dee ', N'Barr', N'232 Pleasant Street', N'5631244')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (288, N'Aurelia ', N'Barrera', N'538 4th Street', N'2631436')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (289, N'Brandi ', N'Ball', N'142 Hillcrest Drive', N'9361544')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (290, N'Cassie ', N'Baxter', N'744 Market Street', N'3871795')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (291, N'Pablo ', N'Baldwin', N'834 Pin Oak Drive', N'7192226')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (292, N'Pamela ', N'Baker', N'182 Wall Street', N'5592258')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (293, N'Harriet ', N'Barker', N'842 Ridge Avenue', N'6072702')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (294, N'Samuel ', N'Bailey', N'881 Oak Street', N'5883083')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (295, N'Coy ', N'Bartlett', N'922 Clinton Street', N'3783947')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (296, N'Deann ', N'Barlow', N'284 Laurel Lane', N'2323961')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (297, N'Virgie ', N'Barron', N'246 Washington Avenue', N'7764083')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (298, N'Byron ', N'Barnett', N'119 Fairview Avenue', N'5954225')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (299, N'Drew ', N'Ballard', N'222 Smith Street', N'4854763')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (300, N'Luke ', N'Ball', N'584 Summer Street', N'6695251')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (301, N'Jerri ', N'Battle', N'830 College Street', N'4575454')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (302, N'Howard ', N'Barnes', N'981 Washington Avenue', N'1575650')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (303, N'Ernesto ', N'Barber', N'883 Market Street', N'7015849')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (304, N'Marcy ', N'Bauer', N'572 Magnolia Avenue', N'1496339')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (305, N'Olive ', N'Bass', N'769 Bank Street', N'4206363')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (306, N'Daisy ', N'Bates', N'799 James Street', N'3466488')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (307, N'Gregory ', N'Baker', N'607 Clay Street', N'5606594')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (308, N'Issac ', N'Barr', N'295 11th Street', N'6346869')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (309, N'Kayla ', N'Baldwin', N'448 5th Street East', N'7847121')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (310, N'Conrad ', N'Bass', N'991 3rd Street', N'8487750')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (311, N'Willard ', N'Barrett', N'365 School Street', N'9667980')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (312, N'Duane ', N'Banks', N'914 Inverness Drive', N'7817987')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (313, N'Jessie ', N'Banks', N'967 Elmwood Avenue', N'2808659')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (314, N'Carole ', N'Barnett', N'915 Washington Street', N'7739221')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (315, N'Dudley ', N'Bauer', N'486 Essex Court', N'4509251')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (316, N'Tracey ', N'Barrett', N'926 West Street', N'1939455')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (317, N'Otis ', N'Barker', N'945 College Street', N'5109563')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (318, N'Penelope ', N'Barry', N'278 Fairway Drive', N'6659762')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (319, N'Wilford ', N'Barry', N'323 Prospect Avenue', N'7619973')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (320, N'Jean ', N'Bell', N'860 Sunset Drive', N'6740488')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (321, N'Seymour ', N'Bender', N'301 4th Street West', N'2290500')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (322, N'Randi ', N'Bean', N'367 2nd Street North', N'4970500')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (323, N'Aaron ', N'Bennett', N'425 Depot Street', N'7830511')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (324, N'Freddie ', N'Beck', N'945 Devon Road', N'9371355')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (325, N'Giovanni ', N'Bentley', N'982 Sycamore Street', N'3641943')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (326, N'Dionne ', N'Beach', N'411 Rose Street', N'5812477')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (327, N'Joan ', N'Berg', N'713 Market Street', N'3272510')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (328, N'Marylou ', N'Berg', N'120 Pleasant Street', N'7192842')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (329, N'Regina ', N'Berry', N'625 Pennsylvania Avenue', N'8563947')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (330, N'Danial ', N'Benton', N'327 Harrison Street', N'2264531')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (331, N'Burt ', N'Berger', N'790 Park Avenue', N'8484847')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (332, N'Leo ', N'Berry', N'716 South Street', N'8404848')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (333, N'Charmaine ', N'Bernard', N'915 Williams Street', N'4155053')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (334, N'Sandy ', N'Benjamin', N'365 College Avenue', N'9345673')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (335, N'Winfred ', N'Best', N'570 6th Street', N'5996159')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (336, N'Moises ', N'Beard', N'999 5th Street North', N'3516280')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (337, N'Corine ', N'Bender', N'307 Division Street', N'3807036')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (338, N'Ariel ', N'Bernard', N'296 Valley View Drive', N'4367058')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (339, N'Chrystal ', N'Benjamin', N'220 College Street', N'3497983')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (340, N'Lorna ', N'Beasley', N'404 Liberty Street', N'1308017')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (341, N'Weldon ', N'Bean', N'219 Academy Street', N'6328156')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (342, N'Roxanne ', N'Becker', N'851 Pleasant Street', N'2139114')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (343, N'Bette ', N'Beard', N'831 Devon Court', N'8329622')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (344, N'Elliott ', N'Beasley', N'174 Eagle Road', N'1549748')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (345, N'Agnes ', N'Bishop', N'410 Academy Street', N'9821839')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (346, N'Reyna ', N'Bird', N'503 Clay Street', N'1868688')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (347, N'Lesley ', N'Blackwell', N'312 High Street', N'8470300')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (348, N'Leland ', N'Blake', N'431 Magnolia Court', N'5290741')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (349, N'Clifford ', N'Black', N'348 Lilac Lane', N'3671666')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (350, N'Leonel ', N'Blanchard', N'964 3rd Street West', N'6351772')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (351, N'Nelda ', N'Blackburn', N'816 4th Street West', N'4712221')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (352, N'Cliff ', N'Blackwell', N'797 Park Avenue', N'9852342')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (353, N'Valerie ', N'Black', N'275 Valley View Drive', N'3144678')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (354, N'Jonathon ', N'Blair', N'692 Ridge Avenue', N'2677350')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (355, N'Harris ', N'Blackburn', N'762 Jones Street', N'4028185')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (356, N'Ava ', N'Blanchard', N'511 Elm Avenue', N'1798754')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (357, N'Jackson ', N'Blankenship', N'180 Spruce Street', N'3798845')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (358, N'Silas ', N'Blevins', N'765 Church Road', N'2418941')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (359, N'Kendra ', N'Blake', N'919 North Street', N'7429230')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (360, N'Joni ', N'Blankenship', N'553 Washington Street', N'4589529')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (361, N'Rex ', N'Bowen', N'978 Lawrence Street', N'7480207')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (362, N'Aida ', N'Bond', N'827 Main Street North', N'9690576')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (363, N'Brandie ', N'Boyle', N'958 Fawn Lane', N'5251278')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (364, N'Kelly ', N'Bowman', N'534 Franklin Street', N'3981335')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (365, N'Margret ', N'Boyer', N'980 6th Street', N'8402469')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (366, N'Irvin ', N'Bowers', N'588 Route 7', N'8553221')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (367, N'Genevieve ', N'Bowen', N'172 Linda Lane', N'8023329')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (368, N'Blaine ', N'Bond', N'142 Laurel Street', N'6803687')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (369, N'Wyatt ', N'Bonner', N'440 River Street', N'2424215')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (370, N'Caroline ', N'Bowman', N'208 Route 64', N'4804496')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (371, N'Mason ', N'Booker', N'612 Henry Street', N'6385888')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (372, N'Miranda ', N'Boone', N'394 Hamilton Street', N'4856211')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (373, N'Darrin ', N'Boone', N'784 Penn Street', N'7646230')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (374, N'Emma ', N'Boyd', N'369 Lake Avenue', N'9116400')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (375, N'Beryl ', N'Bolton', N'214 Ann Street', N'1497272')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (376, N'Esperanza ', N'Booth', N'467 Magnolia Court', N'5107941')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (377, N'Esteban ', N'Booth', N'554 Washington Avenue', N'4908186')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (378, N'Mindy ', N'Bowers', N'696 Ivy Lane', N'2418358')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (379, N'Edwin ', N'Boyd', N'532 Jackson Street', N'9838419')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (380, N'Madge ', N'Bonner', N'681 2nd Street North', N'4249103')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (381, N'Philip ', N'Bryant', N'478 7th Avenue', N'5460769')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (382, N'Davis ', N'Browning', N'911 Magnolia Drive', N'2151076')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (383, N'Antoine ', N'Bradford', N'445 Forest Street', N'4801164')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (384, N'Tabitha ', N'Bridges', N'749 Oak Avenue', N'5001723')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (385, N'Parker ', N'Britt', N'286 James Street', N'6632550')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (386, N'Hugo ', N'Briggs', N'869 Hillside Avenue', N'9783184')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (387, N'Rogelio ', N'Brady', N'487 5th Street East', N'2353825')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (388, N'Alyssa ', N'Brady', N'771 Mulberry Street', N'4003836')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (389, N'Shari ', N'Bryan', N'587 Main Street South', N'8353929')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (390, N'Beverly ', N'Brooks', N'458 Fawn Lane', N'3794043')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (391, N'Eula ', N'Briggs', N'508 Liberty Street', N'7254577')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (392, N'Zachary ', N'Bradley', N'385 5th Street South', N'2565191')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (393, N'Colby ', N'Bradshaw', N'290 Amherst Street', N'7295216')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (394, N'Alonzo ', N'Brock', N'512 Vine Street', N'4825264')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (395, N'Vickie ', N'Brewer', N'482 5th Street East', N'1515282')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (396, N'Mervin ', N'Bray', N'154 Deerfield Drive', N'2615783')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (397, N'Ana ', N'Bradley', N'745 Sheffield Drive', N'3395794')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (398, N'Clarissa ', N'Brennan', N'430 Cardinal Drive', N'9215804')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (399, N'Pasquale ', N'Brennan', N'612 Lake Street', N'3126567')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (400, N'Elizabeth ', N'Brown', N'528 Route 10', N'1716636')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (401, N'Etta ', N'Bradford', N'331 Main Street West', N'9766815')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (402, N'Boyd ', N'Bryan', N'248 8th Street', N'3927027')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (403, N'Gwen ', N'Brock', N'424 Colonial Drive', N'4877105')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (404, N'Paula ', N'Bryant', N'493 19th Street', N'6897474')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (405, N'Johnathon ', N'Branch', N'882 Court Street', N'1248100')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (406, N'Billy ', N'Brooks', N'984 Williams Street', N'2598492')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (407, N'Emmett ', N'Bridges', N'555 Cardinal Drive', N'4368826')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (408, N'Nelson ', N'Brewer', N'219 Fulton Street', N'9519237')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (409, N'John ', N'Bray', N'783 Grant Avenue', N'9229637')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (410, N'Deana ', N'Browning', N'722 Surrey Lane', N'2169643')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (411, N'Estella ', N'Bruce', N'793 Elizabeth Street', N'1229771')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (412, N'Carey ', N'Bright', N'779 York Street', N'7049994')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (413, N'Landon ', N'Buckley', N'620 Ridge Street', N'7370160')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (414, N'Guadalupe ', N'Bush', N'391 Route 70', N'9750357')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (415, N'Myrna ', N'Burnett', N'493 Fairview Road', N'3091105')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (416, N'Leta ', N'Buckner', N'442 Aspen Court', N'4471643')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (417, N'Kendrick ', N'Bullock', N'956 Orange Street', N'9851852')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (418, N'Arturo ', N'Bush', N'164 2nd Street', N'7462877')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (419, N'Erick ', N'Buchanan', N'765 4th Street West', N'6942940')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (420, N'Colleen ', N'Burton', N'156 Court Street', N'3183031')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (421, N'Rochelle ', N'Buchanan', N'712 Fieldstone Drive', N'2863945')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (422, N'Darren ', N'Burke', N'839 Washington Avenue', N'4564668')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (423, N'Maribel ', N'Bullock', N'202 Route 41', N'2756457')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (424, N'Bernard ', N'Burns', N'883 Pearl Street', N'7686502')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (425, N'Elnora ', N'Buck', N'964 Elm Street', N'6007061')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (426, N'Hallie ', N'Burks', N'473 Grant Street', N'4517102')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (427, N'Lakeisha ', N'Burch', N'349 13th Street', N'3227653')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (428, N'Opal ', N'Burgess', N'427 Route 32', N'5507739')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (429, N'Buford ', N'Buck', N'266 Colonial Drive', N'2267915')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (430, N'Tisha ', N'Burt', N'924 Valley Road', N'7447952')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (431, N'Lydia ', N'Burke', N'433 Garfield Avenue', N'9488050')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (432, N'April ', N'Burns', N'800 Maple Avenue', N'5939870')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (433, N'Everett ', N'Byrd', N'870 Oak Street', N'8181164')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (434, N'Deanna ', N'Byrd', N'870 Mulberry Court', N'7466477')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (435, N'Eileen ', N'Carr', N'341 Country Lane', N'8620007')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (436, N'Rafael ', N'Castillo', N'226 Devon Road', N'7610183')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (437, N'Martina ', N'Carrillo', N'566 Magnolia Court', N'5890202')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (438, N'Glenna ', N'Carey', N'956 Cleveland Street', N'8190535')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (439, N'Boris ', N'Cantrell', N'490 State Street', N'2870661')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (440, N'Johanna ', N'Cain', N'908 Ashley Court', N'2680789')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (441, N'Bettye ', N'Camacho', N'509 Franklin Avenue', N'3771082')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (442, N'Angel ', N'Carr', N'142 Washington Street', N'2791543')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (443, N'Loretta ', N'Carpenter', N'722 Taylor Street', N'5421678')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (444, N'Amanda ', N'Carter', N'560 Academy Street', N'3681794')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (445, N'Cornell ', N'Cantu', N'721 Circle Drive', N'8371992')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (446, N'Dane ', N'Callahan', N'412 Lawrence Street', N'5962377')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (447, N'Dennis ', N'Carter', N'796 Valley Drive', N'5762393')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (448, N'Queen ', N'Castaneda', N'123 Ridge Road', N'1833301')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (449, N'Ivan ', N'Caldwell', N'481 Forest Drive', N'9313348')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (450, N'Michel ', N'Carey', N'423 Fieldstone Drive', N'4073822')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (451, N'Jeannie ', N'Casey', N'803 Chestnut Street', N'8153850')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (452, N'Petra ', N'Callahan', N'387 Summer Street', N'8874550')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (453, N'Timmy ', N'Casey', N'961 Route 41', N'1934576')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (454, N'Dominick ', N'Cain', N'140 State Street', N'5615138')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (455, N'Curt ', N'Cameron', N'317 Penn Street', N'6165563')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (456, N'Quincy ', N'Carrillo', N'572 Route 7', N'3565571')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (457, N'Saundra ', N'Cantu', N'922 East Street', N'8605602')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (458, N'Moses ', N'Carson', N'395 Magnolia Drive', N'9925631')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (459, N'Carlene ', N'Case', N'708 Sheffield Drive', N'2215649')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (460, N'Lincoln ', N'Cardenas', N'922 5th Street West', N'7015740')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (461, N'May ', N'Carson', N'517 Myrtle Avenue', N'8096083')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (462, N'Ingrid ', N'Cameron', N'683 Route 2', N'3946180')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (463, N'Kimberley ', N'Calhoun', N'231 Walnut Street', N'8746218')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (464, N'Patty ', N'Cannon', N'315 Front Street South', N'7196450')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (465, N'Hector ', N'Carpenter', N'543 Route 11', N'8026527')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (466, N'Terry ', N'Carlson', N'685 Bridge Street', N'7186744')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (467, N'Earnestine ', N'Cabrera', N'492 Deerfield Drive', N'4986899')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (468, N'Kay ', N'Caldwell', N'436 Holly Drive', N'3096904')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (469, N'Mitchel ', N'Carver', N'578 Canal Street', N'6117096')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (470, N'Ross ', N'Castro', N'918 Liberty Street', N'2857415')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (471, N'Claudine ', N'Calderon', N'322 Route 202', N'1677600')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (472, N'Duncan ', N'Cabrera', N'400 Holly Court', N'8078620')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (473, N'Eve ', N'Cardenas', N'851 Harrison Street', N'8638858')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (474, N'Lauri ', N'Carney', N'845 Garden Street', N'3168904')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (475, N'Gertrude ', N'Castillo', N'809 Heather Lane', N'9748922')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (476, N'Nona ', N'Cantrell', N'728 Route 6', N'4208960')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (477, N'Solomon ', N'Calhoun', N'665 Laurel Lane', N'8879022')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (478, N'Myles ', N'Case', N'859 College Avenue', N'2359089')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (479, N'Dustin ', N'Carroll', N'970 Lawrence Street', N'2429132')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (480, N'Daphne ', N'Campos', N'415 Circle Drive', N'1899193')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (481, N'Katina ', N'Cash', N'819 River Street', N'6579218')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (482, N'Carmella ', N'Cervantes', N'424 Church Road', N'5872958')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (483, N'Kennith ', N'Cervantes', N'705 Lafayette Avenue', N'9634799')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (484, N'Avis ', N'Church', N'172 Park Avenue', N'5391274')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (485, N'Marva ', N'Chaney', N'606 Myrtle Avenue', N'7681312')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (486, N'Edgar ', N'Chapman', N'328 Cambridge Court', N'2921317')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (487, N'Sandy ', N'Chandler', N'411 2nd Street North', N'2911517')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (488, N'Errol ', N'Chan', N'163 Route 70', N'6642472')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (489, N'Karina ', N'Cherry', N'620 Prospect Street', N'9613194')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (490, N'Jacques ', N'Church', N'541 Sycamore Drive', N'6863399')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (491, N'Lynette ', N'Christensen', N'776 Front Street North', N'5123798')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (492, N'Lester ', N'Chavez', N'930 Park Drive', N'6423828')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (493, N'Allie ', N'Chan', N'881 Washington Street', N'8333919')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (494, N'Efren ', N'Chaney', N'406 Lakeview Drive', N'9264261')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (495, N'Marion ', N'Chambers', N'572 Hamilton Street', N'9154548')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (496, N'Bridgette ', N'Chen', N'707 Route 70', N'9045431')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (497, N'Kristina ', N'Chambers', N'928 Mulberry Lane', N'9285615')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (498, N'Morgan ', N'Chase', N'278 Jefferson Court', N'7145695')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (499, N'Latasha ', N'Chase', N'333 9th Street', N'7495850')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (500, N'Frederic ', N'Chen', N'975 Route 32', N'4557550')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (501, N'Robby ', N'Cherry', N'487 Brookside Drive', N'5637705')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (502, N'Robbie ', N'Charles', N'462 Madison Court', N'5217768')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (503, N'Lottie ', N'Charles', N'476 Main Street West', N'3729158')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (504, N'Ladonna ', N'Chang', N'214 Ivy Court', N'5929351')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (505, N'Ronald ', N'Clark', N'989 Sheffield Drive', N'5040061')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (506, N'Sonja ', N'Clayton', N'282 Buckingham Drive', N'6870271')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (507, N'Emmanuel ', N'Clay', N'373 Grand Avenue', N'1392677')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (508, N'Merle ', N'Clayton', N'533 Harrison Avenue', N'7152776')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (509, N'Carolina ', N'Cline', N'968 Schoolhouse Lane', N'5693075')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (510, N'Lucia ', N'Clarke', N'363 2nd Street', N'3783523')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (511, N'Vilma ', N'Clemons', N'566 Front Street', N'1843683')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (512, N'Brendan ', N'Clarke', N'474 Park Place', N'8553866')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (513, N'Michelle ', N'Clark', N'493 Front Street', N'9694148')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (514, N'Sherrie ', N'Clay', N'237 Orchard Avenue', N'4145923')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (515, N'Anastasia ', N'Cleveland', N'134 Center Street', N'9466226')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (516, N'Cherry ', N'Clements', N'350 6th Avenue', N'5658917')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (517, N'Bret ', N'Cochran', N'114 Cottage Street', N'1780278')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (518, N'Kathie ', N'Cotton', N'666 Beech Street', N'9900296')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (519, N'Josie ', N'Combs', N'821 Center Street', N'7310388')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (520, N'Stewart ', N'Copeland', N'992 Mulberry Lane', N'7240544')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (521, N'Jermaine ', N'Cobb', N'124 Depot Street', N'3600650')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (522, N'Elisa ', N'Collier', N'702 4th Avenue', N'7950755')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (523, N'Judith ', N'Cox', N'890 Lilac Lane', N'9650799')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (524, N'Colette ', N'Coffey', N'535 Devon Court', N'9990813')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (525, N'Marquis ', N'Cotton', N'605 Park Drive', N'7010944')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (526, N'Gloria ', N'Cook', N'168 Mill Street', N'4840994')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (527, N'Tracy ', N'Cole', N'703 Center Street', N'4791562')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (528, N'Marco ', N'Cohen', N'467 Summer Street', N'8681679')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (529, N'Juana ', N'Cohen', N'140 Sunset Avenue', N'8812473')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (530, N'Young ', N'Compton', N'594 Oak Lane', N'8222483')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (531, N'Aimee ', N'Conley', N'982 Center Street', N'6112574')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (532, N'Eugenia ', N'Contreras', N'302 Route 70', N'7212669')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (533, N'Joan ', N'Cooper', N'348 Garden Street', N'2692725')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (534, N'Ellis ', N'Colon', N'312 Durham Court', N'9863166')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (535, N'Winston ', N'Cortez', N'835 Bank Street', N'2373248')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (536, N'Earle ', N'Cooley', N'283 Canal Street', N'3143681')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (537, N'Russell ', N'Coleman', N'941 School Street', N'5683712')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (538, N'Elijah ', N'Collier', N'609 5th Avenue', N'7833851')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (539, N'Yesenia ', N'Cooley', N'118 Church Street', N'1303914')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (540, N'Alphonso ', N'Conway', N'809 2nd Street West', N'4934169')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (541, N'Nicholas ', N'Cox', N'365 Linden Street', N'9164362')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (542, N'Francis ', N'Conner', N'641 Briarwood Drive', N'9324572')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (543, N'Nathan ', N'Cole', N'165 Glenwood Drive', N'1184943')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (544, N'Rubin ', N'Coffey', N'955 Franklin Avenue', N'4595246')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (545, N'Grover ', N'Combs', N'231 5th Street South', N'7745544')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (546, N'Augusta ', N'Cote', N'888 Valley Drive', N'4985848')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (547, N'Tammie ', N'Cochran', N'966 Sunset Avenue', N'3655996')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (548, N'Sherman ', N'Conner', N'428 Maple Lane', N'9446484')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (549, N'Justin ', N'Cook', N'988 Grant Street', N'4836566')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (550, N'Roger ', N'Collins', N'195 Canterbury Road', N'9996756')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (551, N'Dixie ', N'Cortez', N'296 Harrison Street', N'4707001')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (552, N'Robert ', N'Cooke', N'403 Pennsylvania Avenue', N'9167212')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (553, N'Cecelia ', N'Copeland', N'823 Route 4', N'9928159')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (554, N'Agustin ', N'Contreras', N'997 Hickory Lane', N'7388516')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (555, N'Bernadette ', N'Cobb', N'620 Rose Street', N'8038707')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (556, N'Kathryn ', N'Coleman', N'140 Spruce Street', N'9058780')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (557, N'Will ', N'Conley', N'987 4th Street', N'3789934')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (558, N'Neva ', N'Crosby', N'189 Hillcrest Drive', N'8430200')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (559, N'Ray ', N'Crawford', N'387 Mill Road', N'1760409')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (560, N'Jeffery ', N'Cruz', N'924 Oak Avenue', N'8990854')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (561, N'Arnulfo ', N'Crane', N'550 Willow Drive', N'4871458')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (562, N'Lilian ', N'Crane', N'426 Monroe Street', N'5282333')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (563, N'Bobbie ', N'Craig', N'946 New Street', N'7785174')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (564, N'Kim ', N'Cruz', N'957 Colonial Drive', N'9865811')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (565, N'Melody ', N'Cross', N'315 Broad Street', N'7686328')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (566, N'Esther ', N'Crawford', N'863 Sunset Drive', N'8386623')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (567, N'Wilmer ', N'Crosby', N'384 Hilltop Road', N'8597344')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (568, N'Isabel ', N'Curry', N'708 Dogwood Lane', N'1150006')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (569, N'Alberto ', N'Curtis', N'445 Orchard Avenue', N'4783515')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (570, N'Leah ', N'Curtis', N'675 Tanglewood Drive', N'4353573')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (571, N'Julius ', N'Curry', N'662 Route 6', N'4654273')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (572, N'Stacy ', N'Cunningham', N'808 Garfield Avenue', N'4534411')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (573, N'Cameron ', N'Cummings', N'441 Buttonwood Drive', N'8116298')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (574, N'Lewis ', N'Cunningham', N'881 Elm Street', N'5988409')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (575, N'Janie ', N'Cummings', N'979 Summer Street', N'8228940')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (576, N'Helga ', N'Dale', N'295 Route 10', N'9401755')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (577, N'Jordan ', N'Davidson', N'515 Oxford Court', N'3691915')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (578, N'Briana ', N'Daugherty', N'745 Windsor Drive', N'9902183')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (579, N'Lucio ', N'David', N'954 8th Street South', N'7712545')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (580, N'David ', N'Davis', N'849 York Street', N'5472926')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (581, N'Danielle ', N'Daniels', N'417 Fairview Avenue', N'8503000')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (582, N'Carlton ', N'Daniel', N'464 Adams Street', N'1763517')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (583, N'Bonita ', N'Davenport', N'740 Forest Drive', N'8173939')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (584, N'Patsy ', N'Davidson', N'579 B Street', N'7634750')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (585, N'Monique ', N'Daniel', N'266 Maple Avenue', N'7436091')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (586, N'Miguel ', N'Daniels', N'904 Canterbury Road', N'2818006')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (587, N'Lavern ', N'Daugherty', N'367 Howard Street', N'6678981')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (588, N'Sheryl ', N'Dawson', N'710 Pin Oak Drive', N'2419525')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (589, N'Sheree ', N'David', N'522 B Street', N'7809906')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (590, N'Christian ', N'Dean', N'868 Spring Street', N'4820680')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (591, N'Gus ', N'Decker', N'871 Orange Street', N'1670685')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (592, N'Kelvin ', N'Delgado', N'713 Garden Street', N'3753098')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (593, N'Roscoe ', N'Deleon', N'253 8th Avenue', N'7243296')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (594, N'Erna ', N'Delaney', N'211 Route 17', N'9664717')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (595, N'Alba ', N'Delacruz', N'569 Dogwood Lane', N'9954902')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (596, N'Malcolm ', N'Dennis', N'541 2nd Street West', N'3185506')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (597, N'Marcia ', N'Dean', N'276 Route 11', N'4016853')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (598, N'Trudy ', N'Deleon', N'754 Cleveland Street', N'5867382')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (599, N'Jaclyn ', N'Decker', N'310 Evergreen Lane', N'4447567')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (600, N'Lorrie ', N'Dickson', N'896 3rd Street North', N'5040061')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (601, N'Jules ', N'Dillard', N'824 College Street', N'9130108')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (602, N'Adriana ', N'Dickerson', N'185 Church Road', N'1980388')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (603, N'Lon ', N'Dickson', N'239 5th Street', N'9051066')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (604, N'Stacy ', N'Dickerson', N'213 Redwood Drive', N'6441654')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (605, N'Dollie ', N'Dillon', N'973 6th Street West', N'3774531')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (606, N'Jimmy ', N'Diaz', N'510 B Street', N'8386579')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (607, N'Emily ', N'Diaz', N'884 Route 5', N'4627194')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (608, N'Amber ', N'Dixon', N'841 Brook Lane', N'3829634')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (609, N'Elwood ', N'Dorsey', N'790 Chestnut Street', N'5180266')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (610, N'Tameka ', N'Donaldson', N'319 Arch Street', N'7790965')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (611, N'Marsha ', N'Douglas', N'388 Highland Avenue', N'7521047')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (612, N'Leila ', N'Dodson', N'247 Main Street North', N'6511307')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (613, N'Paulette ', N'Doyle', N'771 Delaware Avenue', N'8411469')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (614, N'Melisa ', N'Dotson', N'305 Riverside Drive', N'5151622')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (615, N'Normand ', N'Donovan', N'514 Chestnut Street', N'9962995')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (616, N'Octavio ', N'Donaldson', N'804 Walnut Avenue', N'4394794')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (617, N'Trisha ', N'Dominguez', N'188 Prospect Street', N'3904901')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (618, N'Emerson ', N'Dotson', N'749 Hickory Street', N'1485396')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (619, N'Florine ', N'Downs', N'266 Highland Avenue', N'3565569')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (620, N'Royce ', N'Dominguez', N'978 Dogwood Lane', N'5707347')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (621, N'Stefan ', N'Dodson', N'130 Lexington Court', N'3378611')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (622, N'Lou ', N'Dorsey', N'349 Poplar Street', N'4729787')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (623, N'Tasha ', N'Drake', N'930 Orange Street', N'7408418')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (624, N'Erin ', N'Dunn', N'663 Chestnut Avenue', N'9170385')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (625, N'Carly ', N'Duke', N'286 Holly Court', N'2930484')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (626, N'Pedro ', N'Duncan', N'757 Madison Street', N'9950768')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (627, N'Alden ', N'Duffy', N'982 Washington Avenue', N'9283066')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (628, N'Dale ', N'Durham', N'401 Spruce Avenue', N'5373186')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (629, N'Jerrod ', N'Duke', N'288 Linden Street', N'8613875')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (630, N'Samantha ', N'Duncan', N'340 Route 11', N'3164572')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (631, N'Lloyd ', N'Dunn', N'951 Lakeview Drive', N'1225258')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (632, N'Earline ', N'Dudley', N'172 Oak Avenue', N'2817599')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (633, N'Hal ', N'Duran', N'695 3rd Avenue', N'5399531')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (634, N'Luann ', N'Dunlap', N'536 Elmwood Avenue', N'4529747')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (635, N'Ernie ', N'Dyer', N'292 Fulton Street', N'5434257')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (636, N'Norbert ', N'Eaton', N'178 Windsor Court', N'2992055')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (637, N'Helena ', N'Eaton', N'345 Laurel Lane', N'2675316')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (638, N'Joyce ', N'Edwards', N'288 Lincoln Avenue', N'1392733')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (639, N'Ryan ', N'Edwards', N'137 Jefferson Court', N'8286348')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (640, N'Bernardo ', N'Ellison', N'764 Prospect Street', N'7071408')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (641, N'Allen ', N'Ellis', N'184 Surrey Lane', N'9912793')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (642, N'Grace ', N'Ellis', N'821 Valley View Road', N'9133266')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (643, N'Rick ', N'Elliott', N'943 Cooper Street', N'9598317')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (644, N'Evangelina ', N'Emerson', N'126 3rd Street', N'3346608')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (645, N'Gerry ', N'English', N'375 Fawn Lane', N'5340922')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (646, N'Rhea ', N'England', N'619 Dogwood Drive', N'3352146')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (647, N'Sheena ', N'English', N'884 Cedar Avenue', N'9804130')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (648, N'Angelica ', N'Erickson', N'712 Heritage Drive', N'8911759')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (649, N'Cedric ', N'Erickson', N'327 8th Street', N'4528479')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (650, N'Woodrow ', N'Estrada', N'354 Hamilton Street', N'6990750')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (651, N'Elena ', N'Estrada', N'941 Front Street', N'7007811')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (652, N'Celeste ', N'Espinoza', N'443 Spruce Street', N'4768736')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (653, N'Efrain ', N'Espinoza', N'696 Lake Street', N'3219208')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (654, N'Jeri ', N'Everett', N'233 Liberty Street', N'4892682')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (655, N'Sanford ', N'Everett', N'976 4th Street North', N'2895007')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (656, N'Arthur ', N'Evans', N'452 Fairview Road', N'7437879')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (657, N'Ann ', N'Evans', N'598 Pine Street', N'3159607')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (658, N'Lawanda ', N'Ewing', N'816 Locust Lane', N'1280729')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (659, N'Mitch ', N'Ewing', N'546 Railroad Street', N'9754791')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (660, N'Odessa ', N'Faulkner', N'769 Taylor Street', N'6983966')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (661, N'Lula ', N'Farmer', N'333 Clinton Street', N'6166021')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (662, N'Damon ', N'Farmer', N'844 Cedar Court', N'8876596')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (663, N'Angelia ', N'Farrell', N'477 Hilltop Road', N'6967834')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (664, N'Roxie ', N'Farley', N'233 Court Street', N'1418824')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (665, N'Alex ', N'Ferguson', N'607 Delaware Avenue', N'9800713')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (666, N'Roland ', N'Fernandez', N'145 Lafayette Street', N'6411181')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (667, N'Jamar ', N'Ferrell', N'267 Route 41', N'2092433')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (668, N'Bertha ', N'Ferguson', N'931 Route 41', N'9523093')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (669, N'Melinda ', N'Fernandez', N'572 Route 27', N'9233425')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (670, N'Valeria ', N'Ferrell', N'240 Route 27', N'5589216')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (671, N'Darla ', N'Figueroa', N'600 Vine Street', N'3780086')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (672, N'Corinne ', N'Fischer', N'971 River Road', N'5520243')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (673, N'Marc ', N'Fields', N'755 Victoria Court', N'4891363')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (674, N'Margarito ', N'Fitzpatrick', N'784 Williams Street', N'6381915')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (675, N'Marcos ', N'Fitzgerald', N'659 Arch Street', N'2442032')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (676, N'Russel ', N'Fischer', N'412 Glenwood Drive', N'7993620')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (677, N'Vicki ', N'Fields', N'924 Main Street North', N'9973725')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (678, N'Letha ', N'Finley', N'812 Carriage Drive', N'9844641')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (679, N'Marci ', N'Fitzpatrick', N'114 Schoolhouse Lane', N'8285254')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (680, N'Terrell ', N'Figueroa', N'672 Route 202', N'3845589')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (681, N'Estelle ', N'Fitzgerald', N'581 Madison Avenue', N'8675671')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (682, N'Cindy ', N'Fisher', N'484 Route 202', N'8566889')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (683, N'Norman ', N'Fisher', N'654 Columbia Street', N'5497235')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (684, N'Marquita ', N'Finch', N'648 Mechanic Street', N'9827950')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (685, N'Julia ', N'Flores', N'659 Heritage Drive', N'5001023')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (686, N'Sadie ', N'Flowers', N'276 North Street', N'7973968')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (687, N'Armando ', N'Fleming', N'695 Heritage Drive', N'8204198')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (688, N'Micah ', N'Flynn', N'620 Country Lane', N'7526087')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (689, N'Myrtle ', N'Fleming', N'296 2nd Street', N'3206862')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (690, N'Kent ', N'Fletcher', N'628 Street Road', N'7508512')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (691, N'Abigail ', N'Flynn', N'428 13th Street', N'8148863')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (692, N'Clark ', N'Floyd', N'394 Queen Street', N'8599023')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (693, N'Pansy ', N'Forbes', N'818 Cottage Street', N'2690084')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (694, N'Phyllis ', N'Foster', N'612 Amherst Street', N'8171059')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (695, N'Ines ', N'Foreman', N'655 Buckingham Drive', N'7732754')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (696, N'Dolly ', N'Foley', N'330 Oak Avenue', N'2203322')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (697, N'Clarence ', N'Foster', N'364 Cypress Court', N'4294684')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (698, N'Roberto ', N'Fox', N'212 Cypress Court', N'9874713')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (699, N'Crystal ', N'Ford', N'486 Highland Avenue', N'6915608')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (700, N'Allan ', N'Fowler', N'176 Ridge Avenue', N'9185692')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (701, N'Bryan ', N'Ford', N'184 Main Street North', N'7636381')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (702, N'Clement ', N'Foley', N'143 Cypress Court', N'7026995')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (703, N'Holly ', N'Fox', N'984 Lake Avenue', N'6988052')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (704, N'Tessa ', N'Frye', N'560 6th Street West', N'9490381')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (705, N'Shannon ', N'Freeman', N'250 King Street', N'2310544')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (706, N'Glenda ', N'Frazier', N'272 Ridge Road', N'2700688')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (707, N'Jenna ', N'Frank', N'565 Hill Street', N'7690719')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (708, N'Eloise ', N'French', N'291 Grant Street', N'6261148')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (709, N'Dorian ', N'Fry', N'663 Mulberry Street', N'8031156')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (710, N'Scottie ', N'Franco', N'763 Pheasant Run', N'2441824')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (711, N'Beth ', N'Franklin', N'461 Warren Avenue', N'2472202')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (712, N'Ahmad ', N'Frye', N'796 Pennsylvania Avenue', N'3322206')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (713, N'Rodolfo ', N'Francis', N'456 Cedar Court', N'5143834')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (714, N'Lee ', N'Freeman', N'885 Virginia Avenue', N'2794856')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (715, N'Gena ', N'Frederick', N'488 Eagle Road', N'6664873')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (716, N'Myra ', N'Francis', N'843 Devon Court', N'1525276')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (717, N'Reva ', N'Fry', N'283 5th Street South', N'4647449')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (718, N'Greta ', N'Frost', N'162 Park Avenue', N'5398280')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (719, N'Britney ', N'Franks', N'337 Redwood Drive', N'4399583')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (720, N'Marcelino ', N'Frost', N'129 Sheffield Drive', N'8609706')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (721, N'Neil ', N'Fuller', N'342 Canterbury Road', N'5360641')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (722, N'Isiah ', N'Fulton', N'591 Main Street West', N'2551438')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (723, N'Antony ', N'Fuentes', N'468 Glenwood Drive', N'8122615')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (724, N'Rosalinda ', N'Fuentes', N'806 Fulton Street', N'4254369')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (725, N'Claudia ', N'Fuller', N'980 Belmont Avenue', N'7024610')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (726, N'Mitzi ', N'Fulton', N'667 Oxford Road', N'2438062')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (727, N'Fernando ', N'Garrett', N'541 4th Street', N'9121017')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (728, N'Carson ', N'Gay', N'469 Delaware Avenue', N'4851098')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (729, N'Steven ', N'Garcia', N'154 Cedar Street', N'2852378')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (730, N'Benita ', N'Gay', N'321 Grove Street', N'6512557')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (731, N'Keri ', N'Gallegos', N'384 Union Street', N'4222800')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (732, N'Carol ', N'Garcia', N'656 Warren Street', N'9633334')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (733, N'Tamika ', N'Garrison', N'828 Willow Drive', N'7463693')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (734, N'Jean ', N'Garner', N'582 Brown Street', N'2544223')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (735, N'Kathrine ', N'Galloway', N'302 Mill Street', N'7994367')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (736, N'Luz ', N'Garner', N'775 Westminster Drive', N'2514543')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (737, N'Joann ', N'Gardner', N'543 Virginia Avenue', N'6954546')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (738, N'Michael ', N'Gamble', N'495 Dogwood Lane', N'5664917')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (739, N'Stevie ', N'Gamble', N'622 8th Street South', N'9735141')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (740, N'Jarrett ', N'Galloway', N'778 West Avenue', N'2595952')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (741, N'Nellie ', N'Garrett', N'147 Prospect Avenue', N'4926931')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (742, N'Damien ', N'Garrison', N'529 Poplar Street', N'8907111')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (743, N'Pearl ', N'Garza', N'914 6th Avenue', N'6808191')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (744, N'Chuck ', N'Gallagher', N'582 Cottage Street', N'6288389')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (745, N'Arnold ', N'Garza', N'278 Cedar Avenue', N'5728611')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (746, N'Rory ', N'Gallegos', N'899 Harrison Avenue', N'8419372')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (747, N'Damian ', N'Gaines', N'172 Redwood Drive', N'3829622')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (748, N'Warren ', N'Gardner', N'749 14th Street', N'4439751')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (749, N'Humberto ', N'Gates', N'204 Willow Street', N'4249887')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (750, N'Claude ', N'George', N'322 Eagle Street', N'6521451')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (751, N'Vince ', N'Gentry', N'912 Essex Court', N'6376483')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (752, N'Rene ', N'Gentry', N'141 State Street', N'9907286')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (753, N'Arron ', N'Gillespie', N'821 Durham Road', N'5280263')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (754, N'Lane ', N'Giles', N'415 Walnut Street', N'7940920')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (755, N'Angelina ', N'Gibbs', N'913 Lake Avenue', N'6061508')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (756, N'Kristopher ', N'Gibbs', N'312 Woodland Drive', N'9323638')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (757, N'Angel ', N'Gill', N'608 6th Street West', N'9423693')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (758, N'Vincent ', N'Gibson', N'741 Summit Avenue', N'8743951')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (759, N'Althea ', N'Gillespie', N'278 Dogwood Lane', N'2634502')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (760, N'Kendall ', N'Gilmore', N'817 Jefferson Court', N'2475533')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (761, N'Kerri ', N'Gilmore', N'670 Cardinal Drive', N'6885884')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (762, N'Victoria ', N'Gibson', N'286 Heritage Drive', N'8576337')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (763, N'Tanya ', N'Gilbert', N'470 Rosewood Drive', N'7467073')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (764, N'Dallas ', N'Gill', N'362 Durham Court', N'8617409')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (765, N'Javier ', N'Gilbert', N'780 Hillcrest Drive', N'4347491')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (766, N'Elba ', N'Gilliam', N'890 7th Street', N'9008551')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (767, N'Antoinette ', N'Glover', N'608 William Street', N'8760910')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (768, N'Millard ', N'Glass', N'503 7th Street', N'5421705')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (769, N'Tonia ', N'Glass', N'931 West Avenue', N'4925137')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (770, N'Janette ', N'Glenn', N'364 Washington Avenue', N'7947117')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (771, N'Wilfredo ', N'Glenn', N'922 Mulberry Lane', N'7198085')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (772, N'Alton ', N'Glover', N'677 Hickory Lane', N'5949047')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (773, N'Josephine ', N'Gomez', N'809 Cambridge Road', N'8041521')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (774, N'Leticia ', N'Goodman', N'175 Pleasant Street', N'3481833')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (775, N'Mario ', N'Gordon', N'751 Hilltop Road', N'7242024')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (776, N'Joshua ', N'Gonzalez', N'411 Chestnut Street', N'5602401')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (777, N'Morton ', N'Gould', N'896 Cooper Street', N'2172686')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (778, N'Vicky ', N'Goodwin', N'901 Pheasant Run', N'8582798')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (779, N'Delbert ', N'Goodwin', N'428 Prospect Street', N'5705067')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (780, N'Katheryn ', N'Good', N'429 Harrison Street', N'9655798')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (781, N'Graciela ', N'Golden', N'731 Grant Avenue', N'1435956')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (782, N'Sean ', N'Gonzales', N'382 Race Street', N'3457070')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (783, N'Leslie ', N'Gordon', N'904 Cherry Lane', N'9567165')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (784, N'Annmarie ', N'Goff', N'857 5th Street East', N'1907169')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (785, N'Joesph ', N'Golden', N'206 Elm Street', N'3287262')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (786, N'Norma ', N'Gonzales', N'511 Summer Street', N'6959158')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (787, N'Chad ', N'Gomez', N'359 Howard Street', N'4349807')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (788, N'Adam ', N'Gray', N'215 Summer Street', N'2180079')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (789, N'Virginia ', N'Green', N'786 Redwood Drive', N'4910144')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (790, N'Iva ', N'Grimes', N'838 Mill Street', N'1201221')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (791, N'Andy ', N'Gregory', N'287 Route 17', N'3391679')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (792, N'Tom ', N'Grant', N'451 12th Street', N'5893012')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (793, N'Kari ', N'Gross', N'227 Lake Street', N'5154583')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (794, N'Quentin ', N'Grimes', N'530 Market Street', N'6385417')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (795, N'Jeanette ', N'Greene', N'364 4th Street North', N'7986090')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (796, N'Levi ', N'Gross', N'506 Main Street West', N'8146212')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (797, N'Luis ', N'Graham', N'473 Creek Road', N'9416383')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (798, N'Julian ', N'Graves', N'767 Grant Street', N'6556443')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (799, N'Michele ', N'Grant', N'318 Cemetery Road', N'5566457')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (800, N'Lillian ', N'Griffin', N'925 Cedar Lane', N'9286703')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (801, N'Sonya ', N'Griffith', N'449 Street Road', N'5297093')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (802, N'Rita ', N'Graham', N'205 Aspen Court', N'4657785')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (803, N'Judy ', N'Gray', N'140 Atlantic Avenue', N'3428622')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (804, N'Antonia ', N'Greer', N'499 Old York Road', N'7718636')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (805, N'Clint ', N'Greer', N'931 Cedar Court', N'8128785')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (806, N'Sonia ', N'Gregory', N'833 5th Street', N'6878929')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (807, N'Reginald ', N'Gutierrez', N'140 Maple Avenue', N'2162599')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (808, N'Noelle ', N'Guthrie', N'469 Fairway Drive', N'2563891')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (809, N'Owen ', N'Guerrero', N'779 Park Avenue', N'1474210')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (810, N'Keisha ', N'Guerra', N'429 6th Avenue', N'7615062')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (811, N'Hershel ', N'Guy', N'788 Route 202', N'6256386')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (812, N'Shannon ', N'Guzman', N'368 B Street', N'6236812')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (813, N'Carla ', N'Gutierrez', N'393 Park Drive', N'5477734')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (814, N'Muriel ', N'Guerrero', N'329 Hillside Avenue', N'7437747')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (815, N'Sammie ', N'Guerra', N'401 Oxford Road', N'3508051')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (816, N'Molly ', N'Guzman', N'524 Lafayette Avenue', N'4329411')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (817, N'Elvia ', N'Guy', N'694 Augusta Drive', N'4269617')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (818, N'Ezra ', N'Hayden', N'642 Willow Street', N'6500288')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (819, N'Kasey ', N'Hayden', N'686 Ivy Lane', N'5451047')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (820, N'Mai ', N'Hahn', N'524 Valley Drive', N'1451268')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (821, N'Nolan ', N'Harrell', N'731 Washington Avenue', N'7861310')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (822, N'Dan ', N'Hart', N'380 Central Avenue', N'1431638')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (823, N'Dana ', N'Hart', N'632 Hillside Avenue', N'2481702')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (824, N'Ned ', N'Hardin', N'271 Grove Street', N'2661809')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (825, N'Antonio ', N'Hayes', N'863 Broad Street', N'4441940')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (826, N'Ada ', N'Hardy', N'552 Grant Avenue', N'7442407')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (827, N'Delores ', N'Hansen', N'384 Madison Avenue', N'3172429')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (828, N'Tony ', N'Hamilton', N'355 Route 7', N'7852515')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (829, N'Francesca ', N'Haney', N'575 Durham Court', N'7402621')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (830, N'Vernon ', N'Harper', N'424 Bridge Street', N'5262849')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (831, N'Wm ', N'Harmon', N'669 Circle Drive', N'1132910')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (832, N'Donald ', N'Harris', N'248 Linda Lane', N'2962939')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (833, N'Jessica ', N'Hall', N'606 5th Street North', N'3263015')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (834, N'Roosevelt ', N'Hammond', N'155 Spruce Street', N'5853066')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (835, N'Bill ', N'Hawkins', N'415 Linda Lane', N'9083096')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (836, N'Wendell ', N'Hardy', N'161 Crescent Street', N'8513165')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (837, N'Adela ', N'Hatfield', N'142 Edgewood Drive', N'2273304')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (838, N'Lindsey ', N'Haynes', N'547 Route 20', N'6503399')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (839, N'Wendy ', N'Harrison', N'510 Delaware Avenue', N'3133454')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (840, N'Dirk ', N'Haley', N'754 5th Street South', N'5353463')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (841, N'Fay ', N'Hartman', N'547 Roberts Road', N'4403549')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (842, N'Helen ', N'Harris', N'239 Carriage Drive', N'2663704')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (843, N'Arlene ', N'Harvey', N'829 Canterbury Court', N'8494030')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (844, N'Irwin ', N'Hatfield', N'928 Market Street', N'5294979')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (845, N'Gregorio ', N'Hartman', N'799 Heather Lane', N'7975315')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (846, N'Mitchell ', N'Hansen', N'944 Locust Lane', N'8095394')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (847, N'Tamra ', N'Hays', N'401 Grove Street', N'8065486')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (848, N'Robin ', N'Hayes', N'431 Maple Street', N'4165638')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (849, N'Bethany ', N'Hammond', N'117 Valley Drive', N'9216221')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (850, N'Jeannette ', N'Harmon', N'609 Forest Drive', N'2716417')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (851, N'Gladys ', N'Hamilton', N'980 7th Street', N'3316477')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (852, N'Austin ', N'Haynes', N'285 Country Lane', N'3076496')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (853, N'Sharron ', N'Haley', N'208 Country Club Road', N'8996852')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (854, N'Josefina ', N'Harrington', N'887 2nd Street East', N'7606957')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (855, N'Stefanie ', N'Harrell', N'940 Park Avenue', N'8267500')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (856, N'Marianne ', N'Hampton', N'988 River Street', N'6057679')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (857, N'Harvey ', N'Harvey', N'830 10th Street', N'2848043')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (858, N'Jill ', N'Hawkins', N'445 Park Street', N'4478222')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (859, N'Eduardo ', N'Hale', N'715 Oak Street', N'2218445')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (860, N'Roberta ', N'Harper', N'408 Washington Avenue', N'7339058')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (861, N'Gary ', N'Hall', N'747 Buttonwood Drive', N'4929152')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (862, N'Viola ', N'Hanson', N'702 Fieldstone Drive', N'3689331')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (863, N'Dylan ', N'Hancock', N'472 Sycamore Lane', N'3209456')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (864, N'Nora ', N'Herrera', N'169 Colonial Drive', N'4920189')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (865, N'Twila ', N'Hewitt', N'914 Glenwood Drive', N'4450287')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (866, N'Angela ', N'Hernandez', N'715 Route 20', N'1432947')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (867, N'Andrea ', N'Henderson', N'317 Laurel Drive', N'5923611')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (868, N'Gale ', N'Herring', N'172 Bridle Lane', N'2203669')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (869, N'Carlos ', N'Henderson', N'230 2nd Street East', N'6643703')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (870, N'Larry ', N'Hernandez', N'630 Heather Court', N'1523725')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (871, N'Alisa ', N'Hess', N'347 Church Road', N'6484832')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (872, N'Esmeralda ', N'Hebert', N'598 Cherry Lane', N'6044836')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (873, N'Raymundo ', N'Hendricks', N'702 Bridle Lane', N'9215096')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (874, N'Houston ', N'Hebert', N'413 Madison Street', N'9555667')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (875, N'Charley ', N'Herman', N'572 Route 202', N'2095845')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (876, N'Hollie ', N'Head', N'549 Main Street South', N'6826300')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (877, N'Tamera ', N'Hendrix', N'361 Route 11', N'2176853')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (878, N'Rob ', N'Hess', N'887 10th Street', N'9296968')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (879, N'Cleveland ', N'Heath', N'257 Union Street', N'1677202')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (880, N'Lazaro ', N'Hester', N'624 Ridge Street', N'1268340')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (881, N'Dion ', N'Herring', N'185 5th Street North', N'9819513')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (882, N'Ila ', N'Herman', N'284 1st Street', N'2639528')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (883, N'Fabian ', N'Henson', N'439 Center Street', N'2599653')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (884, N'Joel ', N'Henry', N'610 Hickory Street', N'9249732')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (885, N'Karla ', N'Higgins', N'695 Prospect Street', N'5450769')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (886, N'Augustine ', N'Hinton', N'343 Wall Street', N'4050933')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (887, N'Anna ', N'Hill', N'933 Orange Street', N'3881499')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (888, N'Rodrigo ', N'Hickman', N'197 Dogwood Drive', N'3023639')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (889, N'Noemi ', N'Hinton', N'781 Spruce Avenue', N'3634577')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (890, N'Frederick ', N'Hicks', N'820 Jefferson Court', N'6525193')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (891, N'Maggie ', N'Hines', N'566 Holly Drive', N'7395330')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (892, N'Neal ', N'Hines', N'213 Franklin Court', N'2955460')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (893, N'Jeanine ', N'Hickman', N'760 Route 70', N'9716955')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (894, N'Monica ', N'Hicks', N'490 Route 20', N'4687357')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (895, N'Dewey ', N'Houston', N'267 Brookside Drive', N'6460097')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (896, N'Rose ', N'Howard', N'746 Maple Avenue', N'8520129')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (897, N'Billie ', N'Horton', N'501 North Street', N'8150251')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (898, N'Roslyn ', N'Hopper', N'952 13th Street', N'2240918')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (899, N'Tracy ', N'Holt', N'580 Route 41', N'4901546')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (900, N'Eddie ', N'Holder', N'882 Briarwood Drive', N'3841635')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (901, N'Bennett ', N'Holman', N'398 Jones Street', N'3881704')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (902, N'Patrice ', N'Hood', N'168 West Avenue', N'8802065')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (903, N'Romeo ', N'House', N'736 College Street', N'7452068')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (904, N'Willa ', N'House', N'211 Spruce Street', N'9452285')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (905, N'Cherie ', N'Horn', N'221 6th Street', N'1132437')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (906, N'Daren ', N'Horne', N'992 Pin Oak Drive', N'1753569')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (907, N'Adrian ', N'Holcomb', N'961 College Avenue', N'5483838')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (908, N'Willie ', N'Howell', N'135 Fieldstone Drive', N'1293971')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (909, N'Roy ', N'Howard', N'958 Brookside Drive', N'7114124')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (910, N'Josef ', N'Hooper', N'848 Walnut Street', N'9144320')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (911, N'Johnie ', N'Hopper', N'571 10th Street', N'1324440')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (912, N'Guy ', N'Hoffman', N'273 Devonshire Drive', N'7514779')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (913, N'Aisha ', N'Holden', N'932 Union Street', N'6464943')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (914, N'Lucille ', N'Holmes', N'755 Monroe Street', N'2255081')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (915, N'Taylor ', N'Howe', N'944 Cedar Lane', N'3175165')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (916, N'Jan ', N'Hogan', N'384 Church Road', N'3545743')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (917, N'Roseann ', N'Hooper', N'650 Canterbury Drive', N'4576228')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (918, N'Gracie ', N'Hobbs', N'203 Lantern Lane', N'5776309')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (919, N'Tami ', N'Hogan', N'271 Lakeview Drive', N'8056693')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (920, N'Hilda ', N'Hopkins', N'614 2nd Street North', N'8916704')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (921, N'Tania ', N'Horne', N'972 Park Drive', N'6956871')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (922, N'Kelley ', N'Holloway', N'749 Locust Lane', N'2767368')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (923, N'Mattie ', N'Hoffman', N'871 Pearl Street', N'9027440')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (924, N'Desmond ', N'Horn', N'518 Water Street', N'6617804')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (925, N'Trent ', N'Hood', N'460 5th Street East', N'9517887')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (926, N'Garland ', N'Hodge', N'119 Penn Street', N'7148222')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (927, N'Johnnie ', N'Hodges', N'295 Laurel Drive', N'4438379')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (928, N'Cheri ', N'Hodge', N'781 Central Avenue', N'3568432')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (929, N'Mabel ', N'Holland', N'778 Ann Street', N'1958533')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (930, N'Lowell ', N'Hodges', N'273 Hillcrest Avenue', N'1459003')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (931, N'Morris ', N'Horton', N'920 Route 70', N'8009132')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (932, N'Brad ', N'Howell', N'476 Spruce Avenue', N'4679951')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (933, N'Lauren ', N'Hudson', N'910 6th Street', N'4920354')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (934, N'Autumn ', N'Hurst', N'961 Jones Street', N'9270822')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (935, N'Bradford ', N'Huff', N'286 3rd Street', N'3230965')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (936, N'Lupe ', N'Hutchinson', N'848 Forest Street', N'3311430')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (937, N'Ola ', N'Humphrey', N'507 Spring Street', N'4281558')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (938, N'Todd ', N'Hughes', N'837 Church Street', N'1322320')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (939, N'Rod ', N'Humphrey', N'879 Route 6', N'8962433')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (940, N'Young ', N'Hurley', N'314 Lantern Lane', N'2023605')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (941, N'Kellie ', N'Huff', N'434 3rd Street North', N'3514208')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (942, N'Herbert ', N'Hunter', N'643 5th Street North', N'1676235')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (943, N'Eleanor ', N'Hunt', N'402 Creek Road', N'4546986')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (944, N'Bryce ', N'Huffman', N'317 Hickory Street', N'3006992')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (945, N'Charlotte ', N'Hunter', N'684 Valley View Drive', N'3907357')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (946, N'Leanne ', N'Hull', N'656 Clay Street', N'6977650')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (947, N'Marcie ', N'Hurley', N'508 1st Avenue', N'2728122')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (948, N'Brain ', N'Hutchinson', N'113 4th Street', N'8849422')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (949, N'Wilbur ', N'Hubbard', N'770 4th Street West', N'2879432')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (950, N'Bobbie ', N'Hurst', N'461 Mill Street', N'4419529')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (951, N'Lee ', N'Hubbard', N'154 Briarwood Drive', N'3689587')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (952, N'Cole ', N'Hull', N'896 Colonial Avenue', N'4199789')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (953, N'Bonnie ', N'Hughes', N'392 Park Drive', N'7759957')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (954, N'Vonda ', N'Hyde', N'944 Aspen Drive', N'8827105')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (955, N'Bennie ', N'Ingram', N'157 Lincoln Avenue', N'4284042')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (956, N'Celia ', N'Ingram', N'788 Eagle Road', N'8418424')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (957, N'Eliseo ', N'Jarvis', N'270 Sunset Avenue', N'8601127')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (958, N'Wendi ', N'Jarvis', N'136 2nd Street West', N'5512122')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (959, N'Emilia ', N'Jacobson', N'899 Buttonwood Drive', N'7004592')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (960, N'Paul ', N'Jackson', N'582 Orchard Street', N'2074733')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (961, N'Erik ', N'Jacobs', N'692 3rd Street West', N'7395470')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (962, N'Kathy ', N'James', N'423 Brown Street', N'3606236')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (963, N'Georgia ', N'Jacobs', N'693 Madison Avenue', N'4566640')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (964, N'Fred ', N'James', N'529 Beechwood Drive', N'7256878')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (965, N'Bobby ', N'Jenkins', N'331 South Street', N'6611743')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (966, N'Phil ', N'Jefferson', N'705 6th Street', N'9032222')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (967, N'Naomi ', N'Jennings', N'985 Oak Lane', N'7492495')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (968, N'Elvira ', N'Jefferson', N'842 Aspen Drive', N'1665136')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (969, N'Sidney ', N'Jennings', N'743 Route 44', N'3797075')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (970, N'Felix ', N'Jensen', N'125 Brookside Drive', N'5888093')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (971, N'Louise ', N'Jenkins', N'421 Route 9', N'1179525')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (972, N'Olga ', N'Jimenez', N'129 Country Club Drive', N'4490076')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (973, N'Isaac ', N'Jimenez', N'611 Amherst Street', N'2003572')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (974, N'Tiffany ', N'Jordan', N'931 Maple Avenue', N'1720632')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (975, N'Barbara ', N'Jones', N'559 Morris Street', N'9420768')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (976, N'Lavonne ', N'Joyner', N'167 4th Street West', N'7581450')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (977, N'Abdul ', N'Joyner', N'689 Forest Drive', N'8043039')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (978, N'Manuel ', N'Jordan', N'398 Oak Lane', N'9803631')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (979, N'Ali ', N'Johns', N'633 Front Street', N'5785929')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (980, N'Blanca ', N'Joseph', N'855 Adams Street', N'5996331')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (981, N'Concepcion ', N'Joyce', N'476 Arlington Avenue', N'1288583')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (982, N'Spencer ', N'Joseph', N'711 Creek Road', N'4418764')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (983, N'Kristin ', N'Johnston', N'537 Market Street', N'8679506')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (984, N'John ', N'Johnson', N'263 Valley View Road', N'8899567')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (985, N'Hiram ', N'Juarez', N'705 Linden Street', N'2501520')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (986, N'Christi ', N'Juarez', N'582 John Street', N'7382855')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (987, N'Juliet ', N'Justice', N'340 6th Avenue', N'6839616')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (988, N'Corrine ', N'Kane', N'680 Chapel Street', N'7110659')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (989, N'Mariano ', N'Kane', N'145 Jackson Avenue', N'6038044')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (990, N'Jannie ', N'Kaufman', N'902 Railroad Avenue', N'7278496')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (991, N'Kermit ', N'Kemp', N'154 Spruce Street', N'5941508')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (992, N'Tyler ', N'Kelley', N'120 Highland Drive', N'6031879')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (993, N'Dick ', N'Kerr', N'765 Academy Street', N'8472398')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (994, N'Rhoda ', N'Kerr', N'444 Ivy Lane', N'5992427')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (995, N'Cyrus ', N'Key', N'702 Carriage Drive', N'6415664')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (996, N'Denise ', N'Kelly', N'362 Park Drive', N'3736315')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (997, N'Ricky ', N'Kennedy', N'582 5th Street South', N'2817221')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (998, N'Clare ', N'Key', N'739 Beechwood Drive', N'6607726')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (999, N'Steve ', N'Kelly', N'878 2nd Street East', N'9087749')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1000, N'Blanche ', N'Keller', N'524 Spring Street', N'8917945')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1001, N'Homer ', N'Keller', N'989 14th Street', N'3568289')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1002, N'Margo ', N'Kent', N'778 Academy Street', N'1378907')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1003, N'Rhonda ', N'Kennedy', N'309 Sunset Drive', N'1139346')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1004, N'Carissa ', N'Kirkland', N'248 Church Road', N'3601099')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1005, N'Aurora ', N'Kirby', N'408 William Street', N'3912202')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1006, N'Eli ', N'Kirby', N'908 3rd Avenue', N'3073131')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1007, N'Jeffrey ', N'King', N'546 Fairview Road', N'6373536')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1008, N'Lillie ', N'Kim', N'927 Smith Street', N'9044086')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1009, N'Melissa ', N'King', N'332 Orchard Street', N'2315065')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1010, N'Karyn ', N'Kinney', N'123 Sycamore Drive', N'3785358')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1011, N'Lucinda ', N'Kirk', N'926 Mill Street', N'8118119')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1012, N'Teri ', N'Klein', N'450 Ridge Road', N'1531828')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1013, N'Wilfred ', N'Klein', N'909 Colonial Avenue', N'5244794')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1014, N'Booker ', N'Kline', N'136 Street Road', N'8597733')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1015, N'Loraine ', N'Kline', N'701 Fieldstone Drive', N'1428056')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1016, N'Edwardo ', N'Knapp', N'439 2nd Street East', N'7440863')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1017, N'Harriett ', N'Knapp', N'506 Route 44', N'3023543')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1018, N'Marisa ', N'Knox', N'227 12th Street East', N'8457750')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1019, N'Calvin ', N'Knight', N'453 Ivy Court', N'8278862')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1020, N'Estela ', N'Koch', N'537 Chapel Street', N'1304969')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1021, N'Aurelio ', N'Koch', N'411 Heather Lane', N'1745184')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1022, N'Tracie ', N'Kramer', N'735 Mill Road', N'9055199')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1023, N'Callie ', N'Lara', N'141 Howard Street', N'4220210')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1024, N'Burton ', N'Larsen', N'319 Riverside Drive', N'5580361')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1025, N'Federico ', N'Lara', N'350 Oak Lane', N'4731131')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1026, N'Laurie ', N'Lawrence', N'461 Fairway Drive', N'8481335')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1027, N'Corey ', N'Lane', N'404 New Street', N'8572114')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1028, N'Mathew ', N'Larson', N'591 4th Avenue', N'3393774')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1029, N'Renee ', N'Lane', N'414 Pleasant Street', N'7553874')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1030, N'Randal ', N'Lamb', N'502 Canal Street', N'6854622')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1031, N'Elsa ', N'Lamb', N'326 Schoolhouse Lane', N'4964645')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1032, N'Lara ', N'Landry', N'797 Oxford Road', N'5555197')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1033, N'Lesa ', N'Langley', N'146 Smith Street', N'5165400')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1034, N'Jeanne ', N'Lawson', N'763 Jefferson Street', N'7815882')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1035, N'Seth ', N'Lambert', N'730 Hickory Street', N'7986453')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1036, N'Francisca ', N'Lang', N'836 6th Street North', N'5266789')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1037, N'Maxwell ', N'Landry', N'422 Meadow Lane', N'3446925')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1038, N'Heidi ', N'Larson', N'133 Brown Street', N'9988096')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1039, N'Misty ', N'Lambert', N'388 Linden Street', N'3078660')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1040, N'Gene ', N'Lawson', N'800 Grant Street', N'9258787')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1041, N'Janell ', N'Le', N'693 Cooper Street', N'1161126')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1042, N'Carey ', N'Lester', N'384 Winding Way', N'7961282')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1043, N'Reinaldo ', N'Levy', N'649 Brown Street', N'5921444')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1044, N'Ollie ', N'Leon', N'321 Spruce Avenue', N'8861609')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1045, N'Kevin ', N'Lewis', N'189 Heather Lane', N'1672028')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1046, N'Jason ', N'Lee', N'721 Cypress Court', N'9253261')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1047, N'Joanna ', N'Leonard', N'157 Pennsylvania Avenue', N'6913502')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1048, N'Luella ', N'Leon', N'697 Locust Lane', N'6803940')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1049, N'Rosario ', N'Lester', N'884 Canterbury Road', N'2044674')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1050, N'Lorie ', N'Leach', N'937 Sunset Avenue', N'8374892')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1051, N'Chasity ', N'Levy', N'392 Smith Street', N'9495194')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1052, N'Emery ', N'Leach', N'675 Crescent Street', N'9205451')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1053, N'Kimberly ', N'Lee', N'370 Cambridge Court', N'4296656')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1054, N'Denny ', N'Leblanc', N'792 3rd Avenue', N'7628979')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1055, N'Jeannine ', N'Leblanc', N'796 3rd Street North', N'6029271')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1056, N'Jared ', N'Little', N'892 Cherry Street', N'3951771')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1057, N'Maureen ', N'Little', N'954 Main Street North', N'7755940')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1058, N'Rufus ', N'Lindsey', N'159 Henry Street', N'6086049')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1059, N'Fanny ', N'Lindsay', N'526 1st Avenue', N'8357701')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1060, N'Latisha ', N'Livingston', N'841 Prospect Avenue', N'6178735')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1061, N'Lana ', N'Lloyd', N'886 Winding Way', N'4370836')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1062, N'Jeremiah ', N'Love', N'492 Grant Avenue', N'3520087')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1063, N'Elmo ', N'Lott', N'983 Henry Street', N'8150216')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1064, N'Scott ', N'Lopez', N'694 Locust Street', N'8560422')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1065, N'Jacqueline ', N'Long', N'656 Elm Street', N'8732161')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1066, N'Ernest ', N'Long', N'300 Valley View Road', N'8796360')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1067, N'Amy ', N'Lopez', N'223 Ashley Court', N'4726535')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1068, N'Johnnie ', N'Lowe', N'244 Olive Street', N'1857730')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1069, N'Gabrielle ', N'Lowery', N'246 Belmont Avenue', N'1218282')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1070, N'Elbert ', N'Logan', N'625 Maple Avenue', N'3498897')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1071, N'Natasha ', N'Love', N'193 Smith Street', N'5599225')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1072, N'Vern ', N'Lowery', N'704 Amherst Street', N'5189491')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1073, N'Velma ', N'Lucas', N'404 Riverside Drive', N'2610695')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1074, N'Salvador ', N'Lucas', N'668 Brook Lane', N'7781996')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1075, N'Cary ', N'Luna', N'348 Fawn Lane', N'2038791')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1076, N'Jessie ', N'Lynch', N'153 Inverness Drive', N'5903914')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1077, N'Angelo ', N'Lyons', N'214 Lincoln Avenue', N'8398211')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1078, N'Jackie ', N'Lynch', N'907 Sycamore Lane', N'2588290')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1079, N'Dona ', N'Maddox', N'792 Park Street', N'2830445')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1080, N'Sasha ', N'Mayer', N'372 Park Street', N'6350508')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1081, N'Don ', N'Mason', N'490 Laurel Street', N'6870666')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1082, N'Fern ', N'Mathews', N'378 Pleasant Street', N'6530928')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1083, N'Sandra ', N'Martin', N'299 Pine Street', N'2661204')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1084, N'Kim ', N'Malone', N'918 Garfield Avenue', N'7481830')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1085, N'Edward ', N'Martinez', N'487 Holly Court', N'8341952')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1086, N'Archie ', N'Manning', N'808 Maple Street', N'8082246')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1087, N'Sherry ', N'Marshall', N'855 Prospect Avenue', N'6292252')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1088, N'Andres ', N'Mack', N'757 Hillcrest Drive', N'9182486')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1089, N'Gwendolyn ', N'May', N'136 Wood Street', N'8542545')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1090, N'Toby ', N'Mathis', N'872 Cemetery Road', N'6592568')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1091, N'Ferdinand ', N'Mayo', N'138 Laurel Lane', N'9772668')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1092, N'Marta ', N'Mathis', N'950 Cooper Street', N'7642869')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1093, N'Candice ', N'Manning', N'434 Colonial Drive', N'2423300')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1094, N'Pat ', N'Maldonado', N'389 Cambridge Road', N'9513303')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1095, N'Rickie ', N'Maynard', N'223 Ridge Avenue', N'9533445')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1096, N'Alexis ', N'Marsh', N'874 Green Street', N'4083574')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1097, N'Pat ', N'Marsh', N'626 8th Avenue', N'8433970')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1098, N'George ', N'Martin', N'690 Franklin Court', N'9064188')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1099, N'Leonardo ', N'Mathews', N'919 Linda Lane', N'4424479')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1100, N'Otto ', N'Marquez', N'580 School Street', N'7355086')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1101, N'Darin ', N'Massey', N'472 Creek Road', N'4895611')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1102, N'Aline ', N'Mayo', N'968 Route 1', N'1135715')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1103, N'Rich ', N'Macdonald', N'561 Ridge Avenue', N'8745750')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1104, N'Olivia ', N'Mack', N'871 Glenwood Drive', N'3666331')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1105, N'Brooke ', N'Malone', N'389 Court Street', N'5386335')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1106, N'Rena ', N'Marquez', N'913 Chapel Street', N'6916619')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1107, N'Ira ', N'Mann', N'287 Inverness Drive', N'1456949')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1108, N'Hester ', N'Macias', N'286 Deerfield Drive', N'4187039')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1109, N'Ruth ', N'Martinez', N'838 Elizabeth Street', N'5187063')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1110, N'Tabatha ', N'Mays', N'879 6th Avenue', N'4547071')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1111, N'Adan ', N'Maddox', N'319 Roberts Road', N'4547316')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1112, N'Lila ', N'Massey', N'588 Washington Street', N'8267408')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1113, N'Dino ', N'Mayer', N'707 Center Street', N'7707456')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1114, N'Erica ', N'Matthews', N'847 Lake Street', N'5567511')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1115, N'Cathleen ', N'Maynard', N'143 Maiden Lane', N'8567627')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1116, N'Edmund ', N'Maldonado', N'292 Henry Street', N'1968062')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1117, N'Edwina ', N'Macdonald', N'440 Canal Street', N'3878272')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1118, N'Susie ', N'Mann', N'489 Prospect Avenue', N'7228473')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1119, N'Clarice ', N'Marks', N'404 Cedar Court', N'9588484')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1120, N'Angelita ', N'Madden', N'406 Fairway Drive', N'2518943')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1121, N'Derick ', N'Marks', N'170 Adams Street', N'3779081')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1122, N'Wallace ', N'May', N'743 Cottage Street', N'4659364')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1123, N'Travis ', N'Marshall', N'947 Evergreen Lane', N'5559991')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1124, N'Russ ', N'Mcneil', N'289 Main Street', N'7100116')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1125, N'Miriam ', N'Mckinney', N'411 9th Street', N'3790579')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1126, N'Janna ', N'Mcpherson', N'751 12th Street', N'4420867')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1127, N'Santos ', N'Mcguire', N'707 Creekside Drive', N'8641031')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1128, N'Mamie ', N'Mcgee', N'548 Oxford Court', N'6541105')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1129, N'Phoebe ', N'Mcfadden', N'861 Hickory Street', N'2911367')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1130, N'Melva ', N'Mccarty', N'410 Warren Avenue', N'5902055')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1131, N'Clair ', N'Mcknight', N'853 8th Street', N'9252131')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1132, N'Jasper ', N'Mcclain', N'682 Park Drive', N'4862211')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1133, N'Bernie ', N'Mcmillan', N'851 Howard Street', N'3662396')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1134, N'Pearlie ', N'Mcintyre', N'222 Buttonwood Drive', N'2862889')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1135, N'Jami ', N'Mcknight', N'569 Pin Oak Drive', N'8383005')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1136, N'Rigoberto ', N'Mcclure', N'475 Maple Street', N'2943027')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1137, N'Caleb ', N'Mclaughlin', N'780 Ridge Avenue', N'4403532')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1138, N'Edith ', N'Mcdonald', N'363 3rd Street West', N'1243607')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1139, N'Mary ', N'Mckee', N'422 Aspen Court', N'9853752')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1140, N'Shawna ', N'Mckenzie', N'151 Hillcrest Avenue', N'3334420')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1141, N'Meghan ', N'Mclaughlin', N'285 Depot Street', N'5334485')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1142, N'Ora ', N'Mcguire', N'941 5th Street West', N'2054594')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1143, N'Justine ', N'Mclean', N'543 3rd Street East', N'4374702')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1144, N'Basil ', N'Mclean', N'963 Hawthorne Lane', N'2234836')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1145, N'Mercedes ', N'Mcbride', N'493 College Avenue', N'2794900')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1146, N'Socorro ', N'Mccall', N'685 Franklin Court', N'8614966')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1147, N'Winnie ', N'Mckee', N'500 Fairway Drive', N'9735258')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1148, N'Gilda ', N'Mcleod', N'857 B Street', N'6335330')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1149, N'Jame ', N'Mcintyre', N'863 Brookside Drive', N'6435733')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1150, N'Rusty ', N'Mcdowell', N'835 6th Street West', N'4875888')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1151, N'Bryant ', N'Mccarthy', N'346 Route 41', N'8036033')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1152, N'Lacey ', N'Mcdowell', N'187 10th Street', N'5696106')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1153, N'Marshall ', N'Mckinney', N'934 Lakeview Drive', N'6326750')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1154, N'Vera ', N'Mccoy', N'556 Lantern Lane', N'4836854')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1155, N'Terence ', N'Mccormick', N'192 Brookside Drive', N'5476955')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1156, N'Amalia ', N'Mcgowan', N'614 Walnut Street', N'1527032')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1157, N'Haley ', N'Mcconnell', N'190 Elm Street', N'8487472')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1158, N'Bridgett ', N'Mccray', N'739 Woodland Road', N'3717541')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1159, N'Royal ', N'Mccarty', N'572 Morris Street', N'4317654')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1160, N'Aldo ', N'Mckay', N'778 Clark Street', N'8987709')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1161, N'Jonas ', N'Mcfarland', N'239 Carriage Drive', N'4168172')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1162, N'Lindsay ', N'Mcdaniel', N'483 Glenwood Avenue', N'5918250')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1163, N'Tanisha ', N'Mcfarland', N'880 Main Street East', N'4478534')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1164, N'Stuart ', N'Mcdaniel', N'471 Cypress Court', N'3968538')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1165, N'Collin ', N'Mccullough', N'999 Sycamore Street', N'5229094')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1166, N'Hunter ', N'Mcintosh', N'277 Mechanic Street', N'5049435')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1167, N'Louella ', N'Mcmahon', N'799 Church Street', N'6029642')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1168, N'Scot ', N'Mccall', N'985 Route 44', N'8909881')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1169, N'Kenya ', N'Melendez', N'421 Laurel Drive', N'1140710')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1170, N'Mohammad ', N'Mejia', N'660 West Avenue', N'2741040')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1171, N'Franklin ', N'Meyer', N'932 Mulberry Court', N'6811401')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1172, N'Bettie ', N'Melton', N'149 George Street', N'8431433')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1173, N'Kurt ', N'Medina', N'414 Jefferson Street', N'6421458')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1174, N'Jeanie ', N'Meadows', N'906 Aspen Court', N'8251651')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1175, N'Natalie ', N'Meyer', N'956 Warren Avenue', N'1813458')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1176, N'Fredrick ', N'Mendez', N'686 Lexington Court', N'8563770')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1177, N'Suzette ', N'Mercer', N'564 Oak Avenue', N'4784662')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1178, N'Morgan ', N'Meyers', N'124 Hillside Drive', N'9674856')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1179, N'Odell ', N'Mercado', N'241 Cherry Lane', N'4775327')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1180, N'Geneva ', N'Mendez', N'462 Cedar Avenue', N'4655676')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1181, N'Alphonse ', N'Melendez', N'453 Brook Lane', N'1645958')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1182, N'Vance ', N'Meyers', N'114 Pennsylvania Avenue', N'2856835')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1183, N'Hans ', N'Melton', N'148 Park Drive', N'1847314')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1184, N'Lidia ', N'Mejia', N'281 Madison Avenue', N'3987404')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1185, N'Arline ', N'Merrill', N'556 Pennsylvania Avenue', N'3427840')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1186, N'Monroe ', N'Meadows', N'683 Oxford Road', N'4098550')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1187, N'Tracey ', N'Mercer', N'433 Maiden Lane', N'7839258')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1188, N'Shana ', N'Merritt', N'885 5th Street South', N'1669715')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1189, N'Refugio ', N'Merrill', N'524 Broad Street', N'2999892')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1190, N'Adeline ', N'Miranda', N'275 3rd Street East', N'6770689')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1191, N'Jay ', N'Mills', N'533 Hamilton Street', N'7450787')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1192, N'Alyce ', N'Michael', N'823 Belmont Avenue', N'5131784')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1193, N'Alicia ', N'Mills', N'215 Fawn Lane', N'7725271')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1194, N'Maria ', N'Miller', N'647 Ridge Road', N'9805977')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1195, N'Stephanie ', N'Mitchell', N'749 Cedar Lane', N'8496108')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1196, N'Richard ', N'Miller', N'663 Heather Court', N'3806586')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1197, N'Barbra ', N'Middleton', N'772 Garden Street', N'4287215')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1198, N'Perry ', N'Miles', N'163 Amherst Street', N'8658810')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1199, N'Truman ', N'Middleton', N'397 Creek Road', N'1628855')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1200, N'Kris ', N'Miranda', N'339 Hillcrest Avenue', N'9309341')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1201, N'Barton ', N'Michael', N'312 Mill Street', N'7689868')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1202, N'Rebekah ', N'Morrow', N'400 Clark Street', N'1550011')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1203, N'Cesar ', N'Moss', N'224 Route 202', N'1220073')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1204, N'Jeffry ', N'Moses', N'928 Berkshire Drive', N'6310255')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1205, N'Harrison ', N'Mosley', N'371 Magnolia Drive', N'8100326')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1206, N'Delia ', N'Morton', N'842 Jefferson Street', N'2150389')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1207, N'Chandra ', N'Moon', N'312 Main Street West', N'1260421')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1208, N'Cornelia ', N'Morse', N'449 Creek Road', N'3330742')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1209, N'Forrest ', N'Moody', N'542 Roberts Road', N'3571242')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1210, N'Traci ', N'Moody', N'175 Fawn Lane', N'7601351')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1211, N'Donny ', N'Morse', N'811 Lincoln Avenue', N'2141781')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1212, N'Logan ', N'Monroe', N'578 Route 1', N'6111836')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1213, N'Evelyn ', N'Morgan', N'743 South Street', N'3761980')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1214, N'Thurman ', N'Montoya', N'840 Sycamore Lane', N'5862069')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1215, N'Frankie ', N'Moran', N'846 Franklin Avenue', N'3702627')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1216, N'Jenifer ', N'Mosley', N'144 Myrtle Avenue', N'8273623')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1217, N'Stella ', N'Moreno', N'856 High Street', N'2933660')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1218, N'Gretchen ', N'Moran', N'961 Madison Street', N'8334118')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1219, N'Freddy ', N'Molina', N'822 Chestnut Avenue', N'5394216')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1220, N'Raul ', N'Montgomery', N'252 Ivy Lane', N'8004568')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1221, N'Terry ', N'Morgan', N'143 Brookside Drive', N'9464918')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1222, N'Ron ', N'Morrison', N'797 Route 10', N'2995667')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1223, N'Rodger ', N'Morrow', N'430 Valley Road', N'4725906')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1224, N'Hung ', N'Morin', N'817 John Street', N'6376083')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1225, N'Bessie ', N'Morrison', N'144 College Street', N'4116277')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1226, N'Stacey ', N'Montgomery', N'132 Augusta Drive', N'8206425')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1227, N'Heather ', N'Morris', N'903 Route 202', N'5836508')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1228, N'Cara ', N'Monroe', N'442 Riverside Drive', N'1976997')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1229, N'German ', N'Moon', N'795 Mulberry Lane', N'1227419')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1230, N'Anita ', N'Morales', N'304 Ashley Court', N'6177644')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1231, N'Jack ', N'Morris', N'476 Cypress Court', N'1208727')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1232, N'Eddie ', N'Morales', N'966 Broad Street', N'4809147')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1233, N'Flora ', N'Moss', N'344 Willow Drive', N'1889608')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1234, N'Sallie ', N'Molina', N'697 2nd Street', N'6599696')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1235, N'Imogene ', N'Montoya', N'161 Warren Avenue', N'7439869')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1236, N'Lynn ', N'Mullins', N'448 Devon Court', N'2663585')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1237, N'Jacob ', N'Murray', N'589 Route 9', N'6033803')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1238, N'Eloy ', N'Mullen', N'688 Creekside Drive', N'6704305')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1239, N'Susanna ', N'Mullen', N'695 5th Street East', N'7584417')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1240, N'Oliver ', N'Munoz', N'684 Route 64', N'5624979')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1241, N'Xavier ', N'Mueller', N'954 Warren Avenue', N'3977179')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1242, N'Cheryl ', N'Murphy', N'604 Charles Street', N'2467393')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1243, N'Kristi ', N'Munoz', N'750 Sunset Drive', N'6938470')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1244, N'Thelma ', N'Murray', N'427 Augusta Drive', N'3899557')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1245, N'Madeline ', N'Mullins', N'655 York Street', N'4349880')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1246, N'Keith ', N'Murphy', N'488 Highland Avenue', N'3589903')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1247, N'Danny ', N'Myers', N'111 Mill Street', N'1275569')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1248, N'Peggy ', N'Myers', N'916 Essex Court', N'5575746')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1249, N'Jaime ', N'Nash', N'522 Garden Street', N'5631172')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1250, N'Cleo ', N'Navarro', N'721 Center Street', N'4323237')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1251, N'Williams ', N'Navarro', N'636 Devonshire Drive', N'8116851')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1252, N'Claire ', N'Newman', N'676 Route 29', N'5900749')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1253, N'Dave ', N'Neal', N'121 B Street', N'7361186')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1254, N'Jerry ', N'Nelson', N'474 West Avenue', N'7281203')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1255, N'Garry ', N'Newton', N'312 Old York Road', N'8731875')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1256, N'Wade ', N'Newman', N'778 Devonshire Drive', N'6872256')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1257, N'Debra ', N'Nelson', N'198 Linda Lane', N'9045876')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1258, N'Penny ', N'Neal', N'674 Grove Street', N'3198866')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1259, N'Hannah ', N'Newton', N'420 Woodland Road', N'7499453')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1260, N'Tamara ', N'Nguyen', N'464 Poplar Street', N'5795775')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1261, N'Cory ', N'Nguyen', N'507 Holly Drive', N'7286112')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1262, N'Suzanne ', N'Nichols', N'297 Main Street West', N'6461259')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1263, N'Rosella ', N'Nielsen', N'115 Canal Street', N'4702382')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1264, N'Lolita ', N'Nieves', N'252 Charles Street', N'8292511')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1265, N'Billie ', N'Nicholson', N'140 Route 29', N'5132520')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1266, N'Katharine ', N'Nixon', N'574 Maiden Lane', N'3213381')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1267, N'Jim ', N'Nichols', N'508 Clinton Street', N'2198264')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1268, N'Alexandra ', N'Norman', N'148 Orange Street', N'7360154')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1269, N'Sylvester ', N'Norman', N'128 Old York Road', N'9240534')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1270, N'Faye ', N'Norris', N'862 6th Avenue', N'2702430')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1271, N'Carter ', N'Nolan', N'591 Mill Street', N'2012869')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1272, N'Dexter ', N'Norton', N'163 Lake Avenue', N'6923374')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1273, N'Selma ', N'Noble', N'360 Route 9', N'1273903')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1274, N'Catalina ', N'Nolan', N'613 Virginia Avenue', N'9664311')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1275, N'Luther ', N'Norris', N'250 Mulberry Court', N'4605474')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1276, N'Terra ', N'Noel', N'382 Elm Street', N'9228717')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1277, N'Lorena ', N'Norton', N'713 Route 32', N'4779583')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1278, N'Orville ', N'Nunez', N'352 9th Street', N'1721369')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1279, N'Betsy ', N'Nunez', N'702 Prospect Avenue', N'3076937')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1280, N'Leona ', N'Obrien', N'375 Cardinal Drive', N'9150877')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1281, N'Rocky ', N'Oconnor', N'766 Lexington Court', N'8051202')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1282, N'Milagros ', N'Ochoa', N'489 Jefferson Avenue', N'9056371')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1283, N'Weston ', N'Odonnell', N'165 Mulberry Lane', N'4250576')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1284, N'James ', N'Odonnell', N'869 West Avenue', N'1832225')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1285, N'Antwan ', N'Odom', N'453 Willow Drive', N'1744547')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1286, N'Imelda ', N'Odom', N'124 Crescent Street', N'5645452')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1287, N'Darwin ', N'Olsen', N'319 Clark Street', N'2635492')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1288, N'Milton ', N'Oliver', N'461 Hillcrest Avenue', N'4157790')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1289, N'Annette ', N'Olson', N'599 Arlington Avenue', N'1729344')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1290, N'Dina ', N'Olsen', N'932 14th Street', N'6259345')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1291, N'Dominique ', N'Oneill', N'310 Cardinal Drive', N'5580878')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1292, N'Sterling ', N'Oneal', N'450 Buttonwood Drive', N'1572023')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1293, N'Bertie ', N'Oneil', N'963 Myrtle Avenue', N'7695647')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1294, N'Nannie ', N'Oneill', N'480 Route 17', N'3866477')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1295, N'Nikki ', N'Oneal', N'617 Pleasant Street', N'2459903')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1296, N'Kara ', N'Ortega', N'182 Windsor Drive', N'7122712')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1297, N'Sylvia ', N'Ortiz', N'271 Race Street', N'6138336')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1298, N'Chelsea ', N'Osborne', N'709 North Street', N'6810366')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1299, N'Tammi ', N'Osborn', N'500 10th Street', N'7640403')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1300, N'Rodney ', N'Owens', N'139 Chestnut Street', N'5885172')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1301, N'Rosalind ', N'Pacheco', N'543 Primrose Lane', N'3900038')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1302, N'Cornelius ', N'Park', N'705 Penn Street', N'9131132')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1303, N'Enid ', N'Pate', N'993 College Street', N'5481436')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1304, N'Casey ', N'Park', N'898 Cardinal Drive', N'4752185')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1305, N'Nicolas ', N'Padilla', N'448 7th Street', N'3322372')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1306, N'Trevor ', N'Page', N'837 Forest Drive', N'1162882')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1307, N'Megan ', N'Palmer', N'805 Fawn Lane', N'3892951')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1308, N'Hope ', N'Padilla', N'369 Jones Street', N'9642980')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1309, N'Patrica ', N'Patel', N'820 Route 6', N'7572997')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1310, N'Anton ', N'Patel', N'247 Magnolia Drive', N'8623833')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1311, N'Jackie ', N'Parks', N'892 Pine Street', N'7523938')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1312, N'Lucile ', N'Pace', N'244 Willow Drive', N'7814505')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1313, N'Wanda ', N'Patterson', N'125 College Avenue', N'6994900')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1314, N'Patti ', N'Patrick', N'368 Harrison Street', N'8645303')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1315, N'Frances ', N'Parker', N'784 Spruce Street', N'9725731')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1316, N'Quinton ', N'Parrish', N'680 New Street', N'8995855')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1317, N'Carroll ', N'Paul', N'280 Chestnut Street', N'8076253')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1318, N'Margarita ', N'Parks', N'814 Cedar Court', N'6146302')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1319, N'Oscar ', N'Palmer', N'457 Walnut Avenue', N'5916739')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1320, N'Jacquelyn ', N'Patton', N'511 5th Street', N'6366748')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1321, N'Adolph ', N'Pacheco', N'270 Water Street', N'6726979')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1322, N'Percy ', N'Patrick', N'419 Ann Street', N'3357097')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1323, N'Benny ', N'Patton', N'149 Locust Street', N'7077347')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1324, N'Phillip ', N'Patterson', N'346 Route 17', N'5547760')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1325, N'Mable ', N'Paul', N'201 New Street', N'1248292')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1326, N'Leigh ', N'Parsons', N'953 5th Street West', N'2249428')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1327, N'Cecilia ', N'Page', N'309 6th Street', N'6609683')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1328, N'Janine ', N'Parrish', N'442 1st Street', N'8129817')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1329, N'Tommy ', N'Perkins', N'843 Elm Avenue', N'2501030')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1330, N'Carlo ', N'Pennington', N'387 Hamilton Street', N'7102377')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1331, N'Nicole ', N'Peterson', N'405 Harrison Street', N'1783736')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1332, N'Max ', N'Pearson', N'369 Garden Street', N'4064113')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1333, N'Latonya ', N'Petersen', N'453 Cherry Street', N'3475255')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1334, N'Brandon ', N'Peterson', N'119 Bank Street', N'9665731')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1335, N'Geraldine ', N'Perkins', N'762 Madison Court', N'6336008')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1336, N'Gay ', N'Peck', N'698 Orchard Street', N'3876317')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1337, N'Anderson ', N'Petty', N'311 Lincoln Street', N'6536467')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1338, N'Nita ', N'Petty', N'907 Monroe Street', N'2166792')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1339, N'Enrique ', N'Pena', N'959 Route 10', N'9517185')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1340, N'Sue ', N'Peters', N'438 8th Street', N'7037411')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1341, N'Patrick ', N'Perez', N'270 Lake Avenue', N'1707424')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1342, N'Carolyn ', N'Perez', N'701 Cedar Avenue', N'4027907')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1343, N'Victor ', N'Perry', N'395 Route 70', N'2118502')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1344, N'Bart ', N'Petersen', N'603 Jefferson Court', N'4568860')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1345, N'Erika ', N'Pena', N'575 Washington Avenue', N'8739088')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1346, N'Sara ', N'Perry', N'452 Glenwood Avenue', N'9619880')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1347, N'Domingo ', N'Phelps', N'931 3rd Street West', N'4091573')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1348, N'Douglas ', N'Phillips', N'449 Pennsylvania Avenue', N'7212562')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1349, N'Melba ', N'Phelps', N'600 11th Street', N'1427825')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1350, N'Janet ', N'Phillips', N'996 Creek Road', N'6118571')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1351, N'Sally ', N'Pierce', N'298 Clay Street', N'4242025')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1352, N'Deanne ', N'Pickett', N'302 Main Street East', N'5692089')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1353, N'Henrietta ', N'Pittman', N'854 Roberts Road', N'7493773')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1354, N'Floyd ', N'Pierce', N'253 Cemetery Road', N'1964605')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1355, N'Darrel ', N'Pittman', N'819 Lake Street', N'8195521')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1356, N'Alisha ', N'Pitts', N'379 Willow Drive', N'5836547')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1357, N'Dewayne ', N'Pitts', N'221 Harrison Street', N'7778782')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1358, N'Loren ', N'Potter', N'660 Berkshire Drive', N'6790727')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1359, N'Guadalupe ', N'Pope', N'552 Colonial Drive', N'1500919')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1360, N'Della ', N'Potter', N'919 York Street', N'8651495')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1361, N'Jesus ', N'Porter', N'782 Wall Street', N'2852575')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1362, N'Kerry ', N'Poole', N'935 Prospect Street', N'9644132')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1363, N'Elias ', N'Poole', N'415 Mulberry Street', N'8504745')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1364, N'Carrie ', N'Porter', N'709 Route 30', N'8567098')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1365, N'Martin ', N'Powell', N'719 Elizabeth Street', N'7018359')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1366, N'Nichole ', N'Pope', N'191 Walnut Street', N'9048764')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1367, N'Nanette ', N'Potts', N'892 Magnolia Drive', N'7888872')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1368, N'Marguerite ', N'Powers', N'671 Liberty Street', N'4949289')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1369, N'Jeremy ', N'Price', N'966 College Street', N'5830964')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1370, N'Lily ', N'Prince', N'787 Essex Court', N'2631988')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1371, N'Cristina ', N'Pratt', N'798 Division Street', N'7822825')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1372, N'Alvaro ', N'Pruitt', N'349 Wood Street', N'5896859')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1373, N'Irene ', N'Price', N'333 Water Street', N'3547290')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1374, N'Loyd ', N'Preston', N'343 George Street', N'7868798')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1375, N'Ofelia ', N'Pugh', N'598 Oak Lane', N'4611231')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1376, N'Carmelo ', N'Pugh', N'506 Spring Street', N'3534866')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1377, N'Sharlene ', N'Puckett', N'390 Dogwood Lane', N'5375786')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1378, N'Wilbert ', N'Quinn', N'570 Magnolia Avenue', N'2502507')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1379, N'Jody ', N'Quinn', N'702 Route 64', N'2739675')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1380, N'Elma ', N'Randolph', N'663 3rd Avenue', N'3690620')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1381, N'Harry ', N'Ramirez', N'206 Railroad Avenue', N'8131324')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1382, N'Dean ', N'Ray', N'570 Route 7', N'4671733')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1383, N'Shaun ', N'Ramsey', N'250 Durham Court', N'6452809')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1384, N'Christian ', N'Raymond', N'616 Cambridge Road', N'5073237')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1385, N'Eva ', N'Ramos', N'461 Clay Street', N'8404867')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1386, N'Casandra ', N'Ratliff', N'827 Route 6', N'8675032')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1387, N'Riley ', N'Randolph', N'900 Madison Court', N'5206440')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1388, N'Barry ', N'Ramos', N'715 Jefferson Avenue', N'8196527')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1389, N'Demetrius ', N'Randall', N'654 Dogwood Lane', N'1496675')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1390, N'Audrey ', N'Ray', N'607 Bridge Street', N'3317102')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1391, N'Angie ', N'Ramsey', N'419 Park Place', N'4357467')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1392, N'Dorthy ', N'Randall', N'697 State Street', N'3068311')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1393, N'Rowena ', N'Rasmussen', N'226 Franklin Court', N'2718539')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1394, N'Doris ', N'Reed', N'713 Washington Street', N'6060362')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1395, N'Alexander ', N'Reyes', N'274 Canterbury Drive', N'2200717')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1396, N'Candace ', N'Reeves', N'606 Elizabeth Street', N'4592330')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1397, N'Gerardo ', N'Reese', N'746 Pearl Street', N'8313096')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1398, N'Curtis ', N'Reynolds', N'803 Virginia Avenue', N'7724335')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1399, N'Rosa ', N'Reynolds', N'590 Cherry Lane', N'5835534')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1400, N'Debbie ', N'Reyes', N'991 Ridge Road', N'7835796')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1401, N'Jonathan ', N'Reed', N'524 Route 1', N'4468611')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1402, N'Darryl ', N'Reid', N'594 Surrey Lane', N'9588701')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1403, N'Liliana ', N'Reilly', N'590 Church Street North', N'9049178')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1404, N'Sherri ', N'Rhodes', N'971 Canterbury Court', N'8991728')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1405, N'Terrence ', N'Rhodes', N'211 Jackson Avenue', N'7192979')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1406, N'Deidre ', N'Riddle', N'952 Lincoln Street', N'7040125')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1407, N'Katherine ', N'Rivera', N'864 Arch Street', N'9510789')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1408, N'Brittany ', N'Riley', N'545 Creek Road', N'4541212')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1409, N'Marcus ', N'Rice', N'885 Magnolia Drive', N'2452113')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1410, N'Lawrence ', N'Richardson', N'857 Cypress Court', N'1593976')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1411, N'Isabelle ', N'Rich', N'286 Hillcrest Drive', N'7184496')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1412, N'Rodrick ', N'Riddle', N'847 Williams Street', N'4194682')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1413, N'Jamie ', N'Rice', N'329 Wall Street', N'7675391')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1414, N'Nigel ', N'Riggs', N'227 Route 41', N'1405747')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1415, N'Sofia ', N'Richmond', N'988 2nd Street West', N'8596576')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1416, N'Gregg ', N'Rios', N'266 Olive Street', N'2087889')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1417, N'Willie ', N'Rivera', N'973 Meadow Lane', N'2358179')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1418, N'Emory ', N'Rivas', N'786 Cottage Street', N'7048185')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1419, N'Clyde ', N'Riley', N'134 College Street', N'3908332')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1420, N'Dalton ', N'Richmond', N'820 Wall Street', N'7679361')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1421, N'Serena ', N'Roach', N'356 Central Avenue', N'8560252')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1422, N'Pete ', N'Rodgers', N'658 Buckingham Drive', N'4410295')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1423, N'Susanne ', N'Robles', N'305 Pearl Street', N'6240446')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1424, N'Elinor ', N'Rollins', N'997 Sycamore Street', N'2030489')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1425, N'Eugenio ', N'Rowland', N'770 Hilltop Road', N'6401217')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1426, N'Darius ', N'Robles', N'379 Essex Court', N'3391230')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1427, N'Teresa ', N'Rogers', N'876 College Avenue', N'3161308')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1428, N'Christine ', N'Roberts', N'232 Bank Street', N'7571322')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1429, N'Essie ', N'Roberson', N'365 4th Street', N'6122539')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1430, N'Deloris ', N'Roman', N'473 Windsor Court', N'1822729')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1431, N'Leopoldo ', N'Rosa', N'592 Cleveland Street', N'1203030')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1432, N'Randolph ', N'Robbins', N'835 10th Street', N'5833043')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1433, N'Jerry ', N'Rowland', N'602 Colonial Drive', N'5353259')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1434, N'Beatriz ', N'Rojas', N'995 Adams Street', N'2393905')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1435, N'Rocco ', N'Rojas', N'920 Cemetery Road', N'4723925')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1436, N'Sergio ', N'Rodriquez', N'347 Division Street', N'9043940')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1437, N'Marilyn ', N'Ross', N'144 Holly Court', N'6914136')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1438, N'Minnie ', N'Romero', N'665 Durham Road', N'4874200')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1439, N'Kelli ', N'Robbins', N'392 6th Street North', N'6344457')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1440, N'Anthony ', N'Rodriguez', N'304 Lafayette Avenue', N'1335407')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1441, N'Eugene ', N'Ross', N'777 Park Avenue', N'2105956')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1442, N'Brian ', N'Robinson', N'466 Railroad Avenue', N'6676035')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1443, N'Pam ', N'Rodgers', N'268 Lexington Court', N'3726787')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1444, N'Peter ', N'Roberts', N'847 Elizabeth Street', N'5776971')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1445, N'Doyle ', N'Roy', N'934 Surrey Lane', N'8567022')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1446, N'Saul ', N'Roberson', N'987 Holly Drive', N'2147202')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1447, N'Sheri ', N'Rowe', N'724 North Street', N'1787670')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1448, N'Fran ', N'Rosa', N'769 Bank Street', N'3657871')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1449, N'Ronny ', N'Rollins', N'189 Route 11', N'7497928')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1450, N'Raquel ', N'Roy', N'289 Arlington Avenue', N'7868017')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1451, N'Laura ', N'Rodriguez', N'463 Valley Drive', N'5398442')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1452, N'Clinton ', N'Romero', N'752 Madison Avenue', N'3928762')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1453, N'Darlene ', N'Rose', N'974 Pine Street', N'1398768')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1454, N'Jon ', N'Rose', N'340 Park Place', N'2859600')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1455, N'Audra ', N'Rush', N'575 Chapel Street', N'7901547')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1456, N'Ericka ', N'Russo', N'788 Mulberry Lane', N'1532289')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1457, N'Johnny ', N'Russell', N'985 Deerfield Drive', N'4382360')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1458, N'Vivian ', N'Ruiz', N'705 Washington Avenue', N'4875408')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1459, N'Nestor ', N'Rush', N'689 Hickory Lane', N'8396039')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1460, N'Annie ', N'Russell', N'317 Cooper Street', N'7036855')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1461, N'Tara ', N'Ryan', N'320 Old York Road', N'1885193')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1462, N'Sammy ', N'Sandoval', N'173 Chestnut Avenue', N'2380464')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1463, N'Polly ', N'Savage', N'236 Race Street', N'6601000')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1464, N'Kaitlin ', N'Sargent', N'722 8th Street South', N'1382000')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1465, N'Nick ', N'Santiago', N'698 Route 9', N'2592140')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1466, N'Kristine ', N'Salazar', N'977 Queen Street', N'9512197')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1467, N'Francine ', N'Sawyer', N'253 Locust Lane', N'2162373')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1468, N'Leola ', N'Salinas', N'459 Main Street East', N'9402508')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1469, N'Cora ', N'Santiago', N'298 High Street', N'8802648')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1470, N'Alva ', N'Sanford', N'374 5th Street West', N'1322674')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1471, N'Lilia ', N'Sanford', N'386 Water Street', N'1613070')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1472, N'Katy ', N'Sampson', N'230 Pennsylvania Avenue', N'2913698')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1473, N'Julie ', N'Sanchez', N'692 4th Street West', N'9223805')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1474, N'Bryon ', N'Salinas', N'226 Brook Lane', N'9634511')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1475, N'Mona ', N'Saunders', N'807 Division Street', N'2804595')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1476, N'Krystal ', N'Sandoval', N'226 Sycamore Lane', N'2295134')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1477, N'Alejandra ', N'Salas', N'965 Orchard Street', N'7336352')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1478, N'Marty ', N'Saunders', N'413 6th Street West', N'3366373')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1479, N'Tammy ', N'Sanders', N'186 Winding Way', N'2767610')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1480, N'Darcy ', N'Santana', N'129 Andover Court', N'6657793')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1481, N'Louis ', N'Sanders', N'883 Route 44', N'1538259')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1482, N'Abraham ', N'Santos', N'745 Clay Street', N'3308614')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1483, N'Forest ', N'Sampson', N'589 Cambridge Court', N'1958881')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1484, N'Juan ', N'Sanchez', N'468 Country Lane', N'4689616')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1485, N'Rebecca ', N'Scott', N'804 Mulberry Lane', N'5291842')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1486, N'Lynda ', N'Schneider', N'886 Magnolia Avenue', N'6462883')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1487, N'Rosemary ', N'Schmidt', N'452 Garfield Avenue', N'9074102')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1488, N'Donnie ', N'Schultz', N'340 Main Street West', N'2535528')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1489, N'Freda ', N'Schwartz', N'617 Cardinal Drive', N'6136856')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1490, N'Hattie ', N'Schultz', N'131 Orange Street', N'5238183')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1491, N'Maritza ', N'Sexton', N'667 Route 4', N'1501966')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1492, N'Marisol ', N'Serrano', N'532 8th Street West', N'4323129')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1493, N'Manuela ', N'Sellers', N'178 Forest Drive', N'3033847')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1494, N'Jayson ', N'Sellers', N'525 Route 9', N'2625243')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1495, N'Juliana ', N'Sears', N'688 Delaware Avenue', N'6516110')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1496, N'Gonzalo ', N'Serrano', N'643 Virginia Avenue', N'9348587')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1497, N'Tommie ', N'Shepard', N'668 Washington Avenue', N'9080785')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1498, N'Tristan ', N'Shepard', N'195 2nd Street', N'2211511')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1499, N'Lionel ', N'Sherman', N'714 Spring Street', N'3191883')
GO
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1500, N'Lourdes ', N'Shaffer', N'159 Lakeview Drive', N'7441988')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1504, N'Clifton2', N'Shelton', N'326 Academy Street', N'6722981')
INSERT [dbo].[Customer] ([CustID], [FirstName], [LastName], [Address], [Phone]) VALUES (1505, N'Bobbi 2', N'Shannon', N'767 Route 17', N'7225220')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (1, N'Henry IV, Part 1', N'', N'N/A', N'', N'1403:- Henry IV finds himself facing uprisings from the Welsh chieftain Owen Glendower and impetuous young Harry Hotspur,son of the Duke of Northumberland,angry with the king for not paying...        ', 0.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (2, N'Psalm 21', N'Horror, Sci-Fi, Thriller', N'N/A', N'2009', N'Henrik, a much beloved priest, doesn''t believe in hell. Upon receiving the news of his fathers death, he starts a journey that will take him through terrifying secrets, distorted childhood memories, and shake the foundation of his belief.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (3, N'Kill Bill: Vol. 1', N'Action, Crime', N'R', N'2003', N'The Bride wakens from a four-year coma. The child she carried in her womb is gone. Now she must wreak vengeance on the team of assassins who betrayed her - a team she was once part of.                ', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (4, N'Superbabies: Baby Geniuses 2', N'Comedy, Family', N'PG', N'2004', N'A group of smart-talking toddlers find themselves at the center of a media mogul''s experiment to crack the code to baby talk. The toddlers must race against time for the sake of babies everywhere.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (5, N'Harry Potter and the Deathly Hallows: Part 2', N'Adventure, Fantasy, Mystery', N'8', N'2011', N'Harry, Ron and Hermione search for Voldemort''s remaining Horcruxes in their effort to destroy the Dark Lord as the final battle rages on at Hogwarts.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (6, N'FX/2', NULL, N'8', N'1991', NULL, 2.0000, N'2')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (7, N'8½', N'Drama, Fantasy', N'Not Rated', N'1963', N'A harried movie director retreats into his memories and fantasies.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (8, N'Troll 2', N'Fantasy, Horror, Mystery', N'PG-13', N'1990', N'A family vacationing in a small town discovers the entire town is inhabited by goblins in disguise as humans, who plan to eat them.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (9, N'Monsters, Inc.', N'Animation, Adventure, Comedy', N'G', N'2001', N'Monsters generate their city''s power by scaring children, but they are terribly afraid themselves of being contaminated by children, so when one enters Monstropolis, top scarer Sulley finds his world disrupted.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (10, N'Snatch.', N'Comedy, Crime', N'R', N'2000', N'Unscrupulous boxing promoters, violent bookmakers, a Russian gangster, incompetent amateur robbers, and supposedly Jewish jewelers fight to track down a priceless stolen diamond.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (11, N'Toy Story 3', N'Animation, Adventure, Comedy', N'G', N'2010', N'The toys are mistakenly delivered to a day-care center instead of the attic right before Andy leaves for college, and it''s up to Woody to convince the other toys that they weren''t abandoned and to return home.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (12, N'Who''s Afraid of Virginia Woolf?', N'Drama', N'Not Rated', N'1966', N'A bitter aging couple with the help of alcohol, use a young couple to fuel anguish and emotional pain towards each other.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (13, N'The Incredibly Strange Creatures Who Stopped Living and Became Mixed-Up Zombies!!?', N'Horror, Music, Musical', N'Not Rated', N'1964', N'Jerry falls in love with a stripper he meets at a carnival. Little does he know that she is the sister of a gypsy fortune teller whose predictions he had scoffed at earlier. The gypsy turns him into a zombie and he goes on a killing spree.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (14, N'8½', N'Drama, Fantasy', N'Not Rated', N'1963', N'A harried movie director retreats into his memories and fantasies.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (15, N'Who''s Your Caddy?', N'Comedy, Sport', N'PG-13', N'2007', N'When a rap mogul from Atlanta tries to join a conservative country club in the Carolinas he runs into fierce opposition from the board President- but it''s nothing that he and his entourage can''t handle.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (16, N'24', N'Action, Drama, Mystery', N'TV-14', N'2001–2010', N'Jack Bauer, Director of Field Ops for the Counter-Terrorist Unit of Los Angeles, races against the clock to subvert terrorist plots and save his nation from ultimate disaster.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (17, N'The Mad Adventures of ''Rabbi'' Jacob', N'Comedy', N'G', N'1973', N'A bigoted Frenchman finds himself forced to impersonate a popular rabbi while on the run from a group of assassins - and the police.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (18, N'Titanic: The Legend Goes On...', N'Animation, Family', N'N/A', N'2000', N'A Cinderella meets her Prince Charming on the ill-fated Titanic. Along for the ride are a rapping dog, other talking animals, and an assortment of wacky humans.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (19, N'Car 54, Where Are You?', N'Comedy', N'PG-13', N'1994', N'Brash NYC policeman Officer Gunther Toody is partnered with stiff, by-the-book Officer Francis Muldoon to protect an important mafia witness prior to testifying against orgainzed crime in ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (20, N'Leonard Part 6', N'Action, Comedy', N'PG', N'1987', N'A secret agent is called out of retirement to save the world from an evil genius.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (21, N'Stalag 17', N'Comedy, Drama, War', N'Not Rated', N'1953', N'When two escaping American World War II prisoners are killed, the German POW camp barracks black marketeer, J.J. Sefton, is suspected of being an informer.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (22, N'O Brother, Where Art Thou?', N'Comedy, Crime', N'PG-13', N'2000', N'In the deep south during the 1930s, three escaped convicts search for hidden treasure while a relentless lawman pursues them.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (23, N'District 9', N'Action, Sci-Fi, Thriller', N'R', N'2009', N'An extraterrestrial race forced to live in slum-like conditions on Earth suddenly finds a kindred spirit in a government agent who is exposed to their biotechnology.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (24, N'Once Upon a Time in America', N'Crime, Drama', N'R', N'1984', N'A former Prohibition-era Jewish gangster returns to the Lower East Side of Manhattan over thirty years later, where he once again must confront the ghosts and regrets of his old life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (25, N'Who''s Afraid of Virginia Woolf?', N'Drama', N'Not Rated', N'1966', N'A bitter aging couple with the help of alcohol, use a young couple to fuel anguish and emotional pain towards each other.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (26, N'Anna Karenina', N'Drama', N'R', N'2012', N'In late-19th-century Russian high society, St. Petersburg aristocrat Anna Karenina enters into a life-changing affair with the dashing Count Alexei Vronsky.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (27, N'Hotel Rwanda', N'Biography, Drama, History', N'PG-13', N'2004', N'The true story of Paul Rusesabagina, a hotel manager who housed over a thousand Tutsi refugees during their struggle against the Hutu militia in Rwanda.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (28, N'Lawrence of Arabia', N'Adventure, Biography, Drama', N'PG', N'1962', N'A flamboyant and controversial British military figure and his conflicted loyalties during his World War I service in the Middle East.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (29, N'Rebecca', N'Drama, Mystery, Thriller', N'Not Rated', N'1940', N'A self-conscious bride is tormented by the memory of her husband''s dead first wife.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (30, N'Magnolia', N'Drama', N'R', N'1999', N'An epic mosaic of interrelated characters in search of love, forgiveness, and meaning in the San Fernando Valley.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (31, N'La Strada', N'Drama', N'Not Rated', N'1954', N'A care-free girl is sold to a traveling entertainer, consequently enduring physical and emotional pain along the way.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (32, N'Austin Powers: The Spy Who Sha', NULL, N'4', N'1954', NULL, 2.0000, N'2')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (33, N'Persona', N'Drama', N'Not Rated', N'1966', N'A nurse is put in charge of an actress who can''t talk and finds that the actress''s persona is melding with hers.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (34, N'Adam', N'Drama, Romance', N'PG-13', N'2009', N'Adam, a lonely man with Asperger''s Syndrome, develops a relationship with his upstairs neighbor, Beth.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (35, N'Jalla! Jalla!', N'Comedy, Drama, Romance', N'N/A', N'2000', N'Roro, a foreign worker in Swedish parks, loves his girlfriend but is about to marry another girl to prevent her from being sent back to Lebanon. Roros best friend, Måns, has his own ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (36, N'Die Hard Dracula', N'Comedy, Horror', N'N/A', N'1998', N'A modern-day updating of the Dracula legend that finds Steven, a good-looking American hero devastated by the death of his girlfriend, wandering through Europe and looking for happiness. A ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (37, N'Casablanca', N'Drama, Romance, War', N'PG', N'1942', N'Set in unoccupied Africa during the early days of World War II: An American expatriate meets a former lover, with unforeseen complications.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (38, N'V for Vendetta', N'Action, Sci-Fi, Thriller', N'R', N'2005', N'In a future British tyranny, a shadowy freedom fighter plots to overthrow it with the help of a young woman.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (39, N'A Fish Called Wanda', N'Comedy, Crime', N'R', N'1988', N'In London, four very different people team up to commit armed robbery, then try to doublecross each other for the loot.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (40, N'Kung Fu Panda', N'Animation, Action, Adventure', N'PG', N'2008', N'In the Valley of Peace, Po the Panda finds himself chosen as the Dragon Warrior despite the fact that he is obese and a complete novice at martial arts.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (41, N'Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb', N'Comedy, War', N'PG', N'1964', N'An insane general triggers a path to nuclear holocaust that a war room full of politicians and generals frantically try to stop.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (42, N'Body in the Web', N'Horror', N'Unrated', N'1960', N'Survivors of a plane crash on a remote island find it is covered by spiders. When bitten, the survivors start turning into spiders!', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (43, N'Fight Club', N'Drama', N'R', N'1999', N'An insomniac office worker looking for a way to change his life crosses paths with a devil-may-care soap maker and they form an underground fight club that evolves into something much, much more...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (44, N'The Breakfast Club', N'Comedy, Drama', N'R', N'1985', N'Five high school students, all different stereotypes, meet in detention, where they pour their hearts out to each other, and discover how they have a lot more in common than they thought.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (45, N'The Italian Job', N'Action, Crime, Thriller', N'PG-13', N'2003', N'After being betrayed and left for dead in Italy, Charlie Croker and his team plan an elaborate gold heist against their former ally.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (46, N'Alan Davies: Live at the Lyric', N'Comedy', N'N/A', N'1994', N'N/A', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (47, N'Cyrano de Bergerac', N'Biography, Comedy, Drama', N'PG', N'1990', N'Embarrassed by his large nose, a romantic poet/soldier romances his cousin by proxy.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (48, N'Human Traffic', N'Comedy, Music', N'R', N'1999', N'Five friends spend one lost weekend in a mix of music, love and club culture.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (49, N'Going Overboard', N'Comedy', N'R', N'1989', N'A struggling young comedian takes a menial job on a cruise ship where he hopes for his big chance to make it in the world of cruise ship comedy.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (50, N'The Kid', N'Comedy, Drama, Family', N'Not Rated', N'1921', N'The Tramp cares for an abandoned child, but events put that relationship in jeopardy.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (51, N'Enchanted', N'Comedy, Family, Fantasy', N'PG', N'2007', N'A classic Disney fairytale collides with modern-day New York City in a story about a fairytale princess who is sent to our world by an evil queen. Soon after her arrival, Princess Giselle begins to change her views on life and love after meeting a handsome lawyer. Can a storybook view of romance survive in the real world?', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (52, N'Gone with the Wind', N'Drama, Romance, War', N'TV-PG', N'1939', N'A manipulative Southern belle carries on a turbulent affair with a blockade runner during the American Civil War.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (53, N'Eternal Sunshine of the Spotless Mind', N'Drama, Romance, Sci-Fi', N'R', N'2004', N'A couple undergo a procedure to erase each other from their memories when their relationship turns sour, but it is only through the process of loss that they discover what they had to begin with.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (54, N'Sunset Blvd.', N'Drama, Film-Noir', N'Not Rated', N'1950', N'A hack screenwriter writes a screenplay for a former silent-film star who has faded into Hollywood obscurity.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (55, N'The Departed', N'Crime, Drama, Thriller', N'R', N'2006', N'An undercover state cop who has infiltrated an Irish gang and a mole in the police force working for the same mob race to track down and identify each other before being exposed to the enemy, after both sides realize their outfit has a rat.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (56, N'Chairman of the Board', N'Comedy', N'PG-13', N'1998', N'A surfer becomes the head of a major company.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (57, N'Into the Wild', N'Adventure, Biography, Drama', N'R', N'2007', N'After graduating from Emory University, top student and athlete Christopher McCandless abandons his possessions, gives his entire $24,000 savings account to charity and hitchhikes to Alaska to live in the wilderness. Along the way, Christopher encounters a series of characters that shape his life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (58, N'A Beautiful Mind', N'Biography, Drama', N'PG-13', N'2001', N'After a brilliant but asocial mathematician accepts secret work in cryptography, his life takes a turn for the nightmarish.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (59, N'City of God', N'Crime, Drama', N'R', N'2002', N'Two boys growing up in a violent neighborhood of Rio de Janeiro take different paths: one becomes a photographer, the other a drug dealer.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (60, N'Die Hard', N'Action, Thriller', N'R', N'1988', N'John McClane, officer of the NYPD, tries to save wife Holly Gennaro and several others, taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (61, N'Oh, God!', N'Comedy, Fantasy', N'PG', N'1977', N'When God appears to an assistant grocery manager as a good natured old man, the Almighty selects him as his messenger for the modern world.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (62, N'House of the Dead', N'Action, Horror, Thriller', N'R', N'2003', N'A group of teens arrive on an island for a rave--only to discover the island has been taken over by zombies. The group takes refuge in a house where they try to survive the night.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (63, N'Book of Blood', N'Drama, Horror, Mystery', N'R', N'2009', N'A paranormal expert discovers a house that is at the intersection of so-called "highways" transporting souls in the afterlife.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (64, N'Shutter Island', N'Drama, Mystery, Thriller', N'R', N'2010', N'In 1954, U.S. Marshal Teddy Daniels is investigating the disappearance of a murderess who escaped from a hospital for the criminally insane and is presumed to be hiding nearby.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (65, N'Ed', N'Comedy, Family, Sport', N'PG', N'1996', N'A trained chimpanzee plays third base for a minor-league baseball team.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (66, N'Another World', N'Drama', N'TV-14', N'1964–1999', N'The continuing story of life in the Midwestern town of Bay City, and the love, loss, trials, and triumph of its residents, who come from different backgrounds and social circles. Those who ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (67, N'Butch Cassidy and the Sundance Kid', N'Adventure, Biography, Crime', N'N/A', N'1969', N'Two Western bank/train robbers flee to Bolivia when the law gets too close.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (68, N'There Will Be Blood', N'Drama', N'R', N'2007', N'A story of family, religion, hatred, oil and madness, focusing on a turn-of-the-century prospector in the early days of the business.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (69, N'Close Encounters of the Third Kind', N'Adventure, Drama, Sci-Fi', N'PG', N'1977', N'After an encounter with UFOs, a line worker feels undeniably drawn to an isolated area in the wilderness where something spectacular is about to happen.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (70, N'Kidz in da Hood', N'Comedy, Drama, Family', N'N/A', N'2006', N'Kidz in da Hood is the gripping and warm story of Amina, who came to Sweden with her grandfather three years ago. Amina has not yet received her residency permit and when her grandfather ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (71, N'Nausicaä of the Valley of the Wind', NULL, N'PG', N'1984', NULL, 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (72, N'Django Unchained', N'Adventure, Drama, Western', N'R', N'2012', N'With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal Mississippi plantation owner.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (73, N'Demon Island', N'Horror, Thriller', N'R', N'2002', N'Teens trapped on an island are haunted by a demon hidden inside...a pinata.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (74, N'To Kill a Mockingbird', N'Crime, Drama, Mystery', N'Not Rated', N'1962', N'Atticus Finch, a lawyer in the Depression-era South, defends a black man against an undeserved rape charge, and his kids against prejudice.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (75, N'Speed', N'Action, Thriller', N'R', N'1994', N'A young cop must prevent a bomb exploding aboard a city bus by keeping its speed above 50 mph.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (76, N'Barney''s Great Adventure', N'Adventure, Family', N'G', N'1998', N'Mom and dad dump son Cody, daughter Abby, her best friend Marcella and a baby on the farm with Grandpa and Grandma. Purple dinosaur Barney soon appears to entertain kids, and when a large ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (77, N'Emmerdale Live', NULL, NULL, NULL, NULL, NULL, N'2')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (78, N'Turks in Space', N'Action, Comedy, Sci-Fi', N'N/A', N'2006', N'It is intended to be a comedy film with serious special effects, though it becomes an epic film of laughs as the suppressor of the first series of the film ''The man who saves Earth''...See full synopsis&nbsp;&raquo;', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (79, N'Toby McTeague', N'Action, Drama', N'PG', N'1986', N'Toby is a teenager who doesn''t care much about school. In fact, he has his eyes on the title of a prestigious dog-sleigh race. He will have to undergo extensive training in order to win it.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (80, N'The Green Mile', N'Crime, Drama, Fantasy', N'R', N'1999', N'The lives of guards on Death Row are affected by one of their charges: a black man accused of child murder and rape, yet who has a mysterious gift.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (81, N'Danes Without a Clue', N'Comedy', N'N/A', N'1997', N'Two comedians set out to make their own exploitation video.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (82, N'All About Eve', N'Drama', N'TV-PG', N'1950', N'An ingenue insinuates herself in to the company of an established but aging stage actress and her circle of theater friends.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (83, N'Miracle', N'Drama, Family, History', N'PG', N'2004', N'Miracle tells the true story of Herb Brooks (Russell), the player-turned-coach who led the 1980 U.S. Olympic hockey team to victory over the seemingly invincible Russian squad.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (84, N'The Man Who Shot Liberty Valance', N'Western', N'Approved', N'1962', N'A senator, who became famous for killing a notorious outlaw, returns for the funeral of an old friend and tells the truth about his deed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (85, N'Jerry Maguire', N'Comedy, Drama, Romance', N'R', N'1996', N'When a sports agent has a moral epiphany and is fired for expressing it, he decides to put his new philosophy to the test as an independent with the only athlete who stays with him.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (86, N'Jean de Florette', N'Drama', N'PG', N'1986', N'A greedy landowner and his backward nephew conspire to block the only water source for an adjoining property in order to bankrupt the owner and force him to sell.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (87, N'Amélie', NULL, N'R', N'2001', NULL, 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (88, N'My Bloody Valentine', N'Horror, Thriller', N'R', N'2009', N'Tom returns to his hometown on the tenth anniversary of the Valentine''s night massacre that claimed the lives of 22 people. Instead of a homecoming, however, Tom finds himself suspected of committing the murders, and it seems like his old flame is the only one will believes he''s innocent.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (89, N'Citizen Kane', N'Drama, Mystery', N'Approved', N'1941', N'Following the death of a publishing tycoon, news reporters scramble to discover the meaning of his final utterance.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (90, N'Harry Potter and the Goblet of Fire', N'Adventure, Family, Fantasy', N'PG-13', N'2005', N'Harry finds himself mysteriously selected as an under-aged competitor in a dangerous tournament between three schools of magic.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (91, N'La Haine', N'Drama', N'Not Rated', N'1995', N'After local youth Abdel is beaten unconscious by police, a riot ensues on his estate during which a policeman loses his gun. The gun is found by Vinz who threatens he will kill a cop if Abdel dies.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (92, N'The Final Sacrifice', N'Adventure, Fantasy, Horror', N'PG-13', N'1990', N'Fleeing from the cult that murdered his father, a teen is aided in his quest to find the lost city of the fabled Ziox by a secretive drifter.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (93, N'WALL·E', NULL, N'G', N'2008', NULL, 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (94, N'Ratatouille', N'Animation, Comedy, Family', N'G', N'2007', N'A rat, who can also cook, makes an unusual alliance with a young kitchen worker at a famous restaurant.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (95, N'Shakespeare in Love', N'Comedy, Drama, Romance', N'R', N'1998', N'A young Shakespeare, out of ideas and short of cash, meets his ideal woman and is inspired to write one of his most famous plays.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (96, N'Casino Royale', N'Action, Crime, Thriller', N'PG-13', N'2006', N'Armed with a license to kill, Secret Agent James Bond sets out on his first mission as 007 and must defeat a weapons dealer in a high stakes game of poker at Casino Royale, but things are not what they seem.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (97, N'Strange Love', N'Drama, Fantasy, Mystery', N'TV-MA', N'2008', N'In a society where humans and vampires co-exist, set in the small town of Bon Temps, Louisiana, Sookie Stackhouse is a young woman who may have found a perfect boyfriend. Sookie is ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (98, N'The Manchurian Candidate', N'Drama, Mystery, Sci-Fi', N'R', N'2004', N'In the midst of the Gulf War, soldiers are kidnapped and brainwashed for sinister purposes.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (99, N'A Streetcar Named Desire', N'Drama', N'PG', N'1951', N'Disturbed Blanche DuBois moves in with her sister in New Orleans and is tormented by her brutish brother-in-law while her reality crumbles around her.', 2.0000, N'')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (100, N'For a Few Dollars More', N'Western', N'Approved', N'1965', N'Two bounty hunters with the same intentions, team up to track down a Western outlaw.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (101, N'Feel the Noise', N'Drama, Music', N'PG-13', N'2007', N'A young man from the South Bronx dreams of making it as a rapper, until a run-in with local thugs forces him to hide in Puerto Rico with the father he never knew.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (102, N'Zombie Nightmare', N'Horror', N'R', N'1987', N'Tony Washington is killed by a gang of rampant trendy teenagers. Molly Mokembe is a voodoo lady who brings him back from the dead to seek revenge on his killers so he can rest in peace.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (103, N'Epic Movie', N'Adventure, Comedy', N'PG-13', N'2007', N'A comedic satire of films that are large in scope, reputation and popularity', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (104, N'You''ll Be the Death of Me', N'Drama, Fantasy, Mystery', N'TV-MA', N'2008', N'With Jason in jail for Amy''s murder, he tries to prove his innocence, while Sookie thinks that the killer is someone that they are close with. Meanwhile, Maryann bails Tara out of jail and ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (105, N'Scarface', N'Crime, Drama', N'R', N'1983', N'In 1980 Miami, a determined Cuban immigrant takes over a drug cartel while succumbing to greed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (106, N'Keloglan vs. the Black Prince', N'Comedy', N'N/A', N'2006', N'N/A', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (107, N'Manos: The Hands of Fate', N'Horror', N'Not Rated', N'1966', N'A family gets lost on the road and stumbles upon a hidden, underground, devil-worshiping cult led by the fearsome Master and his servant Torgo.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (108, N'Office Space', N'Comedy', N'R', N'1999', N'Comedic tale of company workers who hate their jobs and decide to rebel against their greedy boss.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (109, N'Back to the Future', N'Adventure, Comedy, Sci-Fi', N'PG', N'1985', N'A teenager is accidentally sent 30 years into the past in a time-traveling DeLorean invented by his friend, Dr. Emmett Brown, and must make sure his high-school-age parents unite in order to save his own existence.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (110, N'Beetlejuice', N'Comedy, Fantasy', N'PG', N'1988', N'A couple of recently deceased ghosts contract the services of a "bio-exorcist" in order to remove the obnoxious new owners of their house.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (111, N'The Thin Red Line', N'Drama, War', N'R', N'1998', N'Terrence Malick''s adaptation of James Jones'' autobiographical 1962 novel, focusing on the conflict at Guadalcanal during the second World War.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (112, N'Army of Crime', N'Drama, History, War', N'N/A', N'2009', N'The poet Missak Manouchian leads a mixed bag of youngsters and immigrants in a clandestine battle against the Nazi occupation. Twenty-two men and one woman fighting for an ideal and for ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (113, N'The Great Escape', N'Adventure, Drama, History', N'Unrated', N'1963', N'Allied P.O.W.s plan for several hundred of their number to escape from a German camp during World War II.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (114, N'The Prestige', N'Drama, Mystery, Thriller', N'PG-13', N'2006', N'The rivalry between two magicians becomes more exacerbated by their attempt to perform the ultimate illusion.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (115, N'Slumdog Millionaire', N'Drama, Romance, Thriller', N'R', N'2008', N'A Mumbai teen who grew up in the slums, becomes a contestant on the Indian version of "Who Wants To Be A Millionaire?" He is arrested under suspicion of cheating, and while being interrogated, events from his life history are shown which explain why he knows the answers.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (116, N'The Da Vinci Code', N'Mystery, Thriller', N'PG-13', N'2006', N'A murder inside the Louvre and clues in Da Vinci paintings lead to the discovery of a religious mystery protected by a secret society for two thousand years -- which could shake the foundations of Christianity.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (117, N'Howl''s Moving Castle', N'Animation, Adventure, Family', N'PG', N'2004', N'When an unconfident young woman is cursed with an old body by a spiteful witch, her only chance of breaking the spell lies with a self-indulgent yet insecure young wizard and his companions in his legged, walking home.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (118, N'The Maize: The Movie', N'Horror', N'R', N'2004', N'A father''s psychic abilities are put to the test when his two daughters are trapped inside of a corn maze haunted by the spirits of two young girls who disappeared a year earlier.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (119, N'Ice Age', N'Animation, Adventure, Comedy', N'PG', N'2002', N'Set during the Ice Age, a sabertooth tiger, a sloth, and a wooly mammoth find a lost human infant, and they try to return him to his tribe.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (120, N'The Sixth Sense', N'Drama, Mystery, Thriller', N'PG-13', N'1999', N'A boy who communicates with spirits that don''t know they''re dead seeks the help of a disheartened child psychologist.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (121, N'The Graduate', N'Comedy, Drama, Romance', N'Approved', N'1967', N'Recent college graduate Benjamin Braddock is trapped into an affair with Mrs. Robinson, who happens to be the wife of his father''s business partner and then finds himself falling in love with her daughter, Elaine.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (122, N'The Princess Bride', N'Adventure, Comedy, Family', N'PG', N'1987', N'A classic fairy tale, with swordplay, giants, an evil prince, a beautiful princess, and yes, some kissing (as read by a kindly grandfather).', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (123, N'Prince of Space', N'Action, Sci-Fi', N'N/A', N'1959', N'When an alien force tries to invade Earth to steal a powerful new rocket fuel, a mysterious hero intervenes.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (124, N'Mission: Impossible', N'Action, Adventure, Thriller', N'PG-13', N'1996', N'An American agent, under false suspicion of disloyalty, must discover and expose the real spy without the help of his organization.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (125, N'It''s a Wonderful Life', N'Drama, Family, Fantasy', N'Approved', N'1946', N'An angel helps a compassionate but despairingly frustrated businessman by showing what life would have been like if he never existed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (126, N'The Treasure of the Sierra Madre', N'Action, Adventure, Drama', N'TV-PG', N'1948', N'Fred Dobbs and Bob Curtin, two Americans searching for work in Mexico, convince an old prospector to help them mine for gold in the Sierra Madre Mountains.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (127, N'The Pod People', N'Sci-Fi', N'N/A', N'1983', N'A young boy in the woods discovers a lovable alien...or is it?', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (128, N'Rope', N'Crime, Drama, Thriller', N'PG', N'1948', N'Two young men strangle their "inferior" classmate, hide his body in their apartment, and invite his friends and family to a dinner party as a means to challenge the "perfection" of their crime.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (129, N'Being There', N'Comedy', N'PG', N'1979', N'Chance, a simple gardener, has never left the estate until his employer dies. His simple TV-informed utterances are mistaken for profundity.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (130, N'Total Eclipse', N'Biography, Drama, Romance', N'R', N'1995', N'Young, wild poet Arthur Rimbaud and his mentor Paul Verlaine engage in a fierce, forbidden romance while feeling the effects of a hellish artistic lifestyle.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (131, N'Disaster Movie', N'Comedy', N'PG-13', N'2008', N'Over the course of one evening, an unsuspecting group of twenty-somethings find themselves bombarded by a series of natural disasters and catastrophic events.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (132, N'A Story About Love', N'Romance', N'N/A', N'1995', N'Two young people stand on a street corner in a run-down part of New York, kissing. Despite the lawlessness of the district they are left unmolested. A short distance away walk Maria and ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (133, N'Under the Greenwood Tree', N'Drama, Romance', N'N/A', N'2005', N'In this lighthearted romance from Victorian novelist Thomas Hardy, the beautiful new village school teacher is pursued by three suitors: a working-class man, a landowner, and the vicar.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (134, N'Hilde', N'Biography, Drama, Music', N'N/A', N'2009', N'A biography of Hildegard Knef, one of Germany''s biggest post-war stars.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (135, N'A Clockwork Orange', N'Crime, Drama, Sci-Fi', N'X', N'1971', N'In future Britain, charismatic delinquent Alex DeLarge is jailed and volunteers for an experimental aversion therapy developed by the government in an effort to solve society''s crime problem - but not all goes according to plan.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (136, N'A History of Violence', N'Crime, Drama, Thriller', N'R', N'2005', N'A mild-mannered man becomes a local hero through an act of violence, which sets off repercussions that will shake his family to its very core.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (137, N'GoldenEye', N'Action, Crime, Thriller', N'PG-13', N'1995', N'James Bond teams up with the lone survivor of a destroyed Russian research center to stop the hijacking of a nuclear space weapon by a fellow agent believed to be dead.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (138, N'Night Train to Mundo Fine', N'Action, Thriller', N'N/A', N'1966', N'Gritty neo-noir art film about escaped convict Griffin and his friends, who ran all the way to hell... with a penny, and a broken cigarette.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (139, N'Princess Mononoke', N'Animation, Adventure, Fantasy', N'PG-13', N'1997', N'On a journey to find the cure for a Tatarigami''s curse, Ashitaka finds himself in the middle of a war between the forest gods and Tatara, a mining colony. In this quest he also meets San, the Mononoke Hime.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (140, N'Drive', N'Crime, Drama', N'R', N'2011', N'A mysterious Hollywood stuntman, mechanic and getaway driver lands himself in trouble when he helps out his neighbor.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (141, N'Cool as Ice', N'Comedy, Music, Romance', N'PG', N'1991', N'A rap-oriented remake of "The Wild One", with heavy emphasis on the fact that rap star Vanilla Ice has assumed the Marlon Brando role.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (142, N'Indiana Jones and the Last Crusade', N'Action, Adventure', N'PG-13', N'1989', N'When Dr. Henry Jones Sr. suddenly goes missing while pursuing the Holy Grail, eminent archaeologist Indiana Jones must follow in his father''s footsteps and stop the Nazis.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (143, N'Marley', N'Documentary, Biography, Music', N'PG-13', N'2012', N'A documentary on the life, music, and legacy of Bob Marley.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (144, N'Lawnmower Man 2: Beyond Cyberspace', N'Action, Sci-Fi, Thriller', N'PG-13', N'1996', N'Jobe is resuscitated by Jonathan Walker. He wants Jobe to create a special computer chip that would connect all the computers in the world into one network, which Walker would control and ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (145, N'Stand by Me', N'Adventure, Drama', N'R', N'1986', N'After the death of a friend, a writer recounts a boyhood journey to find the body of a missing boy.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (146, N'Cool Hand Luke', N'Crime, Drama', N'PG', N'1967', N'A man refuses to conform to life in a rural prison.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (147, N'The Hottie', N'Comedy, Family', N'N/A', N'2004', N'N/A', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (148, N'The Game', N'Drama, Mystery, Thriller', N'R', N'1997', N'Wealthy San Francisco financier Nicholas Van Orton gets a strange birthday present from wayward brother Conrad: a live-action game that consumes his life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (149, N'The Spy Who Loved Me', N'Action, Adventure, Crime', N'PG', N'1977', N'James Bond investigates the hijacking of British and Russian submarines carrying nuclear warheads with the help of a KGB agent whose lover he killed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (150, N'In the Mood for Love', N'Drama, Romance', N'PG', N'2000', N'A man and a woman move in to neighboring Hong Kong apartments and form a bond when they both suspect their spouses of extramarital activities.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (151, N'Enemy Mine', N'Action, Adventure, Drama', N'PG-13', N'1985', N'A soldier from Earth crash-lands on an alien world after sustaining battle damage. Eventually he encounters another survivor, but from the enemy species he was fighting; they band together ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (152, N'Prince of Persia: The Sands of Time', N'Action, Adventure, Fantasy', N'PG-13', N'2010', N'A young fugitive prince and princess must stop a villain who unknowingly threatens to destroy the world with a special dagger that enables the magic sand inside to reverse time.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (153, N'Ferris Bueller''s Day Off', N'Comedy, Drama', N'PG-13', N'1986', N'A high school wise guy is determined to have a day off from school, despite of what the principal thinks of that.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (154, N'The Right Stuff', N'Adventure, Drama, History', N'R', N'1983', N'The story of the original Mercury 7 astronauts and their macho, seat-of-the-pants approach to the space program.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (155, N'The Vanishing', N'Mystery, Thriller', N'Unrated', N'1988', N'Rex and Saskia, a young couple in love, are on vacation. They stop at a busy service station and Saskia is abducted. After three years and no sign of Saskia, Rex begins receiving letters from the abductor.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (156, N'The Hillz', N'Crime, Drama', N'R', N'2004', N'A promising college athlete takes a turn for the worse when he hooks up with old highschool friends during his summer break.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (157, N'The Lion King', N'Animation, Adventure, Drama', N'G', N'1994', N'Lion cub and future king Simba searches for his identity. His eagerness to please others and penchant for testing his boundaries sometimes gets him into trouble.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (158, N'The Killing', N'Crime, Film-Noir, Thriller', N'Approved', N'1956', N'Crooks plan and execute a daring race-track robbery.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (159, N'Trainspotting', N'Crime, Drama', N'R', N'1996', N'Renton, deeply immersed in the Edinburgh drug scene, tries to clean up and get out, despite the allure of the drugs and influence of friends.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (160, N'Good Will Hunting', N'Drama', N'R', N'1997', N'Will Hunting, a janitor at MIT, has a gift for mathematics but needs help from a psychologist to find direction in his life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (161, N'Spring, Summer, Fall, Winter... and Spring', N'Drama', N'R', N'2003', N'On an isolated lake, an old monk lives on a small floating temple. The wise master has also a young boy with him who learns to become a monk. And we watch as seasons and years pass by.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (162, N'The Sting', N'Comedy, Crime, Drama', N'PG', N'1973', N'In 1930s Chicago, a young con man seeking revenge for his murdered partner teams up with a master of the big con to win a fortune from a criminal banker.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (163, N'The Lord of the Rings: The Return of the King', N'Action, Adventure, Fantasy', N'PG-13', N'2003', N'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (164, N'The Thing', N'Horror, Mystery, Sci-Fi', N'R', N'1982', N'Scientists in the Antarctic are confronted by a shape-shifting alien that assumes the appearance of the people that it kills.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (165, N'Loving', N'Comedy, Drama', N'R', N'1970', N'Brooks Wilson is in crisis. He is torn between his wife Selma and two daughters and his mistress Grace, and also between his career as a successful illustrator and his feeling that he might...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (166, N'The Shining', N'Horror', N'R', N'1980', N'A family heads to an isolated hotel for the winter where an evil and spiritual presence influences the father into violence, while his psychic son sees horrific forebodings from the past and of the future.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (167, N'The Lord of the Rings: The Fellowship of the Ring', N'Action, Adventure, Fantasy', N'PG-13', N'2001', N'A meek hobbit of The Shire and eight companions set out on a journey to Mount Doom to destroy the One Ring and the dark lord Sauron.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (168, N'Friday the 13th', N'Horror', N'X', N'1980', N'Camp counselors are stalked and murdered by an unknown assailant while trying to reopen a summer camp that was the site of a child''s drowning.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (169, N'Munich', N'Drama, History, Thriller', N'R', N'2005', N'Based on the true story of the Black September aftermath, about the five men chosen to eliminate the ones responsible for that fateful day.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (170, N'Interview with the Vampire: Th', NULL, NULL, NULL, NULL, NULL, N'2')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (171, N'Phone Booth', N'Mystery, Thriller', N'R', N'2002', N'Stuart Shepard finds himself trapped in a phone booth, pinned down by an extortionist''s sniper rifle.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (172, N'Sleuth', N'Mystery, Thriller', N'PG', N'1972', N'A man who loves games and theater invites his wife''s lover to meet him, setting up a battle of wits with potentially deadly results.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (173, N'Pan''s Labyrinth', N'Drama, Fantasy, War', N'R', N'2006', N'In the fascist Spain of 1944, the bookish young stepdaughter of a sadistic army officer escapes into an eerie but captivating fantasy world.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (174, N'The Gold Rush', N'Adventure, Comedy, Family', N'Not Rated', N'1925', N'The Tramp goes to the Klondike in search of gold and finds it and more.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (175, N'Wreck-It Ralph', N'Animation, Adventure, Comedy', N'PG', N'2012', N'A video game villain wants to be a hero and sets out to fulfill his dream, but his quest brings havoc to the whole arcade where he lives.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (176, N'The Horror of Party Beach', N'Horror, Musical', N'Approved', N'1964', N'Sea creatures created from radioactive sludge terrorize a beach community.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (177, N'Big Fish', N'Adventure, Drama, Fantasy', N'PG-13', N'2003', N'A son tries to learn more about his dying father by reliving stories and myths he told about his life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (178, N'Macbeth', N'Drama, History, War', N'R', N'1971', N'A ruthlessly ambitious Scottish lord siezes the throne with the help of his scheming wife and a trio of witches.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (179, N'Crash', N'Drama', N'R', N'2004', N'Los Angeles citizens with vastly separate lives collide in interweaving stories of race, loss and redemption.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (180, N'Battlefield Earth', N'Action, Sci-Fi', N'PG-13', N'2000', N'After enslavement & near extermination by an alien race in the year 3000, humanity begins to fight back.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (181, N'Eegah', N'Adventure, Fantasy', N'Unrated', N'1962', N'Teenagers stumble across a prehistoric caveman, who goes on a rampage.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (182, N'Being John Malkovich', N'Comedy, Drama, Fantasy', N'R', N'1999', N'A puppeteer discovers a portal that leads literally into the head of the movie star, John Malkovich.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (183, N'Like Stars on Earth', N'Drama', N'PG', N'2007', N'An eight year old boy is thought to be lazy and a troublemaker, until the new art teacher has the patience and compassion to discover the real problem behind his struggles in school.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (184, N'Devil Fish', N'Action, Horror, Thriller', N'R', N'1984', N'A marine biologist, a dolphin trainer, a research scientist, and a local sheriff try to hunt down a large sea monster, a shark/octopus hybrid, that is devouring swimmers and fishermen off a south Florida coast.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (185, N'The King''s Speech', N'Biography, Drama, History', N'R', N'2010', N'The story of King George VI of the United Kingdom of Great Britain and Northern Ireland, his impromptu ascension to the throne and the speech therapist who helped the unsure monarch become worthy of it.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (186, N'The Grapes of Wrath', N'Drama', N'Not Rated', N'1940', N'A poor Midwest family is forced off of their land. They travel to California, suffering the misfortunes of the homeless in the Great Depression.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (187, N'The Wild Bunch', N'Western', N'R', N'1969', N'An aging group of outlaws look for one last big score as the "traditional" American West is disappearing around them.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (188, N'Star Wars: Episode VI - Return of the Jedi', N'Action, Adventure, Fantasy', N'PG', N'1983', N'After rescuing Han Solo from the palace of Jabba the Hutt, the Rebels attempt to destroy the Second Death Star, while Luke Skywalker tries to bring his father back to the Light Side of the Force.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (189, N'Gigli', N'Comedy, Crime, Romance', N'R', N'2003', N'The violent story about how a criminal lesbian, a tough-guy hit-man with a heart of gold, and a mentally challenged man came to be best friends through a hostage.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (190, N'The Godfather: Part II', N'Crime, Drama', N'R', N'1974', N'The early life and career of Vito Corleone in 1920s New York is portrayed while his son, Michael, expands and tightens his grip on his crime syndicate stretching from Lake Tahoe, Nevada to pre-revolution 1958 Cuba.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (191, N'Seven Samurai', N'Action, Drama', N'Unrated', N'1954', N'A poor village under attack by bandits recruits seven unemployed samurai to help them defend themselves.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (192, N'The Big Lebowski', N'Comedy, Crime', N'R', N'1998', N'"Dude" Lebowski, mistaken for a millionaire Lebowski, seeks restitution for his ruined rug and enlists his bowling buddies to help get it.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (193, N'Life of Pi', N'Adventure, Drama, Fantasy', N'PG', N'2012', N'A young man who survives a disaster at sea is hurtled into an epic journey of adventure and discovery. While cast away, he forms an unexpected connection with another survivor: a fearsome Bengal tiger.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (194, N'The Godfather: Part III', N'Crime, Drama, Mystery', N'R', N'1990', N'In the midst of trying to legitimize his business dealings in 1979 New York and Italy, aging mafia don Michael Corleone seeks to vow for his sins while taking a young protégé under his wing.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (195, N'The Bridge on the River Kwai', N'Adventure, Drama, War', N'PG', N'1957', N'After settling his differences with a Japanese PoW camp commander, a British colonel co-operates to oversee his men''s construction of a railway bridge for their captors - while oblivious to a plan by the Allies to destroy it.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (196, N'Gandhi', N'Biography, Drama, History', N'PG', N'1982', N'Biography of Mohandas K. Gandhi, the lawyer who became the famed leader of the Indian revolts against the British rule through his philosophy of nonviolent protest.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (197, N'Raiders of the Lost Ark', N'Action, Adventure', N'PG', N'1981', N'Archeologist and adventurer Indiana Jones is hired by the US government to find the Ark of the Covenant before the Nazis.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (198, N'Shark', N'Crime, Drama, Mystery', N'N/A', N'2006–2008', N'Title character Sebastian Stark is an L.A. hot-shot lawyer, who leaves his lucrative career as defender of rich criminals to join the public prosecution under the District Attorney (D.A.), ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (199, N'Alone in the Dark', N'Action, Horror', N'R', N'2005', N'Based on the video game, Alone in the Dark focuses on Edward Carnby, a detective of the paranormal, who slowly unravels a mysterious events with deadly results.', 2.0000, N'')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (200, N'Dancer in the Dark', N'Crime, Drama, Musical', N'R', N'2000', N'An east European girl goes to America with her young son, expecting it to be like a Hollywood film.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (201, N'Mask', N'Biography, Drama', N'R', N'1985', N'A teenager with a massive facial skull deformity and biker gang mother attempts to live as normal a life as possible under the circumstances.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (202, N'Star Trek', N'Action, Adventure, Sci-Fi', N'PG-13', N'2009', N'The brash James T. Kirk tries to live up to his father''s legacy with Mr. Spock keeping him in check as a vengeful, time-traveling Romulan creates black holes to destroy the Federation one planet at a time.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (203, N'Star Wars: Episode V - The Empire Strikes Back', N'Action, Adventure, Sci-Fi', N'PG', N'1980', N'After the rebels have been brutally overpowered by the Empire on their newly established base, Luke Skywalker takes advanced Jedi training with Master Yoda, while his friends are pursued by Darth Vader as part of his plan to capture Luke.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (204, N'Kis Vuk', NULL, N'2.4', NULL, NULL, NULL, N'2')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (205, N'Son of the Mask', N'Adventure, Comedy, Family', N'PG', N'2005', N'Tim Avery, an aspiring cartoonist, finds himself in a predicament when his dog stumbles upon the mask of Loki. Then after conceiving an infant son "born of the mask", he discovers just how looney child raising can be.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (206, N'Jurassic Park', N'Adventure, Sci-Fi', N'PG-13', N'1993', N'During a preview tour, a theme park suffers a major power breakdown that allows its cloned dinosaur exhibits to run amok.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (207, N'Network', N'Drama', N'R', N'1976', N'A television network cynically exploits a deranged former anchor''s ravings and revelations about the news media for its own profit.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (208, N'The Jerk', N'Comedy', N'R', N'1979', N'An idiotic man struggles to make it through life on his own in St. Louis.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (209, N'Men in Black', N'Comedy, Sci-Fi', N'PG-13', N'1997', N'A streetwise NYPD detective joins a secret organization that polices extraterrestrial affairs on Earth.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (210, N'Monty Python and the Holy Grail', N'Adventure, Comedy, Fantasy', N'PG', N'1975', N'King Arthur and his knights embark on a low-budget search for the Grail, encountering many very silly obstacles.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (211, N'Anne B. Real', N'Drama', N'PG-13', N'2003', N'ANNE B. REAL is the coming of age story of a young female rapper, who finds her inspiration by reading the Diary of Anne Frank.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (212, N'Life Is Beautiful', N'Comedy, Drama, Romance', N'PG-13', N'1997', N'A Jewish man has a wonderful romance with the help of his humour, but must use that same quality to protect his son in a Nazi death camp.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (213, N'Touch of Evil', N'Crime, Film-Noir, Thriller', N'PG-13', N'1958', N'A stark, perverse story of murder, kidnapping, and police corruption in a Mexican border town.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (214, N'Annie Hall', N'Comedy, Romance', N'PG', N'1977', N'Neurotic New York comedian Alvy Singer falls in love with the ditsy Annie Hall.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (215, N'Mitchell', N'Crime, Action, Drama', N'R', N'1975', N'A sleazy, incompetent detective tries to simultaneously take down heroin dealers and a socialite who murdered a burglar.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (216, N'The Seventh Seal', N'Drama, Fantasy', N'Not Rated', N'1957', N'A man seeks answers about life, death, and the existence of God as he plays chess against the Grim Reaper during the Black Plague.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (217, N'Original', N'Comedy, Drama', N'N/A', N'2009', N'Henry has been acting the human chameleon all his life - a pale reflection of other people''s expectations. One day Henry''s best friend Jon talks him into opening a restaurant with him in ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (218, N'Downfall', N'Biography, Drama, History', N'R', N'2004', N'Traudl Junge, the final secretary for Adolf Hitler, tells of the Nazi dictator''s final days in his Berlin bunker at the end of WWII.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (219, N'Dream Well', N'Comedy, Romance, Sport', N'N/A', N'2009', N'Regina, the once popular girl has to make new friends at her new, conservative school. Problems arrive when she becomes enemies with Lívia, the school''s queen bee, and falls in love with ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (220, N'Pirates of the Caribbean: The Curse of the Black Pearl', N'Action, Adventure, Fantasy', N'PG-13', N'2003', N'Blacksmith Will Turner teams up with eccentric pirate "Captain" Jack Sparrow to save his love, the governor''s daughter, from Jack''s former pirate allies, who are now undead.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (221, N'Death at a Funeral', N'Comedy', N'R', N'2007', N'Chaos ensues when a man tries to expose a dark secret regarding a recently deceased patriarch of a dysfunctional British family.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (222, N'The General', N'Action, Adventure, Comedy', N'Unrated', N'1926', N'When Union spies steal an engineer''s beloved locomotive, he pursues it single handedly and straight through enemy lines.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (223, N'Skyfall', N'Action, Thriller', N'PG-13', N'2012', N'Bond''s loyalty to M is tested when her past comes back to haunt her. Whilst MI6 comes under attack, 007 must track down and destroy the threat, no matter how personal the cost.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (224, N'Call Girl', N'Drama, Thriller', N'N/A', N'2012', N'A young girl is recruited from the bottom rung of society into a ruthless world where power can get you anything.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (225, N'A Christmas Carol', N'Animation, Comedy, Drama', N'PG', N'2009', N'An animated retelling of Charles Dickens'' classic novel about a Victorian-era miser taken on a journey of self-redemption, courtesy of several mysterious Christmas apparitions.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (226, N'Beginning of the Great Revival', N'Drama, History', N'N/A', N'2011', N'A chronicle of the events that led to the founding of the Chinese Communist Party.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (227, N'Evil', N'Drama', N'Not Rated', N'2003', N'Erik is expelled from school for fighting. He ends up at a private boarding school where the senior students control the young ones. Erik finds a friend in Pierre, his room mate. The story ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (228, N'Moneyball', N'Biography, Drama, Sport', N'PG-13', N'2011', N'Oakland A''s general manager Billy Beane''s successful attempt to assemble a baseball team on a lean budget by employing computer-generated analysis to acquire new players.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (229, N'Hannibal', N'Crime, Drama, Thriller', N'R', N'2001', N'Hannibal returns to America and attempts to make contact with disgraced Agent Starling and survive a vengeful victim''s plan.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (230, N'Raging Bull', N'Biography, Drama, Sport', N'R', N'1980', N'An emotionally self-destructive boxer''s journey through life, as the violence and temper that leads him to the top in the ring, destroys his life outside it.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (231, N'Surf School', N'Comedy, Sport', N'R', N'2006', N'A rag-tag bunch of seniors, complete outsiders at their surf-crazed Laguna Beach High School, decide to crash the biggest team surf contest. In order to prevail, however, they must do one ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (232, N'L.A. Confidential', N'Crime, Drama, Mystery', N'R', N'1997', N'As corruption grows in 1950s LA, three policemen - the straight-laced, the brutal, and the sleazy - investigate a series of murders with their own brand of justice.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (233, N'Léon: The Professional', NULL, N'R', N'1994', NULL, 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (234, N'Resident Evil', N'Action, Horror, Sci-Fi', N'R', N'2002', N'A special military unit fights a powerful, out-of-control supercomputer and hundreds of scientists who have mutated into flesh-eating creatures after a laboratory accident.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (235, N'Storm', N'Drama, Fantasy, Thriller', N'N/A', N'2005', N'DD is a smug fellow, almost 30 years of age, who can manage all by himself. At least that''s what he thinks. However, a strange woman - Lova - enters his life, hunted by evil men who want to...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (236, N'Requiem for a Dream', N'Drama', N'R', N'2000', N'The drug-induced utopias of four Coney Island people are shattered when their addictions become stronger.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (237, N'M', NULL, N'8.4', NULL, NULL, NULL, N'4')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (238, N'The Ice Storm', N'Drama', N'R', N'1997', N'1973, suburban Connecticut: middle class families experimenting with casual sex, drink, etc., find their lives out of control.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (239, N'The Bourne Ultimatum', N'Action, Crime, Thriller', N'PG-13', N'2007', N'Jason Bourne dodges a ruthless CIA official and his agents from a new assassination program while searching for the origins of his life as a trained killer.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (240, N'Ip Man', N'Action, Biography, Drama', N'R', N'2008', N'A semi-biographical account of Yip Man, the first martial arts master to teach the Chinese martial art of Wing Chun.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (241, N'Alien', N'Horror, Sci-Fi', N'R', N'1979', N'The commercial vessel Nostromo receives a distress call from an unexplored planet. After searching for survivors, the crew heads home only to realize that a deadly bioform has joined them.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (242, N'A Separation', N'Drama', N'PG-13', N'2011', N'A married couple are faced with a difficult decision - to improve the life of their child by moving to another country or to stay in Iran and look after a deteriorating parent who has Alzheimer''s disease.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (243, N'Zombie Nation', N'Horror', N'R', N'2004', N'A psycho cop with a weakness for killing his female arrests gets what''s coming to him when a pack of zombie women rise from their graves in order to get proper revenge.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (244, N'The Rules of Attraction', N'Comedy, Drama, Romance', N'R', N'2002', N'The incredibly spoiled and overprivileged students of Camden College are a backdrop for an unusual love triangle between a drug dealer, a virgin and a bisexual classmate.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (245, N'Life of Brian', N'Comedy', N'R', N'1979', N'Brian is born on the original Christmas, in the stable next door. He spends his life being mistaken for a messiah.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (246, N'Batman', N'Action, Fantasy', N'PG-13', N'1989', N'The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (247, N'Tees Maar Khan', N'Comedy, Crime, Drama', N'N/A', N'2010', N'Posing as a movie producer, a robber cons an entire village to help him rob a treasure-laden train.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (248, N'The Celebration', N'Drama', N'R', N'1998', N'At Helge''s 60th birthday party, some unpleasant family truths are revealed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (249, N'Star Wars: Episode III - Reven', NULL, NULL, NULL, NULL, NULL, N'4')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (250, N'Habermann', N'Drama, Romance, War', N'N/A', N'2010', N'A mill owner in the Sudetenland and his family''s lives are changed as Europe heats up in 1938.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (251, N'3 Ninjas: High Noon at Mega Mountain', N'Action, Adventure, Comedy', N'PG', N'1998', N'Three young boys, Rocky, Colt and Tum Tum together with their neighbor girl, computer whiz Amanda are visiting Mega Mountain amusement park when it is invaded by an army of ninjas led by ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (252, N'The Maltese Falcon', N'Crime, Drama, Film-Noir', N'Not Rated', N'1941', N'A private detective takes on a case that involves him with three eccentric criminals, a gorgeous liar, and their quest for a priceless statuette.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (253, N'Pretty Woman', N'Comedy, Romance', N'R', N'1990', N'A man in a legal but hurtful business needs an escort for some social events, and hires a beautiful prostitute he meets... only to fall in love.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (254, N'Ran', N'Action, Drama, War', N'R', N'1985', N'An elderly lord abdicates to his three sons, and the two corrupt ones turn against him.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (255, N'Rain Man', N'Drama', N'R', N'1988', N'Selfish yuppie Charlie Babbitt''s father left a fortune to his savant brother Raymond and a pittance to Charlie; they travel cross-country.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (256, N'Se7en', N'Crime, Mystery, Thriller', N'R', N'1995', N'Two detectives, a rookie and a veteran, hunt a serial killer who uses the seven deadly sins as his modus operandi.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (257, N'Witness for the Prosecution', N'Crime, Drama, Mystery', N'Approved', N'1957', N'Leonard Vole is arrested on suspicion of murdering an elderly acquaintance. He employs an experienced but aging barrister as his defense attorney.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (258, N'Platoon', N'Action, Drama, War', N'R', N'1986', N'A young recruit in Vietnam faces a moral crisis when confronted with the horrors of war and the duality of man.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (259, N'Black Swan', N'Drama, Mystery, Thriller', N'R', N'2010', N'A ballet dancer wins the lead in "Swan Lake" and is perfect for the role of the delicate White Swan - Princess Odette - but slowly loses her mind as she becomes more and more like Odile, the Black Swan.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (260, N'Mr. Smith Goes to Washington', N'Drama', N'Not Rated', N'1939', N'A naive man is appointed to fill a vacancy in the US Senate. His plans promptly collide with political corruption, but he doesn''t back down.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (261, N'Barry Lyndon', N'Drama', N'PG', N'1975', N'An Irish rogue wins the heart of a rich widow and assumes her dead husband''s aristocratic position in 18th-century England.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (262, N'Strangers on a Train', N'Crime, Film-Noir, Thriller', N'PG', N'1951', N'A psychotic socialite confronts a pro tennis star with a theory on how two complete strangers can get away with murder...a theory that he plans to implement.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (263, N'Aquaman', N'Short, Action, Adventure', N'N/A', N'2006', N'A young twenty-something diver living in the Florida Keys discovers he has the power to breathe underwater.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (264, N'Dog Day Afternoon', N'Crime, Drama', N'R', N'1975', N'A man robs a bank to pay for his lover''s operation; it turns into a hostage situation and a media circus.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (265, N'Pulp Fiction', N'Crime, Drama, Thriller', N'R', N'1994', N'The lives of two mob hit men, a boxer, a gangster''s wife, and a pair of diner bandits intertwine in four tales of violence and redemption.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (266, N'No Country for Old Men', N'Crime, Drama, Thriller', N'R', N'2007', N'Violence and mayhem ensue after a hunter stumbles upon a drug deal gone wrong and more than two million dollars in cash near the Rio Grande.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (267, N'Cheaper by the Dozen', N'Comedy, Family', N'PG', N'2003', N'With his wife doing a book tour, a father of twelve must handle a new job and his unstable brood.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (268, N'Unforgiven', N'Western', N'R', N'1992', N'Retired Old West gunslinger William Munny reluctantly takes on one last job, with the help of his old partner and a young man.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (269, N'Catch Me If You Can', N'Biography, Crime, Drama', N'PG-13', N'2002', N'A true story about Frank Abagnale Jr., who, before his 19th birthday, successfully conned millions of dollars'' worth of checks as a Pan Am pilot, doctor, and legal prosecutor.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (270, N'Snow White and the Huntsman', N'Adventure, Drama, Fantasy', N'PG-13', N'2012', N'In a twist to the fairy tale, the Huntsman ordered to take Snow White into the woods to be killed winds up becoming her protector and mentor in a quest to vanquish the Evil Queen.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (271, N'The Wild World of Batwoman', N'Action, Comedy, Adventure', N'N/A', N'1966', N'The pointlessly named Batwoman and her bevy of Batmaidens fight evil and dance.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (272, N'High Noon', N'Drama, Western', N'PG', N'1952', N'A marshall, personally compelled to face a returning deadly enemy, finds that his own town refuses to help him.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (273, N'The Shawshank Redemption', N'Crime, Drama', N'R', N'1994', N'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (274, N'Armageddon', N'Action, Adventure, Sci-Fi', N'PG-13', N'1998', N'After discovering that an asteroid the size of Texas is going to impact Earth in less than a month, N.A.S.A. recruits a misfit team of deep core drillers to save the planet.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (275, N'Top Gun', N'Action, Drama, Romance', N'PG', N'1986', N'As students at the Navy''s elite fighter weapons school compete to be best in the class, one daring young flyer learns a few things from a civilian instructor that are not taught in the classroom.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (276, N'The Touch of Satan', N'Horror', N'PG', N'1971', N'A young man meets a farm girl who is actually a witch.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (277, N'Black Hawk Down', N'Drama, History, War', N'R', N'2001', N'123 elite U.S. soldiers drop into Somalia to capture two top lieutenants of a renegade warlord and find themselves in a desperate battle with a large force of heavily-armed Somalis.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (278, N'Manhattan', N'Comedy, Drama, Romance', N'R', N'1979', N'The life of a divorced television writer dating a teenage girl is further complicated when he falls in love with his best friend''s mistress.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (279, N'Ocean''s Eleven', N'Crime, Thriller', N'PG-13', N'2001', N'Danny Ocean and his eleven accomplices plan to rob three Las Vegas casinos simultaneously.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (280, N'Rashomon', N'Crime, Drama', N'Unrated', N'1950', N'A heinous crime and its aftermath are recalled from differing points of view.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (281, N'Saving Private Ryan', N'Action, Drama, War', N'R', N'1998', N'Following the Normandy Landings, a group of U.S. soldiers go behind enemy lines to retrieve a paratrooper whose brothers have been killed in action.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (282, N'Spider-Man', N'Action, Fantasy', N'PG-13', N'2002', N'When bitten by a genetically modified spider, a nerdy, shy, and awkward high school student gains spider-like abilities that he eventually must use to fight evil as a superhero after tragedy befalls his family.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (283, N'Cocoon', N'Comedy, Drama, Sci-Fi', N'PG-13', N'1985', N'When a group of trespassing seniors swim in a pool containing alien cocoons, they find themselves energized with youthful vigour.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (284, N'Kingdom of Heaven', N'Action, Adventure, Drama', N'R', N'2005', N'Balian of Ibelin travels to Jerusalem during the crusades of the 12th century, and there he finds himself as the defender of the city and its people.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (285, N'Papillon', N'Biography, Crime, Drama', N'R', N'1973', N'A man befriends a fellow criminal as the two of them begin serving their sentence on a dreadful prison island, which inspires the man to plot his escape.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (286, N'The Pumaman', N'Action, Adventure, Fantasy', N'N/A', N'1980', N'Low-budget film about a young man given a mystical medallion by an Aztec shaman, in order to become a puma-empowered champion like his father before him. In trying to initially locate the ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (287, N'Inception', N'Action, Adventure, Mystery', N'PG-13', N'2010', N'A skilled extractor is offered a chance to regain his old life as payment for a task considered to be impossible.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (288, N'The Elephant Man', N'Biography, Drama', N'PG', N'1980', N'A Victorian surgeon rescues a heavily disfigured man who is mistreated while scraping a living as a side-show freak. Behind his monstrous facade, there is revealed a person of intelligence and sensitivity.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (289, N'Children of Men', N'Drama, Sci-Fi, Thriller', N'R', N'2006', N'In 2027, in a chaotic world in which women have become somehow infertile, a former activist agrees to help transport a miraculously pregnant woman to a sanctuary at sea.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (290, N'Plump Fiction', N'Comedy, Crime', N'R', N'1997', N'Follows the plot of Pulp Fiction, also parodying scenes from other movies.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (291, N'Chinatown', N'Drama, Mystery, Thriller', N'R', N'1974', N'A private detective hired to expose an adulterer finds himself caught up in a web of deceit, corruption and murder.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (292, N'Lethal Weapon', N'Action, Thriller', N'R', N'1987', N'A veteran cop, Murtaugh, is partnered with a young suicidal cop, Riggs. Both having one thing in common; hating working in pairs. Now they must learn to work with one another to stop a gang of drug smugglers.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (293, N'How to Train Your Dragon', N'Animation, Adventure, Comedy', N'PG', N'2010', N'A hapless young Viking who aspires to hunt dragons becomes the unlikely friend of a young dragon himself, and learns there may be more to the creatures than he assumed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (294, N'12 Angry Men', N'Drama', N'Not Rated', N'1957', N'A dissenting juror in a murder trial slowly manages to convince the others that the case is not as obviously clear as it seemed in court.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (295, N'Singin'' in the Rain', N'Comedy, Musical, Romance', N'Approved', N'1952', N'A silent film production company and cast make a difficult transition to sound.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (296, N'The Third Man', N'Film-Noir, Mystery, Thriller', N'Not Rated', N'1949', N'Pulp novelist Holly Martins travels to shadowy, postwar Vienna, only to find himself investigating the mysterious death of an old friend, black-market opportunist Harry Lime.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (297, N'Doctor Zhivago', N'Drama, History, Romance', N'PG-13', N'1965', N'Life of a Russian doctor/poet who, although married, falls for a political activist''s wife and experiences hardships during the Bolshevik Revolution.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (298, N'Gran Torino', N'Drama', N'R', N'2008', N'Disgruntled Korean War veteran Walt Kowalski sets out to reform his neighbor, a Hmong teenager who tried to steal Kowalski''s prized possession: a 1972 Gran Torino.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (299, N'Hero', N'Action, Drama, History', N'PG-13', N'2002', N'A defense officer, Nameless, was summoned by the King of Qin regarding his success of terminating three warriors.', 2.0000, N'')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (300, N'American Psycho', N'Crime, Drama', N'R', N'2000', N'A wealthy New York investment banking executive hides his alternate psychopathic ego from his co-workers and friends as he escalates deeper into his illogical, gratuitous fantasies.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (301, N'Miffo', N'Comedy, Drama, Romance', N'N/A', N'2003', N'Suburban priest falls in love with woman in wheelchair.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (302, N'Vertigo', N'Mystery, Romance, Thriller', N'Approved', N'1958', N'A retired San Francisco detective suffering from acrophobia investigates the strange activities of an old friend''s wife, all the while becoming dangerously obsessed with her.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (303, N'Casino', N'Biography, Crime, Drama', N'R', N'1995', N'Greed, deception, money, power, and murder occur between two mobster best friends and a trophy wife over a gambling empire.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (304, N'Cinema Paradiso', N'Drama', N'R', N'1988', N'A filmmaker recalls his childhood, when he fell in love with the movies at his village''s theater and formed a deep friendship with the theater''s projectionist.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (305, N'Last Action Hero', N'Action, Adventure, Comedy', N'PG-13', N'1993', N'A young movie fan gets thrown into the movie world of his favourite action film character.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (306, N'Memento', N'Mystery, Thriller', N'R', N'2000', N'A man, suffering from short-term memory loss, uses notes and tattoos to hunt for the man he thinks killed his wife.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (307, N'Monster a-Go Go', N'Sci-Fi, Horror', N'TV-PG', N'1965', N'A space capsule crash-lands, and the astronaut aboard disappears. Is there a connection between the missing man and the monster roaming the area?', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (308, N'Desperado', N'Action, Crime, Thriller', N'R', N'1995', N'A gunslinger is embroiled in a war with a local drug runner.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (309, N'Psycho', N'Horror, Mystery, Thriller', N'TV-14', N'1960', N'A Phoenix secretary steals $40,000 from her employer''s client, goes on the run and checks into a remote motel run by a young man under the domination of his mother.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (310, N'Donnie Darko', N'Drama, Mystery, Sci-Fi', N'R', N'2001', N'A troubled teenager is plagued by visions of a large bunny rabbit that manipulates him to commit a series of crimes, after narrowly escaping a bizarre accident.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (311, N'Fargo', N'Crime, Drama, Thriller', N'R', N'1996', N'Jerry Lundegaard''s inept crime falls apart due to his and his henchmen''s bungling and the persistent police work of the quite pregnant Marge Gunderson.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (312, N'Finding Nemo', N'Animation, Adventure, Comedy', N'G', N'2003', N'After his son is captured in the Great Barrier Reef and taken to Sydney, a timid clownfish sets out on a journey to bring him home.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (313, N'Argo', N'Biography, Drama, History', N'R', N'2012', N'Acting under the cover of a Hollywood producer scouting a location for a science fiction film, a CIA agent launches a dangerous operation to rescue six Americans in Tehran during the U.S. hostage crisis in Iran in 1980.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (314, N'Yojimbo', N'Action, Adventure', N'Unrated', N'1961', N'A crafty ronin comes to a town divided by two criminal gangs and decides to play them against each other to free the town.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (315, N'My Neighbor Totoro', N'Animation, Family, Fantasy', N'G', N'1988', N'When two girls move to the country to be near their ailing mother, they have adventures with the wonderous forest spirits who live nearby.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (316, N'Forrest Gump', N'Drama, Romance', N'PG-13', N'1994', N'Forrest Gump, while not intelligent, has accidentally been present at many historic moments, but his true love, Jenny Curran, eludes him.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (317, N'The Help', N'Drama', N'PG-13', N'2011', N'An aspiring author during the civil rights movement of the 1960s decides to write a book detailing the African-American maids'' point of view on the white families for which they work, and the hardships they go through on a daily basis.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (318, N'Up', N'Animation, Adventure, Drama', N'PG', N'2009', N'By tying thousands of balloons to his home, 78-year-old Carl sets out to fulfill his lifelong dream to see the wilds of South America. Russell, a wilderness explorer 70 years younger, inadvertently becomes a stowaway.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (319, N'The Big Sleep', N'Crime, Film-Noir, Mystery', N'Not Rated', N'1946', N'Private detective Philip Marlowe is hired by a rich family. Before the complex case is over, he''s seen murder, blackmail, and what might be love.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (320, N'Blade Runner', N'Drama, Sci-Fi, Thriller', N'R', N'1982', N'A blade runner must pursue and try to terminate four replicants who stole a ship in space and have returned to Earth to find their creator.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (321, N'Ulli Lommel''s Zodiac Killer', N'Crime', N'R', N'2005', N'A young man who works at a nursing home uses the legendary Zodiac killer''s M.O. to kill people who neglect their elderly relatives.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (322, N'.com for Murder', N'Horror, Sci-Fi, Thriller', N'Unrated', N'2002', N'This high-tech, psychological thriller is set in the shadowy world of the Internet. Sondra Brummel is recovering from a skiing accident in her boyfriend''s mansion, and accidently contacts a...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (323, N'Mystic River', N'Crime, Drama, Mystery', N'R', N'2003', N'With a childhood tragedy that overshadowed their lives, three men are reunited by circumstance when one loses a daughter.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (324, N'The Transporter', N'Action, Crime, Thriller', N'PG-13', N'2002', N'This film is about a man whose job is to deliver packages without asking any questions. Complications arise when he breaks those rules.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (325, N'Bright Star', N'Biography, Drama, Romance', N'PG', N'2009', N'The three-year romance between 19th century poet John Keats and Fanny Brawne.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (326, N'Character', N'Crime, Drama, Mystery', N'R', N'1997', N'Jacob Katadreuffe lives mute with his mother, has no contact with his father who only works against him and wants to become a lawyer, at all costs.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (327, N'The Wrestler', N'Drama, Sport', N'R', N'2008', N'A faded professional wrestler must retire, but finds his quest for a new life outside the ring a dispiriting struggle.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (328, N'Popstar', N'Comedy, Family, Romance', N'PG', N'2005', N'A teenage girl''s life gets turned upside down when a new school friend turns out to be a pop star.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (329, N'The Hustler', N'Drama, Sport', N'Unrated', N'1961', N'An up-and-coming pool player plays a long-time champion in a single high-stakes match.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (330, N'Warrior', N'Drama, Sport', N'PG-13', N'2011', N'The youngest son of an alcoholic former boxer returns home, where he''s trained by his father for competition in a mixed martial arts tournament - a path that puts the fighter on a collision corner with his older brother.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (331, N'Ben', N'Horror, Thriller', N'PG', N'1972', N'A lonely boy becomes good friends with Ben, a rat. This rat is also the leader of a pack of vicious killer rats, killing lots of people.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (332, N'Ben-Hur', N'Adventure, Drama', N'TV-PG', N'1959', N'When a Jewish prince is betrayed and sent into slavery by a Roman friend, he regains his freedom and comes back for revenge.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (333, N'The Chrysanthemum and the Swor', N'', N'', N'', N'', 0.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (334, N'Perfume: The Story of a Murder', NULL, NULL, NULL, NULL, NULL, N'2')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (335, N'Anatomy of a Murder', N'Crime, Drama, Mystery', N'Unrated', N'1959', N'In a murder trial, the defendant says he suffered temporary insanity after the victim raped his wife. What is the truth, and will he win his case?', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (336, N'Daniel - Der Zauberer', NULL, N'2', NULL, NULL, NULL, N'2')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (337, N'Taxi Driver', N'Crime, Drama', N'R', N'1976', N'A mentally unstable Vietnam war veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feeds his urge for violent action, attempting to save a preadolescent prostitute in the process.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (338, N'The Lincoln Lawyer', N'Crime, Drama, Thriller', N'R', N'2011', N'A defense attorney has a crisis of conscience when he represents a wealthy client who has a foolproof plan to beat the system.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (339, N'The Night of the Hunter', N'Crime, Film-Noir, Thriller', N'Approved', N'1955', N'A religious fanatic marries a gullible widow whose young children are reluctant to tell him where their real daddy hid $10,000 he''d stolen in a robbery.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (340, N'Birdemic: Shock and Terror', N'Horror, Romance, Thriller', N'Not Rated', N'2010', N'A platoon of eagles and vultures attacks the residents of a small town. Many people die. It''s not known what caused the flying menace to attack. Two people manage to fight back, but will they survive Birdemic?', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (341, N'I Killed My Mother', N'Drama', N'Not Rated', N'2009', N'A semi-autobiographical story about Dolan as a young homosexual at odds with his mother.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (342, N'Easy Rider', N'Drama', N'R', N'1969', N'Two counterculture bikers travel from Los Angeles to New Orleans in search of America.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (343, N'Stalker', N'Drama, Sci-Fi', N'Not Rated', N'1979', N'A guide leads two men through an area known as the Zone to find a room that grants wishes.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (344, N'The Terminator', N'Action, Sci-Fi', N'R', N'1984', N'A human-looking indestructible cyborg is sent from 2029 to 1984 to assassinate a waitress, whose unborn son will lead humanity in a war against the machines, while a soldier from that war is sent to protect her at all costs.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (345, N'Gladiator', N'Action, Adventure, Drama', N'R', N'2000', N'When a Roman general is betrayed and his family murdered by an emperor''s corrupt son, he comes to Rome as a gladiator to seek revenge.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (346, N'Soultaker', N'Fantasy, Horror', N'R', N'1990', N'Four teenagers are killed in a car accident. Two of the teenagers refuse to go with "The Grim Reaper" and a race between life and death ensues!', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (347, N'The Godfather', N'Crime, Drama', N'R', N'1972', N'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (348, N'Harry Potter and the Prisoner of Azkaban', N'Adventure, Family, Fantasy', N'PG', N'2004', N'It''s Harry''s third year at Hogwarts; not only does he have a new "Defense Against the Dark Arts" teacher, but there is also trouble brewing. Convicted murderer Sirius Black has escaped the Wizards'' Prison and is coming after Harry.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (349, N'The Blade Master', N'Action, Adventure, Fantasy', N'PG', N'1984', N'Muscle-bound Ator and his mute Asian sidekick travel from the ends of the Earth to save his aged mentor from the evil mustachioed Zor.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (350, N'Lord of War', N'Crime, Drama, Thriller', N'R', N'2005', N'An arms dealer confronts the morality of his work as he is being chased by an Interpol agent.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (351, N'The Creeping Terror', N'Sci-Fi, Horror', N'N/A', N'1964', N'A newlywed sheriff tries to stop a shambling monster that has emerged from a spaceship to eat people.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (352, N'Crossover', N'Action, Sport', N'PG-13', N'2006', N'A naturally talented basketball player, Noah Cruise is determined to become a doctor using his basketball scholarship to UCLA pre-med, rather than succumb to the lure of former sports agent...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (353, N'The Ghost Writer', N'Horror', N'N/A', N'1990', N'N/A', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (354, N'In the Name of the Father', N'Biography, Drama, Thriller', N'R', N'1993', N'A man''s coerced confession to an IRA bombing he did not commit results in the imprisonment of his father as well. An English lawyer fights to free them.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (355, N'The Great Dictator', N'Comedy, Drama, War', N'Approved', N'1940', N'Dictator Adenoid Hynkel tries to expand his empire while a poor Jewish barber tries to avoid persecution from Hynkel''s regime.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (356, N'(500) Days of Summer', N'Comedy, Drama, Romance', N'PG-13', N'2009', N'An offbeat romantic comedy about a woman who doesn''t believe true love exists, and the young man who falls for her.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (357, N'Arn: The Knight Templar', N'Action, Adventure, Drama', N'N/A', N'2007', N'Arn, the son of a high-ranking Swedish nobleman is educated in a monastery and sent to the Holy Land as a knight templar to do penance for a forbidden love.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (358, N'Dial M for Murder', N'Crime, Thriller', N'PG', N'1954', N'An ex-tennis pro carries out a plot to murder his wife. When things go wrong, he improvises a brilliant plan B.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (359, N'American Gangster', N'Biography, Crime, Drama', N'R', N'2007', N'In 1970s America, a detective works to bring down the drug empire of Frank Lucas, a heroin kingpin from Manhattan, who is smuggling the drug into the country from the Far East.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (360, N'The Deer Hunter', N'Drama, War', N'R', N'1978', N'An in-depth examination of the way that the Vietnam war affects the lives of people in a small industrial town in the USA.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (361, N'Yes Sir', N'Action, Adventure, Comedy', N'N/A', N'2007', N'N/A', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (362, N'Kramer vs. Kramer', N'Drama', N'Approved', N'1979', N'A just-divorced man must learn to care for his son on his own, and then must fight in court to keep custody of him.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (363, N'Memories of Murder', N'Crime, Drama, Mystery', N'Unrated', N'2003', N'In 1986, in the province of Gyunggi, in South Korea, a second young and beautiful woman is found dead, raped and tied and gagged with her underwear. Detective Park Doo-Man and Detective Cho...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (364, N'The Perks of Being a Wallflower', N'Drama, Romance', N'PG-13', N'2012', N'An introvert freshman is taken under the wings of two seniors who welcome him to the real world.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (365, N'Sweeney Todd: The Demon Barber of Fleet Street', N'Drama, Horror, Musical', N'R', N'2007', N'The infamous story of Benjamin Barker, a.k.a Sweeney Todd, who sets up a barber shop down in London which is the basis for a sinister partnership with his fellow tenant, Mrs. Lovett. Based on the hit Broadway musical.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (366, N'Glitter', N'Music, Romance', N'PG-13', N'2001', N'A young singer dates a disc jockey who helps her get into the music business, but their relationship become complicated as she ascends to super stardom.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (367, N'Baby Geniuses', N'Comedy, Crime, Family', N'PG', N'1999', N'Scientist hold talking, super-intelligent babies captive, but things take a turn for the worse when a mix-up occurs between a baby genius and its twin.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (368, N'Miss Castaway and the Island Girls', N'Adventure, Comedy, Fantasy', N'N/A', N'2004', N'A spoof that combines Cast Away with Miss Congeniality, Planet of the Apes, Love Boat, Gilligan''s Island, The Sixth Sense, Jurassic Park, and more', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (369, N'Incendies', N'Drama, Mystery, War', N'R', N'2010', N'Twins journey to the Middle East to discover their family history, and fulfill their mother''s last wishes.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (370, N'Dangerous Liaisons', N'Drama, Romance', N'R', N'1988', N'Rich and bored aristocrats in Rococo France play high-stakes games of passion and betrayal.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (371, N'The Hunger Games', N'Adventure, Sci-Fi, Thriller', N'PG-13', N'2012', N'Katniss Everdeen voluntarily takes her younger sister''s place in the Hunger Games, a televised fight to the death in which two teenagers from each of the twelve Districts of Panem are chosen at random to compete.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (372, N'A Fistful of Dollars', N'Western', N'R', N'1964', N'A wandering gunfighter plays two rival families against each other in a town torn apart by greed, pride, and revenge.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (373, N'Seven Mummies', N'Action, Adventure, Drama', N'Unrated', N'2006', N'Six escaped convicts and their female hostage make a desperate run for the Mexican border, where they stumble across a lost treasure of untold wealth, and find certain death instead on the Arizona desert.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (374, N'Army of Shadows', N'Drama, War', N'Not Rated', N'1969', N'A account of underground resistance fighters in Nazi-occupied France.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (375, N'Merlin''s Shop of Mystical Wonders', N'Fantasy', N'Unrated', N'1996', N'Two creepy "horror" films joined together by Merlin''s Shop which is, in turn, introduced by a Grandpa telling the story.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (376, N'Quills', N'Biography, Drama', N'R', N'2000', N'In a Napoleonic era insane asylum, an inmate, the irrepressible Marquis De Sade, fights a battle of wills against a tyrannically prudish doctor.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (377, N'The Usual Suspects', N'Crime, Mystery, Thriller', N'R', N'1995', N'A boat has been destroyed, criminals are dead, and the key to this mystery lies with the only survivor and his twisted, convoluted story beginning with five career crooks in a seemingly random police lineup.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (378, N'The Naked Gun: From the Files of Police Squad!', N'Comedy, Crime', N'PG-13', N'1988', N'Incompetent cop Frank Drebin has to foil an attempt to assassinate Queen Elizabeth II.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (379, N'Iris', N'Biography, Drama, Romance', N'R', N'2001', N'True story of the lifelong romance between novelist Iris Murdoch and her husband John Bayley, from their student days through her battle with Alzheimer''s disease.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (380, N'The Searchers', N'Western', N'Unrated', N'1956', N'A Civil War veteran embarks on a journey to rescue his niece from an Indian tribe.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (381, N'The Secret in Their Eyes', N'Drama, Mystery, Thriller', N'R', N'2009', N'A retired legal counselor writes a novel hoping to find closure for one of his past unresolved homicide cases and for his unreciprocated love with his superior - both of which still haunt him decades later.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (382, N'Jaws', N'Adventure, Horror, Thriller', N'PG', N'1975', N'When a gigantic great white shark begins to menace the small island community of Amity, a police chief, a marine scientist and grizzled fisherman set out to stop it.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (383, N'Hocus Pocus', N'Comedy, Family, Fantasy', N'PG', N'1993', N'After three centuries, three witch sisters are resurrected in Salem Massachusetts on Halloween night, and it is up to two teen-agers, a young girl, and an immortal cat to put an end to the witches'' reign of terror once and for all.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (384, N'The Untouchables', N'Crime, Drama, History', N'R', N'1987', N'Federal Agent Eliot Ness sets out to stop Al Capone; because of rampant corruption, he assembles a small, hand-picked team.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (385, N'Infernal Affairs', N'Crime, Mystery, Thriller', N'R', N'2002', N'A story between a mole in the police department and an undercover cop. Their objectives are the same: to find out who is the mole, and who is the cop.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (386, N'Prometheus', N'Adventure, Mystery, Sci-Fi', N'R', N'2012', N'A team of explorers discover a clue to the origins of mankind on Earth, leading them on a journey to the darkest corners of the universe. There, they must fight a terrifying battle to save the future of the human race.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (387, N'The Lives of Others', N'Drama, Thriller', N'R', N'2006', N'In 1984 East Berlin, an agent of the secret police, conducting surveillance on a writer and his lover, finds himself becoming increasingly absorbed by their lives.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (388, N'The Dreamers', N'Drama, Romance', N'NC-17', N'2003', N'A young American studying in Paris in 1968 strikes up a friendship with a French brother and sister. Set against the background of the ''68 Paris student riots.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (389, N'Edward Scissorhands', N'Drama, Fantasy, Romance', N'PG-13', N'1990', N'An uncommonly gentle young man, who happens to have scissors for hands, falls in love with a beautiful adolescent girl.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (390, N'The Avengers', N'Action, Fantasy', N'PG-13', N'2012', N'Nick Fury of S.H.I.E.L.D. assembles a team of superheroes to save the planet from Loki and his army.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (391, N'Metropolis', N'Drama, Sci-Fi', N'Not Rated', N'1927', N'In a futuristic city sharply divided between the working class and the city planners, the son of the city''s mastermind falls in love with a working class prophet who predicts the coming of a savior to mediate their differences.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (392, N'The Silence of the Lambs', N'Crime, Drama, Thriller', N'R', N'1991', N'A young F.B.I. cadet must confide in an incarcerated and manipulative killer to receive his help on catching another serial killer who skins his victims.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (393, N'Bicycle Thieves', N'Drama', N'Not Rated', N'1948', N'A man and his son search for a stolen bicycle vital for his job.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (394, N'Weekend at Bernie''s', N'Comedy', N'PG-13', N'1989', N'A pair of losers try to pretend that their murdered employer is really alive, but the murderer is out to "finish him off."', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (395, N'Notorious', N'Drama, Film-Noir, Romance', N'Approved', N'1946', N'A woman is asked to spy on a group of Nazi friends in South America. How far will she have to go to ingratiate herself with them?', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (396, N'Smoke Gets in Your Eyes', N'Drama', N'TV-14', N'2007', N'In 1960 New York City - the high-powered and glamorous "Golden Age" of advertising - Don Draper, the biggest ad man in the business, struggles to stay a step ahead of the rapidly changing ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (397, N'The 400 Blows', N'Crime, Drama', N'Not Rated', N'1959', N'Intensely touching story of a misunderstood young adolescent who left without attention, delves into a life of petty crime.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (398, N'Star Wars', N'Action, Adventure, Sci-Fi', N'N/A', N'1983', N'N/A', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (399, N'Inglourious Basterds', N'Adventure, Drama, War', N'R', N'2009', N'In Nazi-occupied France during World War II, a plan to assassinate Nazi leaders by a group of Jewish U.S. soldiers coincides with a theatre owner''s vengeful plans for the same.', 2.0000, N'')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (400, N'Pledge This!', N'Comedy', N'R', N'2006', N'At South Beach University, a beautiful sorority president takes in a group of unconventional freshman girls seeking acceptance into her house.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (401, N'The Duellists', N'Drama, War', N'PG', N'1977', N'Set during the grand, sweeping Napoleonic age, an officer in the French army insults another officer and sets off a life-long enmity. The two officers, D''Hubert and Feraud, cross swords ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (402, N'The Starfighters', N'Drama', N'N/A', N'1964', N'A young Air Force lieutenant falls in love with fighter planes while his father, a Congressman and war hero, yearns for him to fly heavy bombers.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (403, N'Fat Slags', N'Comedy', N'N/A', N'2004', N'The Fat Slags from Viz hit the big time and become celebrities.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (404, N'Santa Claus', N'Adventure, Family, Fantasy', N'PG', N'1985', N'The first half of this film, set hundreds of years ago, shows how the old man who eventually became Santa Claus was given immortality and chosen to deliver toys to all the children of the world. The second half moves into the modern era, in which Patch, the head elf, strikes out on his own and falls in with an evil toy manufacturer who wants to corner the market and eliminate Santa Claus.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (405, N'The Living Daylights', N'Action, Adventure, Crime', N'PG', N'1987', N'James Bond is living on the edge to stop an evil arms dealer from starting another world war. Bond crosses all seven continents in order to stop the evil Whitaker and General Koskov.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (406, N'Twelve Monkeys', N'Mystery, Sci-Fi, Thriller', N'R', N'1995', N'In a future world devastated by disease, a convict is sent back in time to gather information about the man-made virus that wiped out most of the human population on the planet.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (407, N'Boggy Creek II: And the Legend Continues', N'Horror, Drama, Mystery', N'PG', N'1985', N'Professor and students camp out to find Bigfoot-type creature.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (408, N'127 Hours', N'Adventure, Biography, Drama', N'R', N'2010', N'A mountain climber becomes trapped under a boulder while canyoneering alone near Moab, Utah and resorts to desperate measures in order to survive.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (409, N'Nine Lives', N'Drama', N'R', N'2005', N'Captives of the very relationships that define and sustain them, nine women resiliently meet the travails and disappointments of life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (410, N'City Lights', N'Comedy, Drama, Romance', N'N/A', N'1931', N'The Tramp struggles to help a blind flower girl he has fallen in love with.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (411, N'I Accuse My Parents', N'Crime, Drama', N'Approved', N'1944', N'Young man goes to work for gangsters to impress his nightclub-singer girlfriend.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (412, N'Santa Claus Conquers the Martians', N'Comedy, Family, Sci-Fi', N'Not Rated', N'1964', N'The Martians kidnap Santa because there is nobody on Mars to give their children presents.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (413, N'Lock, Stock and Two Smoking Barrels', N'Comedy, Crime', N'R', N'1998', N'A botched card game in London triggers four friends, thugs, weed-growers, hard gangsters, loan sharks and debt collectors to collide with each other in a series of unexpected events, all for the sake of weed, cash and two antique shotguns.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (414, N'The Lord of the Rings: The Two Towers', N'Action, Adventure, Fantasy', N'PG-13', N'2002', N'While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron''s new ally, Saruman, and his hordes of Isengard.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (415, N'Ram Gopal Varma''s Indian Flames', N'Action, Adventure, Comedy', N'N/A', N'2007', N'Nasik-based Heerendra Dhaan and Raj Ranade are bodyguards of a politician, but after their employer is implicated in a scam, they end up assaulting a police officer and flee to Mumbai. Once...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (416, N'Aliens', N'Action, Adventure, Sci-Fi', N'R', N'1986', N'The planet from Alien (1979) has been colonized, but contact is lost. This time, the rescue team has impressive firepower, but will it be enough?', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (417, N'Rocco and His Brothers', N'Crime, Drama, Sport', N'Approved', N'1960', N'Having recently been uprooted to Milan, Rocco and his four brothers each look for a new way in life when a prostitute comes between Rocco and his brother Simone.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (418, N'The Best Years of Our Lives', N'Drama, Romance, War', N'N/A', N'1946', N'Three WWII veterans return home to small-town America to discover that they and their families have been irreparably changed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (419, N'X-Men: First Class', N'Action, Adventure, Sci-Fi', N'PG-13', N'2011', N'In 1962, the United States government enlists the help of Mutants with superhuman abilities to stop a malicious dictator who is determined to start world war III.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (420, N'Spartacus', N'Action, Adventure, Biography', N'PG-13', N'1960', N'The slave Spartacus leads a violent revolt against the decadent Roman Republic.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (421, N'The Skydivers', N'Drama', N'N/A', N'1963', N'A woman seeks revenge on her former lover, who owns a skydiving business.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (422, N'The Dark Knight Rises', N'Action, Crime, Thriller', N'PG-13', N'2012', N'Eight years on, a new evil rises from where the Batman and Commissioner Gordon tried to bury it, causing the Batman to resurface and fight to protect Gotham City... the very city which brands him an enemy.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (423, N'The Others', N'Drama, Horror, Mystery', N'PG-13', N'2001', N'A woman who lives in a darkened old house with her two photosensitive children becomes convinced that her family home is haunted.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (424, N'Grave of the Fireflies', N'Animation, Drama, War', N'Unrated', N'1988', N'A tragic film covering a young boy and his little sister''s struggle to survive in Japan during World War II.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (425, N'Another Nine & a Half Weeks', N'Drama, Romance', N'R', N'1997', N'John flies over to Paris to find out his girlfriend Elizabeth. He finds a mysterious fashion designer named Lea and her assistant Claire, and it turns out that Lea was Elizabeth''s friend in...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (426, N'Santa with Muscles', N'Family, Comedy', N'PG', N'1996', N'An evil millionaire (Hulk Hogan) gets amnesia and then belives that he is Santa Claus.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (427, N'The Beast of Yucca Flats', N'Horror, Sci-Fi', N'Unrated', N'1961', N'A defecting Soviet scientist is hit by a nuclear explosion near Yucca Flats and roams around as a beast.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (428, N'The Killing Fields', N'Drama, History, War', N'R', N'1984', N'A photographer is trapped in Cambodia during tyrant Pol Pot''s bloody "Year Zero" cleansing campaign, which claimed the lives of two million "undesirable" civilians.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (429, N'Dances with Wolves', N'Adventure, Drama, Romance', N'PG-13', N'1990', N'Lt. John Dunbar, exiled to a remote western Civil War outpost, befriends wolves and Indians, making him an intolerable aberration in the military.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (430, N'Batman Begins', N'Action, Adventure, Crime', N'PG-13', N'2005', N'After training with his mentor, Batman begins his war on crime to free the crime-ridden Gotham City from corruption that the Scarecrow and the League of Shadows have cast upon it.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (431, N'Flyboys', N'Action, Adventure, Drama', N'PG-13', N'2006', N'The adventures of the Lafayette Escadrille, young Americans who volunteered for the French military before the U.S. entered World War I, and became the country''s first fighter pilots.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (432, N'Amores Perros', N'Drama, Thriller', N'R', N'2000', N'A horrific car accident connects three stories, each involving characters dealing with loss, regret, and life''s harsh realities, all in the name of love.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (433, N'Modern Times', N'Comedy, Drama', N'G', N'1936', N'The Tramp struggles to live in modern industrial society with the help of a young homeless woman.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (434, N'Amadeus', N'Biography, Drama, Music', N'R', N'1984', N'The incredible story of Wolfgang Amadeus Mozart, told by his peer and secret rival Antonio Salieri - now confined to an insane asylum.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (435, N'Breathless', N'Crime, Drama, Romance', N'Unrated', N'1960', N'A young car thief kills a policeman and tries to persuade a girl to hide in Italy with him.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (436, N'Kopps', N'Action, Comedy', N'N/A', N'2003', N'When a small town police station is threatened with shutting down because of too little crime, the police realise that something has to be done...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (437, N'Immortals', N'Action, Drama, Fantasy', N'R', N'2011', N'Theseus is a mortal man chosen by Zeus to lead the fight against the ruthless King Hyperion, who is on a rampage across Greece to obtain a weapon that can destroy humanity.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (438, N'Sherlock Holmes', N'Action, Adventure, Crime', N'PG-13', N'2009', N'Detective Sherlock Holmes and his stalwart partner Watson engage in a battle of wits and brawn with a nemesis whose plot is a threat to all of England.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (439, N'The Smokers', N'Drama', N'R', N'2000', N'Three rebellious teenage girls decide to even the score in the battle of the sexes.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (440, N'Wild Strawberries', N'Drama', N'Unrated', N'1957', N'After living a life marked by coldness, an aging professor is forced to confront the emptiness of his existence.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (441, N'Girl in Gold Boots', N'Crime, Drama, Music', N'R', N'1968', N'A girl tries to become the top star in the glamorous world of Go-Go Dancing.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (442, N'The Cabin in the Woods', N'Horror, Mystery, Thriller', N'R', N'2012', N'Five friends go for a break at a remote cabin in the woods, where they get more than they bargained for. Together, they must discover the truth behind the cabin in the woods.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (443, N'Hobgoblins', N'Comedy, Horror, Sci-Fi', N'R', N'1988', N'A young security guard must track down diminutive aliens who kill people even as they make their fantasies come true.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (444, N'Transformers', N'Action, Adventure, Sci-Fi', N'PG-13', N'2007', N'An ancient struggle between two Cybertronian races, the heroic Autobots and the evil Decepticons, comes to Earth, with a clue to the ultimate power held by a teenager.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (445, N'Goodfellas', N'Biography, Crime, Drama', N'R', N'1990', N'Henry Hill and his friends work their way up through the mob hierarchy.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (446, N'Les Misérables', NULL, N'PG-13', N'2012', NULL, 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (447, N'3 Idiots', N'Comedy, Drama, Romance', N'PG-13', N'2009', N'Two friends are searching for their long lost companion. They revisit their college days and recall the memories of their friend who inspired them to think differently, even as the rest of the world called them "idiots".', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (448, N'Reservoir Dogs', N'Crime, Thriller', N'R', N'1992', N'After a simple jewelery heist goes terribly wrong, the surviving criminals begin to suspect that one of them is a police informant.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (449, N'Tangents', N'Sci-Fi', N'PG-13', N'1994', N'An inventor comes up with a time machine, but must prevent its abuse at the hands of an evil C.E.O.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (450, N'The Intouchables', N'Biography, Comedy, Drama', N'R', N'2011', N'After he becomes a quadriplegic from a paragliding accident, an aristocrat hires a young man from the projects to be his caretaker.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (451, N'Wedding Crashers', N'Comedy, Romance', N'R', N'2005', N'John Beckwith and Jeremy Grey, a pair of committed womanizers who sneak into weddings to take advantage of the romantic tinge in the air, find themselves at odds with one another when John meets and falls for Claire Cleary.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (452, N'Atonement', N'Drama, Mystery, Romance', N'R', N'2007', N'Fledgling writer Briony Tallis, as a 13-year-old, irrevocably changes the course of several lives when she accuses her older sister''s lover of a crime he did not commit. Based on the British romance novel by Ian McEwan.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (453, N'The Butterfly Effect', N'Sci-Fi, Thriller', N'R', N'2004', N'A young man blocks out harmful memories of significant events of his life. As he grows up, he finds a way to remember these lost memories and a supernatural way to alter his life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (454, N'Schindler''s List', N'Biography, Drama, History', N'R', N'1993', N'In Poland during World War II, Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (455, N'The Passion of the Christ', N'Drama', N'R', N'2004', N'A film detailing the final hours and crucifixion of Jesus Christ.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (456, N'The Dark Knight', N'Action, Crime, Drama', N'PG-13', N'2008', N'When Batman, Gordon and Harvey Dent launch an assault on the mob, they let the clown out of the box, the Joker, bent on turning Gotham on itself and bringing any heroes down to his level.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (457, N'All Quiet on the Western Front', N'Drama, War', N'Unrated', N'1930', N'A young soldier faces profound disillusionment in the soul-destroying horror of World War I.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (458, N'North by Northwest', N'Action, Adventure, Mystery', N'Not Rated', N'1959', N'A hapless New York advertising executive is mistaken for a government agent by a group of foreign spies, and is pursued across the country while he looks for a way to survive.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (459, N'In the Heat of the Night', N'Crime, Drama, Mystery', N'Approved', N'1967', N'An African American police detective is asked to investigate a murder in a racially hostile southern town.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (460, N'The Exorcist', N'Horror', N'R', N'1973', N'When a teenage girl is possessed by a mysterious entity, her mother seeks the help of two priests to save her daughter.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (461, N'Some Like It Hot', N'Comedy', N'Not Rated', N'1959', N'When two musicians witness a mob hit, they flee the state in an all female band disguised as women, but further complications set in.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (462, N'Mortal Kombat', N'Action, Adventure, Fantasy', N'PG-13', N'1995', N'Three unknowing martial artists are summoned to a mysterious island to compete in a tournament whose outcome will decide the fate of the world.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (463, N'On the Waterfront', N'Crime, Drama', N'Not Rated', N'1954', N'An ex-prize fighter turned longshoreman struggles to stand up to his corrupt union bosses.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (464, N'Elevhemmet', N'Drama, Romance, Short', N'N/A', N'2003', N'In a typical school dorm two parties are colliding. One is the Hockey guys and their girls the other the drama students. As the night progresses one of the hockey guys deceides to shoot the...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (465, N'The Kids Are Alright', N'Documentary, Music', N'PG', N'1979', N'From the early black and white days to their colourful hedonistic era, you will Rock! See them at their most creative, and destructive, and experience The Who: Here!', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (466, N'Backdraft', N'Action, Crime, Drama', N'R', N'1991', N'Two Chicago firefighter brothers who don''t get along have to work together while a dangerous arsonist is on the loose.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (467, N'The Tony Blair Witch Project', N'Comedy', N'Unrated', N'2000', N'Told in Documentary form, the film depicts a group of five British film critics and politicians who venture off into the West Virginian wilderness in search of the "Tony Blair Witch" which ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (468, N'The Jacket', N'Drama, Mystery, Sci-Fi', N'R', N'2005', N'A Gulf war veteran is wrongly sent to a mental institution for insane criminals, where he becomes the object of a Doctor''s experiments, and his life is completely affected by them.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (469, N'It Happened One Night', N'Comedy, Romance', N'Unrated', N'1934', N'A spoiled heiress, running away from her family, is helped by a man who''s actually a reporter looking for a story.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (470, N'Star Trek: First Contact', N'Action, Adventure, Sci-Fi', N'PG-13', N'1996', N'Captain Picard and his crew pursue the Borg back in time to stop them from preventing Earth''s first contact with an alien species. They also make sure that Zefram Cochrane makes his famous maiden flight at warp speed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (471, N'The Apartment', N'Comedy, Drama, Romance', N'Approved', N'1960', N'A man tries to rise in his company by letting its executives use his apartment for trysts, but complications and a romance of his own ensue.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (472, N'Pilot', N'Crime, Drama, Mystery', N'Unrated', N'1990', N'An eccentric, mystical FBI agent arrives in the small Pacific Northwest town of Twin Peaks to investigate the murder of a young high school girl.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (473, N'Track of the Moon Beast', N'Horror, Sci-Fi', N'PG', N'1976', N'A young man is transformed into a hideous "moon beast" due to a meteor fragment lodged in his body.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (474, N'The Pianist', N'Biography, Drama, War', N'R', N'2002', N'A Polish Jewish musician struggles to survive the destruction of the Warsaw ghetto of World War II.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (475, N'Das Boot', N'Action, Adventure, Drama', N'R', N'1981', N'The claustrophobic world of a WWII German U-boat; boredom, filth, and sheer terror.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (476, N'Full Metal Jacket', N'Drama, War', N'R', N'1987', N'A pragmatic U.S. Marine observes the dehumanizing effects the U.S.-Vietnam War has on his fellow recruits from their brutal boot camp training to the bloody street fighting in Hue.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (477, N'Laserblast', N'Sci-Fi', N'PG', N'1978', N'A teenager stumbles upon an alien weapon, which transform him into a grotesque killer.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (478, N'One Flew Over the Cuckoo''s Nest', N'Drama', N'R', N'1975', N'Upon admittance to a mental institution, a brash rebel rallies the patients to take on the oppressive head nurse.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (479, N'The Killings at Badger''s Drift', N'Crime, Drama, Mystery', N'N/A', N'1997', N'An elderly woman is found dead in her cottage and DCI Barnaby is convinced the death is not down to natural causes.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (480, N'Billy Elliot', N'Comedy, Drama, Music', N'PG-13', N'2000', N'A talented young boy becomes torn between his unexpected love of dance and the disintegration of his family.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (481, N'Zaat', N'Fantasy, Sci-Fi', N'PG', N'1971', N'A mad scientist transforms himself into an aquatic killer.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (482, N'Match Point', N'Drama, Romance', N'R', N'2005', N'At a turning point in his life, a former tennis pro falls for a femme-fatal type who happens to be dating his friend and soon-to-be brother-in-law.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (483, N'Heat', N'Action, Crime, Drama', N'R', N'1995', N'A group of professional bank robbers start to feel the heat from police when they unknowingly leave a clue at their latest heist.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (484, N'Once Upon a Time in the West', N'Western', N'PG-13', N'1968', N'Epic story of a mysterious stranger with a harmonica who joins forces with a notorious desperado to protect a beautiful widow from a ruthless assassin working for the railroad.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (485, N'Braveheart', N'Action, Biography, Drama', N'R', N'1995', N'When his secret bride is executed for assaulting an English soldier who tried to rape her, a commoner begins a revolt and leads Scottish warriors against the cruel English tyrant who rules Scotland with an iron fist.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (486, N'The Artist', N'Comedy, Drama, Romance', N'PG-13', N'2011', N'A silent movie star meets a young dancer, but the arrival of talking pictures sends their careers in opposite directions.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (487, N'It''s Pat', N'Comedy', N'PG-13', N'1994', N'The comedic misadventures of a person of indeterminable gender.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (488, N'Beauty and the Beast', N'Animation, Family, Fantasy', N'G', N'1991', N'Belle, whose father is imprisoned by the Beast, offers herself instead and discovers her captor to be an enchanted prince.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (489, N'The Hunt', N'Drama', N'R', N'2012', N'A teacher lives a lonely life, all the while struggling over his son''s custody. His life slowly gets better as he finds love and receives good news from his son, but his new luck is about to be brutally shattered by an innocent little lie.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (490, N'Wall Street', N'Crime, Drama', N'R', N'1987', N'A young and impatient stockbroker is willing to do anything to get to the top, including trading on illegal inside information taken through a ruthless and greedy corporate raider who takes the youth under his wing.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (491, N'Nosferatu', N'Horror', N'Unrated', N'1922', N'Vampire Count Orlok expresses interest in a new residence and real estate agent Hutter''s wife. Silent classic based on the story "Dracula."', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (492, N'American Ninja V', N'Action', N'PG-13', N'1993', N'When a scientists daughter is kidnapped, American Ninja (David Bradley), attempts to find her, but this time he teams up with a youngster he has trained in the ways of the ninja.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (493, N'Apocalypse Now', N'Drama, War', N'R', N'1979', N'During the U.S.-Viet Nam War, Captain Willard is sent on a dangerous mission into Cambodia to assassinate a renegade colonel who has set himself up as a god among a local tribe.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (494, N'The Truman Show', N'Comedy, Drama, Sci-Fi', N'PG', N'1998', N'An insurance salesman/adjuster discovers his entire life is actually a T.V. show.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (495, N'The Day After Tomorrow', N'Action, Adventure, Sci-Fi', N'PG-13', N'2004', N'Jack Hall, paleoclimatologist, must make a daring trek across America to reach his son, trapped in the cross-hairs of a sudden international storm which plunges the planet into a new Ice Age.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (496, N'Rear Window', N'Mystery, Thriller', N'Approved', N'1954', N'A wheelchair bound photographer spies on his neighbours from his apartment window and becomes convinced one of them has committed murder.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (497, N'The Last Picture Show', N'Drama', N'R', N'1971', N'A group of 1950s high schoolers come of age in a bleak, isolated, atrophied West Texas town that is slowly dying, both economically and culturally.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (498, N'Among the Few', N'Crime, Drama, Mystery', N'N/A', N'2003', N'Sam volunteers to go undercover to discover how rationed gasoline is being stolen from a fuel depot, and Andrew becomes a suspect in a murder case.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (499, N'American History X', N'Crime, Drama', N'R', N'1998', N'A former neo-nazi skinhead tries to prevent his younger brother from going down the same wrong path that he did.', 2.0000, N'')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (500, N'In the Mix', N'Comedy, Crime, Drama', N'PG-13', N'2005', N'A successful DJ manages to rescue a powerful mobster one night. In order to repay him, the mobster gives him the task of protecting his daughter.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (501, N'The Matrix', N'Action, Sci-Fi', N'R', N'1999', N'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (502, N'Mary and Max', N'Animation, Comedy, Drama', N'Not Rated', N'2009', N'A tale of friendship between two unlikely pen pals: Mary, a lonely, eight-year-old girl living in the suburbs of Melbourne, and Max, a forty-four-year old, severely obese man living in New York.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (503, N'2001: A Space Odyssey', N'Adventure, Mystery, Sci-Fi', N'G', N'1968', N'Humanity finds a mysterious, obviously artificial, object buried beneath the Lunar surface and, with the intelligent computer H.A.L. 9000, sets off on a quest.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (504, N'Grand Theft Auto: Vice City', N'Action, Comedy, Crime', N'N/A', N'2002', N'After being released from jail, Tommy Vercetti left Liberty City for Vice City--a city overrun by the mob. Now, Tommy is out to make the Vice City his home.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (505, N'Oldboy', N'Drama, Mystery, Thriller', N'R', N'2003', N'After being kidnapped and imprisoned for 15 years, Oh Dae-Su is released, only to find that he must find his captor in 5 days.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (506, N'Paths of Glory', N'Drama, War', N'Approved', N'1957', N'When soldiers in World War I refuse to continue with an impossible attack, their superior officers decide to make an example of them.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (507, N'Zero Dark Thirty', N'Drama, History, Thriller', N'R', N'2012', N'A chronicle of the decade-long hunt for al-Qaeda terrorist leader Osama bin Laden after the September 2001 attacks, and his death at the hands of the Navy S.E.A.L. Team 6 in May 2011.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (508, N'Spirited Away', N'Animation, Adventure, Family', N'PG', N'2001', N'In the middle of her family''s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and monsters; where humans are changed into animals; and a bathhouse for these creatures.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (509, N'Dark City', N'Mystery, Sci-Fi', N'R', N'1998', N'A man struggles with memories of his past, including a wife he cannot remember, in a nightmarish world with no sun and run by beings with telekinetic powers who seek the souls of humans.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (510, N'From Justin to Kelly', N'Comedy, Musical, Romance', N'PG', N'2003', N'A waitress from Texas and a college student from Pennsylvania meet during spring break in Fort Lauderdale, Florida and come together through their shared love of singing.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (511, N'Harvey', N'Comedy, Drama', N'Not Rated', N'1950', N'Because of his insistence that his companion is an invisible six-foot rabbit, a whimsical middle-aged man is thought by his family to be insane - but the man might be wiser than anyone knows.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (512, N'Groundhog Day', N'Comedy, Drama, Fantasy', N'PG', N'1993', N'A weatherman finds himself living the same day over and over again.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (513, N'Independence Day', N'Action, Adventure, Drama', N'PG-13', N'1996', N'The aliens are coming and their goal is to invade and destroy. Fighting superior technology, Man''s best weapon is the will to survive.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (514, N'Snowboard Academy', N'Comedy, Sport', N'PG', N'1996', N'A wacky free-for-all comedy about the riotous rivalry between snobby skiers and knuckle-dragging snowboarders.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (515, N'The Longest Day', N'Action, Drama, History', N'G', N'1962', N'The events of D-Day, told on a grand scale from both the Allied and German points of view.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (516, N'The Holiday', N'Comedy, Romance', N'PG-13', N'2006', N'Two women troubled with guy-problems swap homes in each other''s countries, where they each meet a local guy and fall in love.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (517, N'Roman Holiday', N'Comedy, Drama, Romance', N'Not Rated', N'1953', N'A bored and sheltered princess escapes her guardians and falls in love with an American newsman in Rome.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (518, N'Terminator 2: Judgment Day', N'Action, Sci-Fi, Thriller', N'R', N'1991', N'A cyborg, identical to the one who failed to kill Sarah Connor, must now protect her teenage son, John, from a more advanced cyborg, made out of liquid metal.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (519, N'Killing Me Softly', N'Drama, Mystery, Romance', N'R', N'2002', N'A woman faces deadly consequences for abandoning her loving relationship with her boyfriend to pursue exciting sexual scenarios with a mysterious celebrity mountaineer.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (520, N'There''s Something About Mary', N'Comedy, Romance', N'R', N'1998', N'A man gets a chance to meet up with his dream girl from highschool, even though his date with her back then was a complete disaster.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (521, N'Million Dollar Baby', N'Drama, Sport', N'PG-13', N'2004', N'A determined woman works with a hardened boxing trainer to become a professional.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (522, N'About a Boy', N'Comedy, Drama, Romance', N'PG-13', N'2002', N'Based on Nick Hornby''s best-selling novel, About A Boy is the story of a cynical, immature young man who is taught how to act like a grown-up by a little boy', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (523, N'The Hobbit: An Unexpected Journey', N'Adventure, Fantasy', N'PG-13', N'2012', N'A reluctant hobbit, Bilbo Baggins, sets out to the Lonely Mountain with a spirited group of dwarves to reclaim their mountain home - and the gold within it - from the dragon Smaug.', 5.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (524, N'Toy Story', N'Animation, Adventure, Comedy', N'G', N'1995', N'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy''s room.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (525, N'The Diving Bell and the Butterfly', N'Biography, Drama', N'PG-13', N'2007', N'The true story of Elle editor Jean-Dominique Bauby who suffers a stroke and has to live with an almost totally paralyzed body; only his left eye isn''t paralyzed.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (526, N'Rosemary''s Baby', N'Drama, Horror, Mystery', N'R', N'1968', N'A young couple move into a new apartment, only to be surrounded by peculiar neighbors and occurrences. When the wife becomes mysteriously pregnant, paranoia over the safety of her unborn child begins controlling her life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (527, N'Freaky Friday', N'Comedy, Family, Fantasy', N'PG', N'2003', N'An overworked mother and her daughter do not get along. When they switch bodies, each is forced to adapt to the others life for one freaky Friday.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (528, N'American Beauty', N'Drama', N'R', N'1999', N'Lester Burnham, a depressed suburban father in a mid-life crisis, decides to turn his hectic life around after developing an infatuation for his daughter''s attractive friend.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (529, N'Troy', N'Adventure, Drama', N'R', N'2004', N'An adaptation of Homer''s great epic, the film follows the assault on Troy by the united Greek forces and chronicles the fates of the men involved.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (530, N'Space Mutiny', N'Action, Adventure, Romance', N'R', N'1988', N'A pilot is the only hope to stop the mutiny of a spacecraft by its security crew, who plot to sell the crew of the ship into slavery.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (531, N'The Good, the Bad and the Ugly', N'Adventure, Western', N'Approved', N'1966', N'A bounty hunting scam joins two men in an uneasy alliance against a third in a race to find a fortune in gold buried in a remote cemetery.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (532, N'Anus Magillicutty', N'Comedy, Romance', N'Not Rated', N'2003', N'When Anus Magillicutty''s woman stops a would-be assassin, Anus is forced to interrupt his life of guzzling beer and women to dispose of the corpse. What starts as a simple chore quickly ...', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (533, N'Nowhere Boy', N'Biography, Drama, Music', N'R', N'2009', N'A chronicle of John Lennon''s first years, focused mainly in his adolescence and his relationship with his stern aunt Mimi, who raised him, and his absentee mother Julia, who re-entered his life at a crucial moment in his young life.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (534, N'Double Indemnity', N'Crime, Drama, Film-Noir', N'N/A', N'1944', N'An insurance rep lets himself be talked into a murder/insurance fraud scheme that arouses an insurance investigator''s suspicions.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (535, N'Rocky', N'Drama, Sport', N'PG', N'1976', N'Rocky Balboa, a small-time boxer gets a supremely rare chance to fight the heavy-weight champion, Apollo Creed, in a bout in which he strives to go the distance for his self-respect.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (536, N'Sin City', N'Crime, Mystery, Thriller', N'R', N'2005', N'A film that explores the dark and miserable town, Basin City, and tells the story of three different people, all caught up in violent corruption.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (537, N'The Wizard of Oz', N'Adventure, Family, Fantasy', N'PG', N'1939', N'Dorothy Gale is swept away to a magical land in a tornado and embarks on a quest to see the Wizard who can help her return home.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (538, N'Simon Sez', N'Action, Comedy', N'PG-13', N'1999', N'Basketball superstar Dennis Rodman stars as a hip Interpol agent attempting to defeat the deadly plans of a crazed arms dealer.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (539, N'The Hillz', N'Crime, Drama', N'R', N'2004', N'A promising college athlete takes a turn for the worse when he hooks up with old highschool friends during his summer break.', 2.0000, N'')
INSERT [dbo].[Movies] ([MovieID], [Title], [Genre], [Rating], [Year], [Plot], [Rental_Cost], [Copies]) VALUES (540, N'up', N'Animation, Adventure, Drama', N'PG', N'2009', N'By tying thousands of balloons to his home, 78-year-old Carl sets out to fulfill his lifelong dream to see the wilds of South America. Russell, a wilderness explorer 70 years younger, inadvertently becomes a stowaway.', 2.0000, N'2')
SET IDENTITY_INSERT [dbo].[Movies] OFF
GO
SET IDENTITY_INSERT [dbo].[RentedMovies] ON 

INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (1, 356, 1, CAST(N'2014-04-09T11:11:38.793' AS DateTime), CAST(N'2014-04-09T15:30:03.447' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (2, 322, 1, CAST(N'2014-04-09T11:14:42.367' AS DateTime), CAST(N'2014-04-09T15:30:10.383' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (3, 503, 1, CAST(N'2014-04-09T11:18:31.327' AS DateTime), CAST(N'2014-04-09T15:34:26.067' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (4, 447, 1, CAST(N'2014-04-09T11:21:56.943' AS DateTime), CAST(N'2014-04-10T15:36:32.740' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (5, 76, 1, CAST(N'2014-04-09T11:44:33.877' AS DateTime), CAST(N'2014-04-11T10:49:33.767' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (6, 503, 1, CAST(N'2014-04-09T11:55:06.583' AS DateTime), CAST(N'2014-04-11T10:50:03.760' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (7, 294, 1, CAST(N'2014-04-09T13:25:06.557' AS DateTime), CAST(N'2014-04-14T09:54:41.210' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (8, 503, 1, CAST(N'2014-04-09T13:25:21.093' AS DateTime), CAST(N'2014-04-14T10:04:19.697' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (9, 69, 5, CAST(N'2014-04-10T15:27:32.157' AS DateTime), CAST(N'2014-04-10T15:27:44.740' AS DateTime))
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (10, 1, 10, CAST(N'2014-04-10T15:34:54.463' AS DateTime), NULL)
INSERT [dbo].[RentedMovies] ([RMID], [MovieIDFK], [CustIDFK], [DateRented], [DateReturned]) VALUES (11, 8, 5, CAST(N'2014-04-14T09:53:50.243' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[RentedMovies] OFF
GO
ALTER TABLE [dbo].[RentedMovies]  WITH CHECK ADD  CONSTRAINT [FK1] FOREIGN KEY([MovieIDFK])
REFERENCES [dbo].[Movies] ([MovieID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RentedMovies] CHECK CONSTRAINT [FK1]
GO
ALTER TABLE [dbo].[RentedMovies]  WITH CHECK ADD  CONSTRAINT [FK2] FOREIGN KEY([CustIDFK])
REFERENCES [dbo].[Customer] ([CustID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RentedMovies] CHECK CONSTRAINT [FK2]
GO
/****** Object:  StoredProcedure [dbo].[GetAll]    Script Date: 19/2/2021 12:34:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAll]
    @ID int
AS
SET NOCOUNT ON;
SELECT * FROM Customer WHERE CustID = @ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customer"
            Begin Extent = 
               Top = 123
               Left = 488
               Bottom = 253
               Right = 658
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 86
               Bottom = 208
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomersAndMoviesRented'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomersAndMoviesRented'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Movies"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 148
               Right = 405
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomersAndMoviesRented"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 2295
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MostRentedMovies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MostRentedMovies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "RentedMovies"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 136
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1125
         Width = 1125
         Width = 1305
         Width = 1035
         Width = 2295
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 11580
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TopCustomers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TopCustomers'
GO
