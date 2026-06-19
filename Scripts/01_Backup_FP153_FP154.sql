/* =========================================================
   BACKUP FP153 - 154
   PROYECTO MINSA - TRÁMITE 20
   FECHA: 2026-06-08
   ========================================================= */

USE [AuraPortal_BPMS_DES];
GO

-- 1. Backup completo familia 153
SELECT *
INTO [dbo].[BK_AP_Dyn_Familias_153_20260608]
FROM [dbo].[AP_Dyn_Familias_153];

-- 2. Backup completo familia 154
SELECT *
INTO [dbo].[BK_AP_Dyn_Familias_154_20260608]
FROM [dbo].[AP_Dyn_Familias_154];

-- 3. Backup relaciones actuales asociadas al trámite 20
SELECT rel.*
INTO [dbo].[BK_AP_FamilyRelational_Data_Tramite20_20260608]
FROM [dbo].[AP__FamilyRelational_Data] rel
INNER JOIN [dbo].[AP_Dyn_Familias_154] f154
    ON f154.ID = rel.ElementFamily2Id
WHERE rel.RelationId = 25
  AND f154.[1_VUI - Procesos/Name] = 20;

-----------------------------------------------------*/

SELECT COUNT(*) AS TotalBK153
FROM [dbo].[BK_AP_Dyn_Familias_153_20260608];

SELECT COUNT(*) AS TotalBK154
FROM [dbo].[BK_AP_Dyn_Familias_154_20260608];

SELECT COUNT(*) AS TotalBKRelacionesTramite20
FROM [dbo].[BK_AP_FamilyRelational_Data_Tramite20_20260608];

---------------------------------------------*/

SELECT 
    rel.ID,
    rel.RelationId,
    rel.ElementFamily1Id,
    f153.[1_Super usuario institucion/Name] AS Usuario153,
    rel.ElementFamily2Id,
    f154.[_Name] AS Rama154,
    f154.[3_Institución a la que pertenece],
    f154.[3_Nombre de cargo],
    f154.[1_VUI - Procesos/Name],
    f154.[2_VUI - Procesos/Nombre de proceso]
FROM [dbo].[BK_AP_FamilyRelational_Data_Tramite20_20260608] rel
LEFT JOIN [dbo].[AP_Dyn_Familias_153] f153
    ON f153.ID = rel.ElementFamily1Id
LEFT JOIN [dbo].[AP_Dyn_Familias_154] f154
    ON f154.ID = rel.ElementFamily2Id
ORDER BY rel.ElementFamily1Id, rel.ElementFamily2Id;


Esperado:

TotalBK153: 27 registros aprox.
TotalBK154: 731 registros aprox.
TotalBKRelacionesTramite20: depende de las relaciones actuales del trámite 20.


BK 153: 27
BK 154: 731
BK Relaciones trámite 20: 8


Son relaciones antiguas del trámite 20.
La mayoría son usuarios viejos: Christopher, José Francisco, Tatiana, Helder.
Hay una relación con ElementFamily1Id = 712 que no existe en la 153 actual, por eso sale Usuario153 = NULL.

Como estamos en DES y el objetivo es rehacer correctamente el trámite 20 para los 27 usuarios nuevos,
