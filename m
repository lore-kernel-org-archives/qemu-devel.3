Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A360CF94B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=K5ORCwDX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtC-0002rk-Vq; Wed, 04 Nov 2026 14:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsu-0002X3-A7
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:01 -0500
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgsr-0002S8-DR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:00 -0500
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-36cedf1bd63so1173700eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821376; x=1794426176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ddXskcSP4FOaR2ojnycYDtZw7pbeJlnYbPdLt5Tk3oM=;
 b=K5ORCwDXGydQpEiHPTY9rmnJP47Pwn3pJ05EZHrZzY6TO1jtCZ8pODNow8DlIh9cIH
 K095iKvR9wB9VD75OWIujvJdgr/RZokna42ZiDRrAJAKW/PlQxsoRXB0xqkEZzl5RAy/
 uKoK1b+5eyYpnrejkHweYO+RVG49Ttzw2Q2vkz1MzInz0VMTYvWjAI+Lr2C4IZ0LprDr
 HUH6QevSoOrD+C68by5h9lpRtN9YjapeDyJQaaodA21CGkMzVuJtT/o/hycuSbIGmqMW
 zeoKV8EWaSowRP3pLAoKc55R6bGYLedxAAluiCff0VF1oA/WyVgjAyUB6KlKR7nyvdE/
 1j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821376; x=1794426176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ddXskcSP4FOaR2ojnycYDtZw7pbeJlnYbPdLt5Tk3oM=;
 b=PIPHf+lYI3YsxxJ4WR9SILv9RYzCnfJrWorg03PEqTjGLKhu3i/tAGs3TbLRTn6cgT
 8FDG8OFWPiraLXUNg1JXJFDH2z8+Yx+RxtSHx/RGzbPhQMQCpvPl71i1iOKs6zFr6T8/
 ++9N9QNECXUl84wPYKHu+plVVTVHInqzrzmRrUh1SKQnSMFIlUfn1y44yERrDwfhCcLD
 snlt0/AC56S4oEBFR96385oBt6LS7eRewfFhubgSrzbuDSEoGnonsY3wflzq6KMMPxev
 QpAA+ungLbqwTNNUUiH4Z9IFQnU4euEZWRo7MvENFS3RMAUu1ZZ5iMfCr8zlTX3RflEd
 bZBg==
X-Gm-Message-State: APuU4Z9izIblVyYz1YW060W58FGW8UFSZGYkAT5LvfxH5lwigg0HO3p6
 m8e5jB7ZWAVpl8M8ABSWXGcbdgbeWO6vE9gDTDPQKcgxHTgqcZtiB/XdryhVaVpdtd9UMUQvhAg
 BmECNjeTzevcUR1cENLytvEnah4wJzifcYbjr4JS0XnkPij+v8uag0cscT1VZE5p7HAtFpEGjmw
 t+SIAfyXSvQRQvw9B3BSeyCkUiKdV5jdwVtqH++WtIqQ==
X-Gm-Gg: AYBFou0iTXTlfXB/jdYfGuH/5eFdn0ApWmoZgVmEP2dq07AoNM7FtGVEYACJrVnrW3s
 SpVdEBU18p4SpAvpOAvXPUadMRe+1zPHdmjGD2jq8X0StfCUBzZZkKsWs715UEOzhnhp+YkIKww
 WjlEMzXgOuuh/cnaAnVRJdJ1Fn6M9bD7e0GN43Gjv1+U+MHTwOr7u2xsgXAXNLpFLHLQ78g8HXf
 cwdNG1CsTWhLo4XkxzOCSGXQljV20L5Oqa4OCxu/VJ1LYJDX9jbFC0/7NEt1e5m62avu+IKUTLq
 IisLnrKmPSxtlQE5HSerI1Df8e6ANpON1N3VtGsMgwgHsNhzGdehG0VsA4i3VrgXcAiCT4xlsQy
 JjxPYEY208mBrEKT5c1I0tsHkpZ2r/N526dVHlFlAg0Y9OtQB4uOjOQwJ/Fg0dirOOPI/9G/TPg
 ZZuzr2M2UmNrwz+llTO9ngaAEX9uUWncpYwHfKadzvH7R6GD+o24B2iLs8qQFqTgPQMpimrCyAw
 VxTnqZIKg6By691F5q9LGYwODwFdujCOjBVTiDmUz5axgko4kQHbwBzsdwbmH9EQIU5Co2ewcGx
 qSSjT1n4E0zLm/NXh+uJMMPYzIDcElqDj1wilXFX/LnL8eZZmSym3iNfAtuzKIsoS35ksUgNJBj
 I2vwXGdDCnqNIgn0HjYdyvKg8H0Io
X-Received: by 2002:a05:7022:b881:b0:145:ac96:3917 with SMTP id
 a92af1059eb24-1b24f4d380fmr554337c88.21.1793821375642; 
 Wed, 04 Nov 2026 11:42:55 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:42:55 -0800 (PST)
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
Subject: [RFC PATCH 13/38] target/riscv: rvv: Implement Zvfwdota16bf
 instruction
Date: Thu,  5 Nov 2026 03:41:28 +0800
Message-ID: <20261104194155.679241-14-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1333.google.com
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
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the vfwdota.vv instruction from the Zvfwdota16bf extension.
This instruction computes a dot product between two BF16 vectors,
accumulating into an FP32 scalar in vd[0].

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                       |  2 +
 target/riscv/insn32.decode                  |  3 ++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 42 ++++++++++++++++++
 target/riscv/tcg/vector_helper.c            | 48 +++++++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 23d3e9b3c43..918ff21b3e2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1393,6 +1393,8 @@ DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vqwdotau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 
+/* Zvfwdota16bf - BF16 Dot Product */
+DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
 /* SiFive Custom int8 Matrix-Multiply */
 DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b8a5d0567b1..d800ad99451 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1101,3 +1101,6 @@ vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
 # *** Zvqwdota8i/Zvqwdota16i Integer Dot-Product Extension ***
 vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
 vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
+
+# *** Zvfwdota16bf BF16 Dot-Product Extension ***
+vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index fcff472a2ea..c50f863ea0b 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4200,3 +4200,45 @@ GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
 
 GEN_ZVDOTA_INT_TRANS(vqwdotau_vv, vext_vqwdota_check)
 GEN_ZVDOTA_INT_TRANS(vqwdotas_vv, vext_vqwdota_check)
+
+static bool vext_vfwdota_check(DisasContext *s, arg_rmrr * a)
+{
+    return s->mstatus_fs != EXT_STATUS_DISABLED &&
+           vext_zvdota_base_check(s, a) &&
+           (s->cfg_ptr->ext_zvfwdota16bf && s->sew == MO_16 && s->altfmt == 1);
+}
+
+static bool trans_vfwdota_vv(DisasContext *s, arg_rmrr * a)
+{
+    if (vext_vfwdota_check(s, a)) {
+        TCGv_ptr dest, src1, src2, mask;
+        TCGv_i32 desc;
+        uint32_t data = 0;
+
+        gen_set_rm(s, RISCV_FRM_DYN);
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);
+
+        dest = tcg_temp_new_ptr();
+        mask = tcg_temp_new_ptr();
+        src1 = tcg_temp_new_ptr();
+        src2 = tcg_temp_new_ptr();
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,
+                                          data));
+
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));
+        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
+
+        gen_helper_vfwdota_vv(dest, mask, src1, src2, tcg_env, desc);
+
+        finalize_rvv_inst(s);
+
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 41b526d25ef..5947427b6b4 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -6025,3 +6025,51 @@ GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
 GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)
 GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_h, 64, 16, uint16_t, H8, H2)
 GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_h, 64, 16, int16_t, H8, H2)
+
+/*
+ * Zvfwdota16bf: BF16 Dot Product with Accumulation
+ */
+void HELPER(vfwdota_vv)(void *vd, void *v0, void *vs1, void *vs2,
+                        CPURISCVState *env, uint32_t desc)
+{
+    uint32_t vlmax = vext_max_elems(desc, 1);
+    uint32_t vm = vext_vm(desc);
+    uint32_t vl = env->vl;
+    uint32_t vta = vext_vta(desc);
+    uint32_t vta_all_1s = vext_vta_all_1s(desc);
+    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb >> 2;
+    uint32_t i;
+    bfloat16 *a_vec, *b_vec;
+    uint32_t dot_result, acc;
+
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
+    a_vec = g_new0(bfloat16, vlmax);
+    b_vec = g_new0(bfloat16, vlmax);
+
+    for (i = 0; i < vl; i++) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            continue;
+        }
+        a_vec[i] = *((uint16_t *)vs1 + H2(i));
+        b_vec[i] = *((uint16_t *)vs2 + H2(i));
+    }
+
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    dot_result = rvbna_dot_bfloat16_bfloat16(a_vec, b_vec, vlmax,
+                                             &env->fp_status);
+
+    acc = *((uint32_t *)vd + H4(0));
+    *((uint32_t *)vd + H4(0)) = rvbna_final_f32_add(dot_result, acc,
+                                                    &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+
+    g_free(a_vec);
+    g_free(b_vec);
+
+    env->vstart = 0;
+
+    if (vta_all_1s) {
+        vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);
+    }
+}
-- 
2.56.0


