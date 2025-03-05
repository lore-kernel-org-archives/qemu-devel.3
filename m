Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6D9C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpi08-0000nU-J5; Wed, 05 Mar 2025 01:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tpi05-0000mQ-EU
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:01 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tpi01-0004Fp-TD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:01 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxC3Jk68dntN+KAA--.41010S3;
 Wed, 05 Mar 2025 14:12:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MRi68dnfRQ3AA--.5679S2;
 Wed, 05 Mar 2025 14:12:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 00/15] loongarch-to-apply queue
Date: Wed,  5 Mar 2025 14:12:35 +0800
Message-Id: <20250305061250.1908444-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MRi68dnfRQ3AA--.5679S2
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

The following changes since commit 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56:

  scripts/checkpatch: Fix a typo (2025-03-04 09:30:26 +0800)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20250305

for you to fetch changes up to 0a629c827300d514cc1f61806414d214fcf75051:

  target/loongarch: Adjust the cpu reset action to a proper position (2025-03-05 09:45:52 +0800)

----------------------------------------------------------------
pull-loongarch-20250305 queue

----------------------------------------------------------------
Bibo Mao (14):
      hw/intc/loongarch_ipi: Add basic hotplug framework
      hw/intc/loongarch_ipi: Implment cpu hotplug interface
      hw/intc/loongarch_ipi: Notify ipi object when cpu is plugged
      hw/intc/loongarch_extioi: Move gpio irq initial to common code
      hw/intc/loongarch_extioi: Add basic hotplug framework
      hw/intc/loongarch_extioi: Implment cpu hotplug interface
      hw/intc/loongarch_extioi: Use cpu plug notification
      hw/loongarch/virt: Add CPU topology support
      hw/loongarch/virt: Add topo properties on CPU object
      hw/loongarch/virt: Add basic cpu plug interface framework
      hw/loongarch/virt: Implement cpu unplug interface
      hw/loongarch/virt: Implement cpu plug interface
      hw/loongarch/virt: Update the ACPI table for hotplug cpu
      hw/loongarch/virt: Enable cpu hotplug feature on virt machine

Xianglai Li (1):
      target/loongarch: Adjust the cpu reset action to a proper position

 hw/intc/loongarch_extioi.c        |   8 +-
 hw/intc/loongarch_extioi_common.c |  84 ++++++++++-
 hw/intc/loongarch_ipi.c           |  71 +++++++++
 hw/loongarch/Kconfig              |   1 +
 hw/loongarch/virt-acpi-build.c    |  35 ++++-
 hw/loongarch/virt.c               | 301 ++++++++++++++++++++++++++++++++++----
 include/hw/loongarch/virt.h       |   1 +
 target/loongarch/cpu.c            |  25 +++-
 target/loongarch/cpu.h            |  11 ++
 9 files changed, 493 insertions(+), 44 deletions(-)


