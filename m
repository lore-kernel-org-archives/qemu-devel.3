Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D250DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7E5-0008Bt-6U; Thu, 22 Feb 2024 06:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DR-00083N-76; Thu, 22 Feb 2024 06:26:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DK-0004p1-Tv; Thu, 22 Feb 2024 06:26:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 701CB4FB43;
 Thu, 22 Feb 2024 14:26:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EB40A8716F;
 Thu, 22 Feb 2024 14:26:01 +0300 (MSK)
Received: (nullmailer pid 2526143 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 01/34] hw/usb: Style cleanup
Date: Thu, 22 Feb 2024 14:25:28 +0300
Message-Id: <20240222112601.2526057-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222112601.2526057-1-mjt@tls.msk.ru>
References: <20240222112601.2526057-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We are going to modify these lines, fix their style
in order to avoid checkpatch.pl warning.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/hcd-ehci.c | 3 ++-
 hw/usb/hcd-uhci.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 870c72cb59..98a2860069 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1086,8 +1086,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
     case CONFIGFLAG:
         val &= 0x1;
         if (val) {
-            for(i = 0; i < NB_PORTS; i++)
+            for (i = 0; i < NB_PORTS; i++) {
                 handle_port_owner_write(s, i, 0);
+            }
         }
         break;
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 7d3c026dae..b95b47f6a4 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -457,8 +457,9 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             int n;
 
             n = (addr >> 1) & 7;
-            if (n >= NB_PORTS)
+            if (n >= NB_PORTS) {
                 return;
+            }
             port = &s->ports[n];
             dev = port->port.dev;
             if (dev && dev->attached) {
@@ -513,8 +514,9 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
             UHCIPort *port;
             int n;
             n = (addr >> 1) & 7;
-            if (n >= NB_PORTS)
+            if (n >= NB_PORTS) {
                 goto read_default;
+            }
             port = &s->ports[n];
             val = port->ctrl;
         }
-- 
2.39.2


