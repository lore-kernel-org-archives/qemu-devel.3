Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1351ACD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPj-0005HA-Nm; Wed, 12 Nov 2025 23:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOz-0004mb-Oq; Wed, 12 Nov 2025 23:57:49 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOv-0001cQ-KP; Wed, 12 Nov 2025 23:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009862; x=1794545862;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3OTgmbXWXa3j4MCRvhCK3zxnzKKL2HP9WGCm4S7ASyk=;
 b=Gd4v15LvH1PvqvQlAuAdD0IAlPl+DaNpOQ3FQvoL1pz13VhhN3O6cS8g
 2w9kzRE5UVzEB1zalKfj9DQXy/NYHpOSEq1X8A59834DIB8qlaCU4DCVT
 MmITD+9GjaCgl93QNHXYexdpvUc/NWe0FteRvdmL2V4YyHPepvFRawwmO
 jM9sCNNjUWOalpxlobqHNg6Rv5OXl4QqcD46150n3G/Bnw04Fw9IHer6G
 3M+HkwY3QPgKEomfzyVpyqwVA77nD5ZoXv1ibIljfPz4SNvydAP2G7HHM
 g7heHvvCdDFzvxlBjVtK9mjYPxRixAu0dZ4KkvFT5xpLp3Z1Rvrr/f2cb A==;
X-CSE-ConnectionGUID: xwlkU8hZQiukCy+gSpQlmQ==
X-CSE-MsgGUID: O4FLhJfsQJ2kwsycqKFvEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682091"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682091"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:38 -0800
X-CSE-ConnectionGUID: YrPllLViQnKjvMQ2Z1gIXQ==
X-CSE-MsgGUID: twD4nmjcQF+zNsNfCHifCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663250"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:36 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/22] rust/hpet: Rename HPETRegister to DecodedRegister
Date: Thu, 13 Nov 2025 13:19:23 +0800
Message-Id: <20251113051937.4017675-9-zhao1.liu@intel.com>
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

HPETRegister represents the layout of register spaces of HPET timer
block and timer N, and is used to decode register address into register
enumeration.

To avoid confusion with the subsequently introduced HPETRegisters (that
is used to maintain values of HPET registers), rename HPETRegister to
DecodedRegister.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 5e08b91494cf..c76f52a374de 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -102,7 +102,7 @@
 #[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
-/// Timer registers, masked by 0x18
+/// Timer register enumerations, masked by 0x18
 enum TimerRegister {
     /// Timer N Configuration and Capability Register
     CFG = 0,
@@ -115,7 +115,7 @@ enum TimerRegister {
 #[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
-/// Global registers
+/// Global register enumerations
 enum GlobalRegister {
     /// General Capabilities and ID Register
     CAP = 0,
@@ -127,7 +127,7 @@ enum GlobalRegister {
     COUNTER = 0xF0,
 }
 
-enum HPETRegister<'a> {
+enum DecodedRegister<'a> {
     /// Global register in the range from `0` to `0xff`
     Global(GlobalRegister),
 
@@ -142,7 +142,7 @@ enum HPETRegister<'a> {
 struct HPETAddrDecode<'a> {
     shift: u32,
     len: u32,
-    reg: HPETRegister<'a>,
+    reg: DecodedRegister<'a>,
 }
 
 const fn hpet_next_wrap(cur_tick: u64) -> u64 {
@@ -783,22 +783,22 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
 
         addr &= !4;
         let reg = if (0..=0xff).contains(&addr) {
-            GlobalRegister::try_from(addr).map(HPETRegister::Global)
+            GlobalRegister::try_from(addr).map(DecodedRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
             if timer_id < self.num_timers {
                 // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
                 TimerRegister::try_from(addr & 0x18)
-                    .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
+                    .map(|reg| DecodedRegister::Timer(&self.timers[timer_id], reg))
             } else {
                 // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
                 Err(addr)
             }
         };
 
-        // reg is now a Result<HPETRegister, hwaddr>
-        // convert the Err case into HPETRegister as well
-        let reg = reg.unwrap_or_else(HPETRegister::Unknown);
+        // reg is now a Result<DecodedRegister, hwaddr>
+        // convert the Err case into DecodedRegister as well
+        let reg = reg.unwrap_or_else(DecodedRegister::Unknown);
         HPETAddrDecode { shift, len, reg }
     }
 
@@ -807,7 +807,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         let HPETAddrDecode { shift, reg, .. } = self.decode(addr, size);
 
         use GlobalRegister::*;
-        use HPETRegister::*;
+        use DecodedRegister::*;
         (match reg {
             Timer(timer, tn_reg) => timer.borrow_mut().read(tn_reg),
             Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
@@ -834,7 +834,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
 
         // TODO: Add trace point - trace_hpet_ram_write(addr, value)
         use GlobalRegister::*;
-        use HPETRegister::*;
+        use DecodedRegister::*;
         match reg {
             Timer(timer, tn_reg) => timer.borrow_mut().write(tn_reg, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
-- 
2.34.1


