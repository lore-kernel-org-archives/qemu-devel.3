Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC09CCD193
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Oct 2025 11:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCyeM-0003Fq-60; Sun, 26 Oct 2025 07:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyeG-0003Dk-3S
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:10:57 -0400
Received: from mail-m1087.netease.com ([154.81.10.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1vCyeA-0002OB-1R
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 07:10:54 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown [117.67.70.197])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2734efe8c;
 Sun, 26 Oct 2025 18:53:27 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v3 0/3] hw/arm Add STM32F4 support and PWR device model
Date: Sun, 26 Oct 2025 18:53:17 +0800
Message-ID: <20251026105320.5591-1-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2026d53503a4kunmcecdce756fb9ac
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE5IVkpKH0lITxhCGhlDHlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSkxVTUxVTEtVSkJMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=EHyxWZoZpVsbhOWRoNvBLwIkgf79fkvMTb3jU2rUXO9Npv4OZ+jQ8Bs/qRd41zH69xGpuZhMpbRrGoRyDUi79xQIwrwcA0XpVXpz96OdBENRztd+bzg/M2JdtYBWcIiddK9i9yxzxBAruJbFGwiicJ5/apCRZSB92kSKgd1nzQdx3yKpgEmd8O2m3kQPsdbUbjYvAnuuDvX63ie/5XN8DGXlA7aTki7uz8V+LVaHGjkGdqxASETG1PRHdy8QRZHxGVn++XTc9cjSdRAQR/ZKL+aArUdC26/6b071YGaF0uR1ydJISLxOZP5OfvK9INIOWt68T4VR7e88euwUK979Bw==;
 s=default; c=relaxed/relaxed; d=rt-thread.org; v=1; 
 bh=gSQgDGzHd0DPl21PTZbTJ+WaDy1s6qkipCbYatTL2Lw=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=154.81.10.87; envelope-from=fanyihao@rt-thread.org;
 helo=mail-m1087.netease.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yihao Fan <fanyihao@rt-thread.org>

This patch series introduces basic support for the STM32F407 SoC and
a new STM32F4spark machine in QEMU, along with a PWR device model.

In addition, I have modified the header file referenced by the RCC
driver to STM32RCC in accordance with the suggestions.

This series includes:
- A new SoC model (STM32F407) with initial integration.
- A board model called STM32F4spark to instantiate and test the SoC.
- A PWR device implementation for STM32F4xx family.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
---

Yihao Fan (3):
  hw/arm: Add support for the STM32F407 SoC
  hw/arm: Add support for the STM32F407-RT-SPARk board
  hw/arm/stm32f407: Add PWR device to stm32f407 SoC

 MAINTAINERS                            |  14 ++
 docs/system/arm/STM32F407-RT-SPARK.rst |  41 +++++
 docs/system/arm/stm32.rst              |   2 +
 docs/system/target-arm.rst             |   1 +
 hw/arm/Kconfig                         |  13 ++
 hw/arm/meson.build                     |   2 +
 hw/arm/stm32f407_soc.c                 | 217 +++++++++++++++++++++++++
 hw/arm/stm32f4spark.c                  |  56 +++++++
 hw/misc/Kconfig                        |   3 +
 hw/misc/meson.build                    |   1 +
 hw/misc/stm32f4xx_pwr.c                | 111 +++++++++++++
 include/hw/arm/stm32f407_soc.h         |  77 +++++++++
 include/hw/misc/stm32f4xx_pwr.h        |  40 +++++
 13 files changed, 578 insertions(+)
 create mode 100644 docs/system/arm/STM32F407-RT-SPARK.rst
 create mode 100644 hw/arm/stm32f407_soc.c
 create mode 100644 hw/arm/stm32f4spark.c
 create mode 100644 hw/misc/stm32f4xx_pwr.c
 create mode 100644 include/hw/arm/stm32f407_soc.h
 create mode 100644 include/hw/misc/stm32f4xx_pwr.h

-- 
2.43.0


