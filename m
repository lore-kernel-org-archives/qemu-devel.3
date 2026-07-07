Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A44C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5IA-0005cR-7Z; Tue, 07 Jul 2026 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wh5Hx-0005WY-3c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wh5Hr-0002NT-A8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxeeuG9kxqBe4AAA--.3961S3;
 Tue, 07 Jul 2026 20:52:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxX8eF9kxqpekDAA--.23644S2;
 Tue, 07 Jul 2026 20:52:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn,
	lixianglai@loongson.cn
Subject: [PULL 0/8] loongarch queue
Date: Tue,  7 Jul 2026 20:32:18 +0800
Message-Id: <20260707123226.25918-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX8eF9kxqpekDAA--.23644S2
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

The following changes since commit 94826ec1370328375c3b6d1e80fdc94c8f46c348:

  Merge tag 'accel-20260706' of https://github.com/philmd/qemu into staging (2026-07-06 18:38:14 +0200)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260707

for you to fetch changes up to a37dcc1bf04093d6d451b055129abde5c5e0a086:

  MAINTAINERS: add LoongArch's maintainers (2026-07-07 08:41:29 -0400)

----------------------------------------------------------------
pull-loongarch-20260707

----------------------------------------------------------------
Miao Wang (1):
      target/loongarch: Enable TARGET_PAGE_BITS_VARY for loongarch64 user-only

Song Gao (3):
      hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO write handler
      MAINTAINERS: update Song Gao's email address
      MAINTAINERS: add LoongArch's maintainers

Tao Cui (4):
      target/loongarch/kvm: fix uninitialized val and unchecked GET in cpucfg2 check
      target/loongarch/kvm: pass device attr by reference to kvm_vcpu_ioctl
      target/loongarch/kvm: remove redundant cpucfg failure traces
      target/loongarch/kvm: fix cpucfg sync error handling

 .mailmap                      |  1 +
 MAINTAINERS                   |  7 +++++--
 hw/intc/loongarch_dintc.c     | 13 ++++++++++++
 target/loongarch/cpu-param.h  |  7 ++++++-
 target/loongarch/kvm/kvm.c    | 46 ++++++++++++++++++++++++-------------------
 target/loongarch/trace-events |  2 --
 6 files changed, 51 insertions(+), 25 deletions(-)


