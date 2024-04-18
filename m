Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91687C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXyT-0001fX-74; Thu, 18 Apr 2024 16:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXy1-0001YM-6o; Thu, 18 Apr 2024 16:02:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxXxx-0005HW-Eb; Thu, 18 Apr 2024 16:02:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A530E5FE0F;
 Thu, 18 Apr 2024 23:02:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 10E25B93F5;
 Thu, 18 Apr 2024 23:02:25 +0300 (MSK)
Received: (nullmailer pid 952860 invoked by uid 1000);
 Thu, 18 Apr 2024 20:02:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 48/59] qemu-options: Fix CXL Fixed Memory Window
 interleave-granularity typo
Date: Thu, 18 Apr 2024 23:02:08 +0300
Message-Id: <20240418200224.952785-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240418230159@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Fix the unit typo of interleave-granularity of CXL Fixed Memory
Window in qemu-option.hx.

Fixes: 03b39fcf64 ("hw/cxl: Make the CFMW a machine parameter.")
Signed-off-by: Yuquan Wang wangyuquan1236@phytium.com.cn
Message-ID: <20240407083539.1488172-2-wangyuquan1236@phytium.com.cn>
[PMD: Reworded]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit aa88f99c87c0e5d195d6d96190374650553ea61f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-options.hx b/qemu-options.hx
index 7f798ce47e..2c00ceac83 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -149,14 +149,14 @@ SRST
         platform and configuration dependent.
 
         ``interleave-granularity=granularity`` sets the granularity of
-        interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
-        4096KiB, 8192KiB and 16384KiB granularities supported.
+        interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
+        4k, 8k and 16k granularities supported.
 
         Example:
 
         ::
 
-            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512k
+            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.39.2


