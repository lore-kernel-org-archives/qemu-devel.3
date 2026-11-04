Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE82606A848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=NIxVYudE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtM-0003ID-Da; Wed, 04 Nov 2026 14:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtG-0002wk-MN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:23 -0500
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtE-0002WG-Nr
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:22 -0500
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-36a315ed211so1092081eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821399; x=1794426199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eN0sKqeH193m9ZPSfXJ0v60alO4ZgTObZSFjZJcSqL8=;
 b=NIxVYudE84oSwOu858BQi27ALEqS4lGD5sDGqfAW9pxIMZHqP9gLuf9tTLdSpyi9I4
 /501RtLnMnXBKfjcomaRgDjVVdCYz4p3BtUL/+NSaZeuh+BhezA7F0jH/OX0E3MM+O2p
 bxM3I0wEcaTRPyotKGzqtgo/PrHUwGGWZrhM4sqJAKuHEgjqfexsExMMjfD8B1bA7yto
 xnBIJggOPXoiSrTcLLHASmdc/k+h/eOX+OuDNxgV7Mmc0G9tC8xmqjcZQlwhumSgrRrU
 WpMX7e3FJvStfPoy7B1haA/LGcvtJx6Pm1pACAhVaaawGRTsOTECdvz0llZE9AnPJWVx
 KfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821399; x=1794426199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eN0sKqeH193m9ZPSfXJ0v60alO4ZgTObZSFjZJcSqL8=;
 b=ho/8Vp6Vj72oxkH+t5YoEnGsRZn2vf7mqLgQCOQKEszqjGNq3LQSUjUS5KGLvJ395c
 xovtS8tGsV823zsC8d6xpsQWLSvDjJGYDOIX2Cghuc2oZSYBgljwXvmJM0bJlD71crLk
 djm6ZyMW+YMtUUOD2xSw44zWCU1YvxFcfjdLrWBQvcba0+e4eZHtilTFf2F4I5WRiU7A
 Fq1ENP1UVhq/qMdC5CyDZaJ0+CSuakLmvtE+ymH8PyocPO7lFVeJtXaZm6qK+FDrP/db
 af8zLimOZh+5weJQyiT835C7IzDRWnxdWjAwggdDwGeNHYX29kycHxfTqUCAU5BWnZrT
 Z6bg==
X-Gm-Message-State: APuU4Z/DQKiIvow2/QLqqWGEkj0VmTdN53AfjgZ/Fy8KSHMak1eaAJ9L
 tZZiwYnez7RFPslI1P2g4YEQFF2txkhlL9rGdNH2/IucvBZ5CXq9Ed/ypHQgPAIrxPEe883pG56
 5xu0Je6TlzgEYw8jDhxtEYip0yGoLGkKoRU4iUS2aYEA4WyDTeibxfchoCvzrN+Zkf+fsquC57R
 kR041J0KyDLH9510dCBc1XMfesz4ZVZHDHHDRq8hhwBg==
X-Gm-Gg: AYBFou1YrsW+i43vkxmx2Kiq1M1rybKgFyuuX/M99t091+cvd3odn1gTOFjQbnTILZo
 rcrFrveQ0Qeph/WVu7Ru66cnGfJ6grd0Jf5ydUJVMDH+9g8Et6J+L6iG8xfR8ieCeEQX6+WTaCX
 7vs7HcDeDqOFMtNkHz4VaJBKMCOUCi4WZOonX+hFwfh6+2NixPKJQotbZTDfYy24JWmJesJT39v
 LZOZJGjNXtTlWfv0PkhwUyBH99sdT/U9rjsyHHrY/m8dwEEFvw3lMj9hpU66vx84vQdAZNg0q2z
 CiZsSdydLzBvwlmL4im/HtMGI4VYP4kkptynjOOmJOSYlmfQGiIJIYKmWnKE52ow3bbxPKkTLaA
 uTuu5fVmE2y6uEubTHIix7m+PmIjI7njx3AsbZBDngfv8eiMPRlL1Vm1EoljHW2R7saE7ZEp+sE
 zJbbbAoewpxYL4jRU9S2IB+oKdKff3ufVnqOhTcj6Lvg6haejAs4EtqCwLIBK2pVu5gRhZlT0xS
 vKhuXEXieh94tsr/VVP8QTV73fZdKX3yriA19RTGYS6PVf6aT+jv8J5WAyosA1X2pY1AC+q9w7B
 Mv8qWPs6ykStfQXkf85bsI7hzAP+0pSEWX7+keE25uT9ACJtpfHRuOTjW7GgV2Uy1RkIbBgeIA1
 e3m1OymgSGW4P4yrDVRS8xZr7B6hePhWwxSM0OsflNrOLoCn7Hg==
X-Received: by 2002:a05:7300:841c:b0:36a:2473:9b2f with SMTP id
 5a478bee46e88-36de743530bmr487524eec.23.1793821398912; 
 Wed, 04 Nov 2026 11:43:18 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:18 -0800 (PST)
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
Subject: [RFC PATCH 21/38] target/riscv: rvv: Implement Zvqwbdota8i
 instructions
Date: Thu,  5 Nov 2026 03:41:36 +0800
Message-ID: <20261104194155.679241-22-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1336.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implements the Zvqwbdota8i INT8 dot-product instructions:
- vqwbdotau.vv
- vqwbdotas.vv

The vqwbdotau.vv and vqwbdotas.vv instructions perform batched
dot-product operations on 8-bit integer vectors, computing 8 parallel
dot products and accumulating into 32-bit integers.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                       |  4 ++
 target/riscv/insn32.decode                  |  4 ++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 75 +++++++++++++++++++++
 target/riscv/tcg/vector_helper.c            | 56 +++++++++++++++
 4 files changed, 139 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 48c64f45748..e48b9b4edec 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1400,6 +1400,10 @@ DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
 
+/* Zvqwbdota8i - 8-bit Integer Batched Dot Product */
+DEF_HELPER_7(vqwbdotau_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
+DEF_HELPER_7(vqwbdotas_vv_b, void, ptr, ptr, ptr, ptr, i32, env, i32)
+
 /* SiFive Custom int8 Matrix-Multiply */
 DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index def5785f8e2..bf325229100 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1108,3 +1108,7 @@ vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
 # *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
 vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
 vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
+
+# *** Zvqwbdota8i 8-bit Integer Batched Dot-Product Extension ***
+vqwbdotau_vv  101110 . ..... ..... 000 ..... 1110111 @r_vm
+vqwbdotas_vv  101111 . ..... ..... 000 ..... 1110111 @r_vm
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 6eb22494838..bc12bcb9b72 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -4289,3 +4289,78 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
 
 GEN_ZVDOTA_FP8_TRANS(vfqwdota_vv, vext_vfqwdota_check)
 GEN_ZVDOTA_FP8_TRANS(vfqwdota_alt_vv, vext_vfqwdota_check)
+
+static bool vext_zvbdota_base_check(DisasContext *s, arg_rmrr * a,
+                                    int32_t vd_eew)
+{
+    int32_t vlenb = s->cfg_ptr->vlenb;
+    int32_t vd_emul = MAX(0, vd_eew + 3 - ctzl(vlenb));
+    uint8_t ci = a->rs2 & 0b111;
+    int rs2 = a->rs2 & ~0x7;
+
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           s->vstart_eq_zero &&
+           (s->lmul == 0) &&
+           ((ci << (3 + vd_eew)) < vlenb) &&
+           require_vm(a->vm, a->rd) &&
+           require_align(a->rd, vd_emul) &&
+           !is_overlapped(a->rd, 1 << vd_emul, a->rs1, 1) &&
+           !is_overlapped(a->rd, 1 << vd_emul, rs2, 8) &&
+           vext_check_input_eew(s, a->rs1, s->sew, rs2, s->sew, a->vm);
+}
+
+static bool vext_vqwbdota_check(DisasContext *s, arg_rmrr *a)
+{
+    int32_t sew = s->sew;
+    int32_t vd_eew = sew + 2;
+    return vext_zvbdota_base_check(s, a, vd_eew) &&
+           (s->cfg_ptr->ext_zvqwbdota8i && sew == MO_8);
+}
+
+typedef void gen_helper_zvbdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                    TCGv_i32, TCGv_env, TCGv_i32);
+
+#define GEN_ZVBDOTA_INT_TRANS(NAME, CHECK)                               \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                   \
+{                                                                        \
+    static gen_helper_zvbdota_int * const fns[2] = {                     \
+        gen_helper_##NAME##_b, NULL,                                     \
+    };                                                                   \
+    if (CHECK(s, a)) {                                                   \
+        TCGv_ptr dest, src1, src2, mask;                                 \
+        TCGv_i32 ci, desc;                                               \
+        uint32_t data = 0;                                               \
+        int32_t vd_eew = s->sew + 2;                                     \
+        int32_t vd_emul = MAX(0, vd_eew + 3 - ctzl(s->cfg_ptr->vlenb));  \
+                                                                         \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                       \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                     \
+        data = FIELD_DP32(data, VDATA, LMUL, vd_emul);                   \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                     \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);   \
+                                                                         \
+        dest = tcg_temp_new_ptr();                                       \
+        mask = tcg_temp_new_ptr();                                       \
+        src1 = tcg_temp_new_ptr();                                       \
+        src2 = tcg_temp_new_ptr();                                       \
+        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,             \
+                                          s->cfg_ptr->vlenb, data));     \
+        ci = tcg_constant_i32((a->rs2 & 0x7) << 3);                      \
+                                                                         \
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));             \
+        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));            \
+        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2 & ~0x7));     \
+        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                 \
+                                                                         \
+        fns[s->sew](dest, mask, src1, src2, ci, tcg_env, desc);          \
+                                                                         \
+        finalize_rvv_inst(s);                                            \
+                                                                         \
+        return true;                                                     \
+    }                                                                    \
+    return false;                                                        \
+}
+
+GEN_ZVBDOTA_INT_TRANS(vqwbdotau_vv, vext_vqwbdota_check)
+GEN_ZVBDOTA_INT_TRANS(vqwbdotas_vv, vext_vqwbdota_check)
diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index b1ca584f9ef..9e872eccaeb 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -6139,3 +6139,59 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
 
 GEN_VEXT_ZVDOTA_FP8(vfqwdota_vv, e4m3)
 GEN_VEXT_ZVDOTA_FP8(vfqwdota_alt_vv, e5m2)
+
+/*
+ * Zvqwbdota8i: 8-bit Integer Batched Dot Product with Accumulation
+ */
+#define GEN_VEXT_ZVBDOTA_INT(NAME, WD, W1, T2, HD, HS)                       \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,                  \
+                  uint32_t ci, CPURISCVState *env, uint32_t desc)            \
+{                                                                            \
+    uint32_t vm = vext_vm(desc);                                             \
+    uint32_t vl = env->vl;                                                   \
+    uint32_t vta = vext_vta(desc);                                           \
+    uint32_t vta_all_1s = vext_vta_all_1s(desc);                             \
+    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;                              \
+    uint32_t vd_emul = vext_lmul(desc);                                      \
+    uint32_t total_elems = (vlenb << vd_emul) >> ctzl(sizeof(uint##WD##_t)); \
+    uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);                  \
+    uint32_t n, k;                                                           \
+    uint32_t stride = vlenb >> ctzl(sizeof(uint##W1##_t));                   \
+    uint##WD##_t acc, dot_result, a;                                         \
+                                                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                        \
+                                                                             \
+    for (n = 0; n < 8; n++) {                                                \
+        if (!vm && !vext_elem_mask(v0, ci + n)) {                            \
+            continue;                                                        \
+        }                                                                    \
+                                                                             \
+        acc = *((uint##WD##_t *)vd + HD(ci + n));                            \
+        dot_result = 0;                                                      \
+                                                                             \
+        for (k = 0; k < vl; k++) {                                           \
+            uint##WD##_t b = *((T2 *)vs2 + n * stride + HS(k));              \
+            if (altfmt) {                                                    \
+                a = *((int##W1##_t *)vs1 + HS(k));                           \
+            } else {                                                         \
+                a = *((uint##W1##_t *)vs1 + HS(k));                          \
+            }                                                                \
+            dot_result += (a * b);                                           \
+        }                                                                    \
+                                                                             \
+        *((uint##WD##_t *)vd + HD(ci + n)) = acc + dot_result;               \
+    }                                                                        \
+                                                                             \
+    env->vstart = 0;                                                         \
+                                                                             \
+    if (ci + 8 < total_elems) {                                              \
+        if (vta_all_1s) {                                                    \
+            vext_set_elems_1s(vd, vta,                                       \
+                              (ci + 8) * sizeof(int##WD##_t),                \
+                              total_elems * sizeof(int##WD##_t));            \
+        }                                                                    \
+    }                                                                        \
+}
+
+GEN_VEXT_ZVBDOTA_INT(vqwbdotau_vv_b, 32, 8, uint8_t, H4, H1)
+GEN_VEXT_ZVBDOTA_INT(vqwbdotas_vv_b, 32, 8, int8_t, H4, H1)
-- 
2.56.0


