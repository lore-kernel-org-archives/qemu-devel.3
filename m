Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0B7C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPihQ-0000tl-SO; Thu, 12 Jun 2025 10:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yoshinori.sato@nifty.com>)
 id 1uPhnX-0004vk-NM
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:16:53 -0400
Received: from ik1-413-38519.vs.sakura.ne.jp ([153.127.30.23]
 helo=sakura.ysato.name) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yoshinori.sato@nifty.com>) id 1uPhnV-0005dH-1t
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:16:51 -0400
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 904FA1C0019;
 Thu, 12 Jun 2025 22:16:37 +0900 (JST)
From: Yoshinori Sato <yoshinori.sato@nifty.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
	ysato@users.sourceforge.jp
Subject: [PATCH] MAINTAINERS: Yoshinori Sato email address has been updated
Date: Thu, 12 Jun 2025 22:16:32 +0900
Message-Id: <20250612131632.137155-1-yoshinori.sato@nifty.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=153.127.30.23;
 envelope-from=yoshinori.sato@nifty.com; helo=sakura.ysato.name
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.4,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Jun 2025 10:14:33 -0400
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

The email address <ysato@users.sourceforge.jp> has been suspended.
I have prepared a new email address.

Signed-off-by: Yoshinori Sato <yoshinori.sato@nifty.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6763077e..f28b908e62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -351,7 +351,7 @@ F: target/riscv/insn_trans/trans_xventanacondops.c.inc
 F: disas/riscv-xventana*
 
 RENESAS RX CPUs
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: target/rx/
 
@@ -367,7 +367,7 @@ F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SH4 TCG CPUs
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: target/sh4/
 F: hw/sh4/
@@ -1693,7 +1693,7 @@ F: docs/system/riscv/microblaze-v-generic.rst
 RX Machines
 -----------
 rx-gdbsim
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: docs/system/target-rx.rst
 F: hw/rx/rx-gdbsim.c
@@ -1702,7 +1702,7 @@ F: tests/functional/test_rx_gdbsim.py
 SH4 Machines
 ------------
 R2D
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/sh_serial.c
@@ -2753,7 +2753,7 @@ F: tests/qtest/*xive*
 F: docs/*/*xive*
 
 Renesas peripherals
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/renesas_sci.c
@@ -2765,7 +2765,7 @@ F: include/hw/sh4/sh.h
 F: include/hw/timer/renesas_*.h
 
 Renesas RX peripherals
-R: Yoshinori Sato <ysato@users.sourceforge.jp>
+R: Yoshinori Sato <yoshinori.sato@nifty.com>
 S: Orphan
 F: hw/intc/rx_icu.c
 F: hw/rx/
-- 
2.39.5


