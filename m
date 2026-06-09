Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ADCCD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtB2-0006wi-P9; Tue, 09 Jun 2026 05:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtAj-0006kJ-1B
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtAg-0004tG-As
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:00 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxJenn4idqcjUSAA--.42230S3;
 Tue, 09 Jun 2026 17:54:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S2;
 Tue, 09 Jun 2026 17:54:40 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] loongarch queue
Date: Tue,  9 Jun 2026 17:28:10 +0800
Message-Id: <20260609092824.227250-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S2
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

The following changes since commit cc329c491768b2d91eb0b0984f3baa0bf805776d:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-06-08 09:30:30 -0400)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260609

for you to fetch changes up to b653a954d427561fc563238af6b2feb8da209e41:

  target/loongarch: Add new structure CPUSysState (2026-06-09 08:37:18 -0400)

----------------------------------------------------------------
pull-loongarch-20260609

----------------------------------------------------------------
Bibo Mao (14):
      target/loongarch: Add new field curState in CPULoongArchState
      target/loongarch: Use sys_state in cpu.c when accessing CSR registers
      target/loongarch: Use sys_state in cpu_helper.c when accessing CSR registers
      target/loongarch: Use sys_state in file arch_dump.c when accessing CSR registers
      target/loongarch: Use sys_state in kvm.c when accessing CSR registers
      target/loongarch: Use sys_state in tlb_helper.c when accessing CSR registers
      target/loongarch: Use sys_state in tcg_cpu.c when accessing CSR registers
      target/loongarch: Use sys_state in csr_helper.c when accessing CSR registers
      target/loongarch: Use sys_state in op_helper.c when accessing CSR registers
      linux-user/loongarch64: Use sys_state when accessing CSR registers
      target/loongarch: Add default CSRFL_BASIC info with flags field
      target/loongarch: Add wrapper function get_csr_offset()
      target/loongarch: Add macro CSR_OFFSET and CPU_CSR_OFFSET
      target/loongarch: Add new structure CPUSysState

 hw/intc/loongarch_dintc.c                          |   4 +-
 linux-user/loongarch64/cpu_loop.c                  |   5 +-
 linux-user/loongarch64/elfload.c                   |   4 +-
 linux-user/loongarch64/signal.c                    |  16 +-
 target/loongarch/arch_dump.c                       |   5 +-
 target/loongarch/cpu-mmu.h                         |   4 +-
 target/loongarch/cpu.c                             | 120 ++++++-----
 target/loongarch/cpu.h                             |  49 +++--
 target/loongarch/cpu_helper.c                      |  41 ++--
 target/loongarch/csr.c                             |  10 +-
 target/loongarch/csr.h                             |  10 +
 target/loongarch/gdbstub.c                         |   3 +-
 target/loongarch/kvm/kvm.c                         | 228 +++++++++++----------
 target/loongarch/machine.c                         | 118 +++++------
 target/loongarch/tcg/constant_timer.c              |  10 +-
 target/loongarch/tcg/csr_helper.c                  |  55 ++---
 target/loongarch/tcg/insn_trans/trans_extra.c.inc  |   6 +-
 .../tcg/insn_trans/trans_privileged.c.inc          |  16 +-
 target/loongarch/tcg/op_helper.c                   |  45 ++--
 target/loongarch/tcg/tcg_cpu.c                     | 107 +++++-----
 target/loongarch/tcg/tlb_helper.c                  | 137 +++++++------
 21 files changed, 549 insertions(+), 444 deletions(-)


