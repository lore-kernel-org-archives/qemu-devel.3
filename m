Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8702C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOeft-0000QE-T0; Mon, 09 Jun 2025 11:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefs-0000NO-4E
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefp-0007gy-Tz
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749483873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HjroMel8a6RF+nigSPUiqMo1YKd1zSm1exQlnXqhVE=;
 b=eCn+Nxijya2SOZlOr2LCxknlhwoleaO6d3NhDkBvcQkkjVJDDawdtOqa+WK4XlYyFCgdkR
 EevDRVPdDniUKB50a+Twjp5tx34rdjJ2eiRUtIHZNU7SP+eC6bwEbfdkGoKfW0JB3kozkE
 Bngd3n426lqR3bb0Mz8GbOGvlnksQnQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-1CAVF-HHM4icG44tJPohjA-1; Mon, 09 Jun 2025 11:44:32 -0400
X-MC-Unique: 1CAVF-HHM4icG44tJPohjA-1
X-Mimecast-MFC-AGG-ID: 1CAVF-HHM4icG44tJPohjA_1749483871
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453080e4741so12727335e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483870; x=1750088670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HjroMel8a6RF+nigSPUiqMo1YKd1zSm1exQlnXqhVE=;
 b=UjtR3DzdLMQZ4NfS6YRoERzjbsjdI6WwRqvrTm3B+5eTq42YkYNkMXSIdBVi5lRBdC
 5kYneYFklXrlOKCWBx0rTp1g/0wK/mNMyWG9rRznQAOXvANHXqEmdigEXR73YRIV6iK0
 5zOoYa1gquX4J4qSMekC+D6aHP6eAC6aSmuLn8CcGnefvXl/neV8uEXcnS1vUknELNDj
 F4xY1Lp3XjDeG2cI1SPRsMfDwWGQ9vkecz+AUWeAxGqFRxjLzeIvBgkB8hW0Ti1tmHhe
 6l8IrbTOigtqaixTPda/Q9TX12nTZMtyejZnDPYwKo98vmHG9fKM1CTsh+EXRxUiG2tC
 XuAw==
X-Gm-Message-State: AOJu0YyZ2SvB4d/xLPzXHCg626i7sQ7N3Cr4cgQj6nxy1x/eYfLFzgcv
 WeTvqCC7vW4YZvRzMJMD/PyWtCBSPqN9IUTKoazhieqT+NppVGElCT1H+Kr6V21oBS9i0NEbBYa
 xA5Oy+okShuZXnvW38kZmPW3IxFYE4xA75u5G5x+srXue5P2pOQrVH1hQq9y1BvCPwXh34SHywu
 d3SZhzVZXeef7/yBJ1n1l7eO1pQO4bZFx8ltG+ZTbS
X-Gm-Gg: ASbGncuaOgpztsozfn73e2WqdD+Z13TysbosBQbmIri1rVJR80H+8H1XESIZpqFd/wl
 fMYZd0eulaBixUiyfsJVGrVjIUHKoNQisDCvkpYPMklJUdQQJLG2cwI/5mXVYIY86jGHBoHn4XP
 W8Hsy4+0Uh2zjcNb3hbT923smJAdgTfZ2wXT3tO5voZ2wUFTvZNen1/+GPZSUtMOyhO82MD4Ake
 ryYCVXbNNsqHw31Pr3pLxmRN+BSGV+Ed9CtDsYzquZAiHAMBscgr0O1eWb9zHvKbxlO7pknxGkD
 q+vJ7kC1sFi0VQ==
X-Received: by 2002:a05:600c:8b23:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-452013898d8mr134266425e9.13.1749483869999; 
 Mon, 09 Jun 2025 08:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF535ooEPbrZS5uS233pOZdaRmQSWaeSCD/MruHfVyfo1LgqyeQe8cN6CnFFxN99WP1nPwp5A==
X-Received: by 2002:a05:600c:8b23:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-452013898d8mr134266155e9.13.1749483869432; 
 Mon, 09 Jun 2025 08:44:29 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730d1686sm110576235e9.36.2025.06.09.08.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:44:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/5] rust: hpet: fully initialize object after instance_init
Date: Mon,  9 Jun 2025 17:44:20 +0200
Message-ID: <20250609154423.706056-3-pbonzini@redhat.com>
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

The array of BqlRefCell<HPETTimer> is not initialized yet at the
end of instance_init.  In particular, the "state" field is NonNull
and therefore it is invalid to have it as zero bytes.

Note that MaybeUninit is necessary because assigning to self.timers[index]
would trigger Drop of the old value.

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


