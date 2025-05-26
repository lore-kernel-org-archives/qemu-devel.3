Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677BBC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlv-0003In-RR; Mon, 26 May 2025 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYli-00032O-5N
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYld-0007t2-Az
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e7XL373PGEgSsSjnf8t+unv02/Oh406O0MVIcACVlRA=;
 b=Cb36HSbzx5/NA4+vu3ikk43p/STfhehT0n1n+ScBIIEgTTKauGf9G2qGuCLHyRm2FhDdA4
 JetoN29sRvPE7pQ/qnrQh98IGkevmjEjgWu/7fGI9l+JA8e209fGwq4EUWbpRpuz1/c1uQ
 efg1VgDfiZkgvlgU3RWx/qBS+BcWmsQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-cbvXHzz7P5-WRdaqsSN2lw-1; Mon, 26 May 2025 10:25:27 -0400
X-MC-Unique: cbvXHzz7P5-WRdaqsSN2lw-1
X-Mimecast-MFC-AGG-ID: cbvXHzz7P5-WRdaqsSN2lw_1748269526
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so12162365e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269525; x=1748874325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7XL373PGEgSsSjnf8t+unv02/Oh406O0MVIcACVlRA=;
 b=anVYh5QOFhOzQa9H/68KHChwYYMExnq5gNUGbgOqDhFsem7lfOkrxvwj26iuqHwZW1
 LJig5Q9mnkE32Wg1VC+21wn+4p/AmuWJ5wEoXd8EfkCOI5vo5Fgf3o1jc7ZMT6bF/Li7
 cwPmVDspH5CLpa9gw9Oiomyd6ZZYUZNo6tj23yUZcwuT0tXMDyJXK7gh3Z4vls+ZoE6p
 8dfiFEL35DIeTGPSEORHdnGohqnbHlq+HlV9AfK/GLq8LG+LcxaidMvrwwMv7++OEsMH
 AjwJCogckkwiaKwTqArTnL0f/tlLSkd1yXTg+r7QX12yyxem5dux7REhBES/0cBPLLF4
 J+KA==
X-Gm-Message-State: AOJu0Ywe5QOstX2NtDMGoc3WHfFzrrMrMBFKDLFnuzXQ6yz3774EP00U
 z+AkaZdN33XWji61HWhVd58q1v5CjCPoKNeE+UNuNVKZgRWNo2TpeiGnVuGrO8JbkMxIOQQMQcs
 Bfl25cQDPmPURfPXCS61ZGEbY0bBWPM19m0qh3zh0+wb+OIh+JaiYYr2cK8yQ5tbUrFbAXeB+Zk
 JoXHlzEluFsr2zFxM3CvVD2CojvEn4q3rd02O9T/Ff
X-Gm-Gg: ASbGncugwLE8Je8QCEqngqIU+Qnvv5/aJG3Aice0vEODKK/xt8cuT+6vNZvZU/Mu8Fb
 +sz89CZ9kAvCiXMkJTDpz0a4XGvvcQlNBahwc/jKtKpiQ08SGh0x5jyuBkiZVhnOCjQVMBzh62S
 z0phqLt3quKh/pNOZXYTpUhfqtCNR1jSyODxdD83sXt1QXcaKApg8ZtBdNn18iJ5DKI9zS29QyS
 tNmlxms2vEzp+c/fDkJEt/NQOvakiADlmuPo/EZSoFHC4TeBQbTuhnpiQ1quCMM5PLFKbviOvH1
 BSgUc/kc7MhBkA==
X-Received: by 2002:a05:600c:34ca:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-44c91ad7026mr86946275e9.14.1748269525415; 
 Mon, 26 May 2025 07:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzoBz7wkVpIO4pdjuOW8qCuI7xCcvhjjqVOMYzJbqIs93+muKPKEJSTXNKX00Yti2oLT4ENw==
X-Received: by 2002:a05:600c:34ca:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-44c91ad7026mr86945865e9.14.1748269524870; 
 Mon, 26 May 2025 07:25:24 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cf7aa715sm7003240f8f.35.2025.05.26.07.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 12/12] rust/hpet: Drop BqlCell wrapper for num_timers
Date: Mon, 26 May 2025 16:24:55 +0200
Message-ID: <20250526142455.1061519-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

From: Zhao Liu <zhao1.liu@intel.com>

Now that the num_timers field is initialized as a property, someone may
change its default value using qdev_prop_set_uint8(), but the value is
fixed after the Rust code sees it first.  Since there is no need to modify
it after realize(), it is not to be necessary to have a BqlCell wrapper.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250520152750.2542612-4-zhao1.liu@intel.com
[Remove .into() as well. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index b298938e4d5..3c5c65ff47d 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -562,7 +562,7 @@ pub struct HPETState {
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
     timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
-    num_timers: BqlCell<usize>,
+    num_timers: usize,
     num_timers_save: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
@@ -570,11 +570,6 @@ pub struct HPETState {
 }
 
 impl HPETState {
-    // Get num_timers with `usize` type, which is useful to play with array index.
-    fn get_num_timers(&self) -> usize {
-        self.num_timers.get()
-    }
-
     const fn has_msi_flag(&self) -> bool {
         self.flags & (1 << HPET_FLAG_MSI_SUPPORT_SHIFT) != 0
     }
@@ -636,7 +631,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             self.hpet_offset
                 .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
 
-            for timer in self.timers.iter().take(self.get_num_timers()) {
+            for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
 
                 if t.is_int_enabled() && t.is_int_active() {
@@ -648,7 +643,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             // Halt main counter and disable interrupt generation.
             self.counter.set(self.get_ticks());
 
-            for timer in self.timers.iter().take(self.get_num_timers()) {
+            for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow_mut().del_timer();
             }
         }
@@ -671,7 +666,7 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
         let new_val = val << shift;
         let cleared = new_val & self.int_status.get();
 
-        for (index, timer) in self.timers.iter().take(self.get_num_timers()).enumerate() {
+        for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
                 timer.borrow_mut().update_irq(false);
             }
@@ -725,7 +720,7 @@ fn post_init(&self) {
     }
 
     fn realize(&self) -> qemu_api::Result<()> {
-        if self.num_timers.get() < HPET_MIN_TIMERS || self.num_timers.get() > HPET_MAX_TIMERS {
+        if self.num_timers < HPET_MIN_TIMERS || self.num_timers > HPET_MAX_TIMERS {
             Err(format!(
                 "hpet.num_timers must be between {HPET_MIN_TIMERS} and {HPET_MAX_TIMERS}"
             ))?;
@@ -743,7 +738,7 @@ fn realize(&self) -> qemu_api::Result<()> {
             1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
             1 << HPET_CAP_LEG_RT_CAP_SHIFT |
             HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
-            ((self.get_num_timers() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
+            ((self.num_timers - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
             (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT, // 10 ns
         );
 
@@ -753,7 +748,7 @@ fn realize(&self) -> qemu_api::Result<()> {
     }
 
     fn reset_hold(&self, _type: ResetType) {
-        for timer in self.timers.iter().take(self.get_num_timers()) {
+        for timer in self.timers.iter().take(self.num_timers) {
             timer.borrow_mut().reset();
         }
 
@@ -781,7 +776,7 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
             GlobalRegister::try_from(addr).map(HPETRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
-            if timer_id <= self.get_num_timers() {
+            if timer_id < self.num_timers {
                 // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
                 TimerRegister::try_from(addr & 0x18)
                     .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
@@ -852,12 +847,12 @@ fn pre_save(&self) -> i32 {
          * also added to the migration stream.  Check that it matches the value
          * that was configured.
          */
-        self.num_timers_save.set(self.num_timers.get() as u8);
+        self.num_timers_save.set(self.num_timers as u8);
         0
     }
 
     fn post_load(&self, _version_id: u8) -> i32 {
-        for timer in self.timers.iter().take(self.get_num_timers()) {
+        for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
 
             t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.cmp);
@@ -882,7 +877,7 @@ fn is_offset_needed(&self) -> bool {
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-        self.num_timers.get() == self.num_timers_save.get().into()
+        self.num_timers == self.num_timers_save.get().into()
     }
 }
 
-- 
2.49.0


