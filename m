Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D99CCD18D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qFx-0006fk-Mt; Thu, 09 Oct 2025 09:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v6qFm-0006Zb-S6
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v6qFd-0006fu-M9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:00:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxN9HFsedooUkUAA--.43551S3;
 Thu, 09 Oct 2025 20:59:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxG8HCsedoBqnWAA--.42888S2;
 Thu, 09 Oct 2025 20:59:46 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL  0/6] loongarch-to-apply queue
Date: Thu,  9 Oct 2025 20:35:55 +0800
Message-Id: <20251009123601.2380901-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxG8HCsedoBqnWAA--.42888S2
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

The following changes since commit 37ad0e48e9fd58b170abbf31c18a994346f62ed7:

  Merge tag 'pull-10.2-maintainer-071025-1' of https://gitlab.com/stsquad/qemu into staging (2025-10-07 08:46:28 -0700)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20251009

for you to fetch changes up to fa6af7f6bf6dbc4c83595905d2572ad86358aa67:

  target/loongarch: Define loongarch_exception_name() as static (2025-10-09 19:11:37 +0800)

----------------------------------------------------------------
pull-loongarch-20251009

----------------------------------------------------------------
Bibo Mao (3):
      target/loongarch: Move TCG specified functions to tcg_cpu.c
      target/loongarch: Move function do_raise_exception() to tcg_cpu.c
      target/loongarch: Define loongarch_exception_name() as static

Huacai Chen (3):
      bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
      hw/loongarch/virt: Align VIRT_GED_CPUHP_ADDR to 4 bytes
      tests/data/acpi/loongarch64: Update expected DSDT.*

 include/hw/loongarch/virt.h                    |   6 +-
 target/loongarch/cpu.c                         | 318 +-----------------------
 target/loongarch/internals.h                   |   4 +-
 target/loongarch/tcg/meson.build               |   1 +
 target/loongarch/tcg/tcg_cpu.c                 | 322 +++++++++++++++++++++++++
 target/loongarch/tcg/tcg_loongarch.h           |   1 +
 tests/data/acpi/loongarch64/virt/DSDT          | Bin 4603 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp    | Bin 5824 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem  | Bin 4609 -> 4609 bytes
 tests/data/acpi/loongarch64/virt/DSDT.topology | Bin 4905 -> 4905 bytes
 10 files changed, 331 insertions(+), 321 deletions(-)
 create mode 100644 target/loongarch/tcg/tcg_cpu.c


