Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9979DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIea-0000BX-Qu; Mon, 13 Jul 2026 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0008Sq-Tz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeG-00018h-61
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so13249935e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956766; x=1784561566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IIals0TVGejPzx41Sg5e9UWZp3mdy9oKx98sxzoBabA=;
 b=AfvFiy173FNRqIKVdYHfUxdLsGQmSsXSE32l8NZmBdipx7e8FGDKKsNEQE+FLy5sq9
 D5c/4zLABQbz5Ab8bOo5OARzCsr8qyM81ngZrh6a+ZkrX6E+UBHd1KwtXzd3AdxbX/M2
 sB/YZOJXwBGIgh5CfznoEOiY9VroRneR72s0xNEWmrHW5RFAc+lvbIP8iNulzt0t5ZOF
 u472IAXv9hllzyMuDma2Q0a+JS+ZAqAqPbm5sBxSsbcXAb4sQz7OEk08+7yOUlcuANoo
 B4YeKHuwPml6leUHmrmYaC+b9AKNZIIeXRUyhw32V87li9FzGskcOivDHabsW3IZMXot
 W//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956766; x=1784561566;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IIals0TVGejPzx41Sg5e9UWZp3mdy9oKx98sxzoBabA=;
 b=F65qsfAJFg/EeZZX8rC90xX5kS/yM6WA1L7yvwzvwoXGcHyKTxZPVtyHLktMWqlW/C
 osehC5MVpXJj8G9agIGALG0OsOTmdhpsCN4rXJd7FSOHOg89iyw1kc7Rfo+KAS9hJchg
 8ZslDNj1vfreCNc08qShqu9573YTiyL21Y4jGET1WoKTq4jHYlllUKxvuJ/EWsmu3ndo
 8aPcgWexlzDc4grQ7ba5OgMOJmIATj9gy6pNeXgeEX/XMB46CPFLV2rj8hLI6Oo4Wv9Y
 97L6wDcFqtzhhvUJ62UlO4AHk8bQ5tG7C6p7k0mOjJgCSdeEVlHvX6sB6JxdE/eDFP/B
 nFUA==
X-Gm-Message-State: AOJu0YyCJaqityj0rhuyRH8/aHapI6vwyg5EBgsTL5Y7ZgsnN3xGLSeT
 77rwYjub+uCwMONbfMYl08TaHpgnWKNYrbyJbP+vuod1B/UjQp8cbVKfUVJuFJxw1Baplo/mLV+
 ciA3qez6AjQ==
X-Gm-Gg: AfdE7cl4wRVN/KsLPrqQsfxWWUWwxdqssF+yhNRndmFVVPuf7F4G8pglLDbnk2MyB7E
 USQ8d99Ge4BqPBCDClQcRf6F7A42mtFzZJfmaV6nwz8A8LuIAmdQtM0ZiHXz6eqDCvXneH+RbPx
 T7fig7y5KEPoVDwj8Ugp+koIOCn4wi2OQkURhXRlWR4CGBrpKZz6rcJgGs8Ur217Nmcd1Z6ReEw
 xBeChr3Anu5c09Yj5pa2LRF5UmdDZFKd6CuzGFxolP4rwOTli1ZLHk0h1DRwP+9p0PJWEuZ4kxQ
 xHmGLTshus539yEZ5CXK69Y9qTmnKWdoOsCxc1G1grI8ZUo2mwhtTRqgk5xTUd2R2SUvBSIa1+0
 m8XUV6TDiGYToWARNrA9Ha2rEYvJs3aZcLYgs2trcoaaWbA9zhZeRq5arQpYr0DUVPCYCeD/wnh
 DqRT/wDhlfg1Mhj4zpSCgfQ3o/C+4+T8E8PyBW9zpQXNiCYk/ARDbw0niTntJkou30VkmkluaRN
 wTEeN9Oz4/jaM5+OP95JgBoKXqtqFpE
X-Received: by 2002:a05:600c:8b74:b0:490:9d1b:f086 with SMTP id
 5b1f17b1804b1-493ffd06bdcmr61996875e9.14.1783956766195; 
 Mon, 13 Jul 2026 08:32:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/26] docs/system: document FEAT_MTE4
Date: Mon, 13 Jul 2026 16:32:19 +0100
Message-ID: <20260713153233.3391818-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

FEAT_MTE4 includes the sub-features: FEAT_MTE_CANONICAL_TAGS,
FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY and FEAT_MTE_NO_ADDRESS_TAGS.

We have already implemented those so update the docs to include the
rolled up feature.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-5-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b751646e10e..05e85d7a367 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -126,6 +126,7 @@ the following architecture extensions:
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_MTE4 (Enhanced Memory Tagging Extension)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
 - FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
-- 
2.43.0


