Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D25607077E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=XqfuX6ur
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgti-0004No-Kr; Wed, 04 Nov 2026 14:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtf-00048v-Jk
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:47 -0500
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtd-0002cY-Nq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:47 -0500
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-3550c917fd3so1610195eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821424; x=1794426224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wbh56d/pOn2MjN0iy7iGhATtIRZG9ILXVONxj3+pGlM=;
 b=XqfuX6urDuOVmwBHKTIvp8QYsO6yZxvPYV9zJ4xV7W9KUlrUomvPx2sO/ya7Qqho9c
 U6xTnVx/U8tTj0kgG3H8HP2YWC0exqfWD2xdwDJ3qHjdOydZrf/Th511cjqr+38YCQFm
 xABOHZ4UmLsQ3xZosMFS8Nl6QN46dohKSx66azi2YkCVDxrzIQfnoDtRV3aHdOl/z4oo
 ehsuCI73vGVvrKdvzNyNVrJQpL2Q89/hNvhM8+FEj39u4EV0212UG5rXefYZNcSOFYhy
 rEjPAAj5OjD5P54VymWnF9ybavHdobHF/vlR+pvqbputbavDmgI3CpznudiH575143Qu
 +dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821424; x=1794426224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wbh56d/pOn2MjN0iy7iGhATtIRZG9ILXVONxj3+pGlM=;
 b=g8a3dvOcC7l2x1uxItE6hhU1B5mOJJgxgDOnHZZO6/jQni6Fk4ctAriRbZ6GME0jxX
 jKlM2+5xvGMkwL+Ln/k0kp3vM/mPcHQemz21elhPiGXgTEHnJxT6BMjimKew5JBRtIUf
 7nT0r+9mFa+dNdMX12h2wn9pgMdl1WtqqQsjSibUt7SMhThvZ2gudRijGAeOdOdeOuJm
 b4XlHvAZ7t9ThkGTbJJNWvK4HlyX1yyUGptasruoPd8rzHVO0/vg5KjMaiK+Y2FmrJcv
 9dKS+QE/fH7pTGm/Qo3ELURfvdghkwYNtaogxiDwHPjNHofOdvShEh6gHABYahNe6cOs
 mfBw==
X-Gm-Message-State: APuU4Z9Q+B37EdzA5LSUo7wzdLHEjE/tbD52SW0wtUTp0lOvwf+5NJn7
 GCBe6eBt4nI4WfhwwiHCrv1UI3Zj3A2BcePmnohRkX40Z7u/B/AstH1a+7nsR3RP4OSPRRnEntl
 9ndpiz6vX/nQfVkqVXUWa/qZi/mH5XSHfxa3mhHjr7yjnh/F6b6A/rD17MDIFxoIFnZOfr9AHiA
 333Z3G0hYGsjBxEq3T4LSBlyiQBSy/XJlGxaCxgNeGFw==
X-Gm-Gg: AYBFou3YSY4LvcZEuGS1SVHZDxxYyD2VYvvYwNEKas+/YfAH2cvdAHgQp/ctHOdEG1s
 SfERONMhN9cOODOmCVQzOdmy0vk1WFCz3t6IL7vlz0cEpP+GmQqDeg2W79JgI1E/Z7wpdLC6JNw
 muNjXSnewKc9cDQTxr3yFILDJBaB30pCtW17PNqnku7c1xju832mXsiO9OwYkgyONLJ6Y8109zg
 rEVu68fokjdfJizk4ROwL0ffM7AQ5RX/HA+TgU7iTO+8FVarYmqJEAui44qKnNB30nlW9SIpcCe
 7PJGrGgz91VSLj0yPH0YQp867tjPoVDJ718Ub3vGWAczhWBWGJt4FlisC55v7mxCtnDjvugHDw8
 8RoHu0RVh02n01VWy29PL3+8H6XuXa+3VO3R6KfxzendF5l3a9FmnlKBCPHUbywFfUTpNfSge1k
 vl+YgxfjbEKZwG0+G7qTuHrvz2SFiDUJ8vZ0PVb7UVNCBRacw8U+GJWcjtd2nJx6JowayxpIrsc
 7dpmaPs4DNFVixPCA8sULcSEDxpLdku8VFDl/xtX/KOakK2Urmhf5yKGcdd0z/AwkDIVl98F/vY
 SQlPK1dwujtHp3lqeFoUoKfxy3xTp062iTi9PUSL8h3+wkK+zeh7JaDzhhdT1qYU2Q04nECbggQ
 lpXimXHXHWmT5huOkqOFJt3i2HjNz5Q==
X-Received: by 2002:a05:693c:60c9:b0:36c:a390:8907 with SMTP id
 5a478bee46e88-36ca3908cb8mr5450772eec.21.1793821424089; 
 Wed, 04 Nov 2026 11:43:44 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:43 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC PATCH 28/38] target/riscv: rvv: Implement Zvfwbdota16bf
 instruction
Date: Thu,  5 Nov 2026 03:41:43 +0800
Message-ID: <20261104194155.679241-29-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x132a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the vfwbdota.vv instruction from the Zvfwbdota16bf
extension.
This instruction performs a batched dot-product operation on BF16
vectors, accumulating into FP32

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                       |  2 +
 target/riscv/insn32.decode                  |  3 ++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 52 +++++++++++++++++++
 target/riscv/tcg/vector_helper.c            | 55 +++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 84571a999f4..1f2dfd6d557 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1395,6 +1395,8 @@ DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 
 /* Zvfwdota16bf - BF16 Dot Product */
 DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
+/* Zvfwbdota16bf - BF16 Batched Dot Product */
+DEF_HELPER_7(vfwbdota_vv, void, ptr, ptr, ptr, ptr, i32, env, i32)
 
 /* Zvfqwdota8f - OCP FP8 Dot Product */
 DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 8a06547a570..00ed64b73fd 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1105,6 +1105,9 @@ vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
 # *** Zvfwdota16bf BF16 Dot-Product Extension ***
 vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
 
+# *** Zvfwbdota16bf BF16 Batched Dot-Product Extension ***
+vfwbdota_vv 101100 . ..... ..... 001 ..... 1110111 @r_vm
+
 # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
 vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
 vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 650affc045b..d4678171ac5 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4365,3 +4365,55 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
 
 GEN_ZVBDOTA_INT_TRANS(vqwbdotau_vv, vext_vqwbdota_check)
 GEN_ZVBDOTA_INT_TRANS(vqwbdotas_vv, vext_vqwbdota_check)
+
+/* Zvfwbdota16bf BF16 Batched Dot-Product Extension */
+static bool vext_vfwbdota_check(DisasContext *s, arg_rmrr * a)
+{
+    int32_t sew = s->sew;
+    int32_t vd_eew = sew + 1;
+    return s->mstatus_fs != EXT_STATUS_DISABLED &&
+           vext_zvbdota_base_check(s, a, vd_eew) &&
+           (s->cfg_ptr->ext_zvfwbdota16bf && s->sew == MO_16 && s->altfmt == 1);
+}
+
+#define GEN_ZVBDOTA_FP_TRANS(NAME, CHECK, EEW_VD)                       \
+static bool trans_##NAME(DisasContext *s, arg_rmrr * a)                 \
+{                                                                       \
+    if (CHECK(s, a)) {                                                  \
+        TCGv_ptr dest, src1, src2, mask;                                \
+        TCGv_i32 ci, desc;                                              \
+        uint32_t data = 0;                                              \
+        uint32_t vlenb = s->cfg_ptr->vlenb;                             \
+        int32_t vd_emul = MAX(0, EEW_VD + 3 - ctzl(vlenb));             \
+                                                                        \
+        gen_set_rm(s, RISCV_FRM_DYN);                                   \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, vd_emul);                  \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
+                                                                        \
+        dest = tcg_temp_new_ptr();                                      \
+        mask = tcg_temp_new_ptr();                                      \
+        src1 = tcg_temp_new_ptr();                                      \
+        src2 = tcg_temp_new_ptr();                                      \
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
+                                          s->cfg_ptr->vlenb, data));    \
+        ci = tcg_constant_i32((a->rs2 & 0x7) << 3);                     \
+                                                                        \
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
+        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));           \
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2 & ~0x7));    \
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
+                                                                        \
+        gen_helper_##NAME(dest, mask, src1, src2, ci, tcg_env, desc);   \
+                                                                        \
+        finalize_rvv_inst(s);                                           \
+                                                                        \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_ZVBDOTA_FP_TRANS(vfwbdota_vv, vext_vfwbdota_check, MO_32)
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 873adf4d7a6..51170625aad 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -6201,3 +6201,58 @@ GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_b, 32, 8, uint8_t, H4, H1)
 GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_b, 32, 8, int8_t, H4, H1)
 GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_h, 64, 16, uint16_t, H8, H2)
 GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_h, 64, 16, int16_t, H8, H2)
+
+/*
+ * Zvfwbdota16bf: BF16 Batched Dot Product with Accumulation
+ */
+void HELPER(vfwbdota_vv)(void *vd, void *v0, void *vs1, void *vs2, uint32_t ci,
+                         CPURISCVState *env, uint32_t desc)
+{
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t vta = vext_vta(desc);
+    uint32_t vta_all_1s = vext_vta_all_1s(desc);
+    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;
+    uint32_t vd_emul = vext_lmul(desc);
+    uint32_t log_esz = 2;
+    uint32_t total_elems = (vlenb << vd_emul) >> log_esz;
+    uint32_t vlmax = vlenb >> MO_16;
+    uint32_t n, k;
+    bfloat16 *a_vec, *b_vec;
+    float32 acc, dot_result;
+
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
+    a_vec = g_new0(bfloat16, vlmax);
+    b_vec = g_new0(bfloat16, vlmax);
+
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    for (n = 0; n < 8; n++) {
+        if (!vm && !vext_elem_mask(v0, ci + n)) {
+            continue;
+        }
+
+        for (k = 0; k < vl; k++) {
+            a_vec[k] = *((bfloat16 *)vs2 + n * vlmax + H2(k));
+            b_vec[k] = *((bfloat16 *)vs1 + H2(k));
+        }
+
+        dot_result = rvbna_dot_bfloat16_bfloat16(a_vec, b_vec, vlmax,
+                                                 &env->fp_status);
+        acc = *((float32 *)vd + H4(ci + n));
+        *((float32 *)vd + H4(ci + n)) = rvbna_final_f32_add(dot_result, acc,
+                                                            &env->fp_status);
+    }
+    riscv_cpu_check_fflags(env, pre_fflag);
+
+    g_free(a_vec);
+    g_free(b_vec);
+
+    env->vstart = 0;
+
+    if (ci + 8 < total_elems) {
+        if (vta_all_1s) {
+            vext_set_elems_1s(vd, vta, (ci + 8) * 4, total_elems * 4);
+        }
+    }
+}
-- 
2.56.0


