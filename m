Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40217C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7EA-0008Fw-Ii; Thu, 22 Feb 2024 06:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DV-00083h-G1; Thu, 22 Feb 2024 06:26:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DT-0004r4-7E; Thu, 22 Feb 2024 06:26:16 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7FB274FB44;
 Thu, 22 Feb 2024 14:26:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0525F87170;
 Thu, 22 Feb 2024 14:26:02 +0300 (MSK)
Received: (nullmailer pid 2526146 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 02/34] hw/usb/uhci: Rename NB_PORTS -> UHCI_PORTS
Date: Thu, 22 Feb 2024 14:25:29 +0300
Message-Id: <20240222112601.2526057-3-mjt@tls.msk.ru>
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

Rename NB_PORTS as UHCI_PORTS to avoid definition clash
with EHCI equivalent:

  hw/usb/hcd-uhci.h:38:9: error: 'NB_PORTS' macro redefined [-Werror,-Wmacro-redefined]
  #define NB_PORTS 2
          ^
  hw/usb/hcd-ehci.h:40:9: note: previous definition is here
  #define NB_PORTS         6        /* Max. Number of downstream ports */
          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/hcd-uhci.c | 22 +++++++++++-----------
 hw/usb/hcd-uhci.h |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index b95b47f6a4..a03cf22e69 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -322,7 +322,7 @@ static void uhci_reset(DeviceState *dev)
     s->fl_base_addr = 0;
     s->sof_timing = 64;
 
-    for(i = 0; i < NB_PORTS; i++) {
+    for(i = 0; i < UHCI_PORTS; i++) {
         port = &s->ports[i];
         port->ctrl = 0x0080;
         if (port->port.dev && port->port.dev->attached) {
@@ -364,7 +364,7 @@ static const VMStateDescription vmstate_uhci = {
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, UHCIState),
         VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState, NULL),
-        VMSTATE_STRUCT_ARRAY(ports, UHCIState, NB_PORTS, 1,
+        VMSTATE_STRUCT_ARRAY(ports, UHCIState, UHCI_PORTS, 1,
                              vmstate_uhci_port, UHCIPort),
         VMSTATE_UINT16(cmd, UHCIState),
         VMSTATE_UINT16(status, UHCIState),
@@ -404,7 +404,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             int i;
 
             /* send reset on the USB bus */
-            for(i = 0; i < NB_PORTS; i++) {
+            for(i = 0; i < UHCI_PORTS; i++) {
                 port = &s->ports[i];
                 usb_device_reset(port->port.dev);
             }
@@ -457,7 +457,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             int n;
 
             n = (addr >> 1) & 7;
-            if (n >= NB_PORTS) {
+            if (n >= UHCI_PORTS) {
                 return;
             }
             port = &s->ports[n];
@@ -514,7 +514,7 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
             UHCIPort *port;
             int n;
             n = (addr >> 1) & 7;
-            if (n >= NB_PORTS) {
+            if (n >= UHCI_PORTS) {
                 goto read_default;
             }
             port = &s->ports[n];
@@ -609,7 +609,7 @@ static USBDevice *uhci_find_device(UHCIState *s, uint8_t addr)
     USBDevice *dev;
     int i;
 
-    for (i = 0; i < NB_PORTS; i++) {
+    for (i = 0; i < UHCI_PORTS; i++) {
         UHCIPort *port = &s->ports[i];
         if (!(port->ctrl & UHCI_PORT_EN)) {
             continue;
@@ -1173,11 +1173,11 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
     s->irq = pci_allocate_irq(dev);
 
     if (s->masterbus) {
-        USBPort *ports[NB_PORTS];
-        for(i = 0; i < NB_PORTS; i++) {
+        USBPort *ports[UHCI_PORTS];
+        for(i = 0; i < UHCI_PORTS; i++) {
             ports[i] = &s->ports[i].port;
         }
-        usb_register_companion(s->masterbus, ports, NB_PORTS,
+        usb_register_companion(s->masterbus, ports, UHCI_PORTS,
                                s->firstport, s, &uhci_port_ops,
                                USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL,
                                &err);
@@ -1187,14 +1187,14 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
         }
     } else {
         usb_bus_new(&s->bus, sizeof(s->bus), &uhci_bus_ops, DEVICE(dev));
-        for (i = 0; i < NB_PORTS; i++) {
+        for (i = 0; i < UHCI_PORTS; i++) {
             usb_register_port(&s->bus, &s->ports[i].port, s, i, &uhci_port_ops,
                               USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);
         }
     }
     s->bh = qemu_bh_new_guarded(uhci_bh, s, &DEVICE(dev)->mem_reentrancy_guard);
     s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, uhci_frame_timer, s);
-    s->num_ports_vmstate = NB_PORTS;
+    s->num_ports_vmstate = UHCI_PORTS;
     QTAILQ_INIT(&s->queues);
 
     memory_region_init_io(&s->io_bar, OBJECT(s), &uhci_ioport_ops, s,
diff --git a/hw/usb/hcd-uhci.h b/hw/usb/hcd-uhci.h
index 69f8b40c49..6d26b94e92 100644
--- a/hw/usb/hcd-uhci.h
+++ b/hw/usb/hcd-uhci.h
@@ -35,7 +35,7 @@
 
 typedef struct UHCIQueue UHCIQueue;
 
-#define NB_PORTS 2
+#define UHCI_PORTS 2
 
 typedef struct UHCIPort {
     USBPort port;
@@ -59,7 +59,7 @@ typedef struct UHCIState {
     uint32_t frame_bytes;
     uint32_t frame_bandwidth;
     bool completions_only;
-    UHCIPort ports[NB_PORTS];
+    UHCIPort ports[UHCI_PORTS];
     qemu_irq irq;
     /* Interrupts that should be raised at the end of the current frame.  */
     uint32_t pending_int_mask;
-- 
2.39.2


