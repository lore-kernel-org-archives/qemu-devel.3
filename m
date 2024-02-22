Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99555C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7E3-0008AH-4J; Thu, 22 Feb 2024 06:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Dg-00085u-94; Thu, 22 Feb 2024 06:26:28 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7Dd-0004um-HJ; Thu, 22 Feb 2024 06:26:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BAC284FB48;
 Thu, 22 Feb 2024 14:26:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4123B87174;
 Thu, 22 Feb 2024 14:26:02 +0300 (MSK)
Received: (nullmailer pid 2526158 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 06/34] hw/timer: Move HPET_INTCAP definition to "hpet.h"
Date: Thu, 22 Feb 2024 14:25:33 +0300
Message-Id: <20240222112601.2526057-7-mjt@tls.msk.ru>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

HPET_INTCAP is specific to TYPE_HPET, so define it there.
hpet.c doesn't need to include "hw/i386/pc.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/timer/hpet.c         | 1 -
 include/hw/i386/pc.h    | 2 --
 include/hw/timer/hpet.h | 2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1672faa4f2..01efe4885d 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -25,7 +25,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 02a0deedd3..c0e6c43fbd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -15,8 +15,6 @@
 #include "hw/firmware/smbios.h"
 #include "hw/cxl/cxl.h"
 
-#define HPET_INTCAP "hpet-intcap"
-
 /**
  * PCMachineState:
  * @acpi_dev: link to ACPI PM device that performs ACPI hotplug handling
diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index f04c4d3238..d17a8d4319 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -78,6 +78,8 @@ extern struct hpet_fw_config hpet_cfg;
 
 #define TYPE_HPET "hpet"
 
+#define HPET_INTCAP "hpet-intcap"
+
 static inline bool hpet_find(void)
 {
     return object_resolve_path_type("", TYPE_HPET, NULL);
-- 
2.39.2


