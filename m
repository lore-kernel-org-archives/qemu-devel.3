Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C45DCA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dI-0006qJ-9t; Tue, 26 Aug 2025 21:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cx-0005MM-Bu
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4ce-0007RJ-Jq
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so5860214b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256801; x=1756861601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMuL64RgjNJBh/XTj9TXpDrNBLGbyRPLO9EO9A1A2p8=;
 b=yZT2C6WETKjHrbBWDHKnFUw92R5URxiG/fyJxpAm2NpUuOFruNVy1mVPjEVR0hz3BG
 nNk9x4SP+YuEMr2ZQywW8irJQS3MINhyLHNpMVocTyiJ0fWnn+8jQjOvnjMuiFQAnoI7
 EgVGi/GKG/GJrScY1iIQkW/wANMkxmnMjSiR36sxDHLtiWNQ/t7L2O88OZ02XqZK2T7v
 2SB3av3LkJ6As3wIGUwB3hNzG69WwDvMFfznn5ptUVDL9yNWPXvaLIoIODqP7btYvGTK
 IKeNT424WWtvruMG+AaEl2YkHA/kr3HCFmqT1ykyffldPZhmr7vCoDQCYhMDngtnOYx+
 gAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256801; x=1756861601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMuL64RgjNJBh/XTj9TXpDrNBLGbyRPLO9EO9A1A2p8=;
 b=evHj2RI42pR1QDRlz/ts4xI1mhNZgXFsUrKP6BTvSlprTNmFiHDTkc9wn6me7wkLP/
 JWK2WVH4ZHxODckwv5DOTZGgn9Tmoes/1Vg8ZtEoDSfAGA4n2skOXsRZH05ODFwEDBu6
 CwCvxpLe1xA3lQXBpp6xZYv9gPMMXULUoFDlhjKTLATiU2qdbk4lZJ1U/gBFti6+AMGO
 YSfZ1rrJqiW1pZO3pt31DW4BUQVl2KIHkmFgFSqzmZCeMCAr9YTn6g3iLr5ESmsnp9xw
 3c6QiH2SRQEPA9mNR7qtmEzu5i75CD/nT1mRQuMjQs6456WLgosf/P/pyGbrcsMIlYLu
 +yZQ==
X-Gm-Message-State: AOJu0YwV0A9HRSg0LwDtjQZwCHSuU1w+qs6JBNQsoSH4K8gn0cL5rieD
 Zm8yaMGhTxMSvRQJ7+CjxYhfPqX0uhYL9cXgP2uKYv0FzEW7kDhmY4WOJ9z8E8apdv6wP4NTg8R
 ql94oiM0=
X-Gm-Gg: ASbGnctiA089Mi/IF8uVK33Ss7VoviJuXALeXFBVGHYAocAc7ZRPoS1RgamR437cg0w
 /GWAqmS4xS08C1W52ageI62q9/1EjIzLVQGOGZeHN3mnqULLyNFUO92FyY8jJJG24Uj26tvorRY
 2lxlE6/q/8ktjfIKuAC9epctthW4Y4eyDxV7m4FYGLpJc2Cmp0xrxkgTOItONnG2uSnnhlcR6pL
 biv1i3MlUbVMKSotmEO6yQVidODTS/AMSldHZq9zLxzvj/96PciJ3lpsb3BniLmjfd0WKBG7D4T
 X73mm6+NiEOIaqhCLCxXmbZJ6mEyrg5kozIlrjYJO6y34YmnhhEKi4VOwChFT1VyyV8y9sOQY6f
 wKhrvi4GLSHvP1gHVse4fTWEI0Q==
X-Google-Smtp-Source: AGHT+IGaI1uVyol0Hfdy0BTY66sYdIPsHuZvwTVvCkWCtu7ZrvN3/GGGZbvi4slBZJCXSsT37SU6HQ==
X-Received: by 2002:a05:6a00:398a:b0:76b:d75c:8a76 with SMTP id
 d2e1a72fcca58-7702f9d90b9mr21126397b3a.1.1756256800751; 
 Tue, 26 Aug 2025 18:06:40 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 18/61] target/arm: Remove cp argument to ENCODE_AA64_CP_REG
Date: Wed, 27 Aug 2025 11:04:09 +1000
Message-ID: <20250827010453.4059782-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

All invocations were required to pass the same value,
CP_REG_ARM64_SYSREG_CP.  Bake that in to the result directly.
Remove CP_REG_ARM64_SYSREG_CP as unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  5 ++---
 target/arm/kvm-consts.h        |  3 ---
 target/arm/helper.c            | 11 +++++------
 target/arm/hvf/hvf.c           |  3 +--
 target/arm/tcg/translate-a64.c |  6 ++----
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 7ebe404163..95b0b9c78e 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -187,9 +187,8 @@ enum {
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
-#define ENCODE_AA64_CP_REG(cp, crn, crm, op0, op1, op2) \
-    (CP_REG_AA64_MASK |                                 \
-     ((cp) << CP_REG_ARM_COPROC_SHIFT) |                \
+#define ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2) \
+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
      ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
      ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
      ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index fdb305eea1..54ae5da7ce 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -160,9 +160,6 @@ MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A53, KVM_ARM_TARGET_CORTEX_A53);
 #define CP_REG_ARM64_SYSREG_OP2_MASK   0x0000000000000007
 #define CP_REG_ARM64_SYSREG_OP2_SHIFT  0
 
-/* No kernel define but it's useful to QEMU */
-#define CP_REG_ARM64_SYSREG_CP (CP_REG_ARM64_SYSREG >> CP_REG_ARM_COPROC_SHIFT)
-
 MISMATCH_CHECK(CP_REG_ARM64, KVM_REG_ARM64);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_MASK, KVM_REG_ARM_COPROC_MASK);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_SHIFT, KVM_REG_ARM_COPROC_SHIFT);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 268cad905f..93cae888e2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4527,7 +4527,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     };
 
 #define K(op0, op1, crn, crm, op2) \
-    ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
+    ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2)
 
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
@@ -7297,10 +7297,9 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
          * in their AArch64 view (the .cp value may be non-zero for the
          * benefit of the AArch32 view).
          */
-        if (cp == 0 || r->state == ARM_CP_STATE_BOTH) {
-            cp = CP_REG_ARM64_SYSREG_CP;
-        }
-        key = ENCODE_AA64_CP_REG(cp, r->crn, crm, r->opc0, opc1, opc2);
+        assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
+        cp = 0;
+        key = ENCODE_AA64_CP_REG(r->crn, crm, r->opc0, opc1, opc2);
         break;
     default:
         g_assert_not_reached();
@@ -7525,7 +7524,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
         }
         break;
     case ARM_CP_STATE_AA64:
-        assert(r->cp == 0 || r->cp == CP_REG_ARM64_SYSREG_CP);
+        assert(r->cp == 0);
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9dffa99ed1..af03fc7fc1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1124,8 +1124,7 @@ static bool is_id_sysreg(uint32_t reg)
 
 static uint32_t hvf_reg2cp_reg(uint32_t reg)
 {
-    return ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
+    return ENCODE_AA64_CP_REG((reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
                               (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
                               (reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
                               (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dbf47595db..743c5a10e1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2466,8 +2466,7 @@ static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
                        unsigned int crn, unsigned int crm, unsigned int rt)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                                      crn, crm, op0, op1, op2);
+    uint32_t key = ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
@@ -2603,8 +2602,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * We don't use the EL1 register's access function, and
          * fine-grained-traps on EL1 also do not apply here.
          */
-        key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                                 crn, crm, op0, 0, op2);
+        key = ENCODE_AA64_CP_REG(crn, crm, op0, 0, op2);
         ri = get_arm_cp_reginfo(s->cp_regs, key);
         assert(ri);
         assert(cp_access_ok(s->current_el, ri, isread));
-- 
2.43.0


