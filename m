Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA72C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCj8D-0008AM-J8; Wed, 07 May 2025 14:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj8B-00089P-NP; Wed, 07 May 2025 14:04:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uCj8A-0008B8-1u; Wed, 07 May 2025 14:04:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3EB8311FEFC;
 Wed, 07 May 2025 21:04:00 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B7CB206701;
 Wed,  7 May 2025 21:04:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 07/21] hw/i386/acpi-build: Fix typo in function name
Date: Wed,  7 May 2025 21:03:58 +0300
Message-Id: <20250507180412.182797-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507180412.182797-1-mjt@tls.msk.ru>
References: <20250507180412.182797-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Fix missing "i" in the name of the function responsible for adding the call to
the PCI notification method (PCNT) in the ACPI table.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i386/acpi-build.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b5836417a0..f40ad062f9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -589,8 +589,8 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
     }
 }
 
-static bool build_append_notfication_callback(Aml *parent_scope,
-                                              const PCIBus *bus)
+static bool build_append_notification_callback(Aml *parent_scope,
+                                               const PCIBus *bus)
 {
     Aml *method;
     PCIBus *sec;
@@ -604,7 +604,7 @@ static bool build_append_notfication_callback(Aml *parent_scope,
             continue;
         }
         nr_notifiers = nr_notifiers +
-                       build_append_notfication_callback(br_scope, sec);
+                       build_append_notification_callback(br_scope, sec);
         /*
          * add new child scope to parent
          * and keep track of bus that have PCNT,
@@ -1773,7 +1773,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
 
         scope = aml_scope("\\_SB.PCI0");
-        has_pcnt = build_append_notfication_callback(scope, b);
+        has_pcnt = build_append_notification_callback(scope, b);
         if (has_pcnt) {
             aml_append(dsdt, scope);
         }
-- 
2.39.5


