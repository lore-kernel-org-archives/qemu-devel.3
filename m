Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C2EC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOeg2-0000a5-61; Mon, 09 Jun 2025 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOeg0-0000V8-Fn
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefx-0007id-T8
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749483881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJdTmi7Wq/CYnDjJy94M4C2eH+AHFnXk5byaM7y7ITg=;
 b=MUM4whgXkq63yWTZbNbcJLgbMKJBiykJxpVjheAIgJgptDG45ihzxUiFApA7ckSzZgM+m5
 dk0mZbxP6UVKav3Di0LjmEW105nFPSMpM5/SIKjI8xxA2IgfC1F3/y1e5uuhshhFM/TD+e
 DXl/7gDTHfJ+lEH1PTmeclx8Ke7qyEM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-flbWxF30OZqc7beeTtDIvA-1; Mon, 09 Jun 2025 11:44:39 -0400
X-MC-Unique: flbWxF30OZqc7beeTtDIvA-1
X-Mimecast-MFC-AGG-ID: flbWxF30OZqc7beeTtDIvA_1749483878
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so34384995e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483877; x=1750088677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJdTmi7Wq/CYnDjJy94M4C2eH+AHFnXk5byaM7y7ITg=;
 b=CzI97+/7904dlw8AGCI1G6q3djkrw+c8xnSXCJvtoG+ZHKjI1+Ar5fv0Z4aqrhSGQg
 DiHpSNyCu+mfRJcPcBCuacR2KutT+bM2E6f6bWmOUmHwAhNsJUBpy2z2RRvdiXrW+i1l
 Xl2aeE04vED1uBnvEvyyWJvg25kqDpSg/B9mvRjfE2K4Z6Cm5vRDsXUPTu+4jtwTWmBL
 oN0Bv1kKwwRa+lPM6jDMfZdpEjXfZYK+CMU4LuOyPgy9uzr00ngPY+Jaw2CqXGja1XvH
 KVqYPuSLUDhgD2eEbdMLvOgbc2NOQ6ttuw2SgIX+u5QoReMh26lI3QKO5Qfu98Rubq+C
 4iZw==
X-Gm-Message-State: AOJu0YwYAFlA2k7VpJqJ903LmN9DXR47abMJCh4/pOFQKBkVZE2P890v
 dD+Qa2oYR+FJxpJQiTBIZ0VFAl07RaLFRhkvPb/9jS4LQrO17Og65K7TM/DckdpCwRSKTx9lzm5
 /sHkKD0U9zJ97LTNUvEK3MOV4+1ipw/FvC/Zo2MVDup1bmQbDxb+4g22pjXwTvBR2KGqbJjD1gm
 5olhDctUFZCgggjU8NtgaXGDDkPAaeAo+nGIg8sK4a
X-Gm-Gg: ASbGncvzji2ApyB6jh+opMhj3rgphLu48VspOpTOuxXSxTyWRSTzXwWpu517oIQx9Vi
 QW9IcLVFVofPDUTTiyT+cwB72jsiA9w41qvs5NfuBddsNNAqhDr8bOpbcIXBpws8w80h3nhB/D1
 j7VIfcWG+Fe7rYEl6tr3V5lyOq8XAZ7nG4yWeAMZH5MgvzNeKhV1SMyCqY7PCpp5Wh8lce+VB7U
 awi6LsEpuhYjvaE38vVa06XEAeFcSH36bYSKjkFr7WpJFBTS/+LDJuOuecEYae0Tyn1EAWVXwOR
 GW/PBaGKGsgp6MMAvGOMdhOB
X-Received: by 2002:a05:6000:1787:b0:3a4:e502:81b8 with SMTP id
 ffacd0b85a97d-3a531caf95fmr10762751f8f.43.1749483877144; 
 Mon, 09 Jun 2025 08:44:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx4j3Fs+EP83RDPqP4md1YaQYyLAVX6E/8VNJ1+RrXZKeUL4o4iIgIHtEBt1GCKhM28JeGPg==
X-Received: by 2002:a05:6000:1787:b0:3a4:e502:81b8 with SMTP id
 ffacd0b85a97d-3a531caf95fmr10762732f8f.43.1749483876586; 
 Mon, 09 Jun 2025 08:44:36 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244fd02sm9723515f8f.75.2025.06.09.08.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:44:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/5] rust: qom: change instance_init to take a ParentInit<>
Date: Mon,  9 Jun 2025 17:44:23 +0200
Message-ID: <20250609154423.706056-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609154423.706056-1-pbonzini@redhat.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This removes undefined behavior associated to writing to uninitialized
fields, and makes it possible to remove "unsafe" from the instance_init
implementation.

However, the init function itself is still unsafe, because it must promise
(as a sort as MaybeUninit::assume_init) that all fields have been
initialized.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 34 ++++++++++-----------
 rust/hw/timer/hpet/src/device.rs | 16 ++++------
 rust/qemu-api/src/memory.rs      | 12 ++++----
 rust/qemu-api/src/qdev.rs        | 51 ++++++++++++++++++++------------
 rust/qemu-api/src/qom.rs         |  9 ++++--
 5 files changed, 65 insertions(+), 57 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index be8387f6f2d..2d416cd9a3c 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, ptr::addr_of_mut};
+use std::{ffi::CStr, mem::size_of};
 
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
@@ -11,9 +11,10 @@
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, Owned, ParentField},
+    qom::{ObjectImpl, Owned, ParentField, ParentInit},
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
+    uninit_field_mut,
     vmstate::VMStateDescription,
 };
 
@@ -163,7 +164,7 @@ impl PL011Impl for PL011State {
 impl ObjectImpl for PL011State {
     type ParentType = SysBusDevice;
 
-    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
+    const INSTANCE_INIT: Option<unsafe fn(ParentInit<Self>)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
     const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
 }
@@ -488,7 +489,7 @@ impl PL011State {
     /// `PL011State` type. It must not be called more than once on the same
     /// location/instance. All its fields are expected to hold uninitialized
     /// values with the sole exception of `parent_obj`.
-    unsafe fn init(&mut self) {
+    unsafe fn init(mut this: ParentInit<Self>) {
         static PL011_OPS: MemoryRegionOps<PL011State> = MemoryRegionOpsBuilder::<PL011State>::new()
             .read(&PL011State::read)
             .write(&PL011State::write)
@@ -496,28 +497,23 @@ unsafe fn init(&mut self) {
             .impl_sizes(4, 4)
             .build();
 
-        // SAFETY:
-        //
-        // self and self.iomem are guaranteed to be valid at this point since callers
-        // must make sure the `self` reference is valid.
+        // SAFETY: this and this.iomem are guaranteed to be valid at this point
         MemoryRegion::init_io(
-            unsafe { &mut *addr_of_mut!(self.iomem) },
-            addr_of_mut!(*self),
+            &mut uninit_field_mut!(*this, iomem),
             &PL011_OPS,
             "pl011",
             0x1000,
         );
 
-        self.regs = Default::default();
+        uninit_field_mut!(*this, regs).write(Default::default());
 
-        // SAFETY:
-        //
-        // self.clock is not initialized at this point; but since `Owned<_>` is
-        // not Drop, we can overwrite the undefined value without side effects;
-        // it's not sound but, because for all PL011State instances are created
-        // by QOM code which calls this function to initialize the fields, at
-        // leastno code is able to access an invalid self.clock value.
-        self.clock = self.init_clock_in("clk", &Self::clock_update, ClockEvent::ClockUpdate);
+        let clock = DeviceState::init_clock_in(
+            &mut this,
+            "clk",
+            &Self::clock_update,
+            ClockEvent::ClockUpdate,
+        );
+        uninit_field_mut!(*this, clock).write(clock);
     }
 
     const fn clock_update(&self, _event: ClockEvent) {
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 340ca1d355d..a281927781e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -21,8 +21,8 @@
         hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
     },
     prelude::*,
-    qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, ObjectType, ParentField},
+    qdev::{DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qom::{ObjectImpl, ObjectType, ParentField, ParentInit},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
@@ -697,7 +697,7 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
             .set(self.counter.get().deposit(shift, len, val));
     }
 
-    unsafe fn init(&mut self) {
+    unsafe fn init(mut this: ParentInit<Self>) {
         static HPET_RAM_OPS: MemoryRegionOps<HPETState> =
             MemoryRegionOpsBuilder::<HPETState>::new()
                 .read(&HPETState::read)
@@ -707,18 +707,14 @@ unsafe fn init(&mut self) {
                 .impl_sizes(4, 8)
                 .build();
 
-        // SAFETY:
-        // self and self.iomem are guaranteed to be valid at this point since callers
-        // must make sure the `self` reference is valid.
         MemoryRegion::init_io(
-            unsafe { &mut *addr_of_mut!(self.iomem) },
-            addr_of_mut!(*self),
+            &mut uninit_field_mut!(*this, iomem),
             &HPET_RAM_OPS,
             "hpet",
             HPET_REG_SPACE_LEN,
         );
 
-        Self::init_timers(unsafe { &mut *((self as *mut Self).cast::<MaybeUninit<Self>>()) });
+        Self::init_timers(&mut this);
     }
 
     fn post_init(&self) {
@@ -900,7 +896,7 @@ unsafe impl ObjectType for HPETState {
 impl ObjectImpl for HPETState {
     type ParentType = SysBusDevice;
 
-    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
+    const INSTANCE_INIT: Option<unsafe fn(ParentInit<Self>)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
     const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
 }
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 9ef2694bd62..e40fad6cf19 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -16,6 +16,7 @@
     callbacks::FnCall,
     cell::Opaque,
     prelude::*,
+    uninit::MaybeUninitField,
     zeroable::Zeroable,
 };
 
@@ -147,7 +148,7 @@ impl MemoryRegion {
     #[inline(always)]
     unsafe fn do_init_io(
         slot: *mut bindings::MemoryRegion,
-        owner: *mut Object,
+        owner: *mut bindings::Object,
         ops: &'static bindings::MemoryRegionOps,
         name: &'static str,
         size: u64,
@@ -156,7 +157,7 @@ unsafe fn do_init_io(
             let cstr = CString::new(name).unwrap();
             memory_region_init_io(
                 slot,
-                owner.cast::<bindings::Object>(),
+                owner,
                 ops,
                 owner.cast::<c_void>(),
                 cstr.as_ptr(),
@@ -166,16 +167,15 @@ unsafe fn do_init_io(
     }
 
     pub fn init_io<T: IsA<Object>>(
-        &mut self,
-        owner: *mut T,
+        this: &mut MaybeUninitField<'_, T, Self>,
         ops: &'static MemoryRegionOps<T>,
         name: &'static str,
         size: u64,
     ) {
         unsafe {
             Self::do_init_io(
-                self.0.as_mut_ptr(),
-                owner.cast::<Object>(),
+                this.as_mut_ptr().cast(),
+                MaybeUninitField::parent_mut(this).cast(),
                 &ops.0,
                 name,
                 size,
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 0610959f467..a2a95a4938f 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -19,7 +19,7 @@
     error::{Error, Result},
     irq::InterruptSource,
     prelude::*,
-    qom::{ObjectClass, ObjectImpl, Owned},
+    qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
     vmstate::VMStateDescription,
 };
 
@@ -247,15 +247,9 @@ unsafe impl ObjectType for DeviceState {
 }
 qom_isa!(DeviceState: Object);
 
-/// Trait for methods exposed by the [`DeviceState`] class.  The methods can be
-/// called on all objects that have the trait `IsA<DeviceState>`.
-///
-/// The trait should only be used through the blanket implementation,
-/// which guarantees safety via `IsA`.
-pub trait DeviceMethods: ObjectDeref
-where
-    Self::Target: IsA<DeviceState>,
-{
+/// Initialization methods take a [`ParentInit`] and can be called as
+/// associated functions.
+impl DeviceState {
     /// Add an input clock named `name`.  Invoke the callback with
     /// `self` as the first parameter for the events that are requested.
     ///
@@ -266,12 +260,15 @@ pub trait DeviceMethods: ObjectDeref
     /// which Rust code has a reference to a child object) it would be
     /// possible for this function to return a `&Clock` too.
     #[inline]
-    fn init_clock_in<F: for<'a> FnCall<(&'a Self::Target, ClockEvent)>>(
-        &self,
+    pub fn init_clock_in<T: DeviceImpl, F: for<'a> FnCall<(&'a T, ClockEvent)>>(
+        this: &mut ParentInit<T>,
         name: &str,
         _cb: &F,
         events: ClockEvent,
-    ) -> Owned<Clock> {
+    ) -> Owned<Clock>
+    where
+        T::ParentType: IsA<DeviceState>,
+    {
         fn do_init_clock_in(
             dev: &DeviceState,
             name: &str,
@@ -287,10 +284,10 @@ fn do_init_clock_in(
             unsafe {
                 let cstr = CString::new(name).unwrap();
                 let clk = bindings::qdev_init_clock_in(
-                    dev.as_mut_ptr(),
+                    dev.0.as_mut_ptr(),
                     cstr.as_ptr(),
                     cb,
-                    dev.as_void_ptr(),
+                    dev.0.as_void_ptr(),
                     events.0,
                 );
 
@@ -307,12 +304,12 @@ fn do_init_clock_in(
                 // SAFETY: the opaque is "this", which is indeed a pointer to T
                 F::call((unsafe { &*(opaque.cast::<T>()) }, event))
             }
-            Some(rust_clock_cb::<Self::Target, F>)
+            Some(rust_clock_cb::<T, F>)
         } else {
             None
         };
 
-        do_init_clock_in(self.upcast(), name, cb, events)
+        do_init_clock_in(unsafe { this.upcast_mut() }, name, cb, events)
     }
 
     /// Add an output clock named `name`.
@@ -324,16 +321,32 @@ fn do_init_clock_in(
     /// which Rust code has a reference to a child object) it would be
     /// possible for this function to return a `&Clock` too.
     #[inline]
-    fn init_clock_out(&self, name: &str) -> Owned<Clock> {
+    pub fn init_clock_out<T: DeviceImpl>(this: &mut ParentInit<T>, name: &str) -> Owned<Clock>
+    where
+        T::ParentType: IsA<DeviceState>,
+    {
         unsafe {
             let cstr = CString::new(name).unwrap();
-            let clk = bindings::qdev_init_clock_out(self.upcast().as_mut_ptr(), cstr.as_ptr());
+            // TODO: introduce a type guaranteeing that the DeviceState part has been
+            // initialized
+            let dev: &mut DeviceState = this.upcast_mut();
+            let clk = bindings::qdev_init_clock_out(dev.0.as_mut_ptr(), cstr.as_ptr());
 
             let clk: &Clock = Clock::from_raw(clk);
             Owned::from(clk)
         }
     }
+}
 
+/// Trait for methods exposed by the [`DeviceState`] class.  The methods can be
+/// called on all objects that have the trait `IsA<DeviceState>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`.
+pub trait DeviceMethods: ObjectDeref
+where
+    Self::Target: IsA<DeviceState>,
+{
     fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
         assert!(bql_locked());
         let c_propname = CString::new(propname).unwrap();
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 1481ef20f0c..80a50108e65 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -371,12 +371,15 @@ fn deref_mut(&mut self) -> &mut Self::Target {
 }
 
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut bindings::Object) {
-    let mut state = NonNull::new(obj).unwrap().cast::<T>();
+    let mut state = NonNull::new(obj).unwrap().cast::<MaybeUninit<T>>();
+
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
     // is called from QOM core as the instance_init function
     // for class T
     unsafe {
-        T::INSTANCE_INIT.unwrap()(state.as_mut());
+        ParentInit::with(state.as_mut(), |parent_init| {
+            T::INSTANCE_INIT.unwrap()(parent_init);
+        });
     }
 }
 
@@ -643,7 +646,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     ///
     /// FIXME: The argument is not really a valid reference. `&mut
     /// MaybeUninit<Self>` would be a better description.
-    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = None;
+    const INSTANCE_INIT: Option<unsafe fn(ParentInit<Self>)> = None;
 
     /// Function that is called to finish initialization of an object, once
     /// `INSTANCE_INIT` functions have been called.
-- 
2.49.0


