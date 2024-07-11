Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C7EC3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRooa-0007yV-Cq; Thu, 11 Jul 2024 04:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sRooT-0007wO-R4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:06:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sRooQ-0001uO-UL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:06:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx5Olgko9mty4DAA--.320S3;
 Thu, 11 Jul 2024 16:05:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxNMVfko9mXttDAA--.13828S2; 
 Thu, 11 Jul 2024 16:05:51 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/9] loongarch-to-apply queue
Date: Thu, 11 Jul 2024 15:48:20 +0800
Message-Id: <20240711074829.3338879-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxNMVfko9mXttDAA--.13828S2
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

The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:

  Merge tag 'pull-aspeed-20240709' of https://github.com/legoater/qemu into staging (2024-07-09 07:13:55 -0700)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240711

for you to fetch changes up to 78341408e705e1b8dc92eaae2071ae0023d586b0:

  target/loongarch: Fix cpu_reset set wrong CSR_CRMD (2024-07-11 15:56:50 +0800)

----------------------------------------------------------------
pull-loongarch-20240711

----------------------------------------------------------------
Bibo Mao (2):
      hw/loongarch/virt: Remove unused assignment
      target/loongarch/kvm: Add software breakpoint support

Dmitry Frolov (1):
      hw/loongarch/boot.c: fix out-of-bound reading

Feiyang Chen (1):
      target/loongarch: Remove avail_64 in trans_srai_w() and simplify it

Jiaxun Yang (1):
      MAINTAINERS: Add myself as a reviewer of LoongArch virt machine

Song Gao (2):
      target/loongarch: Set CSR_PRCFG1 and CSR_PRCFG2 values
      target/loongarch: Fix cpu_reset set wrong CSR_CRMD

Xianglai Li (2):
      hw/loongarch: Change the tpm support by default
      hw/loongarch: Modify flash block size to 256K

 MAINTAINERS                                       |  1 +
 configs/targets/loongarch64-softmmu.mak           |  1 +
 hw/loongarch/Kconfig                              |  1 +
 hw/loongarch/acpi-build.c                         |  3 +
 hw/loongarch/boot.c                               |  2 +-
 hw/loongarch/virt.c                               | 15 +++--
 include/hw/loongarch/virt.h                       |  2 +-
 target/loongarch/cpu.c                            | 23 ++++---
 target/loongarch/kvm/kvm.c                        | 76 +++++++++++++++++++++++
 target/loongarch/tcg/insn_trans/trans_shift.c.inc | 15 +----
 10 files changed, 109 insertions(+), 30 deletions(-)


