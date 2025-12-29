Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD12E92FF7
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaM9p-0001tJ-7m; Mon, 29 Dec 2025 17:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9a-0001rI-EP
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:56 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM9Y-0001Dp-3X
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so4499937f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048950; x=1767653750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wCOqNVpDIwgmrLQExYLyHGxt46hOYDrBPkO4R5DEaM=;
 b=pd7xStaAK7znUKXwhj6V0G9PXLT6rXMsXdDzXYojCFazgqSntuc6xQ7aAE59Bk78j2
 teGVKeL6LMZK4I2XVG3ykHbSq0les9gLj7Eb/tH7iOlLKQXKBrVWiRkCjmqcp2FuPHFv
 aMGXK8h8sxfCwhBL5W0591lord2mxD7sam0oYQnMySAThszZIAzH2tAuB7hrTMKXeFEQ
 HG/BoZxLf9xAY2RySMam9HdinDb8xVYldZokn4cmENcbHmmnU/F0bJFtR+k5oDkJRbeb
 KZpBZqKz5NkjFEMjK1mAyEioOZhQMmcm2lb6ykPSZ+0IsrU/Oyrv+ihVjz7QzgzBUBgS
 H9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048950; x=1767653750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6wCOqNVpDIwgmrLQExYLyHGxt46hOYDrBPkO4R5DEaM=;
 b=SubiOmE979pjijKjMnwWVjn6Q39MuNuPWtIN//RypwscEOG9v7JBYsVVddM7BVjOlf
 IfWVPTSFjlMIOvOR1E7ZRk8ppSONBTmCR4eBXQ8+kEXp5X+7Tz7LAPxN1VQj3a01RKp3
 Ik2DEc2OPYQrsOf23NdQE+N5A+9JFysYKbE0yQnnQUPW0lTBy2KZ0xaMA4obQ64ybnyV
 yHiUylDOz4l4gjRMc0ndKh7a5pBBIJ3DxrKQx37/i/tCmqtZHBBP9BLTJLcmJyLUVilL
 SzlyQ3zqVsNq+kpxepNbklEzfjqwpcjZBL2BDKat1KaRXEPgtg0w1RjV65iM7lzuKW1J
 cyYQ==
X-Gm-Message-State: AOJu0Yx303Hr9xE3CaTEqNsnY5ubmyAL0U45VWmgWWoWeSpAHa8I3WYJ
 BaZ7Pv5r7uYtqFgpBMFrHrUR6MllpRSvExtPw74ID77Of8PeRIe5Wevjk+olZsgUJV/TZa6Vrzp
 uz1UYvbA=
X-Gm-Gg: AY/fxX5t4+/Oty8Er+8XVChlxvB/0wHy9o+c1S/mBXhzVwZhrgffd5xFqrTQgyRmErM
 p8lL4H3cckAn+wnHcVevF8G+6LkfhICjITOVvj0zkyXFIxr9Z9MWjHrEIF918p5m8svan8/fjnH
 qhHb/+ZzV0DRc3L8Cs4IsG1RMELhG31p+ARp5EoLUfWDqu8S4bDwafrpaj4RbZu9NDju/SZLMev
 eloNXEWcwf+s5TYfWolTB72gNMnPFWGKaJmK4CebWSmoKsZybOmUvn0IIwYqjYADYJB+Ys0Bl2w
 Nopqoj5tlJEsVhtQUzFggrZsdr2MYUmj7QB5GugH7h9h9A58Z9o/vKfVqIWFTpzk/9LZlYq2Oaz
 lZkRqJ2kkZtfMsWJeuERELES17cdyraPl7civh6KrkW0oH8ba6QiQoPJxTW16j/P+AyRan3GGmz
 VgdSIuZ4KQbt7OAP5B5uQlqWIROvoyV/J2+hcGHOhH9dIXHtxlvh7xKR3P1R0N
X-Google-Smtp-Source: AGHT+IHDy6NvahyIadSX0qjpJSjBJv8RSHm3L3GkFEgE7j+tl4ECh2MnfIT6yeFkpKBCquW6ecIIyg==
X-Received: by 2002:a05:6000:4305:b0:430:fbe1:383c with SMTP id
 ffacd0b85a97d-4324e6f9f64mr41524553f8f.58.1767048950261; 
 Mon, 29 Dec 2025 14:55:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm64943011f8f.35.2025.12.29.14.55.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 14:55:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] target/hppa: Inline translator_ldl()
Date: Mon, 29 Dec 2025 23:55:16 +0100
Message-ID: <20251229225517.45078-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229225517.45078-1-philmd@linaro.org>
References: <20251229225517.45078-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since PA-RISC use big-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/hppa/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 853cba2ba4f..73c2cbdf5fc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4737,7 +4737,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
-        uint32_t insn = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        uint32_t insn = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
+                                           MO_BE);
 
         /*
          * Set up the IA queue for the next insn.
-- 
2.52.0


