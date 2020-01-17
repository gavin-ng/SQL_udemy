SELECT C.ClaimNumber, 
	U.LastFirstName AS ExaminerName, U.Title AS ExaminerTitle, U.UserName as ExaminerUser,
	U.ReserveLimit,
	U2.LastFirstName AS SupervisorName, U2.Title AS SupervisorTitle, U2.UserName as SupervisorUser,
	U3.LastFirstName AS ManagerName, U3.Title AS ManagerTitle, U3.UserName as ManagerUser,
	O.OfficeDesc, O.State,
	Cmt.ReopenedDate, CT.ClaimantTypeDesc,
	CS.ClaimStatusDesc,
	P.FirstName, P.MiddleName, P.LastName,
	R.ReserveAmount,
	(CASE 
	WHEN RT.ParentID IN (1,2,3,4,5) THEN RT.ParentID
	ELSE RT.reserveTypeID
	END) AS ReserveCostID
FROM Claim C
LEFT JOIN Users U ON C.ExaminerCode = U.UserName
LEFT JOIN Users U2 ON U.Supervisor = U2.UserName
LEFT JOIN Users U3 ON U2.Supervisor = U3.UserName
LEFT JOIN Office O ON O.OfficeID = U.OfficeID
LEFT JOIN Claimant Cmt ON C.ClaimID = Cmt.ClaimID
LEFT JOIN ClaimantType CT ON Cmt.ClaimantTypeID = CT.ClaimantTypeID
LEFT JOIN ClaimStatus CS ON Cmt.claimStatusID = CS.ClaimStatusID
LEFT JOIN Patient P ON P.PatientID = Cmt.PatientID
LEFT JOIN Reserve R ON R.ClaimantID = Cmt.ClaimantID
LEFT JOIN ReserveType RT ON RT.reserveTypeID = R.ReserveTypeID
--LEFT JOIN ReserveType RT ON RT.reserveTypeID = R.ReserveTypeID AND RT.ReserveTypeCode != 'Expense'
--LEFT JOIN ReserveType RT2 ON RT2.reserveTypeID = RT.ParentID AND RT2.ReserveTypeDesc != 'Expense'
WHERE O.OfficeDesc IN ('Sacramento', 'San Diego', 'San Francisco') 
	AND (CS.ClaimStatusID = 1 OR (CS.ClaimStatusID = 2 AND Cmt.ReopenedReasonID !=3))
	AND (RT.ParentID IN (1,2,3,4,5) OR RT.reserveTypeID IN (1,2,3,4,5))

