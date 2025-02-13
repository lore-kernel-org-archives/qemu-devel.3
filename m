Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E6CC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibeu-0000x5-0H; Thu, 13 Feb 2025 11:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeW-0000r2-T7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeS-0005Sg-2k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpScOGuqkkpqCWAGOqG2RKOLu/MENt6Jr9VwylD8zsA=;
 b=YQVim5+vwK7FurL4lX8TXoDQKzQPJ+YPvDIXkwK4ZNyR6Sj+OHD+mp02AKd/2yL9ZIrcVg
 MQNiawc5maa5XZO6G66NxYeWsGWSwjRnkT88fAnJ05AaAcLB0frVm+SCCFWhb/Oxei9PF1
 kDv+lDSUubDrKLA1Wcpppag1GoT+6Mw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Fx7r2193O8yqK6WS-m0rZQ-1; Thu, 13 Feb 2025 11:01:17 -0500
X-MC-Unique: Fx7r2193O8yqK6WS-m0rZQ-1
X-Mimecast-MFC-AGG-ID: Fx7r2193O8yqK6WS-m0rZQ_1739462475
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dd533dad0so1177929f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462474; x=1740067274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fpScOGuqkkpqCWAGOqG2RKOLu/MENt6Jr9VwylD8zsA=;
 b=eEcefMFlV3x0O7ltfekewHCIr5H3GwN42aK+OstelaInwomejnrpoolQy+FUP79X8Q
 f+THu8/wI1VFXByy/I7Tl9YoJVm+STAbecIga1pW/iv8Q3TDm5JofDJhuHDZ4s9azYt8
 /s47mgqNJMBdBfvUKz1/SnCb+g64WDkv+W9NY/jUIZeBDCvINsP/gIANEx20jAZZ7JIK
 wKQHMgJv9YvkWHqOztfXungrAi5qAAoF6HgtR1DgiM3NfK/oqP9aUUsq9v7QS80KHgNx
 qSCbwXCnIQeCM8yJdJypTMtOvW/nj3leEwUPkmQz7hvgLZkg5jXzILRQUp8joExBbjKP
 ZMVw==
X-Gm-Message-State: AOJu0YxH2vdlo4C2J2qa5fftPczSupSzERXAvkK1vvQcY/nZbBqGyyPt
 FQqJ1oHxCZbjL3DDy0XcuY0dSKQK/FwrevOIa1GLDkuPeghsrXdLiB2M6KBdcBxlDpuvXrpwjUx
 jGDJRGgtQPDaCXzJ4GE5/j8GLwSz7UkbyPcrWJ3bMkZndc1X+t5cWLdFkmesPsZ1jmtEaSYfyot
 eHeEDJu5eL4mpz7mo6RDk8qNwI7RAIAVaWmQcsiQg=
X-Gm-Gg: ASbGnctcxgtyper5aSXlQhYUOk86ggOzumu4bmNp6wLTN4ByMEDzBWdLDWZoLnpVPj9
 R8FsrjCaEFMfLNAjDHl2LD4ZbgSvTp8xU/HnBO3q7OmCzeaFr+tjQC03cV1gFdi1RPyDVzS+iQT
 5NmI5AahPrg8gARORRcsW3k0cDpEdVw4HO6bxgdIOwsi0DoqopneB17PrVCt33c/c73C4Y47qGf
 nu5l5tpIcq84Ne/qLfnCJGTjVzS6G8y7FjK423pH4Z6O5gn3C1f7BP9mZelhroh0dooeW9yPGnH
 OBNXHXwqcChnbD8058ZmevjDONpHwM/kyJ7os0BoQBxtwA==
X-Received: by 2002:a05:6000:18a7:b0:38d:dfb8:368d with SMTP id
 ffacd0b85a97d-38dea2f76ddmr7278923f8f.50.1739462469856; 
 Thu, 13 Feb 2025 08:01:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE46/BxU0Ec0C8ZUXM85fjiiS60CRxllE+fBxQR+rHcorVSs5iz/bMommZ1x7vXRCkm1tzo7A==
X-Received: by 2002:a05:6000:18a7:b0:38d:dfb8:368d with SMTP id
 ffacd0b85a97d-38dea2f76ddmr7278847f8f.50.1739462469042; 
 Thu, 13 Feb 2025 08:01:09 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4123sm2319261f8f.17.2025.02.13.08.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/27] rust: qdev: add clock creation
Date: Thu, 13 Feb 2025 17:00:32 +0100
Message-ID: <20250213160054.3937012-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a Rust version of qdev_init_clock_in, which can be used in
instance_init.  There are a couple differences with the C
version:

- in Rust the object keeps its own reference to the clock (in addition to
  the one embedded in the NamedClockList), and the reference is dropped
  automatically by instance_finalize(); this is encoded in the signature
  of DeviceClassMethods::init_clock_in, which makes the lifetime of the
  clock independent of that of the object it holds.  This goes unnoticed
  in the C version and is due to the existence of aliases.

- also, anything that happens during instance_init uses the pinned_init
  framework to operate on a partially initialized object, and is done
  through class methods (i.e. through DeviceClassMethods rather than
  DeviceMethods) because the device does not exist yet.  Therefore, Rust
  code *must* create clocks from instance_init, which is stricter than C.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  43 +++++--------
 rust/qemu-api/src/prelude.rs     |   2 +
 rust/qemu-api/src/qdev.rs        | 107 ++++++++++++++++++++++++++++++-
 rust/qemu-api/src/vmstate.rs     |   4 +-
 4 files changed, 125 insertions(+), 31 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f5db114b0c7..37936a328b8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,17 +10,16 @@
 
 use qemu_api::{
     bindings::{
-        error_fatal, hwaddr, memory_region_init_io, qdev_init_clock_in, qdev_prop_set_chr,
-        qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
-        qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq, sysbus_mmio_map, sysbus_realize,
-        CharBackend, Chardev, Clock, ClockEvent, MemoryRegion, QEMUChrEvent,
-        CHR_IOCTL_SERIAL_SET_BREAK,
+        error_fatal, hwaddr, memory_region_init_io, qdev_prop_set_chr, qemu_chr_fe_accept_input,
+        qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers, qemu_chr_fe_write_all, qemu_irq,
+        sysbus_connect_irq, sysbus_mmio_map, sysbus_realize, CharBackend, Chardev, MemoryRegion,
+        QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
     },
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
     prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property},
-    qom::{ClassInitImpl, ObjectImpl, ParentField},
+    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property},
+    qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
     sysbus::{SysBusDevice, SysBusDeviceClass},
     vmstate::VMStateDescription,
 };
@@ -131,7 +130,7 @@ pub struct PL011State {
     #[doc(alias = "irq")]
     pub interrupts: [InterruptSource; IRQMASK.len()],
     #[doc(alias = "clk")]
-    pub clock: NonNull<Clock>,
+    pub clock: Owned<Clock>,
     #[doc(alias = "migrate_clk")]
     pub migrate_clock: bool,
 }
@@ -485,8 +484,6 @@ impl PL011State {
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
-        const CLK_NAME: &CStr = c_str!("clk");
-
         // SAFETY:
         //
         // self and self.iomem are guaranteed to be valid at this point since callers
@@ -506,22 +503,16 @@ unsafe fn init(&mut self) {
 
         // SAFETY:
         //
-        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
-        // we can overwrite the undefined value without side effects. This is
-        // safe since all PL011State instances are created by QOM code which
-        // calls this function to initialize the fields; therefore no code is
-        // able to access an invalid self.clock value.
-        unsafe {
-            let dev: &mut DeviceState = self.upcast_mut();
-            self.clock = NonNull::new(qdev_init_clock_in(
-                dev,
-                CLK_NAME.as_ptr(),
-                None, /* pl011_clock_update */
-                addr_of_mut!(*self).cast::<c_void>(),
-                ClockEvent::ClockUpdate.0,
-            ))
-            .unwrap();
-        }
+        // self.clock is not initialized at this point; but since `Owned<_>` is
+        // not Drop, we can overwrite the undefined value without side effects;
+        // it's not sound but, because for all PL011State instances are created
+        // by QOM code which calls this function to initialize the fields, at
+        // leastno code is able to access an invalid self.clock value.
+        self.clock = self.init_clock_in("clk", &Self::clock_update, ClockEvent::ClockUpdate);
+    }
+
+    const fn clock_update(&self, _event: ClockEvent) {
+        /* pl011_trace_baudrate_change(s); */
     }
 
     fn post_init(&self) {
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 3df6a5c21ec..87e3ce90f26 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -7,6 +7,8 @@
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
+pub use crate::qdev::DeviceMethods;
+
 pub use crate::qom::IsA;
 pub use crate::qom::Object;
 pub use crate::qom::ObjectCast;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index f4c75c752f1..176c69a5600 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -4,14 +4,20 @@
 
 //! Bindings to create devices and access device functionality from Rust.
 
-use std::{ffi::CStr, ptr::NonNull};
+use std::{
+    ffi::{CStr, CString},
+    os::raw::c_void,
+    ptr::NonNull,
+};
 
-pub use bindings::{DeviceClass, DeviceState, Property};
+pub use bindings::{Clock, ClockEvent, DeviceClass, DeviceState, Property};
 
 use crate::{
     bindings::{self, Error},
+    callbacks::FnCall,
+    cell::bql_locked,
     prelude::*,
-    qom::{ClassInitImpl, ObjectClass},
+    qom::{ClassInitImpl, ObjectClass, Owned},
     vmstate::VMStateDescription,
 };
 
@@ -143,3 +149,98 @@ unsafe impl ObjectType for DeviceState {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
 qom_isa!(DeviceState: Object);
+
+/// Trait for methods exposed by the [`DeviceState`] class.  The methods can be
+/// called on all objects that have the trait `IsA<DeviceState>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`.
+pub trait DeviceMethods: ObjectDeref
+where
+    Self::Target: IsA<DeviceState>,
+{
+    /// Add an input clock named `name`.  Invoke the callback with
+    /// `self` as the first parameter for the events that are requested.
+    ///
+    /// The resulting clock is added as a child of `self`, but it also
+    /// stays alive until after `Drop::drop` is called because C code
+    /// keeps an extra reference to it until `device_finalize()` calls
+    /// `qdev_finalize_clocklist()`.  Therefore (unlike most cases in
+    /// which Rust code has a reference to a child object) it would be
+    /// possible for this function to return a `&Clock` too.
+    #[inline]
+    fn init_clock_in<F: for<'a> FnCall<(&'a Self::Target, ClockEvent)>>(
+        &self,
+        name: &str,
+        _cb: &F,
+        events: ClockEvent,
+    ) -> Owned<Clock> {
+        fn do_init_clock_in(
+            dev: *mut DeviceState,
+            name: &str,
+            cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)>,
+            events: ClockEvent,
+        ) -> Owned<Clock> {
+            assert!(bql_locked());
+
+            // SAFETY: the clock is heap allocated, but qdev_init_clock_in()
+            // does not gift the reference to its caller; so use Owned::from to
+            // add one.  The callback is disabled automatically when the clock
+            // is unparented, which happens before the device is finalized.
+            unsafe {
+                let cstr = CString::new(name).unwrap();
+                let clk = bindings::qdev_init_clock_in(
+                    dev,
+                    cstr.as_ptr(),
+                    cb,
+                    dev.cast::<c_void>(),
+                    events.0,
+                );
+
+                Owned::from(&*clk)
+            }
+        }
+
+        let cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)> = if F::is_some() {
+            unsafe extern "C" fn rust_clock_cb<T, F: for<'a> FnCall<(&'a T, ClockEvent)>>(
+                opaque: *mut c_void,
+                event: ClockEvent,
+            ) {
+                // SAFETY: the opaque is "this", which is indeed a pointer to T
+                F::call((unsafe { &*(opaque.cast::<T>()) }, event))
+            }
+            Some(rust_clock_cb::<Self::Target, F>)
+        } else {
+            None
+        };
+
+        do_init_clock_in(self.as_mut_ptr(), name, cb, events)
+    }
+
+    /// Add an output clock named `name`.
+    ///
+    /// The resulting clock is added as a child of `self`, but it also
+    /// stays alive until after `Drop::drop` is called because C code
+    /// keeps an extra reference to it until `device_finalize()` calls
+    /// `qdev_finalize_clocklist()`.  Therefore (unlike most cases in
+    /// which Rust code has a reference to a child object) it would be
+    /// possible for this function to return a `&Clock` too.
+    #[inline]
+    fn init_clock_out(&self, name: &str) -> Owned<Clock> {
+        unsafe {
+            let cstr = CString::new(name).unwrap();
+            let clk = bindings::qdev_init_clock_out(self.as_mut_ptr(), cstr.as_ptr());
+
+            Owned::from(&*clk)
+        }
+    }
+}
+
+impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
+
+unsafe impl ObjectType for Clock {
+    type Class = ObjectClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CLOCK) };
+}
+qom_isa!(Clock: Object);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 11d21b8791c..164effc6553 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -470,11 +470,11 @@ macro_rules! vmstate_clock {
                 $crate::assert_field_type!(
                     $struct_name,
                     $field_name,
-                    core::ptr::NonNull<$crate::bindings::Clock>
+                    $crate::qom::Owned<$crate::bindings::Clock>
                 );
                 $crate::offset_of!($struct_name, $field_name)
             },
-            size: ::core::mem::size_of::<*const $crate::bindings::Clock>(),
+            size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
             flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
             vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
             ..$crate::zeroable::Zeroable::ZERO
-- 
2.48.1


