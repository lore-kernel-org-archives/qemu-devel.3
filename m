Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ED1C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQS-00085x-K1; Fri, 07 Feb 2025 05:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQA-0007cD-OY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQ7-0004JP-9r
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uES4HqqtaqOqQfE1eDVbpmrfNp7K4yqKrpgY/1SVq6M=;
 b=MVfwFLJ+opy4yyOosnBaDVM3guywh7iQ9BhGg+Np27IlzCYF+2OFTlDJ4sXAwmyaUFcipd
 gOdvF7fzP0wjwZt7HRROCJTlOk0o5FlIxk9dnvGcnFOUMxHtnQwnceCDmtNHWBiLhw1H1a
 i/zjnUJsfFrvGkZPw1EaghFF4VJABmo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-LbFYS8CPMR-gC_TJmAF7hA-1; Fri, 07 Feb 2025 05:17:07 -0500
X-MC-Unique: LbFYS8CPMR-gC_TJmAF7hA-1
X-Mimecast-MFC-AGG-ID: LbFYS8CPMR-gC_TJmAF7hA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab6c52ca20aso236465466b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923423; x=1739528223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uES4HqqtaqOqQfE1eDVbpmrfNp7K4yqKrpgY/1SVq6M=;
 b=pUoBWjpsdyDv+fWjuSfEQ7LKjRb5Abs4ocFGGLJ49BjgbiSz8TmppHclfx+oU+6IS3
 XPpuJM9TYIP8ss1xhcPOhOZoRX9eWqQVSsw/cuH6G/dKe0sK4VXymwkVNyYiE99Rt4vZ
 Brrc5xcOFI3KBJeVrZVjDHueABKE+KPCPrlgRlXczv4wblKFAT3GqXexMLCxG6sBaeT/
 hpwO4J+Kb0sSgzTlB9VLjtgeJdjFY4mh+hyusYv69PLEcSOJAPd2Q1qvT8mRnE3S2SCI
 o4HJR1S16jUX9KdNjXRHCzwyqdH65aZHtxLTf/c7mSFRPAv8OYc0A0tIaoyiDt7nQW9u
 vVJA==
X-Gm-Message-State: AOJu0Yxt3Gj1MdKOwjqwTrWgIGxgfhPqxAp+ZeV9s2qy1sexb0jxOdPe
 AhKB7WnlHHPJ3Y/r8AoWaffx2JqXHkisOZr2iZy76nv9RvtYWB9iIB0VceBTqHlhsY/hPiSk6Ig
 eVSojPSyyvhZ3VKTm7EeSNHrGX5e54xDsIKjBmbCVL+jAPA3kMmO2XGpVDz7TFUhMjpZo0PvUCx
 YEmB0Y9/hOcYy1pVuC/AxjP7aRIlyQ2TWIJ4Y7Bb8=
X-Gm-Gg: ASbGncuUlNjVsA0E+fMvqSVY21xAvxqhbB1kix3tSMJPsPUcgBtXpXZRrAZhIYStPwc
 gtiSsE+he40jnlarpKaAi2lYFNF+tI4BaX5iy1Z57QiFmF/RfGsI/3Q0e/W108FCc7ejeXQUFo/
 0bA4ekhDZFCMn1zoh372aqMrZYPC4zA+8LK6gYkSeDEpxiLuxEmGZQYKnk9R2tuYlK7Ql2JFPeq
 kMgWWb+SYRz4Sv+bWgUGG1elXCndUr+lzwoh7BtJu96snfuk62KGClB3WE6umAyKkc+Sr0aEhew
 4HNH0A==
X-Received: by 2002:a17:907:1c9c:b0:aab:ee4a:6788 with SMTP id
 a640c23a62f3a-ab789c52c06mr265615266b.57.1738923422911; 
 Fri, 07 Feb 2025 02:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO1fspAubICNGVr5jbIr6183o8CuCT9k/HZqztef1KcklMNYJUU3W4/K74J0ggeoj8UGHV0g==
X-Received: by 2002:a17:907:1c9c:b0:aab:ee4a:6788 with SMTP id
 a640c23a62f3a-ab789c52c06mr265609966b.57.1738923422303; 
 Fri, 07 Feb 2025 02:17:02 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772fd6933sm239441866b.78.2025.02.07.02.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:16:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 07/12] rust: qdev: switch from legacy reset to Resettable
Date: Fri,  7 Feb 2025 11:16:18 +0100
Message-ID: <20250207101623.2443552-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      |   1 +
 rust/hw/char/pl011/src/device.rs |  10 ++-
 rust/qemu-api/src/qdev.rs        | 111 ++++++++++++++++++++++++-------
 rust/qemu-api/tests/tests.rs     |   5 +-
 4 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/meson.build b/meson.build
index 131b2225ab6..32abefb7c48 100644
--- a/meson.build
+++ b/meson.build
@@ -4072,6 +4072,7 @@ if have_rust
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
index cb6f12e726c..2ec1ecc8489 100644
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
index 9986925d71f..ccf915d64f3 100644
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


