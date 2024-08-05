Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BECC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49H-0002lI-Rs; Mon, 05 Aug 2024 16:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XTOxZgUKCsQ3k5szqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--tavip.bounces.google.com>)
 id 1sb49E-0002R5-3C
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:40 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XTOxZgUKCsQ3k5szqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--tavip.bounces.google.com>)
 id 1sb499-0001QT-Et
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:39 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-1ff3dfaa090so56171235ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889053; x=1723493853; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=fPOF8tPVCB5RUT1vLWhA1MQiOoDtDv85xjMES2IhNfM=;
 b=UO5C5yK+f9vyyGBWhg7P0Ag64aBxXhhP5ocfdrCHBj46zIXuqLs0E2QWRQnQXyxNup
 Z0HcRVD4bUW9JS6aQcC+y2/GDGeVAb0aQOwdjBhZw4MmBDfKEC0+YoU+PuHBcrQ1hT5l
 lUXRsKjesOIpoTloak8ZprhUpfKRCJtG3rKDiU0jfTNp0+nuT4BMFgIgXZqjHu/6eYEd
 yf6gpK1AZztUbgrVLA8CrzRmmaFGcjZ2ppIWUCiKoBwBdTR18YXazeVgvMi06+cOVLuH
 FgkNS4XEajsqAlYkndo4HbyDF6C/kk85cKO8ZbIYTAT7jIHnbmbdaQgS/AzQQvYw07Wr
 L8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889053; x=1723493853;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fPOF8tPVCB5RUT1vLWhA1MQiOoDtDv85xjMES2IhNfM=;
 b=doqRgsVsPV+eQt1dYj0PIx5QfwfcoU2LrPTCkTHhgPZsvZNSgiWJefaNvw17siUgtP
 XDN8N2lqX3eKiJFPEhI8L4qQ4vr2V8yo7IFJXjB+xNZoW8dahYO1MTSNmJH//2Xfk0Pn
 qd27UurCeVPAia3aSkPv3t/YnGUVt8c6iq4NBPJOZ+Y55wqaIfMraT7VgHwgrBhlErqP
 9CxXLz3Z1bgc1omzvOVgrqpZ+WESdIaWfoEQ3D6wnrmfAIjjsmrdn0+iTIzYjRtIxqJO
 RILhNY/HFJgyFCG9kLUG6gSYZLgTaiRcCAMZtBsHUTuMwKm6GyhNi6GTxNSHdmrqayq0
 BnTw==
X-Gm-Message-State: AOJu0YzkE+g05HLuiIQyQlEjWcl04Dki59dorI57KUtk9dYA9BUuYTrX
 V9QFwy6JarhXzgRR3PURQpnvRyQCeRJTkMqJE/dVun96ZoBgLyMxtEdJH6vP+OunYmVIPTqKdw2
 1O8Zql0KYNgGQAcNf8rvd2mJlcXX0bHRGUEpis87GYOET/8050sic+6UPd7Olcl/KKlvM2mhLrN
 b4pxFHJGX5L0Guwn5N0oBJgOQECw==
X-Google-Smtp-Source: AGHT+IGa+UzwdbIld7JsQhx6EPRnqA/aNMmojNYxLGBdvPzBROaZTGG7602qUJgCnMz1HGkefTTNEeUCUg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:e742:b0:1f9:cbe5:e422
 with SMTP id
 d9443c01a7336-1ff5748d438mr4976885ad.8.1722889053049; Mon, 05 Aug 2024
 13:17:33 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:02 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-8-tavip@google.com>
Subject: [RFC PATCH 07/23] tests/unit: add system bus mock
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3XTOxZgUKCsQ3k5szqyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--tavip.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Valentin Ghita <valentinghita@google.com>

From: Valentin Ghita <valentinghita@google.com>

Add a system bus mock and the necessary memory access functions to be
able to create unit tests for device models.

Signed-off-by: Valentin Ghita <valentinghita@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/sysbus-mock.c | 314 +++++++++++++++++++++++++++++++++++++++
 tests/unit/sysbus-mock.h |  82 ++++++++++
 2 files changed, 396 insertions(+)
 create mode 100644 tests/unit/sysbus-mock.c
 create mode 100644 tests/unit/sysbus-mock.h

diff --git a/tests/unit/sysbus-mock.c b/tests/unit/sysbus-mock.c
new file mode 100644
index 0000000000..c6c654eabc
--- /dev/null
+++ b/tests/unit/sysbus-mock.c
@@ -0,0 +1,314 @@
+/*
+ * System Bus Mock
+ *
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "exec/memory.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "hw/qdev-core.h"
+
+#include "sysbus-mock.h"
+
+AddressSpace address_space_memory;
+
+/* Simulates guest memory space. */
+static uint8_t *guest_mem;
+static size_t guest_mem_size;
+
+static uint64_t memory_region_ram_device_read(void *opaque,
+                                              hwaddr addr, unsigned size)
+{
+    uint64_t data = (uint64_t)~0;
+    uint8_t *buf = opaque;
+
+    switch (size) {
+    case 1:
+        data = *(uint8_t *)(buf + addr);
+        break;
+    case 2:
+        data = *(uint16_t *)(buf + addr);
+        break;
+    case 4:
+        data = *(uint32_t *)(buf + addr);
+        break;
+    case 8:
+        data = *(uint64_t *)(buf + addr);
+        break;
+    }
+
+    return data;
+}
+
+static void memory_region_ram_device_write(void *opaque, hwaddr addr,
+                                           uint64_t data, unsigned size)
+{
+    uint8_t *buf = opaque;
+
+    switch (size) {
+    case 1:
+        *(uint8_t *)(buf + addr) = (uint8_t)data;
+        break;
+    case 2:
+        *(uint16_t *)(buf + addr) = (uint16_t)data;
+        break;
+    case 4:
+        *(uint32_t *)(buf + addr) = (uint32_t)data;
+        break;
+    case 8:
+        *(uint64_t *)(buf + addr) = data;
+        break;
+    }
+}
+
+static const MemoryRegionOps ram_device_mem_ops = {
+    .read = memory_region_ram_device_read,
+    .write = memory_region_ram_device_write,
+    .endianness = DEVICE_HOST_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+};
+
+void *cpu_physical_memory_map(hwaddr addr, hwaddr *plen, bool is_write)
+{
+    /* Mock implementation. Return a pointer inside the guest_mem buffer. */
+    g_assert(guest_mem != NULL);
+    g_assert(guest_mem_size <= addr + (size_t)plen);
+
+    return guest_mem + addr;
+}
+
+void cpu_physical_memory_unmap(void *buffer, hwaddr len,
+                               bool is_write, hwaddr access_len)
+{
+    /* Mock implementation. */
+}
+
+MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
+                                    MemTxAttrs attrs, void *buf, hwaddr len)
+{
+    /* Mock implementation */
+    g_assert(guest_mem != NULL);
+
+    if (guest_mem_size < addr + (size_t)len) {
+        return MEMTX_ERROR;
+    }
+
+    memcpy(buf, guest_mem + addr, len);
+
+    return MEMTX_OK;
+}
+
+MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
+                                MemTxAttrs attrs,
+                                const void *buf, hwaddr len)
+{
+    /* Mock implementation */
+    g_assert(guest_mem != NULL);
+
+    if (guest_mem_size < addr + (size_t)len) {
+        return MEMTX_ERROR;
+    }
+
+    memcpy(guest_mem + addr, buf, len);
+
+    return MEMTX_OK;
+}
+
+MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
+                             void *buf, hwaddr len, bool is_write)
+{
+    if (is_write) {
+        return address_space_write(as, addr, attrs, buf, len);
+    } else {
+        return address_space_read_full(as, addr, attrs, buf, len);
+    }
+}
+
+void cpu_physical_memory_rw(hwaddr addr, void *buf,
+                            hwaddr len, bool is_write)
+{
+    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                     buf, len, is_write);
+}
+
+void memory_region_init_io(MemoryRegion *mr, Object *owner,
+                           const MemoryRegionOps *ops, void *opaque,
+                           const char *name, uint64_t size)
+{
+    /* Mock implementation. */
+    mr->size = size;
+    mr->ops = ops;
+    mr->opaque = opaque;
+}
+
+void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
+                                       const char *name, uint64_t size,
+                                       void *ptr)
+{
+    mr->size = size;
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = ptr;
+}
+
+void memory_region_set_readonly(MemoryRegion *mr, bool readonly)
+{
+    if (mr->readonly != readonly) {
+        mr->readonly = readonly;
+    }
+}
+
+void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
+{
+    assert(n >= 0 && n < dev->num_mmio);
+    dev->mmio[n].addr = addr;
+    dev->mmio[n].memory->addr = addr;
+}
+
+void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
+{
+    /* Mock implementation. */
+    assert(dev->num_mmio < QDEV_MAX_MMIO);
+    int n = dev->num_mmio++;
+    dev->mmio[n].addr = -1;
+    dev->mmio[n].memory = memory;
+}
+
+static void sysbus_device_class_init(ObjectClass *klass, void *data)
+{
+    /* Mock implementation. */
+}
+
+void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p)
+{
+    qdev_init_gpio_out_named(DEVICE(dev), p, SYSBUS_DEVICE_GPIO_IRQ, 1);
+}
+
+/*
+ * Mock implementation of the sysbus device class.
+ * Including the sysbus source code is difficult because of the dependencies,
+ * so it is easier to define the type here.
+ */
+static const TypeInfo sysbus_device_type_info = {
+    .name = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(SysBusDevice),
+    .abstract = true,
+    .class_size = sizeof(SysBusDeviceClass),
+    .class_init = sysbus_device_class_init,
+};
+
+void sysbus_mock_init(void)
+{
+    type_register_static(&sysbus_device_type_info);
+}
+
+/* Find the mmio region containing an address. */
+static MemoryRegion *find_region(SysBusDevice *dev, hwaddr addr)
+{
+    int i;
+
+    for (i = 0; i < dev->num_mmio; i++) {
+        if (dev->mmio[i].addr <= addr &&
+            (addr - dev->mmio[i].addr) < dev->mmio[i].memory->size) {
+
+            return dev->mmio[i].memory;
+        }
+    }
+
+    return NULL;
+}
+
+uint32_t sysbus_mmio_read_addr(DeviceState *dev, hwaddr addr, unsigned size)
+{
+    uint64_t value;
+    MemTxResult result;
+    MemoryRegion *mem = find_region(SYS_BUS_DEVICE(dev), addr);
+
+    assert(mem != NULL);
+    assert(mem->ops->read_with_attrs != NULL || mem->ops->read != NULL);
+
+    if (mem->ops->read_with_attrs != NULL) {
+        result = mem->ops->read_with_attrs(mem->opaque, addr - mem->addr,
+                                           &value, size,
+                                           MEMTXATTRS_UNSPECIFIED);
+        assert(result == MEMTX_OK);
+    } else {
+        value = mem->ops->read(mem->opaque, addr - mem->addr, size);
+    }
+
+    return (uint32_t)value;
+}
+
+void sysbus_mmio_write_addr(DeviceState *dev, hwaddr addr, uint64_t value,
+                            unsigned size)
+{
+    MemTxResult result;
+    MemoryRegion *mem = find_region(SYS_BUS_DEVICE(dev), addr);
+
+    assert(mem != NULL);
+    assert(mem->ops->write_with_attrs != NULL || mem->ops->write != NULL);
+    assert(!mem->readonly);
+
+    if (mem->ops->write_with_attrs != NULL) {
+        result = mem->ops->write_with_attrs(mem->opaque, addr - mem->addr,
+                                            value, size,
+                                            MEMTXATTRS_UNSPECIFIED);
+        g_assert(result == MEMTX_OK);
+    } else {
+        mem->ops->write(mem->opaque, addr - mem->addr, value, size);
+    }
+}
+
+void sysbus_dev_set_guest_mem(void *mem, size_t size)
+{
+    guest_mem = mem;
+    guest_mem_size = size;
+}
+
+MemTxResult sysbus_mmio_read_addr_raw(DeviceState *dev, hwaddr addr,
+                                      uint64_t *value, unsigned size)
+{
+    uint64_t tmp;
+    MemTxResult result;
+    MemoryRegion *mem = find_region(SYS_BUS_DEVICE(dev), addr);
+
+    assert(mem != NULL);
+
+    result = mem->ops->read_with_attrs(dev, addr - mem->addr, &tmp,
+                                       size,
+                                       MEMTXATTRS_UNSPECIFIED);
+    *value = tmp;
+    return result;
+}
+
+MemTxResult sysbus_mmio_write_addr_raw(DeviceState *dev, hwaddr addr,
+                                       uint64_t value, unsigned size)
+{
+    MemoryRegion *mem = find_region(SYS_BUS_DEVICE(dev), addr);
+    assert(mem != NULL);
+    assert(!mem->readonly);
+
+    return mem->ops->write_with_attrs(dev, addr - mem->addr, value,
+                                      size,
+                                      MEMTXATTRS_UNSPECIFIED);
+}
diff --git a/tests/unit/sysbus-mock.h b/tests/unit/sysbus-mock.h
new file mode 100644
index 0000000000..7a4c2e7b9a
--- /dev/null
+++ b/tests/unit/sysbus-mock.h
@@ -0,0 +1,82 @@
+/*
+ * System Bus Mock
+ *
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef SYSBUS_MOCK_H
+#define SYSBUS_MOCK_H
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/sysbus.h"
+
+/*
+ * sysbus_mock_init
+ *
+ * Initialize the sysbus mock implementation.
+ */
+void sysbus_mock_init(void);
+
+/*
+ * sysbus_mmio_read_addr
+ * @dev: device structure
+ * @addr: address to read from
+ *
+ * Read from an address in a mmio region and assert on errors.
+ */
+uint32_t sysbus_mmio_read_addr(DeviceState *dev, hwaddr addr, unsigned size);
+
+/*
+ * sysbus_mmio_write_addr
+ * @dev: device structure
+ * @addr: address to write to
+ * @value: value to write
+ *
+ * Write to an address in a mmio region and assert on errors.
+ */
+void sysbus_mmio_write_addr(DeviceState *dev, hwaddr addr, uint64_t value,
+                            unsigned size);
+
+/*
+ * sysbus_dev_set_guest_mem
+ *
+ * Set guest generic memory space.
+ */
+void sysbus_dev_set_guest_mem(void *mem, size_t size);
+
+
+/*
+ * sysbus_mmio_read_addr_raw
+ * @dev: device structure
+ * @addr: address to write to
+ * @size: access size
+ *
+ * Read from an address in a mmio region and return errors.
+ *
+ * Returns: MEMTX_OK if the access was successful, MEMTX_ERROR otherwise
+ */
+MemTxResult sysbus_mmio_read_addr_raw(DeviceState *dev, hwaddr addr,
+                                      uint64_t *value, unsigned size);
+
+/*
+ * sysbus_mmio_write_addr_raw
+ * @dev: device structure
+ * @addr: address to write to
+ * @value: value to write
+ * @size: access size
+ *
+ * Write to an address in a mmio region and return errors.
+ *
+ * Returns: MEMTX_OK if the access was successful, MEMTX_ERROR otherwise
+ */
+MemTxResult sysbus_mmio_write_addr_raw(DeviceState *dev, hwaddr addr,
+                                       uint64_t value, unsigned size);
+
+#endif /* SYSBUS_MOCK_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


