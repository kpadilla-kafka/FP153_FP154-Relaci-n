/* =========================================================
RELACIÓN COMPLETA FP153 ↔ FP154
REGIÓN: CENTRAL OCCIDENTE
AMBIENTE: PRODUCCIÓN
TRÁMITE: 20
FECHA: 2026-06-19

Objetivo:
Crear los registros correspondientes en la familia
propia FP154 (Ramas de Usuarios) para la Región
Central Occidente y establecer las relaciones con el
usuario delegado registrado en la FP153.

Usuario incluido:

* ID 38: Andrey Delgado Vásquez

Alcance:

* 5 Áreas Rectoras de Salud (ARS).
* 3 roles por cada ARS:
  • Funcionario revisor PSF
  • Funcionario firmante PSF
  • Funcionario reportería PSF
* 15 tareas para el usuario.
* 15 tareas totales para la Región Central Occidente.


========================================================= */


USE [AuraPortal_BPMS_PROD];
GO

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRAN;

    DECLARE @IdUsuario153 INT = 38; -- Andrey Delgado Vásquez

    DECLARE @NuevasRamas TABLE (IdRama154 INT);

    DECLARE @RamasCentralOccidente TABLE (
        Rama NVARCHAR(50),
        UnidadOrganizativa NVARCHAR(250),
        Cargo NVARCHAR(100)
    );

    INSERT INTO @RamasCentralOccidente VALUES
    ('7.6.8.1.1.','Región Central Occidente - ARS Naranjo','Funcionario revisor PSF'),
    ('7.6.8.1.2.','Región Central Occidente - ARS Naranjo','Funcionario firmante PSF'),
    ('7.6.8.1.3.','Región Central Occidente - ARS Naranjo','Funcionario reportería PSF'),

    ('7.6.8.2.1.','Región Central Occidente - ARS Palmares','Funcionario revisor PSF'),
    ('7.6.8.2.2.','Región Central Occidente - ARS Palmares','Funcionario firmante PSF'),
    ('7.6.8.2.3.','Región Central Occidente - ARS Palmares','Funcionario reportería PSF'),

    ('7.6.8.3.1.','Región Central Occidente - ARS San Ramón','Funcionario revisor PSF'),
    ('7.6.8.3.2.','Región Central Occidente - ARS San Ramón','Funcionario firmante PSF'),
    ('7.6.8.3.3.','Región Central Occidente - ARS San Ramón','Funcionario reportería PSF'),

    ('7.6.8.4.1.','Región Central Occidente - ARS Sarchí','Funcionario revisor PSF'),
    ('7.6.8.4.2.','Región Central Occidente - ARS Sarchí','Funcionario firmante PSF'),
    ('7.6.8.4.3.','Región Central Occidente - ARS Sarchí','Funcionario reportería PSF'),

    ('7.6.8.5.1.','Región Central Occidente - ARS Zarcero','Funcionario revisor PSF'),
    ('7.6.8.5.2.','Región Central Occidente - ARS Zarcero','Funcionario firmante PSF'),
    ('7.6.8.5.3.','Región Central Occidente - ARS Zarcero','Funcionario reportería PSF');

    IF (SELECT COUNT(*) FROM @RamasCentralOccidente) <> 15
        THROW 50001, 'La cantidad de ramas Central Occidente no es 15.', 1;

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
    OUTPUT INSERTED.ID INTO @NuevasRamas
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
    FROM @RamasCentralOccidente r;

    IF (SELECT COUNT(*) FROM @NuevasRamas) <> 15
        THROW 50002, 'No se crearon 15 tareas FP154 para el usuario.', 1;

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
        nr.IdRama154
    FROM @NuevasRamas nr;

    IF (
        SELECT COUNT(*)
        FROM dbo.AP__FamilyRelational_Data rel
        INNER JOIN @NuevasRamas nr
            ON nr.IdRama154 = rel.ElementFamily2Id
        WHERE rel.RelationId = 25
          AND rel.ElementFamily1Id = @IdUsuario153
    ) <> 15
        THROW 50003, 'No se crearon 15 relaciones para el usuario.', 1;

    SELECT
        f153.[1_Super usuario institucion/Name] AS Usuario,
        f154.ID AS IdRama154,
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
      AND f154.[3_Institución a la que pertenece] LIKE 'Región Central Occidente%'
    ORDER BY f154.[_Name], f154.ID;

    COMMIT;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;

    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
