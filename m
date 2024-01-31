Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48468C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9DJ-0002KA-KE; Wed, 31 Jan 2024 06:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9DI-0002Hx-3x; Wed, 31 Jan 2024 06:57:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9DG-00041l-Gw; Wed, 31 Jan 2024 06:57:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C6629490CF;
 Wed, 31 Jan 2024 14:56:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 08EE670278;
 Wed, 31 Jan 2024 14:55:51 +0300 (MSK)
Received: (nullmailer pid 2263963 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 17/21] hw/i386: Add `\n` to hint message
Date: Wed, 31 Jan 2024 14:55:45 +0300
Message-Id: <20240131115549.2263854-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131115549.2263854-1-mjt@tls.msk.ru>
References: <20240131115549.2263854-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Greg Kurz <groug@kaod.org>

error_printf() doesn't add newlines.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index edc979379c..e990b0ae92 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2697,7 +2697,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                         " migration may not work",
                         tables_blob->len, legacy_table_size);
             error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.");
+                         " or PCI bridges.\n");
         }
         g_array_set_size(tables_blob, legacy_table_size);
     } else {
@@ -2709,7 +2709,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                         " migration may not work",
                         tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
             error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                         " or PCI bridges.");
+                         " or PCI bridges.\n");
         }
         acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
     }
-- 
2.39.2


