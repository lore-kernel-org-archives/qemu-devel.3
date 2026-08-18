Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF4EC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwRvs-0007wH-TE; Tue, 18 Aug 2026 18:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvr-0007vw-Bb
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:19 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1wwRvp-0001FF-Qe
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:05:19 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5aeba09900bso333919e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787090715; x=1787695515; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JcjEj0fhQ45OWXoFQJAAYO4zPjWPSV3jqes7kC7rXlc=;
 b=HG7s8jc15QYJPyFd1NV5Kco7Rf8/v78QE/xgZX0sCxEDjh4joeBaR5uCwAaVG9obZr
 vt0SXJT1Rc1+9L28gHHfFLEatUNYjTMn0ic9yx7XO4RJLYem9T8lIZYGVibos4RWwbTE
 owd61Uh+a0icsNZSatAVT1pvZl9gejoj21agIrqZyTJk8g6X1c9mfehkXlQ40Pv6FU8q
 dKvd275feWlHPVHfSJbHss90F/Ppc5NDPMzPV6Mzvilvu6qgt8PkxefVceW1gTCR0BWh
 FtK+u0ZDJn/boeCM6/WEDeOP19BChm7N/NgYSQvl1tYlAuU2rOpxUuvWod3Xn+nRNNv2
 BZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787090715; x=1787695515;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JcjEj0fhQ45OWXoFQJAAYO4zPjWPSV3jqes7kC7rXlc=;
 b=SmULs3feaL7PPw+BKAY95Z+QZhDk+hBLkV8FKcim46fyaLTxqvzCjRuPG5sqLfzknA
 0Yf4bVCRVgpONv2Gdl30P1C5jxJWIvUy37uWUG2RJdx8/chve6J2AXes+21RXkaRlEAf
 8rJEJRxqASkZ64OKvUHxLv8TG5X8EcoojR/wuY84XzfUeIh6liSsKYV0TGftKlSjysEh
 HUCKN17/lB75YrrUVmt0dbHJ8PKTvxN5s3r13g9w/dH8pDS01Extj4Y5gz6bxmKVSTvK
 D9dM7sCuzjtInI0vuXzqon7wajkrvqEVlRNKUqgoeZtzM+afuHb7rMvX84aPBBbgXjLI
 RUuQ==
X-Gm-Message-State: AOJu0YzkceKRwYJo2OteF65Gpm440pjrhtUs98yoQfg3hnaW/J1CNcly
 J1KVrhoG8gxHuiZRgI7iWrF2QO+z/7ntyO3ODjOXWsEVnPbYkDMeF6gW
X-Gm-Gg: AR+sD11Gb8BKQEsCzwhDvtdlDYf/qmdBiMOJPn5q2GI/ux05j+Ye4YU4QU72RTK9qzJ
 snZ+Ztow47GD9PZe34GbyDLWCwQFNEFv6dg2r9+PH+RFm/iMIz92+9DOcl3IhWZcATR7OddXpDK
 9+FlrfJjhGc27tpD5EGi2pfevT3zhj9VPe/IxKhuK1eztzWYl6h3kBzH3RwO3v3on33GoVNj1gP
 Y7Cp3Qb6kd3p4AtzAuA62IK+E5A2JVSv6xtVmgCdiuIkB81mO3e/09BlSRcmvnTRot1UziGUqCc
 3wjPAcamphNrdowCu9rjhoMGihF7P4WtKa3OJG6IDNlLrwI91Tbs/pbVwvC8OJiojw8kXG+ntds
 0ZFAYFbSXyGgzQkULBmfAgMZ2ylVEGJizzfFc0REa1ux/I6AgDrkmO20t0vdo7eaaUzfa8f/TOA
 XZSvbyk1NDuQFci8msp4mN4YiFOSclC7ykPAq6nMNQnI9bY+GZ6qL8itOWk3ASln0+wzERx4zW7
 c6UoEu8MmaH/GEqj6xSiEtwWF1yo31zRjmt7cxB27BpNPy5
X-Received: by 2002:a05:6512:1044:b0:5ae:b91d:b2ec with SMTP id
 2adb3069b0e04-5b478bc5be8mr16199e87.3.1787090715178; 
 Tue, 18 Aug 2026 15:05:15 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b478853ae5sm21836e87.17.2026.08.18.15.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 15:05:14 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [PATCH 0/3] Allwinner A10 GPIO support
Date: Wed, 19 Aug 2026 00:04:50 +0200
Message-Id: <20260819-allwinner-gpio-v1-0-2a64866dff11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBOcCLOuEi2kRhuQKRQqCO+et
 HyL/1/IlJgyTM0LiS7OfEgFtg2su5NAirdq6HRntEWrXIw3i1BS4eRDGXK2Rxw2P/ZQozOR5+c
 fzkspH9zmvZBgAAAA
X-Change-ID: 20260818-allwinner-gpio-6ea84117df94
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch series introduces GPIO support for Allwinner A10 and
Cubieboard.

The support is focused on input/output and interrupt functionality.
The qtest suite is also updated with tests for implemented
functionality.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
Strahinja Jankovic (3):
      hw/gpio: Allwinner A10 GPIO emulation
      hw/arm: Add GPIO to Allwinner A10 model
      tests/qtest: Allwinner GPIO tests

 MAINTAINERS                           |   3 +
 docs/system/arm/cubieboard.rst        |   1 +
 hw/arm/Kconfig                        |   1 +
 hw/arm/allwinner-a10.c                |   8 +
 hw/gpio/Kconfig                       |   3 +
 hw/gpio/allwinner-gpio.c              | 465 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build                   |   1 +
 hw/gpio/trace-events                  |   6 +
 include/hw/arm/allwinner-a10.h        |   2 +
 include/hw/gpio/allwinner-gpio-regs.h | 228 ++++++++++++++++
 include/hw/gpio/allwinner-gpio.h      |  41 +++
 tests/qtest/allwinner-gpio-test.c     | 474 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build               |   3 +-
 13 files changed, 1235 insertions(+), 1 deletion(-)
---
base-commit: fa19879df1658f96ac07365fca8835b7decd6995
change-id: 20260818-allwinner-gpio-6ea84117df94

Best regards,
-- 
Strahinja Jankovic <strahinja.p.jankovic@gmail.com>


