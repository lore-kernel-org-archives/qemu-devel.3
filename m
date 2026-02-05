Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D759EA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnphN-0002x9-I9; Wed, 04 Feb 2026 22:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphM-0002wv-3i
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:28 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphK-00016U-Jb
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:27 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso346782b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260785; x=1770865585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2bwae1gm4TyeUWnkObIFy9BceFXzbtgb5gforCQLjQQ=;
 b=N0IKDkWIrmv7AJrX6ENQvjt0jdC/B5J0IvHKHQIGnkGjYGoq8cfqZEFngA130q/QyZ
 VXPg3wUGwz2fXDPT45VMgJbprj8jw9YnMMOlI6S3szOYcm1L3vEEGgY95JaJZejPNPRu
 6NhEhlDEksNocXTc8vcYjRpG27F9f0SMTGSwTQRFx5T2cBookKBkQW2PV7X6o8l9T5fa
 bNpQrdE+daVyEL36mOrWYpj0sw3kUVWgsYuV3k4UxdqvXNFid/86tuu2hHuCQ9D7tsE7
 ZEBdKwgswDq4QmjXWDO85rchgXbyidSOUzfw5xvZ0o1EbhdXbqXEA0FiobDO8UFsCjx/
 FouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260785; x=1770865585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2bwae1gm4TyeUWnkObIFy9BceFXzbtgb5gforCQLjQQ=;
 b=pWiDKK9zDt0BrMPRxwSw6EgyN05qZpgAHGZw853JAI6HUQjesj/alZlbt86/yJIn53
 Z1hxVDYKMX1tfh1rSs7dMO3RyNob8PmXglGXp5zBhhbD9DLeXlAdv5XjvLmb33Y52TBB
 kslFv2nyM/vPh7rwQp3rudAcdSroVgZOWmdRuZbUpjf5BpRr2fFP/v3tQu8fcVKaV8c2
 yC1PxY8Kk0q2af5JLGDje74fREFvK+Xg0FsdJOQW4LT7Kr5ZKNY3GdgFnKfdfIjjJ2pc
 XHPoaCTA3bVbLvSZ8pSJy4xPjwByAM1Ou2+7jVHuq0mhDy9S5RN+eFqI/9a5ZuDvpTdJ
 Gi9Q==
X-Gm-Message-State: AOJu0YwebcaRtSPSV74/gDh7ZrJ7B/t5jd8/o/PrRlF0ZYXZ0ocF1BFs
 rXRklHrUwIllDWXZxm6xc+wxi2R2EHUdNdOqLWB5iMeSWjpneHf5FnshxzLesjcxtvMWl1BnOw+
 Lf3yJ35H8qA==
X-Gm-Gg: AZuq6aKT9/+rYpp2q4UGWwW+aQgNLGFOqvxQP0MpbRmmU2LivbaKLZm2T98AiLYLbNB
 QWwDHoUZu0IHqnUb0LWY/vhvvnPAGM6JBOFIiDgsxXEq20Pv3prFtNN8g8kH1pkEvjMCi51qp8Q
 cuaS9xWH6sddkD8/GEGrtbZaAhZB/BlGYb3YJXcM275k4zOkXHr7L5Di7cv82HDZ7cXcbD+Eoht
 g1gobxkZqmL80gNZZJtMHBNPiTMKg6tkpToUEWUK/Q4eFYcf7lNkbWwKxBxRcychbMBWVjtckEL
 sB6iIctzr5jF2melZTeKElF4sp6ixTdkLeci5alcvJNIkIl8ARmMV3hxW1sS0sWT7dRG8ktndEu
 VnYdnJuQPMbzAEscUuQzAnjqDtj6dHR8kHM4eDMXI8j86j81zkON3w9zfPdShRGGIhjfyMsMRxW
 X+EYsfjZ4t/tW8cBp87Yt9As6mSg3qiZsq84NjhZaAVjYK2OWsUfjk2+Og2x6tDQ==
X-Received: by 2002:a05:6a00:4fc4:b0:81f:3f88:89f3 with SMTP id
 d2e1a72fcca58-8241c1695femr5584892b3a.3.1770260784925; 
 Wed, 04 Feb 2026 19:06:24 -0800 (PST)
Received: from stoup.. (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d1694c8sm4003544b3a.8.2026.02.04.19.06.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:06:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] qapi: Add hexagon to SysEmuTarget
Date: Thu,  5 Feb 2026 13:06:15 +1000
Message-ID: <20260205030617.266625-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030617.266625-1-richard.henderson@linaro.org>
References: <20260205030617.266625-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 qapi/machine.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 907cb25f75..ef8575b6eb 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -28,6 +28,8 @@
 #
 # @loongarch64: since 7.1
 #
+# @hexagon: since 11.0
+#
 # .. note:: The resulting QMP strings can be appended to the
 #    "qemu-system-" prefix to produce the corresponding QEMU
 #    executable name.  This is true even for "qemu-system-x86_64".
@@ -35,7 +37,7 @@
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
-- 
2.43.0


