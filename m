Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1340C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 19:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZDrn-0008SG-1f; Tue, 08 Jul 2025 15:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZBMH-0005uM-2H
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:40:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZBLh-0004UL-EW
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 12:39:34 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxjXIRBm1ohF0kAQ--.12598S3;
 Tue, 08 Jul 2025 19:50:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxQ+QQBm1oiVEOAA--.17600S2;
 Tue, 08 Jul 2025 19:50:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/loongarch: Enhancement about tcg mmu
Date: Tue,  8 Jul 2025 19:50:33 +0800
Message-Id: <20250708115039.2724551-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+QQBm1oiVEOAA--.17600S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

There is some enhance about LoongArch mmu tcg emulation, add new
header file cpu-mmu.h and function loongarch_check_pte(). Function
loongarch_check_pte() can work on both TLB entry and pte entry.

This patchset mainly is code cleanup and enhancement, its main
purpose is to work for hardware page table walk emluation in future.

Bibo Mao (6):
  target/loongarch: Move some function definition to kvm directory
  target/loongarch: Define function loongarch_cpu_post_init as static
  target/loongarch: Set page size in TLB misc with STLB
  target/loongarch: Add header file cpu-mmu.h
  target/loongarch: Add common function loongarch_check_pte()
  target/loongarch: Use loongarch_check_pte() with page table walking

 hw/loongarch/virt.c                  |   1 +
 target/loongarch/cpu-mmu.h           |  39 ++++++
 target/loongarch/cpu.c               | 181 ++++++++++++++-------------
 target/loongarch/cpu.h               |  11 --
 target/loongarch/cpu_helper.c        |  99 +++++++++++----
 target/loongarch/internals.h         |  20 ---
 target/loongarch/kvm/kvm_loongarch.h |   4 +-
 target/loongarch/tcg/csr_helper.c    |   1 +
 target/loongarch/tcg/tlb_helper.c    | 103 +++------------
 9 files changed, 227 insertions(+), 232 deletions(-)
 create mode 100644 target/loongarch/cpu-mmu.h


base-commit: e240f6cc25917f3138d9e95e0343ae23b63a3f8c
-- 
2.39.3


