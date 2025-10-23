Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D80CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjN-0000f5-Kb; Thu, 23 Oct 2025 00:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjK-0000co-2p
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:14 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjH-0007J6-SE
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso449290b3a.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192909; x=1761797709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dT1VY6c3XA4W7tm/UffiQu1Cbfu56OKc9VjdmzDBxLA=;
 b=kUDrA9U6aV5oIN7MA8cbBgM1Odj7SQBNCCgucYWMOS9w3fBiDivDLqx6Wh7Vg+CebE
 aitt1gBoNCG2uK7CUCkJTxBi7M7ujaJiYeJgapKm+SsENTu13QFCqb05h3Ve9dlZi/Hu
 j/g1GQo1aptHIyKluJN5eluiYhZpa36z6AGTy+13R+dXLsICou2DnF/RvoNn17yPEzCQ
 W6zas0FSoP3jlhH3nsSRvUY5AjfSCD2BKn97Snfov50f9bFl5CLGW/S77FjVtWTK+asu
 IDTMhEY43sSGcQcSMUWSOeLz83MdXR4I4wn3yXYQGQKgHAmN49IzlEfs0DdyxHhcI+bC
 51Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192909; x=1761797709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dT1VY6c3XA4W7tm/UffiQu1Cbfu56OKc9VjdmzDBxLA=;
 b=sq4d6Qx5u0PiyG4D0+q4yPFS/U5sBYAA3R95MIoBUDiqoBhpKEzlaWjhfRdIWLvNw3
 CvLwBo3rpVL3Go4WiPDPcmEgJBpKZm3Z7OYjxD5/sj9wyUBOq9V1qnrmJKvpGJwpqV5Y
 roFXk7WCqeVTzIdCCfxWmbpXHoXybOmRjeZIr6AOw1gAb+3NlZSW9v4VE60yWDNv6B93
 wuaG2GL0OhLHVHjdoNozLt1Zu3OuC45mQ8htEZo2f+kXL2N/+hLAFchMj2GlgKxGxuea
 yzgXj6+cvOIzxLQZ0DLx0tvAUcx6soVNfoMGYwqeN2TaoOC5hASvib2IGruTbjiXTl+Z
 lAQQ==
X-Gm-Message-State: AOJu0YwLp2dkaxOoz1R79DfW7HwfvA1+E2k1k9KOY8GaDcPSBVK7D1bW
 MQdw1lD45w7oC0sLZky/R/DXadhLLawQ+DoUbUxBkaktWJyRS7G7lmNs8/o7Aw==
X-Gm-Gg: ASbGnctOfTd9uUOkbxns+cgY2WeDnMTJH0V4SLBrWqts52CPEb14TmE01FHWDucZOP4
 pVxorkN1pR8lEx3B3IMCyatQgzLftkoboasU6VJo43AM1DGFtp4udt/uURTQJIoFWJ/lfEmb4e7
 qwuWYHqLD+wURIYGZUpgosjGDEWMG+mXJXShGXxu8tj/+4PpTQA+zzCnnFbZwg9JgVznXHUWq9B
 hRAPNiTV5mVJzkzQtkZVFUE4uaYGRTy/JGOWCm2SlxNX+HNNFnd77jy1l6aJ1uudLKFf56sVJeh
 yyWfr2IrnVXaYLsCyxqknWzIy8siOOj4zXYQvPumfoYFOrR4DKZotMqfiYPZWUtsoX0Lpky7NrP
 SveIiY/hNCH6HjfsivaA++W0ycwH2OZvhkuux3UWrMK3KEU/k3G6H+U1vpZq89DRlwnqnUO7IO4
 pQb5HUJlDHD5OhBJOxm44Na5nd5NeyFfbOKT1xiHcCpETeHQjcGKKl80nzgHgfVaj2S5BNfK+UU
 jk0i57Fhw==
X-Google-Smtp-Source: AGHT+IFV5JCap/WIO1udc1Ykp/0dcm7QZ4cE7drJGzUOU6na5mrhynNB/MxDxm8Grb3FD3Ow2euseg==
X-Received: by 2002:a05:6a00:228a:b0:780:fd97:77d4 with SMTP id
 d2e1a72fcca58-7a220a7f0d3mr26985619b3a.10.1761192908951; 
 Wed, 22 Oct 2025 21:15:08 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:08 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/37] target/riscv: Conceal MO_TE within gen_load_idx() /
 gen_store_idx()
Date: Thu, 23 Oct 2025 14:14:04 +1000
Message-ID: <20251023041435.1775208-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_load_idx() / gen_store_idx() set the MO_TE flag.
Set it once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-7-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 34 ++++++++++++----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 7e69906e5b..70c563664a 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -745,6 +745,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, rd);
 
@@ -762,6 +763,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
+    memop |= MO_TE;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
 
     return true;
@@ -771,32 +773,32 @@ static bool trans_th_lrd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SQ, false);
+    return gen_load_idx(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_lrw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SL, false);
+    return gen_load_idx(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_lrwu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UL, false);
+    return gen_load_idx(ctx, a, MO_UL, false);
 }
 
 static bool trans_th_lrh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SW, false);
+    return gen_load_idx(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_lrhu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UW, false);
+    return gen_load_idx(ctx, a, MO_UW, false);
 }
 
 static bool trans_th_lrb(DisasContext *ctx, arg_th_memidx *a)
@@ -815,19 +817,19 @@ static bool trans_th_srd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SQ, false);
+    return gen_store_idx(ctx, a, MO_SQ, false);
 }
 
 static bool trans_th_srw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SL, false);
+    return gen_store_idx(ctx, a, MO_SL, false);
 }
 
 static bool trans_th_srh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SW, false);
+    return gen_store_idx(ctx, a, MO_SW, false);
 }
 
 static bool trans_th_srb(DisasContext *ctx, arg_th_memidx *a)
@@ -839,32 +841,32 @@ static bool trans_th_lurd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SQ, true);
+    return gen_load_idx(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_lurw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SL, true);
+    return gen_load_idx(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_lurwu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UL, true);
+    return gen_load_idx(ctx, a, MO_UL, true);
 }
 
 static bool trans_th_lurh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_SW, true);
+    return gen_load_idx(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_lurhu(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_load_idx(ctx, a, MO_TE | MO_UW, true);
+    return gen_load_idx(ctx, a, MO_UW, true);
 }
 
 static bool trans_th_lurb(DisasContext *ctx, arg_th_memidx *a)
@@ -883,19 +885,19 @@ static bool trans_th_surd(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
     REQUIRE_64BIT(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SQ, true);
+    return gen_store_idx(ctx, a, MO_SQ, true);
 }
 
 static bool trans_th_surw(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SL, true);
+    return gen_store_idx(ctx, a, MO_SL, true);
 }
 
 static bool trans_th_surh(DisasContext *ctx, arg_th_memidx *a)
 {
     REQUIRE_XTHEADMEMIDX(ctx);
-    return gen_store_idx(ctx, a, MO_TE | MO_SW, true);
+    return gen_store_idx(ctx, a, MO_SW, true);
 }
 
 static bool trans_th_surb(DisasContext *ctx, arg_th_memidx *a)
-- 
2.51.0


