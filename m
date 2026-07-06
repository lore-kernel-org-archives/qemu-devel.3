Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3AAC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggih-0007Ep-3R; Mon, 06 Jul 2026 06:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiH-00070J-6P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiF-0003H7-Fa
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-493d3135f62so9044355e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334286; x=1783939086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pPkWKKHOnNoHHo33e/HALhEFjRT3a0i7uwqrWO34aA8=;
 b=OVyD9sFKKUX4VtPZnconS6+O/crh+ux80hDvTLLKav5gmAl5XjqWxJGiqQGFdvtiyS
 C3hn+fTFo5IxB5Ct/0dgVHOgLV4Kixwh5/gMAnsC0ePRQaqgPYP1wz6c++WluCirp1hY
 IoL2vm5aGtiJVUpWN4UTikqyyzQaKnixoYjKOThJzV/5vbQ8EbBeMfa9Ft7nFaODpQXK
 ZzzEocxEemDNlxG68SYqBEIkya46qGDQ4dz3XwhWQgnLaAZkfKF64/s5S8r1d+U33jDl
 DwVSJpJdnuiAgDFUyXmRJLOVef0D7OWhYpZ+k7i6tKpy13nHHWmp2m9LGybLphfpIbPt
 QoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334286; x=1783939086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pPkWKKHOnNoHHo33e/HALhEFjRT3a0i7uwqrWO34aA8=;
 b=q74C67Mdf8HGEeg4sKvk089KyQJCGTHJPLexmtVjC34f00DfeuOOffA7U3jlJZWAUg
 tB/bFsY6uhk1EFvqH7A2YFmERVG1z5MliJ3fDqrWLtGZstjQ7wQuWUE1ti0gqgQkywyh
 Nr8nJz58oxKq1Ct8z6MOqj6H/raMPKuJxaNQg+a0XhFZQRMAcJxU5nJlvYIGeqdCpz7Y
 J3hC8gPZOxtSt0xluF/Vhe9WBXPiwLwdo7ap6U+CTEPrOXrgWa4dYn3rhlJhWYC9KUtM
 JVEzaQdlEAGjKT2yEQjj2K3rwW6deJ2UQFnS5XTM5P/moFxNLcdMUDtrou5d2U4m+Op0
 cSUA==
X-Gm-Message-State: AOJu0YzmQhmANbp23/dH9h1dyVotTQqVgiEseGA/18aEGh1RN7HNXGhf
 zQd/BY0UDK4nHiEjsZCWppT7cJOuciGqjp4sGXRYbegKJHvUzWTVJWTWCsjH5eMQ+WiOTIvlWPe
 GR5FU7bSrueEl
X-Gm-Gg: AfdE7ckmMJvg8IXibwkHZMNrFEAcH6DBKIhQNCYjRgGezamLEefdscIwGmRs5wGfvEU
 CeLm63232aEKp2MCQ7xws/z6AlaIMSn98hNbQwk79QZ18s2ncoPAPP2emI8Y3pelFzMd1HA+cOs
 yESXKFAmne69Vc+jQVBTcsU9l+/oypF/f/fBSy9at+/GLyUmJzGrz3AF6nbngb5ZqjFoTo04YKR
 ygL9+9rYcrVaad3vmppy4778QY02cz93T7i5j3Z7YsSws1bYFVvErw+8/ZDmuJuOOOrPdJPt8NX
 XXaWq5AQhyLJP+ePw5yyPiLVfnJe8Zh+1xoT45sy9J+BoSvxeHBB4GPcqgULCaGXlzkSk9ItNfX
 Zy+XPQ7sJLhe24lfcsAEPnO3Yg7u6VF6G3gtpmmd52dp7peuDCjv5ieLjVxlnn40F9G9EepHRTK
 82TacVhviGiUyt4/eJOEVoIEevJiU76QRHWD+lhwiUmuMvRb7ffC2Mf/ttc7/a4g+MR+b4X3wDv
 GNp1a4S+oUfdAc/uf7jAQ==
X-Received: by 2002:a05:600c:64c6:b0:492:4363:e7eb with SMTP id
 5b1f17b1804b1-493d11f8d5fmr103470215e9.32.1783334286075; 
 Mon, 06 Jul 2026 03:38:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/49] tests/functional: update anacapa-bmc image
Date: Mon,  6 Jul 2026 11:37:15 +0100
Message-ID: <20260706103752.320511-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

The initial version had the wrong DTB which caused issues with image
corruption [1]. Update to the latest version.

[1] https://github.com/legoater/qemu-aspeed-boot/pull/7

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260624103049.884930-3-alex.bennee@linaro.org
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/arm/test_aspeed_anacapa.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 27f8bd8b56..b16c6035c9 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -11,8 +11,8 @@
 class AnacapaMachine(FacebookAspeedTest):
 
     ASSET_ANACAPA_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
-        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
+        'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
 
     def test_arm_ast2600_anacapa_openbmc(self):
         image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
-- 
2.43.0


