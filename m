Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CA4C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOu9s-0004mu-SE; Tue, 10 Jun 2025 04:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOu9o-0004mf-W2
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOu9m-0000Sc-2P
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxlmnW6UdoaX0SAQ--.45731S3;
 Tue, 10 Jun 2025 16:16:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8fT6UdojgwUAQ--.58593S2;
 Tue, 10 Jun 2025 16:16:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com
Subject: [PULL 0/7] loongarch-to-apply queue
Date: Tue, 10 Jun 2025 15:53:43 +0800
Message-Id: <20250610075350.865626-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fT6UdojgwUAQ--.58593S2
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

The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:

  Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250610

for you to fetch changes up to ffe89c1762d879fd39ba1be853d154677dbfbc7b:

  hw/loongarch/virt: Remove global variables about memmap tables (2025-06-10 15:01:41 +0800)

----------------------------------------------------------------
pull-loongarch_20250610

----------------------------------------------------------------
Bibo Mao (5):
      hw/loongarch/virt: Fix big endian support with MCFG table
      hw/intc/loongarch_pch: Convert to little endian with ID register
      hw/intc/loongarch_extioi: Fix typo issue about register EXTIOI_COREISR_END
      hw/loongarch/virt: Remove global variables about initrd
      hw/loongarch/virt: Remove global variables about memmap tables

Qiang Ma (1):
      hw/loongarch/virt: inform guest of kvm

Song Gao (1):
      target/loongarch: add check for fcond

 hw/intc/loongarch_pch_pic.c                      |  2 +-
 hw/loongarch/boot.c                              | 52 +++++++++++++-----------
 hw/loongarch/virt-acpi-build.c                   |  4 +-
 hw/loongarch/virt.c                              | 27 ++++++++----
 include/hw/intc/loongarch_extioi_common.h        |  2 +-
 include/hw/loongarch/boot.h                      |  5 +--
 include/hw/loongarch/virt.h                      |  2 +
 target/loongarch/tcg/insn_trans/trans_fcmp.c.inc | 25 ++++++++----
 target/loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++++--
 9 files changed, 87 insertions(+), 48 deletions(-)


