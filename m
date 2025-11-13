Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1F8CD4F43
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPQC-0006G1-A3; Wed, 12 Nov 2025 23:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPr-0005Sl-0h; Wed, 12 Nov 2025 23:58:40 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPo-0001cD-B1; Wed, 12 Nov 2025 23:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009916; x=1794545916;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EdFLGENnkpgLu7RJcinMDXaJqsKi0QCi24bVBZVBmBw=;
 b=DL6jY6fD7VQwEHDgzYrVHBLlK9AQf80AaF45gU+kvpGB7aGc3DFXvoGv
 jWmGSeOmo6vRjKt0wOzRHdWRUIiAp4NpnqAmJkFo8u+DHzUnqr56Iuq5D
 j3kBUg6HL1NgVg/WSE3NRZU+dnbLI8pIH810MO61vWIxiYJk3G6JOWX1J
 vv+ale/eKUBXXAJP1VBvXa8n4DNR/BKK08oXuEK/HxWIhx3VThSUxDHxx
 /E8sbvoTQtwXummykdN2psL8erdfgqIBl5AtclD6mkFojfSt4iIK9/jEk
 YBG882zwfmIn9tCdU4kKsGntKehdKZ/1hiL0edu0+7/M2/Rx7JyDbyAkG Q==;
X-CSE-ConnectionGUID: f5Lai5vRQ8uDdQ3wQptECg==
X-CSE-MsgGUID: LvZ63aPxTnuMZy382t5kBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682167"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682167"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:58:02 -0800
X-CSE-ConnectionGUID: pCXMPIeFRkywbQlGh7yZgw==
X-CSE-MsgGUID: GPlrPY8RQ7SsOkJMFNpAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663478"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:59 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 19/22] rust/hpet: Rename hpet_regs variables to regs
Date: Thu, 13 Nov 2025 13:19:34 +0800
Message-Id: <20251113051937.4017675-20-zhao1.liu@intel.com>
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

Now, both global registers and timer registers are placed together
within the HPETRegisters struct. The previous "hpet_regs" name is used
to distinguish global registers, and it's not needed anymore for now.

Rename hpet_regs variables to regs, to make code use the consistent
variable naming style.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 116 +++++++++++++++----------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index f8a551fc0a78..73a1c87abd95 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -179,8 +179,8 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
 fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
     let mut t = timer_cell.borrow_mut();
     // SFAETY: state field is valid after timer initialization.
-    let hpet_regs = &mut unsafe { t.state.as_mut() }.regs.borrow_mut();
-    t.callback(hpet_regs)
+    let regs = &mut unsafe { t.state.as_mut() }.regs.borrow_mut();
+    t.callback(regs)
 }
 
 #[repr(C)]
@@ -286,27 +286,27 @@ fn get_state(&self) -> &HPETState {
         unsafe { self.state.as_ref() }
     }
 
-    fn is_int_active(&self, hpet_regs: &HPETRegisters) -> bool {
+    fn is_int_active(&self, regs: &HPETRegisters) -> bool {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        hpet_regs.is_timer_int_active(self.index.into())
+        regs.is_timer_int_active(self.index.into())
     }
 
     /// calculate next value of the general counter that matches the
     /// target (either entirely, or the low 32-bit only depending on
     /// the timer mode).
-    fn calculate_cmp64(&self, hpet_regs: &HPETRegisters, cur_tick: u64, target: u64) -> u64 {
+    fn calculate_cmp64(&self, regs: &HPETRegisters, cur_tick: u64, target: u64) -> u64 {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             let mut result: u64 = cur_tick.deposit(0, 32, target);
             if result < cur_tick {
@@ -318,14 +318,14 @@ fn calculate_cmp64(&self, hpet_regs: &HPETRegisters, cur_tick: u64, target: u64)
         }
     }
 
-    fn get_int_route(&self, hpet_regs: &HPETRegisters) -> usize {
+    fn get_int_route(&self, regs: &HPETRegisters) -> usize {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        if self.index <= 1 && hpet_regs.is_legacy_mode() {
+        if self.index <= 1 && regs.is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
             // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
@@ -345,21 +345,21 @@ fn get_int_route(&self, hpet_regs: &HPETRegisters) -> usize {
             // ...
             // If the LegacyReplacement Route bit is not set, the individual
             // routing bits for each of the timers are used.
-            hpet_regs.tn_regs[self.index as usize].get_individual_route()
+            regs.tn_regs[self.index as usize].get_individual_route()
         }
     }
 
-    fn set_irq(&self, hpet_regs: &HPETRegisters, set: bool) {
+    fn set_irq(&self, regs: &HPETRegisters, set: bool) {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
-        let route = self.get_int_route(hpet_regs);
+        let tn_regs = &regs.tn_regs[self.index as usize];
+        let route = self.get_int_route(regs);
 
-        if set && tn_regs.is_int_enabled() && hpet_regs.is_hpet_enabled() {
+        if set && tn_regs.is_int_enabled() && regs.is_hpet_enabled() {
             if tn_regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
@@ -382,7 +382,7 @@ fn set_irq(&self, hpet_regs: &HPETRegisters, set: bool) {
         }
     }
 
-    fn update_irq(&self, hpet_regs: &mut HPETRegisters, set: bool) {
+    fn update_irq(&self, regs: &mut HPETRegisters, set: bool) {
         // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
@@ -392,22 +392,22 @@ fn update_irq(&self, hpet_regs: &mut HPETRegisters, set: bool) {
         // If Timer N Interrupt Enable bit is 0, "the timer will
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
-        hpet_regs.int_status = hpet_regs.int_status.deposit(
+        regs.int_status = regs.int_status.deposit(
             self.index.into(),
             1,
-            u64::from(set && hpet_regs.tn_regs[self.index as usize].is_int_level_triggered()),
+            u64::from(set && regs.tn_regs[self.index as usize].is_int_level_triggered()),
         );
-        self.set_irq(hpet_regs, set);
+        self.set_irq(regs, set);
     }
 
-    fn arm_timer(&mut self, hpet_regs: &HPETRegisters, tick: u64) {
+    fn arm_timer(&mut self, regs: &HPETRegisters, tick: u64) {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &regs.tn_regs[self.index as usize];
         let mut ns = self.get_state().get_ns(tick);
 
         // Clamp period to reasonable min value (1 us)
@@ -419,31 +419,31 @@ fn arm_timer(&mut self, hpet_regs: &HPETRegisters, tick: u64) {
         self.qemu_timer.modify(self.last);
     }
 
-    fn set_timer(&mut self, hpet_regs: &HPETRegisters) {
+    fn set_timer(&mut self, regs: &HPETRegisters) {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &regs.tn_regs[self.index as usize];
         let cur_tick: u64 = self.get_state().get_ticks();
 
         self.wrap_flag = 0;
-        self.cmp64 = self.calculate_cmp64(hpet_regs, cur_tick, tn_regs.cmp);
+        self.cmp64 = self.calculate_cmp64(regs, cur_tick, tn_regs.cmp);
         if tn_regs.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
             if !tn_regs.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
                 self.wrap_flag = 1;
-                self.arm_timer(hpet_regs, hpet_next_wrap(cur_tick));
+                self.arm_timer(regs, hpet_next_wrap(cur_tick));
                 return;
             }
         }
-        self.arm_timer(hpet_regs, self.cmp64);
+        self.arm_timer(regs, self.cmp64);
     }
 
-    fn del_timer(&self, hpet_regs: &mut HPETRegisters) {
+    fn del_timer(&self, regs: &mut HPETRegisters) {
         // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
@@ -454,16 +454,16 @@ fn del_timer(&self, hpet_regs: &mut HPETRegisters) {
         // this timer instance.
         self.qemu_timer.delete();
 
-        if self.is_int_active(hpet_regs) {
+        if self.is_int_active(regs) {
             // For level-triggered interrupt, this leaves interrupt status
             // register set but lowers irq.
-            self.update_irq(hpet_regs, true);
+            self.update_irq(regs, true);
         }
     }
 
     fn prepare_tn_cfg_reg_new(
         &self,
-        hpet_regs: &mut HPETRegisters,
+        regs: &mut HPETRegisters,
         shift: u32,
         len: u32,
         val: u64,
@@ -474,7 +474,7 @@ fn prepare_tn_cfg_reg_new(
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &regs.tn_regs[self.index as usize];
         // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
         let old_val: u64 = tn_regs.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
@@ -484,14 +484,14 @@ fn prepare_tn_cfg_reg_new(
         if deactivating_bit(old_val, new_val, HPET_TN_CFG_INT_TYPE_SHIFT) {
             // Do this before changing timer.regs.config; otherwise, if
             // HPET_TN_FSB is set, update_irq will not lower the qemu_irq.
-            self.update_irq(hpet_regs, false);
+            self.update_irq(regs, false);
         }
 
         (new_val, old_val)
     }
 
     /// Configuration and Capability Register
-    fn set_tn_cfg_reg(&mut self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+    fn set_tn_cfg_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
         // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
@@ -499,38 +499,38 @@ fn set_tn_cfg_reg(&mut self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32
         assert!(bql::is_locked());
 
         // Factor out a prepare_tn_cfg_reg_new() to better handle immutable scope.
-        let (new_val, old_val) = self.prepare_tn_cfg_reg_new(hpet_regs, shift, len, val);
+        let (new_val, old_val) = self.prepare_tn_cfg_reg_new(regs, shift, len, val);
         // After prepare_tn_cfg_reg_new(), it's safe to access int_status with a
         // immutable reference before update_irq().
-        let tn_int_active = self.is_int_active(hpet_regs);
-        hpet_regs.tn_regs[self.index as usize].config = new_val;
+        let tn_int_active = self.is_int_active(regs);
+        regs.tn_regs[self.index as usize].config = new_val;
 
         if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT) && tn_int_active {
-            self.update_irq(hpet_regs, true);
+            self.update_irq(regs, true);
         }
 
         // Create the mutable reference after update_irq() to ensure that
         // only one mutable reference exists at a time.
-        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             tn_regs.cmp = u64::from(tn_regs.cmp as u32); // truncate!
             self.period = u64::from(self.period as u32); // truncate!
         }
 
-        if hpet_regs.is_hpet_enabled() {
-            self.set_timer(hpet_regs);
+        if regs.is_hpet_enabled() {
+            self.set_timer(regs);
         }
     }
 
     /// Comparator Value Register
-    fn set_tn_cmp_reg(&mut self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+    fn set_tn_cmp_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
         // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         let mut length = len;
         let mut value = val;
 
@@ -554,33 +554,33 @@ fn set_tn_cmp_reg(&mut self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32
         }
 
         tn_regs.clear_valset();
-        if hpet_regs.is_hpet_enabled() {
-            self.set_timer(hpet_regs);
+        if regs.is_hpet_enabled() {
+            self.set_timer(regs);
         }
     }
 
     /// FSB Interrupt Route Register
-    fn set_tn_fsb_route_reg(&self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+    fn set_tn_fsb_route_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
         // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         tn_regs.fsb = tn_regs.fsb.deposit(shift, len, val);
     }
 
-    fn reset(&mut self, hpet_regs: &mut HPETRegisters) {
+    fn reset(&mut self, regs: &mut HPETRegisters) {
         // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        self.del_timer(hpet_regs);
+        self.del_timer(regs);
 
-        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         tn_regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
         tn_regs.config = (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
         if self.get_state().has_msi_flag() {
@@ -594,14 +594,14 @@ fn reset(&mut self, hpet_regs: &mut HPETRegisters) {
     }
 
     /// timer expiration callback
-    fn callback(&mut self, hpet_regs: &mut HPETRegisters) {
+    fn callback(&mut self, regs: &mut HPETRegisters) {
         // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
@@ -614,22 +614,22 @@ fn callback(&mut self, hpet_regs: &mut HPETRegisters) {
             } else {
                 tn_regs.cmp = self.cmp64;
             }
-            self.arm_timer(hpet_regs, self.cmp64);
+            self.arm_timer(regs, self.cmp64);
         } else if self.wrap_flag != 0 {
             self.wrap_flag = 0;
-            self.arm_timer(hpet_regs, self.cmp64);
+            self.arm_timer(regs, self.cmp64);
         }
-        self.update_irq(hpet_regs, true);
+        self.update_irq(regs, true);
     }
 
-    fn read(&self, target: TimerRegister, hpet_regs: &HPETRegisters) -> u64 {
+    fn read(&self, target: TimerRegister, regs: &HPETRegisters) -> u64 {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
+        let tn_regs = &regs.tn_regs[self.index as usize];
 
         use TimerRegister::*;
         match target {
@@ -642,7 +642,7 @@ fn read(&self, target: TimerRegister, hpet_regs: &HPETRegisters) -> u64 {
     fn write(
         &mut self,
         target: TimerRegister,
-        hpet_regs: &mut HPETRegisters,
+        regs: &mut HPETRegisters,
         value: u64,
         shift: u32,
         len: u32,
@@ -655,9 +655,9 @@ fn write(
 
         use TimerRegister::*;
         match target {
-            CFG => self.set_tn_cfg_reg(hpet_regs, shift, len, value),
-            CMP => self.set_tn_cmp_reg(hpet_regs, shift, len, value),
-            ROUTE => self.set_tn_fsb_route_reg(hpet_regs, shift, len, value),
+            CFG => self.set_tn_cfg_reg(regs, shift, len, value),
+            CMP => self.set_tn_cmp_reg(regs, shift, len, value),
+            ROUTE => self.set_tn_fsb_route_reg(regs, shift, len, value),
         }
     }
 }
-- 
2.34.1


