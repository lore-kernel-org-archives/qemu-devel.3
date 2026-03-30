Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BC71061B1C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hjh-0007kT-94; Mon, 30 Mar 2026 14:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjD-0007hY-CR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjB-00039Z-BI
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cf5fbacc9so1111168f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774896763; x=1775501563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZybrFBw7Ix8mwMCX2q8Yt1KrEczHCjP+PGVzV3FEqrY=;
 b=rkAsugEqUV3HpjutLo+R8FUsSp/onUH6pesHBD6+0AXusZu9b8FpOQ6joqx6Z2rWWm
 6yyJLO37LSOeYPxXjxRSfGyyAuLpAFfbbUx2ug64hSzNZV0Yfxd+tflXXSSuqbbp8piW
 mBuRRhgHT7q/2W4UnCNt8ANCnb0Z8vozbFITzR+SA9TDwcsUPx/MZcG9r6slydLEpMza
 EJRiKP8ffPcLFqS/wdTn1senEbVH2utHPtuoLijCMerITVNIN02hp58OyMEYKRrC9eL/
 10OshR1f00liRA2fiLZde0DfFYuKzpDfsUdTJWl0q/8Rj2XqmiG4/+vWnptdw7SlcsfK
 EVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896763; x=1775501563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZybrFBw7Ix8mwMCX2q8Yt1KrEczHCjP+PGVzV3FEqrY=;
 b=fR/w1nFPsLb2V/zq3lDWP8dH7BQ8gUwPOPrM9MMXoYC4X6GkdcINcwMFSopsYJZbJ2
 hhEkgkHsH3Be94ysFVn4iivzEPqVb1XwkY7l//l5kBrv8geOnnqOu/sRLYXJsA1E1G64
 QAZrK8WDJ++ZX9F1+ihmFAKTVXv4Bw2dIV3tC88P5+O5dgjfL9Oq8bvoKjEd0gwfF+eL
 OA7xk00fXtVKOs8rw0Q8+BBFCk4oKw26CxK99LZcbbNsDNtRmLmi/xD8LjFPpMk5iKu6
 OTZTsFDz/lz8PBxFwDi0bYffF1fjnWGi4rkqQ1tY9aVNwwgHfV20mstdknch/reCxYwY
 r2KQ==
X-Gm-Message-State: AOJu0YyFx8MLd/cBrWMHZs3o4f9yToNI0qrxjutxqG5d+pOVySt/kQ1M
 rCArk68k6TOYVAECqIBWHJ0kp1F5BteN6CAH3o1ajQ7neysn4NjmCJL10W84bvdNeq49EUlJUvl
 X6CURZsI=
X-Gm-Gg: ATEYQzx3mzWBczgNkaKEfyBOQCae5tmmFSZd0q/en6JHwaaqS5Fq1fox6F77sIw8zZi
 qLEppDRyBhIOKo5cN9J0r+PsAMwQltoZeZUXbJWeaw1QlhvZI4w0n+RFFZa3NRJ+P1bhIEP9LK5
 D6kuj59VPe6VIzZPcg53Ft1l76tCV0Xxfgtg2T2PKd3vmTv7h9JwmDxqoSXmsXqoEk508XFUnO3
 ZYonp4iLneNM+VH0ng3lCF6OeH7hqPFpUQLIZB6Uql2h2cgCPUKXa3JyhpNyJkHv/1OIBTnLS+M
 HPZeQeYk56bW67vPEIK4nKYNX7fqTX5ViUIZmhdFMIXQkFtetN8ehy2axx23nSwaw7ei/E7vlXW
 6OWGDcTyPMoMR0TwCd8vsjQSIWCDl3aP47wVvcxD/jCnTxfufVUAPJZ2QgiwbTWlodEfvnoHh+H
 q5IPTQZmph0r1sYzsLd7yZx9JtcOOA7hJLYnhFq70v3PMH4uNesstnu/wk18zNsm9CBBwY8w5lv
 XzOrdQfSlSO91IA3iulkc8ea9bduHI=
X-Received: by 2002:a05:6000:23ca:b0:43b:9d69:43a with SMTP id
 ffacd0b85a97d-43d081c1b5amr922063f8f.8.1774896763163; 
 Mon, 30 Mar 2026 11:52:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f1749sm21229400f8f.14.2026.03.30.11.52.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:52:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] MAINTAINERS: Remove Igor Mitsyanko
Date: Mon, 30 Mar 2026 19:52:35 +0100
Message-ID: <20260330185236.1905636-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330185236.1905636-1-peter.maydell@linaro.org>
References: <20260330185236.1905636-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Message-id: 20260323134741.4114629-3-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae356d886f..81f49b232b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -821,7 +821,6 @@ F: hw/display/dm163.c
 F: tests/qtest/dm163-test.c
 
 Exynos
-M: Igor Mitsyanko <i.mitsyanko@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
-- 
2.43.0


