Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7880C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHX-0001IT-T7; Fri, 24 Jan 2025 04:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGI-0007dW-Nj
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGG-0003xu-LV
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX5ZXSWUGkXS8f5Sw6QjzbC9hARnbnbxThpUdHGomPY=;
 b=HOf5tA2aWbrLnhzHrCTJR5b/EsUFHzT+JoOnVOTNSirTuhUivw7LB5asCPRTK1wRsYNWmh
 kS55pBKrQNL0OVljz9puRb+im1oMLyoAA4SBC9sLykqdN7y1b6U5v5P/StsIyr0sGbhPuK
 X5Xz8feG0gigDDdW1T3kjz8DDecWG8Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-RgrdhWqbOlagfosL1Ofv4g-1; Fri, 24 Jan 2025 04:45:57 -0500
X-MC-Unique: RgrdhWqbOlagfosL1Ofv4g-1
X-Mimecast-MFC-AGG-ID: RgrdhWqbOlagfosL1Ofv4g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359eb032c9so13289975e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711955; x=1738316755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GX5ZXSWUGkXS8f5Sw6QjzbC9hARnbnbxThpUdHGomPY=;
 b=EqwjQsZTMlQIBQYWg/jbwovx4l3/Et7MLIzFoD9IJOZI57k88EAko2i3amMaTrmpK/
 fQSD/pEgDB49GaII7p3z5bSBYzRQWWpVB3uMTJSI3BI0rwgOfAsZRaVhJfK1bbcedj2M
 ouFAYUY5PIzOMrWGxRic93v+qZ+JQhuHIoWxfwKtFn/bJE/QCijL3JhidrUsbVeVgx84
 AaRSOa/0J+zhN69ck857bpWVyiJ6XKJ5Qp9uwDbJmJ3khnOr/Wf9Me355DmeGSePY5K+
 Z2vTgG2NMruXVEVETLkd8YPzLZOifSqQVSxFeu/zpg2hCs8hcuWwaxOVB5odVow8y8TX
 FjXg==
X-Gm-Message-State: AOJu0YwYVsaswOxK+H+Bz360i7pRoy7HqIkvT3IDbsyILvPvyBQWTnlq
 +edM3DMwq76SCmipFhZIi1zm4OTJ5JjVlvj1v1PNtuOqv5PCaGAkxw20VlbusF11ifDMdkvVvRF
 ItXyTjJBvMv/dZb4Em1RNAeqH45CkoRN7UPy8HVuvlhqu400ig8YnJsA4GtZyTrmQWEaQ7i3vmw
 6uNuPQBlpfhycyMg0gSU4et9oQKulgd1wrHVWikrU=
X-Gm-Gg: ASbGncv2GhiIi8tBr6FwpBp2xTa4tWWZ1Rxo/9YZDCY6nTjRSoB6PIWbHDIJZH8Sd6+
 sIoI+bKpx7AeC3OQiLOW/C7zlU6FsFWmJWdyjTA4V7BQOpIB0ozvR99PrJH7zxBlL4sLdpQ7vI2
 LGj2Ed1SG1Elyvjik8lPmMVHAOekbEOAJtg8iaH8hhAnKNSY8FtoEaxgpKfKdgXopcZAaXxDije
 +4tzTbg3Ggtgo8oVocHU7b3kBTJ0767PTKQZ8opZpe8mlKqdKnT1NXH6MdteH8dLUllUWMz3Q==
X-Received: by 2002:a7b:c3d8:0:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-438a0d3c71fmr208517655e9.6.1737711955383; 
 Fri, 24 Jan 2025 01:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR9jW+ROCeL72qO2reeDCROKBMuAF3wWj+2qVaXLi7wNINfmAQHvdTWDrQXp4CNcpJCHUt3Q==
X-Received: by 2002:a7b:c3d8:0:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-438a0d3c71fmr208517355e9.6.1737711954807; 
 Fri, 24 Jan 2025 01:45:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa46esm20470025e9.1.2025.01.24.01.45.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/48] rust: prefer NonNull::new to assertions
Date: Fri, 24 Jan 2025 10:44:29 +0100
Message-ID: <20250124094442.13207-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Do not use new_unchecked; the effect is the same, but the
code is easier to read and unsafe regions become smaller.
Likewise, NonNull::new can be used instead of assertion and
followed by as_ref() or as_mut() instead of dereferencing the
pointer.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 17 +++++------------
 rust/hw/char/pl011/src/device_class.rs | 23 +++++++++--------------
 rust/hw/char/pl011/src/memory_ops.rs   |  9 +++------
 rust/qemu-api/src/qdev.rs              | 12 +++++-------
 rust/qemu-api/src/qom.rs               | 21 +++++++++++++--------
 5 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index a1a522fdcdb..c0b53f2515c 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -593,11 +593,8 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
 pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_ref().can_receive().into()
-    }
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_ref().can_receive().into() }
 }
 
 /// # Safety
@@ -608,9 +605,8 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 ///
 /// The buffer and size arguments must also be valid.
 pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8, size: c_int) {
+    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
     unsafe {
-        debug_assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
         if state.as_ref().loopback_enabled() {
             return;
         }
@@ -627,11 +623,8 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
 pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEvent) {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_mut().event(event)
-    }
+    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_mut().event(event) }
 }
 
 /// # Safety
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index b052d98803f..6fa14ca0f9b 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -12,12 +12,10 @@
 
 use crate::device::PL011State;
 
+#[allow(clippy::missing_const_for_fn)]
 extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_ref().migrate_clock
-    }
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_ref().migrate_clock }
 }
 
 /// Migration subsection for [`PL011State`] clock.
@@ -33,15 +31,12 @@ extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
 };
 
 extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
-    unsafe {
-        debug_assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        let result = state.as_mut().post_load(version_id as u32);
-        if result.is_err() {
-            -1
-        } else {
-            0
-        }
+    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    let result = unsafe { state.as_mut().post_load(version_id as u32) };
+    if result.is_err() {
+        -1
+    } else {
+        0
     }
 }
 
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index c4e8599ba43..a286003d136 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -25,7 +25,7 @@
 
 unsafe extern "C" fn pl011_read(opaque: *mut c_void, addr: hwaddr, size: c_uint) -> u64 {
     assert!(!opaque.is_null());
-    let mut state = unsafe { NonNull::new_unchecked(opaque.cast::<PL011State>()) };
+    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
     let val = unsafe { state.as_mut().read(addr, size) };
     match val {
         std::ops::ControlFlow::Break(val) => val,
@@ -43,9 +43,6 @@
 }
 
 unsafe extern "C" fn pl011_write(opaque: *mut c_void, addr: hwaddr, data: u64, _size: c_uint) {
-    unsafe {
-        assert!(!opaque.is_null());
-        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
-        state.as_mut().write(addr, data)
-    }
+    let mut state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_mut().write(addr, data) }
 }
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index a5121e31a37..42429903aae 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -4,7 +4,7 @@
 
 //! Bindings to create devices and access device functionality from Rust.
 
-use std::ffi::CStr;
+use std::{ffi::CStr, ptr::NonNull};
 
 pub use bindings::{DeviceClass, DeviceState, Property};
 
@@ -55,9 +55,8 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(dev: *mut DeviceState, _errp: *mut *mut Error) {
-    assert!(!dev.is_null());
-    let state = dev.cast::<T>();
-    T::REALIZE.unwrap()(unsafe { &mut *state });
+    let state = NonNull::new(dev).unwrap().cast::<T>();
+    T::REALIZE.unwrap()(unsafe { state.as_ref() });
 }
 
 /// # Safety
@@ -66,9 +65,8 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_reset_fn<T: DeviceImpl>(dev: *mut DeviceState) {
-    assert!(!dev.is_null());
-    let state = dev.cast::<T>();
-    T::RESET.unwrap()(unsafe { &mut *state });
+    let mut state = NonNull::new(dev).unwrap().cast::<T>();
+    T::RESET.unwrap()(unsafe { state.as_mut() });
 }
 
 impl<T> ClassInitImpl<DeviceClass> for T
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 97901fb9084..f50ee371aac 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -58,6 +58,7 @@
     fmt,
     ops::{Deref, DerefMut},
     os::raw::c_void,
+    ptr::NonNull,
 };
 
 pub use bindings::{Object, ObjectClass};
@@ -153,27 +154,34 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
 }
 
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
+    let mut state = NonNull::new(obj).unwrap().cast::<T>();
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
     // is called from QOM core as the instance_init function
     // for class T
-    unsafe { T::INSTANCE_INIT.unwrap()(&mut *obj.cast::<T>()) }
+    unsafe {
+        T::INSTANCE_INIT.unwrap()(state.as_mut());
+    }
 }
 
 unsafe extern "C" fn rust_instance_post_init<T: ObjectImpl>(obj: *mut Object) {
+    let state = NonNull::new(obj).unwrap().cast::<T>();
     // SAFETY: obj is an instance of T, since rust_instance_post_init<T>
     // is called from QOM core as the instance_post_init function
     // for class T
-    T::INSTANCE_POST_INIT.unwrap()(unsafe { &*obj.cast::<T>() })
+    T::INSTANCE_POST_INIT.unwrap()(unsafe { state.as_ref() });
 }
 
 unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
     klass: *mut ObjectClass,
     _data: *mut c_void,
 ) {
+    let mut klass = NonNull::new(klass)
+        .unwrap()
+        .cast::<<T as ObjectType>::Class>();
     // SAFETY: klass is a T::Class, since rust_class_init<T>
     // is called from QOM core as the class_init function
     // for class T
-    T::class_init(unsafe { &mut *klass.cast::<T::Class>() })
+    T::class_init(unsafe { klass.as_mut() })
 }
 
 unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
@@ -581,11 +589,8 @@ pub trait ClassInitImpl<T> {
 /// can be downcasted to type `T`. We also expect the device is
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_unparent_fn<T: ObjectImpl>(dev: *mut Object) {
-    unsafe {
-        assert!(!dev.is_null());
-        let state = core::ptr::NonNull::new_unchecked(dev.cast::<T>());
-        T::UNPARENT.unwrap()(state.as_ref());
-    }
+    let state = NonNull::new(dev).unwrap().cast::<T>();
+    T::UNPARENT.unwrap()(unsafe { state.as_ref() });
 }
 
 impl<T> ClassInitImpl<ObjectClass> for T
-- 
2.48.1


