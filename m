Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A1EE9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 02:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpduz-0002SW-S4; Mon, 09 Feb 2026 21:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vpduy-0002RG-CS
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:56:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vpduu-0003wO-Nl
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:56:00 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxCMIxnoppd0oRAA--.42637S3;
 Tue, 10 Feb 2026 10:55:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxD8Mtnoppm59DAA--.61278S2;
 Tue, 10 Feb 2026 10:55:41 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] loongarch-to-apply queue
Date: Tue, 10 Feb 2026 10:30:33 +0800
Message-Id: <20260210023040.3507338-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxD8Mtnoppm59DAA--.61278S2
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

The following changes since commit c4a9d49c7b23a02c646ebac756519c15a24f7ecc:

  Merge tag 'pull-9p-20260207' of https://github.com/cschoenebeck/qemu into staging (2026-02-07 17:46:15 +0000)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260210

for you to fetch changes up to 59c8adc2830342c2cff5fe8867191d0e166abb29:

  target/loongarch: Add LA v1.1 instructions to max cpu (2026-02-10 10:48:20 +0800)

----------------------------------------------------------------
pull-loongarch-2026-02-10

----------------------------------------------------------------
Jiajie Chen (7):
      target/loongarch: Require atomics to be aligned
      target/loongarch: Add am{swap/add}[_db].{b/h}
      target/loongarch: Add amcas[_db].{b/h/w/d}
      target/loongarch: Add estimated reciprocal instructions
      target/loongarch: Add llacq/screl instructions
      target/loongarch: Add sc.q instructions
      target/loongarch: Add LA v1.1 instructions to max cpu

 target/loongarch/cpu.c                             |  11 +-
 target/loongarch/cpu.h                             |   7 +
 target/loongarch/disas.c                           |  33 +++++
 target/loongarch/insns.decode                      |  34 +++++
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 145 +++++++++++++++++++--
 target/loongarch/tcg/insn_trans/trans_farith.c.inc |   4 +
 target/loongarch/tcg/insn_trans/trans_memory.c.inc |  22 ++++
 target/loongarch/tcg/insn_trans/trans_vec.c.inc    |   8 ++
 target/loongarch/tcg/translate.c                   |   6 +-
 target/loongarch/translate.h                       |  30 +++--
 10 files changed, 280 insertions(+), 20 deletions(-)


