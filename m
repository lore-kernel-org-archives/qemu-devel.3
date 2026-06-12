Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2EACD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5Fg-0005Z8-Iq; Fri, 12 Jun 2026 13:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Ez-0005AE-NV; Fri, 12 Jun 2026 13:00:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Ex-00068r-I5; Fri, 12 Jun 2026 13:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781283582; bh=iJFczm4Mkj6FVh+btnly1TBsvJWUTxtYdAijnu5GC5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lCiSsQTvzNF7lH5NxfQ0zjHT/GhNgMZiobxq+oHZN57/xV8IFJpTP9MbHfq8q4vbx
 452vr4VRlr1dEHaNkAmjfn1do7dWVwDusCnjnb9DNUUh6mBHE0D2m1YwDtHeEOu7cv
 OfcrgLNcxPmRdyFhikpwE31mSw664ixLzXL/FIy76jlk9pad5T81B+DuPLoyeHHxwX
 D6rReQLNfnUFclXVM4BOuhS1zoJlParue28wcUkRRImIK96rRm/gDZ1DR8FyiDqJYt
 o7kKb5yUKrfThaUTX4DkDCUGGtx68uwiklLRquOeDB21A9yuaFjPXn1jmg0OXf7g1C
 HwqnldUx9TSiA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D0351B6BCD;
 Fri, 12 Jun 2026 19:59:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1C8903CE16A;
 Fri, 12 Jun 2026 19:59:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 8/8] qemu-options: fix typo in spelling of 'scheduler'
Date: Fri, 12 Jun 2026 19:59:52 +0300
Message-ID: <20260612165957.1779082-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165957.1779082-1-mjt@tls.msk.ru>
References: <20260612165957.1779082-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..2fd21519b2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5517,7 +5517,7 @@ DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
     "                    main QEMU process but will allow forks and execves to run unprivileged\n" \
     "                use 'spawn' to avoid QEMU to spawn new threads or processes by\n" \
     "                     blocking *fork and execve\n" \
-    "                use 'resourcecontrol' to disable process affinity and schedular priority\n",
+    "                use 'resourcecontrol' to disable process affinity and scheduler priority\n",
     QEMU_ARCH_ALL)
 SRST
 ``-sandbox arg[,obsolete=string][,elevateprivileges=string][,spawn=string][,resourcecontrol=string]``
@@ -5534,7 +5534,7 @@ SRST
         Disable \*fork and execve
 
     ``resourcecontrol=string``
-        Disable process affinity and schedular priority
+        Disable process affinity and scheduler priority
 ERST
 
 DEF("readconfig", HAS_ARG, QEMU_OPTION_readconfig,
-- 
2.47.3


