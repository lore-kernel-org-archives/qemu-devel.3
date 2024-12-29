Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B064DE77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhR-0006YB-2z; Sun, 29 Dec 2024 02:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhO-0006XU-VM
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:55 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhN-00029S-Ha
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:54 -0500
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1088793466b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457212; x=1736062012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqZjoK0ZImfPOgOFtgojHS/Q0wDjVJPffV/7c5jWce0=;
 b=mDxY4TNDfaSkmP/g4r+f/cpBI2N66Mp/fsHgSn8gnn6ake+JWdds2HXYzgit5SmZbn
 1uaynuTQ+/Xrn0+6L+9g55saGwsIdEURbitl/cLeo+tW2wK6IgfefNcKqtgEzRS2T6TB
 2wXN/YnLbFei6tt/A+1FuCjjfhC42GEb3lAUKgC9JKk1yz5yNZLUZNQHF/LZe9LFt0vl
 +qeePAk4qQda7vrDW3G4HF7cT6JITiLQnOI/CsG9nxqkYKuAvicZO9naOitiR4xEkjf1
 6f1lKNmqVLVKm1xH3mBxexYeGEPxo0RKpsuuDUXvEYgIN1iDEdMKQGQzqC6I2pTS8Qxu
 UMkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBQklvsy7tJi3WrXf+MhB1MBe6FpWUxhyC5IFACI65usRuu1e9zEfSpsWogR/lKGj2vsH6ax2TguR+@nongnu.org
X-Gm-Message-State: AOJu0YzcXzV5aRQgSO/8ZlRjEVB2IY+2PtEjBgE4DQ4EdVzadgcw3SWC
 9X3ni2mAaUDjWfuOW0JzSiRglhDJ52BfJlJWzVk2564c3zJjCklT5h5rEQ==
X-Gm-Gg: ASbGncthyUfzG5tJDU0rrsGh1XBuDmleHHfMOhT8DykhRQCKGeR9ocwQ9u1k5EtgZ8x
 c++kRYV4DV4/LjJtbxnup+y/511HlN3TtDYuuIgA+DCE9B/2dy5VrFtLLdc815bjm7KHYxHRiF8
 ykhJU18+Nr25cX3Gs+Jmbjm+nx7Msy4F8X3TU0UZgYYlZx5MOptzehCRFzSyPqmDLMJdY1MhrNL
 4G4iDoWRkPkGrC2Kz3m4+u8o0I7s5a/wMDZqfJzXDXUO6af586OkMhcbv1nmEK7n0KCLCbDnnhJ
 Poo=
X-Google-Smtp-Source: AGHT+IEdlXartQrmt3BF9c3P+JhldIpvAdRxM7wJgXeS6dUWxgdqTMp2+3ZJc65rFaiWyHfRInn+WA==
X-Received: by 2002:a17:906:f5a6:b0:aae:b259:ef6c with SMTP id
 a640c23a62f3a-aaeb259f285mr2465766266b.0.1735457211916; 
 Sat, 28 Dec 2024 23:26:51 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:50 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 11/35] next-cube: move floppy disk MMIO to separate memory
 region in next-pc
Date: Sun, 29 Dec 2024 08:25:02 +0100
Message-ID: <20241229072526.166555-12-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
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

The dummy floppy disk device is part of the next-pc device, and not related to
the NeXTCube SCRs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 61 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 402e268f6b..4d7fcdd943 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -108,6 +108,7 @@ struct NeXTPC {
 
     M68kCPU *cpu;
 
+    MemoryRegion floppy_mem;
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
 
@@ -368,11 +369,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
     uint64_t val;
 
     switch (addr) {
-    case 0x14108:
-        DPRINTF("FD read @ %x\n", (unsigned int)addr);
-        val = 0x40 | 0x04 | 0x2 | 0x1;
-        break;
-
     /*
      * These 4 registers are the hardware timer, not sure which register
      * is the latch instead of data, but no problems so far.
@@ -402,13 +398,6 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
     switch (addr) {
-    case 0x14108:
-        DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
-        if (val == 0x0) {
-            /* qemu_irq_raise(s->fd_irq[0]); */
-        }
-        break;
-
     /* Hardware timer latch - not implemented yet */
     case 0x1a000:
     default:
@@ -948,6 +937,47 @@ static const TypeInfo next_scsi_info = {
     .class_init = next_scsi_class_init,
 };
 
+static void next_floppy_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    switch (addr) {
+    case 0:
+        DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
+        if (val == 0x0) {
+            /* qemu_irq_raise(s->fd_irq[0]); */
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t next_floppy_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val;
+
+    switch (addr) {
+    case 0:
+        DPRINTF("FD read @ %x\n", (unsigned int)addr);
+        val = 0x40 | 0x04 | 0x2 | 0x1;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return val;
+}
+
+static const MemoryRegionOps next_floppy_ops = {
+    .read = next_floppy_read,
+    .write = next_floppy_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void next_escc_init(DeviceState *pcdev)
 {
     DeviceState *dev;
@@ -1006,6 +1036,10 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
 
     s->scsi_reset = qdev_get_gpio_in(d, 0);
     s->scsi_dma = qdev_get_gpio_in(d, 1);
+
+    /* Floppy */
+    memory_region_add_subregion(&s->scrmem, 0x14108,
+                                &s->floppy_mem);
 }
 
 static void next_pc_init(Object *obj)
@@ -1024,6 +1058,9 @@ static void next_pc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->scrmem);
 
     object_initialize_child(obj, "next-scsi", &s->next_scsi, TYPE_NEXT_SCSI);
+
+    memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
+                          "next.floppy", 4);
 }
 
 /*
-- 
2.47.1


