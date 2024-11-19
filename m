Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25854D44162
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8f-0005vB-Q3; Tue, 19 Nov 2024 09:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8b-0005qB-25
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:29 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8W-0006C1-Us
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:28 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43158625112so30502465e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026203; x=1732631003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UEyPoQaNM10M6PqHT1LgloK+mD2I/2Fouuz1b90vkTw=;
 b=l8Jj1Yn4B2K1k7A4N+fJULEYivkYOP8E0SgwAMgBueUMRR1fn64FuEQChEWMi/MMm3
 XBVVaxPA/twEBgW3oWidvw+bYPUXt+gp6T4hmuO61K2la1TqvQKLfVuwj8G3+jL1UDET
 gf0pd6MDIpei//yaDNrfcfjoQN/f5jPoNsssFnl4qOqNspl4kLz9SZpWJkAEdC1Yb24Q
 IL1sgHPJSRFzGNkfQvaDSzEeZKxm9+Fje0pySfXIAIc717FDew8K/z8dKWeZZjgVfa9V
 7laMV4B4BULMBiFWHYVEsCMSqEY6okhgOwntMlIVlfvUZ//9molcSaxObTu/gOIQEXWl
 3TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026203; x=1732631003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEyPoQaNM10M6PqHT1LgloK+mD2I/2Fouuz1b90vkTw=;
 b=hc8AZKOPn+wg10N7b8UIdB9vLgaZUr+T7ToI9mV7aMRlAC962MKW+TXjOB22GO48sw
 nngFkh4vTEsxNPYGtQ1GL0MmWnwHpKwr+UKEBnA22mbu5fdETRsXiJYHnQtV1LWOWtbu
 ROgPSEQu2zna5iPTEXvFIcs7e6Qr316BeXDP4RGKyuYG6BboQZ082zvMfxuy3blujVpp
 S6nYwMjGygs1vyfzdfjHgI/ii+coS4nvJ8yNEuhpf6Gqzc3lNYzTu3AHjg9LngDwLjeu
 R4aYLPmO4QqBWie8ENbyB8IC7L2dwWkT6Ha8/1rmzz4X6CQ9EOQ86vi3+PrWbc7hj/WS
 jaCQ==
X-Gm-Message-State: AOJu0YyEVZU9lM7NhlNgcjSqAIFQQLZD6Rr6um6S2owOgtH5aSjwKE1T
 6JkGv7J+Y5r6TaDzTD4Cpxge6rVe22LLyT6l+lKDFTO7Hnn2/305mn07TYu16GSAZYukG956aV7
 c
X-Google-Smtp-Source: AGHT+IFTvHNZIo/lFcphYMhdZDY1cKlehr3MRg7Cp4dtgOOypVpI92ZHc5tQwPsISIIco8FcrkIUmQ==
X-Received: by 2002:a05:600c:474e:b0:431:518a:683b with SMTP id
 5b1f17b1804b1-432df74f2c1mr133360125e9.18.1732026202852; 
 Tue, 19 Nov 2024 06:23:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] target-arm queue
Date: Tue, 19 Nov 2024 14:23:06 +0000
Message-Id: <20241119142321.1853732-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Some Arm bugfixes, and a few non-arm ones that I also picked up.
Most of the diffstat is a test program.

thanks
-- PMM

The following changes since commit af4c4fd128d3e73f7435a3723e9fcd2ec64c5f4c:

  Merge tag 'pull-nbd-2024-11-18' of https://repo.or.cz/qemu/ericb into staging (2024-11-18 20:24:05 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241119

for you to fetch changes up to c5275c734233d6457f2340ca01d4577a971ea328:

  trace: Don't include trace-root.h in control.c or control-target.c (2024-11-19 14:14:13 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/timer/exynos4210_mct: fix possible int overflow
 * hw/net/rocker/rocker_of_dpa.c: Remove superfluous error check
 * hw/intc/openpic: Avoid taking address of out-of-bounds array index
 * hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
 * arm/ptw: Honour WXN/UWXN and SIF in short-format descriptors
 * hw/intc/loongarch_extioi: Use set_bit32() and clear_bit32() to avoid UB
 * system/dma-helpers.c: Move trace events to system/trace-events
 * target/arm/hvf: Add trace.h header
 * trace: Don't include trace-root.h in control.c or control-target.c

----------------------------------------------------------------
Dmitry Frolov (1):
      hw/timer/exynos4210_mct: fix possible int overflow

Pavel Skripkin (2):
      arm/ptw: Make get_S1prot accept decoded AP
      arm/ptw: Honour WXN/UWXN and SIF in short-format descriptors

Peter Maydell (7):
      hw/intc/openpic: Avoid taking address of out-of-bounds array index
      bitops.h: Define bit operations on 'uint32_t' arrays
      hw/intc/arm_gicv3: Use bitops.h uint32_t bit array functions
      hw/intc/loongarch_extioi: Use set_bit32() and clear_bit32() for s->isr
      system/dma-helpers.c: Move trace events to system/trace-events
      target/arm/hvf: Add trace.h header
      trace: Don't include trace-root.h in control.c or control-target.c

Rodrigo Dias Correa (1):
      hw/net/rocker/rocker_of_dpa.c: Remove superfluous error check

Roque Arcudia Hernandez (4):
      hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
      tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
      tests/qtest/cmsdk-apb-watchdog-test: Don't abort on assertion failure
      tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as counter enable

 include/hw/intc/arm_gicv3_common.h    |  54 ++----
 include/qemu/bitmap.h                 |   8 +
 include/qemu/bitops.h                 | 172 ++++++++++++++++-
 target/arm/hvf/trace.h                |   1 +
 hw/intc/loongarch_extioi.c            |  11 +-
 hw/intc/openpic.c                     |  15 +-
 hw/net/rocker/rocker_of_dpa.c         |  13 +-
 hw/timer/exynos4210_mct.c             |   2 +-
 hw/watchdog/cmsdk-apb-watchdog.c      |  34 +++-
 system/dma-helpers.c                  |   2 +-
 target/arm/hvf/hvf.c                  |   2 +-
 target/arm/ptw.c                      |  72 ++++---
 tests/qtest/cmsdk-apb-watchdog-test.c | 344 ++++++++++++++++++++++++++++++----
 trace/control-target.c                |   1 -
 trace/control.c                       |   1 -
 system/trace-events                   |   7 +
 tests/qtest/meson.build               |   3 +-
 trace-events                          |   7 -
 18 files changed, 584 insertions(+), 165 deletions(-)
 create mode 100644 target/arm/hvf/trace.h

