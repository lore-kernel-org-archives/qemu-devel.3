Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4D606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Iyc3XG+z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0Q-0007Lq-On; Mon, 09 Nov 2026 09:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ09-0007AX-9u
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:39 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ07-0008B4-F8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:37 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so742997f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233134; x=1794837934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K0N5mXlXkvLuRoO3ciD/U4zuNV7Lwc6MUcZnwB0Wneo=;
 b=Iyc3XG+zgEKZav5Y+BfeENeybQVBjCOI2LNTo0+knvohO2b/iWWvfdXvR/avFKx1xP
 ryESoxaJ7fx3z/AuTyXTWjoY9QjhoFTddINNFSjOjYjFKE7jSUtUgfFdb2hb0bG8awZo
 tBMuQhlSLlNdVVH5hpEBYGAYWJiSk/8xNCelwTq1/1ssFKs1NLCZBrdqz3GuM/cD0fct
 YtxJFzjDtd/7ShIuOBDlI436PhBoajdfqo6+UNG+B2f7hsUhylTRrdvOyH+k0ADq8TKA
 NNSJNaCoUdqUFotBFT2d2/GSpOX74J7YndypB1hoBlA4+fFKAcobf+1pSS/AzE9y4+Mu
 5RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233134; x=1794837934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K0N5mXlXkvLuRoO3ciD/U4zuNV7Lwc6MUcZnwB0Wneo=;
 b=CVkX9mfN1A7/pHEXewM+Y2TNE6zsB12/dgXgmA8F+hLgCUjilNvKrwZB5tXBl64pI7
 s5vcCFJVyhAcyYejLxYjoNC/H0cWpC/7HuKF5WycX3dGcQAq+QMIC40kUmuKFH07BzJC
 iDu9PtX0RV0tA92Bz7Nzscc816zVg1PtctyyJ1LCbbFGqLIxV4eqiOvFoItmWWfvvC9A
 KAC3frUA0YSPkxdMUUWOTmKDZhDUF5MfOwen8WpKV7E6mVmva8ltFyMZ5h+W7vLIvtV7
 u7aMkXiNHdi5i1dYU5yvtBuvsntP1kKsb/5YN3168evnFs1B93qUWQ8lqc8YOnpk47Cy
 sQ/A==
X-Gm-Message-State: APuU4Z90d+zmLpeVbBK4HTzT1ReJv/tpOZJuQ0eDK/4LYkIBat3HKA+O
 YGvrptnNXWvAaqHs4sSjidUi7hJHEvqHB7N7cOSqvRsL/t2nUmcdgq3r3OKFHvwzb0ZuElJm3bh
 SdsEADmY=
X-Gm-Gg: AYBFou1iaJG+WqIji7B1DlBOBCjlNMkoqOksJcJjPAwRkGF4aoQtNjz+Ahcn7FYVSUw
 pb0cjzgYUuIDSURvxy2SlC/r3Ip9u288nSpZflN+wH+RKQcmO5z92MNhUC6lQseLW7a8Q88e+fi
 Xui0KLmedVVKLpHTpSAlny00kStZv8P/9M4H7p9bdZninuHH8t96jIeiE1lTTOyijDQ+fvElBGv
 YSGtE+IM2UKZhnBle9ZYau79Rdpa0/Hk2zbx9IZAah/PFf4u4osngA6LveuhvD1qBTHtVYaVfuB
 aBvjsAA9ly8CDYYZlJtkUsFOOmMbF1qztmS8wifx7xZ6EAx9SuQODajxgzVZLgotM9YFtvZVhwJ
 xWZCrUDWz9chFxqijn4gKABpT15nnOrNvAqaBXHISAW9mHsKNb3DOifudO42yMl9peE8hyJNV6b
 0o9/ukAu2HbNcA8xnuSkkcSHBoXRo7/ZUXox6BfA3TM1NQWfcg7+q8PFfWmtIE1CsSH0Mag6ze3
 2WqtxrKtKMguQCxC6mBevpP7xbwzjBIu5T+cGKc5LcMct+VuRC1OnvmW4iz/mWNen6y8ATAaC1C
 U7vcjkTNrhin8Tm96rjAhAm1ArYn+KufSs/5+puK3NMHfISRec9R27FU4mKEb1a2oKOPOvyzIa5
 97EesImfvMw5LFxE0PViCKM6K0Y6Tm3ONN0lnLEe6vVxYILaaZPGUlbc=
X-Received: by 2002:a05:6000:4b14:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-49588af4845mr9332196f8f.10.1794233133824; 
 Mon, 09 Nov 2026 06:05:33 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] hw/intc/arm_gic: do not hardcode GICv2 minimum binary point
Date: Mon,  9 Nov 2026 14:05:21 +0000
Message-ID: <20261109140523.240161-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The number of priority bits is implementation defined, and indeed
machines such as a9mpcore and arm11mpcore define it in the
num-priority-bits property. However we still hardcoded GIC_MIN_BPR.

This commit replaces the GIC_MIN_BPR and GIC_MIN_ABPR defs with macros
that read the property.

The calculation is based on "Table 4-47 Active Priorities register
implementation" in the GICv2 spec (page 4-150 of ARM IHI 0048B.b
ID072613):

+---------------+---------------+---------------+
|               |               |    Maximum    |
| Minimum value | Minimum value |    number of  |
|   of Secure   | of Non-secure |     group     |
|   GICC_BPR    |   GICC_BPR    | priority bits |
+===============+===============+===============+
|             3 |             4 |             4 |
|             2 |             3 |             5 |
|             1 |             2 |             6 |
|             0 |             1 |             7 |
+---------------+---------------+---------------+

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4375
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20261106-gic_read_bpr_from_property-v2-1-9f096cce4814@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gic.h        |  2 --
 include/hw/intc/arm_gic_common.h | 18 ++++++++++++++++--
 hw/intc/arm_gic.c                | 14 +++++++-------
 hw/intc/arm_gic_common.c         |  4 ++--
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index be923f7ed88..a1f4a2eebab 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -72,8 +72,6 @@
 
 /* Number of SGI target-list bits */
 #define GIC_TARGETLIST_BITS 8
-#define GIC_MAX_PRIORITY_BITS 8
-#define GIC_MIN_PRIORITY_BITS 4
 
 #define TYPE_ARM_GIC "arm_gic"
 typedef struct ARMGICClass ARMGICClass;
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index b169394e6ca..db7370a80ab 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -37,8 +37,8 @@
 #define MAX_NR_GROUP_PRIO 128
 #define GIC_NR_APRS (MAX_NR_GROUP_PRIO / 32)
 
-#define GIC_MIN_BPR 0
-#define GIC_MIN_ABPR (GIC_MIN_BPR + 1)
+#define GIC_MAX_PRIORITY_BITS 8
+#define GIC_MIN_PRIORITY_BITS 4
 
 /* Architectural maximum number of list registers in the virtual interface */
 #define GIC_MAX_LR 64
@@ -151,6 +151,20 @@ struct GICState {
 };
 typedef struct GICState GICState;
 
+
+static inline uint32_t gic_min_bpr(GICState *s)
+{
+    uint32_t num_preemption_bits = s->n_prio_bits == 8 ? 7 : s->n_prio_bits;
+    assert(!(s->n_prio_bits > GIC_MAX_PRIORITY_BITS
+             || s->n_prio_bits < GIC_MIN_PRIORITY_BITS));
+    return 7 - num_preemption_bits;
+}
+
+static inline uint32_t gic_min_abpr(GICState *s)
+{
+    return gic_min_bpr(s) + 1;
+}
+
 #define TYPE_ARM_GIC_COMMON "arm_gic_common"
 typedef struct ARMGICCommonClass ARMGICCommonClass;
 DECLARE_OBJ_CHECKERS(GICState, ARMGICCommonClass,
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b60f1f630b0..0236f45c3d1 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -479,7 +479,7 @@ static void gic_activate_irq(GICState *s, int cpu, int irq)
      * and update the running priority.
      */
     int prio = gic_get_group_priority(s, cpu, irq);
-    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+    int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
     int preemption_level = prio >> (min_bpr + 1);
     int regno = preemption_level / 32;
     int bitno = preemption_level % 32;
@@ -521,7 +521,7 @@ static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
         if (!apr) {
             continue;
         }
-        return (i * 32 + ctz32(apr)) << (GIC_MIN_BPR + 1);
+        return (i * 32 + ctz32(apr)) << (gic_min_bpr(s) + 1);
     }
     return 0x100;
 }
@@ -1561,7 +1561,7 @@ static inline uint32_t gic_apr_ns_view(GICState *s, int cpu, int regno)
     /* Return the Nonsecure view of GICC_APR<regno>. This is the
      * second half of GICC_NSAPR.
      */
-    switch (GIC_MIN_BPR) {
+    switch (gic_min_bpr(s)) {
     case 0:
         if (regno < 2) {
             return s->nsapr[regno + 2][cpu];
@@ -1592,7 +1592,7 @@ static inline void gic_apr_write_ns_view(GICState *s, int cpu, int regno,
                                          uint32_t value)
 {
     /* Write the Nonsecure view of GICC_APR<regno>. */
-    switch (GIC_MIN_BPR) {
+    switch (gic_min_bpr(s)) {
     case 0:
         if (regno < 2) {
             s->nsapr[regno + 2][cpu] = value;
@@ -1731,10 +1731,10 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                 /* WI when CBPR is 1 */
                 return MEMTX_OK;
             } else {
-                s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+                s->abpr[cpu] = MAX(value & 0x7, gic_min_abpr(s));
             }
         } else {
-            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
+            int min_bpr = gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
             s->bpr[cpu] = MAX(value & 0x7, min_bpr);
         }
         break;
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
             /* unimplemented, or NS access: RAZ/WI */
             return MEMTX_OK;
         } else {
-            s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
+            s->abpr[cpu] = MAX(value & 0x7, gic_min_abpr(s));
         }
         break;
     case 0xd0: case 0xd4: case 0xd8: case 0xdc:
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index a7c0763ab6a..fec5662d695 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -259,8 +259,8 @@ static inline void arm_gic_common_reset_irq_state(GICState *s, int cidx,
         s->current_pending[i] = 1023;
         s->running_priority[i] = 0x100;
         s->cpu_ctlr[i] = 0;
-        s->bpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR;
-        s->abpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_ABPR : GIC_MIN_ABPR;
+        s->bpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_BPR : gic_min_bpr(s);
+        s->abpr[i] = gic_is_vcpu(i) ? GIC_VIRT_MIN_ABPR : gic_min_abpr(s);
 
         if (!gic_is_vcpu(i)) {
             for (j = 0; j < GIC_INTERNAL; j++) {
-- 
2.43.0


