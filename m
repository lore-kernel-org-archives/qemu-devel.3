Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC83CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNK-0001au-NL; Thu, 21 May 2026 20:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNI-0001aG-UC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:25 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNG-0003Lr-VG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:24 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so3178005a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408261; x=1780013061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voLNE+GP6MgaDC842wErmF2XBwpM8m0z5a8r1iEUN1w=;
 b=aYrgZawLPOPuc8ct0plJ5Vi9KCSqgXICcZqH5xvzDBKGXiYsgM4cs7IU7hd+5tE6hS
 pSl8vf+j9BRQBU/EqBJ+hc1MU8kFPNrO7CI8QXJmJ82mvHW298ODbNS4fwxteDjPJ5x6
 i+yR8CZc1i/G1EBdk20+fcLFcEY6M48CbxKBrK00drbzKVqkPM31NEZADEM2XL/d7oL0
 Qmu1w5gop+ZP2gl6zBW/0QwKsdiYRfszDcO9IXl+Sr+f+r/1bCjZ/VxcstQ/LAv4YzT8
 i0yAzRZAmTUfkfUwrDXNQyHCmTMkQ4e+MvKXKuLrIwaIj09EgQ6WYcynJOLAaHmJPO+p
 8EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408261; x=1780013061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=voLNE+GP6MgaDC842wErmF2XBwpM8m0z5a8r1iEUN1w=;
 b=iUB9eV0JnbZeZCNUZ6hNXNZ9OkBTzwkCeeuUL70BcPwjCFLxZhRB1S/rj385P1pxe9
 P0BL9P0qVW+tacqU3rmmmyUVvb5x302C+jIuNRn1xb0nmSxJRFboCFW+nHXp+8Aey96h
 KWoBnc9aQGRdYeNfQH0LEUa9tYCRWfl7nJhvJzOBD9+xkWA3uBBecGJIOhOq6Jsq1aer
 e0NvCtAsaBu1kbKEzbdFlxJDRKaquVbady4syBoNS1W6BdnEwMtXYAb0xUVl2sfIqg8R
 a89VQjChyrCRZ/rk/NYRLXK5lKsf7l5IBhg3J0sy37bevcBgPy5FP8K3uqdbctx3gJXE
 b0Eg==
X-Gm-Message-State: AOJu0Yxla59VxGm1lgnfGbzqA20gGIBuAQA33LJCY3jwfmMjhgls3AT/
 fXhwioKpinXSK+iBdB2PdlyLTJiFPgLsintuVM1ComhPzvdO5jXj59E4ire3KQEu
X-Gm-Gg: Acq92OFzro+o4xs/TC1WVbhBGG/YCZYXnjMmcvLRCVg8byqVGrnW2bcsoaGRloCWWVL
 RQItnNtWKLF+b2BpfU8++dSY+JO9rCmTjmMCDWUVZf8fYoSPHGp+aRPe8XdQkGocVpnOh5T1ZQj
 ejRW6wo5AIKKQahmr7BJL89w/Sy/KkRWPMpp3rK9uoMWlpmbKVYVdMAR1ECLHB7baj3uekw8je6
 mTSXnBFnDTNSfigzssC1XdoUId484YvgTAsum4JZKf5duHfSlMazKC9nwORvjG6+VlYgEcufybY
 eKc0ndwOdUKyCCr7Myg4BP7AbL9q7eYPI/eK7qMYTie6lYjJPgsXeyPUUO8CbMfbSXH+tqo1Ala
 8BzksiB1MUwTPfq2w6b0iENsvnbDVf0KIkMPlM3NSW8FU6pmr0wLwwqb2qMuPDqj711inOT2lvC
 CUAoPLIkhRxOWx+2/vMfqtd47fy0pZuHaX2QoA2MUgFA==
X-Received: by 2002:a17:903:3905:b0:2b4:59bf:5728 with SMTP id
 d9443c01a7336-2beb05e4149mr12379355ad.25.1779408257472; 
 Thu, 21 May 2026 17:04:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 "chen.zhongyao@zte.com.cn" <chen.zhongyao@zte.com.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/48] target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f
Date: Fri, 22 May 2026 10:02:49 +1000
Message-ID: <20260522000324.23255-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "chen.zhongyao@zte.com.cn" <chen.zhongyao@zte.com.cn>

The risc-v vector spec defines vmv.s.x and vfmv.s.f as writing
element 0 of the destination register while the remaining destination
elements follow the current tail policy. When QEMU runs with
rvv_ta_all_1s enabled, those elements must therefore become all 1s.

QEMU handled both instructions as translation-time special cases that
directly wrote vd[0] and skipped the usual tail processing. As a result,
vmv.s.x and vfmv.s.f left the remaining destination elements unchanged
instead of applying the configured tail policy.

Fix this by routing both instructions through a helper that writes
vd[0] and then treats the rest of the destination register as tail,
reusing the existing agnostic-element fill logic.

Signed-off-by: Zhongyao Chen <chen.zhongyao@zte.com.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <202605061005.646A537u037157@mse-fl1.zte.com.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  4 +++
 target/riscv/vector_helper.c            | 18 ++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc | 44 ++++++++-----------------
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 36cdacfb0e..542b7c264f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -662,6 +662,10 @@ DEF_HELPER_4(vmv_v_x_b, void, ptr, i64, env, i32)
 DEF_HELPER_4(vmv_v_x_h, void, ptr, i64, env, i32)
 DEF_HELPER_4(vmv_v_x_w, void, ptr, i64, env, i32)
 DEF_HELPER_4(vmv_v_x_d, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_b, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_h, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_w, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_d, void, ptr, i64, env, i32)
 
 DEF_HELPER_6(vsaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vsaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5a3554dd71..c4e150635e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2141,6 +2141,24 @@ GEN_VEXT_VMV_VX(vmv_v_x_h, int16_t, H2)
 GEN_VEXT_VMV_VX(vmv_v_x_w, int32_t, H4)
 GEN_VEXT_VMV_VX(vmv_v_x_d, int64_t, H8)
 
+#define GEN_VEXT_SET_VELEM0(NAME, ETYPE, H)                             \
+void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,            \
+                  uint32_t desc)                                        \
+{                                                                       \
+    uint32_t esz = sizeof(ETYPE);                                       \
+    uint32_t vlenb = riscv_cpu_cfg(env)->vlenb;                         \
+    uint32_t vta = vext_vta(desc);                                      \
+                                                                        \
+    *((ETYPE *)vd + H(0)) = (ETYPE)s1;                                  \
+    /* Treat every element past vd[0] as tail for scalar-to-vector moves. */ \
+    vext_set_elems_1s(vd, vta, esz, vlenb);                             \
+}
+
+GEN_VEXT_SET_VELEM0(vset_velem0_b, int8_t,  H1)
+GEN_VEXT_SET_VELEM0(vset_velem0_h, int16_t, H2)
+GEN_VEXT_SET_VELEM0(vset_velem0_w, int32_t, H4)
+GEN_VEXT_SET_VELEM0(vset_velem0_d, int64_t, H8)
+
 #define GEN_VEXT_VMERGE_VV(NAME, ETYPE, H)                           \
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
                   CPURISCVState *env, uint32_t desc)                 \
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 0b41cecb27..9a86c6dcd4 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3607,37 +3607,21 @@ static void vec_element_loadi(DisasContext *s, TCGv_i64 dest,
     load_element(dest, tcg_env, endian_ofs(s, vreg, idx), s->sew, sign);
 }
 
-/* Integer Scalar Move Instruction */
+typedef void gen_helper_vset_velem0(TCGv_ptr, TCGv_i64, TCGv_env, TCGv_i32);
 
-static void store_element(TCGv_i64 val, TCGv_ptr base,
-                          int ofs, int sew)
+static void vec_element_storei_tail(DisasContext *s, int vreg, TCGv_i64 val)
 {
-    switch (sew) {
-    case MO_8:
-        tcg_gen_st8_i64(val, base, ofs);
-        break;
-    case MO_16:
-        tcg_gen_st16_i64(val, base, ofs);
-        break;
-    case MO_32:
-        tcg_gen_st32_i64(val, base, ofs);
-        break;
-    case MO_64:
-        tcg_gen_st_i64(val, base, ofs);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
+    static gen_helper_vset_velem0 * const fns[4] = {
+        gen_helper_vset_velem0_b, gen_helper_vset_velem0_h,
+        gen_helper_vset_velem0_w, gen_helper_vset_velem0_d,
+    };
+    TCGv_ptr dest = tcg_temp_new_ptr();
+    uint32_t data = FIELD_DP32(0, VDATA, VTA, s->vta);
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
+                                              s->cfg_ptr->vlenb, data));
 
-/*
- * Store vreg[idx] = val.
- * The index must be in range of VLMAX.
- */
-static void vec_element_storei(DisasContext *s, int vreg,
-                               int idx, TCGv_i64 val)
-{
-    store_element(val, tcg_env, endian_ofs(s, vreg, idx), s->sew);
+    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vreg));
+    fns[s->sew](dest, val, tcg_env, desc);
 }
 
 /* vmv.x.s rd, vs2 # x[rd] = vs2[0] */
@@ -3684,7 +3668,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
          */
         s1 = get_gpr(s, a->rs1, EXT_NONE);
         tcg_gen_ext_tl_i64(t1, s1);
-        vec_element_storei(s, a->rd, 0, t1);
+        vec_element_storei_tail(s, a->rd, t1);
         gen_set_label(over);
         tcg_gen_movi_tl(cpu_vstart, 0);
         finalize_rvv_inst(s);
@@ -3741,7 +3725,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         t1 = tcg_temp_new_i64();
         do_nanbox(s, t1, cpu_fpr[a->rs1]);
 
-        vec_element_storei(s, a->rd, 0, t1);
+        vec_element_storei_tail(s, a->rd, t1);
 
         gen_set_label(over);
         tcg_gen_movi_tl(cpu_vstart, 0);
-- 
2.53.0


