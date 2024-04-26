Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA6EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RV2-0007UR-A2; Fri, 26 Apr 2024 15:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUo-0005qs-F9
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:34 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RUl-0003mO-5f
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:44:34 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-516d6c1e238so3260673e87.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160669; x=1714765469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0UDCxOSM6losMm33QUR2Xxw05S6cfuoGa+9agKli+0=;
 b=hssJiEDIznYtgjxnv2AnEtq42xHsqFoFgxpuwgpNzpR3pnfuMwY75//9Cdpkzqxjl1
 Pb7VRJJ2mLkAmavmRO/XesOFuqqPTlpycf6bmo3t4PEbpnaBRsFZACNjxZ5Za3iIaKFz
 Q5aBJGBu6lPd/mIp4zMsS3avvXyQaP4ltArfrGKTcVVVKnCnqOCtE1QLKPvUmlKR4v7F
 KXo68VU295XeBC27YPuG+a2Cs8tcU+ot+5+zFXqXbYyu6vtoVj9KEskeLs567sDESqzl
 Xp7BU+iax2D+7kOVUK6ZzfLilETNsUlvBPN0t3ntKRglauPEBxtNurP3YoH/HiGH5W6E
 BSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160669; x=1714765469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0UDCxOSM6losMm33QUR2Xxw05S6cfuoGa+9agKli+0=;
 b=T+Gbdypl5aCDRz/ts4cfhymdlbDkEaqlQZJOu5YGzrJtSFpx4pwgOEJzU5BryE6Ntn
 HC9ZlGfleLV1173wzAcbWFOSu2B35oAAiM3oxPjN7l8IYjXyW72usvXp7bPRVaYbjUD6
 xa77QEJM3o2OD3qR8M4ohN0qhae+KphmrfNOEQJSGcL08IompCNH4kf8fPrxElsuAMot
 nkk30YmePd39OHLxpZdRu0uVyRZE6A+ximIkHTHLr0rdoQ1q5+Szcp8b7CMy87VKrI9j
 fMgF7q7/A9rPpixqUGhJ1HFbbSHk/s96iL7T8FTSDMm+LKekNZN7S4fmwCDz34NtGumG
 8sVg==
X-Gm-Message-State: AOJu0YyA+2/7fR7nJb+N46flENfX7aqpgyb1lHC0KJdNlgwkAIB0hp5r
 c1VQnL9ARwwKjsVoVSVAzyLs3oFjVV9nQ0NTHEa+KrPxJJX3ubAcDhew7n3b3jorTxYTMeKxT9c
 iZ2M=
X-Google-Smtp-Source: AGHT+IFpraAeEBrfBwzgkYIqxwrSxx6UxxiFJc4VVXV9x/2kjpwaRriQS99+C/00qFZ/Kw18c+RlHQ==
X-Received: by 2002:a2e:950e:0:b0:2db:2397:1055 with SMTP id
 f14-20020a2e950e000000b002db23971055mr2054988ljh.9.1714160668962; 
 Fri, 26 Apr 2024 12:44:28 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 da25-20020a056402177900b005700024ca57sm10440528edb.4.2024.04.26.12.44.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:44:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 25/38] exec/cpu-all: Remove unused tswapls() definitions
Date: Fri, 26 Apr 2024 21:41:45 +0200
Message-ID: <20240426194200.43723-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Last use of tswapls() was removed 2 years ago in commit
aee14c77f4 ("linux-user: Rewrite do_getdents, do_getdents64").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-15-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 4de0d5a0d7..7c44ffb3af 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -38,11 +38,9 @@
 
 #if TARGET_LONG_SIZE == 4
 #define tswapl(s) tswap32(s)
-#define tswapls(s) tswap32s((uint32_t *)(s))
 #define bswaptls(s) bswap32s(s)
 #else
 #define tswapl(s) tswap64(s)
-#define tswapls(s) tswap64s((uint64_t *)(s))
 #define bswaptls(s) bswap64s(s)
 #endif
 
-- 
2.41.0


