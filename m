Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281A5C021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtcY-0003lZ-9Y; Tue, 25 Feb 2025 07:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmtcN-0003iv-IH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:00:55 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmtcI-0006Vl-FA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:00:53 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxrnLrsL1nIRaCAA--.26669S3;
 Tue, 25 Feb 2025 20:00:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfpsL1n2uMnAA--.19507S2;
 Tue, 25 Feb 2025 20:00:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 00/11] loongarch-to-apply queue
Date: Tue, 25 Feb 2025 20:00:30 +0800
Message-Id: <20250225120041.1652869-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfpsL1n2uMnAA--.19507S2
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

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://gitlab.com/bibo-mao/qemu.git tags/pull-loongarch-20250225

for you to fetch changes up to db369c11c90b35f3a6ab59ad78564aea5b30c3da:

  target/loongarch: Enable virtual extioi feature (2025-02-25 16:05:31 +0800)

----------------------------------------------------------------
pull-loongarch-20250225 queue

----------------------------------------------------------------
Bibo Mao (10):
      target/loongarch/gdbstub: Fix gdbstub incorrectly handling some registers
      target/loongarch: Correct maximum physical address in KVM mode
      target/loongarch: Add post init function for kvm mode
      target/loongarch: Move kvm specified vCPU property to kvm directory
      target/loongarch: Add vCPU property for paravirt ipi feature
      target/loongarch: Add paravirt ipi feature detection
      target/loongarch: Enable paravirt ipi feature
      target/loongarch: Add vCPU property for kvm steal time feature
      target/loongarch: Add kvm steal time feature detection
      target/loongarch: Enable virtual extioi feature

Xianglai Li (1):
      target/loongarch: fix vcpu reset command word issue

 hw/loongarch/virt.c                   |   8 --
 include/hw/loongarch/virt.h           |   9 ++
 target/loongarch/cpu.c                |  52 ++--------
 target/loongarch/cpu.h                |  13 +++
 target/loongarch/gdbstub.c            |  11 +-
 target/loongarch/kvm/kvm.c            | 186 +++++++++++++++++++++++++++++++++-
 target/loongarch/loongarch-qmp-cmds.c |   2 +-
 7 files changed, 224 insertions(+), 57 deletions(-)


