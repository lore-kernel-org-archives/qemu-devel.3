Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04067C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHqe-0000SM-I1; Thu, 04 Jul 2024 04:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sPHqc-0000RU-5G; Thu, 04 Jul 2024 04:29:46 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sPHqW-0002HT-PL; Thu, 04 Jul 2024 04:29:45 -0400
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 4 Jul
 2024 16:29:23 +0800
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Jul
 2024 16:29:23 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 4 Jul 2024 16:29:23 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 2/8] hw/net:ftgmac100: update ring base address to 64 bits
Date: Thu, 4 Jul 2024 16:29:16 +0800
Message-ID: <20240704082922.1464317-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
References: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update TX and RX ring base address data type to uint64_t for
64 bits dram address DMA support.

Both "Normal Priority Transmit Ring Base Address Register(0x20)" and
"Receive Ring Base Address Register (0x24)" are used for saving the
low part physical address of descriptor manager.

Therefore, changes to set TX and RX descriptor manager address bits [31:0]
in ftgmac100_read and ftgmac100_write functions.

Incrementing the version of vmstate to 2.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/net/ftgmac100.c         | 33 ++++++++++++++++-----------------
 include/hw/net/ftgmac100.h |  9 ++++-----
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 9e1f12cd33..d026242e2b 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -515,12 +515,12 @@ out:
     return frame_size;
 }
 
-static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
-                            uint32_t tx_descriptor)
+static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
+                            uint64_t tx_descriptor)
 {
     int frame_size = 0;
     uint8_t *ptr = s->frame;
-    uint32_t addr = tx_descriptor;
+    uint64_t addr = tx_descriptor;
     uint32_t flags = 0;
 
     while (1) {
@@ -726,9 +726,9 @@ static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
     case FTGMAC100_MATH1:
         return s->math[1];
     case FTGMAC100_RXR_BADR:
-        return s->rx_ring;
+        return extract64(s->rx_ring, 0, 32);
     case FTGMAC100_NPTXR_BADR:
-        return s->tx_ring;
+        return extract64(s->tx_ring, 0, 32);
     case FTGMAC100_ITC:
         return s->itc;
     case FTGMAC100_DBLAC:
@@ -799,9 +799,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
                           HWADDR_PRIx "\n", __func__, value);
             return;
         }
-
-        s->rx_ring = value;
-        s->rx_descriptor = s->rx_ring;
+        s->rx_ring = deposit64(s->rx_ring, 0, 32, value);
+        s->rx_descriptor = deposit64(s->rx_descriptor, 0, 32, value);
         break;
 
     case FTGMAC100_RBSR: /* DMA buffer size */
@@ -814,8 +813,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
                           HWADDR_PRIx "\n", __func__, value);
             return;
         }
-        s->tx_ring = value;
-        s->tx_descriptor = s->tx_ring;
+        s->tx_ring = deposit64(s->tx_ring, 0, 32, value);
+        s->tx_descriptor = deposit64(s->tx_descriptor, 0, 32, value);
         break;
 
     case FTGMAC100_NPTXPD: /* Trigger transmit */
@@ -957,7 +956,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
     FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
     FTGMAC100Desc bd;
     uint32_t flags = 0;
-    uint32_t addr;
+    uint64_t addr;
     uint32_t crc;
     uint32_t buf_addr;
     uint8_t *crc_ptr;
@@ -1126,18 +1125,14 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_ftgmac100 = {
     .name = TYPE_FTGMAC100,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(irq_state, FTGMAC100State),
         VMSTATE_UINT32(isr, FTGMAC100State),
         VMSTATE_UINT32(ier, FTGMAC100State),
         VMSTATE_UINT32(rx_enabled, FTGMAC100State),
-        VMSTATE_UINT32(rx_ring, FTGMAC100State),
         VMSTATE_UINT32(rbsr, FTGMAC100State),
-        VMSTATE_UINT32(tx_ring, FTGMAC100State),
-        VMSTATE_UINT32(rx_descriptor, FTGMAC100State),
-        VMSTATE_UINT32(tx_descriptor, FTGMAC100State),
         VMSTATE_UINT32_ARRAY(math, FTGMAC100State, 2),
         VMSTATE_UINT32(itc, FTGMAC100State),
         VMSTATE_UINT32(aptcr, FTGMAC100State),
@@ -1156,6 +1151,10 @@ static const VMStateDescription vmstate_ftgmac100 = {
         VMSTATE_UINT32(phy_int_mask, FTGMAC100State),
         VMSTATE_UINT32(txdes0_edotr, FTGMAC100State),
         VMSTATE_UINT32(rxdes0_edorr, FTGMAC100State),
+        VMSTATE_UINT64(rx_ring, FTGMAC100State),
+        VMSTATE_UINT64(tx_ring, FTGMAC100State),
+        VMSTATE_UINT64(rx_descriptor, FTGMAC100State),
+        VMSTATE_UINT64(tx_descriptor, FTGMAC100State),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 269446e858..aae57ae8cb 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -42,10 +42,6 @@ struct FTGMAC100State {
     uint32_t isr;
     uint32_t ier;
     uint32_t rx_enabled;
-    uint32_t rx_ring;
-    uint32_t rx_descriptor;
-    uint32_t tx_ring;
-    uint32_t tx_descriptor;
     uint32_t math[2];
     uint32_t rbsr;
     uint32_t itc;
@@ -58,7 +54,10 @@ struct FTGMAC100State {
     uint32_t phycr;
     uint32_t phydata;
     uint32_t fcr;
-
+    uint64_t rx_ring;
+    uint64_t rx_descriptor;
+    uint64_t tx_ring;
+    uint64_t tx_descriptor;
 
     uint32_t phy_status;
     uint32_t phy_control;
-- 
2.34.1


