Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC86C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RET-0003Qf-TY; Fri, 25 Apr 2025 18:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB4-0003p0-5S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB1-0001th-6e
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:45 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso3815313b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618742; x=1746223542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLIrt9FcxJ0ZNV2kgjCLQtdcPNteFJW5HH49DliR1nU=;
 b=nHz/VpW48bM7IxmdIn3mxN4T+wSw1KEtTe1Gpj3OrbrmmXJ9havXWFmXg9xfiCXSsJ
 MmisCFlEHVUgTfkJTLUUSYohqFhcBHXuvAzAqj/38pUgtuWlcG0VT0t6sDvtkdpuwo/6
 3Rr20v8a7BhXl8rYLzbVLVEq5uoWJEDISsb0Ng25/r2yv+08/cXt9rKJpXC9ekP2glZU
 YgQqlz6D61CE2nZqZISQq24KghbqnQsZbUhNafdDfmrVCZJb27St3ah6O/Lb+mi0X87F
 kTEbpLP20yxp1e2key/msCCly4fVjoY9XqSlkHYimMYza+NbDLk4RgWnbRdP2Z6eYCth
 PtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618742; x=1746223542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLIrt9FcxJ0ZNV2kgjCLQtdcPNteFJW5HH49DliR1nU=;
 b=gZDXuGAMh4v6iXXwZUeHHZwqRPKaNqQIzbl2/hKjKPFxs3cv06QzaJnWKrzELRnmP/
 wHc3UBXe2V3pEy7N0ayiPo9uGOfim8aFTTiImOBSV/3s182qRf+w19Ao69Yz8+OBLX/L
 NjjW/CXh7uLTzaRUIHshd214+uYY1naWSaWtkVTunyswVKdYNapfaOCP9Wc6Z1gT+VYX
 jSunh39uMHmkNrItJnY8/dWWxFaGwhRqKiRerMr+IDZ727kHeAyOb33vI2UZmWBcGCbp
 8T6z1B/qY65biJL3mmfcWFNwKI6JjMTSGhWAUt7C2tpcS+hx2Ep976VJWpOtzYRXlvXv
 vGMg==
X-Gm-Message-State: AOJu0YwMkyUNTHfDnmHl858tXsS6inyTSH/GqB984RGHF5veXbV6iwBi
 /4SXkA/q80a3mWv9UcxECMhcjoVoKOmAlJUUVP/wVDmBAZjg0TH+qu1ZRuH7kIRneEsjQ0iL/SQ
 h
X-Gm-Gg: ASbGnctzAhJQZoiFL2ZcOkKSlvECMfI/w6IlI9VFjtkvGW0WY94+LL+NWVcHGRbkiwR
 UQRAefmBWkubdmRRc858TeCxGlQfTyKDFWkWqBH9iQSK8dY1CSKiout2tPRgl2lEVAIDE/Dii4S
 RWR9KzHT00ef1ybRW9B6W7A9yh3RRK4kHc0kRt1R3TnHeLpPns5w+JVheUmvUNZV6/VeX/TXSb4
 zaacLLcoSIgRn8Rz9bdpAKim6UsnrU9Q65vdZXdZJi1uW+BrFw++ZDZ3kBSKMRTjGgiaNojEreR
 ZksZSV9JgdkZXH/4ImRvx8cl6iHZMDjVMc2FGIejAXWGJ/AfkWshw1jec1yC9bv3gjHF7us6VXQ
 =
X-Google-Smtp-Source: AGHT+IEaH49pum7Rzjsu8hSKgdAlPSGTHti7FhiiGGDGLKiiEV8+RQNaJ9NF2SZcb/qzqgj5tOWotg==
X-Received: by 2002:a05:6a00:3903:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-73fd8f4d8bamr5856070b3a.20.1745618741737; 
 Fri, 25 Apr 2025 15:05:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 145/159] tcg/tci: Implement add/sub carry opcodes
Date: Fri, 25 Apr 2025 14:54:39 -0700
Message-ID: <20250425215454.886111-146-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target-has.h     |   8 +--
 tcg/tci.c                    | 120 +++++++++++++++++------------------
 tcg/tci/tcg-target-opc.h.inc |   1 +
 tcg/tci/tcg-target.c.inc     |  97 +++++++++++++++++-----------
 4 files changed, 125 insertions(+), 101 deletions(-)

diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
index 6063f32f7b..310d45ba62 100644
--- a/tcg/tci/tcg-target-has.h
+++ b/tcg/tci/tcg-target-has.h
@@ -8,13 +8,13 @@
 #define TCG_TARGET_HAS_H
 
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #endif /* TCG_TARGET_REG_BITS == 64 */
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/tci.c b/tcg/tci.c
index dc916eb112..a18478a07a 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -179,17 +179,6 @@ static void tci_args_rrrrrc(uint32_t insn, TCGReg *r0, TCGReg *r1,
     *c5 = extract32(insn, 28, 4);
 }
 
-static void tci_args_rrrrrr(uint32_t insn, TCGReg *r0, TCGReg *r1,
-                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGReg *r5)
-{
-    *r0 = extract32(insn, 8, 4);
-    *r1 = extract32(insn, 12, 4);
-    *r2 = extract32(insn, 16, 4);
-    *r3 = extract32(insn, 20, 4);
-    *r4 = extract32(insn, 24, 4);
-    *r5 = extract32(insn, 28, 4);
-}
-
 static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
 {
     bool result = false;
@@ -361,6 +350,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
                    / sizeof(uint64_t)];
+    bool carry = false;
 
     regs[TCG_AREG0] = (tcg_target_ulong)env;
     regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
@@ -369,13 +359,12 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
     for (;;) {
         uint32_t insn;
         TCGOpcode opc;
-        TCGReg r0, r1, r2, r3, r4, r5;
+        TCGReg r0, r1, r2, r3, r4;
         tcg_target_ulong t1;
         TCGCond condition;
         uint8_t pos, len;
         uint32_t tmp32;
         uint64_t tmp64, taddr;
-        uint64_t T1, T2;
         MemOpIdx oi;
         int32_t ofs;
         void *ptr;
@@ -444,9 +433,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 #if TCG_TARGET_REG_BITS == 32
         case INDEX_op_setcond2_i32:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
-            T1 = tci_uint64(regs[r2], regs[r1]);
-            T2 = tci_uint64(regs[r4], regs[r3]);
-            regs[r0] = tci_compare64(T1, T2, condition);
+            regs[r0] = tci_compare64(tci_uint64(regs[r2], regs[r1]),
+                                     tci_uint64(regs[r4], regs[r3]),
+                                     condition);
             break;
 #elif TCG_TARGET_REG_BITS == 64
         case INDEX_op_setcond:
@@ -471,6 +460,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
             regs[r0] = *(tcg_target_ulong *)ptr;
             break;
+        case INDEX_op_tci_setcarry:
+            carry = true;
+            break;
 
             /* Load/store operations (32 bit). */
 
@@ -575,6 +567,46 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
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
@@ -673,22 +705,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tb_ptr = ptr;
             }
             break;
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_add2_i32
-        case INDEX_op_add2_i32:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 + T2);
-            break;
-#endif
-#if TCG_TARGET_REG_BITS == 32 || TCG_TARGET_HAS_sub2_i32
-        case INDEX_op_sub2_i32:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = tci_uint64(regs[r3], regs[r2]);
-            T2 = tci_uint64(regs[r5], regs[r4]);
-            tci_write_reg64(regs, r1, r0, T1 - T2);
-            break;
-#endif
         case INDEX_op_bswap16:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap16(regs[r1]);
@@ -742,24 +758,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
             break;
-#if TCG_TARGET_HAS_add2_i64
-        case INDEX_op_add2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] + regs[r4];
-            T2 = regs[r3] + regs[r5] + (T1 < regs[r2]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
-#endif
-#if TCG_TARGET_HAS_add2_i64
-        case INDEX_op_sub2_i64:
-            tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-            T1 = regs[r2] - regs[r4];
-            T2 = regs[r3] - regs[r5] - (regs[r2] < regs[r4]);
-            regs[r0] = T1;
-            regs[r1] = T2;
-            break;
-#endif
 
             /* Shift/rotate operations (64 bit). */
 
@@ -908,7 +906,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     const char *op_name;
     uint32_t insn;
     TCGOpcode op;
-    TCGReg r0, r1, r2, r3, r4, r5;
+    TCGReg r0, r1, r2, r3, r4;
     tcg_target_ulong i1;
     int32_t s2;
     TCGCond c;
@@ -968,6 +966,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), ptr);
         break;
 
+    case INDEX_op_tci_setcarry:
+        info->fprintf_func(info->stream, "%-12s", op_name);
+        break;
+
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i32:
@@ -1007,6 +1009,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_add:
+    case INDEX_op_addci:
+    case INDEX_op_addcio:
+    case INDEX_op_addco:
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_clz:
@@ -1027,6 +1032,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_sub:
+    case INDEX_op_subbi:
+    case INDEX_op_subbio:
+    case INDEX_op_subbo:
     case INDEX_op_xor:
     case INDEX_op_tci_ctz32:
     case INDEX_op_tci_clz32:
@@ -1071,16 +1079,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            str_r(r2), str_r(r3));
         break;
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        tci_args_rrrrrr(insn, &r0, &r1, &r2, &r3, &r4, &r5);
-        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
-                           op_name, str_r(r0), str_r(r1), str_r(r2),
-                           str_r(r3), str_r(r4), str_r(r5));
-        break;
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
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
index bba96d7a19..35c0c91f3e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -66,12 +66,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, r, r, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
@@ -346,22 +340,6 @@ static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
-static void tcg_out_op_rrrrrr(TCGContext *s, TCGOpcode op,
-                              TCGReg r0, TCGReg r1, TCGReg r2,
-                              TCGReg r3, TCGReg r4, TCGReg r5)
-{
-    tcg_insn_unit insn = 0;
-
-    insn = deposit32(insn, 0, 8, op);
-    insn = deposit32(insn, 8, 4, r0);
-    insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 16, 4, r2);
-    insn = deposit32(insn, 20, 4, r3);
-    insn = deposit32(insn, 24, 4, r4);
-    insn = deposit32(insn, 28, 4, r5);
-    tcg_out32(s, insn);
-}
-
 static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
                          TCGReg base, intptr_t offset)
 {
@@ -573,21 +551,50 @@ static const TCGOutOpBinary outop_add = {
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
@@ -910,21 +917,45 @@ static const TCGOutOpSubtract outop_sub = {
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
@@ -1129,12 +1160,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(add2)
-    CASE_32_64(sub2)
-        tcg_out_op_rrrrrr(s, opc, args[0], args[1], args[2],
-                          args[3], args[4], args[5]);
-        break;
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
-- 
2.43.0


