Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF7CCCFA05
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 12:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFBAt-0004fJ-Dc; Sat, 01 Nov 2025 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFBAo-0004f3-Ko
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:57:38 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFBAl-0006Zl-Qm
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:57:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7a23208a0c2so2553445b3a.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762001853; x=1762606653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rM4zdqzhZhgE7Wmc6sIZ0trptvMtcbCYqpaw0Htfk8k=;
 b=Ty7qbOmNMPGAcoB7JjpduPKpgB5aCvqynHM3S1HqgAxx04RzDONb6N5djeNh7v2CGD
 UWQF7ePZoY7Dr+nbkk/Ee6pA+c2GhC4v0SN52PQ3k+yHoBej1zjRnbPlWOXO10erNtkA
 ZLrwANYlzG+YUEv/9zkv5Q3hW/Ix2goL18tizIXzvVBO3SrHv/Ys7sM1v+YnELbUrNYd
 8nRNaf5dYB+Hb788lVC9pywRV+ZeHgAe6fgubGgCJoNFSHgT+RK/UAT1ISxDS1QXQPuw
 ialzRO0lg7ceb/pwhi2qhzRY45/VUVx6BV0N5rI5F3cPeNs0wvOFXLM3gtwGC95XCqkG
 OIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762001853; x=1762606653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rM4zdqzhZhgE7Wmc6sIZ0trptvMtcbCYqpaw0Htfk8k=;
 b=wXlnCF0mcIfd/YpALLxFa4PsXcTS7DspyHqZOGERm9kTpi1WXYECbg9jnrjY0nxi4I
 HUhQek/uQz1115SbkNl75C34s9GDnSyPhKpHXA3WbA0OdWtinsorIwYJSCUf3zU30ZnH
 YgIl7WVoXrzQcCgA7xuASG5vAcwZZlZeDWjCz9vc3wOJmMd7IpqYoAw/Mv6bS6tWt7cF
 jssy0Qscb+wsmWlJkq1ZLfc3oBTaoKXNhzyzSHdZ94MrrgARpEVClpw1tDOHqBGfXt0q
 R367YnVQ4o58iA4An8vKxPW6ZsPps4xd3jRRKM9IeSgHxsLEj8wEWmBYmtyxducn7tdP
 23Tw==
X-Gm-Message-State: AOJu0Yy+Qka/SThMYGlDjDCXRKPNf0rlaXn9GaJ3hI3x68PGabgUVTiI
 k1glJzVAbnXwAVJl7RrqzaY4agYvf2ZAfQKI1uoCakrdmVJn9ozI1g95Ej6YcqrChYXsLg==
X-Gm-Gg: ASbGnctk/yn15iNPnxaDJXcW4FjhpF6tscrRIETqDNU58/66w2+CalrjsDXw9AX2dOg
 keTpFp6QBOqvmWNUOIcq5+biVK2IMDdef0DMZOLtAgb8AENwYW+58Xr54kGxLi7YmXn6F+s8HWA
 CDYlCZjHT3MUnoIqT7nFI62cCrzwE82XGMNLtTErZOTLZ48Ux4Mo6OMCdLf4bITtuIjt41GHMbh
 Ec5VTE6XxVTgRsj9X7dsWpf0hBlvlGM8IZYHz/RZIoJbYVOQ9DKf4QAzJlkJEssspUl5RRKXBGm
 6xqu/cJyMzHbr81a83nHSvgPFHHCbbAcns+r42W1tCkUWZ61Xsi20arJONQWRoGqJNairByM7/n
 c7lV6hZd7AvbGpujo/3vtzeQdu1OIaQRYS8sj8B2Oi9QqSFik2ka5A09QuJK9ThnmSo2+XFfW8N
 /q8x+8stVBVWDFJOqM3EHhw5qx5DzdvVZTEFcDsXB+6CbWw/hR4Q==
X-Google-Smtp-Source: AGHT+IGZpvlgsmvLzCd66MJunbWkEahRN78ML7jRHK56J8obmcxWBWOspbtH6/nWQ2mklNGxJXocVA==
X-Received: by 2002:a05:6a00:1909:b0:780:fff4:f7db with SMTP id
 d2e1a72fcca58-7a7790dae99mr9469485b3a.15.1762001852791; 
 Sat, 01 Nov 2025 05:57:32 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db09f362sm5212550b3a.38.2025.11.01.05.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 05:57:32 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org,
	mark.cave-ayland@ilande.co.uk,
	deller@gmx.de
Cc: Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>,
 RemZapCypher <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
Date: Sat,  1 Nov 2025 18:27:25 +0530
Message-ID: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: RemZapCypher <soumyajyotisarkar23@gmail.com>

Enable the i82596 network chip which is included in the LASI
multi I/O chip. Since LASI has different start addresses on
the various machines, always initialize the LASI components
by their offsets.

As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Changes since v1:
Added proper Qemu device initialization for LASI

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h     | 20 ++++++++++++--------
 hw/hppa/machine.c           | 31 +++++++++++++++++--------------
 hw/net/lasi_i82596.c        | 30 +++++++-----------------------
 include/hw/net/lasi_82596.h |  3 ---
 4 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index d422af0429..a8a496c0e1 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -21,14 +21,6 @@
 #define DINO_SCSI_HPA   0xfff8c000
 #define LASI_HPA_715    0xf0100000
 #define LASI_HPA        0xffd00000
-#define LASI_UART_HPA   0xffd05000
-#define LASI_SCSI_HPA   0xffd06000
-#define LASI_LAN_HPA    0xffd07000
-#define LASI_RTC_HPA    0xffd09000
-#define LASI_LPT_HPA    0xffd02000
-#define LASI_AUDIO_HPA  0xffd04000
-#define LASI_PS2KBD_HPA 0xffd08000
-#define LASI_PS2MOU_HPA 0xffd08100
 #define LASI_GFX_HPA    0xf8000000
 #define ARTIST_FB_ADDR  0xf9000000
 #define CPU_HPA         0xfffb0000
@@ -44,6 +36,18 @@
 
 #define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be in f region */
 
+#define HPA_DISABLED_DEVICE     1       /* add to HPA to disable */
+
+/* LASI offsets */
+#define LASI_LPT        0x02000
+#define LASI_AUDIO      0x04000
+#define LASI_UART       0x05000
+#define LASI_SCSI       0x06000
+#define LASI_LAN        0x07000
+#define LASI_PS2        0x08000
+#define LASI_RTC        0x09000
+#define LASI_FDC        0x0A000
+
 /* offsets to DINO HPA: */
 #define DINO_PCI_ADDR           0x064
 #define DINO_CONFIG_DATA        0x068
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index cbca0026ab..8c66eed5a2 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -50,8 +50,6 @@ struct HppaMachineState {
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
 
-#define enable_lasi_lan()       0
-
 static DeviceState *lasi_dev;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
@@ -376,13 +374,6 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         }
     }
 
-    /* Network setup. */
-    if (lasi_dev) {
-        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
-                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
-                        enable_lasi_lan());
-    }
-
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
 
@@ -595,6 +586,17 @@ static void machine_HP_715_init(MachineState *machine)
         lasi_ncr710_handle_legacy_cmdline(dev);
     }
 
+    /* LASI i82596 network */
+    dev = qemu_create_nic_device(TYPE_LASI_82596, true, "lasi");
+    if (dev) {
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA));
+        memory_region_add_subregion(addr_space,
+                                    translate(NULL, LASI_HPA_715 + LASI_LAN),
+                                    sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+    }
+
     /* Add NICs, graphics & load firmware */
     machine_HP_common_init_tail(machine, NULL, translate);
 }
@@ -638,7 +640,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     assert(isa_bus);
 
     /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, translate(NULL, LASI_UART_HPA + 0x800), 0,
+    serial_mm_init(addr_space, translate(NULL, LASI_HPA + LASI_UART + 0x800), 0,
         qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
@@ -647,7 +649,8 @@ static void machine_HP_B160L_init(MachineState *machine)
         serial_hd(1), DEVICE_BIG_ENDIAN);
 
     /* Parallel port */
-    parallel_mm_init(addr_space, translate(NULL, LASI_LPT_HPA + 0x800), 0,
+    parallel_mm_init(addr_space,
+                     translate(NULL, LASI_HPA + LASI_LPT + 0x800), 0,
                      qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
                      parallel_hds[0]);
 
@@ -657,11 +660,11 @@ static void machine_HP_B160L_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA),
+                                translate(NULL, LASI_HPA + LASI_PS2),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        0));
     memory_region_add_subregion(addr_space,
-                                translate(NULL, LASI_PS2KBD_HPA + 0x100),
+                                translate(NULL, LASI_HPA + LASI_PS2 + 0x100),
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
                                                        1));
 
@@ -832,7 +835,7 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     /* can only support up to max. 8 CPUs due inventory major numbers */
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
-    mc->default_nic = NULL;
+    mc->default_nic = TYPE_LASI_82596;
 }
 
 
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 9e1dd21546..b87cea411a 100644
--- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -115,30 +115,10 @@ static void lasi_82596_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->mmio, OBJECT(d), &lasi_82596_mem_ops, d,
                 "lasi_82596-mmio", PA_GET_MACADDR + 4);
 
-    i82596_common_init(dev, s, &net_lasi_82596_info);
-}
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
-                                   qemu_irq lan_irq, gboolean match_default)
-{
-    DeviceState *dev;
-    SysBusI82596State *s;
-    static const MACAddr HP_MAC = {
-        .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
-
-    dev = qemu_create_nic_device(TYPE_LASI_82596, match_default, "lasi");
-    if (!dev) {
-        return NULL;
-    }
-
-    s = SYSBUS_I82596(dev);
-    s->state.irq = lan_irq;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    s->state.conf.macaddr = HP_MAC; /* set HP MAC prefix */
-
-    /* LASI 82596 ports in main memory. */
-    memory_region_add_subregion(addr_space, hpa, &s->state.mmio);
-    return s;
+    i82596_common_init(dev, s, &net_lasi_82596_info);
 }
 
 static void lasi_82596_reset(DeviceState *dev)
@@ -152,6 +132,10 @@ static void lasi_82596_instance_init(Object *obj)
 {
     SysBusI82596State *d = SYSBUS_I82596(obj);
     I82596State *s = &d->state;
+    static const MACAddr HP_MAC = {
+        .a = { 0x08, 0x00, 0x09, 0xef, 0x34, 0xf6 } };
+
+    s->conf.macaddr = HP_MAC;
 
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
diff --git a/include/hw/net/lasi_82596.h b/include/hw/net/lasi_82596.h
index 439356ec19..c46a4a137e 100644
--- a/include/hw/net/lasi_82596.h
+++ b/include/hw/net/lasi_82596.h
@@ -25,7 +25,4 @@ struct SysBusI82596State {
     int val_index:1;
 };
 
-SysBusI82596State *lasi_82596_init(MemoryRegion *addr_space, hwaddr hpa,
-                                   qemu_irq irq, gboolean match_default);
-
 #endif
-- 
2.49.0


