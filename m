Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48EDCD3441
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXOa-0001F8-G6; Wed, 06 May 2026 04:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <specialfred453@gmail.com>)
 id 1wKRWR-0003bP-HW
 for qemu-devel@nongnu.org; Tue, 05 May 2026 21:57:59 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <specialfred453@gmail.com>)
 id 1wKRWP-0001YZ-Dm
 for qemu-devel@nongnu.org; Tue, 05 May 2026 21:57:59 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7bd5dde63dbso60615797b3.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778032675; x=1778637475; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/DYJgHssiV4kmweEJO9mPM/DVD+M0iqCY7xFajGbVUg=;
 b=CihFZMddW6QCHAiK4N3iqVuKkayuXZArbF/qo8ct5mIh52+xHj2Rk6wVtlDi6W74Nl
 OIFRTXgoE+YCes1gLOLeztrq/2wdNJ0v/nbxdHOceBaYTNCCaFetrooKdCxwo1ZNEgg1
 jLVuzjTtSK40mouwUiosZan9kiqN5oK4CeWNn4fG+Va7riVZJiaSTAA9qn95Oi+Kl/Xl
 FZ5pCFis6g7QhgcQ2LNL63UHjgVmuW9CQSRF5GlxjatAfD+oDk6ourwls5oxxrI231ke
 U/Uq77SZGHeFXgSNlPd2zsL2QJtZdsg5sKVs/VdhFDgTTUkMzGLhmud7lS4uuQAHAAjN
 rNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778032675; x=1778637475;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/DYJgHssiV4kmweEJO9mPM/DVD+M0iqCY7xFajGbVUg=;
 b=mL7kEDgjlBYM/j/XG1uLTRc/tl8wqGI/HzYLkSXlF1j8kEcJv7tzuT29YA7Pe8YTBz
 N3/bexbv0ObhcuOwS18w651WJrEYKNu3ew0G3zwNTmdtAuBITed8er1JzJY61cYHsRDy
 q6To40R5yZxKlGQ9wlyaATG33++8/xhkLO/YDJQ29DXwh4/oA+ie4X/1k7z3Qt1JOYF+
 hq6rNMAhorrK9cTMWnEPKInib4q5o5qjAvhkPjIy1uYq7MBPE1Az2F2tSn111JtCUpQ3
 0apDJxngox3DbO+oezHHZ/wjln6GCUYXruWyi996/iW/y+8kYNyi6sHMO0IEoerM7r/I
 t9cg==
X-Gm-Message-State: AOJu0Yxa+npQj11V+CvLyCykaKDhx5GrwVWFWYKLsfnBZu1CCegG86BT
 maL8Tqqlv8rAu6BWWjpE/bfuBSkSpwwi7vfu3xrMhgTzISxW43QERd4R81IEpg==
X-Gm-Gg: AeBDieuts/lt6m23dxSTqdBFEhUdNGYLbQhImv45yDwfvpJFT4CsznTu0JIHzUc+Um2
 3thU+/I1pIZDDZdQWMDl+BgbAD35p4AZ1/r54vDxmXhqLSZNRbBdKwtTy69COSbtEoWjtrzXq27
 iAWyl/HdRcgJ1kYVM/yvmoUgOH9abN612aGciFvU7nGYOJ7sFrBdxKfk7TxEtMsRU/bAlY/9EKl
 zAoUnt04UZSYC8CaqI7fuMlWQsvlS8btb2PJrLso41pjMW32DV2DXHxqGJU07yEhM3sx6GTgVEE
 7mRndS+UybgB7PwC3uu69AKRjogwP5i748HKzD0meuTNKQI5CwfgW9PSYCzgXHq8t4nDS4xU5zS
 WXj1pzapENXduiPbKjU5LRSyGjMHX8PtGvfWJVDZYZXXDDvr8V6jwaogdhCj+Ez1T6ZdvLqvKL6
 nJ4Z9L9Up1ST3GQ/OtcSWtJr1niEv1JJ6hrL6hLNG6AWHl8R+4cp7czTVplwRYKlXG2f7vlQyb6
 V6rTtcGUbEkOc50x04=
X-Received: by 2002:a05:690c:38b:b0:7bd:8cb2:4f9f with SMTP id
 00721157ae682-7bdf5df4820mr20400017b3.21.1778032674962; 
 Tue, 05 May 2026 18:57:54 -0700 (PDT)
Received: from [192.168.4.136] (1533255-static.lxtnkya2.metronetinc.net.
 [162.221.217.211]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7bd6683794dsm73829167b3.27.2026.05.05.18.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 18:57:54 -0700 (PDT)
From: specialfred453@gmail.com
Date: Tue, 05 May 2026 21:57:50 -0400
Subject: [PATCH] Changed hcd-ohci to allow up to one active packet per
 endpoint rather than up to one active packet per host controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-ohci-one-packet-per-endpoint-v1-1-295bd298c206@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBAF0KuUWTsQYyPoVcRFOvm1o5CEJIpQe
 nejLt/mrVRRFJXOw0oFL62aYsd+N5AsPt7AGrrJGns0zoycFlFOEZy9PNA4ozBiyEljY7HO+Xk
 8HcIUqBe5YNb3r79c/67P6Q5p35O27QNPjVWYgAAAAA==
X-Change-ID: 20260504-ohci-one-packet-per-endpoint-c255af493dbd
To: qemu-devel@nongnu.org
Cc: specialfred453 <specialfred453@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11765;
 i=specialfred453@gmail.com; h=from:subject:message-id;
 bh=BLfoIFN7sIcLcFocFmHTJPVu/N4uqXV1WLrtHtdePiU=;
 b=owGbwMvMwCUWkf1S/muK2CvG02pJDJm/Figadi69UBfozJY57+HcfTN8Vxi7z7I89MQ50TIj8
 8Ne8yeqHaUsDGJcDLJiiiy97dmtX/TD7HX2/6yCmcPKBDKEgYtTACYy14WRoYtbZI53T98ZZ54M
 vfmCm+/tvNo42y42UGonj7tvwDaxA4wMU36K5M8vYuQ/fvhoTPin0Aml/yZsv174u1FD+8bapef
 eMgIA
X-Developer-Key: i=specialfred453@gmail.com; a=openpgp;
 fpr=8D876B85F42F563F2CBFF97A586BE91FF56416EA
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=specialfred453@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 May 2026 04:14:14 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



---
This patch addresses an issue with the OHCI controller that is documented on 
line 999 of hw/usb/hcd-ohci.c where it states that the hardware should
allow one active packet per endpoint and that the current implementation
only allows one active packet per controller. This limitation causes
problems with some input devices, particularly when using USB
passthrough of original Xbox controllers. This doesn't appear to be an
issue when using the uhci or xhci implementations, but Xemu uses
pci-ohci for its USB implementation. 

I'm not completely sure of the implementation I've done here, but it
does appear to address the problem.

I was able to reproduce the issue using a Steel Battalion controller
passed into a VM using the Archlinux VM image, and running a small
utility I wrote that interacts with the Steel Battalion controller via
libusb-1.0. With this patch, I am no longer able to reproduce the issue.

Signed-off-by: specialfred453 <specialfred453@gmail.com>
---
 hw/usb/hcd-ohci-pci.c |   4 --
 hw/usb/hcd-ohci.c     | 127 ++++++++++++++++++++++++++++++++------------------
 hw/usb/hcd-ohci.h     |  14 ++++++
 3 files changed, 95 insertions(+), 50 deletions(-)

diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 18b58f5fcb..5ca204da28 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -87,10 +87,6 @@ static void usb_ohci_exit(PCIDevice *dev)
     trace_usb_ohci_exit(s->name);
     ohci_bus_stop(s);
 
-    if (s->async_td) {
-        usb_cancel_packet(&s->usb_packet);
-        s->async_td = 0;
-    }
     ohci_stop_endpoints(s);
 
     if (!ohci->masterbus) {
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 6ed8046fc2..c8b098448a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -299,10 +299,7 @@ void ohci_stop_endpoints(OHCIState *ohci)
     USBDevice *dev;
     int i, j;
 
-    if (ohci->async_td) {
-        usb_cancel_packet(&ohci->usb_packet);
-        ohci->async_td = 0;
-    }
+    ohci_clear_active_packets(ohci);
     for (i = 0; i < ohci->num_ports; i++) {
         dev = ohci->rhport[i].port.dev;
         if (dev && dev->attached) {
@@ -885,6 +882,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
     uint32_t addr;
     int flag_r;
     int completion;
+    USBActivePacket *packet = NULL;
+    USBActivePacket *iter;
 
     addr = ed->head & OHCI_DPTR_MASK;
     if (addr == 0) {
@@ -904,6 +903,12 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         return 1;
     }
 
+    dev = ohci_find_device(ohci, OHCI_BM(ed->flags, ED_FA));
+    if (dev == NULL) {
+        trace_usb_ohci_td_dev_error();
+        return 1;
+    }
+
     dir = OHCI_BM(ed->flags, ED_D);
     switch (dir) {
     case OHCI_TD_DIR_OUT:
@@ -937,6 +942,31 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         trace_usb_ohci_td_bad_direction(dir);
         return 1;
     }
+
+    ep = usb_ep_get(dev, pid, OHCI_BM(ed->flags, ED_EN));
+    QTAILQ_FOREACH(iter, &ohci->active_packets, next) {
+        if (iter->ep == ep) {
+            packet = iter;
+            break;
+        }
+    }
+
+    if (packet == NULL) {
+        packet = g_malloc(sizeof(USBActivePacket));
+        usb_packet_init(&packet->usb_packet);
+        packet->ep = ep;
+        packet->async_complete = false;
+        packet->async_td = 0;
+        packet->ohci = ohci;
+        QTAILQ_INSERT_TAIL(&ohci->active_packets, packet, next);
+    }
+
+    completion = (addr == packet->async_td);
+    if (completion && !packet->async_complete) {
+        trace_usb_ohci_td_skip_async();
+        return 1;
+    }
+
     if (td.cbp && td.be) {
         if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
             len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
@@ -948,8 +978,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
             }
             len = (td.be - td.cbp) + 1;
         }
-        if (len > sizeof(ohci->usb_buf)) {
-            len = sizeof(ohci->usb_buf);
+        if (len > sizeof(packet->usb_buf)) {
+            len = sizeof(packet->usb_buf);
         }
 
         pktlen = len;
@@ -971,7 +1001,7 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
                 pktlen = len;
             }
             if (!completion) {
-                if (ohci_copy_td(ohci, &td, ohci->usb_buf, pktlen,
+                if (ohci_copy_td(ohci, &td, packet->usb_buf, pktlen,
                                  DMA_DIRECTION_TO_DEVICE)) {
                     ohci_die(ohci);
                 }
@@ -985,50 +1015,39 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
     ohci_td_pkt("OUT", ohci->usb_buf, pktlen);
 
     if (completion) {
-        ohci->async_td = 0;
-        ohci->async_complete = false;
+        packet->async_td = 0;
+        packet->async_complete = false;
     } else {
-        dev = ohci_find_device(ohci, OHCI_BM(ed->flags, ED_FA));
-        if (dev == NULL) {
-            trace_usb_ohci_td_dev_error();
-            return 1;
-        }
-        ep = usb_ep_get(dev, pid, OHCI_BM(ed->flags, ED_EN));
-        if (ohci->async_td) {
-            /*
-             * ??? The hardware should allow one active packet per
-             * endpoint.  We only allow one active packet per controller.
-             * This should be sufficient as long as devices respond in a
-             * timely manner.
-             */
+        if (packet->async_td) {
+            /* Only allow one active packet per endpoint */
             trace_usb_ohci_td_too_many_pending(ep->nr);
             return 1;
         }
-        usb_packet_setup(&ohci->usb_packet, pid, ep, 0, addr, !flag_r,
+        usb_packet_setup(&packet->usb_packet, pid, ep, 0, addr, !flag_r,
                          OHCI_BM(td.flags, TD_DI) == 0);
-        usb_packet_addbuf(&ohci->usb_packet, ohci->usb_buf, pktlen);
-        usb_handle_packet(dev, &ohci->usb_packet);
-        trace_usb_ohci_td_packet_status(ohci->usb_packet.status);
+        usb_packet_addbuf(&packet->usb_packet, packet->usb_buf, pktlen);
+        usb_handle_packet(dev, &packet->usb_packet);
+        trace_usb_ohci_td_packet_status(packet->usb_packet.status);
 
-        if (ohci->usb_packet.status == USB_RET_ASYNC) {
+        if (packet->usb_packet.status == USB_RET_ASYNC) {
             usb_device_flush_ep_queue(dev, ep);
-            ohci->async_td = addr;
+            packet->async_td = addr;
             return 1;
         }
     }
-    if (ohci->usb_packet.status == USB_RET_SUCCESS) {
-        ret = ohci->usb_packet.actual_length;
+    if (packet->usb_packet.status == USB_RET_SUCCESS) {
+        ret = packet->usb_packet.actual_length;
     } else {
-        ret = ohci->usb_packet.status;
+        ret = packet->usb_packet.status;
     }
 
     if (ret >= 0) {
         if (dir == OHCI_TD_DIR_IN) {
-            if (ohci_copy_td(ohci, &td, ohci->usb_buf, ret,
+            if (ohci_copy_td(ohci, &td, packet->usb_buf, ret,
                              DMA_DIRECTION_FROM_DEVICE)) {
                 ohci_die(ohci);
             }
-            ohci_td_pkt("IN", ohci->usb_buf, pktlen);
+            ohci_td_pkt("IN", packet->usb_buf, pktlen);
         } else {
             ret = pktlen;
         }
@@ -1124,6 +1143,7 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
     int active;
     uint32_t link_cnt = 0;
     active = 0;
+    USBActivePacket *iter;
 
     if (head == 0) {
         return 0;
@@ -1141,11 +1161,13 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head)
             uint32_t addr;
             /* Cancel pending packets for ED that have been paused. */
             addr = ed.head & OHCI_DPTR_MASK;
-            if (ohci->async_td && addr == ohci->async_td) {
-                usb_cancel_packet(&ohci->usb_packet);
-                ohci->async_td = 0;
-                usb_device_ep_stopped(ohci->usb_packet.ep->dev,
-                                      ohci->usb_packet.ep);
+            QTAILQ_FOREACH(iter, &ohci->active_packets, next) {
+                if (iter->async_td && addr == iter->async_td) {
+                    usb_cancel_packet(&iter->usb_packet);
+                    iter->async_td = 0;
+                    usb_device_ep_stopped(iter->usb_packet.ep->dev,
+                                        iter->usb_packet.ep);
+                }
             }
             continue;
         }
@@ -1820,12 +1842,7 @@ static void ohci_child_detach(USBPort *port1, USBDevice *dev)
 {
     OHCIState *ohci = port1->opaque;
 
-    if (ohci->async_td &&
-        usb_packet_is_inflight(&ohci->usb_packet) &&
-        ohci->usb_packet.ep->dev == dev) {
-        usb_cancel_packet(&ohci->usb_packet);
-        ohci->async_td = 0;
-    }
+    ohci_clear_active_packets(ohci);
 }
 
 static void ohci_detach(USBPort *port1)
@@ -1955,9 +1972,8 @@ void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports,
     ohci->localmem_base = localmem_base;
 
     ohci->name = object_get_typename(OBJECT(dev));
-    usb_packet_init(&ohci->usb_packet);
 
-    ohci->async_td = 0;
+    QTAILQ_INIT(&ohci->active_packets);
 
     ohci->eof_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                    ohci_frame_boundary, ohci);
@@ -1971,10 +1987,29 @@ void ohci_sysbus_die(struct OHCIState *ohci)
 {
     trace_usb_ohci_die();
 
+    ohci_clear_active_packets(ohci);
     ohci_set_interrupt(ohci, OHCI_INTR_UE);
     ohci_bus_stop(ohci);
 }
 
+void ohci_clear_active_packets(struct OHCIState *ohci)
+{
+    while (!QTAILQ_EMPTY(&ohci->active_packets)) {
+        USBActivePacket *packet = QTAILQ_FIRST(&ohci->active_packets);
+        if (packet->async_td) {
+            usb_cancel_packet(&packet->usb_packet);
+            packet->async_td = 0;
+            if (packet->usb_packet.ep) {
+                usb_device_ep_stopped(packet->usb_packet.ep->dev,
+                    packet->usb_packet.ep);
+            }
+        }
+        QTAILQ_REMOVE(&ohci->active_packets, packet, next);
+        usb_packet_cleanup(&packet->usb_packet);
+        g_free(packet);
+    }
+}
+
 static const VMStateDescription vmstate_ohci_state_port = {
     .name = "ohci-core/port",
     .version_id = 1,
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 243cd1f46a..5ab4fa9acf 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -34,8 +34,20 @@ typedef struct OHCIPort {
     uint32_t ctrl;
 } OHCIPort;
 
+typedef struct USBActivePacket USBActivePacket;
 typedef struct OHCIState OHCIState;
 
+struct USBActivePacket {
+    USBEndpoint *ep;
+    USBPacket usb_packet;
+    uint8_t usb_buf[8192];
+    uint32_t async_td;
+    bool async_complete;
+    OHCIState *ohci;
+
+    QTAILQ_ENTRY(USBActivePacket) next;
+};
+
 struct OHCIState {
     USBBus bus;
     qemu_irq irq;
@@ -91,6 +103,7 @@ struct OHCIState {
     uint8_t usb_buf[8192];
     uint32_t async_td;
     bool async_complete;
+    QTAILQ_HEAD(, USBActivePacket) active_packets;
 
     void (*ohci_die)(OHCIState *ohci);
 };
@@ -120,5 +133,6 @@ void ohci_bus_stop(OHCIState *ohci);
 void ohci_stop_endpoints(OHCIState *ohci);
 void ohci_hard_reset(OHCIState *ohci);
 void ohci_sysbus_die(struct OHCIState *ohci);
+void ohci_clear_active_packets(struct OHCIState *ohci);
 
 #endif

---
base-commit: a85c588d07f8d3345ccad38b22026569a04571d1
change-id: 20260504-ohci-one-packet-per-endpoint-c255af493dbd

Best regards,
--  
specialfred453 <specialfred453@gmail.com>


