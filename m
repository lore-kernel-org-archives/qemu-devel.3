Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEE2FED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMB4-0005Pa-7Z; Fri, 24 Apr 2026 15:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMB1-000556-W3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:27:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMAz-0001hF-FV
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so90757515e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058815; x=1777663615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RxfzJlmuo8tmdqUwHdWNSQl/LrnZoeealET/va5hRPU=;
 b=PLX87zMdVytnvUnsgvW7WHAif3rzp7pRTXNR/w9i3rcC0LdZ4ZRdf6bFiliGUGmQ5L
 zjfrVz3zSVvTboRx0EWAdfL38wMRPrt/l3E76uBds0IugVBbNxYUF4VdE54SfaqxoLvE
 05R6LiSep79xMuIiXVpLv7d8Bma2A72zFBuWxvkAzqgEHuhI09xT+2GJb/ONo7RvFoob
 /Iv6l3CdMOJGqTfjeQZBO6ftEX/ygqi9gTpbMUxaU5idmWlOhDoqYcbgd3+NWX5w4P6S
 Yt2RpDQ7W31nCzG+LpZoIhelF8iHkJr08ejBHEfJ8nG/gjKfyNLo+60WxsRoTzo+ReD9
 cDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058815; x=1777663615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RxfzJlmuo8tmdqUwHdWNSQl/LrnZoeealET/va5hRPU=;
 b=NEX0sGMc3DhZdhTSDDKGV5rU0TshKgLXU/IqE1Gq33dDdHaYVO0O50EE+Y9HPba1uB
 hJtk3QkeXMAqghJUqPkmrNWhMts16h7QIaUKsZF1mkECbJ6ppZp5sKvVftxJRpDiECOV
 FXZo+kQ8gQiUZX+zqsXTXjuXMzMLs1mkSObOI0W1N1yeoMlotdIYo58tMdplWUWLCst4
 ite6u7sCNcKK2ioV6qRQ49hLOQTM3+IuIAqd62lnn7ycpX+ISpxyGY/+Z8Umu+68hHaz
 2YgeCpyI+vw7YJbLL+8wQBJS91WQctk4DlgBAk1NzRE4YdApNvEQ7nqLeKMWPNSl3qak
 lF9A==
X-Gm-Message-State: AOJu0YxUmESm/GUr8KC8nhAJdqCHDMz7F1KG/MJJm0nc8mND+YzRTKqI
 7O2UAelaB0GQjdwMDkqWpeJ4+RDYT/qmEP9pXDlb69SakAfM3zZXjFOtrvtlF53++9Mmf3w7MCh
 3lZIPuhU=
X-Gm-Gg: AeBDievO3wcY9h7XMz+GBjyK/zlsertQWva5SuT4uACZFFPi0kXd+nYZdlb5xgL5d9m
 D+Yrj3CIlX+PZDDeHOqlF/crc87NmWQO+PNOzYqfM7vofhT4z3plMgdsAdsz760HcA7ad3bgQVy
 uQF9iBQkdoBJ2eytQZBrJpqhYzHK12tHuRTSx2j8TmFOEASDBoQZG8tNgKrr/BsVapNxh2UjEKc
 c1Eloa8EzZGAs7cA8Ygj17BeGFj2bIrG2xy/wqQpKvg9+h1KhjBBpSGY0azck/fCuhVsXiIhaXK
 iFRUKulZxjhYkgTpyWwHnXEOnjf5MXkI9TmRJ8aqe0vqbPNoTvBeAclTXhfZybnrjH5pQRam5fg
 MBKRvfGDFBKf2hiFIZh61QtQ0zS3J0ypIMuGtQwPqrzTiuCBdwh1cTzVfJ90apsvqn4zPDCQ00C
 b/4IbgLLQScPka7dOW5OPCNFaN3dTZGvQfeB5VrHIAhU4FptGa20dDoOaGJ8b1TN1PX+OtHI+Tc
 dMSGXVqisaYxCcDHIJF+w==
X-Received: by 2002:a05:600c:797:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-4891a3a9f38mr213736915e9.26.1777058815231; 
 Fri, 24 Apr 2026 12:26:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7b2716sm191911485e9.30.2026.04.24.12.26.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:26:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 54/62] hw/usb/hcd-ehci: Replace DPRINTF debug logs with
 trace events
Date: Fri, 24 Apr 2026 21:25:42 +0200
Message-ID: <20260424192543.22614-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Replace legacy DPRINTF() debug logging in the EHCI host controller
implementation with QEMU trace events.

The EHCI_DEBUG macro and associated DPRINTF() definitions are
removed as they are no longer needed.

Trace events are added for:
- packet submission and completion
- queue head execution state
- periodic schedule advancement
- ITD error conditions
- port state handling
- skipped microframes

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260424080508.53992-7-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.h   | 10 ---------
 hw/usb/hcd-ehci.c   | 49 +++++++++++++++++++--------------------------
 hw/usb/trace-events |  9 +++++++++
 3 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 736407fd521..4234591cb41 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -24,16 +24,6 @@
 #include "hw/pci/pci_device.h"
 #include "hw/core/sysbus.h"
 
-#ifndef EHCI_DEBUG
-#define EHCI_DEBUG   0
-#endif
-
-#if EHCI_DEBUG
-#define DPRINTF printf
-#else
-#define DPRINTF(...)
-#endif
-
 #define MMIO_SIZE        0x1000
 #define CAPA_SIZE        0x10
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 8acaedeaa90..28a60e4c1a7 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -839,7 +839,7 @@ static USBDevice *ehci_find_device(EHCIState *ehci, uint8_t addr)
     for (i = 0; i < EHCI_PORTS; i++) {
         port = &ehci->ports[i];
         if (!(ehci->portsc[i] & PORTSC_PED)) {
-            DPRINTF("Port %d not enabled\n", i);
+            trace_usb_ehci_port_disable(i);
             continue;
         }
         dev = usb_find_device(port, addr);
@@ -1281,10 +1281,8 @@ static void ehci_execute_complete(EHCIQueue *q)
     assert(p->async == EHCI_ASYNC_INITIALIZED ||
            p->async == EHCI_ASYNC_FINISHED);
 
-    DPRINTF("execute_complete: qhaddr 0x%x, next 0x%x, qtdaddr 0x%x, "
-            "status %d, actual_length %d\n",
-            q->qhaddr, q->qh.next, q->qtdaddr,
-            p->packet.status, p->packet.actual_length);
+    trace_usb_ehci_execute_complete(q->qhaddr, q->qh.next, q->qtdaddr,
+                                    p->packet.status, p->packet.actual_length);
 
     switch (p->packet.status) {
     case USB_RET_SUCCESS:
@@ -1327,7 +1325,7 @@ static void ehci_execute_complete(EHCIQueue *q)
     } else {
         tbytes = 0;
     }
-    DPRINTF("updating tbytes to %d\n", tbytes);
+    trace_usb_ehci_qh_tbytes(tbytes);
     set_field(&q->qh.token, tbytes, QTD_TOKEN_TBYTES);
 
     ehci_finish_transfer(q, p->packet.actual_length);
@@ -1392,10 +1390,9 @@ static int ehci_execute(EHCIPacket *p, const char *action)
 
     trace_usb_ehci_packet_action(p->queue, p, action);
     usb_handle_packet(p->queue->dev, &p->packet);
-    DPRINTF("submit: qh 0x%x next 0x%x qtd 0x%x pid 0x%x len %zd endp 0x%x "
-            "status %d actual_length %d\n", p->queue->qhaddr, p->qtd.next,
-            p->qtdaddr, p->pid, p->packet.iov.size, endp, p->packet.status,
-            p->packet.actual_length);
+    trace_usb_ehci_packet_submit(p->queue->qhaddr, p->qtd.next, p->qtdaddr,
+                                 p->pid, p->packet.iov.size, endp,
+                                 p->packet.status, p->packet.actual_length);
 
     if (p->packet.actual_length > BUFF_SIZE) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -1472,7 +1469,8 @@ static int ehci_process_itd(EHCIState *ehci,
                     usb_handle_packet(dev, &ehci->ipacket);
                     usb_packet_unmap(&ehci->ipacket, &ehci->isgl);
                 } else {
-                    DPRINTF("ISOCH: attempt to address non-iso endpoint\n");
+                    trace_usb_ehci_log("ISOCH: "
+                                       "attempt to address non-iso endpoint");
                     ehci->ipacket.status = USB_RET_NAK;
                     ehci->ipacket.actual_length = 0;
                 }
@@ -1677,24 +1675,22 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
         if (ehci->usbsts & USBSTS_REC) {
             ehci_clear_usbsts(ehci, USBSTS_REC);
         } else {
-            DPRINTF("FETCHQH:  QH 0x%08x. H-bit set, reclamation status reset"
-                       " - done processing\n", q->qhaddr);
+            trace_usb_ehci_fetchqh_reclaim_done(q->qhaddr);
             ehci_set_state(ehci, async, EST_ACTIVE);
             q = NULL;
             goto out;
         }
     }
 
-#if EHCI_DEBUG
-    if (q->qhaddr != q->qh.next) {
-        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",
-               q->qhaddr,
-               q->qh.epchar & QH_EPCHAR_H,
-               q->qh.token & QTD_TOKEN_HALT,
-               q->qh.token & QTD_TOKEN_ACTIVE,
-               q->qh.next);
+    if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {
+        if (q->qhaddr != q->qh.next) {
+            trace_usb_ehci_fetchqh_dbg(q->qhaddr,
+                                       q->qh.epchar & QH_EPCHAR_H,
+                                       q->qh.token & QTD_TOKEN_HALT,
+                                       q->qh.token & QTD_TOKEN_ACTIVE,
+                                       q->qh.next);
+        }
     }
-#endif
 
     if (q->qh.token & QTD_TOKEN_HALT) {
         ehci_set_state(ehci, async, EST_HORIZONTALQH);
@@ -2161,7 +2157,7 @@ static void ehci_advance_async_state(EHCIState *ehci)
         /* make sure guest has acknowledged the doorbell interrupt */
         /* TO-DO: is this really needed? */
         if (ehci->usbsts & USBSTS_IAA) {
-            DPRINTF("IAA status bit still set.\n");
+            trace_usb_ehci_log("IAA status bit still set.");
             break;
         }
 
@@ -2226,9 +2222,7 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
         if (get_dwords(ehci, list, &entry, 1) < 0) {
             break;
         }
-
-        DPRINTF("PERIODIC state adv fr=%d.  [%08X] -> %08X\n",
-                ehci->frindex / 8, list, entry);
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, entry);
         ehci_set_fetch_addr(ehci, async, entry);
         ehci_set_state(ehci, async, EST_FETCHENTRY);
         ehci_advance_state(ehci, async);
@@ -2294,8 +2288,7 @@ static void ehci_work_bh(void *opaque)
             ehci_update_frindex(ehci, skipped_uframes);
             ehci->last_run_ns += UFRAME_TIMER_NS * skipped_uframes;
             uframes -= skipped_uframes;
-            DPRINTF("WARNING - EHCI skipped %"PRIu64" uframes\n",
-                    skipped_uframes);
+            trace_usb_ehci_skipped_uframes(skipped_uframes);
         }
 
         for (i = 0; i < uframes; i++) {
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index dd04f14add1..0d4318dcf14 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -89,6 +89,7 @@ usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"
 usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0x%08x,0x%08x"
 usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"
 usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x - c %d, h %d, dtc %d, i %d"
+usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"
 usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"
 usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"
 usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacterr %d"
@@ -100,13 +101,21 @@ usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"
 usb_ehci_port_suspend(uint32_t port) "port #%d"
 usb_ehci_port_wakeup(uint32_t port) "port #%d"
 usb_ehci_port_resume(uint32_t port) "port #%d"
+usb_ehci_port_disable(uint32_t port) "port #%d"
 usb_ehci_queue_action(void *q, const char *action) "q %p: %s"
 usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %s"
+usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, int pid, size_t len, int endp, int status, int actual_length) "qh=0x%x, next=0x%x, qtd=0x%x, pid=0x%x, len=%zd, endp=0x%x, status=%d, actual_length=%d"
 usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"
 usb_ehci_guest_bug(const char *reason) "%s"
 usb_ehci_doorbell_ring(void) ""
 usb_ehci_doorbell_ack(void) ""
 usb_ehci_dma_error(void) ""
+usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, int status, int actual_length) "qhaddr=0x%x, next=0x%x, qtdaddr=0x%x, status=%d, actual_length=%d"
+usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, reclamation status reset - done processing"
+usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08x"
+usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t entry) "frame=%d, list=0x%x, entry=0x%x"
+usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uframes"
+usb_ehci_log(const char *msg) "%s"
 
 # hcd-uhci.c
 usb_uhci_reset(void) "=== RESET ==="
-- 
2.53.0


