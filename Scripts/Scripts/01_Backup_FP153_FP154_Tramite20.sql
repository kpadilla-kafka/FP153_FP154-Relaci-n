/* =========================================================
BACKUP FP153 - FP154
PROYECTO MINSA - TRÁMITE 20
FECHA: 2026-06-08

Objetivo:
Realizar respaldo previo de las familias propias
FP153 (Usuarios Delegados), FP154 (Ramas Gestor de Usuarios)
y sus relaciones asociadas al trámite 20 antes de ejecutar
procesos de limpieza y reconstrucción de relaciones.

Ambiente:
AuraPortal_BPMS_DES

Responsable:
GPG - Proyecto MINSA VUI
========================================================= */

USE [AuraPortal_BPMS_DES];
GO

/* =========================================================

1. RESPALDO COMPLETO FP153
   ========================================================= */

SELECT *
INTO [dbo].[BK_AP_Dyn_Familias_153_20260608]
FROM [dbo].[AP_Dyn_Familias_153];

/* =========================================================
2. RESPALDO COMPLETO FP154
========================================================= */

SELECT *
INTO [dbo].[BK_AP_Dyn_Familias_154_20260608]
FROM [dbo].[AP_Dyn_Familias_154];

/* =========================================================
3. RESPALDO RELACIONES ACTUALES DEL TRÁMITE 20
========================================================= */

SELECT rel.*
INTO [dbo].[BK_AP_FamilyRelational_Data_Tramite20_20260608]
FROM [dbo].[AP__FamilyRelational_Data] rel
INNER JOIN [dbo].[AP_Dyn_Familias_154] f154
ON f154.ID = rel.ElementFamily2Id
WHERE rel.RelationId = 25
AND f154.[1_VUI - Procesos/Name] = 20;

/* =========================================================
VALIDACIÓN DE RESPALDOS GENERADOS
========================================================= */

SELECT COUNT(*) AS TotalBK153
FROM [dbo].[BK_AP_Dyn_Familias_153_20260608];

SELECT COUNT(*) AS TotalBK154
FROM [dbo].[BK_AP_Dyn_Familias_154_20260608];

SELECT COUNT(*) AS TotalBKRelacionesTramite20
FROM [dbo].[BK_AP_FamilyRelational_Data_Tramite20_20260608];

/* =========================================================
RESULTADOS OBTENIDOS EN DES
===========================

## BK_AP_Dyn_Familias_153_20260608

Total registros: 27

## BK_AP_Dyn_Familias_154_20260608

Total registros: 731

## BK_AP_FamilyRelational_Data_Tramite20_20260608

Total registros: 8

Observaciones:

* Las 8 relaciones encontradas corresponden a
  configuraciones históricas del trámite 20.

* Se identificaron usuarios antiguos asociados
  al esquema original del trámite:

  * Christopher
  * José Francisco
  * Tatiana
  * Helder

* Se detectó una relación cuyo ElementFamily1Id = 712
  no posee correspondencia en la FP153 actual,
  motivo por el cual aparece Usuario153 = NULL
  durante las validaciones.

* Debido a que el objetivo del proyecto es reconstruir
  correctamente la asignación de ramas para los usuarios
  delegados vigentes del trámite 20, estas relaciones
  históricas se conservaron únicamente como respaldo.

========================================================= */

/* =========================================================
CONSULTA DE VALIDACIÓN DEL RESPALDO DE RELACIONES
========================================================= */

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
ORDER BY rel.ElementFamily1Id,
rel.ElementFamily2Id;
GO
