Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E186C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYe-0008JM-87; Thu, 23 May 2024 19:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYW-0007pN-V6; Thu, 23 May 2024 19:09:05 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYS-0005kX-Qn; Thu, 23 May 2024 19:09:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f5053dc057so4048833b3a.2; 
 Thu, 23 May 2024 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505739; x=1717110539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lB5GqY0PlW3o6VVUNw0U2Pf07iRZlY3kfJLyLydulk=;
 b=AxTlhCK7joWRkKTZ0sDg7T6+pzrOmHRgKPJK6nKSo1AxItIiUQkx5NvGjXbhgOmGLB
 GjmQr57QNK9QikFfDlUqvaXjjrlZ1IqlVqMFE6elIs2ZU2jDQxUMkZLGxzqf73at+Zkg
 IZMEVDW4GIzur2EEV9GuxckmxvltQm1Cgg4MJVJX0aArpfI3QU74gsHx91YMVAxF+dNC
 iCQ52yhD4IeRkYd+rNS2Puf99oYIQk5G2XfX/lXNHp1g1Vo93qZtp9PuuGXSfdhjjX8y
 UEJCZL80/3D5pcEWDRvu5vLET5SwyHp6MY3ttsj6DKfr2UKw7ofssC474qM/AC4t0+W1
 uXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505739; x=1717110539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lB5GqY0PlW3o6VVUNw0U2Pf07iRZlY3kfJLyLydulk=;
 b=gVNJ6wiU5vtihf4WResYVsIb1hJq2kSB5qHhib5J11kpZYyne8oRQbr//NTeOypK4I
 ic6j4fvUYCFb0GMoulgSKwp9nvRKx/0LNKHrLHf7aD16LXyspZqBCrKF9mV4OO0Zozbt
 rSGGlkYhs7whFukrhXwYs84iP8RTvm4gZJqC7Q0oM36XlpJtWST0pSv+rXmyok2M7AdH
 dOlAsHGNJ0dMWARz9fyL9VK9jpMLwjkRd2AOtV31/08vyHY7a+e2NDyalWFlL2jF9DDp
 tIHYzF5f0L8Ftr92+g79AaNaK/ZXwuXI8HzzZNG4mYAuhoe/i6loY/xP1AdO5jC2sETI
 eFGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUmzB5nhDypCOkb4AXlMr3rQsnsvkFR3OUpcWP17kjfmnKSgaDxNsjDMWBA2sATvQD+Sp2blsqgYrvNrLyUrSll/NY
X-Gm-Message-State: AOJu0YzCU4yKCf6QdgodWVlHKdt+h6NYTj9Zs6teoDRQxqNJpRgBKH3G
 gD0PCYs0HKyZq2pCmK/9YXyVp7VQ1XX94EGRhNfQZo/t7dCI6cEWk/0TqQ==
X-Google-Smtp-Source: AGHT+IGZt03rty3z8I/fGtyJ6H2C5oPv1s/rS+qsrzq8D5Lzpo6fliZcrPhMH4adyveHBo3AkxGkgA==
X-Received: by 2002:a05:6a20:564b:b0:1af:e3f1:9af7 with SMTP id
 adf61e73a8af0-1b212d461a6mr911457637.36.1716505738741; 
 Thu, 23 May 2024 16:08:58 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/72] target/ppc: Move VMX storage access instructions to
 decodetree
Date: Fri, 24 May 2024 09:06:52 +1000
Message-ID: <20240523230747.45703-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification :

	{l,st}ve{b,h,w}x,
	{l,st}v{x,xl},
	lvs{l,r}		: X-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper.h                 |  12 +-
 target/ppc/insn32.decode            |  17 +++
 target/ppc/mem_helper.c             |  12 +-
 target/ppc/translate.c              |   2 -
 target/ppc/translate/vmx-impl.c.inc | 221 ++++++++++++----------------
 target/ppc/translate/vmx-ops.c.inc  |  19 ---
 6 files changed, 120 insertions(+), 163 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 4267917615..6d6f31366c 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -267,12 +267,12 @@ DEF_HELPER_5(VMSUMSHS, void, env, avr, avr, avr, avr)
 DEF_HELPER_FLAGS_5(VMLADDUHM, TCG_CALL_NO_RWG, void, avr, avr, avr, avr, i32)
 DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_1(mfvscr, TCG_CALL_NO_RWG, i32, env)
-DEF_HELPER_3(lvebx, void, env, avr, tl)
-DEF_HELPER_3(lvehx, void, env, avr, tl)
-DEF_HELPER_3(lvewx, void, env, avr, tl)
-DEF_HELPER_3(stvebx, void, env, avr, tl)
-DEF_HELPER_3(stvehx, void, env, avr, tl)
-DEF_HELPER_3(stvewx, void, env, avr, tl)
+DEF_HELPER_3(LVEBX, void, env, avr, tl)
+DEF_HELPER_3(LVEHX, void, env, avr, tl)
+DEF_HELPER_3(LVEWX, void, env, avr, tl)
+DEF_HELPER_3(STVEBX, void, env, avr, tl)
+DEF_HELPER_3(STVEHX, void, env, avr, tl)
+DEF_HELPER_3(STVEWX, void, env, avr, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(lxvl, void, env, tl, vsr, tl)
 DEF_HELPER_4(lxvll, void, env, tl, vsr, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index dc62bc90aa..11be21d230 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -661,6 +661,23 @@ DSCRIQ          111111 ..... ..... ...... 001100010 .   @Z22_tap_sh_rc
 
 VPMSUMD         000100 ..... ..... ..... 10011001000    @VX
 
+## Vector Load/Store Instructions
+
+LVEBX           011111 ..... ..... ..... 0000000111 -   @X
+LVEHX           011111 ..... ..... ..... 0000100111 -   @X
+LVEWX           011111 ..... ..... ..... 0001000111 -   @X
+LVX             011111 ..... ..... ..... 0001100111 -   @X
+LVXL            011111 ..... ..... ..... 0101100111 -   @X
+
+STVEBX          011111 ..... ..... ..... 0010000111 -   @X
+STVEHX          011111 ..... ..... ..... 0010100111 -   @X
+STVEWX          011111 ..... ..... ..... 0011000111 -   @X
+STVX            011111 ..... ..... ..... 0011100111 -   @X
+STVXL           011111 ..... ..... ..... 0111100111 -   @X
+
+LVSL            011111 ..... ..... ..... 0000000110 -   @X
+LVSR            011111 ..... ..... ..... 0000100110 -   @X
+
 ## Vector Integer Instructions
 
 VCMPEQUB        000100 ..... ..... ..... . 0000000110   @VC
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index ea7e8443a8..f88155ad45 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -404,9 +404,9 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         }                                                       \
     }
 #define I(x) (x)
-LVE(lvebx, cpu_ldub_data_ra, I, u8)
-LVE(lvehx, cpu_lduw_data_ra, bswap16, u16)
-LVE(lvewx, cpu_ldl_data_ra, bswap32, u32)
+LVE(LVEBX, cpu_ldub_data_ra, I, u8)
+LVE(LVEHX, cpu_lduw_data_ra, bswap16, u16)
+LVE(LVEWX, cpu_ldl_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
@@ -432,9 +432,9 @@ LVE(lvewx, cpu_ldl_data_ra, bswap32, u32)
         }                                                               \
     }
 #define I(x) (x)
-STVE(stvebx, cpu_stb_data_ra, I, u8)
-STVE(stvehx, cpu_stw_data_ra, bswap16, u16)
-STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
+STVE(STVEBX, cpu_stb_data_ra, I, u8)
+STVE(STVEHX, cpu_stw_data_ra, bswap16, u16)
+STVE(STVEWX, cpu_stl_data_ra, bswap32, u32)
 #undef I
 #undef LVE
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2cfa7d37ee..2c39605273 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -5790,8 +5790,6 @@ GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
                PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
              PPC_440_SPEC),
-GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
-GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
 GEN_HANDLER(mtvscr, 0x04, 0x2, 0x19, 0x03ff0000, PPC_ALTIVEC),
 
diff --git a/target/ppc/translate/vmx-impl.c.inc b/target/ppc/translate/vmx-impl.c.inc
index b56e615c24..4d5e743cfe 100644
--- a/target/ppc/translate/vmx-impl.c.inc
+++ b/target/ppc/translate/vmx-impl.c.inc
@@ -14,125 +14,88 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
     return r;
 }
 
-#define GEN_VR_LDX(name, opc2, opc3)                                          \
-static void glue(gen_, name)(DisasContext *ctx)                               \
-{                                                                             \
-    TCGv EA;                                                                  \
-    TCGv_i64 avr;                                                             \
-    if (unlikely(!ctx->altivec_enabled)) {                                    \
-        gen_exception(ctx, POWERPC_EXCP_VPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    gen_set_access_type(ctx, ACCESS_INT);                                     \
-    avr = tcg_temp_new_i64();                                                 \
-    EA = tcg_temp_new();                                                      \
-    gen_addr_reg_index(ctx, EA);                                              \
-    tcg_gen_andi_tl(EA, EA, ~0xf);                                            \
-    /*                                                                        \
-     * We only need to swap high and low halves. gen_qemu_ld64_i64            \
-     * does necessary 64-bit byteswap already.                                \
-     */                                                                       \
-    if (ctx->le_mode) {                                                       \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, false);                               \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, true);                                \
-    } else {                                                                  \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, true);                                \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, false);                               \
-    }                                                                         \
-}
-
-#define GEN_VR_STX(name, opc2, opc3)                                          \
-static void gen_st##name(DisasContext *ctx)                                   \
-{                                                                             \
-    TCGv EA;                                                                  \
-    TCGv_i64 avr;                                                             \
-    if (unlikely(!ctx->altivec_enabled)) {                                    \
-        gen_exception(ctx, POWERPC_EXCP_VPU);                                 \
-        return;                                                               \
-    }                                                                         \
-    gen_set_access_type(ctx, ACCESS_INT);                                     \
-    avr = tcg_temp_new_i64();                                                 \
-    EA = tcg_temp_new();                                                      \
-    gen_addr_reg_index(ctx, EA);                                              \
-    tcg_gen_andi_tl(EA, EA, ~0xf);                                            \
-    /*                                                                        \
-     * We only need to swap high and low halves. gen_qemu_st64_i64            \
-     * does necessary 64-bit byteswap already.                                \
-     */                                                                       \
-    if (ctx->le_mode) {                                                       \
-        get_avr64(avr, rD(ctx->opcode), false);                               \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        get_avr64(avr, rD(ctx->opcode), true);                                \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-    } else {                                                                  \
-        get_avr64(avr, rD(ctx->opcode), true);                                \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-        tcg_gen_addi_tl(EA, EA, 8);                                           \
-        get_avr64(avr, rD(ctx->opcode), false);                               \
-        gen_qemu_st64_i64(ctx, avr, EA);                                      \
-    }                                                                         \
-}
-
-#define GEN_VR_LVE(name, opc2, opc3, size)                              \
-static void gen_lve##name(DisasContext *ctx)                            \
-    {                                                                   \
-        TCGv EA;                                                        \
-        TCGv_ptr rs;                                                    \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        gen_set_access_type(ctx, ACCESS_INT);                           \
-        EA = tcg_temp_new();                                            \
-        gen_addr_reg_index(ctx, EA);                                    \
-        if (size > 1) {                                                 \
-            tcg_gen_andi_tl(EA, EA, ~(size - 1));                       \
-        }                                                               \
-        rs = gen_avr_ptr(rS(ctx->opcode));                              \
-        gen_helper_lve##name(tcg_env, rs, EA);                          \
-    }
-
-#define GEN_VR_STVE(name, opc2, opc3, size)                             \
-static void gen_stve##name(DisasContext *ctx)                           \
-    {                                                                   \
-        TCGv EA;                                                        \
-        TCGv_ptr rs;                                                    \
-        if (unlikely(!ctx->altivec_enabled)) {                          \
-            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
-            return;                                                     \
-        }                                                               \
-        gen_set_access_type(ctx, ACCESS_INT);                           \
-        EA = tcg_temp_new();                                            \
-        gen_addr_reg_index(ctx, EA);                                    \
-        if (size > 1) {                                                 \
-            tcg_gen_andi_tl(EA, EA, ~(size - 1));                       \
-        }                                                               \
-        rs = gen_avr_ptr(rS(ctx->opcode));                              \
-        gen_helper_stve##name(tcg_env, rs, EA);                         \
-    }
+static bool trans_LVX(DisasContext *ctx, arg_X *a)
+{
+    TCGv EA;
+    TCGv_i64 avr;
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+    gen_set_access_type(ctx, ACCESS_INT);
+    avr = tcg_temp_new_i64();
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    tcg_gen_andi_tl(EA, EA, ~0xf);
+    /*
+     * We only need to swap high and low halves. gen_qemu_ld64_i64
+     * does necessary 64-bit byteswap already.
+     */
+    gen_qemu_ld64_i64(ctx, avr, EA);
+    set_avr64(a->rt, avr, !ctx->le_mode);
+    tcg_gen_addi_tl(EA, EA, 8);
+    gen_qemu_ld64_i64(ctx, avr, EA);
+    set_avr64(a->rt, avr, ctx->le_mode);
+    return true;
+}
 
-GEN_VR_LDX(lvx, 0x07, 0x03);
 /* As we don't emulate the cache, lvxl is strictly equivalent to lvx */
-GEN_VR_LDX(lvxl, 0x07, 0x0B);
+QEMU_FLATTEN
+static bool trans_LVXL(DisasContext *ctx, arg_LVXL *a)
+{
+    return trans_LVX(ctx, a);
+}
 
-GEN_VR_LVE(bx, 0x07, 0x00, 1);
-GEN_VR_LVE(hx, 0x07, 0x01, 2);
-GEN_VR_LVE(wx, 0x07, 0x02, 4);
+static bool trans_STVX(DisasContext *ctx, arg_STVX *a)
+{
+    TCGv EA;
+    TCGv_i64 avr;
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+    gen_set_access_type(ctx, ACCESS_INT);
+    avr = tcg_temp_new_i64();
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    tcg_gen_andi_tl(EA, EA, ~0xf);
+    /*
+     * We only need to swap high and low halves. gen_qemu_st64_i64
+     * does necessary 64-bit byteswap already.
+     */
+    get_avr64(avr, a->rt, !ctx->le_mode);
+    gen_qemu_st64_i64(ctx, avr, EA);
+    tcg_gen_addi_tl(EA, EA, 8);
+    get_avr64(avr, a->rt, ctx->le_mode);
+    gen_qemu_st64_i64(ctx, avr, EA);
+    return true;
+}
 
-GEN_VR_STX(svx, 0x07, 0x07);
 /* As we don't emulate the cache, stvxl is strictly equivalent to stvx */
-GEN_VR_STX(svxl, 0x07, 0x0F);
+QEMU_FLATTEN
+static bool trans_STVXL(DisasContext *ctx, arg_STVXL *a)
+{
+    return trans_STVX(ctx, a);
+}
+
+static bool do_ldst_ve_X(DisasContext *ctx, arg_X *a, int size,
+                   void (*helper)(TCGv_env, TCGv_ptr, TCGv))
+{
+    TCGv EA;
+    TCGv_ptr vrt;
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+    gen_set_access_type(ctx, ACCESS_INT);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
+    if (size > 1) {
+        tcg_gen_andi_tl(EA, EA, ~(size - 1));
+    }
+    vrt = gen_avr_ptr(a->rt);
+    helper(tcg_env, vrt, EA);
+    return true;
+}
+
+TRANS(LVEBX, do_ldst_ve_X, 1, gen_helper_LVEBX);
+TRANS(LVEHX, do_ldst_ve_X, 2, gen_helper_LVEHX);
+TRANS(LVEWX, do_ldst_ve_X, 4, gen_helper_LVEWX);
 
-GEN_VR_STVE(bx, 0x07, 0x04, 1);
-GEN_VR_STVE(hx, 0x07, 0x05, 2);
-GEN_VR_STVE(wx, 0x07, 0x06, 4);
+TRANS(STVEBX, do_ldst_ve_X, 1, gen_helper_STVEBX);
+TRANS(STVEHX, do_ldst_ve_X, 2, gen_helper_STVEHX);
+TRANS(STVEWX, do_ldst_ve_X, 4, gen_helper_STVEWX);
 
 static void gen_mfvscr(DisasContext *ctx)
 {
@@ -460,15 +423,17 @@ static void trans_vmrgow(DisasContext *ctx)
  * Let X be the 32-byte value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1F.
  * Bytes sh:sh+15 of X are placed into vD.
  */
-static void trans_lvsl(DisasContext *ctx)
+static bool trans_LVSL(DisasContext *ctx, arg_LVSL *a)
 {
-    int VT = rD(ctx->opcode);
     TCGv_i64 result = tcg_temp_new_i64();
     TCGv_i64 sh = tcg_temp_new_i64();
     TCGv EA = tcg_temp_new();
 
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
+
     /* Get sh(from description) by anding EA with 0xf. */
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_extu_tl_i64(sh, EA);
     tcg_gen_andi_i64(sh, sh, 0xfULL);
 
@@ -478,13 +443,14 @@ static void trans_lvsl(DisasContext *ctx)
      */
     tcg_gen_muli_i64(sh, sh, 0x0101010101010101ULL);
     tcg_gen_addi_i64(result, sh, 0x0001020304050607ull);
-    set_avr64(VT, result, true);
+    set_avr64(a->rt, result, true);
     /*
      * Create bytes sh+8:sh+15 of X(from description) and place them in
      * lower doubleword of vD.
      */
     tcg_gen_addi_i64(result, sh, 0x08090a0b0c0d0e0fULL);
-    set_avr64(VT, result, false);
+    set_avr64(a->rt, result, false);
+    return true;
 }
 
 /*
@@ -494,16 +460,17 @@ static void trans_lvsl(DisasContext *ctx)
  * Let X be the 32-byte value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1F.
  * Bytes (16-sh):(31-sh) of X are placed into vD.
  */
-static void trans_lvsr(DisasContext *ctx)
+static bool trans_LVSR(DisasContext *ctx, arg_LVSR *a)
 {
-    int VT = rD(ctx->opcode);
     TCGv_i64 result = tcg_temp_new_i64();
     TCGv_i64 sh = tcg_temp_new_i64();
     TCGv EA = tcg_temp_new();
 
+    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
+    REQUIRE_VECTOR(ctx);
 
     /* Get sh(from description) by anding EA with 0xf. */
-    gen_addr_reg_index(ctx, EA);
+    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
     tcg_gen_extu_tl_i64(sh, EA);
     tcg_gen_andi_i64(sh, sh, 0xfULL);
 
@@ -513,13 +480,14 @@ static void trans_lvsr(DisasContext *ctx)
      */
     tcg_gen_muli_i64(sh, sh, 0x0101010101010101ULL);
     tcg_gen_subfi_i64(result, 0x1011121314151617ULL, sh);
-    set_avr64(VT, result, true);
+    set_avr64(a->rt, result, true);
     /*
      * Create bytes (24-sh):(32-sh) of X(from description) and place them in
      * lower doubleword of vD.
      */
     tcg_gen_subfi_i64(result, 0x18191a1b1c1d1e1fULL, sh);
-    set_avr64(VT, result, false);
+    set_avr64(a->rt, result, false);
+    return true;
 }
 
 /*
@@ -1158,8 +1126,6 @@ GEN_VXFORM_TRANS_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
 GEN_VXFORM_HETRO(vextubrx, 6, 28)
 GEN_VXFORM_HETRO(vextuhrx, 6, 29)
 GEN_VXFORM_HETRO(vextuwrx, 6, 30)
-GEN_VXFORM_TRANS(lvsl, 6, 31)
-GEN_VXFORM_TRANS(lvsr, 6, 32)
 GEN_VXFORM_TRANS_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207,
                 vextuwrx, PPC_NONE, PPC2_ISA300)
 
@@ -3365,11 +3331,6 @@ TRANS_FLAGS2(ISA310, VMODUQ, do_vx_helper, gen_helper_VMODUQ)
 #undef DIVS64
 #undef DIVU64
 
-#undef GEN_VR_LDX
-#undef GEN_VR_STX
-#undef GEN_VR_LVE
-#undef GEN_VR_STVE
-
 #undef GEN_VX_LOGICAL
 #undef GEN_VX_LOGICAL_207
 #undef GEN_VXFORM
diff --git a/target/ppc/translate/vmx-ops.c.inc b/target/ppc/translate/vmx-ops.c.inc
index 33fec8aca4..672fba3796 100644
--- a/target/ppc/translate/vmx-ops.c.inc
+++ b/target/ppc/translate/vmx-ops.c.inc
@@ -1,22 +1,3 @@
-#define GEN_VR_LDX(name, opc2, opc3)                                          \
-GEN_HANDLER(name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-#define GEN_VR_STX(name, opc2, opc3)                                          \
-GEN_HANDLER(st##name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-#define GEN_VR_LVE(name, opc2, opc3)                                    \
-    GEN_HANDLER(lve##name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-#define GEN_VR_STVE(name, opc2, opc3)                                   \
-    GEN_HANDLER(stve##name, 0x1F, opc2, opc3, 0x00000001, PPC_ALTIVEC)
-GEN_VR_LDX(lvx, 0x07, 0x03),
-GEN_VR_LDX(lvxl, 0x07, 0x0B),
-GEN_VR_LVE(bx, 0x07, 0x00),
-GEN_VR_LVE(hx, 0x07, 0x01),
-GEN_VR_LVE(wx, 0x07, 0x02),
-GEN_VR_STX(svx, 0x07, 0x07),
-GEN_VR_STX(svxl, 0x07, 0x0F),
-GEN_VR_STVE(bx, 0x07, 0x04),
-GEN_VR_STVE(hx, 0x07, 0x05),
-GEN_VR_STVE(wx, 0x07, 0x06),
-
 #define GEN_VX_LOGICAL(name, tcg_op, opc2, opc3)                        \
 GEN_HANDLER(name, 0x04, opc2, opc3, 0x00000000, PPC_ALTIVEC)
 
-- 
2.43.0


