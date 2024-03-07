Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F9BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAso-0005PZ-DP; Thu, 07 Mar 2024 05:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsi-0005Ow-Na
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:44 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsf-0007CU-Cg
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:44 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e4a0e80d14so554215a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806899; x=1710411699;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3/84n3G740Rm4hmj3TunpldInJlo341Vetn+9WdD47E=;
 b=eXBavnflLvZ3nKviTKvbDLXC35tYgkUqajS8Ahtw26qTj/AJ21da0I1FQ6ShSXdo6s
 Hm+M8WsQnQSdCs+r1YtqtgQpH9og8JZVqnaPki0E+euu7Y3OKkKy6IXNLB0N1Lv7VgHn
 uHb2LH5heyUW0ps6aEiNpFSEUy60+VUgxtozsOe+6acp4ayymJMWZfeHnyc3p2JDViaT
 rNh7GExz+AQzasW57qvtRYEjrLqCtznWCp6zjrZf3OcqBbqKECTu0UVX+n9F2PEfgN6g
 dqGr8mA5Q8AFbEBPNfOhYulR6+1xENIz3irEdC4j2wY0t4PsVQ6vcaRtHpzW6y0ND7Ml
 hdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806899; x=1710411699;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/84n3G740Rm4hmj3TunpldInJlo341Vetn+9WdD47E=;
 b=vxfSHuFbGnRKCdPJ3yklTKUlp/16+qrtdittpjl7u79UNOEuoMW9MwNJcOJIYcTj8b
 G2YpqDemNxLyn3fBugjnVtUpcxkcNld9Avpg6VbRUcQPOFRliYyolIW7+kssMLfUbUz1
 p55Sr9lw3mmSgasCeugNByn63s1unzGyNQl0KREzavfV5F/D/KS2NslQH0MiJJCsUW4r
 bxE0wJVDhr2ZeV2Da8kXxpl83X4hcU3Y7sdY6I8jmCQwZ3KJRemoIk0AzYblbLewUFoj
 2P3HCK+LTGVdkpOGlmL/kgLb6cwMK6iruWLCCZfVMhaLeL466aTzaJbIpHZiF4V9t6uh
 KrsA==
X-Gm-Message-State: AOJu0Yzn5Xsa7d2J8k3ORcFlUxYrirsW+x5Q+asXyVWvCnIMZJoxG2Qz
 pG2QaWGrGAVmSzZ6S1cklrfxjU36CHB5lX3EA5wIJKxXc6xhMyoBQYIyIY4wUuo=
X-Google-Smtp-Source: AGHT+IFh3G/9ZepsXtxbhdUpXFx3vDivziBUBOZ/ZDpSEbsqw9dGzIm9WId/UrIg3ew0NhlmcfOz3w==
X-Received: by 2002:a9d:75cc:0:b0:6e4:e7c5:d4c7 with SMTP id
 c12-20020a9d75cc000000b006e4e7c5d4c7mr8127384otl.19.1709806899615; 
 Thu, 07 Mar 2024 02:21:39 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 b16-20020a630c10000000b005dbed0ffb10sm12353454pgl.83.2024.03.07.02.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:57 +0900
Subject: [PATCH v4 14/19] contrib/elf2dmp: Use rol64() to decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-14-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

rol64() is roubust against too large shift values and fixes UBSan
warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 32dc8bac6a30..d046a72ae67f 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 
 #include "err.h"
 #include "addrspace.h"
@@ -47,11 +48,6 @@ static const uint64_t SharedUserData = 0xfffff78000000000;
     s ? printf(#s" = 0x%016"PRIx64"\n", s) :\
     eprintf("Failed to resolve "#s"\n"), s)
 
-static uint64_t rol(uint64_t x, uint64_t y)
-{
-    return (x << y) | (x >> (64 - y));
-}
-
 /*
  * Decoding algorithm can be found in Volatility project
  */
@@ -64,7 +60,7 @@ static void kdbg_decode(uint64_t *dst, uint64_t *src, size_t size,
         uint64_t block;
 
         block = src[i];
-        block = rol(block ^ kwn, (uint8_t)kwn);
+        block = rol64(block ^ kwn, kwn);
         block = __builtin_bswap64(block ^ kdbe) ^ kwa;
         dst[i] = block;
     }

-- 
2.44.0


