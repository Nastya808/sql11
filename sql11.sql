CREATE TABLE [Files] (
    [Id] INT IDENTITY PRIMARY KEY,
    [FileName] NVARCHAR(50),
    [ParentFolderID] INT
);

INSERT INTO Files VALUES ('FolderA', NULL),
('File1.txt', 1), ('File2.txt', 1), ('FolderB', NULL),
('File3.txt', 4), ('File4.txt', 4), ('FolderC', NULL),
('File5.txt', 7);

WITH RecursiveFilesCTE AS (
    SELECT 
        [Id],
        [FileName],
        [ParentFolderID],
        0 AS [Level]
    FROM 
        [Files]
    WHERE 
        [ParentFolderID] IS NULL

    UNION ALL

    SELECT 
        F.[Id],
        F.[FileName],
        F.[ParentFolderID],
        R.[Level] + 1 AS [Level]
    FROM 
        [Files] F
    INNER JOIN 
        RecursiveFilesCTE R ON F.[ParentFolderID] = R.[Id]
)

SELECT 
    [Id],
    [FileName],
    [ParentFolderID],
    [Level]
FROM 
    RecursiveFilesCTE
ORDER BY 
    [Level], [Id];
