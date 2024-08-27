Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E8C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 10:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sit1u-0006Rs-5r; Tue, 27 Aug 2024 06:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sit1q-0006Ql-8Z; Tue, 27 Aug 2024 06:02:23 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sit1m-00010C-Iq; Tue, 27 Aug 2024 06:02:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1109788F9C;
 Tue, 27 Aug 2024 13:01:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8EBD712D85A;
 Tue, 27 Aug 2024 13:02:08 +0300 (MSK)
Received: (nullmailer pid 3502779 invoked by uid 1000);
 Tue, 27 Aug 2024 10:02:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] mark <zlib.h> with for-crc32 in a consistent manner
Date: Tue, 27 Aug 2024 13:02:07 +0300
Message-Id: <20240827100207.3502764-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
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

in many cases, <zlib.h> is only included for crc32 function,
and in some of them, there's a comment saying that, but in
a different way.  In one place (hw/net/rtl8139.c), there was
another #include added between the comment and <zlib.h> include.

Make all such comments to be on the same line as #include, make
it consistent, and also add a few missing comments, including
hw/nvram/mac_nvram.c which uses adler32 instead.

There's no code changes.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/cadence_gem.c             | 2 +-
 hw/net/dp8393x.c                 | 2 +-
 hw/net/ftgmac100.c               | 3 +--
 hw/net/i82596.c                  | 2 +-
 hw/net/imx_fec.c                 | 3 +--
 hw/net/lan9118.c                 | 3 +--
 hw/net/mcf_fec.c                 | 3 +--
 hw/net/npcm7xx_emc.c             | 3 +--
 hw/net/rtl8139.c                 | 4 +---
 hw/net/smc91c111.c               | 3 +--
 hw/net/stellaris_enet.c          | 2 +-
 hw/nvram/mac_nvram.c             | 2 +-
 target/arm/helper.c              | 2 +-
 target/arm/tcg/helper-a64.c      | 2 +-
 target/loongarch/tcg/op_helper.c | 2 +-
 15 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index ec7bf562e5..12857d9d7d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include <zlib.h> /* For crc32 */
+#include <zlib.h> /* for crc32 */
 
 #include "hw/irq.h"
 #include "hw/net/cadence_gem.h"
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index bf0652da1b..6d143bac5c 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 #include "qom/object.h"
 #include "trace.h"
 
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 80f9cd56d5..c68db4e15f 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -24,8 +24,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
-/* For crc32 */
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 
 /*
  * FTGMAC100 registers
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 6cc8292a65..d786086a51 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -19,7 +19,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "i82596.h"
-#include <zlib.h>       /* For crc32 */
+#include <zlib.h> /* for crc32 */
 
 #if defined(ENABLE_DEBUG)
 #define DBG(x)          x
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 8c91d20d44..dfc3fb0d9a 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -33,8 +33,7 @@
 #include "net/eth.h"
 #include "trace.h"
 
-/* For crc32 */
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 
 #define IMX_MAX_DESC    1024
 
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 91d81b410b..c38ea40ada 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -22,8 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-/* For crc32 */
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 #include "qom/object.h"
 
 //#define DEBUG_LAN9118
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index e6902716bd..9db64f08c5 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -16,8 +16,7 @@
 #include "hw/net/mii.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-/* For crc32 */
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 
 //#define DEBUG_FEC 1
 
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index d1583b6f9b..7f25bca448 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -29,8 +29,7 @@
 
 #include "qemu/osdep.h"
 
-/* For crc32 */
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 
 #include "hw/irq.h"
 #include "hw/qdev-clock.h"
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 03a204ef8a..69a78ad677 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -48,10 +48,8 @@
  *  2011-Mar-22  Benjamin Poirier:  Implemented VLAN offloading
  */
 
-/* For crc32 */
-
 #include "qemu/osdep.h"
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 702d0e8e83..a00a76009e 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -17,8 +17,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-/* For crc32 */
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 #include "qom/object.h"
 
 /* Number of 2k memory pages available.  */
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index db95766e29..8e2ce3bf29 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -15,7 +15,7 @@
 #include "net/net.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 #include "qom/object.h"
 
 //#define DEBUG_STELLARIS_ENET 1
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index fe9df9fa35..83c6724c0a 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -35,7 +35,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include <zlib.h>
+#include <zlib.h> /* for adler32 */
 
 #define DEF_SYSTEM_SIZE 0xc10
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0a582c1cd3..3f77b40734 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -19,7 +19,7 @@
 #include "qemu/crc32c.h"
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
-#include <zlib.h> /* For crc32 */
+#include <zlib.h> /* for crc32 */
 #include "hw/irq.h"
 #include "sysemu/cpu-timers.h"
 #include "sysemu/kvm.h"
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 21a9abd90a..56b431faf5 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -33,7 +33,7 @@
 #include "qemu/int128.h"
 #include "qemu/atomic128.h"
 #include "fpu/softfloat.h"
-#include <zlib.h> /* For crc32 */
+#include <zlib.h> /* for crc32 */
 
 /* C2.4.7 Multiply and divide */
 /* special cases for 0 and LLONG_MIN are mandated by the standard */
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index fe79c62fa4..b17208e5b9 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -14,7 +14,7 @@
 #include "exec/cpu_ldst.h"
 #include "internals.h"
 #include "qemu/crc32c.h"
-#include <zlib.h>
+#include <zlib.h> /* for crc32 */
 #include "cpu-csr.h"
 
 /* Exceptions helpers */
-- 
2.39.2


