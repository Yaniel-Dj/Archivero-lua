<div align="center">

# 🐉 Scripts Lua para AzerothCore

**Colección de scripts Lua independientes para servidores AzerothCore (WoW 3.3.5a) con Eluna**

[![AzerothCore](https://img.shields.io/badge/AzerothCore-3.3.5a-blue?style=flat-square)](https://www.azerothcore.org/)
[![Eluna](https://img.shields.io/badge/Eluna-Lua%20Engine-purple?style=flat-square)](https://github.com/ElunaLuaEngine/Eluna)
[![Lua](https://img.shields.io/badge/Lua-5.1%20%2F%205.2-2C2D72?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org/)
[![License](https://img.shields.io/badge/License-GPL--3.0-green?style=flat-square)](LICENSE)

*"Reviviendo Azeroth, un script a la vez."*

</div>

---

## 📖 Tabla de contenidos

- [¿Qué es este repositorio?](#-qué-es-este-repositorio)
- [Filosofía](#-filosofía)
- [Requisitos](#-requisitos)
- [Instalación y uso](#-instalación-y-uso)
- [Scripts disponibles](#-scripts-disponibles)
- [Estructura del repositorio](#-estructura-del-repositorio)
- [Buenas prácticas](#-buenas-prácticas)
- [Contribuir](#-contribuir)
- [Licencia](#-licencia)
- [Créditos](#-créditos)

---

## 🧭 ¿Qué es este repositorio?

Un **cajón de scripts Lua** para servidores **AzerothCore** (World of Warcraft 3.3.5a), pensados para funcionar con **Eluna Lua Engine**.

Cada archivo `.lua` es **autónomo**: lo copias a tu carpeta `lua_scripts`, revisas su cabecera y funciona. Sin frameworks, sin compilaciones, sin dependencias externas.

| ✅ Lo que SÍ encontrarás | ❌ Lo que NO encontrarás |
|--------------------------|--------------------------|
| Scripts Lua independientes | Módulos C++ |
| Código comentado en español | `composer install` |
| Cabeceras con requisitos claros | Dependencias raras |
| Aportes listos para copiar | Estructura MVC compleja |

> ⚠️ Esto es un **hobby**, no un producto terminado. Léelo antes de usarlo en producción. 😄

---

## 💡 Filosofía

- 🧩 **Un script = un archivo**: fácil de leer, modificar y borrar.
- 📘 **Legibilidad primero**: que se entienda antes que ser "bonito".
- 🪶 **Ligero por diseño**: solo Lua y lo que trae Eluna de serie.
- 🤝 **Compartir es la idea**: si te sirve, úsalo; si lo mejoras, compártelo.
- 🇪🇸 **Comentado en español**: para que cualquiera pueda entenderlo.

---

## ⚙️ Requisitos

| Componente | Versión / Nota |
|------------|----------------|
| **AzerothCore** | 3.3.5a funcionando |
| **Eluna Lua Engine** | Integrado y activado en el core |
| **Lua** | 5.1 o 5.2 (según tu versión de Eluna) |
| **Carpeta `lua_scripts`** | Configurada en `worldserver.conf` |

Configuración en `worldserver.conf`:

```ini
Eluna.ScriptPath = "lua_scripts"
