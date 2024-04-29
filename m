Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A254DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1H3P-00069y-EJ; Sun, 28 Apr 2024 22:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s1H3K-00063L-HH
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 22:47:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s1H3I-00065i-0o
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 22:47:37 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx1OpECi9mBsUEAA--.4363S3;
 Mon, 29 Apr 2024 10:47:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxkFVECi9mp6QJAA--.7424S2; 
 Mon, 29 Apr 2024 10:47:32 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL v2 00/17] loongarch-to-apply queue
Date: Mon, 29 Apr 2024 10:30:26 +0800
Message-Id: <20240429023043.2607982-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxkFVECi9mp6QJAA--.7424S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:

  Merge tag 'accel-20240426' of https://github.com/philmd/qemu into staging (2024-04-26 15:28:13 -0700)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240429

for you to fetch changes up to 841ef2c9df5317e32de590424b0c5c36fbb4de78:

  hw/loongarch: Add cells missing from rtc node (2024-04-29 10:25:56 +0800)

----------------------------------------------------------------
Add boot LoongArch elf kernel with FDT

v2: Fix 'make check-tcg' failed.

----------------------------------------------------------------
Song Gao (17):
      hw/loongarch: Move boot functions to boot.c
      hw/loongarch: Add load initrd
      hw/loongarch: Add slave cpu boot_code
      hw/loongarch: Add init_cmdline
      hw/loongarch: Init efi_system_table
      hw/loongarch: Init efi_boot_memmap table
      hw/loongarch: Init efi_initrd table
      hw/loongarch: Init efi_fdt table
      hw/loongarch: Fix fdt memory node wrong 'reg'
      hw/loongarch: fdt adds cpu interrupt controller node
      hw/loongarch: fdt adds Extend I/O Interrupt Controller
      hw/loongarch: fdt adds pch_pic Controller
      hw/loongarch: fdt adds pch_msi Controller
      hw/loongarch: fdt adds pcie irq_map node
      hw/loongarch: fdt remove unused irqchip node
      hw/loongarch: Add cells missing from uart node
      hw/loongarch: Add cells missing from rtc node

 hw/loongarch/boot.c                | 336 ++++++++++++++++++++++++++++++++++
 hw/loongarch/meson.build           |   1 +
 hw/loongarch/virt.c                | 365 +++++++++++++++++++++----------------
 include/hw/intc/loongarch_extioi.h |   1 +
 include/hw/loongarch/boot.h        | 109 +++++++++++
 include/hw/loongarch/virt.h        |  16 ++
 include/hw/pci-host/ls7a.h         |   2 +
 target/loongarch/cpu.h             |   2 +
 8 files changed, 670 insertions(+), 162 deletions(-)
 create mode 100644 hw/loongarch/boot.c
 create mode 100644 include/hw/loongarch/boot.h


