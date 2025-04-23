Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1416C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcp-0006u9-8X; Wed, 23 Apr 2025 05:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcT-000639-Uq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcR-0008QR-VC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYt3ABz0nzdAVWqaTctbQSwov0PN9M4iHaiJO7YPA7E=;
 b=Db2TX2nG0Ig6g+JNo5taQksk/qy1W0JVxQnllTFtpRL/Xek7Df1oOU0HHK++Uqki1NNJ2E
 ijlagohcp9Tc5gbLlaTOMLiBIQmOMvXwL+aTyAy3wKDsyJ9JqG6sv16cI2LmbU/7UDhQSd
 XpwPlQHM9hCCFxFkEusr1rP/pmUWsZg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-N-fdiF-FMoO-fc7OqVnvLg-1; Wed, 23 Apr 2025 05:42:13 -0400
X-MC-Unique: N-fdiF-FMoO-fc7OqVnvLg-1
X-Mimecast-MFC-AGG-ID: N-fdiF-FMoO-fc7OqVnvLg_1745401332
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac28a2c7c48so523784166b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401332; x=1746006132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MYt3ABz0nzdAVWqaTctbQSwov0PN9M4iHaiJO7YPA7E=;
 b=L3jb6zF/rG0JVEYYxcjvPQN4aH4GgKx+e7I395hiTi7FL7jDDQhe5hUkvqcYtgr4PZ
 +WiMbD/3ZFWfZu/u7QNOdv4RNe2ko5lo+1v4WdYqvTCflv0Mqx2uRH8wvGWERSaEZejv
 mNpEq8fIQft+DCEhj/1B5C1CVSbdCP3g5PgFQvH5ffnhif67TpRZF5YwFGG/31ES1U5G
 Xvjw3+PuLy2YdJvpYhJUUTh5KY1+rILlF4qicYeWK3kq3VQspzO5EaAljlCefoo3oSGf
 R8ic9OGGpwTmKqI4rhwU+4PF+82FuipiFZ7WsdOk9LHlxS1SOzclejHXwHkc+ngfBdkF
 Ef9w==
X-Gm-Message-State: AOJu0YzIi3svgTukpVeSlhPGT12axczB8B5VSlJGJkbF/Scj3qwAI0k4
 hXybs2eMao+FECrzulnl5A5qlY8PsWLdkTGGCOFysvsmK8WtK6+TlgdtrlTB87opJOjVXaRqqdS
 nBJZsxR6qy+R+Z0G5MmgHGQfQYoX2UAm5V88G/SOCk4hUq5aTQdr6EivtYcJTELSC8JdZ8shRri
 AAMCDjAJVL/BJybUgDZkDnPrh+1UDt0xZkUUbi
X-Gm-Gg: ASbGncv7FggEQY/3Bt4XD5VNXpi6wYLdxcL82LT85EdCgi+iPK4s/Mka5L+QxGRrzEX
 ZE4b+yxs86rJSgKMXQ2TwbPkldhwD9wDHuxZM8vQMWTXT7+IZXa1066Rnqp2f+gq26nz7IUF/p5
 dqPxzeW7ZGdRTtx9TS42AVkj+OwMVEHaPt7BbCHCK4hSHuq0he2wVWx4aiK4unDZhxdXzrjqOwR
 okVBD3M5l6WCuSNLHlt3DL2uviUTbKzcA9q+eLCF40g8oFUrFj1mr+4ge69v5MxiQeLp+6YZvmp
 3m7+utgeHua/KU2U
X-Received: by 2002:a17:907:1b21:b0:acb:33c6:5c71 with SMTP id
 a640c23a62f3a-acb74b8189cmr1702713566b.29.1745401331981; 
 Wed, 23 Apr 2025 02:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfDA/DRDOOTpPX1pQSxZBcqjxtcredX3sgxWAwHclqgGbnwAwDQRKi8yxKGUaMZS7lqXiEog==
X-Received: by 2002:a17:907:1b21:b0:acb:33c6:5c71 with SMTP id
 a640c23a62f3a-acb74b8189cmr1702709866b.29.1745401331460; 
 Wed, 23 Apr 2025 02:42:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ec0b6f0sm775589066b.6.2025.04.23.02.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 29/34] rust/hpet: convert num_timers to u8 type
Date: Wed, 23 Apr 2025 11:40:59 +0200
Message-ID: <20250423094105.40692-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

From: Zhao Liu <zhao1.liu@intel.com>

The C version of HPET uses the uint8_t type for num_timers, and usize
type in Rust version will break migration between the C and Rust
versions.

So convert num_timers' type to u8 (consistent with the C version of
HPET) to make it friendly for vmstate support.

Note the commit 7bda68e8e2b0 ("qdev, rust/hpet: fix type of HPET
'timers property") supports the usize type property, but the uint8
property has to be re-supported now.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 3ae3ec25f17..1afa891362f 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -12,7 +12,7 @@
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_usize,
+        qdev_prop_uint32, qdev_prop_uint8,
     },
     c_str,
     cell::{BqlCell, BqlRefCell},
@@ -34,9 +34,9 @@
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
 /// Minimum recommended hardware implementation.
-const HPET_MIN_TIMERS: usize = 3;
+const HPET_MIN_TIMERS: u8 = 3;
 /// Maximum timers in each timer block.
-const HPET_MAX_TIMERS: usize = 32;
+const HPET_MAX_TIMERS: u8 = 32;
 
 /// Flags that HPETState.flags supports.
 const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
@@ -559,14 +559,19 @@ pub struct HPETState {
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
-    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
-    num_timers: BqlCell<usize>,
+    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS as usize],
+    num_timers: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
     hpet_id: BqlCell<usize>,
 }
 
 impl HPETState {
+    // Get num_timers with `usize` type, which is useful to play with array index.
+    fn get_num_timers(&self) -> usize {
+        self.num_timers.get().into()
+    }
+
     const fn has_msi_flag(&self) -> bool {
         self.flags & (1 << HPET_FLAG_MSI_SUPPORT_SHIFT) != 0
     }
@@ -628,7 +633,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             self.hpet_offset
                 .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
 
-            for timer in self.timers.iter().take(self.num_timers.get()) {
+            for timer in self.timers.iter().take(self.get_num_timers()) {
                 let mut t = timer.borrow_mut();
 
                 if t.is_int_enabled() && t.is_int_active() {
@@ -640,7 +645,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             // Halt main counter and disable interrupt generation.
             self.counter.set(self.get_ticks());
 
-            for timer in self.timers.iter().take(self.num_timers.get()) {
+            for timer in self.timers.iter().take(self.get_num_timers()) {
                 timer.borrow_mut().del_timer();
             }
         }
@@ -663,7 +668,7 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
         let new_val = val << shift;
         let cleared = new_val & self.int_status.get();
 
-        for (index, timer) in self.timers.iter().take(self.num_timers.get()).enumerate() {
+        for (index, timer) in self.timers.iter().take(self.get_num_timers()).enumerate() {
             if cleared & (1 << index) != 0 {
                 timer.borrow_mut().update_irq(false);
             }
@@ -737,7 +742,7 @@ fn realize(&self) {
             1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
             1 << HPET_CAP_LEG_RT_CAP_SHIFT |
             HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
-            ((self.num_timers.get() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
+            ((self.get_num_timers() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
             (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT, // 10 ns
         );
 
@@ -746,7 +751,7 @@ fn realize(&self) {
     }
 
     fn reset_hold(&self, _type: ResetType) {
-        for timer in self.timers.iter().take(self.num_timers.get()) {
+        for timer in self.timers.iter().take(self.get_num_timers()) {
             timer.borrow_mut().reset();
         }
 
@@ -774,7 +779,7 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
             GlobalRegister::try_from(addr).map(HPETRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
-            if timer_id <= self.num_timers.get() {
+            if timer_id <= self.get_num_timers() {
                 // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
                 TimerRegister::try_from(addr & 0x18)
                     .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
@@ -859,8 +864,8 @@ impl ObjectImpl for HPETState {
         c_str!("timers"),
         HPETState,
         num_timers,
-        unsafe { &qdev_prop_usize },
-        usize,
+        unsafe { &qdev_prop_uint8 },
+        u8,
         default = HPET_MIN_TIMERS
     ),
     qemu_api::define_property!(
-- 
2.49.0


