Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD3606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xmegSw0k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDx-0005BU-KM; Mon, 02 Nov 2026 08:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD4-0003K2-48
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD1-0002In-Vd
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:25 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2886937f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626582; x=1794231382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kcRensL1RkuJS8+eT/j59lsZ0tYoTAPZBF/p+L4Um4U=;
 b=xmegSw0kRAcOaxabO78LkINpIjKQCKDf0fHFF+8PEB6AsqYrLGvkwiyy2ZUlNa9K/4
 FDcj0RYIvUxfivzWW7KmXlCr/chi6jxgiTx75kdX96g+LheNq3a9CBlCf0AZRFPm/aCv
 JfVwh5uYezGrPX3UjN2zjg4NCH+y/zpp2Dzv0KUe0MivyjzWwpC8s852r4R+2ro96X7o
 //b3ePys6Y0XSbiINzFiN2gSgvNUPH8brfUKPTH/EyQARkpj2gHlWzu9cQT2JGMqnyZT
 KxFMWwrU6wYKd1maaFuvwJc6jnnr4cpVNWHzAOf+Sppovm5/LFV3mB/Tx5kgFNr2RUaS
 DYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626582; x=1794231382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kcRensL1RkuJS8+eT/j59lsZ0tYoTAPZBF/p+L4Um4U=;
 b=oMmsBgDcJodqbw8SGzqTZPQh9hZwydXxV7p7jwN/94z4e7JlXs12R3kM/dnw6LJyTv
 BCATkv8lnPhJ5sv0hova+XpvhSdFi1tSSYemmUPdVCFLWDAZ9IxwtHIC+BJRX3ODSiwj
 UjZNDaTmsLA2oh7FaMIr3fbUkulkmhT6RtNBj0wKM7hi+EWVkZVtQd+ZuOR67EP1uZtu
 frOoLTgODFVrZuga2iH/DxmEoqaX0vuuMyjz+yZMnY1vtMD12vGW7D2+bWhqg5cW+axP
 qJ+sr1ci1lY9WsVntBIxThjTIdoBkv7jDVpo/9I5z/FuJNAu3SYkbyb6zKVtP6i8MDv8
 K7dQ==
X-Gm-Message-State: APuU4Z+HAY+4Ptm1LNx11IPx3aqkRhxrNu0ASoudd7U8UQKJnbsoFmFI
 eOoql9ZUFswYTQ0LIZgjrhrEtFLuwBS4R9SQ8YM47J/nB28c3n/lDBw52t0Up8zFPVgojdgKy9q
 ajaBOjZQ=
X-Gm-Gg: AYBFou3GtfGWLeE7vIj5U0fgmO3YyyOq4HhMyj4CRhozQUWig17/cDghJNZ0siAT5Oc
 /QAgZsAtEBvTsQxiXX1SpubgTTB2NW1zSI8w/bRzuFaTUr48UQCtow2fTyKzSk/r+qCHD8shGkv
 2BLzZmg3iP17KgB4WRtY2bo3kSU7xuS/hb/RWxqcB/C/ED2FCog1tEoRRi/PwETHD0T2Ywx9EpB
 zZZN1ORFFcNY9ro19i4Axj0oleWBiXIrhyqbCoehsZTuPuCfuV3yBEpBRWgwqypH6/wfXoL3Jtp
 8BXX7N8Wy1CfeHrNEcy8TIaJaPxPtXwyzrr8qa2jdBKJwUj5vn0/AlomCzgPhNi81pmLplh3NvD
 yCh17Fwbvx7/Nz8pQtD7ZqwV9qV8+g6YB94VMJSBwvFjmpFjeNJacqQy5D2MwmksgEjixdBIlH8
 /elPHMB2d4vNUUC46mImIrIaay/Xs8Pg8klKfRDOxQxUbru0X0nmShLkmLEB7CqQsGDCJC+kqTe
 r6bDsJniT0OCFyAjSAhUKovD6cuFHDb8YEp2YblK7kXmP9OSuL1MFjFD8QyYJNMuGZi1+P0rmOc
 38CHlcv7I3jJ4AV80suBA/X+IJJVsDeVAi4xZ2U02lRxTmcpyNarH/sSu7UwUtTiCa0u/C+ejuQ
 dfdbdRnb25Sv0pbBIl9x9e0RoqOPkL0oXlQ==
X-Received: by 2002:a05:6000:1a86:b0:488:5af8:eabc with SMTP id
 ffacd0b85a97d-48e6e2ef7bbmr24386072f8f.26.1793626582438; 
 Mon, 02 Nov 2026 05:36:22 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/47] target/arm: Enforce MPIDR into isar.idregs[] storage
Date: Mon,  2 Nov 2026 13:35:29 +0000
Message-ID: <20261102133547.1375701-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

At the moment MPIDR_EL1 has no real storage. Instead cpu
mp_affinity field stores the Aff0-Aff2 bits only and the
ID register is reconstructed when needed. There is also
an mp-affinity property used for TCG only.

Keep the mp-affinity property and its associated storage
while making sure the MPIDR_EL1 full register is stored
in cpu->isar.idregs[] as other ID registers.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Message-id: 20261030131406.461599-5-eric.auger@redhat.com
Suggested-by: Khushit Shah <khushit.shah@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  8 +++++++-
 target/arm/cpu-sysregs.h.inc |  1 +
 target/arm/cpu.c             | 17 +++++++++++++++++
 target/arm/helper.c          | 14 +-------------
 target/arm/hvf/hvf.c         |  2 +-
 target/arm/kvm.c             |  1 +
 target/arm/whpx/whpx-all.c   |  2 +-
 7 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e6b40001279..5c5f551dacb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1130,7 +1130,13 @@ struct ArchCPU {
     uint32_t reset_sctlr;
     uint64_t pmceid0;
     uint64_t pmceid1;
-    uint64_t mp_affinity; /* MP ID without feature bits */
+    /*
+     * MP ID without feature bits, ie. Aff0..Aff3 only
+     * used to store the corresponding property value for TCG vcpus.
+     * The MPIDR_EL1 value (affinity + feature bits) is stored in a
+     * consistent manner in isar.idregs[MPIDR_EL1_IDX].
+     */
+    uint64_t mp_affinity;
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 709dc8fc97e..f148f6f5659 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -42,6 +42,7 @@ DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(MIDR_EL1, 3, 0, 0, 0, 0)
+DEF(MPIDR_EL1, 3, 0, 0, 0, 5)
 DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
 DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
 DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5c8a11f482f..b9e4734de8d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2174,6 +2174,23 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  ARM_DEFAULT_CPUS_PER_CLUSTER);
     }
 
+    /* Consistently update MPIDR_EL1 in isar.idregs[] by adding feature bits */
+    {
+        uint64_t mpidr = cpu->mp_affinity;
+
+        if (arm_feature(env, ARM_FEATURE_V7MP)) {
+            mpidr |= (1U << 31);
+            /*
+             * Uniprocessor (non-coherent) cores that still implement the MP
+             * extensions set U (bit 30), e.g. Cortex-R5.
+             */
+            if (cpu->mp_is_up) {
+                mpidr |= (1u << 30);
+            }
+        }
+        SET_IDREG(&cpu->isar, MPIDR, mpidr);
+    }
+
     if (cpu->reset_hivecs) {
             cpu->reset_sctlr |= (1 << 13);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index afaac33f2ad..f413b15eb74 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3180,20 +3180,8 @@ static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t mpidr_read_val(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t mpidr = cpu->mp_affinity;
 
-    if (arm_feature(env, ARM_FEATURE_V7MP)) {
-        mpidr |= (1U << 31);
-        /*
-         * Cores which are uniprocessor (non-coherent)
-         * but still implement the MP extensions set
-         * bit 30. (For instance, Cortex-R5).
-         */
-        if (cpu->mp_is_up) {
-            mpidr |= (1u << 30);
-        }
-    }
-    return mpidr;
+    return GET_IDREG(&cpu->isar, MPIDR);
 }
 
 static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 51fe4d43720..40b7febceb9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1502,7 +1502,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     assert_hvf_ok(ret);
 
     ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MPIDR_EL1,
-                              arm_cpu->mp_affinity);
+                              GET_IDREG(&arm_cpu->isar, MPIDR));
     assert_hvf_ok(ret);
 
     pfr = GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index de09d63d2e3..724bc08edfe 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2103,6 +2103,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (ret) {
         return ret;
     }
+    SET_IDREG(&cpu->isar, MPIDR, mpidr);
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
     return kvm_arm_init_cpreg_list(cpu);
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 18009d6c8d6..024d18df046 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -842,7 +842,7 @@ int whpx_init_vcpu(CPUState *cpu)
 
     clean_whv_register_value(&val);
 
-    val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);
+    val.Reg64 = GET_IDREG(&arm_cpu->isar, MPIDR);
     whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
-- 
2.43.0


