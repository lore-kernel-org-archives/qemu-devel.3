Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB3AC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 07:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua7x3-0002l9-KY; Fri, 11 Jul 2025 03:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ua7we-0002Zy-2e
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:13:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ua7wZ-000452-W6
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:13:19 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxHHKBuXBo8QUnAQ--.16898S3;
 Fri, 11 Jul 2025 15:13:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+R_uXBoo28SAA--.39054S2;
 Fri, 11 Jul 2025 15:13:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL v2 0/4] loongarch-to-apply queue
Date: Fri, 11 Jul 2025 15:12:58 +0800
Message-Id: <20250711071302.742014-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+R_uXBoo28SAA--.39054S2
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

The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba336:

  Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging (2025-07-07 09:22:41 -0400)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250711

for you to fetch changes up to 94c874f0f2bdc048bacf9873d8d9ee9a68d44ea5:

  target/loongarch: Remove unnecessary page size validity checking (2025-07-11 14:47:15 +0800)

----------------------------------------------------------------
pull-loongarch-20250711 queue

----------------------------------------------------------------
Bibo Mao (4):
      hw/intc/loongarch_extioi: Move unrealize function to common code
      target/loongarch: Correct spelling in helper_csrwr_pwcl()
      target/loongarch: Fix CSR STLBPS register write emulation
      target/loongarch: Remove unnecessary page size validity checking

 hw/intc/loongarch_extioi.c                |  9 ---------
 hw/intc/loongarch_extioi_common.c         |  9 +++++++++
 include/hw/intc/loongarch_extioi.h        |  1 -
 include/hw/intc/loongarch_extioi_common.h |  1 +
 target/loongarch/tcg/csr_helper.c         |  8 ++++++--
 target/loongarch/tcg/tlb_helper.c         | 27 ++++++++++-----------------
 6 files changed, 26 insertions(+), 29 deletions(-)


