Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A6DD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sU-000633-Bt; Mon, 04 Nov 2024 12:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sS-0005ru-Bi
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sN-0000Nx-4h
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeACifbCFLCHko0mFSBbcv0dEN3Keg1lZLZXzqzwC4Y=;
 b=ADrErDDNyJrPdvO0E/OXEZuzGY2qAzE+4rXKuFLq/Q4QyMhJsOUmRXK7qYQCRmZ1rit5s2
 7zHZ/Icsa1165wt9ChrUqJ5gepWEiz4/ilxhYDVtfoAdr+sIkf9RMGsX6BNde1gN7uQ0OH
 K/7VfzPXyh45rHuk9mLR7WK8L1zSvwM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-eg-Pve9dPA28lkgodWEgKQ-1; Mon, 04 Nov 2024 12:28:24 -0500
X-MC-Unique: eg-Pve9dPA28lkgodWEgKQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso29102445e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741302; x=1731346102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeACifbCFLCHko0mFSBbcv0dEN3Keg1lZLZXzqzwC4Y=;
 b=mIDcEpTrTE+Weh2FGV/+titGkfmsZzXCGmxHuNB1cPpiPbYwm/KiWbN5M++00uqwDY
 3xOx6CwjttSdO1dNpJmaAPAGgZOkyETRQKcrFkqot7cTKhaq7PNJ0FxzsmFY5mpQSbO/
 v4m3d642P1o/ifWGTu9HUJS1d6RaeaDTB9bICy9mzJfOXCE8fHB/C2JeF0UD2GM4Fs0w
 3DjUP5eBnZdauaUVRjQvomJ0uewjqruW+BpotzauL9DDrW26tFyf4fcl88wbE+eteFMS
 LguNAWuaamLcoYUuZMoPZb4jmzZhswHPih1VfAB2bUc6DgwUf2L1QNgc6Qk6q7v14rnq
 FIkA==
X-Gm-Message-State: AOJu0YwyAkxzjA8KUJ1BvKJsHKbxNbNFvIrAil1OOEl/kIxNxTwnOvAJ
 Z9su8jsDbtf8X7n0qpwmQZH9muiRxpdOttjqdyS+GsIvRgwtj/iZ61Fc3b06XR5eOIWp6USWagK
 isLMHoiSi+E+X2asZk9Qua+XUCh7EH0vLnTlHGof0bKddhSf/CgtipoDNMoNCSm5kKboqeIznr8
 /9R8Wo4AxYjn4a0bhW6Y2GjPFdjCC6KzMToEMNzGc=
X-Received: by 2002:a05:600c:3b83:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-43283244db4mr104214475e9.10.1730741302139; 
 Mon, 04 Nov 2024 09:28:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8tN8ySatGtD1LXrRTQod/wYVFKxtqYOVj3mcgD18rn9nxfate/Q+JAT4K8H14libNs7yjkw==
X-Received: by 2002:a05:600c:3b83:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-43283244db4mr104214065e9.10.1730741301616; 
 Mon, 04 Nov 2024 09:28:21 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698144sm164522305e9.39.2024.11.04.09.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 27/40] rust: use std::os::raw instead of core::ffi
Date: Mon,  4 Nov 2024 18:27:06 +0100
Message-ID: <20241104172721.180255-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
no need to compile QEMU as no_std, so this is acceptable as long as we support
a version of Debian with Rust 1.63.0.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                          |  3 +--
 rust/hw/char/pl011/src/device.rs     | 35 +++++++++++-----------------
 rust/hw/char/pl011/src/lib.rs        |  4 ++--
 rust/hw/char/pl011/src/memory_ops.rs | 14 +++--------
 rust/qemu-api/src/definitions.rs     |  2 +-
 rust/qemu-api/src/device_class.rs    |  6 ++---
 rust/qemu-api/src/lib.rs             | 11 +++++----
 rust/qemu-api/src/vmstate.rs         | 10 ++++----
 rust/qemu-api/tests/tests.rs         |  9 ++++---
 9 files changed, 39 insertions(+), 55 deletions(-)

diff --git a/meson.build b/meson.build
index d360120b233..aa0b0fc5584 100644
--- a/meson.build
+++ b/meson.build
@@ -3947,14 +3947,13 @@ if have_rust and have_system
   bindgen_args = [
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
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 788b47203b1..036757f7f3a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,9 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::{
-    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
-    ptr::{addr_of, addr_of_mut, NonNull},
+use core::ptr::{addr_of, addr_of_mut, NonNull};
+use std::{
+    ffi::CStr,
+    os::raw::{c_int, c_uchar, c_uint, c_void},
 };
 
 use qemu_api::{
@@ -117,11 +118,10 @@ pub struct PL011Class {
 }
 
 impl qemu_api::definitions::Class for PL011Class {
-    const CLASS_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
-    > = Some(crate::device_class::pl011_class_init);
+    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
+        Some(crate::device_class::pl011_class_init);
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     > = None;
 }
 
@@ -176,11 +176,7 @@ unsafe fn init(&mut self) {
         }
     }
 
-    pub fn read(
-        &mut self,
-        offset: hwaddr,
-        _size: core::ffi::c_uint,
-    ) -> std::ops::ControlFlow<u64, u64> {
+    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
         use RegisterOffset::*;
 
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
@@ -562,11 +558,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 /// readable/writeable from one thread at any time.
 ///
 /// The buffer and size arguments must also be valid.
-pub unsafe extern "C" fn pl011_receive(
-    opaque: *mut core::ffi::c_void,
-    buf: *const u8,
-    size: core::ffi::c_int,
-) {
+pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8, size: c_int) {
     unsafe {
         debug_assert!(!opaque.is_null());
         let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
@@ -585,7 +577,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 /// We expect the FFI user of this function to pass a valid pointer, that has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
+pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEvent) {
     unsafe {
         debug_assert!(!opaque.is_null());
         let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
@@ -656,11 +648,10 @@ pub struct PL011LuminaryClass {
 }
 
 impl qemu_api::definitions::Class for PL011LuminaryClass {
-    const CLASS_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
-    > = None;
+    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
+        None;
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     > = None;
 }
 
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index fb33110d3d8..69e96d72854 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -46,8 +46,8 @@
 pub mod device_class;
 pub mod memory_ops;
 
-pub const TYPE_PL011: &::core::ffi::CStr = c"pl011";
-pub const TYPE_PL011_LUMINARY: &::core::ffi::CStr = c"pl011_luminary";
+pub const TYPE_PL011: &::std::ffi::CStr = c"pl011";
+pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c"pl011_luminary";
 
 /// Offset of each register from the base memory address of the device.
 ///
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index fc69922fbf3..169d485a4d2 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -3,6 +3,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use core::ptr::NonNull;
+use std::os::raw::{c_uint, c_void};
 
 use qemu_api::{bindings::*, zeroable::Zeroable};
 
@@ -22,11 +23,7 @@
     },
 };
 
-unsafe extern "C" fn pl011_read(
-    opaque: *mut core::ffi::c_void,
-    addr: hwaddr,
-    size: core::ffi::c_uint,
-) -> u64 {
+unsafe extern "C" fn pl011_read(opaque: *mut c_void, addr: hwaddr, size: c_uint) -> u64 {
     assert!(!opaque.is_null());
     let mut state = unsafe { NonNull::new_unchecked(opaque.cast::<PL011State>()) };
     let val = unsafe { state.as_mut().read(addr, size) };
@@ -43,12 +40,7 @@
     }
 }
 
-unsafe extern "C" fn pl011_write(
-    opaque: *mut core::ffi::c_void,
-    addr: hwaddr,
-    data: u64,
-    _size: core::ffi::c_uint,
-) {
+unsafe extern "C" fn pl011_write(opaque: *mut c_void, addr: hwaddr, data: u64, _size: c_uint) {
     unsafe {
         assert!(!opaque.is_null());
         let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 064afe60549..26597934bbd 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -4,7 +4,7 @@
 
 //! Definitions required by QEMU when registering a device.
 
-use ::core::ffi::{c_void, CStr};
+use std::{ffi::CStr, os::raw::c_void};
 
 use crate::bindings::{Object, ObjectClass, TypeInfo};
 
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 3d40256f60f..cb4573ca6ef 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -7,7 +7,7 @@ macro_rules! device_class_init {
     ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
         pub unsafe extern "C" fn $func(
             klass: *mut $crate::bindings::ObjectClass,
-            _: *mut ::core::ffi::c_void,
+            _: *mut ::std::os::raw::c_void,
         ) {
             let mut dc =
                 ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
@@ -26,7 +26,7 @@ macro_rules! define_property {
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-            name: ::core::ffi::CStr::as_ptr($name),
+            name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
@@ -37,7 +37,7 @@ macro_rules! define_property {
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-            name: ::core::ffi::CStr::as_ptr($name),
+            name: ::std::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: false,
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 10ab3d7e639..ed840ee2f72 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -34,7 +34,10 @@ unsafe impl Sync for bindings::VMStateInfo {}
 pub mod vmstate;
 pub mod zeroable;
 
-use std::alloc::{GlobalAlloc, Layout};
+use std::{
+    alloc::{GlobalAlloc, Layout},
+    os::raw::c_void,
+};
 
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
 extern "C" {
@@ -48,8 +51,8 @@ fn g_aligned_alloc0(
 
 #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
 extern "C" {
-    fn qemu_memalign(alignment: usize, size: usize) -> *mut ::core::ffi::c_void;
-    fn qemu_vfree(ptr: *mut ::core::ffi::c_void);
+    fn qemu_memalign(alignment: usize, size: usize) -> *mut c_void;
+    fn qemu_vfree(ptr: *mut c_void);
 }
 
 extern "C" {
@@ -114,7 +117,7 @@ fn default() -> Self {
 }
 
 // Sanity check.
-const _: [(); 8] = [(); ::core::mem::size_of::<*mut ::core::ffi::c_void>()];
+const _: [(); 8] = [(); ::core::mem::size_of::<*mut c_void>()];
 
 unsafe impl GlobalAlloc for QemuAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 0c1197277f9..4e06e40505f 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -56,7 +56,7 @@ macro_rules! vmstate_single_test {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
             offset: ::core::mem::offset_of!($struct_name, $field_name),
             size: $size,
@@ -133,7 +133,7 @@ macro_rules! vmstate_array {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
             offset: ::core::mem::offset_of!($struct_name, $field_name),
             size: $size,
@@ -181,7 +181,7 @@ macro_rules! vmstate_struct_pointer_v {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             err_hint: ::core::ptr::null(),
             offset: ::core::mem::offset_of!($struct_name, $field_name),
             size: ::core::mem::size_of::<*const $type>(),
@@ -206,7 +206,7 @@ macro_rules! vmstate_array_of_pointer {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             version_id: $version_id,
             num: $num as _,
             info: unsafe { $info },
@@ -231,7 +231,7 @@ macro_rules! vmstate_array_of_pointer_to_struct {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), 0)
                 .as_bytes()
-                .as_ptr() as *const ::core::ffi::c_char,
+                .as_ptr() as *const ::std::os::raw::c_char,
             version_id: $version_id,
             num: $num as _,
             vmsd: unsafe { $vmsd },
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 37c4dd44f81..c7089f0cf21 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ffi::CStr;
+use std::{ffi::CStr, os::raw::c_void};
 
 use qemu_api::{
     bindings::*,
@@ -64,11 +64,10 @@ impl ObjectImpl for DummyState {
     }
 
     impl Class for DummyClass {
-        const CLASS_INIT: Option<
-            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
-        > = Some(dummy_class_init);
+        const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)> =
+            Some(dummy_class_init);
         const CLASS_BASE_INIT: Option<
-            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
         > = None;
     }
 
-- 
2.47.0


