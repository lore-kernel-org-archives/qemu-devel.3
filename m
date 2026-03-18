Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F4A107BCF5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oCV-0001p5-QZ; Wed, 18 Mar 2026 06:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oC8-0001ZR-UY
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oC5-0002PD-7l
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso4744992f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829922; x=1774434722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnDCTRCky1piZxyLRpsMcdQHH/JXGmpFXuBfJy0DyaU=;
 b=ms+7MurmhZm+4KNeRLBUwWmIYK6OPYtAfrbKVg5D8wknd+n2En5MfbdnZH3U6AR1Gs
 4pc4D/iWBo4f9YPkMOEISHw6t8t7xSvlx71G3iFby4BQ5Yql0vnk8j/YLSx/WmsCDbuQ
 Po4U78AafZlSBXHmgUuWIhE/z1eG+2hRCFdQDqI7LRzRVdX8wMyQSJynUieQf9htXjYd
 5cRm/AG4bn7DN4Y+9s5lNYjv+n4ci0zc2L/mM6HOWzLg8kb6OQomDVWwlBNEnj7igunQ
 hQ0Mu7kmp2/ttSlvgR7Q7pGsRV24ayytkKpBP2kikDIg4eG/CtmnsMYy8SGJaT6p7bBG
 J2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829922; x=1774434722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OnDCTRCky1piZxyLRpsMcdQHH/JXGmpFXuBfJy0DyaU=;
 b=dSglo6TM4wqhQ39dMdbQV2VeqmWcgRqHrEHm3vea37kPm3/gVeQOaFBTMteJRcZS65
 +XNCUybF6XvQilGED0upWfRXyZyYryZmxA1/eA0gSkoU4dmtOLhTv4/QGPPR2b3/Twcg
 2/r76iIg+ifH7UKRqznw5dCogpSvhuTDs5saa3jPGokuSpnvgJM3pr89HjVDPYmFnvdx
 iqzpOIlPrGpU8TqIIp4IgoM+rg9NPaWcoTcTpLPLfKL71oxwE90u358IuHQ3MpfltHtV
 itqx3YJegBOJKyyFi6WumhuJFu+qQZRKCtNMQ/2g9tNVzO7nlyXlGCoqIZyvmm0AgMSu
 uEgQ==
X-Gm-Message-State: AOJu0YxnPLq0oIleDdWNlLa2Uw/D2fRS3Yzs+03Ky90V6StzHg3020eh
 tW5+ZcvRZRs4kdGtwpyBhXhtOP3UH7nVyYanbVw2wy5UTEWysBvZrJ6avzyit6RSV0F2t9YuktY
 WPhcjicI=
X-Gm-Gg: ATEYQzzU2PFQVYEYgP8Mh0DQdghgPBExhArekcLcd83EWZ+55rSZEwVScDHBATcwQPv
 YYKDG9BC/siwFeiVVMqO2kvdyABEIh1ZZD1Cca/Qa9VegVp/ieCUzmQr+a0nx2gUNo4v/P+7eBZ
 8qZLu9kUembT5pxbr50BA3vUNFb0GfepGE+zTU0Ay42/OSe6NOCBkeOqJ9pEdbtMLSIjPVn0A2T
 GuDupXossO/NidpVvBqxN+92dYOy4OZdAg3pXhgDBrmhlibeDfHMyR+7OfMZGo+KmTT9nO0hP+s
 KgVcUGZgrpWailxaZYjKLI3w49NFjBAnjxM2Fw0BTMBRWc8sQeBdHRZ8MEu8fQBy9TmoGM4ENeE
 04TBbOeJujy4U4GFkvetSa42sZF+DqbBm1qSfgywK39fpk+XQorPmQriP8D9e3+SmCIHPC+4E0M
 9MM6wqPVIHTYvkG1oqJIDpc6kDOUSbQJjbvljhcaEyVUQd2WN7fBMaehU2rYiXyEY4mfQUbpj0
X-Received: by 2002:a05:6000:24c5:b0:43a:378:b48b with SMTP id
 ffacd0b85a97d-43b527c9af9mr4421697f8f.37.1773829921710; 
 Wed, 18 Mar 2026 03:32:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518588a0sm10615947f8f.16.2026.03.18.03.32.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 05/16] target/riscv: Explode MO_TExx -> MO_TE | MO_xx
 (again)
Date: Wed, 18 Mar 2026 11:31:10 +0100
Message-ID: <20260318103122.97244-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Following commit 73ae67fd4e6, extract the implicit MO_TE
definition in order to replace it.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/riscv); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 12 ++++++------
 target/riscv/insn_trans/trans_xmips.c.inc    | 16 ++++++++--------
 target/riscv/insn_trans/trans_zilsd.c.inc    |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
index bf86805cef6..525f01ca347 100644
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
index 9a72f3392f1..37572563ae9 100644
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
index 369c33004b6..445406cf015 100644
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


