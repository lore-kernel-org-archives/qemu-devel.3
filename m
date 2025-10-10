Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CA3CCD18D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75aU-0006kk-DY; Fri, 10 Oct 2025 01:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75aT-0006kU-88
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75aP-00010w-6U
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so864723f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073752; x=1760678552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxyw79BDyPzWZUDOlss+2O2wNC+MFML6pfrIxuJvSkw=;
 b=pu56pdWwLBnqD76WTJ2TnGvMoQssFHsbfGgEkn0hQShZd8XACzqsYm/kqp5Q4bA0cD
 ZlwU0f5xIIxvd0+RHcwhIqvpCmCfwgUMxc/3s+O8niaO3EpAMaA7+sX8HMpVPmBEHiGX
 pv0aMkYcX4cK9W9fJaKY7qPSyRFMzgWrJmVoffJqPIT+iQJgvIgfS656g2ZFQM2v7rec
 tGI/zn+UUyJVBt3rR9MSHV5bzSNpa1IMC7kzH4cSjDc8CADJBokuPonqe2fPEPQvr2aY
 Yzp5cS/htCdnWgd/ZGLTmmBQwnTWfd6VyP8bFlUlKo8TcRocvPJtPP6jgBzvPLwdwqY1
 bX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073752; x=1760678552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxyw79BDyPzWZUDOlss+2O2wNC+MFML6pfrIxuJvSkw=;
 b=ea+x7IJXDa5UK3sl8x9V/42Jbvim7OThdeo5sPIqR5xRJ8CwkI2WV49DUSWV106m6A
 f6Ieh4JnJsjtAXO/2+zvrzpzrqIcEweg4iWAJ7a50HlGbxj+ceJzLbK4ZHMoLSu8wvKH
 UIF9KFwX65yFtwrp397r454+tpYgK6cZvDa2HN+IjujdX1YYANQtixc5fYYiJS/+I/PE
 BxSalX69voPdd1IyD8CB9pO1r3DS4tmCc/XxRbQelPW6jIxkrVGfyhxMbyza4bn/Msqi
 aLa4zjZbdUC2trpZRZtJqhnCqREvpEk+Iuny0Bz4PaIDUgoVXKVqSmLKlopPILHpNKkG
 pdYQ==
X-Gm-Message-State: AOJu0YwX2PVxKiR8PXOQ8VWOf6PrQX+09tX/iQ9OU+hjA4B5kn3H3BlO
 badTqOoOa8KORaQH48koUPijonB+mWAcQh1UxwdLP+UTFPOzAGeC42RbTYn4Hz8riwD2bTDKDEN
 jFt0AkVX7atLw
X-Gm-Gg: ASbGncuGD4pyaNmZb2Cg0uPuPXNs8g1wMfxnyBIOjhAyQ6nyZLZLEKVnHwEolkXDb+X
 E1NwYI16t5m/jFUXWDXUzbuESPkdmR5VKGaX+gpcIL7OtDlfB/i0VXxnReQ7MbMP2zZE0fo2uVf
 zaxIJkox/O63J8rOVxwGX8wWDX4vMPW9i3EG+dODJ7hwPoMlIIv8ikcGSbz1u7XfV2zuV3+zAtI
 GJllkDpXLLxd2B1A7MhrdBlyERaErNhBhccLKE5W7ijvUV8jNzKv/DRvqpT1Hh2j+c9+DP/gxca
 w5pcLYZPDSXWf6fu/vNGxbUu3O22HX1arWULtWF7wd7AqFBohXU5pzHA0aOxLhjZ5qppxvC07Gv
 nujAjdbq6LeBra5vJyzGRow7jcbvTjRA4+ox2xuVjZRqFGv+g6EQUjssgPip8qL658Vnq1rlWnd
 /+SxezILeU/FPN7H3vmZ3pe/ZG
X-Google-Smtp-Source: AGHT+IH8jF6BHXgW+hXOvO+iZwkRPVRyLoGkgrqXridVCOKaaGkZ892IyGUAyfi0oArCoJjGaoW+sQ==
X-Received: by 2002:a05:6000:41d1:b0:400:6e06:e0ae with SMTP id
 ffacd0b85a97d-4266e8ddf1bmr6793247f8f.47.1760073751702; 
 Thu, 09 Oct 2025 22:22:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cd11sm2327565f8f.5.2025.10.09.22.22.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:22:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/12] target/tricore: Pass DisasContext as first argument
Date: Fri, 10 Oct 2025 07:21:38 +0200
Message-ID: <20251010052141.42460-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

Unify style, always pass DisasContext as the first argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 68 +++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index ce4e3f6202e..595db14bb2b 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -226,7 +226,7 @@ static inline void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,
     tcg_gen_qemu_st_i32(r1, temp, ctx->mem_idx, mop);
 }
 
-static void gen_st_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
+static void gen_st_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -234,15 +234,15 @@ static void gen_st_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
     tcg_gen_qemu_st_i64(temp, address, ctx->mem_idx, MO_LEUQ);
 }
 
-static void gen_offset_st_2regs(TCGv rh, TCGv rl, TCGv base, int16_t con,
-                                DisasContext *ctx)
+static void gen_offset_st_2regs(DisasContext *ctx,
+                                TCGv rh, TCGv rl, TCGv base, int16_t con)
 {
     TCGv temp = tcg_temp_new();
     tcg_gen_addi_i32(temp, base, con);
-    gen_st_2regs_64(rh, rl, temp, ctx);
+    gen_st_2regs_64(ctx, rh, rl, temp);
 }
 
-static void gen_ld_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
+static void gen_ld_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -251,12 +251,12 @@ static void gen_ld_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
     tcg_gen_extr_i64_i32(rl, rh, temp);
 }
 
-static void gen_offset_ld_2regs(TCGv rh, TCGv rl, TCGv base, int16_t con,
-                                DisasContext *ctx)
+static void gen_offset_ld_2regs(DisasContext *ctx,
+                                TCGv rh, TCGv rl, TCGv base, int16_t con)
 {
     TCGv temp = tcg_temp_new();
     tcg_gen_addi_i32(temp, base, con);
-    gen_ld_2regs_64(rh, rl, temp, ctx);
+    gen_ld_2regs_64(ctx, rh, rl, temp);
 }
 
 static void gen_st_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t off,
@@ -3798,11 +3798,11 @@ static void decode_abs_ldw(DisasContext *ctx)
         break;
     case OPC2_32_ABS_LD_D:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_ABS_LD_DA:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         break;
     case OPC2_32_ABS_LD_W:
         tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
@@ -3913,11 +3913,11 @@ static void decode_abs_store(DisasContext *ctx)
         break;
     case OPC2_32_ABS_ST_D:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_ABS_ST_DA:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         break;
     case OPC2_32_ABS_ST_W:
         tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
@@ -4289,36 +4289,36 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_D_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_st_2regs(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_st_2regs(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_ST_D_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_D_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_ST_DA_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_st_2regs(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_st_2regs(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_ST_DA_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_DA_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_ST_H_SHORTOFF:
@@ -4413,7 +4413,7 @@ static void decode_bo_addrmode_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_D_BR:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_D_CIRC:
@@ -4428,7 +4428,7 @@ static void decode_bo_addrmode_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_DA_BR:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2, ctx);
+        gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_DA_CIRC:
@@ -4520,36 +4520,36 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_D_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_ld_2regs(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_ld_2regs(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_LD_D_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_D_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_LD_DA_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_ld_2regs(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
-                            off10, ctx);
+        gen_offset_ld_2regs(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
+                            off10);
         break;
     case OPC2_32_BO_LD_DA_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_DA_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_LD_H_SHORTOFF:
@@ -4651,7 +4651,7 @@ static void decode_bo_addrmode_ld_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_D_BR:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_D_CIRC:
@@ -4666,7 +4666,7 @@ static void decode_bo_addrmode_ld_bitreverse_circular(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_DA_BR:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2, ctx);
+        gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2);
         gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_DA_CIRC:
@@ -8377,7 +8377,7 @@ static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     tcg_gen_insn_start(ctx->base.pc_next);
 }
 
-static bool insn_crosses_page(CPUTriCoreState *env, DisasContext *ctx)
+static bool insn_crosses_page(DisasContext *ctx, CPUTriCoreState *env)
 {
     /*
      * Return true if the insn at ctx->base.pc_next might cross a page boundary.
@@ -8420,7 +8420,7 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
         if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE
             || (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE - 3
-                && insn_crosses_page(env, ctx))) {
+                && insn_crosses_page(ctx, env))) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         }
     }
-- 
2.51.0


