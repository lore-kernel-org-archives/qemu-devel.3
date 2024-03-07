Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5360DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riF6n-0000QD-Oc; Thu, 07 Mar 2024 09:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riF6l-0000Ou-N3
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riF6h-0003NH-FV
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:31 -0500
Received: from loongson.cn (unknown [43.156.43.207])
 by gateway (Coremail) with SMTP id _____8BxefCc1OllzfMVAA--.55516S3;
 Thu, 07 Mar 2024 22:52:13 +0800 (CST)
Received: from VM-4-14-ubuntu.. (unknown [43.156.43.207])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs2Y1OllbElQAA--.15045S2; 
 Thu, 07 Mar 2024 22:52:10 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 00/17] loongarch-to-apply queue
Date: Thu,  7 Mar 2024 22:51:50 +0800
Message-Id: <20240307145207.247913-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs2Y1OllbElQAA--.15045S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ary8uw17Kry7GFW7GryfGrX_yoW8Zryfpr
 W3Ar13Cr48Ga9rJrn3J3sxXr98Arn7Gr12qa13tr18ArW7Ar1UZr1xArykZFyUJ348Jryq
 vr1Fkw1jgF4UJwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:

  Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240307

for you to fetch changes up to 4dc2edfd6f8abfc38f0ba110502790aa5051b1b5:

  hw/loongarch: Add cells missing from rtc node (2024-03-07 21:58:00 +0800)

----------------------------------------------------------------
pull-loongarch-20240307

----------------------------------------------------------------
Song Gao (17):
      hw/loongarch: Move boot fucntions to boot.c
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

 hw/loongarch/boot.c                | 330 +++++++++++++++++++++++++++++++++
 hw/loongarch/meson.build           |   1 +
 hw/loongarch/virt.c                | 363 +++++++++++++++++++++----------------
 include/hw/intc/loongarch_extioi.h |   1 +
 include/hw/loongarch/boot.h        | 109 +++++++++++
 include/hw/loongarch/virt.h        |  14 ++
 include/hw/pci-host/ls7a.h         |   2 +
 target/loongarch/cpu.h             |   2 +
 8 files changed, 662 insertions(+), 160 deletions(-)
 create mode 100644 hw/loongarch/boot.c
 create mode 100644 include/hw/loongarch/boot.h


