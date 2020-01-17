DECLARE @AsOf DATE
SET @AsOf = '1/1/2019'

DECLARE @PublishedReservingTool TABLE(
	ClaimNumber VarChar(30)
	, LastPublishDate DATETIME
)

DECLARE @AssignedDateLog TABLE(
	PK INT 
	, ExaminerAssignedDate DATETIME
)