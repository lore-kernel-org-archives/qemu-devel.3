Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD49C5474A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjA2y-0006KW-5q; Wed, 28 Aug 2024 00:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2t-00064a-FZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:35 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2r-0000mU-1y
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:35 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso9291766a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724818351; x=1725423151; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PS8BB3FWvG/qWytireMjd1erjq7vy7tFLolrwsIWluI=;
 b=HqNUkX+lovLV6UcUj8TFSu1GS2B4nIXOTtCorl/xZY6xZZ3kahS41UcuYemUa9qDuP
 7tsJnocuP5t189i1j9T15R0pPXW9a/pWgXsQSXOypdiWcUDHaG7TF/hbUO9YE894oPfV
 N04LjVTVQwsm2Sw2KPXu/ddmv/0TYjl59a2pNcogm9UDPHM9r/ZWp77/hps6rM3X+Pul
 zuH/sM2I43y+67AhsFe1U5ZzyvEhsw+Yt6pqAsvbbdU8b+Pnu0eVNLfGm4p1bixdx1ed
 rSiqQKzz7/3109aEiK17fcquUg8VjUUXBj71lnBeWthwPL4H4OhUjQ9RY3d/KRpX2LBP
 eL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724818351; x=1725423151;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PS8BB3FWvG/qWytireMjd1erjq7vy7tFLolrwsIWluI=;
 b=v+DwFzL1Mlb46yZNKZp1NKZqXrW1PEcbtRE5AbkDlrlPHGNA3KWXfO+3H5FQVsdAig
 dLMpD5PF1bxRT7oYZjcb/5mUyioTyhmJK/2PUNuvkt+FFTidiJab1AUDt7pGu01HGbwO
 0iwKKleGR9OEnDf4ykAfATZpcn/By7sLqkeJntNbveDoCIHNdbh8cuVeuT5eQLBvdBf5
 f8T9lyrljK2zvUn1E/hUw/jgrla27hmIswJrwzwWA96SrpVKWVpHwbSD4cnmeUK9gRqZ
 JNsOdUyxIV55JZYYX0Iq7EgsAHHE9gli3h5yfR+m5l3FbHU6A/qoc43XAHgLP9Magcr/
 xzWA==
X-Gm-Message-State: AOJu0YyhDijhZ4MgbotgCzpoPkV6iTRf6gsqJh6xMDwv4RAfy6IcWkza
 pXNfBYLtaJiTempY6wZzOaavWTlcAR+++L7xFa8tlehBoZVPaX1lICZ0LslPkcA=
X-Google-Smtp-Source: AGHT+IG0F+v9RLfkDxmCogKyohbRv4HN/JSfXRuG/k5c7DYt81vKAXl+hJXm5aWNs9OgY5xMKmIKag==
X-Received: by 2002:a05:6402:1941:b0:5bf:dd0:93ad with SMTP id
 4fb4d7f45d1cf-5c0891a293amr8774775a12.27.1724818351072; 
 Tue, 27 Aug 2024 21:12:31 -0700 (PDT)
Received: from [127.0.1.1] (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb1c29b9sm1712814a12.18.2024.08.27.21.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:12:30 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 28 Aug 2024 07:11:49 +0300
Subject: [PATCH RESEND v9 8/9] rust: add utility procedural macro crate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-rust-pl011-v9-8-35579191f17c@linaro.org>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=7543;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=ZxB9ieSoYRaqCxkSAitiBS3RFAT8Cug415DHJ1Rmjvo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16cU9MMXF0N2hzU0FDUXgrQjFOL3oxZ3pzQW9rCkJzQXlMd3RXMXluU0dncUhx
 YStKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnM2aml3QUt
 DUkIzS2Nkd2YzNEowRm5KRUFDWFRKblpoODl6S2NBNjhRTkdKNFBuNkIzbm10UTE4NmlzZSsyMw
 pFUDE0V3pYQlhNcWd4azEySjdHTGlYdEJBT2Fpdm9ldk5RNDdBT1NzWWdiNFZaSXVpV2lNUGJsN
 3E1UGJhbXMzCkVkdTVJNnNvVDV4V1JwanNyUnVYUFZ5UVUrQjdrQnB4VW8vL3N5dFA3U1dTS3NQ
 VGErWU1SSmdoZmU1bFNvMUgKRmVzY1pXM0FRSFJIME9IUWMrYmtqQk5kaXZla082a095Z0pxSFh
 IS3pkdGNSeEROV0grb3RQMFNLdmpaWEJvVQpQSDkxOHlWTUNQQXhuVnZOemdGT2ZFOEtkblQvVF
 gwanVSSU1Ua0NNT2tnZUJyeUNGNTU0aGlLNWllbXpBNzBhCmJDenRTY2VmVjJ6RkUwT00xbjVpN
 TQ5U1BxQXpUWVRUNjZmTklsbnlSOStmRjRIa253R3FKeE9RR2NUYTVLT2MKR3IvMmtMNFlTellj
 ZHZhcW1ONmZzMDB4MC83RnAyTU15Q3ZkS3pVT0V2RzFaWjFjWVo5UmFiSUJRamVVWms2TApnOEV
 UNkI1Mm5YSldRdTV3RkNOMzl1VHpTN3ZBNFVrSlNsd04vQktwbS8ycTN6bkhjWGdwLzY3M3NFUV
 EwSGdkCnNIeGEzK0hubmNNV09WQ1hKU3htRDBVSndPcjBTdXE4Z3ZMMVR2UXY3bGVqL2RZSEY3R
 UhZejY2Qnd0Z1laVUwKNWZHOUJWcGNRMDJWVkJxZkc3dUZkN2N2YlVwQTR3b1hQbjNkR0JlY3My
 d3lueVZtK0tFcTYvdGxQWEJndzRJKwpEWEFwQUNmVXNRL2dCUHlXVVhSVHo5M202cXRUYzFMaSt
 hai96MTM0Q05VQVVYbTJ6RVV5RzVvZDRvRjVXdG0rCnhlSHFhQT09Cj1VdnRrCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit adds a helper crate library, qemu-api-macros for derive (and
other procedural) macros to be used along qemu-api.

It needs to be a separate library because in Rust, procedural macros, or
macros that can generate arbitrary code, need to be special separate
compilation units.

Only one macro is introduced in this patch, #[derive(Object)]. It
generates a constructor to register a QOM TypeInfo on init and it must
be used on types that implement qemu_api::definitions::ObjectImpl trait.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                      |  1 +
 rust/meson.build                 |  1 +
 rust/qemu-api-macros/Cargo.lock  | 47 ++++++++++++++++++++++++++++++++++++++++
 rust/qemu-api-macros/Cargo.toml  | 25 +++++++++++++++++++++
 rust/qemu-api-macros/README.md   |  1 +
 rust/qemu-api-macros/meson.build | 25 +++++++++++++++++++++
 rust/qemu-api-macros/src/lib.rs  | 43 ++++++++++++++++++++++++++++++++++++
 rust/qemu-api/meson.build        |  3 +++
 8 files changed, 146 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d35e9f6b20bb23c7580de488ebaabc6c031343d2..727f3a7a2cfe600ffdb861bafada7db415d020e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3352,6 +3352,7 @@ Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/qemu-api
+F: rust/qemu-api-macros
 F: rust/rustfmt.toml
 
 SLIRP
diff --git a/rust/meson.build b/rust/meson.build
index 4a58d106b1dd1d7bee39dd129f57ddb5a95bd9b7..7a32b1b195083571931ad589965c10ddaf6383b1 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1 +1,2 @@
+subdir('qemu-api-macros')
 subdir('qemu-api')
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
new file mode 100644
index 0000000000000000000000000000000000000000..fdc0fce116c795da63fff3cfcddab164c98d47fa
--- /dev/null
+++ b/rust/qemu-api-macros/Cargo.lock
@@ -0,0 +1,47 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.86"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "qemu_api_macros"
+version = "0.1.0"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.36"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "syn"
+version = "2.0.72"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.12"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
new file mode 100644
index 0000000000000000000000000000000000000000..144cc3650fa04b2fa35a1185d970e1bab210a4eb
--- /dev/null
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -0,0 +1,25 @@
+[package]
+name = "qemu_api_macros"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "Rust bindings for QEMU - Utility macros"
+repository = "https://gitlab.com/qemu-project/qemu/"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[lib]
+proc-macro = true
+
+[dependencies]
+proc-macro2 = "1"
+quote = "1"
+syn = "2"
+
+# Do not include in any global workspace
+[workspace]
diff --git a/rust/qemu-api-macros/README.md b/rust/qemu-api-macros/README.md
new file mode 100644
index 0000000000000000000000000000000000000000..f60f54ac4be08ccfbcfea8e21ceb15d25012dfc3
--- /dev/null
+++ b/rust/qemu-api-macros/README.md
@@ -0,0 +1 @@
+# `qemu-api-macros` - Utility macros for defining QEMU devices
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..48af91ed389120ddd6e15f6ee002f5da7063e329
--- /dev/null
+++ b/rust/qemu-api-macros/meson.build
@@ -0,0 +1,25 @@
+add_languages('rust', required: true, native: true)
+
+quote_dep = dependency('quote-1-rs', native: true)
+syn_dep = dependency('syn-2-rs', native: true)
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+
+_qemu_api_macros_rs = import('rust').proc_macro(
+  'qemu_api_macros',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_args: [
+    '--cfg', 'use_fallback',
+    '--cfg', 'feature="syn-error"',
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    proc_macro2_dep,
+    quote_dep,
+    syn_dep,
+  ],
+)
+
+qemu_api_macros = declare_dependency(
+  link_with: _qemu_api_macros_rs,
+)
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
new file mode 100644
index 0000000000000000000000000000000000000000..331bc9e215e0115191865cb8a29c4605e03fdaa8
--- /dev/null
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -0,0 +1,43 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use proc_macro::TokenStream;
+use quote::{format_ident, quote};
+use syn::{parse_macro_input, DeriveInput};
+
+#[proc_macro_derive(Object)]
+pub fn derive_object(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+
+    let name = input.ident;
+    let module_static = format_ident!("__{}_LOAD_MODULE", name);
+
+    let expanded = quote! {
+        #[allow(non_upper_case_globals)]
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static #module_static: extern "C" fn() = {
+            extern "C" fn __register() {
+                unsafe {
+                    ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
+                }
+            }
+
+            extern "C" fn __load() {
+                unsafe {
+                    ::qemu_api::bindings::register_module_init(
+                        Some(__register),
+                        ::qemu_api::bindings::module_init_type_MODULE_INIT_QOM
+                    );
+                }
+            }
+
+            __load
+        };
+    };
+
+    TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index cf2b465e9f7cc7fb10af0d3aac469b58211cd64e..2030c24ed980596da0d53944252409e535510195 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -14,6 +14,9 @@ _qemu_api_rs = static_library(
     '--cfg', 'MESON',
     '--cfg', 'feature="allocator"',
   ],
+  dependencies: [
+    qemu_api_macros,
+  ],
 )
 
 qemu_api = declare_dependency(

-- 
2.45.2


