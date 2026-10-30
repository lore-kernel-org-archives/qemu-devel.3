Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6704606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AxEDrBaE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrmy-0007YC-4l; Fri, 30 Oct 2026 14:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlz-0006tv-6U
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:20 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlv-0004pJ-12
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:16 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8726acc5eadso9309247b3.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386573; x=1793991373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=huYcXpcvi0CcacnVUoggrHLfJkueTbDQs53OqkTKktQ=;
 b=AxEDrBaE0nh93LFlsFya8yWNBVdRmCfw4vEGzidPaHg6Ew/V53yovI23f4Bk3A8CtO
 HY4j6Dmzz/vablASOMSqDPRLE+AIhT5GN+bGoyssCS1OPIursldbVzcJYvCKMOh26art
 YxzipeaxW2TsGduDRtzCfcHMypjJkwjzc44fYoUGwLOqUtqcQ+292dJki5y3nveq/zWL
 6jhD1TNib9J4dQXmdRsWwCPgcLjDFlQ/XR2S/8rJRenFaA6UhXUFHWLeBmR8dAYvfnJ0
 oMDfOm3ShtkzP+i3uorR64wz+tMpZ0qGK+D01YJySJ+lMJ3CF51skf5b3tQY5M41fASK
 Nv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386573; x=1793991373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=huYcXpcvi0CcacnVUoggrHLfJkueTbDQs53OqkTKktQ=;
 b=xM8yvV81sei9AQfvTokFdeJjiO6BBkyj58a+HVNnKfrQlc+QOdyPykAqy9jtRWTlOC
 IVn0+JZpWxKR6vwq5wr84u2oR7BOVE3Ehkh/oPiMj5gvcIxIm+lBHJDJlimRlVQkIEXu
 VzN/Hu6r25UkTGH3Bx25J5dCPEtdxq4w4Q8GleIlrEi3fHt4V5gPW9HV2mAtZwxt7/9J
 X7MZjTTvPbLe64ThGhxXz9C8M2W7vdMTfwPOQY0C4oqoHrq834O5Pk1t0sdHYpvt5Hxf
 U/G5WYEK8unjc1Zz4l2IDGqPbLQFMovrEHBMwPD5SeGqzKnCs1HgnT4CI5Hfo1attsgV
 XSkQ==
X-Gm-Message-State: AFq9FYLFPA/9Z+6eY7wvW5PZnLNQ5x/UfPsAKPlWgnNBJsE/v0pG4qtR
 Y7SrGiYvJnBRjetZw/0L4i8AuLOzTj/VlE6kausZfxJolO3veRUkUIw4YaSXVjYTE+sD93SgCKw
 d0nOU
X-Gm-Gg: AYBFou3HKAnzKCwbpgMkSkzCU8aNgbTxCGhqgxJevCesH9K7R6VzkAm9OWplW5H0kuT
 8DLbCu3RbLwa+/J77YWQW12eE9+9L5EpqjUL8B5K9NhpUbjuSixBXWoHiPttrfWYwbOvb+YbXgQ
 txA8GWrJYXi/qZhH5MEv/QRaqSeNSrcfjSBDva/N+tcWp77oE/LmAxcUbMMvF4m0Jcuq+kXAWNG
 SbM//oRI5HbqUamrarEKdbDri6O9mfRdZSKJm0EZWKBSt4AluElgx3l9DEJvt1mZXnStAFgQLbo
 Bqpc+0LoRRiweiJQRQUzI44qjSwClGxv8/yypbSlYknTzDSxeE8IKTFbT5j/eq5MxDCqC00K1SK
 tmna9+jtRBNkweWIcmiOP2byUlnCIAoFGO8E/HUeLRtzN2Vn4UJph4YFAjOQM1/aTHPmV2NbGpO
 YNUGsgXivPMdpHNT791azg1bEE9LAcbwEj3vU7beonD4z4176fC1b+t7I+VWLGDktpUga8dcX/J
 c7lB6c1Qp92P03YQta7LW30Um2MAGve06CDETRGxu/w9XptVJK/TcEZjk21Kb3s/M3cdo/IIN8Q
 N45DmBuEFckkd2nKWkI8bfC+h7cxvkS3Bn4=
X-Received: by 2002:a05:690c:6609:b0:8ae:b617:7138 with SMTP id
 00721157ae682-8b2b6769adamr22092217b3.49.1793386572679; 
 Fri, 30 Oct 2026 11:56:12 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 12/14] tcg/aarch64: Implement INDEX_op_goto_jc
Date: Fri, 30 Oct 2026 13:55:49 -0500
Message-ID: <20261030185551.193092-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
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

Use ldp to load multiple values at once.
Use ccmp to reduce the number of branhes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |   1 +
 tcg/aarch64/tcg-target.c.inc     | 129 +++++++++++++++++++++++++++++--
 2 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index dd84a9af58..9d13aef4a3 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -14,6 +14,7 @@ C_O0_I2(r, rC)
 C_O0_I2(rz, r)
 C_O0_I2(w, r)
 C_O0_I3(rz, rz, r)
+C_O0_I4(r, rz, ri, ri)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 1c3cf835e2..f3264545a3 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -570,6 +570,10 @@ typedef enum {
     /* Logical shifted register instructions (with a shift).  */
     Iaddsub_realshift_AND_LSR  = Ilogic_shift_AND | (1 << 22),
 
+    /* Conditional compare. */
+    Iccmp_reg_CCMP     = 0x7a400000,
+    Iccmp_imm_CCMP     = 0x7a400800,
+
     /* AdvSIMD copy */
     Isimd_copy_DUP     = 0x0e000400,
     Isimd_copy_INS     = 0x4e001c00,
@@ -712,6 +716,16 @@ static void tcg_out_insn_bcond_imm(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | tcg_cond_to_aarch64[c] | (imm19 & 0x7ffff) << 5);
 }
 
+static void tcg_out_insn_ccmp_reg(TCGContext *s, AArch64Insn insn,
+                                  TCGType ext, TCGCond c, TCGReg rn,
+                                  TCGReg rm, unsigned nzcv)
+{
+    tcg_out32(s, insn | ext << 31 | tcg_cond_to_aarch64[c] << 12
+              | rm << 16 | rn << 5 | nzcv);
+}
+
+#define tcg_out_insn_ccmp_imm tcg_out_insn_ccmp_reg
+
 static void tcg_out_insn_tbz(TCGContext *s, AArch64Insn insn,
                               TCGReg rt, int imm6, int imm14)
 {
@@ -1450,12 +1464,17 @@ static void tcg_out_br(TCGContext *s, TCGLabel *l)
     }
 }
 
+static void tgen_b_c(TCGContext *s, TCGCond c, TCGLabel *l)
+{
+    tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
+    tcg_out_insn(s, bcond_imm, B_C, c, 0);
+}
+
 static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
                         TCGReg a, TCGReg b, TCGLabel *l)
 {
     tgen_cmp(s, type, c, a, b);
-    tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
-    tcg_out_insn(s, bcond_imm, B_C, c, 0);
+    tgen_b_c(s, c, l);
 }
 
 static void tgen_brcondi(TCGContext *s, TCGType ext, TCGCond c,
@@ -1502,8 +1521,7 @@ static void tgen_brcondi(TCGContext *s, TCGType ext, TCGCond c,
 
     if (need_cmp) {
         tgen_cmpi(s, ext, c, a, b);
-        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
-        tcg_out_insn(s, bcond_imm, B_C, c, 0);
+        tgen_b_c(s, c, l);
         return;
     }
 
@@ -2008,8 +2026,109 @@ static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
     .out = tgen_qemu_st2,
 };
 
+static void tgen_goto_jc_cmp_ccmp(TCGContext *s,
+                                  TCGReg reg1, TCGArg ref1, bool const_ref1,
+                                  const uint64_t *tb_slot1,
+                                  TCGReg reg2, TCGArg ref2, bool const_ref2,
+                                  const uint64_t *tb_slot2,
+                                  TCGCond ccmp_cond, unsigned ccmp_nzcv)
+{
+    if (!const_ref1) {
+        tgen_cmp(s, TCG_TYPE_I64, TCG_COND_NE, reg1, ref1);
+    } else if (tcg_target_const_match(ref1, TCG_CT_CONST_CMP,
+                                      TCG_TYPE_I64, TCG_COND_NE, 0)) {
+        tgen_cmpi(s, TCG_TYPE_I64, TCG_COND_NE, reg1, ref1);
+    } else {
+        if (tb_slot1 && ref1 == *tb_slot1) {
+            tcg_out_insn(s, ldlit, LDR, tcg_pcrel_diff(s, tb_slot1) >> 2,
+                         TCG_REG_TMP2);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP2, ref1);
+        }
+        tgen_cmp(s, TCG_TYPE_I64, TCG_COND_NE, reg1, TCG_REG_TMP2);
+    }
+
+    if (!const_ref2) {
+        tcg_out_insn(s, ccmp_reg, CCMP, TCG_TYPE_I64, ccmp_cond,
+                     reg2, ref2, ccmp_nzcv);
+    } else if (ref2 <= 0x1f) {
+        tcg_out_insn(s, ccmp_imm, CCMP, TCG_TYPE_I64, ccmp_cond,
+                     reg2, ref2, ccmp_nzcv);
+    } else {
+        if (!is_aimm(ref2) && tb_slot2 && ref2 == *tb_slot2) {
+            tcg_out_insn(s, ldlit, LDR, tcg_pcrel_diff(s, tb_slot2) >> 2,
+                         TCG_REG_TMP2);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP2, ref2);
+        }
+        tcg_out_insn(s, ccmp_reg, CCMP, TCG_TYPE_I64, ccmp_cond,
+                     reg2, TCG_REG_TMP2, ccmp_nzcv);
+    }
+}
+
+static void tgen_goto_jc(TCGContext *s, TCGReg ptr, TCGReg pc,
+                         TCGArg cs, bool const_cs,
+                         TCGArg fl, bool const_fl, TCGLabel *label)
+{
+    const TranslationBlock *tb = tcg_splitwx_to_rx(s->gen_tb);
+
+    /* ptr is CPUJumpCache */
+
+    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) !=
+                      offsetof(CPUJumpCache, array[0].tb) + 8);
+    tcg_out_insn(s, ldstpair, LDP, ptr, TCG_REG_TMP0, ptr,
+                 offsetof(CPUJumpCache, array[0].tb), 1, 0);
+
+    /*
+     * if (ptr == 0 || pc != tmp) goto label;
+     *
+     * z=cmp(ptr,0)
+     * if !z, z=cmp(pc,tmp), else z=0
+     * if !z, goto label
+     */
+    tgen_goto_jc_cmp_ccmp(s, ptr, 0, true, NULL,
+                          TCG_REG_TMP0, pc, false, NULL,
+                          TCG_COND_NE, 0b0000);
+    tgen_b_c(s, TCG_COND_NE, label);
+
+    /* ptr is now TranslationBlock */
+
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) !=
+                      offsetof(TranslationBlock, cs_base) + 8);
+    tcg_out_insn(s, ldstpair, LDP, TCG_REG_TMP0, TCG_REG_TMP1,
+                 ptr, offsetof(TranslationBlock, cs_base), 1, 0);
+    tcg_out_ld(s, TCG_TYPE_PTR, ptr, ptr, offsetof(TranslationBlock, tc.ptr));
+
+    /*
+     * if (cs != tmp0 || fl != tmp1) goto label;
+     *
+     * z=cmp(cs,tmp0)
+     * if z, z=cmp(fl,tmp1), else z=0
+     * if !z, goto label
+     *
+     * Since both comparisons are logically NE, sort the register or
+     * smaller immediate value second, where it is slightly more likely
+     * to be able to use CCMP (immediate).
+     */
+    if (!const_fl || (const_cs && fl < cs)) {
+        tgen_goto_jc_cmp_ccmp(s, TCG_REG_TMP0, cs, const_cs, &tb->cs_base,
+                              TCG_REG_TMP1, fl, const_fl,
+                              (const uint64_t *)&tb->flags,
+                              TCG_COND_EQ, 0b0000);
+    } else {
+        tgen_goto_jc_cmp_ccmp(s, TCG_REG_TMP1, fl, const_fl,
+                              (const uint64_t *)&tb->flags,
+                              TCG_REG_TMP0, cs, const_cs, &tb->cs_base,
+                              TCG_COND_EQ, 0b0000);
+    }
+    tgen_b_c(s, TCG_COND_NE, label);
+
+    tcg_out_goto_ptr(s, ptr);
+}
+
 static const TCGOutOpGotoJC outop_goto_jc = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O0_I4(r, rz, ri, ri),
+    .out = tgen_goto_jc,
 };
 
 static const tcg_insn_unit *tb_ret_addr;
-- 
2.53.0


