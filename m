Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406DFCFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 08:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNS0T-00081f-EF; Mon, 24 Nov 2025 03:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNS0R-0007zu-Cs; Mon, 24 Nov 2025 03:33:07 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vNS0O-0002NH-VQ; Mon, 24 Nov 2025 03:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763973185; x=1795509185;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lKn1v3RIQpy9ZDsxyrygs9oCqvZ1gmzfEIZFFC8Bx2o=;
 b=h6M/mW251PY3YeES5cOWPViCD8HDZIwDtgawAUBYYc13bHlt8Y1L6Yii
 Kq9eG/FwXSGO5Uiuqvjw5/V131aTjHkaku1VdFXpswVWLIDsXd2tYa9uz
 NudMiz0eFwOcBnesHOveUXTqykjvoNpe+x9MhlI6lSyE5rPYQ9wIXTvvw
 dC7D9HRWWC/n3NpKKKLtdgS6IM4jE4Zy2YgRmpWZPTs6B3QcvOkjWWBVf
 7n4pKAEj5WdRDbr8VUcUkp8l8N6KqjJ7q/W5p/8LMhe0svey/KdW72rWR
 /9bacl5uVkVJt0lLO/YrCrjhQrQU6j512xgw6EWoHo3040Pd3SYyEJ9S3 g==;
X-CSE-ConnectionGUID: KGCb+PvZR5uNeV8cG96cOQ==
X-CSE-MsgGUID: bTBCEutSTzmHPunQ16g4/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65996614"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="65996614"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2025 00:33:01 -0800
X-CSE-ConnectionGUID: S5dlRhqxQ16qR5w/6NMZfQ==
X-CSE-MsgGUID: OfF92MbdSCePj+4n8egshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; d="scan'208";a="215619877"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 24 Nov 2025 00:32:59 -0800
Date: Mon, 24 Nov 2025 16:57:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/5] rust/hpet: move hpet_offset to HPETRegisters
Message-ID: <aSQeAjvtU9Ggb+Pl@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
 <20251117084752.203219-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084752.203219-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
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

> @@ -596,11 +598,11 @@ fn callback(&self, regs: &mut HPETRegisters) {
>              } else {
>                  tn_regs.cmp = tn_regs.cmp64;
>              }
> -            self.arm_timer(tn_regs, tn_regs.cmp64);
>          } else if tn_regs.wrap_flag != 0 {
>              tn_regs.wrap_flag = 0;
> -            self.arm_timer(tn_regs, tn_regs.cmp64);
>          }
> +        let next_tick = tn_regs.cmp64;
> +        self.arm_timer(regs, next_tick);

I didn't notice this in previous review... arming timer unconditionally
is wrong, since the code block is:

if tn_regs.is_periodic() && tn_regs.period != 0 {
    ...
    self.arm_timer(tn_regs, tn_regs.cmp64);
} else if tn_regs.wrap_flag != 0 {
    ...
    self.arm_timer(tn_regs, tn_regs.cmp64);
}

So one-shot mode (with wrap_flag == 0) shouldn't arm timer again,
(otherwise, the guest will hang).

---
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 19676af74bc6..179bd18e2045 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -586,23 +586,33 @@ fn callback(&self, regs: &mut HPETRegisters) {
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());

-        let cur_tick: u64 = regs.get_ticks();
-        let tn_regs = &mut regs.tn_regs[self.index as usize];
+        let next_tick = {
+            let cur_tick: u64 = regs.get_ticks();
+            let tn_regs = &mut regs.tn_regs[self.index as usize];

-        if tn_regs.is_periodic() && tn_regs.period != 0 {
-            while hpet_time_after(cur_tick, tn_regs.cmp64) {
-                tn_regs.cmp64 += tn_regs.period;
-            }
-            if tn_regs.is_32bit_mod() {
-                tn_regs.cmp = u64::from(tn_regs.cmp64 as u32); // truncate!
+            if tn_regs.is_periodic() && tn_regs.period != 0 {
+                while hpet_time_after(cur_tick, tn_regs.cmp64) {
+                    tn_regs.cmp64 += tn_regs.period;
+                }
+                if tn_regs.is_32bit_mod() {
+                    tn_regs.cmp = u64::from(tn_regs.cmp64 as u32); // truncate!
+                } else {
+                    tn_regs.cmp = tn_regs.cmp64;
+                }
+
+                Some(tn_regs.cmp64)
+            } else if tn_regs.wrap_flag != 0 {
+                tn_regs.wrap_flag = 0;
+
+                Some(tn_regs.cmp64)
             } else {
-                tn_regs.cmp = tn_regs.cmp64;
+                None
             }
-        } else if tn_regs.wrap_flag != 0 {
-            tn_regs.wrap_flag = 0;
+        };
+
+        if let Some(t) = next_tick {
+            self.arm_timer(regs, t);
         }
-        let next_tick = tn_regs.cmp64;
-        self.arm_timer(regs, next_tick);
         self.update_irq(regs, true);
     }




