Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB830C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCr-0001cV-Da; Fri, 17 Jan 2025 14:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCp-0001aX-0m
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCe-0002Cz-13
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oahqCqM04zU6SgnyH8PstMyxlymjpkN8kciJN6RaKAY=;
 b=QEBnwTi954YohlcETYViuBL4nZd/bl4WUvcltX7t8wwpFIvkqq+hxGMyTcsGHIv4hejJ6B
 mkzeNSWHuooQuIvKvgsInFAx0D/Zmrf430+wFFPBNb3lJ2C7nY+gUAev7XzzC0LLdmI2AI
 7yesSfAWI74ifjawCCi2JXdM8aE2g6k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-mOd_VZWhOLqLd46FcKIjwA-1; Fri, 17 Jan 2025 14:40:20 -0500
X-MC-Unique: mOd_VZWhOLqLd46FcKIjwA-1
X-Mimecast-MFC-AGG-ID: mOd_VZWhOLqLd46FcKIjwA
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa68952272bso289572666b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142817; x=1737747617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oahqCqM04zU6SgnyH8PstMyxlymjpkN8kciJN6RaKAY=;
 b=IAr0PnI40GT9rrX16IxpPFml4MM10TEC3GlSylK4vHlJFJoxncvupQlAr1PwUHs5MX
 BJS3Yj/SpIeiZbSKVovAAkjKnoM93s+pBWI+vyCumuJRrApR9Kml4XtcLqjaf4SCOoej
 ExCd3blUYWkUGZ5FQ/WcgUMBveEiiMe79nWAAfPLswltYDg1OVJrsvYXSZsuNeMhJsFs
 mtck4cgylmpgsN+EF9HyiaZAL7BJw0a6vOLeiokfjmgcc4oBzbT2RJnpo7aljewsNYBe
 ZfV5H7yOSQ6unnjuFdrafnEx0cWNPsVqE1bCRq8wPFR3TrxTzDQvytNAYtGjvjQ/yBof
 OTPg==
X-Gm-Message-State: AOJu0YzB7e/X2g3LBEhQHtKanIOtiji2eRqQe4ECwbdF+AreisUIfEeu
 Yd+kxBGzv7gfQ5FxeUXaw2iPWdxVnr2LCFCpDHBVy9CfVzBS7JoBAkg74BOBEcoC8xfVIzAZY4M
 MubBfmyb4OoajhsloxnNUZzjnsN5CrktgL8Ub0ROaFMWqS1MNZsAOIv7GZQvlen/HYbAuEBYoEm
 /aZMClgvPyKq7Eo+NvIP5gV8AeaQ9cWs7pP8IArtk=
X-Gm-Gg: ASbGncsg8BmzzVNpi7hxWoeAsrp35FQezTgC62VsntnFwoprl/gVMZ7MEqX7UOZNFE5
 WTdNsKN815XTP1DzQfSwyBXw2Ckuav0WvjEjuhHorFK577gP3UCApoYX4ZNlAfwyTI77NIcXZ6U
 VlDJ5XqgRboEpj3aMDijv/eOrDCbGOekUmtAzL6ArWXlf3DnaMGizNUS06g00HqmNWe37nnJU2V
 KeHsyb0023fwFh/b0ua9s0Avt0R0zOkbAHVjoSQbPq/mm40US6XNINhD089VQ==
X-Received: by 2002:a17:907:971a:b0:aa6:66eb:9c06 with SMTP id
 a640c23a62f3a-ab38b1e207bmr357684566b.5.1737142817126; 
 Fri, 17 Jan 2025 11:40:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFosYdYhimjMiswhnSJuuOa2F6TozlgWSH1f1nUqSoanZQZX5mubtd8TH4IUPY4KsN3mmKDPg==
X-Received: by 2002:a17:907:971a:b0:aa6:66eb:9c06 with SMTP id
 a640c23a62f3a-ab38b1e207bmr357682166b.5.1737142816563; 
 Fri, 17 Jan 2025 11:40:16 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce1bacsm220451766b.53.2025.01.17.11.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 05/10] rust: qdev: add clock creation
Date: Fri, 17 Jan 2025 20:39:58 +0100
Message-ID: <20250117194003.1173231-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 28 +++++-------
 rust/qemu-api/src/prelude.rs     |  2 +
 rust/qemu-api/src/qdev.rs        | 76 ++++++++++++++++++++++++++++++--
 rust/qemu-api/src/vmstate.rs     |  4 +-
 4 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index d8409f3d310..dfe199ad0ed 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,8 +13,8 @@
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
     prelude::*,
-    qdev::DeviceImpl,
-    qom::{ClassInitImpl, ObjectImpl, ParentField},
+    qdev::{Clock, ClockEvent, DeviceImpl},
+    qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
 };
 
 use crate::{
@@ -123,7 +123,7 @@ pub struct PL011State {
     #[doc(alias = "irq")]
     pub interrupts: [InterruptSource; IRQMASK.len()],
     #[doc(alias = "clk")]
-    pub clock: NonNull<Clock>,
+    pub clock: Owned<Clock>,
     #[doc(alias = "migrate_clk")]
     pub migrate_clock: bool,
 }
@@ -487,8 +487,6 @@ impl PL011State {
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
-        const CLK_NAME: &CStr = c_str!("clk");
-
         // SAFETY:
         //
         // self and self.iomem are guaranteed to be valid at this point since callers
@@ -508,22 +506,16 @@ unsafe fn init(&mut self) {
 
         // SAFETY:
         //
-        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
-        // we can overwrite the undefined value without side effects. This is
+        // self.clock is not initialized at this point; but since `NonNull<_>` is
+        // not Drop, we can overwrite the undefined value without side effects. This is
         // safe since all PL011State instances are created by QOM code which
         // calls this function to initialize the fields; therefore no code is
         // able to access an invalid self.clock value.
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
index 4658409bebb..f573712550e 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -4,14 +4,19 @@
 
 //! Bindings to create devices and access device functionality from Rust.
 
-use std::ffi::CStr;
+use std::{
+    ffi::{CStr, CString},
+    os::raw::c_void,
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
 
@@ -145,3 +150,68 @@ unsafe impl ObjectType for DeviceState {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
 qom_isa!(DeviceState: Object);
+
+pub trait DeviceMethods: ObjectDeref
+where
+    Self::Target: IsA<DeviceState>,
+{
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
+            // SAFETY: the clock is heap allocated and does not have a reference, so
+            // Owned::from adds one.  the callback is disabled automatically
+            // when the clock is unparented, which happens before the device is
+            // finalized.
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
+        // SAFETY: self can be cast to DeviceState because its type has an
+        // IsA<DeviceState> bound.
+        do_init_clock_in(unsafe { self.as_mut_ptr() }, name, cb, events)
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
2.47.1


