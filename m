Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F27CCA468
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2n4S-0007L1-Ct; Sun, 28 Sep 2025 04:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v2n4L-0007Jf-1K
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:47:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v2n4G-00023S-2v
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:47:43 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxM9Ai9thoPcsPAA--.33437S3;
 Sun, 28 Sep 2025 16:47:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8Eg9tho32y5AA--.23975S2;
 Sun, 28 Sep 2025 16:47:28 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] loongarch queue
Date: Sun, 28 Sep 2025 16:47:15 +0800
Message-Id: <20250928084728.1972177-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8Eg9tho32y5AA--.23975S2
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

The following changes since commit d6dfd8d40cebebc3378d379cd28879e0345fbf91:

  Merge tag 'pull-target-arm-20250926' of https://gitlab.com/pm215/qemu into staging (2025-09-26 13:27:01 -0700)

are available in the Git repository at:

  https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250928

for you to fetch changes up to 8d26856fabf8faac60de03a2e0fc35e5338e248e:

  target/loongarch: Only flush one TLB entry in helper_invtlb_page_asid() (2025-09-28 16:10:34 +0800)

----------------------------------------------------------------
pull-loongarch-20250928 queue

----------------------------------------------------------------
Bibo Mao (13):
      target/loongarch: Use mmu idx bitmap method when flush TLB
      target/loongarch: Add parameter tlb pointer with fill_tlb_entry
      target/loongarch: Reduce TLB flush with helper_tlbwr
      target/loongarch: Update TLB index selection method
      target/loongarch: Fix page size set issue with CSR_STLBPS
      target/loongarch: Add tlb search callback in loongarch_tlb_search()
      target/loongarch: Add common API loongarch_tlb_search_cb()
      target/loongarch: Change return value type with loongarch_tlb_search_cb()
      target/loongarch: Use loongarch_tlb_search_cb in helper_invtlb_page_asid_or_g
      target/loongarch: Use loongarch_tlb_search_cb in helper_invtlb_page_asid
      target/loongarch: Invalid tlb entry in invalidate_tlb()
      target/loongarch: Only flush one TLB entry in helper_invtlb_page_asid_or_g()
      target/loongarch: Only flush one TLB entry in helper_invtlb_page_asid()

 target/loongarch/cpu-csr.h        |   1 +
 target/loongarch/tcg/csr_helper.c |   5 +-
 target/loongarch/tcg/tlb_helper.c | 205 +++++++++++++++++++++++---------------
 3 files changed, 131 insertions(+), 80 deletions(-)


