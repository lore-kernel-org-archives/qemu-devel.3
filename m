Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D26CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dl-0008Qc-FJ; Tue, 26 Aug 2025 21:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dD-0006Si-Rw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4d1-0007V6-1n
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso2844121b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256823; x=1756861623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiTlSDbl7ZE2Kdnr9r+qg6Y8XwHKnrFV6OAAtT3qX4s=;
 b=vaMCFL7+ZVFuuLoZeC3wFPiZXckN07/iN0qm9H36lTErZW2MaTk9HTg8HTaNLfrMAI
 LnckHPPm/gk2kwqRTfMDuetD1QULE8u5mjzosBKM/0svWS4KPRU39avCj2/r3mWRFly3
 +r0v/Z4V2gl7TUBOBR64zTVxKQI7cAALRwA7bHcLIGpIims8Q3ZQ0NRQqJ7uvHjxERQA
 c7QyWA7feZ2VpgUUDMs7vdaPB3ZEgLUox68DGsg2Zl/6c66pc92Hu4g8zBZFpzwIpYle
 zMZ3pbSneuKi1NysSbJV4PEIxReQck9SAv7kunDcX2xAYV66UFFEFq3riKCqrSLiyVMm
 0Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256823; x=1756861623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiTlSDbl7ZE2Kdnr9r+qg6Y8XwHKnrFV6OAAtT3qX4s=;
 b=nVFvlbsJ5DCGtc7ulOxUJ7xO+Hca790rJi3zBApcR9GeTqhjWT2yDV++xyFmrITs6j
 SRIBrkkOxO71HmGlnPPOwrBMVEk52mJDoiZjmnww1GHCpcXY0p4t/RcsR+V6kSjgb4WK
 zxsSaNxh31aJ96RMN4Q3ttNgtGeEhUo3W3h+7V3yTI7DBNRDRB2rp7OUVT7DbcRK4t7G
 vXcFi66oHEnERchNKvz5KY1kOhgYjoz3zvdPxCwIM5PmVs+Q64sLLhsvFgGEqIJ4i8e1
 BqgaAbZlDpkk/MbpV14umo1ix6cQ04499TdoKdJ1/B0V4KKrg8eoiSwdT30gLKglRvcd
 DQVQ==
X-Gm-Message-State: AOJu0Yxv8Q2KaMbIn/1FijOJKiv1GyBvUaDH4caMMr4z1F67nKGOgqqO
 973E0+rfIY4w2ruaZMx3m/YqM+O/XZV++TDu4mPLjwjzhwcnirfPVqYeu9SSBBAWYUIvO42Qpwd
 a2XnW9nE=
X-Gm-Gg: ASbGncsSpZJ0O81vXSliZ7w4DtPiDhfnc8Cd/jaqADRNfhqFuLzOprfocPEfKSNUUrz
 cqig5YIxppzyJbdG1DQpJWzeCeLlgE/Bn5DVJFEbpXaSMbn7S1HX4jrC41bYNUqDExp8EtpQAZI
 QOyKwzwr4MAuY5rzZPfoG5ThV0I+7k07RXqTrI1S0Drxt7ah+Vf/Q9pR6+V87KrT+3FjchJZvc8
 zK1cW/L1hne27Igso/kdTOIyj+TaQwF7MHQKWYhJMWR4cw/+j6OrjZwIZfPHzL3mNE+Yd5sXPrl
 ZOp89PaEbhc+dRixEV/1ldVrDfr5U6Ufrvn5YUP1D3Mu70bEpVN2M/rptVoJPaayrJG3W15fTBD
 qhmYCA6XCAkRuyRXOwpU+22Zhs57SWsTCVeCOV9wxM9P81ZE=
X-Google-Smtp-Source: AGHT+IH0iM1ygKOoU5r2kTMIxyLmtw73+6189p1IT7DGgLcP4y82qXYsjOF7Vl5WtssV+z+GIVmRkA==
X-Received: by 2002:a05:6a00:14c7:b0:770:5987:5b3a with SMTP id
 d2e1a72fcca58-77059879144mr11624726b3a.16.1756256823287; 
 Tue, 26 Aug 2025 18:07:03 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 22/61] target/arm: Move cp processing to define_one_arm_cp_reg
Date: Wed, 27 Aug 2025 11:04:13 +1000
Message-ID: <20250827010453.4059782-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Processing of cp was split between add_cpreg_to_hashtable and
define_one_arm_cp_reg.  Unify it all to the top-level function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index da6a8f0a8f..a9d6ed1270 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7269,7 +7269,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
-                                   int crm, int opc1, int opc2,
+                                   int cp, int crm, int opc1, int opc2,
                                    const char *name)
 {
     CPUARMState *env = &cpu->env;
@@ -7277,28 +7277,14 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     ARMCPRegInfo *r2;
     bool is64 = r->type & ARM_CP_64BIT;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
-    int cp = r->cp;
     size_t name_len;
     bool make_const;
 
     switch (state) {
     case ARM_CP_STATE_AA32:
-        /* We assume it is a cp15 register if the .cp field is left unset. */
-        if (cp == 0 && r->state == ARM_CP_STATE_BOTH) {
-            cp = 15;
-        }
         key = ENCODE_CP_REG(cp, is64, ns, r->crn, crm, opc1, opc2);
         break;
     case ARM_CP_STATE_AA64:
-        /*
-         * To allow abbreviation of ARMCPRegInfo definitions, we treat
-         * cp == 0 as equivalent to the value for "standard guest-visible
-         * sysreg".  STATE_BOTH definitions are also always "standard sysreg"
-         * in their AArch64 view (the .cp value may be non-zero for the
-         * benefit of the AArch32 view).
-         */
-        assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
-        cp = 0;
         key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
         break;
     default:
@@ -7459,7 +7445,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
 }
 
 static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
-                                        int crm, int opc1, int opc2)
+                                        int cp, int crm, int opc1, int opc2)
 {
     /*
      * Under AArch32 CP registers can be common
@@ -7472,16 +7458,16 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
     switch (r->secure) {
     case ARM_CP_SECSTATE_S:
     case ARM_CP_SECSTATE_NS:
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               r->secure, crm, opc1, opc2, r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
+                               cp, crm, opc1, opc2, r->name);
         break;
     case ARM_CP_SECSTATE_BOTH:
         name = g_strdup_printf("%s_S", r->name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               ARM_CP_SECSTATE_S, crm, opc1, opc2, name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
+                               cp, crm, opc1, opc2, name);
         g_free(name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
+                               cp, crm, opc1, opc2, r->name);
         break;
     default:
         g_assert_not_reached();
@@ -7512,11 +7498,11 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
             nxs_ri.fgt |= R_FGT_NXS_MASK;
         }
         add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, name);
+                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2, name);
     }
 
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           crm, opc1, opc2, r->name);
+                           0, crm, opc1, opc2, r->name);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7551,6 +7537,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     int opc1max = (r->opc1 == CP_ANY) ? 7 : r->opc1;
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
+    int cp = r->cp;
 
     /*
      * AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless.
@@ -7573,21 +7560,25 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
      */
     switch (r->state) {
     case ARM_CP_STATE_BOTH:
-        /* 0 has a special meaning, but otherwise the same rules as AA32. */
-        if (r->cp == 0) {
+        /*
+         * If the cp field is left unset, assume cp15.
+         * Otherwise apply the same rules as AA32.
+         */
+        if (cp == 0) {
+            cp = 15;
             break;
         }
         /* fall through */
     case ARM_CP_STATE_AA32:
         if (arm_feature(&cpu->env, ARM_FEATURE_V8) &&
             !arm_feature(&cpu->env, ARM_FEATURE_M)) {
-            assert(r->cp >= 14 && r->cp <= 15);
+            assert(cp >= 14 && cp <= 15);
         } else {
-            assert(r->cp < 8 || (r->cp >= 14 && r->cp <= 15));
+            assert(cp < 8 || (cp >= 14 && cp <= 15));
         }
         break;
     case ARM_CP_STATE_AA64:
-        assert(r->cp == 0);
+        assert(cp == 0);
         break;
     default:
         g_assert_not_reached();
@@ -7657,13 +7648,13 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_AA64:
                     add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_BOTH:
-                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
                     add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
                     break;
                 default:
-- 
2.43.0


