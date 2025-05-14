Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD9BC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF747-0002Z6-M9; Wed, 14 May 2025 04:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uF744-0002XT-OT
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uF740-00029f-5K
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxvnLuTSRoplbmAA--.48000S3;
 Wed, 14 May 2025 16:01:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XkTSRofwHRAA--.9319S2;
 Wed, 14 May 2025 16:01:40 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 00/17] loongarch-to-apply queue
Date: Wed, 14 May 2025 15:39:10 +0800
Message-Id: <20250514073927.2424543-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XkTSRofwHRAA--.9319S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The following changes since commit 69ee0189d7977cfbb1b2c7a27393d8b9fb661b20:

  Merge tag 'qtest-20250509-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-05-12 11:11:37 -0400)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250514

for you to fetch changes up to a3d5f62254a48b7c260d5aa7bd8e8467a0bb8ea3:

  hw/loongarch/boot: Adjust the loading position of the initrd (2025-05-14 15:57:23 +0800)

----------------------------------------------------------------
pull-loongarch-20250514

----------------------------------------------------------------
Bibo Mao (16):
      hw/intc/loongarch_pch: Modify name of some registers
      hw/intc/loongarch_pch: Modify register name PCH_PIC_xxx_OFFSET with PCH_PIC_xxx
      hw/intc/loongarch_pch: Remove some duplicate macro
      hw/intc/loongarch_pch: Set version information at initial stage
      hw/intc/loongarch_pch: Use relative address in MemoryRegionOps
      hw/intc/loongarch_pch: Discard write operation with ISR register
      hw/intc/loongarch_pch: Use generic read callback for iomem32_low region
      hw/intc/loongarch_pch: Use generic read callback for iomem32_high region
      hw/intc/loongarch_pch: Use generic read callback for iomem8 region
      hw/intc/loongarch_pch: Use generic write callback for iomem32_low region
      hw/intc/loongarch_pch: Use generic write callback for iomem32_high region
      hw/intc/loongarch_pch: Use generic write callback for iomem8 region
      hw/intc/loongarch_pch: Use unified trace event for memory region ops
      hw/intc/loongarch_pch: Rename memory region iomem32_low with iomem
      hw/intc/loongarch_pch: Set flexible memory access size with iomem region
      hw/intc/loongarch_pch: Merge three memory region into one

Xianglai Li (1):
      hw/loongarch/boot: Adjust the loading position of the initrd

 hw/intc/loongarch_pch_pic.c            | 331 +++++++++++----------------------
 hw/intc/loongarch_pic_common.c         |  13 ++
 hw/intc/trace-events                   |   8 +-
 hw/loongarch/boot.c                    |  52 +++++-
 hw/loongarch/virt.c                    |   6 -
 include/hw/intc/loongarch_pic_common.h |  57 +++---
 6 files changed, 195 insertions(+), 272 deletions(-)


