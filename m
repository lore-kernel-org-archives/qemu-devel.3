Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CE5C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjRI-0002Iu-NI; Sun, 03 Mar 2024 05:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRH-0002IP-DN
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:27 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRG-0001ym-DZ
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:27 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6e4c62b6406so1366825a34.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463085; x=1710067885;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nCsWk0WGiVM2x8kzQW2DXQXp4GeFwvjE8Te/kDy8WeQ=;
 b=YBFmxBStmyc+fW8k41hDt/arp+jjpweyFlmEkA0TgiNrv4vGwPqRF7wnY7V9MCzb9J
 xkugaj+gRVMdsL0oMwYJ4RJZU0m1besD7isM+7Vn8WgM6X7974xLXNavujj5OHoJkN8k
 UcBrWe3ZXH8UDBiZsbg7Eu6GBjo9zRDJPtoVLnRJXsYL9si8zYVsKUutjM4QaadkRIQm
 w7WOF8ixGoxaKYDJr8Cu5XiGQjfR84hAbGlvA0t4TfrGY1/KCE//ogap9rQ6lKWjIVIX
 nSFsH0qGOsD4ljqOBFvK+8KZpWDGpChpcBZjF9fwvlQbK+5IlAF9NS+fMnlYpjV9D6s8
 Z20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463085; x=1710067885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCsWk0WGiVM2x8kzQW2DXQXp4GeFwvjE8Te/kDy8WeQ=;
 b=CCaGzzE0t6fvM/MG2Gm9/TzU1VZdw15fXpF7hLAK040ayNejEYRdpvW8UecCdoYPzj
 7Evgp+ZiqChF1YUUlI2kEQUICAEcC+xCxeRBIDyOwijY62g42CtjH5ca180YAvGpjbiu
 gcn6v/b68jIpjYUwbd7BLvwDGbCulRb65o1AoylTaOmIPO+xr6X8NLiKaj5uHBz3Qdq8
 3dLMBe/pHZ0PaEwlhZrCPMs5ELcu37MElWjmNUNP4LO6d14PKSUCHkk+6avMh2ENoWF2
 DqjRC1Fnp33ml5M9ioEYu22fbjnmrX83QQXRfsUf6g04SJZXZa0N4gZwxlia/KchFKiU
 IT1g==
X-Gm-Message-State: AOJu0YxTQtK+dQQ71S4lgJrpfU9pHjCuRuY1vH4vY4if/ateeTlS9K0w
 Qf6xR+4Z0DF3iDAiB0FDoM5m/Jq3mh1aHKiaXsTW7MZ87uRq9ksdY7O1NQ2C4J6486Ph3TTm+E5
 g
X-Google-Smtp-Source: AGHT+IHDupLpwhjK1Rvgy5zwR+avyLwV6+hJxnijjgEQJjTWaRDMSVkpWH5eCXXQhfvWiviX9MtvBg==
X-Received: by 2002:a54:460a:0:b0:3c1:da6b:b3e0 with SMTP id
 p10-20020a54460a000000b003c1da6bb3e0mr4410045oip.39.1709463085067; 
 Sun, 03 Mar 2024 02:51:25 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 n2-20020a170902d2c200b001dc2d1bd4d6sm6478736plc.77.2024.03.03.02.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 03 Mar 2024 19:50:39 +0900
Subject: [PATCH 5/7] contrib/elf2dmp: Use rol64() to decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-elf2dmp-v1-5-bea6649fe3e6@daynix.com>
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x334.google.com
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
---
 contrib/elf2dmp/main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index dd686280f981..432f8629f321 100644
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


