Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09691EE57F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sojZa-0002qi-EN; Thu, 12 Sep 2024 09:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sojZO-0002oi-JQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sojZM-0004nA-1E
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:09:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxleju5+Jm0+QFAA--.12597S3;
 Thu, 12 Sep 2024 21:09:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front2 (Coremail) with SMTP id qciowMDxl8Xr5+JmR8MFAA--.9219S2;
 Thu, 12 Sep 2024 21:09:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/7] loongarch-to-apply queue
Date: Thu, 12 Sep 2024 20:51:25 +0800
Message-Id: <20240912125132.268802-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMDxl8Xr5+JmR8MFAA--.9219S2
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

The following changes since commit 4b7ea33074450bc6148c8e1545d78f179e64adb4:

  Merge tag 'pull-request-2024-09-11' of https://gitlab.com/thuth/qemu into staging (2024-09-11 19:28:23 +0100)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240912

for you to fetch changes up to 45d1fe46e5a6fe2b22b034e2b2bc0d941acd4b9e:

  hw/loongarch: Add acpi SPCR table support (2024-09-12 20:57:54 +0800)

----------------------------------------------------------------
pull-loongarch-20240912

----------------------------------------------------------------
Bibo Mao (5):
      target/loongarch: Add compatible support about VM reboot
      hw/loongarch: Remove default enable with VIRTIO_VGA device
      target/loongarch/kvm: Add vCPU reset function
      target/loongarch: Support QMP dump-guest-memory
      hw/loongarch: Add acpi SPCR table support

Jason A. Donenfeld (2):
      hw/loongarch: virt: support up to 4 serial ports
      hw/loongarch: virt: pass random seed to fdt

 hw/loongarch/Kconfig                 |   1 -
 hw/loongarch/acpi-build.c            |  63 +++++++++++--
 hw/loongarch/virt.c                  |  33 ++++---
 include/hw/pci-host/ls7a.h           |   9 +-
 target/loongarch/arch_dump.c         | 167 +++++++++++++++++++++++++++++++++++
 target/loongarch/cpu.c               |  17 +++-
 target/loongarch/internals.h         |   2 +
 target/loongarch/kvm/kvm.c           |   5 +-
 target/loongarch/kvm/kvm_loongarch.h |   2 +-
 target/loongarch/meson.build         |   1 +
 10 files changed, 274 insertions(+), 26 deletions(-)
 create mode 100644 target/loongarch/arch_dump.c


