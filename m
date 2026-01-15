Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEF1D4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVz-00020R-FC; Thu, 15 Jan 2026 13:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVS-0000m4-Ki
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0005wl-UG
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:42 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so882990f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503331; x=1769108131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+qqWyiis4vu13eF2YaYpjfVH8hK5g4ZbYU2p2JdrOWg=;
 b=wacjJoLQaF3/9rYXmez9sGPVc8A7dD4OtslYoVBJWkdej9CesiETEmzJwUK13b51jZ
 gbkhLh6ry1oRsS8rFItM1CKK0fSj6rjTWPZDsFQrQrl3xtM+63JDvBIaY9nRPzP2nOhe
 2x0jWCdA9vWSsqOUAfjo37mYybusvp8AX/TnwOdTsvEccFUGjSt8ZGOlMfxvK5A+1uSt
 WuILcH+lcK6TZB2Ihv5B0VOhtG6Kdxx+m9lLl8Fz7FnGZobQ/JLJ6nLRM61/HGjCewUs
 M52zZxfah2eVI3UB4UK8kI/M1Neuqn4Ne7M7bTSjW0ypcE0C6HZssuM7yAhBNFQhMAIu
 pEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503331; x=1769108131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+qqWyiis4vu13eF2YaYpjfVH8hK5g4ZbYU2p2JdrOWg=;
 b=XmQ2tDH4WvZq4STcYhHwWZC/aLEi2z8EL5atp03mvfclWM2fuuTdGxQnHTXpe9ocA3
 /1ZnsxR78lnT3fwBz3+CwJa9IIhvei02TSbRVe2pc0hkKjx/YvnnoDv5yFUh+i7eMsAE
 Z8d1BYBaLxHakJpL0tbBSAHLes19NjBgfAB64MUG4Z1WxY1+h1PKdq4sNUoRcJL18VGv
 1IEsQMrNvYMtc2skosjuUpAcsh3iGrppL/HURMEafRJwEFPZ/dtiUZMLFQKIrVGivXLr
 HGml0ze8gxxpqEifUVTVYQD3Wr70SLDjNG6Q+bYGRLFzyqxKy2BJLds9+qT5pq2r2QoJ
 t37A==
X-Gm-Message-State: AOJu0YxgYuw+KMcZbwmOBDGUnFRYkKLOPpWTVz3EoCwMVgoNwz/wudWG
 a8mg9yPWUT2l6j4ET3xDkhsN/BgW9uyGrq7cqUcEQ58QFXvA+w3FV1FfZDeDA8dgGvQ77C45OFT
 Z6TK/
X-Gm-Gg: AY/fxX5D3N82ro7V26wZmYk5BxdCThsCdwL8lZmCU9or3suLhHsVkslP/QqvPgnkM5F
 AHEjLtGueDmpAtpCVhOyTu+YVlJb+Fv+qJtVm0H/SnQl1vlHfd8aYyeq+V6ixuXJdyAVDmV1w54
 ZQsoQP5n4Caws8Uj5kOgfIKuMWEjoCPlo0iFbt4RjerzhnL4zyn1GadMrgdiKxDiNfx4WGOjfcP
 MiyNZX6cAJ5+o6/U78jSWki+wWBamCuEluBgR8IRsgaeFWuAY6xUl1MBOYh6iaAEKhmRfPiKMEg
 hnt90n7pJCpvTpMmCyq3VmZAZdNLogAVhk9BNlbsf9CIcVTDz7MEfSrvaGa6Go6yp5ycyaXuFpZ
 447E2uHot3F60f4aGrsh2SpnyyDHrSDFF3eTbLWnVVrlRDbMJO0kQQLMAu8GDBjSWneioCC6ejm
 uEu+30XlGBlqUlWLpUvJwucVIndGcAca4t/8R2zO1fsE+LYp2EalWEX/dlig2pp+9R8KqdkmXtc
 qrs8tFEoXsH7skuLQ879zPJaF+VVvOHNlVlu0R+j4NzCw==
X-Received: by 2002:a05:6000:2481:b0:42f:9f18:8f40 with SMTP id
 ffacd0b85a97d-43569bc6d7cmr459670f8f.42.1768503330500; 
 Thu, 15 Jan 2026 10:55:30 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/25] target/arm: Correctly honour HCR.TID3 for v7A cores
Date: Thu, 15 Jan 2026 18:55:05 +0000
Message-ID: <20260115185508.786428-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

The HCR.TID3 bit defines that we should trap to the hypervisor for
reads to a collection of ID registers. Different architecture versions
have defined this differently:

 * v7A has a set of ID regs that definitely must trap:
    - ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3},
      ID_ISAR{0,1,2,3,4,5}, MVFR{0,1}
   and somewhat vaguely says that "there is no requirement"
   to trap for registers that are reserved in the ID reg space
   (i.e. which RAZ and might be used for new ID regs in future)
 * v8A adds to this list:
    - ID_PFR2 and MVFR2 must trap
    - ID_MMFR4, ID_MMFR5, ID_ISAR6, ID_DFR1 and reserved registers
      in the ID reg space must trap if FEAT_FGT is implemented,
      and it is IMPDEF if they trap if FEAT_FGT is not implemented

In QEMU we seem to have attempted to implement this distinction
(taking the "we do trap" IMPDEF choice if no FEAT_FGT), with
access_aa64_tid3() always trapping on TID3 and access_aa32_tid3()
trapping only if ARM_FEATURE_V8 is set.  However, we didn't apply
these to the right set of registers: we use access_aa32_tid3() on all
the 32-bit ID registers *except* ID_PFR2, ID_DFR1, ID_MMFR5 and the
RES0 space, which means that for a v7 CPU we don't trap on a lot of
registers that we should trap on, and we do trap on various things
that the v7A Arm ARM says there is "no requirement" to trap on.

Straighten this out by naming the access functions more clearly for
their purpose, and documenting this: access_v7_tid3() is only for the
fixed set of ID registers that v7A traps on HCR.TID3, and
access_tid3() is for any others, including the reserved encoding
spaces and any new registers we add in future.

AArch32 MVFR2 access is handled differently, in check_hcr_el2_trap;
there we already do not trap on TID3 on v7A cores (where MVFR2
doesn't exist), because we in the code-generation function we UNDEF
if ARM_FEATURE_V8 is not set, without generating code to call
check_hcr_el2_trap.

This bug was causing a problem for Xen which (after a recent change
to Xen) expects to be able to trap ID_PFR0 on a Cortex-A15.

The result of these changes is that our v8A behaviour remains
the same, and on v7A we now trap the registers the Arm ARM definitely
requires us to trap, and don't trap the reserved space that "there is
no requirement" to trap.

Cc: qemu-stable@nongnu.org
Fixes: 6a4ef4e5d1084c ("target/arm: Honor HCR_EL2.TID3 trapping requirements")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251231170858.254594-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 146 ++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 65 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 958e8edd34..3f422f509d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5839,9 +5839,18 @@ static const ARMCPRegInfo ccsidr2_reginfo[] = {
       .readfn = ccsidr2_read, .type = ARM_CP_NO_RAW },
 };
 
-static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_v7a_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      bool isread)
 {
+    /*
+     * Trap on TID3 always. This should be used only for the fixed set of
+     * registers which are defined to trap on HCR.TID3 in v7A, which is:
+     *   ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3}, ID_ISAR{0,1,2,3,4,5}
+     * (MVFR0 and MVFR1 also trap in v7A, but this is not handled via
+     * this accessfn but in check_hcr_el2_trap.)
+     * Any other registers in the TID3 trap space should use access_tid3(),
+     * so that they trap on v8 and above, but not on v7.
+     */
     if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3)) {
         return CP_ACCESS_TRAP_EL2;
     }
@@ -5849,11 +5858,18 @@ static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
-static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_tid3(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
 {
+    /*
+     * Trap on TID3, if we implement at least v8. For v8 and above
+     * the ID register space is at least IMPDEF permitted to trap,
+     * and must trap if FEAT_FGT is implemented. We choose to trap
+     * always. Use this function for any new registers that should
+     * trap on TID3.
+     */
     if (arm_feature(env, ARM_FEATURE_V8)) {
-        return access_aa64_tid3(env, ri, isread);
+        return access_v7a_tid3(env, ri, isread);
     }
 
     return CP_ACCESS_OK;
@@ -6303,7 +6319,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_PFR0)},
             /*
              * ID_PFR1 is not a plain ARM_CP_CONST because we don't know
@@ -6317,7 +6333,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = GET_IDREG(isar, ID_PFR1),
 #else
               .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .readfn = id_pfr1_read,
               .writefn = arm_cp_write_ignore
 #endif
@@ -6325,72 +6341,72 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_DFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_DFR0)},
             { .name = "ID_AFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_AFR0)},
             { .name = "ID_MMFR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR0)},
             { .name = "ID_MMFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR1)},
             { .name = "ID_MMFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR2)},
             { .name = "ID_MMFR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR3)},
             { .name = "ID_ISAR0", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR0)},
             { .name = "ID_ISAR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR1)},
             { .name = "ID_ISAR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR2)},
             { .name = "ID_ISAR3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR3) },
             { .name = "ID_ISAR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR4) },
             { .name = "ID_ISAR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_v7a_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR5) },
             { .name = "ID_MMFR4", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR4)},
             { .name = "ID_ISAR6", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa32_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_ISAR6) },
         };
         define_arm_cp_regs(cpu, v6_idregs);
@@ -6441,7 +6457,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = GET_IDREG(isar, ID_AA64PFR0)
 #else
               .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .readfn = id_aa64pfr0_read,
               .writefn = arm_cp_write_ignore
 #endif
@@ -6449,172 +6465,172 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_AA64PFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64PFR1)},
             { .name = "ID_AA64PFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64PFR2)},
             { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ZFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ZFR0)},
             { .name = "ID_AA64SMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64SMFR0)},
             { .name = "ID_AA64PFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64DFR0) },
             { .name = "ID_AA64DFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64DFR1) },
             { .name = "ID_AA64DFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64DFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64AFR0) },
             { .name = "ID_AA64AFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64AFR1) },
             { .name = "ID_AA64AFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64AFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR0)},
             { .name = "ID_AA64ISAR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR1)},
             { .name = "ID_AA64ISAR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR2)},
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64ISAR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR0)},
             { .name = "ID_AA64MMFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR1) },
             { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR2) },
             { .name = "ID_AA64MMFR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
             { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR6_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_AA64MMFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "MVFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = cpu->isar.mvfr0 },
             { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = cpu->isar.mvfr1 },
             { .name = "MVFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = cpu->isar.mvfr2 },
             /*
              * "0, c0, c3, {0,1,2}" are the encodings corresponding to
@@ -6625,17 +6641,17 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "RES_0_C0_C3_0", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "RES_0_C0_C3_1", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "RES_0_C0_C3_2", .state = ARM_CP_STATE_AA32,
               .cp = 15, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             /*
              * Other encodings in "0, c0, c3, ..." are STATE_BOTH because
@@ -6646,27 +6662,27 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "RES_0_C0_C3_3", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
             { .name = "ID_PFR2", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_PFR2)},
             { .name = "ID_DFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_DFR1)},
             { .name = "ID_MMFR5", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 6,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_MMFR5)},
             { .name = "RES_0_C0_C3_7", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
-              .accessfn = access_aa64_tid3,
+              .accessfn = access_tid3,
               .resetvalue = 0 },
         };
 #ifdef CONFIG_USER_ONLY
@@ -6818,7 +6834,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                 .state = ARM_CP_STATE_AA32,
                 .cp = 15, .opc1 = 0, .crn = 0, .crm = i, .opc2 = CP_ANY,
                 .access = PL1_R, .type = ARM_CP_CONST,
-                .accessfn = access_aa64_tid3,
+                .accessfn = access_tid3,
                 .resetvalue = 0 };
             define_one_arm_cp_reg(cpu, &v8_aa32_raz_idregs);
         }
-- 
2.47.3


