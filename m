Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD698D2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9T-0007Os-Nt; Tue, 22 Oct 2024 23:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S97-00070V-2e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008LM-JM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so3926856a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654478; x=1730259278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGj9NIqRgmgSLRSzX3rBNungML5CHycRbRnnDre79Nc=;
 b=uPF3sBLLo9AWYvvxR9PXAHHj4+IMtqWcSaKfd5FmhVzcm/ZYbgp6dgXjqeI+ctA9mz
 UoNRqfBDgMNZzKn/SqqIchXwZDL5ojlq9Dvoiv1Fl9BRn4lCIBXVgfob4Lqz/uSfseaA
 PhhvHiLpVSmkyJfddvz7pVncTq80A7dktbwMFUjrWkZuvSG9gauHvqC46vXmlWaaZPR2
 NPqx2dyVW6VyiaCMLiqpZT+AT/kaV8y4QL5uBn27e107F2MDb6t6RqsJ1ddPrII9BQTn
 9GF6ck0MKjazPJkW8FbPD1hC/ANRqnJt6Dmcvsyg+JR9umY1T0mdESaFV908VHOHiJzr
 Rx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654478; x=1730259278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGj9NIqRgmgSLRSzX3rBNungML5CHycRbRnnDre79Nc=;
 b=a0MH+KKCIn5g7vNvfUqk+6yqpmRltmh5bFhspmZwb4KyCW58n7sl5HujQVyElWa2LM
 5jBwXKN6I2DDxkCIK9Gd1PBlEV2eynofWFyZG0ZzIyga0ojlHDHaFjHymybYCzbMUFc8
 xXF0VY5sBBiiIexjbfMuXQbNr1XAGAGaA/X2LLf+3IZvwkiKHJyFUgGQm3NNsGLShcNa
 zMVW0tKFr2CF6gwKnER+T9pbUFOmKYBamuWtCM8exL0mlUbkRkJeSUXgox5TxkjW8gWz
 NJN7EoC1L22Xg3MgYWEsAizp/h7WjwRahZrioMDYiFM8R/CUhgqiq7nAaCUFQxOWihDr
 PKMg==
X-Gm-Message-State: AOJu0YzAYEDOQTH1rWsWtn1Uk0zw4LWNL+EbQ44y7Fd07Q0hPXWYk2Fw
 D2a8j6fJIHIifwWBOcU1Zrio72wqyHfdNOPewyAHdF+2VAlszyks/WwAvFJO2MXoR5D5bEF25Nc
 n
X-Google-Smtp-Source: AGHT+IGifp7iboN4pqpKDpe4dSfSTlYs31mKgGGgycwU4LB3fufQ3D0k6DlVHTLp2aseEC8SAwA8OQ==
X-Received: by 2002:a05:6a21:1191:b0:1cc:9f25:54d4 with SMTP id
 adf61e73a8af0-1d978bad20amr1542020637.38.1729654477726; 
 Tue, 22 Oct 2024 20:34:37 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 05/24] tcg/riscv: Implement vector mov/dup{m/i}
Date: Tue, 22 Oct 2024 20:34:13 -0700
Message-ID: <20241023033432.1353830-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-5-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 76 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 38d71111c9..17fcc21b0e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -309,6 +309,12 @@ typedef enum {
     OPC_VS2R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(1),
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
+
+    OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
+    OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
+    OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
+
+    OPC_VMVNR_V = 0x9e000057 | V_OPIVI,
 } RISCVInsn;
 
 /*
@@ -401,6 +407,16 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
 
+
+/* Type-OPIVI */
+
+static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
+                         TCGReg vs2, bool vm)
+{
+    return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
+           (vs2 & 0x1f) << 20 | (vm << 25);
+}
+
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
 
 static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
@@ -546,6 +562,24 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * RISC-V vector instruction emitters
  */
 
+/*
+ * Vector registers uses the same 5 lower bits as GPR registers,
+ * and vm=0 (vm = false) means vector masking ENABLED.
+ * With RVV 1.0, vs2 is the first operand, while rs1/imm is the
+ * second operand.
+ */
+static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc,
+                           TCGReg vd, TCGReg vs2, TCGReg rs1)
+{
+    tcg_out32(s, encode_v(opc, vd, rs1, vs2, true));
+}
+
+static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
+                           TCGReg vd, TCGReg vs2, int32_t imm)
+{
+    tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
+}
+
 typedef struct VsetCache {
     uint32_t movi_insn;
     uint32_t vset_insn;
@@ -574,6 +608,13 @@ static MemOp set_vtype_len(TCGContext *s, TCGType type)
     return s->riscv_cur_vsew;
 }
 
+static void set_vtype_len_sew(TCGContext *s, TCGType type, MemOp vsew)
+{
+    if (type != s->riscv_cur_type || vsew != s->riscv_cur_vsew) {
+        set_vtype(s, type, vsew);
+    }
+}
+
 /*
  * TCG intrinsics
  */
@@ -588,6 +629,15 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_I64:
         tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
         break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        {
+            int lmul = type - riscv_lg2_vlenb;
+            int nf = 1 << MAX(lmul, 0);
+            tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -951,18 +1001,35 @@ static void tcg_out_addsub2(TCGContext *s,
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                                    TCGReg dst, TCGReg src)
 {
-    return false;
+    set_vtype_len_sew(s, type, vece);
+    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, src);
+    return true;
 }
 
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                                     TCGReg dst, TCGReg base, intptr_t offset)
 {
-    return false;
+    tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
+    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
                                     TCGReg dst, int64_t arg)
 {
+    /* Arg is replicated by VECE; extract the highest element. */
+    arg >>= (-8 << vece) & 63;
+
+    if (arg >= -16 && arg < 16) {
+        if (arg == 0 || arg == -1) {
+            set_vtype_len(s, type);
+        } else {
+            set_vtype_len_sew(s, type, vece);
+        }
+        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, 0, arg);
+        return;
+    }
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
+    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static const struct {
@@ -2104,6 +2171,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a2 = args[2];
 
     switch (opc) {
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
     case INDEX_op_ld_vec:
         tcg_out_ld(s, type, a0, a1, a2);
         break;
@@ -2272,6 +2342,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
+    case INDEX_op_dup_vec:
+    case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
     default:
-- 
2.43.0


