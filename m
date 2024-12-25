Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3C1E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 02:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQHK2-0007Rh-HX; Tue, 24 Dec 2024 21:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tQHK0-0007Qo-3N
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:40:28 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tQHJx-0000Y7-Jc
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 21:40:27 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Ax6+GKcGtnJkBaAA--.46007S3;
 Wed, 25 Dec 2024 10:40:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx3sWJcGtnJV0IAA--.35957S2;
 Wed, 25 Dec 2024 10:40:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 0/6] loongarch-to-apply queue
Date: Wed, 25 Dec 2024 10:40:02 +0800
Message-Id: <20241225024008.486236-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx3sWJcGtnJV0IAA--.35957S2
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

The following changes since commit aa3a285b5bc56a4208b3b57d4a55291e9c260107:

  Merge tag 'mem-2024-12-21' of https://github.com/davidhildenbrand/qemu into staging (2024-12-22 14:33:27 -0500)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20241225

for you to fetch changes up to cb91b7108cb0b3781de9a00994fe78b631d80012:

  target/loongarch: Use auto method with LASX feature (2024-12-25 10:33:20 +0800)

----------------------------------------------------------------
pull-loongarch-20241225

----------------------------------------------------------------
Bibo Mao (5):
      target/loongarch: Use actual operand size with vbsrl check
      hw/loongarch/virt: Create fdt table on machine creation done notification
      hw/loongarch/virt: Improve fdt table creation for CPU object
      target/loongarch: Use auto method with LSX feature
      target/loongarch: Use auto method with LASX feature

ghy (1):
      target/loongarch: Fix vldi inst

 hw/loongarch/virt.c                             | 142 ++++++++++++++----------
 target/loongarch/cpu.c                          |  86 ++++++++------
 target/loongarch/cpu.h                          |   4 +
 target/loongarch/kvm/kvm.c                      | 107 ++++++++++++++++++
 target/loongarch/tcg/insn_trans/trans_vec.c.inc |   4 +-
 5 files changed, 249 insertions(+), 94 deletions(-)


