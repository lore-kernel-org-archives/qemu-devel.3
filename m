Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1B710706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oBx-0001X8-IO; Wed, 18 Mar 2026 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBt-0001Vu-Qw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBp-0002IC-T9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so40271975e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829907; x=1774434707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQ3zUzJ2FjK4yIIVfR4qK+5n7J5Lr2pGjFB5SIZiZ7w=;
 b=X18wNVTyITY+KkxiNeXDVH5HOUm5Fw3bYvUgSj4YY4/cpWYvz+PC7VHqVEtVW5MIHE
 VdkuwszeQ6g2UYDTI2cKUCDi13D+NXQsUQiSBwXyNqxidA91vP+scrdt4ZLfCn8NumLh
 nvE8DjqN8DgHTkkfeXar+vf146W4NxPSSH/XoxvxtZES9g0zoYiRa8kKIzqzK/WPXD3J
 298Er9V1vMnM6Thr661mS0hpNdNzH0doqmb0tFmQBk7pd+psAqNpkoI5zUDO50hCOVe7
 Fe1vSK0coij8tKiRb/g1Fc84EmJSiA+gyGMPr1K1tps9DW++mEFHBdbQuqoSr4zt+GZH
 Rtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829907; x=1774434707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQ3zUzJ2FjK4yIIVfR4qK+5n7J5Lr2pGjFB5SIZiZ7w=;
 b=aUOOCs60gGMzMC4fordNuODqvJTiTjFv1wscf2D1A3hq0EE31iErsYtMHc6kkSku4p
 cvoZ0Tcx3IezVnocXZccCb5C876EWX+OXMKvnMNcxR/FRSewkpWh47uCahI89CelNI0C
 fxkqNYr+QavQYhik4VG99eg30ZwKXdit32JvI3IA32TUwyFs7yWe4Ats36McG/v3vvjm
 3+7MHFUX00s9X4m/VUhwkew1bhjE8Zoic/6wDu0iAjElSVPtUz7JdT71RyyshX+2tDRr
 CkjbBQd8eeH0U8ShxdrLSRN/qfpWhqwsSPHT3ic5qtwXB86jfkjPFYZ21OGEqett7L45
 v97A==
X-Gm-Message-State: AOJu0Yzqz4rv/DM+XJtajAWr904iQ4Fuc1HGNgY/0lUfgJWwzKRxaIFd
 Y0vR4/DdFbqqpRCYPjcdTZlaQVHJjifz0tpUg5ePXqufmxA9Dwqzj8yMQYfdjbcrNGvr5Xo5+QO
 TpnqbaLs=
X-Gm-Gg: ATEYQzwrMa2a9XxGG9f/kOfH5v9Ld6kKq80snGT4YBfah3pzGzXc0ib8AVAYVc3aXJs
 mx/Fkf+cBVWK+oDj2F26pkPPHD65OIPbQ9HU064NCWmvon8gpn+tT4q8rD+9DCuZUlANGyY054c
 fjxPUfZZBmcJg1eD/tOUhar0HySzI5Kj+TjEo9OQ/crIwGRJuwWhrP6BLD8KXf3T1pTpssA/U6Z
 i2yYOw/K6/dAmbHR0xzUIpMA/7y/W/IsX6rw+11QF0RoYW2epWe/IynVYWe6PTTHhcrdKEMaefT
 JI6H731PTK6xvFXr2YyDN5wFHLaXTddcxiD+M0ycY7wbYAeJsMTwvcug1O8fYMe8gXzgZUMsO39
 BabgCPUhddFyfW80ZpmEUrrogwInD35IdwW/5fJPPA6Jg5OqjQWpmNNUNs3Wki/UqWIG1+OMq9d
 lKMpn+hmKoKQjwM2P1JNumhy/uK+5eZGrcM3A8nxsnLyL83QmdQH6g80qwkC7ekp51bUmXUgZs
X-Received: by 2002:a05:600c:8b45:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-486f457970bmr39907745e9.23.1773829907104; 
 Wed, 18 Mar 2026 03:31:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5184b7f7sm6663962f8f.4.2026.03.18.03.31.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:31:46 -0700 (PDT)
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
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-11.1 03/16] target/riscv: Make LQ and SQ use 128-bit ld/st
Date: Wed, 18 Mar 2026 11:31:08 +0100
Message-ID: <20260318103122.97244-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

The lq and sq helpers for the experimental rv128 architecture
currently use direct memory accesses.
Replace these direct accesses with the standard
tcg_gen_qemu_{ld,st}_i128 TCG helpers that handle endianness
issues.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Message-ID: <20260101181442.2489496-2-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 32 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 54b9b4f2413..2c82ae41a77 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -377,6 +377,9 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
     TCGv destl = dest_gpr(ctx, a->rd);
     TCGv desth = dest_gprh(ctx, a->rd);
     TCGv addrl = tcg_temp_new();
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv_i64 tl = tcg_temp_new_i64();
+    TCGv_i64 th = tcg_temp_new_i64();
 
     tcg_gen_addi_tl(addrl, src1l, a->imm);
 
@@ -388,10 +391,14 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
             tcg_gen_movi_tl(desth, 0);
         }
     } else {
-        /* assume little-endian memory access for now */
-        tcg_gen_qemu_ld_tl(destl, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_ld_tl(desth, addrl, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_extr_i128_i64(tl, th, t16);
+        } else {
+            tcg_gen_extr_i128_i64(th, tl, t16);
+        }
+        tcg_gen_trunc_i64_tl(destl, tl);
+        tcg_gen_trunc_i64_tl(desth, th);
     }
 
     gen_set_gpr128(ctx, a->rd, destl, desth);
@@ -488,16 +495,25 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv src2l = get_gpr(ctx, a->rs2, EXT_NONE);
     TCGv src2h = get_gprh(ctx, a->rs2);
     TCGv addrl = tcg_temp_new();
+    TCGv_i128 t16 = tcg_temp_new_i128();
+    TCGv_i64 tl = tcg_temp_new_i64();
+    TCGv_i64 th = tcg_temp_new_i64();
 
     tcg_gen_addi_tl(addrl, src1l, a->imm);
 
     if ((memop & MO_SIZE) <= MO_64) {
         tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, memop);
     } else {
-        /* little-endian memory access assumed for now */
-        tcg_gen_qemu_st_tl(src2l, addrl, ctx->mem_idx, MO_TEUQ);
-        tcg_gen_addi_tl(addrl, addrl, 8);
-        tcg_gen_qemu_st_tl(src2h, addrl, ctx->mem_idx, MO_TEUQ);
+
+        tcg_gen_ext_tl_i64(tl, src2l);
+        tcg_gen_ext_tl_i64(th, src2h);
+
+        if (mo_endian(ctx) == MO_LE) {
+            tcg_gen_concat_i64_i128(t16, tl, th);
+        } else {
+            tcg_gen_concat_i64_i128(t16, th, tl);
+        }
+        tcg_gen_qemu_st_i128(t16, addrl, ctx->mem_idx, memop);
     }
     return true;
 }
-- 
2.53.0


