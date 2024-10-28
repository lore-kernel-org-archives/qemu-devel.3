Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DA4D13590
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Fe9-0002Zn-DK; Sun, 27 Oct 2024 22:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5Fe5-0002Z2-Mi
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:38:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5Fe3-0002G7-JJ
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:38:17 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxG+IT+R5n7ssXAA--.49541S3;
 Mon, 28 Oct 2024 10:38:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx18AR+R5nE_sgAA--.13349S2;
 Mon, 28 Oct 2024 10:38:10 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>, kvm@vger.kernel.org
Subject: [PATCH v3 0/3] linux-headers: Update to Linux v6.12-rc5
Date: Mon, 28 Oct 2024 10:38:06 +0800
Message-Id: <20241028023809.1554405-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx18AR+R5nE_sgAA--.13349S2
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

Add unistd_64.h on arm64,loongarch and riscv platform, and update
linux headers to Linux v6.12-rc5.

Pass to compile on aarch64, arm, loongarch64, x86_64, i386, riscv64,
riscv32 softmmu and linux-user.

---
v2 ... v3:
  1. Add unistd_64.h on arm64 and riscv platform also
  2. Update header files to Linux v6.12-rc5

v1 ... v2:
  1. update header files in directory linux-headers to v6.12-rc3
---

Bibo Mao (3):
  linux-headers: Add unistd_64.h
  linux-headers: loongarch: Add kvm_para.h
  linux-headers: Update to Linux v6.12-rc5

 include/standard-headers/drm/drm_fourcc.h     |  43 +++
 include/standard-headers/linux/const.h        |  17 +
 include/standard-headers/linux/ethtool.h      | 226 ++++++++++++
 include/standard-headers/linux/fuse.h         |  22 +-
 .../linux/input-event-codes.h                 |   2 +
 include/standard-headers/linux/pci_regs.h     |  41 ++-
 .../standard-headers/linux/virtio_balloon.h   |  16 +-
 include/standard-headers/linux/virtio_gpu.h   |   1 +
 linux-headers/asm-arm64/mman.h                |   9 +
 linux-headers/asm-arm64/unistd.h              |  25 +-
 linux-headers/asm-arm64/unistd_64.h           | 324 +++++++++++++++++
 linux-headers/asm-generic/unistd.h            |   6 +-
 linux-headers/asm-loongarch/kvm.h             |  24 ++
 linux-headers/asm-loongarch/kvm_para.h        |  21 ++
 linux-headers/asm-loongarch/unistd.h          |   4 +-
 linux-headers/asm-loongarch/unistd_64.h       | 320 +++++++++++++++++
 linux-headers/asm-riscv/kvm.h                 |   7 +
 linux-headers/asm-riscv/unistd.h              |  41 +--
 linux-headers/asm-riscv/unistd_32.h           | 315 +++++++++++++++++
 linux-headers/asm-riscv/unistd_64.h           | 325 ++++++++++++++++++
 linux-headers/asm-x86/kvm.h                   |   2 +
 linux-headers/asm-x86/unistd_64.h             |   1 +
 linux-headers/asm-x86/unistd_x32.h            |   1 +
 linux-headers/linux/bits.h                    |   3 +
 linux-headers/linux/const.h                   |  17 +
 linux-headers/linux/iommufd.h                 | 143 +++++++-
 linux-headers/linux/kvm.h                     |  23 +-
 linux-headers/linux/mman.h                    |   1 +
 linux-headers/linux/psp-sev.h                 |  28 ++
 scripts/update-linux-headers.sh               |   7 +
 30 files changed, 1922 insertions(+), 93 deletions(-)
 create mode 100644 linux-headers/asm-arm64/unistd_64.h
 create mode 100644 linux-headers/asm-loongarch/kvm_para.h
 create mode 100644 linux-headers/asm-loongarch/unistd_64.h
 create mode 100644 linux-headers/asm-riscv/unistd_32.h
 create mode 100644 linux-headers/asm-riscv/unistd_64.h


base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
-- 
2.39.3


