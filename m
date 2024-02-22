Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01480C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7E6-0008CW-5q; Thu, 22 Feb 2024 06:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DW-00083k-2I; Thu, 22 Feb 2024 06:26:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rd7DT-0004rV-Ka; Thu, 22 Feb 2024 06:26:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8F1D64FB45;
 Thu, 22 Feb 2024 14:26:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 14A4A87171;
 Thu, 22 Feb 2024 14:26:02 +0300 (MSK)
Received: (nullmailer pid 2526149 invoked by uid 1000);
 Thu, 22 Feb 2024 11:26:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 03/34] hw/usb/ehci: Rename NB_PORTS -> EHCI_PORTS
Date: Thu, 22 Feb 2024 14:25:30 +0300
Message-Id: <20240222112601.2526057-4-mjt@tls.msk.ru>
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

Rename NB_PORTS as EHCI_PORTS to avoid definition clash
with UHCI equivalent:

  hw/usb/hcd-ehci.h:40:9: error: 'NB_PORTS' macro redefined [-Werror,-Wmacro-redefined]
  #define NB_PORTS         6        /* Max. Number of downstream ports */
          ^
  hw/usb/hcd-uhci.h:38:9: note: previous definition is here
  #define NB_PORTS 2
          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/hcd-ehci-pci.c    |  2 +-
 hw/usb/hcd-ehci-sysbus.c |  2 +-
 hw/usb/hcd-ehci.c        | 20 ++++++++++----------
 hw/usb/hcd-ehci.h        |  8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 0b26db74d8..3ff54edf62 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -83,7 +83,7 @@ static void usb_ehci_pci_init(Object *obj)
     s->capsbase = 0x00;
     s->opregbase = 0x20;
     s->portscbase = 0x44;
-    s->portnr = NB_PORTS;
+    s->portnr = EHCI_PORTS;
 
     if (!dc->hotpluggable) {
         s->companion_enable = true;
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index bfb774504c..fe1dabd0bb 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -88,7 +88,7 @@ static void ehci_sysbus_class_init(ObjectClass *klass, void *data)
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(klass);
 
     sec->portscbase = 0x44;
-    sec->portnr = NB_PORTS;
+    sec->portnr = EHCI_PORTS;
 
     dc->realize = usb_ehci_sysbus_realize;
     dc->vmsd = &vmstate_ehci_sysbus;
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 98a2860069..01864d4649 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -783,9 +783,9 @@ static void ehci_register_companion(USBBus *bus, USBPort *ports[],
     EHCIState *s = container_of(bus, EHCIState, bus);
     uint32_t i;
 
-    if (firstport + portcount > NB_PORTS) {
+    if (firstport + portcount > EHCI_PORTS) {
         error_setg(errp, "firstport must be between 0 and %u",
-                   NB_PORTS - portcount);
+                   EHCI_PORTS - portcount);
         return;
     }
 
@@ -831,7 +831,7 @@ static USBDevice *ehci_find_device(EHCIState *ehci, uint8_t addr)
     USBPort *port;
     int i;
 
-    for (i = 0; i < NB_PORTS; i++) {
+    for (i = 0; i < EHCI_PORTS; i++) {
         port = &ehci->ports[i];
         if (!(ehci->portsc[i] & PORTSC_PED)) {
             DPRINTF("Port %d not enabled\n", i);
@@ -850,7 +850,7 @@ void ehci_reset(void *opaque)
 {
     EHCIState *s = opaque;
     int i;
-    USBDevice *devs[NB_PORTS];
+    USBDevice *devs[EHCI_PORTS];
 
     trace_usb_ehci_reset();
 
@@ -858,7 +858,7 @@ void ehci_reset(void *opaque)
      * Do the detach before touching portsc, so that it correctly gets send to
      * us or to our companion based on PORTSC_POWNER before the reset.
      */
-    for(i = 0; i < NB_PORTS; i++) {
+    for(i = 0; i < EHCI_PORTS; i++) {
         devs[i] = s->ports[i].dev;
         if (devs[i] && devs[i]->attached) {
             usb_detach(&s->ports[i]);
@@ -877,7 +877,7 @@ void ehci_reset(void *opaque)
     s->astate = EST_INACTIVE;
     s->pstate = EST_INACTIVE;
 
-    for(i = 0; i < NB_PORTS; i++) {
+    for(i = 0; i < EHCI_PORTS; i++) {
         if (s->companion_ports[i]) {
             s->portsc[i] = PORTSC_POWNER | PORTSC_PPOWER;
         } else {
@@ -1086,7 +1086,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
     case CONFIGFLAG:
         val &= 0x1;
         if (val) {
-            for (i = 0; i < NB_PORTS; i++) {
+            for (i = 0; i < EHCI_PORTS; i++) {
                 handle_port_owner_write(s, i, 0);
             }
         }
@@ -2427,7 +2427,7 @@ static int usb_ehci_post_load(void *opaque, int version_id)
     EHCIState *s = opaque;
     int i;
 
-    for (i = 0; i < NB_PORTS; i++) {
+    for (i = 0; i < EHCI_PORTS; i++) {
         USBPort *companion = s->companion_ports[i];
         if (companion == NULL) {
             continue;
@@ -2509,9 +2509,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
 {
     int i;
 
-    if (s->portnr > NB_PORTS) {
+    if (s->portnr > EHCI_PORTS) {
         error_setg(errp, "Too many ports! Max. port number is %d.",
-                   NB_PORTS);
+                   EHCI_PORTS);
         return;
     }
     if (s->maxframes < 8 || s->maxframes > 512)  {
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 2cd821f49e..56a1c09d1f 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -37,7 +37,7 @@
 #define MMIO_SIZE        0x1000
 #define CAPA_SIZE        0x10
 
-#define NB_PORTS         6        /* Max. Number of downstream ports */
+#define EHCI_PORTS       6        /* Max. Number of downstream ports */
 
 typedef struct EHCIPacket EHCIPacket;
 typedef struct EHCIQueue EHCIQueue;
@@ -288,7 +288,7 @@ struct EHCIState {
             uint32_t configflag;
         };
     };
-    uint32_t portsc[NB_PORTS];
+    uint32_t portsc[EHCI_PORTS];
 
     /*
      *  Internal states, shadow registers, etc
@@ -298,8 +298,8 @@ struct EHCIState {
     bool working;
     uint32_t astate;         /* Current state in asynchronous schedule */
     uint32_t pstate;         /* Current state in periodic schedule     */
-    USBPort ports[NB_PORTS];
-    USBPort *companion_ports[NB_PORTS];
+    USBPort ports[EHCI_PORTS];
+    USBPort *companion_ports[EHCI_PORTS];
     uint32_t usbsts_pending;
     uint32_t usbsts_frindex;
     EHCIQueueHead aqueues;
-- 
2.39.2


