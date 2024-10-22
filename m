Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA87D1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BqN-0004sE-Vf; Tue, 22 Oct 2024 06:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqH-0004rg-Hn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqF-0004NT-KF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QP7e8UEKzoE0KB/7pMJdUtY48ENaf+OvkadNUEq9q/I=;
 b=i5ClNuk8EW9YOCsPXla+Ysdqq5sspTwHqfA7+m7CDx8lwiHvpFk07zfvvGe21VFhDPE6ni
 8AHqER5Jxs40kDt4CQy/4xHViqc/z27zcyBbIFE/WZG27SaymKUafQGFsrGyu7NcAA5iNG
 pS4mEpurjlZR+PgfPKAlTAgo445qn+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-72yTXa1zMeCcGtSN-8kvGQ-1; Tue, 22 Oct 2024 06:10:14 -0400
X-MC-Unique: 72yTXa1zMeCcGtSN-8kvGQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315af466d9so37788005e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591811; x=1730196611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QP7e8UEKzoE0KB/7pMJdUtY48ENaf+OvkadNUEq9q/I=;
 b=bgVs2Mge0SV76PshRipqKu4MbPWKIo81pGbcGOvU87bS5eWAMU4whSpcFBgMEY8KLw
 GDK8+CxsrM8yRBuB2L+yaSMoXlbXjwTxQhHI+nOzGfN60BWdtCHfapMHS6/pzEckFPgG
 Y/YonjPg1eKV46KML8SwQJxLypdR1R6p4tGX77w/whIfsxak13bU+YOnyewOMGU1zzOB
 wz1T77HxBO74HrQU6yVM8Dze9Wb7Sv7oNAumh3JiOLVnIAWOWZMTqOHMas2uBerm95KE
 x7NUBTqVdKn/yyiZPdH2W9PUqdW5xdCgPQiw3P1rmKHm0aRf+NblO1Hc5ZyQgIQ9pjKk
 t8Ag==
X-Gm-Message-State: AOJu0YzrprFsY3IZ0NKg1LYYBIWMcHy9Tq0p0qN3guZ9ZsUUdGDVL1j9
 x/vfxxqh7AplIfAUJh7qxELUFXWd/RqmCOL6B54tWjR8yZ9A0HBtf0QXEgqMUS7KQzV6f0EXBgb
 ThJuc+ORaupuvad3lNMqTN/ZxaiYNa20rkZvY6BmCfIRyl+Ft8+YjJKLCyZR0UeUtGiFx43DlPf
 iXbCLMLb03198PLmDlpJWUgWqzEtW1clfSHJ2S7c8=
X-Received: by 2002:a05:600c:5121:b0:431:4b88:d408 with SMTP id
 5b1f17b1804b1-4316163520emr125197345e9.5.1729591810586; 
 Tue, 22 Oct 2024 03:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJv4+Fr3Onxrgwi+Sa76xEiyaIS92rbONOREWRZWq3Lwox9lcdRK9+O73Eb9AYtVl+pPT6Yg==
X-Received: by 2002:a05:600c:5121:b0:431:4b88:d408 with SMTP id
 5b1f17b1804b1-4316163520emr125197025e9.5.1729591810012; 
 Tue, 22 Oct 2024 03:10:10 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f58f0efsm84440045e9.26.2024.10.22.03.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 03/14] rust: use std::os::raw instead of core::ffi
Date: Tue, 22 Oct 2024 12:09:44 +0200
Message-ID: <20241022100956.196657-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

core::ffi::c_* types were introduced in Rust 1.64.0.  Use the older types
in std::os::raw, which are now aliases of the types in core::ffi.  There is
no need to compile QEMU as no_std, so this is acceptable as long as we supp=
ort
a version of Debian with Rust 1.63.0.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                          |  3 +--
 rust/hw/char/pl011/src/device.rs     | 20 +++++++++++---------
 rust/hw/char/pl011/src/lib.rs        |  2 +-
 rust/hw/char/pl011/src/memory_ops.rs | 10 ++++++----
 rust/qemu-api/src/definitions.rs     |  2 +-
 rust/qemu-api/src/device_class.rs    |  8 ++++----
 rust/qemu-api/src/lib.rs             | 11 +++++++----
 rust/qemu-api/tests/tests.rs         |  9 ++++-----
 8 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/meson.build b/meson.build
index 3c71d129494..94f30033f68 100644
--- a/meson.build
+++ b/meson.build
@@ -3933,14 +3933,13 @@ if have_rust and have_system
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
-    '--ctypes-prefix', 'core::ffi',
+    '--ctypes-prefix', 'std::os::raw',
     '--formatter', 'rustfmt',
     '--generate-block',
     '--generate-cstr',
     '--impl-debug',
     '--merge-extern-blocks',
     '--no-doc-comments',
-    '--use-core',
     '--with-derive-default',
     '--no-layout-tests',
     '--no-prepend-enum-name',
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index b3d8bc004e0..7be21769ae4 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,9 +2,11 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use core::{
-    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
-    ptr::{addr_of, addr_of_mut, NonNull},
+use core::ptr::{addr_of, addr_of_mut, NonNull};
+
+use std::{
+    ffi::CStr,
+    os::raw::{c_int, c_uchar, c_uint, c_void}
 };
=20
 use qemu_api::{
@@ -89,10 +91,10 @@ pub struct PL011Class {
=20
 impl qemu_api::definitions::Class for PL011Class {
     const CLASS_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     > =3D Some(crate::device_class::pl011_class_init);
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     > =3D None;
 }
=20
@@ -151,7 +153,7 @@ pub unsafe fn init(&mut self) {
     pub fn read(
         &mut self,
         offset: hwaddr,
-        _size: core::ffi::c_uint,
+        _size: c_uint,
     ) -> std::ops::ControlFlow<u64, u64> {
         use RegisterOffset::*;
=20
@@ -530,9 +532,9 @@ pub fn update(&self) {
 ///
 /// The buffer and size arguments must also be valid.
 pub unsafe extern "C" fn pl011_receive(
-    opaque: *mut core::ffi::c_void,
+    opaque: *mut c_void,
     buf: *const u8,
-    size: core::ffi::c_int,
+    size: c_int,
 ) {
     unsafe {
         debug_assert!(!opaque.is_null());
@@ -552,7 +554,7 @@ pub fn update(&self) {
 /// We expect the FFI user of this function to pass a valid pointer, that =
has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event=
: QEMUChrEvent) {
+pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEv=
ent) {
     unsafe {
         debug_assert!(!opaque.is_null());
         let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>=
());
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2939ee50c99..2b157868b0f 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -45,7 +45,7 @@
 pub mod device_class;
 pub mod memory_ops;
=20
-pub const TYPE_PL011: &::core::ffi::CStr =3D c"pl011";
+pub const TYPE_PL011: &::std::ffi::CStr =3D c"pl011";
=20
 /// Offset of each register from the base memory address of the device.
 ///
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/=
memory_ops.rs
index 24ac9c870c1..6d822027d51 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -4,6 +4,8 @@
=20
 use core::ptr::NonNull;
=20
+use std::os::raw::{c_uint, c_void};
+
 use qemu_api::{
     bindings::*,
     zeroable::Zeroable
@@ -26,9 +28,9 @@
 };
=20
 unsafe extern "C" fn pl011_read(
-    opaque: *mut core::ffi::c_void,
+    opaque: *mut c_void,
     addr: hwaddr,
-    size: core::ffi::c_uint,
+    size: c_uint,
 ) -> u64 {
     assert!(!opaque.is_null());
     let mut state =3D unsafe { NonNull::new_unchecked(opaque.cast::<PL011S=
tate>()) };
@@ -47,10 +49,10 @@
 }
=20
 unsafe extern "C" fn pl011_write(
-    opaque: *mut core::ffi::c_void,
+    opaque: *mut c_void,
     addr: hwaddr,
     data: u64,
-    _size: core::ffi::c_uint,
+    _size: c_uint,
 ) {
     unsafe {
         assert!(!opaque.is_null());
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitio=
ns.rs
index 064afe60549..26597934bbd 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -4,7 +4,7 @@
=20
 //! Definitions required by QEMU when registering a device.
=20
-use ::core::ffi::{c_void, CStr};
+use std::{ffi::CStr, os::raw::c_void};
=20
 use crate::bindings::{Object, ObjectClass, TypeInfo};
=20
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index ed2d7ce1a54..5c305d945d3 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -7,7 +7,7 @@ macro_rules! device_class_init {
     ($func:ident, props =3D> $props:ident, realize_fn =3D> $realize_fn:exp=
r, legacy_reset_fn =3D> $legacy_reset_fn:expr, vmsd =3D> $vmsd:ident$(,)*) =
=3D> {
         pub unsafe extern "C" fn $func(
             klass: *mut $crate::bindings::ObjectClass,
-            _: *mut ::core::ffi::c_void,
+            _: *mut ::std::os::raw::c_void,
         ) {
             let mut dc =3D
                 ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::D=
eviceClass>()).unwrap();
@@ -26,7 +26,7 @@ macro_rules! define_property {
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default =
=3D $defval:expr$(,)*) =3D> {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-            name: ::core::ffi::CStr::as_ptr($name),
+            name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
@@ -37,7 +37,7 @@ macro_rules! define_property {
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) =3D>=
 {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-            name: ::core::ffi::CStr::as_ptr($name),
+            name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: false,
@@ -75,7 +75,7 @@ macro_rules! vm_state_description {
         pub static $name: $crate::bindings::VMStateDescription =3D $crate:=
:bindings::VMStateDescription {
             $(name: {
                 #[used]
-                static VMSTATE_NAME: &::core::ffi::CStr =3D $vname;
+                static VMSTATE_NAME: &::std::ffi::CStr =3D $vname;
                 $vname.as_ptr()
             },)*
             unmigratable: true,
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index e94a15bb823..321c33d2c7b 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -31,7 +31,10 @@ unsafe impl Sync for bindings::VMStateDescription {}
 pub mod device_class;
 pub mod zeroable;
=20
-use std::alloc::{GlobalAlloc, Layout};
+use std::{
+    alloc::{GlobalAlloc, Layout},
+    os::raw::c_void,
+};
=20
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
 extern "C" {
@@ -45,8 +48,8 @@ fn g_aligned_alloc0(
=20
 #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
 extern "C" {
-    fn qemu_memalign(alignment: usize, size: usize) -> *mut ::core::ffi::c=
_void;
-    fn qemu_vfree(ptr: *mut ::core::ffi::c_void);
+    fn qemu_memalign(alignment: usize, size: usize) -> *mut c_void;
+    fn qemu_vfree(ptr: *mut c_void);
 }
=20
 extern "C" {
@@ -111,7 +114,7 @@ fn default() -> Self {
 }
=20
 // Sanity check.
-const _: [(); 8] =3D [(); ::core::mem::size_of::<*mut ::core::ffi::c_void>=
()];
+const _: [(); 8] =3D [(); ::core::mem::size_of::<*mut c_void>()];
=20
 unsafe impl GlobalAlloc for QemuAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index aa1e0568c69..3396c33fe1e 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use core::ffi::CStr;
+use std::{ffi::CStr, os::raw::c_void};
=20
 use qemu_api::{
     bindings::*,
@@ -63,11 +63,10 @@ impl ObjectImpl for DummyState {
     }
=20
     impl Class for DummyClass {
-        const CLASS_INIT: Option<
-            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core:=
:ffi::c_void),
-        > =3D Some(dummy_class_init);
+        const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectCl=
ass, data: *mut c_void)> =3D
+            Some(dummy_class_init);
         const CLASS_BASE_INIT: Option<
-            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core:=
:ffi::c_void),
+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_voi=
d),
         > =3D None;
     }
=20
--=20
2.46.2


