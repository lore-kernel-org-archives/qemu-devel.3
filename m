Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FBC54736
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIs-00038j-DS; Tue, 27 Aug 2024 07:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIq-0002zt-8x
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:24:00 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIm-0000kv-KY
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:24:00 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso8016119a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757835; x=1725362635; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ohqu+It40QRHzc//RGQ9VAfV//MOlOSNKWa9txWnvI0=;
 b=vOr3MftZV8RRmBUSmXy9rpOWUudFBL2IM5e7PwGD7+Qm82m/44atENTfPehOPAInFW
 0cmkUMhDVTCjlhQ2VCwwlVA+RA1h/F1y8SVLVOiS2oU067ATGIDIojcyBE9WjCl0fti8
 vXeq4tarZwi389MRwZpjuOdJeFQQIo6u9+bKncGU3XtWRNtej5MqUOERi6TKFOHL0X5v
 k8m3c+MuEcBj0FFob2y8jVDpZygDEJu7yNYKVNwWtyRnomuboehGuCxfBTSzCinrbcBV
 wLWKWAhq/xijvXFls48cQzv5pXYZWMwvGLPtr2z7S1TdPgI2lB2KNuw9bdQ32htsYo04
 7RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757835; x=1725362635;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohqu+It40QRHzc//RGQ9VAfV//MOlOSNKWa9txWnvI0=;
 b=iPiGFDVfXIGMrBAIyT4PKdoNJJeJm+sCndgKD5Ri3ebbaZrocw6ADvJzv2OgCtJwXb
 sRiAzArTSnEhSzwz3mjjtevEfghAtoFZXO6bBx2CeUI/btKPFDowiNxu8eetZulUcfOa
 3qmphqKImzS+qq+A8swPt6dRnFpbckY16vl+aAUOSuOE5EGjB+E4gEtS/Zds0K6ba0ZF
 cSKez0eaG6SA0ehD/16WKLRNs3VuYYwa0tf+Q89SMJX1XVqxy79n6Ye6xGyD23lt6GDI
 VVum7oZBNMDZNuuyvMdmxkbMzhp8/G10MbdZOs9010U/kxI2h45LCev9sl7ztuEgHms1
 1ckg==
X-Gm-Message-State: AOJu0Yx1a8GeC/1xFVYmnaFKzPv/CajSmiYcIxTACymyt/R/Nn3NscVL
 MHI/03AiVe9iNJ3DaiDuO70aAkgFaadLd5Z2egpnG92W1JMD7CyklSOajD99UZs=
X-Google-Smtp-Source: AGHT+IFxKiQelfUhNTgQt7vnOC3/GK0uEWcVhyAQuxx0ImKG5s5qrEDgUV7uKuBKrEOoyvwHx6IhQw==
X-Received: by 2002:a17:906:c105:b0:a86:9204:1c87 with SMTP id
 a640c23a62f3a-a86a516303dmr1044796166b.11.1724757834557; 
 Tue, 27 Aug 2024 04:23:54 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:53 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:16 +0300
Subject: [PATCH v9 7/9] rust: add crate to expose bindings and interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rust-pl011-v9-7-e90b9c28f861@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21462;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=OUrPQRsPa5AbLZl8Fm0K3yzqcwvDx/PlcGwW+GlLFLU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMxMXVqSGlEVmhvYXBNVG52SWV6bGdRaEk2CkZXQ0R4NzBSK3NqaWhxdGRK
 cU9KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05RQUt
 DUkIzS2Nkd2YzNEowUFZjRC9vQ0dtUUtHUEx0RmZoR2JxazdBUEdLWExEREQzTHhiTjkxbU93eg
 pQNmpNUmRjOFF3WHd4ODYwRGF4dmVBMUF6SnUzeTRLQnhZMi9sTDdUWThIZ2tIOFYvbnQ1UHNhU
 WxhWklYYW5tCkFLd3NsaFlST3lQMGhibE9aL1c1Z1M3WkVDQ3p5a1JCcEJBM0ExVHpNV2pWdU9p
 L1dTRDB1aDEzOVgwRmVxVTkKZ1pEZFJCOG5JUlhkVENLYkVpdFVBaFBHSmNGZXZEVWo1OG4xbWV
 keU56cjduWnZxbS9CdTVDUi91ekdobXM2aAo2RnkxZXQzdVM3cStkeXcrL2Q3aExuK0FvQ3RVRX
 EzdFlxUk5kWWRNVFkwWmVLV0FJU0owakFhbmJYa0Frb012CjN4eHNvc253d0dVSWVmRDBMelBjW
 kVDSkNkYlNMM2paUEQ5UnZqbS9PTUVqZUZOZTZyaytSMVpRRm1MSVdxTXIKVEc0dlNUQjkzd1p3
 T3B3Y0JyS3JZc1lYaXlCaFJOQ3N3SXhOWWdkUkw1U3E4cFRVamxnd2h0eW5hWTdnbSsrcQpUOWh
 wMHZFQmZIRkg3c3dHRFRYVjNLKzRJZEhZaEY1dFA4OTBqb2p2UDVmWVdvblJnK2wvc2RBUExVaS
 tWOVNsCjVReUp6Q1l2ZlFsMnBtUE8rWjhNaytNeWVBRUlwV3F2YW5YYXVVcVpQQU01Ymw5TDBJb
 EpleGZWcXNLNFNKeGgKcUJibGV0TG9yNUNDMUxoUlNqQnZBT0FNb1FYY0VKWjhxY1ZrZE51MWQw
 RVArVEwvYTY2TUJUR2xyaFhEcTJTQQpPMHBaL29mNlFsSUZON1hQbmNvcVA4TG1TZC9nRm8vVW9
 RMC84Wml2RUlrbitFeEJUcDBKOVJNZklDaDd1eENvCnNXeFZVQT09Cj12NnVMCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
provides some declaration macros for symbols visible to the rest of
QEMU.

Co-authored-by: Junjie Mao <junjie.mao@intel.com>
Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Junjie Mao <junjie.mao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                       |   6 ++
 rust/meson.build                  |   1 +
 rust/qemu-api/.gitignore          |   2 +
 rust/qemu-api/Cargo.lock          |   7 ++
 rust/qemu-api/Cargo.toml          |  26 +++++++
 rust/qemu-api/README.md           |  17 +++++
 rust/qemu-api/build.rs            |  14 ++++
 rust/qemu-api/meson.build         |  21 ++++++
 rust/qemu-api/src/definitions.rs  | 109 +++++++++++++++++++++++++++
 rust/qemu-api/src/device_class.rs | 128 +++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs          | 154 ++++++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/tests.rs        |  49 ++++++++++++
 rust/rustfmt.toml                 |   7 ++
 13 files changed, 541 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 642c07a9ff..d35e9f6b20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3348,6 +3348,12 @@ F: hw/core/register.c
 F: include/hw/register.h
 F: include/hw/registerfields.h
 
+Rust
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: rust/qemu-api
+F: rust/rustfmt.toml
+
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
diff --git a/rust/meson.build b/rust/meson.build
index e69de29bb2..4a58d106b1 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -0,0 +1 @@
+subdir('qemu-api')
diff --git a/rust/qemu-api/.gitignore b/rust/qemu-api/.gitignore
new file mode 100644
index 0000000000..b9e7e004c8
--- /dev/null
+++ b/rust/qemu-api/.gitignore
@@ -0,0 +1,2 @@
+# Ignore generated bindings file overrides.
+src/bindings.rs
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
new file mode 100644
index 0000000000..e9c51a243a
--- /dev/null
+++ b/rust/qemu-api/Cargo.lock
@@ -0,0 +1,7 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "qemu_api"
+version = "0.1.0"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
new file mode 100644
index 0000000000..efc369e5ae
--- /dev/null
+++ b/rust/qemu-api/Cargo.toml
@@ -0,0 +1,26 @@
+[package]
+name = "qemu_api"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "Rust bindings for QEMU"
+repository = "https://gitlab.com/qemu-project/qemu/"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[dependencies]
+
+[features]
+default = ["allocator"]
+allocator = []
+
+# Do not include in any global workspace
+[workspace]
+
+[lints.rust]
+unexpected_cfgs = { level = "warn", check-cfg = ['cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)'] }
diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
new file mode 100644
index 0000000000..7588fa29ef
--- /dev/null
+++ b/rust/qemu-api/README.md
@@ -0,0 +1,17 @@
+# QEMU bindings and API wrappers
+
+This library exports helper Rust types, Rust macros and C FFI bindings for internal QEMU APIs.
+
+The C bindings can be generated with `bindgen`, using this build target:
+
+```console
+$ ninja bindings.rs
+```
+
+## Generate Rust documentation
+
+To generate docs for this crate, including private items:
+
+```sh
+cargo doc --no-deps --document-private-items
+```
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
new file mode 100644
index 0000000000..419b154c2d
--- /dev/null
+++ b/rust/qemu-api/build.rs
@@ -0,0 +1,14 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::path::Path;
+
+fn main() {
+    if !Path::new("src/bindings.rs").exists() {
+        panic!(
+            "No generated C bindings found! Either build them manually with bindgen or with meson \
+             (`ninja bindings.rs`) and copy them to src/bindings.rs, or build through meson."
+        );
+    }
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
new file mode 100644
index 0000000000..cf2b465e9f
--- /dev/null
+++ b/rust/qemu-api/meson.build
@@ -0,0 +1,21 @@
+_qemu_api_rs = static_library(
+  'qemu_api',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/definitions.rs',
+      'src/device_class.rs',
+    ],
+    {'.' : bindings_rs},
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: rustc_config_args + [
+    '--cfg', 'MESON',
+    '--cfg', 'feature="allocator"',
+  ],
+)
+
+qemu_api = declare_dependency(
+  link_with: _qemu_api_rs,
+)
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
new file mode 100644
index 0000000000..4abd0253bd
--- /dev/null
+++ b/rust/qemu-api/src/definitions.rs
@@ -0,0 +1,109 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Definitions required by QEMU when registering a device.
+
+/// Trait a type must implement to be registered with QEMU.
+pub trait ObjectImpl {
+    type Class;
+    const TYPE_INFO: crate::bindings::TypeInfo;
+    const TYPE_NAME: &'static ::core::ffi::CStr;
+    const PARENT_TYPE_NAME: Option<&'static ::core::ffi::CStr>;
+    const INSTANCE_INIT: ::core::option::Option<
+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
+    >;
+    const INSTANCE_POST_INIT: ::core::option::Option<
+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
+    >;
+    const INSTANCE_FINALIZE: ::core::option::Option<
+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
+    >;
+    const ABSTRACT: bool;
+}
+
+pub trait Class {
+    const CLASS_INIT: ::core::option::Option<
+        unsafe extern "C" fn(
+            klass: *mut crate::bindings::ObjectClass,
+            data: *mut core::ffi::c_void,
+        ),
+    >;
+    const CLASS_BASE_INIT: ::core::option::Option<
+        unsafe extern "C" fn(
+            klass: *mut crate::bindings::ObjectClass,
+            data: *mut core::ffi::c_void,
+        ),
+    >;
+}
+
+#[macro_export]
+macro_rules! module_init {
+    ($func:expr, $type:expr) => {
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static LOAD_MODULE: extern "C" fn() = {
+            assert!($type < $crate::bindings::module_init_type_MODULE_INIT_MAX);
+
+            extern "C" fn __load() {
+                unsafe {
+                    $crate::bindings::register_module_init(Some($func), $type);
+                }
+            }
+
+            __load
+        };
+    };
+    (qom: $func:ident => $body:block) => {
+        // NOTE: To have custom identifiers for the ctor func we need to either supply
+        // them directly as a macro argument or create them with a proc macro.
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static LOAD_MODULE: extern "C" fn() = {
+            extern "C" fn __load() {
+                #[no_mangle]
+                unsafe extern "C" fn $func() {
+                    $body
+                }
+
+                unsafe {
+                    $crate::bindings::register_module_init(
+                        Some($func),
+                        $crate::bindings::module_init_type_MODULE_INIT_QOM,
+                    );
+                }
+            }
+
+            __load
+        };
+    };
+}
+
+#[macro_export]
+macro_rules! type_info {
+    ($t:ty) => {
+        $crate::bindings::TypeInfo {
+            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
+            parent: if let Some(pname) = <$t as $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
+                pname.as_ptr()
+            } else {
+                ::core::ptr::null_mut()
+            },
+            instance_size: ::core::mem::size_of::<$t>(),
+            instance_align: ::core::mem::align_of::<$t>(),
+            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
+            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
+            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
+            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
+            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
+            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
+            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
+            class_data: ::core::ptr::null_mut(),
+            interfaces: ::core::ptr::null_mut(),
+        };
+    }
+}
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
new file mode 100644
index 0000000000..69ee912c33
--- /dev/null
+++ b/rust/qemu-api/src/device_class.rs
@@ -0,0 +1,128 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::sync::OnceLock;
+
+use crate::bindings::Property;
+
+#[macro_export]
+macro_rules! device_class_init {
+    ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, reset_fn => $reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
+        #[no_mangle]
+        pub unsafe extern "C" fn $func(
+            klass: *mut $crate::bindings::ObjectClass,
+            _: *mut ::core::ffi::c_void,
+        ) {
+            let mut dc =
+                ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
+            dc.as_mut().realize = $realize_fn;
+            dc.as_mut().reset = $reset_fn;
+            dc.as_mut().vmsd = &$vmsd;
+            $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
+        }
+    };
+}
+
+#[macro_export]
+macro_rules! define_property {
+    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
+        $crate::bindings::Property {
+            name: {
+                #[used]
+                static _TEMP: &::core::ffi::CStr = $name;
+                _TEMP.as_ptr()
+            },
+            info: $prop,
+            offset: ::core::mem::offset_of!($state, $field)
+                .try_into()
+                .expect("Could not fit offset value to type"),
+            bitnr: 0,
+            bitmask: 0,
+            set_default: true,
+            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
+            arrayoffset: 0,
+            arrayinfo: ::core::ptr::null(),
+            arrayfieldsize: 0,
+            link_type: ::core::ptr::null(),
+        }
+    };
+    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
+        $crate::bindings::Property {
+            name: {
+                #[used]
+                static _TEMP: &::core::ffi::CStr = $name;
+                _TEMP.as_ptr()
+            },
+            info: $prop,
+            offset: ::core::mem::offset_of!($state, $field)
+                .try_into()
+                .expect("Could not fit offset value to type"),
+            bitnr: 0,
+            bitmask: 0,
+            set_default: false,
+            defval: $crate::bindings::Property__bindgen_ty_1 { i: 0 },
+            arrayoffset: 0,
+            arrayinfo: ::core::ptr::null(),
+            arrayfieldsize: 0,
+            link_type: ::core::ptr::null(),
+        }
+    };
+}
+
+#[repr(C)]
+pub struct Properties<const N: usize>(pub OnceLock<[Property; N]>, pub fn() -> [Property; N]);
+
+impl<const N: usize> Properties<N> {
+    pub fn as_mut_ptr(&mut self) -> *mut Property {
+        _ = self.0.get_or_init(self.1);
+        self.0.get_mut().unwrap().as_mut_ptr()
+    }
+}
+
+#[macro_export]
+macro_rules! declare_properties {
+    ($ident:ident, $($prop:expr),*$(,)*) => {
+
+        const fn _calc_prop_len() -> usize {
+            let mut len = 1;
+            $({
+                _ = stringify!($prop);
+                len += 1;
+            })*
+            len
+        }
+        const PROP_LEN: usize = _calc_prop_len();
+
+        fn _make_properties() -> [$crate::bindings::Property; PROP_LEN] {
+            [
+                $($prop),*,
+                    unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
+            ]
+        }
+
+        #[no_mangle]
+        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
+    };
+}
+
+#[macro_export]
+macro_rules! vm_state_description {
+    ($(#[$outer:meta])*
+     $name:ident,
+     $(name: $vname:expr,)*
+     $(unmigratable: $um_val:expr,)*
+    ) => {
+        #[used]
+        $(#[$outer])*
+        pub static $name: $crate::bindings::VMStateDescription = $crate::bindings::VMStateDescription {
+            $(name: {
+                #[used]
+                static VMSTATE_NAME: &::core::ffi::CStr = $vname;
+                $vname.as_ptr()
+            },)*
+            unmigratable: true,
+            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStateDescription>::zeroed().assume_init() }
+        };
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
new file mode 100644
index 0000000000..2663702490
--- /dev/null
+++ b/rust/qemu-api/src/lib.rs
@@ -0,0 +1,154 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
+
+#[allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    clippy::missing_const_for_fn,
+    clippy::too_many_arguments,
+    clippy::approx_constant,
+    clippy::use_self,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+)]
+#[rustfmt::skip]
+pub mod bindings;
+
+unsafe impl Send for bindings::Property {}
+unsafe impl Sync for bindings::Property {}
+unsafe impl Sync for bindings::TypeInfo {}
+unsafe impl Sync for bindings::VMStateDescription {}
+
+pub mod definitions;
+pub mod device_class;
+
+#[cfg(test)]
+mod tests;
+
+use std::alloc::{GlobalAlloc, Layout};
+
+#[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
+extern "C" {
+    fn g_aligned_alloc0(
+        n_blocks: bindings::gsize,
+        n_block_bytes: bindings::gsize,
+        alignment: bindings::gsize,
+    ) -> bindings::gpointer;
+    fn g_aligned_free(mem: bindings::gpointer);
+}
+
+#[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
+extern "C" {
+    fn qemu_memalign(alignment: usize, size: usize) -> *mut ::core::ffi::c_void;
+    fn qemu_vfree(ptr: *mut ::core::ffi::c_void);
+}
+
+extern "C" {
+    fn g_malloc0(n_bytes: bindings::gsize) -> bindings::gpointer;
+    fn g_free(mem: bindings::gpointer);
+}
+
+/// An allocator that uses the same allocator as QEMU in C.
+///
+/// It is enabled by default with the `allocator` feature.
+///
+/// To set it up manually as a global allocator in your crate:
+///
+/// ```ignore
+/// use qemu_api::QemuAllocator;
+///
+/// #[global_allocator]
+/// static GLOBAL: QemuAllocator = QemuAllocator::new();
+/// ```
+#[derive(Clone, Copy, Debug)]
+#[repr(C)]
+pub struct QemuAllocator {
+    _unused: [u8; 0],
+}
+
+#[cfg_attr(all(feature = "allocator", not(test)), global_allocator)]
+pub static GLOBAL: QemuAllocator = QemuAllocator::new();
+
+impl QemuAllocator {
+    // From the glibc documentation, on GNU systems, malloc guarantees 16-byte
+    // alignment on 64-bit systems and 8-byte alignment on 32-bit systems. See
+    // https://www.gnu.org/software/libc/manual/html_node/Malloc-Examples.html.
+    // This alignment guarantee also applies to Windows and Android. On Darwin
+    // and OpenBSD, the alignment is 16 bytes on both 64-bit and 32-bit systems.
+    #[cfg(all(
+        target_pointer_width = "32",
+        not(any(target_os = "macos", target_os = "openbsd"))
+    ))]
+    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = Some(8);
+    #[cfg(all(
+        target_pointer_width = "64",
+        not(any(target_os = "macos", target_os = "openbsd"))
+    ))]
+    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = Some(16);
+    #[cfg(all(
+        any(target_pointer_width = "32", target_pointer_width = "64"),
+        any(target_os = "macos", target_os = "openbsd")
+    ))]
+    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = Some(16);
+    #[cfg(not(any(target_pointer_width = "32", target_pointer_width = "64")))]
+    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = None;
+
+    pub const fn new() -> Self {
+        Self { _unused: [] }
+    }
+}
+
+impl Default for QemuAllocator {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+// Sanity check.
+const _: [(); 8] = [(); ::core::mem::size_of::<*mut ::core::ffi::c_void>()];
+
+unsafe impl GlobalAlloc for QemuAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        if matches!(Self::DEFAULT_ALIGNMENT_BYTES, Some(default) if default.checked_rem(layout.align()) == Some(0))
+        {
+            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
+        } else {
+            #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
+            {
+                g_aligned_alloc0(
+                    layout.size().try_into().unwrap(),
+                    1,
+                    (8 * layout.align()).try_into().unwrap(),
+                )
+                .cast::<u8>()
+            }
+            #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
+            {
+                qemu_memalign(8 * layout.align(), layout.size()).cast::<u8>()
+            }
+        }
+    }
+
+    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
+        if matches!(Self::DEFAULT_ALIGNMENT_BYTES, Some(default) if default.checked_rem(layout.align()) == Some(0))
+        {
+            g_free(ptr.cast::<_>())
+        } else {
+            #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
+            {
+                g_aligned_free(ptr.cast::<_>())
+            }
+            #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
+            {
+                qemu_vfree(ptr.cast::<_>())
+            }
+        }
+    }
+}
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
new file mode 100644
index 0000000000..df54edbd4e
--- /dev/null
+++ b/rust/qemu-api/src/tests.rs
@@ -0,0 +1,49 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use crate::{
+    bindings::*, declare_properties, define_property, device_class_init, vm_state_description,
+};
+
+#[test]
+fn test_device_decl_macros() {
+    // Test that macros can compile.
+    vm_state_description! {
+        VMSTATE,
+        name: c"name",
+        unmigratable: true,
+    }
+
+    #[repr(C)]
+    pub struct DummyState {
+        pub char_backend: CharBackend,
+        pub migrate_clock: bool,
+    }
+
+    declare_properties! {
+        DUMMY_PROPERTIES,
+            define_property!(
+                c"chardev",
+                DummyState,
+                char_backend,
+                unsafe { &qdev_prop_chr },
+                CharBackend
+            ),
+            define_property!(
+                c"migrate-clk",
+                DummyState,
+                migrate_clock,
+                unsafe { &qdev_prop_bool },
+                bool
+            ),
+    }
+
+    device_class_init! {
+        dummy_class_init,
+        props => DUMMY_PROPERTIES,
+        realize_fn => None,
+        reset_fn => None,
+        vmsd => VMSTATE,
+    }
+}
diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
new file mode 100644
index 0000000000..ebecb99fe0
--- /dev/null
+++ b/rust/rustfmt.toml
@@ -0,0 +1,7 @@
+edition = "2021"
+format_generated_files = false
+format_code_in_doc_comments = true
+format_strings = true
+imports_granularity = "Crate"
+group_imports = "StdExternalCrate"
+wrap_comments = true

-- 
2.45.2


