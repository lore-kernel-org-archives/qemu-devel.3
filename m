Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB9DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFum-0006vU-0v; Thu, 22 Feb 2024 15:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFul-0006td-8R
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:31 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuj-0002Zb-0j
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:30 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d731314e67so460395ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634607; x=1709239407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bGhiDlU0H1FunNKKdUnN7eps2A5T8/N/TZO0RrbQvI=;
 b=KXUG7fKqV+wD9Bd0gYjuGGkHLnN1Vb8hqhqy8PAQmrb0+SFXsWXecWt7RlHeSipmzq
 x+s+3etnKwc0po28IcZRiDZTsfTDvP4t1LRQfdRHUCzM7h1ePCSF/nXpuJGhW+BLoPfj
 fFe/9Zp6BrpTXRSdCdDecaJFZ0Y8CsPFioYXyRDmL/Y/km39C/isDpuPVa+bGxZcF/MY
 ZVjKojlOD5AXjbD5muSnvxjhdncUlyZl3++E3sQe9FHal39NxY4mZmqeVMIl5Vzk0VCg
 +oEOgxHIOPhZMfUnvfEJxkaV8uTG5LxKchxgCVJdnZdYaQ6WSIO5TLK36fEE/oFB3HvP
 DQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634607; x=1709239407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bGhiDlU0H1FunNKKdUnN7eps2A5T8/N/TZO0RrbQvI=;
 b=JJ2MBV1nRrk79Te2YwIXvEiq8+wZdrdzmgkcOtQvuTUJkFZXNe+3ximSiopSVKED07
 4/zJV0B68gTqboi8MWSPNvKVJwu4zr3xwZKx27iG3NOuatSdaFFCUbpApGEOC6RDVNQp
 WQCqexEwGU8jguX1tf86inEbArBTeeLZWxVwmAM8G8qdXdK1q5pZXYzSeHSAG9WYNjRK
 sy/nmTROzHcSBL0kV2IqCETshFWr23tBKX5fxwbJDH4RD18J4/xQOo/3Zb8IIgI5FFsc
 rPGNbcO1mXlciCRyvzTr13PW5A3ORYX15eyHPKZmfOZvf6yxBZxG1vCDQJVLvlQlG/aW
 Akpw==
X-Gm-Message-State: AOJu0Yx76OogZTL1qkYO5szJbla2DdFQJPv/JczO05TLs/U9WOFoV/eG
 cuFNZscODTxjTP0NN5+4mYDPrL0ys04guJwgx1Tt1hfCn0lsRnuOArCV6xXYl8tYEKcc6sW9w+5
 B
X-Google-Smtp-Source: AGHT+IGV+DNcAIjYL2CRgDuAA3BrvJQe/tICE//QVX2rWx+a5IY5VlKzgBOyq+5AYqKF3vlIskqamA==
X-Received: by 2002:a17:902:da8f:b0:1db:e7a4:9d4d with SMTP id
 j15-20020a170902da8f00b001dbe7a49d4dmr17151169plx.46.1708634607498; 
 Thu, 22 Feb 2024 12:43:27 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/39] tcg/aarch64: Apple does not align __int128_t in even
 registers
Date: Thu, 22 Feb 2024 10:42:45 -1000
Message-Id: <20240222204323.268539-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From https://developer.apple.com/documentation/xcode/writing-arm64-code-for-apple-platforms

  When passing an argument with 16-byte alignment in integer registers,
  Apple platforms allow the argument to start in an odd-numbered xN
  register. The standard ABI requires it to begin in an even-numbered
  xN register.

Cc: qemu-stable@nongnu.org
Fixes: 5427a9a7604 ("tcg: Add TCG_TARGET_CALL_{RET,ARG}_I128")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2169
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <9fc0c2c7-dd57-459e-aecb-528edb74b4a7@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/aarch64/tcg-target.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ef5ebe91bd..85d5746e47 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -55,7 +55,11 @@ typedef enum {
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
+#ifdef CONFIG_DARWIN
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
+#else
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
+#endif
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
 #define have_lse    (cpuinfo & CPUINFO_LSE)
-- 
2.34.1


