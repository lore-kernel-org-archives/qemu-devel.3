Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0ACC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HU7-00022P-LM; Sat, 04 May 2024 11:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU6-00021U-05
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:34 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU4-0006EI-IO
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:33 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-61eba9f9c5dso453659a12.0
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837171; x=1715441971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfHxYfQijfNm9q0rpqswl8HrggnkGTpjh4fn75ISOwE=;
 b=zEdJ5CqNivpkqZWidMWcOhn8pqX2VYxrrCWeo1uuniGyPZrp1OicMfFMvw895wITvM
 kEtN3JPaL2ULV6EBxjNMetZXcayRsz1wrwF9prOLYYmkRMUpZTBbFUH4q5/kPpdebBLi
 2Xn66THU1El2xAym/GO+LTMjUM2YMs+NIpMuNunE44fsFKnz1HBYAqVHEejY8xdVQf+x
 Xt/pXeT7iV8RzhAg2ggnJyexkLWKkbLm4vBRKj1YCSXpZhQe61z36e0Whts+cDcZesER
 X3VU05X3JRzTaHEfOcpcDfrRIbsyY9Rnqix0G8PUP6Hgrbp/xrnM0H9ZxD+Q/Q3PWBYz
 jo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837171; x=1715441971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfHxYfQijfNm9q0rpqswl8HrggnkGTpjh4fn75ISOwE=;
 b=tjLCbRUidFxjApdv6c9Z+w0tv8NiLI8yXjTXDyUX/12Ysd8lM6Gk4Eq0YGDhugeq/w
 Wx1LCotoxDiQ44V6QI7VpqAgXflnnysEq6MkHAQuP+I+A5lCY2zcCcgat0OksgT/csM5
 JnLrf7HeuUU69JyQW292jkLHzl6TIeL2Kwq/hWM+IhMpDtdkCWfjAD53gdYSaam7yw9G
 e3+L9MymJfzRdm+LZ+9mOxawzNjbUzjm3/Df3VbFirKzUybbZa/G/wHzNJfHeK2n3Nr9
 TFY6hKh0yyl5kjb5GnJRQPN9XZbEdLMDdb4TpyBy0gRhW5/R+w5jUr1wDXnz82w42VAv
 4z3Q==
X-Gm-Message-State: AOJu0Yx8hMuq/ORVWmKEKWPEve7oN64GdE5IhHVdOuNGQkb3cls+Fnxl
 Rnx2vH+8mHpwsQ7lmF4g0A9fOVgYkkhKSgll1Efw0TOkaFvrME/l1rAm8PCpLeI/9MCwLHK9vNl
 i
X-Google-Smtp-Source: AGHT+IFH8oA2Gk266QDn6+yaWXIiCenPKzKHAqasXAHBPApOVt/nSnEGZcrbWLKjfopeXL3jzYC4uQ==
X-Received: by 2002:a17:902:f609:b0:1df:f681:3cd8 with SMTP id
 n9-20020a170902f60900b001dff6813cd8mr7201555plg.12.1714837171063; 
 Sat, 04 May 2024 08:39:31 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/9] target/alpha: Use DISAS_NEXT definition instead of magic
 '0' value
Date: Sat,  4 May 2024 08:39:20 -0700
Message-Id: <20240504153926.357845-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 1/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-4-philmd@linaro.org>
---
 target/alpha/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 52c2e6248b..9ad7bf6e5f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -440,8 +440,10 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 
     /* Notice branch-to-next; used to initialize RA with the PC.  */
     if (disp == 0) {
-        return 0;
-    } else if (use_goto_tb(ctx, dest)) {
+        return DISAS_NEXT;
+    }
+
+    if (use_goto_tb(ctx, dest)) {
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 0);
-- 
2.34.1


