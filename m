Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953B9C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26No-0005QU-JL; Tue, 08 Apr 2025 06:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NO-00059N-Kk
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:19 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1u26NK-0008RY-DH
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:40:17 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso4790832b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744108813; x=1744713613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTLtT4vDY352g4F75LFgIJisHzAnF4unEfl2dckYO0Y=;
 b=bn6sX5O04tfKNutERM0BGfQg/xKrNQQGUTQuTXApIM5BUf61uTKlF3jNUOegol3JVo
 IQr6fn5Kisfv7UYrXRcfufn49nz8gevWcNEyr5lSm5mdEg3JGvvZjl2hJRRjBNp7vM/C
 XG+h6bDZnRe3/9VLCEQ9dyjQyO85lKjGEKcTJDDl0l2KF5r0EbbeVLe5kfZbrl0bOEhA
 rQnjgi5aR6/r1kt7krwy2XGpJmI6QipYyDumB43+Ne7D2f5cig4e6c0ebr8ov7YLmgwn
 +gg+QICpxBErYRMWdPJqHmkGwdh9avEIFa7n6mEfp03WoDo3EMjvuHNRR1bkjVwhRU4w
 8fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744108813; x=1744713613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTLtT4vDY352g4F75LFgIJisHzAnF4unEfl2dckYO0Y=;
 b=mVtWC1xNTgU08H3Oef515kGRGLnoI1/J6l/819/BIby7oBEZEmPtYgYdUGdSuBuqdU
 hJD3XM9TUrNxKS1O+8BadeEjSDCvJdanci6l/yX8YHAppGqKrLOwPZwfXHn9dRhOm9Hj
 4PfdcjLiIqYXBd491D2fLs5BMi+Ni128dg2Bi9kFgzIvqZC+PSmgVDFdreaoN6ekiU7H
 lZB11CwBRaniZaqgBuFprMSOLDnss93kWPeXOHbNOV1Y9SyrxqT6H0Fvs4AV4BagjIv9
 810lYopxmgO0c3btjaIjGkBXcDohTOrmhP1ve8gVHgx4xp3LGxwlmfiYAtjlrqEzoxwB
 iiMg==
X-Gm-Message-State: AOJu0YytUMXU+4EHpG4gNwGpjTWf2ln1RDoD1SwjXBp6a0DbDQRC/8SJ
 MsYo+0JEwqQF6Yfp2EtUrwRDrUBjvo4BKfQPYkOwwYfUSnKXoWEcrIvptHyP7tNyShSaqG42+k0
 Vml6cgrnoQ5bNlm+Vwu8YuR1pohcmB8wJQLMx7oRzjBStO2CCX5wKpm7OSX9MrxYRP+bdQD/9FU
 WMf5oOlY+ga3pNB84g2C6wv+CbJqDMiAVjRgpOeSEm
X-Gm-Gg: ASbGnctkjS/hpgeNYW4Z3hHkjQROO5vdczpZ6dk+jw/1DpaRHa9VTf/Kqc6lXf8Ha3j
 mKwISt1PFv4qQqB0C6WuMOAaqdqQjxgvJ1Vy4OsMXHr5e98c6kCdJoTHZZ3z7EXmW3bVufETi1a
 grkDJtC4/8ZLh+9cXCw3N3BCuSBTHkonUykXZ9oXl3BQz6EWdTOsbouvrGT0UN2+5KbmHGoe1gZ
 V95e9So7Bk6n75L2lpb/o+vGfGITkfiY9Df/D4bSNugAT+CIIqWoCJfgtuhyyREYOJz2hR7A9qe
 3kYwO4MPxzFvHlaosbkDvR72hvqPGV/COoB1TzRPvtefLVvQDQuJ+oOHCwlEA3z4H1s0o0oUg8L
 Z3qhjKivdp/Z5nX/kxIdqOD9M
X-Google-Smtp-Source: AGHT+IH5H8PeMhk6urA2FhG1MSe0NKi0Fx77i1TW0TGHgQKBYjOatUk6UKJwZZeYURNeaYRkCv+jaw==
X-Received: by 2002:a05:6a00:3d52:b0:730:9502:d564 with SMTP id
 d2e1a72fcca58-739e485dabdmr17476255b3a.14.1744108812702; 
 Tue, 08 Apr 2025 03:40:12 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e3734sm10532380b3a.179.2025.04.08.03.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 03:40:12 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 08/10] target/riscv: rvv: Apply vext_check_input_eew to
 vector narrow/widen instructions
Date: Tue,  8 Apr 2025 18:39:36 +0800
Message-ID: <20250408103938.3623486-9-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408103938.3623486-1-max.chou@sifive.com>
References: <20250408103938.3623486-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42a.google.com
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

Handle the overlap of source registers with different EEWs.
The vd of vector widening mul-add instructions is one of the input
operands.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc |  9 ++-
 target/riscv/insn_trans/trans_rvv.c.inc    | 77 +++++++++++++++++-----
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 0a9cd1ec315..066dc364c5b 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -119,8 +119,11 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
     REQUIRE_FPU;
     REQUIRE_ZVFBFWMA(ctx);
 
+    uint8_t sew = ctx->sew;
     if (require_rvv(ctx) && vext_check_isa_ill(ctx) && (ctx->sew == MO_16) &&
-        vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm)) {
+        vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm) &&
+        vext_check_input_eew(ctx, a->rd, sew + 1, a->rs1, sew, a->vm) &&
+        vext_check_input_eew(ctx, a->rd, sew + 1, a->rs2, sew, a->vm)) {
         uint32_t data = 0;
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
@@ -146,8 +149,10 @@ static bool trans_vfwmaccbf16_vf(DisasContext *ctx, arg_vfwmaccbf16_vf *a)
     REQUIRE_FPU;
     REQUIRE_ZVFBFWMA(ctx);
 
+    uint8_t sew = ctx->sew;
     if (require_rvv(ctx) && (ctx->sew == MO_16) && vext_check_isa_ill(ctx) &&
-        vext_check_ds(ctx, a->rd, a->rs2, a->vm)) {
+        vext_check_ds(ctx, a->rd, a->rs2, a->vm) &&
+        vext_check_input_eew(ctx, a->rd, sew + 1, a->rs2, sew, a->vm)) {
         uint32_t data = 0;
 
         gen_set_rm(ctx, RISCV_FRM_DYN);
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 585ee98b27d..2d067a59e27 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -528,6 +528,7 @@ static bool vext_narrow_check_common(DisasContext *s, int vd, int vs2,
 static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 {
     return vext_wide_check_common(s, vd, vm) &&
+           vext_check_input_eew(s, vs, s->sew, -1, 0, vm) &&
            require_align(vs, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs, s->lmul);
 }
@@ -535,6 +536,7 @@ static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 {
     return vext_wide_check_common(s, vd, vm) &&
+           vext_check_input_eew(s, vs, s->sew + 1, -1, 0, vm) &&
            require_align(vs, s->lmul + 1);
 }
 
@@ -553,6 +555,7 @@ static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew, vm) &&
            require_align(vs1, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs1, s->lmul);
 }
@@ -575,12 +578,14 @@ static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs1, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew + 1, vm) &&
            require_align(vs2, s->lmul + 1);
 }
 
 static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
 {
-    bool ret = vext_narrow_check_common(s, vd, vs, vm);
+    bool ret = vext_narrow_check_common(s, vd, vs, vm) &&
+               vext_check_input_eew(s, vs, s->sew + 1, -1, 0, vm);
     if (vd != vs) {
         ret &= require_noover(vd, s->lmul, vs, s->lmul + 1);
     }
@@ -603,6 +608,7 @@ static bool vext_check_sd(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_sd(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew + 1, vm) &&
            require_align(vs1, s->lmul);
 }
 
@@ -1531,6 +1537,16 @@ static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
+/* OPIVV with overwrite and WIDEN */
+static bool opivv_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs1, s->sew, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            gen_helper_gvec_4_ptr *fn,
                            bool (*checkfn)(DisasContext *, arg_rmrr *))
@@ -1578,6 +1594,14 @@ static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
+static bool opivx_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 #define GEN_OPIVX_WIDEN_TRANS(NAME, CHECK) \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                    \
 {                                                                         \
@@ -2049,13 +2073,13 @@ GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
 GEN_OPIVX_TRANS(vnmsub_vx, opivx_check)
 
 /* Vector Widening Integer Multiply-Add Instructions */
-GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_widen_check)
-GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmacc_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx, opivx_widen_check)
-GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx, opivx_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccu_vv, opivv_overwrite_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmacc_vv, opivv_overwrite_widen_check)
+GEN_OPIVV_WIDEN_TRANS(vwmaccsu_vv, opivv_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccu_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmacc_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccsu_vx, opivx_overwrite_widen_check)
+GEN_OPIVX_WIDEN_TRANS(vwmaccus_vx, opivx_overwrite_widen_check)
 
 /* Vector Integer Merge and Move Instructions */
 static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
@@ -2396,6 +2420,17 @@ static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
 
+static bool opfvv_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs1, s->sew, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 /* OPFVV with WIDEN */
 #define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
@@ -2435,6 +2470,16 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
+static bool opfvf_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+{
+    return require_rvv(s) &&
+           require_rvf(s) &&
+           require_scale_rvf(s) &&
+           vext_check_isa_ill(s) &&
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
+}
+
 /* OPFVF with WIDEN */
 #define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
@@ -2559,14 +2604,14 @@ GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
 
 /* Vector Widening Floating-Point Fused Multiply-Add Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_overwrite_widen_check)
+GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_overwrite_widen_check)
+GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_overwrite_widen_check)
 
 /* Vector Floating-Point Square-Root Instruction */
 
-- 
2.43.0


