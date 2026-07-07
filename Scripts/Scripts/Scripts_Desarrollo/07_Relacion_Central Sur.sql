/* =========================================================
RELACIÓN COMPLETA FP153 ↔ FP154
REGIÓN: CENTRAL SUR
TRÁMITE: 20
FECHA: 2026-06-19

Objetivo:
Crear las tareas correspondientes en la familia propia
FP154 (Ramas de Usuarios) para la Región Central Sur y
establecer las relaciones con los usuarios delegados
existentes en la FP153.

Usuarios incluidos:

ID 31: Bibiana Marchena Morales
ID 32: Danny Astorga Aguilar

Alcance:

19 Áreas Rectoras de Salud (ARS).
3 roles por ARS:
• Funcionario revisor PSF
• Funcionario firmante PSF
• Funcionario reportería PSF
57 tareas por usuario.
114 tareas totales para la Región Central Sur.

Resultado esperado:

Creación de registros en FP154 para cada rol y ARS.
Creación de relaciones FP153 ↔ FP154 (RelationId = 25).
Visualización de 57 ramas asociadas para cada usuario
dentro de la FP153 (Usuarios Delegados).

========================================================= */

USE [AuraPortal_BPMS_DES];
GO

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRAN;

    DECLARE @IdUsuario153 INT = 31; -- Bibiana Marchena Morales

    DECLARE @NuevasRamas TABLE (IdRama154 INT);

    DECLARE @RamasCentralSur TABLE (
        Rama NVARCHAR(50),
        UnidadOrganizativa NVARCHAR(250),
        Cargo NVARCHAR(100)
    );

    INSERT INTO @RamasCentralSur VALUES
    ('7.6.1.1.1.','Región Central Sur - ARS Acosta','Funcionario revisor PSF'),
    ('7.6.1.1.2.','Región Central Sur - ARS Acosta','Funcionario firmante PSF'),
    ('7.6.1.1.3.','Región Central Sur - ARS Acosta','Funcionario reportería PSF'),
    ('7.6.1.2.1.','Región Central Sur - ARS Alajuelita','Funcionario revisor PSF'),
    ('7.6.1.2.2.','Región Central Sur - ARS Alajuelita','Funcionario firmante PSF'),
    ('7.6.1.2.3.','Región Central Sur - ARS Alajuelita','Funcionario reportería PSF'),
    ('7.6.1.3.1.','Región Central Sur - ARS Aserrí','Funcionario revisor PSF'),
    ('7.6.1.3.2.','Región Central Sur - ARS Aserrí','Funcionario firmante PSF'),
    ('7.6.1.3.3.','Región Central Sur - ARS Aserrí','Funcionario reportería PSF'),
    ('7.6.1.4.1.','Región Central Sur - ARS Carmen-Merced-Urca','Funcionario revisor PSF'),
    ('7.6.1.4.2.','Región Central Sur - ARS Carmen-Merced-Urca','Funcionario firmante PSF'),
    ('7.6.1.4.3.','Región Central Sur - ARS Carmen-Merced-Urca','Funcionario reportería PSF'),
    ('7.6.1.5.1.','Región Central Sur - ARS Coronado','Funcionario revisor PSF'),
    ('7.6.1.5.2.','Región Central Sur - ARS Coronado','Funcionario firmante PSF'),
    ('7.6.1.5.3.','Región Central Sur - ARS Coronado','Funcionario reportería PSF'),
    ('7.6.1.6.1.','Región Central Sur - ARS Curridabat','Funcionario revisor PSF'),
    ('7.6.1.6.2.','Región Central Sur - ARS Curridabat','Funcionario firmante PSF'),
    ('7.6.1.6.3.','Región Central Sur - ARS Curridabat','Funcionario reportería PSF'),
    ('7.6.1.7.1.','Región Central Sur - ARS Desamparados','Funcionario revisor PSF'),
    ('7.6.1.7.2.','Región Central Sur - ARS Desamparados','Funcionario firmante PSF'),
    ('7.6.1.7.3.','Región Central Sur - ARS Desamparados','Funcionario reportería PSF'),
    ('7.6.1.8.1.','Región Central Sur - ARS Goicoechea','Funcionario revisor PSF'),
    ('7.6.1.8.2.','Región Central Sur - ARS Goicoechea','Funcionario firmante PSF'),
    ('7.6.1.8.3.','Región Central Sur - ARS Goicoechea','Funcionario reportería PSF'),
    ('7.6.1.9.1.','Región Central Sur - ARS Hatillo','Funcionario revisor PSF'),
    ('7.6.1.9.2.','Región Central Sur - ARS Hatillo','Funcionario firmante PSF'),
    ('7.6.1.9.3.','Región Central Sur - ARS Hatillo','Funcionario reportería PSF'),
    ('7.6.1.10.1.','Región Central Sur - ARS Hospital-Mata Redonda','Funcionario revisor PSF'),
    ('7.6.1.10.2.','Región Central Sur - ARS Hospital-Mata Redonda','Funcionario firmante PSF'),
    ('7.6.1.10.3.','Región Central Sur - ARS Hospital-Mata Redonda','Funcionario reportería PSF'),
    ('7.6.1.11.1.','Región Central Sur - ARS Mora','Funcionario revisor PSF'),
    ('7.6.1.11.2.','Región Central Sur - ARS Mora','Funcionario firmante PSF'),
    ('7.6.1.11.3.','Región Central Sur - ARS Mora','Funcionario reportería PSF'),
    ('7.6.1.12.1.','Región Central Sur - ARS Escazú','Funcionario revisor PSF'),
    ('7.6.1.12.2.','Región Central Sur - ARS Escazú','Funcionario firmante PSF'),
    ('7.6.1.12.3.','Región Central Sur - ARS Escazú','Funcionario reportería PSF'),
    ('7.6.1.13.1.','Región Central Sur - ARS Pavas','Funcionario revisor PSF'),
    ('7.6.1.13.2.','Región Central Sur - ARS Pavas','Funcionario firmante PSF'),
    ('7.6.1.13.3.','Región Central Sur - ARS Pavas','Funcionario reportería PSF'),
    ('7.6.1.14.1.','Región Central Sur - ARS Puriscal-Turrubares','Funcionario revisor PSF'),
    ('7.6.1.14.2.','Región Central Sur - ARS Puriscal-Turrubares','Funcionario firmante PSF'),
    ('7.6.1.14.3.','Región Central Sur - ARS Puriscal-Turrubares','Funcionario reportería PSF'),
    ('7.6.1.15.1.','Región Central Sur - ARS Santa Ana','Funcionario revisor PSF'),
    ('7.6.1.15.2.','Región Central Sur - ARS Santa Ana','Funcionario firmante PSF'),
    ('7.6.1.15.3.','Región Central Sur - ARS Santa Ana','Funcionario reportería PSF'),
    ('7.6.1.16.1.','Región Central Sur - ARS Sureste-Metropolitana','Funcionario revisor PSF'),
    ('7.6.1.16.2.','Región Central Sur - ARS Sureste-Metropolitana','Funcionario firmante PSF'),
    ('7.6.1.16.3.','Región Central Sur - ARS Sureste-Metropolitana','Funcionario reportería PSF'),
    ('7.6.1.17.1.','Región Central Sur - ARS Tibás','Funcionario revisor PSF'),
    ('7.6.1.17.2.','Región Central Sur - ARS Tibás','Funcionario firmante PSF'),
    ('7.6.1.17.3.','Región Central Sur - ARS Tibás','Funcionario reportería PSF'),
    ('7.6.1.18.1.','Región Central Sur - ARS Moravia','Funcionario revisor PSF'),
    ('7.6.1.18.2.','Región Central Sur - ARS Moravia','Funcionario firmante PSF'),
    ('7.6.1.18.3.','Región Central Sur - ARS Moravia','Funcionario reportería PSF'),
    ('7.6.1.19.1.','Región Central Sur - ARS Montes de Oca','Funcionario revisor PSF'),
    ('7.6.1.19.2.','Región Central Sur - ARS Montes de Oca','Funcionario firmante PSF'),
    ('7.6.1.19.3.','Región Central Sur - ARS Montes de Oca','Funcionario reportería PSF');

    IF (SELECT COUNT(*) FROM @RamasCentralSur) <> 57
        THROW 50001, 'La cantidad de ramas Central Sur no es 57. Revisar antes de continuar.', 1;

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
    FROM @RamasCentralSur r;

    IF (SELECT COUNT(*) FROM @NuevasRamas) <> 57
        THROW 50002, 'No se crearon 57 tareas FP154 para Bibiana.', 1;

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
    ) <> 57
        THROW 50003, 'No se crearon 57 relaciones para Bibiana.', 1;

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
      AND f154.[3_Institución a la que pertenece] LIKE 'Región Central Sur%'
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
