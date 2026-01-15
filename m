Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE485D4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVz-00024U-Pk; Thu, 15 Jan 2026 13:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV8-0000dt-Im
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:22 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV6-0005tZ-Os
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:22 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so1004818f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503318; x=1769108118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cetP1J1aWKEi9nsVT6d4hD/J2+TMx9aoQKwyU7+I/5k=;
 b=L+OR4JgC3w1abF2S756pUcRjviofjjcXp2y3uEe5LapJ/akv+QPUf0B9ihHBuNffKt
 KOL6GZkZm3GaAIGfQXYzFVo4Cx2v7PUkf+XENzxrBJRex79JruQWqZRGIlsHdNvDAQD1
 FV/o42iyMWKHwpWYE7HwXXQ/rOtw0mitM2XTYwj6m+RHmpMZbX8QerRCViF3DW6VxzRU
 cwFd7OcX5Tqf7NNzjusxfVa6MqmQ0xHoU1InVhhziaVCmobMyjWxUM02kmPXUoW/4M/j
 E515qzfYMiVTKzP7+3a/u7ZswO4xG4LjJFtgBgrgkuO65ZOH0xK9ALEh7aVXF8lteoiI
 a09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503318; x=1769108118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cetP1J1aWKEi9nsVT6d4hD/J2+TMx9aoQKwyU7+I/5k=;
 b=FOOxwd2E1Glendh410L3ZUhjuZiRYGSlnT/j0Ih/F6mUv/cdTrpONb8ClE7TAJO6Be
 TKr4LKOrLnzv/KBt2ssCvNXIVey/25QAuUJCLA4DE7JBm3ef5AM+jXg0rDq+1hJvF0sR
 hwThJNWXydTU9RlnIna00Wqi5q3raSnYCLcxT/fEBLSQ3o3cJDenmwosri9/CAtFHDns
 fsPd4q4QrJl/J4PckAddDtHSqG8h7GBjyQXji4ueDdZyVGBcmjEXaVRKyb2jVwRdi+XX
 C3PMo2+YfsogvnUz0qO4bc00ZO9P7Aqz6uDwyOZUB+fDgpt17y/lPnjA21yBFDhhd/Fu
 Qq4Q==
X-Gm-Message-State: AOJu0Yx4ExzEviZaGoOV6WdU/emdbD1qYTBquCcDTXjiIQxel/BA+BJI
 xkkZnreuXhZrzUNgsZETGgZSrw8PbecxTAuFrVLtq/bEBVic2jEpEE5y0KRUcBTP99uGQgNjcil
 ZXPL7
X-Gm-Gg: AY/fxX4OBG3zRLPvU88DE76l0l3XgY3/jmHqyydx3ul8aFQXa1KbZwAJcuI2Jo0Zucp
 D4je0WsUv5aMfo6V+oU9F6H+P11MmEHsMJDVEWiXayflq/OzFEvJENk1jF/55+YHUo9Jv4qcn93
 73CVl2JagjidUIXAEE7B8lq5jfb0SbrNL3q4Ixrqo35DYjirjB7dtN1iiIenIXlt4rZEBUkRFN8
 QIiDDjsVp0Zh+0qCaaiK0BxKo0SzAMyjmITxZl/q18PousqrSJVzMkk82C7d5tHuTkRlTn0jeoz
 pDhzFu4MFILN7n2eS50RX3KnBkMpDAWBwzGOL7vSskbg5nhJx6UvzWncwTkij+Zh2qGVAcOSCAw
 X2Dw7KnPT/GyVMZdB0sb4Vr7QPxKd8320FRphswPuh3VFYdtndzt9TkaYYTqBu3JAEfVDvlP1uL
 Ueq+cN6HvoLqdalae+tA5QswEhtn2hNBcNY0GU1SA2PCUIYSw1E3nf/Rf7wZ/UarFzXJRy5z1fX
 kzWd2sObI8NI1W46kUv8PbW3BVH0cf95ZIBriPw9XGGvA==
X-Received: by 2002:a05:6000:2306:b0:434:32cc:6c86 with SMTP id
 ffacd0b85a97d-4356a039819mr372200f8f.14.1768503317773; 
 Thu, 15 Jan 2026 10:55:17 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/25] target/arm/ptw: make granule_protection_check usable
 without a cpu
Date: Thu, 15 Jan 2026 18:54:51 +0000
Message-ID: <20260115185508.786428-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

By removing cpu details and use a config struct, we can use the
same granule_protection_check with other devices, like SMMU.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251216000122.763264-3-pierrick.bouvier@linaro.org
[PMM: avoid local vars in middle of block]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 34 +++++++++++++++++++++++++++++
 target/arm/ptw.c | 57 ++++++++++++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 992dff41c3..2f124d1b15 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1216,6 +1216,40 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
+
+typedef struct ARMGranuleProtectionConfig {
+    /* GPCCR_EL3 */
+    uint64_t gpccr;
+    /* GPTBR_EL3 */
+    uint64_t gptbr;
+    /* ID_AA64MMFR0_EL1.PARange */
+    uint8_t parange;
+    /* FEAT_SEL2 */
+    bool support_sel2;
+    /* Address space to access Granule Protection Table */
+    AddressSpace *gpt_as;
+} ARMGranuleProtectionConfig;
+
+/**
+ * arm_granule_protection_check
+ * @config: granule protection configuration
+ * @paddress: address accessed
+ * @pspace: physical address space accessed
+ * @ss: security state for access
+ * @fi: fault information in case a fault is detected
+ *
+ * Checks if @paddress can be accessed in physical adress space @pspace
+ * for @ss secure state, following granule protection setup with @config.
+ * If a fault is detected, @fi is set accordingly.
+ * See GranuleProtectionCheck() in A-profile manual.
+ *
+ * Returns: true if access is authorized, else false.
+ */
+bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
+                                  uint64_t paddress,
+                                  ARMSecuritySpace pspace,
+                                  ARMSecuritySpace ss,
+                                  ARMMMUFaultInfo *fi);
 #endif /* !CONFIG_USER_ONLY */
 
 int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e6b149b2d..a986dc66f6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -330,26 +330,26 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
     return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
 }
 
-static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
-                                     ARMSecuritySpace pspace,
-                                     ARMSecuritySpace ss,
-                                     ARMMMUFaultInfo *fi)
+bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
+                                  uint64_t paddress,
+                                  ARMSecuritySpace pspace,
+                                  ARMSecuritySpace ss,
+                                  ARMMMUFaultInfo *fi)
 {
     MemTxAttrs attrs = {
         .secure = true,
         .space = ARMSS_Root,
     };
-    ARMCPU *cpu = env_archcpu(env);
-    uint64_t gpccr = env->cp15.gpccr_el3;
+    const uint64_t gpccr = config.gpccr;
     unsigned pps, pgs, l0gptsz, level = 0;
     uint64_t tableaddr, pps_mask, align, entry, index;
-    AddressSpace *as;
     MemTxResult result;
     int gpi;
 
-    if (!FIELD_EX64(gpccr, GPCCR, GPC)) {
-        return true;
-    }
+    /*
+     * We assume Granule Protection Check is enabled when
+     * calling this function (GPCCR.GPC == 1).
+     */
 
     /*
      * GPC Priority 1 (R_GMGRR):
@@ -362,7 +362,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
      * physical address size is invalid.
      */
     pps = FIELD_EX64(gpccr, GPCCR, PPS);
-    if (pps > FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE)) {
+    if (pps > config.parange) {
         goto fault_walk;
     }
     pps = pamax_map[pps];
@@ -432,7 +432,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
     }
 
     /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
-    tableaddr = env->cp15.gptbr_el3 << 12;
+    tableaddr = config.gptbr << 12;
     if (tableaddr & ~pps_mask) {
         goto fault_size;
     }
@@ -446,12 +446,10 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
     align = MAKE_64BIT_MASK(0, align);
     tableaddr &= ~align;
 
-    as = arm_addressspace(env_cpu(env), attrs);
-
     /* Level 0 lookup. */
     index = extract64(paddress, l0gptsz, pps - l0gptsz);
     tableaddr += index * 8;
-    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
+    entry = address_space_ldq_le(config.gpt_as, tableaddr, attrs, &result);
     if (result != MEMTX_OK) {
         goto fault_eabt;
     }
@@ -479,7 +477,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
     level = 1;
     index = extract64(paddress, pgs + 4, l0gptsz - pgs - 4);
     tableaddr += index * 8;
-    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
+    entry = address_space_ldq_le(config.gpt_as, tableaddr, attrs, &result);
     if (result != MEMTX_OK) {
         goto fault_eabt;
     }
@@ -513,7 +511,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
     case 0b1111: /* all access */
         return true;
     case 0b1000: /* secure */
-        if (!cpu_isar_feature(aa64_sel2, cpu)) {
+        if (!config.support_sel2) {
             goto fault_walk;
         }
         /* fall through */
@@ -3786,11 +3784,28 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                             memop, result, fi)) {
         return true;
     }
-    if (!granule_protection_check(env, result->f.phys_addr,
-                                  result->f.attrs.space, ptw->in_space, fi)) {
-        fi->type = ARMFault_GPCFOnOutput;
-        return true;
+
+    if (FIELD_EX64(env->cp15.gpccr_el3, GPCCR, GPC)) {
+        ARMCPU *cpu = env_archcpu(env);
+        MemTxAttrs attrs = {
+            .secure = true,
+            .space = ARMSS_Root,
+        };
+        struct ARMGranuleProtectionConfig config = {
+            .gpccr = env->cp15.gpccr_el3,
+            .gptbr = env->cp15.gptbr_el3,
+            .parange = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE),
+            .support_sel2 = cpu_isar_feature(aa64_sel2, cpu),
+            .gpt_as = arm_addressspace(env_cpu(env), attrs)
+        };
+        if (!arm_granule_protection_check(config, result->f.phys_addr,
+                                          result->f.attrs.space, ptw->in_space,
+                                          fi)) {
+            fi->type = ARMFault_GPCFOnOutput;
+            return true;
+        }
     }
+
     return false;
 }
 
-- 
2.47.3


