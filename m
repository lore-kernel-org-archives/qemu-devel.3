Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCABD68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzNi-0006WQ-8u; Fri, 15 Nov 2024 11:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNJ-0006Gm-2K
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNE-0002Jk-Ls
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxrtk5aMMaKYzRzX6De6/Aykasa/8z/jP3nArnuWvHc=;
 b=DDFuhswRhKkYvloTB5+R+6A2X8PoMZj/v0d/GfFrb0akGbIJxNdEO36w+Bwrdvsv5H2yJ/
 IUm4hHFm1R1jbl/I3KB6FoSpyrOFbzXjyywmAcwW0X7KZkUOymUHGk12CFtsPT9toFj/Yt
 kMFNlTKu/L7c869ighz4LnP0IVPVVOA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-93DbIRBSMXe-nVDZS_GfyA-1; Fri, 15 Nov 2024 11:40:38 -0500
X-MC-Unique: 93DbIRBSMXe-nVDZS_GfyA-1
X-Mimecast-MFC-AGG-ID: 93DbIRBSMXe-nVDZS_GfyA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so1124745f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:40:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688833; x=1732293633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gxrtk5aMMaKYzRzX6De6/Aykasa/8z/jP3nArnuWvHc=;
 b=wAwAo19SiWv+0QI7L8YzW7GpCslO/slI/YWXVjiFOA2KmKdMt3GjKZakXBD4b57YqB
 TzpODUx//Bq0jTEbg3EoeGgt/diu3haaOms7pmfVrtuERPbxBX4PlLoAkJrgr6m2X6XD
 VcXKyLQH/m+dqZxN1FA0kJLIkRajgBFkcEP3RoSV+wBnlHff+kP1EHxgUIXusSbsxfrD
 2wvtn2lFMtFQlyhYlP9B95haItL6hJf56Wzehd5FQ7AX7zKvY0J+sLdxj+ftUF7B5oPO
 jYCRHfuSMNgafmI7sSZpeq6ydQgli4DCMJ6ea0i2nEo/oOt45Sxv8vRbWHvZ7CWMKr6r
 vduA==
X-Gm-Message-State: AOJu0YxFrOzZ9kEnvuAJRj6Kbv859Hu5A/mguxC1hQFjFoLpzaIqpB6y
 gI3nm+hd5pOcXDRIyAfZ31YoAvvVK6Ys4np2ialdD89haCoZ8+oTQcKxhqC8mE/Nx4sCTNcqF6R
 k8rfchKXY1nUSNWI3MkEqQU5uLUD1PJQFghNTXB1uLrTs/eysZg6K8NWyCh52FWogG8n0o8IsLQ
 gV/MK5lwnZ6DuHTwEadwYuFzbJ+Coi4vRxjdA9ONg=
X-Received: by 2002:a05:6000:a0c:b0:382:1ade:83ee with SMTP id
 ffacd0b85a97d-3822590646emr2974182f8f.23.1731688832586; 
 Fri, 15 Nov 2024 08:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYj3w5nuQz4f9pxFQUHSDBKEbvnUwx0bl56+NOw6uuR2PC31PB65FEaoVu9xjpUGyi33sPBA==
X-Received: by 2002:a05:6000:a0c:b0:382:1ade:83ee with SMTP id
 ffacd0b85a97d-3822590646emr2974151f8f.23.1731688831965; 
 Fri, 15 Nov 2024 08:40:31 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38229b6e2fasm1218830f8f.40.2024.11.15.08.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:40:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 02/12] rust: allow using build-root bindings.rs from cargo
Date: Fri, 15 Nov 2024 17:40:15 +0100
Message-ID: <20241115164025.1917618-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Right now, using cargo with QEMU requires copying by hand the bindings.rs to the
source tree.  Instead, we can use an include file to escape the cage of cargo's
mandated source directory structure.

By running cargo within meson's "devenv" and adding a MESON_BUILD_ROOT
environment variable, it is easy for build.rs to find the file.  However, the
file must be symlinked into cargo's output directory for rust-analyzer to find
it.

Suggested-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   |  4 +++-
 rust/hw/char/pl011/.gitignore |  2 --
 rust/qemu-api/.gitignore      |  2 +-
 rust/qemu-api/README.md       |  4 ++--
 rust/qemu-api/build.rs        | 34 +++++++++++++++++++++++++++-------
 rust/qemu-api/meson.build     |  1 +
 rust/qemu-api/src/bindings.rs | 29 +++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs      | 22 ----------------------
 8 files changed, 63 insertions(+), 35 deletions(-)
 delete mode 100644 rust/hw/char/pl011/.gitignore
 create mode 100644 rust/qemu-api/src/bindings.rs

diff --git a/meson.build b/meson.build
index a6172524287..8def5f67bb5 100644
--- a/meson.build
+++ b/meson.build
@@ -3,6 +3,8 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
 
+meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
+
 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
 add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
 add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
@@ -4090,7 +4092,7 @@ if have_rust
   bindings_rs = rust.bindgen(
     input: 'rust/wrapper.h',
     dependencies: common_ss.all_dependencies(),
-    output: 'bindings.rs',
+    output: 'bindings.inc.rs',
     include_directories: include_directories('.', 'include'),
     bindgen_version: ['>=0.60.0'],
     args: bindgen_args,
diff --git a/rust/hw/char/pl011/.gitignore b/rust/hw/char/pl011/.gitignore
deleted file mode 100644
index 71eaff2035d..00000000000
--- a/rust/hw/char/pl011/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# Ignore generated bindings file overrides.
-src/bindings.rs.inc
diff --git a/rust/qemu-api/.gitignore b/rust/qemu-api/.gitignore
index b9e7e004c86..df6c2163e03 100644
--- a/rust/qemu-api/.gitignore
+++ b/rust/qemu-api/.gitignore
@@ -1,2 +1,2 @@
 # Ignore generated bindings file overrides.
-src/bindings.rs
+/src/bindings.inc.rs
diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
index 7588fa29ef3..53810f48882 100644
--- a/rust/qemu-api/README.md
+++ b/rust/qemu-api/README.md
@@ -5,7 +5,7 @@ This library exports helper Rust types, Rust macros and C FFI bindings for inter
 The C bindings can be generated with `bindgen`, using this build target:
 
 ```console
-$ ninja bindings.rs
+$ ninja bindings.inc.rs
 ```
 
 ## Generate Rust documentation
@@ -13,5 +13,5 @@ $ ninja bindings.rs
 To generate docs for this crate, including private items:
 
 ```sh
-cargo doc --no-deps --document-private-items
+pyvenv/bin/meson devenv -w ../rust cargo doc --no-deps --document-private-items
 ```
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 20f8f718b90..06e79082b5f 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -2,22 +2,42 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::path::Path;
+#[cfg(unix)]
+use std::os::unix::fs::symlink as symlink_file;
+#[cfg(windows)]
+use std::os::windows::fs::symlink_file;
+use std::{env, fs::remove_file, io::Result, path::Path};
 
 use version_check as rustc;
 
-fn main() {
-    if !Path::new("src/bindings.rs").exists() {
-        panic!(
-            "No generated C bindings found! Either build them manually with bindgen or with meson \
-             (`ninja bindings.rs`) and copy them to src/bindings.rs, or build through meson."
-        );
+fn main() -> Result<()> {
+    // Placing bindings.inc.rs in the source directory is supported
+    // but not documented or encouraged.
+    let path = env::var("MESON_BUILD_ROOT")
+        .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
+
+    let file = format!("{}/bindings.inc.rs", path);
+    let file = Path::new(&file);
+    if !Path::new(&file).exists() {
+        panic!(concat!(
+            "No generated C bindings found! If you want to run `cargo`, start a subshell\n",
+            "with `meson devenv`, or point MESON_BUILD_ROOT to the top of the build tree."
+        ));
     }
 
+    let out_dir = env::var("OUT_DIR").unwrap();
+    let dest_path = format!("{}/bindings.inc.rs", out_dir);
+    let dest_path = Path::new(&dest_path);
+    if dest_path.symlink_metadata().is_ok() {
+        remove_file(dest_path)?;
+    }
+    symlink_file(file, dest_path)?;
+
     // Check for available rustc features
     if rustc::is_min_version("1.77.0").unwrap_or(false) {
         println!("cargo:rustc-cfg=has_offset_of");
     }
 
     println!("cargo:rerun-if-changed=build.rs");
+    Ok(())
 }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index cad9ac4844e..3be7b7e5ced 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -9,6 +9,7 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/bindings.rs',
       'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
new file mode 100644
index 00000000000..0b76ec58bee
--- /dev/null
+++ b/rust/qemu-api/src/bindings.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unsafe_op_in_unsafe_fn,
+    clippy::missing_const_for_fn,
+    clippy::too_many_arguments,
+    clippy::approx_constant,
+    clippy::use_self,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc
+)]
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+unsafe impl Send for Property {}
+unsafe impl Sync for Property {}
+unsafe impl Sync for TypeInfo {}
+unsafe impl Sync for VMStateDescription {}
+unsafe impl Sync for VMStateField {}
+unsafe impl Sync for VMStateInfo {}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index aa8d16ec94b..440aff3817d 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -4,31 +4,9 @@
 
 #![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
 
-#[allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unsafe_op_in_unsafe_fn,
-    clippy::missing_const_for_fn,
-    clippy::too_many_arguments,
-    clippy::approx_constant,
-    clippy::use_self,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc,
-)]
 #[rustfmt::skip]
 pub mod bindings;
 
-unsafe impl Send for bindings::Property {}
-unsafe impl Sync for bindings::Property {}
-unsafe impl Sync for bindings::TypeInfo {}
-unsafe impl Sync for bindings::VMStateDescription {}
-unsafe impl Sync for bindings::VMStateField {}
-unsafe impl Sync for bindings::VMStateInfo {}
-
 pub mod c_str;
 pub mod definitions;
 pub mod device_class;
-- 
2.47.0


