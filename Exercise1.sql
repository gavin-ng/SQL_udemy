USE Insurance
GO

-- Query 1
SELECT ClaimantID, MAX(ReopenedDate) as ReopenedDate
FROM Claimant
GROUP BY ClaimantID

-- Query 2
SELECT PK, MAX(EntryDate) as ExaminerAssignedDate
FROM ClaimLog
WHERE FieldName = 'ExaminerCode'
GROUP BY PK


-- Query 3
SELECT ClaimNumber, MAX(EnteredOn) as LastDate
FROM ReservingTool
WHERE IsPublished = 1
GROUP BY ClaimNumber
