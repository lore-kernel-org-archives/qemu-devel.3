Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC0CE8E7B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yRW-0007Bd-P9; Thu, 24 Oct 2024 10:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yR9-00078l-PV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:50 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yR5-0003vD-78
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:39 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so127480266b.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778614; x=1730383414; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=swZs0PvDIygR17bMoZNG/KFXxGRO0tSgGnszjaO+Hkw=;
 b=wsE/65xdxQlLgyEig+PnPcXICtPxqB+Xg+WG3xJ4cJg/uAd7rteKTq8u5qz5/nWob6
 bKT8ehX4kTV5UjeNUlO90Q8TNIS6u3cKpZyU6DvKpE8Ignzgya154zZmLNmtHVTDs5Tw
 eJnbHISO6nziIGnWVJjBX5tojxn6Yd54l9YR+neQxjWtx6Oi7w5M40xoeEJIuOAFcJjB
 g+hVYd57whWFirYJwMxwt6sCsj9P/SBmmVLW70Kb+3H6qmWw0e73ObYSs803JRJzlwsi
 8CZ46qdDn80k5bd75gw0Vjd2xEY2fGBBOtjI2589FXZPP7RBYmWoC2o+4wYqYDU6+6+y
 SkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778614; x=1730383414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swZs0PvDIygR17bMoZNG/KFXxGRO0tSgGnszjaO+Hkw=;
 b=XXgdI3KdB1QwQYBzK6Yo44BEqoQkBcv45kjZG6xmfvJmNdpOqxIe7blpbgSDjriAeq
 5NVcEQTbKS+IYngd1y1IOMzps/BCLeoeos9LZBbExi36ysO6A8jvlhNnXqrnGaHqKr+p
 cJfo2cfIS/GSj5GARyfXrR/vfT7Zw3wzWNSYkWZXvKFgtuQkNdXaSVBfDudO/Eh7rnm+
 JSOe5dedtMtlaZIlTCJoNFttmxASDda/VYjfmno1sweakMtbI2HWyA64+z0J4F0ZSynZ
 vLO4jHECHWQLecc9h3rm96+55/pDsr4aRFHTKNQ8EuHUWMHBnDmSBA7iMgnTKsnQilJz
 ViPQ==
X-Gm-Message-State: AOJu0YzcNfT3kTAyZly6/N1a2VqpZT3t6HT0chwoYu8iC8UzIdUcK0Zt
 P3XUglXR4LvIdBRrunb7kv57IN5y4a0IK1LkaRs8uVktW/imXTPXLuMGybMxH50=
X-Google-Smtp-Source: AGHT+IHOL8SJMdgpdOlMXhi240mYeHWvmTK+XMYm/R+T9TX6gQCO7ENeJrnX7hkWY7JmO3ETRIFWsg==
X-Received: by 2002:a17:906:c115:b0:a9a:e6:a031 with SMTP id
 a640c23a62f3a-a9abf964e1amr597810866b.59.1729778610634; 
 Thu, 24 Oct 2024 07:03:30 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:30 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Oct 2024 17:03:01 +0300
Subject: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
In-Reply-To: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=61915;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=I158Py0RnGmdnzcCp2wTlUb35MV778QZs4qZ5m1FnJk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9pbXdQdlM1RS94RlM5b1Z4ZzVmTzVaN210CjF2VUxtYkFkQzBZT2dIUldx
 Uk9KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG9nQUt
 DUkIzS2Nkd2YzNEowTGg0RC80bXN4SDdscm12dXV6Tk5BNGppc2NTcTM2NWhCdGU5djN6QWVJLw
 o3WFpYdGw4bm1nWGVKalcraW5wN1dxdUI5MHgwYnlJNEJ4dWk4WmdLL1hCSVFJMHFBMmsyMjJOW
 Fhwb3ArQnlwCitIVEdwRnVvU25wcEFzMUx1MW9WVkZZS1VSSlRuMVRqTHlHb1Jub0VTeE9kZklL
 ZDFaNEFMWmVERnJFdW9JajkKOEFlT0IwWUE5U1lNOXV6RGNjLys2aGRqU3hnZ0lGNU94YWxxcjk
 xdGhUM0lUdGFmeU83WjBESDkwZzd3RU9FegpkQ0s0NXZZRm9XVkhDNkNLYURIVFBQUWRPOU5vMU
 FHMWpHVjMxMi9ldEttNWxzbElzUzdoNFQ1NlZhZ003N25WCjY3Kzk5eWU5R01PdVphbDB3SWw2M
 y9FL3QyK3lOeDRPS1Vpa1VXYWl4dEl5ekhQTW1LVGNtTjZMYWJtaW1ETzkKNjgxd2FXRFRrcVc4
 R21hbXBBU2NySWlRbTRVZmlWUkloVHdTTVJYN1dVY1RsYUkyYm1tRDZrL3NXNHYwNS9xVgpKRTB
 CaUwwSmw0OTFPUUZVQmVSRlBJNlVqRC9OT29GK1ppcEFCUGNZNEhWWUNoY2J3bHJMMkRVaUw4aD
 Mxbkt3CjhuV3dabDZhV2l2UTRndkU1amFSL0l1alBiTW1Ob1BLWWptUDdQMzhWSlYvNTdwNVVZT
 WZOeVczenR0RXMveVIKUGhQWTNkdGc0VzhDYWZMMVBONFcvTEU3ajhsdEp5VDdPZ3NmMEkwRU9M
 dGlVeVNGWTQ0WnNrd093ZFhsZ3kvZQpXRVVOcTMwMlVCaUNCWmZPa3JUOFl1azgyRnkrK2tLMUN
 wYXV6elBGMnVYSElPMms0VEdCajZmRjBNU1E2WGJzClQ4b1Rsdz09Cj1LejI0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new derive procedural macro to declare device models. Add
corresponding DeviceImpl trait after already existing ObjectImpl trait.
At the same time, add instance_init, instance_post_init,
instance_finalize methods to the ObjectImpl trait and call them from the
ObjectImplUnsafe trait, which is generated by the procedural macro.

This allows all the boilerplate device model registration to be handled
by macros, and all pertinent details to be declared through proc macro
attributes or trait associated constants and methods.

The device class can now be generated automatically and the name can be
optionally overridden:

  ------------------------ >8 ------------------------
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
 #[device(class_name_override = PL011Class)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
  ------------------------ >8 ------------------------

Properties are now marked as field attributes:

  ------------------------ >8 ------------------------
 #[property(name = c"chardev", qdev_prop = qdev_prop_chr)]
 pub char_backend: CharBackend,
  ------------------------ >8 ------------------------

Object methods (instance_init, etc) methods are now trait methods:

  ------------------------ >8 ------------------------
 /// Trait a type must implement to be registered with QEMU.
 pub trait ObjectImpl {
     type Class: ClassImpl;
     const TYPE_NAME: &'static CStr;
     const PARENT_TYPE_NAME: Option<&'static CStr>;
     const ABSTRACT: bool;

     unsafe fn instance_init(&mut self) {}
     fn instance_post_init(&mut self) {}
     fn instance_finalize(&mut self) {}
 }
  ------------------------ >8 ------------------------

Device methods (realize/reset etc) are now safe idiomatic trait methods:

  ------------------------ >8 ------------------------
 /// Implementation methods for device types.
 pub trait DeviceImpl: ObjectImpl {
     fn realize(&mut self) {}
     fn reset(&mut self) {}
 }
  ------------------------ >8 ------------------------

The derive Device macro is responsible for creating all the extern "C" FFI
functions that QEMU needs to call these methods.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs              | 124 +++-----
 rust/hw/char/pl011/src/device_class.rs        |  70 -----
 rust/hw/char/pl011/src/lib.rs                 |   1 -
 rust/qemu-api-macros/src/device.rs            | 433 ++++++++++++++++++++++++++
 rust/qemu-api-macros/src/lib.rs               |  45 +--
 rust/qemu-api-macros/src/object.rs            | 107 +++++++
 rust/qemu-api-macros/src/symbols.rs           |  55 ++++
 rust/qemu-api-macros/src/utilities.rs         | 152 +++++++++
 rust/qemu-api/meson.build                     |   3 +-
 rust/qemu-api/src/definitions.rs              |  97 ------
 rust/qemu-api/src/device_class.rs             | 128 --------
 rust/qemu-api/src/lib.rs                      |   6 +-
 rust/qemu-api/src/objects.rs                  |  90 ++++++
 rust/qemu-api/src/tests.rs                    |  49 ---
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 15 files changed, 902 insertions(+), 459 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c7193b41beec0b177dbc75ac0e43fcfea4c82bfb..c469877b1ca70dd1a02e3a2449c65ad3e57c93ae 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -9,7 +9,7 @@
 
 use qemu_api::{
     bindings::{self, *},
-    definitions::ObjectImpl,
+    objects::*,
 };
 
 use crate::{
@@ -26,7 +26,8 @@
 pub const PL011_FIFO_DEPTH: usize = 16_usize;
 
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::Object)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
+#[device(class_name_override = PL011Class)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: SysBusDevice,
@@ -51,6 +52,7 @@ pub struct PL011State {
     pub read_count: usize,
     pub read_trigger: usize,
     #[doc(alias = "chr")]
+    #[property(name = c"chardev", qdev_prop = qdev_prop_chr)]
     pub char_backend: CharBackend,
     /// QEMU interrupts
     ///
@@ -68,38 +70,17 @@ pub struct PL011State {
     #[doc(alias = "clk")]
     pub clock: NonNull<Clock>,
     #[doc(alias = "migrate_clk")]
+    #[property(name = c"migrate-clk", qdev_prop = qdev_prop_bool)]
     pub migrate_clock: bool,
 }
 
 impl ObjectImpl for PL011State {
     type Class = PL011Class;
-    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
+
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
     const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
     const ABSTRACT: bool = false;
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)> = None;
-}
 
-#[repr(C)]
-pub struct PL011Class {
-    _inner: [u8; 0],
-}
-
-impl qemu_api::definitions::Class for PL011Class {
-    const CLASS_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
-    > = Some(crate::device_class::pl011_class_init);
-    const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
-    > = None;
-}
-
-#[used]
-pub static CLK_NAME: &CStr = c"clk";
-
-impl PL011State {
     /// Initializes a pre-allocated, unitialized instance of `PL011State`.
     ///
     /// # Safety
@@ -108,7 +89,7 @@ impl PL011State {
     /// `PL011State` type. It must not be called more than once on the same
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
-    pub unsafe fn init(&mut self) {
+    unsafe fn instance_init(&mut self) {
         let dev = addr_of_mut!(*self).cast::<DeviceState>();
         // SAFETY:
         //
@@ -120,7 +101,7 @@ pub unsafe fn init(&mut self) {
                 addr_of_mut!(*self).cast::<Object>(),
                 &PL011_OPS,
                 addr_of_mut!(*self).cast::<c_void>(),
-                Self::TYPE_INFO.name,
+                Self::TYPE_NAME.as_ptr(),
                 0x1000,
             );
             let sbd = addr_of_mut!(*self).cast::<SysBusDevice>();
@@ -147,7 +128,49 @@ pub unsafe fn init(&mut self) {
             .unwrap();
         }
     }
+}
 
+impl DeviceImpl for PL011State {
+    fn realize(&mut self) {
+        // SAFETY: self.char_backend has the correct size and alignment for a
+        // CharBackend object, and its callbacks are of the correct types.
+        unsafe {
+            qemu_chr_fe_set_handlers(
+                addr_of_mut!(self.char_backend),
+                Some(pl011_can_receive),
+                Some(pl011_receive),
+                Some(pl011_event),
+                None,
+                addr_of_mut!(*self).cast::<c_void>(),
+                core::ptr::null_mut(),
+                true,
+            );
+        }
+    }
+
+    fn reset(&mut self) {
+        self.line_control.reset();
+        self.receive_status_error_clear.reset();
+        self.dmacr = 0;
+        self.int_enabled = 0;
+        self.int_level = 0;
+        self.ilpr = 0;
+        self.ibrd = 0;
+        self.fbrd = 0;
+        self.read_trigger = 1;
+        self.ifl = 0x12;
+        self.control.reset();
+        self.flags = 0.into();
+        self.reset_fifo();
+    }
+}
+
+impl qemu_api::objects::Migrateable for PL011State {}
+
+#[used]
+pub static CLK_NAME: &CStr = c"clk";
+
+impl PL011State {
     pub fn read(
         &mut self,
         offset: hwaddr,
@@ -394,39 +417,6 @@ fn set_read_trigger(&mut self) {
         self.read_trigger = 1;
     }
 
-    pub fn realize(&mut self) {
-        // SAFETY: self.char_backend has the correct size and alignment for a
-        // CharBackend object, and its callbacks are of the correct types.
-        unsafe {
-            qemu_chr_fe_set_handlers(
-                addr_of_mut!(self.char_backend),
-                Some(pl011_can_receive),
-                Some(pl011_receive),
-                Some(pl011_event),
-                None,
-                addr_of_mut!(*self).cast::<c_void>(),
-                core::ptr::null_mut(),
-                true,
-            );
-        }
-    }
-
-    pub fn reset(&mut self) {
-        self.line_control.reset();
-        self.receive_status_error_clear.reset();
-        self.dmacr = 0;
-        self.int_enabled = 0;
-        self.int_level = 0;
-        self.ilpr = 0;
-        self.ibrd = 0;
-        self.fbrd = 0;
-        self.read_trigger = 1;
-        self.ifl = 0x12;
-        self.control.reset();
-        self.flags = 0.into();
-        self.reset_fifo();
-    }
-
     pub fn reset_fifo(&mut self) {
         self.read_count = 0;
         self.read_pos = 0;
@@ -583,17 +573,3 @@ pub fn update(&self) {
         dev
     }
 }
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
-    unsafe {
-        debug_assert!(!obj.is_null());
-        let mut state = NonNull::new_unchecked(obj.cast::<PL011State>());
-        state.as_mut().init();
-    }
-}
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
deleted file mode 100644
index b7ab31af02d7bb50ae94be0b153baafc7ccfa375..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/src/device_class.rs
+++ /dev/null
@@ -1,70 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use core::ptr::NonNull;
-
-use qemu_api::{bindings::*, definitions::ObjectImpl};
-
-use crate::device::PL011State;
-
-#[used]
-pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: PL011State::TYPE_INFO.name,
-    unmigratable: true,
-    ..unsafe { ::core::mem::MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
-};
-
-qemu_api::declare_properties! {
-    PL011_PROPERTIES,
-    qemu_api::define_property!(
-        c"chardev",
-        PL011State,
-        char_backend,
-        unsafe { &qdev_prop_chr },
-        CharBackend
-    ),
-    qemu_api::define_property!(
-        c"migrate-clk",
-        PL011State,
-        migrate_clock,
-        unsafe { &qdev_prop_bool },
-        bool
-    ),
-}
-
-qemu_api::device_class_init! {
-    pl011_class_init,
-    props => PL011_PROPERTIES,
-    realize_fn => Some(pl011_realize),
-    legacy_reset_fn => Some(pl011_reset),
-    vmsd => VMSTATE_PL011,
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_realize(dev: *mut DeviceState, _errp: *mut *mut Error) {
-    unsafe {
-        assert!(!dev.is_null());
-        let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
-        state.as_mut().realize();
-    }
-}
-
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer, that has
-/// the same size as [`PL011State`]. We also expect the device is
-/// readable/writeable from one thread at any time.
-#[no_mangle]
-pub unsafe extern "C" fn pl011_reset(dev: *mut DeviceState) {
-    unsafe {
-        assert!(!dev.is_null());
-        let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
-        state.as_mut().reset();
-    }
-}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2939ee50c99ceaacf6ec68127272d58814e33679..f4d9cce4b01f605cfcbec7ea87c8b2009d77ee52 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -42,7 +42,6 @@
 extern crate qemu_api;
 
 pub mod device;
-pub mod device_class;
 pub mod memory_ops;
 
 pub const TYPE_PL011: &::core::ffi::CStr = c"pl011";
diff --git a/rust/qemu-api-macros/src/device.rs b/rust/qemu-api-macros/src/device.rs
new file mode 100644
index 0000000000000000000000000000000000000000..3b965576a065601cd5c97d5ab6a2501f96d16a61
--- /dev/null
+++ b/rust/qemu-api-macros/src/device.rs
@@ -0,0 +1,433 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use proc_macro::TokenStream;
+use quote::{format_ident, quote, ToTokens};
+use syn::{
+    parse::{Parse, ParseStream},
+    Result,
+};
+use syn::{parse_macro_input, DeriveInput};
+
+use crate::{symbols::*, utilities::*};
+
+#[derive(Debug, Default)]
+struct DeriveContainer {
+    category: Option<syn::Path>,
+    class_name: Option<syn::Ident>,
+    class_name_override: Option<syn::Ident>,
+}
+
+impl Parse for DeriveContainer {
+    fn parse(input: ParseStream) -> Result<Self> {
+        let _: syn::Token![#] = input.parse()?;
+        let bracketed;
+        _ = syn::bracketed!(bracketed in input);
+        assert_eq!(DEVICE, bracketed.parse::<syn::Ident>()?);
+        let mut retval = Self {
+            category: None,
+            class_name: None,
+            class_name_override: None,
+        };
+        let content;
+        _ = syn::parenthesized!(content in bracketed);
+        while !content.is_empty() {
+            let value: syn::Ident = content.parse()?;
+            if value == CLASS_NAME {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.class_name.is_some() {
+                    panic!("{} can only be used at most once", CLASS_NAME);
+                }
+                retval.class_name = Some(content.parse()?);
+            } else if value == CLASS_NAME_OVERRIDE {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.class_name_override.is_some() {
+                    panic!("{} can only be used at most once", CLASS_NAME_OVERRIDE);
+                }
+                retval.class_name_override = Some(content.parse()?);
+            } else if value == CATEGORY {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.category.is_some() {
+                    panic!("{} can only be used at most once", CATEGORY);
+                }
+                let lit: syn::LitStr = content.parse()?;
+                let path: syn::Path = lit.parse()?;
+                retval.category = Some(path);
+            } else {
+                panic!("unrecognized token `{}`", value);
+            }
+
+            if !content.is_empty() {
+                let _: syn::Token![,] = content.parse()?;
+            }
+        }
+        if retval.class_name.is_some() && retval.class_name_override.is_some() {
+            panic!(
+                "Cannot define `{}` and `{}` at the same time",
+                CLASS_NAME, CLASS_NAME_OVERRIDE
+            );
+        }
+        Ok(retval)
+    }
+}
+
+#[derive(Debug)]
+struct QdevProperty {
+    name: Option<syn::LitCStr>,
+    qdev_prop: Option<syn::Path>,
+}
+
+impl Parse for QdevProperty {
+    fn parse(input: ParseStream) -> Result<Self> {
+        let _: syn::Token![#] = input.parse()?;
+        let bracketed;
+        _ = syn::bracketed!(bracketed in input);
+        assert_eq!(PROPERTY, bracketed.parse::<syn::Ident>()?);
+        let mut retval = Self {
+            name: None,
+            qdev_prop: None,
+        };
+        let content;
+        _ = syn::parenthesized!(content in bracketed);
+        while !content.is_empty() {
+            let value: syn::Ident = content.parse()?;
+            if value == NAME {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.name.is_some() {
+                    panic!("{} can only be used at most once", NAME);
+                }
+                retval.name = Some(content.parse()?);
+            } else if value == QDEV_PROP {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.qdev_prop.is_some() {
+                    panic!("{} can only be used at most once", QDEV_PROP);
+                }
+                retval.qdev_prop = Some(content.parse()?);
+            } else {
+                panic!("unrecognized token `{}`", value);
+            }
+
+            if !content.is_empty() {
+                let _: syn::Token![,] = content.parse()?;
+            }
+        }
+        Ok(retval)
+    }
+}
+
+pub fn derive_device(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+
+    assert_is_repr_c_struct(&input, "Device");
+
+    let derive_container: DeriveContainer = input
+        .attrs
+        .iter()
+        .find(|a| a.path() == DEVICE)
+        .map(|a| syn::parse(a.to_token_stream().into()).expect("could not parse device attr"))
+        .unwrap_or_default();
+    let (qdev_properties_static, qdev_properties_expanded) = make_qdev_properties(&input);
+    let class_expanded = gen_device_class(derive_container, qdev_properties_static, &input.ident);
+    let name = input.ident;
+
+    let realize_fn = format_ident!("__{}_realize_generated", name);
+    let reset_fn = format_ident!("__{}_reset_generated", name);
+
+    let expanded = quote! {
+        unsafe impl ::qemu_api::objects::DeviceImplUnsafe for #name {
+            const REALIZE: ::core::option::Option<
+                unsafe extern "C" fn(
+                    dev: *mut ::qemu_api::bindings::DeviceState,
+                    errp: *mut *mut ::qemu_api::bindings::Error,
+                ),
+                > = Some(#realize_fn);
+            const RESET: ::core::option::Option<
+                unsafe extern "C" fn(dev: *mut ::qemu_api::bindings::DeviceState),
+                > = Some(#reset_fn);
+        }
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #realize_fn(
+            dev: *mut ::qemu_api::bindings::DeviceState,
+            errp: *mut *mut ::qemu_api::bindings::Error,
+        ) {
+            let mut instance = NonNull::new(dev.cast::<#name>()).expect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#name)));
+            unsafe {
+                ::qemu_api::objects::DeviceImpl::realize(instance.as_mut());
+            }
+        }
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #reset_fn(
+            dev: *mut ::qemu_api::bindings::DeviceState,
+        ) {
+            let mut instance = NonNull::new(dev.cast::<#name>()).expect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#name)));
+            unsafe {
+                ::qemu_api::objects::DeviceImpl::reset(instance.as_mut());
+            }
+        }
+
+        #qdev_properties_expanded
+        #class_expanded
+    };
+
+    TokenStream::from(expanded)
+}
+
+fn make_qdev_properties(input: &DeriveInput) -> (syn::Ident, proc_macro2::TokenStream) {
+    let name = &input.ident;
+
+    let qdev_properties: Vec<(syn::Field, QdevProperty)> = match &input.data {
+        syn::Data::Struct(syn::DataStruct {
+            fields: syn::Fields::Named(fields),
+            ..
+        }) => fields
+            .named
+            .iter()
+            .map(|f| {
+                f.attrs
+                    .iter()
+                    .filter(|a| a.path() == PROPERTY)
+                    .map(|a| (f.clone(), a.clone()))
+            })
+            .flatten()
+            .map(|(f, a)| {
+                (
+                    f.clone(),
+                    syn::parse(a.to_token_stream().into()).expect("could not parse property attr"),
+                )
+            })
+            .collect::<Vec<(syn::Field, QdevProperty)>>(),
+        _other => unreachable!(),
+    };
+
+    let mut properties_expanded = quote! {
+        unsafe { ::core::mem::MaybeUninit::<::qemu_api::bindings::Property>::zeroed().assume_init() }
+    };
+    let prop_len = qdev_properties.len() + 1;
+    for (field, prop) in qdev_properties {
+        let prop_name = prop.name.as_ref().unwrap();
+        let field_name = field.ident.as_ref().unwrap();
+        let qdev_prop = prop.qdev_prop.as_ref().unwrap();
+        let prop = quote! {
+            ::qemu_api::bindings::Property {
+                name: ::core::ffi::CStr::as_ptr(#prop_name),
+                info: unsafe { &#qdev_prop },
+                offset: ::core::mem::offset_of!(#name, #field_name) as _,
+                bitnr: 0,
+                bitmask: 0,
+                set_default: false,
+                defval: ::qemu_api::bindings::Property__bindgen_ty_1 { i: 0 },
+                arrayoffset: 0,
+                arrayinfo: ::core::ptr::null(),
+                arrayfieldsize: 0,
+                link_type: ::core::ptr::null(),
+            }
+        };
+        properties_expanded = quote! {
+            #prop,
+            #properties_expanded
+        };
+    }
+    let properties_ident = format_ident!("__{}_QDEV_PROPERTIES", name);
+    let expanded = quote! {
+        #[no_mangle]
+        pub static mut #properties_ident: [::qemu_api::bindings::Property; #prop_len] = [#properties_expanded];
+    };
+    (properties_ident, expanded)
+}
+
+fn gen_device_class(
+    derive_container: DeriveContainer,
+    qdev_properties_static: syn::Ident,
+    name: &syn::Ident,
+) -> proc_macro2::TokenStream {
+    let (class_name, class_def) = match (
+        derive_container.class_name_override,
+        derive_container.class_name,
+    ) {
+        (Some(class_name), _) => {
+            let class_expanded = quote! {
+                #[repr(C)]
+                pub struct #class_name {
+                    _inner: [u8; 0],
+                }
+            };
+            (class_name, class_expanded)
+        }
+        (None, Some(class_name)) => (class_name, quote! {}),
+        (None, None) => {
+            let class_name = format_ident!("{}Class", name);
+            let class_expanded = quote! {
+                #[repr(C)]
+                pub struct #class_name {
+                    _inner: [u8; 0],
+                }
+            };
+            (class_name, class_expanded)
+        }
+    };
+    let class_init_fn = format_ident!("__{}_class_init_generated", class_name);
+    let class_base_init_fn = format_ident!("__{}_class_base_init_generated", class_name);
+
+    let (vmsd, vmsd_impl) = {
+        let (i, vmsd) = make_vmstate(name);
+        (quote! { &#i }, vmsd)
+    };
+    let category = if let Some(category) = derive_container.category {
+        quote! {
+            const BITS_PER_LONG: u32 = ::core::ffi::c_ulong::BITS;
+            let _: ::qemu_api::bindings::DeviceCategory = #category;
+            let nr: ::core::ffi::c_ulong = #category as _;
+            let mask = 1 << (nr as u32 % BITS_PER_LONG);
+            let p = ::core::ptr::addr_of_mut!(dc.as_mut().categories).offset((nr as u32 / BITS_PER_LONG) as isize);
+            let p: *mut ::core::ffi::c_ulong = p.cast();
+            let categories = p.read_unaligned();
+            p.write_unaligned(categories | mask);
+        }
+    } else {
+        quote! {}
+    };
+    let props = quote! {
+        ::qemu_api::bindings::device_class_set_props(dc.as_mut(), #qdev_properties_static.as_mut_ptr());
+    };
+
+    quote! {
+        #class_def
+
+        impl ::qemu_api::objects::ClassImpl for #class_name {
+            type Object = #name;
+        }
+
+        unsafe impl ::qemu_api::objects::ClassImplUnsafe for #class_name {
+            const CLASS_INIT: Option<
+                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+                > = Some(#class_init_fn);
+            const CLASS_BASE_INIT: Option<
+                unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),
+                > = Some(#class_base_init_fn);
+        }
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #class_init_fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void) {
+            {
+                {
+                    let mut dc =
+                        ::core::ptr::NonNull::new(klass.cast::<::qemu_api::bindings::DeviceClass>()).unwrap();
+                    unsafe {
+                        dc.as_mut().realize =
+                            <#name as ::qemu_api::objects::DeviceImplUnsafe>::REALIZE;
+                        ::qemu_api::bindings::device_class_set_legacy_reset(
+                            dc.as_mut(),
+                            <#name as ::qemu_api::objects::DeviceImplUnsafe>::RESET
+                        );
+                        dc.as_mut().vmsd = #vmsd;
+                        #props
+                        #category
+                    }
+                }
+                let mut klass = NonNull::new(klass.cast::<#class_name>()).expect(concat!("Expected klass to be a non-null pointer of type ", stringify!(#class_name)));
+                unsafe {
+                    ::qemu_api::objects::ClassImpl::class_init(klass.as_mut(), data);
+                }
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #class_base_init_fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void) {
+            {
+                let mut klass = NonNull::new(klass.cast::<#class_name>()).expect(concat!("Expected klass to be a non-null pointer of type ", stringify!(#class_name)));
+                unsafe {
+                    ::qemu_api::objects::ClassImpl::class_base_init(klass.as_mut(), data);
+                }
+            }
+        }
+
+        #vmsd_impl
+    }
+}
+
+fn make_vmstate(name: &syn::Ident) -> (syn::Ident, proc_macro2::TokenStream) {
+    let vmstate_description_ident = format_ident!("__VMSTATE_{}", name);
+
+    let pre_load = format_ident!("__{}_pre_load_generated", name);
+    let post_load = format_ident!("__{}_post_load_generated", name);
+    let pre_save = format_ident!("__{}_pre_save_generated", name);
+    let post_save = format_ident!("__{}_post_save_generated", name);
+    let needed = format_ident!("__{}_needed_generated", name);
+    let dev_unplug_pending = format_ident!("__{}_dev_unplug_pending_generated", name);
+
+    let migrateable_fish = quote! {<#name as ::qemu_api::objects::Migrateable>};
+    let vmstate_description = quote! {
+        #[used]
+        #[allow(non_upper_case_globals)]
+        pub static #vmstate_description_ident: ::qemu_api::bindings::VMStateDescription = ::qemu_api::bindings::VMStateDescription {
+            name: if let Some(name) = #migrateable_fish::NAME {
+                name.as_ptr()
+            } else {
+                <#name as ::qemu_api::objects::ObjectImplUnsafe>::TYPE_INFO.name
+            },
+            unmigratable: #migrateable_fish::UNMIGRATABLE,
+            early_setup: #migrateable_fish::EARLY_SETUP,
+            version_id: #migrateable_fish::VERSION_ID,
+            minimum_version_id: #migrateable_fish::MINIMUM_VERSION_ID,
+            priority: #migrateable_fish::PRIORITY,
+            pre_load: Some(#pre_load),
+            post_load: Some(#post_load),
+            pre_save: Some(#pre_save),
+            post_save: Some(#post_save),
+            needed: Some(#needed),
+            dev_unplug_pending: Some(#dev_unplug_pending),
+            fields: ::core::ptr::null(),
+            subsections: ::core::ptr::null(),
+        };
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #pre_load(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::pre_load(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #post_load(opaque: *mut ::core::ffi::c_void, version_id: core::ffi::c_int) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::post_load(instance.as_mut(), version_id)
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #pre_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::pre_save(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #post_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::post_save(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #needed(opaque: *mut ::core::ffi::c_void) -> bool {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::needed(instance.as_mut())
+            }
+        }
+        #[no_mangle]
+        pub unsafe extern "C" fn #dev_unplug_pending(opaque: *mut ::core::ffi::c_void) -> bool {
+            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
+            unsafe {
+                ::qemu_api::objects::Migrateable::dev_unplug_pending(instance.as_mut())
+            }
+        }
+    };
+
+    let expanded = quote! {
+        #vmstate_description
+    };
+    (vmstate_description_ident, expanded)
+}
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 59aba592d9ae4c5a4cdfdc6f9b9b08363b8a57e5..7753a853fae72fc87e6dc642cf076c6d0c736345 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -2,42 +2,21 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#![allow(dead_code)]
+
 use proc_macro::TokenStream;
-use quote::{format_ident, quote};
-use syn::{parse_macro_input, DeriveInput};
+
+mod device;
+mod object;
+mod symbols;
+mod utilities;
 
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
-    let input = parse_macro_input!(input as DeriveInput);
-
-    let name = input.ident;
-    let module_static = format_ident!("__{}_LOAD_MODULE", name);
-
-    let expanded = quote! {
-        #[allow(non_upper_case_globals)]
-        #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static #module_static: extern "C" fn() = {
-            extern "C" fn __register() {
-                unsafe {
-                    ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
-                }
-            }
-
-            extern "C" fn __load() {
-                unsafe {
-                    ::qemu_api::bindings::register_module_init(
-                        Some(__register),
-                        ::qemu_api::bindings::module_init_type::MODULE_INIT_QOM
-                    );
-                }
-            }
-
-            __load
-        };
-    };
+    object::derive_object(input)
+}
 
-    TokenStream::from(expanded)
+#[proc_macro_derive(Device, attributes(device, property))]
+pub fn derive_device(input: TokenStream) -> TokenStream {
+    device::derive_device(input)
 }
diff --git a/rust/qemu-api-macros/src/object.rs b/rust/qemu-api-macros/src/object.rs
new file mode 100644
index 0000000000000000000000000000000000000000..f808069aea42de752dea7524fef64467427f105c
--- /dev/null
+++ b/rust/qemu-api-macros/src/object.rs
@@ -0,0 +1,107 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use proc_macro::TokenStream;
+use quote::{format_ident, quote};
+use syn::{parse_macro_input, DeriveInput};
+
+use crate::utilities::*;
+
+pub fn derive_object(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+
+    assert_is_repr_c_struct(&input, "Object");
+
+    let name = input.ident;
+    let module_static = format_ident!("__{}_LOAD_MODULE", name);
+
+    let ctors = quote! {
+        #[allow(non_upper_case_globals)]
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static #module_static: extern "C" fn() = {
+            extern "C" fn __register() {
+                unsafe {
+                    ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::objects::ObjectImplUnsafe>::TYPE_INFO);
+                }
+            }
+
+            extern "C" fn __load() {
+                unsafe {
+                    ::qemu_api::bindings::register_module_init(
+                        Some(__register),
+                        ::qemu_api::bindings::module_init_type::MODULE_INIT_QOM
+                    );
+                }
+            }
+
+            __load
+        };
+    };
+
+    let instance_init = format_ident!("__{}_instance_init_generated", name);
+    let instance_post_init = format_ident!("__{}_instance_post_init_generated", name);
+    let instance_finalize = format_ident!("__{}_instance_finalize_generated", name);
+
+    let obj_impl_unsafe = quote! {
+        unsafe impl ::qemu_api::objects::ObjectImplUnsafe for #name {
+            const TYPE_INFO: ::qemu_api::bindings::TypeInfo =
+                ::qemu_api::bindings::TypeInfo {
+                    name: <Self as ::qemu_api::objects::ObjectImpl>::TYPE_NAME.as_ptr(),
+                    parent: if let Some(pname) = <Self as ::qemu_api::objects::ObjectImpl>::PARENT_TYPE_NAME {
+                        pname.as_ptr()
+                    } else {
+                        ::core::ptr::null()
+                    },
+                    instance_size: ::core::mem::size_of::<Self>() as ::qemu_api::bindings::size_t,
+                    instance_align: ::core::mem::align_of::<Self>() as ::qemu_api::bindings::size_t,
+                    instance_init: <Self as ::qemu_api::objects::ObjectImplUnsafe>::INSTANCE_INIT,
+                    instance_post_init: <Self as ::qemu_api::objects::ObjectImplUnsafe>::INSTANCE_POST_INIT,
+                    instance_finalize: <Self as ::qemu_api::objects::ObjectImplUnsafe>::INSTANCE_FINALIZE,
+                    abstract_: <Self as ::qemu_api::objects::ObjectImpl>::ABSTRACT,
+                    class_size:  ::core::mem::size_of::<<Self as ::qemu_api::objects::ObjectImpl>::Class>() as ::qemu_api::bindings::size_t,
+                    class_init: <<Self as ::qemu_api::objects::ObjectImpl>::Class as ::qemu_api::objects::ClassImplUnsafe>::CLASS_INIT,
+                    class_base_init: <<Self as ::qemu_api::objects::ObjectImpl>::Class as ::qemu_api::objects::ClassImplUnsafe>::CLASS_BASE_INIT,
+                    class_data: ::core::ptr::null_mut(),
+                    interfaces: ::core::ptr::null_mut(),
+                };
+            const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut ::qemu_api::bindings::Object)> = Some(#instance_init);
+            const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut ::qemu_api::bindings::Object)> = Some(#instance_post_init);
+            const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut ::qemu_api::bindings::Object)> = Some(#instance_finalize);
+        }
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #instance_init(obj: *mut ::qemu_api::bindings::Object) {
+            let mut instance = NonNull::new(obj.cast::<#name>()).expect(concat!("Expected obj to be a non-null pointer of type ", stringify!(#name)));
+            unsafe {
+                ::qemu_api::objects::ObjectImpl::instance_init(instance.as_mut());
+            }
+        }
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #instance_post_init(obj: *mut ::qemu_api::bindings::Object) {
+                let mut instance = NonNull::new(obj.cast::<#name>()).expect(concat!("Expected obj to be a non-null pointer of type ", stringify!(#name)));
+            unsafe {
+                ::qemu_api::objects::ObjectImpl::instance_post_init(instance.as_mut());
+            }
+        }
+
+        #[no_mangle]
+        pub unsafe extern "C" fn #instance_finalize(obj: *mut ::qemu_api::bindings::Object) {
+                let mut instance = NonNull::new(obj.cast::<#name>()).expect(concat!("Expected obj to be a non-null pointer of type ", stringify!(#name)));
+            unsafe {
+                ::qemu_api::objects::ObjectImpl::instance_finalize(instance.as_mut());
+            }
+        }
+    };
+
+    let expanded = quote! {
+        #obj_impl_unsafe
+
+        #ctors
+    };
+    TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api-macros/src/symbols.rs b/rust/qemu-api-macros/src/symbols.rs
new file mode 100644
index 0000000000000000000000000000000000000000..f73768d228ed2b4d478c18336db56cb11e70f012
--- /dev/null
+++ b/rust/qemu-api-macros/src/symbols.rs
@@ -0,0 +1,55 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use core::fmt;
+use syn::{Ident, Path};
+
+#[derive(Copy, Clone, Debug)]
+pub struct Symbol(&'static str);
+
+pub const DEVICE: Symbol = Symbol("device");
+pub const NAME: Symbol = Symbol("name");
+pub const CATEGORY: Symbol = Symbol("category");
+pub const CLASS_NAME: Symbol = Symbol("class_name");
+pub const CLASS_NAME_OVERRIDE: Symbol = Symbol("class_name_override");
+pub const QDEV_PROP: Symbol = Symbol("qdev_prop");
+pub const MIGRATEABLE: Symbol = Symbol("migrateable");
+pub const PROPERTIES: Symbol = Symbol("properties");
+pub const PROPERTY: Symbol = Symbol("property");
+
+impl PartialEq<Symbol> for Ident {
+    fn eq(&self, word: &Symbol) -> bool {
+        self == word.0
+    }
+}
+
+impl<'a> PartialEq<Symbol> for &'a Ident {
+    fn eq(&self, word: &Symbol) -> bool {
+        *self == word.0
+    }
+}
+
+impl PartialEq<Symbol> for Path {
+    fn eq(&self, word: &Symbol) -> bool {
+        self.is_ident(word.0)
+    }
+}
+
+impl<'a> PartialEq<Symbol> for &'a Path {
+    fn eq(&self, word: &Symbol) -> bool {
+        self.is_ident(word.0)
+    }
+}
+
+impl PartialEq<Ident> for Symbol {
+    fn eq(&self, ident: &Ident) -> bool {
+        ident == self.0
+    }
+}
+
+impl fmt::Display for Symbol {
+    fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result {
+        self.0.fmt(fmt)
+    }
+}
diff --git a/rust/qemu-api-macros/src/utilities.rs b/rust/qemu-api-macros/src/utilities.rs
new file mode 100644
index 0000000000000000000000000000000000000000..bd8776539aa0bb3bcaa023bd88d962efe1431746
--- /dev/null
+++ b/rust/qemu-api-macros/src/utilities.rs
@@ -0,0 +1,152 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use syn::{parenthesized, token, Data, DeriveInput, LitInt};
+
+#[derive(Default)]
+pub enum Abi {
+    #[default]
+    Rust,
+    C,
+    Transparent,
+    Other(String),
+}
+
+#[derive(Default)]
+pub struct Repr {
+    pub abi: Abi,
+    /// whether the attribute was declared in the definition.
+    pub present: bool,
+    pub align: Option<usize>,
+    pub packed: Option<usize>,
+}
+
+impl core::fmt::Display for Repr {
+    fn fmt(&self, fmt: &mut core::fmt::Formatter) -> core::fmt::Result {
+        write!(fmt, "repr(")?;
+        match &self.abi {
+            Abi::C => write!(fmt, "C")?,
+            Abi::Rust => write!(fmt, "Rust")?,
+            Abi::Transparent => write!(fmt, "transparent")?,
+            Abi::Other(s) => write!(fmt, "{}", s)?,
+        }
+        if self.align.is_some() || self.packed.is_some() {
+            write!(fmt, ", ")?;
+            if let Some(v) = self.align {
+                write!(fmt, "align({})", v)?;
+                if self.packed.is_some() {
+                    write!(fmt, ", ")?;
+                }
+            }
+            match self.packed {
+                Some(1) => write!(fmt, "packed")?,
+                Some(n) => write!(fmt, "packed({})", n)?,
+                None => {}
+            }
+        }
+        write!(fmt, ")")
+    }
+}
+
+impl Repr {
+    pub fn detect_repr(attrs: &[syn::Attribute]) -> Self {
+        let mut repr = Self::default();
+
+        // We don't validate the repr attribute; if it's invalid rustc will complain
+        // anyway.
+        for attr in attrs {
+            if attr.path().is_ident("repr") {
+                repr.present = true;
+                if let Err(err) = attr.parse_nested_meta(|meta| {
+                    // #[repr(C)]
+                    if meta.path.is_ident("C") {
+                        repr.abi = Abi::C;
+                        return Ok(());
+                    }
+
+                    // #[repr(Rust)]
+                    if meta.path.is_ident("Rust") {
+                        repr.abi = Abi::Rust;
+                        return Ok(());
+                    }
+
+                    // #[repr(transparent)]
+                    if meta.path.is_ident("transparent") {
+                        repr.abi = Abi::Transparent;
+                        return Ok(());
+                    }
+
+                    // #[repr(align(N))]
+                    if meta.path.is_ident("align") {
+                        let content;
+                        parenthesized!(content in meta.input);
+                        let lit: LitInt = content.parse()?;
+                        let n: usize = lit.base10_parse()?;
+                        repr.align = Some(n);
+                        return Ok(());
+                    }
+
+                    // #[repr(packed)] or #[repr(packed(N))], omitted N means 1
+                    if meta.path.is_ident("packed") {
+                        repr.packed = if meta.input.peek(token::Paren) {
+                            let content;
+                            parenthesized!(content in meta.input);
+                            let lit: LitInt = content.parse()?;
+                            let n: usize = lit.base10_parse()?;
+                            Some(n)
+                        } else {
+                            Some(1)
+                        };
+                        return Ok(());
+                    }
+
+                    if let Some(i) = meta.path.get_ident() {
+                        repr.abi = Abi::Other(i.to_string());
+                    }
+
+                    Err(meta.error("unrecognized repr"))
+                }) {
+                    println!("Error while processing Object Derive macro: {}", err);
+                }
+            }
+        }
+        repr
+    }
+}
+
+pub fn assert_is_repr_c_struct(input: &DeriveInput, derive_macro: &'static str) {
+    if !matches!(input.data, Data::Struct(_)) {
+        panic!(
+            "`{}` derive macro can only be used with structs, and `{}` is {}",
+            derive_macro,
+            input.ident,
+            match input.data {
+                Data::Struct(_) => unreachable!(),
+                Data::Enum(_) => "enum",
+                Data::Union(_) => "union",
+            }
+        );
+    }
+    match Repr::detect_repr(&input.attrs) {
+        Repr { abi: Abi::C, .. } => { /* all good */ }
+        Repr {
+            abi: Abi::Transparent,
+            ..
+        } => {
+            // If the data layout is `transparent`, then its representation
+            // depends on the ABI of the wrapped type. We cannot
+            // detect it here.
+        }
+        other => {
+            panic!(
+                "`{}` derive macro can only be used with repr(C) structs, and `{}` {} \
+                 {}\nHint: Annotate the struct with `#[repr(C)]`.",
+                derive_macro,
+                input.ident,
+                if other.present { "is" } else { "defaults to" },
+                other,
+            );
+        }
+    }
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index c72d34b607df1da90185046f4d9c26b3cb6c6523..0bd70b59afcc005251135802897954789b068e6e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,8 +3,7 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
-      'src/definitions.rs',
-      'src/device_class.rs',
+      'src/objects.rs',
     ],
     {'.' : bindings_rs},
   ),
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
deleted file mode 100644
index 60bd3f8aaa65ae131a9c4628a96ac52f590d7324..0000000000000000000000000000000000000000
--- a/rust/qemu-api/src/definitions.rs
+++ /dev/null
@@ -1,97 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-//! Definitions required by QEMU when registering a device.
-
-use ::core::ffi::{c_void, CStr};
-
-use crate::bindings::{Object, ObjectClass, TypeInfo};
-
-/// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl {
-    type Class;
-    const TYPE_INFO: TypeInfo;
-    const TYPE_NAME: &'static CStr;
-    const PARENT_TYPE_NAME: Option<&'static CStr>;
-    const ABSTRACT: bool;
-    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
-    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
-    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)>;
-}
-
-pub trait Class {
-    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)>;
-    const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
-    >;
-}
-
-#[macro_export]
-macro_rules! module_init {
-    ($func:expr, $type:expr) => {
-        #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static LOAD_MODULE: extern "C" fn() = {
-            extern "C" fn __load() {
-                unsafe {
-                    $crate::bindings::register_module_init(Some($func), $type);
-                }
-            }
-
-            __load
-        };
-    };
-    (qom: $func:ident => $body:block) => {
-        // NOTE: To have custom identifiers for the ctor func we need to either supply
-        // them directly as a macro argument or create them with a proc macro.
-        #[used]
-        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
-        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static LOAD_MODULE: extern "C" fn() = {
-            extern "C" fn __load() {
-                #[no_mangle]
-                unsafe extern "C" fn $func() {
-                    $body
-                }
-
-                unsafe {
-                    $crate::bindings::register_module_init(
-                        Some($func),
-                        $crate::bindings::module_init_type::MODULE_INIT_QOM,
-                    );
-                }
-            }
-
-            __load
-        };
-    };
-}
-
-#[macro_export]
-macro_rules! type_info {
-    ($t:ty) => {
-        $crate::bindings::TypeInfo {
-            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
-            parent: if let Some(pname) = <$t as $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
-                pname.as_ptr()
-            } else {
-                ::core::ptr::null_mut()
-            },
-            instance_size: ::core::mem::size_of::<$t>() as $crate::bindings::size_t,
-            instance_align: ::core::mem::align_of::<$t>() as $crate::bindings::size_t,
-            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
-            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
-            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
-            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
-            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>() as $crate::bindings::size_t,
-            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
-            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
-            class_data: ::core::ptr::null_mut(),
-            interfaces: ::core::ptr::null_mut(),
-        };
-    }
-}
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
deleted file mode 100644
index 1ea95beb78dbf8637d9af1edb668d51411a9ac33..0000000000000000000000000000000000000000
--- a/rust/qemu-api/src/device_class.rs
+++ /dev/null
@@ -1,128 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use std::sync::OnceLock;
-
-use crate::bindings::Property;
-
-#[macro_export]
-macro_rules! device_class_init {
-    ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
-        #[no_mangle]
-        pub unsafe extern "C" fn $func(
-            klass: *mut $crate::bindings::ObjectClass,
-            _: *mut ::core::ffi::c_void,
-        ) {
-            let mut dc =
-                ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
-            dc.as_mut().realize = $realize_fn;
-            dc.as_mut().vmsd = &$vmsd;
-            $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
-            $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
-        }
-    };
-}
-
-#[macro_export]
-macro_rules! define_property {
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
-        $crate::bindings::Property {
-            name: {
-                #[used]
-                static _TEMP: &::core::ffi::CStr = $name;
-                _TEMP.as_ptr()
-            },
-            info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
-                .try_into()
-                .expect("Could not fit offset value to type"),
-            bitnr: 0,
-            bitmask: 0,
-            set_default: true,
-            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
-            arrayoffset: 0,
-            arrayinfo: ::core::ptr::null(),
-            arrayfieldsize: 0,
-            link_type: ::core::ptr::null(),
-        }
-    };
-    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
-        $crate::bindings::Property {
-            name: {
-                #[used]
-                static _TEMP: &::core::ffi::CStr = $name;
-                _TEMP.as_ptr()
-            },
-            info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
-                .try_into()
-                .expect("Could not fit offset value to type"),
-            bitnr: 0,
-            bitmask: 0,
-            set_default: false,
-            defval: $crate::bindings::Property__bindgen_ty_1 { i: 0 },
-            arrayoffset: 0,
-            arrayinfo: ::core::ptr::null(),
-            arrayfieldsize: 0,
-            link_type: ::core::ptr::null(),
-        }
-    };
-}
-
-#[repr(C)]
-pub struct Properties<const N: usize>(pub OnceLock<[Property; N]>, pub fn() -> [Property; N]);
-
-impl<const N: usize> Properties<N> {
-    pub fn as_mut_ptr(&mut self) -> *mut Property {
-        _ = self.0.get_or_init(self.1);
-        self.0.get_mut().unwrap().as_mut_ptr()
-    }
-}
-
-#[macro_export]
-macro_rules! declare_properties {
-    ($ident:ident, $($prop:expr),*$(,)*) => {
-
-        const fn _calc_prop_len() -> usize {
-            let mut len = 1;
-            $({
-                _ = stringify!($prop);
-                len += 1;
-            })*
-            len
-        }
-        const PROP_LEN: usize = _calc_prop_len();
-
-        fn _make_properties() -> [$crate::bindings::Property; PROP_LEN] {
-            [
-                $($prop),*,
-                    unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
-            ]
-        }
-
-        #[no_mangle]
-        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
-    };
-}
-
-#[macro_export]
-macro_rules! vm_state_description {
-    ($(#[$outer:meta])*
-     $name:ident,
-     $(name: $vname:expr,)*
-     $(unmigratable: $um_val:expr,)*
-    ) => {
-        #[used]
-        $(#[$outer])*
-        pub static $name: $crate::bindings::VMStateDescription = $crate::bindings::VMStateDescription {
-            $(name: {
-                #[used]
-                static VMSTATE_NAME: &::core::ffi::CStr = $vname;
-                $vname.as_ptr()
-            },)*
-            unmigratable: true,
-            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStateDescription>::zeroed().assume_init() }
-        };
-    }
-}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index e72fb4b4bb13b0982f828b6ec1cfe848c3e6bdf0..b94adc15288cdc62de7679988f549ebd80f895d7 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -27,11 +27,7 @@ unsafe impl Sync for bindings::Property {}
 unsafe impl Sync for bindings::TypeInfo {}
 unsafe impl Sync for bindings::VMStateDescription {}
 
-pub mod definitions;
-pub mod device_class;
-
-#[cfg(test)]
-mod tests;
+pub mod objects;
 
 use std::alloc::{GlobalAlloc, Layout};
 
diff --git a/rust/qemu-api/src/objects.rs b/rust/qemu-api/src/objects.rs
new file mode 100644
index 0000000000000000000000000000000000000000..5c6762023ed6914f9c6b7dd16a5e07f778c2d4fa
--- /dev/null
+++ b/rust/qemu-api/src/objects.rs
@@ -0,0 +1,90 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Implementation traits for QEMU objects, devices.
+
+use ::core::ffi::{c_int, c_void, CStr};
+
+use crate::bindings::{DeviceState, Error, MigrationPriority, Object, ObjectClass, TypeInfo};
+
+/// Trait a type must implement to be registered with QEMU.
+pub trait ObjectImpl {
+    type Class: ClassImpl;
+    const TYPE_NAME: &'static CStr;
+    const PARENT_TYPE_NAME: Option<&'static CStr>;
+    const ABSTRACT: bool;
+
+    unsafe fn instance_init(&mut self) {}
+    fn instance_post_init(&mut self) {}
+    fn instance_finalize(&mut self) {}
+}
+
+/// The `extern`/`unsafe` analogue of [`ObjectImpl`]; it is used internally by `#[derive(Object)]`
+/// and should not be implemented manually.
+pub unsafe trait ObjectImplUnsafe {
+    const TYPE_INFO: TypeInfo;
+
+    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
+    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
+    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)>;
+}
+
+/// Methods for QOM class types.
+pub trait ClassImpl {
+    type Object: ObjectImpl;
+
+    unsafe fn class_init(&mut self, _data: *mut core::ffi::c_void) {}
+    unsafe fn class_base_init(&mut self, _data: *mut core::ffi::c_void) {}
+}
+
+/// The `extern`/`unsafe` analogue of [`ClassImpl`]; it is used internally by `#[derive(Object)]`
+/// and should not be implemented manually.
+pub unsafe trait ClassImplUnsafe {
+    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)>;
+    const CLASS_BASE_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+    >;
+}
+
+/// Implementation methods for device types.
+pub trait DeviceImpl: ObjectImpl {
+    fn realize(&mut self) {}
+    fn reset(&mut self) {}
+}
+
+/// The `extern`/`unsafe` analogue of [`DeviceImpl`]; it is used internally by `#[derive(Device)]`
+/// and should not be implemented manually.
+pub unsafe trait DeviceImplUnsafe {
+    const REALIZE: Option<unsafe extern "C" fn(dev: *mut DeviceState, _errp: *mut *mut Error)>;
+    const RESET: Option<unsafe extern "C" fn(dev: *mut DeviceState)>;
+}
+
+/// Constant metadata and implementation methods for types with device migration state.
+pub trait Migrateable: DeviceImplUnsafe {
+    const NAME: Option<&'static CStr> = None;
+    const UNMIGRATABLE: bool = true;
+    const EARLY_SETUP: bool = false;
+    const VERSION_ID: c_int = 1;
+    const MINIMUM_VERSION_ID: c_int = 1;
+    const PRIORITY: MigrationPriority = MigrationPriority::MIG_PRI_DEFAULT;
+
+    unsafe fn pre_load(&mut self) -> c_int {
+        0
+    }
+    unsafe fn post_load(&mut self, _version_id: c_int) -> c_int {
+        0
+    }
+    unsafe fn pre_save(&mut self) -> c_int {
+        0
+    }
+    unsafe fn post_save(&mut self) -> c_int {
+        0
+    }
+    unsafe fn needed(&mut self) -> bool {
+        false
+    }
+    unsafe fn dev_unplug_pending(&mut self) -> bool {
+        false
+    }
+}
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
deleted file mode 100644
index df54edbd4e27e7d2aafc243355d1826d52497c21..0000000000000000000000000000000000000000
--- a/rust/qemu-api/src/tests.rs
+++ /dev/null
@@ -1,49 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use crate::{
-    bindings::*, declare_properties, define_property, device_class_init, vm_state_description,
-};
-
-#[test]
-fn test_device_decl_macros() {
-    // Test that macros can compile.
-    vm_state_description! {
-        VMSTATE,
-        name: c"name",
-        unmigratable: true,
-    }
-
-    #[repr(C)]
-    pub struct DummyState {
-        pub char_backend: CharBackend,
-        pub migrate_clock: bool,
-    }
-
-    declare_properties! {
-        DUMMY_PROPERTIES,
-            define_property!(
-                c"chardev",
-                DummyState,
-                char_backend,
-                unsafe { &qdev_prop_chr },
-                CharBackend
-            ),
-            define_property!(
-                c"migrate-clk",
-                DummyState,
-                migrate_clock,
-                unsafe { &qdev_prop_bool },
-                bool
-            ),
-    }
-
-    device_class_init! {
-        dummy_class_init,
-        props => DUMMY_PROPERTIES,
-        realize_fn => None,
-        reset_fn => None,
-        vmsd => VMSTATE,
-    }
-}
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index a53335f3092e06723039513a1bf5a0d35b4afcd7..9f56ce1c24d0ff86e9b0146b0f82c37ac868fab7 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -24,6 +24,7 @@ _syn_rs = static_library(
     '--cfg', 'feature="printing"',
     '--cfg', 'feature="clone-impls"',
     '--cfg', 'feature="proc-macro"',
+    '--cfg', 'feature="extra-traits"',
   ],
   dependencies: [
     quote_dep,

-- 
2.45.2


