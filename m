Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12D1109B468
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Ywc-0005ex-RN; Tue, 31 Mar 2026 09:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YwX-0005dl-5F
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YwV-00046v-1c
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4887eca00c4so3877125e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962936; x=1775567736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZMEvZqXM1s5ZrHLjKPMsTqMknGdEXuNvVui5H2JTOzk=;
 b=U0I57L00DrPMLU55LIYLs3HbsHPNC7jBdjRcgLRw+O+H7zrBb4KianOvpSKnp3DixC
 MLHDjY4YTNn9DPjJuL4jBoouYKL4irYloBJK7mR4WgJKEdAviMr0golOVx7jup34AhV2
 PYQ4t3sB7caqHwmQ9JXzDfzempjdhHPXqbzlj2QlktJhNoR1GIxPrZtu5ahCEqBTrtd1
 E3MCix9ECiaCwAVs7trtoSgrFdK5FQkgm87T+BreiPw2kuT1JlORbPa6oER1XNQ74+P2
 WrwdDO8AyQKAsYkerW2itKgstZVCWwEJfpwnYeeCCm7ArRA61yIvp5S10LvFaKN4noxV
 bc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962936; x=1775567736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZMEvZqXM1s5ZrHLjKPMsTqMknGdEXuNvVui5H2JTOzk=;
 b=q6l5b5YGGToB+scXIwinc4CCZ6IHvh91O214koQ6jdkdY1a0rTulLMGl+cX8STou5L
 yq2QWdAzLoLBJXGUpBfbceWqk/8tKg2klfPLYcJZf8dCiR9dIvDF0xiJzt/gX/cumiBn
 AtZDs6vx7WOjDjAHg5Wk7/m5NrTBa8ZsXDZTPLsmyi2IQJ9ZmBS93T+3ZiQAlqLILVxN
 jM54kk73iH3q6arZ8epwkXOEUQHooLZKiG+qxGCs0rDQSu6RwDMGpI3c6CCGXm9VpFb7
 yOzY04aAFzaK9W+5xwgCs5otBOwPcsZWi5QcqcVqPsZGOegrNQaNAvdROX6y4Mq67OA6
 F21A==
X-Gm-Message-State: AOJu0Yyf6R65bvT7xyeZ5rPrawj5hlwvUiFfw1wG6n4DhnQ9f4HU5WLM
 Awabu10A36IKi0rAoEhlKmyEMeKFO7VF5sfBVkbw0XKpo5tH+59CNLk10BiuNo7ZypXT506FxaX
 XaUBS5UQ=
X-Gm-Gg: ATEYQzwDmXfFzGoK0104y/pwEdCQeWgps9ri7X0rG/T3pILdqbrIX8H6IXy+ZzlHa+E
 0ufpreaPRkQXHQfOGMi6XLt4l8vX0ojLZv0oeNPXrygli4Dp2YrXPwEFQ20wP8MnPL/4eMHFBhn
 F8NLPepju/OE0/B31jLwLDh11RzZk88CF9XyZwFu9E2x7UTVpgq1Tt+4fNgw0dcvJYo9whw9TQe
 syKFdgKyZhz/HryPk3n1etHkOTJ3lz052DW/JKfj0hmwAWTxHsRz28pQASD4ESr7pe38qwnvyAb
 EeHUYKe7v5PrRHe8tvHZQ1P2Cm2sUe0vaC650TeAPPlHaoYcDv4k6MVkJYk8yEaohlUc4EZlzTO
 Y2R3cZvI3wWKWDS3sX1XPtqXlJEAtcmWcYjGSVijzpULakH06it8h+rJrDf/7SwGzNaDjS1k7EW
 GyV95vqX6LyrhGj31rRngECt+O9b/PvazhksLYhjrdjWSktU9FTtOFaTTGm4xlAETUeRM=
X-Received: by 2002:a05:600c:6309:b0:487:1fbf:e0c5 with SMTP id
 5b1f17b1804b1-48727ef678bmr321369345e9.19.1774962935816; 
 Tue, 31 Mar 2026 06:15:35 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48880d864b7sm6316385e9.3.2026.03.31.06.15.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:15:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] MAINTAINERS: Separate QDev section from QOM one
Date: Tue, 31 Mar 2026 15:15:04 +0200
Message-ID: <20260331131514.21152-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

QDev is about QEMU devices model API, while
QOM is about QEMU object model in plain C.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20260325151728.45378-2-philmd@linaro.org>
---
 MAINTAINERS | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81f49b232b5..de8819b7aaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3546,24 +3546,29 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Supported
 F: docs/devel/qom.rst
+F: include/qom/
+F: qapi/qom.json
+F: scripts/coccinelle/qom-parent-type.cocci
+F: scripts/qom-cast-macro-clean-cocci-gen.py
+F: qom/
+F: tests/unit/check-qom-interface.c
+F: tests/unit/check-qom-proplist.c
+F: tests/qtest/qom-test.c
+
+QDev
+M: Paolo Bonzini <pbonzini@redhat.com>
+R: Daniel P. Berrange <berrange@redhat.com>
+S: Supported
 F: docs/qdev-device-use.txt
 F: hw/core/qdev*
 F: hw/core/bus.c
 F: hw/core/sysbus.c
 F: include/hw/qdev*
 F: include/monitor/qdev.h
-F: include/qom/
-F: qapi/qom.json
 F: qapi/qdev.json
-F: scripts/coccinelle/qom-parent-type.cocci
-F: scripts/qom-cast-macro-clean-cocci-gen.py
 F: system/qdev-monitor.c
 F: stubs/qdev.c
-F: qom/
-F: tests/unit/check-qom-interface.c
-F: tests/unit/check-qom-proplist.c
 F: tests/unit/test-qdev-global-props.c
-F: tests/qtest/qom-test.c
 
 QOM boilerplate conversion script
 S: Orphan
-- 
2.53.0


