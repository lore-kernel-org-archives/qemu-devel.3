Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F91BCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWap-0006Gi-HX; Tue, 16 Sep 2025 10:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaP-0005qA-PX
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaE-0008Mg-FQ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2445826fd9dso65604575ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032580; x=1758637380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRgfGoWkJBViaWdfAuuV3gVCQiMB3rBg0skWkT97tNk=;
 b=tQByyXcTa7IKRSB8ZWM4+ZTk2/esMRKDZ8zBS9Q3LL1D0SeuuSkC/yhdtEFR4190dp
 DFsE1LzHCmC+2bdx9umrsvjmbbh9g5o/yDinq0ytzGQioEcdCxnpJQU7Nk6ORkINxc6A
 kZgtMi0eEgjaeIK2slbvyCjwpmcTl+uW0bBM2IGu8W7711YZUKvDS9dWBiI+QYpxBDo2
 MEgkhDRFyTtWyq+mRSpg/NGMBuJXxbpruzjeth8TcQIlhxwqIhhWazU01W6Ljje7dsja
 KRxCUZxWwIvt2ac/Zah6GyPAZ8pX7m1Pev64X3xyUPiHwa2MPkipLjU1JezsKjAQB1nF
 e2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032580; x=1758637380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRgfGoWkJBViaWdfAuuV3gVCQiMB3rBg0skWkT97tNk=;
 b=eqU9usU58ruPQdTeqegPAcKxkJEyPiNwzxw6yaEAQgwAM0cr3Fkn0gjYAbGL46lkCp
 okzKcj+sKuJGb6/vEVSKjh7RnPSgkOcopA2K+b2MpsF1uUxLwMYqMkGsefw0zow8bMha
 jOj3KcJXcg6DFKBE40rxUysNzqeRCd4bRoKcY1c7xdgWcfMPmEsdPVjeLuJy5G+jxCnV
 u7kruBoin/G7/HlRlYWCxqhKHN05mDU5p3UwqXNJCUNT0YeuSwANOdhZfQx/yh1EhFTx
 ksZE+jvA+Pxhxu+UrHnKTPzI15CZdfYFnPwBEkG8IcXg6akcRLSwTI7lp3YVltf/ME1o
 u/HA==
X-Gm-Message-State: AOJu0YyqZEbxXgmVuRdqMfZwXMWClwPJWcojoU4+0OSGiLuAFFg+h7Q5
 PslE2UKbeMSIGAyFwSpAJuCcCuV1c18Cjw7xRSxPO6H8s8awIPVAzHTGAnbw0qmjo+GYU1Bi7pU
 Pwdk6
X-Gm-Gg: ASbGnctuipVFWGJJbyLNlOYfvSUFODR0K0lB+FzJmpq8tc6MvhmsUo1jxrlPONi/LWz
 8pn8toWPmcwhHbn706yao9alHv7RMG6GKi1xANe3mw+JJu/ruc2pf0k2EuFaYeYRloQJk7zRbVO
 mwlT80ZmI0lVJ2qZJxTg9kredkV1VRjvWQyp7yLeQ0y7p9zcqKMoNkAf1SoQD51KiZPARIm5/Q1
 kaIB9vFWt9Aqn2CUcWTFDlk7WucY0spYXX5VzdGRwoQipwWpMAU7RFP/r1J1iZboDmC7ElbBVHk
 vLTpePBnAOokAWI3DqeepNu7IqiZFAn931xMNnMjyN7LCwqUCtTFasTbKaDRyIcq5fWhHrGOCNl
 rVKEwXAoBfnqLRm/HnhMOOEpoaurH
X-Google-Smtp-Source: AGHT+IEKg8RBNQVZfjsGxxqrsTnQ/ZBF4bXbkMjZ2HndW1XegnOq6B70B5k+pKzbPOExU5yiP7nkGQ==
X-Received: by 2002:a17:902:d2cf:b0:266:e0e6:873e with SMTP id
 d9443c01a7336-266e0e68a56mr103540915ad.57.1758032579582; 
 Tue, 16 Sep 2025 07:22:59 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 26/36] target/arm: Hoist the allocation of ARMCPRegInfo
Date: Tue, 16 Sep 2025 07:22:27 -0700
Message-ID: <20250916142238.664316-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Pass in a newly allocated structure, rather than having to
dance around allocation of the name and the structure.

Since we no longer have two copies of the structure handy
within add_cpreg_to_hashtable, delay the writeback of concrete
values over wildcards until we're done querying the wildcards.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 97 ++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7f55ea726d..71dd094fac 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7443,13 +7443,12 @@ static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in,
  * Private utility function for define_one_arm_cp_reg():
  * add a single reginfo struct to the hash table.
  */
-static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
+static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
                                    int cp, int crm, int opc1, int opc2,
-                                   const char *name, uint32_t key)
+                                   uint32_t key)
 {
     CPUARMState *env = &cpu->env;
-    ARMCPRegInfo *r2;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
 
     /* Overriding of an existing definition must be explicitly requested. */
@@ -7460,19 +7459,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
         }
     }
 
-    r2 = alloc_cpreg(r, name, NULL);
-
-    /*
-     * Update fields to match the instantiation, overwiting wildcards
-     * such as CP_ANY, ARM_CP_STATE_BOTH, or ARM_CP_SECSTATE_BOTH.
-     */
-    r2->cp = cp;
-    r2->crm = crm;
-    r2->opc1 = opc1;
-    r2->opc2 = opc2;
-    r2->state = state;
-    r2->secure = secstate;
-
     {
         bool isbanked = r->bank_fieldoffsets[0] && r->bank_fieldoffsets[1];
 
@@ -7482,7 +7468,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
              * Overwriting fieldoffset as the array is only used to define
              * banked registers but later only fieldoffset is used.
              */
-            r2->fieldoffset = r->bank_fieldoffsets[ns];
+            r->fieldoffset = r->bank_fieldoffsets[ns];
         }
         if (state == ARM_CP_STATE_AA32) {
             if (isbanked) {
@@ -7499,19 +7485,19 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                  */
                 if ((r->state == ARM_CP_STATE_BOTH && ns) ||
                     (arm_feature(env, ARM_FEATURE_V8) && !ns)) {
-                    r2->type |= ARM_CP_ALIAS;
+                    r->type |= ARM_CP_ALIAS;
                 }
             } else if ((secstate != r->secure) && !ns) {
                 /*
                  * The register is not banked so we only want to allow
                  * migration of the non-secure instance.
                  */
-                r2->type |= ARM_CP_ALIAS;
+                r->type |= ARM_CP_ALIAS;
             }
 
             if (HOST_BIG_ENDIAN &&
-                r->state == ARM_CP_STATE_BOTH && r2->fieldoffset) {
-                r2->fieldoffset += sizeof(uint32_t);
+                r->state == ARM_CP_STATE_BOTH && r->fieldoffset) {
+                r->fieldoffset += sizeof(uint32_t);
             }
         }
     }
@@ -7523,35 +7509,46 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
      * multiple times. Special registers (ie NOP/WFI) are
      * never migratable and not even raw-accessible.
      */
-    if (r2->type & ARM_CP_SPECIAL_MASK) {
-        r2->type |= ARM_CP_NO_RAW;
+    if (r->type & ARM_CP_SPECIAL_MASK) {
+        r->type |= ARM_CP_NO_RAW;
     }
     if (((r->crm == CP_ANY) && crm != 0) ||
         ((r->opc1 == CP_ANY) && opc1 != 0) ||
         ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
+        r->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
     }
 
+    /*
+     * Update fields to match the instantiation, overwiting wildcards
+     * such as CP_ANY, ARM_CP_STATE_BOTH, or ARM_CP_SECSTATE_BOTH.
+     */
+    r->cp = cp;
+    r->crm = crm;
+    r->opc1 = opc1;
+    r->opc2 = opc2;
+    r->state = state;
+    r->secure = secstate;
+
     /*
      * Check that raw accesses are either forbidden or handled. Note that
      * we can't assert this earlier because the setup of fieldoffset for
      * banked registers has to be done first.
      */
-    if (!(r2->type & ARM_CP_NO_RAW)) {
-        assert(!raw_accessors_invalid(r2));
+    if (!(r->type & ARM_CP_NO_RAW)) {
+        assert(!raw_accessors_invalid(r));
     }
 
-    g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r2);
+    g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r);
 }
 
-static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
+static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
                                         int cp, int crm, int opc1, int opc2)
 {
     /*
      * Under AArch32 CP registers can be common
      * (same for secure and non-secure world) or banked.
      */
-    char *name;
+    ARMCPRegInfo *r_s;
     bool is64 = r->type & ARM_CP_64BIT;
     uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
 
@@ -7563,24 +7560,23 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
         /* fall through */
     case ARM_CP_SECSTATE_S:
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
-                               cp, crm, opc1, opc2, r->name, key);
+                               cp, crm, opc1, opc2, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
-        name = g_strdup_printf("%s_S", r->name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
-                               cp, crm, opc1, opc2, name, key);
-        g_free(name);
+        r_s = alloc_cpreg(r, r->name, "_S");
+        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
+                               cp, crm, opc1, opc2, key);
 
         key |= CP_REG_AA32_NS_MASK;
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
-                               cp, crm, opc1, opc2, r->name, key);
+                               cp, crm, opc1, opc2, key);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
-static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
                                         int crm, int opc1, int opc2)
 {
     uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
@@ -7597,24 +7593,23 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
          * and name that it is passed, so it's OK to use
          * a local struct here.
          */
-        ARMCPRegInfo nxs_ri = *r;
-        g_autofree char *name = g_strdup_printf("%sNXS", r->name);
+        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, r->name, "NXS");
         uint32_t nxs_key;
 
-        assert(nxs_ri.crn < 0xf);
-        nxs_ri.crn++;
+        assert(nxs_ri->crn < 0xf);
+        nxs_ri->crn++;
         nxs_key = key + (1 << CP_REG_ARM64_SYSREG_CRN_SHIFT);
-        if (nxs_ri.fgt) {
-            nxs_ri.fgt |= R_FGT_NXS_MASK;
+        if (nxs_ri->fgt) {
+            nxs_ri->fgt |= R_FGT_NXS_MASK;
         }
 
-        add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
+        add_cpreg_to_hashtable(cpu, nxs_ri, ARM_CP_STATE_AA64,
                                ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
-                               name, nxs_key);
+                               nxs_key);
     }
 
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           0, crm, opc1, opc2, r->name, key);
+                           0, crm, opc1, opc2, key);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7821,16 +7816,20 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     for (int crm = crmmin; crm <= crmmax; crm++) {
         for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
+                ARMCPRegInfo *r2 = alloc_cpreg(r, r->name, NULL);
+                ARMCPRegInfo *r3;
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_AA64:
-                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r2, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_BOTH:
-                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
-                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    r3 = alloc_cpreg(r2, r2->name, NULL);
+                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r3, crm, opc1, opc2);
                     break;
                 default:
                     g_assert_not_reached();
-- 
2.43.0


