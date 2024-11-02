Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76B4E677F0
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 08:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t799B-0007L6-AW; Sat, 02 Nov 2024 04:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t7998-0007J3-D4
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t7994-0001yy-Ht
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxTOJm3SVnUn0nAA--.14339S3;
 Sat, 02 Nov 2024 16:05:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAx7uBh3SVnzZA1AA--.18827S2;
 Sat, 02 Nov 2024 16:05:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL v2 0/8] loongarch-to-apply queue
Date: Sat,  2 Nov 2024 15:47:29 +0800
Message-Id: <20241102074737.1394884-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7uBh3SVnzZA1AA--.18827S2
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

The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:

  Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20241102

for you to fetch changes up to 47b54e15bbe78722c62dfafc3e04deded820c05e:

  target/loongarch: Add steal time support on migration (2024-11-02 15:45:45 +0800)

----------------------------------------------------------------
pull-loongarch-20241102

V2: Fix no 'asm/unistd_64.h' build error.
    Add a new patch (hw/loongarch/boot: Use warn_report when no kernel filename).
----------------------------------------------------------------
Bibo Mao (7):
      target/loongarch: Add loongson binary translation feature
      target/loongarch: Implement lbt registers save/restore function
      target/loongarch/kvm: Implement LoongArch PMU extension
      linux-headers: Add unistd_64.h
      linux-headers: loongarch: Add kvm_para.h
      linux-headers: Update to Linux v6.12-rc5
      target/loongarch: Add steal time support on migration

Song Gao (1):
      hw/loongarch/boot: Use warn_report when no kernel filename

 hw/loongarch/boot.c                                |   5 +-
 include/standard-headers/drm/drm_fourcc.h          |  43 +++
 include/standard-headers/linux/const.h             |  17 ++
 include/standard-headers/linux/ethtool.h           | 226 ++++++++++++++
 include/standard-headers/linux/fuse.h              |  22 +-
 include/standard-headers/linux/input-event-codes.h |   2 +
 include/standard-headers/linux/pci_regs.h          |  41 ++-
 include/standard-headers/linux/virtio_balloon.h    |  16 +-
 include/standard-headers/linux/virtio_gpu.h        |   1 +
 linux-headers/asm-arm64/mman.h                     |   9 +
 linux-headers/asm-arm64/unistd.h                   |  25 +-
 linux-headers/asm-arm64/unistd_64.h                | 324 ++++++++++++++++++++
 linux-headers/asm-generic/unistd.h                 |   6 +-
 linux-headers/asm-loongarch/kvm.h                  |  24 ++
 linux-headers/asm-loongarch/kvm_para.h             |  21 ++
 linux-headers/asm-loongarch/unistd.h               |   4 +-
 linux-headers/asm-loongarch/unistd_64.h            | 320 ++++++++++++++++++++
 linux-headers/asm-riscv/kvm.h                      |   7 +
 linux-headers/asm-riscv/unistd.h                   |  41 +--
 linux-headers/asm-riscv/unistd_32.h                | 315 ++++++++++++++++++++
 linux-headers/asm-riscv/unistd_64.h                | 325 +++++++++++++++++++++
 linux-headers/asm-x86/kvm.h                        |   2 +
 linux-headers/asm-x86/unistd_64.h                  |   1 +
 linux-headers/asm-x86/unistd_x32.h                 |   1 +
 linux-headers/linux/bits.h                         |   3 +
 linux-headers/linux/const.h                        |  17 ++
 linux-headers/linux/iommufd.h                      | 143 +++++++--
 linux-headers/linux/kvm.h                          |  23 +-
 linux-headers/linux/mman.h                         |   1 +
 linux-headers/linux/psp-sev.h                      |  28 ++
 scripts/update-linux-headers.sh                    |   7 +
 target/loongarch/cpu.c                             |  43 +++
 target/loongarch/cpu.h                             |  23 ++
 target/loongarch/kvm/kvm.c                         | 225 +++++++++++++-
 target/loongarch/loongarch-qmp-cmds.c              |   2 +-
 target/loongarch/machine.c                         |  30 +-
 36 files changed, 2243 insertions(+), 100 deletions(-)
 create mode 100644 linux-headers/asm-arm64/unistd_64.h
 create mode 100644 linux-headers/asm-loongarch/kvm_para.h
 create mode 100644 linux-headers/asm-loongarch/unistd_64.h
 create mode 100644 linux-headers/asm-riscv/unistd_32.h
 create mode 100644 linux-headers/asm-riscv/unistd_64.h


