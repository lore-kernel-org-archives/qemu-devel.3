Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727BFC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 14:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyXRB-00088P-Hv; Sat, 29 Mar 2025 10:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXR6-00084w-SA
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1tyXR4-0004Sl-Lx
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 10:45:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2240b4de12bso29627625ad.2
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743259521; x=1743864321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tIlPjmiVXJ11RniASEfA9pzU1FEFazuJvw0YnA23RU=;
 b=TAR8VprRG6WjvM87ukWBP9Z9PjLVlPCJn2P1YEYlHgEc0MefqAzUhoKYZklsp1il0V
 kyxGa1RqVP+x1p4Mh5fJTLWm/NRALCFMNxmAgf/O2JYvLItmO0NOGIF46Bs9MG1Wg8kB
 tyj6xMEhQ1i4WIXN/z3GaNTZrBlcX6lT8gA+N9FFJxn4/1tfYXUBVrurBuV9hzoURfa3
 UaCfDHSAE+KHMER2CCCPCGIbDj/vj5/hyd0Enjlel+xsw6NJ5ims0E3s3iRmV2FCOPQm
 TsDAru9k8/stCNpAUNtga53K+C+J+ssCNvo85hTEcKBsbvTDZYtWc890gTP1mPNKBssF
 ZnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743259521; x=1743864321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tIlPjmiVXJ11RniASEfA9pzU1FEFazuJvw0YnA23RU=;
 b=cjDPQXgc05EYtHVQ1cNqabcnzPVA4pvW2VmdkIOz2TJL3bk9Zuw/6mt0JOn/VXrUBr
 aZ10BaVX9XR/936twS3mk3guDgtNr/2eRkwHLtL8g8f8lNgsgiC2o2OGnrMUBYMjgJc4
 Lpy3TQPguSDdneVgExrV2YkBuk9X2yhQ0zUCOdrWvGdEOOupvlW8/LbkLFwkimQHYUf4
 BF9a6q5dMoh/cMHj1pcv8w+BBPyqaaKJVv62ZaWpa4IWF+krBHTeKIKtFjC4ps9P6329
 Q4gxwUXHVjNHY2vK03k2332Tx3lhxms15sQ3M17mvdUsCYVEtrElkZmPWa6SsBMJqLfo
 R7hw==
X-Gm-Message-State: AOJu0Yz5h5pK9DUU0AwgPfafUPtaagOwdzS/xcC/HqsKAZ6ddaFahAi5
 ND2dTYizcgsZcVqULYcNsmKzdq+q9XGTFPaknOHFCYKLjgakgGWnqfAAIHOtWk8e5GSclIP3Bz1
 w+GQqW1xP2PtGynU4WDnd97cOAWtvFOFVV3aAuOVZ0bChsi9PIZ9xNgQP75BJRVeJe/czGfD6vP
 AwJ9Wh5T38yTYhtPQx+vFgUmerJcJmXF7NZTudKw==
X-Gm-Gg: ASbGncvAEIBAMvc+QLOrmgftkcYyJBvIEK1+JZ91qypjB+gpoVteNAj6L5wSSfOHlN6
 uVnrYW3JOQzfYxi90f0yn/I/nkfqUW2wN4N1dwz0H8MvY05dU0ZlibaNAkTq0Ygs2iYcSukQgr1
 lQIM77eAA2tSdD5Gg9EZMXTypFpNsq/tb1/fySUP9FsLdM/gggyLNBumQqI7OFcROCm6qN8z5kH
 hOqyI6dQtUch3IbUUI98JbL6cCEAOYcbYECkkXYewvZqfoLyxcoGqdCdyVeQ259cHHpR/gXhBXx
 xQgoLnm5QejK3jN3dCwE9wn2CBpt4pZiJiR/EqVfsxmDycpWCgxzN1iFtlEEd1aya65fFbMXSuu
 IJvQ0v5AqCHE5Vw==
X-Google-Smtp-Source: AGHT+IFwDr3CoMhIab+lG3j3En+kQTFnJfqVKmVbP4Agw2cnWlrBX3duEpbrNdyZnkAUsQEyEfRRdA==
X-Received: by 2002:a17:903:228a:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-2292f9423e1mr50580785ad.11.1743259520712; 
 Sat, 29 Mar 2025 07:45:20 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f6b6bcbsm6737196a91.45.2025.03.29.07.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 07:45:20 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 09/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector widen instructions(OPMVV/OPMVX/etc.)
Date: Sat, 29 Mar 2025 22:44:43 +0800
Message-ID: <20250329144446.2619306-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329144446.2619306-1-max.chou@sifive.com>
References: <20250329144446.2619306-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x632.google.com
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
Co-authored-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc |  9 ++-
 target/riscv/insn_trans/trans_rvv.c.inc    | 73 +++++++++++++++++-----
 2 files changed, 65 insertions(+), 17 deletions(-)

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
index 728912fc1f2..f30157939b8 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -529,6 +529,7 @@ static bool vext_narrow_check_common(DisasContext *s, int vd, int vs2,
 static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 {
     return vext_wide_check_common(s, vd, vm) &&
+           vext_check_input_eew(s, vs, s->sew, -1, 0, vm) &&
            require_align(vs, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs, s->lmul);
 }
@@ -536,6 +537,7 @@ static bool vext_check_ds(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 {
     return vext_wide_check_common(s, vd, vm) &&
+           vext_check_input_eew(s, vs, s->sew + 1, -1, 0, vm) &&
            require_align(vs, s->lmul + 1);
 }
 
@@ -554,6 +556,7 @@ static bool vext_check_dd(DisasContext *s, int vd, int vs, int vm)
 static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs2, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew, vm) &&
            require_align(vs1, s->lmul) &&
            require_noover(vd, s->lmul + 1, vs1, s->lmul);
 }
@@ -576,6 +579,7 @@ static bool vext_check_dss(DisasContext *s, int vd, int vs1, int vs2, int vm)
 static bool vext_check_dds(DisasContext *s, int vd, int vs1, int vs2, int vm)
 {
     return vext_check_ds(s, vd, vs1, vm) &&
+           vext_check_input_eew(s, vs1, s->sew, vs2, s->sew + 1, vm) &&
            require_align(vs2, s->lmul + 1);
 }
 
@@ -1532,6 +1536,16 @@ static bool opivv_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -1579,6 +1593,14 @@ static bool opivx_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -2050,13 +2072,13 @@ GEN_OPIVX_TRANS(vmadd_vx, opivx_check)
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
@@ -2397,6 +2419,17 @@ static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -2436,6 +2469,16 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
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
@@ -2560,14 +2603,14 @@ GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
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


