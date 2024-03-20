Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C74CD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 02:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmlsQ-0003If-6Q; Tue, 19 Mar 2024 22:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rmlsL-0003Ha-M7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:40:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rmlsI-0005yt-Sg
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 22:40:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxfeuMTPpltA4bAA--.64496S3;
 Wed, 20 Mar 2024 10:40:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfROLTPplkAFeAA--.18372S2; 
 Wed, 20 Mar 2024 10:40:11 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/3] loongarch fixes for 9.0
Date: Wed, 20 Mar 2024 10:40:07 +0800
Message-Id: <20240320024010.1659193-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfROLTPplkAFeAA--.18372S2
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

The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33fa7:

  Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240320

for you to fetch changes up to 77642f92c0b71a105aba2a4d03bc62328eae703b:

  target/loongarch: Fix qemu-loongarch64 hang when executing 'll.d $t0, $t0, 0' (2024-03-20 10:20:08 +0800)

----------------------------------------------------------------
pull-loongarch-20240320

----------------------------------------------------------------
Bibo Mao (1):
      hw/intc/loongarch_extioi: Fix interrupt routing update

Song Gao (1):
      target/loongarch: Fix qemu-loongarch64 hang when executing 'll.d $t0, $t0, 0'

Xianglai Li (1):
      target/loongarch: Fix tlb huge page loading issue

 hw/intc/loongarch_extioi.c                         |   2 +-
 target/loongarch/cpu-csr.h                         |   3 +
 target/loongarch/internals.h                       |   5 -
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc |   8 +-
 target/loongarch/tcg/tlb_helper.c                  | 113 ++++++++++++++-------
 5 files changed, 87 insertions(+), 44 deletions(-)


