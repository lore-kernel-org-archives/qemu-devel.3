Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CCAE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 06:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR3jp-0003Aj-Au; Fri, 27 Dec 2024 01:22:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tR3jj-00039b-HD
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tR3jh-0000KH-Jo
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:15 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxPOKRR25nnNlaAA--.47500S3;
 Fri, 27 Dec 2024 14:22:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8eQR25nZ54KAA--.56394S2;
 Fri, 27 Dec 2024 14:22:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL v2 0/6] loongarch-to-apply queue
Date: Fri, 27 Dec 2024 14:22:02 +0800
Message-Id: <20241227062208.1232281-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8eQR25nZ54KAA--.56394S2
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

The following changes since commit 38d0939b86e2eef6f6a622c6f1f7befda0146595:

  Merge tag 'pull-vfio-20241226' of https://github.com/legoater/qemu into staging (2024-12-26 04:38:38 -0500)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20241227

for you to fetch changes up to 5e360dabedb1ab1f15cce27a134ccbe4b8e18424:

  target/loongarch: Use auto method with LASX feature (2024-12-27 11:33:06 +0800)

----------------------------------------------------------------
pull-loongarch-20241227
v1 ... v2
  1. Modify patch auther inconsistent with SOB

----------------------------------------------------------------
Bibo Mao (5):
      target/loongarch: Use actual operand size with vbsrl check
      hw/loongarch/virt: Create fdt table on machine creation done notification
      hw/loongarch/virt: Improve fdt table creation for CPU object
      target/loongarch: Use auto method with LSX feature
      target/loongarch: Use auto method with LASX feature

Guo Hongyu (1):
      target/loongarch: Fix vldi inst

 hw/loongarch/virt.c                             | 142 ++++++++++++++----------
 target/loongarch/cpu.c                          |  86 ++++++++------
 target/loongarch/cpu.h                          |   4 +
 target/loongarch/kvm/kvm.c                      | 107 ++++++++++++++++++
 target/loongarch/tcg/insn_trans/trans_vec.c.inc |   4 +-
 5 files changed, 249 insertions(+), 94 deletions(-)


