Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890FEC61DCB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzPEE-00026N-0h; Wed, 26 Aug 2026 21:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wzPEB-00025J-CO
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wzPE7-0007pJ-RU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxTtNfl49qe4YFAA--.15334S3;
 Thu, 27 Aug 2026 09:48:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx+c1dl49q1KwTAA--.16714S2;
 Thu, 27 Aug 2026 09:48:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/3] loongarch queue
Date: Thu, 27 Aug 2026 09:28:08 +0800
Message-Id: <20260827012811.1008381-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c1dl49q1KwTAA--.16714S2
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

The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:

  Merge tag 'fixes-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260826

for you to fetch changes up to dd9641cb140d6e2c297f8d87c7875409e42319b2:

  target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT (2026-08-26 21:40:19 -0400)

----------------------------------------------------------------
pull-loongarch-20260826

----------------------------------------------------------------
Bibo Mao (3):
      hw/loongarch/boot: Check memory boundary in init_boot_rom()
      hw/loongarch/virt: Add bootargs and initrd to device-tree
      target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT

 hw/loongarch/boot.c               | 68 +++++++++++++++++++++++++++++++--------
 hw/loongarch/virt-fdt-build.c     | 27 ++++++++++++++++
 target/loongarch/cpu.c            | 26 +++++++++++----
 target/loongarch/internals.h      |  1 +
 target/loongarch/tcg/csr_helper.c | 10 ++++++
 5 files changed, 113 insertions(+), 19 deletions(-)


