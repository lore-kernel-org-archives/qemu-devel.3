Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F5D2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciO-00032i-Kt; Tue, 27 Jan 2026 01:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciK-0002zQ-Qt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:12 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciI-0006mT-LQ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:12 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-352e2c59264so3627774a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495889; x=1770100689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGcwg0GwnJbskM4hAjvfJZ7w7+5kGXiia0IIZ2hjvCE=;
 b=bB28VKssvZ2vMoEgKKmu+3hSXHkHQfYE6R/k1a93XwCsmd5TfECSSAzZCseTp+FJMy
 nWlhReqEIP3cygw2pqAz6wPwTxkZffBvnZ5CKs8jfBYsntXmruiEKK50c4BRomScpROj
 kGrNHb+tzXh5T12JFEuwS8TM18FqJWrLK7jOp1EzTNUO/7Ve+iwUCbu0TG+J6iCzgVAf
 kFhaNazUJlzbzILIJP3saTOH8AQJ9wd3DSbZ2mxxAlcRuO91HWxhzgb5aFjpiWUmP0Oj
 J+hvvJ4yLGTPVay+74Aat1KxBjvhpjsxOQFXw1qYnMkGAzFhs/jh27MPsT5ZRlFr0KAa
 jVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495889; x=1770100689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JGcwg0GwnJbskM4hAjvfJZ7w7+5kGXiia0IIZ2hjvCE=;
 b=bhWA1RFk5of33CZ0TCeZZ8hBx51gkbBGevadFGwE5J+L9dPAaA8UZ54B/0zRaeS7lV
 EMkSll5NBywlQC6KGZ9/ndYXZb21eEdsjiJUXX9BTzsW/ju1AGEGV4opqmMaBJd5ALZJ
 uS8u/7EgDyOzqmNPGi24eRYbv7cPaZw9N8vZNBHP5REbIc4M0Z4wFOMEFBG2M0vdRJrZ
 lWflYu7vakft9dkSYi8l7/GEzYdGPRRDRtabMOJpT9Mdbr6Ek0BwIJtA9xcuk4lxjXfs
 cyzxpBDb/mX7VoHHEVXUJKO0slz01XBSRiUP/+r84G377qVwTYW1thIb3kuOGpcp55kk
 62NA==
X-Gm-Message-State: AOJu0YxC6i/yQ1+IFbqSs3P1SA5sFX7QGZaYzJjB13Sl5nkpdm/HPxEY
 Nn2vO2PI1aunNx0JRmGkTITI4hU32pHHyqOm6vYfbkPssB8ThmxNoH8Io9BuvLrjGRx87ctK4kI
 KtWzJ1a6obFokYeJ9jjzK6RpMsxELgHt7uJiyDHX+U8D7Gwlr2rMJUrqUW9mnEdy5TaTCqGOED0
 B4VvCIavvRBMLTgjm3XfLSFfN9oYZKuCvVH6SH8Qu6Hw==
X-Gm-Gg: AZuq6aJa+oJm+Nrdv5URGxozItvma6uXYM7jadEFetV3dmenLsghJa/4jzsv0EJ7uYP
 FJmSa9HrWlEoi3jS6Q3Kp7byeOQJMbHPHey2vhYxGQrlVsngIg0s7Gx4/bm3Xu4APCVcjJn/xUn
 6T6pJODhfYo0jqLzL2ivQJ4doCSfFwJ0LT0Ol63HDmQme5c5Bf8IeZJUDODzOS8wpWCCy9UnMm1
 WoYCDUWKVXCjiKUvEV+Y87MlhPAemCavmEPM66gx3yIWAk2qxH2fnhyazxd2b4qVhwglJ4EdKGr
 ILfrXcHKivRfbAEVo2mLT9E3bIIcxwtMQlQ1tPffcOZztoThaBuPQNfhniDovdjdp7+pWksCOb6
 Mv7RbyyXWHMQY3/yihj+pcACTMxZNKg0CKflyCRDbhYEeYJFof5FUEUC1ypBqq/oVT6XB2SlH3i
 YrXpMdyOxGW+amRbk4Ls7pbrotrE60w9rRGgscmuJoNhrUNPeix3dLilKoBn0I7RhVSzK3ePTgu
 9reygBr2bQ6yJQ=
X-Received: by 2002:a17:90b:528e:b0:349:2154:eef4 with SMTP id
 98e67ed59e1d1-353fecdcf8amr801119a91.5.1769495888865; 
 Mon, 26 Jan 2026 22:38:08 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:38:08 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 15/17] target/riscv: rvv: Add vfext.vf2 instruction for
 Zvfofp4min extension
Date: Tue, 27 Jan 2026 14:37:21 +0800
Message-ID: <20260127063723.442734-16-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1033.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The vfext.vf2 instruction converts a vector of OCP FP4 E2M1
floating-point numbers to a vector of OFP FP8 E4M3 floating-points
numbers.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                      |  3 ++
 target/riscv/insn32.decode                 |  3 ++
 target/riscv/insn_trans/trans_rvofp4.c.inc | 44 ++++++++++++++++++++++
 target/riscv/translate.c                   |  1 +
 target/riscv/vector_helper.c               | 33 ++++++++++++++++
 5 files changed, 84 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 356c24d9fb..162303fb6c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1259,6 +1259,9 @@ DEF_HELPER_5(vfncvt_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
 
+/* OFP4 function */
+DEF_HELPER_5(vfext_vf2, void, ptr, ptr, ptr, env, i32)
+
 /* Vector crypto functions */
 DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f2b413c7d4..c58223ebd8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -754,6 +754,9 @@ vsext_vf2       010010 . ..... 00111 010 ..... 1010111 @r2_vm
 vsext_vf4       010010 . ..... 00101 010 ..... 1010111 @r2_vm
 vsext_vf8       010010 . ..... 00011 010 ..... 1010111 @r2_vm
 
+# Zvfofp4min Extension
+vfext_vf2       010010 . ..... 10110 010 ..... 1010111 @r2_vm
+
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm11
 vsetivli        11 .......... ..... 111 ..... 1010111  @r2_zimm10
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvofp4.c.inc b/target/riscv/insn_trans/trans_rvofp4.c.inc
new file mode 100644
index 0000000000..91bf50834f
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvofp4.c.inc
@@ -0,0 +1,44 @@
+/*
+ * RISC-V translation routines for the OFP4 Standard Extensions.
+ *
+ * Copyright (C) 2025 SiFive, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+static bool vext_zvfofp4min_check(DisasContext *s, arg_rmr *a)
+{
+    return s->cfg_ptr->ext_zvfofp4min &&
+           (s->sew == MO_8) &&
+           vext_check_altfmt(s, -1) &&
+           (s->lmul >= -2) &&
+           require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (a->rd != a->rs2) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs2, s->lmul - 1) &&
+           require_vm(a->vm, a->rd) &&
+           require_noover(a->rd, s->lmul, a->rs2, s->lmul - 1);
+}
+
+static bool trans_vfext_vf2(DisasContext *s, arg_rmr *a)
+{
+    if (vext_zvfofp4min_check(s, a)) {
+        uint32_t data = 0;
+
+        data = FIELD_DP32(data, VDATA, VM, a->vm);
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
+                           vreg_ofs(s, a->rs2), tcg_env,
+                           s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, data,
+                           gen_helper_vfext_vf2);
+        tcg_gen_movi_tl(cpu_vstart, 0);
+        finalize_rvv_inst(s);
+
+        return true;
+    }
+    return false;
+}
+
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 137022d7fb..bf403785b5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1220,6 +1220,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "insn_trans/trans_rvofp8.c.inc"
+#include "insn_trans/trans_rvofp4.c.inc"
 #include "decode-xthead.c.inc"
 #include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 418212973d..a87728f130 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5121,6 +5121,7 @@ RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
 GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
 GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
 
+/* Zvfofp4min: vfext.vf2 - OFP4 E2M1 to OFP8 E4M3 conversion */
 /*
  * Vector Reduction Operations
  */
@@ -5920,3 +5921,35 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
 GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
 GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
 GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
+
+
+void HELPER(vfext_vf2)(void *vd, void *v0, void *vs2, CPURISCVState *env,
+                       uint32_t desc)
+{
+    float_status fp_status = env->fp_status;
+    uint32_t vl = env->vl;
+    uint32_t vm = vext_vm(desc);
+    uint32_t esz = sizeof(uint8_t);
+    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
+    uint32_t vta = vext_vta(desc);
+    uint32_t vma = vext_vma(desc);
+    uint32_t i;
+
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
+    for (i = env->vstart; i < vl; ++i) {
+        if (!vm && !vext_elem_mask(v0, i)) {
+            /* set masked-off elements to 1s */
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
+            continue;
+        }
+
+        uint8_t input = *((uint8_t *)vs2 + H1((i % 2 ? i - 1 : i) / 2));
+        input = (i % 2) ? ((input >> 4) & 0xf) : (input & 0xf);
+        *((uint8_t *)vd + H1(i)) = float4_e2m1_to_float8_e4m3(input,
+                                                              &fp_status);
+    }
+    env->vstart = 0;
+    /* set tail elements to 1s */
+    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
+}
-- 
2.52.0


