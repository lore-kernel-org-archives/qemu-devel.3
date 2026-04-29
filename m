Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CABFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwr2-00015e-OX; Wed, 29 Apr 2026 00:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwr1-000158-B2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:55 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwqz-0008Iz-Gs
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:48:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b2ea1b3962so68651595ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438132; x=1778042932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkLUQJjTejs5SkUpf6I65XYzbpK75WlvWkzO4cu5fqA=;
 b=PmCUy6mU4WY0AaqWzoFem0eQ3/8tGG6yZhAZsL3PUJ85AL5kN8oFbyt0xaeg3bbnab
 0vPGeyXpojg7t5/0PPDegH2RmbgBRKyOf4CE04b0O/IYQa5TdiQ1nteg6OJtNvuWXqHa
 TISMJvqhbneisw4iP1X9g7LCLVYvm0smhmjLlUPftj6jl7Vrhu8bGzEMDQ1M2+AbRKvt
 QX6kcScqsRGOSco6X4fYOixlDMbo0Yh2GrvsuZ7eAOqqpmdOpFx2fRG+XsXsTVapfz0d
 AendWVRq0DrGFdNrHM4lk78u7RqsKw0GXhR/X8msscQqH8MEc2J7W+wciIz+jLme1UgP
 K3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438132; x=1778042932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkLUQJjTejs5SkUpf6I65XYzbpK75WlvWkzO4cu5fqA=;
 b=E3OOLlnFcsSZLTvdpxoTe2fLH535Ub7pzGX5aDqGkmOIqJsn9cTToglELpDBKma21u
 HGrRWjZi2Pm8I6jdrauZzJKlPAsj7YyTj1OW8V46Nhb8EAZi69cBc0cqlBEDm6AWZMyT
 Bpcptxoz32zmW5NJ8DAslmxRhYQhpOoG0x7SWMqQQI8TcUe0GzsuPgj0zr8MwkDmZ35+
 6RZPMJ9uXiRLnK5IKFDIAFFu7iNuUI9xt7BxqcUwrLWSt6ciLi/izdWkQTY2qIsJd0O/
 KKFK1o0Ks1+U1SasoHc4+04XNgK6I8qdMlyJAAOHN7NZcIyTkPiGDSs+nko7+9c9apxu
 Gp+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ju2kLD2Wqs5l1HAsEsjYnaQF4Q0rGffc0AngGAxMnKh7EFSNw9GNPr6IfU7oStjpbqWWy6lONK2rH@nongnu.org
X-Gm-Message-State: AOJu0YzGNpIQdPmcpBepLzumbLiO4LGFayMZ2Ub9BUNuh0CmyyrHrUlG
 xeilTHv0w57uHUEXqc0AobbVJL/fI1J9wzX1HRUoK1w5lgMJweZTPdAN
X-Gm-Gg: AeBDietH5SEAp1k23dc2kR/at/aaSleQAAYMBaM04Yx7UKQCEfRnPtpjlMjHB5/VYgA
 m2fZRyqa3EkMqXc6eTijjegBImDXxzrANplaAfUVRtILKLnUpycYmUE72Z0cDDfDAmqejMotxvf
 9GlKaRhWOklmKU6dJbaXsusvR0BooWbF8Qfc2/t2gwrgdnIt/Vm78JbRbKRuMWF2DRiQdPH5VqN
 33hwY4w1ozuji3dMTkdHR6oRMkS+a5a9T+5KsRoZN32csKTuiwkvNyzw09VNxNHlZ7QXw6NCvuA
 RFhdWn6+TKn2xaIQEWtJ931DmvT/k8m7UUHxZS5IG+si2rFh0/PFj8Ydsuy+Vxg1CeOijbY5EX4
 DFmKswF5174EonoczPUa8YC2HYGjcBJpisL8SNNT9SlWSOJ+B71sH7fjgOzUGUPSap1+bwLgrJb
 XaBirlbg0e0F7GGaCGQBMbEU4fzDtdTtp6H2sPh3sf9QJEGkcoj5RF
X-Received: by 2002:a17:903:2a83:b0:2b2:ae89:fd44 with SMTP id
 d9443c01a7336-2b987359d09mr23771325ad.6.1777438132187; 
 Tue, 28 Apr 2026 21:48:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:48:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/51] target/riscv: Explode MO_TExx -> MO_TE | MO_xx (again)
Date: Wed, 29 Apr 2026 14:47:09 +1000
Message-ID: <20260429044752.4176397-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Following commit 73ae67fd4e6, extract the implicit MO_TE
definition in order to replace it.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/riscv); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-6-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 12 ++++++------
 target/riscv/insn_trans/trans_xmips.c.inc    | 16 ++++++++--------
 target/riscv/insn_trans/trans_zilsd.c.inc    |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
index bf86805cef..525f01ca34 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -49,20 +49,20 @@ static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
 static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
 }
 
 static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
 }
 
 static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZALASR(ctx);
-    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
+    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
 }
 
 static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
@@ -96,18 +96,18 @@ static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
 static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SW));
 }
 
 static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
 {
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
 }
 
 static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_ZALASR(ctx);
-    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
+    return gen_store_release(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
 }
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index 9a72f3392f..37572563ae 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -56,11 +56,11 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_y);
-    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SQ);
     gen_set_gpr(ctx, a->rd, dest0);
 
     tcg_gen_addi_tl(addr, addr, 8);
-    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SQ);
     gen_set_gpr(ctx, a->rs3, dest1);
 
     return true;
@@ -77,11 +77,11 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_x);
-    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TE | MO_SL);
     gen_set_gpr(ctx, a->rd, dest0);
 
     tcg_gen_addi_tl(addr, addr, 4);
-    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TE | MO_SL);
     gen_set_gpr(ctx, a->rs3, dest1);
 
     return true;
@@ -99,10 +99,10 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_w);
-    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_UQ);
 
     tcg_gen_addi_tl(addr, addr, 8);
-    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_UQ);
 
     return true;
 }
@@ -118,10 +118,10 @@ static bool trans_swp(DisasContext *ctx, arg_swp *a)
     TCGv addr = tcg_temp_new();
 
     tcg_gen_addi_tl(addr, src, a->imm_v);
-    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TE | MO_SL);
 
     tcg_gen_addi_tl(addr, addr, 4);
-    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TE | MO_SL);
 
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_trans/trans_zilsd.c.inc
index 369c33004b..445406cf01 100644
--- a/target/riscv/insn_trans/trans_zilsd.c.inc
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
     TCGv addr = get_address(ctx, a->rs1, a->imm);
     TCGv_i64 tmp = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
 
     if (a->rd == 0) {
         return true;
@@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
     } else {
         tcg_gen_concat_tl_i64(tmp, data_low, data_high);
     }
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
 
     return true;
 }
-- 
2.53.0


