Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA924C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMw-0006uO-3b; Tue, 05 Mar 2024 02:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMM-0006Hv-4b
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:13 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMI-0005sD-FB
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:09 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e56d594b31so245261b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624216; x=1710229016;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i3f3HL5yPh+B2f2TWI8nLswxD9Zg3vmdmgIkTXj+uig=;
 b=xhfoaqbupk9Tgn9DBe5/ySIM3GDph7OazMSWGfXpqB3egpEoqNkdPd5mNli4L+SBdU
 nnJBZ4+I3+WvuJDfoN+754zU/bGErbuT6nqND4Okh8yb6Vu+dtSX0lBr5OGUGd1gG8qa
 ZpSV3vaEt0AfhtuFg3qOOloCzAETjA0e2GlWDPmx8TzRgjy7ZRhCZ8Ub09o3auOb6iUa
 tZKDVSRLITIWhrQHYHlmeM9JwJ2HVq64qfl13TK9Cy/2h3U/mixDjrokctUwGs8OpuPN
 crhpgvYiNCL7yyMICUhMlwkIEX0n2CSZmtCGUmO/3ZPkQmxhQlVDYSxMhUsq7ESmyfm0
 r75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624216; x=1710229016;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3f3HL5yPh+B2f2TWI8nLswxD9Zg3vmdmgIkTXj+uig=;
 b=SD2ODU9Hr0U2MIDfOAW4Y3DhIqQ2SpI2kpwUs9+I12KbSawHQLe/10dAo9o24IR50D
 uY58u0z2S81lFQhbkKR4hWa7UDU2VvtZXFEUEKRnIADbRuTODraJZd1DNewt10WL1GkY
 IbAwNFrJWl1tT2lX4WZ+YvL5DJWcuYmqELd34uN+P0kyJWp/427ARCBYHFga/W8qM3TG
 hQO0Q/O+RQgIYdL3skaqeUjQvqQ0tUfpcED/lLHmOKDECJ9EzlWk+UGVOJrGsPPD1gm+
 SSUgpggjHYOIysMQ9/RvDt6J6XHOKmIU1ZVWFJQct9GJEu3sIU3MKfLD32DTAomot7zo
 juZA==
X-Gm-Message-State: AOJu0YwaR+ketQ0OJKFJAOE0Ah5Yy31lKZrNnCO9/e04pvHIhH87Kvv2
 mCtnUSCwrLeailJ5GFew+Y6rDb3+9DD1/+Br10xFagua5qcSXLYPy4qkSZ1gfsHcIgPrIYnKIA3
 N
X-Google-Smtp-Source: AGHT+IHTkLIkjVo41zPM6rMVfI6Pw4doPdq5mpKXgGn0terhyFFQZsUnHkt4nT5wlvNe6ad0kDIHHA==
X-Received: by 2002:a05:6a20:748d:b0:1a1:4bec:4841 with SMTP id
 p13-20020a056a20748d00b001a14bec4841mr1084100pzd.25.1709624216342; 
 Mon, 04 Mar 2024 23:36:56 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 j1-20020a62b601000000b006e64370ace9sm52664pff.195.2024.03.04.23.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:26 +0900
Subject: [PATCH v2 09/13] contrib/elf2dmp: Use rol64() to decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-9-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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
index 25cf0fdff724..20547fd8f819 100644
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


