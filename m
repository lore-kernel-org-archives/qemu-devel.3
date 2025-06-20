Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34176C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSenm-0006Vh-FS; Fri, 20 Jun 2025 12:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenk-0006VI-U3
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenj-0000F4-D2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KETZnc4aDehl43qftNGze3IPzLrQSPsMMuMzCI6EM3Q=;
 b=fGPx+ZHt5ywpOx6O7q6tt4/QE4FDzJh+MU5wu4n7i7DQU2f1l6pvpPZgJXD2K04mrfpBSm
 K5VNe12dlDZeesiqcnjsYI8it/FeF0mMp5UCgwHGaPa8CiTFOyFEABT+Vbzp7g0ZaGi2Dd
 S8yJoyxfxwRBVvvbKrgc3NsTmo9d2iQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-ZR6bHt9fOeKEHmMhb3UDHg-1; Fri, 20 Jun 2025 12:41:13 -0400
X-MC-Unique: ZR6bHt9fOeKEHmMhb3UDHg-1
X-Mimecast-MFC-AGG-ID: ZR6bHt9fOeKEHmMhb3UDHg_1750437672
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-adb5f5f43dfso163925666b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437671; x=1751042471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KETZnc4aDehl43qftNGze3IPzLrQSPsMMuMzCI6EM3Q=;
 b=oSKkQEoeUy3dNJk8nM3oSvxLlCnwXi4YBbiPnpGmGlQu3tUwkJAuczTbA08JaWuDno
 httvdTEfR7Th6fUWZ27UBNiKZvUJy61ERTJzSGLkmH76A8KqhTEujVJDLft/NyszN0nw
 +jXtCq6r3zSdr7bWkXIQBiZx+L4Tg5rnSGcUri/2mZ5PIwTVeWEJlVaVyFI22peLWa6W
 zhejOdsg481zL4DXPxIscUleh9LOjqQirH+GkP4REjRIl6Iv+8Wr1DT7Fmzlielbovmm
 pgePE1Mes40xwhb89o4ap2whR8x9UcHze71GPyHSd/kkqqeIQWN2/5GQdBxmPUPCah1I
 ztRQ==
X-Gm-Message-State: AOJu0YydaFKfqA1OXa9+rULa4LoTtBsIEUwaulIfTFY/wquFurKEyvt/
 BaZwzWN8y4Mfl7e906iyW0lNsl4QIVmp+ljx6NXKUEjLjJv3KgHZmeLiLpvxVJ517ZPxJv61kY7
 JGHzoMs5ttvZBQzinbE55j5aCKQaRiOB0fmjc/aDBcdmbIIc3jxUgaqs6+6T0kmAeyLUm+sQlU7
 kVhqXUafMUH0m4RM0tHgnAh0IoEyh/C1xgObX0jCor
X-Gm-Gg: ASbGncvCb28izvgmVr1S0o0kkyVYqe9CREYuR682BWK8Sp68Gd2EuIPKAN7P1JTMWD1
 5sud9CujWD8WRW3dVK65hK4WQjMklM/bqhjRSVWiPWbFQc0E6i6o/A/mKM/+5/4iUEu0Mp/Tv82
 Tr8iY5S5Sha+bcPkNV6PfZem0qWQegbXuLly/6kkVw1LwDeKtrMuzluxkwVpGD+E7v/Ee5IH3zs
 JRnsSwoJlDhtN+nkUs657hKZi/+or4otYpPoIZebLFHuMs/06re2yM6nDX9iezhr34KblJi5rZL
 fH0WztILXSjFd6iyaChdrmqALQ==
X-Received: by 2002:a17:906:c154:b0:ad8:a935:b8ff with SMTP id
 a640c23a62f3a-ae057ef75famr395038466b.31.1750437671038; 
 Fri, 20 Jun 2025 09:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKIXo5bvf5DFxav6ONdMjZu7+ciCVgv64jhuf5sBoov1UxO9ykrVnJL9NVvOVIBV16bPAvZA==
X-Received: by 2002:a17:906:c154:b0:ad8:a935:b8ff with SMTP id
 a640c23a62f3a-ae057ef75famr395035366b.31.1750437670525; 
 Fri, 20 Jun 2025 09:41:10 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0541b74b6sm185278566b.139.2025.06.20.09.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/24] rust: hpet: fully initialize object during instance_init
Date: Fri, 20 Jun 2025 18:40:34 +0200
Message-ID: <20250620164053.579416-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

The array of BqlRefCell<HPETTimer> is not initialized yet at the
end of instance_init.  In particular, the "state" field is NonNull
and therefore it is invalid to have it as zero bytes.

Note that MaybeUninit is necessary because assigning to self.timers[index]
would trigger Drop of the old value.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 42 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 735b2fbef79..340ca1d355d 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -4,6 +4,7 @@
 
 use std::{
     ffi::{c_int, c_void, CStr},
+    mem::MaybeUninit,
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
@@ -25,6 +26,7 @@
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
+    uninit_field_mut,
     vmstate::VMStateDescription,
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
     zeroable::Zeroable,
@@ -212,13 +214,13 @@ pub struct HPETTimer {
 }
 
 impl HPETTimer {
-    fn init(&mut self, index: u8, state: &HPETState) {
-        *self = HPETTimer {
+    fn new(index: u8, state: *const HPETState) -> HPETTimer {
+        HPETTimer {
             index,
             // SAFETY: the HPETTimer will only be used after the timer
             // is initialized below.
             qemu_timer: unsafe { Timer::new() },
-            state: NonNull::new((state as *const HPETState).cast_mut()).unwrap(),
+            state: NonNull::new(state.cast_mut()).unwrap(),
             config: 0,
             cmp: 0,
             fsb: 0,
@@ -226,19 +228,15 @@ fn init(&mut self, index: u8, state: &HPETState) {
             period: 0,
             wrap_flag: 0,
             last: 0,
-        };
+        }
+    }
 
+    fn init_timer_with_cell(cell: &BqlRefCell<Self>) {
+        let mut timer = cell.borrow_mut();
         // SAFETY: HPETTimer is only used as part of HPETState, which is
         // always pinned.
-        let qemu_timer = unsafe { Pin::new_unchecked(&mut self.qemu_timer) };
-        qemu_timer.init_full(
-            None,
-            CLOCK_VIRTUAL,
-            Timer::NS,
-            0,
-            timer_handler,
-            &state.timers[self.index as usize],
-        )
+        let qemu_timer = unsafe { Pin::new_unchecked(&mut timer.qemu_timer) };
+        qemu_timer.init_full(None, CLOCK_VIRTUAL, Timer::NS, 0, timer_handler, cell);
     }
 
     fn get_state(&self) -> &HPETState {
@@ -607,9 +605,18 @@ fn handle_legacy_irq(&self, irq: u32, level: u32) {
         }
     }
 
-    fn init_timer(&self) {
-        for (index, timer) in self.timers.iter().enumerate() {
-            timer.borrow_mut().init(index.try_into().unwrap(), self);
+    fn init_timers(this: &mut MaybeUninit<Self>) {
+        let state = this.as_ptr();
+        for index in 0..HPET_MAX_TIMERS {
+            let mut timer = uninit_field_mut!(*this, timers[index]);
+
+            // Initialize in two steps, to avoid calling Timer::init_full on a
+            // temporary that can be moved.
+            let timer = timer.write(BqlRefCell::new(HPETTimer::new(
+                index.try_into().unwrap(),
+                state,
+            )));
+            HPETTimer::init_timer_with_cell(timer);
         }
     }
 
@@ -710,6 +717,8 @@ unsafe fn init(&mut self) {
             "hpet",
             HPET_REG_SPACE_LEN,
         );
+
+        Self::init_timers(unsafe { &mut *((self as *mut Self).cast::<MaybeUninit<Self>>()) });
     }
 
     fn post_init(&self) {
@@ -731,7 +740,6 @@ fn realize(&self) -> qemu_api::Result<()> {
 
         self.hpet_id.set(HPETFwConfig::assign_hpet_id()?);
 
-        self.init_timer();
         // 64-bit General Capabilities and ID Register; LegacyReplacementRoute.
         self.capability.set(
             HPET_CAP_REV_ID_VALUE << HPET_CAP_REV_ID_SHIFT |
-- 
2.49.0


