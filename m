Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B00C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskPP-0007Ww-0j; Thu, 13 Mar 2025 11:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tskPL-0007Ta-3E
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:23:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tskPI-0001fW-7d
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:23:38 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso652141f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1741879414; x=1742484214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKtNdPa7LTv10WYlPiVYfpqgYoxHOE+GIe+ymVWq8ik=;
 b=FT7oT5zzPg2NkvgyhsTGwH6HW8N6BpAtFQghFgqVWVM4vws+cYWnfpyq20/yutAYxM
 Iae3LSxx4dkLpozXIV0m9aiptx0iwhfG22TaBOLAe7zaWh/aGSMak3iJYWMYXT3EKNRI
 B9SkJYezAh4lX21dHA6puXDI0ozrkKb+Hj8cvg9uL+WbQT+15c6osY/Zf1oz71rv8V5v
 DamotLLHL3ooofF5XM9u3IG9nIz3RIM7q2bKFwEReDlOV1T/1Wi8COjPtJrANxIbAofg
 geSttBlnIa5lGOHq6/fGVd3AJvoylKdf3HJGAZoDsCZdfzPei25HGYEpJE1Bbv1kRAFg
 ZJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741879414; x=1742484214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKtNdPa7LTv10WYlPiVYfpqgYoxHOE+GIe+ymVWq8ik=;
 b=dlPzMXdrk3MaUNSelIvIUN5voV5E2ogiUIOZQnTJEQI+rtki4xNuriSvK4tlW7cXt9
 icAWg5ZI2p6svnkl+K/eyf4A6LLwFzI5rc5OQWhzvavCRaTvbZdQRHBc1lNm2JYKX8HU
 QClVjcWl0Bx78hYzdQU6GLrwfttsQnpMxApCf5XROit/swyQsPghPj+qmD8wK7KiX2vF
 vnIDT/LKUVD8nVpD0uapTYOJ7R9R70VskXMb3eNyGjMTSKDXq1WZ90HUUCRf6QUNLnmH
 0eSvYuov4/78iO4DqJF1lQthUMIBU+XMMfTlLoXb7FC7Bu42QFkN3opq0wY/DFeZJ3wt
 oPQw==
X-Gm-Message-State: AOJu0Yxo/qZoo0eTuQcNnUdzeaRVeUNPfc/U+zL7gXpFvm4qRbWoE1Km
 sjejfpN8XOBGCC7jb+9kYlZo+SnJLazDuf5BgDRy8ZWw2OFsVBoHQDNiqqYccZnz/Mm9eQCvgdJ
 gK8P1WQ==
X-Gm-Gg: ASbGncv1dBA6+UdI7DsDe2DzeFr71gz5Zm+HW/lbtKin0hk12jRjsY//5WJO6oBoE5X
 l4wNsKoaD5i80hkfS1omss8+4wNZL3sWQwtBdIP446LGT5bmqv5ZxfRcleNF6n0ZWOsSeibphie
 OMEuRnBug8aYghyUziMxlin6HTm6aVO3Bv0od5nNCcRwiU8hY31jaUCconM96vld8Vop1dhUioE
 PxakW1+CtpBUgHpccV8xrhpaQ7cxEebpLEH4PohJwn1laW8fOr1rbkiYBGYSKLfx5HzTFIWO6sl
 v0hZysCklNchwAUvzbwJkcx3xYyqi50ZCAhqCUzpbeTzkJyte5jF/sVwH50M6o4N+tdHjC3I6HV
 0CpDt+Sgq6GvjGUTd07CB
X-Google-Smtp-Source: AGHT+IFsyDOX/Blc9E5oymCi/EBrqc8obx2uTyb4Wb4BpLsSCqIFSGMyCTUh3DNfx4wi32ATfXSnmQ==
X-Received: by 2002:a5d:47a2:0:b0:391:31c8:ba6b with SMTP id
 ffacd0b85a97d-39132d77343mr20285183f8f.10.1741879414375; 
 Thu, 13 Mar 2025 08:23:34 -0700 (PDT)
Received: from paolo-laptop-amd.sou.embecosm-corp.com ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ebaedsm2462868f8f.90.2025.03.13.08.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 08:23:34 -0700 (PDT)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/1 v4] target/riscv: use tcg ops generation to emulate whole
 reg rvv loads/stores.
Date: Thu, 13 Mar 2025 15:23:30 +0000
Message-ID: <20250313152330.398396-2-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313152330.398396-1-paolo.savini@embecosm.com>
References: <20250313152330.398396-1-paolo.savini@embecosm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wr1-x435.google.com
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

This patch replaces the use of a helper function with direct tcg ops generation
in order to emulate whole register loads and stores. This is done in order to
improve the performance of QEMU.
We still use the helper function when vstart is not 0 at the beginning of the
emulation of the whole register load or store or when we would end up generating
partial loads or stores of vector elements (e.g. emulating 64 bits element loads
with pairs of 32 bits loads on hosts with 32 bits registers).
The latter condition ensures that we are not surprised by a trap in mid-element
and consecutively that we can update vstart correctly.
We also use the helper function when it performs better than tcg for specific
combinations of vector length, number of fields and element size.

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Handerson <richard.henderson@linaro.org>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: "Alex Bennée" <alex.bennee@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 155 +++++++++++++++++-------
 1 file changed, 108 insertions(+), 47 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..2914efbb2b 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1100,25 +1100,86 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
 typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
-                             gen_helper_ldst_whole *fn,
-                             DisasContext *s)
+                             uint32_t log2_esz, gen_helper_ldst_whole *fn,
+                             DisasContext *s, bool is_load)
 {
-    TCGv_ptr dest;
-    TCGv base;
-    TCGv_i32 desc;
-
-    uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
-    data = FIELD_DP32(data, VDATA, VM, 1);
-    dest = tcg_temp_new_ptr();
-    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
-                                      s->cfg_ptr->vlenb, data));
-
-    base = get_gpr(s, rs1, EXT_NONE);
-    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
-
     mark_vs_dirty(s);
 
-    fn(dest, base, tcg_env, desc);
+    /*
+     * Load/store multiple bytes per iteration.
+     * When possible do this atomically.
+     * Update vstart with the number of processed elements.
+     * Use the helper function if either:
+     * - vstart is not 0.
+     * - the target has 32 bit registers and we are loading/storing 64 bit long
+     *   elements. This is to ensure that we process every element with a single
+     *   memory instruction.
+     */
+
+    bool use_helper_fn = !(s->vstart_eq_zero) ||
+                          (TCG_TARGET_REG_BITS == 32 && log2_esz == 3);
+
+    if (!use_helper_fn) {
+        TCGv addr = tcg_temp_new();
+        uint32_t size = s->cfg_ptr->vlenb * nf;
+        TCGv_i64 t8 = tcg_temp_new_i64();
+        TCGv_i32 t4 = tcg_temp_new_i32();
+        MemOp atomicity = MO_ATOM_NONE;
+        if (log2_esz == 0) {
+            atomicity = MO_ATOM_NONE;
+        } else {
+            atomicity = MO_ATOM_IFALIGN_PAIR;
+        }
+        if (TCG_TARGET_REG_BITS == 64) {
+            for (int i = 0; i < size; i += 8) {
+                addr = get_address(s, rs1, i);
+                if (is_load) {
+                    tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
+                            MO_LE | MO_64 | atomicity);
+                    tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                } else {
+                    tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                    tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
+                            MO_LE | MO_64 | atomicity);
+                }
+                if (i == size - 8) {
+                    tcg_gen_movi_tl(cpu_vstart, 0);
+                } else {
+                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
+                }
+            }
+        } else {
+            for (int i = 0; i < size; i += 4) {
+                addr = get_address(s, rs1, i);
+                if (is_load) {
+                    tcg_gen_qemu_ld_i32(t4, addr, s->mem_idx,
+                            MO_LE | MO_32 | atomicity);
+                    tcg_gen_st_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
+                } else {
+                    tcg_gen_ld_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
+                    tcg_gen_qemu_st_i32(t4, addr, s->mem_idx,
+                            MO_LE | MO_32 | atomicity);
+                }
+                if (i == size - 4) {
+                    tcg_gen_movi_tl(cpu_vstart, 0);
+                } else {
+                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_esz);
+                }
+            }
+        }
+    } else {
+        TCGv_ptr dest;
+        TCGv base;
+        TCGv_i32 desc;
+        uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
+        data = FIELD_DP32(data, VDATA, VM, 1);
+        dest = tcg_temp_new_ptr();
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                        s->cfg_ptr->vlenb, data));
+        base = get_gpr(s, rs1, EXT_NONE);
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+        fn(dest, base, tcg_env, desc);
+    }
 
     finalize_rvv_inst(s);
     return true;
@@ -1128,42 +1189,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
  * load and store whole register instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 7.9)
  */
-#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                                \
-static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
-{                                                                         \
-    if (require_rvv(s) &&                                                 \
-        QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
-        return ldst_whole_trans(a->rd, a->rs1, ARG_NF,                    \
-                                gen_helper_##NAME, s);                    \
-    }                                                                     \
-    return false;                                                         \
-}
-
-GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
-GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
-GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
-GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
-GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
-GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
-GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
-GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
-GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
-GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
-GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
-GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
-GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
-GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
-GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
-GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
+#define GEN_LDST_WHOLE_TRANS(NAME, ETYPE, ARG_NF, IS_LOAD)                  \
+static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                   \
+{                                                                           \
+    if (require_rvv(s) &&                                                   \
+        QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                   \
+        return ldst_whole_trans(a->rd, a->rs1, ARG_NF, ctzl(sizeof(ETYPE)), \
+                                gen_helper_##NAME, s, IS_LOAD);             \
+    }                                                                       \
+    return false;                                                           \
+}
+
+GEN_LDST_WHOLE_TRANS(vl1re8_v,  int8_t,  1, true)
+GEN_LDST_WHOLE_TRANS(vl1re16_v, int16_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl1re32_v, int32_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl1re64_v, int64_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl2re8_v,  int8_t,  2, true)
+GEN_LDST_WHOLE_TRANS(vl2re16_v, int16_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl2re32_v, int32_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl2re64_v, int64_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl4re8_v,  int8_t,  4, true)
+GEN_LDST_WHOLE_TRANS(vl4re16_v, int16_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl4re32_v, int32_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl4re64_v, int64_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl8re8_v,  int8_t,  8, true)
+GEN_LDST_WHOLE_TRANS(vl8re16_v, int16_t, 8, true)
+GEN_LDST_WHOLE_TRANS(vl8re32_v, int32_t, 8, true)
+GEN_LDST_WHOLE_TRANS(vl8re64_v, int64_t, 8, true)
 
 /*
  * The vector whole register store instructions are encoded similar to
  * unmasked unit-stride store of elements with EEW=8.
  */
-GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
-GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
-GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
-GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
+GEN_LDST_WHOLE_TRANS(vs1r_v, int8_t, 1, false)
+GEN_LDST_WHOLE_TRANS(vs2r_v, int8_t, 2, false)
+GEN_LDST_WHOLE_TRANS(vs4r_v, int8_t, 4, false)
+GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
 
 /*
  *** Vector Integer Arithmetic Instructions
-- 
2.34.1


