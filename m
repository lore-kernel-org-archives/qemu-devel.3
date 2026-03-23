Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AA9F46112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fdN-0000eX-Ki; Mon, 23 Mar 2026 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fdF-0000d4-CK
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:47:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fdC-0005Xt-LO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:47:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so3045518f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774273665; x=1774878465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKxs08Eal2HGj5ECW9ciBCNGi/We4yXnPvl6pwVcAoM=;
 b=H5BSgfkhWTpDvAd2NpHm9wz24FZ6gUpZQ5bY3Yz4elLR8aEJg/cu7x6u7pd0sdtMty
 sqZ4HrpNlXYYC2cvNaqKYXk3H3LFg+e+Ze3b8e2IClVRdsfr7FfcF+b1+GwCLzBiSMFw
 Bo5W7PIlB++jCP0iXNkfIT22UdpfY2Jku0F3EQkyCI52I5db7WBwVNK8H+LlRrDiFqBr
 IEgMxINciV97+E2WSpK0oO0iyltHYZHZbZIKeZeFNaD2NNTxG72jBCck4eNULU26Jedi
 Q1feUijlXc36ukyR8gmjnbehjIDQqrqcUYsbdrDqMZGi9wPDCw7Vh47ptWqUdQfb0pLF
 nhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774273665; x=1774878465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uKxs08Eal2HGj5ECW9ciBCNGi/We4yXnPvl6pwVcAoM=;
 b=MuhX04PYlZT+3kOXOW+XbDb22hL/PFzFnma+/YT2fl3KqR4jqZ4oEKUnxRGN4W/bFZ
 vHIN+xbHwDEep/8jzYyMsPXnt8ofgv9kAmWwnQHLgPBJyDeAoHDu4zVrhdKo3Tq4JbhA
 CgXjxxjg/zLX8QdD6GvXeuGWX02nwy1wHsGkq3UH4HryMtgJDhJuvlVo0syOZefbHXV7
 np81nAPdayBTob05isDBFDUSo7GEoUusPoZfoO+tbgGNhk7oLfGvj3EOhnLLrATdZa4E
 0E4OCwAVQTbN+SbUb00xxyQCpYvvoOBUmJ6pTrx4cLC4xcZcTPteJCmYqbMi1XYnZYGY
 8u7Q==
X-Gm-Message-State: AOJu0YwyNlJsGsn4A98HmCz6w6sDyxqUjfod4zw0hyYxbCkY29XmJZFQ
 tm9ug6ADyVGmTodDGGm8Uny9k7+y9YFSLu3q3Nyqf/jokPSk6kqymSY9WXXS+hbYaeMUgymdnrv
 Ap5+28ZE=
X-Gm-Gg: ATEYQzw4P1jyGLTZSDWLC7js8HaWWSPiJtScCEe2djDd21Hzm0Za8wO82t36kopLU/J
 7iHltVljknjhNNvCS7+fB0wvKiatVDEWLGUQ1O6vc5qq3pjms01vn0Ghqu7ToPFcpIVA9PxkkMq
 CSI4103tY61pj+2BMpXrSyfu9dGVabi3awRYwqGkpf037kHPRiO9RReyh91zVGZSmlEiNh5Bfyc
 hXlLOq3hw6pCcmWhMHlCm8pbr14N83h/3x1rxt1Uy53daZRek7iQApnm0GSu1gPf5dpqzyH3EBB
 DwUZ7IhYlRH53Ti7bv/eWclugUDIYsbtprFHlEkmWXqf/Jw5cINYE+EPqgZxz1m5Ci+33kg9V9b
 t4wqQ0mIaz44mLIEoWLv6sKWqCP5YaLn7onw1LLp5Ysj2362K1OUkHN5QPQZC5BZxlnqyWJxpCk
 BMuEVmv4gcru36RYv6voiGWErGy444BVifJfw6HR+iK2rYCKnTeTeALjP0vL/TKc0YXxJwpIhMb
 ycROKOYGo2OStmZDiEqOiANbW7eZtQ=
X-Received: by 2002:a05:6000:26c8:b0:439:bcb8:54b7 with SMTP id
 ffacd0b85a97d-43b6424b9eemr18322781f8f.15.1774273664935; 
 Mon, 23 Mar 2026 06:47:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b646b0d3dsm28308143f8f.16.2026.03.23.06.47.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 06:47:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] MAINTAINERS: Remove Igor Mitsyanko
Date: Mon, 23 Mar 2026 13:47:41 +0000
Message-ID: <20260323134741.4114629-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323134741.4114629-1-peter.maydell@linaro.org>
References: <20260323134741.4114629-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Igor Mitsyanko doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c686010599..ed07629e49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -820,7 +820,6 @@ F: hw/display/dm163.c
 F: tests/qtest/dm163-test.c
 
 Exynos
-M: Igor Mitsyanko <i.mitsyanko@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
-- 
2.43.0


