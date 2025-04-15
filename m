Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E693C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mI1-0004WS-OI; Tue, 15 Apr 2025 15:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mBk-0001Uy-HU
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:22 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAf-0007Zo-03
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:20 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c07cd527e4so544840885a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746123; x=1745350923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dWNGKKhJgIDty3tW+9S0XZ9GNS5MAM0q41XF0iwuPDo=;
 b=VuA4lD5bRWwBp2BUOYEieGXXNKxerH1GVvJoHyR4DbsoG2/ZX1HSXy5p7ma8IZrrJy
 EF48H9fe2Hi/KiNRZSmWAfRsWK3A5kFwSgHo2/vmGVgGGU4mIUDqSv15Ovl0e294YSXV
 yVGXz+6Qs0N1ge7ZYP5dS+D0QDc2CcW8k2yEsZ0+/5cL+UtuxP44I7bG0+xW7BUQ6hJT
 pt0mT12334MviVD0XiV54IAqHt18adlz+hV5RGXUjxK36MRhVfJlad+x82OjxAE0+hni
 ATkZmyl+X7S5af+mljVBZt0mfzqolTBz0ghUr0Yiak2YolQ+jiPixXKctiIJ6iR4xSO+
 tZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746123; x=1745350923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWNGKKhJgIDty3tW+9S0XZ9GNS5MAM0q41XF0iwuPDo=;
 b=EnHWaJOMSvR9WyPxjPay71XaBWBKKlI3uRE4dUcR1dJ45Bcx7v3z+431JnDxJX4R4n
 jdT2HQTO15ykqNU23KxLn3a6zWF0jqJ0+GC6NTXrrMQ21r/iy3589U7CJpjBFyNP9hX+
 Sk62guGjz2BTp10cSMYBC9TGRycpNdc5GhMJxbeCiPGAHuxwPc7a8OWmFEZG166Cvu2j
 Pcc2HoeNCCwTzGpgTm5WS3IQKEsBNRk86+6Ga1Mbjxbs3lC3r+lakfz7L4PxgVYGJ7HH
 tOB/wVI9jfrV9lIRJVenv/osbvxD1Jp1c3h+hwmmzlwGkA8b9zwLVwO6BUju3+A4+4GV
 u1SQ==
X-Gm-Message-State: AOJu0Yy6zRsa99MKfmhgygSZ5mf/34tr0l4mUWT00dJeDMjmE/DO3GHT
 yEcT7usz7rpL/N3zhW5QdNAKpxtNL44EFEknO3G7yb/7bd6A98i11wfX/PYfwkg0A7WwDKAEoYY
 V
X-Gm-Gg: ASbGncunzSAyyzg27U8gte/oDPzxtOud8lhuqcynI2d3//ZLXqv2F3J1J9AqOWKYbZQ
 lP1Ux1elCcJN9dZ6L3NZcALvKxLbDZ8H7B9+12AmC7Vm+GuFKqfzJY4f/IfnFvmnr03qWArGyQd
 NLr8JrZvQnwyhhzrkUkAhc3/zye+pi1XYLYvLP9rhm6IQta/jSprNVsLFQOwAhC0xmydiB8GB6g
 /ahN8SzMEA6RNxxR7r4EmOhlmXEijPkK8ZEVkIIPxaXlLVfM4ft6+jL7flgeAaVU86suF0IQXZw
 SgMOsf0s6SMCbqPtsEihBvX/ahQE4rld8OprKumuFYRNX36q1beZUJ2Ic/Jce9vZMiG9YHZWIwX
 EKSOCkySDyw==
X-Google-Smtp-Source: AGHT+IHNzVsz/IUOtYrPVUTdeJPoIf2wV+YpzMeHJE4PX9kH9St9lsultV3Cp/oCDcP84/QJBgGyww==
X-Received: by 2002:a05:6a00:a91:b0:736:57cb:f2aa with SMTP id
 d2e1a72fcca58-73c1f978832mr1078996b3a.13.1744745778255; 
 Tue, 15 Apr 2025 12:36:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 147/163] tcg/tci: Implement add/sub carry opcodes
Date: Tue, 15 Apr 2025 12:24:58 -0700
Message-ID: <20250415192515.232910-148-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c                    | 54 ++++++++++++++++++++++++++++
 tcg/tci/tcg-target-opc.h.inc |  1 +
 tcg/tci/tcg-target.c.inc     | 69 +++++++++++++++++++++++++++++++-----
 3 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index dc916eb112..d65ff2b8f1 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -361,6 +361,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
                    / sizeof(uint64_t)];
+    bool carry = false;
 
     regs[TCG_AREG0] = (tcg_target_ulong)env;
     regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
@@ -471,6 +472,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
             regs[r0] = *(tcg_target_ulong *)ptr;
             break;
+        case INDEX_op_tci_setcarry:
+            carry = true;
+            break;
 
             /* Load/store operations (32 bit). */
 
@@ -575,6 +579,46 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ctpop_tr(regs[r1]);
             break;
+        case INDEX_op_addco:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            t1 = regs[r1] + regs[r2];
+            carry = t1 < regs[r1];
+            regs[r0] = t1;
+            break;
+        case INDEX_op_addci:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] + regs[r2] + carry;
+            break;
+        case INDEX_op_addcio:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (carry) {
+                t1 = regs[r1] + regs[r2] + 1;
+                carry = t1 <= regs[r1];
+            } else {
+                t1 = regs[r1] + regs[r2];
+                carry = t1 < regs[r1];
+            }
+            regs[r0] = t1;
+            break;
+        case INDEX_op_subbo:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            carry = regs[r1] < regs[r2];
+            regs[r0] = regs[r1] - regs[r2];
+            break;
+        case INDEX_op_subbi:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] - regs[r2] - carry;
+            break;
+        case INDEX_op_subbio:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (carry) {
+                carry = regs[r1] <= regs[r2];
+                regs[r0] = regs[r1] - regs[r2] - 1;
+            } else {
+                carry = regs[r1] < regs[r2];
+                regs[r0] = regs[r1] - regs[r2];
+            }
+            break;
         case INDEX_op_muls2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
 #if TCG_TARGET_REG_BITS == 32
@@ -968,6 +1012,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), ptr);
         break;
 
+    case INDEX_op_tci_setcarry:
+        info->fprintf_func(info->stream, "%-12s", op_name);
+        break;
+
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
@@ -1007,6 +1055,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_add:
+    case INDEX_op_addci:
+    case INDEX_op_addcio:
+    case INDEX_op_addco:
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
@@ -1027,6 +1078,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_sub:
+    case INDEX_op_subbi:
+    case INDEX_op_subbio:
+    case INDEX_op_subbo:
     case INDEX_op_xor:
     case INDEX_op_tci_ctz32:
     case INDEX_op_tci_clz32:
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 672d9b7323..4eb32ed736 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -2,6 +2,7 @@
 /* These opcodes for use between the tci generator and interpreter. */
 DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_setcarry, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index bba96d7a19..947aa1aada 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -573,21 +573,50 @@ static const TCGOutOpBinary outop_add = {
     .out_rrr = tgen_add,
 };
 
+static TCGConstraintSetIndex cset_addsubcarry(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addco, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addco,
 };
 
+static void tgen_addci(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addci, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addci,
 };
 
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addcio, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addcio,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_op_v(s, INDEX_op_tci_setcarry);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -910,21 +939,45 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbo, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbo,
 };
 
+static void tgen_subbi(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbi, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbi,
 };
 
+static void tgen_subbio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbio, a0, a1, a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbio,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_op_v(s, INDEX_op_tci_setcarry);  /* borrow == carry */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


