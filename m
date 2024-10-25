Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADACD149C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mn4-0002yi-SH; Fri, 25 Oct 2024 12:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mmp-0002OF-Gm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mmn-0004s1-Ak
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1AWbbclV6flLDb0VZh8Mn48C06nKC3a8IWhDK0o1WU=;
 b=iAjr6nK4zVGJycVBLNzBAYAos61Q5aMCq8G3A7e5IjAVozGYddzlZAKIBJurgBQbySl16Q
 6iUVGe89cwmWYM6+r1hLLCCjuFSRjlrFrl0hpaiyHD3OVkIQSrRFAuH/fOzN2MH8VtmK2T
 knliLm+e/IuC2keTRjNyvf4Rxk7lwXo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-t2D9Fpf_PmOOdkbQ1RbLMw-1; Fri, 25 Oct 2024 12:03:34 -0400
X-MC-Unique: t2D9Fpf_PmOOdkbQ1RbLMw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c94862c3adso1546564a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872212; x=1730477012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1AWbbclV6flLDb0VZh8Mn48C06nKC3a8IWhDK0o1WU=;
 b=ga1byDNPLoH9tMWxnBla9ytLR/RagCaNDOO2AVQCxvPgsE2jNqXSNtCx3Y0mMkkM3O
 Xe9xDmPe0e/J9dfthaJYykOGmQSi2+sDgnKJ/oQXXQkRzXAfNpQIYCqcvsFe7Z1z4n3S
 vuMmaIVXIYuwwBvHDr4K3W/qHxAgy3w1wpj6Hi8Pk+Ek54Ktg0S383nhZ2GpEvx8jbPK
 Vs66HW8QnvmSJWI9wtbNROTy1zDOjcxW2Qp+UMukyZRQkBHxEjp4vgCOI4XPpFq2DbM/
 HhjDn8y2zd8M2O/TDfPeh3A853IytfDI/3j4fbSatxoMJ3dl1o4bshSbNR/XR4Tu6/W4
 P/qQ==
X-Gm-Message-State: AOJu0YwAnsyN312i7q+ozxpcJ8um1teGiac0zxeLQMzUArbA4ezOYvyd
 SSQ5xvKwZvCOSM5+ghocpNfmEWfl/1XJvWoUg/qiUMDz7bmkMU/XfM15Cw87GGiA6ctas5wpXfz
 sF6ePFdf54CZea2ZTj5kaLdpCANtbifXrlR4Q0p/UxC5J/7PrvRoy6OPGdqLqSZbvy0Hjs0S/No
 /8z543omexjxUMnYdGegbzOrMVrwlat8j4J29FA7k=
X-Received: by 2002:a05:6402:2710:b0:5c8:84a8:5185 with SMTP id
 4fb4d7f45d1cf-5cb8ac37e7bmr8484533a12.6.1729872211748; 
 Fri, 25 Oct 2024 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsiiWJvT/MFQBypq3FPhiRGYaQ1OSqGv4ivGfQOjHxhSP1P3cR8si84K29So5YltfE87UzlA==
X-Received: by 2002:a05:6402:2710:b0:5c8:84a8:5185 with SMTP id
 4fb4d7f45d1cf-5cb8ac37e7bmr8484451a12.6.1729872210794; 
 Fri, 25 Oct 2024 09:03:30 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb62c22d1sm757566a12.45.2024.10.25.09.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:03:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 11/23] rust: introduce a c_str macro
Date: Fri, 25 Oct 2024 18:01:56 +0200
Message-ID: <20241025160209.194307-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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
 rust/hw/char/pl011/src/device_class.rs | 18 ++++-----
 rust/hw/char/pl011/src/lib.rs          |  6 ++-
 rust/qemu-api/meson.build              |  4 ++
 rust/qemu-api/src/c_str.rs             | 53 ++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs               |  1 +
 rust/qemu-api/src/vmstate.rs           |  2 +-
 rust/qemu-api/tests/tests.rs           |  8 ++--
 8 files changed, 78 insertions(+), 19 deletions(-)
 create mode 100644 rust/qemu-api/src/c_str.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index 036757f7f3a..2d225d544de 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,6 +10,7 @@
=20
 use qemu_api::{
     bindings::{self, *},
+    c_str,
     definitions::ObjectImpl,
 };
=20
@@ -135,7 +136,7 @@ impl PL011State {
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
-        const CLK_NAME: &CStr =3D c"clk";
+        const CLK_NAME: &CStr =3D c_str!("clk");
=20
         let dev =3D addr_of_mut!(*self).cast::<DeviceState>();
         // SAFETY:
@@ -598,7 +599,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result=
<(), ()> {
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
index 27cabbd6651..8a2019e5345 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -2,14 +2,12 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use core::{
-    ffi::{c_int, c_void},
-    ptr::NonNull,
-};
+use core::ptr::NonNull;
+use std::os::raw::{c_int, c_void};
=20
 use qemu_api::{
-    bindings::*, vmstate_clock, vmstate_fields, vmstate_int32, vmstate_sub=
sections, vmstate_uint32,
-    vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
+    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_int32, vmst=
ate_subsections,
+    vmstate_uint32, vmstate_uint32_array, vmstate_unused, zeroable::Zeroab=
le,
 };
=20
 use crate::device::{PL011State, PL011_FIFO_DEPTH};
@@ -24,7 +22,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> =
bool {
=20
 /// Migration subsection for [`PL011State`] clock.
 pub static VMSTATE_PL011_CLOCK: VMStateDescription =3D VMStateDescription {
-    name: c"pl011/clock".as_ptr(),
+    name: c_str!("pl011/clock").as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(pl011_clock_needed),
@@ -43,7 +41,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, versio=
n_id: c_int) -> c_int {
 }
=20
 pub static VMSTATE_PL011: VMStateDescription =3D VMStateDescription {
-    name: c"pl011".as_ptr(),
+    name: c_str!("pl011").as_ptr(),
     version_id: 2,
     minimum_version_id: 2,
     post_load: Some(pl011_post_load),
@@ -74,14 +72,14 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, vers=
ion_id: c_int) -> c_int {
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
index a539062aa30..a98d5cf9574 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -41,12 +41,14 @@
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
-pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr =3D c"pl011_luminary";
+pub const TYPE_PL011: &::std::ffi::CStr =3D c_str!("pl011");
+pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr =3D c_str!("pl011_luminar=
y");
=20
 /// Offset of each register from the base memory address of the device.
 ///
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 3b849f7c413..c950b008d59 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,6 +3,7 @@ _qemu_api_rs =3D static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
       'src/vmstate.rs',
@@ -18,6 +19,9 @@ _qemu_api_rs =3D static_library(
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
index 00000000000..cc6d8dc1211
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
+            if i =3D=3D b.len() - 1 {
+            } else if b[i] =3D=3D 0 {
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
index ed840ee2f72..e6bd953e10b 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -29,6 +29,7 @@ unsafe impl Sync for bindings::VMStateDescription {}
 unsafe impl Sync for bindings::VMStateField {}
 unsafe impl Sync for bindings::VMStateInfo {}
=20
+pub mod c_str;
 pub mod definitions;
 pub mod device_class;
 pub mod vmstate;
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 5dd783a902a..0aaaef1c7c8 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -14,7 +14,7 @@
 macro_rules! vmstate_unused_buffer {
     ($field_exists_fn:expr, $version_id:expr, $size:expr) =3D> {{
         $crate::bindings::VMStateField {
-            name: c"unused".as_ptr(),
+            name: c_str!("unused").as_ptr(),
             err_hint: ::core::ptr::null(),
             offset: 0,
             size: $size,
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index c7089f0cf21..381ac84657b 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -6,7 +6,7 @@
=20
 use qemu_api::{
     bindings::*,
-    declare_properties, define_property,
+    c_str, declare_properties, define_property,
     definitions::{Class, ObjectImpl},
     device_class_init,
     zeroable::Zeroable,
@@ -16,7 +16,7 @@
 fn test_device_decl_macros() {
     // Test that macros can compile.
     pub static VMSTATE: VMStateDescription =3D VMStateDescription {
-        name: c"name".as_ptr(),
+        name: c_str!("name").as_ptr(),
         unmigratable: true,
         ..Zeroable::ZERO
     };
@@ -36,7 +36,7 @@ pub struct DummyClass {
     declare_properties! {
         DUMMY_PROPERTIES,
             define_property!(
-                c"migrate-clk",
+                c_str!("migrate-clk"),
                 DummyState,
                 migrate_clock,
                 unsafe { &qdev_prop_bool },
@@ -55,7 +55,7 @@ pub struct DummyClass {
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
2.47.0


