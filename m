Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F853CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUes-00071P-Um; Tue, 29 Sep 2026 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUer-00070j-3U
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:57 -0400
Received: from mail-ed2-x27.google.com ([2a00:1450:4864:33::27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUen-00089R-HL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:56 -0400
Received: by mail-ed2-x27.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so6268041a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676111; x=1791280911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8Y0aJau/fEHa5bllo+Xmn6ulHxaJgB0GsALQc1dqaPw=;
 b=y/ocz2P5Ztl+G+/5axRpBBmceGKpGsSYsC/szN7MZdcZLpiUYp0YrubS4rEQjW4ITs
 M2PBCEdLK5gvu/ur/PjV4YpWISZJbyt5kOtxyjtNCjkkLDLK47IiGZcrQ6UVeuxCrkyV
 G0KBrGIyvVEYGwauZoCOAKMetle40xnzQlelo7K/vA8bd1qtwg02nvjcm7zle/t104a5
 08RxA9CIZq8yRlD5uhzoso+VcNzTU/uqBxWkyBi67l+UjZt9U3wtBkU5fbJ7eswkWXvN
 kiFFxL/Q41iunaea17IE6HtJCm6SoUnsoIhm6dncRxsc8y+Q37ulKOAS94m7Itg648VL
 0A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676111; x=1791280911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8Y0aJau/fEHa5bllo+Xmn6ulHxaJgB0GsALQc1dqaPw=;
 b=z5qsJuM8KcH4CwOhzSWhv1sSBdrGPe5VNX7I1zL3kUQrWFnbtMmk6Se/nRg+QV9FBE
 VJikUBsFPtmZRXWl5AOBwKdcEDHwnXpUWoEj/P8/NqWXBAxOruI0XyzD9VRWTrshVfUG
 ktr1ij0gf/5jEl0y8FfLgazhzjBcBLfaYsxzMmcZmdVMA2wFKxuegNhTCl6Dn7V1/qIM
 9Waju6FdC/fLE98cJgHmUPMQrUNsWiac8HzGHNyTGqIdbN2KGlDsP5Ele8nGjEH7QZJ0
 JmthX7RFVDLw0k4FfuPacjS4tE+payCeeiNDdDeyVhrzhnqYd3eaRyUNDAddwmxHdwcj
 xPtA==
X-Gm-Message-State: AFq9FYIINq/z6ym5uvpyPDjhrUJIX7GVKiWVNx58kGmJgSZOa18T1QcX
 LtLQkzGR4R6nKwYYaKFO/Kw/eC7bTfriEzB2TO5/+Okt+b7RH//UCS3i2MhCMtyeIS8qOe9ho50
 2XQ6y
X-Gm-Gg: AYBFou2sTD5ZmZpFkyHenryLY+5fCefsRAHU0uAglCbJk/Q++gkTohXefBr62zW2ioz
 DiNjNuGvLHkUsxQQEfWQxot3kKnyF0IRkg3zE8C27z7cppT75y4v932jVhVRsnDbDxfqMvmRPVn
 6/6UbvusiEQC2x5xFJMqM4jitwRKbK6+P0jVxf7GztMwFoaJK1LNXr95NHcqTP48Fze4QakouLK
 h7Zf3tRFH7intriO6EQUhG1q2Afzo9fbp7LotFJjJLft9Rq99clltn4gMB6niiaSLqEr0TDxnwi
 ITyttsY4W8X/4416oE6hfcX56cw1Q9avQXcIiJCHlUlnSZcksBIxdvKb5kDm3Hol5ntFde9Xb8h
 DEt4Bv5jUIlKO3xcYxn0bfoY6+3Nvd9uTwh9GovEl7VSqat2J+mm6IakyIi0kZ1gB//2czZVkZO
 UM24F5tj19RUiGJCBBRJQ7+BuvnKb/oz4ldaBTJXzEdXxQoBeq9I+iL+voZemtQ0V/fZO+E29c5
 Y/Dts3skG2UOVEqMLxGUkRlLMiz+sKMfPcaGwdgysLnf6boggJ+ObARV422v1gUSR62x5eAc+SC
 sgeF
X-Received: by 2002:a05:6402:c212:b0:6aa:e589:87de with SMTP id
 4fb4d7f45d1cf-6aae5898986mr6805289a12.20.1790676110623; 
 Tue, 29 Sep 2026 03:01:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/37] arm: handle CCSIDR_EL1 as a demuxed register
Date: Tue, 29 Sep 2026 11:01:05 +0100
Message-ID: <20260929100133.2598676-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:33::27;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed2-x27.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Move handling of CCSIDR_EL1 over to the new *_IDREG_DEMUX
infrastructure.

Note: the existing size of 16 is kept and might be extended
at a later time.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Message-id: 20260916165117.39764-3-sebott@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c                | 19 ++++------
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-max.c         |  6 ++--
 target/arm/cpu-sysregs.h.inc |  1 +
 target/arm/cpu.h             | 12 +++----
 target/arm/cpu64.c           |  6 ++--
 target/arm/helper.c          |  2 +-
 target/arm/tcg/cpu32.c       | 26 +++++++-------
 target/arm/tcg/cpu64.c       | 68 ++++++++++++++++++------------------
 9 files changed, 69 insertions(+), 73 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..bdac33a1de8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -306,24 +306,19 @@ void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type,
     int bank_index = ((cache_level - 1) * 2) | is_i_cache0;
     ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
     bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
+    uint64_t ccsidr = GET_IDREG_DEMUX(&armcpu->isar, CCSIDR_EL1, bank_index);
 
     if (ccidx) {
         *cpu_cache = (CPUCoreCaches){
-            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                         CCIDX_LINESIZE) + 4),
-            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                        CCIDX_ASSOCIATIVITY) + 1,
-            .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                               CCIDX_NUMSETS) + 1,
+            .linesize = 1 << (FIELD_EX64(ccsidr, CCSIDR_EL1, CCIDX_LINESIZE) + 4),
+            .associativity = FIELD_EX64(ccsidr, CCSIDR_EL1, CCIDX_ASSOCIATIVITY) + 1,
+            .sets = FIELD_EX64(ccsidr, CCSIDR_EL1, CCIDX_NUMSETS) + 1,
         };
     } else {
         *cpu_cache = (CPUCoreCaches){
-            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                         LINESIZE) + 4),
-            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                        ASSOCIATIVITY) + 1,
-            .sets =
-                FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1, NUMSETS) + 1,
+            .linesize = 1 << (FIELD_EX64(ccsidr, CCSIDR_EL1, LINESIZE) + 4),
+            .associativity = FIELD_EX64(ccsidr, CCSIDR_EL1, ASSOCIATIVITY) + 1,
+            .sets = FIELD_EX64(ccsidr, CCSIDR_EL1, NUMSETS) + 1,
         };
     }
     cpu_cache->type = cache_type;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 4136c91f235..6bc392b0e33 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1360,7 +1360,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd80: /* CSSIDR */
     {
         int idx = cpu->env.v7m.csselr[attrs.secure] & R_V7M_CSSELR_INDEX_MASK;
-        return cpu->ccsidr[idx];
+        return GET_IDREG_DEMUX(&cpu->isar, CCSIDR_EL1, idx);
     }
     case 0xd84: /* CSSELR */
         return cpu->env.v7m.csselr[attrs.secure];
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 739500a04fc..2ed1cfef9be 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -71,11 +71,11 @@ void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 48KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2));
     /* 2048KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7));
     if (aarch64_enabled) {
         set_dczid_bs(cpu, 4); /* 64 bytes */
         cpu->gic_num_lrs = 4;
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 6e8b335b8f6..d9e058a57e5 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -39,6 +39,7 @@ DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
 DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
 DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
+DEF_MUX(CCSIDR_EL1, 3, 1, 0, 0, 0, 16)
 DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
 DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF(CTR_EL0, 3, 3, 0, 0, 1)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6d1bad1dfc6..5c8ea5a7ed2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1106,6 +1106,12 @@ struct ArchCPU {
      * kvm_arm_get_host_cpu_features() function to correctly populate the
      * field by reading the value from the KVM vCPU. If it is an AArch64
      * ID register then you also must update arm_clear_aarch64_idregs().
+     *
+     * The multiplexed register CCSIDR is handled as part of idregs[] -
+     * these contain values for each cache, in the order L1DCache, L1ICache,
+     * L2DCache, L2ICache, etc. Currently only 16 indexes into CCSIDR are
+     * supported because we don't implement separate MTE Allocation Tag caches.
+     * See {G,S}ET_IDREG_DEMUX() accessors.
      */
     struct ARMISARegisters {
         uint32_t mvfr0;
@@ -1125,10 +1131,6 @@ struct ArchCPU {
     uint64_t pmceid0;
     uint64_t pmceid1;
     uint64_t mp_affinity; /* MP ID without feature bits */
-    /* The elements of this array are the CCSIDR values for each cache,
-     * in the order L1DCache, L1ICache, L2DCache, L2ICache, etc.
-     */
-    uint64_t ccsidr[16];
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
@@ -2142,8 +2144,6 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
-QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
-
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c11ab2da210..dcd0d698b30 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -749,11 +749,11 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.reset_pmcr_el0 = 0x41033000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 32KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2));
     /* 1024KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7));
     set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3f607e6d6b..a608df12111 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -925,7 +925,7 @@ static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint32_t index = A32_BANKED_REG_GET(env, csselr,
                                         ri->secure & ARM_CP_SECSTATE_S);
 
-    return cpu->ccsidr[index];
+    return GET_IDREG_DEMUX(&cpu->isar, CCSIDR_EL1, index);
 }
 
 static void csselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 1999e502904..f95051458df 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -278,9 +278,9 @@ static void cortex_a8_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x15141000;
     SET_IDREG(isar, CLIDR, (1 << 27) | (2 << 24) | 3);
-    cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
-    cpu->ccsidr[1] = 0x2007e01a; /* 16k L1 icache. */
-    cpu->ccsidr[2] = 0xf0000000; /* No L2 icache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0xe007e01a); /* 16k L1 dcache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x2007e01a); /* 16k L1 icache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, 0xf0000000); /* No L2 icache. */
     cpu->reset_auxcr = 2;
     cpu->isar.reset_pmcr_el0 = 0x41002000;
     define_arm_cp_regs(cpu, cortexa8_cp_reginfo);
@@ -356,8 +356,8 @@ static void cortex_a9_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x35141000;
     SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 3);
-    cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
-    cpu->ccsidr[1] = 0x200fe019; /* 16k L1 icache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0xe00fe019); /* 16k L1 dcache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x200fe019); /* 16k L1 icache. */
     cpu->isar.reset_pmcr_el0 = 0x41093000;
     define_arm_cp_regs(cpu, cortexa9_cp_reginfo);
 }
@@ -430,9 +430,9 @@ static void cortex_a7_initfn(Object *obj)
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x1;
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
-    cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0x701fe00a); /* 32K L1 dcache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x201fe00a); /* 32K L1 icache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, 0x711fe07a); /* 4096K L2 unified cache */
     cpu->isar.reset_pmcr_el0 = 0x41072000;
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo); /* Same as A15 */
 }
@@ -479,9 +479,9 @@ static void cortex_a15_initfn(Object *obj)
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x0;
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
-    cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0x701fe00a); /* 32K L1 dcache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x201fe00a); /* 32K L1 icache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, 0x711fe07a); /* 4096K L2 unified cache */
     cpu->isar.reset_pmcr_el0 = 0x410F3000;
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
 }
@@ -671,8 +671,8 @@ static void cortex_r52_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR5, 0x00010001);
     cpu->isar.dbgdidr = 0x77168000;
     SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 0x3);
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0x700fe01a); /* 32KB L1 dcache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x201fe00a); /* 32KB L1 icache */
 
     cpu->pmsav7_dregion = 16;
     cpu->pmsav8r_hdregion = 16;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index affd87a3ae5..e156baf35d2 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -83,11 +83,11 @@ static void aarch64_a35_initfn(Object *obj)
 
     /* From B2.29 Cache ID registers */
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 32KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7));
 
     /* From B3.5 VGIC Type register */
     cpu->gic_num_lrs = 4;
@@ -252,11 +252,11 @@ static void aarch64_a55_initfn(Object *obj)
 
     /* From B2.23 CCSIDR_EL1 */
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 32KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7));
 
     /* From B2.96 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -323,11 +323,11 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.reset_pmcr_el0 = 0x41023000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 48KB L1 dcache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2));
     /* 1MB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7));
     set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -387,11 +387,11 @@ static void aarch64_a76_initfn(Object *obj)
 
     /* From B2.18 CCSIDR_EL1 */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7));
 
     /* From B2.93 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -460,11 +460,11 @@ static void aarch64_a78ae_initfn(Object *obj)
 
     /* From 3.2.33 CCSIDR_EL1 */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7));
 
     /* From 3.2.118 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -518,11 +518,11 @@ static void aarch64_a64fx_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
     SET_IDREG(isar, CLIDR, 0x0000000080000023);
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2));
     /* 8MB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7));
     set_dczid_bs(cpu, 6); /* 256 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -711,11 +711,11 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
 
     /* From B2.23 CCSIDR_EL1 */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 1MB L2 dcache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7));
 
     /* From B2.98 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -800,11 +800,11 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
      * L3: No L3 (this matches the CLIDR_EL1 value).
      */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* 1MB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 1 * MiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 1 * MiB, 0));
 
     /* From 3.2.115 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -1043,11 +1043,11 @@ static void aarch64_a710_initfn(Object *obj)
      * L2: 8-way set associative 64 byte line size, total either 256K or 512K.
      */
     /* L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L1 icache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0));
 
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
@@ -1146,11 +1146,11 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
      * L2: 8-way set associative 64 byte line size, total either 512K or 1024K.
      */
     /* L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L1 icache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0));
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
 
@@ -1180,13 +1180,13 @@ void aarch64_max_v8_tcg_initfn(Object *obj)
 
     SET_IDREG(isar, CLIDR, 0x8200123);
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 1MB L2 unified cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7));
     /* 2MB L3 unified cache */
-    cpu->ccsidr[4] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 4, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7));
 
     /*
      * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
-- 
2.43.0


