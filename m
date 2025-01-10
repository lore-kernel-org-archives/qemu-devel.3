Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DAEE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 23:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWO3R-00046W-AZ; Fri, 10 Jan 2025 18:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO3P-000464-1b
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:04:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWO3M-0006UX-R8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 18:04:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so19081545e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 15:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736550271; x=1737155071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W25jCjTw3zL4NQze2wpgw5aayT5u4S6jWvsz4SFODlI=;
 b=WafzVO0LLirEsQv8AalekUHxG/WwCMDbjKlaHwfAUPdy6McphL9y3zWlthBib62Hbl
 rtC0QbL9sygfurd+VMjgF6dXlp0frTuitvZb0/NJBg8heQ/1xC0p3zclApzO18l9S1UF
 t3aZ6r8ejqjF08hvShjUAnhlNQMwNsYrcm4aYAzPFt3jiqkaLIeTlTP8tVe7fYhWMQW+
 /oRdv4gQmM4yK2o6XZ3ow8XwHkhfAamTLCce+EiQMy+8QcOqawh83T4mZTt0eTa2QI/v
 901h7vnXCoT9LFPLrRlsx5P28ZAjj46PJPtoXYKrwIOOBrSrOUW+N2ys9D6GWt8ItBri
 QLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736550271; x=1737155071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W25jCjTw3zL4NQze2wpgw5aayT5u4S6jWvsz4SFODlI=;
 b=aiQQpcYTQKEY1xIBg6v2saMakIZTICYBUTukn+xcluo/uFSaNt3WJPUFi1EXjZt9Yl
 +SEO5CCT3KFRSAsTWa7jrkqOSX7wBarph3vBfTXrPdeaIAZcJeFq4dXwkwqxWOUyp73b
 oUxsx3q9NgWj5sOMyx2JdJ+gpKEL3wKdwhYryg626bXKlxJU6svLvN5j+HaVeuaPIwMc
 jalci+jhl3HidW1bScffMbSEuBRUKipPSGOS/tZY127gybYbKRbjNiwur+9YMwCHlfkL
 imqSGfhArw/36ygGQVCzUw2xzuam2A46KuDN/b/G2gtXL191ISNkEihOH3UKCkdKu4JC
 Zhjw==
X-Gm-Message-State: AOJu0Yx8g+ArNowTxpX0AqQNnTgHcQOPLTaH54bdRalDkl+ueMvLBJH8
 O+fbOeg2omJ4FWRkmpsVrkpAi/EUb48rZi0x5lDOpll4NXwUOTy2F0itdBY7Luz6PBz8w2o9Yqs
 WFcc=
X-Gm-Gg: ASbGncu7trbWmvDi/E6tLPTWE6NY2C/R+wDB2mnMEL5YNRFGcX0aorsTZBCZfVUGJbS
 IovcEwKxxiuDTMP3soLzRayXElL4q32tIySGy5pfSzLQDXyfgg8RoeXNAEbbftHVENPwx+dQW0m
 CvzRaVLmBnEeYelA25iUckevQYW+YhlAtf7mIRFs3aHodXGgwyNvMxyWVY3L9mdxccRUN1RBx4h
 OvsPK5EHev0Fkbe55qUUcGEZjMjCcPYh6ZYCPtaOEAfEv+SZwgfEQurCPvpJpk7gbGMJRqmpl7y
 RzZK2ZFcZYkys76xvW5xLhjFT0pQ5u9acdOo
X-Google-Smtp-Source: AGHT+IEUSPCrcAgqW6AFbYmGbNXgVOCuMRREaRBFtEd10bXg76kJBtn4IWJQy2pkCIetluf1OMs35w==
X-Received: by 2002:a05:600c:1c14:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-436e26786a3mr109228595e9.2.1736550270949; 
 Fri, 10 Jan 2025 15:04:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c23dcsm5542241f8f.101.2025.01.10.15.04.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 15:04:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/2] hw/char/serial: Convert to three-phase reset
Date: Sat, 11 Jan 2025 00:04:18 +0100
Message-ID: <20250110230418.95571-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110230418.95571-1-philmd@linaro.org>
References: <20250110230418.95571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Convert the TYPE_SERIAL (16550A UART) based devices
to three-phase reset.

Only local states are reset so use the ResetHold
handler, like other legacy devices.

TYPE_SERIAL is a plain QDev object:
- Implement and register ResetHold
- Remove call to serial_reset() in DeviceRealize
- Remove qemu_[un]register_reset() calls

For TYPE_ISA_SERIAL, TYPE_PCI_SERIAL (single and
multi):
- Implement and register ResetHold
- Call device_cold_reset(TYPE_SERIAL) in ResetHold

For TYPE_SERIAL_MM, since it is not on a QBus, we
register a global reset hook to reset the embedded
TYPE_SERIAL (see commits surrounding 751b4b7b4b7).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial-isa.c       | 10 ++++++++++
 hw/char/serial-mm.c        | 11 +++++++++++
 hw/char/serial-pci-multi.c | 19 +++++++++++++++++++
 hw/char/serial-pci.c       | 12 ++++++++++++
 hw/char/serial.c           | 10 ++++------
 5 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 2e755eaf440..29894737c61 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -53,6 +53,14 @@ static const int isa_serial_irq[MAX_ISA_SERIAL_PORTS] = {
     4, 3, 4, 3
 };
 
+static void serial_isa_reset_hold(Object *obj, ResetType type)
+{
+    ISASerialState *isa = ISA_SERIAL(obj);
+    SerialState *s = &isa->state;
+
+    device_cold_reset(DEVICE(s));
+}
+
 static void serial_isa_realizefn(DeviceState *dev, Error **errp)
 {
     static int index;
@@ -123,11 +131,13 @@ static void serial_isa_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = serial_isa_realizefn;
     dc->vmsd = &vmstate_isa_serial;
     adevc->build_dev_aml = serial_isa_build_aml;
     device_class_set_props(dc, serial_isa_properties);
+    rc->phases.hold = serial_isa_reset_hold;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 6338e7c0ba8..7208fbda526 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -29,6 +29,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
+#include "system/reset.h"
 
 static uint64_t serial_mm_read(void *opaque, hwaddr addr, unsigned size)
 {
@@ -82,6 +83,16 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
                           8 << smm->regshift);
     sysbus_init_mmio(SYS_BUS_DEVICE(smm), &s->io);
     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
+
+    /*
+     * Because this Device is not on any bus in the qbus tree (it is
+     * not a sysbus device and it's not on some other bus like a PCI
+     * bus) it will not be automatically reset by the 'reset the
+     * sysbus' hook registered by vl.c like most devices. So we must
+     * manually register a reset hook for it.
+     * TODO: there should be a better way to do this.
+     */
+    qemu_register_reset(resettable_cold_reset_fn, DEVICE(s));
 }
 
 static const VMStateDescription vmstate_serial_mm = {
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 54b6224f4da..4c7081198a0 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -90,6 +90,19 @@ static size_t multi_serial_get_port_count(PCIDeviceClass *pc)
     g_assert_not_reached();
 }
 
+static void multi_serial_pci_reset_hold(Object *obj, ResetType type)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
+    PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
+    size_t nports = multi_serial_get_port_count(pc);
+
+    for (size_t i = 0; i < nports; i++) {
+        SerialState *s = &pci->state[i];
+
+        device_cold_reset(DEVICE(s));
+    }
+}
 
 static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 {
@@ -150,6 +163,8 @@ static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
     pc->realize = multi_serial_pci_realize;
     pc->exit = multi_serial_pci_exit;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
@@ -159,12 +174,15 @@ static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_multi_serial;
     device_class_set_props(dc, multi_2x_serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    rc->phases.hold = multi_serial_pci_reset_hold;
 }
 
 static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
     pc->realize = multi_serial_pci_realize;
     pc->exit = multi_serial_pci_exit;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
@@ -174,6 +192,7 @@ static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_multi_serial;
     device_class_set_props(dc, multi_4x_serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    rc->phases.hold = multi_serial_pci_reset_hold;
 }
 
 static void multi_serial_init(Object *o)
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 4291bfc4e7f..e3e762d871c 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -44,6 +44,15 @@ struct PCISerialState {
 #define TYPE_PCI_SERIAL "pci-serial"
 OBJECT_DECLARE_SIMPLE_TYPE(PCISerialState, PCI_SERIAL)
 
+static void serial_pci_reset_hold(Object *obj, ResetType type)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
+    SerialState *s = &pci->state;
+
+    device_cold_reset(DEVICE(s));
+}
+
 static void serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
@@ -89,6 +98,8 @@ static void serial_pci_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
     pc->realize = serial_pci_realize;
     pc->exit = serial_pci_exit;
     pc->vendor_id = PCI_VENDOR_ID_REDHAT;
@@ -98,6 +109,7 @@ static void serial_pci_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_pci_serial;
     device_class_set_props(dc, serial_pci_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    rc->phases.hold = serial_pci_reset_hold;
 }
 
 static void serial_pci_init(Object *o)
diff --git a/hw/char/serial.c b/hw/char/serial.c
index cdff29ccee2..587f04c24ef 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -851,9 +851,9 @@ const VMStateDescription vmstate_serial = {
     }
 };
 
-static void serial_reset(void *opaque)
+static void serial_reset_hold(Object *obj, ResetType type)
 {
-    SerialState *s = opaque;
+    SerialState *s = (SerialState *)obj;
 
     if (s->watch_tag > 0) {
         g_source_remove(s->watch_tag);
@@ -928,13 +928,11 @@ static void serial_realize(DeviceState *dev, Error **errp)
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-    qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
                              serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
-    serial_reset(s);
 }
 
 static void serial_unrealize(DeviceState *dev)
@@ -949,8 +947,6 @@ static void serial_unrealize(DeviceState *dev)
 
     fifo8_destroy(&s->recv_fifo);
     fifo8_destroy(&s->xmit_fifo);
-
-    qemu_unregister_reset(serial_reset, s);
 }
 
 const MemoryRegionOps serial_io_ops = {
@@ -975,12 +971,14 @@ static const Property serial_properties[] = {
 static void serial_class_init(ObjectClass *klass, void* data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     /* internal device for serialio/serialmm, not user-creatable */
     dc->user_creatable = false;
     dc->realize = serial_realize;
     dc->unrealize = serial_unrealize;
     device_class_set_props(dc, serial_properties);
+    rc->phases.hold = serial_reset_hold;
 }
 
 static const TypeInfo serial_info = {
-- 
2.47.1


