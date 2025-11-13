Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE89CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPO-00051c-Br; Wed, 12 Nov 2025 23:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPP1-0004mv-Gb; Wed, 12 Nov 2025 23:57:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOy-0001c6-5e; Wed, 12 Nov 2025 23:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009864; x=1794545864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xYpyItzvU+U1U89xSQkA8t3JXUFuUyTI1WKek/jbLis=;
 b=SYARrW0vkfLqs6KnuK2sM5oqdXmncrTf9f22K8dTGWJdHzoAvabcLkzX
 8zQP/6mVgn13v85g/sFmRPYfkOahgeWJ6s6hReH6QlPxqZBJ0EBaMSyOz
 xaLG0E8Z+6m/JQOYYq5zG3l6OZ6ZDPbqk+RtoWo6AOriefK0ieyPAL4xQ
 kVxTOYTkIcAdS2HJjmSz0VQA4Zsp2QKqpFJq0RVdcTOs+5B7l42+4EPEp
 i1ph8vzRS4ap7DzPGLFnwbj47fpb5rYjFcp11zcbgINt/v1UtbwXkxj9S
 LlasqJLLORHB1SiToJRLDZwc6G6aVbCVKYorNKAUwH2V9tnR7Prt4B5/6 g==;
X-CSE-ConnectionGUID: P2PNvTh9TC2VxzrbyOxmKA==
X-CSE-MsgGUID: wdmg2CwsQOyZ7hQVygRVeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682095"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682095"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:40 -0800
X-CSE-ConnectionGUID: zrsWifUPSGaI2GHmhZpYbQ==
X-CSE-MsgGUID: qx5Ng6GAQ4KR/B1Y0spvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663255"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:38 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/22] rust/hpet: Rename decoded "reg" enumeration to "target"
Date: Thu, 13 Nov 2025 13:19:24 +0800
Message-Id: <20251113051937.4017675-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113051937.4017675-1-zhao1.liu@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

HPETAddrDecode has a `reg` field so that there're many variables named
"reg" in MMIO read/write/decode functions.

In the future, there'll be other HPETRegisters/HPETTimerRegisters
structs containing values of HPET registers, and related variables or
arguments will be named as "regs".

To avoid potential confusion between many "reg" and "regs", rename
HPETAddrDecode::reg to HPETAddrDecode::target, and rename decoding
related variables from "reg" to "target".

"target" is picked as the name since this clearly reflects the field or
variable is the target decoded register.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index c76f52a374de..2105538cffe6 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -142,7 +142,7 @@ enum DecodedRegister<'a> {
 struct HPETAddrDecode<'a> {
     shift: u32,
     len: u32,
-    reg: DecodedRegister<'a>,
+    target: DecodedRegister<'a>,
 }
 
 const fn hpet_next_wrap(cur_tick: u64) -> u64 {
@@ -501,18 +501,18 @@ fn callback(&mut self) {
         self.update_irq(true);
     }
 
-    const fn read(&self, reg: TimerRegister) -> u64 {
+    const fn read(&self, target: TimerRegister) -> u64 {
         use TimerRegister::*;
-        match reg {
+        match target {
             CFG => self.config, // including interrupt capabilities
             CMP => self.cmp,    // comparator register
             ROUTE => self.fsb,
         }
     }
 
-    fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
+    fn write(&mut self, target: TimerRegister, value: u64, shift: u32, len: u32) {
         use TimerRegister::*;
-        match reg {
+        match target {
             CFG => self.set_tn_cfg_reg(shift, len, value),
             CMP => self.set_tn_cmp_reg(shift, len, value),
             ROUTE => self.set_tn_fsb_route_reg(shift, len, value),
@@ -782,34 +782,34 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
         let len = std::cmp::min(size * 8, 64 - shift);
 
         addr &= !4;
-        let reg = if (0..=0xff).contains(&addr) {
+        let target = if (0..=0xff).contains(&addr) {
             GlobalRegister::try_from(addr).map(DecodedRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
             if timer_id < self.num_timers {
                 // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
                 TimerRegister::try_from(addr & 0x18)
-                    .map(|reg| DecodedRegister::Timer(&self.timers[timer_id], reg))
+                    .map(|target| DecodedRegister::Timer(&self.timers[timer_id], target))
             } else {
                 // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
                 Err(addr)
             }
         };
 
-        // reg is now a Result<DecodedRegister, hwaddr>
+        // `target` is now a Result<DecodedRegister, hwaddr>
         // convert the Err case into DecodedRegister as well
-        let reg = reg.unwrap_or_else(DecodedRegister::Unknown);
-        HPETAddrDecode { shift, len, reg }
+        let target = target.unwrap_or_else(DecodedRegister::Unknown);
+        HPETAddrDecode { shift, len, target }
     }
 
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
         // TODO: Add trace point - trace_hpet_ram_read(addr)
-        let HPETAddrDecode { shift, reg, .. } = self.decode(addr, size);
+        let HPETAddrDecode { shift, target, .. } = self.decode(addr, size);
 
         use GlobalRegister::*;
         use DecodedRegister::*;
-        (match reg {
-            Timer(timer, tn_reg) => timer.borrow_mut().read(tn_reg),
+        (match target {
+            Timer(timer, tn_target) => timer.borrow_mut().read(tn_target),
             Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
             Global(CFG) => self.config.get(),
             Global(INT_STATUS) => self.int_status.get(),
@@ -830,13 +830,13 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
     }
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
-        let HPETAddrDecode { shift, len, reg } = self.decode(addr, size);
+        let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
 
         // TODO: Add trace point - trace_hpet_ram_write(addr, value)
         use GlobalRegister::*;
         use DecodedRegister::*;
-        match reg {
-            Timer(timer, tn_reg) => timer.borrow_mut().write(tn_reg, value, shift, len),
+        match target {
+            Timer(timer, tn_target) => timer.borrow_mut().write(tn_target, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
             Global(CFG) => self.set_cfg_reg(shift, len, value),
             Global(INT_STATUS) => self.set_int_status_reg(shift, len, value),
-- 
2.34.1


