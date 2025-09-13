Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A6CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMr-0001Fn-3I; Sat, 13 Sep 2025 04:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMb-0000l2-Me
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMY-0005Ay-Bj
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LPSYsNqNQZj0qqwLeQ44bnH1Mi9Qg0+txhVsw7SWVE=;
 b=J6IHZl0FPqFsbAHY46AqB9A4E96LAVt9RfMgcLOmmbdg5vin3A2B7yxc2gVUCx8P6mEJ2Z
 1Dh7JCoHC0LcbJ5KOTtJHsOGKtVkbbqunNCZLKye+qauxzUU7jb/LxbrEqoNKr9gtcX82s
 enzWIlg/QwdMep5iaVk6JZxY1WylZ5s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-HYGwBwLJO2uXH4WMsFm9vw-1; Sat, 13 Sep 2025 04:11:59 -0400
X-MC-Unique: HYGwBwLJO2uXH4WMsFm9vw-1
X-Mimecast-MFC-AGG-ID: HYGwBwLJO2uXH4WMsFm9vw_1757751118
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3df9f185c7cso1547168f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751117; x=1758355917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LPSYsNqNQZj0qqwLeQ44bnH1Mi9Qg0+txhVsw7SWVE=;
 b=HJ0sGegcaj2e3X5KwDS8VahhgpkfzHqZRcOJrLskNqEP0hrW4h1GRTvzhVtCzKzFwz
 8c49qgtZbunbOMiI/4C5TWBZ+glNNNn+aUUH+nF6juuNBXorFFU2HUuzJVv6g8LbU9UL
 RPfKymE2h4mt9JnYVsojNDHbZo0qttxoDNjlrvoosGx8aaK71xnhoagXZ8PMwkHj9czJ
 PaHQLgBgw3Chk8JgU9JnaQJG/hELlro1QTYu69b66tkrHE8io3G+u/AbBaHjNTqbU6Hl
 WkL2TwfluAkf6WMw491Q4OF3HaaaYcCo/2FmERMOzCUzlZ3+1o9ilsjAQKzYpuIDikq7
 E2ww==
X-Gm-Message-State: AOJu0YxTQPY1BxtRAinfbitKv/f9KjnXt3OQflrFggMY7qdHEcQhlszc
 P6wIIO5ihb3VOeiNGnfnpddd6bGCeq2wMcVUY8w13n4HnS1MuqrXdaVJ29v07ZohsallOQ5jZC9
 vM/5Yok1/xCmDxvJdYcI3TdzgoBELgrpjS8yq/m1ye+ZRvrh2VcSqtjSqcOtl2Go3JOmHOwxdi5
 FQ5e05AZMhk+Hfks9HNuEfEQDkXLllSv8wi/pJwNjd
X-Gm-Gg: ASbGncsdQHniMVd8kXsdfBF5A32hH5I31Ld8WUfQaaSzDrhHKiXbjMwj62uCLypavqa
 hVn8wwfaAqKsmiKkNlyqcSR1L9sFfLDYSTiTdbJPM7R/8TLyYtZ8PSaxGFWMqUilQs8XB1nswW9
 AKG/JMa/5S+eOALQeZVF8gRmLAUztdomShko9K2oA2PRkpyDKbwWV6bkZ0P6kzVf7jFIxyEEXYm
 hQT5G/QgKmlfXJJKM8w4BbGI9zIQYex50nR0wrEQD+5N2extpmZ/SYh3v4xngZ+tZ8yqULvMwZ6
 zn6ymsjx6z9iV1jomln4IjrpH9XfqmlEQmMbXgiLryMfy71uX8olOLdjp8QteRnxmKsGIgTAr9n
 dn7/yBgUEqEjOEQPPZ2JFEm7xSC3hJuiKkzjRW/e3utw=
X-Received: by 2002:a05:6000:2c04:b0:3cb:cc6f:734e with SMTP id
 ffacd0b85a97d-3e7657960a1mr5814891f8f.14.1757751116597; 
 Sat, 13 Sep 2025 01:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf1XQo6KoVoDtaRtmoAcsRikYs38Hnay4e2UQZMgQO0Vx0DGNhzbXfA4n1yYrZ3dEU9BmI6A==
X-Received: by 2002:a05:6000:2c04:b0:3cb:cc6f:734e with SMTP id
 ffacd0b85a97d-3e7657960a1mr5814862f8f.14.1757751116004; 
 Sat, 13 Sep 2025 01:11:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760786c95sm9661988f8f.17.2025.09.13.01.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 47/61] rust: repurpose qemu_api -> tests
Date: Sat, 13 Sep 2025 10:09:28 +0200
Message-ID: <20250913080943.11710-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The crate purpose is only to provide integration tests at this point,
that can't easily be moved to a specific crate.

It's also often a good practice to have a single integration test crate
(see for ex https://github.com/rust-lang/cargo/issues/4867)

Drop README.md, use docs/devel/rust.rst instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-20-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 rust/qemu-api/wrapper.h                       | 53 -------------
 rust/Cargo.lock                               | 30 ++++----
 rust/Cargo.toml                               |  2 +-
 rust/meson.build                              |  4 +-
 rust/qemu-api/.gitignore                      |  2 -
 rust/qemu-api/README.md                       | 19 -----
 rust/qemu-api/build.rs                        |  1 -
 rust/qemu-api/meson.build                     | 75 -------------------
 rust/qemu-api/src/bindings.rs                 | 33 --------
 rust/qemu-api/src/lib.rs                      | 18 -----
 rust/qemu-api/src/prelude.rs                  |  5 --
 rust/{qemu-api => tests}/Cargo.toml           |  7 +-
 rust/tests/meson.build                        | 14 ++++
 .../tests/vmstate_tests.rs                    |  0
 15 files changed, 35 insertions(+), 230 deletions(-)
 delete mode 100644 rust/qemu-api/wrapper.h
 delete mode 100644 rust/qemu-api/.gitignore
 delete mode 100644 rust/qemu-api/README.md
 delete mode 120000 rust/qemu-api/build.rs
 delete mode 100644 rust/qemu-api/meson.build
 delete mode 100644 rust/qemu-api/src/bindings.rs
 delete mode 100644 rust/qemu-api/src/lib.rs
 delete mode 100644 rust/qemu-api/src/prelude.rs
 rename rust/{qemu-api => tests}/Cargo.toml (78%)
 create mode 100644 rust/tests/meson.build
 rename rust/{qemu-api => tests}/tests/vmstate_tests.rs (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23bda7d3325..05e0597d532 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3520,11 +3520,11 @@ F: rust/chardev/
 F: rust/common/
 F: rust/hw/core/
 F: rust/migration/
-F: rust/qemu-api
 F: rust/qemu-macros/
 F: rust/qom/
 F: rust/rustfmt.toml
 F: rust/system/
+F: rust/tests/
 F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
 
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
deleted file mode 100644
index 7c9c20b14fe..00000000000
--- a/rust/qemu-api/wrapper.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2024 Linaro Ltd.
- *
- * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-#include "qemu-io.h"
-#include "exec/memattrs.h"
-#include "hw/char/pl011.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 2018d13fbf5..ac79c6a34a9 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -187,21 +187,6 @@ dependencies = [
  "unicode-ident",
 ]
 
-[[package]]
-name = "qemu_api"
-version = "0.1.0"
-dependencies = [
- "bql",
- "chardev",
- "common",
- "hwcore",
- "migration",
- "qemu_macros",
- "qom",
- "system",
- "util",
-]
-
 [[package]]
 name = "qemu_macros"
 version = "0.1.0"
@@ -252,6 +237,21 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "tests"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "chardev",
+ "common",
+ "hwcore",
+ "migration",
+ "qemu_macros",
+ "qom",
+ "system",
+ "util",
+]
+
 [[package]]
 name = "unicode-ident"
 version = "1.0.12"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index b2a5c230fa2..d8183c614d4 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -6,13 +6,13 @@ members = [
     "common",
     "migration",
     "qemu-macros",
-    "qemu-api",
     "qom",
     "system",
     "hw/core",
     "hw/char/pl011",
     "hw/timer/hpet",
     "util",
+    "tests",
 ]
 
 [workspace.package]
diff --git a/rust/meson.build b/rust/meson.build
index 9f6a0b161d2..bd9b9cb83ea 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -18,8 +18,6 @@ quote_rs_native = dependency('quote-1-rs', native: true)
 syn_rs_native = dependency('syn-2-rs', native: true)
 proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
 
-qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
-
 genrs = []
 
 subdir('common')
@@ -32,7 +30,7 @@ subdir('qom')
 subdir('system')
 subdir('chardev')
 subdir('hw/core')
-subdir('qemu-api')
+subdir('tests')
 
 subdir('hw')
 
diff --git a/rust/qemu-api/.gitignore b/rust/qemu-api/.gitignore
deleted file mode 100644
index df6c2163e03..00000000000
--- a/rust/qemu-api/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# Ignore generated bindings file overrides.
-/src/bindings.inc.rs
diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
deleted file mode 100644
index ed1b7ab263d..00000000000
--- a/rust/qemu-api/README.md
+++ /dev/null
@@ -1,19 +0,0 @@
-# QEMU bindings and API wrappers
-
-This library exports helper Rust types, Rust macros and C FFI bindings for internal QEMU APIs.
-
-The C bindings can be generated with `bindgen`, using this build target:
-
-```console
-$ make bindings.inc.rs
-```
-
-## Generate Rust documentation
-
-Common Cargo tasks can be performed from the QEMU build directory
-
-```console
-$ make clippy
-$ make rustfmt
-$ make rustdoc
-```
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
deleted file mode 120000
index 71a3167885c..00000000000
--- a/rust/qemu-api/build.rs
+++ /dev/null
@@ -1 +0,0 @@
-../util/build.rs
\ No newline at end of file
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
deleted file mode 100644
index fe81f16d990..00000000000
--- a/rust/qemu-api/meson.build
+++ /dev/null
@@ -1,75 +0,0 @@
-_qemu_api_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
-  capture: true, check: true).stdout().strip().splitlines()
-
-c_enums = [
-  'MemoryDeviceInfoKind',
-]
-_qemu_api_bindgen_args = []
-foreach enum : c_enums
-  _qemu_api_bindgen_args += ['--rustified-enum', enum]
-endforeach
-
-blocked_type = [
-  'Chardev',
-  'Error',
-  'MemTxAttrs',
-  'MemoryRegion',
-  'ObjectClass',
-  'VMStateDescription',
-  'device_endian',
-]
-foreach type: blocked_type
-  _qemu_api_bindgen_args += ['--blocklist-type', type]
-endforeach
-
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_qemu_api_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common + _qemu_api_bindgen_args,
-  )
-
-_qemu_api_rs = static_library(
-  'qemu_api',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/prelude.rs',
-    ],
-    {'.' : _qemu_api_bindings_inc_rs},
-  ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, bql_rs, chardev_rs, common_rs, foreign_rs, hwcore_rs, libc_rs, migration_rs, qemu_macros,
-                 qom_rs, system_rs, util_rs, hwcore],
-)
-
-qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
-  dependencies: [qemu_macros, qom, hwcore, chardev, migration])
-
-test('rust-qemu-api-integration',
-    executable(
-        'rust-qemu-api-integration',
-        files('tests/vmstate_tests.rs'),
-        override_options: ['rust_std=2021', 'build.rust_std=2021'],
-        rust_args: ['--test'],
-        install: false,
-        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs, qemu_api_rs]),
-    args: [
-        '--test', '--test-threads', '1',
-        '--format', 'pretty',
-    ],
-    protocol: 'rust',
-    suite: ['unit', 'rust'])
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
deleted file mode 100644
index 9c863e9b5b4..00000000000
--- a/rust/qemu-api/src/bindings.rs
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#![allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unnecessary_transmutes,
-    unsafe_op_in_unsafe_fn,
-    clippy::pedantic,
-    clippy::restriction,
-    clippy::style,
-    clippy::missing_const_for_fn,
-    clippy::ptr_offset_with_cast,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc,
-    clippy::too_many_arguments
-)]
-
-//! `bindgen`-generated declarations.
-
-use chardev::bindings::Chardev;
-use migration::bindings::VMStateDescription;
-use qom::bindings::ObjectClass;
-use system::bindings::{device_endian, MemTxAttrs, MemoryRegion};
-use util::bindings::Error;
-
-#[cfg(MESON)]
-include!("bindings.inc.rs");
-
-#[cfg(not(MESON))]
-include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
deleted file mode 100644
index 21b886035f3..00000000000
--- a/rust/qemu-api/src/lib.rs
+++ /dev/null
@@ -1,18 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
-#![deny(clippy::missing_const_for_fn)]
-
-#[rustfmt::skip]
-pub mod bindings;
-
-// preserve one-item-per-"use" syntax, it is clearer
-// for prelude-like modules
-#[rustfmt::skip]
-pub mod prelude;
-
-// Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this
-// crate).
-extern crate self as qemu_api;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
deleted file mode 100644
index 8db56f9f817..00000000000
--- a/rust/qemu-api/src/prelude.rs
+++ /dev/null
@@ -1,5 +0,0 @@
-// Copyright 2024 Red Hat, Inc.
-// Author(s): Paolo Bonzini <pbonzini@redhat.com>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-//! Commonly used traits and types for QEMU.
diff --git a/rust/qemu-api/Cargo.toml b/rust/tests/Cargo.toml
similarity index 78%
rename from rust/qemu-api/Cargo.toml
rename to rust/tests/Cargo.toml
index 9abb88aa1f8..8d106d896d7 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/tests/Cargo.toml
@@ -1,12 +1,11 @@
 [package]
-name = "qemu_api"
+name = "tests"
 version = "0.1.0"
-authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-description = "Rust bindings for QEMU"
-readme = "README.md"
+description = "Rust integration tests for QEMU"
 resolver = "2"
 publish = false
 
+authors.workspace = true
 edition.workspace = true
 homepage.workspace = true
 license.workspace = true
diff --git a/rust/tests/meson.build b/rust/tests/meson.build
new file mode 100644
index 00000000000..00688c66fb1
--- /dev/null
+++ b/rust/tests/meson.build
@@ -0,0 +1,14 @@
+test('rust-integration',
+    executable(
+        'rust-integration',
+        files('tests/vmstate_tests.rs'),
+        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        rust_args: ['--test'],
+        install: false,
+        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs]),
+    args: [
+        '--test', '--test-threads', '1',
+        '--format', 'pretty',
+    ],
+    protocol: 'rust',
+    suite: ['unit', 'rust'])
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
similarity index 100%
rename from rust/qemu-api/tests/vmstate_tests.rs
rename to rust/tests/tests/vmstate_tests.rs
-- 
2.51.0


