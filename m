Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ED7CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgw-0007EQ-9l; Tue, 16 Jun 2026 06:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgu-0007Dt-Gd
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:44 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgs-0003Di-L7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:44 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c85a2c012e5so1466456a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604401; x=1782209201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oiSn8O3FBvzdVJGDR7fJW81Sm/kT5OP34oodmyNA8w=;
 b=U9+Gfu6oJqwpBaiyqG+3rfuVwziE5uUFRPccIKwDhaewlgZKgwumk4nXV0V8580SKH
 PBcxxEWhoJB7tnwQhNeyWKRHGzGrwlflUKwLafw0F2xk6dnU8X8zl3JkQ0fu5DIuO+7i
 WYUyFGiuX09gGw84SK8X2Ahrpxld42D67ArXnw8wkE3ZAhbos4ku53zTtfZYtRtnl3BR
 HepbXBkFyJjjBHXHh2r5++tWmb7wqlhVLtFPyrBed/nicjM9zWDurZncMr1AFir9M4OW
 IKIgqV1IZ+OR2t8Qr/YEliGq9C8BN/UUVrDMK0YOXMGfVsiLscsE9rS15mCmTIs6dm9j
 8OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604401; x=1782209201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8oiSn8O3FBvzdVJGDR7fJW81Sm/kT5OP34oodmyNA8w=;
 b=Wuw5CWY/nCpc627oE6cY+Zd/GAwMly4ydIpfeHwCzGRAeHehCiHatcmQqFApx/MGzB
 rHah+wmNlLyoir/l4QoCt2MaiEC7eTY0ADXnoXJ+OoWNArOjIB/pTq3uPXaf5Yk0HPF5
 dVW6Z1yIenmjXzAQtQQIdXbF1lC3RXbEY0bwsfR83yfNuokqdYEzGUTmH1uNVSb5P7iq
 HocYdSnNxDwhBG32P3zi+X+ndnwwTvo+K7ksC5BtTTsF6R2OoM5ct+nvGUt/2hqFAH7I
 TtpuXzmTQT1W7HF4NEvzwUSoi4pVXYjWXljEMnHZs01SSfx2nYSclDT/GidezoxLdcGI
 t55Q==
X-Gm-Message-State: AOJu0Yxx4ltG/dKDUcFSdK1n0NBLFsiGJRaj3lMdXHcI4ciUtFucXFQK
 QpRybhnumbDrEP5gWRitd14VJCBsN76GMVpWopJJUQv0VXMdD5L9yPcMCP2E60iQ
X-Gm-Gg: Acq92OHnq3Awp8ba4hMMgvcLeDLWfmXoQW2B3GZnoH4wMWuVx2X9oCoU1bS8JFZ0DWI
 OzBF6vh9m2MZ07CgU/gyfB9qCOoi+81/cvRZDu8BeQ1BSSKheXsuTRNc0lnH6C255PgtK3B82Jc
 Wvwa4q9J7GqxcMr+yqNVGoM9Ekbc10x5oCGlrANoQTkbFziHwcAe1T14dTbfrmqZTjguFvK4M9N
 c32KpYNLYSoUTAj1cf0tEs0rzqtle9BA5q+Nn4Lv/KpDG5JyortwBaUoClmXE/WzpG9WQbLC2fh
 fhSfLKFgi9sJLR59fmeWfAfxWtL5rJXfW3D1/uo0jDF0JHz/et+0/1vjR0RRhDCqBuFc4qeGPBe
 1SGY3B+R9JnqIX4zJ96MybthRodseURXfSxfQIaRpk4lkd85BCNg5geaeoz9S6I0d6m0Dfp5Q3E
 xeAXeIq+6y+cj3J/knbYfkwm0p7Z2+vOt1ZZY7GY67
X-Received: by 2002:a05:6a20:9f04:b0:3b3:1ee3:2794 with SMTP id
 adf61e73a8af0-3b7e4272829mr3493670637.5.1781604401282; 
 Tue, 16 Jun 2026 03:06:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/83] target/riscv: Fix size of retxh
Date: Tue, 16 Jun 2026 20:04:22 +1000
Message-ID: <20260616100527.1939565-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Anton Johansson <anjo@rev.ng>

128-bit helpers only make sense for MXL_RV128, TARGET_RISCV64,
and TCGv == TCGv_i64, therefore fix retxh to 64 bits.

For the sake of being pedandic, update 128-bit instructions to access
retxh via 64 bit TCG ops, even if they only make sense when TCGv ==
TCGv_i64.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-9-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                      |  2 +-
 target/riscv/insn_trans/trans_rvi.c.inc |  8 ++++++--
 target/riscv/insn_trans/trans_rvm.c.inc | 16 ++++++++++++----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5336344cba..0a684f146f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -250,7 +250,7 @@ struct CPUArchState {
     uint32_t xl;            /* current xlen */
 
     /* 128-bit helpers upper part return value */
-    target_ulong retxh;
+    uint64_t retxh;
 
     uint64_t jvt;
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 2c82ae41a7..ff450d46f8 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -1030,10 +1030,12 @@ static bool do_csrr_i128(DisasContext *ctx, int rd, int rc)
     TCGv destl = dest_gpr(ctx, rd);
     TCGv desth = dest_gprh(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
+    TCGv_i64 wide_desth = tcg_temp_new_i64();
 
     translator_io_start(&ctx->base);
     gen_helper_csrr_i128(destl, tcg_env, csr);
-    tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(desth, wide_desth);
     gen_set_gpr128(ctx, rd, destl, desth);
     return do_csr_post(ctx);
 }
@@ -1053,10 +1055,12 @@ static bool do_csrrw_i128(DisasContext *ctx, int rd, int rc,
     TCGv destl = dest_gpr(ctx, rd);
     TCGv desth = dest_gprh(ctx, rd);
     TCGv_i32 csr = tcg_constant_i32(rc);
+    TCGv_i64 wide_desth = tcg_temp_new_i64();
 
     translator_io_start(&ctx->base);
     gen_helper_csrrw_i128(destl, tcg_env, csr, srcl, srch, maskl, maskh);
-    tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_desth, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(desth, wide_desth);
     gen_set_gpr128(ctx, rd, destl, desth);
     return do_csr_post(ctx);
 }
diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/insn_trans/trans_rvm.c.inc
index 795f0ccf14..0e2da5bed2 100644
--- a/target/riscv/insn_trans/trans_rvm.c.inc
+++ b/target/riscv/insn_trans/trans_rvm.c.inc
@@ -169,8 +169,10 @@ static bool trans_mulhu(DisasContext *ctx, arg_mulhu *a)
 static void gen_div_i128(TCGv rdl, TCGv rdh,
                          TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_divs_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_div(TCGv ret, TCGv source1, TCGv source2)
@@ -212,8 +214,10 @@ static bool trans_div(DisasContext *ctx, arg_div *a)
 static void gen_divu_i128(TCGv rdl, TCGv rdh,
                           TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_divu_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_divu(TCGv ret, TCGv source1, TCGv source2)
@@ -244,8 +248,10 @@ static bool trans_divu(DisasContext *ctx, arg_divu *a)
 static void gen_rem_i128(TCGv rdl, TCGv rdh,
                          TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_rems_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_rem(TCGv ret, TCGv source1, TCGv source2)
@@ -289,8 +295,10 @@ static bool trans_rem(DisasContext *ctx, arg_rem *a)
 static void gen_remu_i128(TCGv rdl, TCGv rdh,
                           TCGv rs1l, TCGv rs1h, TCGv rs2l, TCGv rs2h)
 {
+    TCGv_i64 wide_rdh = tcg_temp_new_i64();
     gen_helper_remu_i128(rdl, tcg_env, rs1l, rs1h, rs2l, rs2h);
-    tcg_gen_ld_tl(rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_ld_i64(wide_rdh, tcg_env, offsetof(CPURISCVState, retxh));
+    tcg_gen_trunc_i64_tl(rdh, wide_rdh);
 }
 
 static void gen_remu(TCGv ret, TCGv source1, TCGv source2)
-- 
2.54.0


