/* =========================================================
VALIDACIÓN DE USUARIOS FP153
PROYECTO MINSA - TRÁMITE 20
FECHA: 2026-06-19

Objetivo:
Validar los usuarios existentes en la familia propia
FP153 (Usuarios Delegados) y obtener su ID interno
para utilizarlo posteriormente en los scripts de
creación de relaciones FP153 ↔ FP154.

Observación:
Los IDs obtenidos en esta consulta deben utilizarse
en la variable @IdUsuario153 de los scripts de carga.
========================================================= */

SELECT
ID,
[1_Super usuario institucion/Name] AS Usuario
FROM dbo.AP_Dyn_Familias_153
ORDER BY ID;
GO

-------------------------------------------------------*/
/*
Usuarios activos validados FP153
Fecha: 2026-06-19

| ID | Usuario                        |
| -- | ------------------------------ |
| 22 | Rosibel Cascante Fallas        |
| 23 | Ronny Fonseca Fallas           |
| 24 | Michael Mora Fernandez         |
| 25 | Ana Gabriela Monestel Brenes   |
| 26 | Mariela Díaz Ríos              |
| 27 | Nuria Isela Villalta Solano    |
| 28 | Dayana Melissa Fajardo Aguirre |
| 29 | Hugo Alberto Chavarría Oviedo  |
| 30 | Wilder Martínez Álvares        |
| 31 | Bibiana Marchena Morales       |
| 32 | Danny Astorga Aguilar          |
| 33 | Leidy Serrano Álvarez          |
| 34 | Carlos Smith Alterno           |
| 35 | Roger Miranda Barrantes        |
| 36 | Jenory Fernández Peraza        |
| 37 | José María Cordero Herrera     |
| 38 | Alfredo Viales Wahrmann        |
| 39 | Rolando Salazar Moreno         |
| 40 | Dayanna Calderón Abasrca       |
| 41 | Marcela Melissa Diaz Araya     |
| 42 | Freddy Miranda Ordoñez         |
| 43 | Juan Pablo Caravaca Martinez   |
| 44 | Andrey Delgado Vásquez         |

*/
