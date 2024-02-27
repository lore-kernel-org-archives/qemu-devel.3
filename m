Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C66BC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexH7-0001zs-I5; Tue, 27 Feb 2024 08:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rexH2-0001x1-Jf; Tue, 27 Feb 2024 08:13:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rexGn-00078c-9m; Tue, 27 Feb 2024 08:13:32 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AF90C4E601B;
 Tue, 27 Feb 2024 14:13:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id eh6BLkOvoKU6; Tue, 27 Feb 2024 14:13:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C24EB4E6005; Tue, 27 Feb 2024 14:13:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/ide/ahci: Rename ahci_internal.h to ahci-internal.h
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Message-Id: <20240227131310.C24EB4E6005@zero.eik.bme.hu>
Date: Tue, 27 Feb 2024 14:13:10 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Other headers now use dash instead of underscore. Rename
ahci_internal.h accordingly for consistency.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/{ahci_internal.h => ahci-internal.h} | 0
 hw/ide/ahci.c                               | 2 +-
 hw/ide/ich.c                                | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/ide/{ahci_internal.h => ahci-internal.h} (100%)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci-internal.h
similarity index 100%
rename from hw/ide/ahci_internal.h
rename to hw/ide/ahci-internal.h
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index b8123bc73d..bfefad2965 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -37,7 +37,7 @@
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide/ahci-sysbus.h"
-#include "ahci_internal.h"
+#include "ahci-internal.h"
 #include "ide-internal.h"
 
 #include "trace.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 3ea793d790..9b909c87f3 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -70,7 +70,7 @@
 #include "sysemu/dma.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
-#include "ahci_internal.h"
+#include "ahci-internal.h"
 
 #define ICH9_MSI_CAP_OFFSET     0x80
 #define ICH9_SATA_CAP_OFFSET    0xA8
-- 
2.30.9


