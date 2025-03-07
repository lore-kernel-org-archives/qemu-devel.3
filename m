Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083B5C282EC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqNeN-0007TP-PM; Thu, 06 Mar 2025 21:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tqNeL-0007Sj-Hl
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:41:21 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tqNeJ-0006iN-En
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 21:41:21 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx12nCXMpnSAaNAA--.44464S3;
 Fri, 07 Mar 2025 10:41:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxLsfAXMpnQro6AA--.23941S2;
 Fri, 07 Mar 2025 10:41:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 0/2] loongarch tcg queue
Date: Fri,  7 Mar 2025 10:19:32 +0800
Message-Id: <20250307021934.1080115-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfAXMpnQro6AA--.23941S2
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

The following changes since commit e8a01102936286e012ed0f00bd7f3b7474d415c9:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-03-05 21:58:23 +0800)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20250307

for you to fetch changes up to d882c284a3d4472d827e49a7357198b611900b08:

  target/loongarch: check tlb_ps (2025-03-07 10:15:08 +0800)

----------------------------------------------------------------
 pull-loongarch-tcg-20250307

----------------------------------------------------------------
Song Gao (2):
      target/loongarch: fix 'make check-functional' failed
      target/loongarch: check tlb_ps

 target/loongarch/cpu.c                             | 11 +++++--
 target/loongarch/helper.h                          |  1 +
 target/loongarch/internals.h                       |  2 ++
 target/loongarch/tcg/csr_helper.c                  | 26 ++++++++++++++--
 .../tcg/insn_trans/trans_privileged.c.inc          |  1 +
 target/loongarch/tcg/tlb_helper.c                  | 35 ++++++++++++++++++++--
 6 files changed, 68 insertions(+), 8 deletions(-)


