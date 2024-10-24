Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4795D0BB7F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uOj-00044H-By; Thu, 24 Oct 2024 05:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t3uOh-00043r-Qp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:44:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t3uOe-0002Yn-Oa
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:44:51 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxuuAFFxpnAG4KAA--.24357S3;
 Thu, 24 Oct 2024 17:44:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxPMICFxpnHi0PAA--.1186S2;
 Thu, 24 Oct 2024 17:44:34 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/6] loongarch-to-apply queue
Date: Thu, 24 Oct 2024 17:26:19 +0800
Message-Id: <20241024092626.1328049-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPMICFxpnHi0PAA--.1186S2
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

The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:

  Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20241024

for you to fetch changes up to c44e0d6ba280dcc6bdf4ed555020c61d564b526c:

  target/loongarch: Add steal time support on migration (2024-10-24 17:27:55 +0800)

----------------------------------------------------------------
pull-loongarch-20241024

----------------------------------------------------------------
Bibo Mao (6):
      target/loongarch: Add loongson binary translation feature
      target/loongarch: Implement lbt registers save/restore function
      target/loongarch/kvm: Implement LoongArch PMU extension
      linux-headers: loongarch: Add kvm_para.h and unistd_64.h
      linux-headers: Update to Linux v6.12-rc3
      target/loongarch: Add steal time support on migration

 include/standard-headers/drm/drm_fourcc.h          |  43 +++
 include/standard-headers/linux/const.h             |  17 ++
 include/standard-headers/linux/ethtool.h           | 226 +++++++++++++++
 include/standard-headers/linux/fuse.h              |  22 +-
 include/standard-headers/linux/input-event-codes.h |   2 +
 include/standard-headers/linux/pci_regs.h          |  41 ++-
 include/standard-headers/linux/virtio_balloon.h    |  16 +-
 include/standard-headers/linux/virtio_gpu.h        |   1 +
 linux-headers/asm-arm64/mman.h                     |   9 +
 linux-headers/asm-arm64/unistd.h                   |  25 +-
 linux-headers/asm-generic/unistd.h                 |   6 +-
 linux-headers/asm-loongarch/kvm.h                  |  24 ++
 linux-headers/asm-loongarch/kvm_para.h             |  21 ++
 linux-headers/asm-loongarch/unistd.h               |   4 +-
 linux-headers/asm-loongarch/unistd_64.h            | 320 +++++++++++++++++++++
 linux-headers/asm-riscv/kvm.h                      |   7 +
 linux-headers/asm-riscv/unistd.h                   |  41 +--
 linux-headers/asm-x86/kvm.h                        |   2 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/bits.h                         |   3 +
 linux-headers/linux/const.h                        |  17 ++
 linux-headers/linux/iommufd.h                      | 143 +++++++--
 linux-headers/linux/kvm.h                          |  23 +-
 linux-headers/linux/mman.h                         |   1 +
 linux-headers/linux/psp-sev.h                      |  28 ++
 scripts/update-linux-headers.sh                    |   4 +
 target/loongarch/cpu.c                             |  43 +++
 target/loongarch/cpu.h                             |  23 ++
 target/loongarch/kvm/kvm.c                         | 225 ++++++++++++++-
 target/loongarch/loongarch-qmp-cmds.c              |   2 +-
 target/loongarch/machine.c                         |  30 +-
 32 files changed, 1274 insertions(+), 97 deletions(-)
 create mode 100644 linux-headers/asm-loongarch/kvm_para.h
 create mode 100644 linux-headers/asm-loongarch/unistd_64.h


