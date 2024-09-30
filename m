Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154F0CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCRh-0001Cj-5n; Mon, 30 Sep 2024 05:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRf-000175-Va
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRc-0004bT-0s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so32920925e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687510; x=1728292310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xe8ibOwFnRIMlTGImGSanb0hSlMbHwC9x9mAJ2BGppM=;
 b=mKjz6LLisjt4YvaHNa9IFZ5ytZnPnOWmox/ILQaaqD4a8q7SmN2Laq1NOX2Xt9fQrl
 +WVuYPP1Ib7QMQXfafeKjI04x/mx14jVivelWE6xouKnJXbUHx8m4GH7QabrL8hBjX7L
 4rs7f0+hHUoN3Po2D1VxXuWQzDo3uW55j6JnA3wDWMfe/tNhcST4VmpUNs7lPtRrbCd0
 oJ/m0+uBhYJiF2j2UnMci/i9d/uW1kdPZ8YxzTXHulIRuKI50KM/tOGPqmlDylIrFA6D
 Kk7oBDO0Gb4i5SG4b5cJjzsbmBVH3ax5gSgIIx8XHngSoUGO0Pf+sPU3AOre8VcxAwON
 brBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687510; x=1728292310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xe8ibOwFnRIMlTGImGSanb0hSlMbHwC9x9mAJ2BGppM=;
 b=Axhsp/DVuRl04ekXNUrzQvfeDiNynQWWHuZxinRPtzMF3inXvtkwi6raatJwAeXpfI
 OuINu6rrklu/d36lno+JEIjXxRLqEtpTdk+WPOwK3XdxqiYPVVXa6T0l2ETELEMPeUam
 yS7CV8BLB/1GzxVXB1b9APh2LZ1B769mGNv1Ve7Y1asORc+QRmSPyWbcg8vJR7k1nKg6
 ZJqOr5wr4MhhZPIdOVCNHC+lSdAkBrsk2EEOjCr1o+/8yQMMzwjmqA2brRisy86CRqw+
 cM33kUTDr4omWMEXK79PWgMOnMkzPFDOYFcAlKYCaWWJ3HRuHEL0s1bre241N7rRs+M2
 sjCA==
X-Gm-Message-State: AOJu0YzyaEdnGLhuhREcLKrhUn9ElsHl5mqmMjj4DRPv767XHUDkC86v
 kkYNU+UUKy5E7x6mgCmT7VIWFnfIBFDgvhUGhNDHFcfZsmcsiiwq4DVTF1HsmLBggtZ8zTbYr/e
 3
X-Google-Smtp-Source: AGHT+IG2cpwsQI6ArbE4zdMXjSxuk6MBofjxxCfvW7USVey60zomP5T/EnLb0sqGzU+r0uuMzFAvzg==
X-Received: by 2002:a5d:49c2:0:b0:37c:d26c:8dc4 with SMTP id
 ffacd0b85a97d-37cd5af25cemr6166634f8f.36.1727687509701; 
 Mon, 30 Sep 2024 02:11:49 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd574283fsm8461586f8f.99.2024.09.30.02.11.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:11:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 06/12] target/mips: Explode MO_TExx -> MO_TE | MO_xx
Date: Mon, 30 Sep 2024 11:10:55 +0200
Message-ID: <20240930091101.40591-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Extract the implicit MO_TE definition in order to replace
it by runtime variable in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/mips); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c           |   8 +-
 target/mips/tcg/translate.c               | 120 +++++++++++-----------
 target/mips/tcg/tx79_translate.c          |   8 +-
 target/mips/tcg/micromips_translate.c.inc |  22 ++--
 target/mips/tcg/mips16e_translate.c.inc   |  12 +--
 target/mips/tcg/nanomips_translate.c.inc  |  32 +++---
 6 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c517258ac5..b221f7a4a0 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1533,7 +1533,7 @@ static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
     tcg_gen_add_tl(t0, t0, t1);
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |
                         ctx->default_tcg_memop_mask);
     gen_store_mxu_gpr(t1, XRa);
 
@@ -1569,7 +1569,7 @@ static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
 
     gen_load_mxu_gpr(t1, XRa);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |
                         ctx->default_tcg_memop_mask);
 
     if (postinc) {
@@ -1605,7 +1605,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
     tcg_gen_add_tl(t0, t0, t1);
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |
                         ctx->default_tcg_memop_mask);
     gen_store_mxu_gpr(t1, XRa);
 
@@ -1675,7 +1675,7 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
 
     gen_load_mxu_gpr(t1, XRa);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                       (MO_TESL ^ (reversed ? MO_BSWAP : 0)) |
+                       (MO_TE | MO_SL ^ (reversed ? MO_BSWAP : 0)) |
                         ctx->default_tcg_memop_mask);
 
     if (postinc) {
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 333469b268..906fd3d73c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1964,9 +1964,9 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
     gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(mem_idx));      \
 }
 #endif
-OP_LD_ATOMIC(ll, MO_TESL);
+OP_LD_ATOMIC(ll, MO_TE | MO_SL);
 #if defined(TARGET_MIPS64)
-OP_LD_ATOMIC(lld, MO_TEUQ);
+OP_LD_ATOMIC(lld, MO_TE | MO_UQ);
 #endif
 #undef OP_LD_ATOMIC
 
@@ -2073,12 +2073,12 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_LWU:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUL |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LD:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2090,33 +2090,33 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LDL:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxl(ctx, t1, t0, mem_idx, MO_TEUQ);
+        gen_lxl(ctx, t1, t0, mem_idx, MO_TE | MO_UQ);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LDR:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxr(ctx, t1, t0, mem_idx, MO_TEUQ);
+        gen_lxr(ctx, t1, t0, mem_idx, MO_TE | MO_UQ);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LDPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UQ);
         gen_store_gpr(t0, rt);
         break;
 #endif
     case OPC_LWPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_SL);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LWE:
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LW:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESL |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2124,7 +2124,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LH:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TESW |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_SW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2132,7 +2132,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LHU:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TEUW |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2156,7 +2156,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LWL:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxl(ctx, t1, t0, mem_idx, MO_TEUL);
+        gen_lxl(ctx, t1, t0, mem_idx, MO_TE | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
         break;
@@ -2166,7 +2166,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LWR:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxr(ctx, t1, t0, mem_idx, MO_TEUL);
+        gen_lxr(ctx, t1, t0, mem_idx, MO_TE | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
         break;
@@ -2194,7 +2194,7 @@ static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_SD:
-        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SDL:
@@ -2208,14 +2208,14 @@ static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_SW:
-        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SHE:
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_SH:
-        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TEUW |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TE | MO_UW |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SBE:
@@ -2281,7 +2281,7 @@ static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
     case OPC_LWC1:
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
-            tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TESL |
+            tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_SL |
                                 ctx->default_tcg_memop_mask);
             gen_store_fpr32(ctx, fp0, ft);
         }
@@ -2290,14 +2290,14 @@ static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, ft);
-            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TEUL |
+            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_UL |
                                 ctx->default_tcg_memop_mask);
         }
         break;
     case OPC_LDC1:
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TEUQ |
+            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ |
                                 ctx->default_tcg_memop_mask);
             gen_store_fpr64(ctx, fp0, ft);
         }
@@ -2306,7 +2306,7 @@ static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, ft);
-            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TEUQ |
+            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ |
                                 ctx->default_tcg_memop_mask);
         }
         break;
@@ -2987,14 +2987,14 @@ static inline void gen_pcrel(DisasContext *ctx, int opc, target_ulong pc,
     case R6_OPC_LWPC:
         offset = sextract32(ctx->opcode << 2, 0, 21);
         addr = addr_add(ctx, pc, offset);
-        gen_r6_ld(addr, rs, ctx->mem_idx, MO_TESL);
+        gen_r6_ld(addr, rs, ctx->mem_idx, MO_TE | MO_SL);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_LWUPC:
         check_mips_64(ctx);
         offset = sextract32(ctx->opcode << 2, 0, 21);
         addr = addr_add(ctx, pc, offset);
-        gen_r6_ld(addr, rs, ctx->mem_idx, MO_TEUL);
+        gen_r6_ld(addr, rs, ctx->mem_idx, MO_TE | MO_UL);
         break;
 #endif
     default:
@@ -3021,7 +3021,7 @@ static inline void gen_pcrel(DisasContext *ctx, int opc, target_ulong pc,
             check_mips_64(ctx);
             offset = sextract32(ctx->opcode << 3, 0, 21);
             addr = addr_add(ctx, (pc & ~0x7), offset);
-            gen_r6_ld(addr, rs, ctx->mem_idx, MO_TEUQ);
+            gen_r6_ld(addr, rs, ctx->mem_idx, MO_TE | MO_UQ);
             break;
 #endif
         default:
@@ -4160,10 +4160,10 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
     case OPC_GSLQ:
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rt);
         gen_store_gpr(t0, lsq_rt1);
@@ -4172,10 +4172,10 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         check_cp1_enabled(ctx);
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_fpr64(ctx, t1, rt);
         gen_store_fpr64(ctx, t0, lsq_rt1);
@@ -4184,11 +4184,11 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
         gen_load_gpr(t1, lsq_rt1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_GSSQC1:
@@ -4196,11 +4196,11 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
         gen_load_fpr64(ctx, t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
         gen_load_fpr64(ctx, t1, lsq_rt1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
 #endif
@@ -4213,7 +4213,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_load_fpr32(ctx, fp0, rt);
             t1 = tcg_temp_new();
             tcg_gen_ext_i32_tl(t1, fp0);
-            gen_lxl(ctx, t1, t0, ctx->mem_idx, MO_TEUL);
+            gen_lxl(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UL);
             tcg_gen_trunc_tl_i32(fp0, t1);
             gen_store_fpr32(ctx, fp0, rt);
             break;
@@ -4224,7 +4224,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_load_fpr32(ctx, fp0, rt);
             t1 = tcg_temp_new();
             tcg_gen_ext_i32_tl(t1, fp0);
-            gen_lxr(ctx, t1, t0, ctx->mem_idx, MO_TEUL);
+            gen_lxr(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UL);
             tcg_gen_trunc_tl_i32(fp0, t1);
             gen_store_fpr32(ctx, fp0, rt);
             break;
@@ -4234,7 +4234,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_base_offset_addr(ctx, t0, rs, shf_offset);
             t1 = tcg_temp_new();
             gen_load_fpr64(ctx, t1, rt);
-            gen_lxl(ctx, t1, t0, ctx->mem_idx, MO_TEUQ);
+            gen_lxl(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UQ);
             gen_store_fpr64(ctx, t1, rt);
             break;
         case OPC_GSLDRC1:
@@ -4242,7 +4242,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_base_offset_addr(ctx, t0, rs, shf_offset);
             t1 = tcg_temp_new();
             gen_load_fpr64(ctx, t1, rt);
-            gen_lxr(ctx, t1, t0, ctx->mem_idx, MO_TEUQ);
+            gen_lxr(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UQ);
             gen_store_fpr64(ctx, t1, rt);
             break;
 #endif
@@ -4360,7 +4360,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         gen_store_gpr(t0, rt);
         break;
     case OPC_GSLHX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -4369,7 +4369,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -4379,7 +4379,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -4390,7 +4390,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
         fp0 = tcg_temp_new_i32();
-        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TESL |
+        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_SL |
                             ctx->default_tcg_memop_mask);
         gen_store_fpr32(ctx, fp0, rt);
         break;
@@ -4400,7 +4400,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_fpr64(ctx, t0, rt);
         break;
@@ -4413,34 +4413,34 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     case OPC_GSSHX:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UW |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_GSSWX:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSSDX:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
 #endif
     case OPC_GSSWXC1:
         fp0 = tcg_temp_new_i32();
         gen_load_fpr32(ctx, fp0, rt);
-        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_UL |
                             ctx->default_tcg_memop_mask);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSSDXC1:
         t1 = tcg_temp_new();
         gen_load_fpr64(ctx, t1, rt);
-        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                             ctx->default_tcg_memop_mask);
         break;
 #endif
@@ -10779,7 +10779,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
 
-            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SL);
             tcg_gen_trunc_tl_i32(fp0, t0);
             gen_store_fpr32(ctx, fp0, fd);
         }
@@ -10789,7 +10789,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         check_cp1_registers(ctx, fd);
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TEUQ);
+            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
             gen_store_fpr64(ctx, fp0, fd);
         }
         break;
@@ -10799,7 +10799,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
 
-            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TEUQ);
+            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
             gen_store_fpr64(ctx, fp0, fd);
         }
         break;
@@ -10808,7 +10808,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, fs);
-            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TEUL);
+            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_UL);
         }
         break;
     case OPC_SDXC1:
@@ -10817,7 +10817,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, fs);
-            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TEUQ);
+            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
         }
         break;
     case OPC_SUXC1:
@@ -10826,7 +10826,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, fs);
-            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TEUQ);
+            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
         }
         break;
     }
@@ -11476,7 +11476,7 @@ void gen_ldxs(DisasContext *ctx, int base, int index, int rd)
         gen_op_addr_add(ctx, t0, t1, t0);
     }
 
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL);
     gen_store_gpr(t1, rd);
 }
 
@@ -11567,16 +11567,16 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
         gen_store_gpr(t0, rd);
         break;
     case OPC_LHX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SW);
         gen_store_gpr(t0, rd);
         break;
     case OPC_LWX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SL);
         gen_store_gpr(t0, rd);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_LDX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ);
         gen_store_gpr(t0, rd);
         break;
 #endif
@@ -13719,7 +13719,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case R6_OPC_SC:
-        gen_st_cond(ctx, rt, rs, imm, MO_TESL, false);
+        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_SL, false);
         break;
     case R6_OPC_LL:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -13765,7 +13765,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 #endif
 #if defined(TARGET_MIPS64)
     case R6_OPC_SCD:
-        gen_st_cond(ctx, rt, rs, imm, MO_TEUQ, false);
+        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_UQ, false);
         break;
     case R6_OPC_LLD:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -14448,7 +14448,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
             return;
         case OPC_SCE:
             check_cp0_enabled(ctx);
-            gen_st_cond(ctx, rt, rs, imm, MO_TESL, true);
+            gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_SL, true);
             return;
         case OPC_CACHEE:
             check_eva(ctx);
@@ -14912,7 +14912,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
-        gen_st_cond(ctx, rt, rs, imm, MO_TESL, false);
+        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_SL, false);
         break;
     case OPC_CACHE:
         check_cp0_enabled(ctx);
@@ -15191,7 +15191,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
         check_mips_64(ctx);
-        gen_st_cond(ctx, rt, rs, imm, MO_TEUQ, false);
+        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_UQ, false);
         break;
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC, OPC_DADDI */
         if (ctx->insn_flags & ISA_MIPS_R6) {
diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index dd6fb8a7bd..1d290b86a9 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -340,12 +340,12 @@ static bool trans_LQ(DisasContext *ctx, arg_i *a)
     tcg_gen_andi_tl(addr, addr, ~0xf);
 
     /* Lower half */
-    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
     gen_store_gpr(t0, a->rt);
 
     /* Upper half */
     tcg_gen_addi_i64(addr, addr, 8);
-    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
     gen_store_gpr_hi(t0, a->rt);
     return true;
 }
@@ -364,12 +364,12 @@ static bool trans_SQ(DisasContext *ctx, arg_i *a)
 
     /* Lower half */
     gen_load_gpr(t0, a->rt);
-    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
 
     /* Upper half */
     tcg_gen_addi_i64(addr, addr, 8);
     gen_load_gpr_hi(t0, a->rt);
-    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
     return true;
 }
 
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 7510831701..343d64a0e8 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -977,23 +977,23 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
             gen_reserved_instruction(ctx);
             return;
         }
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
         tcg_gen_movi_tl(t1, 4);
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
         break;
     case SWP:
         gen_load_gpr(t1, rd);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         tcg_gen_movi_tl(t1, 4);
         gen_op_addr_add(ctx, t0, t0, t1);
         gen_load_gpr(t1, rd + 1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
 #ifdef TARGET_MIPS64
@@ -1002,23 +1002,23 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
             gen_reserved_instruction(ctx);
             return;
         }
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
         tcg_gen_movi_tl(t1, 8);
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
         break;
     case SDP:
         gen_load_gpr(t1, rd);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         tcg_gen_movi_tl(t1, 8);
         gen_op_addr_add(ctx, t0, t0, t1);
         gen_load_gpr(t1, rd + 1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
 #endif
@@ -2572,13 +2572,13 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_st(ctx, mips32_op, rt, rs, offset);
             break;
         case SC:
-            gen_st_cond(ctx, rt, rs, offset, MO_TESL, false);
+            gen_st_cond(ctx, rt, rs, offset, MO_TE | MO_SL, false);
             break;
 #if defined(TARGET_MIPS64)
         case SCD:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            gen_st_cond(ctx, rt, rs, offset, MO_TEUQ, false);
+            gen_st_cond(ctx, rt, rs, offset, MO_TE | MO_UQ, false);
             break;
 #endif
         case LD_EVA:
@@ -2659,7 +2659,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
                 mips32_op = OPC_SHE;
                 goto do_st_lr;
             case SCE:
-                gen_st_cond(ctx, rt, rs, offset, MO_TESL, true);
+                gen_st_cond(ctx, rt, rs, offset, MO_TE | MO_SL, true);
                 break;
             case SWE:
                 mips32_op = OPC_SWE;
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 31bc14f9ca..9dd867fe89 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -135,7 +135,7 @@ static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
     tcg_gen_movi_tl(t2, -4);
     gen_op_addr_add(ctx, t0, t0, t2);
     gen_load_gpr(t1, regidx);
-    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                        ctx->default_tcg_memop_mask);
 }
 
@@ -184,25 +184,25 @@ static void gen_mips16_save(DisasContext *ctx,
     case 4:
         gen_base_offset_addr(ctx, t0, 29, 12);
         gen_load_gpr(t1, 7);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 3:
         gen_base_offset_addr(ctx, t0, 29, 8);
         gen_load_gpr(t1, 6);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 2:
         gen_base_offset_addr(ctx, t0, 29, 4);
         gen_load_gpr(t1, 5);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 1:
         gen_base_offset_addr(ctx, t0, 29, 0);
         gen_load_gpr(t1, 4);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
                            ctx->default_tcg_memop_mask);
     }
 
@@ -297,7 +297,7 @@ static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
 
     tcg_gen_movi_tl(t2, -4);
     gen_op_addr_add(ctx, t0, t0, t2);
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL |
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
                        ctx->default_tcg_memop_mask);
     gen_store_gpr(t1, regidx);
 }
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index b4b746d418..40ef0346a7 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -998,7 +998,7 @@ static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
     TCGv tmp2 = tcg_temp_new();
 
     gen_base_offset_addr(ctx, taddr, base, offset);
-    tcg_gen_qemu_ld_i64(tval, taddr, ctx->mem_idx, MO_TEUQ | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(tval, taddr, ctx->mem_idx, MO_TE | MO_UQ | MO_ALIGN);
     if (cpu_is_bigendian(ctx)) {
         tcg_gen_extr_i64_tl(tmp2, tmp1, tval);
     } else {
@@ -1075,7 +1075,7 @@ static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
         gen_base_offset_addr(ctx, va, 29, this_offset);
         gen_load_gpr(t0, this_rt);
         tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
-                           (MO_TEUL | ctx->default_tcg_memop_mask));
+                           (MO_TE | MO_UL | ctx->default_tcg_memop_mask));
         counter++;
     }
 
@@ -1095,7 +1095,7 @@ static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
         int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
         int this_offset = u - ((counter + 1) << 2);
         gen_base_offset_addr(ctx, va, 29, this_offset);
-        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TESL |
+        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TE | MO_SL |
                         ctx->default_tcg_memop_mask);
         tcg_gen_ext32s_tl(t0, t0);
         gen_store_gpr(t0, this_rt);
@@ -2647,13 +2647,13 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
     case NM_LHX:
     /*case NM_LHXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
-                           MO_TESW | ctx->default_tcg_memop_mask);
+                           MO_TE | MO_SW | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_LWX:
     /*case NM_LWXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
-                           MO_TESL | ctx->default_tcg_memop_mask);
+                           MO_TE | MO_SL | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_LBUX:
@@ -2663,7 +2663,7 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
     case NM_LHUX:
     /*case NM_LHUXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
-                           MO_TEUW | ctx->default_tcg_memop_mask);
+                           MO_TE | MO_UW | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_SBX:
@@ -2676,14 +2676,14 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                           MO_TEUW | ctx->default_tcg_memop_mask);
+                           MO_TE | MO_UW | ctx->default_tcg_memop_mask);
         break;
     case NM_SWX:
     /*case NM_SWXS:*/
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                           MO_TEUL | ctx->default_tcg_memop_mask);
+                           MO_TE | MO_UL | ctx->default_tcg_memop_mask);
         break;
     case NM_LWC1X:
     /*case NM_LWC1XS:*/
@@ -3737,7 +3737,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
                     tcg_gen_movi_tl(t0, addr);
                     tcg_gen_qemu_ld_tl(cpu_gpr[rt], t0, ctx->mem_idx,
-                                       MO_TESL | ctx->default_tcg_memop_mask);
+                                       MO_TE | MO_SL | ctx->default_tcg_memop_mask);
                 }
                 break;
             case NM_SWPC48:
@@ -3754,7 +3754,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     gen_load_gpr(t1, rt);
 
                     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                                       MO_TEUL | ctx->default_tcg_memop_mask);
+                                       MO_TE | MO_UL | ctx->default_tcg_memop_mask);
                 }
                 break;
             default:
@@ -4132,13 +4132,13 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
                         switch (extract32(ctx->opcode, 11, 4)) {
                         case NM_UALH:
-                            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
+                            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SW |
                                                MO_UNALN);
                             gen_store_gpr(t0, rt);
                             break;
                         case NM_UASH:
                             gen_load_gpr(t1, rt);
-                            tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
+                            tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UW |
                                                MO_UNALN);
                             break;
                         }
@@ -4161,7 +4161,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 case NM_P_SC:
                     switch (ctx->opcode & 0x03) {
                     case NM_SC:
-                        gen_st_cond(ctx, rt, rs, s, MO_TESL, false);
+                        gen_st_cond(ctx, rt, rs, s, MO_TE | MO_SL, false);
                         break;
                     case NM_SCWP:
                         check_xnp(ctx);
@@ -4274,7 +4274,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         check_xnp(ctx);
                         check_eva(ctx);
                         check_cp0_enabled(ctx);
-                        gen_st_cond(ctx, rt, rs, s, MO_TESL, true);
+                        gen_st_cond(ctx, rt, rs, s, MO_TE | MO_SL, true);
                         break;
                     case NM_SCWPE:
                         check_xnp(ctx);
@@ -4317,7 +4317,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         switch (extract32(ctx->opcode, 11, 1)) {
                         case NM_LWM:
                             tcg_gen_qemu_ld_tl(t1, va, ctx->mem_idx,
-                                               memop | MO_TESL);
+                                               memop | MO_TE | MO_SL);
                             gen_store_gpr(t1, this_rt);
                             if ((this_rt == rs) &&
                                 (counter != (count - 1))) {
@@ -4328,7 +4328,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                             this_rt = (rt == 0) ? 0 : this_rt;
                             gen_load_gpr(t1, this_rt);
                             tcg_gen_qemu_st_tl(t1, va, ctx->mem_idx,
-                                               memop | MO_TEUL);
+                                               memop | MO_TE | MO_UL);
                             break;
                         }
                         counter++;
-- 
2.45.2


