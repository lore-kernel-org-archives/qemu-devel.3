Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474C606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrKv-0006xV-Gy; Thu, 05 Nov 2026 01:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrKs-0006x9-Nk
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xOrKq-0000mV-A4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:34 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxQNGnJ+xqTY8cAA--.17840S3;
 Thu, 05 Nov 2026 14:52:24 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxnM6dJ+xq+IEyAA--.17797S2;
 Thu, 05 Nov 2026 14:52:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] pull-loongarch-20261105 queue
Date: Thu,  5 Nov 2026 14:53:32 +0800
Message-ID: <20261105065345.966691-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxnM6dJ+xq+IEyAA--.17797S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy5XF13XFWDCF4DArW3twc_yoW5Xr13pr
 y3CrnxtF48GFZrJFn3X345Xrn8Jrn7CF42q3WxtryxCF45Ar1UZr18t3s2gFyUJ348Wry0
 qr1rCw1UWF1UX3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5:

  Merge tag 'pull-11.2-misc-fixes-031126-1' of https://gitlab.com/stsquad/qemu into staging (2026-11-03 14:44:10 -0800)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20261105

for you to fetch changes up to 07a4c09e4c1c9de78b3ee287b3ac7b5badc0277b:

  target/loongarch: Clear PAGE_READ when PTE.NR is set (2026-11-05 14:50:32 +0800)

----------------------------------------------------------------
pull-loongarch-20261105 queue

----------------------------------------------------------------
Bibo Mao (8):
      target/loongarch: Replace sys_state with vm_level
      target/loongarch: Fix memory access address with fldle
      target/loongarch: Replace kvm_cpu_has_msgint() with cpu_has_msgint()
      target/loongarch: Check CPU msgint feature with cpu_has_msgint()
      target/loongarch: Add asrtle_du()/asrtgt_du() helpers
      target/loongarch: Change asrtle_d()/asrtgt_d() for signed integer comparison
      target/loongarch: Support unaligned access for atomic instructions
      target/loongarch: Clear PAGE_READ when PTE.NR is set

pillow (5):
      bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
      hw/loongarch/virt-acpi-build: Drop invalid _DSD UART clock property
      hw/loongarch/virt-acpi-build: Drop UART _CCA declaration
      hw/loongarch/virt: Fix UART clock frequency in FDT
      tests/data/acpi/loongarch64: Update expected DSDT.*

 hw/loongarch/virt-acpi-build.c                     |  11 -----------
 hw/loongarch/virt-fdt-build.c                      |   2 +-
 hw/loongarch/virt.c                                |   4 ++--
 target/loongarch/cpu.c                             |   4 +++-
 target/loongarch/cpu.h                             |  16 +++++++++++----
 target/loongarch/cpu_helper.c                      |   5 ++++-
 target/loongarch/kvm/kvm.c                         |  11 ++---------
 target/loongarch/machine.c                         |   2 +-
 target/loongarch/tcg/helper.h                      |   2 ++
 .../loongarch/tcg/insn_trans/trans_fmemory.c.inc   |  16 +++++++--------
 target/loongarch/tcg/insn_trans/trans_memory.c.inc |   8 ++++----
 target/loongarch/tcg/op_helper.c                   |  22 ++++++++++++++++++++-
 target/loongarch/tcg/tcg_cpu.c                     |   2 ++
 target/loongarch/tcg/tcg_loongarch.h               |   4 ++++
 target/loongarch/tcg/tlb_helper.c                  |  16 +++++++++++++++
 tests/data/acpi/loongarch64/virt/DSDT              | Bin 4603 -> 4351 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp        | Bin 5824 -> 5572 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem      | Bin 4609 -> 4357 bytes
 tests/data/acpi/loongarch64/virt/DSDT.topology     | Bin 4905 -> 4653 bytes
 19 files changed, 82 insertions(+), 43 deletions(-)


