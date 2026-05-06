Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8BFFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 12:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKbfo-0003TB-C4; Wed, 06 May 2026 08:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhongyao@zte.com.cn>)
 id 1wKZ83-0002g5-MQ; Wed, 06 May 2026 06:05:19 -0400
Received: from mxhk.zte.com.cn ([160.30.148.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhongyao@zte.com.cn>)
 id 1wKZ80-0006Dk-M0; Wed, 06 May 2026 06:05:19 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4g9WGB6mv9z5B10G;
 Wed, 06 May 2026 18:05:06 +0800 (CST)
Received: (from root@localhost) by mse-fl1.zte.com.cn id 646A537u037157;
 Wed, 6 May 2026 18:05:03 +0800 (+08)
 (envelope-from chen.zhongyao@zte.com.cn)
Message-Id: <202605061005.646A537u037157@mse-fl1.zte.com.cn>
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 6467GCQk073999;
 Wed, 6 May 2026 15:16:12 +0800 (+08)
 (envelope-from chen.zhongyao@zte.com.cn)
Received: from mapi (szxlzmapp01[null]) by mapi (Zmail) with MAPI id mid18;
 Wed, 6 May 2026 15:16:14 +0800 (CST)
X-Zmail-TransId: 2b0369faeabe1a1-84c5d
X-Mailer: Zmail v1.0
Date: Wed, 6 May 2026 15:16:14 +0800 (CST)
Mime-Version: 1.0
From: <chen.zhongyao@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSB0YXJnZXQvcmlzY3Y6IEZpeCB0YWlsIGhhbmRsaW5nIGZvciB2bXYucy54IGFuZCB2Zm12LnMuZg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 646A537u037157
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: chen.zhongyao@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 06 May 2026 18:05:06 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69FB1252.002/4g9WGB6mv9z5B10G
Received-SPF: pass client-ip=160.30.148.34;
 envelope-from=chen.zhongyao@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 May 2026 08:48:08 -0400
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
---
 target/riscv/helper.h                   |  4 +++
 target/riscv/insn_trans/trans_rvv.c.inc | 44 ++++++++-----------------
 target/riscv/vector_helper.c            | 18 ++++++++++
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..5a7f043edb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -660,6 +660,10 @@ DEF_HELPER_4(vmv_v_x_b, void, ptr, i64, env, i32)
 DEF_HELPER_4(vmv_v_x_h, void, ptr, i64, env, i32)
 DEF_HELPER_4(vmv_v_x_w, void, ptr, i64, env, i32)
 DEF_HELPER_4(vmv_v_x_d, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_b, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_h, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_w, void, ptr, i64, env, i32)
+DEF_HELPER_4(vset_velem0_d, void, ptr, i64, env, i32)

 DEF_HELPER_6(vsaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vsaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 4df9a40b44..6a966c35c3 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3381,37 +3381,21 @@ static void vec_element_loadi(DisasContext *s, TCGv_i64 dest,
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
@@ -3458,7 +3442,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
          */
         s1 = get_gpr(s, a->rs1, EXT_NONE);
         tcg_gen_ext_tl_i64(t1, s1);
-        vec_element_storei(s, a->rd, 0, t1);
+        vec_element_storei_tail(s, a->rd, t1);
         gen_set_label(over);
         tcg_gen_movi_tl(cpu_vstart, 0);
         finalize_rvv_inst(s);
@@ -3514,7 +3498,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
         t1 = tcg_temp_new_i64();
         do_nanbox(s, t1, cpu_fpr[a->rs1]);

-        vec_element_storei(s, a->rd, 0, t1);
+        vec_element_storei_tail(s, a->rd, t1);

         gen_set_label(over);
         tcg_gen_movi_tl(cpu_vstart, 0);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 83dd26314d..6c7af25d82 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2112,6 +2112,24 @@ GEN_VEXT_VMV_VX(vmv_v_x_h, int16_t, H2)
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
-- 
2.43.0

