Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE10C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udx1C-0006AL-Sg; Mon, 21 Jul 2025 16:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyO-00038V-Aq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:19:02 -0400
Received: from mail-m8288.xmail.ntesmail.com ([156.224.82.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1udwyK-0000Xx-RN
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:18:55 -0400
Received: from DESKTOP-FHFCVTH.localdomain (unknown
 [IPV6:240e:360:9379:c800:30:bacc:21c0:5559])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1cc453b65;
 Tue, 22 Jul 2025 04:11:35 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yihao Fan <fanyihao@rt-thread.org>
Subject: [PATCH v2 0/3] Add STM32F4 support and USART device model
Date: Tue, 22 Jul 2025 04:11:31 +0800
Message-ID: <20250721201134.13270-1-fanyihao@rt-thread.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB0fVkkYHUIYHkodQxkfHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kWGg
 8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a982e9cf87203a4kunm518c726929260ae
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46Ehw4DzEhEDoRTg0xFTVK
 CEMaCkpVSlVKTE5ISklDTUJNTEtPVTMWGhIXVR0aFQISExoUOwkPVg8TCR4aH1UUCRxFWVdZEgtZ
 QVlJT0seQUhNS0FCSExCQRhDS0tBSEtBGRoYGEFJShhLQU5OTkJZV1kIAVlBSkNPSjcG
DKIM-Signature: a=rsa-sha256;
 b=WioTTbc0oRPmx7GecNVL5QUULf7YbliJcPuiSesSMZ0pda8GPbyIFp+/TqTFWuQM2vm7ETYpU+KK/G4GWMEnrS9WvNZNfmkmxaRo+ozRyVEUTnGVPVwpwwbsH90eDPHVMkyouNyT9MAm+IatVd0WZ+z3Qt+6Cdb+3pUy+qotou9oFWYmS/OpzFee6i73th5xqyYcNQPt3wzoO8BptPsnA8ocm+KN8ipyhNG5kkmI83o0KFI6xMpPpl53sABe86IzFrxJ1bLCY8UNLJVBBCFSg0i88WpTMvS9CMWsxqovn5wDprL0H+8KEpPMjY7NmudTxRrauGMU7X9WP3d5NY+QcQ==;
 c=relaxed/relaxed; s=default; d=rt-thread.org; v=1; 
 bh=zpV62gaFona0W5aWDG4KVdn1LgVeP8AThJsp7DC6jIY=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=156.224.82.88;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m8288.xmail.ntesmail.com
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
a new STM32F4spark machine in QEMU, along with a USART device model.

This series includes:
- A new SoC model (STM32F407) with initial integration.
- A board model called STM32F4spark to instantiate and test the SoC.
- A USART device implementation for STM32F4xx family.

Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>

Yihao Fan (3):
  Add-the-stm32f407-SoC
  Add the STM32F4spark Machine
  Add STM32F4xx USART device model

 MAINTAINERS                       |  16 ++
 hw/arm/Kconfig                    |  13 ++
 hw/arm/meson.build                |   2 +
 hw/arm/stm32f407_soc.c            | 154 +++++++++++++++++++
 hw/arm/stm32f4spark.c             |  48 ++++++
 hw/char/Kconfig                   |   3 +
 hw/char/meson.build               |   1 +
 hw/char/stm32f4xx_usart.c         | 236 ++++++++++++++++++++++++++++++
 include/hw/arm/stm32f407_soc.h    |  47 ++++++
 include/hw/char/stm32f4xx_usart.h |  60 ++++++++
 10 files changed, 580 insertions(+)
 create mode 100644 hw/arm/stm32f407_soc.c
 create mode 100644 hw/arm/stm32f4spark.c
 create mode 100644 hw/char/stm32f4xx_usart.c
 create mode 100644 include/hw/arm/stm32f407_soc.h
 create mode 100644 include/hw/char/stm32f4xx_usart.h

-- 
2.43.0


