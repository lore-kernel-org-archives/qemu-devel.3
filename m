Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988C6CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpA-0006BV-S7; Fri, 10 Oct 2025 09:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cor-00067j-DM
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Coa-0003mG-Oi
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso2101311f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101540; x=1760706340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jQndNdeetcNr/PbsPypNqg0wlm459zWbpBdE5jQZ1zE=;
 b=b1pMVGMgvgPPgGr5e0g6hjEfovrj3kTCPWwh8G8KX5vgoo70XfKP3W8KK4hSRZOdTg
 7RIBsTf/2t9dsxKEStloZW+O0GZl56KJtjYk5c0//QuUZir6mylPjYBvz2JXhtQh36kx
 nMY/clP4GkcbSkZwaoRHmA/SzRvls7LM3jF5AGs6I8CnYQt7jqaZmLSiwlt2i23YGm3F
 eZKiNjP9pDcWIilu+NZFBGsJa82SW2ZwFNO6vD4pw6yxDyrg2NVF/RSP+QBPjI4BREuC
 Ldv5Xp3yF7VOa5nBQhaHe1x52/CO+8moMbzvGHgp50TNfRKbmaFpmZkOfNOrI81X5zG4
 0b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101540; x=1760706340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jQndNdeetcNr/PbsPypNqg0wlm459zWbpBdE5jQZ1zE=;
 b=SYuqzqkJvz+C5Vt8Ne20JIaJJCRPa1OvsFfBU4aomVUts+WDq5keUdgLEvc5zNWWLp
 LPB+wWeA2cPr57ZgkWv0mmCtHC5rUHG8TBHc+ktnd1/9HAiiG9L7Wht9AV40Dd2oHive
 iidR51zSVWCAd+Ry7sGPbqqQ9b+cSW79+GUHq1z69w/T+KWhdUy1udCBD065vZ36Cy0B
 99TqET9KCWR4VMBZfrt9AHQIdUxPQcf3JPoLE4GOyGJxagazUJ3Z7StutWaGQmCAhgm6
 LCuNhmMOzebz0bvsR+p53NAIKPi8vnwkAi/FrGDOTqghJZJkDsnJ6DLzHlOdi8GpqN9F
 jO9g==
X-Gm-Message-State: AOJu0YxSpZA5MNMsLLUyJeJt/ec7uA1x7tmATlgKBEgEpO03CIYUFZHv
 p4Ac1802Hzl48gkwIHREoshatYHrN2eCT8D7o4faGa2frw+GtJFKyZWTV9trlXLUEu125LPF/DR
 idffZ
X-Gm-Gg: ASbGnctjKXTSJrZFO87jRdSj/PFFSuHhYOJ+qARtmKs795DRxXBdEeduQQNKZQ0Q3GM
 vvpQl/Zok0bd1AZnfMhEsP6t3DFpq5y5ddhewlZWFGYqvn0ZCOFSMXcNIcPH24Z4gV5tfcgmU4t
 ywJkY80JgMC1JMNmxW0ii/T4vUTAzrsClWILXfanE0RoNe7wLEWfC4D0H2D1csrDgqPjXbWJZ6D
 D+CyYxBQRNYwiULR5y+HBpvHbZMPKuyxdd80qG03EBYvk0+NrGw/Fu/kSTRi3JFiY7zoDpzPN2f
 ac+PTZqXfZODhAH/srTPJNhERztv5U14zp245RZlTkQcL64B6W2hPYv3FYFP6gYc3qybsOhlVZQ
 ZhtbW5WSIuIxjEkVnhWC02pJUSywbYBSFQuscNqCGWzNdBwNX2/s9+xtLc+kUWQ==
X-Google-Smtp-Source: AGHT+IGAJYWTb5Tw7g5zhZmcQJBx0P6+9/Aj55au6nuq4swoCvWQqrWUHGaZkDYtPuJjnoL54TP15Q==
X-Received: by 2002:a5d:5d88:0:b0:3eb:dcf:bfad with SMTP id
 ffacd0b85a97d-4266e7e17c7mr6626858f8f.34.1760101539842; 
 Fri, 10 Oct 2025 06:05:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/76] target/arm: Implement get_S2prot_indirect
Date: Fri, 10 Oct 2025 14:04:20 +0100
Message-ID: <20251010130527.3921602-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the stage2 permissions for normal accesses to
GetPhysAddrResult.s2prot.  Put the stage2 permissions
for page table walking in CPUTLBEntryFull.prot.
This allows the permission checks in S1_ptw_translate
and arm_casq_ptw to see the right permission.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  7 ++++
 target/arm/ptw.c       | 81 +++++++++++++++++++++++++++++++-----------
 2 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index face1019f52..22947c4b78a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1577,6 +1577,13 @@ typedef struct ARMCacheAttrs {
 typedef struct GetPhysAddrResult {
     CPUTLBEntryFull f;
     ARMCacheAttrs cacheattrs;
+    /*
+     * For ARMMMUIdx_Stage2*, the protection installed into f.prot
+     * is the result for AccessType_TTW, i.e. the page table walk itself.
+     * The protection installed info s2prot is the one to be merged
+     * with the stage1 protection.
+     */
+    int s2prot;
 } GetPhysAddrResult;
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 59135560776..2e026a7c597 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1316,7 +1316,7 @@ do_fault:
  * @xn:      XN (execute-never) bits
  * @s1_is_el0: true if this is S2 of an S1+2 walk for EL0
  */
-static int get_S2prot_noexecute(int s2ap)
+static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
 {
     int prot = 0;
 
@@ -1326,12 +1326,6 @@ static int get_S2prot_noexecute(int s2ap)
     if (s2ap & 2) {
         prot |= PAGE_WRITE;
     }
-    return prot;
-}
-
-static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
-{
-    int prot = get_S2prot_noexecute(s2ap);
 
     if (cpu_isar_feature(any_tts2uxn, env_archcpu(env))) {
         switch (xn) {
@@ -1363,6 +1357,44 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
     return prot;
 }
 
+static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
+                               int pi_index, int po_index, bool s1_is_el0)
+{
+    /* Last index is (priv, unpriv, ttw) */
+    static const uint8_t perm_table[16][3] = {
+        /* 0 */ { 0, 0, 0 },   /* no access */
+        /* 1 */ { 0, 0, 0 },   /* reserved */
+        /* 2 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 3 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 4 */ { PAGE_WRITE, PAGE_WRITE, 0 },
+        /* 5 */ { 0, 0, 0 },   /* reserved */
+        /* 6 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 7 */ { PAGE_READ, PAGE_READ, PAGE_READ | PAGE_WRITE },
+        /* 8 */ { PAGE_READ, PAGE_READ, PAGE_READ },
+        /* 9 */ { PAGE_READ, PAGE_READ | PAGE_EXEC, PAGE_READ },
+        /* A */ { PAGE_READ | PAGE_EXEC, PAGE_READ, PAGE_READ },
+        /* B */ { PAGE_READ | PAGE_EXEC, PAGE_READ | PAGE_EXEC, PAGE_READ },
+        /* C */ { PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE },
+        /* D */ { PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE },
+        /* E */ { PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE,
+                  PAGE_READ | PAGE_WRITE },
+        /* F */ { PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+                  PAGE_READ | PAGE_WRITE },
+    };
+
+    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
+    int s2pi = extract64(pir, pi_index * 4, 4);
+
+    result->f.prot = perm_table[s2pi][2];
+    return perm_table[s2pi][s1_is_el0];
+}
+
 /*
  * Translate section/page access permissions to protection flags
  * @env:     CPUARMState
@@ -1813,7 +1845,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int32_t stride;
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    int ap;
+    int ap, prot;
     uint32_t el = regime_el(env, mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
@@ -2137,6 +2169,18 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     ap = extract32(attrs, 6, 2);
     out_space = ptw->cur_space;
     if (regime_is_stage2(mmu_idx)) {
+        if (param.pie) {
+            int pi = extract64(attrs, 6, 1)
+                   | (extract64(attrs, 51, 1) << 1)
+                   | (extract64(attrs, 53, 2) << 2);
+            int po = extract64(attrs, 60, 3);
+            prot = get_S2prot_indirect(env, result, pi, po, ptw->in_s1_is_el0);
+        } else {
+            int xn = extract64(attrs, 53, 2);
+            prot = get_S2prot(env, ap, xn, ptw->in_s1_is_el0);
+            /* Install TTW permissions in f.prot. */
+            result->f.prot = prot & (PAGE_READ | PAGE_WRITE);
+        }
         /*
          * R_GYNXY: For stage2 in Realm security state, bit 55 is NS.
          * The bit remains ignored for other security states.
@@ -2145,11 +2189,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
          */
         if (out_space == ARMSS_Realm && extract64(attrs, 55, 1)) {
             out_space = ARMSS_NonSecure;
-            result->f.prot = get_S2prot_noexecute(ap);
-        } else {
-            int xn = extract64(attrs, 53, 2);
-            result->f.prot = get_S2prot(env, ap, xn, ptw->in_s1_is_el0);
+            prot &= ~PAGE_EXEC;
         }
+        result->s2prot = prot;
 
         result->cacheattrs.is_s2_format = true;
         result->cacheattrs.attrs = extract32(attrs, 2, 4);
@@ -2221,9 +2263,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              * Note that we modified ptw->in_space earlier for NSTable, but
              * result->f.attrs retains a copy of the original security space.
              */
-            result->f.prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
-                                                 result->f.attrs.space,
-                                                 out_space);
+            prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
+                                       result->f.attrs.space, out_space);
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
@@ -2248,10 +2289,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
             user_rw = simple_ap_to_rw_prot_is_user(ap, true);
             prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
-            result->f.prot = get_S1prot(env, mmu_idx, aarch64,
-                                        user_rw, prot_rw, xn, pxn,
-                                        ptw->in_space, out_space);
+            prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw,
+                              xn, pxn, ptw->in_space, out_space);
         }
+        result->f.prot = prot;
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
@@ -2297,7 +2338,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         result->f.tlb_fill_flags = 0;
     }
 
-    if (ptw->in_prot_check & ~result->f.prot) {
+    if (ptw->in_prot_check & ~prot) {
         fi->type = ARMFault_Permission;
         goto do_fault;
     }
@@ -3495,7 +3536,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
-    result->f.prot &= s1_prot;
+    result->f.prot = s1_prot & result->s2prot;
 
     /* If S2 fails, return early.  */
     if (ret) {
-- 
2.43.0


