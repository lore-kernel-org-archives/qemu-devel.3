Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7D2C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPd7R-0005f3-OT; Thu, 12 Jun 2025 04:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uPd7K-0005eD-8B
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:16:59 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1uPd7I-0002s5-Dg
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:16:58 -0400
DKIM-Signature: a=rsa-sha256; bh=mMvbD/NwpXg4yiI+Jx8saoyx1a+QQoenlF2EVEVMkeE=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1749716209; v=1;
 b=KXTQ6C86mVGAMEZIVZdgKVpl8HfC7YTGvFeB5NaI4BMMUWoGH6CgnY2y4H9R1nmf5sBUuGwU
 ZtoDS98Qp77IiTIqnayA1idNvsJZ/Lb6p5Z/R3LwJeMp3rnNzKtfIJg59Nv+Q9PbaRjVUq/3sSz
 v/vJL0fxxWgRrICZCQyLJJuYpR+YRMhDZCl+ko2y12DLPNk1GvmXcUGx8p9FUQdn/pcuT3Jrbwv
 962Ah0DS58GyX3OnlSnF7Wv71eOKVHQ2B8XBVVVpjNl5nXj5SJezddBcr6vMeo22qxAvAsa3ztz
 5IC/nnKViljW9d6xPOWkDaHIHxHHBGcfonR8FVBwSE65g==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 364C3220AD;
 Thu, 12 Jun 2025 08:16:49 +0000 (UTC)
From: ~liuxu <liuxu@git.sr.ht>
Date: Thu, 12 Jun 2025 08:16:49 +0000
Subject: [PATCH qemu v8 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
MIME-Version: 1.0
Message-ID: <174971620915.19456.15836954551382475540-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~liuxu <liuxu@nucleisys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thanks for Alistair Francis's reply, and now this version has changed as
follows:
1. Rebase to https://github.com/alistair23/qemu/tree/riscv-to-
apply.next.
2. The Review-by information has been added.

lxx (1):
  target/riscv: Add Zilsd and Zclsd extension support

 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu_cfg_fields.h.inc         |   2 +
 target/riscv/insn16.decode                |   8 ++
 target/riscv/insn32.decode                |  12 ++-
 target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                |  30 ++++++
 target/riscv/translate.c                  |   1 +
 7 files changed, 167 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc

-- 
2.45.3

