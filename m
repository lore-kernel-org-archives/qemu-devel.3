Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AC1C54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIt-0003Dv-Nk; Tue, 27 Aug 2024 07:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIr-00035z-OI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:24:01 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIp-0000m8-Ht
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:24:01 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5334b0e1a8eso7050819e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757838; x=1725362638; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i3+mtYYzHBBtikw1zXv7DKh3kbgt/BPOlVSFhrrwD3U=;
 b=ZhJA0H+SvtZoocw+RXVT2O/bMhDBpSrxzXzHMxv/aj6nPYPfr047WGP2sSj48KhPfb
 W919ymkRhxt9tsQF6P79gsVjcUfNUvX56bVzE/OVPeb4pP/C5Qpa4vRfF0ZnvMfR+uqQ
 XCSZOONKGgFgZwnLrzSTZt/w3wmXXehdYDYCJfTVj4oaK1gJdKvKUu6q7bA6NhYdLnsb
 AA5fbgVvG9G1Bg0ARrvwFoxyccXhJrdJ5dg9UHYhYM1gb/fUg37mcsQXJLw9CHfPT8vQ
 HKNFzy8Egxg+o5yEicNs2kfZZvj+epyO36RuTQTCJp92bWv8VWAS89oUQHo0ClHIli6H
 4KOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757838; x=1725362638;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3+mtYYzHBBtikw1zXv7DKh3kbgt/BPOlVSFhrrwD3U=;
 b=nMDFC9Cw4aYD7xTsLVqDjz9ggdmybyg9dBqbK3xNXCDCjKPFtxa4oM7Ri29vAlpLy9
 XUpdFx1ijk3M85mfln3xOIYyVQMcMDnbOduntxsn5gGPR7bDovDufgT3EK9fVTBrgzIy
 8YmDZHqXK1+uYkhhfjFhcHPPxA5lcmTBturd9Ob+Zdr4UjJKwRVkGwahfHdLqRZLsFae
 BYnBnVklDFkv3vPISY9Wu/3vvIQtXbX6lAYt0cQUzGsY5XM3BxLrADFRloii1S7dzSu4
 OXCPVPIGnLTU1ve/fUj9oowcrX+OxAK1r8kl9nzCaohJ0/2XWCoTffuyxnHlb2UwKkeu
 f5JA==
X-Gm-Message-State: AOJu0Yx0SpLhO/ANUbrLQCnJccTtFnX+UIgP0slsDsbRjlUpwFSa4YRY
 20cUDXLJPUV5vhsv7ImFTOBf3PwuVAzmP+nR9978dhTMZBz12OlCRu5ycYryK/8=
X-Google-Smtp-Source: AGHT+IEgcwR6GVifVq0roSHsxuggrkgrC43Ux+87MXb3CEuQN73rQHe4B6TVeJRIJmXN8w3SeconZA==
X-Received: by 2002:a05:6512:3b26:b0:52c:e084:bb1e with SMTP id
 2adb3069b0e04-534387783d0mr8983460e87.13.1724757837136; 
 Tue, 27 Aug 2024 04:23:57 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:56 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:17 +0300
Subject: [PATCH v9 8/9] rust: add utility procedural macro crate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rust-pl011-v9-8-e90b9c28f861@linaro.org>
References: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
In-Reply-To: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
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
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=7063;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=WqLWGjMMrP33Qrl9SCmBKmJw/e75wdTkZmQfueIPGPk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMxakoya0lvM2gxZy83c0FMQ0V3KzNqcEtSCjBNeTdOMWNudmE0VTU4eG9t
 bjJKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05RQUt
 DUkIzS2Nkd2YzNEowTER1RC80dk44NVhjY0R4dkVrNEpTcnBPU1kyMnY2a08xeWpUelREeWpKKw
 pEK3ZLZjdGRVNuMjE3WXAwN2tjNDJEbW9yOUtwelloZE8vZ29JdlBLWnFqTFlkeXlGR2xoV09Pc
 2hvSkdpemZpCjJNOE5zYmEzUFZkOHRlYkhraHExM3RnQjZlUGNHNUxvM1RydW43ZWNIUXJYT3BE
 OFhJZ3VPOHk0L0dFZmVnQnoKbnJscFU2dDRzZnhQaHAvVTRLVW5jUUtkcHp6bWlmVDlEMElUOGx
 yb3FoSVc5Vys3VHRVa3RxU2kxdHVHbzVhMQp5bnRpanhtUGtOalB4cXpPWW1GVlJFcTZCZmxHaz
 V6YkdCM1NlYXBOQnYvY1pPV0NQSWh3L09CYlZ0dVJLWmh3Ck1pMXBkSEc5MFZmNTgrMkZIS1FrT
 jlPSHg5U0E5d1F0SXBTUXM0K3VjL2JEbTg3eVh6UlRUdm81bk1tWXNYMG0KcUYyZ3pzZUF6RWxH
 L2ZuWjhHb2pyLzVXZ2NmeTI3MUtoTEc5Y1FWUXFzS2w0T0tOK1VQL3h3a1NCZGlBLzFCNgpRWVl
 Lc3RqNFl6R2NFNDh1azJrTFIzUjZQSURjSEE1ZzQxM3QyOVo1bU5LS1NqckFoYlk4WTNWNVRoYX
 YwNmwyCllpY3pvVFA1T3VoUU9wRmxTbzJBMndBdzBoQUM0SlpVWDZESi9XYjN5Zm9vd0V1U2Ivd
 zhRZUVjbnhBSTNFYlYKbjhKT1NvclBjTjcwaFptQjhDLzZJRk5HUHB3YVdlR2xISWo0U0FBemdu
 eWlsWVFzNGtsRXJ2Q1YxQ1dVRW5BYwpuVzI0Sms0aXhMZHVrVWJ4aXFKR1JGVHBhZXE5WWVzNll
 Qb2R2NFF2S2JwNkR2alkvOVhZRXJjclFYT2xMMDVLCkJHbXlJZz09Cj11ZU5NCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12e.google.com
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
index d35e9f6b20..727f3a7a2c 100644
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
index 4a58d106b1..7a32b1b195 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1 +1,2 @@
+subdir('qemu-api-macros')
 subdir('qemu-api')
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
new file mode 100644
index 0000000000..fdc0fce116
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
index 0000000000..144cc3650f
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
index 0000000000..f60f54ac4b
--- /dev/null
+++ b/rust/qemu-api-macros/README.md
@@ -0,0 +1 @@
+# `qemu-api-macros` - Utility macros for defining QEMU devices
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
new file mode 100644
index 0000000000..48af91ed38
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
index 0000000000..331bc9e215
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
index cf2b465e9f..2030c24ed9 100644
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


