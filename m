Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B10BE7718F
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhH-0006Vs-9r; Sun, 29 Dec 2024 02:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnh7-0006Tj-LI
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:37 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnh6-00027Z-2z
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:37 -0500
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so1249691666b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457194; x=1736061994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BY3Nbpch55a2OXFwP4iqNPbMPRnYJkcP0SNHBbJMknQ=;
 b=jT/im3IciryrYbIHU5O3MBkNovJH3Iacrm91NAg5Y9iSsm7O8GPvdW8P5lL+v33iZV
 iD4J7EzHjFhv46W6QEQv4vyHqdut28fvIV1T72UQYUVXzZnXqelNgs5A6aIHYhJRTpkH
 64R+nZswgmNfp6UFM480ifJWICtvRjvx30XtHwCq1m+aadCfU4rf1HpHjbc9wpBc6k7z
 QxEZSkx8mD4We4Zl5ENM2drOMDF2+g+BCSrHLDeTjZRt5L09ceoO4YYJ5liqQmD6j2FN
 jkswlDnQ7eWBcpnOQkMh9rf8kRdDLnsnuu654D805zN8liYysko9qkFnrWjIkTgyVJD6
 ajvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOohtB6aHs8X7LEhff1dbFBYiEKYFgs1TN9qRGz7hbQl+gIL+krhlOiQE8wmZwnQ80U12s1QXjFT2K@nongnu.org
X-Gm-Message-State: AOJu0YyBJinj2nARk577TZOJBtSfCeWwT848hpEud6tDuQPovQEzqxTL
 NAQolMuj4BU7M8oDQm72LcmVozfTcZrva4Z54PTCw5HzG9PxLbaP
X-Gm-Gg: ASbGncuaQvTz7lVku+1bKAweYXzf4ks62OtXptatVSKzQ9RemuUBogA/i4FzWhv35zo
 SqWKHTn1/f6LqT6LiQwY/S8gQFSCadtbt2FnmGF2i0q1AqguyQHKkVOsDztK34lOIilR0cRg4kL
 ov1tUMYo9MUGQxj03OZmPRd8gzDjF+LQAGladz5Fvptk1eT6qV1JoNIUG8urrrK60cn5PqX6XlP
 Q7QdVou/WhaK9whV4IsU0Bbg34/wRuL5PYO1w24ZKGkK9LedUvCO0hgFKQw0RJezfQL/lgnh+Ou
 LmQ=
X-Google-Smtp-Source: AGHT+IGxMtt+RoVwUhGC3UA2oBFlj+RjJklGpX8jPoAE/H7P4fzfuoVz9caYRMdJHIGNRab7eyIJqA==
X-Received: by 2002:a17:906:c10d:b0:aa6:7881:1e84 with SMTP id
 a640c23a62f3a-aac2ad82cf6mr3446765366b.15.1735457194210; 
 Sat, 28 Dec 2024 23:26:34 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:33 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 04/35] next-cube: remove overlap between next.dma and next.mmio
 memory regions
Date: Sun, 29 Dec 2024 08:24:55 +0100
Message-ID: <20241229072526.166555-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Change the start of the next.mmio memory region so that it follows on directly
after the next.dma memory region. Increase the address offsets in
next_mmio_read() and next_mmio_write(), and reduce the size of the next.mmio
memory region accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 243d9e7e66..5f07791707 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -266,23 +266,23 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    case 0x7000:
+    case 0x2000:    /* 0x2007000 */
         /* DPRINTF("Read INT status: %x\n", s->int_status); */
         val = s->int_status;
         break;
 
-    case 0x7800:
+    case 0x2800:    /* 0x2007800 */
         DPRINTF("MMIO Read INT mask: %x\n", s->int_mask);
         val = s->int_mask;
         break;
 
-    case 0xc000 ... 0xc003:
-        val = extract32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+    case 0x7000 ... 0x7003:    /* 0x200c000 */
+        val = extract32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
                         size << 3);
         break;
 
-    case 0xd000 ... 0xd003:
-        val = extract32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+    case 0x8000 ... 0x8003:    /* 0x200d000 */
+        val = extract32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
                         size << 3);
         break;
 
@@ -301,25 +301,25 @@ static void next_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     NeXTPC *s = NEXT_PC(opaque);
 
     switch (addr) {
-    case 0x7000:
+    case 0x2000:    /* 0x2007000 */
         DPRINTF("INT Status old: %x new: %x\n", s->int_status,
                 (unsigned int)val);
         s->int_status = val;
         break;
 
-    case 0x7800:
+    case 0x2800:    /* 0x2007800 */
         DPRINTF("INT Mask old: %x new: %x\n", s->int_mask, (unsigned int)val);
         s->int_mask  = val;
         break;
 
-    case 0xc000 ... 0xc003:
+    case 0x7000 ... 0x7003:    /* 0x200c000 */
         DPRINTF("SCR1 Write: %x\n", (unsigned int)val);
-        s->scr1 = deposit32(s->scr1, (4 - (addr - 0xc000) - size) << 3,
+        s->scr1 = deposit32(s->scr1, (4 - (addr - 0x7000) - size) << 3,
                             size << 3, val);
         break;
 
-    case 0xd000 ... 0xd003:
-        s->scr2 = deposit32(s->scr2, (4 - (addr - 0xd000) - size) << 3,
+    case 0x8000 ... 0x8003:    /* 0x200d000 */
+        s->scr2 = deposit32(s->scr2, (4 - (addr - 0x8000) - size) << 3,
                             size << 3, val);
         next_scr2_led_update(s);
         next_scr2_rtc_update(s);
@@ -897,7 +897,7 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
-                          "next.mmio", 0xd0000);
+                          "next.mmio", 0x9000);
     memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
                           "next.scr", 0x20000);
     sysbus_init_mmio(sbd, &s->mmiomem);
@@ -999,7 +999,7 @@ static void next_cube_init(MachineState *machine)
     sysbus_create_simple(TYPE_NEXTFB, 0x0B000000, NULL);
 
     /* MMIO */
-    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02000000);
+    sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 0, 0x02005000);
 
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
-- 
2.47.1


