Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3104BD1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BqJ-0004rx-Ma; Tue, 22 Oct 2024 06:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqH-0004rf-Dp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqF-0004NZ-Lq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoIDQehBCXOq+hK5SCx2x9E41Nu5lYrh5jQDtEdUC3E=;
 b=ZLx3XUaufF5hGfTBT6VX/Ob4ZMiuXLnI8FHhExlkp+NbH6Q/thYlVDo+t7rlYZRztcT4+M
 V5oOFIj35DStUjdMn10vB9QQfW2TACxRkeIleQHyVx/txqGSJi+wOISLTihJ3K2gmVaX3m
 Kfzrzb1JBJ4Neu0yGmZmeplAeldReYA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-VdRURoNlNmGiDy8JdBteMw-1; Tue, 22 Oct 2024 06:10:17 -0400
X-MC-Unique: VdRURoNlNmGiDy8JdBteMw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d47fdbbd6so3187099f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591816; x=1730196616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoIDQehBCXOq+hK5SCx2x9E41Nu5lYrh5jQDtEdUC3E=;
 b=uqYYVe+fkXZRSa5sdNwcTLZErJNEBW9HXgAXFw4CCNr/4fPblBHxmoF7LGanRefQjU
 y4t6TxN/yii3EPcmfRQ6SFs9DNjFo90l0g8a3tExX8Zba8zHX4uGOF6qPGIuM969wWpv
 Si14PkQ3v2tltJMPyDeUduWLi6zXx5ynSK2OIjdYuRJw6Jag8y0fOsd9QPUFD0dtoXGS
 ZLHlnCd7cXte6Kp1NPxbyECUMvFcjF3DwEuAfMg2Y7bIlJcOzbHKSCQnDXj2bMWd/24O
 /rRKm+d2BNfPlzuobvPfvEdR6efXUIPRvi0i4viS3XcD6rJpLZGdoYeJvCYf/Maetx6B
 FYbQ==
X-Gm-Message-State: AOJu0Yw8JlUfQyggKHPbyPgkYxopGK2yL6g7QeRYkbUr2IKaHuV41iRL
 qAsuCsGmB43CIesZFPJWOozYpL6QEIlBKitUO2GFOZrvYYNfDbbgLkR3CisRK0wi2Lv9v+ETK91
 VEpgFBvXp37i5pvC9Q7LtBJe+0qUip8fIw2EJm5Tbo5wloLxsN5JUI/L41doAdI3qaFdy8uREpm
 zVs7QTKFQm6Tz7TQcxwU7XjkTXn6bTWOeLQXawTp8=
X-Received: by 2002:adf:f491:0:b0:37d:47f9:be8a with SMTP id
 ffacd0b85a97d-37ef2040d72mr1443619f8f.0.1729591815616; 
 Tue, 22 Oct 2024 03:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV/5Fa5LQjFFaW5cFo+BfLBeWWn3KlkerhQymuadx9IzZ/+riWB9rstO66wqBfjZMuNIiW8A==
X-Received: by 2002:adf:f491:0:b0:37d:47f9:be8a with SMTP id
 ffacd0b85a97d-37ef2040d72mr1443546f8f.0.1729591813778; 
 Tue, 22 Oct 2024 03:10:13 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f570dd5sm83879455e9.3.2024.10.22.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 04/14] rust: introduce a c_str macro
Date: Tue, 22 Oct 2024 12:09:45 +0200
Message-ID: <20241022100956.196657-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This allows CStr constants to be defined easily on Rust 1.63.0, while
checking that there are no embedded NULs.  c"" literals were only
stabilized in Rust 1.77.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  5 ++-
 rust/hw/char/pl011/src/device_class.rs |  5 ++-
 rust/hw/char/pl011/src/lib.rs          |  4 +-
 rust/qemu-api/meson.build              |  4 ++
 rust/qemu-api/src/c_str.rs             | 53 ++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/tests/tests.rs           |  8 ++--
 7 files changed, 71 insertions(+), 9 deletions(-)
 create mode 100644 rust/qemu-api/src/c_str.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index 7be21769ae4..5ffe1911376 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -11,6 +11,7 @@
=20
 use qemu_api::{
     bindings::{self, *},
+    c_str,
     definitions::ObjectImpl,
 };
=20
@@ -99,7 +100,7 @@ impl qemu_api::definitions::Class for PL011Class {
 }
=20
 #[used]
-pub static CLK_NAME: &CStr =3D c"clk";
+pub static CLK_NAME: &CStr =3D c_str!("clk");
=20
 impl PL011State {
     /// Initializes a pre-allocated, unitialized instance of `PL011State`.
@@ -575,7 +576,7 @@ pub fn update(&self) {
         let dev: *mut DeviceState =3D qdev_new(PL011State::TYPE_INFO.name);
         let sysbus: *mut SysBusDevice =3D dev.cast::<SysBusDevice>();
=20
-        qdev_prop_set_chr(dev, c"chardev".as_ptr(), chr);
+        qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
         sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mu=
t Error);
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/sr=
c/device_class.rs
index 78fa1cdd5b6..3b9b0267b4c 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -6,6 +6,7 @@
=20
 use qemu_api::{
     bindings::*,
+    c_str,
     definitions::ObjectImpl,
     zeroable::Zeroable,
 };
@@ -22,14 +23,14 @@
 qemu_api::declare_properties! {
     PL011_PROPERTIES,
     qemu_api::define_property!(
-        c"chardev",
+        c_str!("chardev"),
         PL011State,
         char_backend,
         unsafe { &qdev_prop_chr },
         CharBackend
     ),
     qemu_api::define_property!(
-        c"migrate-clk",
+        c_str!("migrate-clk"),
         PL011State,
         migrate_clock,
         unsafe { &qdev_prop_bool },
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2b157868b0f..0a598e5629d 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -41,11 +41,13 @@
 extern crate bilge_impl;
 extern crate qemu_api;
=20
+use qemu_api::c_str;
+
 pub mod device;
 pub mod device_class;
 pub mod memory_ops;
=20
-pub const TYPE_PL011: &::std::ffi::CStr =3D c"pl011";
+pub const TYPE_PL011: &::std::ffi::CStr =3D c_str!("pl011");
=20
 /// Offset of each register from the base memory address of the device.
 ///
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 1b0fd406378..2b3dea59fb6 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,6 +3,7 @@ _qemu_api_rs =3D static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
       'src/zeroable.rs',
@@ -17,6 +18,9 @@ _qemu_api_rs =3D static_library(
   ],
 )
=20
+rust.test('rust-qemu-api-tests', _qemu_api_rs,
+          suite: ['unit', 'rust'])
+
 qemu_api =3D declare_dependency(
   link_with: _qemu_api_rs,
   dependencies: qemu_api_macros,
diff --git a/rust/qemu-api/src/c_str.rs b/rust/qemu-api/src/c_str.rs
new file mode 100644
index 00000000000..5ef46d12bef
--- /dev/null
+++ b/rust/qemu-api/src/c_str.rs
@@ -0,0 +1,53 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[macro_export]
+/// Given a string constant _without_ embedded or trailing NULs, return
+/// a CStr.
+///
+/// Needed for compatibility with Rust <1.77.
+macro_rules! c_str {
+    ($str:expr) =3D> {{
+        const STRING: &str =3D concat!($str, "\0");
+        const BYTES: &[u8] =3D STRING.as_bytes();
+
+        // "for" is not allowed in const context... oh well,
+        // everybody loves some lisp.  This could be turned into
+        // a procedural macro if this is a problem; alternatively
+        // Rust 1.72 makes CStr::from_bytes_with_nul a const function.
+        const fn f(b: &[u8], i: usize) {
+            if i =3D=3D BYTES.len() - 1 {
+            } else if BYTES[i] =3D=3D 0 {
+                panic!("c_str argument contains NUL")
+            } else {
+                f(b, i + 1)
+            }
+        }
+        f(BYTES, 0);
+
+        // SAFETY: absence of NULs apart from the final byte was checked a=
bove
+        unsafe { std::ffi::CStr::from_bytes_with_nul_unchecked(BYTES) }
+    }};
+}
+
+#[cfg(test)]
+mod tests {
+    use std::ffi::CStr;
+
+    use crate::c_str;
+
+    #[test]
+    fn test_cstr_macro() {
+        let good =3D c_str!("=F0=9F=A6=80");
+        let good_bytes =3D b"\xf0\x9f\xa6\x80\0";
+        assert_eq!(good.to_bytes_with_nul(), good_bytes);
+    }
+
+    #[test]
+    fn test_cstr_macro_const() {
+        const GOOD: &CStr =3D c_str!("=F0=9F=A6=80");
+        const GOOD_BYTES: &[u8] =3D b"\xf0\x9f\xa6\x80\0";
+        assert_eq!(GOOD.to_bytes_with_nul(), GOOD_BYTES);
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 321c33d2c7b..9c3be4f6489 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -27,6 +27,7 @@ unsafe impl Sync for bindings::Property {}
 unsafe impl Sync for bindings::TypeInfo {}
 unsafe impl Sync for bindings::VMStateDescription {}
=20
+pub mod c_str;
 pub mod definitions;
 pub mod device_class;
 pub mod zeroable;
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 3396c33fe1e..605bc99ed4c 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -6,7 +6,7 @@
=20
 use qemu_api::{
     bindings::*,
-    declare_properties, define_property,
+    c_str, declare_properties, define_property,
     definitions::{Class, ObjectImpl},
     device_class_init, vm_state_description,
 };
@@ -16,7 +16,7 @@ fn test_device_decl_macros() {
     // Test that macros can compile.
     vm_state_description! {
         VMSTATE,
-        name: c"name",
+        name: c_str!("name"),
         unmigratable: true,
     }
=20
@@ -35,7 +35,7 @@ pub struct DummyClass {
     declare_properties! {
         DUMMY_PROPERTIES,
             define_property!(
-                c"migrate-clk",
+                c_str!("migrate-clk"),
                 DummyState,
                 migrate_clock,
                 unsafe { &qdev_prop_bool },
@@ -54,7 +54,7 @@ pub struct DummyClass {
     impl ObjectImpl for DummyState {
         type Class =3D DummyClass;
         const TYPE_INFO: qemu_api::bindings::TypeInfo =3D qemu_api::type_i=
nfo! { Self };
-        const TYPE_NAME: &'static CStr =3D c"dummy";
+        const TYPE_NAME: &'static CStr =3D c_str!("dummy");
         const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(TYPE_DEVICE=
);
         const ABSTRACT: bool =3D false;
         const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)=
> =3D None;
--=20
2.46.2


