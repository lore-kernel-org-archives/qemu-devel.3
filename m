Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79770CCF9F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 02:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEIhT-00022Z-Vq; Wed, 29 Oct 2025 22:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vEIhP-00021v-89
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 22:47:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vEIhB-0001zO-NA
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 22:47:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxB9Gq0QJpR3AcAA--.61872S3;
 Thu, 30 Oct 2025 10:47:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKn0QJpWSIbAQ--.26243S2;
 Thu, 30 Oct 2025 10:47:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] loongarch queue
Date: Thu, 30 Oct 2025 10:47:01 +0800
Message-Id: <20251030024703.3730929-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKn0QJpWSIbAQ--.26243S2
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

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20251030

for you to fetch changes up to c981119dab04ac20f86ae755a669d74fc1373cb7:

  target/loongarch: Add PTW feature support in KVM mode (2025-10-30 10:34:58 +0800)

----------------------------------------------------------------
pull-loongarch-20251030 queue

----------------------------------------------------------------
Bibo Mao (2):
      linux-headers: Update to Linux v6.18-rc3
      target/loongarch: Add PTW feature support in KVM mode

 include/standard-headers/linux/ethtool.h           |  1 +
 include/standard-headers/linux/fuse.h              | 22 ++++++++++++--
 include/standard-headers/linux/input-event-codes.h |  1 +
 include/standard-headers/linux/input.h             | 22 +++++++++++++-
 include/standard-headers/linux/pci_regs.h          | 10 +++++++
 include/standard-headers/linux/virtio_ids.h        |  1 +
 linux-headers/asm-loongarch/kvm.h                  |  1 +
 linux-headers/asm-riscv/kvm.h                      | 23 +++++++++++++-
 linux-headers/asm-riscv/ptrace.h                   |  4 +--
 linux-headers/asm-x86/kvm.h                        | 34 +++++++++++++++++++++
 linux-headers/asm-x86/unistd_64.h                  |  1 +
 linux-headers/asm-x86/unistd_x32.h                 |  1 +
 linux-headers/linux/kvm.h                          |  3 ++
 linux-headers/linux/psp-sev.h                      | 10 ++++++-
 linux-headers/linux/stddef.h                       |  1 -
 linux-headers/linux/vduse.h                        |  2 +-
 linux-headers/linux/vhost.h                        |  4 +--
 target/loongarch/cpu.c                             |  6 ++--
 target/loongarch/cpu.h                             |  1 +
 target/loongarch/kvm/kvm.c                         | 35 ++++++++++++++++++++++
 20 files changed, 169 insertions(+), 14 deletions(-)


