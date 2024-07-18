Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC584C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUKxo-0004gF-Vb; Thu, 18 Jul 2024 02:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUKxn-0004fC-8S; Thu, 18 Jul 2024 02:50:03 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUKxk-00047C-PI; Thu, 18 Jul 2024 02:50:02 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 18 Jul
 2024 14:49:25 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 18 Jul 2024 14:49:25 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 00/15] support ADC and I2C for AST2700
Date: Thu, 18 Jul 2024 14:49:10 +0800
Message-ID: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1: 
1. support ADC for AST2700
2. support I2C for AST2700

Jamin Lin (15):
  aspeed/adc: Add AST2700 support
  aspeed/soc: support ADC for AST2700
  hw/i2c/aspeed: support to set the different memory size
  hw/i2c/aspeed: support discontinuous register memory region of I2C bus
  hw/i2c/aspeed: rename the I2C class pool attribute to share_pool
  hw/i2c/aspeed: introduce a new bus pool buffer attribute in
    AspeedI2Cbus
  hw/i2c/aspeed: support discontinuous poll buffer memory region of I2C
    bus
  hw/i2c/aspeed: introduce a new dma_dram_offset attribute in
    AspeedI2Cbus
  hw/i2c/aspeed: Add AST2700 support
  hw/i2c/aspeed: support Tx/Rx buffer 64 bits address
  hw/i2c/aspeed: support high part dram offset for DMA 64 bits
  aspeed/soc: introduce a new API to get the INTC orgate information
  aspeed/soc: support I2C for AST2700
  aspeed: fix coding style
  aspeed: add tmp105 in i2c bus 0 for AST2700

 hw/adc/aspeed_adc.c         |  16 ++
 hw/arm/aspeed.c             |  31 +++-
 hw/arm/aspeed_ast27x0.c     |  65 +++++++
 hw/i2c/aspeed_i2c.c         | 340 ++++++++++++++++++++++++++++++------
 include/hw/adc/aspeed_adc.h |   1 +
 include/hw/i2c/aspeed_i2c.h |  34 ++--
 6 files changed, 418 insertions(+), 69 deletions(-)

-- 
2.34.1


