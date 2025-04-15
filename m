Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A646CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eez-0006Mn-Eh; Tue, 15 Apr 2025 07:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4eek-0006KJ-Ac; Tue, 15 Apr 2025 07:40:49 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4eee-0001Ec-E5; Tue, 15 Apr 2025 07:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744717241; x=1776253241;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AWdj9DAw7TzJ84cjaNPRllAeYkqOjTIsOY72njK01/4=;
 b=cN6I6wogexdb0zpcQDexVG5pBKQAeBwyMQMDs/t7SNYlbR11SEdeJ3wt
 5AtIseAmMRejO/tre76s/DOHTEskfwDELTSmRuqP1Otvz89Pte9TZ07bZ
 X+UOqsldkvhK1/EfGtJkopovGKVdAfsHMh+3tgNK0dfS8Upq1DUI/JvQN
 zyfjdFdSCx3TSisIMX4BSdGeIg7qkl93QeVJCNql+gGF2xeLHUpxyxmLY
 RsU4XVNnLSBRSkF+D9iKC1364ouwd++2AtgoujV0Je3OY5GkLAkFHPbVi
 cw8sJOyGxPuhA+FtikEAg/Z0AatOghu95nNKZ9/oufQiqCknLwQ4NfQDf w==;
X-CSE-ConnectionGUID: TRhqkxZUSFy7iQaIowmUrg==
X-CSE-MsgGUID: 0MjLFuYySH2zsma3+AYPFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="49872084"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="49872084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 04:40:36 -0700
X-CSE-ConnectionGUID: +YQMN2hPTr2FvSOoWoLECw==
X-CSE-MsgGUID: ZYG1a2c7SWqsHzSZrk/DVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="130057167"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 15 Apr 2025 04:40:34 -0700
Date: Tue, 15 Apr 2025 20:01:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 8/9] rust/hpet: Support migration
Message-ID: <Z/5KlfQgC65g6Kid@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-9-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414144943.1112885-9-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Paolo,

Based on the this patch, I simply copied your MemoryRegionOpsBuilder
and quickly tried out the vmstate builder over a few cups of tea.

Although it can handle callbacks well, I found that the difficulty still
lies in the fact that the vmstate_fields and vmstate_subsections macros
cannot be eliminated, because any dynamic creation of arrays is not
allowed in a static context! (As I understand it, lazy_static might
still be needed.)

An additional difficult case is vmsd(). Passing the raw VMStateDescription
looks not good, while passing the VMStateDescription<> wrapper requires
bounding DeviceImpl with 'static. Ultimately, I added an extra
StaticVMStateDescription trait to successfully compile... In any case,
it's definitely still rough, but hope it helps and takes a small step
forward.

(Thanks for the patch 2 comment, I'll reply later!)

Thanks,
Zhao

---
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index a3538af14b48..16d495508424 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -4,7 +4,6 @@

 use std::{
     ffi::CStr,
-    os::raw::{c_int, c_void},
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
@@ -27,9 +26,8 @@
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
-    vmstate::VMStateDescription,
+    vmstate::{StaticVMStateDescription, VMStateDescription, VMStateDescriptionBuilder},
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
-    zeroable::Zeroable,
 };

 use crate::fw_cfg::HPETFwConfig;
@@ -943,104 +941,73 @@ impl ObjectImpl for HPETState {
     ),
 }

-unsafe extern "C" fn hpet_rtc_irq_level_needed(opaque: *mut c_void) -> bool {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
-    state.is_rtc_irq_level_needed()
-}
-
-unsafe extern "C" fn hpet_offset_needed(opaque: *mut c_void) -> bool {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
-    state.is_offset_needed()
-}
-unsafe extern "C" fn hpet_pre_save(opaque: *mut c_void) -> c_int {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &mut HPETState =
-        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
-    state.pre_save() as c_int
-}
-
-unsafe extern "C" fn hpet_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
-    // SAFETY:
-    // the pointer is convertible to a reference
-    let state: &mut HPETState =
-        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
-    let version: u8 = version_id.try_into().unwrap();
-    state.post_load(version) as c_int
-}
-
-static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet/rtc_irq_level").as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    needed: Some(hpet_rtc_irq_level_needed),
-    fields: vmstate_fields! {
-        vmstate_of!(HPETState, rtc_irq_level),
-    },
-    ..Zeroable::ZERO
-};
-
-static VMSTATE_HPET_OFFSET: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet/offset").as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    needed: Some(hpet_offset_needed),
-    fields: vmstate_fields! {
-        vmstate_of!(HPETState, hpet_offset),
-    },
-    ..Zeroable::ZERO
-};
-
-static VMSTATE_HPET_TIMER: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet_timer").as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    fields: vmstate_fields! {
-        vmstate_of!(HPETTimer, index),
-        vmstate_of!(HPETTimer, config),
-        vmstate_of!(HPETTimer, cmp),
-        vmstate_of!(HPETTimer, fsb),
-        vmstate_of!(HPETTimer, period),
-        vmstate_of!(HPETTimer, wrap_flag),
-        vmstate_of!(HPETTimer, qemu_timer),
-    },
-    ..Zeroable::ZERO
-};
+static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription<HPETState> =
+    VMStateDescriptionBuilder::<HPETState>::new()
+        .name(c_str!("hpet/rtc_irq_level"))
+        .version_id(1)
+        .minimum_version_id(1)
+        .needed(&HPETState::is_rtc_irq_level_needed)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETState, rtc_irq_level),
+        })
+        .build();
+
+static VMSTATE_HPET_OFFSET: VMStateDescription<HPETState> =
+    VMStateDescriptionBuilder::<HPETState>::new()
+        .name(c_str!("hpet/offset"))
+        .version_id(1)
+        .minimum_version_id(1)
+        .needed(&HPETState::is_offset_needed)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETState, hpet_offset),
+        })
+        .build();
+
+static VMSTATE_HPET_TIMER: VMStateDescription<BqlRefCell<HPETTimer>> =
+    VMStateDescriptionBuilder::<BqlRefCell<HPETTimer>>::new()
+        .name(c_str!("hpet_timer"))
+        .version_id(1)
+        .minimum_version_id(1)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETTimer, index),
+            vmstate_of!(HPETTimer, config),
+            vmstate_of!(HPETTimer, cmp),
+            vmstate_of!(HPETTimer, fsb),
+            vmstate_of!(HPETTimer, period),
+            vmstate_of!(HPETTimer, wrap_flag),
+            vmstate_of!(HPETTimer, qemu_timer),
+        })
+        .build();

 const VALIDATE_TIMERS_NAME: &CStr = c_str!("num_timers must match");

-static VMSTATE_HPET: VMStateDescription = VMStateDescription {
-    name: c_str!("hpet").as_ptr(),
-    version_id: 2,
-    minimum_version_id: 1,
-    pre_save: Some(hpet_pre_save),
-    post_load: Some(hpet_post_load),
-    fields: vmstate_fields! {
-        vmstate_of!(HPETState, config),
-        vmstate_of!(HPETState, int_status),
-        vmstate_of!(HPETState, counter),
-        vmstate_of!(HPETState, num_timers_save).with_version_id(2),
-        vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-        vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
-    },
-    subsections: vmstate_subsections! {
-        VMSTATE_HPET_RTC_IRQ_LEVEL,
-        VMSTATE_HPET_OFFSET,
-    },
-    ..Zeroable::ZERO
-};
+static VMSTATE_HPET: VMStateDescription<HPETState> =
+    VMStateDescriptionBuilder::<HPETState>::new()
+        .name(c_str!("hpet"))
+        .version_id(2)
+        .minimum_version_id(1)
+        .pre_save(&HPETState::pre_save)
+        .post_load(&HPETState::post_load)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETState, config),
+            vmstate_of!(HPETState, int_status),
+            vmstate_of!(HPETState, counter),
+            vmstate_of!(HPETState, num_timers_save).with_version_id(2),
+            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
+            vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+        })
+        .subsections(vmstate_subsections!(
+            VMSTATE_HPET_RTC_IRQ_LEVEL,
+            VMSTATE_HPET_OFFSET,
+        ))
+        .build();

 impl DeviceImpl for HPETState {
     fn properties() -> &'static [Property] {
         &HPET_PROPERTIES
     }

-    fn vmsd() -> Option<&'static VMStateDescription> {
+    fn vmsd() -> Option<&'static dyn StaticVMStateDescription> {
         Some(&VMSTATE_HPET)
     }

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 18b4a9ba687d..3398167d2b4d 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -20,7 +20,7 @@
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned},
-    vmstate::VMStateDescription,
+    vmstate::{StaticVMStateDescription, VMStateDescription},
 };

 /// A safe wrapper around [`bindings::Clock`].
@@ -121,7 +121,7 @@ fn properties() -> &'static [Property] {
     /// A `VMStateDescription` providing the migration format for the device
     /// Not a `const` because referencing statics in constants is unstable
     /// until Rust 1.83.0.
-    fn vmsd() -> Option<&'static VMStateDescription> {
+    fn vmsd() -> Option<&'static dyn StaticVMStateDescription> {
         None
     }
 }
@@ -170,7 +170,7 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
             self.realize = Some(rust_realize_fn::<T>);
         }
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
-            self.vmsd = vmsd;
+            self.vmsd = vmsd.get_vmsd_ptr();
         }
         let prop = <T as DeviceImpl>::properties();
         if !prop.is_empty() {
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 7d9f3a2ca6f2..35d4d12c8ed6 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -25,11 +25,18 @@
 //!   functionality that is missing from `vmstate_of!`.

 use core::{marker::PhantomData, mem, ptr::NonNull};
-use std::os::raw::{c_int, c_void};
+use std::{
+    ffi::CStr,
+    os::raw::{c_int, c_void},
+};

-pub use crate::bindings::{VMStateDescription, VMStateField};
+pub use crate::bindings::{MigrationPriority, VMStateField};
 use crate::{
-    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, zeroable::Zeroable,
+    bindings::{VMStateDescription as RawVMStateDescription, VMStateFlags},
+    callbacks::FnCall,
+    prelude::*,
+    qom::Owned,
+    zeroable::Zeroable,
 };

 /// This macro is used to call a function with a generic argument bound
@@ -489,7 +496,7 @@ macro_rules! vmstate_struct {
             },
             size: ::core::mem::size_of::<$type>(),
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-            vmsd: $vmsd,
+            vmsd: $vmsd.get_vmsd_ptr(),
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
             ..$crate::zeroable::Zeroable::ZERO
          } $(.with_varray_flag_unchecked(
@@ -586,11 +593,188 @@ macro_rules! vmstate_subsections {
     ($($subsection:expr),*$(,)*) => {{
         static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper = $crate::vmstate::VMStateSubsectionsWrapper(&[
             $({
-                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection;
+                static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection.get_vmsd();
                 ::core::ptr::addr_of!(_SUBSECTION)
             }),*,
             ::core::ptr::null()
         ]);
-        _SUBSECTIONS.0.as_ptr()
+        &_SUBSECTIONS
     }}
 }
+
+pub struct VMStateDescription<T>(RawVMStateDescription, PhantomData<fn(&T)>);
+
+// SAFETY: When a *const T is passed to the callbacks, the call itself
+// is done in a thread-safe manner.  The invocation is okay as long as
+// T itself is `Sync`.
+unsafe impl<T: Sync> Sync for VMStateDescription<T> {}
+
+#[derive(Clone)]
+pub struct VMStateDescriptionBuilder<T>(RawVMStateDescription, PhantomData<fn(&T)>);
+
+unsafe extern "C" fn vmstate_pre_load_cb<T, F: for<'a> FnCall<(&'a T,), i32>>(
+    opaque: *mut c_void,
+) -> c_int {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    F::call((unsafe { &*(opaque.cast::<T>()) },)) as c_int
+}
+
+unsafe extern "C" fn vmstate_post_load_cb<T, F: for<'a> FnCall<(&'a T, u8), i32>>(
+    opaque: *mut c_void,
+    version_id: c_int,
+) -> c_int {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+    let version: u8 = version_id.try_into().unwrap();
+    F::call((owner, version)) as c_int
+}
+
+unsafe extern "C" fn vmstate_pre_save_cb<T, F: for<'a> FnCall<(&'a T,), i32>>(
+    opaque: *mut c_void,
+) -> c_int {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    F::call((unsafe { &*(opaque.cast::<T>()) },)) as c_int
+}
+
+unsafe extern "C" fn vmstate_post_save_cb<T, F: for<'a> FnCall<(&'a T,), i32>>(
+    opaque: *mut c_void,
+) -> c_int {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    F::call((unsafe { &*(opaque.cast::<T>()) },)) as c_int
+}
+
+unsafe extern "C" fn vmstate_needed_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
+    opaque: *mut c_void,
+) -> bool {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    F::call((unsafe { &*(opaque.cast::<T>()) },))
+}
+
+unsafe extern "C" fn vmstate_dev_unplug_pending_cb<T, F: for<'a> FnCall<(&'a T,), bool>>(
+    opaque: *mut c_void,
+) -> bool {
+    // SAFETY: the opaque was passed as a reference to `T`.
+    F::call((unsafe { &*(opaque.cast::<T>()) },))
+}
+
+impl<T> VMStateDescriptionBuilder<T> {
+    #[must_use]
+    pub const fn name(mut self, name_str: &CStr) -> Self {
+        self.0.name = ::std::ffi::CStr::as_ptr(name_str);
+        self
+    }
+
+    #[must_use]
+    pub const fn unmigratable(mut self) -> Self {
+        self.0.unmigratable = true;
+        self
+    }
+
+    #[must_use]
+    pub const fn early_setup(mut self) -> Self {
+        self.0.early_setup = true;
+        self
+    }
+
+    #[must_use]
+    pub const fn version_id(mut self, version: u8) -> Self {
+        self.0.version_id = version as c_int;
+        self
+    }
+
+    #[must_use]
+    pub const fn minimum_version_id(mut self, min_version: u8) -> Self {
+        self.0.minimum_version_id = min_version as c_int;
+        self
+    }
+
+    #[must_use]
+    pub const fn priority(mut self, priority: MigrationPriority) -> Self {
+        self.0.priority = priority;
+        self
+    }
+
+    #[must_use]
+    pub const fn pre_load<F: for<'a> FnCall<(&'a T,), i32>>(mut self, _f: &F) -> Self {
+        self.0.pre_load = Some(vmstate_pre_load_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn post_load<F: for<'a> FnCall<(&'a T, u8), i32>>(mut self, _f: &F) -> Self {
+        self.0.post_load = Some(vmstate_post_load_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn pre_save<F: for<'a> FnCall<(&'a T,), i32>>(mut self, _f: &F) -> Self {
+        self.0.pre_save = Some(vmstate_pre_save_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn post_save<F: for<'a> FnCall<(&'a T,), i32>>(mut self, _f: &F) -> Self {
+        self.0.post_save = Some(vmstate_post_save_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn needed<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F) -> Self {
+        self.0.needed = Some(vmstate_needed_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn unplug_pending<F: for<'a> FnCall<(&'a T,), bool>>(mut self, _f: &F) -> Self {
+        self.0.dev_unplug_pending = Some(vmstate_dev_unplug_pending_cb::<T, F>);
+        self
+    }
+
+    #[must_use]
+    pub const fn fields(mut self, fields: *const VMStateField) -> Self {
+        self.0.fields = fields;
+        self
+    }
+
+    #[must_use]
+    pub const fn subsections(mut self, subs: &'static VMStateSubsectionsWrapper) -> Self {
+        self.0.subsections = subs.0.as_ptr();
+        self
+    }
+
+    #[must_use]
+    pub const fn build(self) -> VMStateDescription<T> {
+        VMStateDescription::<T>(self.0, PhantomData)
+    }
+
+    #[must_use]
+    pub const fn new() -> Self {
+        Self(RawVMStateDescription::ZERO, PhantomData)
+    }
+}
+
+impl<T> Default for VMStateDescriptionBuilder<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T> VMStateDescription<T> {
+    pub const fn get_vmsd(&self) -> RawVMStateDescription {
+        self.0
+    }
+
+    pub const fn get_vmsd_ptr(&self) -> *const RawVMStateDescription {
+        &self.0 as *const _ as *const RawVMStateDescription
+    }
+}
+
+pub trait StaticVMStateDescription {
+    fn get_vmsd_ptr(&'static self) -> *const RawVMStateDescription;
+}
+
+impl<T> StaticVMStateDescription for VMStateDescription<T> {
+    fn get_vmsd_ptr(&'static self) -> *const RawVMStateDescription {
+        self.get_vmsd_ptr()
+    }
+}




