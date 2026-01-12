Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809FED2503C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 07:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfC3H-0007pl-82; Mon, 12 Jan 2026 02:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vfC3E-0007nO-C5
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:09:20 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vfC3B-0004pt-7t
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:09:20 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxrsMUnmRpf8YHAA--.25448S3;
 Mon, 12 Jan 2026 15:09:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxacERnmRpEqgaAA--.41358S2;
 Mon, 12 Jan 2026 15:09:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] loongarch queue
Date: Mon, 12 Jan 2026 15:08:54 +0800
Message-Id: <20260112070904.3230440-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxacERnmRpEqgaAA--.41358S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:

  Merge tag 'pull-riscv-to-apply-20260109' of https://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20260112

for you to fetch changes up to 1a8d5e95d70ab1bdbc2a39065e9864f4201e519f:

  hw/loongarch/virt: Add property highmem-mmio-size with virt machine (2026-01-12 14:58:01 +0800)

----------------------------------------------------------------
pull-loongarch-20260112 queue

----------------------------------------------------------------
Bibo Mao (10):
      target/loongarch: Add PMU migration support in KVM mode
      target/loongarch: Call function loongarch_la464_init_csr() after realized
      target/loongarch: Add PMU register dump support in KVM
      hw/loongarch/virt: Add field ram_end in LoongArchVirtMachineState
      hw/loongarch/virt: Add field gpex in LoongArchVirtMachineState
      hw/loongarch/virt: Get irq number from gpex config info
      hw/loongarch/virt: Get PCI info from gpex config info
      hw/loongarch/virt: Add property highmem_mmio with virt machine
      hw/loongarch/virt: Add high MMIO support with GPEX host
      hw/loongarch/virt: Add property highmem-mmio-size with virt machine

 hw/loongarch/virt-acpi-build.c |  17 +---
 hw/loongarch/virt-fdt-build.c  |  43 +++++++---
 hw/loongarch/virt.c            | 175 ++++++++++++++++++++++++++++++++++++++---
 include/hw/loongarch/virt.h    |   5 +-
 target/loongarch/cpu-csr.h     |   4 +
 target/loongarch/cpu.c         |  11 ++-
 target/loongarch/cpu.h         |   4 +
 target/loongarch/csr.c         |  32 ++++++++
 target/loongarch/kvm/kvm.c     |  54 ++++++++++++-
 target/loongarch/machine.c     |  21 +++++
 10 files changed, 322 insertions(+), 44 deletions(-)


