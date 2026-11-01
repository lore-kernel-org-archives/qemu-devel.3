Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E4606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=BuOym+Bv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUTi-0003ut-Sb; Sun, 01 Nov 2026 07:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNMtx-0003HL-1K
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 00:10:41 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNMtr-0004Xv-4j
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 00:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1793506219;
 bh=5ikS364LHECGsXOw3SDibIJR0X5EJ8U7EnVscpl04A4=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=BuOym+BvE/mbduLqjqMk15cEayN29daE6D0ywIJVLVfqd6FbLMGzxI/RNR5ltQ3NX
 N4HLp25LyaGFX6iXDXXcrpNDCBGaJyPi/OZ+onxAnNgwAXoIioL5+1E3lWxcoOvuSM
 59FwUuz2oxQwMQW0IkKzDKX2kIlhuIiftY+h7eJ0=
Received: from localhost.localdomain ([113.200.174.63])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 2212124A; Sun, 01 Nov 2026 12:08:33 +0800
X-QQ-mid: xmsmtpt1793506150tc4mj2d4o
Message-ID: <tencent_9256BC46CB818A63AA22812B8422798DE205@qq.com>
X-QQ-XMAILINFO: MoZ/+D/yktIRRgAFk4c7ISP2eY6m/qPqOqOPAZvT/x83/Ioila1PEfVvL+ro5b
 kaxqsfr+Dj562e2hwHX0OaZGtJj2B7ACUl7uDA/REcLP1go8jcsf1u1I1rIx85W9+GWN7qtJpIoi
 VR/5tginYuZRf+9PtjUimPJkawoUe4ctkfLAvpY5eKMbq2n0csrzGxQsauFm3YciwCjqUC/XzGaO
 nng1qeecgBr4esOiAUX6Mq7Mv0i2NRT4UWrXYxD1cNTGGgkXGwwqt4eoYTF3D2IzgMFpOOvW1hJl
 C4slmCDxYeMZ8MeglezKUrzPR497nfdkMNKFRIxUkxWauWHMlDWOBh8kTBgOxB9MwhhI6unuDiYy
 Z+GbnKQBqYAkS8fKNiae2sN3ipzMEaAgtxXBZwPmXbtleO7/LL3isCUrByh8SASB7HNNv5oWTJ6h
 b6U0l0IK/gtiVeRvcdAwFiqTCwtUI6yU0vo5zrM14fcxTkp9FUQpqPzpN/I4/FTwVOZtzX/kjrEg
 Nj0icgxkGW/WPUYhq3m6MjKzMLg4dh9izCeWGybSa0aoI3ne2pKRMEuHaVaNyM7I3qP68G8nA5y9
 8ZiI25sIOtkzKsPLs9+ZKdy5oiSQNpPOcdwl9D5acqgVvXSRiF3C/oBa1W62iyV0EE6Z4CEGH4rO
 yDJX6OrmOApNX1R/vqqqMN6gLCXk4S4dT2nTPPLf+W0i2bNekLBmFXCRrsBegOKRR7GIHoIrJtrD
 tt+mIEu7+LrEXHSZg+1z5vSg05/R8IfZeN976LyXMXp9c4/xxrTeuarUwRBNAXsshYxqL/OWCd5/
 QeMq2WAlAC8+ke1GiQWM9NI7Nhkv96fQNlj5ZQZwONTjfS4NRQN3bn3gtNWcwEeEIEkKaFbx3I6D
 RCHYY42bi9abhBthR6YIvnhI7xvZG0lr/7k9Bd71vq60817dGQS6i4DFaH4Pv0AWpdZV+ATFvOPV
 0Zom+4hBdMN+0/xC66yjJ/PawdAdx4WPi+fk7bW9FaA6yBsNFZNNz1RVgQBQ/sMQOv4M9C68Nl8M
 oDnowukwLMlB/AuboqEXACy4DPE5TiwkWTIAslvOyzptDqyF1MBrMLbDILNZTPbr4A19e+R19bbT
 gOjmf5IRnqDGRyrM7XMw/3Zy5LPxmSNoOdZfY+WsZnjoHDxIpyNQwT/Frog5hTPDTRBgizaoF83s
 EjZ2rKuLkw5KEXbJ52Ol7PBYXf
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Haoyu Nan <Holypumpkin@foxmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] target/riscv: inline RV64 LMUL=1 vector configuration
Date: Sun,  1 Nov 2026 12:08:21 +0800
X-OQ-MSGID: <20261101040821.1841-2-Holypumpkin@foxmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20261101040821.1841-1-Holypumpkin@foxmail.com>
References: <20261101040821.1841-1-Holypumpkin@foxmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.43;
 envelope-from=holypumpkin@foxmail.com; helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Nov 2026 07:15:59 -0500
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vsetvli and vsetivli currently call the generic vsetvl helper even
when their immediate vtype can be validated during translation. For
legal RV64 LMUL=1 configurations, generate the VL calculation and
architectural state updates directly in TCG to avoid the runtime
helper call and repeated validation of the constant type.

Restrict this path to encodings without reserved or alternate-format
bits and with an element width supported by the configured ELEN.
Compute VL during translation for vsetivli, where AVL is also an
immediate. For vsetvli with a nonzero source register, generate an
unsigned minimum and, when required, conditional selection for the
rvv_vl_half_avl policy. Preserve the rounded-up half-AVL result for
VLMAX < AVL < 2 * VLMAX.

Write vl and vtype, clear vstart and VILL, and return the selected VL
through the destination register. Compute the result before writing
the destination so that rd may alias the AVL source register. Use
the existing 32-bit TCG globals for vl and vstart.

Keep the generic helper for RV32, other LMUL values, unsupported
types, register-supplied vtype, and vsetvli with rs1=x0. In particular,
retain the existing handling of the x0 forms and their VILL policy.
Leave instruction checks, finalization, PC updates and the subsequent
translation-block lookup unchanged.

The preceding regression test covers AVL boundaries, register aliases,
state updates, helper fallback cases and subsequent vector arithmetic
with both VL selection policies.
---
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 79 +++++++++++++++++++--
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 7e1295f33e..d26844c99c 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -221,7 +221,26 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
     return true;
 }
 
-static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
+static bool vsetvl_inline_vtype(DisasContext *s, unsigned vtype)
+{
+    unsigned vsew = FIELD_EX64(vtype, VTYPE, VSEW);
+
+    /* RV64, LMUL=1, no reserved or alternate-format bits. */
+    return get_xl(s) == MXL_RV64 && !(vtype & ~0xf8u) &&
+           (8u << vsew) <= s->cfg_ptr->elen;
+}
+
+static void gen_vsetvl_inline_state(TCGv vl, unsigned vtype)
+{
+    tcg_gen_trunc_tl_i32(cpu_vl, vl);
+    tcg_gen_st_tl(tcg_constant_tl(vtype), tcg_env,
+                  offsetof(CPURISCVState, vtype));
+    tcg_gen_movi_i32(cpu_vstart, 0);
+    tcg_gen_st8_i32(tcg_constant_i32(0), tcg_env,
+                   offsetof(CPURISCVState, vill));
+}
+
+static bool do_vsetivli(DisasContext *s, int rd, unsigned avl, unsigned vtype)
 {
     TCGv dst;
 
@@ -231,7 +250,20 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 
     dst = dest_gpr(s, rd);
 
-    gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
+    if (vsetvl_inline_vtype(s, vtype)) {
+        unsigned vsew = FIELD_EX64(vtype, VTYPE, VSEW);
+        unsigned vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, vsew, 0);
+        unsigned vl = MIN(avl, vlmax);
+
+        if (avl > vlmax && avl < 2 * vlmax && s->cfg_ptr->rvv_vl_half_avl) {
+            vl = (avl + 1) >> 1;
+        }
+        tcg_gen_movi_tl(dst, vl);
+        gen_vsetvl_inline_state(tcg_constant_tl(vl), vtype);
+    } else {
+        gen_helper_vsetvl(dst, tcg_env, tcg_constant_tl(avl),
+                         tcg_constant_tl(vtype), tcg_constant_tl(0));
+    }
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
     gen_update_pc(s, s->cur_insn_len);
@@ -249,15 +281,48 @@ static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)
 
 static bool trans_vsetvli(DisasContext *s, arg_vsetvli *a)
 {
-    TCGv s2 = tcg_constant_tl(a->zimm);
-    return do_vsetvl(s, a->rd, a->rs1, s2);
+    TCGv avl, vl;
+    unsigned vsew, vlmax;
+
+    /* The x0 AVL encodings retain the helper's special VILL semantics. */
+    if (a->rs1 == 0 || !vsetvl_inline_vtype(s, a->zimm)) {
+        return do_vsetvl(s, a->rd, a->rs1, tcg_constant_tl(a->zimm));
+    }
+    if (!require_rvv(s) || !s->cfg_ptr->ext_zve32x) {
+        return false;
+    }
+
+    avl = get_gpr(s, a->rs1, EXT_ZERO);
+    vl = tcg_temp_new();
+    vsew = FIELD_EX64(a->zimm, VTYPE, VSEW);
+    vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, vsew, 0);
+    tcg_gen_umin_tl(vl, avl, tcg_constant_tl(vlmax));
+    if (s->cfg_ptr->rvv_vl_half_avl) {
+        TCGv half = tcg_temp_new();
+
+        /* Overflow of AVL+1 is harmless outside the selected small range. */
+        tcg_gen_addi_tl(half, avl, 1);
+        tcg_gen_shri_tl(half, half, 1);
+        tcg_gen_movcond_tl(TCG_COND_LTU, half, avl,
+                           tcg_constant_tl(2 * vlmax), half,
+                           tcg_constant_tl(vlmax));
+        tcg_gen_movcond_tl(TCG_COND_LEU, vl, avl,
+                           tcg_constant_tl(vlmax), avl, half);
+    }
+
+    /* Compute VL before writing rd, which may alias the AVL register. */
+    gen_vsetvl_inline_state(vl, a->zimm);
+    gen_set_gpr(s, a->rd, vl);
+    finalize_rvv_inst(s);
+    gen_update_pc(s, s->cur_insn_len);
+    lookup_and_goto_ptr(s);
+    s->base.is_jmp = DISAS_NORETURN;
+    return true;
 }
 
 static bool trans_vsetivli(DisasContext *s, arg_vsetivli *a)
 {
-    TCGv s1 = tcg_constant_tl(a->rs1);
-    TCGv s2 = tcg_constant_tl(a->zimm);
-    return do_vsetivli(s, a->rd, s1, s2);
+    return do_vsetivli(s, a->rd, a->rs1, a->zimm);
 }
 
 /* vector register offset from env */
-- 
2.47.0.windows.1


