Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CA1C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 01:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9xXc-0001f1-Fa; Wed, 22 May 2024 21:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9xXa-0001eQ-Tv
 for qemu-devel@nongnu.org; Wed, 22 May 2024 21:46:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9xXY-00012q-0J
 for qemu-devel@nongnu.org; Wed, 22 May 2024 21:46:46 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxDOv9n05mm98CAA--.6049S3;
 Thu, 23 May 2024 09:46:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMf9n05mSDMGAA--.17472S2; 
 Thu, 23 May 2024 09:46:37 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 00/10] loongarch-to-apply queue
Date: Thu, 23 May 2024 09:46:27 +0800
Message-Id: <20240523014637.614872-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDMf9n05mSDMGAA--.17472S2
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

The following changes since commit 6af8037c42fdc3d20d5aa2686799ab356a9ee1a9:

  Merge tag 'pull-vfio-20240522' of https://github.com/legoater/qemu into staging (2024-05-22 06:02:06 -0700)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240523

for you to fetch changes up to 6204af704a071ea68d3af55c0502b112a7af9546:

  hw/loongarch/virt: Fix FDT memory node address width (2024-05-23 09:30:41 +0800)

----------------------------------------------------------------
pull-loongarch-20240523

----------------------------------------------------------------
Bibo Mao (7):
      hw/loongarch: Add VM mode in IOCSR feature register in kvm mode
      hw/loongarch: Refine acpi srat table for numa memory
      hw/loongarch: Refine fadt memory table for numa memory
      hw/loongarch: Refine fwcfg memory map
      hw/loongarch: Refine system dram memory region
      hw/loongarch: Remove minimum and default memory size
      target/loongarch: Add loongarch vector property unconditionally

Jiaxun Yang (1):
      hw/loongarch/virt: Fix FDT memory node address width

Song Gao (2):
      target/loongarch/kvm: Fix VM recovery from disk failures
      target/loongarch/kvm: fpu save the vreg registers high 192bit

 hw/loongarch/acpi-build.c  |  58 +++++++++------
 hw/loongarch/virt.c        | 179 ++++++++++++++++++++++++++++++++-------------
 target/loongarch/cpu.c     |  14 +---
 target/loongarch/kvm/kvm.c |   6 ++
 target/loongarch/machine.c |   6 +-
 5 files changed, 176 insertions(+), 87 deletions(-)


