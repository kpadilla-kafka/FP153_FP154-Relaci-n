/* =========================================================
LIMPIEZA CONTROLADA FP154 - TRÁMITE 20
PROYECTO MINSA - PERMISO SANITARIO DE FUNCIONAMIENTO
FECHA: 2026-06-08

Objetivo:
Eliminar las configuraciones existentes del trámite 20
en la familia FP154 y sus relaciones asociadas para
reconstruir la asignación de ramas de usuarios
delegados según el nuevo esquema definido por MINSA.

Ambiente:
AuraPortal_BPMS_DES

Respaldo previo:

* BK_AP_Dyn_Familias_153_20260608
* BK_AP_Dyn_Familias_154_20260608
* BK_AP_FamilyRelational_Data_Tramite20_20260608

========================================================= */

/* =========================================================
PASO 1 - ELIMINACIÓN DE RELACIONES EXISTENTES
=============================================

Se eliminan únicamente las relaciones del término
FP153 ↔ FP154 correspondientes al trámite 20.

RelationId = 25
Trámite = 20

Resultado esperado:
8 relaciones históricas.

========================================================= */

BEGIN TRAN;

DELETE rel
FROM [dbo].[AP__FamilyRelational_Data] rel
INNER JOIN [dbo].[AP_Dyn_Familias_154] f154
ON f154.ID = rel.ElementFamily2Id
WHERE rel.RelationId = 25
AND f154.[1_VUI - Procesos/Name] = 20;

SELECT @@ROWCOUNT AS RelacionesEliminadas;

COMMIT;

/*
Resultado obtenido:

Relaciones eliminadas: 8

Observaciones:

* Las relaciones eliminadas correspondían a
  configuraciones históricas del trámite 20.

* Entre los usuarios encontrados se identificaron
  registros asociados a configuraciones antiguas
  utilizadas para pruebas y validaciones previas.

* La eliminación se realizó exitosamente después
  de validar el respaldo correspondiente.
  */

/* =========================================================
PASO 2 - ELIMINACIÓN DE REGISTROS FP154
=======================================

Se eliminan todas las ramas configuradas en FP154
para el trámite 20.

Esto permite reconstruir desde cero las relaciones
de usuarios delegados según la distribución actual
por regiones, áreas rectoras y roles.

========================================================= */

BEGIN TRAN;

DELETE FROM [dbo].[AP_Dyn_Familias_154]
WHERE [1_VUI - Procesos/Name] = 20;

SELECT @@ROWCOUNT AS Ramas154Eliminadas;

COMMIT;

/*
Resultado obtenido:

Ramas FP154 eliminadas: 20

Observaciones:

* Se eliminaron todas las configuraciones existentes
  asociadas al trámite 20.

* FP153 (Usuarios Delegados) NO fue modificada.

* Los usuarios existentes permanecen intactos.

* A partir de este punto la FP154 quedó preparada
  para la reconstrucción de ramas y relaciones
  según la estructura validada por MINSA.

=========================================================

Resumen final de la limpieza

Backup FP153:                          27 registros
Backup FP154:                         731 registros
Backup relaciones trámite 20:           8 registros

Relaciones eliminadas trámite 20:       8 registros
Ramas FP154 eliminadas trámite 20:     20 registros

Estado final:
FP154 limpia para reconstrucción del
trámite 20 - Permiso Sanitario de Funcionamiento.

=========================================================
*/
