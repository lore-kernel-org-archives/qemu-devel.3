Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TNwXpB9t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG35-0003Fn-2c; Fri, 23 Oct 2026 10:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG33-0003Fd-Nl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG31-0006XQ-7X
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so784902f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764905; x=1793369705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rao4giwkilDoDPZ4eFpWpq59/NDYH2RgfwoNy92gcJE=;
 b=TNwXpB9tmIwfUedVj7Hu93CfA5dlRwORhQZrpboPc99E7PFXAyJ3PTfytDv4P0/TDJ
 hsp5Pu4g16J4dXax8DsKnnQdy1pV6s663U9eqtSSe9eIaGo0Bh2Q764pECiN9Bkr867c
 GZjcIUfBG3AItDLATC05YlBxWMk5iygnNddeK4zfmUy507kmcMAJxad2EDHM/KXtlxRd
 w5HPnt1SNCblyE9uZgRCrCOgQNCwpUs8K2pV7IbXBfYDZOF5EYIg3oHvDAVkU7knmPOv
 FvvUfYmSVaCptDxXC+XJe/+F2oIyw9AogddZ6KeFxRqxMtL612PG3sBzWdMvpavBpEHR
 gv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764905; x=1793369705;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rao4giwkilDoDPZ4eFpWpq59/NDYH2RgfwoNy92gcJE=;
 b=SvAPdoE8040pvxOj2oXwImvdWGdazaAIoMiOJ3oHTajFzIxSa7KmWj1iX/5D2xxzXG
 9l6GEQGxjQvtrRQZBwI7U5h49eRzcMHdDqKu7U5hVWaoDomLundCa+xuUu0kquWeec3a
 WsJE2JeJ2GCbEW0Gv8TTaYzmVWt1MD/19RyTdjFjmvCpMbMAS1tp/mb7yIm25b/PyC8g
 Dz72mPw0ullfxEWaMRI3IqVnuGO5Kf77641m0QH2G7J+HCwPlU62NDpU/4xpUOha6y8C
 2SkNMvAkX+Tpaa0Jz29LhOvhRsM9Z0cNNaXYogt22da1RzGYO21JOi9wv6WMsPlTHvzC
 L3+g==
X-Gm-Message-State: AFq9FYIvBe4OYwDiHC0x+OFeon4f8azoJiuAfWZgFQ2iPjkuU1YA202L
 6FdY7qmmMs4QC0xCkBCh35wjqsoJpYA262NqwxfASTJwkTy2vwTJtAoNlzkEXJszuDA2SmUk1Jo
 WaBUcc6A=
X-Gm-Gg: AYBFou3pKcdewXP7RdvsEJd/bSnVq9FzgaNdRI42aKWmICHc0icfMnfr/f440TGSrU3
 YSnGVkmh9OOvOx6sziI/UZSQeKb/pyD0ixSZg3s5RXio0ohEeG1aavs3Crx65erKq6QE8rp5Slo
 LZDbVfc1RmHzron7fePaQI9w2b/KNnAEc4GwACP0dginMITVSLK9BuTZGDz0CeNFVTvFxImdOd/
 2sg9p5EJAOt8lULvCuvO+isRHPEZx0ThxTWghgw+DuMlzuBT3HVQ8Ewq/pLa5u599gBkACl/5+L
 xGvbXZrs1kMcpZ7wrCcnhIdll0w3kt6DndvDLbZGBq1LCCQeDe7AUNIJB9tfNoRy5icvp5hB/tr
 huWIpBAwMYv95fzQzkfdneyA5PQTBQMKoutP9ReP9+hhz4yd2JweMW4r20BDeP7GSb8o98hXsz0
 eo5K+XhvtvKNp95x7UCr9cO7fsrOsI5qpN+7pHFo/4K59WUJDeKZot2EvYkQ3Ceo3JEo53jO451
 F3G+DeuJO1W5GFXNj0mGt3DdgjbA3+XWCzH+pBqbcbb8qk7tlG/YUr66tosUPR7NM1zHk8/Otur
 vf/Z1HPXDreemMEXi/ShM7TYV/abB++9FqgcbNBVtiPuupQxvCYuAu8KFqDC
X-Received: by 2002:a05:600c:a47:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4a218671227mr21739055e9.25.1792764905330; 
 Fri, 23 Oct 2026 07:15:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] target-arm queue
Date: Fri, 23 Oct 2026 15:14:47 +0100
Message-ID: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:

  Merge tag 'pull-request-2026-10-22' of https://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261023

for you to fetch changes up to 02e9aebb8ecdf9c19c7e2d0ecd62de8ff0c6827f:

  hw/adc/stm32f2xx_adc: fix left-aligned conversion results (2026-10-23 10:01:16 +0100)

----------------------------------------------------------------
target-arm queue:
 * raspi4: emulated RNG and thermal sensor devices
 * hw/gpio: Add EINT CFG to Allwinner GPIO, fix interrupt handling
 * target/arm: Deprecate using named CPU models with KVM
 * include/hw/core/qdev.h: Fix where device_class_set_parent_realize docs suggest putting parent_realize
 * tests: arm/virt: add GWDT tests
 * hw/misc/bcm2835_cprman: Treat invalid clock mux source select as GND
 * hw/intc/exynos4210_combiner: Fix various bounds-check issues
 * hw/adc/stm32f2xx_adc: fix left-aligned conversion results

----------------------------------------------------------------
Igor Mammedov (1):
      tests: arm/virt: add GWDT tests

Manuele Conti (1):
      hw/adc/stm32f2xx_adc: fix left-aligned conversion results

Marcelo Manzo (3):
      hw/arm/bcm2838: enable BCM2838 RNG200
      hw/arm/bcm2838: enable BCM2838 thermal sensor
      tests/functional/aarch64: add raspi4b RNG200/thermal test

Peter Maydell (7):
      target/arm: Deprecate using named CPU models with KVM
      include/hw/core/qdev.h: Fix where device_class_set_parent_realize docs suggest putting parent_realize
      hw/misc/bcm2835_cprman: Treat invalid clock mux source select as GND
      hw/intc/exynos4210_combiner: Fix group register range check
      hw/intc/exynos4210_combiner: Clean up reg_set[] bounds checks
      hw/intc/exynos4210_combiner: Make reg_set[] only as large as it needs to be
      hw/intc/exynos4210_combiner: write default case is unreachable, not guest error

Sergey Kambalin (2):
      hw/misc/bcm2838_rng200: add BCM2838 RNG200
      hw/misc/bcm2838_thermal: add BCM2838 thermal sensor

Strahinja Jankovic (2):
      hw/gpio: Add EINT CFG to Allwinner GPIO, fix interrupt handling
      tests/qtest: Add Allwinner GPIO input test

 MAINTAINERS                             |   1 +
 docs/about/deprecated.rst               |  13 ++
 include/hw/arm/bcm2838_peripherals.h    |   4 +
 include/hw/core/qdev.h                  |  15 +-
 include/hw/gpio/allwinner-gpio-regs.h   |   5 +-
 include/hw/intc/exynos4210_combiner.h   |   6 +-
 include/hw/misc/bcm2838_rng200.h        |  41 ++++
 include/hw/misc/bcm2838_thermal.h       |  23 ++
 hw/adc/stm32f2xx_adc.c                  |  12 +-
 hw/arm/bcm2838.c                        |   4 +
 hw/arm/bcm2838_peripherals.c            |  28 +++
 hw/arm/raspi4b.c                        |   2 -
 hw/gpio/allwinner-gpio.c                |  19 +-
 hw/intc/exynos4210_combiner.c           |  26 +--
 hw/misc/bcm2835_cprman.c                |   2 +-
 hw/misc/bcm2838_rng200.c                | 400 ++++++++++++++++++++++++++++++++
 hw/misc/bcm2838_thermal.c               |  98 ++++++++
 target/arm/kvm.c                        |   7 +
 tests/qtest/allwinner-gpio-test.c       |  57 +++--
 tests/qtest/sbsa-gwdt-test.c            | 227 ++++++++++++++++++
 hw/misc/meson.build                     |   2 +
 hw/misc/trace-events                    |  10 +
 tests/functional/aarch64/test_raspi4.py |   7 +
 tests/qtest/meson.build                 |   1 +
 24 files changed, 958 insertions(+), 52 deletions(-)
 create mode 100644 include/hw/misc/bcm2838_rng200.h
 create mode 100644 include/hw/misc/bcm2838_thermal.h
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 tests/qtest/sbsa-gwdt-test.c

