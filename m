Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C3DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZE-00013K-5N; Thu, 23 May 2024 19:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYt-0000Fr-VQ; Thu, 23 May 2024 19:09:34 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYp-0005nw-1K; Thu, 23 May 2024 19:09:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f3310a21d8so16155345ad.1; 
 Thu, 23 May 2024 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505760; x=1717110560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkWMu8dLgBQslrOlCwfLt/yP6TjinsGZIeno/YYDSKI=;
 b=l5YS4DYAEPitLbttlRjl3CO/y8KKDj/+DvtZWI6Yp1VXBxFqEuBQrXzD/ddtnL1W1u
 FgEH4sBwv65xFQ+btkoN8okO7G+jDdCm4f/bNmzH7+peBrjWqTIgP9NFiVGSXu1YFQ2H
 HXKBhQxIBFez0tF3xLO5/WjPgfdpnjQPI2rBR1oEZNjsRY6lPQ5rcRlaiLtQ9jomvQZR
 ScijWw9rA6LKmFg3XgZjYzRRq6e29L7O+OOgPou9YbmyFsNv/m5qaFGDu/XypxChr4DQ
 drHtaqsYz3V/jw0m1sk5mLJTIub8VHL5ltIR0xjY3XfmaK6sjMhlFzf3lLQRPJknrpA4
 VDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505760; x=1717110560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkWMu8dLgBQslrOlCwfLt/yP6TjinsGZIeno/YYDSKI=;
 b=gqlwWNWFSjlL8UpWEOHcfnFxD5EsgK3O4+n0DHSj9Ks2kxtXN2Vnx5Fq3dl2eLD42B
 qbXBscR5dfJ9Wnf+I1UnPsOpmOhnW8tIIp+B4oM5nqySGL93XBpczcx1GC1lUr585rQ7
 nM6WD170ocFYXy4YkoTNwqpOJFHexUZIy7rEntDsX/lwjMGn8hiwp8gmlf+jzJ7VDx6M
 Ps/wk8jnTrIbJCluuxbGBVb9OTeQDKp8Q13HcUQaRTevz7nsQrC+hKL3wYq8g3EQ+iMx
 82FIeJy0RMS4tOcgOl4s6gNdRqudIau/VCdlm23N8cx4NBOeAkOFdCP39IbincT1sl2X
 J6Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFmU7HA7c47zpsSbdzj1VKY9XvNHDdRi28ai+N5ru+b9RQ+bDy6+SrSvliqRLMtGYAhS6F2hf9UTPGIOKyYkh7L5x9
X-Gm-Message-State: AOJu0YygWNJbSrYXHR1qdGi91J9b02kCLjr47ffIlGxa7MIeJFi3+Ex9
 9eN+VmZs/dL/GdYCYFc4h71iv4VnLHwDHiG0VtclFqAzgICNsrsW2mVNMA==
X-Google-Smtp-Source: AGHT+IG2QbaOqlS+k/fwNNkCCOZKwjiCJdr2g6sBQZ7UmApZtLve+ucOlnHBVnE1TvSRAFPiSBhTBg==
X-Received: by 2002:a17:902:d486:b0:1f3:1cb9:47a0 with SMTP id
 d9443c01a7336-1f44870a07cmr9631925ad.27.1716505759890; 
 Thu, 23 May 2024 16:09:19 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/72] target/ppc: larx/stcx generation need only apply
 DEF_MEMOP() once
Date: Fri, 24 May 2024 09:06:59 +1000
Message-ID: <20240523230747.45703-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Use DEF_MEMOP() consistently in larx and stcx. generation, and apply it
once when it's used rather than where the macros are expanded, to reduce
typing.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 546f1754de..6c103dafe0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2849,7 +2849,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
 
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
-    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
+    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve, t0);
     tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
@@ -2862,9 +2862,9 @@ static void gen_##name(DisasContext *ctx)  \
 }
 
 /* lwarx */
-LARX(lbarx, DEF_MEMOP(MO_UB))
-LARX(lharx, DEF_MEMOP(MO_UW))
-LARX(lwarx, DEF_MEMOP(MO_UL))
+LARX(lbarx, MO_UB)
+LARX(lharx, MO_UW)
+LARX(lwarx, MO_UL)
 
 static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
                                       TCGv EA, TCGCond cond, int addend)
@@ -3109,15 +3109,15 @@ static void gen_##name(DisasContext *ctx)  \
     gen_conditional_store(ctx, memop);     \
 }
 
-STCX(stbcx_, DEF_MEMOP(MO_UB))
-STCX(sthcx_, DEF_MEMOP(MO_UW))
-STCX(stwcx_, DEF_MEMOP(MO_UL))
+STCX(stbcx_, MO_UB)
+STCX(sthcx_, MO_UW)
+STCX(stwcx_, MO_UL)
 
 #if defined(TARGET_PPC64)
 /* ldarx */
-LARX(ldarx, DEF_MEMOP(MO_UQ))
+LARX(ldarx, MO_UQ)
 /* stdcx. */
-STCX(stdcx_, DEF_MEMOP(MO_UQ))
+STCX(stdcx_, MO_UQ)
 
 /* lqarx */
 static void gen_lqarx(DisasContext *ctx)
-- 
2.43.0


