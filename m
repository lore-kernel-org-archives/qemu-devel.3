Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFC6D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sS-0005sf-PC; Mon, 04 Nov 2024 12:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sQ-0005eN-Lh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sO-0000OH-GM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+sxt4oLLbOzLQhV8QoJ8Ld4Rd8cnl0CfYwHxwv+BjE=;
 b=iFDkvD3k+9s/YtU+EBHeM/eR7zpADXKfXguXK/i3zZ5yKYACujdcbQAx8NFNsIeOrhgkWd
 J1HjofJ3h5gYk2zDfMDbTyt+t9iKlxAPjpVfBxM2dpH6aBmiGQxyPMAbDXaXIGS+hdM7XY
 8pZdCEaOFqac7kMxpVrXX28zqyaRALw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-delg9ghcNmSXSnHoyF17iQ-1; Mon, 04 Nov 2024 12:28:26 -0500
X-MC-Unique: delg9ghcNmSXSnHoyF17iQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d47127e69so1916045f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741305; x=1731346105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+sxt4oLLbOzLQhV8QoJ8Ld4Rd8cnl0CfYwHxwv+BjE=;
 b=iv27EWQWsZytJwezdvDuAmJiZOAD8NCe/qpCuaQ+blU+RuDOn4GJgOwV9t8qFsaUSp
 cWHphhFQhLeiLaZdsX7GZnALgjOHrnO61RAXD6yEfZvVVkIz9dZ2lflWkaw7Iw7Jsr4R
 a0beZ6OGQwtgsiCpcDmptIT/FKRZbQM3MJMEPc8tM+rsNoVa/8YgeuKRDJi0LfGJiIsH
 OfculRHwDxls+XT9RCIpZUddozboMQUIWyY+2EPhkParajKz6rj/6RGTILC9FGMBq0BV
 kQ+Nz7/rjcL5WmrykiRrINfdlgvjkd1hNcS4KW3mNQ9fplKOS4rG/AnTfMDeE9oU0lNx
 68OA==
X-Gm-Message-State: AOJu0YyTkcDimOhdt94OhXFPpgMMjAVP+bqi972fqxZlgkVV/kae8Hps
 q0vuUbI1gEYP1pbOnFkVQFbPAsTj94ulTJiyagea3u9aCOZqaERhXJTzB9HJOgEP3GWAaBvZQc7
 qOsCHymkftb4CAgMBCivOo2A49RXMargmE9gPZQZRoivN3lzHA2O1HZjz6JuMSHx2rDOzcjoEjt
 e9jQRngBlfP3Ilyo117Ewshb/G8+7BHF+mafGbWzw=
X-Received: by 2002:adf:ae1a:0:b0:37d:4cd6:6f2f with SMTP id
 ffacd0b85a97d-380610f7ecbmr22267897f8f.3.1730741304421; 
 Mon, 04 Nov 2024 09:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrgnXUyvLvadgHma+rIwC5AFtq8WJOHKKkWlVmoyPdEK8Jvp9dICYLg82sC6CyucWhGrta4g==
X-Received: by 2002:adf:ae1a:0:b0:37d:4cd6:6f2f with SMTP id
 ffacd0b85a97d-380610f7ecbmr22267870f8f.3.1730741303830; 
 Mon, 04 Nov 2024 09:28:23 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d15sm13913397f8f.8.2024.11.04.09.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 28/40] rust: introduce a c_str macro
Date: Mon,  4 Nov 2024 18:27:07 +0100
Message-ID: <20241104172721.180255-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This allows CStr constants to be defined easily on Rust 1.63.0, while
checking that there are no embedded NULs.  c"" literals were only
stabilized in Rust 1.77.0.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 036757f7f3a..2d225d544de 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,6 +10,7 @@
 
 use qemu_api::{
     bindings::{self, *},
+    c_str,
     definitions::ObjectImpl,
 };
 
@@ -135,7 +136,7 @@ impl PL011State {
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
-        const CLK_NAME: &CStr = c"clk";
+        const CLK_NAME: &CStr = c_str!("clk");
 
         let dev = addr_of_mut!(*self).cast::<DeviceState>();
         // SAFETY:
@@ -598,7 +599,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
         let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
-        qdev_prop_set_chr(dev, c"chardev".as_ptr(), chr);
+        qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
         sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 6a554ad7926..a707fde1384 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -2,14 +2,12 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::{
-    ffi::{c_int, c_void},
-    ptr::NonNull,
-};
+use core::ptr::NonNull;
+use std::os::raw::{c_int, c_void};
 
 use qemu_api::{
-    bindings::*, vmstate_clock, vmstate_fields, vmstate_int32, vmstate_subsections, vmstate_uint32,
-    vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
+    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_int32, vmstate_subsections,
+    vmstate_uint32, vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
 };
 
 use crate::device::{PL011State, PL011_FIFO_DEPTH};
@@ -24,7 +22,7 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
 
 /// Migration subsection for [`PL011State`] clock.
 pub static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
-    name: c"pl011/clock".as_ptr(),
+    name: c_str!("pl011/clock").as_ptr(),
     version_id: 1,
     minimum_version_id: 1,
     needed: Some(pl011_clock_needed),
@@ -48,7 +46,7 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
 }
 
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: c"pl011".as_ptr(),
+    name: c_str!("pl011").as_ptr(),
     version_id: 2,
     minimum_version_id: 2,
     post_load: Some(pl011_post_load),
@@ -79,14 +77,14 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
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
index 69e96d72854..cd0a49acb91 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -42,12 +42,14 @@
 extern crate bilge_impl;
 extern crate qemu_api;
 
+use qemu_api::c_str;
+
 pub mod device;
 pub mod device_class;
 pub mod memory_ops;
 
-pub const TYPE_PL011: &::std::ffi::CStr = c"pl011";
-pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c"pl011_luminary";
+pub const TYPE_PL011: &::std::ffi::CStr = c_str!("pl011");
+pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c_str!("pl011_luminary");
 
 /// Offset of each register from the base memory address of the device.
 ///
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 3b849f7c413..c950b008d59 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,6 +3,7 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
       'src/vmstate.rs',
@@ -18,6 +19,9 @@ _qemu_api_rs = static_library(
   ],
 )
 
+rust.test('rust-qemu-api-tests', _qemu_api_rs,
+          suite: ['unit', 'rust'])
+
 qemu_api = declare_dependency(
   link_with: _qemu_api_rs,
   dependencies: qemu_api_macros,
diff --git a/rust/qemu-api/src/c_str.rs b/rust/qemu-api/src/c_str.rs
new file mode 100644
index 00000000000..4cd96da0b45
--- /dev/null
+++ b/rust/qemu-api/src/c_str.rs
@@ -0,0 +1,53 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[macro_export]
+/// Given a string constant _without_ embedded or trailing NULs, return
+/// a `CStr`.
+///
+/// Needed for compatibility with Rust <1.77.
+macro_rules! c_str {
+    ($str:expr) => {{
+        const STRING: &str = concat!($str, "\0");
+        const BYTES: &[u8] = STRING.as_bytes();
+
+        // "for" is not allowed in const context... oh well,
+        // everybody loves some lisp.  This could be turned into
+        // a procedural macro if this is a problem; alternatively
+        // Rust 1.72 makes CStr::from_bytes_with_nul a const function.
+        const fn f(b: &[u8], i: usize) {
+            if i == b.len() - 1 {
+            } else if b[i] == 0 {
+                panic!("c_str argument contains NUL")
+            } else {
+                f(b, i + 1)
+            }
+        }
+        f(BYTES, 0);
+
+        // SAFETY: absence of NULs apart from the final byte was checked above
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
+        let good = c_str!("🦀");
+        let good_bytes = b"\xf0\x9f\xa6\x80\0";
+        assert_eq!(good.to_bytes_with_nul(), good_bytes);
+    }
+
+    #[test]
+    fn test_cstr_macro_const() {
+        const GOOD: &CStr = c_str!("🦀");
+        const GOOD_BYTES: &[u8] = b"\xf0\x9f\xa6\x80\0";
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
 
+pub mod c_str;
 pub mod definitions;
 pub mod device_class;
 pub mod vmstate;
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 4e06e40505f..9c252ce18ef 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -15,7 +15,7 @@
 macro_rules! vmstate_unused_buffer {
     ($field_exists_fn:expr, $version_id:expr, $size:expr) => {{
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
     pub static VMSTATE: VMStateDescription = VMStateDescription {
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
         type Class = DummyClass;
         const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
-        const TYPE_NAME: &'static CStr = c"dummy";
+        const TYPE_NAME: &'static CStr = c_str!("dummy");
         const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_DEVICE);
         const ABSTRACT: bool = false;
         const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-- 
2.47.0


