Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7240CCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEM-000795-6v; Thu, 28 Aug 2025 13:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1urbhT-000262-Ju; Thu, 28 Aug 2025 08:25:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1urbhP-0002jm-JS; Thu, 28 Aug 2025 08:25:55 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxvr_DSrBo2S8EAA--.7394S3;
 Thu, 28 Aug 2025 20:25:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxT+bCSrBoy2RuAA--.14734S2;
 Thu, 28 Aug 2025 20:25:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 0/2] loongarch-to-apply queue
Date: Thu, 28 Aug 2025 20:02:16 +0800
Message-Id: <20250828120218.1227427-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxT+bCSrBoy2RuAA--.14734S2
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit ca18b336e12c8433177a3cd639c5bf757952adaa:

  Merge tag 'pull-lu-20250828' of https://gitlab.com/rth7680/qemu into staging (2025-08-28 09:24:36 +1000)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250828

for you to fetch changes up to 86bca40402316891b8b9a920c2e3bf8cf37ba9a4:

  hw/intc/loongarch_pch_pic: Fix ubsan warning and endianness issue (2025-08-28 20:06:27 +0800)

----------------------------------------------------------------
pull-loongarch-20250828

----------------------------------------------------------------
Thomas Huth (1):
      hw/intc/loongarch_pch_pic: Fix ubsan warning and endianness issue

WANG Rui (1):
      target/loongarch: Guard 64-bit-only insn translation with TRANS64 macro

 hw/intc/loongarch_pch_pic.c                        | 15 ++++-----
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 36 +++++++++++-----------
 target/loongarch/tcg/insn_trans/trans_extra.c.inc  |  8 +++--
 target/loongarch/tcg/insn_trans/trans_farith.c.inc |  8 ++---
 target/loongarch/tcg/insn_trans/trans_fcnv.c.inc   |  4 +--
 .../loongarch/tcg/insn_trans/trans_fmemory.c.inc   | 16 +++++-----
 .../tcg/insn_trans/trans_privileged.c.inc          |  4 +--
 target/loongarch/tcg/insn_trans/trans_shift.c.inc  |  4 +--
 target/loongarch/translate.h                       |  4 +++
 9 files changed, 54 insertions(+), 45 deletions(-)


