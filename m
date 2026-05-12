Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E10CCD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgYk-0006mm-FB; Tue, 12 May 2026 02:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgY4-0003dw-CG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgY1-0006YK-0t
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:24:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45297094718so4060367f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567089; x=1779171889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HtM4pvITAcAWMJ185IMRhefQ8a/IBEtSiXJeVthh5tQ=;
 b=LoN2qTg3DJgnfyJZJxknaYPH0jICeEZ0ITgyrlPG4BrnW7dFR9cLh/DLOdQ6py/dcl
 6d8uoWkPWOUl370mIzDW6iTGx9AiOnXIay2R66Mvr6TA25EVyNt+OuOBYHqp5ZQCni+B
 5PlvaeuR15Lo23Sgo6feP/cK9yWzXSkH+Cx3iPNT1ATothV5u3sln9ktv9ogUS3apSuL
 JabPJd0USnYthMEpw3HYRtTtl6amygomHjBFOuWAi/3/kcAHgma41id8K9o5onrYGzYI
 5Z0OWjZUxMnsGN9pMO5iExGkXAFWe4+E/u5myUBI0sO0XbFCeS/CnlEbbxFcJgk4KWl7
 g1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567089; x=1779171889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HtM4pvITAcAWMJ185IMRhefQ8a/IBEtSiXJeVthh5tQ=;
 b=VevPqfeYAZV+cZ0Kt9xjRArLsD9w5fcp+BBIc+7C2tNsqERmzN6+Qhw/NhI87sSZx1
 8+5mJNgmtXurxJFo66qQmN33xH4yioenBDC1gWGdKCfmQ8XL/0t4DkdXojAjyiEXNNz7
 4EhPZ47MDEbYishD+pfkHE2BuQ+8LmnQYYR3kSSEI/b6b4CiTP1ByMweeOmt1uMx3IAi
 TnDtZKB99reFzVqYrKecNt+hmqYUs/QqZALOUq63Y0fEbJNbDWerynYpW4RB2ORNFbXI
 Ug3Qiq8pk5wevPikKlMufQsJbggD55J1sQx5wyvm7XAu70Ev1H2bhEKgK8E7Cl64Pkrp
 CB3g==
X-Gm-Message-State: AOJu0YywBZdaOW+9Pbw+u2SQs2PXNu8IpbXDgf+m8dxD9PgL/y48q33b
 Jh3uYPDN3EwTG4AL6PVqcfZ07Uy6O1iMC8B3nN6wDJCtq32JfQXh5bK/CywzGKbcg40MzsO82Li
 9d7K7obA=
X-Gm-Gg: Acq92OG6ZAd/goF7vGPn7WvNcVr56s+DZr/uPpUWh8COPuZrGVBsgoP55g41DUNLa+P
 VALwPoKlQZ9Tm5o4Tb7VFtQBBwesaGcfhBgcCV4WUffr3rYBeIcaRwFi9ljKMhS9s1VC48WkpSQ
 fTrOMKPs4BN9dVgRcew5vEJ6aQ+Riabd1WxFN/nsRCl5h5rgbAYqaJkr6ntjhSm9xBhrCZ8fouv
 5uzrcs5FSOQTNAPQ3AQkLE9fFg3X2/fW1CV+dU3NNWnGBzbflgT6UzTO+XD+ZescKlJFT79AGlA
 7FtqgW9ylqkL6XPXOg/3UDLw7mTupWuZRO76pDKShbJZGSATfksTvrQKlYR2Fm8t0MByhCDVXcN
 h8c3MD3RTF5oadceb5rPSlvwhnYyafvuoW7KMvPzTn/FtR61IpK72EfmqeET8g5q/DHe+vZ7YWQ
 r6wlESqaB08id+ybISOANgrXFtcA/EQNz7NDs1kwlY8KORx0QLB4V+3CfxYcBHbs7WvFbh+Yr+h
 4qjU+7Muj4=
X-Received: by 2002:a05:600c:1f85:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-48e8fe825bemr22619285e9.26.1778567089010; 
 Mon, 11 May 2026 23:24:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9052c7dcsm27706195e9.2.2026.05.11.23.24.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:24:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/41] target/arm: Implement translate_for_debug
Date: Tue, 12 May 2026 08:21:27 +0200
Message-ID: <20260512062142.67998-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Implement the translate_for_debug method instead of the
get_phys_addr_attrs_debug one.  This allows us to pass the caller the
lg_page_size from our internal GetPhysAddrResult struct.

Awkwardly, translate_for_debug's "true on success" convention
is the opposite of the one we use internally in ptw.c, so
we have to be careful about the sense of the return values.
This corresponds to the way that arm_cpu_tlb_fill_align()
also has to return true when get_phys_addr() returns false.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260417173105.1648172-17-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260430093810.2762539-18-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h       |  3 ---
 target/arm/internals.h |  4 ++++
 target/arm/cpu.c       |  2 +-
 target/arm/ptw.c       | 39 +++++++++++++++++++++++----------------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 60f11379bfb..15a13b92927 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1260,9 +1260,6 @@ extern const VMStateDescription vmstate_arm_cpu;
 void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 
-hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cpu, vaddr addr,
-                                         MemTxAttrs *attrs);
-
 typedef struct ARMGranuleProtectionConfig {
     /* GPCCR_EL3 */
     uint64_t gpccr;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 86b41b4724a..3edc15c7b4a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1540,6 +1540,10 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
 
 void arm_log_exception(CPUState *cs);
 
+/* Implementation of SysemuCPUOps::translate_for_debug */
+bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                 TranslateForDebugResult *result);
+
 #endif /* !CONFIG_USER_ONLY */
 
 /*
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6e13873360d..31e0a12a986 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2498,7 +2498,7 @@ static vaddr aarch64_untagged_addr(CPUState *cs, vaddr x)
 
 static const struct SysemuCPUOps arm_sysemu_ops = {
     .has_work = arm_cpu_has_work,
-    .get_phys_addr_attrs_debug = arm_cpu_get_phys_addr_attrs_debug,
+    .translate_for_debug = arm_cpu_translate_for_debug,
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 24656b1a062..8706dd59dd6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3942,8 +3942,9 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
                              memop, result, fi);
 }
 
-static hwaddr arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
-                                    MemTxAttrs *attrs, ARMMMUIdx mmu_idx)
+static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
+                                  TranslateForDebugResult *result,
+                                  ARMMMUIdx mmu_idx)
 {
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
@@ -3954,26 +3955,31 @@ static hwaddr arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-    bool ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
-    *attrs = res.f.attrs;
+    bool fault = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
 
-    if (ret) {
-        return -1;
+    if (!fault) {
+        /* translation succeeded */
+        result->physaddr = res.f.phys_addr;
+        result->attrs = res.f.attrs;
+        result->lg_page_size = res.f.lg_page_size;
     }
-    return res.f.phys_addr;
+    return fault;
 }
 
-hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
-                                         MemTxAttrs *attrs)
+bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                 TranslateForDebugResult *result)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
-    hwaddr res = arm_cpu_get_phys_addr(env, addr, attrs, mmu_idx);
-
-    if (res != -1) {
-        return res;
+    /*
+     * Note that this function returns true on translation success,
+     * but arm_cpu_get_phys_addr() and all the other get_phys_addr
+     * style functions in this file return true on failure.
+     */
+    if (!arm_cpu_get_phys_addr(env, addr, result, mmu_idx)) {
+        return true;
     }
 
     /*
@@ -3984,11 +3990,12 @@ hwaddr arm_cpu_get_phys_addr_attrs_debug(CPUState *cs, vaddr addr,
     switch (mmu_idx) {
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
-        return arm_cpu_get_phys_addr(env, addr, attrs, ARMMMUIdx_E10_0);
+        return !arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E10_0);
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
-        return arm_cpu_get_phys_addr(env, addr, attrs, ARMMMUIdx_E20_0);
+        return !arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E20_0);
     default:
-        return -1;
+        /* translation failed */
+        return false;
     }
 }
-- 
2.53.0


