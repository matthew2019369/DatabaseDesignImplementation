/* Question 3-DDL Scripts */
-- MySQL Script generated by MySQL Workbench
-- Wed Sep 12 16:34:03 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema 45282188
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 45282188
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `45282188` DEFAULT CHARACTER SET utf8 ;
USE `45282188` ;

-- -----------------------------------------------------
-- Table `45282188`.`Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Branch` (
  `BranchBSB` INT(6) NOT NULL,
  `BranchName` VARCHAR(45) NULL,
  `BranchAdd` VARCHAR(45) NULL,
  `BranchPhoneNo` VARCHAR(20) NULL,
  PRIMARY KEY (`BranchBSB`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Customer` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(45) NULL,
  `CustomerAdd` VARCHAR(45) NULL,
  `CustomerContactNo` VARCHAR(15) NULL,
  `CustomerEmailAdd` VARCHAR(45) NULL,
  `CustomerJoinDate` DATE NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`ATM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`ATM` (
  `ATMID` INT NOT NULL,
  `ATMLoc` VARCHAR(45) NULL,
  `ATMOpenHour` VARCHAR(45) NULL,
  `ATMMaxCashCap` DECIMAL(6,2) NULL,
  `Branch_BranchBSB` INT(6) NULL,
  PRIMARY KEY (`ATMID`),
  INDEX `fk_ATM_Branch1_idx` (`Branch_BranchBSB` ASC),
  CONSTRAINT `fk_ATM_Branch1`
    FOREIGN KEY (`Branch_BranchBSB`)
    REFERENCES `45282188`.`Branch` (`BranchBSB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Department` (
  `DepartmentID` INT NOT NULL,
  `DepartmentName` VARCHAR(45) NULL,
  `DepartmentOfficeLoc` VARCHAR(45) NULL,
  PRIMARY KEY (`DepartmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`AccountType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`AccountType` (
  `AccountTypeID` INT NOT NULL,
  `AccountTypeName` VARCHAR(45) NULL,
  `AccountTypeDesc` VARCHAR(45) NULL,
  `AccountTypeInterestRate` DECIMAL(5,2) NULL,
  `AccountTypeYearlyServiceFee` DECIMAL(10,2) NULL,
  PRIMARY KEY (`AccountTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Account` (
  `AccountNo` INT(8) NOT NULL,
  `AccountBalance` DECIMAL(13,2) NULL,
  `Branch_BranchBSB` INT(6) NOT NULL,
  `AccountType_AccountTypeID` INT NOT NULL,
  PRIMARY KEY (`AccountNo`, `Branch_BranchBSB`),
  INDEX `fk_Account_Branch1_idx` (`Branch_BranchBSB` ASC),
  INDEX `fk_Account_AccountType1_idx` (`AccountType_AccountTypeID` ASC),
  CONSTRAINT `fk_Account_Branch1`
    FOREIGN KEY (`Branch_BranchBSB`)
    REFERENCES `45282188`.`Branch` (`BranchBSB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Account_AccountType1`
    FOREIGN KEY (`AccountType_AccountTypeID`)
    REFERENCES `45282188`.`AccountType` (`AccountTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Registration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Registration` (
  `Account_AccountNo` INT(8) NOT NULL,
  `Account_Branch_BranchBSB` INT(6) NOT NULL,
  `Customer_CustomerID` INT NOT NULL,
  PRIMARY KEY (`Account_AccountNo`, `Account_Branch_BranchBSB`, `Customer_CustomerID`),
  INDEX `fk_Account_has_Customer_Customer1_idx` (`Customer_CustomerID` ASC),
  INDEX `fk_Account_has_Customer_Account1_idx` (`Account_AccountNo` ASC, `Account_Branch_BranchBSB` ASC),
  CONSTRAINT `fk_Account_has_Customer_Account1`
    FOREIGN KEY (`Account_AccountNo` , `Account_Branch_BranchBSB`)
    REFERENCES `45282188`.`Account` (`AccountNo` , `Branch_BranchBSB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Account_has_Customer_Customer1`
    FOREIGN KEY (`Customer_CustomerID`)
    REFERENCES `45282188`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`DebitCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`DebitCard` (
  `DebitCardNo` INT NOT NULL,
  `DebitCardExpiryDate` DATE NULL,
  `DebitCardCVV` INT(3) NULL,
  `DebitCardPIN` INT(4) NULL,
  `Registration_Account_AccountNo` INT(8) NOT NULL,
  `Registration_Account_Branch_BranchBSB` INT(6) NOT NULL,
  `Registration_Customer_CustomerID` INT NOT NULL,
  PRIMARY KEY (`DebitCardNo`),
  INDEX `fk_DebitCard_Registration1_idx` (`Registration_Account_AccountNo` ASC, `Registration_Account_Branch_BranchBSB` ASC, `Registration_Customer_CustomerID` ASC),
  CONSTRAINT `fk_DebitCard_Registration1`
    FOREIGN KEY (`Registration_Account_AccountNo` , `Registration_Account_Branch_BranchBSB` , `Registration_Customer_CustomerID`)
    REFERENCES `45282188`.`Registration` (`Account_AccountNo` , `Account_Branch_BranchBSB` , `Customer_CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Withdrawal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Withdrawal` (
  `WithdrawalID` INT NOT NULL,
  `WithdrawalTime` TIME NULL,
  `WithdrawalAmt` DECIMAL(6,2) NULL,
  `WithdrawalDate` DATE NULL,
  `ATM_ATMID` INT NOT NULL,
  `DebitCard_DebitCardNo` INT NOT NULL,
  PRIMARY KEY (`WithdrawalID`, `ATM_ATMID`),
  INDEX `fk_Withdrawal_ATM1_idx` (`ATM_ATMID` ASC),
  INDEX `fk_Withdrawal_DebitCard1_idx` (`DebitCard_DebitCardNo` ASC),
  CONSTRAINT `fk_Withdrawal_ATM1`
    FOREIGN KEY (`ATM_ATMID`)
    REFERENCES `45282188`.`ATM` (`ATMID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Withdrawal_DebitCard1`
    FOREIGN KEY (`DebitCard_DebitCardNo`)
    REFERENCES `45282188`.`DebitCard` (`DebitCardNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Employee` (
  `EmployeeID` INT NOT NULL,
  `EmployeeName` VARCHAR(45) NULL,
  `EmployeeAdd` VARCHAR(45) NULL,
  `EmployeePhoneNo` VARCHAR(20) NULL,
  `EmployeePosition` VARCHAR(45) NULL,
  `EmployeeAnnualSalary` DECIMAL(13,2) NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`LoanType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`LoanType` (
  `LoanTypeID` INT NOT NULL,
  `LoanTypeName` VARCHAR(45) NULL,
  `LoanTypeDesc` VARCHAR(45) NULL,
  PRIMARY KEY (`LoanTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Loan` (
  `LoanID` INT NOT NULL,
  `LoanInterestRate` DECIMAL(5,2) NULL,
  `LoanTotalAmt` DECIMAL(13,2) NULL,
  `LoanOutstandingBal` DECIMAL(13,2) NULL,
  `LoanType_LoanTypeID` INT NOT NULL,
  `Account_AccountNo` INT(8) NOT NULL,
  `Account_Branch_BranchBSB` INT(6) NOT NULL,
  PRIMARY KEY (`LoanID`),
  INDEX `fk_Loan_LoanType1_idx` (`LoanType_LoanTypeID` ASC),
  INDEX `fk_Loan_Account1_idx` (`Account_AccountNo` ASC, `Account_Branch_BranchBSB` ASC),
  CONSTRAINT `fk_Loan_LoanType1`
    FOREIGN KEY (`LoanType_LoanTypeID`)
    REFERENCES `45282188`.`LoanType` (`LoanTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loan_Account1`
    FOREIGN KEY (`Account_AccountNo` , `Account_Branch_BranchBSB`)
    REFERENCES `45282188`.`Account` (`AccountNo` , `Branch_BranchBSB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`Repayment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`Repayment` (
  `RepaymentNo` INT NOT NULL,
  `RepaymentAmt` DECIMAL(20,2) NULL,
  `RepaymentDate` DATE NULL,
  `RepaymentTime` TIME NULL,
  `Loan_LoanID` INT NOT NULL,
  `Employee_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`RepaymentNo`, `Loan_LoanID`),
  INDEX `fk_Repayment_Loan1_idx` (`Loan_LoanID` ASC),
  INDEX `fk_Repayment_Employee1_idx` (`Employee_EmployeeID` ASC),
  CONSTRAINT `fk_Repayment_Loan1`
    FOREIGN KEY (`Loan_LoanID`)
    REFERENCES `45282188`.`Loan` (`LoanID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Repayment_Employee1`
    FOREIGN KEY (`Employee_EmployeeID`)
    REFERENCES `45282188`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table `45282188`.`EmploymentRecord`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`EmploymentRecord` (
  `Department_DepartmentID` INT NOT NULL,
  `Employee_EmployeeID` INT NOT NULL,
  `Branch_BranchBSB` INT(6) NOT NULL,
  PRIMARY KEY (`Department_DepartmentID`, `Employee_EmployeeID`, `Branch_BranchBSB`),
  INDEX `fk_Department_has_Employee_Employee1_idx` (`Employee_EmployeeID` ASC),
  INDEX `fk_Department_has_Employee_Department1_idx` (`Department_DepartmentID` ASC),
  INDEX `fk_employment for employee_Branch1_idx` (`Branch_BranchBSB` ASC),
  CONSTRAINT `fk_Department_has_Employee_Department1`
    FOREIGN KEY (`Department_DepartmentID`)
    REFERENCES `45282188`.`Department` (`DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Department_has_Employee_Employee1`
    FOREIGN KEY (`Employee_EmployeeID`)
    REFERENCES `45282188`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employment for employee_Branch1`
    FOREIGN KEY (`Branch_BranchBSB`)
    REFERENCES `45282188`.`Branch` (`BranchBSB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45282188`.`ManagementRecord`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `45282188`.`ManagementRecord` (
  `Employee_EmployeeID` INT NOT NULL,
  `Department_DepartmentID` INT NOT NULL,
  `ManagementRecordStartDate` DATE NULL,
  `ManagementRecordEndDate` DATE NULL,
  `Branch_BranchBSB` INT(6) NOT NULL,
  PRIMARY KEY (`Employee_EmployeeID`, `Department_DepartmentID`, `Branch_BranchBSB`),
  INDEX `fk_Employee_has_Department_Department1_idx` (`Department_DepartmentID` ASC),
  INDEX `fk_Employee_has_Department_Employee2_idx` (`Employee_EmployeeID` ASC),
  INDEX `fk_manages_Branch2_idx` (`Branch_BranchBSB` ASC),
  CONSTRAINT `fk_Employee_has_Department_Employee2`
    FOREIGN KEY (`Employee_EmployeeID`)
    REFERENCES `45282188`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_Department_Department1`
    FOREIGN KEY (`Department_DepartmentID`)
    REFERENCES `45282188`.`Department` (`DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_manages_Branch2`
    FOREIGN KEY (`Branch_BranchBSB`)
    REFERENCES `45282188`.`Branch` (`BranchBSB`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* Question 4-DML Scripts */
insert  into `AccountType`(`AccountTypeID`,`AccountTypeName`,`AccountTypeDesc`,`AccountTypeInterestRate`,`AccountTypeYearlyServiceFee`) 
values 
(001,'SAV','Saving',5.00,50.00),
(002,'CHECK','Checking',6.00,80.00),
(003,'GOAL','Goal Saver',5.50,70.00),
(004,'IRA','Retirement',8.00,85.00),
(005,'LOAN','Loan',5.00,120.00),
(006,'JOINT','Joint Account',7.00,100.00);


insert  into `Customer`(`CustomerID`,`CustomerName`,`CustomerAdd`,`CustomerContactNo`,`CustomerEmailAdd`,`CustomerJoinDate`) 
values 
(0001,'Matthew Lee','11/22 CYBER ST STRATHFIELD','0433322112','matthewlee123@gmail.com','2007-03-15'),

(0002,'Mary Lam','21/12 HELLOWEEN ST BLACKTOWN','0435635678','marylam332@gmail.com','2006-09-12'),

(0003,'Jay Chou','12/22 TAIWAN ST BURWOOD','0563956745','jaychou213@gmail.com','2013-05-07'),

(0004,'Selina Tusi','01/09 BABY ST MACQUARIE PARK','0876567853','selinatusi3322@gmail.com','2017-11-12'),

(0005,'Ella Tam','11/09 WOOLWORTH ST MACQUARIE UNIVERSITY','0876567333','ellatam1444@gmail.com','2018-02-12'),

(0006,'Yvonne Lam','11/29 BABY ST HURSTVILLE','0876537853','yvonnelam2@gmail.com','2015-07-12');

insert  into `LoanType`(`LoanTypeID`,`LoanTypeName`,`LoanTypeDesc`) 
values
(1,'STU','student loan'),
(2,'MORT','mortgage loan'),
(3,'PL','personal loan'),
(4,'BUS','business loan'),
(5,'CAR','car loan');

insert into `Branch`(`BranchBSB`,`BranchName`,`BranchAdd`,`BranchPhoneNo`) 
values 
(123450,'Burwood','11/20 BURWOOD ST BURWOOD','24759655'),
(123451,'Strathfield','11/11 STRATHFIELD ST BURWOOD','29987775'),
(123452,'Rhodes','11/20 PARRAMATTA ST RHODES','29988775'),
(123453,'Parramatta','02/02 PARRAMATTA ST PARRAMATTA','21102201'),
(123454,'Epping','11/20 EPPING ST EPPING','29975555'),
(123455,'Eastwood','11/20 EASTWOOD ST EASTWOOD','24434433');

insert into `Employee`(`EmployeeID`,`EmployeeName`,`EmployeeAdd`,`EmployeePhoneNo`,`EmployeePosition`,`EmployeeAnnualSalary`) 
values
(001,'Lawerence Chung','11/22 STRATHFIELD ST STRATHFIELD','0556443454','SERVICE MANAGER',100000.00),
(002,'TsiTsi Tam','01/01 BURWOOD ST BURWOOD','0456456456','TELLER',55000.00),
(003,'Matthew Vi','10/02 EPPING ST EPPING','0444444322','TELLER',60000.00),
(004,'Michael Lee','10/02 EASTWOOD ST EASTWOOD','0111222334','LOAN ASSISTANT',59000.00),
(005,'Yvonne Ti','10/02 DENISTONE ST DENISTONE','01111112222','LOAN MANAGER',130000.00),
(006,'Fi Lee','07/02 WEST ST WESTLY','0333442253','TECHNICIAN MANAGER',80000.00),
(007,'Lilly Lee','10/12 ANGEL ST ANGEL','0321123321','Human Resource Manager',70000.00),
(008,'Rick Chung','11/02 TIME ST TIME','0890789789','TELLER',60000.00),
(009,'Chris Delgado','21/02 DREAM ST DREAM','0297986875','TELLER',65000.00),
(010,'Michael Yip','11/22 MALAYSIAN ST MA','0556443434','SERVICE MANAGER',100000.00);

insert into `Department`(`DepartmentID`,`DepartmentName`,`DepartmentOfficeLoc`) values 
(1,'Loan','1st floor'),
(2,'Customer Service','Ground floor'),
(3,'Information Technology','2rd floor'),
(4,'Human Resource','2rd floor');

insert into `ATM`(`ATMID`,`ATMLoc`,`ATMOpenHour`,`ATMMaxCashCap`,`Branch_BranchBSB`) 
values
(1,'Burwood','6:00',2000.00,123450),
(2,'Strathfield','6:00',2000.00,123451),
(3,'Rhodes','6:00',2000.00,123452),
(4,'Parramatta','6:00',2000.00,123453),
(5,'Epping','6:00',2000.00,123454),
(6,'Eastwood','6:00',2000.00,123455);

insert into `Account`(`AccountNo`,`AccountBalance`,`Branch_BranchBSB`,`AccountType_AccountTypeID`) values

(12345678,5000.00,123450,001),
(23456789,2000.00,123450,002),
(63456789,20000.00,123450,006),
(53456789,100050.20,123451,004),
(08080808,50000.00,123451,005),
(09980808,40000.00,123452,005),
(10080808,70000.00,123452,005);

insert into `Registration`(`Account_Branch_BranchBSB`,`Account_AccountNo`,`Customer_CustomerID`) 
values
(123450,12345678,001),
(123450,23456789,002),
(123451,53456789,005),
(123450,63456789,005),
(123450,63456789,006),
(123451,08080808,001),
(123452,09980808,002),
(123452,10080808,003);


insert into `DebitCard`(`DebitCardNo`,`DebitCardExpiryDate`,`DebitCardCVV`,`DebitCardPIN`,`Registration_Account_Branch_BranchBSB`,`Registration_Account_AccountNo`,`Registration_Customer_CustomerID`) 
values
(001,'2020-01-20',123,1234,123450,12345678,001),
(002,'2021-12-01',234,2341,123450,12345678,001),
(003,'2020-04-04',345,3451,123450,63456789,005), 
(004,'2020-05-11',456,4561,123450,63456789,006);

insert into `Withdrawal`(`WithdrawalID`,`WithdrawalTime`,`WithdrawalAmt`,`WithdrawalDate`,`DebitCard_DebitCardNo`,`ATM_ATMID`) 
values
(0001,'13:30:12',200.00,'2018-03-05',001,005),
(0002,'16:24:53',150.00,'2018-04-15',002,001),
(0003,'09:11:23',150.00,'2018-05-15',003,002),
(0004,'10:41:01',120.00,'2018-08-15',004,003),
(0005,'10:45:01',120.00,'2018-08-15',004,003);

insert into `Loan`(`LoanID`,`LoanInterestRate`,`LoanTotalAmt`,`LoanOutstandingBal`,`Account_Branch_BranchBSB`,`Account_AccountNo`,`LoanType_LoanTypeID`) values

(001,5.00,100000.00,5000.00,123451,08080808,1),
(002,5.00,150000.00,7500.00,123452,09980808,2),
(003,5.00,100000.00,5000.00,123452,10080808,3);


insert into `Repayment`(`RepaymentNo`,`RepaymentAmt`,`RepaymentDate`,`RepaymentTime`,`Employee_EmployeeID`,`Loan_LoanID`) values
(001,2000.00,'2018-03-03','13:13:12',004,001),
(002,3000.00,'2018-04-03','15:13:12',004,002),
(003,4000.00,'2018-05-03','13:15:12',004,003);


Insert into `EmploymentRecord`(`Department_DepartmentID`,`Employee_EmployeeID`,`Branch_BranchBSB`)values
(2,002,123450),
(2,003,123450),
(1,004,123450),
(2,008,123450),
(2,009,123450);

Insert into `ManagementRecord` (`Employee_EmployeeID`,`Department_DepartmentID`,`ManagementRecordStartDate`,`ManagementRecordEndDate`,`Branch_BranchBSB`)
values
(001,2,'2018-01-01','2019-01-01',123450),
(005,1,'2018-01-01','2019-01-01',123450),
(006,3,'2018-01-01','2019-01-01',123450),
(007,4,'2018-01-01','2019-01-01',123450),
(010,2,'2018-01-01','2019-01-01',123451);

/* Question 5-DQL Scripts */

select count(accountNo), AccountTypeName
from Account a, AccountType at
where a.AccountType_AccountTypeID=at.AccountTypeID
and AccountTypeName='JOINT'
group by AccountTypeName;

select a.AccountNo , a.Branch_BranchBSB
from Account a, Loan l
where a.AccountNo=l.Account_AccountNo and
a.Branch_BranchBSB = l.Account_Branch_BranchBSB and
l.LoanType_LoanTypeID in (select LoanTypeID from LoanType where LoanTypeName ='PL');

select e.EmployeeName, d.DepartmentName, b.BranchName
from Employee e, Department d, ManagementRecord mr, Branch b
where e.EmployeeID=mr.Employee_EmployeeID and 
d.DepartmentID= mr.Department_DepartmentID and 
b.BranchBSB= mr.Branch_BranchBSB;

select e.EmployeeName
from Employee e, ManagementRecord mr
where e.EmployeeID= mr.Employee_EmployeeID and
e.EmployeeAnnualSalary >( select avg(EmployeeAnnualSalary) 
from Employee e
where e.EmployeeID in (select Employee_EmployeeID from ManagementRecord));