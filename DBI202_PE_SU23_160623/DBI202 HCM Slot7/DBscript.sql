
if DB_ID('SaleMNG') is not null
	DROP DATABASE SaleMNG

create database SaleMNG
GO
use SaleMNG
GO
create table tblSuppliers(
	supcode nchar(2) primary key,
	supname nvarchar(30),
	address nvarchar(100),
	phone nvarchar(15)
	
)
GO
create table tblInvoices(
	invid nchar(6) primary key,
	invdate date,
	customer nvarchar(30),
	employeeid nchar(4),
	
)
GO
create table tblProducts(
	proid nchar(6) primary key,
	proname nvarchar(70),
	unit nvarchar(10),
	supcode nchar(2),
	FOREIGN KEY (supcode) REFERENCES tblSuppliers(supcode)
	)
GO
create table tblInv_Detail(
	invid nchar(6) NOT NULL,
	proid nchar(6) NOT NULL,
	quantity int,
	price int,
	primary key(invid,proid),
	FOREIGN KEY (invid) REFERENCES tblInvoices(invid),
	FOREIGN KEY (proid) REFERENCES tblProducts(proid)

)

GO

INSERT [dbo].[tblInvoices] ([invid], [invdate], [customer], [employeeid]) VALUES (N'000001', CAST(N'2022-06-12' AS Date), N'Trần Khánh Minh', N'S001')
INSERT [dbo].[tblInvoices] ([invid], [invdate], [customer], [employeeid]) VALUES (N'000002', CAST(N'2022-06-26' AS Date), N'Lê Thanh Tùng', N'S001')
INSERT [dbo].[tblInvoices] ([invid], [invdate], [customer], [employeeid]) VALUES (N'000003', CAST(N'2022-07-04' AS Date), N'Nguyễn Văn Bình', N'S002')
INSERT [dbo].[tblInvoices] ([invid], [invdate], [customer], [employeeid]) VALUES (N'000004', CAST(N'2022-08-10' AS Date), N'Phạm Chí Trung', N'S003')
INSERT [dbo].[tblInvoices] ([invid], [invdate], [customer], [employeeid]) VALUES (N'000005', CAST(N'2022-09-16' AS Date), N'Nguyễn Hoàng Hà', N'S001')
INSERT [dbo].[tblInvoices] ([invid], [invdate], [customer], [employeeid]) VALUES (N'000006', CAST(N'2022-10-10' AS Date), N'Lê Minh phương', N'S003')


INSERT [dbo].[tblSuppliers] ([supcode], [supname], [address], [phone]) VALUES (N'HT', N'Hoàng Tuấn', N'24/7 Lý Chính Thắng Q3 TPHCM', N'0971234568')
INSERT [dbo].[tblSuppliers] ([supcode], [supname], [address], [phone]) VALUES (N'HV', N'Hoàn Vũ', N'20/5 Trần Hưng Đạo Q5 TPHCM', N'0936549980')
INSERT [dbo].[tblSuppliers] ([supcode], [supname], [address], [phone]) VALUES (N'MT', N'Minh Thông', N'100 Nguyễn Thị Minh Khai Q1 TPHCM', N'0987456320')

INSERT [dbo].[tblProducts] ([proid], [proname], [unit], [supcode]) VALUES (N'BAVTVP', N'Bàn Vi Tính Văn Phòng', N'Cái', N'MT')
INSERT [dbo].[tblProducts] ([proid], [proname], [unit], [supcode]) VALUES (N'CAMVP ', N'Camera Ezviz C6N 1080P ', N'Chiếc', N'HV')
INSERT [dbo].[tblProducts] ([proid], [proname], [unit], [supcode]) VALUES (N'DDRAM4', N'Ram Laptop Crucial DDR4 16GB 3200MHz ', N'Thanh', N'HV')
INSERT [dbo].[tblProducts] ([proid], [proname], [unit], [supcode]) VALUES (N'GLVP01', N'Ghế Lưới Xoay Văn Phòng', N'Cái', N'MT')
INSERT [dbo].[tblProducts] ([proid], [proname], [unit], [supcode]) VALUES (N'RTPL02', N'Router Wifi Chuẩn Wifi 6 AX5400 TP-Link Archer AX73', N'Chiếc', N'HV')


INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000001', N'BAVTVP', 5, 750000)
INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000001', N'GLVP01', 2, 400000)
INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000002', N'CAMVP ', 4, 820000)
INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000002', N'RTPL02', 2, 2400000)
INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000003', N'BAVTVP', 2, 700000)
INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000004', N'RTPL02', 1, 2300000)
INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000005', N'CAMVP ', 6, 800000)
INSERT [dbo].[tblInv_Detail] ([invid], [proid], [quantity], [price]) VALUES (N'000005', N'RTPL02', 3, 2300000)

