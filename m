Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F8BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYP-0003lw-B0; Wed, 27 May 2026 06:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYL-0003ck-Qf
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYK-0000qi-0n
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so122368715e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877914; x=1780482714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YIKJoy/xA0XKj07xKvGej7htS8zXYPvR5YPrJoMb0t8=;
 b=Kiy9HW19FUteegX2xIj1Hq58FQDy++oxqkfE8N/9TGhs1EUcuzaJqkHm1A2M4yvRDi
 xGu0axtSjn7KOHtYqxJrDQOo0YmWyMpDbhYBl/FP/b2HnciOh7tYDruurJB92rfppaC6
 WWQD4KXvNqfLDGeTp6zpqqjjtIXz0zmyUCT5ZoiQVmaakmbUipc7URbil2ShF9ZtHsf1
 DFK3TT1skUrVLx+2izqj8mAMvk6UHUqre+q9vitgt+wCWr+yqiZGCa72tuYbH7spkPto
 lVAKNXD6udsfgaPfbgp0yBzXtxuzqs69nLDT1p3PGmN+roPHddiPlXxtS4jk/3wfj9WI
 luFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877914; x=1780482714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YIKJoy/xA0XKj07xKvGej7htS8zXYPvR5YPrJoMb0t8=;
 b=ORJDf+Nev2BNpFzMIzb5m2sv1FqVitFYmndaC65dj1LaaM1vHQGJlQcKKJ8x7XjFzr
 qUCeCKlSGRyTlqbHGFiA8ZIEFkQ6HYZbSpimFThp7KxPhtBlwKtynEYsweEZq9syp/CH
 sCYXXjMuXZqP1HkTG6kGwKWSSTAXtqyAhLVlFSJh7604uMGoh041w0foL2GNLfLyKYUj
 fsnFLkAtOxuukdm3u/HwSHqVX2VznkUfJMConGj/z7JzJAKu6HivHZDLF7tAQlqsKcOP
 +XO6iWlhorgevhN3m8L4OJuKEl3feJJqudPBQmUL6CILkk2h2XvJ94OGPWTp3zkHQYfB
 LDmQ==
X-Gm-Message-State: AOJu0YzYGJQfDOgCuqxYnjZch8CtWcucP2XRZoecatnZUGFlx6xfvlGP
 HTwWZ6cJxn5iF7KNV5gxVBxIzEjG7BPIN9A04EU0GiuiqdNNIv5lKdISyHbGtlD5CIKW+zbGj2w
 fAK1scvlZUw==
X-Gm-Gg: Acq92OEdHt6FflQyfCCZQApydFRg8g3ahG8/ObyKnO7DqEYNXKQ6ovIkAgrEtz61UHI
 sioL94+b0kkYbOP5kTf8YWiTjcnU2oBd1Iqsx3N3EOFIHZ+Xgt9n1z6sYPFu8BSSEGDHplEIcE1
 yIaQga+Uf+NRpnksH2fx33a23QouaNOQApVwBZsb3bhf+P2Cu0r3NKyM78sx/M7vU1G6waf2udi
 DzvRjtmpB81C9w/WULLHJtsqLouRvdC2VKRUwvONwCjql4kLeDfs0srV04t2iWQIJjmMS+UJdJv
 IF4LP82tbusTut2r7lW3XO3sJ7UQqdkmPfru6hTeBYkHNoYmC5R/m3nco5ECVsEwHC/isIev2en
 KRIara7R0dbrNYnuREQ4Esf110s/qNKoixAp89hyNAl9US9AYddgSKQYgnZbbHyD9METQBgEr7u
 g5TLXCXn3o61X/w2rXlwbQnAL0Ch17NVGNQ0v3GY40scPTGXeqcIJPvUjnfVB6+tOLQg==
X-Received: by 2002:a05:600c:83c6:b0:490:5872:e641 with SMTP id
 5b1f17b1804b1-4905872e758mr280289885e9.18.1779877914332; 
 Wed, 27 May 2026 03:31:54 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c60b5sm425259475e9.1.2026.05.27.03.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/32] target/hppa: Inline UNALIGN() macro
Date: Wed, 27 May 2026 12:30:15 +0200
Message-ID: <20260527103037.4461-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Directly access DisasContext::mo_align in place.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Message-Id: <20260513074323.10616-3-philmd@linaro.org>
---
 target/hppa/translate.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a05e7e70d19..4e348225654 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -95,10 +95,8 @@ typedef struct DisasContext {
 } DisasContext;
 
 #ifdef CONFIG_USER_ONLY
-#define UNALIGN(C)       ((C)->mo_align)
 #define MMU_DISABLED(C)  false
 #else
-#define UNALIGN(C)       ((C)->mo_align)
 #define MMU_DISABLED(C)  MMU_IDX_MMU_DISABLED((C)->mmu_idx)
 #endif
 
@@ -1603,10 +1601,11 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= ctx->mo_align;
     mop |= mo_endian(ctx);
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
-    tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop);
     if (modify) {
         save_gpr(ctx, rb, ofs);
     }
@@ -1622,10 +1621,11 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= ctx->mo_align;
     mop |= mo_endian(ctx);
-    form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
+     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
-    tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop);
     if (modify) {
         save_gpr(ctx, rb, ofs);
     }
@@ -1641,10 +1641,11 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= ctx->mo_align;
     mop |= mo_endian(ctx);
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
-    tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
+    tcg_gen_qemu_st_i32(src, addr, ctx->mmu_idx, mop);
     if (modify) {
         save_gpr(ctx, rb, ofs);
     }
@@ -1660,10 +1661,11 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= ctx->mo_align;
     mop |= mo_endian(ctx);
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
-    tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
+    tcg_gen_qemu_st_i64(src, addr, ctx->mmu_idx, mop);
     if (modify) {
         save_gpr(ctx, rb, ofs);
     }
-- 
2.53.0


