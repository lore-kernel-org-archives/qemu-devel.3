Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F4FC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0zW-0003NH-Ce; Thu, 20 Aug 2026 07:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wx0zU-0003Ki-Cl
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:31:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wx0zR-0000W2-4t
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:31:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxhvCA5YZqmhgDAA--.9220S3;
 Thu, 20 Aug 2026 19:31:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxvM5_5YZq_N4LAA--.10909S2;
 Thu, 20 Aug 2026 19:31:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/4] loongarch queue
Date: Thu, 20 Aug 2026 19:11:05 +0800
Message-Id: <20260820111109.786405-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvM5_5YZq_N4LAA--.10909S2
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

The following changes since commit ae4f3443209ab154b48b706a146e5f557ab147cb:

  Merge tag 'qtest-20260819-pull-request' of https://gitlab.com/farosas/qemu into staging (2026-08-19 08:21:57 -0700)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260820

for you to fetch changes up to 215a4fc08f2aafce54c168cf41c64c79187430c1:

  target/loongarch: check FPE before reading fcc in bceqz/bcnez (2026-08-20 07:24:34 -0400)

----------------------------------------------------------------
pull-loongarch-20260820

----------------------------------------------------------------
Jan Mercl (1):
      target/loongarch: check FPE before reading fcc in bceqz/bcnez

Song Gao (3):
      target/loongarch: Add kvm support dintc
      Add dintc kvm_irqchip_in_kernel support
      target/loongarch: KVM disable msgint

 hw/intc/loongarch_dintc.c                          | 13 ++++
 hw/intc/loongarch_dintc_kvm.c                      | 48 ++++++++++++++
 hw/intc/meson.build                                |  2 +
 include/hw/intc/loongarch_dintc.h                  | 10 +++
 target/loongarch/cpu.c                             |  8 ++-
 target/loongarch/cpu.h                             |  1 +
 target/loongarch/kvm/kvm.c                         | 74 ++++++++++++++++++++++
 target/loongarch/tcg/insn_trans/trans_branch.c.inc |  2 +
 8 files changed, 155 insertions(+), 3 deletions(-)
 create mode 100644 hw/intc/loongarch_dintc_kvm.c


