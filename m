Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36C1D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9I-00074C-0X; Tue, 22 Oct 2024 23:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S97-00070W-3C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008LT-Ir
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:52 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5e7ae4c504fso2818119eaf.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654478; x=1730259278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhq+IoN6vCvTOOHHSITV2/VutlKjJMMqJDBjbqbk8YI=;
 b=rM5I7UoeYdaTVv/H9dhbJSOOiOxk0tsZylTfC0KyrTWep3ZZgAbSlKoCVr0YdikXU3
 4kzRmkn57gPQLQ94aq/HG/ZF2R/22UnL/TGjR4GbseVYN0lLN6FXGqY0uCQxYc9kEj4n
 Q8dy4uS5Z+0+JbRZoCsfOdoNzBe+ApRRExhazfhD0L5b2FolpuhE1u1w+5YX5oW0DMoD
 KbIU2Hp+ogU87/3LHW6eBMi0By5BugmVpqlspj7s9pYHcEhu1Tu1hyIRe0L2+xB9uo3u
 LNlub+e/WD8RvKVoHvv5HsvIvCuHCrPqzRDjxxZEdANdk5VTTOoMP42eiR7GDfwMQEHT
 TfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654478; x=1730259278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xhq+IoN6vCvTOOHHSITV2/VutlKjJMMqJDBjbqbk8YI=;
 b=lQArgXjNvbIJlZ/vj/zKcVStjXjq6izX1wbHAa+uPKXU17wHK1ibstIbqdfs60dHcD
 6EIjExr3XEJHiphUw/fbm5O37mkv6MP/iULwrf4IPPBYcocb39hJvMx50+S8SCjbaeBk
 IypkHXJyd+4vkbsR9z1NJd304nUIXRv/+2TAaEtoTj0GOf2765k03g6/Io/N6sTqgsI1
 bHdkb3FB/Dd9DYm5CQfR4G8aSlDzftHodnzQednLfyE/lhakfvojzGcJ3odjXc0UilCd
 dAstnIkOJYz4oFfqkmiuSIXbkfawWE9PElmiqcLyauthrV2Otodo2U8Y1Z38e//Gg4GU
 vT4w==
X-Gm-Message-State: AOJu0YwbVqnX+zgK1z2HDKRPyRDxpcUXp33lRqHtvwvTtESLtI2Hs106
 03mjnQE/6S8hVauhkun5MaqwiJGLwUyS6FlTi40Jp4M5OJmc+Jq79W1lCvF0wOYAchHUPEZebs9
 B
X-Google-Smtp-Source: AGHT+IGskrdi0tozLtoVfDtZzqRoTfp9KkfovmDV6WFQQkNm/edPKWzFZBT77hFY76VulSxBXz5PjQ==
X-Received: by 2002:a05:6870:2045:b0:261:f8e:a37a with SMTP id
 586e51a60fabf-28ccb7f3a34mr1329181fac.14.1729654478517; 
 Tue, 22 Oct 2024 20:34:38 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 06/24] tcg/riscv: Add support for basic vector opcodes
Date: Tue, 22 Oct 2024 20:34:14 -0700
Message-ID: <20241023033432.1353830-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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
Message-ID: <20241007025700.47259-6-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |  3 ++
 tcg/riscv/tcg-target-con-str.h |  1 +
 tcg/riscv/tcg-target.h         |  2 +-
 tcg/riscv/tcg-target.c.inc     | 80 ++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d73a62b0f2..6513cebc4c 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -23,3 +23,6 @@ C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
+C_O1_I1(v, v)
+C_O1_I2(v, v, v)
+C_O1_I2(v, v, vK)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index b2b3211bcb..0aaad7b753 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -17,6 +17,7 @@ REGS('v', ALL_VECTOR_REGS)
  */
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_J12)
+CONST('K', TCG_CT_CONST_S5)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 12a7a37aaa..acb8dfdf16 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -151,7 +151,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_vec         0
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 17fcc21b0e..c8540f9a75 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -111,6 +111,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_N12   0x400
 #define TCG_CT_CONST_M12   0x800
 #define TCG_CT_CONST_J12  0x1000
+#define TCG_CT_CONST_S5   0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -129,6 +130,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
         return 1;
     }
+    if (type >= TCG_TYPE_V64) {
+        /* Val is replicated by VECE; extract the highest element. */
+        val >>= (-8 << vece) & 63;
+    }
     /*
      * Sign extended from 12 bits: [-0x800, 0x7ff].
      * Used for most arithmetic, as this is the isa field.
@@ -158,6 +163,13 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
         return 1;
     }
+    /*
+     * Sign extended from 5 bits: [-0x10, 0x0f].
+     * Used for vector-immediate.
+     */
+    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
+        return 1;
+    }
     return 0;
 }
 
@@ -310,6 +322,16 @@ typedef enum {
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 
+    OPC_VADD_VV = 0x57 | V_OPIVV,
+    OPC_VADD_VI = 0x57 | V_OPIVI,
+    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
+    OPC_VAND_VV = 0x24000057 | V_OPIVV,
+    OPC_VAND_VI = 0x24000057 | V_OPIVI,
+    OPC_VOR_VV = 0x28000057 | V_OPIVV,
+    OPC_VOR_VI = 0x28000057 | V_OPIVI,
+    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
+    OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -568,6 +590,12 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * With RVV 1.0, vs2 is the first operand, while rs1/imm is the
  * second operand.
  */
+static void tcg_out_opc_vv(TCGContext *s, RISCVInsn opc,
+                           TCGReg vd, TCGReg vs2, TCGReg vs1)
+{
+    tcg_out32(s, encode_v(opc, vd, vs1, vs2, true));
+}
+
 static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc,
                            TCGReg vd, TCGReg vs2, TCGReg rs1)
 {
@@ -580,6 +608,16 @@ static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
 }
 
+static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
+                              TCGReg vd, TCGReg vs2, TCGArg vi1, int c_vi1)
+{
+    if (c_vi1) {
+        tcg_out_opc_vi(s, o_vi, vd, vs2, vi1);
+    } else {
+        tcg_out_opc_vv(s, o_vv, vd, vs2, vi1);
+    }
+}
+
 typedef struct VsetCache {
     uint32_t movi_insn;
     uint32_t vset_insn;
@@ -2165,10 +2203,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2;
+    int c2;
 
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
+    c2 = const_args[2];
 
     switch (opc) {
     case INDEX_op_dupm_vec:
@@ -2180,6 +2220,30 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
+    case INDEX_op_add_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_sub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
+        break;
+    case INDEX_op_and_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_or_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_xor_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_not_vec:
+        set_vtype_len(s, type);
+        tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1);
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2196,6 +2260,13 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_not_vec:
+        return 1;
     default:
         return 0;
     }
@@ -2346,6 +2417,15 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_not_vec:
+        return C_O1_I1(v, v);
+    case INDEX_op_add_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+        return C_O1_I2(v, v, vK);
+    case INDEX_op_sub_vec:
+        return C_O1_I2(v, v, v);
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


