Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC33FD2D62
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzvuo-0001mo-Qj; Tue, 10 Mar 2026 08:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vzvuk-0001lD-PR; Tue, 10 Mar 2026 08:10:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1vzvug-00073b-B7; Tue, 10 Mar 2026 08:10:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnsMcCrBpjn8ZAA--.10004S3;
 Tue, 10 Mar 2026 20:10:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx2+AZCrBpiBtSAA--.25432S2;
 Tue, 10 Mar 2026 20:10:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 0/2] loongarch-to-apply queue
Date: Tue, 10 Mar 2026 19:44:40 +0800
Message-Id: <20260310114442.1025328-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx2+AZCrBpiBtSAA--.25432S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 31ee190665dd50054c39cef5ad740680aabda382:

  Merge tag 'hw-misc-20260309' of https://github.com/philmd/qemu into staging (2026-03-09 17:19:26 +0000)

are available in the Git repository at:

  https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260310

for you to fetch changes up to db2325f79481fab87211e5a287580d753f582cb8:

  target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch (2026-03-10 19:50:01 +0800)

----------------------------------------------------------------
loongarch bug fix

----------------------------------------------------------------
rail5 (2):
      target/loongarch: Preserve PTE permission bits in LDPTE
      target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch

 target/loongarch/cpu.c            | 11 +++++++++++
 target/loongarch/cpu.h            |  1 +
 target/loongarch/tcg/tcg_cpu.c    |  2 +-
 target/loongarch/tcg/tlb_helper.c | 24 +++++++++++++++++++++---
 4 files changed, 34 insertions(+), 4 deletions(-)


