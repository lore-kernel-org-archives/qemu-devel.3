Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15E3D42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuHw-0003K0-Hk; Tue, 12 Nov 2024 12:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHV-00039G-KY; Tue, 12 Nov 2024 12:02:21 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuHT-0001SD-Lm; Tue, 12 Nov 2024 12:02:21 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso4436772b3a.3; 
 Tue, 12 Nov 2024 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430936; x=1732035736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hZzxUmUzbT/8mTdrh3yFpC6EpDXg/pxic3wE6lH+qI=;
 b=e7VcE7Tgt18IwbqKKo+NTeICTeHe72/34yB5WVnnpN2imN7wmUQ1le1rz3RZpa77Dq
 hnlUzXJr4YCT7ZxQZDQv+gBIqMdkWJaZLwlyb0CyMU0qK2nOhLEV9wGR93FMPz53eIOc
 2AauGn11tAfSEj5LOxhN3NmJtgJPxtO5Kv1ObajAvdLWynLwDmp4srhAATA/RaBNalRK
 +JRytB67g/uv0YROtae45b7Cdy0EOyvkdrjo9eL6Jh5qbeWbquIXz0+6BNniy/3cmGYT
 xK5RPM6HLkhvUvnUtFEi0lbsd4hkvoR0xSk8krPBPcjzgVY1MoEvjdDzNcl+JqQ/wzqo
 f34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430936; x=1732035736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/hZzxUmUzbT/8mTdrh3yFpC6EpDXg/pxic3wE6lH+qI=;
 b=X9uzIim9MoQwzzBTCjFITqcqDomMcf7VKDeaui8QfwGzPBncNNxeXWWCh9vyYwsy78
 fDNfguHlltTEXsU4cU8qbX4aWE+GkyuTmwLOMWMx6ImjK1M6fXzX5VOgMnRG31gt66x2
 /4n+DXEfbfw6YJg4f9FpTyEkr31FngGx2w7A0mgSwz/WxwZcT2JUCwxo0mabUdk9PFSO
 lZJSUS73zw/3yh1pTHV7c2Mk1rAPqeQcB2mrNt8jGsNFIrFT/wcr2lILYD8H7J4z67eQ
 QXN/cOriNexJdZTwcGrJ6bQNPoF9o3/MCNU+QMmEbG4vEXWsL/PBYvHD+FJG08i6xvtS
 a/UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCbDJn5+ywiGYr8TUR5IqblrUZWmgKzesEyZ8qXo4VURcyW4hsyavHznle5ec8ZWKjjZplwHvdCQ==@nongnu.org
X-Gm-Message-State: AOJu0YwVTlDmgJBVebyIVYuHV2gh0mFI1voMBJCcou2RjVSThsZrYzKu
 Jyug9uMvtUU+wIrNm4UwtzE7/1TjjMai1QlRbYwpiIzDisp+b/DHQjMEhg==
X-Google-Smtp-Source: AGHT+IHmhWPRSXUhXDwuPksFamVQySmGIr64c/IPcoWyl5j8xgkRJnFXgRWleFpjNt/eBBIw43eVuw==
X-Received: by 2002:a05:6a00:c89:b0:71e:6eb:786e with SMTP id
 d2e1a72fcca58-724132cd14amr22086885b3a.13.1731430936539; 
 Tue, 12 Nov 2024 09:02:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f5bee9asm10768956a12.28.2024.11.12.09.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 09:02:15 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RESEND PATCH 01/10] usb/uhci: checkpatch cleanup
Date: Tue, 12 Nov 2024 09:01:43 -0800
Message-ID: <20241112170152.217664-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112170152.217664-1-linux@roeck-us.net>
References: <20241112170152.217664-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Fix reported checkpatch issues to prepare for next patches
in the series.

No functional change.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since RFC:
- Rebased to v9.1.0-1673-g134b443512
- Added Reviewed-by: tag

 hw/usb/hcd-uhci.c | 90 +++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 3d0339af7b..50d488d6fb 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -67,7 +67,7 @@ struct UHCIPCIDeviceClass {
     UHCIInfo       info;
 };
 
-/* 
+/*
  * Pending async transaction.
  * 'packet' must be the first field because completion
  * handler does "(UHCIAsync *) pkt" cast.
@@ -220,8 +220,9 @@ static void uhci_async_cancel(UHCIAsync *async)
     uhci_async_unlink(async);
     trace_usb_uhci_packet_cancel(async->queue->token, async->td_addr,
                                  async->done);
-    if (!async->done)
+    if (!async->done) {
         usb_cancel_packet(&async->packet);
+    }
     uhci_async_free(async);
 }
 
@@ -322,7 +323,7 @@ static void uhci_reset(DeviceState *dev)
     s->fl_base_addr = 0;
     s->sof_timing = 64;
 
-    for(i = 0; i < UHCI_PORTS; i++) {
+    for (i = 0; i < UHCI_PORTS; i++) {
         port = &s->ports[i];
         port->ctrl = 0x0080;
         if (port->port.dev && port->port.dev->attached) {
@@ -387,7 +388,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
 
     trace_usb_uhci_mmio_writew(addr, val);
 
-    switch(addr) {
+    switch (addr) {
     case 0x00:
         if ((val & UHCI_CMD_RS) && !(s->cmd & UHCI_CMD_RS)) {
             /* start frame processing */
@@ -404,7 +405,7 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             int i;
 
             /* send reset on the USB bus */
-            for(i = 0; i < UHCI_PORTS; i++) {
+            for (i = 0; i < UHCI_PORTS; i++) {
                 port = &s->ports[i];
                 usb_device_reset(port->port.dev);
             }
@@ -425,10 +426,13 @@ static void uhci_port_write(void *opaque, hwaddr addr,
         break;
     case 0x02:
         s->status &= ~val;
-        /* XXX: the chip spec is not coherent, so we add a hidden
-           register to distinguish between IOC and SPD */
-        if (val & UHCI_STS_USBINT)
+        /*
+         * XXX: the chip spec is not coherent, so we add a hidden
+         * register to distinguish between IOC and SPD
+         */
+        if (val & UHCI_STS_USBINT) {
             s->status2 = 0;
+        }
         uhci_update_irq(s);
         break;
     case 0x04:
@@ -436,8 +440,9 @@ static void uhci_port_write(void *opaque, hwaddr addr,
         uhci_update_irq(s);
         break;
     case 0x06:
-        if (s->status & UHCI_STS_HCHALTED)
+        if (s->status & UHCI_STS_HCHALTED) {
             s->frnum = val & 0x7ff;
+        }
         break;
     case 0x08:
         s->fl_base_addr &= 0xffff0000;
@@ -464,8 +469,8 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             dev = port->port.dev;
             if (dev && dev->attached) {
                 /* port reset */
-                if ( (val & UHCI_PORT_RESET) &&
-                     !(port->ctrl & UHCI_PORT_RESET) ) {
+                if ((val & UHCI_PORT_RESET) &&
+                     !(port->ctrl & UHCI_PORT_RESET)) {
                     usb_device_reset(dev);
                 }
             }
@@ -487,7 +492,7 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
     UHCIState *s = opaque;
     uint32_t val;
 
-    switch(addr) {
+    switch (addr) {
     case 0x00:
         val = s->cmd;
         break;
@@ -533,12 +538,13 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
 }
 
 /* signal resume if controller suspended */
-static void uhci_resume (void *opaque)
+static void uhci_resume(void *opaque)
 {
     UHCIState *s = (UHCIState *)opaque;
 
-    if (!s)
+    if (!s) {
         return;
+    }
 
     if (s->cmd & UHCI_CMD_EGSM) {
         s->cmd |= UHCI_CMD_FGR;
@@ -674,7 +680,8 @@ static int uhci_handle_td_error(UHCIState *s, UHCI_TD *td, uint32_t td_addr,
     return ret;
 }
 
-static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_t *int_mask)
+static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async,
+                            uint32_t *int_mask)
 {
     int len = 0, max_len;
     uint8_t pid;
@@ -682,8 +689,9 @@ static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_
     max_len = ((td->token >> 21) + 1) & 0x7ff;
     pid = td->token & 0xff;
 
-    if (td->ctrl & TD_CTRL_IOS)
+    if (td->ctrl & TD_CTRL_IOS) {
         td->ctrl &= ~TD_CTRL_ACTIVE;
+    }
 
     if (async->packet.status != USB_RET_SUCCESS) {
         return uhci_handle_td_error(s, td, async->td_addr,
@@ -693,12 +701,15 @@ static int uhci_complete_td(UHCIState *s, UHCI_TD *td, UHCIAsync *async, uint32_
     len = async->packet.actual_length;
     td->ctrl = (td->ctrl & ~0x7ff) | ((len - 1) & 0x7ff);
 
-    /* The NAK bit may have been set by a previous frame, so clear it
-       here.  The docs are somewhat unclear, but win2k relies on this
-       behavior.  */
+    /*
+     * The NAK bit may have been set by a previous frame, so clear it
+     * here.  The docs are somewhat unclear, but win2k relies on this
+     * behavior.
+     */
     td->ctrl &= ~(TD_CTRL_ACTIVE | TD_CTRL_NAK);
-    if (td->ctrl & TD_CTRL_IOC)
+    if (td->ctrl & TD_CTRL_IOC) {
         *int_mask |= 0x01;
+    }
 
     if (pid == USB_TOKEN_IN) {
         pci_dma_write(&s->dev, td->buffer, async->buf, len);
@@ -780,9 +791,11 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
 
     if (async) {
         if (queuing) {
-            /* we are busy filling the queue, we are not prepared
-               to consume completed packages then, just leave them
-               in async state */
+            /*
+             * we are busy filling the queue, we are not prepared
+             * to consume completed packages then, just leave them
+             * in async state
+             */
             return TD_RESULT_ASYNC_CONT;
         }
         if (!async->done) {
@@ -832,7 +845,7 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
     }
     usb_packet_addbuf(&async->packet, async->buf, max_len);
 
-    switch(pid) {
+    switch (pid) {
     case USB_TOKEN_OUT:
     case USB_TOKEN_SETUP:
         pci_dma_read(&s->dev, td->buffer, async->buf, max_len);
@@ -911,12 +924,15 @@ static void qhdb_reset(QhDb *db)
 static int qhdb_insert(QhDb *db, uint32_t addr)
 {
     int i;
-    for (i = 0; i < db->count; i++)
-        if (db->addr[i] == addr)
+    for (i = 0; i < db->count; i++) {
+        if (db->addr[i] == addr) {
             return 1;
+        }
+    }
 
-    if (db->count >= UHCI_MAX_QUEUES)
+    if (db->count >= UHCI_MAX_QUEUES) {
         return 1;
+    }
 
     db->addr[db->count++] = addr;
     return 0;
@@ -970,8 +986,10 @@ static void uhci_process_frame(UHCIState *s)
 
     for (cnt = FRAME_MAX_LOOPS; is_valid(link) && cnt; cnt--) {
         if (!s->completions_only && s->frame_bytes >= s->frame_bandwidth) {
-            /* We've reached the usb 1.1 bandwidth, which is
-               1280 bytes/frame, stop processing */
+            /*
+             * We've reached the usb 1.1 bandwidth, which is
+             * 1280 bytes/frame, stop processing
+             */
             trace_usb_uhci_frame_stop_bandwidth();
             break;
         }
@@ -1120,8 +1138,10 @@ static void uhci_frame_timer(void *opaque)
         uhci_async_validate_begin(s);
         uhci_process_frame(s);
         uhci_async_validate_end(s);
-        /* The spec says frnum is the frame currently being processed, and
-         * the guest must look at frnum - 1 on interrupt, so inc frnum now */
+        /*
+         * The spec says frnum is the frame currently being processed, and
+         * the guest must look at frnum - 1 on interrupt, so inc frnum now
+         */
         s->frnum = (s->frnum + 1) & 0x7ff;
         s->expire_time += frame_t;
     }
@@ -1174,7 +1194,7 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
 
     if (s->masterbus) {
         USBPort *ports[UHCI_PORTS];
-        for(i = 0; i < UHCI_PORTS; i++) {
+        for (i = 0; i < UHCI_PORTS; i++) {
             ports[i] = &s->ports[i].port;
         }
         usb_register_companion(s->masterbus, ports, UHCI_PORTS,
@@ -1200,8 +1220,10 @@ void usb_uhci_common_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->io_bar, OBJECT(s), &uhci_ioport_ops, s,
                           "uhci", 0x20);
 
-    /* Use region 4 for consistency with real hardware.  BSD guests seem
-       to rely on this.  */
+    /*
+     * Use region 4 for consistency with real hardware.  BSD guests seem
+     * to rely on this.
+     */
     pci_register_bar(&s->dev, 4, PCI_BASE_ADDRESS_SPACE_IO, &s->io_bar);
 }
 
-- 
2.45.2


