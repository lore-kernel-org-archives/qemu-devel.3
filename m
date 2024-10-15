Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94E6D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRD-00025k-0U; Tue, 15 Oct 2024 09:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRA-00025V-3N
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hR6-0001Ev-Kb
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvbOSOk5pfxwFgryTrkHWpnMMDPavUiusynCI97arAs=;
 b=IbSZ1Nxgq6d5JdSeE8GOcaxzZ+vEvXt6unSa5AuEX+Whs7lrVK6cAG2ORvJdrHZ8mzA3bu
 mVmneuJo4x0sGT/d8WQHz+BxMFsV0awnpJcQmGKseKqeDf3n4fG51OR49v/FHI/PQjQjC3
 +oVtWev9mgSkOIdEVDaVCq/Mn4V2TmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-x3QoPD4yNK2YHEfsM-bTqw-1; Tue, 15 Oct 2024 09:18:02 -0400
X-MC-Unique: x3QoPD4yNK2YHEfsM-bTqw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43113dab986so47352725e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998281; x=1729603081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvbOSOk5pfxwFgryTrkHWpnMMDPavUiusynCI97arAs=;
 b=istSOAztPEQzwC34M71zKFJjkFcrKl634SwnXVrGpDmLIu9iJApWJcmPH4HSki1S/I
 sNFwMJ6UILcWVkFxz55lTE+XvUV0wUrTqF0bpLFBCeRxcfHfV2pCGfzYMZzISVFeeEKG
 jkDPR1xDwjGEW9nTkC7Nto7YphqbiJ1veBb3AORGiZvcp5Gjy5XMlUEIyNbhiO9PQB0m
 SH8PWRLCorYLz+JulYDFzlHr1QY/fTXU7jSkzDUlkb5jdN3lnqUiYsIRxWk1tAolsvOH
 5lEs+GpmGYJjPZAsncCir/GDOaJyImopXUMOGBc58mu0zspfLI4RyzP6/xAxkrXnXn6S
 x0ZA==
X-Gm-Message-State: AOJu0YyJBXjQxGkEoFFdnP67uV0nowBIeb9IQK2SxaCdWZT/JPGlIrWl
 YCIqKPreIWpXeGlKBiw2x0Mfo1pPmWoixFfXZdENGC1qZv8jBFyiHf7UsybOblrP9XFpB+Ha7Wd
 rt9y++Oj0wiqDKT23mSYV4qnQXx7uNCTj1RMZW7cn/TgxmWqSdbVDfMVcVFpWh1I5rHIALrVlCi
 UeDuK6gaMIvI87dr56gOf84pZnJCIR9q0+YKQCXeM=
X-Received: by 2002:a05:600c:4e13:b0:42c:b9a5:bd95 with SMTP id
 5b1f17b1804b1-43125560014mr130515195e9.0.1728998280658; 
 Tue, 15 Oct 2024 06:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlmy/97pNN32C4ACF2lH9mHWUol1cxRb/hxz3W279ACGfCLzTyoSQ7YR637aKz8xp02KXV7g==
X-Received: by 2002:a05:600c:4e13:b0:42c:b9a5:bd95 with SMTP id
 5b1f17b1804b1-43125560014mr130514715e9.0.1728998279962; 
 Tue, 15 Oct 2024 06:17:59 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314a829abbsm2665635e9.17.2024.10.15.06.17.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] rust: use std::os::raw instead of core::ffi
Date: Tue, 15 Oct 2024 15:17:25 +0200
Message-ID: <20241015131735.518771-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                          |  3 +--
 rust/hw/char/pl011/src/device.rs     | 20 +++++++++++---------
 rust/hw/char/pl011/src/lib.rs        |  2 +-
 rust/hw/char/pl011/src/memory_ops.rs | 10 ++++++----
 rust/qemu-api/src/definitions.rs     |  4 +++-
 rust/qemu-api/src/device_class.rs    |  8 ++++----
 rust/qemu-api/src/lib.rs             |  8 +++++---
 7 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index 2545185014e..175b8d82228 100644
--- a/meson.build
+++ b/meson.build
@@ -3923,14 +3923,13 @@ if have_rust and have_system
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
     '--no-size_t-is-usize',
     '--no-layout-tests',
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index c7193b41bee..cd4c01c2336 100644
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
@@ -532,9 +534,9 @@ pub fn update(&self) {
 /// The buffer and size arguments must also be valid.
 #[no_mangle]
 pub unsafe extern "C" fn pl011_receive(
-    opaque: *mut core::ffi::c_void,
+    opaque: *mut c_void,
     buf: *const u8,
-    size: core::ffi::c_int,
+    size: c_int,
 ) {
     unsafe {
         debug_assert!(!opaque.is_null());
@@ -555,7 +557,7 @@ pub fn update(&self) {
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
 #[no_mangle]
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
index 8d066ebf6d0..2c664fd45ed 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -4,6 +4,8 @@
=20
 use core::{mem::MaybeUninit, ptr::NonNull};
=20
+use std::os::raw::{c_uint, c_void};
+
 use qemu_api::bindings::*;
=20
 use crate::device::PL011State;
@@ -24,9 +26,9 @@
=20
 #[no_mangle]
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
@@ -46,10 +48,10 @@
=20
 #[no_mangle]
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
index 60bd3f8aaa6..aa7cdd69c99 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -4,7 +4,9 @@
=20
 //! Definitions required by QEMU when registering a device.
=20
-use ::core::ffi::{c_void, CStr};
+use std::ffi::CStr;
+
+use std::os::raw::c_void;
=20
 use crate::bindings::{Object, ObjectClass, TypeInfo};
=20
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index 87892b50c63..871063d4a92 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -10,7 +10,7 @@ macro_rules! device_class_init {
         #[no_mangle]
         pub unsafe extern "C" fn $func(
             klass: *mut $crate::bindings::ObjectClass,
-            _: *mut ::core::ffi::c_void,
+            _: *mut ::std::os::raw::c_void,
         ) {
             let mut dc =3D
                 ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::D=
eviceClass>()).unwrap();
@@ -30,7 +30,7 @@ macro_rules! define_property {
         $crate::bindings::Property {
             name: {
                 #[used]
-                static _TEMP: &::core::ffi::CStr =3D $name;
+                static _TEMP: &::std::ffi::CStr =3D $name;
                 _TEMP.as_ptr()
             },
             info: $prop,
@@ -51,7 +51,7 @@ macro_rules! define_property {
         $crate::bindings::Property {
             name: {
                 #[used]
-                static _TEMP: &::core::ffi::CStr =3D $name;
+                static _TEMP: &::std::ffi::CStr =3D $name;
                 _TEMP.as_ptr()
             },
             info: $prop,
@@ -121,7 +121,7 @@ macro_rules! vm_state_description {
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
index e72fb4b4bb1..c2f60ac4727 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -35,6 +35,8 @@ unsafe impl Sync for bindings::VMStateDescription {}
=20
 use std::alloc::{GlobalAlloc, Layout};
=20
+use std::os::raw::c_void;
+
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
 extern "C" {
     fn g_aligned_alloc0(
@@ -47,8 +49,8 @@ fn g_aligned_alloc0(
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
@@ -113,7 +115,7 @@ fn default() -> Self {
 }
=20
 // Sanity check.
-const _: [(); 8] =3D [(); ::core::mem::size_of::<*mut ::core::ffi::c_void>=
()];
+const _: [(); 8] =3D [(); ::core::mem::size_of::<*mut c_void>()];
=20
 unsafe impl GlobalAlloc for QemuAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
--=20
2.46.2


