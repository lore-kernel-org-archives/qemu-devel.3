Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E383D5E120
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 03:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Fhn-00004t-A1; Thu, 07 Nov 2024 22:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fhh-0008VJ-Jn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:33 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1t9Fhd-0001Ir-6z
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 22:30:33 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71850708dc9so1220339a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 19:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1731036628; x=1731641428;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55iqCS8kiLmLFUNlZbRqBM9OdxuIQ62bUAj7d4iMUOA=;
 b=IwY4s38aOoZbhoHRBhO8f/UIEf53xoDz/nguaSwPa0O7isa9QfXtUWPAzTAiQvky+i
 lIhc5lHYUldxQR4JiU0KV6cFRzCq8YkYvMNZJkwdHp6ClSrpi0v2Jxd9zoUBXzAv3UBh
 EJRKnEMmyeSpR4wQ2e0KD7Jd+9NF2M8JbD5oHQg9APDZ/0A9scfMN0wgnRERTkDtXl96
 ZyRbIC9OI3BOnNJKm6RW8OeXkgw0lseXokcxbbPv2+SXtBF2VHHWIPI2kKrM+weCrjqp
 71FeOoIWsnegWk3h57nv1+JbFd5auNexQKLKoF4VBnaoQwDZ+ACL/uRH8toFnFRzc8F/
 Lqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731036628; x=1731641428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55iqCS8kiLmLFUNlZbRqBM9OdxuIQ62bUAj7d4iMUOA=;
 b=bl+5Qy1Xayjo9HeE++Jmkn0xiQpYhM+tAfU8yE/ARU8hwaUULhBXRHKdQrC0yuQQX+
 u3AuKYq859VJSyZnYzZQRQL1fmucbIV9eLI5IO/nk1kM9VVo65dYY2D6sj2TNTnt5FyL
 PZ4k7s+anvQDzglDYnAan2Wv6CKCG7fR10sMFPs1tyzwTwcDDg0E6DUefjkrVv84zQZ/
 aJ6IetbTX+korFqmXeMrePXDZoYgjgU63h6iBg0/S3zCHvHaKNjimp2O4H9ZhmbdPx0T
 +89pKvtJjqT3RKzWIwpOROD3LO7DBpD92tcRXVF9frkCcYh/xNrZ/m+cQ2GH7/NM9wLI
 bp9A==
X-Gm-Message-State: AOJu0YxYOjIk8lpnK8Mng4xfd2k4azpOhD5aJZ5/btS2fnANXo0u7UxI
 +Qn7jhkPeFpNrGd5v3x4uJzof0kUVf7bHJWe3JByuX7/F8463barSnPSc4Lgz+fzB+2aQmoagd3
 5Z0U=
X-Google-Smtp-Source: AGHT+IG9VNwX5kqsMfd5bRck6seSoYmA/uLyg9tqS4gc62BQDKbBkd+4wmhGNxOurxJOdJObAlZY4A==
X-Received: by 2002:a05:6830:388a:b0:718:ce7:9b62 with SMTP id
 46e09a7af769-71a1c0e9d2dmr1947114a34.0.1731036627197; 
 Thu, 07 Nov 2024 19:30:27 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65d358sm2326435a12.84.2024.11.07.19.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:30:26 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 3/5] hw/misc: add test device for memory access
Date: Fri,  8 Nov 2024 12:29:47 +0900
Message-ID: <20241108032952.56692-4-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit adds a test device for checking memory access. The test
device generates memory regions that covers all the parameter
patterns. With this device, we can check the handling of
reading/writing the MemoryRegion is correct.

Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 hw/misc/Kconfig                         |    4 +
 hw/misc/memaccess-testdev.c             |  197 +++
 hw/misc/meson.build                     |    1 +
 include/hw/misc/memaccess-testdev.h     |   42 +
 include/hw/misc/memaccess-testdev.h.inc | 1864 +++++++++++++++++++++++
 5 files changed, 2108 insertions(+)
 create mode 100644 hw/misc/memaccess-testdev.c
 create mode 100644 include/hw/misc/memaccess-testdev.h
 create mode 100644 include/hw/misc/memaccess-testdev.h.inc

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1f1baa5dde..b90b91dc25 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -25,6 +25,10 @@ config PCI_TESTDEV
     default y if TEST_DEVICES
     depends on PCI
 
+config MEMACCESS_TESTDEV
+    bool
+    default y if TEST_DEVICES
+
 config EDU
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/memaccess-testdev.c b/hw/misc/memaccess-testdev.c
new file mode 100644
index 0000000000..8282bd3035
--- /dev/null
+++ b/hw/misc/memaccess-testdev.c
@@ -0,0 +1,197 @@
+/*
+ * QEMU memory access test device
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 IGEL Co., Ltd.
+ * Author: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
+ */
+/*
+ * This device is used to test memory acccess, like:
+ *
+ *     qemu-system-x86_64 -device memaccess-testdev,address=0x10000000
+ */
+
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+
+#include "hw/misc/memaccess-testdev.h"
+
+typedef struct MrOpsList {
+    const char *name;
+    const MemoryRegionOps *ops_array;
+    const size_t ops_array_len;
+    const size_t offset_idx;
+} MrOpsList;
+
+static void testdev_init_memory_region(MemoryRegion *mr,
+                                       Object *owner,
+                                       const MemoryRegionOps *ops,
+                                       void *opaque,
+                                       const char *name,
+                                       uint64_t size,
+                                       MemoryRegion *container,
+                                       hwaddr container_offset)
+{
+    memory_region_init_io(mr, owner, ops, opaque, name, size);
+    memory_region_add_subregion(container, container_offset, mr);
+}
+
+static void testdev_init_from_mr_ops_list(MemAccessTestDev *testdev,
+                                          const MrOpsList *l)
+{
+    for (size_t i = 0; i < l->ops_array_len; i++) {
+        g_autofree gchar *name = g_strdup_printf("%s-%ld", l->name, i);
+        testdev_init_memory_region(&testdev->memory_regions[l->offset_idx + i],
+                                   OBJECT(testdev), &l->ops_array[i],
+                                   testdev->mr_data[l->offset_idx + i],
+                                   name,
+                                   MEMACCESS_TESTDEV_REGION_SIZE,
+                                   &testdev->container,
+                                   MEMACCESS_TESTDEV_REGION_SIZE *
+                                   (l->offset_idx + i));
+    }
+}
+
+#define _DEFINE_MR_OPS_LIST(_n, _a, _l, _o)                            \
+    {                                                                  \
+        .name = (_n),                                                  \
+            .ops_array = (_a),                                         \
+            .ops_array_len = (_l),                                     \
+            .offset_idx = (_o),                                        \
+    }
+
+static const MrOpsList mr_ops_list[] = {
+    _DEFINE_MR_OPS_LIST("little-b-valid",
+                        ops_list_little_b_valid,
+                        N_OPS_LIST_LITTLE_B_VALID,
+                        OFF_IDX_OPS_LIST_LITTLE_B_VALID),
+    _DEFINE_MR_OPS_LIST("little-b-invalid",
+                        ops_list_little_b_invalid,
+                        N_OPS_LIST_LITTLE_B_INVALID,
+                        OFF_IDX_OPS_LIST_LITTLE_B_INVALID),
+    _DEFINE_MR_OPS_LIST("little-w-valid",
+                        ops_list_little_w_valid,
+                        N_OPS_LIST_LITTLE_W_VALID,
+                        OFF_IDX_OPS_LIST_LITTLE_W_VALID),
+    _DEFINE_MR_OPS_LIST("little-w-invalid",
+                        ops_list_little_w_invalid,
+                        N_OPS_LIST_LITTLE_W_INVALID,
+                        OFF_IDX_OPS_LIST_LITTLE_W_INVALID),
+    _DEFINE_MR_OPS_LIST("little-l-valid",
+                        ops_list_little_l_valid,
+                        N_OPS_LIST_LITTLE_L_VALID,
+                        OFF_IDX_OPS_LIST_LITTLE_L_VALID),
+    _DEFINE_MR_OPS_LIST("little-l-invalid",
+                        ops_list_little_l_invalid,
+                        N_OPS_LIST_LITTLE_L_INVALID,
+                        OFF_IDX_OPS_LIST_LITTLE_L_INVALID),
+    _DEFINE_MR_OPS_LIST("little-q-valid",
+                        ops_list_little_q_valid,
+                        N_OPS_LIST_LITTLE_Q_VALID,
+                        OFF_IDX_OPS_LIST_LITTLE_Q_VALID),
+    _DEFINE_MR_OPS_LIST("little-q-invalid",
+                        ops_list_little_q_invalid,
+                        N_OPS_LIST_LITTLE_Q_INVALID,
+                        OFF_IDX_OPS_LIST_LITTLE_Q_INVALID),
+    _DEFINE_MR_OPS_LIST("big-b-valid",
+                        ops_list_big_b_valid,
+                        N_OPS_LIST_BIG_B_VALID,
+                        OFF_IDX_OPS_LIST_BIG_B_VALID),
+    _DEFINE_MR_OPS_LIST("big-b-invalid",
+                        ops_list_big_b_invalid,
+                        N_OPS_LIST_BIG_B_INVALID,
+                        OFF_IDX_OPS_LIST_BIG_B_INVALID),
+    _DEFINE_MR_OPS_LIST("big-w-valid",
+                        ops_list_big_w_valid,
+                        N_OPS_LIST_BIG_W_VALID,
+                        OFF_IDX_OPS_LIST_BIG_W_VALID),
+    _DEFINE_MR_OPS_LIST("big-w-invalid",
+                        ops_list_big_w_invalid,
+                        N_OPS_LIST_BIG_W_INVALID,
+                        OFF_IDX_OPS_LIST_BIG_W_INVALID),
+    _DEFINE_MR_OPS_LIST("big-l-valid",
+                        ops_list_big_l_valid,
+                        N_OPS_LIST_LITTLE_L_VALID,
+                        OFF_IDX_OPS_LIST_BIG_L_VALID),
+    _DEFINE_MR_OPS_LIST("big-l-invalid",
+                        ops_list_big_l_invalid,
+                        N_OPS_LIST_BIG_L_INVALID,
+                        OFF_IDX_OPS_LIST_BIG_L_INVALID),
+    _DEFINE_MR_OPS_LIST("big-q-valid",
+                        ops_list_big_q_valid,
+                        N_OPS_LIST_BIG_Q_VALID,
+                        OFF_IDX_OPS_LIST_BIG_Q_VALID),
+    _DEFINE_MR_OPS_LIST("big-q-invalid",
+                        ops_list_big_q_invalid,
+                        N_OPS_LIST_BIG_Q_INVALID,
+                        OFF_IDX_OPS_LIST_BIG_Q_INVALID),
+};
+#define N_MR_OPS_LIST (sizeof(mr_ops_list) / sizeof(MrOpsList))
+
+static void init_testdev(MemAccessTestDev *testdev)
+{
+    memory_region_init(&testdev->container, OBJECT(testdev), "memtest-regions",
+                       MEMACCESS_TESTDEV_REGION_SIZE * N_OPS_LIST);
+    testdev->mr_data = g_malloc(MEMACCESS_TESTDEV_MR_DATA_SIZE);
+
+    for (size_t i = 0; i < N_MR_OPS_LIST; i++) {
+        testdev_init_from_mr_ops_list(testdev, &mr_ops_list[i]);
+    }
+
+    memory_region_add_subregion(get_system_memory(), testdev->base,
+                                &testdev->container);
+}
+
+static void memaccess_testdev_realize(DeviceState *dev, Error **errp)
+{
+    MemAccessTestDev *d = MEM_ACCESS_TEST_DEV(dev);
+
+    if (d->base == UINT64_MAX) {
+        error_setg(errp, "base address is not assigned");
+        return;
+    }
+
+    init_testdev(d);
+}
+
+static void memaccess_testdev_unrealize(DeviceState *dev)
+{
+    MemAccessTestDev *d = MEM_ACCESS_TEST_DEV(dev);
+    g_free(d->mr_data);
+}
+
+static Property memaccess_testdev_props[] = {
+    DEFINE_PROP_UINT64("address", MemAccessTestDev, base, UINT64_MAX),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void memaccess_testdev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = memaccess_testdev_realize;
+    dc->unrealize = memaccess_testdev_unrealize;
+    device_class_set_props(dc, memaccess_testdev_props);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo memaccess_testdev_info = {
+    .name = TYPE_MEM_ACCESS_TEST_DEV,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(MemAccessTestDev),
+    .class_init = memaccess_testdev_class_init,
+};
+
+static void memaccess_testdev_register_types(void)
+{
+    type_register_static(&memaccess_testdev_info);
+}
+
+type_init(memaccess_testdev_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d02d96e403..28054c5337 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
+system_ss.add(when: 'CONFIG_MEMACCESS_TESTDEV', if_true: files('memaccess-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
diff --git a/include/hw/misc/memaccess-testdev.h b/include/hw/misc/memaccess-testdev.h
new file mode 100644
index 0000000000..1909e40931
--- /dev/null
+++ b/include/hw/misc/memaccess-testdev.h
@@ -0,0 +1,42 @@
+/*
+ * QEMU memory access test device header
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 IGEL Co., Ltd.
+ * Author: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
+ */
+
+#ifndef HW_MISC_MEMACCESS_TESTDEV_H
+#define HW_MISC_MEMACCESS_TESTDEV_H
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_MEM_ACCESS_TEST_DEV "memaccess-testdev"
+
+#include "hw/misc/memaccess-testdev.h.inc"
+
+typedef uint8_t MrData[MEMACCESS_TESTDEV_REGION_SIZE];
+#define MEMACCESS_TESTDEV_MR_DATA_SIZE (sizeof(MrData) * N_OPS_LIST)
+
+typedef DeviceClass MemAccessTestDevClass;
+typedef struct MemAccessTestDev {
+    /* Private */
+    DeviceState parent_obj;
+    /* Public */
+    MemoryRegion container;
+    MemoryRegion memory_regions[N_OPS_LIST]; /* test memory regions */
+    uint64_t base;                           /* map base address */
+    MrData *mr_data;                         /* memory region data array */
+} MemAccessTestDev;
+
+#define MEM_ACCESS_TEST_DEV_GET_CLASS(obj)                              \
+    OBJECT_GET_CLASS(MemAccessTestDevClass, obj, TYPE_MEM_ACCESS_TEST_DEV)
+#define MEM_ACCESS_TEST_DEV_CLASS(klass)                                \
+    OBJECT_CLASS_CHECK(MemAccessTestDevClass, klass, TYPE_MEM_ACCESS_TEST_DEV)
+#define MEM_ACCESS_TEST_DEV(obj)                                    \
+    OBJECT_CHECK(MemAccessTestDev, obj, TYPE_MEM_ACCESS_TEST_DEV)
+
+#endif
diff --git a/include/hw/misc/memaccess-testdev.h.inc b/include/hw/misc/memaccess-testdev.h.inc
new file mode 100644
index 0000000000..d6105a7263
--- /dev/null
+++ b/include/hw/misc/memaccess-testdev.h.inc
@@ -0,0 +1,1864 @@
+/*
+ * QEMU memory access test device functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2024 IGEL Co., Ltd.
+ * Author: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
+ */
+
+#ifndef HW_MISC_MEMACCESS_TESTDEV_H_INC
+#define HW_MISC_MEMACCESS_TESTDEV_H_INC
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+
+#define MEMACCESS_TESTDEV_REGION_SIZE (32)
+
+static uint64_t memaccess_testdev_read_little(void *opaque, hwaddr addr,
+                                              unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *s = (uint8_t *)opaque + addr;
+    return ldn_le_p(s, size);
+}
+
+static void memaccess_testdev_write_little(void *opaque, hwaddr addr,
+                                           uint64_t data, unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *d = (uint8_t *)opaque + addr;
+    stn_le_p(d, size, data);
+}
+
+static uint64_t memaccess_testdev_read_big(void *opaque, hwaddr addr,
+                                           unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *s = (uint8_t *)opaque + addr;
+    return ldn_be_p(s, size);
+}
+
+static void memaccess_testdev_write_big(void *opaque, hwaddr addr,
+                                        uint64_t data, unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *d = (uint8_t *)opaque + addr;
+    stn_be_p(d, size, data);
+}
+
+#define __JOIN6(a, b, c, d, e, f) __JOIN6_AGAIN(a, b, c, d, e, f)
+#define __JOIN6_AGAIN(a, b, c, d, e, f) a##b##c##d##e##f
+#define __JOIN2(a, b) __JOIN2_AGAIN(a, b)
+#define __JOIN2_AGAIN(a, b) a##b
+#define __STR(x) __STR_AGAIN(x)
+#define __STR_AGAIN(x) #x
+
+#define NAME_OPS_LITTLE(valid_max, valid_min, valid_unaligned,          \
+                        impl_max, impl_min, impl_unaligned)             \
+    __JOIN2(ops_little,                                                 \
+            __JOIN6(valid_max, valid_min, valid_unaligned,              \
+                    impl_max, impl_min, impl_unaligned))
+
+#define NAME_OPS_BIG(valid_max, valid_min, valid_unaligned,             \
+                     impl_max, impl_min, impl_unaligned)                \
+    __JOIN2(ops_big,                                                    \
+            __JOIN6(valid_max, valid_min, valid_unaligned,              \
+                    impl_max, impl_min, impl_unaligned))
+
+#define GEN_OPS_LITTLE(valid_max,                                       \
+                       valid_min,                                       \
+                       valid_unaligned,                                 \
+                       impl_max,                                        \
+                       impl_min,                                        \
+                       impl_unaligned)                                  \
+    static const MemoryRegionOps                                        \
+    NAME_OPS_LITTLE(valid_max, valid_min, valid_unaligned,              \
+                    impl_max, impl_min, impl_unaligned)                 \
+    = {                                                                 \
+        .read = memaccess_testdev_read_little,                          \
+        .write = memaccess_testdev_write_little,                        \
+        .endianness = DEVICE_LITTLE_ENDIAN,                             \
+        .valid = {                                                      \
+            .max_access_size = valid_max,                               \
+            .min_access_size = valid_min,                               \
+            .unaligned = valid_unaligned,                               \
+        },                                                              \
+        .impl = {                                                       \
+            .max_access_size = impl_max,                                \
+            .min_access_size = impl_min,                                \
+            .unaligned = impl_unaligned,                                \
+        },                                                              \
+    };
+
+#define GEN_OPS_BIG(valid_max,                                          \
+                    valid_min,                                          \
+                    valid_unaligned,                                    \
+                    impl_max,                                           \
+                    impl_min,                                           \
+                    impl_unaligned)                                     \
+    static const MemoryRegionOps                                        \
+    NAME_OPS_BIG(valid_max, valid_min, valid_unaligned,                 \
+                 impl_max, impl_min, impl_unaligned)                    \
+    = {                                                                 \
+        .read = memaccess_testdev_read_big,                             \
+        .write = memaccess_testdev_write_big,                           \
+        .endianness = DEVICE_BIG_ENDIAN,                                \
+        .valid = {                                                      \
+            .max_access_size = valid_max,                               \
+            .min_access_size = valid_min,                               \
+            .unaligned = valid_unaligned,                               \
+        },                                                              \
+        .impl = {                                                       \
+            .max_access_size = impl_max,                                \
+            .min_access_size = impl_min,                                \
+            .unaligned = impl_unaligned,                                \
+        },                                                              \
+    };
+
+GEN_OPS_LITTLE(1, 1,  true, 1, 1,  true)
+GEN_OPS_LITTLE(1, 1,  true, 2, 1,  true)
+GEN_OPS_LITTLE(1, 1,  true, 4, 1,  true)
+GEN_OPS_LITTLE(1, 1,  true, 8, 1,  true)
+GEN_OPS_LITTLE(1, 1,  true, 2, 2,  true)
+GEN_OPS_LITTLE(1, 1,  true, 4, 2,  true)
+GEN_OPS_LITTLE(1, 1,  true, 8, 2,  true)
+GEN_OPS_LITTLE(1, 1,  true, 4, 4,  true)
+GEN_OPS_LITTLE(1, 1,  true, 8, 4,  true)
+GEN_OPS_LITTLE(1, 1,  true, 8, 8,  true)
+GEN_OPS_LITTLE(1, 1,  true, 1, 1, false)
+GEN_OPS_LITTLE(1, 1,  true, 2, 1, false)
+GEN_OPS_LITTLE(1, 1,  true, 4, 1, false)
+GEN_OPS_LITTLE(1, 1,  true, 8, 1, false)
+GEN_OPS_LITTLE(1, 1,  true, 2, 2, false)
+GEN_OPS_LITTLE(1, 1,  true, 4, 2, false)
+GEN_OPS_LITTLE(1, 1,  true, 8, 2, false)
+GEN_OPS_LITTLE(1, 1,  true, 4, 4, false)
+GEN_OPS_LITTLE(1, 1,  true, 8, 4, false)
+GEN_OPS_LITTLE(1, 1,  true, 8, 8, false)
+GEN_OPS_LITTLE(2, 1,  true, 1, 1,  true)
+GEN_OPS_LITTLE(2, 1,  true, 2, 1,  true)
+GEN_OPS_LITTLE(2, 1,  true, 4, 1,  true)
+GEN_OPS_LITTLE(2, 1,  true, 8, 1,  true)
+GEN_OPS_LITTLE(2, 1,  true, 2, 2,  true)
+GEN_OPS_LITTLE(2, 1,  true, 4, 2,  true)
+GEN_OPS_LITTLE(2, 1,  true, 8, 2,  true)
+GEN_OPS_LITTLE(2, 1,  true, 4, 4,  true)
+GEN_OPS_LITTLE(2, 1,  true, 8, 4,  true)
+GEN_OPS_LITTLE(2, 1,  true, 8, 8,  true)
+GEN_OPS_LITTLE(2, 1,  true, 1, 1, false)
+GEN_OPS_LITTLE(2, 1,  true, 2, 1, false)
+GEN_OPS_LITTLE(2, 1,  true, 4, 1, false)
+GEN_OPS_LITTLE(2, 1,  true, 8, 1, false)
+GEN_OPS_LITTLE(2, 1,  true, 2, 2, false)
+GEN_OPS_LITTLE(2, 1,  true, 4, 2, false)
+GEN_OPS_LITTLE(2, 1,  true, 8, 2, false)
+GEN_OPS_LITTLE(2, 1,  true, 4, 4, false)
+GEN_OPS_LITTLE(2, 1,  true, 8, 4, false)
+GEN_OPS_LITTLE(2, 1,  true, 8, 8, false)
+GEN_OPS_LITTLE(4, 1,  true, 1, 1,  true)
+GEN_OPS_LITTLE(4, 1,  true, 2, 1,  true)
+GEN_OPS_LITTLE(4, 1,  true, 4, 1,  true)
+GEN_OPS_LITTLE(4, 1,  true, 8, 1,  true)
+GEN_OPS_LITTLE(4, 1,  true, 2, 2,  true)
+GEN_OPS_LITTLE(4, 1,  true, 4, 2,  true)
+GEN_OPS_LITTLE(4, 1,  true, 8, 2,  true)
+GEN_OPS_LITTLE(4, 1,  true, 4, 4,  true)
+GEN_OPS_LITTLE(4, 1,  true, 8, 4,  true)
+GEN_OPS_LITTLE(4, 1,  true, 8, 8,  true)
+GEN_OPS_LITTLE(4, 1,  true, 1, 1, false)
+GEN_OPS_LITTLE(4, 1,  true, 2, 1, false)
+GEN_OPS_LITTLE(4, 1,  true, 4, 1, false)
+GEN_OPS_LITTLE(4, 1,  true, 8, 1, false)
+GEN_OPS_LITTLE(4, 1,  true, 2, 2, false)
+GEN_OPS_LITTLE(4, 1,  true, 4, 2, false)
+GEN_OPS_LITTLE(4, 1,  true, 8, 2, false)
+GEN_OPS_LITTLE(4, 1,  true, 4, 4, false)
+GEN_OPS_LITTLE(4, 1,  true, 8, 4, false)
+GEN_OPS_LITTLE(4, 1,  true, 8, 8, false)
+GEN_OPS_LITTLE(8, 1,  true, 1, 1,  true)
+GEN_OPS_LITTLE(8, 1,  true, 2, 1,  true)
+GEN_OPS_LITTLE(8, 1,  true, 4, 1,  true)
+GEN_OPS_LITTLE(8, 1,  true, 8, 1,  true)
+GEN_OPS_LITTLE(8, 1,  true, 2, 2,  true)
+GEN_OPS_LITTLE(8, 1,  true, 4, 2,  true)
+GEN_OPS_LITTLE(8, 1,  true, 8, 2,  true)
+GEN_OPS_LITTLE(8, 1,  true, 4, 4,  true)
+GEN_OPS_LITTLE(8, 1,  true, 8, 4,  true)
+GEN_OPS_LITTLE(8, 1,  true, 8, 8,  true)
+GEN_OPS_LITTLE(8, 1,  true, 1, 1, false)
+GEN_OPS_LITTLE(8, 1,  true, 2, 1, false)
+GEN_OPS_LITTLE(8, 1,  true, 4, 1, false)
+GEN_OPS_LITTLE(8, 1,  true, 8, 1, false)
+GEN_OPS_LITTLE(8, 1,  true, 2, 2, false)
+GEN_OPS_LITTLE(8, 1,  true, 4, 2, false)
+GEN_OPS_LITTLE(8, 1,  true, 8, 2, false)
+GEN_OPS_LITTLE(8, 1,  true, 4, 4, false)
+GEN_OPS_LITTLE(8, 1,  true, 8, 4, false)
+GEN_OPS_LITTLE(8, 1,  true, 8, 8, false)
+GEN_OPS_LITTLE(2, 2,  true, 1, 1,  true)
+GEN_OPS_LITTLE(2, 2,  true, 2, 1,  true)
+GEN_OPS_LITTLE(2, 2,  true, 4, 1,  true)
+GEN_OPS_LITTLE(2, 2,  true, 8, 1,  true)
+GEN_OPS_LITTLE(2, 2,  true, 2, 2,  true)
+GEN_OPS_LITTLE(2, 2,  true, 4, 2,  true)
+GEN_OPS_LITTLE(2, 2,  true, 8, 2,  true)
+GEN_OPS_LITTLE(2, 2,  true, 4, 4,  true)
+GEN_OPS_LITTLE(2, 2,  true, 8, 4,  true)
+GEN_OPS_LITTLE(2, 2,  true, 8, 8,  true)
+GEN_OPS_LITTLE(2, 2,  true, 1, 1, false)
+GEN_OPS_LITTLE(2, 2,  true, 2, 1, false)
+GEN_OPS_LITTLE(2, 2,  true, 4, 1, false)
+GEN_OPS_LITTLE(2, 2,  true, 8, 1, false)
+GEN_OPS_LITTLE(2, 2,  true, 2, 2, false)
+GEN_OPS_LITTLE(2, 2,  true, 4, 2, false)
+GEN_OPS_LITTLE(2, 2,  true, 8, 2, false)
+GEN_OPS_LITTLE(2, 2,  true, 4, 4, false)
+GEN_OPS_LITTLE(2, 2,  true, 8, 4, false)
+GEN_OPS_LITTLE(2, 2,  true, 8, 8, false)
+GEN_OPS_LITTLE(4, 2,  true, 1, 1,  true)
+GEN_OPS_LITTLE(4, 2,  true, 2, 1,  true)
+GEN_OPS_LITTLE(4, 2,  true, 4, 1,  true)
+GEN_OPS_LITTLE(4, 2,  true, 8, 1,  true)
+GEN_OPS_LITTLE(4, 2,  true, 2, 2,  true)
+GEN_OPS_LITTLE(4, 2,  true, 4, 2,  true)
+GEN_OPS_LITTLE(4, 2,  true, 8, 2,  true)
+GEN_OPS_LITTLE(4, 2,  true, 4, 4,  true)
+GEN_OPS_LITTLE(4, 2,  true, 8, 4,  true)
+GEN_OPS_LITTLE(4, 2,  true, 8, 8,  true)
+GEN_OPS_LITTLE(4, 2,  true, 1, 1, false)
+GEN_OPS_LITTLE(4, 2,  true, 2, 1, false)
+GEN_OPS_LITTLE(4, 2,  true, 4, 1, false)
+GEN_OPS_LITTLE(4, 2,  true, 8, 1, false)
+GEN_OPS_LITTLE(4, 2,  true, 2, 2, false)
+GEN_OPS_LITTLE(4, 2,  true, 4, 2, false)
+GEN_OPS_LITTLE(4, 2,  true, 8, 2, false)
+GEN_OPS_LITTLE(4, 2,  true, 4, 4, false)
+GEN_OPS_LITTLE(4, 2,  true, 8, 4, false)
+GEN_OPS_LITTLE(4, 2,  true, 8, 8, false)
+GEN_OPS_LITTLE(8, 2,  true, 1, 1,  true)
+GEN_OPS_LITTLE(8, 2,  true, 2, 1,  true)
+GEN_OPS_LITTLE(8, 2,  true, 4, 1,  true)
+GEN_OPS_LITTLE(8, 2,  true, 8, 1,  true)
+GEN_OPS_LITTLE(8, 2,  true, 2, 2,  true)
+GEN_OPS_LITTLE(8, 2,  true, 4, 2,  true)
+GEN_OPS_LITTLE(8, 2,  true, 8, 2,  true)
+GEN_OPS_LITTLE(8, 2,  true, 4, 4,  true)
+GEN_OPS_LITTLE(8, 2,  true, 8, 4,  true)
+GEN_OPS_LITTLE(8, 2,  true, 8, 8,  true)
+GEN_OPS_LITTLE(8, 2,  true, 1, 1, false)
+GEN_OPS_LITTLE(8, 2,  true, 2, 1, false)
+GEN_OPS_LITTLE(8, 2,  true, 4, 1, false)
+GEN_OPS_LITTLE(8, 2,  true, 8, 1, false)
+GEN_OPS_LITTLE(8, 2,  true, 2, 2, false)
+GEN_OPS_LITTLE(8, 2,  true, 4, 2, false)
+GEN_OPS_LITTLE(8, 2,  true, 8, 2, false)
+GEN_OPS_LITTLE(8, 2,  true, 4, 4, false)
+GEN_OPS_LITTLE(8, 2,  true, 8, 4, false)
+GEN_OPS_LITTLE(8, 2,  true, 8, 8, false)
+GEN_OPS_LITTLE(4, 4,  true, 1, 1,  true)
+GEN_OPS_LITTLE(4, 4,  true, 2, 1,  true)
+GEN_OPS_LITTLE(4, 4,  true, 4, 1,  true)
+GEN_OPS_LITTLE(4, 4,  true, 8, 1,  true)
+GEN_OPS_LITTLE(4, 4,  true, 2, 2,  true)
+GEN_OPS_LITTLE(4, 4,  true, 4, 2,  true)
+GEN_OPS_LITTLE(4, 4,  true, 8, 2,  true)
+GEN_OPS_LITTLE(4, 4,  true, 4, 4,  true)
+GEN_OPS_LITTLE(4, 4,  true, 8, 4,  true)
+GEN_OPS_LITTLE(4, 4,  true, 8, 8,  true)
+GEN_OPS_LITTLE(4, 4,  true, 1, 1, false)
+GEN_OPS_LITTLE(4, 4,  true, 2, 1, false)
+GEN_OPS_LITTLE(4, 4,  true, 4, 1, false)
+GEN_OPS_LITTLE(4, 4,  true, 8, 1, false)
+GEN_OPS_LITTLE(4, 4,  true, 2, 2, false)
+GEN_OPS_LITTLE(4, 4,  true, 4, 2, false)
+GEN_OPS_LITTLE(4, 4,  true, 8, 2, false)
+GEN_OPS_LITTLE(4, 4,  true, 4, 4, false)
+GEN_OPS_LITTLE(4, 4,  true, 8, 4, false)
+GEN_OPS_LITTLE(4, 4,  true, 8, 8, false)
+GEN_OPS_LITTLE(8, 4,  true, 1, 1,  true)
+GEN_OPS_LITTLE(8, 4,  true, 2, 1,  true)
+GEN_OPS_LITTLE(8, 4,  true, 4, 1,  true)
+GEN_OPS_LITTLE(8, 4,  true, 8, 1,  true)
+GEN_OPS_LITTLE(8, 4,  true, 2, 2,  true)
+GEN_OPS_LITTLE(8, 4,  true, 4, 2,  true)
+GEN_OPS_LITTLE(8, 4,  true, 8, 2,  true)
+GEN_OPS_LITTLE(8, 4,  true, 4, 4,  true)
+GEN_OPS_LITTLE(8, 4,  true, 8, 4,  true)
+GEN_OPS_LITTLE(8, 4,  true, 8, 8,  true)
+GEN_OPS_LITTLE(8, 4,  true, 1, 1, false)
+GEN_OPS_LITTLE(8, 4,  true, 2, 1, false)
+GEN_OPS_LITTLE(8, 4,  true, 4, 1, false)
+GEN_OPS_LITTLE(8, 4,  true, 8, 1, false)
+GEN_OPS_LITTLE(8, 4,  true, 2, 2, false)
+GEN_OPS_LITTLE(8, 4,  true, 4, 2, false)
+GEN_OPS_LITTLE(8, 4,  true, 8, 2, false)
+GEN_OPS_LITTLE(8, 4,  true, 4, 4, false)
+GEN_OPS_LITTLE(8, 4,  true, 8, 4, false)
+GEN_OPS_LITTLE(8, 4,  true, 8, 8, false)
+GEN_OPS_LITTLE(8, 8,  true, 1, 1,  true)
+GEN_OPS_LITTLE(8, 8,  true, 2, 1,  true)
+GEN_OPS_LITTLE(8, 8,  true, 4, 1,  true)
+GEN_OPS_LITTLE(8, 8,  true, 8, 1,  true)
+GEN_OPS_LITTLE(8, 8,  true, 2, 2,  true)
+GEN_OPS_LITTLE(8, 8,  true, 4, 2,  true)
+GEN_OPS_LITTLE(8, 8,  true, 8, 2,  true)
+GEN_OPS_LITTLE(8, 8,  true, 4, 4,  true)
+GEN_OPS_LITTLE(8, 8,  true, 8, 4,  true)
+GEN_OPS_LITTLE(8, 8,  true, 8, 8,  true)
+GEN_OPS_LITTLE(8, 8,  true, 1, 1, false)
+GEN_OPS_LITTLE(8, 8,  true, 2, 1, false)
+GEN_OPS_LITTLE(8, 8,  true, 4, 1, false)
+GEN_OPS_LITTLE(8, 8,  true, 8, 1, false)
+GEN_OPS_LITTLE(8, 8,  true, 2, 2, false)
+GEN_OPS_LITTLE(8, 8,  true, 4, 2, false)
+GEN_OPS_LITTLE(8, 8,  true, 8, 2, false)
+GEN_OPS_LITTLE(8, 8,  true, 4, 4, false)
+GEN_OPS_LITTLE(8, 8,  true, 8, 4, false)
+GEN_OPS_LITTLE(8, 8,  true, 8, 8, false)
+GEN_OPS_LITTLE(1, 1, false, 1, 1,  true)
+GEN_OPS_LITTLE(1, 1, false, 2, 1,  true)
+GEN_OPS_LITTLE(1, 1, false, 4, 1,  true)
+GEN_OPS_LITTLE(1, 1, false, 8, 1,  true)
+GEN_OPS_LITTLE(1, 1, false, 2, 2,  true)
+GEN_OPS_LITTLE(1, 1, false, 4, 2,  true)
+GEN_OPS_LITTLE(1, 1, false, 8, 2,  true)
+GEN_OPS_LITTLE(1, 1, false, 4, 4,  true)
+GEN_OPS_LITTLE(1, 1, false, 8, 4,  true)
+GEN_OPS_LITTLE(1, 1, false, 8, 8,  true)
+GEN_OPS_LITTLE(1, 1, false, 1, 1, false)
+GEN_OPS_LITTLE(1, 1, false, 2, 1, false)
+GEN_OPS_LITTLE(1, 1, false, 4, 1, false)
+GEN_OPS_LITTLE(1, 1, false, 8, 1, false)
+GEN_OPS_LITTLE(1, 1, false, 2, 2, false)
+GEN_OPS_LITTLE(1, 1, false, 4, 2, false)
+GEN_OPS_LITTLE(1, 1, false, 8, 2, false)
+GEN_OPS_LITTLE(1, 1, false, 4, 4, false)
+GEN_OPS_LITTLE(1, 1, false, 8, 4, false)
+GEN_OPS_LITTLE(1, 1, false, 8, 8, false)
+GEN_OPS_LITTLE(2, 1, false, 1, 1,  true)
+GEN_OPS_LITTLE(2, 1, false, 2, 1,  true)
+GEN_OPS_LITTLE(2, 1, false, 4, 1,  true)
+GEN_OPS_LITTLE(2, 1, false, 8, 1,  true)
+GEN_OPS_LITTLE(2, 1, false, 2, 2,  true)
+GEN_OPS_LITTLE(2, 1, false, 4, 2,  true)
+GEN_OPS_LITTLE(2, 1, false, 8, 2,  true)
+GEN_OPS_LITTLE(2, 1, false, 4, 4,  true)
+GEN_OPS_LITTLE(2, 1, false, 8, 4,  true)
+GEN_OPS_LITTLE(2, 1, false, 8, 8,  true)
+GEN_OPS_LITTLE(2, 1, false, 1, 1, false)
+GEN_OPS_LITTLE(2, 1, false, 2, 1, false)
+GEN_OPS_LITTLE(2, 1, false, 4, 1, false)
+GEN_OPS_LITTLE(2, 1, false, 8, 1, false)
+GEN_OPS_LITTLE(2, 1, false, 2, 2, false)
+GEN_OPS_LITTLE(2, 1, false, 4, 2, false)
+GEN_OPS_LITTLE(2, 1, false, 8, 2, false)
+GEN_OPS_LITTLE(2, 1, false, 4, 4, false)
+GEN_OPS_LITTLE(2, 1, false, 8, 4, false)
+GEN_OPS_LITTLE(2, 1, false, 8, 8, false)
+GEN_OPS_LITTLE(4, 1, false, 1, 1,  true)
+GEN_OPS_LITTLE(4, 1, false, 2, 1,  true)
+GEN_OPS_LITTLE(4, 1, false, 4, 1,  true)
+GEN_OPS_LITTLE(4, 1, false, 8, 1,  true)
+GEN_OPS_LITTLE(4, 1, false, 2, 2,  true)
+GEN_OPS_LITTLE(4, 1, false, 4, 2,  true)
+GEN_OPS_LITTLE(4, 1, false, 8, 2,  true)
+GEN_OPS_LITTLE(4, 1, false, 4, 4,  true)
+GEN_OPS_LITTLE(4, 1, false, 8, 4,  true)
+GEN_OPS_LITTLE(4, 1, false, 8, 8,  true)
+GEN_OPS_LITTLE(4, 1, false, 1, 1, false)
+GEN_OPS_LITTLE(4, 1, false, 2, 1, false)
+GEN_OPS_LITTLE(4, 1, false, 4, 1, false)
+GEN_OPS_LITTLE(4, 1, false, 8, 1, false)
+GEN_OPS_LITTLE(4, 1, false, 2, 2, false)
+GEN_OPS_LITTLE(4, 1, false, 4, 2, false)
+GEN_OPS_LITTLE(4, 1, false, 8, 2, false)
+GEN_OPS_LITTLE(4, 1, false, 4, 4, false)
+GEN_OPS_LITTLE(4, 1, false, 8, 4, false)
+GEN_OPS_LITTLE(4, 1, false, 8, 8, false)
+GEN_OPS_LITTLE(8, 1, false, 1, 1,  true)
+GEN_OPS_LITTLE(8, 1, false, 2, 1,  true)
+GEN_OPS_LITTLE(8, 1, false, 4, 1,  true)
+GEN_OPS_LITTLE(8, 1, false, 8, 1,  true)
+GEN_OPS_LITTLE(8, 1, false, 2, 2,  true)
+GEN_OPS_LITTLE(8, 1, false, 4, 2,  true)
+GEN_OPS_LITTLE(8, 1, false, 8, 2,  true)
+GEN_OPS_LITTLE(8, 1, false, 4, 4,  true)
+GEN_OPS_LITTLE(8, 1, false, 8, 4,  true)
+GEN_OPS_LITTLE(8, 1, false, 8, 8,  true)
+GEN_OPS_LITTLE(8, 1, false, 1, 1, false)
+GEN_OPS_LITTLE(8, 1, false, 2, 1, false)
+GEN_OPS_LITTLE(8, 1, false, 4, 1, false)
+GEN_OPS_LITTLE(8, 1, false, 8, 1, false)
+GEN_OPS_LITTLE(8, 1, false, 2, 2, false)
+GEN_OPS_LITTLE(8, 1, false, 4, 2, false)
+GEN_OPS_LITTLE(8, 1, false, 8, 2, false)
+GEN_OPS_LITTLE(8, 1, false, 4, 4, false)
+GEN_OPS_LITTLE(8, 1, false, 8, 4, false)
+GEN_OPS_LITTLE(8, 1, false, 8, 8, false)
+GEN_OPS_LITTLE(2, 2, false, 1, 1,  true)
+GEN_OPS_LITTLE(2, 2, false, 2, 1,  true)
+GEN_OPS_LITTLE(2, 2, false, 4, 1,  true)
+GEN_OPS_LITTLE(2, 2, false, 8, 1,  true)
+GEN_OPS_LITTLE(2, 2, false, 2, 2,  true)
+GEN_OPS_LITTLE(2, 2, false, 4, 2,  true)
+GEN_OPS_LITTLE(2, 2, false, 8, 2,  true)
+GEN_OPS_LITTLE(2, 2, false, 4, 4,  true)
+GEN_OPS_LITTLE(2, 2, false, 8, 4,  true)
+GEN_OPS_LITTLE(2, 2, false, 8, 8,  true)
+GEN_OPS_LITTLE(2, 2, false, 1, 1, false)
+GEN_OPS_LITTLE(2, 2, false, 2, 1, false)
+GEN_OPS_LITTLE(2, 2, false, 4, 1, false)
+GEN_OPS_LITTLE(2, 2, false, 8, 1, false)
+GEN_OPS_LITTLE(2, 2, false, 2, 2, false)
+GEN_OPS_LITTLE(2, 2, false, 4, 2, false)
+GEN_OPS_LITTLE(2, 2, false, 8, 2, false)
+GEN_OPS_LITTLE(2, 2, false, 4, 4, false)
+GEN_OPS_LITTLE(2, 2, false, 8, 4, false)
+GEN_OPS_LITTLE(2, 2, false, 8, 8, false)
+GEN_OPS_LITTLE(4, 2, false, 1, 1,  true)
+GEN_OPS_LITTLE(4, 2, false, 2, 1,  true)
+GEN_OPS_LITTLE(4, 2, false, 4, 1,  true)
+GEN_OPS_LITTLE(4, 2, false, 8, 1,  true)
+GEN_OPS_LITTLE(4, 2, false, 2, 2,  true)
+GEN_OPS_LITTLE(4, 2, false, 4, 2,  true)
+GEN_OPS_LITTLE(4, 2, false, 8, 2,  true)
+GEN_OPS_LITTLE(4, 2, false, 4, 4,  true)
+GEN_OPS_LITTLE(4, 2, false, 8, 4,  true)
+GEN_OPS_LITTLE(4, 2, false, 8, 8,  true)
+GEN_OPS_LITTLE(4, 2, false, 1, 1, false)
+GEN_OPS_LITTLE(4, 2, false, 2, 1, false)
+GEN_OPS_LITTLE(4, 2, false, 4, 1, false)
+GEN_OPS_LITTLE(4, 2, false, 8, 1, false)
+GEN_OPS_LITTLE(4, 2, false, 2, 2, false)
+GEN_OPS_LITTLE(4, 2, false, 4, 2, false)
+GEN_OPS_LITTLE(4, 2, false, 8, 2, false)
+GEN_OPS_LITTLE(4, 2, false, 4, 4, false)
+GEN_OPS_LITTLE(4, 2, false, 8, 4, false)
+GEN_OPS_LITTLE(4, 2, false, 8, 8, false)
+GEN_OPS_LITTLE(8, 2, false, 1, 1,  true)
+GEN_OPS_LITTLE(8, 2, false, 2, 1,  true)
+GEN_OPS_LITTLE(8, 2, false, 4, 1,  true)
+GEN_OPS_LITTLE(8, 2, false, 8, 1,  true)
+GEN_OPS_LITTLE(8, 2, false, 2, 2,  true)
+GEN_OPS_LITTLE(8, 2, false, 4, 2,  true)
+GEN_OPS_LITTLE(8, 2, false, 8, 2,  true)
+GEN_OPS_LITTLE(8, 2, false, 4, 4,  true)
+GEN_OPS_LITTLE(8, 2, false, 8, 4,  true)
+GEN_OPS_LITTLE(8, 2, false, 8, 8,  true)
+GEN_OPS_LITTLE(8, 2, false, 1, 1, false)
+GEN_OPS_LITTLE(8, 2, false, 2, 1, false)
+GEN_OPS_LITTLE(8, 2, false, 4, 1, false)
+GEN_OPS_LITTLE(8, 2, false, 8, 1, false)
+GEN_OPS_LITTLE(8, 2, false, 2, 2, false)
+GEN_OPS_LITTLE(8, 2, false, 4, 2, false)
+GEN_OPS_LITTLE(8, 2, false, 8, 2, false)
+GEN_OPS_LITTLE(8, 2, false, 4, 4, false)
+GEN_OPS_LITTLE(8, 2, false, 8, 4, false)
+GEN_OPS_LITTLE(8, 2, false, 8, 8, false)
+GEN_OPS_LITTLE(4, 4, false, 1, 1,  true)
+GEN_OPS_LITTLE(4, 4, false, 2, 1,  true)
+GEN_OPS_LITTLE(4, 4, false, 4, 1,  true)
+GEN_OPS_LITTLE(4, 4, false, 8, 1,  true)
+GEN_OPS_LITTLE(4, 4, false, 2, 2,  true)
+GEN_OPS_LITTLE(4, 4, false, 4, 2,  true)
+GEN_OPS_LITTLE(4, 4, false, 8, 2,  true)
+GEN_OPS_LITTLE(4, 4, false, 4, 4,  true)
+GEN_OPS_LITTLE(4, 4, false, 8, 4,  true)
+GEN_OPS_LITTLE(4, 4, false, 8, 8,  true)
+GEN_OPS_LITTLE(4, 4, false, 1, 1, false)
+GEN_OPS_LITTLE(4, 4, false, 2, 1, false)
+GEN_OPS_LITTLE(4, 4, false, 4, 1, false)
+GEN_OPS_LITTLE(4, 4, false, 8, 1, false)
+GEN_OPS_LITTLE(4, 4, false, 2, 2, false)
+GEN_OPS_LITTLE(4, 4, false, 4, 2, false)
+GEN_OPS_LITTLE(4, 4, false, 8, 2, false)
+GEN_OPS_LITTLE(4, 4, false, 4, 4, false)
+GEN_OPS_LITTLE(4, 4, false, 8, 4, false)
+GEN_OPS_LITTLE(4, 4, false, 8, 8, false)
+GEN_OPS_LITTLE(8, 4, false, 1, 1,  true)
+GEN_OPS_LITTLE(8, 4, false, 2, 1,  true)
+GEN_OPS_LITTLE(8, 4, false, 4, 1,  true)
+GEN_OPS_LITTLE(8, 4, false, 8, 1,  true)
+GEN_OPS_LITTLE(8, 4, false, 2, 2,  true)
+GEN_OPS_LITTLE(8, 4, false, 4, 2,  true)
+GEN_OPS_LITTLE(8, 4, false, 8, 2,  true)
+GEN_OPS_LITTLE(8, 4, false, 4, 4,  true)
+GEN_OPS_LITTLE(8, 4, false, 8, 4,  true)
+GEN_OPS_LITTLE(8, 4, false, 8, 8,  true)
+GEN_OPS_LITTLE(8, 4, false, 1, 1, false)
+GEN_OPS_LITTLE(8, 4, false, 2, 1, false)
+GEN_OPS_LITTLE(8, 4, false, 4, 1, false)
+GEN_OPS_LITTLE(8, 4, false, 8, 1, false)
+GEN_OPS_LITTLE(8, 4, false, 2, 2, false)
+GEN_OPS_LITTLE(8, 4, false, 4, 2, false)
+GEN_OPS_LITTLE(8, 4, false, 8, 2, false)
+GEN_OPS_LITTLE(8, 4, false, 4, 4, false)
+GEN_OPS_LITTLE(8, 4, false, 8, 4, false)
+GEN_OPS_LITTLE(8, 4, false, 8, 8, false)
+GEN_OPS_LITTLE(8, 8, false, 1, 1,  true)
+GEN_OPS_LITTLE(8, 8, false, 2, 1,  true)
+GEN_OPS_LITTLE(8, 8, false, 4, 1,  true)
+GEN_OPS_LITTLE(8, 8, false, 8, 1,  true)
+GEN_OPS_LITTLE(8, 8, false, 2, 2,  true)
+GEN_OPS_LITTLE(8, 8, false, 4, 2,  true)
+GEN_OPS_LITTLE(8, 8, false, 8, 2,  true)
+GEN_OPS_LITTLE(8, 8, false, 4, 4,  true)
+GEN_OPS_LITTLE(8, 8, false, 8, 4,  true)
+GEN_OPS_LITTLE(8, 8, false, 8, 8,  true)
+GEN_OPS_LITTLE(8, 8, false, 1, 1, false)
+GEN_OPS_LITTLE(8, 8, false, 2, 1, false)
+GEN_OPS_LITTLE(8, 8, false, 4, 1, false)
+GEN_OPS_LITTLE(8, 8, false, 8, 1, false)
+GEN_OPS_LITTLE(8, 8, false, 2, 2, false)
+GEN_OPS_LITTLE(8, 8, false, 4, 2, false)
+GEN_OPS_LITTLE(8, 8, false, 8, 2, false)
+GEN_OPS_LITTLE(8, 8, false, 4, 4, false)
+GEN_OPS_LITTLE(8, 8, false, 8, 4, false)
+GEN_OPS_LITTLE(8, 8, false, 8, 8, false)
+
+GEN_OPS_BIG(1, 1,  true, 1, 1,  true)
+GEN_OPS_BIG(1, 1,  true, 2, 1,  true)
+GEN_OPS_BIG(1, 1,  true, 4, 1,  true)
+GEN_OPS_BIG(1, 1,  true, 8, 1,  true)
+GEN_OPS_BIG(1, 1,  true, 2, 2,  true)
+GEN_OPS_BIG(1, 1,  true, 4, 2,  true)
+GEN_OPS_BIG(1, 1,  true, 8, 2,  true)
+GEN_OPS_BIG(1, 1,  true, 4, 4,  true)
+GEN_OPS_BIG(1, 1,  true, 8, 4,  true)
+GEN_OPS_BIG(1, 1,  true, 8, 8,  true)
+GEN_OPS_BIG(1, 1,  true, 1, 1, false)
+GEN_OPS_BIG(1, 1,  true, 2, 1, false)
+GEN_OPS_BIG(1, 1,  true, 4, 1, false)
+GEN_OPS_BIG(1, 1,  true, 8, 1, false)
+GEN_OPS_BIG(1, 1,  true, 2, 2, false)
+GEN_OPS_BIG(1, 1,  true, 4, 2, false)
+GEN_OPS_BIG(1, 1,  true, 8, 2, false)
+GEN_OPS_BIG(1, 1,  true, 4, 4, false)
+GEN_OPS_BIG(1, 1,  true, 8, 4, false)
+GEN_OPS_BIG(1, 1,  true, 8, 8, false)
+GEN_OPS_BIG(2, 1,  true, 1, 1,  true)
+GEN_OPS_BIG(2, 1,  true, 2, 1,  true)
+GEN_OPS_BIG(2, 1,  true, 4, 1,  true)
+GEN_OPS_BIG(2, 1,  true, 8, 1,  true)
+GEN_OPS_BIG(2, 1,  true, 2, 2,  true)
+GEN_OPS_BIG(2, 1,  true, 4, 2,  true)
+GEN_OPS_BIG(2, 1,  true, 8, 2,  true)
+GEN_OPS_BIG(2, 1,  true, 4, 4,  true)
+GEN_OPS_BIG(2, 1,  true, 8, 4,  true)
+GEN_OPS_BIG(2, 1,  true, 8, 8,  true)
+GEN_OPS_BIG(2, 1,  true, 1, 1, false)
+GEN_OPS_BIG(2, 1,  true, 2, 1, false)
+GEN_OPS_BIG(2, 1,  true, 4, 1, false)
+GEN_OPS_BIG(2, 1,  true, 8, 1, false)
+GEN_OPS_BIG(2, 1,  true, 2, 2, false)
+GEN_OPS_BIG(2, 1,  true, 4, 2, false)
+GEN_OPS_BIG(2, 1,  true, 8, 2, false)
+GEN_OPS_BIG(2, 1,  true, 4, 4, false)
+GEN_OPS_BIG(2, 1,  true, 8, 4, false)
+GEN_OPS_BIG(2, 1,  true, 8, 8, false)
+GEN_OPS_BIG(4, 1,  true, 1, 1,  true)
+GEN_OPS_BIG(4, 1,  true, 2, 1,  true)
+GEN_OPS_BIG(4, 1,  true, 4, 1,  true)
+GEN_OPS_BIG(4, 1,  true, 8, 1,  true)
+GEN_OPS_BIG(4, 1,  true, 2, 2,  true)
+GEN_OPS_BIG(4, 1,  true, 4, 2,  true)
+GEN_OPS_BIG(4, 1,  true, 8, 2,  true)
+GEN_OPS_BIG(4, 1,  true, 4, 4,  true)
+GEN_OPS_BIG(4, 1,  true, 8, 4,  true)
+GEN_OPS_BIG(4, 1,  true, 8, 8,  true)
+GEN_OPS_BIG(4, 1,  true, 1, 1, false)
+GEN_OPS_BIG(4, 1,  true, 2, 1, false)
+GEN_OPS_BIG(4, 1,  true, 4, 1, false)
+GEN_OPS_BIG(4, 1,  true, 8, 1, false)
+GEN_OPS_BIG(4, 1,  true, 2, 2, false)
+GEN_OPS_BIG(4, 1,  true, 4, 2, false)
+GEN_OPS_BIG(4, 1,  true, 8, 2, false)
+GEN_OPS_BIG(4, 1,  true, 4, 4, false)
+GEN_OPS_BIG(4, 1,  true, 8, 4, false)
+GEN_OPS_BIG(4, 1,  true, 8, 8, false)
+GEN_OPS_BIG(8, 1,  true, 1, 1,  true)
+GEN_OPS_BIG(8, 1,  true, 2, 1,  true)
+GEN_OPS_BIG(8, 1,  true, 4, 1,  true)
+GEN_OPS_BIG(8, 1,  true, 8, 1,  true)
+GEN_OPS_BIG(8, 1,  true, 2, 2,  true)
+GEN_OPS_BIG(8, 1,  true, 4, 2,  true)
+GEN_OPS_BIG(8, 1,  true, 8, 2,  true)
+GEN_OPS_BIG(8, 1,  true, 4, 4,  true)
+GEN_OPS_BIG(8, 1,  true, 8, 4,  true)
+GEN_OPS_BIG(8, 1,  true, 8, 8,  true)
+GEN_OPS_BIG(8, 1,  true, 1, 1, false)
+GEN_OPS_BIG(8, 1,  true, 2, 1, false)
+GEN_OPS_BIG(8, 1,  true, 4, 1, false)
+GEN_OPS_BIG(8, 1,  true, 8, 1, false)
+GEN_OPS_BIG(8, 1,  true, 2, 2, false)
+GEN_OPS_BIG(8, 1,  true, 4, 2, false)
+GEN_OPS_BIG(8, 1,  true, 8, 2, false)
+GEN_OPS_BIG(8, 1,  true, 4, 4, false)
+GEN_OPS_BIG(8, 1,  true, 8, 4, false)
+GEN_OPS_BIG(8, 1,  true, 8, 8, false)
+GEN_OPS_BIG(2, 2,  true, 1, 1,  true)
+GEN_OPS_BIG(2, 2,  true, 2, 1,  true)
+GEN_OPS_BIG(2, 2,  true, 4, 1,  true)
+GEN_OPS_BIG(2, 2,  true, 8, 1,  true)
+GEN_OPS_BIG(2, 2,  true, 2, 2,  true)
+GEN_OPS_BIG(2, 2,  true, 4, 2,  true)
+GEN_OPS_BIG(2, 2,  true, 8, 2,  true)
+GEN_OPS_BIG(2, 2,  true, 4, 4,  true)
+GEN_OPS_BIG(2, 2,  true, 8, 4,  true)
+GEN_OPS_BIG(2, 2,  true, 8, 8,  true)
+GEN_OPS_BIG(2, 2,  true, 1, 1, false)
+GEN_OPS_BIG(2, 2,  true, 2, 1, false)
+GEN_OPS_BIG(2, 2,  true, 4, 1, false)
+GEN_OPS_BIG(2, 2,  true, 8, 1, false)
+GEN_OPS_BIG(2, 2,  true, 2, 2, false)
+GEN_OPS_BIG(2, 2,  true, 4, 2, false)
+GEN_OPS_BIG(2, 2,  true, 8, 2, false)
+GEN_OPS_BIG(2, 2,  true, 4, 4, false)
+GEN_OPS_BIG(2, 2,  true, 8, 4, false)
+GEN_OPS_BIG(2, 2,  true, 8, 8, false)
+GEN_OPS_BIG(4, 2,  true, 1, 1,  true)
+GEN_OPS_BIG(4, 2,  true, 2, 1,  true)
+GEN_OPS_BIG(4, 2,  true, 4, 1,  true)
+GEN_OPS_BIG(4, 2,  true, 8, 1,  true)
+GEN_OPS_BIG(4, 2,  true, 2, 2,  true)
+GEN_OPS_BIG(4, 2,  true, 4, 2,  true)
+GEN_OPS_BIG(4, 2,  true, 8, 2,  true)
+GEN_OPS_BIG(4, 2,  true, 4, 4,  true)
+GEN_OPS_BIG(4, 2,  true, 8, 4,  true)
+GEN_OPS_BIG(4, 2,  true, 8, 8,  true)
+GEN_OPS_BIG(4, 2,  true, 1, 1, false)
+GEN_OPS_BIG(4, 2,  true, 2, 1, false)
+GEN_OPS_BIG(4, 2,  true, 4, 1, false)
+GEN_OPS_BIG(4, 2,  true, 8, 1, false)
+GEN_OPS_BIG(4, 2,  true, 2, 2, false)
+GEN_OPS_BIG(4, 2,  true, 4, 2, false)
+GEN_OPS_BIG(4, 2,  true, 8, 2, false)
+GEN_OPS_BIG(4, 2,  true, 4, 4, false)
+GEN_OPS_BIG(4, 2,  true, 8, 4, false)
+GEN_OPS_BIG(4, 2,  true, 8, 8, false)
+GEN_OPS_BIG(8, 2,  true, 1, 1,  true)
+GEN_OPS_BIG(8, 2,  true, 2, 1,  true)
+GEN_OPS_BIG(8, 2,  true, 4, 1,  true)
+GEN_OPS_BIG(8, 2,  true, 8, 1,  true)
+GEN_OPS_BIG(8, 2,  true, 2, 2,  true)
+GEN_OPS_BIG(8, 2,  true, 4, 2,  true)
+GEN_OPS_BIG(8, 2,  true, 8, 2,  true)
+GEN_OPS_BIG(8, 2,  true, 4, 4,  true)
+GEN_OPS_BIG(8, 2,  true, 8, 4,  true)
+GEN_OPS_BIG(8, 2,  true, 8, 8,  true)
+GEN_OPS_BIG(8, 2,  true, 1, 1, false)
+GEN_OPS_BIG(8, 2,  true, 2, 1, false)
+GEN_OPS_BIG(8, 2,  true, 4, 1, false)
+GEN_OPS_BIG(8, 2,  true, 8, 1, false)
+GEN_OPS_BIG(8, 2,  true, 2, 2, false)
+GEN_OPS_BIG(8, 2,  true, 4, 2, false)
+GEN_OPS_BIG(8, 2,  true, 8, 2, false)
+GEN_OPS_BIG(8, 2,  true, 4, 4, false)
+GEN_OPS_BIG(8, 2,  true, 8, 4, false)
+GEN_OPS_BIG(8, 2,  true, 8, 8, false)
+GEN_OPS_BIG(4, 4,  true, 1, 1,  true)
+GEN_OPS_BIG(4, 4,  true, 2, 1,  true)
+GEN_OPS_BIG(4, 4,  true, 4, 1,  true)
+GEN_OPS_BIG(4, 4,  true, 8, 1,  true)
+GEN_OPS_BIG(4, 4,  true, 2, 2,  true)
+GEN_OPS_BIG(4, 4,  true, 4, 2,  true)
+GEN_OPS_BIG(4, 4,  true, 8, 2,  true)
+GEN_OPS_BIG(4, 4,  true, 4, 4,  true)
+GEN_OPS_BIG(4, 4,  true, 8, 4,  true)
+GEN_OPS_BIG(4, 4,  true, 8, 8,  true)
+GEN_OPS_BIG(4, 4,  true, 1, 1, false)
+GEN_OPS_BIG(4, 4,  true, 2, 1, false)
+GEN_OPS_BIG(4, 4,  true, 4, 1, false)
+GEN_OPS_BIG(4, 4,  true, 8, 1, false)
+GEN_OPS_BIG(4, 4,  true, 2, 2, false)
+GEN_OPS_BIG(4, 4,  true, 4, 2, false)
+GEN_OPS_BIG(4, 4,  true, 8, 2, false)
+GEN_OPS_BIG(4, 4,  true, 4, 4, false)
+GEN_OPS_BIG(4, 4,  true, 8, 4, false)
+GEN_OPS_BIG(4, 4,  true, 8, 8, false)
+GEN_OPS_BIG(8, 4,  true, 1, 1,  true)
+GEN_OPS_BIG(8, 4,  true, 2, 1,  true)
+GEN_OPS_BIG(8, 4,  true, 4, 1,  true)
+GEN_OPS_BIG(8, 4,  true, 8, 1,  true)
+GEN_OPS_BIG(8, 4,  true, 2, 2,  true)
+GEN_OPS_BIG(8, 4,  true, 4, 2,  true)
+GEN_OPS_BIG(8, 4,  true, 8, 2,  true)
+GEN_OPS_BIG(8, 4,  true, 4, 4,  true)
+GEN_OPS_BIG(8, 4,  true, 8, 4,  true)
+GEN_OPS_BIG(8, 4,  true, 8, 8,  true)
+GEN_OPS_BIG(8, 4,  true, 1, 1, false)
+GEN_OPS_BIG(8, 4,  true, 2, 1, false)
+GEN_OPS_BIG(8, 4,  true, 4, 1, false)
+GEN_OPS_BIG(8, 4,  true, 8, 1, false)
+GEN_OPS_BIG(8, 4,  true, 2, 2, false)
+GEN_OPS_BIG(8, 4,  true, 4, 2, false)
+GEN_OPS_BIG(8, 4,  true, 8, 2, false)
+GEN_OPS_BIG(8, 4,  true, 4, 4, false)
+GEN_OPS_BIG(8, 4,  true, 8, 4, false)
+GEN_OPS_BIG(8, 4,  true, 8, 8, false)
+GEN_OPS_BIG(8, 8,  true, 1, 1,  true)
+GEN_OPS_BIG(8, 8,  true, 2, 1,  true)
+GEN_OPS_BIG(8, 8,  true, 4, 1,  true)
+GEN_OPS_BIG(8, 8,  true, 8, 1,  true)
+GEN_OPS_BIG(8, 8,  true, 2, 2,  true)
+GEN_OPS_BIG(8, 8,  true, 4, 2,  true)
+GEN_OPS_BIG(8, 8,  true, 8, 2,  true)
+GEN_OPS_BIG(8, 8,  true, 4, 4,  true)
+GEN_OPS_BIG(8, 8,  true, 8, 4,  true)
+GEN_OPS_BIG(8, 8,  true, 8, 8,  true)
+GEN_OPS_BIG(8, 8,  true, 1, 1, false)
+GEN_OPS_BIG(8, 8,  true, 2, 1, false)
+GEN_OPS_BIG(8, 8,  true, 4, 1, false)
+GEN_OPS_BIG(8, 8,  true, 8, 1, false)
+GEN_OPS_BIG(8, 8,  true, 2, 2, false)
+GEN_OPS_BIG(8, 8,  true, 4, 2, false)
+GEN_OPS_BIG(8, 8,  true, 8, 2, false)
+GEN_OPS_BIG(8, 8,  true, 4, 4, false)
+GEN_OPS_BIG(8, 8,  true, 8, 4, false)
+GEN_OPS_BIG(8, 8,  true, 8, 8, false)
+GEN_OPS_BIG(1, 1, false, 1, 1,  true)
+GEN_OPS_BIG(1, 1, false, 2, 1,  true)
+GEN_OPS_BIG(1, 1, false, 4, 1,  true)
+GEN_OPS_BIG(1, 1, false, 8, 1,  true)
+GEN_OPS_BIG(1, 1, false, 2, 2,  true)
+GEN_OPS_BIG(1, 1, false, 4, 2,  true)
+GEN_OPS_BIG(1, 1, false, 8, 2,  true)
+GEN_OPS_BIG(1, 1, false, 4, 4,  true)
+GEN_OPS_BIG(1, 1, false, 8, 4,  true)
+GEN_OPS_BIG(1, 1, false, 8, 8,  true)
+GEN_OPS_BIG(1, 1, false, 1, 1, false)
+GEN_OPS_BIG(1, 1, false, 2, 1, false)
+GEN_OPS_BIG(1, 1, false, 4, 1, false)
+GEN_OPS_BIG(1, 1, false, 8, 1, false)
+GEN_OPS_BIG(1, 1, false, 2, 2, false)
+GEN_OPS_BIG(1, 1, false, 4, 2, false)
+GEN_OPS_BIG(1, 1, false, 8, 2, false)
+GEN_OPS_BIG(1, 1, false, 4, 4, false)
+GEN_OPS_BIG(1, 1, false, 8, 4, false)
+GEN_OPS_BIG(1, 1, false, 8, 8, false)
+GEN_OPS_BIG(2, 1, false, 1, 1,  true)
+GEN_OPS_BIG(2, 1, false, 2, 1,  true)
+GEN_OPS_BIG(2, 1, false, 4, 1,  true)
+GEN_OPS_BIG(2, 1, false, 8, 1,  true)
+GEN_OPS_BIG(2, 1, false, 2, 2,  true)
+GEN_OPS_BIG(2, 1, false, 4, 2,  true)
+GEN_OPS_BIG(2, 1, false, 8, 2,  true)
+GEN_OPS_BIG(2, 1, false, 4, 4,  true)
+GEN_OPS_BIG(2, 1, false, 8, 4,  true)
+GEN_OPS_BIG(2, 1, false, 8, 8,  true)
+GEN_OPS_BIG(2, 1, false, 1, 1, false)
+GEN_OPS_BIG(2, 1, false, 2, 1, false)
+GEN_OPS_BIG(2, 1, false, 4, 1, false)
+GEN_OPS_BIG(2, 1, false, 8, 1, false)
+GEN_OPS_BIG(2, 1, false, 2, 2, false)
+GEN_OPS_BIG(2, 1, false, 4, 2, false)
+GEN_OPS_BIG(2, 1, false, 8, 2, false)
+GEN_OPS_BIG(2, 1, false, 4, 4, false)
+GEN_OPS_BIG(2, 1, false, 8, 4, false)
+GEN_OPS_BIG(2, 1, false, 8, 8, false)
+GEN_OPS_BIG(4, 1, false, 1, 1,  true)
+GEN_OPS_BIG(4, 1, false, 2, 1,  true)
+GEN_OPS_BIG(4, 1, false, 4, 1,  true)
+GEN_OPS_BIG(4, 1, false, 8, 1,  true)
+GEN_OPS_BIG(4, 1, false, 2, 2,  true)
+GEN_OPS_BIG(4, 1, false, 4, 2,  true)
+GEN_OPS_BIG(4, 1, false, 8, 2,  true)
+GEN_OPS_BIG(4, 1, false, 4, 4,  true)
+GEN_OPS_BIG(4, 1, false, 8, 4,  true)
+GEN_OPS_BIG(4, 1, false, 8, 8,  true)
+GEN_OPS_BIG(4, 1, false, 1, 1, false)
+GEN_OPS_BIG(4, 1, false, 2, 1, false)
+GEN_OPS_BIG(4, 1, false, 4, 1, false)
+GEN_OPS_BIG(4, 1, false, 8, 1, false)
+GEN_OPS_BIG(4, 1, false, 2, 2, false)
+GEN_OPS_BIG(4, 1, false, 4, 2, false)
+GEN_OPS_BIG(4, 1, false, 8, 2, false)
+GEN_OPS_BIG(4, 1, false, 4, 4, false)
+GEN_OPS_BIG(4, 1, false, 8, 4, false)
+GEN_OPS_BIG(4, 1, false, 8, 8, false)
+GEN_OPS_BIG(8, 1, false, 1, 1,  true)
+GEN_OPS_BIG(8, 1, false, 2, 1,  true)
+GEN_OPS_BIG(8, 1, false, 4, 1,  true)
+GEN_OPS_BIG(8, 1, false, 8, 1,  true)
+GEN_OPS_BIG(8, 1, false, 2, 2,  true)
+GEN_OPS_BIG(8, 1, false, 4, 2,  true)
+GEN_OPS_BIG(8, 1, false, 8, 2,  true)
+GEN_OPS_BIG(8, 1, false, 4, 4,  true)
+GEN_OPS_BIG(8, 1, false, 8, 4,  true)
+GEN_OPS_BIG(8, 1, false, 8, 8,  true)
+GEN_OPS_BIG(8, 1, false, 1, 1, false)
+GEN_OPS_BIG(8, 1, false, 2, 1, false)
+GEN_OPS_BIG(8, 1, false, 4, 1, false)
+GEN_OPS_BIG(8, 1, false, 8, 1, false)
+GEN_OPS_BIG(8, 1, false, 2, 2, false)
+GEN_OPS_BIG(8, 1, false, 4, 2, false)
+GEN_OPS_BIG(8, 1, false, 8, 2, false)
+GEN_OPS_BIG(8, 1, false, 4, 4, false)
+GEN_OPS_BIG(8, 1, false, 8, 4, false)
+GEN_OPS_BIG(8, 1, false, 8, 8, false)
+GEN_OPS_BIG(2, 2, false, 1, 1,  true)
+GEN_OPS_BIG(2, 2, false, 2, 1,  true)
+GEN_OPS_BIG(2, 2, false, 4, 1,  true)
+GEN_OPS_BIG(2, 2, false, 8, 1,  true)
+GEN_OPS_BIG(2, 2, false, 2, 2,  true)
+GEN_OPS_BIG(2, 2, false, 4, 2,  true)
+GEN_OPS_BIG(2, 2, false, 8, 2,  true)
+GEN_OPS_BIG(2, 2, false, 4, 4,  true)
+GEN_OPS_BIG(2, 2, false, 8, 4,  true)
+GEN_OPS_BIG(2, 2, false, 8, 8,  true)
+GEN_OPS_BIG(2, 2, false, 1, 1, false)
+GEN_OPS_BIG(2, 2, false, 2, 1, false)
+GEN_OPS_BIG(2, 2, false, 4, 1, false)
+GEN_OPS_BIG(2, 2, false, 8, 1, false)
+GEN_OPS_BIG(2, 2, false, 2, 2, false)
+GEN_OPS_BIG(2, 2, false, 4, 2, false)
+GEN_OPS_BIG(2, 2, false, 8, 2, false)
+GEN_OPS_BIG(2, 2, false, 4, 4, false)
+GEN_OPS_BIG(2, 2, false, 8, 4, false)
+GEN_OPS_BIG(2, 2, false, 8, 8, false)
+GEN_OPS_BIG(4, 2, false, 1, 1,  true)
+GEN_OPS_BIG(4, 2, false, 2, 1,  true)
+GEN_OPS_BIG(4, 2, false, 4, 1,  true)
+GEN_OPS_BIG(4, 2, false, 8, 1,  true)
+GEN_OPS_BIG(4, 2, false, 2, 2,  true)
+GEN_OPS_BIG(4, 2, false, 4, 2,  true)
+GEN_OPS_BIG(4, 2, false, 8, 2,  true)
+GEN_OPS_BIG(4, 2, false, 4, 4,  true)
+GEN_OPS_BIG(4, 2, false, 8, 4,  true)
+GEN_OPS_BIG(4, 2, false, 8, 8,  true)
+GEN_OPS_BIG(4, 2, false, 1, 1, false)
+GEN_OPS_BIG(4, 2, false, 2, 1, false)
+GEN_OPS_BIG(4, 2, false, 4, 1, false)
+GEN_OPS_BIG(4, 2, false, 8, 1, false)
+GEN_OPS_BIG(4, 2, false, 2, 2, false)
+GEN_OPS_BIG(4, 2, false, 4, 2, false)
+GEN_OPS_BIG(4, 2, false, 8, 2, false)
+GEN_OPS_BIG(4, 2, false, 4, 4, false)
+GEN_OPS_BIG(4, 2, false, 8, 4, false)
+GEN_OPS_BIG(4, 2, false, 8, 8, false)
+GEN_OPS_BIG(8, 2, false, 1, 1,  true)
+GEN_OPS_BIG(8, 2, false, 2, 1,  true)
+GEN_OPS_BIG(8, 2, false, 4, 1,  true)
+GEN_OPS_BIG(8, 2, false, 8, 1,  true)
+GEN_OPS_BIG(8, 2, false, 2, 2,  true)
+GEN_OPS_BIG(8, 2, false, 4, 2,  true)
+GEN_OPS_BIG(8, 2, false, 8, 2,  true)
+GEN_OPS_BIG(8, 2, false, 4, 4,  true)
+GEN_OPS_BIG(8, 2, false, 8, 4,  true)
+GEN_OPS_BIG(8, 2, false, 8, 8,  true)
+GEN_OPS_BIG(8, 2, false, 1, 1, false)
+GEN_OPS_BIG(8, 2, false, 2, 1, false)
+GEN_OPS_BIG(8, 2, false, 4, 1, false)
+GEN_OPS_BIG(8, 2, false, 8, 1, false)
+GEN_OPS_BIG(8, 2, false, 2, 2, false)
+GEN_OPS_BIG(8, 2, false, 4, 2, false)
+GEN_OPS_BIG(8, 2, false, 8, 2, false)
+GEN_OPS_BIG(8, 2, false, 4, 4, false)
+GEN_OPS_BIG(8, 2, false, 8, 4, false)
+GEN_OPS_BIG(8, 2, false, 8, 8, false)
+GEN_OPS_BIG(4, 4, false, 1, 1,  true)
+GEN_OPS_BIG(4, 4, false, 2, 1,  true)
+GEN_OPS_BIG(4, 4, false, 4, 1,  true)
+GEN_OPS_BIG(4, 4, false, 8, 1,  true)
+GEN_OPS_BIG(4, 4, false, 2, 2,  true)
+GEN_OPS_BIG(4, 4, false, 4, 2,  true)
+GEN_OPS_BIG(4, 4, false, 8, 2,  true)
+GEN_OPS_BIG(4, 4, false, 4, 4,  true)
+GEN_OPS_BIG(4, 4, false, 8, 4,  true)
+GEN_OPS_BIG(4, 4, false, 8, 8,  true)
+GEN_OPS_BIG(4, 4, false, 1, 1, false)
+GEN_OPS_BIG(4, 4, false, 2, 1, false)
+GEN_OPS_BIG(4, 4, false, 4, 1, false)
+GEN_OPS_BIG(4, 4, false, 8, 1, false)
+GEN_OPS_BIG(4, 4, false, 2, 2, false)
+GEN_OPS_BIG(4, 4, false, 4, 2, false)
+GEN_OPS_BIG(4, 4, false, 8, 2, false)
+GEN_OPS_BIG(4, 4, false, 4, 4, false)
+GEN_OPS_BIG(4, 4, false, 8, 4, false)
+GEN_OPS_BIG(4, 4, false, 8, 8, false)
+GEN_OPS_BIG(8, 4, false, 1, 1,  true)
+GEN_OPS_BIG(8, 4, false, 2, 1,  true)
+GEN_OPS_BIG(8, 4, false, 4, 1,  true)
+GEN_OPS_BIG(8, 4, false, 8, 1,  true)
+GEN_OPS_BIG(8, 4, false, 2, 2,  true)
+GEN_OPS_BIG(8, 4, false, 4, 2,  true)
+GEN_OPS_BIG(8, 4, false, 8, 2,  true)
+GEN_OPS_BIG(8, 4, false, 4, 4,  true)
+GEN_OPS_BIG(8, 4, false, 8, 4,  true)
+GEN_OPS_BIG(8, 4, false, 8, 8,  true)
+GEN_OPS_BIG(8, 4, false, 1, 1, false)
+GEN_OPS_BIG(8, 4, false, 2, 1, false)
+GEN_OPS_BIG(8, 4, false, 4, 1, false)
+GEN_OPS_BIG(8, 4, false, 8, 1, false)
+GEN_OPS_BIG(8, 4, false, 2, 2, false)
+GEN_OPS_BIG(8, 4, false, 4, 2, false)
+GEN_OPS_BIG(8, 4, false, 8, 2, false)
+GEN_OPS_BIG(8, 4, false, 4, 4, false)
+GEN_OPS_BIG(8, 4, false, 8, 4, false)
+GEN_OPS_BIG(8, 4, false, 8, 8, false)
+GEN_OPS_BIG(8, 8, false, 1, 1,  true)
+GEN_OPS_BIG(8, 8, false, 2, 1,  true)
+GEN_OPS_BIG(8, 8, false, 4, 1,  true)
+GEN_OPS_BIG(8, 8, false, 8, 1,  true)
+GEN_OPS_BIG(8, 8, false, 2, 2,  true)
+GEN_OPS_BIG(8, 8, false, 4, 2,  true)
+GEN_OPS_BIG(8, 8, false, 8, 2,  true)
+GEN_OPS_BIG(8, 8, false, 4, 4,  true)
+GEN_OPS_BIG(8, 8, false, 8, 4,  true)
+GEN_OPS_BIG(8, 8, false, 8, 8,  true)
+GEN_OPS_BIG(8, 8, false, 1, 1, false)
+GEN_OPS_BIG(8, 8, false, 2, 1, false)
+GEN_OPS_BIG(8, 8, false, 4, 1, false)
+GEN_OPS_BIG(8, 8, false, 8, 1, false)
+GEN_OPS_BIG(8, 8, false, 2, 2, false)
+GEN_OPS_BIG(8, 8, false, 4, 2, false)
+GEN_OPS_BIG(8, 8, false, 8, 2, false)
+GEN_OPS_BIG(8, 8, false, 4, 4, false)
+GEN_OPS_BIG(8, 8, false, 8, 4, false)
+GEN_OPS_BIG(8, 8, false, 8, 8, false)
+
+const MemoryRegionOps ops_list_little_b_valid[] = {
+    NAME_OPS_LITTLE(1, 1,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(1, 1,  true, 1, 1, false),
+    NAME_OPS_LITTLE(1, 1,  true, 2, 1, false),
+    NAME_OPS_LITTLE(1, 1,  true, 4, 1, false),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 1, false),
+    NAME_OPS_LITTLE(1, 1,  true, 2, 2, false),
+    NAME_OPS_LITTLE(1, 1,  true, 4, 2, false),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 2, false),
+    NAME_OPS_LITTLE(1, 1,  true, 4, 4, false),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 4, false),
+    NAME_OPS_LITTLE(1, 1,  true, 8, 8, false),
+    NAME_OPS_LITTLE(2, 1,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(2, 1,  true, 1, 1, false),
+    NAME_OPS_LITTLE(2, 1,  true, 2, 1, false),
+    NAME_OPS_LITTLE(2, 1,  true, 4, 1, false),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 1, false),
+    NAME_OPS_LITTLE(2, 1,  true, 2, 2, false),
+    NAME_OPS_LITTLE(2, 1,  true, 4, 2, false),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 2, false),
+    NAME_OPS_LITTLE(2, 1,  true, 4, 4, false),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 4, false),
+    NAME_OPS_LITTLE(2, 1,  true, 8, 8, false),
+    NAME_OPS_LITTLE(4, 1,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(4, 1,  true, 1, 1, false),
+    NAME_OPS_LITTLE(4, 1,  true, 2, 1, false),
+    NAME_OPS_LITTLE(4, 1,  true, 4, 1, false),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 1, false),
+    NAME_OPS_LITTLE(4, 1,  true, 2, 2, false),
+    NAME_OPS_LITTLE(4, 1,  true, 4, 2, false),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 2, false),
+    NAME_OPS_LITTLE(4, 1,  true, 4, 4, false),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 4, false),
+    NAME_OPS_LITTLE(4, 1,  true, 8, 8, false),
+    NAME_OPS_LITTLE(8, 1,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 1,  true, 1, 1, false),
+    NAME_OPS_LITTLE(8, 1,  true, 2, 1, false),
+    NAME_OPS_LITTLE(8, 1,  true, 4, 1, false),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 1, false),
+    NAME_OPS_LITTLE(8, 1,  true, 2, 2, false),
+    NAME_OPS_LITTLE(8, 1,  true, 4, 2, false),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 2, false),
+    NAME_OPS_LITTLE(8, 1,  true, 4, 4, false),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 4, false),
+    NAME_OPS_LITTLE(8, 1,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_little_b_invalid[] = {
+    NAME_OPS_LITTLE(1, 1, false, 1, 1,  true),
+    NAME_OPS_LITTLE(1, 1, false, 2, 1,  true),
+    NAME_OPS_LITTLE(1, 1, false, 4, 1,  true),
+    NAME_OPS_LITTLE(1, 1, false, 8, 1,  true),
+    NAME_OPS_LITTLE(1, 1, false, 2, 2,  true),
+    NAME_OPS_LITTLE(1, 1, false, 4, 2,  true),
+    NAME_OPS_LITTLE(1, 1, false, 8, 2,  true),
+    NAME_OPS_LITTLE(1, 1, false, 4, 4,  true),
+    NAME_OPS_LITTLE(1, 1, false, 8, 4,  true),
+    NAME_OPS_LITTLE(1, 1, false, 8, 8,  true),
+    NAME_OPS_LITTLE(1, 1, false, 1, 1, false),
+    NAME_OPS_LITTLE(1, 1, false, 2, 1, false),
+    NAME_OPS_LITTLE(1, 1, false, 4, 1, false),
+    NAME_OPS_LITTLE(1, 1, false, 8, 1, false),
+    NAME_OPS_LITTLE(1, 1, false, 2, 2, false),
+    NAME_OPS_LITTLE(1, 1, false, 4, 2, false),
+    NAME_OPS_LITTLE(1, 1, false, 8, 2, false),
+    NAME_OPS_LITTLE(1, 1, false, 4, 4, false),
+    NAME_OPS_LITTLE(1, 1, false, 8, 4, false),
+    NAME_OPS_LITTLE(1, 1, false, 8, 8, false),
+    NAME_OPS_LITTLE(2, 1, false, 1, 1,  true),
+    NAME_OPS_LITTLE(2, 1, false, 2, 1,  true),
+    NAME_OPS_LITTLE(2, 1, false, 4, 1,  true),
+    NAME_OPS_LITTLE(2, 1, false, 8, 1,  true),
+    NAME_OPS_LITTLE(2, 1, false, 2, 2,  true),
+    NAME_OPS_LITTLE(2, 1, false, 4, 2,  true),
+    NAME_OPS_LITTLE(2, 1, false, 8, 2,  true),
+    NAME_OPS_LITTLE(2, 1, false, 4, 4,  true),
+    NAME_OPS_LITTLE(2, 1, false, 8, 4,  true),
+    NAME_OPS_LITTLE(2, 1, false, 8, 8,  true),
+    NAME_OPS_LITTLE(2, 1, false, 1, 1, false),
+    NAME_OPS_LITTLE(2, 1, false, 2, 1, false),
+    NAME_OPS_LITTLE(2, 1, false, 4, 1, false),
+    NAME_OPS_LITTLE(2, 1, false, 8, 1, false),
+    NAME_OPS_LITTLE(2, 1, false, 2, 2, false),
+    NAME_OPS_LITTLE(2, 1, false, 4, 2, false),
+    NAME_OPS_LITTLE(2, 1, false, 8, 2, false),
+    NAME_OPS_LITTLE(2, 1, false, 4, 4, false),
+    NAME_OPS_LITTLE(2, 1, false, 8, 4, false),
+    NAME_OPS_LITTLE(2, 1, false, 8, 8, false),
+    NAME_OPS_LITTLE(4, 1, false, 1, 1,  true),
+    NAME_OPS_LITTLE(4, 1, false, 2, 1,  true),
+    NAME_OPS_LITTLE(4, 1, false, 4, 1,  true),
+    NAME_OPS_LITTLE(4, 1, false, 8, 1,  true),
+    NAME_OPS_LITTLE(4, 1, false, 2, 2,  true),
+    NAME_OPS_LITTLE(4, 1, false, 4, 2,  true),
+    NAME_OPS_LITTLE(4, 1, false, 8, 2,  true),
+    NAME_OPS_LITTLE(4, 1, false, 4, 4,  true),
+    NAME_OPS_LITTLE(4, 1, false, 8, 4,  true),
+    NAME_OPS_LITTLE(4, 1, false, 8, 8,  true),
+    NAME_OPS_LITTLE(4, 1, false, 1, 1, false),
+    NAME_OPS_LITTLE(4, 1, false, 2, 1, false),
+    NAME_OPS_LITTLE(4, 1, false, 4, 1, false),
+    NAME_OPS_LITTLE(4, 1, false, 8, 1, false),
+    NAME_OPS_LITTLE(4, 1, false, 2, 2, false),
+    NAME_OPS_LITTLE(4, 1, false, 4, 2, false),
+    NAME_OPS_LITTLE(4, 1, false, 8, 2, false),
+    NAME_OPS_LITTLE(4, 1, false, 4, 4, false),
+    NAME_OPS_LITTLE(4, 1, false, 8, 4, false),
+    NAME_OPS_LITTLE(4, 1, false, 8, 8, false),
+    NAME_OPS_LITTLE(8, 1, false, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 1, false, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 1, false, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 1, false, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 1, false, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 1, false, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 1, false, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 1, false, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 1, false, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 1, false, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 1, false, 1, 1, false),
+    NAME_OPS_LITTLE(8, 1, false, 2, 1, false),
+    NAME_OPS_LITTLE(8, 1, false, 4, 1, false),
+    NAME_OPS_LITTLE(8, 1, false, 8, 1, false),
+    NAME_OPS_LITTLE(8, 1, false, 2, 2, false),
+    NAME_OPS_LITTLE(8, 1, false, 4, 2, false),
+    NAME_OPS_LITTLE(8, 1, false, 8, 2, false),
+    NAME_OPS_LITTLE(8, 1, false, 4, 4, false),
+    NAME_OPS_LITTLE(8, 1, false, 8, 4, false),
+    NAME_OPS_LITTLE(8, 1, false, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_little_w_valid[] = {
+    NAME_OPS_LITTLE(2, 2,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(2, 2,  true, 1, 1, false),
+    NAME_OPS_LITTLE(2, 2,  true, 2, 1, false),
+    NAME_OPS_LITTLE(2, 2,  true, 4, 1, false),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 1, false),
+    NAME_OPS_LITTLE(2, 2,  true, 2, 2, false),
+    NAME_OPS_LITTLE(2, 2,  true, 4, 2, false),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 2, false),
+    NAME_OPS_LITTLE(2, 2,  true, 4, 4, false),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 4, false),
+    NAME_OPS_LITTLE(2, 2,  true, 8, 8, false),
+    NAME_OPS_LITTLE(4, 2,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(4, 2,  true, 1, 1, false),
+    NAME_OPS_LITTLE(4, 2,  true, 2, 1, false),
+    NAME_OPS_LITTLE(4, 2,  true, 4, 1, false),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 1, false),
+    NAME_OPS_LITTLE(4, 2,  true, 2, 2, false),
+    NAME_OPS_LITTLE(4, 2,  true, 4, 2, false),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 2, false),
+    NAME_OPS_LITTLE(4, 2,  true, 4, 4, false),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 4, false),
+    NAME_OPS_LITTLE(4, 2,  true, 8, 8, false),
+    NAME_OPS_LITTLE(8, 2,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 2,  true, 1, 1, false),
+    NAME_OPS_LITTLE(8, 2,  true, 2, 1, false),
+    NAME_OPS_LITTLE(8, 2,  true, 4, 1, false),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 1, false),
+    NAME_OPS_LITTLE(8, 2,  true, 2, 2, false),
+    NAME_OPS_LITTLE(8, 2,  true, 4, 2, false),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 2, false),
+    NAME_OPS_LITTLE(8, 2,  true, 4, 4, false),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 4, false),
+    NAME_OPS_LITTLE(8, 2,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_little_w_invalid[] = {
+    NAME_OPS_LITTLE(2, 2, false, 1, 1,  true),
+    NAME_OPS_LITTLE(2, 2, false, 2, 1,  true),
+    NAME_OPS_LITTLE(2, 2, false, 4, 1,  true),
+    NAME_OPS_LITTLE(2, 2, false, 8, 1,  true),
+    NAME_OPS_LITTLE(2, 2, false, 2, 2,  true),
+    NAME_OPS_LITTLE(2, 2, false, 4, 2,  true),
+    NAME_OPS_LITTLE(2, 2, false, 8, 2,  true),
+    NAME_OPS_LITTLE(2, 2, false, 4, 4,  true),
+    NAME_OPS_LITTLE(2, 2, false, 8, 4,  true),
+    NAME_OPS_LITTLE(2, 2, false, 8, 8,  true),
+    NAME_OPS_LITTLE(2, 2, false, 1, 1, false),
+    NAME_OPS_LITTLE(2, 2, false, 2, 1, false),
+    NAME_OPS_LITTLE(2, 2, false, 4, 1, false),
+    NAME_OPS_LITTLE(2, 2, false, 8, 1, false),
+    NAME_OPS_LITTLE(2, 2, false, 2, 2, false),
+    NAME_OPS_LITTLE(2, 2, false, 4, 2, false),
+    NAME_OPS_LITTLE(2, 2, false, 8, 2, false),
+    NAME_OPS_LITTLE(2, 2, false, 4, 4, false),
+    NAME_OPS_LITTLE(2, 2, false, 8, 4, false),
+    NAME_OPS_LITTLE(2, 2, false, 8, 8, false),
+    NAME_OPS_LITTLE(4, 2, false, 1, 1,  true),
+    NAME_OPS_LITTLE(4, 2, false, 2, 1,  true),
+    NAME_OPS_LITTLE(4, 2, false, 4, 1,  true),
+    NAME_OPS_LITTLE(4, 2, false, 8, 1,  true),
+    NAME_OPS_LITTLE(4, 2, false, 2, 2,  true),
+    NAME_OPS_LITTLE(4, 2, false, 4, 2,  true),
+    NAME_OPS_LITTLE(4, 2, false, 8, 2,  true),
+    NAME_OPS_LITTLE(4, 2, false, 4, 4,  true),
+    NAME_OPS_LITTLE(4, 2, false, 8, 4,  true),
+    NAME_OPS_LITTLE(4, 2, false, 8, 8,  true),
+    NAME_OPS_LITTLE(4, 2, false, 1, 1, false),
+    NAME_OPS_LITTLE(4, 2, false, 2, 1, false),
+    NAME_OPS_LITTLE(4, 2, false, 4, 1, false),
+    NAME_OPS_LITTLE(4, 2, false, 8, 1, false),
+    NAME_OPS_LITTLE(4, 2, false, 2, 2, false),
+    NAME_OPS_LITTLE(4, 2, false, 4, 2, false),
+    NAME_OPS_LITTLE(4, 2, false, 8, 2, false),
+    NAME_OPS_LITTLE(4, 2, false, 4, 4, false),
+    NAME_OPS_LITTLE(4, 2, false, 8, 4, false),
+    NAME_OPS_LITTLE(4, 2, false, 8, 8, false),
+    NAME_OPS_LITTLE(8, 2, false, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 2, false, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 2, false, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 2, false, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 2, false, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 2, false, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 2, false, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 2, false, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 2, false, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 2, false, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 2, false, 1, 1, false),
+    NAME_OPS_LITTLE(8, 2, false, 2, 1, false),
+    NAME_OPS_LITTLE(8, 2, false, 4, 1, false),
+    NAME_OPS_LITTLE(8, 2, false, 8, 1, false),
+    NAME_OPS_LITTLE(8, 2, false, 2, 2, false),
+    NAME_OPS_LITTLE(8, 2, false, 4, 2, false),
+    NAME_OPS_LITTLE(8, 2, false, 8, 2, false),
+    NAME_OPS_LITTLE(8, 2, false, 4, 4, false),
+    NAME_OPS_LITTLE(8, 2, false, 8, 4, false),
+    NAME_OPS_LITTLE(8, 2, false, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_little_l_valid[] = {
+    NAME_OPS_LITTLE(4, 4,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(4, 4,  true, 1, 1, false),
+    NAME_OPS_LITTLE(4, 4,  true, 2, 1, false),
+    NAME_OPS_LITTLE(4, 4,  true, 4, 1, false),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 1, false),
+    NAME_OPS_LITTLE(4, 4,  true, 2, 2, false),
+    NAME_OPS_LITTLE(4, 4,  true, 4, 2, false),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 2, false),
+    NAME_OPS_LITTLE(4, 4,  true, 4, 4, false),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 4, false),
+    NAME_OPS_LITTLE(4, 4,  true, 8, 8, false),
+    NAME_OPS_LITTLE(8, 4,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 4,  true, 1, 1, false),
+    NAME_OPS_LITTLE(8, 4,  true, 2, 1, false),
+    NAME_OPS_LITTLE(8, 4,  true, 4, 1, false),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 1, false),
+    NAME_OPS_LITTLE(8, 4,  true, 2, 2, false),
+    NAME_OPS_LITTLE(8, 4,  true, 4, 2, false),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 2, false),
+    NAME_OPS_LITTLE(8, 4,  true, 4, 4, false),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 4, false),
+    NAME_OPS_LITTLE(8, 4,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_little_l_invalid[] = {
+    NAME_OPS_LITTLE(4, 4, false, 1, 1,  true),
+    NAME_OPS_LITTLE(4, 4, false, 2, 1,  true),
+    NAME_OPS_LITTLE(4, 4, false, 4, 1,  true),
+    NAME_OPS_LITTLE(4, 4, false, 8, 1,  true),
+    NAME_OPS_LITTLE(4, 4, false, 2, 2,  true),
+    NAME_OPS_LITTLE(4, 4, false, 4, 2,  true),
+    NAME_OPS_LITTLE(4, 4, false, 8, 2,  true),
+    NAME_OPS_LITTLE(4, 4, false, 4, 4,  true),
+    NAME_OPS_LITTLE(4, 4, false, 8, 4,  true),
+    NAME_OPS_LITTLE(4, 4, false, 8, 8,  true),
+    NAME_OPS_LITTLE(4, 4, false, 1, 1, false),
+    NAME_OPS_LITTLE(4, 4, false, 2, 1, false),
+    NAME_OPS_LITTLE(4, 4, false, 4, 1, false),
+    NAME_OPS_LITTLE(4, 4, false, 8, 1, false),
+    NAME_OPS_LITTLE(4, 4, false, 2, 2, false),
+    NAME_OPS_LITTLE(4, 4, false, 4, 2, false),
+    NAME_OPS_LITTLE(4, 4, false, 8, 2, false),
+    NAME_OPS_LITTLE(4, 4, false, 4, 4, false),
+    NAME_OPS_LITTLE(4, 4, false, 8, 4, false),
+    NAME_OPS_LITTLE(4, 4, false, 8, 8, false),
+    NAME_OPS_LITTLE(8, 4, false, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 4, false, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 4, false, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 4, false, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 4, false, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 4, false, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 4, false, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 4, false, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 4, false, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 4, false, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 4, false, 1, 1, false),
+    NAME_OPS_LITTLE(8, 4, false, 2, 1, false),
+    NAME_OPS_LITTLE(8, 4, false, 4, 1, false),
+    NAME_OPS_LITTLE(8, 4, false, 8, 1, false),
+    NAME_OPS_LITTLE(8, 4, false, 2, 2, false),
+    NAME_OPS_LITTLE(8, 4, false, 4, 2, false),
+    NAME_OPS_LITTLE(8, 4, false, 8, 2, false),
+    NAME_OPS_LITTLE(8, 4, false, 4, 4, false),
+    NAME_OPS_LITTLE(8, 4, false, 8, 4, false),
+    NAME_OPS_LITTLE(8, 4, false, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_little_q_valid[] = {
+    NAME_OPS_LITTLE(8, 8,  true, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 8,  true, 1, 1, false),
+    NAME_OPS_LITTLE(8, 8,  true, 2, 1, false),
+    NAME_OPS_LITTLE(8, 8,  true, 4, 1, false),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 1, false),
+    NAME_OPS_LITTLE(8, 8,  true, 2, 2, false),
+    NAME_OPS_LITTLE(8, 8,  true, 4, 2, false),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 2, false),
+    NAME_OPS_LITTLE(8, 8,  true, 4, 4, false),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 4, false),
+    NAME_OPS_LITTLE(8, 8,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_little_q_invalid[] = {
+    NAME_OPS_LITTLE(8, 8, false, 1, 1,  true),
+    NAME_OPS_LITTLE(8, 8, false, 2, 1,  true),
+    NAME_OPS_LITTLE(8, 8, false, 4, 1,  true),
+    NAME_OPS_LITTLE(8, 8, false, 8, 1,  true),
+    NAME_OPS_LITTLE(8, 8, false, 2, 2,  true),
+    NAME_OPS_LITTLE(8, 8, false, 4, 2,  true),
+    NAME_OPS_LITTLE(8, 8, false, 8, 2,  true),
+    NAME_OPS_LITTLE(8, 8, false, 4, 4,  true),
+    NAME_OPS_LITTLE(8, 8, false, 8, 4,  true),
+    NAME_OPS_LITTLE(8, 8, false, 8, 8,  true),
+    NAME_OPS_LITTLE(8, 8, false, 1, 1, false),
+    NAME_OPS_LITTLE(8, 8, false, 2, 1, false),
+    NAME_OPS_LITTLE(8, 8, false, 4, 1, false),
+    NAME_OPS_LITTLE(8, 8, false, 8, 1, false),
+    NAME_OPS_LITTLE(8, 8, false, 2, 2, false),
+    NAME_OPS_LITTLE(8, 8, false, 4, 2, false),
+    NAME_OPS_LITTLE(8, 8, false, 8, 2, false),
+    NAME_OPS_LITTLE(8, 8, false, 4, 4, false),
+    NAME_OPS_LITTLE(8, 8, false, 8, 4, false),
+    NAME_OPS_LITTLE(8, 8, false, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_b_valid[] = {
+    NAME_OPS_BIG(1, 1,  true, 1, 1,  true),
+    NAME_OPS_BIG(1, 1,  true, 2, 1,  true),
+    NAME_OPS_BIG(1, 1,  true, 4, 1,  true),
+    NAME_OPS_BIG(1, 1,  true, 8, 1,  true),
+    NAME_OPS_BIG(1, 1,  true, 2, 2,  true),
+    NAME_OPS_BIG(1, 1,  true, 4, 2,  true),
+    NAME_OPS_BIG(1, 1,  true, 8, 2,  true),
+    NAME_OPS_BIG(1, 1,  true, 4, 4,  true),
+    NAME_OPS_BIG(1, 1,  true, 8, 4,  true),
+    NAME_OPS_BIG(1, 1,  true, 8, 8,  true),
+    NAME_OPS_BIG(1, 1,  true, 1, 1, false),
+    NAME_OPS_BIG(1, 1,  true, 2, 1, false),
+    NAME_OPS_BIG(1, 1,  true, 4, 1, false),
+    NAME_OPS_BIG(1, 1,  true, 8, 1, false),
+    NAME_OPS_BIG(1, 1,  true, 2, 2, false),
+    NAME_OPS_BIG(1, 1,  true, 4, 2, false),
+    NAME_OPS_BIG(1, 1,  true, 8, 2, false),
+    NAME_OPS_BIG(1, 1,  true, 4, 4, false),
+    NAME_OPS_BIG(1, 1,  true, 8, 4, false),
+    NAME_OPS_BIG(1, 1,  true, 8, 8, false),
+    NAME_OPS_BIG(2, 1,  true, 1, 1,  true),
+    NAME_OPS_BIG(2, 1,  true, 2, 1,  true),
+    NAME_OPS_BIG(2, 1,  true, 4, 1,  true),
+    NAME_OPS_BIG(2, 1,  true, 8, 1,  true),
+    NAME_OPS_BIG(2, 1,  true, 2, 2,  true),
+    NAME_OPS_BIG(2, 1,  true, 4, 2,  true),
+    NAME_OPS_BIG(2, 1,  true, 8, 2,  true),
+    NAME_OPS_BIG(2, 1,  true, 4, 4,  true),
+    NAME_OPS_BIG(2, 1,  true, 8, 4,  true),
+    NAME_OPS_BIG(2, 1,  true, 8, 8,  true),
+    NAME_OPS_BIG(2, 1,  true, 1, 1, false),
+    NAME_OPS_BIG(2, 1,  true, 2, 1, false),
+    NAME_OPS_BIG(2, 1,  true, 4, 1, false),
+    NAME_OPS_BIG(2, 1,  true, 8, 1, false),
+    NAME_OPS_BIG(2, 1,  true, 2, 2, false),
+    NAME_OPS_BIG(2, 1,  true, 4, 2, false),
+    NAME_OPS_BIG(2, 1,  true, 8, 2, false),
+    NAME_OPS_BIG(2, 1,  true, 4, 4, false),
+    NAME_OPS_BIG(2, 1,  true, 8, 4, false),
+    NAME_OPS_BIG(2, 1,  true, 8, 8, false),
+    NAME_OPS_BIG(4, 1,  true, 1, 1,  true),
+    NAME_OPS_BIG(4, 1,  true, 2, 1,  true),
+    NAME_OPS_BIG(4, 1,  true, 4, 1,  true),
+    NAME_OPS_BIG(4, 1,  true, 8, 1,  true),
+    NAME_OPS_BIG(4, 1,  true, 2, 2,  true),
+    NAME_OPS_BIG(4, 1,  true, 4, 2,  true),
+    NAME_OPS_BIG(4, 1,  true, 8, 2,  true),
+    NAME_OPS_BIG(4, 1,  true, 4, 4,  true),
+    NAME_OPS_BIG(4, 1,  true, 8, 4,  true),
+    NAME_OPS_BIG(4, 1,  true, 8, 8,  true),
+    NAME_OPS_BIG(4, 1,  true, 1, 1, false),
+    NAME_OPS_BIG(4, 1,  true, 2, 1, false),
+    NAME_OPS_BIG(4, 1,  true, 4, 1, false),
+    NAME_OPS_BIG(4, 1,  true, 8, 1, false),
+    NAME_OPS_BIG(4, 1,  true, 2, 2, false),
+    NAME_OPS_BIG(4, 1,  true, 4, 2, false),
+    NAME_OPS_BIG(4, 1,  true, 8, 2, false),
+    NAME_OPS_BIG(4, 1,  true, 4, 4, false),
+    NAME_OPS_BIG(4, 1,  true, 8, 4, false),
+    NAME_OPS_BIG(4, 1,  true, 8, 8, false),
+    NAME_OPS_BIG(8, 1,  true, 1, 1,  true),
+    NAME_OPS_BIG(8, 1,  true, 2, 1,  true),
+    NAME_OPS_BIG(8, 1,  true, 4, 1,  true),
+    NAME_OPS_BIG(8, 1,  true, 8, 1,  true),
+    NAME_OPS_BIG(8, 1,  true, 2, 2,  true),
+    NAME_OPS_BIG(8, 1,  true, 4, 2,  true),
+    NAME_OPS_BIG(8, 1,  true, 8, 2,  true),
+    NAME_OPS_BIG(8, 1,  true, 4, 4,  true),
+    NAME_OPS_BIG(8, 1,  true, 8, 4,  true),
+    NAME_OPS_BIG(8, 1,  true, 8, 8,  true),
+    NAME_OPS_BIG(8, 1,  true, 1, 1, false),
+    NAME_OPS_BIG(8, 1,  true, 2, 1, false),
+    NAME_OPS_BIG(8, 1,  true, 4, 1, false),
+    NAME_OPS_BIG(8, 1,  true, 8, 1, false),
+    NAME_OPS_BIG(8, 1,  true, 2, 2, false),
+    NAME_OPS_BIG(8, 1,  true, 4, 2, false),
+    NAME_OPS_BIG(8, 1,  true, 8, 2, false),
+    NAME_OPS_BIG(8, 1,  true, 4, 4, false),
+    NAME_OPS_BIG(8, 1,  true, 8, 4, false),
+    NAME_OPS_BIG(8, 1,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_b_invalid[] = {
+    NAME_OPS_BIG(1, 1, false, 1, 1,  true),
+    NAME_OPS_BIG(1, 1, false, 2, 1,  true),
+    NAME_OPS_BIG(1, 1, false, 4, 1,  true),
+    NAME_OPS_BIG(1, 1, false, 8, 1,  true),
+    NAME_OPS_BIG(1, 1, false, 2, 2,  true),
+    NAME_OPS_BIG(1, 1, false, 4, 2,  true),
+    NAME_OPS_BIG(1, 1, false, 8, 2,  true),
+    NAME_OPS_BIG(1, 1, false, 4, 4,  true),
+    NAME_OPS_BIG(1, 1, false, 8, 4,  true),
+    NAME_OPS_BIG(1, 1, false, 8, 8,  true),
+    NAME_OPS_BIG(1, 1, false, 1, 1, false),
+    NAME_OPS_BIG(1, 1, false, 2, 1, false),
+    NAME_OPS_BIG(1, 1, false, 4, 1, false),
+    NAME_OPS_BIG(1, 1, false, 8, 1, false),
+    NAME_OPS_BIG(1, 1, false, 2, 2, false),
+    NAME_OPS_BIG(1, 1, false, 4, 2, false),
+    NAME_OPS_BIG(1, 1, false, 8, 2, false),
+    NAME_OPS_BIG(1, 1, false, 4, 4, false),
+    NAME_OPS_BIG(1, 1, false, 8, 4, false),
+    NAME_OPS_BIG(1, 1, false, 8, 8, false),
+    NAME_OPS_BIG(2, 1, false, 1, 1,  true),
+    NAME_OPS_BIG(2, 1, false, 2, 1,  true),
+    NAME_OPS_BIG(2, 1, false, 4, 1,  true),
+    NAME_OPS_BIG(2, 1, false, 8, 1,  true),
+    NAME_OPS_BIG(2, 1, false, 2, 2,  true),
+    NAME_OPS_BIG(2, 1, false, 4, 2,  true),
+    NAME_OPS_BIG(2, 1, false, 8, 2,  true),
+    NAME_OPS_BIG(2, 1, false, 4, 4,  true),
+    NAME_OPS_BIG(2, 1, false, 8, 4,  true),
+    NAME_OPS_BIG(2, 1, false, 8, 8,  true),
+    NAME_OPS_BIG(2, 1, false, 1, 1, false),
+    NAME_OPS_BIG(2, 1, false, 2, 1, false),
+    NAME_OPS_BIG(2, 1, false, 4, 1, false),
+    NAME_OPS_BIG(2, 1, false, 8, 1, false),
+    NAME_OPS_BIG(2, 1, false, 2, 2, false),
+    NAME_OPS_BIG(2, 1, false, 4, 2, false),
+    NAME_OPS_BIG(2, 1, false, 8, 2, false),
+    NAME_OPS_BIG(2, 1, false, 4, 4, false),
+    NAME_OPS_BIG(2, 1, false, 8, 4, false),
+    NAME_OPS_BIG(2, 1, false, 8, 8, false),
+    NAME_OPS_BIG(4, 1, false, 1, 1,  true),
+    NAME_OPS_BIG(4, 1, false, 2, 1,  true),
+    NAME_OPS_BIG(4, 1, false, 4, 1,  true),
+    NAME_OPS_BIG(4, 1, false, 8, 1,  true),
+    NAME_OPS_BIG(4, 1, false, 2, 2,  true),
+    NAME_OPS_BIG(4, 1, false, 4, 2,  true),
+    NAME_OPS_BIG(4, 1, false, 8, 2,  true),
+    NAME_OPS_BIG(4, 1, false, 4, 4,  true),
+    NAME_OPS_BIG(4, 1, false, 8, 4,  true),
+    NAME_OPS_BIG(4, 1, false, 8, 8,  true),
+    NAME_OPS_BIG(4, 1, false, 1, 1, false),
+    NAME_OPS_BIG(4, 1, false, 2, 1, false),
+    NAME_OPS_BIG(4, 1, false, 4, 1, false),
+    NAME_OPS_BIG(4, 1, false, 8, 1, false),
+    NAME_OPS_BIG(4, 1, false, 2, 2, false),
+    NAME_OPS_BIG(4, 1, false, 4, 2, false),
+    NAME_OPS_BIG(4, 1, false, 8, 2, false),
+    NAME_OPS_BIG(4, 1, false, 4, 4, false),
+    NAME_OPS_BIG(4, 1, false, 8, 4, false),
+    NAME_OPS_BIG(4, 1, false, 8, 8, false),
+    NAME_OPS_BIG(8, 1, false, 1, 1,  true),
+    NAME_OPS_BIG(8, 1, false, 2, 1,  true),
+    NAME_OPS_BIG(8, 1, false, 4, 1,  true),
+    NAME_OPS_BIG(8, 1, false, 8, 1,  true),
+    NAME_OPS_BIG(8, 1, false, 2, 2,  true),
+    NAME_OPS_BIG(8, 1, false, 4, 2,  true),
+    NAME_OPS_BIG(8, 1, false, 8, 2,  true),
+    NAME_OPS_BIG(8, 1, false, 4, 4,  true),
+    NAME_OPS_BIG(8, 1, false, 8, 4,  true),
+    NAME_OPS_BIG(8, 1, false, 8, 8,  true),
+    NAME_OPS_BIG(8, 1, false, 1, 1, false),
+    NAME_OPS_BIG(8, 1, false, 2, 1, false),
+    NAME_OPS_BIG(8, 1, false, 4, 1, false),
+    NAME_OPS_BIG(8, 1, false, 8, 1, false),
+    NAME_OPS_BIG(8, 1, false, 2, 2, false),
+    NAME_OPS_BIG(8, 1, false, 4, 2, false),
+    NAME_OPS_BIG(8, 1, false, 8, 2, false),
+    NAME_OPS_BIG(8, 1, false, 4, 4, false),
+    NAME_OPS_BIG(8, 1, false, 8, 4, false),
+    NAME_OPS_BIG(8, 1, false, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_w_valid[] = {
+    NAME_OPS_BIG(2, 2,  true, 1, 1,  true),
+    NAME_OPS_BIG(2, 2,  true, 2, 1,  true),
+    NAME_OPS_BIG(2, 2,  true, 4, 1,  true),
+    NAME_OPS_BIG(2, 2,  true, 8, 1,  true),
+    NAME_OPS_BIG(2, 2,  true, 2, 2,  true),
+    NAME_OPS_BIG(2, 2,  true, 4, 2,  true),
+    NAME_OPS_BIG(2, 2,  true, 8, 2,  true),
+    NAME_OPS_BIG(2, 2,  true, 4, 4,  true),
+    NAME_OPS_BIG(2, 2,  true, 8, 4,  true),
+    NAME_OPS_BIG(2, 2,  true, 8, 8,  true),
+    NAME_OPS_BIG(2, 2,  true, 1, 1, false),
+    NAME_OPS_BIG(2, 2,  true, 2, 1, false),
+    NAME_OPS_BIG(2, 2,  true, 4, 1, false),
+    NAME_OPS_BIG(2, 2,  true, 8, 1, false),
+    NAME_OPS_BIG(2, 2,  true, 2, 2, false),
+    NAME_OPS_BIG(2, 2,  true, 4, 2, false),
+    NAME_OPS_BIG(2, 2,  true, 8, 2, false),
+    NAME_OPS_BIG(2, 2,  true, 4, 4, false),
+    NAME_OPS_BIG(2, 2,  true, 8, 4, false),
+    NAME_OPS_BIG(2, 2,  true, 8, 8, false),
+    NAME_OPS_BIG(4, 2,  true, 1, 1,  true),
+    NAME_OPS_BIG(4, 2,  true, 2, 1,  true),
+    NAME_OPS_BIG(4, 2,  true, 4, 1,  true),
+    NAME_OPS_BIG(4, 2,  true, 8, 1,  true),
+    NAME_OPS_BIG(4, 2,  true, 2, 2,  true),
+    NAME_OPS_BIG(4, 2,  true, 4, 2,  true),
+    NAME_OPS_BIG(4, 2,  true, 8, 2,  true),
+    NAME_OPS_BIG(4, 2,  true, 4, 4,  true),
+    NAME_OPS_BIG(4, 2,  true, 8, 4,  true),
+    NAME_OPS_BIG(4, 2,  true, 8, 8,  true),
+    NAME_OPS_BIG(4, 2,  true, 1, 1, false),
+    NAME_OPS_BIG(4, 2,  true, 2, 1, false),
+    NAME_OPS_BIG(4, 2,  true, 4, 1, false),
+    NAME_OPS_BIG(4, 2,  true, 8, 1, false),
+    NAME_OPS_BIG(4, 2,  true, 2, 2, false),
+    NAME_OPS_BIG(4, 2,  true, 4, 2, false),
+    NAME_OPS_BIG(4, 2,  true, 8, 2, false),
+    NAME_OPS_BIG(4, 2,  true, 4, 4, false),
+    NAME_OPS_BIG(4, 2,  true, 8, 4, false),
+    NAME_OPS_BIG(4, 2,  true, 8, 8, false),
+    NAME_OPS_BIG(8, 2,  true, 1, 1,  true),
+    NAME_OPS_BIG(8, 2,  true, 2, 1,  true),
+    NAME_OPS_BIG(8, 2,  true, 4, 1,  true),
+    NAME_OPS_BIG(8, 2,  true, 8, 1,  true),
+    NAME_OPS_BIG(8, 2,  true, 2, 2,  true),
+    NAME_OPS_BIG(8, 2,  true, 4, 2,  true),
+    NAME_OPS_BIG(8, 2,  true, 8, 2,  true),
+    NAME_OPS_BIG(8, 2,  true, 4, 4,  true),
+    NAME_OPS_BIG(8, 2,  true, 8, 4,  true),
+    NAME_OPS_BIG(8, 2,  true, 8, 8,  true),
+    NAME_OPS_BIG(8, 2,  true, 1, 1, false),
+    NAME_OPS_BIG(8, 2,  true, 2, 1, false),
+    NAME_OPS_BIG(8, 2,  true, 4, 1, false),
+    NAME_OPS_BIG(8, 2,  true, 8, 1, false),
+    NAME_OPS_BIG(8, 2,  true, 2, 2, false),
+    NAME_OPS_BIG(8, 2,  true, 4, 2, false),
+    NAME_OPS_BIG(8, 2,  true, 8, 2, false),
+    NAME_OPS_BIG(8, 2,  true, 4, 4, false),
+    NAME_OPS_BIG(8, 2,  true, 8, 4, false),
+    NAME_OPS_BIG(8, 2,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_w_invalid[] = {
+    NAME_OPS_BIG(2, 2, false, 1, 1,  true),
+    NAME_OPS_BIG(2, 2, false, 2, 1,  true),
+    NAME_OPS_BIG(2, 2, false, 4, 1,  true),
+    NAME_OPS_BIG(2, 2, false, 8, 1,  true),
+    NAME_OPS_BIG(2, 2, false, 2, 2,  true),
+    NAME_OPS_BIG(2, 2, false, 4, 2,  true),
+    NAME_OPS_BIG(2, 2, false, 8, 2,  true),
+    NAME_OPS_BIG(2, 2, false, 4, 4,  true),
+    NAME_OPS_BIG(2, 2, false, 8, 4,  true),
+    NAME_OPS_BIG(2, 2, false, 8, 8,  true),
+    NAME_OPS_BIG(2, 2, false, 1, 1, false),
+    NAME_OPS_BIG(2, 2, false, 2, 1, false),
+    NAME_OPS_BIG(2, 2, false, 4, 1, false),
+    NAME_OPS_BIG(2, 2, false, 8, 1, false),
+    NAME_OPS_BIG(2, 2, false, 2, 2, false),
+    NAME_OPS_BIG(2, 2, false, 4, 2, false),
+    NAME_OPS_BIG(2, 2, false, 8, 2, false),
+    NAME_OPS_BIG(2, 2, false, 4, 4, false),
+    NAME_OPS_BIG(2, 2, false, 8, 4, false),
+    NAME_OPS_BIG(2, 2, false, 8, 8, false),
+    NAME_OPS_BIG(4, 2, false, 1, 1,  true),
+    NAME_OPS_BIG(4, 2, false, 2, 1,  true),
+    NAME_OPS_BIG(4, 2, false, 4, 1,  true),
+    NAME_OPS_BIG(4, 2, false, 8, 1,  true),
+    NAME_OPS_BIG(4, 2, false, 2, 2,  true),
+    NAME_OPS_BIG(4, 2, false, 4, 2,  true),
+    NAME_OPS_BIG(4, 2, false, 8, 2,  true),
+    NAME_OPS_BIG(4, 2, false, 4, 4,  true),
+    NAME_OPS_BIG(4, 2, false, 8, 4,  true),
+    NAME_OPS_BIG(4, 2, false, 8, 8,  true),
+    NAME_OPS_BIG(4, 2, false, 1, 1, false),
+    NAME_OPS_BIG(4, 2, false, 2, 1, false),
+    NAME_OPS_BIG(4, 2, false, 4, 1, false),
+    NAME_OPS_BIG(4, 2, false, 8, 1, false),
+    NAME_OPS_BIG(4, 2, false, 2, 2, false),
+    NAME_OPS_BIG(4, 2, false, 4, 2, false),
+    NAME_OPS_BIG(4, 2, false, 8, 2, false),
+    NAME_OPS_BIG(4, 2, false, 4, 4, false),
+    NAME_OPS_BIG(4, 2, false, 8, 4, false),
+    NAME_OPS_BIG(4, 2, false, 8, 8, false),
+    NAME_OPS_BIG(8, 2, false, 1, 1,  true),
+    NAME_OPS_BIG(8, 2, false, 2, 1,  true),
+    NAME_OPS_BIG(8, 2, false, 4, 1,  true),
+    NAME_OPS_BIG(8, 2, false, 8, 1,  true),
+    NAME_OPS_BIG(8, 2, false, 2, 2,  true),
+    NAME_OPS_BIG(8, 2, false, 4, 2,  true),
+    NAME_OPS_BIG(8, 2, false, 8, 2,  true),
+    NAME_OPS_BIG(8, 2, false, 4, 4,  true),
+    NAME_OPS_BIG(8, 2, false, 8, 4,  true),
+    NAME_OPS_BIG(8, 2, false, 8, 8,  true),
+    NAME_OPS_BIG(8, 2, false, 1, 1, false),
+    NAME_OPS_BIG(8, 2, false, 2, 1, false),
+    NAME_OPS_BIG(8, 2, false, 4, 1, false),
+    NAME_OPS_BIG(8, 2, false, 8, 1, false),
+    NAME_OPS_BIG(8, 2, false, 2, 2, false),
+    NAME_OPS_BIG(8, 2, false, 4, 2, false),
+    NAME_OPS_BIG(8, 2, false, 8, 2, false),
+    NAME_OPS_BIG(8, 2, false, 4, 4, false),
+    NAME_OPS_BIG(8, 2, false, 8, 4, false),
+    NAME_OPS_BIG(8, 2, false, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_l_valid[] = {
+    NAME_OPS_BIG(4, 4,  true, 1, 1,  true),
+    NAME_OPS_BIG(4, 4,  true, 2, 1,  true),
+    NAME_OPS_BIG(4, 4,  true, 4, 1,  true),
+    NAME_OPS_BIG(4, 4,  true, 8, 1,  true),
+    NAME_OPS_BIG(4, 4,  true, 2, 2,  true),
+    NAME_OPS_BIG(4, 4,  true, 4, 2,  true),
+    NAME_OPS_BIG(4, 4,  true, 8, 2,  true),
+    NAME_OPS_BIG(4, 4,  true, 4, 4,  true),
+    NAME_OPS_BIG(4, 4,  true, 8, 4,  true),
+    NAME_OPS_BIG(4, 4,  true, 8, 8,  true),
+    NAME_OPS_BIG(4, 4,  true, 1, 1, false),
+    NAME_OPS_BIG(4, 4,  true, 2, 1, false),
+    NAME_OPS_BIG(4, 4,  true, 4, 1, false),
+    NAME_OPS_BIG(4, 4,  true, 8, 1, false),
+    NAME_OPS_BIG(4, 4,  true, 2, 2, false),
+    NAME_OPS_BIG(4, 4,  true, 4, 2, false),
+    NAME_OPS_BIG(4, 4,  true, 8, 2, false),
+    NAME_OPS_BIG(4, 4,  true, 4, 4, false),
+    NAME_OPS_BIG(4, 4,  true, 8, 4, false),
+    NAME_OPS_BIG(4, 4,  true, 8, 8, false),
+    NAME_OPS_BIG(8, 4,  true, 1, 1,  true),
+    NAME_OPS_BIG(8, 4,  true, 2, 1,  true),
+    NAME_OPS_BIG(8, 4,  true, 4, 1,  true),
+    NAME_OPS_BIG(8, 4,  true, 8, 1,  true),
+    NAME_OPS_BIG(8, 4,  true, 2, 2,  true),
+    NAME_OPS_BIG(8, 4,  true, 4, 2,  true),
+    NAME_OPS_BIG(8, 4,  true, 8, 2,  true),
+    NAME_OPS_BIG(8, 4,  true, 4, 4,  true),
+    NAME_OPS_BIG(8, 4,  true, 8, 4,  true),
+    NAME_OPS_BIG(8, 4,  true, 8, 8,  true),
+    NAME_OPS_BIG(8, 4,  true, 1, 1, false),
+    NAME_OPS_BIG(8, 4,  true, 2, 1, false),
+    NAME_OPS_BIG(8, 4,  true, 4, 1, false),
+    NAME_OPS_BIG(8, 4,  true, 8, 1, false),
+    NAME_OPS_BIG(8, 4,  true, 2, 2, false),
+    NAME_OPS_BIG(8, 4,  true, 4, 2, false),
+    NAME_OPS_BIG(8, 4,  true, 8, 2, false),
+    NAME_OPS_BIG(8, 4,  true, 4, 4, false),
+    NAME_OPS_BIG(8, 4,  true, 8, 4, false),
+    NAME_OPS_BIG(8, 4,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_l_invalid[] = {
+    NAME_OPS_BIG(4, 4, false, 1, 1,  true),
+    NAME_OPS_BIG(4, 4, false, 2, 1,  true),
+    NAME_OPS_BIG(4, 4, false, 4, 1,  true),
+    NAME_OPS_BIG(4, 4, false, 8, 1,  true),
+    NAME_OPS_BIG(4, 4, false, 2, 2,  true),
+    NAME_OPS_BIG(4, 4, false, 4, 2,  true),
+    NAME_OPS_BIG(4, 4, false, 8, 2,  true),
+    NAME_OPS_BIG(4, 4, false, 4, 4,  true),
+    NAME_OPS_BIG(4, 4, false, 8, 4,  true),
+    NAME_OPS_BIG(4, 4, false, 8, 8,  true),
+    NAME_OPS_BIG(4, 4, false, 1, 1, false),
+    NAME_OPS_BIG(4, 4, false, 2, 1, false),
+    NAME_OPS_BIG(4, 4, false, 4, 1, false),
+    NAME_OPS_BIG(4, 4, false, 8, 1, false),
+    NAME_OPS_BIG(4, 4, false, 2, 2, false),
+    NAME_OPS_BIG(4, 4, false, 4, 2, false),
+    NAME_OPS_BIG(4, 4, false, 8, 2, false),
+    NAME_OPS_BIG(4, 4, false, 4, 4, false),
+    NAME_OPS_BIG(4, 4, false, 8, 4, false),
+    NAME_OPS_BIG(4, 4, false, 8, 8, false),
+    NAME_OPS_BIG(8, 4, false, 1, 1,  true),
+    NAME_OPS_BIG(8, 4, false, 2, 1,  true),
+    NAME_OPS_BIG(8, 4, false, 4, 1,  true),
+    NAME_OPS_BIG(8, 4, false, 8, 1,  true),
+    NAME_OPS_BIG(8, 4, false, 2, 2,  true),
+    NAME_OPS_BIG(8, 4, false, 4, 2,  true),
+    NAME_OPS_BIG(8, 4, false, 8, 2,  true),
+    NAME_OPS_BIG(8, 4, false, 4, 4,  true),
+    NAME_OPS_BIG(8, 4, false, 8, 4,  true),
+    NAME_OPS_BIG(8, 4, false, 8, 8,  true),
+    NAME_OPS_BIG(8, 4, false, 1, 1, false),
+    NAME_OPS_BIG(8, 4, false, 2, 1, false),
+    NAME_OPS_BIG(8, 4, false, 4, 1, false),
+    NAME_OPS_BIG(8, 4, false, 8, 1, false),
+    NAME_OPS_BIG(8, 4, false, 2, 2, false),
+    NAME_OPS_BIG(8, 4, false, 4, 2, false),
+    NAME_OPS_BIG(8, 4, false, 8, 2, false),
+    NAME_OPS_BIG(8, 4, false, 4, 4, false),
+    NAME_OPS_BIG(8, 4, false, 8, 4, false),
+    NAME_OPS_BIG(8, 4, false, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_q_valid[] = {
+    NAME_OPS_BIG(8, 8,  true, 1, 1,  true),
+    NAME_OPS_BIG(8, 8,  true, 2, 1,  true),
+    NAME_OPS_BIG(8, 8,  true, 4, 1,  true),
+    NAME_OPS_BIG(8, 8,  true, 8, 1,  true),
+    NAME_OPS_BIG(8, 8,  true, 2, 2,  true),
+    NAME_OPS_BIG(8, 8,  true, 4, 2,  true),
+    NAME_OPS_BIG(8, 8,  true, 8, 2,  true),
+    NAME_OPS_BIG(8, 8,  true, 4, 4,  true),
+    NAME_OPS_BIG(8, 8,  true, 8, 4,  true),
+    NAME_OPS_BIG(8, 8,  true, 8, 8,  true),
+    NAME_OPS_BIG(8, 8,  true, 1, 1, false),
+    NAME_OPS_BIG(8, 8,  true, 2, 1, false),
+    NAME_OPS_BIG(8, 8,  true, 4, 1, false),
+    NAME_OPS_BIG(8, 8,  true, 8, 1, false),
+    NAME_OPS_BIG(8, 8,  true, 2, 2, false),
+    NAME_OPS_BIG(8, 8,  true, 4, 2, false),
+    NAME_OPS_BIG(8, 8,  true, 8, 2, false),
+    NAME_OPS_BIG(8, 8,  true, 4, 4, false),
+    NAME_OPS_BIG(8, 8,  true, 8, 4, false),
+    NAME_OPS_BIG(8, 8,  true, 8, 8, false),
+};
+
+const MemoryRegionOps ops_list_big_q_invalid[] = {
+    NAME_OPS_BIG(8, 8, false, 1, 1,  true),
+    NAME_OPS_BIG(8, 8, false, 2, 1,  true),
+    NAME_OPS_BIG(8, 8, false, 4, 1,  true),
+    NAME_OPS_BIG(8, 8, false, 8, 1,  true),
+    NAME_OPS_BIG(8, 8, false, 2, 2,  true),
+    NAME_OPS_BIG(8, 8, false, 4, 2,  true),
+    NAME_OPS_BIG(8, 8, false, 8, 2,  true),
+    NAME_OPS_BIG(8, 8, false, 4, 4,  true),
+    NAME_OPS_BIG(8, 8, false, 8, 4,  true),
+    NAME_OPS_BIG(8, 8, false, 8, 8,  true),
+    NAME_OPS_BIG(8, 8, false, 1, 1, false),
+    NAME_OPS_BIG(8, 8, false, 2, 1, false),
+    NAME_OPS_BIG(8, 8, false, 4, 1, false),
+    NAME_OPS_BIG(8, 8, false, 8, 1, false),
+    NAME_OPS_BIG(8, 8, false, 2, 2, false),
+    NAME_OPS_BIG(8, 8, false, 4, 2, false),
+    NAME_OPS_BIG(8, 8, false, 8, 2, false),
+    NAME_OPS_BIG(8, 8, false, 4, 4, false),
+    NAME_OPS_BIG(8, 8, false, 8, 4, false),
+    NAME_OPS_BIG(8, 8, false, 8, 8, false),
+};
+
+#define N_OPS_LIST_LITTLE_B_VALID \
+    (sizeof(ops_list_little_b_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_LITTLE_W_VALID \
+    (sizeof(ops_list_little_w_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_LITTLE_L_VALID \
+    (sizeof(ops_list_little_l_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_LITTLE_Q_VALID \
+    (sizeof(ops_list_little_q_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_LITTLE_B_INVALID \
+    (sizeof(ops_list_little_b_invalid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_LITTLE_W_INVALID \
+    (sizeof(ops_list_little_w_invalid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_LITTLE_L_INVALID \
+    (sizeof(ops_list_little_l_invalid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_LITTLE_Q_INVALID \
+    (sizeof(ops_list_little_q_invalid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_B_VALID \
+    (sizeof(ops_list_big_b_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_W_VALID \
+    (sizeof(ops_list_big_w_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_L_VALID \
+    (sizeof(ops_list_big_l_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_Q_VALID \
+    (sizeof(ops_list_big_q_valid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_B_INVALID \
+    (sizeof(ops_list_big_b_invalid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_W_INVALID \
+    (sizeof(ops_list_big_w_invalid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_L_INVALID \
+    (sizeof(ops_list_big_l_invalid) / sizeof(MemoryRegionOps))
+#define N_OPS_LIST_BIG_Q_INVALID \
+    (sizeof(ops_list_big_q_invalid) / sizeof(MemoryRegionOps))
+
+#define N_OPS_LIST                              \
+    (N_OPS_LIST_LITTLE_B_VALID +                \
+     N_OPS_LIST_LITTLE_B_INVALID +              \
+     N_OPS_LIST_LITTLE_W_VALID +                \
+     N_OPS_LIST_LITTLE_W_INVALID +              \
+     N_OPS_LIST_LITTLE_L_VALID +                \
+     N_OPS_LIST_LITTLE_L_INVALID +              \
+     N_OPS_LIST_LITTLE_Q_VALID +                \
+     N_OPS_LIST_LITTLE_Q_INVALID +              \
+     N_OPS_LIST_BIG_B_VALID +                   \
+     N_OPS_LIST_BIG_B_INVALID +                 \
+     N_OPS_LIST_BIG_W_VALID +                   \
+     N_OPS_LIST_BIG_W_INVALID +                 \
+     N_OPS_LIST_BIG_L_VALID +                   \
+     N_OPS_LIST_BIG_L_INVALID +                 \
+     N_OPS_LIST_BIG_Q_VALID +                   \
+     N_OPS_LIST_BIG_Q_INVALID)
+
+#define OFF_IDX_OPS_LIST_LITTLE_B_VALID \
+    (0)
+#define OFF_IDX_OPS_LIST_LITTLE_B_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_B_VALID + N_OPS_LIST_LITTLE_B_VALID)
+#define OFF_IDX_OPS_LIST_LITTLE_W_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_B_INVALID + N_OPS_LIST_LITTLE_B_INVALID)
+#define OFF_IDX_OPS_LIST_LITTLE_W_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_W_VALID + N_OPS_LIST_LITTLE_W_VALID)
+#define OFF_IDX_OPS_LIST_LITTLE_L_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_W_INVALID + N_OPS_LIST_LITTLE_W_INVALID)
+#define OFF_IDX_OPS_LIST_LITTLE_L_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_L_VALID + N_OPS_LIST_LITTLE_L_VALID)
+#define OFF_IDX_OPS_LIST_LITTLE_Q_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_L_INVALID + N_OPS_LIST_LITTLE_L_INVALID)
+#define OFF_IDX_OPS_LIST_LITTLE_Q_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_Q_VALID + N_OPS_LIST_LITTLE_Q_VALID)
+#define OFF_IDX_OPS_LIST_BIG_B_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_Q_INVALID + N_OPS_LIST_LITTLE_Q_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_B_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_B_VALID + N_OPS_LIST_BIG_B_VALID)
+#define OFF_IDX_OPS_LIST_BIG_W_VALID \
+    (OFF_IDX_OPS_LIST_BIG_B_INVALID + N_OPS_LIST_BIG_B_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_W_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_W_VALID + N_OPS_LIST_BIG_W_VALID)
+#define OFF_IDX_OPS_LIST_BIG_L_VALID \
+    (OFF_IDX_OPS_LIST_BIG_W_INVALID + N_OPS_LIST_BIG_W_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_L_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_L_VALID + N_OPS_LIST_BIG_L_VALID)
+#define OFF_IDX_OPS_LIST_BIG_Q_VALID \
+    (OFF_IDX_OPS_LIST_BIG_L_INVALID + N_OPS_LIST_BIG_L_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_Q_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_Q_VALID + N_OPS_LIST_BIG_Q_VALID)
+
+#undef GEN_OPS_LITTLE
+#undef GEN_OPS_BIG
+#undef NAME_OPS_LITTLE
+#undef NAME_OPS_BIG
+#undef __JOIN2
+#undef __JOIN2_AGAIN
+#undef __JOIN6
+#undef __JOIN6_AGAIN
+#undef __STR
+#undef __STR_AGAIN
+
+#endif
-- 
2.43.0


