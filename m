Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB44C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 04:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF4KN-0007WH-My; Thu, 06 Jun 2024 00:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sF4KF-0007Tc-Cn
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:02:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sF4KC-00013X-2u
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 00:02:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxe+q0NGFm9BEEAA--.17313S3;
 Thu, 06 Jun 2024 12:01:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxVcWzNGFmgHQWAA--.45267S2; 
 Thu, 06 Jun 2024 12:01:55 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/6] loongarch-to-apply queue
Date: Thu,  6 Jun 2024 12:01:49 +0800
Message-Id: <20240606040155.2607422-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxVcWzNGFmgHQWAA--.45267S2
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

The following changes since commit db2feb2df8d19592c9859efb3f682404e0052957:

  Merge tag 'pull-misc-20240605' of https://gitlab.com/rth7680/qemu into staging (2024-06-05 14:17:01 -0700)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240606

for you to fetch changes up to 78f932ea1f7b3b9b0ac628dc2a91281318fe51fa:

  target/loongarch: fix a wrong print in cpu dump (2024-06-06 11:58:06 +0800)

----------------------------------------------------------------
pull-loongarch-20240606

----------------------------------------------------------------
Bibo Mao (2):
      tests/libqos: Add loongarch virt machine node
      tests/qtest: Add numa test for loongarch system

Song Gao (3):
      hw/intc/loongarch_extioi: Add extioi virt extension definition
      hw/loongarch/virt: Use MemTxAttrs interface for misc ops
      hw/loongarch/virt: Enable extioi virt extension

lanyanzhi (1):
      target/loongarch: fix a wrong print in cpu dump

 hw/intc/loongarch_extioi.c                  |  88 ++++++++++++-
 hw/loongarch/virt.c                         | 184 +++++++++++++++++++++++-----
 include/hw/intc/loongarch_extioi.h          |  21 ++++
 include/hw/loongarch/virt.h                 |   1 +
 target/loongarch/cpu.c                      |   2 +-
 target/loongarch/cpu.h                      |   1 +
 tests/qtest/libqos/loongarch-virt-machine.c | 114 +++++++++++++++++
 tests/qtest/libqos/meson.build              |   1 +
 tests/qtest/meson.build                     |   2 +-
 tests/qtest/numa-test.c                     |  53 ++++++++
 10 files changed, 428 insertions(+), 39 deletions(-)
 create mode 100644 tests/qtest/libqos/loongarch-virt-machine.c


