/* =========================================================
PRUEBA CONTROLADA FP153 ↔ FP154
USUARIO: ROSIBEL CASCANTE FALLAS
REGIÓN: BRUNCA
ARS: BUENOS AIRES
TRÁMITE: 20
FECHA: 2026-06-19

Objetivo:
Validar la creación de relaciones entre la familia
FP153 (Usuarios Delegados) y FP154 (Ramas Gestor de Usuarios)
para un usuario existente.

Alcance de la prueba:

* Usuario FP153:
  Rosibel Cascante Fallas
  ID FP153 = 22

* Región:
  Brunca

* Área Rectora:
  ARS Buenos Aires

* Roles asociados:
  7.6.7.1.1 → Funcionario revisor PSF
  7.6.7.1.2 → Funcionario firmante PSF
  7.6.7.1.3 → Funcionario reportería PSF

Resultado esperado:

La FP153 debe mostrar tres relaciones activas
correspondientes a los tres roles definidos para
ARS Buenos Aires.

Resultado obtenido:

✓ Relación creada con rama 7.6.7.1.1
✓ Relación creada con rama 7.6.7.1.2
✓ Relación creada con rama 7.6.7.1.3

Total relaciones creadas: 3

Validación funcional:

Desde la FP153 de Rosibel Cascante Fallas se
visualizan correctamente las tres ramas
relacionadas en la sección "Ramas de usuarios".

Esta prueba se considera exitosa y sirve como
base para la carga masiva de los demás usuarios
de la Región Brunca.
========================================================= */

Prueba Controlada: 

USE [AuraPortal_BPMS_DES];
GO

BEGIN TRAN;

DECLARE @IdUsuario153 INT = 22; -- Rosibel Cascante Fallas

/* 1. Crear tareas FP154 si no existen */
INSERT INTO dbo.AP_Dyn_Familias_154
(
    [_ElementID], [Creado], [IdCreador], [TipoCreador],
    [Modificado], [IdModificador], [TipoModificador],
    [_FamilyClass], [_Name], [_SecureRoomID],
    [3_Institución a la que pertenece],
    [3_Nombre de cargo],
    [3_Nombre institución login],
    [2_Página a asignar/IdPágina],
    [3_IdPortal],
    [1_Página a asignar],
    [1_Página a asignar/Name],
    [2_Página a asignar/IdPortal],
    [3_Instituciones en la VUI],
    [3_Acrónimo],
    [1_VUI - Procesos],
    [1_VUI - Procesos/Name],
    [2_VUI - Procesos/_Nm-VUI - Listado de procesos en producción],
    [2_VUI - Procesos/Nombre de proceso]
)
SELECT
    0,
    GETDATE(),
    35,
    0,
    GETDATE(),
    35,
    0,
    157,
    v.Rama,
    0,
    'Región Brunca - ARS Buenos Aires',
    v.Cargo,
    NULL,
    378,
    94,
    1,
    'Página genérica de empleados VUI',
    94,
    12386,
    'MINSA',
    3,
    20,
    20,
    'MINSA - Permiso Sanitario de Funcionamiento'
FROM (
    SELECT '7.6.7.1.1.' AS Rama, 'Funcionario revisor PSF' AS Cargo
    UNION ALL
    SELECT '7.6.7.1.2.', 'Funcionario firmante PSF'
    UNION ALL
    SELECT '7.6.7.1.3.', 'Funcionario reportería PSF'
) v
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.AP_Dyn_Familias_154 f154
    WHERE f154.[_Name] = v.Rama
      AND f154.[3_Nombre de cargo] = v.Cargo
      AND f154.[1_VUI - Procesos/Name] = 20
);

/* 2. Crear relación FP153 -> FP154 */
INSERT INTO dbo.AP__FamilyRelational_Data
(
    CreatorId,
    Created,
    CreatorType,
    ModifierId,
    Modified,
    ModifierType,
    RelationId,
    ElementFamily1Id,
    ElementFamily2Id
)
SELECT
    35,
    GETDATE(),
    0,
    35,
    GETDATE(),
    0,
    25,
    @IdUsuario153,
    f154.ID
FROM dbo.AP_Dyn_Familias_154 f154
WHERE f154.[1_VUI - Procesos/Name] = 20
  AND f154.[3_Institución a la que pertenece] = 'Región Brunca - ARS Buenos Aires'
  AND f154.[_Name] IN ('7.6.7.1.1.', '7.6.7.1.2.', '7.6.7.1.3.')
  AND NOT EXISTS (
        SELECT 1
        FROM dbo.AP__FamilyRelational_Data rel
        WHERE rel.RelationId = 25
          AND rel.ElementFamily1Id = @IdUsuario153
          AND rel.ElementFamily2Id = f154.ID
  );

/* 3. Validar resultado */
SELECT
    rel.ElementFamily1Id AS IdUsuario153,
    f153.[1_Super usuario institucion/Name] AS Usuario,
    rel.ElementFamily2Id AS IdRama154,
    f154.[_Name] AS Rama,
    f154.[3_Institución a la que pertenece] AS UnidadOrganizativa,
    f154.[3_Nombre de cargo] AS Cargo
FROM dbo.AP__FamilyRelational_Data rel
INNER JOIN dbo.AP_Dyn_Familias_153 f153
    ON f153.ID = rel.ElementFamily1Id
INNER JOIN dbo.AP_Dyn_Familias_154 f154
    ON f154.ID = rel.ElementFamily2Id
WHERE rel.RelationId = 25
  AND rel.ElementFamily1Id = @IdUsuario153
  AND f154.[1_VUI - Procesos/Name] = 20
  AND f154.[3_Institución a la que pertenece] = 'Región Brunca - ARS Buenos Aires'
ORDER BY f154.[_Name];

-- Si devuelve las 3 filas correctas:
COMMIT;

-- Si algo sale raro:
-- ROLLBACK;

/*✅ Se crearon correctamente los 3 registros en FP154.

  ✅ Se creó correctamente la relación en AP__FamilyRelational_Data.

  ✅ Rosibel quedó asociada a los 3 roles de Buenos Aires.

  ./*
