/* =========================================================
   RELACIÓN COMPLETA FP153 ↔ FP154
   USUARIO: ROSIBEL CASCANTE FALLAS
   REGIÓN: BRUNCA
   TRÁMITE: 20
   FECHA: 2026-06-19

   Objetivo:
   Crear las tareas de la FP154 y sus relaciones con la FP153
   para el usuario Rosibel Cascante Fallas, considerando las
   6 Áreas Rectoras de Salud de la Región Brunca.

   Alcance:
   6 ARS x 3 roles = 18 relaciones.

   Resultado esperado:
   La FP153 de Rosibel debe mostrar 18 ramas asociadas.

   Resultado obtenido:
   Total visualizado en FP153: 18 ramas.
   ========================================================= */

USE [AuraPortal_BPMS_DES];
GO

BEGIN TRAN;

DECLARE @IdUsuario153 INT = 22; -- Rosibel Cascante Fallas

DECLARE @RamasBrunca TABLE (
    Rama NVARCHAR(50),
    UnidadOrganizativa NVARCHAR(250),
    Cargo NVARCHAR(100)
);

INSERT INTO @RamasBrunca VALUES
('7.6.7.1.1.', 'Región Brunca - ARS Buenos Aires', 'Funcionario revisor PSF'),
('7.6.7.1.2.', 'Región Brunca - ARS Buenos Aires', 'Funcionario firmante PSF'),
('7.6.7.1.3.', 'Región Brunca - ARS Buenos Aires', 'Funcionario reportería PSF'),

('7.6.7.2.1.', 'Región Brunca - ARS Corredores', 'Funcionario revisor PSF'),
('7.6.7.2.2.', 'Región Brunca - ARS Corredores', 'Funcionario firmante PSF'),
('7.6.7.2.3.', 'Región Brunca - ARS Corredores', 'Funcionario reportería PSF'),

('7.6.7.3.1.', 'Región Brunca - ARS Coto Brus', 'Funcionario revisor PSF'),
('7.6.7.3.2.', 'Región Brunca - ARS Coto Brus', 'Funcionario firmante PSF'),
('7.6.7.3.3.', 'Región Brunca - ARS Coto Brus', 'Funcionario reportería PSF'),

('7.6.7.4.1.', 'Región Brunca - ARS Golfito', 'Funcionario revisor PSF'),
('7.6.7.4.2.', 'Región Brunca - ARS Golfito', 'Funcionario firmante PSF'),
('7.6.7.4.3.', 'Región Brunca - ARS Golfito', 'Funcionario reportería PSF'),

('7.6.7.5.1.', 'Región Brunca - ARS Osa', 'Funcionario revisor PSF'),
('7.6.7.5.2.', 'Región Brunca - ARS Osa', 'Funcionario firmante PSF'),
('7.6.7.5.3.', 'Región Brunca - ARS Osa', 'Funcionario reportería PSF'),

('7.6.7.6.1.', 'Región Brunca - ARS Pérez Zeledón', 'Funcionario revisor PSF'),
('7.6.7.6.2.', 'Región Brunca - ARS Pérez Zeledón', 'Funcionario firmante PSF'),
('7.6.7.6.3.', 'Región Brunca - ARS Pérez Zeledón', 'Funcionario reportería PSF');

-- 1. Crear tareas en FP154 si no existen
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
    0, GETDATE(), 35, 0,
    GETDATE(), 35, 0,
    157, r.Rama, 0,
    r.UnidadOrganizativa,
    r.Cargo,
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
FROM @RamasBrunca r
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.AP_Dyn_Familias_154 f154
    WHERE f154.[_Name] = r.Rama
      AND f154.[3_Institución a la que pertenece] = r.UnidadOrganizativa
      AND f154.[3_Nombre de cargo] = r.Cargo
      AND f154.[1_VUI - Procesos/Name] = 20
);

-- 2. Crear relaciones FP153 -> FP154
INSERT INTO dbo.AP__FamilyRelational_Data
(
    CreatorId, Created, CreatorType,
    ModifierId, Modified, ModifierType,
    RelationId, ElementFamily1Id, ElementFamily2Id
)
SELECT
    35, GETDATE(), 0,
    35, GETDATE(), 0,
    25,
    @IdUsuario153,
    f154.ID
FROM dbo.AP_Dyn_Familias_154 f154
INNER JOIN @RamasBrunca r
    ON r.Rama = f154.[_Name]
   AND r.UnidadOrganizativa = f154.[3_Institución a la que pertenece]
   AND r.Cargo = f154.[3_Nombre de cargo]
WHERE f154.[1_VUI - Procesos/Name] = 20
  AND NOT EXISTS (
        SELECT 1
        FROM dbo.AP__FamilyRelational_Data rel
        WHERE rel.RelationId = 25
          AND rel.ElementFamily1Id = @IdUsuario153
          AND rel.ElementFamily2Id = f154.ID
  );

-- 3. Validar resultado
SELECT
    f153.[1_Super usuario institucion/Name] AS Usuario,
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
  AND f154.[3_Institución a la que pertenece] LIKE 'Región Brunca%'
ORDER BY f154.[_Name];

-- Si devuelve 18 filas correctas:
COMMIT;

-- Si algo sale raro:
-- ROLLBACK;
