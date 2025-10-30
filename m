Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B56CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vENqq-0000hr-J6; Thu, 30 Oct 2025 04:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vENqm-0000gr-CN
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vENqe-0003BC-Uk
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:17:40 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxb_AVHwNpiYgcAA--.62487S3;
 Thu, 30 Oct 2025 16:17:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxicAVHwNpKnMcAQ--.9832S2;
 Thu, 30 Oct 2025 16:17:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/loongarch: PMU enhancement in KVM mode
Date: Thu, 30 Oct 2025 16:17:21 +0800
Message-Id: <20251030081724.3921563-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxicAVHwNpKnMcAQ--.9832S2
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

This patchset add PMU migration support and CSR register dump support
with debug purpose, also it removes TLB migration support in TCG mode.

---
v1 ... v2:
  1. Move calling with function loongarch_la464_init_csr() after CPU is
     realized, since PMU feature is decided during realization stage.
  2. Split origin patch #2 for better review
  3. Add PMU event number info in structure CPUArchState rather than
     fixed number 4, save and restore PMU registers by its event number.
---
Bibo Mao (3):
  target/loongarch: Add PMU migration support in KVM mode
  target/loongarch: Call function loongarch_la464_init_csr() after
    realized
  target/loongarch: Add PMU register dump support in KVM

 target/loongarch/cpu-csr.h |  4 +++
 target/loongarch/cpu.c     | 11 +++++---
 target/loongarch/cpu.h     |  4 +++
 target/loongarch/csr.c     | 32 ++++++++++++++++++++++
 target/loongarch/kvm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++-
 target/loongarch/machine.c | 21 +++++++++++++++
 6 files changed, 122 insertions(+), 4 deletions(-)


base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
-- 
2.39.3


