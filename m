Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE9ACAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 09:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2o0s-0001d6-4e; Sun, 28 Sep 2025 05:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v2o0o-0001cp-PM
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v2o0g-0006QV-H9
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxidFHBNlofM4PAA--.33264S3;
 Sun, 28 Sep 2025 17:47:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDx_8NCBNloMpa5AA--.63673S2;
 Sun, 28 Sep 2025 17:47:47 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/11] loongarch-to-apply queue
Date: Sun, 28 Sep 2025 17:23:57 +0800
Message-Id: <20250928092408.948035-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8NCBNloMpa5AA--.63673S2
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

The following changes since commit d6dfd8d40cebebc3378d379cd28879e0345fbf91:

  Merge tag 'pull-target-arm-20250926' of https://gitlab.com/pm215/qemu into staging (2025-09-26 13:27:01 -0700)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250928

for you to fetch changes up to 7470657ec157d4526752147165b2d368e2c7002e:

  hw/loongarch: Implement DINTC plug/unplug interfaces (2025-09-28 17:31:04 +0800)

----------------------------------------------------------------
pull-loongarch-20250928

v2: fix build win64 errors.

----------------------------------------------------------------
Song Gao (11):
      target/loongarch: move some machine define to virt.h
      hw/loongarch: add virt feature dmsi support
      hw/loongarch: add misc register support dmsi
      loongarch: add a direct interrupt controller device
      target/loongarch: add msg interrupt CSR registers
      hw/loongarch: DINTC add a MemoryRegion
      hw/loongarch: Implement dintc realize and unrealize
      hw/loongarch: Implement dintc set irq
      target/loongarch: Add CSR_ESTAT.bit15 and CSR_ECFG.bit15 for msg interrupts.
      target/loongarch:Implement csrrd CSR_MSGIR register
      hw/loongarch: Implement DINTC plug/unplug interfaces

 hw/intc/Kconfig                                    |   3 +
 hw/intc/loongarch_dintc.c                          | 212 +++++++++++++++++++++
 hw/intc/meson.build                                |   1 +
 hw/loongarch/Kconfig                               |   1 +
 hw/loongarch/virt.c                                | 110 ++++++++++-
 include/hw/intc/loongarch_dintc.h                  |  36 ++++
 include/hw/loongarch/virt.h                        |  34 ++++
 include/hw/pci-host/ls7a.h                         |   2 +
 target/loongarch/cpu-csr.h                         |   9 +-
 target/loongarch/cpu.c                             |  29 +++
 target/loongarch/cpu.h                             |  36 ++--
 target/loongarch/csr.c                             |   5 +
 target/loongarch/machine.c                         |  25 ++-
 target/loongarch/tcg/csr_helper.c                  |  21 ++
 target/loongarch/tcg/helper.h                      |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc          |   1 +
 16 files changed, 499 insertions(+), 27 deletions(-)
 create mode 100644 hw/intc/loongarch_dintc.c
 create mode 100644 include/hw/intc/loongarch_dintc.h


