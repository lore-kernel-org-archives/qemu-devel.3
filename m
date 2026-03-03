Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14604EDEBFA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY8C-0004mj-BS; Tue, 03 Mar 2026 17:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY8B-0004m9-Lz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY89-0002U0-Gc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso82469855e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576535; x=1773181335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnHZYYhHEeDQDQM3nfgGAtsOROeLzMQGtMf/C+E4f2I=;
 b=YoAsbPmmZXigsDKaT0ZyhQ1eG14ELHSGgQIO6mNY6fPUWzywtlneXgkuFynDtkXfaO
 4APguHAyx3DtmXNPDgIDpoutFAAN0Ib7gUu7pqwgDMbKR6HK43rqPDlX0hUyHuajCHMu
 l81/hIOZIX8WpYRIyV4bdZ8VS94KRNKxi454eSTnTVNhEnYONnbbmUOKOSc25MsSNEO5
 WSK7Tpn9Wl4kx5Yu/vPti2jOZbdheRTqAjiyTrIzmud9IPfW1Bx0I7IUsrfJdbqtvOVa
 V7TDHQI3Z+qQPyJmh1eZkB5pmvBvliEFQedtDriN4DUw9VNRtxMq13AHApZgp2fLyLha
 6Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576535; x=1773181335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KnHZYYhHEeDQDQM3nfgGAtsOROeLzMQGtMf/C+E4f2I=;
 b=gAWwOWUqsUduuP19IqmePaIUobwe2yjwj4RjGrOmrf1Y91O2FVfwZrzwWa6J9JOm8x
 rIKTifMNHoYB9r9VfBXIRHyHpg3OUS3L1/Kjnl1iOHqahVPWgO5qoSWg1LXo2NCg+26Z
 FudCZUNMytjlBer3Omg2Nff3HW7yFA06PaUJtcw7mLZNuVcnagA1AlBOZ87Od99tkfWA
 9ekZ5YIoXwGZMJ0QyRdMQB0zxeK4rDw7Clu63/Lx5SEhoGXtUFRdY+2AmP0en77IL95i
 3gHmytSPh7awIQ3OvMsjmwhT2iYSP8f9i+O+zxyg1LDYbStFesXakSwRO+zKKC1u5Sp2
 odSw==
X-Gm-Message-State: AOJu0YwDH06IOR3u2KvYELe3Ca3LmF1LqVEfqwwJqf+jrCHj0zKU8LJK
 zC9bYS+xeNYdzZcsQMT/LV9QWb0QRex9N2cMkyI/icRB2dekKpq93nPR1l5sIQ==
X-Gm-Gg: ATEYQzy0DdyHLay3r5H92mq1ZnVwYx7dESsE/atAe5yJMlTw0hdMqFNGSN37PGr6TR0
 GOdSoSyq2wFWlhatKPDTe7fDjMg1oa4pmPIFOKvwo3NUgrj6/Zl//adiJbiPhhVFZXtRC8sGDmn
 BxrTqcmt1qRs6YaaaRUSJovHcS0I8aZlgjJ7zLL1d5BgOmXig04XiK4SXZTGO5hwrnzRGfRHlwq
 aHEdc84WmVHidCPkMIFCnWmT3u/9/c3e5igaq3HpyboMBXQGW82/QHlvv2xjl4JXckBtVr7jcOr
 6nxibiOjU4rlXP6KLFvLDCAZZOn1KNUssPVmzA/cOPXwhv5803n/3R/PZ6gCISKdBte6kf/T6mT
 3Aye07GeqwXPyym7sYB9tr6F/pcOW8EZbVeHI34w01sOrvMAJnyT5uDbvVIP9i1iYqjIJ+FUOpv
 AtKRcxBAbkPgai2ux6MvvE2lQFsadJenIcl7BGMH3dYOFytEGXBbJ/xBFaiL9cm8ROkFYXri5cP
 4ouutDpOKwXAEROlzboFKuVinu2yK4=
X-Received: by 2002:a05:600c:5395:b0:483:bcff:7948 with SMTP id
 5b1f17b1804b1-483c9b9eaf4mr306543795e9.10.1772576534934; 
 Tue, 03 Mar 2026 14:22:14 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:14 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 11/13] hw/char/serial: Keep MemoryRegionOps private
Date: Tue,  3 Mar 2026 23:21:41 +0100
Message-ID: <20260303222143.142741-12-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rather than requiring users of TYPE_SERIAL to initialize the MMIO region
themselves, make it generic enough to be configured via properties. This
makes TYPE_SERIAL more self-contained and prepares it for being turned
into a SysBusDevice.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial-mm.h |  3 --
 include/hw/char/serial.h    |  4 +-
 hw/char/diva-gsp.c          |  5 ---
 hw/char/serial-isa.c        |  1 -
 hw/char/serial-mm.c         | 51 -------------------------
 hw/char/serial-pci-multi.c  |  5 ---
 hw/char/serial-pci.c        |  1 -
 hw/char/serial.c            | 76 ++++++++++++++++++++++++++++++-------
 8 files changed, 66 insertions(+), 80 deletions(-)

diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
index 0076bdc061..4c18e2a609 100644
--- a/include/hw/char/serial-mm.h
+++ b/include/hw/char/serial-mm.h
@@ -39,9 +39,6 @@ struct SerialMM {
     SysBusDevice parent;
 
     SerialState serial;
-
-    uint8_t regshift;
-    uint8_t endianness;
 };
 
 SerialMM *serial_mm_init(MemoryRegion *address_space,
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index ea82ffac47..0cf641a860 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -62,6 +62,9 @@ struct SerialState {
     guint watch_tag;
     bool wakeup;
 
+    uint8_t regshift;
+    uint8_t endianness;
+
     /* Time when the last byte was successfully sent out of the tsr */
     uint64_t last_xmit_ts;
     Fifo8 recv_fifo;
@@ -80,7 +83,6 @@ struct SerialState {
 };
 
 extern const VMStateDescription vmstate_serial;
-extern const MemoryRegionOps serial_io_ops;
 
 #define TYPE_SERIAL "serial"
 OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 280d0413c6..2ea60103ea 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -47,7 +47,6 @@ typedef struct PCIDivaSerialState {
     MemoryRegion mailboxbar;    /* for hardware mailbox */
     uint32_t     subvendor;
     uint32_t     ports;
-    char         *name[PCI_SERIAL_MAX_PORTS];
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
@@ -64,7 +63,6 @@ static void diva_pci_exit(PCIDevice *dev)
         s = pci->state + i;
         qdev_unrealize(DEVICE(s));
         memory_region_del_subregion(&pci->membar, &s->io);
-        g_free(pci->name[i]);
     }
     qemu_free_irqs(pci->irqs, pci->ports);
 }
@@ -136,9 +134,6 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
             return;
         }
         s->irq = pci->irqs[i];
-        pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
-        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
-                              pci->name[i], 8);
 
         /* calculate offset of given port based on bitmask */
         while ((portmask & BIT(0)) == 0) {
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a4be0492c5..3a48b2495e 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -80,7 +80,6 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(s), NULL, errp);
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
 
-    memory_region_init_io(&s->io, OBJECT(isa), &serial_io_ops, s, "serial", 8);
     isa_register_ioport(isadev, &s->io, isa->iobase);
 }
 
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 0e0be26fa9..1dba4fc694 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -30,44 +30,6 @@
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
 
-static uint64_t serial_mm_read(void *opaque, hwaddr addr, unsigned size)
-{
-    SerialMM *s = SERIAL_MM(opaque);
-    return serial_io_ops.read(&s->serial, addr >> s->regshift, 1);
-}
-
-static void serial_mm_write(void *opaque, hwaddr addr,
-                            uint64_t value, unsigned size)
-{
-    SerialMM *s = SERIAL_MM(opaque);
-    value &= 255;
-    serial_io_ops.write(&s->serial, addr >> s->regshift, value, 1);
-}
-
-static const MemoryRegionOps serial_mm_ops[] = {
-    [DEVICE_NATIVE_ENDIAN] = {
-        .read = serial_mm_read,
-        .write = serial_mm_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
-        .valid.max_access_size = 8,
-        .impl.max_access_size = 8,
-    },
-    [DEVICE_LITTLE_ENDIAN] = {
-        .read = serial_mm_read,
-        .write = serial_mm_write,
-        .endianness = DEVICE_LITTLE_ENDIAN,
-        .valid.max_access_size = 8,
-        .impl.max_access_size = 8,
-    },
-    [DEVICE_BIG_ENDIAN] = {
-        .read = serial_mm_read,
-        .write = serial_mm_write,
-        .endianness = DEVICE_BIG_ENDIAN,
-        .valid.max_access_size = 8,
-        .impl.max_access_size = 8,
-    },
-};
-
 static void serial_mm_realize(DeviceState *dev, Error **errp)
 {
     SerialMM *smm = SERIAL_MM(dev);
@@ -77,9 +39,6 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_init_io(&s->io, OBJECT(dev),
-                          &serial_mm_ops[smm->endianness], smm, "serial",
-                          8 << smm->regshift);
     sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
 }
@@ -125,20 +84,10 @@ static void serial_mm_instance_init(Object *o)
     qdev_alias_all_properties(DEVICE(&smm->serial), o);
 }
 
-static const Property serial_mm_properties[] = {
-    /*
-     * Set the spacing between adjacent memory-mapped UART registers.
-     * Each register will be at (1 << regshift) bytes after the previous one.
-     */
-    DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),
-    DEFINE_PROP_UINT8("endianness", SerialMM, endianness, DEVICE_NATIVE_ENDIAN),
-};
-
 static void serial_mm_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    device_class_set_props(dc, serial_mm_properties);
     dc->realize = serial_mm_realize;
     dc->vmsd = &vmstate_serial_mm;
 }
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 17796b93dd..38e5a78e6f 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -42,7 +42,6 @@ typedef struct PCIMultiSerialState {
     PCIDevice    dev;
     MemoryRegion iobar;
     uint32_t     ports;
-    char         *name[PCI_SERIAL_MAX_PORTS];
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     IRQState     irqs[PCI_SERIAL_MAX_PORTS];
@@ -58,7 +57,6 @@ static void multi_serial_pci_exit(PCIDevice *dev)
         s = pci->state + i;
         qdev_unrealize(DEVICE(s));
         memory_region_del_subregion(&pci->iobar, &s->io);
-        g_free(pci->name[i]);
     }
 }
 
@@ -108,9 +106,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
             return;
         }
         s->irq = &pci->irqs[i];
-        pci->name[i] = g_strdup_printf("uart #%zu", i + 1);
-        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
-                              pci->name[i], 8);
         memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
         pci->ports++;
     }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index d8cacc9085..9a0bf2d890 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -56,7 +56,6 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
     pci->dev.config[PCI_INTERRUPT_PIN] = 1;
     s->irq = pci_allocate_irq(&pci->dev);
 
-    memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s, "serial", 8);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
 }
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0f3469a1e8..49227830e1 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -921,10 +921,67 @@ static int serial_be_change(void *opaque)
     return 0;
 }
 
+static const MemoryRegionOps serial_io_ops = {
+    .read = serial_ioport_read,
+    .write = serial_ioport_write,
+    .valid = {
+        .unaligned = 1,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t serial_mm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    SerialState *s = opaque;
+
+    return serial_ioport_read(s, addr >> s->regshift, 1);
+}
+
+static void serial_mm_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    SerialState *s = opaque;
+
+    serial_ioport_write(s, addr >> s->regshift, value & 0xff, 1);
+}
+
+static const MemoryRegionOps serial_mm_ops[] = {
+    [DEVICE_NATIVE_ENDIAN] = {
+        .read = serial_mm_read,
+        .write = serial_mm_write,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
+    },
+    [DEVICE_LITTLE_ENDIAN] = {
+        .read = serial_mm_read,
+        .write = serial_mm_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
+    },
+    [DEVICE_BIG_ENDIAN] = {
+        .read = serial_mm_read,
+        .write = serial_mm_write,
+        .endianness = DEVICE_BIG_ENDIAN,
+        .valid.max_access_size = 8,
+        .impl.max_access_size = 8,
+    },
+};
+
 static void serial_realize(DeviceState *dev, Error **errp)
 {
     SerialState *s = SERIAL(dev);
 
+    memory_region_init_io(&s->io, OBJECT(s),
+                          s->regshift ? &serial_mm_ops[s->endianness]
+                                      : &serial_io_ops,
+                          s, "serial", 8 << s->regshift);
+
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
@@ -952,23 +1009,16 @@ static void serial_unrealize(DeviceState *dev)
     qemu_unregister_reset(serial_reset, s);
 }
 
-const MemoryRegionOps serial_io_ops = {
-    .read = serial_ioport_read,
-    .write = serial_ioport_write,
-    .valid = {
-        .unaligned = 1,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static const Property serial_properties[] = {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
     DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
+    /*
+     * Set the spacing between adjacent memory-mapped UART registers.
+     * Each register will be at (1 << regshift) bytes after the previous one.
+     */
+    DEFINE_PROP_UINT8("regshift", SerialState, regshift, 0),
+    DEFINE_PROP_UINT8("endianness", SerialState, endianness, DEVICE_NATIVE_ENDIAN),
 };
 
 static void serial_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


