Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB5FCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4Fz-0006ea-Mw; Wed, 13 May 2026 03:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Ft-0006dx-W8
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:43:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Fo-0001kN-6j
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:43:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso73493805e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778658219; x=1779263019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDdHa5b5mcW66ntEQmVA1D7Qc9ytIwUkBYq5sb+wbDc=;
 b=eEBnWMYEElPamoqZlw3yQEpfN0HmxANAnfH926zdRuPFl66o8e0un+fj3SjG6RHd+Q
 fPOf6KsL2PWNhE2qV5DpRn2zVktYBplz7ggsohDCubqxUteVATn02jgDg8KF4Yg3j8uJ
 TQwmOllVo+QxqeD0FfDcZ6Q3HFjnTiFbvFMi0MOwa2RzmHX7AKjSaODRYAPHUSUVnnCl
 JOktLflgtZKKRlZGUHCaw0ZmiJafNNjdHBVeRTO75K0lab6Fbmj2G2S36Gj/lPiIaShT
 u0QBgHv/RrRqqNNzf5NdONQuUVlhhLjk0fWWEMW2hX1J82v/xn1RRd5EhlFcJ3D8QCus
 84Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778658219; x=1779263019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XDdHa5b5mcW66ntEQmVA1D7Qc9ytIwUkBYq5sb+wbDc=;
 b=i+Njmxj+4T/PqKum0r2EY7OJEk2prCDLf4wnabDeL2HNeX7Elzt15sDC+tYu+mCQkT
 gXc9Q95O3tM+HQFAEbU0qTAO3d5PjHihngnwDzUGZn1Z/g5lelII3po1QhwAHiVDBvrM
 YeUZN1NCJ+xPCJLFhg6UrqKikLY2KRAQXg8p5fOJ8gY9SvxbBqS/Xd4HEWHD+Krji+uR
 Y3ux1JLRO3PjU/bTB2vfWy9p/QWAwn9W68khbhw0+IbMRQfkuyMzOSmA8XR3JE6E7B7q
 y/cSBxp+8vZBknWW34GNPIAqyxfcR2SdCkGWg+3dwp2GKuW5RVAEMn/obl0TW7W3J5DI
 nd3w==
X-Gm-Message-State: AOJu0YwTNjysfvhgnNQgyKd4FuakgsieJF8Be5ERlYhTxJt+bRvdvUaF
 24Nc8HnQFfMAwZqJo43fFDMPjReQUlM8gqDYqqs/hQiZ2wTU0CIQLBDYM/5bVXi396m8a5c9O7T
 KtNFxQVU=
X-Gm-Gg: Acq92OFmhnuX4ybJ4M8sgdElsdV3Q0fgaDIeVtMQhvgQHG28FoT9W8+zrEOZ8jWrOPj
 QBZcRCkAPzVMLx7+lr8wOoZliSi+0tz2UseDTcn7AJaN9zl2itB36EWU3+kvg+rJa4hm5c2tfBD
 QbDB4bIO/9VWowDcKZ3zrltkhRedknf++WmErRuH86qokyG2/nYUzt1Uvaj9ydUmd3QuhGLRPa4
 IpDrooO34/ZM0VZ6flzU1qbp0MNXV5aggYxwFYIXy0arUnOPVDSbLsruGO506jG+UzasFLJkuaX
 u+TLrjluOHdKrRRprbeU57KUJtEhvHecirwat8uMqSV/9barVEQqwQCWhXm6HXVnEfwnGQDkAsX
 afQo0NnENJAGe1+l4lIziTCjwi7dLb4QI3wKu1eh181+8pB5YKuVmCSk++SePn4qqM+aV1QRNTL
 wT0NaPpAa+sXVlAA/cGrzpBvv3LbLZw4JWIbZkCWFPgggfofXoLYXiMsXSob4UqAWakLWJNI4J
X-Received: by 2002:a05:600c:1792:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-48fcff534edmr8926165e9.25.1778658218574; 
 Wed, 13 May 2026 00:43:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fce05e45esm29479265e9.4.2026.05.13.00.43.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 May 2026 00:43:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/hppa: Inline UNALIGN() macro
Date: Wed, 13 May 2026 09:43:23 +0200
Message-ID: <20260513074323.10616-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513074323.10616-1-philmd@linaro.org>
References: <20260513074323.10616-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
---
 target/hppa/translate.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c3d1027b4e2..4e348225654 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -95,10 +95,8 @@ typedef struct DisasContext {
 } DisasContext;
 
 #ifdef CONFIG_USER_ONLY
-#define UNALIGN(C)       (C)->mo_align
 #define MMU_DISABLED(C)  false
 #else
-#define UNALIGN(C)       (C)->mo_align
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


