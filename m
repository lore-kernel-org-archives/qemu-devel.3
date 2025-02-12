Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86160C0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3FA-0000gG-EB; Tue, 11 Feb 2025 22:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ti3F7-0000ep-D6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:53 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ti3F0-00016q-3w
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:53 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxjayTEqxnbMhyAA--.36155S3;
 Wed, 12 Feb 2025 11:16:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPseSEqxnkg0NAA--.51828S2;
 Wed, 12 Feb 2025 11:16:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 0/6] loongarch-to-apply queue
Date: Wed, 12 Feb 2025 11:16:27 +0800
Message-Id: <20250212031633.3548108-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPseSEqxnkg0NAA--.51828S2
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

The following changes since commit ffaf7f0376f8040ce9068d71ae9ae8722505c42e:

  Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging (2025-02-10 13:26:17 -0500)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20250212

for you to fetch changes up to 456739ce4347c21b6fa2ec1b6585bc4a6504446f:

  hw/loongarch/virt: CPU irq line connection improvement (2025-02-12 10:05:22 +0800)

----------------------------------------------------------------
pull-loongarch-20250212 queue

----------------------------------------------------------------
Bibo Mao (6):
      hw/loongarch/virt: Rename filename acpi-build with virt-acpi-build
      hw/loongarch/virt: Rename function prefix name
      hw/loongarch/virt: Add separate file for fdt building
      hw/loongarch/virt: Set iocsr address space when CPU is created
      hw/loongarch/virt: Remove unused ipistate
      hw/loongarch/virt: CPU irq line connection improvement

 hw/loongarch/meson.build                         |   6 +-
 hw/loongarch/{acpi-build.c => virt-acpi-build.c} |   6 +-
 hw/loongarch/virt-fdt-build.c                    | 535 ++++++++++++++++++++
 hw/loongarch/virt.c                              | 593 ++---------------------
 include/hw/loongarch/virt.h                      |   5 +-
 target/loongarch/cpu.h                           |   2 -
 6 files changed, 584 insertions(+), 563 deletions(-)
 rename hw/loongarch/{acpi-build.c => virt-acpi-build.c} (99%)
 create mode 100644 hw/loongarch/virt-fdt-build.c


