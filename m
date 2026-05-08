Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C099CD37AD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 02:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLBM4-00079K-5J; Thu, 07 May 2026 22:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wLBM1-000786-71
 for qemu-devel@nongnu.org; Thu, 07 May 2026 22:54:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wLBLy-0003qF-Aj
 for qemu-devel@nongnu.org; Thu, 07 May 2026 22:54:16 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax6HhKUP1pJcEHAA--.253S3;
 Fri, 08 May 2026 10:54:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBx68FEUP1p3qd8AA--.38421S2;
 Fri, 08 May 2026 10:53:57 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] loongarch-next queue
Date: Fri,  8 May 2026 10:27:58 +0800
Message-Id: <20260508022801.2637558-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx68FEUP1p3qd8AA--.38421S2
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

The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260508-2

for you to fetch changes up to d735016e9111e7bf0c2457556cedafd387c044a9:

  target/loongarch: Add support for dbar hint variants (2026-05-08 02:48:04 -0400)

----------------------------------------------------------------
pull-loongarch-20260508

----------------------------------------------------------------
Bibo Mao (2):
      hw/loongarch/virt: Define virt machine type with type_init()
      hw/loongarch/virt: Define versioned virt machine

Song Gao (1):
      target/loongarch: Add support for dbar hint variants

 hw/loongarch/virt.c                                | 66 +++++++++++++++++-----
 target/loongarch/cpu.c                             |  4 ++
 target/loongarch/tcg/insn_trans/trans_memory.c.inc | 63 ++++++++++++++++++++-
 target/loongarch/tcg/translate.c                   |  1 +
 target/loongarch/translate.h                       |  3 +
 5 files changed, 122 insertions(+), 15 deletions(-)


