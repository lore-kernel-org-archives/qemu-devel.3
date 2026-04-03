Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3CCE7E36B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8c01-0003xk-TS; Fri, 03 Apr 2026 06:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8bzz-0003x3-2M
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1w8bzw-0005XU-I1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 06:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775212971; bh=iTD+YPwk/gZAcdlT6TByCohIFvhVzDKpWAe9TysC0vQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DL/SFPFFVfGEpcg1SmA1dpdcsb8RSUJPWjBFnNiQOfDF6Eltv57OTwHOo80hiho2z
 DgJiK0LIkfrpf/OoxLO6BPPYMEHek2rSEZx5p3nOYI2qIJ26sf5NjlaziTpbJJlm0H
 nNM3CFG6acauJxQwOFEgwXFr7/lsMQbwYju7RS6r0K/ENdjY8OZfrdiwbhzaWjEMDS
 aECQikKh0gju+X1Tl1B3hy/rVU/Ga68E22PMOc+kGSmQf4UD9zyQTYkYWmhmWuaryo
 wcz/kuYxRy11TCp/vnLwae6ydbeWwIpnyilVW7Q4KGUYD098FrP2N7jwouJ9PbONYQ
 SI7AOBcDSCDyQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 007AB19A63B
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 13:42:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AA58C38DB6B;
 Fri, 03 Apr 2026 13:43:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for-11.0 1/6] util/meson.build: do not add cpuinfo-$arch to
 util_ss for 32bit CPUs
Date: Fri,  3 Apr 2026 13:43:21 +0300
Message-ID: <20260403104327.1163942-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403104327.1163942-1-mjt@tls.msk.ru>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qemu dropped support for 32bit CPUs recently, so this change is an
additional clean-up on top.  But in theory it will allow building
qemu-guest-agent on a 32bit system.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 util/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/meson.build b/util/meson.build
index 33132c04ad..c2d77bf9de 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -116,13 +116,13 @@ endif
 
 if cpu == 'aarch64'
   util_ss.add(files('cpuinfo-aarch64.c'))
-elif cpu in ['x86', 'x86_64']
+elif cpu == 'x86_64'
   util_ss.add(files('cpuinfo-i386.c'))
 elif cpu == 'loongarch64'
   util_ss.add(files('cpuinfo-loongarch.c'))
-elif cpu in ['ppc', 'ppc64']
+elif cpu == 'ppc64'
   util_ss.add(files('cpuinfo-ppc.c'))
-elif cpu in ['riscv32', 'riscv64']
+elif cpu == 'riscv64'
   util_ss.add(files('cpuinfo-riscv.c'))
 elif cpu == 's390x'
   util_ss.add(files('s390x_pci_mmio.c'))
-- 
2.47.3


