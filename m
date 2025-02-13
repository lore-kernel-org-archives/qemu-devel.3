Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AF5C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibf1-0000zq-80; Thu, 13 Feb 2025 11:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeY-0000r7-LH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeW-0005UG-8j
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5PgGVHnFw25YamWWjyXuJxRbq8ocW+EGCTnABnLuhE=;
 b=QF5wnS8Lqw0FAkeZIgGyMatbwOKjf/bVDtm6rRZg11y8ZUxZqwwW5NIbirVC+6Gl+QeFah
 uMr12QvcPKSJ3b71o7smDDZ5Voacz643ixWXBQoHB0cDJx5OdIh4uCEMlNu0uChmzhxg+v
 r7EgE9IdxiZBTNlkBkIGx1sT9gWbBMA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-NL5AhxH9N2yCwNjoXHosuw-1; Thu, 13 Feb 2025 11:01:22 -0500
X-MC-Unique: NL5AhxH9N2yCwNjoXHosuw-1
X-Mimecast-MFC-AGG-ID: NL5AhxH9N2yCwNjoXHosuw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dcc9653a7so553469f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462480; x=1740067280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5PgGVHnFw25YamWWjyXuJxRbq8ocW+EGCTnABnLuhE=;
 b=NRsFNm0UKX0Vl6L2XbLniKJVou+vjMLVuD1QY5oDOiFCuNKTkigQvIUhdkSTK7IWnF
 z7MrRI+HEvRrslFqPXg+xTcm3c4yUUtI6IbCbQ5R4UHnLSwndovBGIFMTyoeQUckwDzw
 R27NHitrHJ3+U/8bZvpSmkhONNy/pa26Ul20/JRZkwGBXhEWsC0c7DRyeRCc/kK4f/i5
 jIUIfBrjXLC4gN3O0BEhy43reef5lJH5MUonrFCz+WnAcRj9P9T69/fSn1go1qbC/7XN
 175YP1NWLBomzjyVH9tBWYD5pytD2iWTl3LNBPlQ6gMigWrLHvmV1s/pvOQ2ic9lVOJn
 NnNA==
X-Gm-Message-State: AOJu0YwlH9OlNDw/YXQRg/8bBaSjNzFEnciO9yKp85a+ZgwRCvFPOLkK
 tC9ysBwHoZDUCmRjSlOayusYMb7qJoV0sqS75cffyP3Ye70Uou3jDJsiH4Si70ncML8yKHPyJOU
 tdOdhLerj0zf4P/BtlYbg7lYZ6YjS6oaiG9+a4Z6PiQRTbEan6+NSaH1ZGAAs6FPDPT5xJtpy4j
 1W9G5HdClxgMBXEJaOS5Urtkk7CAFbjZcVDEKqsgw=
X-Gm-Gg: ASbGncvMrH5FIBAr5exx5O/O7sL/9+/2Yt1aARyaiieJ5q9m6rYVi6MNRfV829PT7jz
 FpcHc7Y2/0B7R+1auEvwbjY+V0YgL15Jg/wM8pH0ETq/JvfH+dQ7OtbQH07uZ3vUTLurgc6Rjyj
 0wSeOkf5ksvzMG0bvQYKykQQG8Zp4g0ukD5W+hjCQEoxUbMgrRICBqadmbSqmpMO4H8i7M9fHPV
 bOW78qBZkSNaoHLmkPuqmNnay5Kk4tkVAx19SyOSDialQv48FDSPGg/KalqccsD1kKR0zGPINnr
 /4EXy8PQRU0X2+Ins6G0QgKEPtUMDmF/4qmBkiBYUSAo0w==
X-Received: by 2002:a7b:cbc7:0:b0:439:65c5:f28a with SMTP id
 5b1f17b1804b1-43965c5f2f4mr10437425e9.16.1739462479628; 
 Thu, 13 Feb 2025 08:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI/OtkM4KzRpkrEmA5gaL8NEPd8+zDRB23sLWWWDgbMUquXcu+YggW9qr4BYDWdT6pEbsDOQ==
X-Received: by 2002:a7b:cbc7:0:b0:439:65c5:f28a with SMTP id
 5b1f17b1804b1-43965c5f2f4mr10436655e9.16.1739462478813; 
 Thu, 13 Feb 2025 08:01:18 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439617ffa28sm21270095e9.14.2025.02.13.08.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/27] rust: qdev: switch from legacy reset to Resettable
Date: Thu, 13 Feb 2025 17:00:35 +0100
Message-ID: <20250213160054.3937012-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      |   1 +
 rust/hw/char/pl011/src/device.rs |  10 ++-
 rust/qemu-api/src/qdev.rs        | 111 ++++++++++++++++++++++++-------
 rust/qemu-api/tests/tests.rs     |   5 +-
 4 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/meson.build b/meson.build
index 18cf9e2913b..16c76c493f3 100644
--- a/meson.build
+++ b/meson.build
@@ -4073,6 +4073,7 @@ if have_rust
     'MigrationPriority',
     'QEMUChrEvent',
     'QEMUClockType',
+    'ResetType',
     'device_endian',
     'module_init_type',
   ]
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 37936a328b8..1d0390b4fbe 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -18,7 +18,7 @@
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
     prelude::*,
-    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property},
+    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
     sysbus::{SysBusDevice, SysBusDeviceClass},
     vmstate::VMStateDescription,
@@ -171,7 +171,10 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
     const REALIZE: Option<fn(&Self)> = Some(Self::realize);
-    const RESET: Option<fn(&Self)> = Some(Self::reset);
+}
+
+impl ResettablePhasesImpl for PL011State {
+    const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
 }
 
 impl PL011Registers {
@@ -622,7 +625,7 @@ pub fn realize(&self) {
         }
     }
 
-    pub fn reset(&self) {
+    pub fn reset_hold(&self, _type: ResetType) {
         self.regs.borrow_mut().reset();
     }
 
@@ -737,3 +740,4 @@ impl ObjectImpl for PL011Luminary {
 }
 
 impl DeviceImpl for PL011Luminary {}
+impl ResettablePhasesImpl for PL011Luminary {}
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 34d24da4b63..64ba3d90981 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -10,10 +10,10 @@
     ptr::NonNull,
 };
 
-pub use bindings::{Clock, ClockEvent, DeviceClass, DeviceState, Property};
+pub use bindings::{Clock, ClockEvent, DeviceClass, DeviceState, Property, ResetType};
 
 use crate::{
-    bindings::{self, Error},
+    bindings::{self, Error, ResettableClass},
     callbacks::FnCall,
     cell::bql_locked,
     prelude::*,
@@ -21,8 +21,70 @@
     vmstate::VMStateDescription,
 };
 
+/// Trait providing the contents of the `ResettablePhases` struct,
+/// which is part of the QOM `Resettable` interface.
+pub trait ResettablePhasesImpl {
+    /// If not None, this is called when the object enters reset. It
+    /// can reset local state of the object, but it must not do anything that
+    /// has a side-effect on other objects, such as raising or lowering an
+    /// [`InterruptSource`](crate::irq::InterruptSource), or reading or
+    /// writing guest memory. It takes the reset's type as argument.
+    const ENTER: Option<fn(&Self, ResetType)> = None;
+
+    /// If not None, this is called when the object for entry into reset, once
+    /// every object in the system which is being reset has had its
+    /// `ResettablePhasesImpl::ENTER` method called. At this point devices
+    /// can do actions that affect other objects.
+    ///
+    /// If in doubt, implement this method.
+    const HOLD: Option<fn(&Self, ResetType)> = None;
+
+    /// If not None, this phase is called when the object leaves the reset
+    /// state. Actions affecting other objects are permitted.
+    const EXIT: Option<fn(&Self, ResetType)> = None;
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_resettable_enter_fn<T: ResettablePhasesImpl>(
+    obj: *mut Object,
+    typ: ResetType,
+) {
+    let state = NonNull::new(obj).unwrap().cast::<T>();
+    T::ENTER.unwrap()(unsafe { state.as_ref() }, typ);
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_resettable_hold_fn<T: ResettablePhasesImpl>(
+    obj: *mut Object,
+    typ: ResetType,
+) {
+    let state = NonNull::new(obj).unwrap().cast::<T>();
+    T::HOLD.unwrap()(unsafe { state.as_ref() }, typ);
+}
+
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer that
+/// can be downcasted to type `T`. We also expect the device is
+/// readable/writeable from one thread at any time.
+unsafe extern "C" fn rust_resettable_exit_fn<T: ResettablePhasesImpl>(
+    obj: *mut Object,
+    typ: ResetType,
+) {
+    let state = NonNull::new(obj).unwrap().cast::<T>();
+    T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
+}
+
 /// Trait providing the contents of [`DeviceClass`].
-pub trait DeviceImpl: ObjectImpl {
+pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl {
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
     /// this is not yet supported for Rust devices).
@@ -31,13 +93,6 @@ pub trait DeviceImpl: ObjectImpl {
     /// with the function pointed to by `REALIZE`.
     const REALIZE: Option<fn(&Self)> = None;
 
-    /// If not `None`, the parent class's `reset` method is overridden
-    /// with the function pointed to by `RESET`.
-    ///
-    /// Rust does not yet support the three-phase reset protocol; this is
-    /// usually okay for leaf classes.
-    const RESET: Option<fn(&Self)> = None;
-
     /// An array providing the properties that the user can set on the
     /// device.  Not a `const` because referencing statics in constants
     /// is unstable until Rust 1.83.0.
@@ -65,29 +120,36 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     T::REALIZE.unwrap()(unsafe { state.as_ref() });
 }
 
-/// # Safety
-///
-/// We expect the FFI user of this function to pass a valid pointer that
-/// can be downcasted to type `T`. We also expect the device is
-/// readable/writeable from one thread at any time.
-unsafe extern "C" fn rust_reset_fn<T: DeviceImpl>(dev: *mut DeviceState) {
-    let mut state = NonNull::new(dev).unwrap().cast::<T>();
-    T::RESET.unwrap()(unsafe { state.as_mut() });
+unsafe impl InterfaceType for ResettableClass {
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_RESETTABLE_INTERFACE) };
+}
+
+impl<T> ClassInitImpl<ResettableClass> for T
+where
+    T: ResettablePhasesImpl,
+{
+    fn class_init(rc: &mut ResettableClass) {
+        if <T as ResettablePhasesImpl>::ENTER.is_some() {
+            rc.phases.enter = Some(rust_resettable_enter_fn::<T>);
+        }
+        if <T as ResettablePhasesImpl>::HOLD.is_some() {
+            rc.phases.hold = Some(rust_resettable_hold_fn::<T>);
+        }
+        if <T as ResettablePhasesImpl>::EXIT.is_some() {
+            rc.phases.exit = Some(rust_resettable_exit_fn::<T>);
+        }
+    }
 }
 
 impl<T> ClassInitImpl<DeviceClass> for T
 where
-    T: ClassInitImpl<ObjectClass> + DeviceImpl,
+    T: ClassInitImpl<ObjectClass> + ClassInitImpl<ResettableClass> + DeviceImpl,
 {
     fn class_init(dc: &mut DeviceClass) {
         if <T as DeviceImpl>::REALIZE.is_some() {
             dc.realize = Some(rust_realize_fn::<T>);
         }
-        if <T as DeviceImpl>::RESET.is_some() {
-            unsafe {
-                bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
-            }
-        }
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             dc.vmsd = vmsd;
         }
@@ -98,6 +160,7 @@ fn class_init(dc: &mut DeviceClass) {
             }
         }
 
+        ResettableClass::interface_init::<T, DeviceState>(dc);
         <T as ClassInitImpl<ObjectClass>>::class_init(&mut dc.parent_class);
     }
 }
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 10748fba197..92dbfb8a0c8 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -13,7 +13,7 @@
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
-    qdev::{DeviceClass, DeviceImpl, DeviceState, Property},
+    qdev::{DeviceClass, DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, ParentField},
     vmstate::VMStateDescription,
     zeroable::Zeroable,
@@ -61,6 +61,8 @@ impl ObjectImpl for DummyState {
     const ABSTRACT: bool = false;
 }
 
+impl ResettablePhasesImpl for DummyState {}
+
 impl DeviceImpl for DummyState {
     fn properties() -> &'static [Property] {
         &DUMMY_PROPERTIES
@@ -101,6 +103,7 @@ impl ObjectImpl for DummyChildState {
     const ABSTRACT: bool = false;
 }
 
+impl ResettablePhasesImpl for DummyChildState {}
 impl DeviceImpl for DummyChildState {}
 
 impl ClassInitImpl<DummyClass> for DummyChildState {
-- 
2.48.1


