Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE42C369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 07:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mU-00086Y-Rk; Sat, 03 May 2025 03:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mO-00085g-Ng
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mM-0006en-BK
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toxRje+xxVT+nxJgLRSzPIeanmmnkchIayeKIhpjgVE=;
 b=gbG+iVvrjPH2DbZcqIzSv4R96BCmAaE4xMOwsMDczk5KAq0W2nqvIrSGS1R0pOH3rnIHw7
 /cADgOYVjZDoEsQWNcF0XT9X6RA7EOniYocHg1kVZvqYmxGyuBbcAMtRM/r1pdJrV5sUAn
 rEGhPvWK0aNDA2OrPbv7jpTNE4X7kms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-UwYcyAVCOHW4H3cInofZ5g-1; Sat, 03 May 2025 03:59:20 -0400
X-MC-Unique: UwYcyAVCOHW4H3cInofZ5g-1
X-Mimecast-MFC-AGG-ID: UwYcyAVCOHW4H3cInofZ5g_1746259159
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43efa869b19so16354015e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259158; x=1746863958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toxRje+xxVT+nxJgLRSzPIeanmmnkchIayeKIhpjgVE=;
 b=Ni+5x6lnq1TFNuJc3nl8oU2izVf0VC10R99ucDZnryEd1vt/dcmLfgqAQu+cOVLsZL
 SrQNRoVCLzRpkY8RodRiAADXxptlIShUhejdmhFAood53UV2pdelYFyMLlohWkubCjay
 aZKYiMlFIfBL42doh3uLLOBYfFR9+5cE7wZoUFo4q2mYXGDsIQiEOdZsTtSkww6nG73Z
 MgjiGTnYlDmsrUg0uxwIoRVH3ZuqZk3Z2DirNdaFleFAi9TN5S3cUy5KVjqNRTvBm1io
 0hjC2JbPr4QQiPawckg7cTMex/N9yQy0V9pdvX+KnH7mGSIZEHoLnup8HhBkks+bQS4Q
 DwTg==
X-Gm-Message-State: AOJu0Yw3REZ1owP1oWMNC5Db8AiH5Xn6tfHCLjb//BPzJTxYfUoBfqyI
 SGIj+sboGK9vFrwzphNef6Q8zGVX/BFAmjdeJEThtftfoKarx3DY211jpw0YOerAq3rsZ+VEyM/
 o3Ks/ObDz8dTRjrUnRF6rKvvLtS6RZ6Jfk3ojGDmru2kIuDbjUh80E2F1o8KT/UjAv9lKge5JIt
 h4IQ9hfqQO8x9pfeEhjDpJyutw+n2L0LU93qlw
X-Gm-Gg: ASbGnctjPl0RaoOz0MW/r/RM3O3Q8FtNugptlz2iY82aWPugzAO6xA2lRfqnmzKZZri
 L7p3xSAt9cj2pa9048LH9vzcgh08iCUSvLWvICtEsCMsYMIiG8fRpkhKdodCxVmLDDc3/xecpUm
 MxNvTENOXhk6Qs53wFE9iLPHcWluLVeUo9BoXUqIuSECJE82fFVanU+pvW9DisVpa7IAD/4/g1Z
 rlEgixpXxcvQxW1QU1+Kbo6vdGYd3kD2ipFaCJOuNQRWeIq6/kzg84PLJ60Szux2vxzZj4PPECl
 WJjs6SJDTYsXKJs=
X-Received: by 2002:a05:600c:45d1:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-441c4938d58mr1919835e9.31.1746259157812; 
 Sat, 03 May 2025 00:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLP8J9soxClfcOJZJGIONXqNi6lgTLOv5Z5EHIbB1ofzavcdoAtrpbUiIS48do9iA6JnwnRg==
X-Received: by 2002:a05:600c:45d1:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-441c4938d58mr1919615e9.31.1746259157328; 
 Sat, 03 May 2025 00:59:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc441sm67909535e9.3.2025.05.03.00.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/13] rust/hpet: Support migration
Date: Sat,  3 May 2025 09:58:51 +0200
Message-ID: <20250503075858.277375-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

From: Zhao Liu <zhao1.liu@intel.com>

Based on commit 1433e38cc8 ("hpet: do not overwrite properties on
post_load"), add the basic migration support to Rust HPET.

The current migration implementation introduces multiple unsafe
callbacks. Before the vmstate builder, one possible cleanup approach is
to wrap callbacks in the vmstate binding using a method similar to the
vmstate_exist_fn macro.

However, this approach would also create a lot of repetitive code (since
vmstate has so many callbacks: pre_load, post_load, pre_save, post_save,
needed and dev_unplug_pending). Although it would be cleaner, it would
somewhat deviate from the path of the vmstate builder.

Therefore, firstly focus on completing the functionality of HPET, and
those current unsafe callbacks can at least clearly indicate the needed
functionality of vmstate. The next step is to consider refactoring
vmstate to move towards the vmstate builder direction.

Additionally, update rust.rst about Rust HPET can support migration.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst            |   3 +-
 rust/hw/timer/hpet/src/hpet.rs | 146 ++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 88bdec1eb28..3cc2841d4d1 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -153,8 +153,7 @@ QEMU includes four crates:
 
 .. [#issues] The ``pl011`` crate is synchronized with ``hw/char/pl011.c``
    as of commit 02b1f7f61928.  The ``hpet`` crate is synchronized as of
-   commit f32352ff9e.  Both are lacking tracing functionality; ``hpet``
-   is also lacking support for migration.
+   commit 1433e38cc8.  Both are lacking tracing functionality.
 
 This section explains how to work with them.
 
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index cbd2ed4f6bf..12de2ba59a1 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -4,6 +4,7 @@
 
 use std::{
     ffi::CStr,
+    os::raw::{c_int, c_void},
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
@@ -25,7 +26,10 @@
     qom::{ObjectImpl, ObjectType, ParentField},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    timer::{Timer, CLOCK_VIRTUAL},
+    timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
+    vmstate::VMStateDescription,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
+    zeroable::Zeroable,
 };
 
 use crate::fw_cfg::HPETFwConfig;
@@ -561,6 +565,7 @@ pub struct HPETState {
     #[doc(alias = "timer")]
     timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS as usize],
     num_timers: BqlCell<u8>,
+    num_timers_save: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
     hpet_id: BqlCell<usize>,
@@ -839,6 +844,49 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
             }
         }
     }
+
+    fn pre_save(&self) -> i32 {
+        if self.is_hpet_enabled() {
+            self.counter.set(self.get_ticks());
+        }
+
+        /*
+         * The number of timers must match on source and destination, but it was
+         * also added to the migration stream.  Check that it matches the value
+         * that was configured.
+         */
+        self.num_timers_save.set(self.num_timers.get());
+        0
+    }
+
+    fn post_load(&self, _version_id: u8) -> i32 {
+        for timer in self.timers.iter().take(self.get_num_timers()) {
+            let mut t = timer.borrow_mut();
+
+            t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.cmp);
+            t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
+        }
+
+        // Recalculate the offset between the main counter and guest time
+        if !self.hpet_offset_saved {
+            self.hpet_offset
+                .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
+        }
+
+        0
+    }
+
+    fn is_rtc_irq_level_needed(&self) -> bool {
+        self.rtc_irq_level.get() != 0
+    }
+
+    fn is_offset_needed(&self) -> bool {
+        self.is_hpet_enabled() && self.hpet_offset_saved
+    }
+
+    fn validate_num_timers(&self, _version_id: u8) -> bool {
+        self.num_timers.get() == self.num_timers_save.get()
+    }
 }
 
 qom_isa!(HPETState: SysBusDevice, DeviceState, Object);
@@ -895,11 +943,107 @@ impl ObjectImpl for HPETState {
     ),
 }
 
+unsafe extern "C" fn hpet_rtc_irq_level_needed(opaque: *mut c_void) -> bool {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
+    state.is_rtc_irq_level_needed()
+}
+
+unsafe extern "C" fn hpet_offset_needed(opaque: *mut c_void) -> bool {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
+    state.is_offset_needed()
+}
+
+unsafe extern "C" fn hpet_pre_save(opaque: *mut c_void) -> c_int {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &mut HPETState =
+        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
+    state.pre_save() as c_int
+}
+
+unsafe extern "C" fn hpet_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &mut HPETState =
+        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
+    let version: u8 = version_id.try_into().unwrap();
+    state.post_load(version) as c_int
+}
+
+static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet/rtc_irq_level").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(hpet_rtc_irq_level_needed),
+    fields: vmstate_fields! {
+        vmstate_of!(HPETState, rtc_irq_level),
+    },
+    ..Zeroable::ZERO
+};
+
+static VMSTATE_HPET_OFFSET: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet/offset").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(hpet_offset_needed),
+    fields: vmstate_fields! {
+        vmstate_of!(HPETState, hpet_offset),
+    },
+    ..Zeroable::ZERO
+};
+
+static VMSTATE_HPET_TIMER: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet_timer").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(HPETTimer, index),
+        vmstate_of!(HPETTimer, config),
+        vmstate_of!(HPETTimer, cmp),
+        vmstate_of!(HPETTimer, fsb),
+        vmstate_of!(HPETTimer, period),
+        vmstate_of!(HPETTimer, wrap_flag),
+        vmstate_of!(HPETTimer, qemu_timer),
+    },
+    ..Zeroable::ZERO
+};
+
+const VALIDATE_TIMERS_NAME: &CStr = c_str!("num_timers must match");
+
+static VMSTATE_HPET: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet").as_ptr(),
+    version_id: 2,
+    minimum_version_id: 1,
+    pre_save: Some(hpet_pre_save),
+    post_load: Some(hpet_post_load),
+    fields: vmstate_fields! {
+        vmstate_of!(HPETState, config),
+        vmstate_of!(HPETState, int_status),
+        vmstate_of!(HPETState, counter),
+        vmstate_of!(HPETState, num_timers_save).with_version_id(2),
+        vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
+        vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+    },
+    subsections: vmstate_subsections! {
+        VMSTATE_HPET_RTC_IRQ_LEVEL,
+        VMSTATE_HPET_OFFSET,
+    },
+    ..Zeroable::ZERO
+};
+
 impl DeviceImpl for HPETState {
     fn properties() -> &'static [Property] {
         &HPET_PROPERTIES
     }
 
+    fn vmsd() -> Option<&'static VMStateDescription> {
+        Some(&VMSTATE_HPET)
+    }
+
     const REALIZE: Option<fn(&Self)> = Some(Self::realize);
 }
 
-- 
2.49.0


