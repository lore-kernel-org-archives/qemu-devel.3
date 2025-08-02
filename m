Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414F0C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjU-0004W8-Ax; Sat, 02 Aug 2025 19:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhX-00085w-2Z
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:43 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhV-00054y-3b
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:31:42 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6199bd724e1so54940eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177499; x=1754782299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQJhsDPGVOwUxFmYhXztN3F3u/xGoBHah5fHPe9a1SU=;
 b=MWcj/yjv4I7Lbq1pAP6EG5ImOmSnAJcwmAEwNmWkvkHBEEbEHJeT78sCorFutZgXCh
 Hgaine5PcrHPey1eS0ZymFk77T3KUT+LN5NeChvwdBaCXul71K0DKxPdL0WpYyPG6Iin
 ZIvxnZyDmwEKoSi+l3VbF+mqNahdE5xsy9aBJNLTnF6KwZ8s24unVeiauHFgs0S5Ysco
 DH1BXOqX9SS8yso6nPLZyC01PVZ/1CyIB7OrijceioJmEfTdOuWDl08jevkH7KG8d0lU
 P3cC49+HK2QsQQV9CBAJFP8sWGkzK3osRyr/iugE065fbX392aOonruPBgjkAKw6NUM3
 pE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177499; x=1754782299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQJhsDPGVOwUxFmYhXztN3F3u/xGoBHah5fHPe9a1SU=;
 b=jGK2XhAPoqBGz5v8jxoaIrjLaqMQXmZ9Jh6u+IuTVBbTJhaJuvtlBqy40/H/iVPxDQ
 87NDNi6KH4vIK4lw93UAMkOfzzcrnW+Y908RkWp3Flpzsgiza21ubGrmSwwtRYnfNnPf
 hgl/O2d6ouY/DHg/NS1usDFwBPf/0Jk2qXzNoc51XUZEmixIsBOpji4wbFNjxUjjHk0u
 hHY6Ou426Q2AuDplvKKsdUbbJKAtP/WbV+l7QqceqHnlZSLM+dOn8GN8U1jtoIKadLcA
 oEzsLlLa+A0aCJAYnn7/XGCKU0opWBbxITTpN41nvinQWmMDLvfA3aiogIu75S8GgOIE
 U44Q==
X-Gm-Message-State: AOJu0YxCr0J2Ww1xpvB60yer29aV3BvrEmJvSVVQqt7Vx+3PaAjq3OFv
 DihfXYX4vAVwgvLZmuQTvipTQ3jH/U7j4+l5Vp4/zYA3xMBzrqSIzuN7UtuyIi+ZBElt50GFX/R
 wA1zRPOQ=
X-Gm-Gg: ASbGnctn+cJ1gXzK9OPRGuTFAMrnbJZkVaBDnrmIGL6wky8tHWv0pUSWrI1O5CkGcIc
 6cGCWqNayFxrnF6F+9bRt2Vz2ziC9GTtOvGrkg6liFUW4nz1fbDovxVqyfbTDAiHnvawb+9MOra
 4Ob7VUaGK6Po+IClGgAyI9R3PfaFuqjLIjP2Vmar8qa02KX8d5l6xn6n6HzzLon5O339SOy6Qpa
 otF+zNBDKVyx73bHXAxHazH7CYUO0vSvs3Di7mSg/rrgvEaC1rTRdDh1vRYcynG9toXD12RWjs0
 gPs//BpEBYeGRalVf/YrNrxxpGIumbv6UV2yMImeGJC9CIHSRrT20a9vdf6MXFWGO22giYb30rz
 TkUwzODJihqi3F4S4n0Dlepftu5vJtlf6GIaYMExce6m0JcQV77m3
X-Google-Smtp-Source: AGHT+IHfHVy73Z76KRHplpYZwVFulCEvcsMsyAe8u9oYyA2zmRKftqLafLd5PsFtSI/cW1K1ltrJ9Q==
X-Received: by 2002:a05:6871:7c0b:b0:2ea:1e5d:8ad3 with SMTP id
 586e51a60fabf-30b6786df66mr2693644fac.22.1754177499471; 
 Sat, 02 Aug 2025 16:31:39 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 20/85] target/arm: Implement get_S2prot_indirect
Date: Sun,  3 Aug 2025 09:28:48 +1000
Message-ID: <20250802232953.413294-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Move the stage2 permissions for normal accesses to
GetPhysAddrResult.s2prot.  Put the stage2 permissions
for page table walking in CPUTLBEntryFull.prot.
This allows the permission checks in S1_ptw_translate
and arm_casq_ptw to see the right permission.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  7 ++++
 target/arm/ptw.c       | 81 +++++++++++++++++++++++++++++++-----------
 2 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d5f501bb30..f0e888ff93 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1574,6 +1574,13 @@ typedef struct ARMCacheAttrs {
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
index 7fd1cee98a..323fc8052d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1281,7 +1281,7 @@ do_fault:
  * @xn:      XN (execute-never) bits
  * @s1_is_el0: true if this is S2 of an S1+2 walk for EL0
  */
-static int get_S2prot_noexecute(int s2ap)
+static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
 {
     int prot = 0;
 
@@ -1291,12 +1291,6 @@ static int get_S2prot_noexecute(int s2ap)
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
@@ -1328,6 +1322,44 @@ static int get_S2prot(CPUARMState *env, int s2ap, int xn, bool s1_is_el0)
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
@@ -1778,7 +1810,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     int32_t stride;
     int addrsize, inputsize, outputsize;
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    int ap;
+    int ap, prot;
     uint32_t el = regime_el(env, mmu_idx);
     uint64_t descaddrmask;
     bool aarch64 = arm_el_is_aa64(env, el);
@@ -2096,6 +2128,18 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     ap = extract32(attrs, 6, 2);
     out_space = ptw->in_space;
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
@@ -2104,11 +2148,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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
@@ -2180,9 +2222,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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
@@ -2211,10 +2252,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              * Note that we modified ptw->in_space earlier for NSTable, but
              * result->f.attrs retains a copy of the original security space.
              */
-            result->f.prot = get_S1prot(env, mmu_idx, aarch64,
-                                        user_rw, prot_rw, xn, pxn,
-                                        result->f.attrs.space, out_space);
+            prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw, xn, pxn,
+                              result->f.attrs.space, out_space);
         }
+        result->f.prot = prot;
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
@@ -2260,7 +2301,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         result->f.tlb_fill_flags = 0;
     }
 
-    if (ptw->in_prot_check & ~result->f.prot) {
+    if (ptw->in_prot_check & ~prot) {
         fi->type = ARMFault_Permission;
         goto do_fault;
     }
@@ -3458,7 +3499,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     fi->s2addr = ipa;
 
     /* Combine the S1 and S2 perms.  */
-    result->f.prot &= s1_prot;
+    result->f.prot = s1_prot & result->s2prot;
 
     /* If S2 fails, return early.  */
     if (ret) {
-- 
2.43.0


