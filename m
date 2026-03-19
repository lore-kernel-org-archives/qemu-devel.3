Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4164E1088E63
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w335y-0003nx-TU; Wed, 18 Mar 2026 22:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335w-0003ld-Jz
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:44 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335u-0002tt-Mu
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:44 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79a5a37113aso6072637b3.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 19:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773887201; x=1774492001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKX5HsaUKSV7F7rfvCDr4RwTZHqLb66reFgdEeXZa+k=;
 b=iorfkBR+Yz6DpScu2zmxzjepd9WYszLjjWm1sbq6o0WDRPiyYndlW7QmuQ3aIPe0A8
 todA0pppwSOSIOSCwPiKdA1xJhfPYrwE4fgI0O0UuL9fxJNfNw9fP8WYADcCjVY+hSXt
 LFYMsU00LcnYLLeb7D3P1F8zSmTATAurgTirfOSLXJ7QFkw53uXSJNom0n2D0hfZecyz
 S3gU4BHVZcqTDNncnjoBBSCBzTnKVV2hup6FSluLXUX/YKnqkI7cfrv8eBfsVIHkzvXY
 xavu7N3RebeM9M0GBY0V69qt1HhawiIJlM+Hwpd+pMeU1/EdZb5ujfUeO+zi7Vq/kWXQ
 aB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887201; x=1774492001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KKX5HsaUKSV7F7rfvCDr4RwTZHqLb66reFgdEeXZa+k=;
 b=pDPg84EJv3ZRyVMDhf0NTH2IrkQtWmAK9W4U3d1z5A5Z7s9zLjSIBPY69XKu7DmKcZ
 AUVVsdnlOkUlV94D3ynrX0G7PcWmp2SJDZSDiE6BPc3Y0JPyKZdxEUqTNjAJPpR0uers
 TK4SBNLgzvmOqLgbPiBBu7RerFZsRvg6z041nK4IvGFx2ovUCjvLUn4PL4HQvXuNLTZ6
 VeZnqYfYx/Fcy0bueasCktFYQIiNAjsArodRWsq5F9IU4v04l3BJpXIXI2RKHFxMnWiG
 L/bPFTr2pgeHT/VP0PnBmo4xbhnDlAcMyAojJG/iDNUj58e6r7YlXNXnxneN/gyfCg2a
 mvxw==
X-Gm-Message-State: AOJu0YysAg7fzQvqC1oOjM3e4Ueeym/VCe4okvrOmTCeqTQvXk7Fu3ii
 qnmYc8fCjJqZIxh9wbhKcJsdY13ntwpS+loVuPI+eDfnlEPPF2HhyWH5xE9MV8hAqz81EJQqbD6
 Zle9jI6Q=
X-Gm-Gg: ATEYQzwPb57+nFqcwZhORcii3Y954r98mLsoXGnzRQ6ZKFwnMZ+y1689qzwODHQHRnk
 UUZFiW4VuP6TbtHEu15kCZVnaYaajVBHpERst5xLJeUBdJ6F/BJXMX2N55h1zxk/TeW1kpF7bw2
 lttUaD2L9xuRqNPd5HYm4WLFRAKw65WuCV1xHQ0kuk1qFMOJn6vvlBjviYZJCYiOIyIJdlkZhNT
 CRpZjJuovZWB59auAtjXJ1JmcoLYq2GFddZArFpnEnwC33bfOcktFM9GR/zzvSuLpHmpnSX1NHt
 Tamq6todAuukLvnfwBExAGZm5CfVsPGY+hI4T42VjdzQ64cvrvDy8rwyJNHhgZiPfst/YZXhlT+
 NfA1knbL6jVJtUGzIlea9fRsMk1P479zQIhOH4zLYY57QX6Vn2NIzuZpcFVmuvgwwyVvGywg2Ly
 teeLbhRKGvoDaDwano3tOA6bvJjZC2tg==
X-Received: by 2002:a05:690c:c50e:b0:79a:3a33:933 with SMTP id
 00721157ae682-79a71ad413dmr61068687b3.31.1773887201137; 
 Wed, 18 Mar 2026 19:26:41 -0700 (PDT)
Received: from gromero0.. ([177.146.137.168]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a7141eb65sm28159417b3.21.2026.03.18.19.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:26:40 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, gustavo.romero@linaro.org
Subject: [RFC PATCH 6/7] target/arm/ptw: Add MECID checks
Date: Wed, 18 Mar 2026 23:23:34 -0300
Message-Id: <20260319022335.22523-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319022335.22523-1-gustavo.romero@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add MECID checks. The MECID registers were introduced before and this
commit uses them to perform the proper MECID checks, which is part of
FEAT_MEC implementation.

On MECID mismatches (wrong MECID) we return a substitute encrypted page
instead of the real encrypted page, which doesn't hurt performance on
memory accesses and behaves like FEAT_MEC design on the physical
hardware.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/internals.h |   2 +
 target/arm/ptw.c       | 215 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8ec2750847..d668948949 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1473,6 +1473,8 @@ typedef struct GetPhysAddrResult {
      * with the stage1 protection.
      */
     int s2prot;
+    /* FEAT_MEC AMEC found in Block or Page descriptor. */
+    bool amec;
 } GetPhysAddrResult;
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8b8dc09e72..aacc32ba33 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2090,6 +2090,17 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         goto do_fault;
     }
 
+    /*
+     * XXX(gromero): Add checks for NS bit and AMEC0/1 bits, generating the due
+     * fault in case AMEC0/1 = 0 and AMEC bit is 1. So far we just get the AMEC
+     * bit directly in case of a Block or Page descriptor.
+     *
+     */
+    if (((level == 1 || level == 2) && (extract64(descriptor, 0, 2) == 1)) ||
+        level == 3) {
+        result->amec = extract64(descriptor, 63, 1);
+    }
+
     if ((descriptor & 2) && (level < 3)) {
         /*
          * Table entry. The top five bits are attributes which may
@@ -3766,6 +3777,208 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     }
 }
 
+static uint32_t *get_mecid_ptr(CPUARMState *env, hwaddr pa)
+{
+    MemoryRegion *mr;
+    AddressSpace *mec_as;
+    hwaddr mec_paddr, xlat;
+    MemTxAttrs memattrs = { 0x0 };
+
+    /* Find out the page number to use it as an offset in mec AS. */
+    mec_paddr = pa >> TARGET_PAGE_BITS;
+    mec_paddr *= 4; /* Assume MECID maximum size is 4 bytes. */
+    /* MECIDs are kept in their own Address Space. */
+    mec_as = cpu_get_address_space(env_cpu(env), ARMASIdx_MEC);
+    mr = address_space_translate(mec_as, mec_paddr, &xlat, NULL, true, memattrs);
+
+    /*
+     * Return pointer in the mec AS associated to physical address 'pa', which
+     * is used to store the MECID.
+     */
+    return memory_region_get_ram_ptr(mr) + xlat;
+}
+
+static uint32_t get_mecid(CPUARMState *env, hwaddr pa)
+{
+    return *get_mecid_ptr(env, pa);
+}
+
+static void set_mecid(CPUARMState *env, hwaddr pa, uint32_t mecid)
+{
+    *get_mecid_ptr(env, pa) = mecid;
+}
+
+/*
+ * Returns 'false' on MECID mismatch and 'true' on MECID match (success).
+ */
+static bool mecid_check(CPUARMState *env, S1Translate *ptw, hwaddr va,
+                        MMUAccessType access_type, GetPhysAddrResult *result,
+                        ARMMMUIdx s1_mmu_idx)
+{
+    ARMSecuritySpace ss = ptw->out_space;
+    /* Final physical address after translation. */
+    hwaddr pa = result->f.phys_addr;
+
+    switch (s1_mmu_idx) {
+    case ARMMMUIdx_Phys_S:
+    case ARMMMUIdx_Phys_NS:
+    case ARMMMUIdx_Phys_Root:
+    case ARMMMUIdx_Phys_Realm:
+    case ARMMMUIdx_Stage2:
+    case ARMMMUIdx_Stage2_S:
+    /* In the middle of a translation, so result->f.phys_addr has no PA yet. */
+        return true;
+        break;
+    default:
+        /* Pass */
+        break;
+    }
+
+    /* Find out which EL controls EMEC for Stage 1 translations. */
+    uint32_t el = regime_el(s1_mmu_idx) < 3 ? 2 : 3;
+
+    /* XXX(gromero): Do we need to check for SCR_EL3.SCTLR2En when el == 2? */
+    if (!(cpu_isar_feature(aa64_mec, env_archcpu(env)) &&
+        (env->cp15.sctlr2_el[el] & SCTLR2_EMEC))) {
+        /* FEAT_MEC is disabled. */
+        return true;
+    }
+
+    if (ss != ARMSS_Realm) {
+        /*
+         * GPT checks are already done, so if SS is Root here MECIDs are
+         * irrelevants for EL3 accesses. If SS is Secure or NonSecure that's not
+         * pertinent to FEAT_MEC. Hence, only proceed with MECID checks if SS is
+         * Realm.
+         */
+        return true;
+    }
+
+    bool amec = result->amec;
+    bool varange_lower = extract64(va, 55, 1) ? false : true;
+    /* MECID in register set given a translation regime. */
+    uint32_t mecid;
+
+    /* ARMMMUIdx after full ptw (all stages). */
+    ARMMMUIdx ptw_mmu_idx = ptw->in_mmu_idx;
+
+    switch (ptw_mmu_idx) {
+    case ARMMMUIdx_Stage2:
+    case ARMMMUIdx_Stage2_S:
+    /* In the middle of a two stage translation, so result->f.phys_addr has no PA yet. */
+        return true;
+        break;
+    default:
+        /* Pass */
+        break;
+    }
+
+    /*
+     * NB: No MECID is used for the ptw itself, i.e., used for the level
+     * lookups, so AArch64.S1TTWalkMECID() and AArch64.S2TTWalkMECID() are not
+     * relevant for our FEAT_MEC implementation.
+     */
+    bool is_pa_from_s2 = regime_is_stage2(ptw_mmu_idx);
+    bool is_mmu_disabled = regime_translation_disabled(env, ptw_mmu_idx, ss);
+    if (is_pa_from_s2) { /* PA from Stage 2. */
+        /* As per AArch64.S2OutputMECID(). */
+        mecid = amec ? env->cp15.vmecid_a_el2 : env->cp15.vmecid_p_el2;
+
+    } else { /* PA from Stage 1. */
+        if (is_mmu_disabled) { /* PA from Stage 1 and MMU is disabled. */
+            /* As per AArch64.S1DisabledOutputMECID(). */
+            switch (s1_mmu_idx) {
+            case ARMMMUIdx_E3:
+                /* MECID = 0 (default), so return without any check. */
+                return true;
+                break;
+            case ARMMMUIdx_E2:
+            case ARMMMUIdx_E20_0:
+            case ARMMMUIdx_E20_2:
+            case ARMMMUIdx_E20_2_PAN:
+                mecid = env->cp15.mecid_p0_el2;
+                break;
+            case ARMMMUIdx_E10_0:
+            case ARMMMUIdx_E10_1:
+                mecid = env->cp15.vmecid_p_el2;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+        } else { /* PA from Stage 1 and MMU is enabled. */
+            /* As per AArch64.S1OutputMECID(). */
+            switch (s1_mmu_idx) {
+            case ARMMMUIdx_E3:
+                mecid = env->cp15.mecid_rl_a_el3;
+                break;
+            case ARMMMUIdx_E2:
+                mecid = amec ? env->cp15.mecid_a0_el2 : env->cp15.mecid_p0_el2;
+                break;
+            case ARMMMUIdx_E20_0:
+            case ARMMMUIdx_E20_2:
+            case ARMMMUIdx_E20_2_PAN:
+                if (varange_lower) {
+                    mecid = amec ? env->cp15.mecid_a0_el2 : env->cp15.mecid_p0_el2;
+                } else {
+                    mecid = amec ? env->cp15.mecid_a1_el2 : env->cp15.mecid_p1_el2;
+                }
+                break;
+            case ARMMMUIdx_E10_0:
+            case ARMMMUIdx_E10_1:
+                mecid = env->cp15.vmecid_p_el2;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+    }
+
+    /*
+     * MECID is updated on data store and checked on other access types.
+     */
+    if (access_type == MMU_DATA_STORE) {
+       /* Store MECID for physical address 'pa'. */
+       set_mecid(env, pa, mecid);
+       return true;
+    } else {
+        uint32_t stored_mecid;
+        /* Load the MECID stored in memory for physical address 'pa'. */
+        stored_mecid = get_mecid(env, pa);
+        if (stored_mecid == mecid) {
+            /* MECID is correct. */
+            return true;
+        } else {
+            /* MECID is incorrect, so return the substitute encrypted page. */
+            result->f.phys_addr = 0x0; /* Start of the page. */
+            result->f.attrs.encrypted = true; /* Substitute encrypted page. */
+            return false;
+        }
+    }
+}
+
+static bool get_phys_addr_mec(CPUARMState *env, S1Translate *ptw,
+                              vaddr address,
+                              MMUAccessType access_type, MemOp memop,
+                              GetPhysAddrResult *result,
+                              ARMMMUFaultInfo *fi)
+
+{
+    /*
+     * After 'address' is resolved by get_phys_addr_nogpc(), ptw->in_mmu_idx can
+     * change depending on the translation stages, hence stash it.
+     */
+    ARMMMUIdx s1_mmu_idx = ptw->in_mmu_idx;
+
+    if (get_phys_addr_gpc(env, ptw, address, access_type, memop, result, fi)) {
+        return true; /* Translation fault. */
+    }
+    if (!mecid_check(env, ptw, address, access_type, result, s1_mmu_idx)) {
+        return true; /* MECID mismatch. */
+    }
+    return false;
+}
+
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
                               MMUAccessType access_type, MemOp memop,
@@ -3907,7 +4120,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         .in_prot_check = 1 << access_type,
     };
 
-    return get_phys_addr_gpc(env, &ptw, address, access_type,
+    return get_phys_addr_mec(env, &ptw, address, access_type,
                              memop, result, fi);
 }
 
-- 
2.34.1


