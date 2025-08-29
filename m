Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9C7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3b-0001ll-QF; Sat, 30 Aug 2025 10:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpH0-0008OZ-W4
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpGp-00077S-Ly
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:30 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxf9OQFrFon24EAA--.8858S3;
 Fri, 29 Aug 2025 10:55:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S2;
 Fri, 29 Aug 2025 10:55:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] loongarch queue
Date: Fri, 29 Aug 2025 10:54:53 +0800
Message-Id: <20250829025507.2315073-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S2
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

The following changes since commit ca18b336e12c8433177a3cd639c5bf757952adaa:

  Merge tag 'pull-lu-20250828' of https://gitlab.com/rth7680/qemu into staging (2025-08-28 09:24:36 +1000)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250829

for you to fetch changes up to cc78259deb21940521a227619eb00a4b8e3e36c2:

  target/loongarch: Use correct address when flush tlb (2025-08-29 10:05:02 +0800)

----------------------------------------------------------------
pull-loongarch-20250829 queue

----------------------------------------------------------------
Bibo Mao (14):
      target/loongarch: Move some function definition to kvm directory
      target/loongarch: Define function loongarch_cpu_post_init as static
      target/loongarch: Set page size in TLB entry with STLB
      target/loongarch: Add header file cpu-mmu.h
      target/loongarch: Add enum type TLBRet definition
      target/loongarch: Use vaddr in get_physical_address()
      target/loongarch: Use MMUAccessType in loongarch_map_tlb_entry()
      target/loongarch: Add common function loongarch_check_pte()
      target/loongarch: Use loongarch_check_pte in loongarch_page_table_walker
      target/loongarch: Use MMUConext in loongarch_map_tlb_entry()
      target/loongarch: Use MMUContext in loongarch_get_addr_from_tlb
      target/loongarch: Use MMUContext in loongarch_map_address()
      target/loongarch: Use MMUContext in get_physical_address()
      target/loongarch: Use correct address when flush tlb

 hw/loongarch/virt.c                  |   1 +
 target/loongarch/cpu-mmu.h           |  40 ++++++++
 target/loongarch/cpu.c               | 181 ++++++++++++++++++-----------------
 target/loongarch/cpu.h               |  11 ---
 target/loongarch/cpu_helper.c        | 142 +++++++++++++++++----------
 target/loongarch/internals.h         |  20 ----
 target/loongarch/kvm/kvm_loongarch.h |   4 +-
 target/loongarch/tcg/csr_helper.c    |   1 +
 target/loongarch/tcg/tcg_loongarch.h |   7 +-
 target/loongarch/tcg/tlb_helper.c    | 144 ++++++++--------------------
 10 files changed, 270 insertions(+), 281 deletions(-)
 create mode 100644 target/loongarch/cpu-mmu.h


