Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B62CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBu6c-00068U-NO; Thu, 23 Oct 2025 08:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vBu6H-00065k-Dq
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:07:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vBu6C-0004up-VV
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:07:24 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxRNBwGvpoY70ZAA--.55210S3;
 Thu, 23 Oct 2025 20:07:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8NuGvporJkDAQ--.47140S2;
 Thu, 23 Oct 2025 20:07:10 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] loongarch queue
Date: Thu, 23 Oct 2025 20:06:56 +0800
Message-Id: <20251023120710.3086556-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8NuGvporJkDAQ--.47140S2
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

The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:

  Merge tag 'pull-vfio-20251022' of https://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20251023

for you to fetch changes up to 79ff2eee9a377f654ed0c3533a0874a0e7d6226d:

  target/loongarch: Add bit A/D checking in TLB entry with PTW supported (2025-10-23 19:43:48 +0800)

----------------------------------------------------------------
pull-loongarch-20251023 queue

----------------------------------------------------------------
Bibo Mao (14):
      target/loongarch: Use auto method with PTW feature
      target/loongarch: Add CSR_PWCH write helper function
      target/loongarch: Add present and write bit with pte entry
      target/loongarch: Add function sptw_prepare_tlb before adding tlb entry
      target/loongarch: target/loongarch: Add common function get_tlb_random_index()
      target/loongarch: Add MMUContext parameter in fill_tlb_entry()
      target/loongarch: Add debug parameter with loongarch_page_table_walker()
      target/loongarch: Reserve higher 48 bit PTE attribute with huge page
      target/loongarch: Move last PTE lookup into page table walker loop
      target/loongarch: Add field tlb_index to record TLB search info
      target/loongarch: Add common interface update_tlb_index()
      target/loongarch: Add basic hardware PTW support
      target/loongarch: Update matched ptw bit A/D with PTW supported
      target/loongarch: Add bit A/D checking in TLB entry with PTW supported

 target/loongarch/cpu-csr.h                         |   4 +
 target/loongarch/cpu-mmu.h                         |  62 ++++++++
 target/loongarch/cpu.c                             |  26 ++++
 target/loongarch/cpu.h                             |   2 +
 target/loongarch/cpu_helper.c                      | 146 ++++++++++++++++---
 target/loongarch/tcg/csr_helper.c                  |  15 ++
 target/loongarch/tcg/helper.h                      |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc          |   1 +
 target/loongarch/tcg/tlb_helper.c                  | 157 ++++++++++++++++-----
 9 files changed, 358 insertions(+), 56 deletions(-)


