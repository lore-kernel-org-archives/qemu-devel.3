Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2563ECF58E4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYH7-00075t-DQ; Fri, 20 Sep 2024 03:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYH5-00070D-71; Fri, 20 Sep 2024 03:41:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYGw-0000Cm-9Y; Fri, 20 Sep 2024 03:41:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C7C49085A;
 Fri, 20 Sep 2024 10:41:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EC9781409DD;
 Fri, 20 Sep 2024 10:41:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Tejas Vipin <tejasvipin76@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 04/22] ppc: fix incorrect spelling of PowerMac
Date: Fri, 20 Sep 2024 10:41:16 +0300
Message-Id: <20240920074134.664961-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920074134.664961-1-mjt@tls.msk.ru>
References: <20240920074134.664961-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Tejas Vipin <tejasvipin76@gmail.com>

PowerMac is spelled as PowerMAC (Media Access Control) in some places.
This is misleading.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2297
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/ppc/powermac.rst | 4 ++--
 hw/ppc/mac_newworld.c        | 2 +-
 hw/ppc/mac_oldworld.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/ppc/powermac.rst b/docs/system/ppc/powermac.rst
index 04334ba210..3eac81c491 100644
--- a/docs/system/ppc/powermac.rst
+++ b/docs/system/ppc/powermac.rst
@@ -4,8 +4,8 @@ PowerMac family boards (``g3beige``, ``mac99``)
 Use the executable ``qemu-system-ppc`` to simulate a complete PowerMac
 PowerPC system.
 
-- ``g3beige``              Heathrow based PowerMAC
-- ``mac99``                Mac99 based PowerMAC
+- ``g3beige``              Heathrow based PowerMac
+- ``mac99``                Mac99 based PowerMac
 
 Supported devices
 -----------------
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index ff9e490c4e..9d249a506c 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -571,7 +571,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
 
-    mc->desc = "Mac99 based PowerMAC";
+    mc->desc = "Mac99 based PowerMac";
     mc->init = ppc_core99_init;
     mc->block_default_type = IF_IDE;
     /* SMP is not supported currently */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 1981d3d8f6..eef3261002 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -411,7 +411,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
 
-    mc->desc = "Heathrow based PowerMAC";
+    mc->desc = "Heathrow based PowerMac";
     mc->init = ppc_heathrow_init;
     mc->block_default_type = IF_IDE;
     /* SMP is not supported currently */
-- 
2.39.5


