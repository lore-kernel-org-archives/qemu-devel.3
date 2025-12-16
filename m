Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D9DD637DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVe8V-0001i7-M4; Tue, 16 Dec 2025 18:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vVd4T-0004kg-E3
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:59:06 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vVd4M-0006ch-MT
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:59:05 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b73161849e1so1178778566b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 13:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765922336; x=1766527136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OHRpKevWV4+Y8gDYYG+ZbSkYrLef3a5xPcEOQRGygI=;
 b=nI01R3QtdWRh4f4K4eT06b4WAMn75hX3+3qW95eVdwu3UhEtJG56gETAI3LgfFMELx
 7YBzeOe//YitlBiVSnU6KBC4S1yQkW4GgI29Cgh+Eb4XwVvBGjvOyapbQ81TJ0EsuBfj
 3VxRV0wJlqlFWxDUk+TBQ6GmjZqNjkiGJcb7dAarMNDk8F1ltsqMmJPchBt8sYOLsNy4
 08m7ObtIRBe2vPAJuiM2rZY6YzRhYgthyKXSow85tzkB1ZsOWNY/yOsFpm/uLAdoP1hH
 td4PMli/L+PGcGgTcvJWQ6/yezKeddN8zZhashCLLk0+uKQ2rlDQwqPD+dLK7ov23daz
 Daww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922336; x=1766527136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2OHRpKevWV4+Y8gDYYG+ZbSkYrLef3a5xPcEOQRGygI=;
 b=uWD66mqrZT1aYPnR6iASjldrB3vUnB5x6CUfcOeLlDSZJWKTue/51GPV03wHr3PUJb
 fljy7XwTZeloOg2RqojFhYnArdr1wcsmc3IVmoOq8xN79Hg9o3kq9ovy239n2jds9JeI
 37E+En81yIj/TRt8P07sZ1IOTMOyK3XR2TABhmQgBYboKX6SHfQeC4sZZaV02gcfWNBF
 jhPREv6dsOGWyqHedryrMaQERqTECLr2WQemIPy0dyO8RLGuN4sRY5EEdRg+W87ua/It
 STCqDaLBzNFqCAYPXF0lDEIlb+mLel/MtyjNOtHFlA0W0CvSW5gSf9nczpV1vV2ORPRO
 XjVA==
X-Gm-Message-State: AOJu0Yzl/roHLmcfrMEZOK5ftA5v2hsEXvNodQNzTU4Mel/PZBISAH6H
 dySakWlUUaXcSvJs/WGh0Lt0/A/gTu78VsC/3I0yojORqh3ZNZOc0DMUzJXu2KoH
X-Gm-Gg: AY/fxX4931S8RxkVxaeu9bm7xbmOFT6yy+jEYYmpNItGMBubB/5pudAi55B9H1JQqjf
 4Uv4izhX/UharNUgBrGMW2/1LF8fA1T/ryIiTGAGYDQv6PfHTLm/tQCD0YYR/7VR8ru/3R7P1Uv
 /d25BJ4TO7SOp372eHbUJ7SvpDbdUoVOAdFdVb35KJe4hxyc9bXvm2QOuhaN8lDyst5qHz8cH+h
 oCVwq0VHGiDX0AN0bwqDHD09b7WeLTZDsty5y8swzFh4sk1FyPfxwz5gNgGPWkM0WP4aZO4JcpM
 fqnLJ10GAtWoR8qTjaxc93pjIQhuDUB1Nniq1ojJGwRFHvAPnPBxpxxz6RElrbpN8KxrnYpkv0F
 TH2L+vAa9RdWHN+1z8WPmmwK2tcG/eVFfO4WMyHjkzG4OWUMoUtpv4tEH9YcNhZqjouGIXSRqg+
 2GbJIrd75BtZVRtXYNNl9V7vZ0OVyGIYhdTYHAFSSs1M5TmwJLWjPdVDOv5P61ZA==
X-Google-Smtp-Source: AGHT+IHl9jyQ0uwjkGYGgjzfRdvF53GFQbFCOJD7aGmR2jwJ/fx8GiorGOAU2m2G5CdDwJ8pJxfkPQ==
X-Received: by 2002:a17:907:940d:b0:b76:7fe7:ff37 with SMTP id
 a640c23a62f3a-b7d23663374mr1764025066b.18.1765922335383; 
 Tue, 16 Dec 2025 13:58:55 -0800 (PST)
Received: from thinkpad-t470s.. (93-140-170-188.adsl.net.t-com.hr.
 [93.140.170.188]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b7fe8a956a5sm420898166b.29.2025.12.16.13.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:58:54 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: Ruslan_Ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 edgar.iglesias@amd.com, peter.maydell@linaro.org,
 volodymyr_babchuk@epam.com, artem_mygaiev@epam.com
Subject: [PATCH RFC 2/2] hw/core: add remote-port protocol implementation
Date: Tue, 16 Dec 2025 22:58:35 +0100
Message-ID: <20251216215835.208036-3-Ruslan_Ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216215835.208036-1-Ruslan_Ruslichenko@epam.com>
References: <20251216215835.208036-1-Ruslan_Ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Dec 2025 18:07:18 -0500
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Remote Port protocol is used for HW simulation, which allows
QEMU to communicate with external simulators such as SystemC.

The implementation was long available as downstream patches,
for example within https://github.com/Xilinx/qemu repo.

For more details regarding the protocol and simulation mechanism,
following document is available:

https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/862421112/Co-simulation

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 chardev/char-fe.c                      |   9 +
 hw/core/fdt_generic_util.c             | 103 +++
 hw/core/meson.build                    |   7 +
 hw/core/qdev-properties.c              |   5 +
 hw/core/remote-port-ats.c              | 405 ++++++++++
 hw/core/remote-port-gpio.c             | 199 +++++
 hw/core/remote-port-memory-master.c    | 402 ++++++++++
 hw/core/remote-port-memory-slave.c     | 257 +++++++
 hw/core/remote-port-proto.c            | 523 +++++++++++++
 hw/core/remote-port-stream.c           | 233 ++++++
 hw/core/remote-port.c                  | 986 +++++++++++++++++++++++++
 hw/core/trace-events                   |  17 +
 hw/misc/meson.build                    |   1 +
 hw/misc/xlnx-serbs.c                   |  43 ++
 include/chardev/char-fe.h              |   2 +
 include/chardev/char.h                 |   2 +
 include/hw/misc/xlnx-serbs.h           |  36 +
 include/hw/qdev-properties.h           |   2 +
 include/hw/remote-port-ats.h           |  74 ++
 include/hw/remote-port-device.h        |  56 ++
 include/hw/remote-port-gpio.h          |  32 +
 include/hw/remote-port-memory-master.h |  62 ++
 include/hw/remote-port-memory-slave.h  |  33 +
 include/hw/remote-port-proto.h         | 537 ++++++++++++++
 include/hw/remote-port.h               | 149 ++++
 include/system/dma.h                   |  19 +
 include/system/memory.h                |  50 ++
 include/system/system.h                |   2 +
 qemu-options.hx                        |  21 +
 system/physmem.c                       |  57 ++
 system/vl.c                            |   5 +
 31 files changed, 4329 insertions(+)
 create mode 100644 hw/core/remote-port-ats.c
 create mode 100644 hw/core/remote-port-gpio.c
 create mode 100644 hw/core/remote-port-memory-master.c
 create mode 100644 hw/core/remote-port-memory-slave.c
 create mode 100644 hw/core/remote-port-proto.c
 create mode 100644 hw/core/remote-port-stream.c
 create mode 100644 hw/core/remote-port.c
 create mode 100644 hw/misc/xlnx-serbs.c
 create mode 100644 include/hw/misc/xlnx-serbs.h
 create mode 100644 include/hw/remote-port-ats.h
 create mode 100644 include/hw/remote-port-device.h
 create mode 100644 include/hw/remote-port-gpio.h
 create mode 100644 include/hw/remote-port-memory-master.h
 create mode 100644 include/hw/remote-port-memory-slave.h
 create mode 100644 include/hw/remote-port-proto.h
 create mode 100644 include/hw/remote-port.h

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 34b83fc1c4..bb197d61df 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -346,6 +346,15 @@ void qemu_chr_fe_set_open(CharFrontend *c, bool is_open)
     }
 }
 
+void qemu_chr_fe_set_blocking(CharFrontend *be, bool blocking)
+{
+    Chardev *chr = be->chr;
+
+    if (chr && CHARDEV_GET_CLASS(chr)->chr_set_blocking) {
+        CHARDEV_GET_CLASS(chr)->chr_set_blocking(chr, blocking);
+    }
+}
+
 guint qemu_chr_fe_add_watch(CharFrontend *c, GIOCondition cond,
                             FEWatchFunc func, void *user_data)
 {
diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 8af3cabe51..2777ed891a 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -68,6 +68,9 @@
      } \
  } while (0);
  
+ #include "hw/remote-port-device.h"
+ #include "hw/remote-port.h"
+ 
  /* FIXME: wrap direct calls into libfdt */
  
  #include <libfdt.h>
@@ -1446,6 +1449,17 @@ static ObjectProperty *fdt_array_link_elem_prop(Object *obj, ObjectProperty *e,
      }
      fdt_init_set_opaque(fdti, node_path, dev);
  
+     /* Set the default sync-quantum based on the global one. Node properties
+      * in the dtb can later override this value.  */
+     if (global_sync_quantum) {
+         ObjectProperty *p;
+ 
+         p = object_property_find(OBJECT(dev), "sync-quantum");
+         if (p) {
+             object_property_set_int(OBJECT(dev), "sync-quantum", global_sync_quantum, &errp);
+         }
+     }
+ 
      /* Call FDT Generic hooks for overriding prop default values.  */
      if (object_dynamic_cast(dev, TYPE_FDT_GENERIC_PROPS)) {
          FDTGenericPropsClass *k = FDT_GENERIC_PROPS_GET_CLASS(dev);
@@ -1512,6 +1526,73 @@ static ObjectProperty *fdt_array_link_elem_prop(Object *obj, ObjectProperty *e,
          fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
      }
  
+     /* FIXME: not pretty, but is half a sane dts binding */
+     if (object_dynamic_cast(dev, TYPE_REMOTE_PORT_DEVICE)) {
+         //int i;
+ 
+         for (i = 0;;++i) {
+             char adaptor_node_path[DT_PATH_LENGTH];
+             uint32_t adaptor_phandle, chan;
+             DeviceState *adaptor;
+             char *name;
+ 
+             adaptor_phandle = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                                     "remote-ports",
+                                                     2 * i, false, &errp);
+             if (errp) {
+                 DB_PRINT_NP(1, "cant get phandle from \"remote-ports\" "
+                             "property\n");
+                 break;
+             }
+             if (qemu_devtree_get_node_by_phandle(fdti->fdt, adaptor_node_path,
+                                                  adaptor_phandle)) {
+                 DB_PRINT_NP(1, "cant get node from phandle\n");
+                 break;
+             }
+             while (!fdt_init_has_opaque(fdti, adaptor_node_path)) {
+                 fdt_init_yield(fdti);
+             }
+             adaptor = DEVICE(fdt_init_get_opaque(fdti, adaptor_node_path));
+             name = g_strdup_printf("rp-adaptor%" PRId32, i);
+             object_property_set_link(OBJECT(dev), name, OBJECT(adaptor), &errp);
+             DB_PRINT_NP(0, "connecting RP to adaptor %s channel %d",
+                         object_get_canonical_path(OBJECT(adaptor)), i);
+             g_free(name);
+             if (errp) {
+                 DB_PRINT_NP(1, "cant set adaptor link for device property\n");
+                 break;
+             }
+ 
+             chan = qemu_fdt_getprop_cell(fdti->fdt, node_path, "remote-ports",
+                                          2 * i + 1, false, &errp);
+             if (errp) {
+                 DB_PRINT_NP(1, "cant get channel from \"remote-ports\" "
+                             "property\n");
+                 break;
+             }
+ 
+             name = g_strdup_printf("rp-chan%" PRId32, i);
+             object_property_set_int(OBJECT(dev), name, chan, &errp);
+             /* Not critical - device has right to not care about channel
+              * numbers if its a pure slave (only responses).
+              */
+             if (errp) {
+                 DB_PRINT_NP(1, "cant set %s property %s\n", name, error_get_pretty(errp));
+                 errp = NULL;
+             }
+             g_free(name);
+ 
+             name = g_strdup_printf("remote-port-dev%d", chan);
+             object_property_set_link(OBJECT(adaptor), name, OBJECT(dev), &errp);
+             g_free(name);
+             if (errp) {
+                 DB_PRINT_NP(1, "cant set device link for adaptor\n");
+                 break;
+             }
+         }
+         errp = NULL;
+     }
+ 
      if (object_dynamic_cast(dev, TYPE_DEVICE)) {
          DeviceClass *dc = DEVICE_GET_CLASS(dev);
          /* connect nic if appropriate */
@@ -1527,6 +1608,28 @@ static ObjectProperty *fdt_array_link_elem_prop(Object *obj, ObjectProperty *e,
              nics++;
          }
  
+         /* We don't want to connect remote port chardev's to the user facing
+          * serial devices.
+          */
+         if (!object_dynamic_cast(dev, TYPE_REMOTE_PORT)) {
+             /* Connect chardev if we can */
+             if (serial_hd(fdt_serial_ports)) {
+                 Chardev *value = (Chardev*) serial_hd(fdt_serial_ports);
+                 char *chardev;
+ 
+                 /* Check if the device already has a chardev.  */
+                 chardev = object_property_get_str(dev, "chardev", &errp);
+                 if (!errp && !strcmp(chardev, "")) {
+                     object_property_set_str(dev, "chardev", value->label, &errp);
+                     if (!errp) {
+                         /* It worked, the device is a charecter device */
+                         fdt_serial_ports++;
+                     }
+                 }
+                 errp = NULL;
+             }
+         }
+ 
          /* We also need to externally connect drives. Let's try to do that
           * here.
           */
diff --git a/hw/core/meson.build b/hw/core/meson.build
index cea3b4660e..84171ef649 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -48,6 +48,13 @@ system_ss.add(files(
   'sysbus.c',
   'vm-change-state-handler.c',
   'clock-vmstate.c',
+  'remote-port-proto.c',
+  'remote-port.c',
+  'remote-port-memory-master.c',
+  'remote-port-memory-slave.c',
+  'remote-port-gpio.c',
+  'remote-port-stream.c',
+  'remote-port-ats.c'
 ))
 user_ss.add(files(
   'cpu-user.c',
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 422a486969..b6d9c273c3 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -52,6 +52,11 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
+void qdev_prop_allow_set_link(const Object *obj, const char *name,
+                              Object *val, Error **errp)
+{
+}
+
 void *object_field_prop_ptr(Object *obj, const Property *prop)
 {
     void *ptr = obj;
diff --git a/hw/core/remote-port-ats.c b/hw/core/remote-port-ats.c
new file mode 100644
index 0000000000..3b223b912a
--- /dev/null
+++ b/hw/core/remote-port-ats.c
@@ -0,0 +1,405 @@
+/*
+ * QEMU remote port ATS
+ *
+ * Copyright (c) 2021 Xilinx Inc
+ * Written by Francisco Iglesias <francisco.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+
+#include "hw/remote-port-proto.h"
+#include "hw/remote-port-device.h"
+#include "hw/remote-port-ats.h"
+
+typedef struct ATSIOMMUNotifier {
+    IOMMUNotifier n;
+    MemoryRegion *mr;
+    RemotePortATS *rp_ats;
+    int iommu_idx;
+} ATSIOMMUNotifier;
+
+IOMMUTLBEntry *rp_ats_cache_lookup_translation(RemotePortATSCache *cache,
+                                               hwaddr translated_addr,
+                                               hwaddr len)
+{
+    RemotePortATSCacheClass *c = REMOTE_PORT_ATS_CACHE_GET_CLASS(cache);
+
+    return c->lookup_translation(cache, translated_addr, len);
+}
+
+static IOMMUTLBEntry *rp_ats_lookup_translation(RemotePortATSCache *cache,
+                                                hwaddr translated_addr,
+                                                hwaddr len)
+{
+    RemotePortATS *s = REMOTE_PORT_ATS(cache);
+
+    for (int i = 0; i < s->cache->len; i++) {
+        IOMMUTLBEntry *iotlb = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        hwaddr masked_start = (translated_addr & ~iotlb->addr_mask);
+        hwaddr masked_end = ((translated_addr + len - 1) & ~iotlb->addr_mask);
+
+        if (masked_start == iotlb->translated_addr &&
+            masked_end == iotlb->translated_addr) {
+            return iotlb;
+        }
+    }
+
+    return NULL;
+}
+
+static void rp_ats_cache_remove(RemotePortATS *s, IOMMUTLBEntry *iotlb)
+{
+    for (int i = 0; i < s->cache->len; i++) {
+        IOMMUTLBEntry *tmp = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        hwaddr masked_start = (tmp->iova & ~iotlb->addr_mask);
+        hwaddr masked_end = ((tmp->iova | tmp->addr_mask) & ~iotlb->addr_mask);
+
+        if (masked_start == iotlb->iova || masked_end == iotlb->iova) {
+            g_array_remove_index_fast(s->cache, i);
+        }
+    }
+}
+
+static void rp_ats_invalidate(RemotePortATS *s, IOMMUTLBEntry *iotlb)
+{
+    size_t pktlen = sizeof(struct rp_pkt_ats);
+    struct rp_pkt_ats pkt;
+    RemotePortRespSlot *rsp_slot;
+    RemotePortDynPkt *rsp;
+    size_t enclen;
+    int64_t clk;
+    uint32_t id;
+    hwaddr len = iotlb->addr_mask + 1;
+
+    id = rp_new_id(s->rp);
+    clk = rp_normalized_vmclk(s->rp);
+
+    enclen = rp_encode_ats_inv(id, s->rp_dev,
+                             &pkt,
+                             clk,
+                             0,
+                             iotlb->iova,
+                             len,
+                             0,
+                             0);
+    assert(enclen == pktlen);
+
+    rp_rsp_mutex_lock(s->rp);
+    rp_write(s->rp, (void *) &pkt, enclen);
+
+    rsp_slot = rp_dev_wait_resp(s->rp, s->rp_dev, id);
+    rsp = &rsp_slot->rsp;
+
+    /* We dont support out of order answers yet.  */
+    assert(rsp->pkt->hdr.id == id);
+
+    rp_resp_slot_done(s->rp, rsp_slot);
+    rp_rsp_mutex_unlock(s->rp);
+}
+
+static void rp_ats_cache_insert(RemotePortATS *s,
+                                hwaddr iova,
+                                hwaddr translated_addr,
+                                hwaddr mask,
+                                AddressSpace *target_as)
+{
+    IOMMUTLBEntry *iotlb;
+
+    /*
+     * Invalidate all current translations that collide with the new one and
+     * does not have the same target_as. This means that translated_addresses
+     * towards the same addresses but in different target address spaces are
+     * not allowed.
+     */
+    for (int i = 0; i < s->cache->len; i++) {
+        //IOMMUTLBEntry *iotlb = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        iotlb = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        hwaddr masked_start = (translated_addr & ~iotlb->addr_mask);
+        hwaddr masked_end = ((translated_addr | mask) & ~iotlb->addr_mask);
+        bool spans_region = masked_start < iotlb->translated_addr &&
+                             masked_end > iotlb->translated_addr;
+
+        if (masked_start == iotlb->translated_addr ||
+            masked_end == iotlb->translated_addr || spans_region) {
+            hwaddr masked_iova_start;
+            hwaddr masked_iova_end;
+
+            /*
+             * Invalidated & remove the mapping if the address range hit in the
+             * cache but the target_as is different.
+             */
+            if (iotlb->target_as != target_as) {
+                rp_ats_invalidate(s, iotlb);
+                g_array_remove_index_fast(s->cache, i);
+                continue;
+            }
+
+            /*
+             * Remove duplicates with a smaller range length since the new
+             * mapping will span over it.
+             */
+            masked_iova_start = (iova & ~iotlb->addr_mask);
+            masked_iova_end = ((iova | mask) & ~iotlb->addr_mask);
+            spans_region = masked_iova_start < iotlb->iova &&
+                            masked_iova_end > iotlb->iova;
+
+            if (masked_iova_start == iotlb->iova ||
+                masked_iova_end == iotlb->iova || spans_region) {
+
+                if ((iotlb->addr_mask + 1) < (mask + 1)) {
+                    g_array_remove_index_fast(s->cache, i);
+                } else {
+                    /*
+                     * The new mapping is smaller or equal in size and is thus
+                     * already cached.
+                     */
+                    return;
+                }
+            }
+        }
+    }
+
+    iotlb = g_new0(IOMMUTLBEntry, 1);
+    iotlb->iova = iova;
+    iotlb->translated_addr = translated_addr;
+    iotlb->addr_mask = mask;
+    iotlb->target_as = target_as;
+    g_array_append_val(s->cache, iotlb);
+}
+
+static void rp_ats_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+{
+    ATSIOMMUNotifier *notifier = container_of(n, ATSIOMMUNotifier, n);
+    RemotePortATS *s = notifier->rp_ats;
+
+    rp_ats_invalidate(s, iotlb);
+    rp_ats_cache_remove(s, iotlb);
+}
+
+static bool ats_translate_address(RemotePortATS *s, struct rp_pkt *pkt,
+                                  hwaddr *phys_addr, hwaddr *phys_len)
+{
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    IOMMUMemoryRegion *iommu_mr;
+    AddressSpace *target_as;
+    MemoryRegion *mr;
+    int prot = 0;
+
+    RCU_READ_LOCK_GUARD();
+
+    mr = ats_do_translate(&s->as, pkt->ats.addr, phys_addr, phys_len,
+                          &target_as, &prot, attrs);
+    if (!mr) {
+        return false;
+    }
+
+    iommu_mr = memory_region_get_iommu(mr);
+    if (iommu_mr) {
+        int iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr, attrs);
+        ATSIOMMUNotifier *notifier;
+        int i;
+
+        for (i = 0; i < s->iommu_notifiers->len; i++) {
+            notifier = g_array_index(s->iommu_notifiers, ATSIOMMUNotifier *, i);
+            if (notifier->mr == mr && notifier->iommu_idx == iommu_idx) {
+                break;
+            }
+        }
+
+        /* Register a notifier if not found.  */
+        if (i == s->iommu_notifiers->len) {
+            Error *err = NULL;
+            bool ret;
+
+            s->iommu_notifiers = g_array_set_size(s->iommu_notifiers, i + 1);
+            notifier = g_new0(ATSIOMMUNotifier, 1);
+            g_array_index(s->iommu_notifiers, ATSIOMMUNotifier *, i) = notifier;
+
+            notifier->mr = mr;
+            notifier->iommu_idx = iommu_idx;
+            notifier->rp_ats = s;
+
+            iommu_notifier_init(&notifier->n,
+                                rp_ats_iommu_unmap_notify,
+                                IOMMU_NOTIFIER_UNMAP,
+                                0,
+                                HWADDR_MAX,
+                                iommu_idx);
+
+            ret = memory_region_register_iommu_notifier(mr, &notifier->n, &err);
+            if (ret) {
+                error_report_err(err);
+                exit(1);
+            }
+        }
+    }
+
+    if (!(prot & IOMMU_RO)) {
+        pkt->ats.attributes &= ~(RP_ATS_ATTR_exec | RP_ATS_ATTR_read);
+    }
+    if (!(prot & IOMMU_WO)) {
+        pkt->ats.attributes &= ~(RP_ATS_ATTR_write);
+    }
+
+    rp_ats_cache_insert(s, pkt->ats.addr, *phys_addr, *phys_len - 1, target_as);
+
+    return true;
+}
+
+static void rp_ats_req(RemotePortDevice *dev, struct rp_pkt *pkt)
+{
+    RemotePortATS *s = REMOTE_PORT_ATS(dev);
+    size_t pktlen = sizeof(struct rp_pkt_ats);
+    hwaddr phys_addr = 0;
+    hwaddr phys_len = (hwaddr)(-1);
+    uint64_t result;
+    size_t enclen;
+    int64_t delay;
+    int64_t clk;
+
+    assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    rp_dpkt_alloc(&s->rsp, pktlen);
+
+    result = ats_translate_address(s, pkt, &phys_addr, &phys_len) ?
+        RP_ATS_RESULT_ok : RP_ATS_RESULT_error;
+
+    /*
+     * delay here could be set to the annotated cost of doing issuing
+     * these accesses. QEMU doesn't support this kind of annotations
+     * at the moment. So we just clear the delay.
+     */
+    delay = 0;
+    clk = pkt->ats.timestamp + delay;
+
+    enclen = rp_encode_ats_req(pkt->hdr.id, pkt->hdr.dev,
+                             &s->rsp.pkt->ats,
+                             clk,
+                             pkt->ats.attributes,
+                             phys_addr,
+                             phys_len,
+                             result,
+                             pkt->hdr.flags | RP_PKT_FLAGS_response);
+    assert(enclen == pktlen);
+
+    rp_write(s->rp, (void *)s->rsp.pkt, enclen);
+}
+
+static void rp_ats_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortATS *s = REMOTE_PORT_ATS(dev);
+
+    s->peer = rp_get_peer(s->rp);
+    address_space_init(&s->as, s->mr ? s->mr : get_system_memory(), "ats-as");
+
+    s->iommu_notifiers = g_array_new(false, true, sizeof(ATSIOMMUNotifier *));
+    s->cache = g_array_new(false, true, sizeof(IOMMUTLBEntry *));
+}
+
+static void rp_ats_init(Object *obj)
+{
+    RemotePortATS *s = REMOTE_PORT_ATS(obj);
+
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&s->rp,
+                             qdev_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "mr", TYPE_MEMORY_REGION,
+                             (Object **)&s->mr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static void rp_ats_unrealize(DeviceState *dev)
+{
+    RemotePortATS *s = REMOTE_PORT_ATS(dev);
+    ATSIOMMUNotifier *notifier;
+    int i;
+
+    for (i = 0; i < s->iommu_notifiers->len; i++) {
+        notifier = g_array_index(s->iommu_notifiers, ATSIOMMUNotifier *, i);
+        memory_region_unregister_iommu_notifier(notifier->mr, &notifier->n);
+        g_free(notifier);
+    }
+    g_array_free(s->iommu_notifiers, true);
+
+    address_space_destroy(&s->as);
+
+    for (i = 0; i < s->cache->len; i++) {
+        IOMMUTLBEntry *tmp = g_array_index(s->cache, IOMMUTLBEntry *, i);
+        g_free(tmp);
+    }
+    g_array_free(s->cache, true);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortATS, rp_dev, 0),
+};
+
+static void rp_ats_class_init(ObjectClass *oc, const void *data)
+{
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+    RemotePortATSCacheClass *atscc = REMOTE_PORT_ATS_CACHE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+
+    rpdc->ops[RP_CMD_ats_req] = rp_ats_req;
+    dc->realize = rp_ats_realize;
+    dc->unrealize = rp_ats_unrealize;
+    atscc->lookup_translation = rp_ats_lookup_translation;
+}
+
+static const TypeInfo rp_ats_info = {
+    .name          = TYPE_REMOTE_PORT_ATS,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePortATS),
+    .instance_init = rp_ats_init,
+    .class_init    = rp_ats_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_REMOTE_PORT_DEVICE },
+        { TYPE_REMOTE_PORT_ATS_CACHE },
+        { },
+    },
+};
+
+static const TypeInfo rp_ats_cache_info = {
+    .name          = TYPE_REMOTE_PORT_ATS_CACHE,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(RemotePortATSCacheClass),
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_ats_cache_info);
+    type_register_static(&rp_ats_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/remote-port-gpio.c b/hw/core/remote-port-gpio.c
new file mode 100644
index 0000000000..2de6570d01
--- /dev/null
+++ b/hw/core/remote-port-gpio.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "hw/qdev-core.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+
+#include "hw/fdt_generic_util.h"
+
+#include "hw/remote-port.h"
+#include "hw/remote-port-proto.h"
+#include "hw/remote-port-device.h"
+#include "hw/remote-port-gpio.h"
+
+#define CACHE_INVALID -1
+
+static void rp_gpio_handler(void *opaque, int irq, int level)
+{
+    RemotePortGPIO *s = opaque;
+    struct rp_pkt pkt;
+    size_t len;
+    int64_t clk;
+    uint32_t id = rp_new_id(s->rp);
+    uint32_t flags = s->posted_updates ? RP_PKT_FLAGS_posted : 0;
+
+    /* If we hit the cache, return early.  */
+    if (s->cache[irq] != CACHE_INVALID && s->cache[irq] == level) {
+        return;
+    }
+    /* Update the cache and update the remote peer.  */
+    s->cache[irq] = level;
+
+    clk = rp_normalized_vmclk(s->rp);
+    len = rp_encode_interrupt_f(id, s->rp_dev, &pkt.interrupt, clk,
+                              irq, 0, level, flags);
+
+    trace_remote_port_gpio_tx_interrupt(id, flags, s->rp_dev, 0, irq, level);
+
+    if (s->peer->caps.wire_posted_updates && !s->posted_updates) {
+        rp_rsp_mutex_lock(s->rp);
+    }
+
+    rp_write(s->rp, (void *)&pkt, len);
+
+    /* If peer supports posted updates it will respect our flag and
+     * not respond.  */
+    if (s->peer->caps.wire_posted_updates && !s->posted_updates) {
+        RemotePortRespSlot *rsp_slot;
+        struct rp_pkt_interrupt *intr;
+
+        rsp_slot = rp_dev_wait_resp(s->rp, s->rp_dev, id);
+        assert(rsp_slot->rsp.pkt->hdr.id == id);
+
+        intr = &rsp_slot->rsp.pkt->interrupt;
+        trace_remote_port_gpio_rx_interrupt(intr->hdr.id, intr->hdr.flags,
+            intr->hdr.dev, intr->vector, intr->line, intr->val);
+
+        rp_resp_slot_done(s->rp, rsp_slot);
+        rp_rsp_mutex_unlock(s->rp);
+    }
+}
+
+static void rp_gpio_interrupt(RemotePortDevice *rpdev, struct rp_pkt *pkt)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(rpdev);
+
+    trace_remote_port_gpio_rx_interrupt(pkt->hdr.id, pkt->hdr.flags,
+        pkt->hdr.dev, pkt->interrupt.vector, pkt->interrupt.line,
+        pkt->interrupt.val);
+
+    qemu_set_irq(s->gpio_out[pkt->interrupt.line], pkt->interrupt.val);
+
+    if (s->peer->caps.wire_posted_updates
+        && !(pkt->hdr.flags & RP_PKT_FLAGS_posted)) {
+        RemotePortDynPkt rsp = {0};
+        size_t len;
+
+        /* Need to reply.  */
+        rp_dpkt_alloc(&rsp, sizeof(struct rp_pkt_interrupt));
+        len = rp_encode_interrupt_f(pkt->hdr.id, pkt->hdr.dev,
+                                    &rsp.pkt->interrupt,
+                                    pkt->interrupt.timestamp,
+                                    pkt->interrupt.line,
+                                    pkt->interrupt.vector,
+                                    pkt->interrupt.val,
+                                    pkt->hdr.flags | RP_PKT_FLAGS_response);
+
+        trace_remote_port_gpio_tx_interrupt(pkt->hdr.id,
+            pkt->hdr.flags | RP_PKT_FLAGS_response, pkt->hdr.dev,
+            pkt->interrupt.vector, pkt->interrupt.line, pkt->interrupt.val);
+
+        rp_write(s->rp, (void *)rsp.pkt, len);
+    }
+}
+
+static void rp_gpio_reset(DeviceState *dev)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(dev);
+
+    /* Mark as invalid.  */
+    memset(s->cache, CACHE_INVALID, s->num_gpios);
+}
+
+static void rp_gpio_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(dev);
+    unsigned int i;
+
+    s->peer = rp_get_peer(s->rp);
+
+    s->gpio_out = g_new0(qemu_irq, s->num_gpios);
+    qdev_init_gpio_out(dev, s->gpio_out, s->num_gpios);
+    qdev_init_gpio_in(dev, rp_gpio_handler, s->num_gpios);
+
+    for (i = 0; i < s->num_gpios; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(s), &s->gpio_out[i]);
+    }
+}
+
+static void rp_gpio_init(Object *obj)
+{
+    RemotePortGPIO *rpms = REMOTE_PORT_GPIO(obj);
+
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&rpms->rp,
+                             qdev_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortGPIO, rp_dev, 0),
+    DEFINE_PROP_UINT32("num-gpios", RemotePortGPIO, num_gpios, 16),
+    DEFINE_PROP_UINT16("cell-offset-irq-num", RemotePortGPIO,
+                       cell_offset_irq_num, 0),
+    DEFINE_PROP_BOOL("posted-updates", RemotePortGPIO, posted_updates, true),
+};
+
+static int rp_fdt_get_irq(FDTGenericIntc *obj, qemu_irq *irqs,
+                          uint32_t *cells, int ncells, int max,
+                          Error **errp)
+{
+    RemotePortGPIO *s = REMOTE_PORT_GPIO(obj);
+
+    if (cells[s->cell_offset_irq_num] >= s->num_gpios) {
+        error_setg(errp, "RP-GPIO was setup for %u interrupts: index %"
+                   PRIu32 " requested", s->num_gpios,
+                   cells[s->cell_offset_irq_num]);
+        return 0;
+    }
+
+    (*irqs) = qdev_get_gpio_in(DEVICE(obj), cells[s->cell_offset_irq_num]);
+    return 1;
+};
+
+static void rp_gpio_class_init(ObjectClass *oc, const void *data)
+{
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(oc);
+
+    rpdc->ops[RP_CMD_interrupt] = rp_gpio_interrupt;
+    dc->legacy_reset = rp_gpio_reset;
+    dc->realize = rp_gpio_realize;
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    fgic->get_irq = rp_fdt_get_irq;
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RemotePortGPIO),
+    .instance_init = rp_gpio_init,
+    .class_init    = rp_gpio_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_REMOTE_PORT_DEVICE },
+        { TYPE_FDT_GENERIC_INTC },
+        { },
+    },
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
new file mode 100644
index 0000000000..a71ab286f9
--- /dev/null
+++ b/hw/core/remote-port-memory-master.c
@@ -0,0 +1,402 @@
+/*
+ * QEMU remote port memory master.
+ *
+ * Copyright (c) 2014 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+
+#include "hw/remote-port-proto.h"
+#include "hw/remote-port.h"
+#include "hw/remote-port-device.h"
+#include "hw/remote-port-memory-master.h"
+
+#include "hw/fdt_generic_util.h"
+
+#ifndef REMOTE_PORT_ERR_DEBUG
+#define REMOTE_PORT_DEBUG_LEVEL 0
+#else
+#define REMOTE_PORT_DEBUG_LEVEL 1
+#endif
+
+#define DB_PRINT_L(level, ...) do { \
+    if (REMOTE_PORT_DEBUG_LEVEL > level) { \
+        fprintf(stderr,  ": %s: ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define REMOTE_PORT_MEMORY_MASTER_PARENT_CLASS \
+    object_class_get_parent( \
+            object_class_by_name(TYPE_REMOTE_PORT_MEMORY_MASTER))
+
+#define RP_MAX_ACCESS_SIZE 4096
+
+static void rp_mm_serbs_timer_config(xlnx_serbs_if *serbs, int id, int timems,
+                                     bool enable)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(serbs);
+
+    s->serbs_id = id;
+    s->rp_timeout = enable ? timems : 0;
+}
+
+static void rp_mm_serbs_timout_set(xlnx_serbs_if *serbs, int id, bool level)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(serbs);
+
+    s->rp_timeout_err = level;
+}
+
+static int rp_mm_get_timeout(MemoryTransaction *tr)
+{
+    RemotePortMap *map = tr->opaque;
+    RemotePortMemoryMaster *s;
+
+    if (!map || !map->parent ||
+        !object_dynamic_cast(OBJECT(map->parent),
+                             TYPE_REMOTE_PORT_MEMORY_MASTER)) {
+        return 0;
+    }
+    s = REMOTE_PORT_MEMORY_MASTER(map->parent);
+    return s->rp_timeout;
+}
+
+static bool rp_mm_timeout_err_state_get(MemoryTransaction *tr)
+{
+    RemotePortMap *map = tr->opaque;
+    RemotePortMemoryMaster *s;
+
+    if (!map || !map->parent ||
+        !object_dynamic_cast(OBJECT(map->parent),
+                             TYPE_REMOTE_PORT_MEMORY_MASTER)) {
+        return false;
+    }
+
+    s = REMOTE_PORT_MEMORY_MASTER(map->parent);
+    return s->rp_timeout_err;
+}
+
+static void rp_mm_timeout_err_state_set(MemoryTransaction *tr, bool level)
+{
+    RemotePortMap *map = tr->opaque;
+    RemotePortMemoryMaster *s;
+
+    if (!map || !map->parent ||
+        !object_dynamic_cast(OBJECT(map->parent),
+                             TYPE_REMOTE_PORT_MEMORY_MASTER)) {
+        return;
+    }
+
+    s = REMOTE_PORT_MEMORY_MASTER(map->parent);
+    if (s->serbsIf) {
+        s->rp_timeout_err = level;
+        xlnx_serbs_if_timeout_set(s->serbsIf, s->serbs_id, s->rp_timeout_err);
+     }
+
+}
+
+MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
+                                       struct rp_peer_state *peer,
+                                       MemoryTransaction *tr,
+                                       bool relative, uint64_t offset,
+                                       uint32_t def_attr)
+{
+    uint64_t addr = tr->addr;
+    RemotePortRespSlot *rsp_slot;
+    RemotePortDynPkt *rsp;
+    struct  {
+        struct rp_pkt_busaccess_ext_base pkt;
+        uint8_t reserved[RP_MAX_ACCESS_SIZE];
+    } pay;
+    uint8_t *data = rp_busaccess_tx_dataptr(peer, &pay.pkt);
+    struct rp_encode_busaccess_in in = {0};
+    int i;
+    int len;
+    int rp_timeout = rp_mm_get_timeout(tr);
+    MemTxResult ret;
+
+    if (rp_timeout && rp_mm_timeout_err_state_get(tr)) {
+        return MEMTX_ERROR;
+    }
+    DB_PRINT_L(0, "addr: %" HWADDR_PRIx " data: %" PRIx64 "\n",
+               addr, tr->data.u64);
+
+    if (tr->rw) {
+        /* Data up to 8 bytes is passed as values.  */
+        if (tr->size <= 8) {
+            for (i = 0; i < tr->size; i++) {
+                data[i] = tr->data.u64 >> (i * 8);
+            }
+        } else {
+            memcpy(data, tr->data.p8, tr->size);
+        }
+    }
+
+    addr += relative ? 0 : offset;
+
+    in.cmd = tr->rw ? RP_CMD_write : RP_CMD_read;
+    in.id = rp_new_id(rp);
+    in.dev = rp_dev;
+    in.clk = rp_normalized_vmclk(rp);
+    in.master_id = tr->attr.requester_id;
+    in.addr = addr;
+    in.attr = def_attr;
+    in.attr |= tr->attr.secure ? RP_BUS_ATTR_SECURE : 0;
+    in.size = tr->size;
+    in.stream_width = tr->size;
+    len = rp_encode_busaccess(peer, &pay.pkt, &in);
+    len += tr->rw ? tr->size : 0;
+
+    trace_remote_port_memory_master_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_rsp_mutex_lock(rp);
+    rp_write(rp, (void *) &pay, len);
+
+    if (!rp_timeout) {
+        rsp_slot = rp_dev_wait_resp(rp, in.dev, in.id);
+    } else {
+        rsp_slot = rp_dev_timed_wait_resp(rp, in.dev, in.id, rp_timeout);
+        if (rsp_slot->valid == false) {
+            /*
+             * Timeout error
+             */
+            rp_rsp_mutex_unlock(rp);
+            rp_mm_timeout_err_state_set(tr, true);
+            return MEMTX_ERROR;
+        }
+    }
+    rsp = &rsp_slot->rsp;
+
+    /* We dont support out of order answers yet.  */
+    assert(rsp->pkt->hdr.id == in.id);
+
+    switch (rp_get_busaccess_response(rsp->pkt)) {
+    case RP_RESP_OK:
+        ret = MEMTX_OK;
+        break;
+    case RP_RESP_ADDR_ERROR:
+        ret = MEMTX_DECODE_ERROR;
+        break;
+    default:
+        ret = MEMTX_ERROR;
+        break;
+    }
+
+    if (ret == MEMTX_OK && !tr->rw) {
+        data = rp_busaccess_rx_dataptr(peer, &rsp->pkt->busaccess_ext_base);
+        /* Data up to 8 bytes is return as values.  */
+        if (tr->size <= 8) {
+            for (i = 0; i < tr->size; i++) {
+                tr->data.u64 |= ((uint64_t) data[i]) << (i * 8);
+            }
+        } else {
+            memcpy(tr->data.p8, data, tr->size);
+        }
+    }
+
+    trace_remote_port_memory_master_rx_busaccess(
+        rp_cmd_to_string(rsp->pkt->hdr.cmd), rsp->pkt->hdr.id,
+        rsp->pkt->hdr.flags, rsp->pkt->hdr.dev, rsp->pkt->busaccess.addr,
+        rsp->pkt->busaccess.len, rsp->pkt->busaccess.attributes);
+
+    if (rp_timeout) {
+        for (i = 0; i < ARRAY_SIZE(rp->dev_state[rp_dev].rsp_queue); i++) {
+            if (rp->dev_state[rp_dev].rsp_queue[i].used &&
+                rp->dev_state[rp_dev].rsp_queue[i].valid) {
+                rp_resp_slot_done(rp, &rp->dev_state[rp_dev].rsp_queue[i]);
+            }
+        }
+    } else {
+        rp_resp_slot_done(rp, rsp_slot);
+    }
+    rp_rsp_mutex_unlock(rp);
+
+    /*
+     * For strongly ordered or transactions that don't allow Early Acking,
+     * we need to drain the pending RP processing queue here. This is
+     * because RP handles responses in parallel with normal requests so
+     * they may get reordered. This becomes visible for example with reads
+     * to read-to-clear registers that clear interrupts. Even though the
+     * lowering of the interrupt-wires arrives to us before the read-resp,
+     * we may handle the response before the wire update, resulting in
+     * spurious interrupts.
+     *
+     * This has some room for optimization but for now we use the big hammer
+     * and drain the entire qeueue.
+     */
+    rp_process(rp);
+
+    /* Reads are sync-points, roll the sync timer.  */
+    rp_restart_sync_timer(rp);
+    DB_PRINT_L(1, "\n");
+    return ret;
+}
+
+MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
+                         struct rp_peer_state *peer,
+                         MemoryTransaction *tr,
+                         bool relative, uint64_t offset)
+{
+    return rp_mm_access_with_def_attr(rp, rp_dev, peer, tr, relative, offset,
+                                      0);
+}
+
+static MemTxResult rp_access(MemoryTransaction *tr)
+{
+    RemotePortMap *map = tr->opaque;
+    RemotePortMemoryMaster *s = map->parent;
+
+    return rp_mm_access(s->rp, s->rp_dev, s->peer, tr, s->relative,
+                        map->offset);
+}
+
+static const MemoryRegionOps rp_ops_template = {
+    .access = rp_access,
+    .valid.max_access_size = RP_MAX_ACCESS_SIZE,
+    .valid.unaligned = true,
+    .impl.max_access_size = RP_MAX_ACCESS_SIZE,
+    .impl.unaligned = false,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void rp_memory_master_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(dev);
+    int i;
+
+    /* Sanity check max access size.  */
+    if (s->max_access_size > RP_MAX_ACCESS_SIZE) {
+        error_setg(errp, "%s: max-access-size %d too large! MAX is %d",
+                   TYPE_REMOTE_PORT_MEMORY_MASTER, s->max_access_size,
+                   RP_MAX_ACCESS_SIZE);
+        return;
+    }
+
+    if (s->max_access_size < 4) {
+        error_setg(errp, "%s: max-access-size %d too small! MIN is 4",
+                   TYPE_REMOTE_PORT_MEMORY_MASTER, s->max_access_size);
+        return;
+    }
+
+    assert(s->rp);
+    s->peer = rp_get_peer(s->rp);
+
+    /* Create a single static region if configuration says so.  */
+    if (s->map_num) {
+        /* Initialize rp_ops from template.  */
+        s->rp_ops = g_malloc(sizeof *s->rp_ops);
+        memcpy(s->rp_ops, &rp_ops_template, sizeof *s->rp_ops);
+        s->rp_ops->valid.max_access_size = s->max_access_size;
+        s->rp_ops->impl.max_access_size = s->max_access_size;
+
+        s->mmaps = g_new0(typeof(*s->mmaps), s->map_num);
+        for (i = 0; i < s->map_num; ++i) {
+            char *name = g_strdup_printf("rp-%d", i);
+
+            s->mmaps[i].offset = s->map_offset;
+            memory_region_init_io(&s->mmaps[i].iomem, OBJECT(dev), s->rp_ops,
+                                  &s->mmaps[i], name, s->map_size);
+            sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmaps[i].iomem);
+            s->mmaps[i].parent = s;
+            g_free(name);
+        }
+    }
+}
+
+static void rp_memory_master_init(Object *obj)
+{
+    RemotePortMemoryMaster *rpms = REMOTE_PORT_MEMORY_MASTER(obj);
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&rpms->rp,
+                             qdev_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "serbs-if", TYPE_XLNX_SERBS_IF,
+                             (Object **)&rpms->serbsIf,
+                             qdev_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static bool rp_parse_reg(FDTGenericMMap *obj, FDTGenericRegPropInfo reg,
+                         Error **errp)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(obj);
+    FDTGenericMMapClass *parent_fmc =
+        FDT_GENERIC_MMAP_CLASS(REMOTE_PORT_MEMORY_MASTER_PARENT_CLASS);
+    int i;
+
+    /* Initialize rp_ops from template.  */
+    s->rp_ops = g_malloc(sizeof *s->rp_ops);
+    memcpy(s->rp_ops, &rp_ops_template, sizeof *s->rp_ops);
+    s->rp_ops->valid.max_access_size = s->max_access_size;
+    s->rp_ops->impl.max_access_size = s->max_access_size;
+
+    s->mmaps = g_new0(typeof(*s->mmaps), reg.n);
+    for (i = 0; i < reg.n; ++i) {
+        char *name = g_strdup_printf("rp-%d", i);
+
+        s->mmaps[i].offset = reg.a[i];
+        memory_region_init_io(&s->mmaps[i].iomem, OBJECT(obj), s->rp_ops,
+                              &s->mmaps[i], name, reg.s[i]);
+        sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmaps[i].iomem);
+        s->mmaps[i].parent = s;
+        g_free(name);
+    }
+
+    return parent_fmc ? parent_fmc->parse_reg(obj, reg, errp) : false;
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("map-num", RemotePortMemoryMaster, map_num, 0),
+    DEFINE_PROP_UINT64("map-offset", RemotePortMemoryMaster, map_offset, 0),
+    DEFINE_PROP_UINT64("map-size", RemotePortMemoryMaster, map_size, 0),
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortMemoryMaster, rp_dev, 0),
+    DEFINE_PROP_BOOL("relative", RemotePortMemoryMaster, relative, false),
+    DEFINE_PROP_UINT32("max-access-size", RemotePortMemoryMaster,
+                       max_access_size, RP_MAX_ACCESS_SIZE),
+};
+
+static void rp_memory_master_class_init(ObjectClass *oc, const void *data)
+{
+    FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    xlnx_serbs_if_class *sc = XLNX_SERBS_IF_CLASS(oc);
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    dc->realize = rp_memory_master_realize;
+    fmc->parse_reg = rp_parse_reg;
+    sc->timer_config = rp_mm_serbs_timer_config;
+    sc->timeout_set = rp_mm_serbs_timout_set;
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT_MEMORY_MASTER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RemotePortMemoryMaster),
+    .instance_init = rp_memory_master_init,
+    .class_init    = rp_memory_master_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_FDT_GENERIC_MMAP },
+        { TYPE_REMOTE_PORT_DEVICE },
+        { TYPE_XLNX_SERBS_IF },
+        { },
+    },
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/remote-port-memory-slave.c b/hw/core/remote-port-memory-slave.c
new file mode 100644
index 0000000000..47c844b8cc
--- /dev/null
+++ b/hw/core/remote-port-memory-slave.c
@@ -0,0 +1,257 @@
+/*
+ * QEMU remote port memory slave. Read and write transactions
+ * recieved from the remote port are translated into an address space.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+#include "qemu/cutils.h"
+
+#include "hw/remote-port-proto.h"
+#include "hw/remote-port-device.h"
+#include "hw/remote-port-memory-slave.h"
+
+#ifndef REMOTE_PORT_ERR_DEBUG
+#define REMOTE_PORT_DEBUG_LEVEL 0
+#else
+#define REMOTE_PORT_DEBUG_LEVEL 1
+#endif
+
+#define DB_PRINT_L(level, ...) do { \
+    if (REMOTE_PORT_DEBUG_LEVEL > level) { \
+        fprintf(stderr,  ": %s: ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0);
+
+/* Slow path dealing with odd stuff like byte-enables.  */
+static MemTxResult process_data_slow(RemotePortMemorySlave *s,
+                                     AddressSpace *as,
+                                     struct rp_pkt *pkt,
+                                     DMADirection dir,
+                                     uint8_t *data, uint8_t *byte_en)
+{
+    unsigned int i;
+    unsigned int byte_en_len = pkt->busaccess_ext_base.byte_enable_len;
+    unsigned int sw = pkt->busaccess.stream_width;
+    MemTxResult ret = MEMTX_OK;
+
+    assert(sw);
+
+    for (i = 0; i < pkt->busaccess.len; i++) {
+        if (byte_en && !byte_en[i % byte_en_len]) {
+            continue;
+        }
+
+        ret = dma_memory_rw_attr(as, pkt->busaccess.addr + i % sw,
+                                 data + i, 1, dir, s->attr);
+
+        if (ret != MEMTX_OK) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
+static AddressSpace *get_as_for_phys_busaccess(RemotePortMemorySlave *s,
+                                               struct rp_pkt *pkt)
+{
+    if (s->ats_cache) {
+        IOMMUTLBEntry *iotlb =
+            rp_ats_cache_lookup_translation(s->ats_cache,
+                                            pkt->busaccess.addr,
+                                            pkt->busaccess.len);
+        if (iotlb) {
+            /* Return the matching address space found. */
+            return iotlb->target_as;
+        }
+    }
+    /* Emit a warning on errors since this really should not happen. */
+    warn_report("Physical address error detected (range address: 0x%"
+                HWADDR_PRIx ", len: 0x%" PRIx32 " contains untranslated "
+                "addresses)", pkt->busaccess.addr, pkt->busaccess.len);
+    return NULL;
+}
+
+static void rp_cmd_rw(RemotePortMemorySlave *s, struct rp_pkt *pkt,
+                      DMADirection dir)
+{
+    size_t pktlen = sizeof(struct rp_pkt_busaccess_ext_base);
+    struct rp_encode_busaccess_in in = {0};
+    size_t enclen;
+    int64_t delay;
+    uint8_t *data = NULL;
+    uint8_t *byte_en;
+    MemTxResult ret;
+    AddressSpace *as;
+
+    byte_en = rp_busaccess_byte_en_ptr(s->peer, &pkt->busaccess_ext_base);
+
+    if (dir == DMA_DIRECTION_TO_DEVICE) {
+        pktlen += pkt->busaccess.len;
+    } else {
+        data = rp_busaccess_rx_dataptr(s->peer, &pkt->busaccess_ext_base);
+    }
+
+    assert(pkt->busaccess.width == 0);
+    assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    rp_dpkt_alloc(&s->rsp, pktlen);
+    if (dir == DMA_DIRECTION_TO_DEVICE) {
+        data = rp_busaccess_tx_dataptr(s->peer,
+                                       &s->rsp.pkt->busaccess_ext_base);
+    }
+    if (dir == DMA_DIRECTION_FROM_DEVICE && REMOTE_PORT_DEBUG_LEVEL > 0) {
+        DB_PRINT_L(0, "address: %" PRIx64 "\n", pkt->busaccess.addr);
+        qemu_hexdump(stderr, ": write: ",
+                     (const char *) data, pkt->busaccess.len);
+    }
+    trace_remote_port_memory_slave_rx_busaccess(rp_cmd_to_string(pkt->hdr.cmd),
+        pkt->hdr.id, pkt->hdr.flags, pkt->hdr.dev, pkt->busaccess.addr,
+        pkt->busaccess.len, pkt->busaccess.attributes);
+
+    s->attr.secure = !!(pkt->busaccess.attributes & RP_BUS_ATTR_SECURE);
+    s->attr.requester_id = pkt->busaccess.master_id;
+
+    if (pkt->busaccess.attributes & RP_BUS_ATTR_PHYS_ADDR) {
+        as = get_as_for_phys_busaccess(s, pkt);
+    } else {
+        as = &s->as;
+    }
+    if (as) {
+        if (byte_en || pkt->busaccess.stream_width != pkt->busaccess.len) {
+            ret = process_data_slow(s, as, pkt, dir, data, byte_en);
+        } else {
+            ret = dma_memory_rw_attr(as, pkt->busaccess.addr, data,
+                                 pkt->busaccess.len, dir, s->attr);
+        }
+    } else {
+        ret = MEMTX_ERROR;
+    }
+
+    if (dir == DMA_DIRECTION_TO_DEVICE && REMOTE_PORT_DEBUG_LEVEL > 0) {
+        DB_PRINT_L(0, "address: %" PRIx64 "\n", pkt->busaccess.addr);
+        qemu_hexdump(stderr, ": read: ",
+                     (const char *) data, pkt->busaccess.len);
+    }
+    /* delay here could be set to the annotated cost of doing issuing
+       these accesses. QEMU doesn't support this kind of annotations
+       at the moment. So we just clear the delay.  */
+    delay = 0;
+
+    rp_encode_busaccess_in_rsp_init(&in, pkt);
+    in.clk = pkt->busaccess.timestamp + delay;
+
+    switch (ret) {
+    case MEMTX_ERROR:
+        in.attr |= RP_RESP_BUS_GENERIC_ERROR << RP_BUS_RESP_SHIFT;
+        break;
+    case MEMTX_DECODE_ERROR:
+        in.attr |= RP_RESP_ADDR_ERROR << RP_BUS_RESP_SHIFT;
+        break;
+    default:
+        /* MEMTX_OK maps to RP_RESP_OK. */
+        break;
+    }
+
+    enclen = rp_encode_busaccess(s->peer, &s->rsp.pkt->busaccess_ext_base,
+                                 &in);
+    assert(enclen <= pktlen);
+
+    trace_remote_port_memory_slave_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_write(s->rp, (void *)s->rsp.pkt, enclen);
+}
+
+static void rp_memory_slave_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortMemorySlave *s = REMOTE_PORT_MEMORY_SLAVE(dev);
+
+    s->peer = rp_get_peer(s->rp);
+    address_space_init(&s->as, s->mr ? s->mr : get_system_memory(), "dma");
+}
+
+static void rp_memory_slave_write(RemotePortDevice *s, struct rp_pkt *pkt)
+{
+    return rp_cmd_rw(REMOTE_PORT_MEMORY_SLAVE(s), pkt,
+                     DMA_DIRECTION_FROM_DEVICE);
+}
+
+static void rp_memory_slave_read(RemotePortDevice *s, struct rp_pkt *pkt)
+{
+    return rp_cmd_rw(REMOTE_PORT_MEMORY_SLAVE(s), pkt,
+                     DMA_DIRECTION_TO_DEVICE);
+}
+
+static void rp_memory_slave_init(Object *obj)
+{
+    RemotePortMemorySlave *rpms = REMOTE_PORT_MEMORY_SLAVE(obj);
+
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&rpms->rp,
+                             qdev_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "mr", TYPE_MEMORY_REGION,
+                             (Object **)&rpms->mr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "rp-ats-cache", TYPE_REMOTE_PORT_ATS_CACHE,
+                             (Object **)&rpms->ats_cache,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static void rp_memory_slave_unrealize(DeviceState *dev)
+{
+    RemotePortMemorySlave *s = REMOTE_PORT_MEMORY_SLAVE(dev);
+
+    address_space_destroy(&s->as);
+}
+
+static void rp_memory_slave_class_init(ObjectClass *oc, const void *data)
+{
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    rpdc->ops[RP_CMD_write] = rp_memory_slave_write;
+    rpdc->ops[RP_CMD_read] = rp_memory_slave_read;
+    dc->realize = rp_memory_slave_realize;
+    dc->unrealize = rp_memory_slave_unrealize;
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT_MEMORY_SLAVE,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePortMemorySlave),
+    .instance_init = rp_memory_slave_init,
+    .class_init    = rp_memory_slave_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_REMOTE_PORT_DEVICE },
+        { },
+    },
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
new file mode 100644
index 0000000000..9f09dc8d16
--- /dev/null
+++ b/hw/core/remote-port-proto.c
@@ -0,0 +1,523 @@
+/*
+ * Remote-port protocol
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef _DEFAULT_SOURCE
+# define _DEFAULT_SOURCE
+#endif
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <assert.h>
+#include "hw/remote-port-proto.h"
+
+#undef MIN
+#define MIN(x, y) (x < y ? x : y)
+
+#if defined(__linux__)
+#  include <endian.h>
+#elif defined(__FreeBSD__) || defined(__NetBSD__)
+#  include <sys/endian.h>
+#elif defined(__OpenBSD__)
+#  include <sys/types.h>
+#  define be16toh(x) betoh16(x)
+#  define be32toh(x) betoh32(x)
+#  define be64toh(x) betoh64(x)
+#elif defined(__WIN32)
+/* We assume little endian.  */
+#    define htobe64(x) _byteswap_uint64(x)
+#    define htobe32(x) _byteswap_ulong(x)
+#    define htobe16(x) _byteswap_ushort(x)
+
+#    define be64toh(x) _byteswap_uint64(x)
+#    define be32toh(x) _byteswap_ulong(x)
+#    define be16toh(x) _byteswap_ushort(x)
+#elif defined(__APPLE__)
+#  include <libkern/OSByteOrder.h>
+
+/* We assume little endian. */
+#  define htobe64(x) OSSwapHostToBigInt64(x)
+#  define htobe32(x) OSSwapHostToBigInt32(x)
+#  define htobe16(x) OSSwapHostToBigInt16(x)
+
+#  define be64toh(x) OSSwapBigToHostInt64(x)
+#  define be32toh(x) OSSwapBigToHostInt32(x)
+#  define be16toh(x) OSSwapBigToHostInt16(x)
+#endif
+
+/* Fallback for ancient Linux systems.  */
+#ifndef htobe64
+#  include <byteswap.h>
+
+#  if __BYTE_ORDER == __LITTLE_ENDIAN
+#    define htobe64(x) bswap_64(x)
+#    define htobe32(x) bswap_32(x)
+#    define htobe16(x) bswap_16(x)
+
+#    define be64toh(x) bswap_64(x)
+#    define be32toh(x) bswap_32(x)
+#    define be16toh(x) bswap_16(x)
+#  else
+#    define htobe64(x) x
+#    define htobe32(x) x
+#    define htobe16(x) x
+
+#    define be64toh(x) x
+#    define be32toh(x) x
+#    define be16toh(x) x
+#  endif
+#endif
+
+static const char *rp_cmd_names[RP_CMD_max + 1] = {
+    [RP_CMD_nop] = "nop",
+    [RP_CMD_hello] = "hello",
+    [RP_CMD_cfg] = "cfg",
+    [RP_CMD_read] = "read",
+    [RP_CMD_write] = "write",
+    [RP_CMD_interrupt] = "interrupt",
+    [RP_CMD_sync] = "sync",
+    [RP_CMD_ats_req] = "ats_request",
+    [RP_CMD_ats_inv] = "ats_invalidation",
+};
+
+const char *rp_cmd_to_string(enum rp_cmd cmd)
+{
+    assert(cmd <= RP_CMD_max);
+    return rp_cmd_names[cmd];
+}
+
+int rp_decode_hdr(struct rp_pkt *pkt)
+{
+    int used = 0;
+
+    pkt->hdr.cmd = be32toh(pkt->hdr.cmd);
+    pkt->hdr.len = be32toh(pkt->hdr.len);
+    pkt->hdr.id = be32toh(pkt->hdr.id);
+    pkt->hdr.flags = be32toh(pkt->hdr.flags);
+    pkt->hdr.dev = be32toh(pkt->hdr.dev);
+    used += sizeof pkt->hdr;
+    return used;
+}
+
+int rp_decode_payload(struct rp_pkt *pkt)
+{
+    int used = 0;
+    /* Master_id has an odd decoding due to historical reasons.  */
+    uint64_t master_id;
+
+    switch (pkt->hdr.cmd) {
+    case RP_CMD_hello:
+        assert(pkt->hdr.len >= sizeof pkt->hello.version);
+        pkt->hello.version.major = be16toh(pkt->hello.version.major);
+        pkt->hello.version.minor = be16toh(pkt->hello.version.minor);
+        used += sizeof pkt->hello.version;
+
+        if ((pkt->hdr.len - used) >= sizeof pkt->hello.caps) {
+            void *offset;
+            int i;
+
+            pkt->hello.caps.offset = be32toh(pkt->hello.caps.offset);
+            pkt->hello.caps.len = be16toh(pkt->hello.caps.len);
+
+            offset = (char *)pkt + pkt->hello.caps.offset;
+            for (i = 0; i < pkt->hello.caps.len; i++) {
+                uint32_t cap;
+
+                /* We don't know if offset is 32bit aligned so use
+                 * memcpy to do the endian conversion.  */
+                memcpy(&cap, offset + i * sizeof cap, sizeof cap);
+                cap = be32toh(cap);
+                memcpy(offset + i * sizeof cap, &cap, sizeof cap);
+            }
+            used += sizeof pkt->hello.caps;
+        } else {
+            pkt->hello.caps.offset = 0;
+            pkt->hello.caps.len = 0;
+        }
+
+        /* Consume everything ignoring additional headers we do not yet
+         * know about.  */
+        used = pkt->hdr.len;
+        break;
+    case RP_CMD_write:
+    case RP_CMD_read:
+        assert(pkt->hdr.len >= sizeof pkt->busaccess - sizeof pkt->hdr);
+        pkt->busaccess.timestamp = be64toh(pkt->busaccess.timestamp);
+        pkt->busaccess.addr = be64toh(pkt->busaccess.addr);
+        pkt->busaccess.attributes = be64toh(pkt->busaccess.attributes);
+        pkt->busaccess.len = be32toh(pkt->busaccess.len);
+        pkt->busaccess.width = be32toh(pkt->busaccess.width);
+        pkt->busaccess.stream_width = be32toh(pkt->busaccess.stream_width);
+        master_id = be16toh(pkt->busaccess.master_id);
+
+        used += sizeof pkt->busaccess - sizeof pkt->hdr;
+
+        if (pkt->busaccess.attributes & RP_BUS_ATTR_EXT_BASE) {
+            struct rp_pkt_busaccess_ext_base *pext = &pkt->busaccess_ext_base;
+
+            assert(pkt->hdr.len >= sizeof *pext - sizeof pkt->hdr);
+            master_id |= (uint64_t)be16toh(pext->master_id_31_16) << 16;
+            master_id |= (uint64_t)be32toh(pext->master_id_63_32) << 32;
+            pext->data_offset = be32toh(pext->data_offset);
+            pext->next_offset = be32toh(pext->next_offset);
+            pext->byte_enable_offset = be32toh(pext->byte_enable_offset);
+            pext->byte_enable_len = be32toh(pext->byte_enable_len);
+
+            used += sizeof *pext - sizeof pkt->busaccess;
+        }
+        pkt->busaccess.master_id = master_id;
+        break;
+    case RP_CMD_interrupt:
+        pkt->interrupt.timestamp = be64toh(pkt->interrupt.timestamp);
+        pkt->interrupt.vector = be64toh(pkt->interrupt.vector);
+        pkt->interrupt.line = be32toh(pkt->interrupt.line);
+        pkt->interrupt.val = pkt->interrupt.val;
+        used += pkt->hdr.len;
+        break;
+    case RP_CMD_sync:
+        pkt->sync.timestamp = be64toh(pkt->interrupt.timestamp);
+        used += pkt->hdr.len;
+        break;
+    case RP_CMD_ats_req:
+    case RP_CMD_ats_inv:
+        pkt->ats.attributes = be64toh(pkt->ats.attributes);
+        pkt->ats.addr = be64toh(pkt->ats.addr);
+        pkt->ats.len = be64toh(pkt->ats.len);
+        pkt->ats.result = be32toh(pkt->ats.result);
+        break;
+    default:
+        break;
+    }
+    return used;
+}
+
+void rp_encode_hdr(struct rp_pkt_hdr *hdr, uint32_t cmd, uint32_t id,
+                   uint32_t dev, uint32_t len, uint32_t flags)
+{
+    hdr->cmd = htobe32(cmd);
+    hdr->len = htobe32(len);
+    hdr->id = htobe32(id);
+    hdr->dev = htobe32(dev);
+    hdr->flags = htobe32(flags);
+}
+
+size_t rp_encode_hello_caps(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                            uint16_t version_major, uint16_t version_minor,
+                            uint32_t *caps, uint32_t *caps_out,
+                            uint32_t caps_len)
+{
+    size_t psize = sizeof *pkt + sizeof caps[0] * caps_len;
+    unsigned int i;
+
+    rp_encode_hdr(&pkt->hdr, RP_CMD_hello, id, dev,
+                  psize - sizeof pkt->hdr, 0);
+    pkt->version.major = htobe16(version_major);
+    pkt->version.minor = htobe16(version_minor);
+
+    /* Feature list is appeneded right after the hello packet.  */
+    pkt->caps.offset = htobe32(sizeof *pkt);
+    pkt->caps.len = htobe16(caps_len);
+
+    for (i = 0; i < caps_len; i++) {
+        uint32_t cap;
+
+        cap = caps[i];
+        caps_out[i] = htobe32(cap);
+    }
+    return sizeof *pkt;
+}
+
+static void rp_encode_busaccess_common(struct rp_pkt_busaccess *pkt,
+                                  int64_t clk, uint16_t master_id,
+                                  uint64_t addr, uint64_t attr, uint32_t size,
+                                  uint32_t width, uint32_t stream_width)
+{
+    pkt->timestamp = htobe64(clk);
+    pkt->master_id = htobe16(master_id);
+    pkt->addr = htobe64(addr);
+    pkt->attributes = htobe64(attr);
+    pkt->len = htobe32(size);
+    pkt->width = htobe32(width);
+    pkt->stream_width = htobe32(stream_width);
+}
+
+size_t rp_encode_read(uint32_t id, uint32_t dev,
+                      struct rp_pkt_busaccess *pkt,
+                      int64_t clk, uint16_t master_id,
+                      uint64_t addr, uint64_t attr, uint32_t size,
+                      uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_read, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, 0);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_read_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_busaccess *pkt,
+                           int64_t clk, uint16_t master_id,
+                           uint64_t addr, uint64_t attr, uint32_t size,
+                           uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_read, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr + size, RP_PKT_FLAGS_response);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt + size;
+}
+
+size_t rp_encode_write(uint32_t id, uint32_t dev,
+                       struct rp_pkt_busaccess *pkt,
+                       int64_t clk, uint16_t master_id,
+                       uint64_t addr, uint64_t attr, uint32_t size,
+                       uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_write, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr + size, 0);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_write_resp(uint32_t id, uint32_t dev,
+                       struct rp_pkt_busaccess *pkt,
+                       int64_t clk, uint16_t master_id,
+                       uint64_t addr, uint64_t attr, uint32_t size,
+                       uint32_t width, uint32_t stream_width)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_write, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, RP_PKT_FLAGS_response);
+    rp_encode_busaccess_common(pkt, clk, master_id, addr, attr,
+                               size, width, stream_width);
+    return sizeof *pkt;
+}
+
+/* New API for extended header.  */
+size_t rp_encode_busaccess(struct rp_peer_state *peer,
+                           struct rp_pkt_busaccess_ext_base *pkt,
+                           struct rp_encode_busaccess_in *in) {
+    struct rp_pkt_busaccess *pkt_v4_0 = (void *) pkt;
+    uint32_t hsize = 0;
+    uint32_t ret_size = 0;
+
+    /* Allocate packet space.  */
+    if (in->cmd == RP_CMD_write && !(in->flags & RP_PKT_FLAGS_response)) {
+        hsize = in->size;
+    }
+    if (in->cmd == RP_CMD_read && (in->flags & RP_PKT_FLAGS_response)) {
+        hsize = in->size;
+        ret_size = in->size;
+    }
+
+    /* If peer does not support the busaccess base extensions, use the
+     * old layout. For responses, what matters is if we're responding
+     * to a packet with the extensions.
+     */
+    if (!peer->caps.busaccess_ext_base && !(in->attr & RP_BUS_ATTR_EXT_BASE)) {
+        /* Old layout.  */
+        assert(in->master_id < UINT16_MAX);
+
+        rp_encode_hdr(&pkt->hdr, in->cmd, in->id, in->dev,
+                  sizeof *pkt_v4_0 - sizeof pkt->hdr + hsize, in->flags);
+        rp_encode_busaccess_common(pkt_v4_0, in->clk, in->master_id,
+                                   in->addr, in->attr,
+                                   in->size, in->width, in->stream_width);
+        return sizeof *pkt_v4_0 + ret_size;
+    }
+
+    /* Encode the extended fields.  */
+    pkt->master_id_31_16 = htobe16(in->master_id >> 16);
+    pkt->master_id_63_32 = htobe32(in->master_id >> 32);
+
+    /* We always put data right after the header.  */
+    pkt->data_offset = htobe32(sizeof *pkt);
+    pkt->next_offset = 0;
+
+    pkt->byte_enable_offset = htobe32(sizeof *pkt + hsize);
+    pkt->byte_enable_len = htobe32(in->byte_enable_len);
+    hsize += in->byte_enable_len;
+
+    rp_encode_hdr(&pkt->hdr, in->cmd, in->id, in->dev,
+                  sizeof *pkt - sizeof pkt->hdr + hsize, in->flags);
+    rp_encode_busaccess_common(pkt_v4_0, in->clk, in->master_id, in->addr,
+                               in->attr | RP_BUS_ATTR_EXT_BASE,
+                               in->size, in->width, in->stream_width);
+
+    return sizeof *pkt + ret_size;
+}
+
+size_t rp_encode_interrupt_f(uint32_t id, uint32_t dev,
+                             struct rp_pkt_interrupt *pkt,
+                             int64_t clk,
+                             uint32_t line, uint64_t vector, uint8_t val,
+                             uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_interrupt, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = htobe64(clk);
+    pkt->vector = htobe64(vector);
+    pkt->line = htobe32(line);
+    pkt->val = val;
+    return sizeof *pkt;
+}
+
+size_t rp_encode_interrupt(uint32_t id, uint32_t dev,
+                           struct rp_pkt_interrupt *pkt,
+                           int64_t clk,
+                           uint32_t line, uint64_t vector, uint8_t val)
+{
+    return rp_encode_interrupt_f(id, dev, pkt, clk, line, vector, val, 0);
+}
+
+static size_t rp_encode_ats_common(uint32_t cmd, uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, cmd, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = htobe64(clk);
+    pkt->attributes = htobe64(attr);
+    pkt->addr = htobe64(addr);
+    pkt->len = htobe64(len);
+    pkt->result = htobe32(result);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_ats_req(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    return rp_encode_ats_common(RP_CMD_ats_req, id, dev,
+                                pkt, clk, attr,
+                                addr, len, result, flags);
+}
+
+size_t rp_encode_ats_inv(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t len, uint64_t result, uint32_t flags)
+{
+    return rp_encode_ats_common(RP_CMD_ats_inv, id, dev,
+                                pkt, clk, attr,
+                                addr, len, result, flags);
+}
+
+static size_t rp_encode_sync_common(uint32_t id, uint32_t dev,
+                                    struct rp_pkt_sync *pkt,
+                                    int64_t clk, uint32_t flags)
+{
+    rp_encode_hdr(&pkt->hdr, RP_CMD_sync, id, dev,
+                  sizeof *pkt - sizeof pkt->hdr, flags);
+    pkt->timestamp = htobe64(clk);
+    return sizeof *pkt;
+}
+
+size_t rp_encode_sync(uint32_t id, uint32_t dev,
+                      struct rp_pkt_sync *pkt,
+                      int64_t clk)
+{
+    return rp_encode_sync_common(id, dev, pkt, clk, 0);
+}
+
+size_t rp_encode_sync_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_sync *pkt,
+                           int64_t clk)
+{
+    return rp_encode_sync_common(id, dev, pkt, clk, RP_PKT_FLAGS_response);
+}
+
+void rp_process_caps(struct rp_peer_state *peer,
+                     void *caps, size_t caps_len)
+{
+    int i;
+
+    assert(peer->caps.busaccess_ext_base == false);
+
+    for (i = 0; i < caps_len; i++) {
+        uint32_t cap;
+
+        memcpy(&cap, caps + i * sizeof cap, sizeof cap);
+
+        switch (cap) {
+        case CAP_BUSACCESS_EXT_BASE:
+            peer->caps.busaccess_ext_base = true;
+            break;
+        case CAP_BUSACCESS_EXT_BYTE_EN:
+            peer->caps.busaccess_ext_byte_en = true;
+            break;
+        case CAP_WIRE_POSTED_UPDATES:
+            peer->caps.wire_posted_updates = true;
+            break;
+        case CAP_ATS:
+            peer->caps.ats = true;
+            break;
+        }
+    }
+}
+
+
+void rp_dpkt_alloc(RemotePortDynPkt *dpkt, size_t size)
+{
+    if (dpkt->size < size) {
+        char *u8;
+        dpkt->pkt = realloc(dpkt->pkt, size);
+        u8 = (void *) dpkt->pkt;
+        memset(u8 + dpkt->size, 0, size - dpkt->size);
+        dpkt->size = size;
+    }
+}
+
+void rp_dpkt_swap(RemotePortDynPkt *a, RemotePortDynPkt *b)
+{
+    struct rp_pkt *tmp_pkt;
+    size_t tmp_size;
+
+    tmp_pkt = a->pkt;
+    tmp_size = a->size;
+    a->pkt = b->pkt;
+    a->size = b->size;
+    b->pkt = tmp_pkt;
+    b->size = tmp_size;
+}
+
+bool rp_dpkt_is_valid(RemotePortDynPkt *dpkt)
+{
+    return dpkt->size > 0 && dpkt->pkt->hdr.len;
+}
+
+void rp_dpkt_invalidate(RemotePortDynPkt *dpkt)
+{
+    assert(rp_dpkt_is_valid(dpkt));
+    dpkt->pkt->hdr.len = 0;
+}
+
+inline void rp_dpkt_free(RemotePortDynPkt *dpkt)
+{
+    dpkt->size = 0;
+    free(dpkt->pkt);
+}
diff --git a/hw/core/remote-port-stream.c b/hw/core/remote-port-stream.c
new file mode 100644
index 0000000000..903664df4c
--- /dev/null
+++ b/hw/core/remote-port-stream.c
@@ -0,0 +1,233 @@
+/*
+ * Copyright (c) 2013 Xilinx Inc
+ * Copyright (c) 2013 Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ * Copyright (c) 2013 Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+
+#include "qemu/bitops.h"
+#include "qapi/qmp/qerror.h"
+#include "hw/stream.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/remote-port-device.h"
+#include "trace.h"
+
+#ifndef REMOTE_PORT_STREAM_ERR_DEBUG
+#define REMOTE_PORT_STREAM_ERR_DEBUG 0
+#endif
+
+#define TYPE_REMOTE_PORT_STREAM "remote-port-stream"
+
+#define REMOTE_PORT_STREAM(obj) \
+     OBJECT_CHECK(RemotePortStream, (obj), TYPE_REMOTE_PORT_STREAM)
+
+typedef struct RemotePortStream RemotePortStream;
+
+struct RemotePortStream {
+    DeviceState parent_obj;
+
+    RemotePort *rp;
+    uint32_t rp_dev;
+    uint16_t stream_width;
+
+    StreamSink *tx_dev;
+
+    StreamCanPushNotifyFn notify;
+    void *notify_opaque;
+
+    uint8_t *buf;
+    struct rp_pkt pkt;
+
+    bool rsp_pending;
+    uint32_t current_id;
+};
+
+static void rp_stream_notify(void *opaque)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(opaque);
+
+    /* FIXME: This is completely bogus.  */
+    if (s->buf && stream_can_push(s->tx_dev, rp_stream_notify, s)) {
+        RemotePortDynPkt rsp;
+        struct rp_encode_busaccess_in in = {0};
+        size_t pktlen = sizeof(struct rp_pkt_busaccess_ext_base);
+        size_t enclen;
+        int64_t delay = 0; /* FIXME - Implement */
+
+        size_t ret = stream_push(s->tx_dev, s->buf, 4, 0);
+        assert(ret == 4);
+        s->buf = NULL;
+
+        memset(&rsp, 0, sizeof(rsp));
+        rp_dpkt_alloc(&rsp, pktlen);
+        rp_encode_busaccess_in_rsp_init(&in, &s->pkt);
+        in.clk = s->pkt.busaccess.timestamp + delay;
+        enclen = rp_encode_busaccess(rp_get_peer(s->rp),
+                                     &rsp.pkt->busaccess_ext_base,
+                                     &in);
+        assert(enclen <= pktlen);
+        trace_remote_port_stream_tx_busaccess(rp_cmd_to_string(in.cmd),
+            in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+        rp_write(s->rp, (void *)rsp.pkt, pktlen);
+    }
+}
+
+static void rp_stream_write(RemotePortDevice *obj, struct rp_pkt *pkt)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    trace_remote_port_stream_rx_busaccess(rp_cmd_to_string(pkt->hdr.cmd),
+        pkt->hdr.id, pkt->hdr.flags, pkt->hdr.dev, pkt->busaccess.addr,
+        pkt->busaccess.len, pkt->busaccess.attributes);
+
+    assert(pkt->busaccess.width == 0);
+    assert(pkt->busaccess.stream_width == pkt->busaccess.len);
+    assert(pkt->busaccess.addr == 0);
+
+    if (pkt->hdr.flags & RP_PKT_FLAGS_response) {
+        /* FXIME - probably need to do syncs and stuff */
+        assert(s->rsp_pending);
+        s->rsp_pending = false;
+        if (s->notify) {
+            StreamCanPushNotifyFn notify = s->notify;
+            s->notify = NULL;
+            notify(s->notify_opaque);
+        }
+    } else {
+        assert(!s->buf);
+        s->buf = g_memdup(pkt + 1, 4);
+        s->pkt = *pkt;
+        rp_stream_notify(s);
+    }
+}
+
+static bool rp_stream_stream_can_push(StreamSink *obj,
+                                            StreamCanPushNotifyFn notify,
+                                            void *notify_opaque)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    if (s->rsp_pending) {
+        s->notify = notify;
+        s->notify_opaque = notify_opaque;
+        return false;
+    }
+    return true;
+}
+
+static size_t rp_stream_stream_push(StreamSink *obj, uint8_t *buf,
+                                    size_t len, bool eop)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+    RemotePortDynPkt rsp;
+    struct rp_pkt_busaccess_ext_base pkt;
+    struct rp_encode_busaccess_in in = {0};
+    uint64_t rp_attr = eop ? RP_BUS_ATTR_EOP : 0;
+    int64_t clk;
+    int enclen;
+
+    clk = rp_normalized_vmclk(s->rp);
+
+    in.cmd = RP_CMD_write;
+    in.id = rp_new_id(s->rp);
+    in.dev = s->rp_dev;
+    in.clk = clk;
+    in.attr = rp_attr;
+    in.size = len;
+    in.stream_width = s->stream_width;
+    enclen = rp_encode_busaccess(rp_get_peer(s->rp), &pkt, &in);
+
+    trace_remote_port_stream_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_rsp_mutex_lock(s->rp);
+    rp_write(s->rp, (void *) &pkt, enclen);
+    rp_write(s->rp, buf, len);
+    rsp = rp_wait_resp(s->rp);
+    assert(rsp.pkt->hdr.id == be32_to_cpu(pkt.hdr.id));
+
+    trace_remote_port_stream_rx_busaccess(
+        rp_cmd_to_string(rsp.pkt->hdr.cmd), rsp.pkt->hdr.id,
+        rsp.pkt->hdr.flags, rsp.pkt->hdr.dev, rsp.pkt->busaccess.addr,
+        rsp.pkt->busaccess.len, rsp.pkt->busaccess.attributes);
+
+    rp_dpkt_invalidate(&rsp);
+    rp_rsp_mutex_unlock(s->rp);
+    rp_restart_sync_timer(s->rp);
+    return len;
+}
+
+static void rp_stream_init(Object *obj)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SINK,
+                             (Object **)&s->tx_dev,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&s->rp,
+                             qdev_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortStream, rp_dev, 0),
+    DEFINE_PROP_UINT16("stream-width", RemotePortStream, stream_width, 4),
+};
+
+static void rp_stream_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    StreamSinkClass *ssc = STREAM_SINK_CLASS(oc);
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+
+    ssc->push = rp_stream_stream_push;
+    ssc->can_push = rp_stream_stream_can_push;
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    rpdc->ops[RP_CMD_write] = rp_stream_write;
+}
+
+static const TypeInfo rp_stream_info = {
+    .name          = TYPE_REMOTE_PORT_STREAM,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePortStream),
+    .class_init    = rp_stream_class_init,
+    .instance_init = rp_stream_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_STREAM_SINK },
+        { TYPE_REMOTE_PORT_DEVICE },
+        { },
+    }
+};
+
+static void rp_stream_register_types(void)
+{
+    type_register_static(&rp_stream_info);
+}
+
+type_init(rp_stream_register_types)
diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
new file mode 100644
index 0000000000..b3282b80d3
--- /dev/null
+++ b/hw/core/remote-port.c
@@ -0,0 +1,986 @@
+/*
+ * QEMU remote attach
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "system/dma.h"
+#include "chardev/char.h"
+#include "system/cpus.h"
+#include "system/cpu-timers.h"
+#include "exec/icount.h"
+#include "system/reset.h"
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+#include "hw/ptimer.h"
+#include "qemu/sockets.h"
+#include "qemu/thread.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "qemu/cutils.h"
+
+#ifndef _WIN32
+#include <sys/mman.h>
+#endif
+
+#include "hw/fdt_generic_util.h"
+#include "hw/remote-port-proto.h"
+#include "hw/remote-port-device.h"
+#include "hw/remote-port.h"
+
+#define D(x)
+#define SYNCD(x)
+
+#ifndef REMOTE_PORT_ERR_DEBUG
+#define REMOTE_PORT_DEBUG_LEVEL 0
+#else
+#define REMOTE_PORT_DEBUG_LEVEL 1
+#endif
+
+#define DB_PRINT_L(level, ...) do { \
+    if (REMOTE_PORT_DEBUG_LEVEL > level) { \
+        fprintf(stderr,  ": %s: ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0);
+
+#define REMOTE_PORT_CLASS(klass)    \
+     OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
+
+static bool time_warp_enable = true;
+
+bool rp_time_warp_enable(bool en)
+{
+    bool ret = time_warp_enable;
+
+    time_warp_enable = en;
+    return ret;
+}
+
+static void rp_event_read(void *opaque);
+static void sync_timer_hit(void *opaque);
+static void syncresp_timer_hit(void *opaque);
+
+static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
+{
+    qemu_hexdump(stdout, prefix, buf, len);
+}
+
+uint32_t rp_new_id(RemotePort *s)
+{
+    return qatomic_fetch_inc(&s->current_id);
+}
+
+void rp_rsp_mutex_lock(RemotePort *s)
+{
+    qemu_mutex_lock(&s->rsp_mutex);
+}
+
+void rp_rsp_mutex_unlock(RemotePort *s)
+{
+    qemu_mutex_unlock(&s->rsp_mutex);
+}
+
+int64_t rp_normalized_vmclk(RemotePort *s)
+{
+    int64_t clk;
+
+    clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    clk -= s->peer.clk_base;
+    return clk;
+}
+
+static void rp_restart_sync_timer_bare(RemotePort *s)
+{
+    if (!s->do_sync) {
+        return;
+    }
+
+    if (s->sync.quantum) {
+        ptimer_stop(s->sync.ptimer);
+        ptimer_set_limit(s->sync.ptimer, s->sync.quantum, 1);
+        ptimer_run(s->sync.ptimer, 1);
+    }
+}
+
+void rp_restart_sync_timer(RemotePort *s)
+{
+    if (s->doing_sync) {
+        return;
+    }
+    ptimer_transaction_begin(s->sync.ptimer);
+    rp_restart_sync_timer_bare(s);
+    ptimer_transaction_commit(s->sync.ptimer);
+}
+
+static void rp_fatal_error(RemotePort *s, const char *reason)
+{
+    int64_t clk = rp_normalized_vmclk(s);
+    error_report("%s: %s clk=%" PRIu64 " ns\n", s->prefix, reason, clk);
+    exit(EXIT_FAILURE);
+}
+
+static ssize_t rp_recv(RemotePort *s, void *buf, size_t count)
+{
+    ssize_t r;
+
+    r = qemu_chr_fe_read_all(&s->chr, buf, count);
+    if (r <= 0) {
+        return r;
+    }
+    if (r != count) {
+        error_report("%s: Bad read, expected %zd but got %zd\n",
+                     s->prefix, count, r);
+        rp_fatal_error(s, "Bad read");
+    }
+
+    return r;
+}
+
+ssize_t rp_write(RemotePort *s, const void *buf, size_t count)
+{
+    ssize_t r;
+
+    qemu_mutex_lock(&s->write_mutex);
+    r = qemu_chr_fe_write_all(&s->chr, buf, count);
+    qemu_mutex_unlock(&s->write_mutex);
+    assert(r == count);
+    if (r <= 0) {
+        error_report("%s: Disconnected r=%zd buf=%p count=%zd\n",
+                     s->prefix, r, buf, count);
+        rp_fatal_error(s, "Bad write");
+    }
+    return r;
+}
+
+static unsigned int rp_has_work(RemotePort *s)
+{
+    unsigned int work = s->rx_queue.wpos - s->rx_queue.rpos;
+    return work;
+}
+
+/* Response handling.  */
+RemotePortRespSlot *rp_dev_timed_wait_resp(RemotePort *s, uint32_t dev,
+                                            uint32_t id, int timems)
+{
+    int i;
+
+    assert(s->devs[dev]);
+
+    /* Find a free slot.  */
+    for (i = 0; i < ARRAY_SIZE(s->dev_state[dev].rsp_queue); i++) {
+        if (s->dev_state[dev].rsp_queue[i].used == false) {
+            break;
+        }
+    }
+
+    if (i == ARRAY_SIZE(s->dev_state[dev].rsp_queue) ||
+        s->dev_state[dev].rsp_queue[i].used == true) {
+        error_report("Number of outstanding transactions exceeded! %d",
+                      RP_MAX_OUTSTANDING_TRANSACTIONS);
+        rp_fatal_error(s, "Internal error");
+    }
+
+    /* Got a slot, fill it in.  */
+    s->dev_state[dev].rsp_queue[i].id = id;
+    s->dev_state[dev].rsp_queue[i].valid = false;
+    s->dev_state[dev].rsp_queue[i].used = true;
+
+    while (!s->dev_state[dev].rsp_queue[i].valid) {
+        rp_rsp_mutex_unlock(s);
+        rp_event_read(s);
+        rp_rsp_mutex_lock(s);
+        if (s->dev_state[dev].rsp_queue[i].valid) {
+            break;
+        }
+        if (!rp_has_work(s)) {
+            if (timems) {
+                if (!qemu_cond_timedwait(&s->progress_cond, &s->rsp_mutex,
+                                       timems)) {
+                    /*
+                     * TimeOut!
+                     */
+                    break;
+                }
+            } else {
+                qemu_cond_wait(&s->progress_cond, &s->rsp_mutex);
+            }
+        }
+    }
+    return &s->dev_state[dev].rsp_queue[i];
+}
+
+RemotePortRespSlot *rp_dev_wait_resp(RemotePort *s, uint32_t dev, uint32_t id)
+{
+    return rp_dev_timed_wait_resp(s, dev, id, 0);
+}
+
+RemotePortDynPkt rp_wait_resp(RemotePort *s)
+{
+    while (!rp_dpkt_is_valid(&s->rspqueue)) {
+        rp_rsp_mutex_unlock(s);
+        rp_event_read(s);
+        rp_rsp_mutex_lock(s);
+        /* Need to recheck the condition with the rsp lock taken.  */
+        if (rp_dpkt_is_valid(&s->rspqueue)) {
+            break;
+        }
+        D(qemu_log("%s: wait for progress\n", __func__));
+        if (!rp_has_work(s)) {
+            qemu_cond_wait(&s->progress_cond, &s->rsp_mutex);
+        }
+    }
+    return s->rspqueue;
+}
+
+static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
+{
+    s->peer.version = pkt->hello.version;
+    if (pkt->hello.version.major != RP_VERSION_MAJOR) {
+        error_report("remote-port version missmatch remote=%d.%d local=%d.%d\n",
+                      pkt->hello.version.major, pkt->hello.version.minor,
+                      RP_VERSION_MAJOR, RP_VERSION_MINOR);
+        rp_fatal_error(s, "Bad version");
+    }
+
+    if (pkt->hello.caps.len) {
+        void *caps = (char *) pkt + pkt->hello.caps.offset;
+
+        rp_process_caps(&s->peer, caps, pkt->hello.caps.len);
+    }
+}
+
+static void rp_cmd_sync(RemotePort *s, struct rp_pkt *pkt)
+{
+    size_t enclen;
+    int64_t clk;
+    int64_t diff;
+
+    assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    clk = rp_normalized_vmclk(s);
+    diff = pkt->sync.timestamp - clk;
+
+    enclen = rp_encode_sync_resp(pkt->hdr.id, pkt->hdr.dev, &s->sync.rsp.sync,
+                                 pkt->sync.timestamp);
+    assert(enclen == sizeof s->sync.rsp.sync);
+
+    /* We have temporarily disabled blocking syncs into QEMU.  */
+    if (diff <= 0LL || true) {
+        /* We are already a head of time. Respond and issue a sync.  */
+        SYNCD(printf("%s: sync resp %lu\n", s->prefix, pkt->sync.timestamp));
+        rp_write(s, (void *) &s->sync.rsp, enclen);
+        return;
+    }
+
+    SYNCD(printf("%s: delayed sync resp - start diff=%ld (ts=%lu clk=%lu)\n",
+          s->prefix, pkt->sync.timestamp - clk, pkt->sync.timestamp, clk));
+
+    ptimer_transaction_begin(s->sync.ptimer_resp);
+    ptimer_set_limit(s->sync.ptimer_resp, diff, 1);
+    ptimer_run(s->sync.ptimer_resp, 1);
+    s->sync.resp_timer_enabled = true;
+    ptimer_transaction_commit(s->sync.ptimer_resp);
+}
+
+static void rp_say_hello(RemotePort *s)
+{
+    struct rp_pkt_hello pkt;
+    uint32_t caps[] = {
+        CAP_BUSACCESS_EXT_BASE,
+        CAP_BUSACCESS_EXT_BYTE_EN,
+        CAP_WIRE_POSTED_UPDATES,
+        CAP_ATS,
+    };
+    size_t len;
+
+    len = rp_encode_hello_caps(s->current_id++, 0, &pkt, RP_VERSION_MAJOR,
+                               RP_VERSION_MINOR,
+                               caps, caps, sizeof caps / sizeof caps[0]);
+    rp_write(s, (void *) &pkt, len);
+
+    if (sizeof caps) {
+        rp_write(s, caps, sizeof caps);
+    }
+}
+
+static void rp_say_sync(RemotePort *s, int64_t clk)
+{
+    struct rp_pkt_sync pkt;
+    size_t len;
+
+    len = rp_encode_sync(s->current_id++, 0, &pkt, clk);
+    rp_write(s, (void *) &pkt, len);
+}
+
+static void syncresp_timer_hit(void *opaque)
+{
+    RemotePort *s = REMOTE_PORT(opaque);
+
+    s->sync.resp_timer_enabled = false;
+    SYNCD(printf("%s: delayed sync response - send\n", s->prefix));
+    rp_write(s, (void *) &s->sync.rsp, sizeof s->sync.rsp.sync);
+    memset(&s->sync.rsp, 0, sizeof s->sync.rsp);
+}
+
+static void sync_timer_hit(void *opaque)
+{
+    RemotePort *s = REMOTE_PORT(opaque);
+    int64_t clk;
+    RemotePortDynPkt rsp;
+
+    clk = rp_normalized_vmclk(s);
+    if (s->sync.resp_timer_enabled) {
+        SYNCD(printf("%s: sync while delaying a resp! clk=%lu\n",
+                     s->prefix, clk));
+        s->sync.need_sync = true;
+        rp_restart_sync_timer_bare(s);
+        return;
+    }
+
+    /* Sync.  */
+    s->doing_sync = true;
+    s->sync.need_sync = false;
+    qemu_mutex_lock(&s->rsp_mutex);
+    /* Send the sync.  */
+    rp_say_sync(s, clk);
+
+    SYNCD(printf("%s: syncing wait for resp %lu\n", s->prefix, clk));
+    rsp = rp_wait_resp(s);
+    rp_dpkt_invalidate(&rsp);
+    qemu_mutex_unlock(&s->rsp_mutex);
+    s->doing_sync = false;
+
+    rp_restart_sync_timer_bare(s);
+}
+
+static char *rp_sanitize_prefix(RemotePort *s)
+{
+    char *sanitized_name;
+    char *c;
+
+    sanitized_name = g_strdup(s->prefix);
+    for (c = sanitized_name; *c != '\0'; c++) {
+        if (*c == '/')
+            *c = '_';
+    }
+    return sanitized_name;
+}
+
+static char *rp_autocreate_chardesc(RemotePort *s, bool server)
+{
+    char *prefix;
+    char *chardesc;
+    int r;
+
+    prefix = rp_sanitize_prefix(s);
+    r = asprintf(&chardesc, "unix:%s/qemu-rport-%s%s",
+                 machine_path, prefix, server ? ",wait,server" : "");
+    assert(r > 0);
+    free(prefix);
+    return chardesc;
+}
+
+static Chardev *rp_autocreate_chardev(RemotePort *s, char *name)
+{
+    Chardev *chr = NULL;
+    char *chardesc;
+    char *s_path;
+    int r;
+
+    r = asprintf(&s_path, "%s/qemu-rport-%s", machine_path,
+                 rp_sanitize_prefix(s));
+    assert(r > 0);
+    if (g_file_test(s_path, G_FILE_TEST_EXISTS)) {
+        chardesc = rp_autocreate_chardesc(s, false);
+        chr = qemu_chr_new_noreplay(name, chardesc, false, NULL);
+        free(chardesc);
+    }
+    free(s_path);
+
+    if (!chr) {
+        chardesc = rp_autocreate_chardesc(s, true);
+        chr = qemu_chr_new_noreplay(name, chardesc, false, NULL);
+        free(chardesc);
+    }
+    return chr;
+}
+
+void rp_process(RemotePort *s)
+{
+    while (true) {
+        struct rp_pkt *pkt;
+        unsigned int rpos;
+        bool actioned = false;
+        RemotePortDevice *dev;
+        RemotePortDeviceClass *rpdc;
+
+        qemu_mutex_lock(&s->rsp_mutex);
+        if (!rp_has_work(s)) {
+            qemu_mutex_unlock(&s->rsp_mutex);
+            break;
+        }
+        rpos = s->rx_queue.rpos;
+
+        pkt = s->rx_queue.pkt[rpos].pkt;
+        D(qemu_log("%s: io-thread rpos=%d wpos=%d cmd=%d dev=%d\n",
+                 s->prefix, s->rx_queue.rpos, s->rx_queue.wpos,
+                 pkt->hdr.cmd, pkt->hdr.dev));
+
+        /* To handle recursiveness, we need to advance the index
+         * index before processing the packet.  */
+        s->rx_queue.rpos++;
+        s->rx_queue.rpos %= ARRAY_SIZE(s->rx_queue.pkt);
+        qemu_mutex_unlock(&s->rsp_mutex);
+
+        dev = s->devs[pkt->hdr.dev];
+        if (dev) {
+            rpdc = REMOTE_PORT_DEVICE_GET_CLASS(dev);
+            if (rpdc->ops[pkt->hdr.cmd]) {
+                rpdc->ops[pkt->hdr.cmd](dev, pkt);
+                actioned = true;
+            }
+        }
+
+        switch (pkt->hdr.cmd) {
+        case RP_CMD_sync:
+            rp_cmd_sync(s, pkt);
+            break;
+        default:
+            assert(actioned);
+        }
+
+        s->rx_queue.inuse[rpos] = false;
+        qemu_sem_post(&s->rx_queue.sem);
+    }
+}
+
+static void rp_event_read(void *opaque)
+{
+    RemotePort *s = REMOTE_PORT(opaque);
+    unsigned char buf[32];
+    ssize_t r;
+
+    /* We don't care about the data. Just read it out to clear the event.  */
+    do {
+#ifdef _WIN32
+        r = qemu_recv_wrap(s->event.pipe.read, buf, sizeof buf, 0);
+#else
+        r = read(s->event.pipe.read, buf, sizeof buf);
+#endif
+        if (r == 0) {
+            return;
+        }
+    } while (r == sizeof buf || (r < 0 && errno == EINTR));
+
+    rp_process(s);
+}
+
+static void rp_event_notify(RemotePort *s)
+{
+    unsigned char d = 0;
+    ssize_t r;
+
+#ifdef _WIN32
+    /* Mingw is sensitive about doing write's to socket descriptors.  */
+    r = qemu_send_wrap(s->event.pipe.write, &d, sizeof d, 0);
+#else
+    r = qemu_write_full(s->event.pipe.write, &d, sizeof d);
+#endif
+    if (r == 0) {
+        hw_error("%s: pipe closed\n", s->prefix);
+    }
+}
+
+/* Handover a pkt to CPU or IO-thread context.  */
+static void rp_pt_handover_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    bool full;
+
+    /* Take the rsp lock around the wpos update, otherwise
+       rp_wait_resp will race with us.  */
+    qemu_mutex_lock(&s->rsp_mutex);
+    s->rx_queue.wpos++;
+    s->rx_queue.wpos %= ARRAY_SIZE(s->rx_queue.pkt);
+    smp_mb();
+    rp_event_notify(s);
+    qemu_cond_signal(&s->progress_cond);
+    qemu_mutex_unlock(&s->rsp_mutex);
+
+    do {
+        full = s->rx_queue.inuse[s->rx_queue.wpos];
+        if (full) {
+            qemu_log("%s: FULL rx queue %d\n", __func__, s->rx_queue.wpos);
+	    if (qemu_sem_timedwait(&s->rx_queue.sem, 2 * 1000) != 0) {
+#ifndef _WIN32
+                int sval;
+
+#ifndef CONFIG_SEM_TIMEDWAIT
+                sval = s->rx_queue.sem.count;
+#else
+                sem_getvalue(&s->rx_queue.sem.sem, &sval);
+#endif
+                qemu_log("semwait: %d rpos=%u wpos=%u\n", sval,
+                         s->rx_queue.rpos, s->rx_queue.wpos);
+#endif
+                qemu_log("Deadlock?\n");
+	    }
+        }
+    } while (full);
+}
+
+static bool rp_pt_cmd_sync(RemotePort *s, struct rp_pkt *pkt)
+{
+    size_t enclen;
+    int64_t clk;
+    int64_t diff = 0;
+    struct rp_pkt rsp;
+
+    assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    if (use_icount) {
+        clk = rp_normalized_vmclk(s);
+        diff = pkt->sync.timestamp - clk;
+    }
+    enclen = rp_encode_sync_resp(pkt->hdr.id, pkt->hdr.dev, &rsp.sync,
+                                 pkt->sync.timestamp);
+    assert(enclen == sizeof rsp.sync);
+
+    if (!use_icount || diff < s->sync.quantum) {
+        /* We are still OK.  */
+        rp_write(s, (void *) &rsp, enclen);
+        return true;
+    }
+
+    /* We need IO or CPU thread sync.  */
+    return false;
+}
+
+static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    struct rp_pkt *pkt = dpkt->pkt;
+
+    D(qemu_log("%s: cmd=%x id=%d dev=%d rsp=%d\n", __func__, pkt->hdr.cmd,
+             pkt->hdr.id, pkt->hdr.dev,
+             pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    if (pkt->hdr.dev >= ARRAY_SIZE(s->devs)) {
+        /* FIXME: Respond with an error.  */
+        return true;
+    }
+
+    if (pkt->hdr.flags & RP_PKT_FLAGS_response) {
+        uint32_t dev = pkt->hdr.dev;
+        uint32_t id = pkt->hdr.id;
+        int i;
+
+        if (pkt->hdr.flags & RP_PKT_FLAGS_posted) {
+            printf("Drop response for posted packets\n");
+            return true;
+        }
+
+        qemu_mutex_lock(&s->rsp_mutex);
+
+        /* Try to find a per-device slot first.  */
+        for (i = 0; i < ARRAY_SIZE(s->dev_state[dev].rsp_queue); i++) {
+            if (s->devs[dev] && s->dev_state[dev].rsp_queue[i].used == true
+                && s->dev_state[dev].rsp_queue[i].id == id) {
+                break;
+            }
+        }
+
+        if (i < ARRAY_SIZE(s->dev_state[dev].rsp_queue)) {
+            /* Found a per device one.  */
+            assert(s->dev_state[dev].rsp_queue[i].valid == false);
+
+            rp_dpkt_swap(&s->dev_state[dev].rsp_queue[i].rsp, dpkt);
+            s->dev_state[dev].rsp_queue[i].valid = true;
+
+            qemu_cond_signal(&s->progress_cond);
+        } else {
+            rp_dpkt_swap(&s->rspqueue, dpkt);
+            qemu_cond_signal(&s->progress_cond);
+        }
+
+        qemu_mutex_unlock(&s->rsp_mutex);
+        return true;
+    }
+
+    switch (pkt->hdr.cmd) {
+    case RP_CMD_hello:
+        rp_cmd_hello(s, pkt);
+        break;
+    case RP_CMD_sync:
+        if (rp_pt_cmd_sync(s, pkt)) {
+            return true;
+        }
+        /* Fall-through.  */
+    case RP_CMD_read:
+    case RP_CMD_write:
+    case RP_CMD_interrupt:
+    case RP_CMD_ats_req:
+    case RP_CMD_ats_inv:
+        rp_pt_handover_pkt(s, dpkt);
+        break;
+    default:
+        assert(0);
+        break;
+    }
+    return false;
+}
+
+static int rp_read_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    struct rp_pkt *pkt = dpkt->pkt;
+    int used;
+    int r;
+
+    r = rp_recv(s, pkt, sizeof pkt->hdr);
+    if (r <= 0) {
+        return r;
+    }
+    used = rp_decode_hdr((void *) &pkt->hdr);
+    assert(used == sizeof pkt->hdr);
+
+    if (pkt->hdr.len) {
+        rp_dpkt_alloc(dpkt, sizeof pkt->hdr + pkt->hdr.len);
+        /* pkt may move due to realloc.  */
+        pkt = dpkt->pkt;
+        r = rp_recv(s, &pkt->hdr + 1, pkt->hdr.len);
+        if (r <= 0) {
+            return r;
+        }
+        rp_decode_payload(pkt);
+    }
+
+    return used + r;
+}
+
+static void *rp_protocol_thread(void *arg)
+{
+    RemotePort *s = REMOTE_PORT(arg);
+    unsigned int i;
+    int r;
+
+    /* Make sure we have a decent bufsize to start with.  */
+    rp_dpkt_alloc(&s->rsp, sizeof s->rsp.pkt->busaccess + 1024);
+    rp_dpkt_alloc(&s->rspqueue, sizeof s->rspqueue.pkt->busaccess + 1024);
+    for (i = 0; i < ARRAY_SIZE(s->rx_queue.pkt); i++) {
+        rp_dpkt_alloc(&s->rx_queue.pkt[i],
+                      sizeof s->rx_queue.pkt[i].pkt->busaccess + 1024);
+        s->rx_queue.inuse[i] = false;
+    }
+
+    rp_say_hello(s);
+
+    while (1) {
+        RemotePortDynPkt *dpkt;
+        unsigned int wpos = s->rx_queue.wpos;
+        bool handled;
+
+        dpkt = &s->rx_queue.pkt[wpos];
+        s->rx_queue.inuse[wpos] = true;
+
+        r = rp_read_pkt(s, dpkt);
+        if (r <= 0) {
+            /* Disconnected.  */
+            break;
+        }
+        if (0) {
+            rp_pkt_dump("rport-pkt", (void *) dpkt->pkt,
+                        sizeof dpkt->pkt->hdr + dpkt->pkt->hdr.len);
+        }
+        handled = rp_pt_process_pkt(s, dpkt);
+        if (handled) {
+            s->rx_queue.inuse[wpos] = false;
+        }
+    }
+
+    if (!s->finalizing) {
+        rp_fatal_error(s, "Disconnected");
+    }
+    return NULL;
+}
+
+static void rp_reset(DeviceState *dev)
+{
+    RemotePort *s = REMOTE_PORT(dev);
+
+    if (s->reset_done) {
+        return;
+    }
+
+    qemu_thread_create(&s->thread, "remote-port", rp_protocol_thread, s,
+                       QEMU_THREAD_JOINABLE);
+
+    rp_restart_sync_timer(s);
+    s->reset_done = true;
+}
+
+static void rp_realize(DeviceState *dev, Error **errp)
+{
+    RemotePort *s = REMOTE_PORT(dev);
+    int r;
+    Error *err = NULL;
+
+    s->prefix = object_get_canonical_path(OBJECT(dev));
+
+    s->peer.clk_base = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    qemu_mutex_init(&s->write_mutex);
+    qemu_mutex_init(&s->rsp_mutex);
+    qemu_cond_init(&s->progress_cond);
+
+    if (!qemu_chr_fe_get_driver(&s->chr)) {
+        char *name;
+        Chardev *chr = NULL;
+        static int nr = 0;
+
+        r = asprintf(&name, "rport%d", nr);
+        nr++;
+        assert(r > 0);
+
+        if (s->chrdev_id) {
+            chr = qemu_chr_find(s->chrdev_id);
+        }
+
+        if (chr) {
+            /* Found the chardev via commandline */
+        } else if (s->chardesc) {
+            chr = qemu_chr_new(name, s->chardesc, NULL);
+        } else {
+            if (!machine_path) {
+                error_report("%s: Missing chardesc prop."
+                             " Forgot -machine-path?\n",
+                             s->prefix);
+                exit(EXIT_FAILURE);
+            }
+            chr = rp_autocreate_chardev(s, name);
+        }
+
+        free(name);
+        if (!chr) {
+            error_report("%s: Unable to create remort-port channel %s\n",
+                         s->prefix, s->chardesc);
+            exit(EXIT_FAILURE);
+        }
+
+        qdev_prop_set_chr(dev, "chardev", chr);
+        s->chrdev = chr;
+    }
+
+    /* Force RP sockets into blocking mode since our RP-thread will deal
+     * with the IO and bypassing QEMUs main-loop.
+     */
+    qemu_chr_fe_set_blocking(&s->chr, true);
+
+#ifdef _WIN32
+    /* Create a socket connection between two sockets. We auto-bind
+     * and read out the port selected by the kernel.
+     */
+    {
+        char *name;
+        SocketAddress *sock;
+        int port;
+        int listen_sk;
+
+        sock = socket_parse("127.0.0.1:0", &error_abort);
+        listen_sk = socket_listen(sock, 1, &error_abort);
+
+        if (s->event.pipe.read < 0) {
+            perror("socket read");
+            exit(EXIT_FAILURE);
+        }
+
+        {
+            struct sockaddr_in saddr;
+            socklen_t slen = sizeof saddr;
+            int r;
+
+            r = getsockname(listen_sk, (struct sockaddr *) &saddr, &slen);
+            if (r < 0) {
+                perror("getsockname");
+                exit(EXIT_FAILURE);
+            }
+            port = htons(saddr.sin_port);
+        }
+
+        name = g_strdup_printf("127.0.0.1:%d", port);
+        s->event.pipe.write = inet_connect(name, &error_abort);
+        g_free(name);
+        if (s->event.pipe.write < 0) {
+            perror("socket write");
+            exit(EXIT_FAILURE);
+        }
+
+        for (;;) {
+            struct sockaddr_in saddr;
+            socklen_t slen = sizeof saddr;
+            int fd;
+
+            slen = sizeof(saddr);
+            fd = qemu_accept(listen_sk, (struct sockaddr *)&saddr, &slen);
+            if (fd < 0 && errno != EINTR) {
+                close(listen_sk);
+                return;
+            } else if (fd >= 0) {
+                close(listen_sk);
+                s->event.pipe.read = fd;
+                break;
+            }
+        }
+
+        if (!qemu_set_blocking(s->event.pipe.read, false, &err)) {
+            error_report("%s: Unable to set non-block for internal pipes\n",
+                        s->prefix);
+            exit(EXIT_FAILURE);
+        }
+        qemu_set_fd_handler(s->event.pipe.read, rp_event_read, NULL, s);
+    }
+#else
+    if (!g_unix_open_pipe(s->event.pipes, FD_CLOEXEC, NULL)) {
+        error_report("%s: Unable to create remort-port internal pipes\n",
+                    s->prefix);
+        exit(EXIT_FAILURE);
+    }
+
+    if (!qemu_set_blocking(s->event.pipe.read, false, &err)) {
+        error_report("%s: Unable to set non-block for internal pipes\n",
+                    s->prefix);
+        exit(EXIT_FAILURE);
+    }
+
+    qemu_set_fd_handler(s->event.pipe.read, rp_event_read, NULL, s);
+#endif
+
+
+    /* Pick up the quantum from the local property setup.
+       After config negotiation with the peer, sync.quantum value might
+       change.  */
+    s->sync.quantum = s->peer.local_cfg.quantum;
+
+    s->sync.ptimer = ptimer_init(sync_timer_hit, s, PTIMER_POLICY_LEGACY);
+    s->sync.ptimer_resp = ptimer_init(syncresp_timer_hit, s,
+                                      PTIMER_POLICY_LEGACY);
+
+    /* The Sync-quantum is expressed in nano-seconds.  */
+    ptimer_transaction_begin(s->sync.ptimer);
+    ptimer_set_freq(s->sync.ptimer, 1000 * 1000 * 1000);
+    ptimer_transaction_commit(s->sync.ptimer);
+
+    ptimer_transaction_begin(s->sync.ptimer_resp);
+    ptimer_set_freq(s->sync.ptimer_resp, 1000 * 1000 * 1000);
+    ptimer_transaction_commit(s->sync.ptimer_resp);
+
+    qemu_sem_init(&s->rx_queue.sem, ARRAY_SIZE(s->rx_queue.pkt) - 1);
+}
+
+static void rp_unrealize(DeviceState *dev)
+{
+    RemotePort *s = REMOTE_PORT(dev);
+
+    s->finalizing = true;
+
+    /* Unregister handler.  */
+    qemu_set_fd_handler(s->event.pipe.read, NULL, NULL, s);
+
+    info_report("%s: Wait for remote-port to disconnect\n", s->prefix);
+    qemu_chr_fe_disconnect(&s->chr);
+    qemu_thread_join(&s->thread);
+
+    close(s->event.pipe.read);
+    close(s->event.pipe.write);
+    object_unparent(OBJECT(s->chrdev));
+}
+
+static const VMStateDescription vmstate_rp = {
+    .name = TYPE_REMOTE_PORT,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property rp_properties[] = {
+    DEFINE_PROP_CHR("chardev", RemotePort, chr),
+    DEFINE_PROP_STRING("chardesc", RemotePort, chardesc),
+    DEFINE_PROP_STRING("chrdev-id", RemotePort, chrdev_id),
+    DEFINE_PROP_BOOL("sync", RemotePort, do_sync, false),
+    DEFINE_PROP_UINT64("sync-quantum", RemotePort, peer.local_cfg.quantum,
+                       1000000),
+};
+
+static void rp_init(Object *obj)
+{
+    RemotePort *s = REMOTE_PORT(obj);
+    int t;
+    int i;
+
+    for (i = 0; i < REMOTE_PORT_MAX_DEVS; ++i) {
+        char *name = g_strdup_printf("remote-port-dev%d", i);
+        object_property_add_link(obj, name, TYPE_REMOTE_PORT_DEVICE,
+                             (Object **)&s->devs[i],
+                             qdev_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+        g_free(name);
+
+
+        for (t = 0; t < RP_MAX_OUTSTANDING_TRANSACTIONS; t++) {
+            s->dev_state[i].rsp_queue[t].used = false;
+            s->dev_state[i].rsp_queue[t].valid = false;
+            rp_dpkt_alloc(&s->dev_state[i].rsp_queue[t].rsp,
+               sizeof s->dev_state[i].rsp_queue[t].rsp.pkt->busaccess + 1024);
+        }
+    }
+}
+
+struct rp_peer_state *rp_get_peer(RemotePort *s)
+{
+    return &s->peer;
+}
+
+static void rp_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->legacy_reset = rp_reset;
+    dc->realize = rp_realize;
+    dc->unrealize = rp_unrealize;
+    dc->vmsd = &vmstate_rp;
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePort),
+    .instance_init = rp_init,
+    .class_init    = rp_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { },
+    },
+};
+
+static const TypeInfo rp_device_info = {
+    .name          = TYPE_REMOTE_PORT_DEVICE,
+    .parent        = TYPE_INTERFACE,
+    .class_size    = sizeof(RemotePortDeviceClass),
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+    type_register_static(&rp_device_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
index 2cf085ac66..a1472ab2b2 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -32,3 +32,20 @@ clock_set_mul_div(const char *clk, uint32_t oldmul, uint32_t mul, uint32_t olddi
 
 # cpu-common.c
 cpu_reset(int cpu_index) "%d"
+
+# remote-port-memory-master.c
+remote_port_memory_master_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_memory_master_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+
+# remote-port-memory-slave.c
+remote_port_memory_slave_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_memory_slave_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len, uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+
+# remote-port-memory-gpio.c
+remote_port_gpio_tx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
+remote_port_gpio_rx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
+
+# remote-port-stream.c
+remote_port_stream_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len,  uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_stream_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len,  uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..371af17c41 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -8,6 +8,7 @@ system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_COMMON', if_true: files('pvpanic.c'))
+system_ss.add(files('xlnx-serbs.c'))
 
 # ARM devices
 system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
diff --git a/hw/misc/xlnx-serbs.c b/hw/misc/xlnx-serbs.c
new file mode 100644
index 0000000000..1b1f2e5bd6
--- /dev/null
+++ b/hw/misc/xlnx-serbs.c
@@ -0,0 +1,43 @@
+/*
+ * Xilinx Versal SERBS
+ *
+ * SPDX-FileCopyrightText: 2023 AMD
+ * SPDX-FileContributor: Author: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/xlnx-serbs.h"
+
+void xlnx_serbs_if_timer_config(xlnx_serbs_if *sif, int id,
+                                int timems, bool enable)
+{
+    xlnx_serbs_if_class *Klass = XLNX_SERBS_IF_GET_CLASS(sif);
+
+    if (Klass->timer_config) {
+        Klass->timer_config(sif, id, timems, enable);
+    }
+}
+
+void xlnx_serbs_if_timeout_set(xlnx_serbs_if *sif, int id, bool level)
+{
+    xlnx_serbs_if_class *Klass = XLNX_SERBS_IF_GET_CLASS(sif);
+
+    if (Klass->timeout_set) {
+        Klass->timeout_set(sif, id, level);
+    }
+}
+
+static const TypeInfo serbs_if_info = {
+    .name   = TYPE_XLNX_SERBS_IF,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(xlnx_serbs_if_class),
+};
+
+static void serbs_if_types(void)
+{
+    type_register_static(&serbs_if_info);
+}
+
+type_init(serbs_if_types);
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 5f8a6df17d..5a2e3d60ee 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -179,6 +179,8 @@ void qemu_chr_fe_printf(CharFrontend *c, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
 
+void qemu_chr_fe_set_blocking(CharFrontend *be, bool blocking);
+
 /**
  * FEWatchFunc: a #GSourceFunc called when any conditions requested by
  *              qemu_chr_fe_add_watch() is satisfied.
diff --git a/include/chardev/char.h b/include/chardev/char.h
index b65e9981c1..1dd2e7741a 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -305,6 +305,8 @@ struct ChardevClass {
     /* notify the backend of frontend open state */
     void (*chr_set_fe_open)(Chardev *chr, int fe_open);
 
+    void (*chr_set_blocking)(Chardev *chr, bool blocking);
+
     /* handle various events */
     void (*chr_be_event)(Chardev *s, QEMUChrEvent event);
 };
diff --git a/include/hw/misc/xlnx-serbs.h b/include/hw/misc/xlnx-serbs.h
new file mode 100644
index 0000000000..ecf839acb3
--- /dev/null
+++ b/include/hw/misc/xlnx-serbs.h
@@ -0,0 +1,36 @@
+/*
+ * Xilinx Versal SERBS
+ *
+ * SPDX-FileCopyrightText: 2023 AMD
+ * SPDX-FileContributor: Author: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef XLNX_VERSAL_SERBS_H
+#define XLNX_VERSAL_SERBS_H
+
+#include "qom/object.h"
+#define TYPE_XLNX_SERBS_IF "xlnx-serbs-if"
+
+typedef struct xlnx_serbs_if_class xlnx_serbs_if_class;
+DECLARE_CLASS_CHECKERS(xlnx_serbs_if_class, XLNX_SERBS_IF, TYPE_XLNX_SERBS_IF)
+
+#define XLNX_SERBS_IF(obj) \
+    INTERFACE_CHECK(xlnx_serbs_if, (obj), TYPE_XLNX_SERBS_IF)
+
+typedef struct xlnx_serbs_if {
+    Object Parent;
+} xlnx_serbs_if;
+
+typedef struct xlnx_serbs_if_class {
+    InterfaceClass parent;
+
+    void (*timer_config)(xlnx_serbs_if *sif, int id, int timems, bool enable);
+    void (*timeout_set)(xlnx_serbs_if *sif, int id, bool level);
+} xlnx_serbs_if_class;
+
+void xlnx_serbs_if_timer_config(xlnx_serbs_if *sif, int id, int timems,
+                                bool enable);
+void xlnx_serbs_if_timeout_set(xlnx_serbs_if *sif, int id, bool level);
+#endif
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 8553abdda1..07f88513a4 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -269,6 +269,8 @@ void qdev_alias_all_properties(DeviceState *target, Object *source);
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                  Error **errp);
 
+void qdev_prop_allow_set_link(const Object *obj, const char *name,
+                              Object *val, Error **errp);
 /**
  * qdev_prop_allow_set_link_before_realize:
  *
diff --git a/include/hw/remote-port-ats.h b/include/hw/remote-port-ats.h
new file mode 100644
index 0000000000..178e51d52a
--- /dev/null
+++ b/include/hw/remote-port-ats.h
@@ -0,0 +1,74 @@
+/*
+ * QEMU remote port ATS
+ *
+ * Copyright (c) 2021 Xilinx Inc
+ * Written by Francisco Iglesias <francisco.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef REMOTE_PORT_ATS_H
+#define REMOTE_PORT_ATS_H
+
+#include "hw/remote-port.h"
+
+#define TYPE_REMOTE_PORT_ATS "remote-port-ats"
+#define REMOTE_PORT_ATS(obj) \
+        OBJECT_CHECK(RemotePortATS, (obj), TYPE_REMOTE_PORT_ATS)
+
+typedef struct {
+    /* private */
+    SysBusDevice parent;
+
+    /* public */
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+    MemoryRegion *mr;
+    AddressSpace as;
+    RemotePortDynPkt rsp;
+    GArray *iommu_notifiers;
+    uint32_t rp_dev;
+    GArray *cache; /* Translation cache */
+} RemotePortATS;
+
+#define TYPE_REMOTE_PORT_ATS_CACHE "remote-port-ats-cache"
+
+#define REMOTE_PORT_ATS_CACHE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(RemotePortATSCacheClass, (klass), \
+                        TYPE_REMOTE_PORT_ATS_CACHE)
+#define REMOTE_PORT_ATS_CACHE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RemotePortATSCacheClass, (obj), TYPE_REMOTE_PORT_ATS_CACHE)
+#define REMOTE_PORT_ATS_CACHE(obj) \
+     INTERFACE_CHECK(RemotePortATSCache, (obj), TYPE_REMOTE_PORT_ATS_CACHE)
+
+typedef struct RemotePortATSCache {
+    Object Parent;
+} RemotePortATSCache;
+
+typedef struct RemotePortATSCacheClass {
+    InterfaceClass parent;
+
+    IOMMUTLBEntry *(*lookup_translation)(RemotePortATSCache *cache,
+                                         hwaddr translated_addr,
+                                         hwaddr len);
+} RemotePortATSCacheClass;
+
+IOMMUTLBEntry *rp_ats_cache_lookup_translation(RemotePortATSCache *cache,
+                                               hwaddr translated_addr,
+                                               hwaddr len);
+#endif
diff --git a/include/hw/remote-port-device.h b/include/hw/remote-port-device.h
new file mode 100644
index 0000000000..9b031e5e87
--- /dev/null
+++ b/include/hw/remote-port-device.h
@@ -0,0 +1,56 @@
+#ifndef REMOTE_PORT_DEVICE_H
+#define REMOTE_PORT_DEVICE_H
+
+#include "qemu/help-texts.h"
+#include "qom/object.h"
+#include "hw/remote-port-proto.h"
+
+#define TYPE_REMOTE_PORT_DEVICE "remote-port-device"
+
+#define REMOTE_PORT_DEVICE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(RemotePortDeviceClass, (klass), TYPE_REMOTE_PORT_DEVICE)
+#define REMOTE_PORT_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RemotePortDeviceClass, (obj), TYPE_REMOTE_PORT_DEVICE)
+#define REMOTE_PORT_DEVICE(obj) \
+     INTERFACE_CHECK(RemotePortDevice, (obj), TYPE_REMOTE_PORT_DEVICE)
+
+typedef struct RemotePort RemotePort;
+
+typedef struct RemotePortDevice {
+    /*< private >*/
+    Object parent_obj;
+} RemotePortDevice;
+
+typedef struct RemotePortDeviceClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    /**
+     * ops - operations to perform when remote port packets are recieved for
+     * this device. Function N will be called for a remote port packet with
+     * cmd == N in the header.
+     *
+     * @obj - Remote port device to recieve packet
+     * @pkt - remote port packets
+     */
+
+    void (*ops[RP_CMD_max+1])(RemotePortDevice *obj, struct rp_pkt *pkt);
+
+} RemotePortDeviceClass;
+
+uint32_t rp_new_id(RemotePort *s);
+/* FIXME: Cleanup and reduce the API complexity for dealing with responses.  */
+void rp_rsp_mutex_lock(RemotePort *s);
+void rp_rsp_mutex_unlock(RemotePort *s);
+void rp_restart_sync_timer(RemotePort *s);
+
+ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
+
+RemotePortDynPkt rp_wait_resp(RemotePort *s);
+
+int64_t rp_normalized_vmclk(RemotePort *s);
+
+struct rp_peer_state *rp_get_peer(RemotePort *s);
+
+#endif
diff --git a/include/hw/remote-port-gpio.h b/include/hw/remote-port-gpio.h
new file mode 100644
index 0000000000..3a0c7c0a6e
--- /dev/null
+++ b/include/hw/remote-port-gpio.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_GPIO_H
+#define REMOTE_PORT_GPIO_H
+
+#define TYPE_REMOTE_PORT_GPIO "remote-port-gpio"
+#define REMOTE_PORT_GPIO(obj) \
+        OBJECT_CHECK(RemotePortGPIO, (obj), TYPE_REMOTE_PORT_GPIO)
+
+#define MAX_GPIOS 960
+
+typedef struct RemotePortGPIO {
+    /* private */
+    SysBusDevice parent;
+    /* public */
+
+    int8_t cache[MAX_GPIOS];
+    uint32_t num_gpios;
+    qemu_irq *gpio_out;
+    uint16_t cell_offset_irq_num;
+
+    bool posted_updates;
+    uint32_t rp_dev;
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+} RemotePortGPIO;
+#endif
diff --git a/include/hw/remote-port-memory-master.h b/include/hw/remote-port-memory-master.h
new file mode 100644
index 0000000000..cbdcd72d29
--- /dev/null
+++ b/include/hw/remote-port-memory-master.h
@@ -0,0 +1,62 @@
+/*
+ * QEMU remote port memory master. Read and write transactions
+ * recieved from QEMU are transmitted over remote-port.
+ *
+ * Copyright (c) 2020 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_MEMORY_MASTER_H
+#define REMOTE_PORT_MEMORY_MASTER_H
+
+#include "hw/remote-port.h"
+#include "hw/misc/xlnx-serbs.h"
+
+#define TYPE_REMOTE_PORT_MEMORY_MASTER "remote-port-memory-master"
+#define REMOTE_PORT_MEMORY_MASTER(obj) \
+        OBJECT_CHECK(RemotePortMemoryMaster, (obj), \
+                     TYPE_REMOTE_PORT_MEMORY_MASTER)
+
+typedef struct RemotePortMemoryMaster RemotePortMemoryMaster;
+
+typedef struct RemotePortMap {
+    void *parent;
+    MemoryRegion iomem;
+    uint32_t rp_dev;
+    uint64_t offset;
+} RemotePortMap;
+
+struct RemotePortMemoryMaster {
+    /* private */
+    SysBusDevice parent;
+
+    MemoryRegionOps *rp_ops;
+    RemotePortMap *mmaps;
+    xlnx_serbs_if *serbsIf;
+
+    /* public */
+    uint32_t map_num;
+    uint64_t map_offset;
+    uint64_t map_size;
+    uint32_t rp_dev;
+    bool relative;
+    uint32_t max_access_size;
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+    int rp_timeout;
+    int serbs_id;
+    bool rp_timeout_err;
+};
+
+MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
+                         struct rp_peer_state *peer,
+                         MemoryTransaction *tr,
+                         bool relative, uint64_t offset);
+
+MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
+                                       struct rp_peer_state *peer,
+                                       MemoryTransaction *tr,
+                                       bool relative, uint64_t offset,
+                                       uint32_t def_attr);
+#endif
diff --git a/include/hw/remote-port-memory-slave.h b/include/hw/remote-port-memory-slave.h
new file mode 100644
index 0000000000..f0b75f90f4
--- /dev/null
+++ b/include/hw/remote-port-memory-slave.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU remote port memory slave. Read and write transactions
+ * recieved from the remote port are translated into an address space.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ * Written by Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_MEMORY_SLAVE_H
+#define REMOTE_PORT_MEMORY_SLAVE_H
+
+#include "hw/remote-port-ats.h"
+
+#define TYPE_REMOTE_PORT_MEMORY_SLAVE "remote-port-memory-slave"
+#define REMOTE_PORT_MEMORY_SLAVE(obj) \
+        OBJECT_CHECK(RemotePortMemorySlave, (obj), \
+                     TYPE_REMOTE_PORT_MEMORY_SLAVE)
+
+typedef struct RemotePortMemorySlave {
+    /* private */
+    SysBusDevice parent;
+    /* public */
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+    MemoryRegion *mr;
+    AddressSpace as;
+    MemTxAttrs attr;
+    RemotePortDynPkt rsp;
+    RemotePortATSCache *ats_cache;
+} RemotePortMemorySlave;
+#endif
diff --git a/include/hw/remote-port-proto.h b/include/hw/remote-port-proto.h
new file mode 100644
index 0000000000..28bf538497
--- /dev/null
+++ b/include/hw/remote-port-proto.h
@@ -0,0 +1,537 @@
+/*
+ * QEMU remote port protocol parts.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#ifndef REMOTE_PORT_PROTO_H__
+#define REMOTE_PORT_PROTO_H__
+
+#include <stdbool.h>
+#include <string.h>
+
+/*
+ * Remote-Port (RP) is an inter-simulator protocol. It assumes a reliable
+ * point to point communcation with the remote simulation environment.
+ *
+ * Setup
+ * In the SETUP phase a mandatory HELLO packet is exchanged with optional
+ * CFG packets following. HELLO packets are useful to ensure that both
+ * sides are speaking the same protocol and using compatible versions.
+ *
+ * CFG packets are used to negotiate configuration options. At the moment
+ * these remain unimplemented.
+ *
+ * Once the session is up, communication can start through various other
+ * commands. The list can be found further down this document.
+ * Commands are carried over RP packets. Every RP packet contains a header
+ * with length, flags and an ID to track potential responses.
+ * The header is followed by a packet specific payload. You'll find the
+ * details of the various commands packet layouts here. Some commands can
+ * carry data/blobs in their payload.
+ */
+
+
+#define RP_VERSION_MAJOR 4
+#define RP_VERSION_MINOR 3
+
+#if defined(_WIN32) && defined(__MINGW32__)
+/* mingw GCC has a bug with packed attributes.  */
+#define PACKED __attribute__ ((gcc_struct, packed))
+#else
+#define PACKED __attribute__ ((packed))
+#endif
+
+/* Could be auto generated.  */
+enum rp_cmd {
+    RP_CMD_nop         = 0,
+    RP_CMD_hello       = 1,
+    RP_CMD_cfg         = 2,
+    RP_CMD_read        = 3,
+    RP_CMD_write       = 4,
+    RP_CMD_interrupt   = 5,
+    RP_CMD_sync        = 6,
+    RP_CMD_ats_req     = 7,
+    RP_CMD_ats_inv     = 8,
+    RP_CMD_max         = 8
+};
+
+enum {
+    RP_OPT_quantum = 0,
+};
+
+struct rp_cfg_state {
+    uint64_t quantum;
+};
+
+enum {
+    RP_PKT_FLAGS_optional      = 1 << 0,
+    RP_PKT_FLAGS_response      = 1 << 1,
+
+    /* Posted hint.
+     * When set this means that the receiver is not required to respond to
+     * the message. Since it's just a hint, the sender must be prepared to
+     * drop responses. Note that since flags are echoed back in responses
+     * a response to a posted packet will be easy to identify early in the
+     * protocol stack.
+     */
+    RP_PKT_FLAGS_posted        = 1 << 2,
+};
+
+struct rp_pkt_hdr {
+    uint32_t cmd;
+    uint32_t len;
+    uint32_t id;
+    uint32_t flags;
+    uint32_t dev;
+} PACKED;
+
+struct rp_pkt_cfg {
+    struct rp_pkt_hdr hdr;
+    uint32_t opt;
+    uint8_t set;
+} PACKED;
+
+struct rp_version {
+    uint16_t major;
+    uint16_t minor;
+} PACKED;
+
+struct rp_capabilities {
+    /* Offset from start of packet.  */
+    uint32_t offset;
+    uint16_t len;
+    uint16_t reserved0;
+} PACKED;
+
+enum {
+    CAP_BUSACCESS_EXT_BASE = 1,    /* New header layout. */
+    CAP_BUSACCESS_EXT_BYTE_EN = 2, /* Support for Byte Enables.  */
+
+    /*
+     * Originally, all interrupt/wire updates over remote-port were posted.
+     * This turned out to be a bad idea. To fix it without breaking backwards
+     * compatibility, we add the WIRE Posted updates capability.
+     *
+     * If the peer supportes this, it will respect the RP_PKT_FLAGS_posted
+     * flag. If the peer doesn't support this capability, senders need to
+     * be aware that the peer will not respond to wire updates regardless
+     * of the posted header-flag.
+     */
+    CAP_WIRE_POSTED_UPDATES = 3,
+
+    CAP_ATS = 4, /* Address translation services */
+};
+
+struct rp_pkt_hello {
+    struct rp_pkt_hdr hdr;
+    struct rp_version version;
+    struct rp_capabilities caps;
+} PACKED;
+
+enum {
+    /* Remote port responses. */
+    RP_RESP_OK                  =  0x0,
+    RP_RESP_BUS_GENERIC_ERROR   =  0x1,
+    RP_RESP_ADDR_ERROR          =  0x2,
+    RP_RESP_MAX                 =  0xF,
+};
+
+enum {
+    RP_BUS_ATTR_EOP        =  (1 << 0),
+    RP_BUS_ATTR_SECURE     =  (1 << 1),
+    RP_BUS_ATTR_EXT_BASE   =  (1 << 2),
+    RP_BUS_ATTR_PHYS_ADDR  =  (1 << 3),
+
+    /*
+     * The access targets the I/O address space.
+     */
+    RP_BUS_ATTR_IO_ACCESS  =  (1 << 4),
+
+    /*
+     * Bits [11:8] are allocated for storing transaction response codes.
+     * These new response codes are backward compatible as existing
+     * implementations will not set/read these bits.
+     * For existing implementations, these bits will be zero which is RESP_OKAY.
+     */
+    RP_BUS_RESP_SHIFT      =  8,
+    RP_BUS_RESP_MASK       =  (RP_RESP_MAX << RP_BUS_RESP_SHIFT),
+};
+
+struct rp_pkt_busaccess {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t attributes;
+    uint64_t addr;
+
+    /* Length in bytes.  */
+    uint32_t len;
+
+    /* Width of each beat in bytes. Set to zero for unknown (let the remote
+       side choose).  */
+    uint32_t width;
+
+    /* Width of streaming, must be a multiple of width.
+       addr should repeat itself around this width. Set to same as len
+       for incremental (normal) accesses.  In bytes.  */
+    uint32_t stream_width;
+
+    /* Implementation specific source or master-id.  */
+    uint16_t master_id;
+} PACKED;
+
+
+/* This is the new extended busaccess packet layout.  */
+struct rp_pkt_busaccess_ext_base {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t attributes;
+    uint64_t addr;
+
+    /* Length in bytes.  */
+    uint32_t len;
+
+    /* Width of each beat in bytes. Set to zero for unknown (let the remote
+       side choose).  */
+    uint32_t width;
+
+    /* Width of streaming, must be a multiple of width.
+       addr should repeat itself around this width. Set to same as len
+       for incremental (normal) accesses.  In bytes.  */
+    uint32_t stream_width;
+
+    /* Implementation specific source or master-id.  */
+    uint16_t master_id;
+    /* ---- End of 4.0 base busaccess. ---- */
+
+    uint16_t master_id_31_16;   /* MasterID bits [31:16].  */
+    uint32_t master_id_63_32;   /* MasterID bits [63:32].  */
+    /* ---------------------------------------------------
+     * Since hdr is 5 x 32bit, we are now 64bit aligned.  */
+
+    uint32_t data_offset;       /* Offset to data from start of pkt.  */
+    uint32_t next_offset;       /* Offset to next extension. 0 if none.  */
+
+    uint32_t byte_enable_offset;
+    uint32_t byte_enable_len;
+
+    /* ---- End of CAP_BUSACCESS_EXT_BASE. ---- */
+
+    /* If new features are needed that may always occupy space
+     * in the header, then add a new capability and extend the
+     * this area with new fields.
+     * Will help receivers find data_offset and next offset,
+     * even those that don't know about extended fields.
+     */
+} PACKED;
+
+struct rp_pkt_interrupt {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t vector;
+    uint32_t line;
+    uint8_t val;
+} PACKED;
+
+struct rp_pkt_sync {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+} PACKED;
+
+enum {
+    RP_ATS_ATTR_exec     = 1 << 0,
+    RP_ATS_ATTR_read     = 1 << 1,
+    RP_ATS_ATTR_write    = 1 << 2,
+};
+
+enum {
+    RP_ATS_RESULT_ok = 0,
+    RP_ATS_RESULT_error = 1,
+};
+
+struct rp_pkt_ats {
+    struct rp_pkt_hdr hdr;
+    uint64_t timestamp;
+    uint64_t attributes;
+    uint64_t addr;
+    uint64_t len;
+    uint32_t result;
+    uint64_t reserved0;
+    uint64_t reserved1;
+    uint64_t reserved2;
+    uint64_t reserved3;
+} PACKED;
+
+struct rp_pkt {
+    union {
+        struct rp_pkt_hdr hdr;
+        struct rp_pkt_hello hello;
+        struct rp_pkt_busaccess busaccess;
+        struct rp_pkt_busaccess_ext_base busaccess_ext_base;
+        struct rp_pkt_interrupt interrupt;
+        struct rp_pkt_sync sync;
+        struct rp_pkt_ats ats;
+    };
+};
+
+struct rp_peer_state {
+    void *opaque;
+
+    struct rp_pkt pkt;
+    bool hdr_used;
+
+    struct rp_version version;
+
+    struct {
+        bool busaccess_ext_base;
+        bool busaccess_ext_byte_en;
+        bool wire_posted_updates;
+        bool ats;
+    } caps;
+
+    /* Used to normalize our clk.  */
+    int64_t clk_base;
+
+    struct rp_cfg_state local_cfg;
+    struct rp_cfg_state peer_cfg;
+};
+
+const char *rp_cmd_to_string(enum rp_cmd cmd);
+int rp_decode_hdr(struct rp_pkt *pkt);
+int rp_decode_payload(struct rp_pkt *pkt);
+
+void rp_encode_hdr(struct rp_pkt_hdr *hdr,
+                   uint32_t cmd, uint32_t id, uint32_t dev, uint32_t len,
+                   uint32_t flags);
+
+/*
+ * caps is a an array of supported capabilities by the implementor.
+ * caps_out is the encoded (network byte order) version of the
+ * same array. It should be sent to the peer after the hello packet.
+ */
+size_t rp_encode_hello_caps(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                            uint16_t version_major, uint16_t version_minor,
+                            uint32_t *caps, uint32_t *features_out,
+                            uint32_t features_len);
+
+/* rp_encode_hello is deprecated in favor of hello_caps.  */
+static inline size_t __attribute__ ((deprecated))
+rp_encode_hello(uint32_t id, uint32_t dev, struct rp_pkt_hello *pkt,
+                uint16_t version_major, uint16_t version_minor) {
+    return rp_encode_hello_caps(id, dev, pkt, version_major, version_minor,
+                                NULL, NULL, 0);
+}
+
+static inline void *__attribute__ ((deprecated))
+rp_busaccess_dataptr(struct rp_pkt_busaccess *pkt)
+{
+    /* Right after the packet.  */
+    return pkt + 1;
+}
+
+/*
+ * rp_busaccess_rx_dataptr
+ *
+ * Predicts the dataptr for a packet to be transmitted.
+ * This should only be used if you are trying to keep
+ * the entire packet in a linear buffer.
+ */
+static inline unsigned char *
+rp_busaccess_tx_dataptr(struct rp_peer_state *peer,
+                        struct rp_pkt_busaccess_ext_base *pkt)
+{
+    unsigned char *p = (unsigned char *) pkt;
+
+    if (peer->caps.busaccess_ext_base) {
+        /* We always put our data right after the header.  */
+        return p + sizeof *pkt;
+    } else {
+        /* Right after the old packet layout.  */
+        return p + sizeof(struct rp_pkt_busaccess);
+    }
+}
+
+/*
+ * rp_busaccess_rx_dataptr
+ *
+ * Extracts the dataptr from a received packet.
+ */
+static inline unsigned char *
+rp_busaccess_rx_dataptr(struct rp_peer_state *peer,
+                        struct rp_pkt_busaccess_ext_base *pkt)
+{
+    unsigned char *p = (unsigned char *) pkt;
+
+    if (pkt->attributes & RP_BUS_ATTR_EXT_BASE) {
+        return p + pkt->data_offset;
+    } else {
+        /* Right after the old packet layout.  */
+        return p + sizeof(struct rp_pkt_busaccess);
+    }
+}
+
+static inline unsigned char *
+rp_busaccess_byte_en_ptr(struct rp_peer_state *peer,
+                         struct rp_pkt_busaccess_ext_base *pkt)
+{
+    unsigned char *p = (unsigned char *) pkt;
+
+    if ((pkt->attributes & RP_BUS_ATTR_EXT_BASE)
+        && pkt->byte_enable_len) {
+        assert(pkt->byte_enable_offset >= sizeof *pkt);
+        assert(pkt->byte_enable_offset + pkt->byte_enable_len
+               <= pkt->hdr.len + sizeof pkt->hdr);
+        return p + pkt->byte_enable_offset;
+    }
+    return NULL;
+}
+
+size_t __attribute__ ((deprecated))
+rp_encode_read(uint32_t id, uint32_t dev,
+               struct rp_pkt_busaccess *pkt,
+               int64_t clk, uint16_t master_id,
+               uint64_t addr, uint64_t attr, uint32_t size,
+               uint32_t width, uint32_t stream_width);
+
+size_t __attribute__ ((deprecated))
+rp_encode_read_resp(uint32_t id, uint32_t dev,
+                    struct rp_pkt_busaccess *pkt,
+                    int64_t clk, uint16_t master_id,
+                    uint64_t addr, uint64_t attr, uint32_t size,
+                    uint32_t width, uint32_t stream_width);
+
+size_t __attribute__ ((deprecated))
+rp_encode_write(uint32_t id, uint32_t dev,
+                struct rp_pkt_busaccess *pkt,
+                int64_t clk, uint16_t master_id,
+                uint64_t addr, uint64_t attr, uint32_t size,
+                uint32_t width, uint32_t stream_width);
+
+size_t __attribute__ ((deprecated))
+rp_encode_write_resp(uint32_t id, uint32_t dev,
+                     struct rp_pkt_busaccess *pkt,
+                     int64_t clk, uint16_t master_id,
+                     uint64_t addr, uint64_t attr, uint32_t size,
+                     uint32_t width, uint32_t stream_width);
+
+struct rp_encode_busaccess_in {
+    uint32_t cmd;
+    uint32_t id;
+    uint32_t flags;
+    uint32_t dev;
+    int64_t clk;
+    uint64_t master_id;
+    uint64_t addr;
+    uint64_t attr;
+    uint32_t size;
+    uint32_t width;
+    uint32_t stream_width;
+    uint32_t byte_enable_len;
+};
+
+/* Prepare encode_busaccess input parameters for a packet response.  */
+static inline void
+rp_encode_busaccess_in_rsp_init(struct rp_encode_busaccess_in *in,
+                                struct rp_pkt *pkt) {
+    memset(in, 0, sizeof *in);
+    in->cmd = pkt->hdr.cmd;
+    in->id = pkt->hdr.id;
+    in->flags = pkt->hdr.flags | RP_PKT_FLAGS_response;
+    in->dev = pkt->hdr.dev;
+    /* FIXME: Propagate all master_id fields?  */
+    in->master_id = pkt->busaccess.master_id;
+    in->addr = pkt->busaccess.addr;
+    in->size = pkt->busaccess.len;
+    in->width = pkt->busaccess.width;
+    in->stream_width = pkt->busaccess.stream_width;
+    in->byte_enable_len = 0;
+}
+size_t rp_encode_busaccess(struct rp_peer_state *peer,
+                           struct rp_pkt_busaccess_ext_base *pkt,
+                           struct rp_encode_busaccess_in *in);
+
+size_t rp_encode_interrupt_f(uint32_t id, uint32_t dev,
+                             struct rp_pkt_interrupt *pkt,
+                             int64_t clk,
+                             uint32_t line, uint64_t vector, uint8_t val,
+                             uint32_t flags);
+
+size_t rp_encode_interrupt(uint32_t id, uint32_t dev,
+                           struct rp_pkt_interrupt *pkt,
+                           int64_t clk,
+                           uint32_t line, uint64_t vector, uint8_t val);
+
+size_t rp_encode_sync(uint32_t id, uint32_t dev,
+                      struct rp_pkt_sync *pkt,
+                      int64_t clk);
+
+size_t rp_encode_sync_resp(uint32_t id, uint32_t dev,
+                           struct rp_pkt_sync *pkt,
+                           int64_t clk);
+
+size_t rp_encode_ats_req(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t size, uint64_t result, uint32_t flags);
+
+size_t rp_encode_ats_inv(uint32_t id, uint32_t dev,
+                         struct rp_pkt_ats *pkt,
+                         int64_t clk, uint64_t attr, uint64_t addr,
+                         uint64_t size, uint64_t result, uint32_t flags);
+
+void rp_process_caps(struct rp_peer_state *peer,
+                     void *caps, size_t caps_len);
+
+/* Dynamically resizable remote port pkt.  */
+
+typedef struct RemotePortDynPkt {
+    struct rp_pkt *pkt;
+    size_t size;
+} RemotePortDynPkt;
+
+/*
+ * Make sure dpkt is allocated and has enough room.
+ */
+
+void rp_dpkt_alloc(RemotePortDynPkt *dpkt, size_t size);
+
+void rp_dpkt_swap(RemotePortDynPkt *a, RemotePortDynPkt *b);
+
+/*
+ * Check if the dpkt is valid. Used for debugging purposes.
+ */
+
+bool rp_dpkt_is_valid(RemotePortDynPkt *dpkt);
+
+/*
+ * Invalidate the dpkt. Used for debugging purposes.
+ */
+
+void rp_dpkt_invalidate(RemotePortDynPkt *dpkt);
+
+void rp_dpkt_free(RemotePortDynPkt *dpkt);
+
+static inline int rp_get_busaccess_response(struct rp_pkt *pkt)
+{
+    return (pkt->busaccess_ext_base.attributes & RP_BUS_RESP_MASK) >>
+                                                            RP_BUS_RESP_SHIFT;
+}
+#endif
diff --git a/include/hw/remote-port.h b/include/hw/remote-port.h
new file mode 100644
index 0000000000..ad90233a60
--- /dev/null
+++ b/include/hw/remote-port.h
@@ -0,0 +1,149 @@
+/*
+ * QEMU remote port.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_H__
+#define REMOTE_PORT_H__
+
+#include <stdbool.h>
+#include "hw/remote-port-proto.h"
+#include "hw/remote-port-device.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "hw/ptimer.h"
+#include "qobject/qdict.h"
+
+#define TYPE_REMOTE_PORT "remote-port"
+#define REMOTE_PORT(obj) OBJECT_CHECK(RemotePort, (obj), TYPE_REMOTE_PORT)
+
+typedef struct RemotePortRespSlot {
+            RemotePortDynPkt rsp;
+            uint32_t id;
+            bool used;
+            bool valid;
+} RemotePortRespSlot;
+
+struct RemotePort {
+    DeviceState parent;
+
+    QemuThread thread;
+    union {
+       int pipes[2];
+       struct {
+           int read;
+           int write;
+       } pipe;
+    } event;
+    Chardev *chrdev;
+    CharFrontend chr;
+    bool do_sync;
+    bool doing_sync;
+    bool finalizing;
+    /* To serialize writes to fd.  */
+    QemuMutex write_mutex;
+
+    char *chardesc;
+    char *chrdev_id;
+    struct rp_peer_state peer;
+
+    struct {
+        ptimer_state *ptimer;
+        ptimer_state *ptimer_resp;
+        bool resp_timer_enabled;
+        bool need_sync;
+        struct rp_pkt rsp;
+        uint64_t quantum;
+    } sync;
+
+    QemuMutex rsp_mutex;
+    QemuCond progress_cond;
+
+#define RX_QUEUE_SIZE 1024
+    struct {
+        /* This array must be sized minimum 2 and always a power of 2.  */
+        RemotePortDynPkt pkt[RX_QUEUE_SIZE];
+        bool inuse[RX_QUEUE_SIZE];
+        QemuSemaphore sem;
+        unsigned int wpos;
+        unsigned int rpos;
+    } rx_queue;
+
+    /*
+     * rsp holds responses for the remote side.
+     * Used by the slave.
+     */
+    RemotePortDynPkt rsp;
+
+    /*
+     * rspqueue holds received responses from the remote side.
+     * Only one for the moment but it might grow.
+     * Used by the master.
+     */
+    RemotePortDynPkt rspqueue;
+
+    bool resets[32];
+
+    const char *prefix;
+    const char *remote_prefix;
+
+    uint32_t current_id;
+    bool reset_done;
+
+#define REMOTE_PORT_MAX_DEVS 1024
+#define RP_MAX_OUTSTANDING_TRANSACTIONS 32
+    struct {
+        RemotePortRespSlot rsp_queue[RP_MAX_OUTSTANDING_TRANSACTIONS];
+    } dev_state[REMOTE_PORT_MAX_DEVS];
+
+    RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
+};
+
+/**
+ * rp_device_attach:
+ * @adaptor: The adaptor onto which to attach the device
+ * @dev: The device to be attached to the adaptor
+ * @rp_nr: The remote-port adaptor nr. A device may attach to multiple
+ *         adaptors.
+ * @dev_nr: The device/channel number to bind the device to.
+ * @errp: returns an error if this function fails
+ *
+ * Attaches a device onto an adaptor and binds it to a device number.
+ */
+void rp_device_attach(Object *adaptor, Object *dev,
+                      int rp_nr, int dev_nr,
+                      Error **errp);
+void rp_device_detach(Object *adaptor, Object *dev,
+                      int rp_nr, int dev_nr,
+                      Error **errp);
+bool rp_time_warp_enable(bool en);
+
+/**
+ * rp_device_add
+ * @opts:  qdev opts created by the qdev subsystem
+ * @dev: The device to be connected
+ * @errp: Returns an error if the function fails
+ *
+ * Function used in qdev-monitor.c to connect remote port devices.
+ * Returns teue on success and false on failure.
+ */
+bool rp_device_add(const QDict *opts, DeviceState *dev, Error **errp);
+
+static inline void rp_resp_slot_done(RemotePort *s,
+                                     RemotePortRespSlot *rsp_slot)
+{
+    rp_dpkt_invalidate(&rsp_slot->rsp);
+    rsp_slot->id = ~0;
+    rsp_slot->used = false;
+    rsp_slot->valid = false;
+}
+
+RemotePortRespSlot *rp_dev_wait_resp(RemotePort *s, uint32_t dev, uint32_t id);
+RemotePortRespSlot *rp_dev_timed_wait_resp(RemotePort *s, uint32_t dev,
+                                           uint32_t id, int timems);
+void rp_process(RemotePort *s);
+
+#endif
diff --git a/include/system/dma.h b/include/system/dma.h
index 82e7ad5437..811ff32d69 100644
--- a/include/system/dma.h
+++ b/include/system/dma.h
@@ -88,6 +88,15 @@ static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
                             buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
 }
 
+static inline MemTxResult dma_memory_rw_relaxed_attr(AddressSpace *as,
+                                             dma_addr_t addr, void *buf,
+                                             dma_addr_t len, DMADirection dir,
+                                             MemTxAttrs attr)
+{
+    return address_space_rw(as, addr, attr,
+                            buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
+}
+
 static inline MemTxResult dma_memory_read_relaxed(AddressSpace *as,
                                                   dma_addr_t addr,
                                                   void *buf, dma_addr_t len)
@@ -107,6 +116,16 @@ static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
                                  MEMTXATTRS_UNSPECIFIED);
 }
 
+static inline MemTxResult dma_memory_rw_attr(AddressSpace *as, dma_addr_t addr,
+                                             void *buf, dma_addr_t len,
+                                             DMADirection dir,
+                                             MemTxAttrs attr)
+{
+    dma_barrier(as, dir);
+
+    return dma_memory_rw_relaxed_attr(as, addr, buf, len, dir, attr);
+}
+
 /**
  * dma_memory_rw: Read from or write to an address space from DMA controller.
  *
diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0..bcfeb624d8 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -27,6 +27,7 @@
 #include "qom/object.h"
 #include "qemu/rcu.h"
 
+extern const char *machine_path;
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
 #define MAX_PHYS_ADDR_SPACE_BITS 62
@@ -36,6 +37,11 @@
 DECLARE_INSTANCE_CHECKER(MemoryRegion, MEMORY_REGION,
                          TYPE_MEMORY_REGION)
 
+#define TYPE_MEMORY_TRANSACTION_ATTR "memory-transaction-attr"
+#define MEMORY_TRANSACTION_ATTR(obj) \
+        OBJECT_CHECK(MemTxAttrs, (obj), TYPE_MEMORY_TRANSACTION_ATTR)
+
+
 #define TYPE_IOMMU_MEMORY_REGION "iommu-memory-region"
 typedef struct IOMMUMemoryRegionClass IOMMUMemoryRegionClass;
 DECLARE_OBJ_CHECKERS(IOMMUMemoryRegion, IOMMUMemoryRegionClass,
@@ -77,6 +83,29 @@ extern unsigned int global_dirty_tracking;
 
 typedef struct MemoryRegionOps MemoryRegionOps;
 
+typedef struct MemoryTransaction
+{
+    union {
+        /*
+         * Data is passed by values up to 64bit sizes. Beyond
+         * that, a pointer is passed in p8.
+         *
+         * Note that p8 has no alignment restrictions.
+         */
+        uint8_t *p8;
+        uint64_t u64;
+        uint32_t u32;
+        uint16_t u16;
+        uint8_t  u8;
+    } data;
+    bool rw;
+    hwaddr addr;
+    unsigned int size;
+    MemTxAttrs attr;
+    void *opaque;
+} MemoryTransaction;
+
+
 struct ReservedRegion {
     Range range;
     unsigned type;
@@ -291,6 +320,8 @@ static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
  * Memory region callbacks
  */
 struct MemoryRegionOps {
+        /* FIXME: Remove */
+    MemTxResult (*access)(MemoryTransaction *tr);
     /* Read from the memory region. @addr is relative to @mr; @size is
      * in bytes. */
     uint64_t (*read)(void *opaque,
@@ -428,6 +459,9 @@ struct IOMMUMemoryRegionClass {
      */
     IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
                                IOMMUAccessFlags flag, int iommu_idx);
+    IOMMUTLBEntry (*translate_attr)(IOMMUMemoryRegion *iommu, hwaddr addr,
+                                    bool is_write, MemTxAttrs *attr);
+    
     /**
      * @get_min_page_size:
      *
@@ -2724,6 +2758,10 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
  */
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
 
+
+/* Remove this */
+AddressSpace *address_space_init_shareable(MemoryRegion *root,
+    const char *name);
 /**
  * address_space_destroy: destroy an address space
  *
@@ -3030,6 +3068,18 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
                               addr, xlat, len, is_write, attrs);
 }
 
+MemoryRegion *ats_do_translate(AddressSpace *as,
+    hwaddr addr,
+    hwaddr *xlat,
+    hwaddr *plen_out,
+    AddressSpace **target_as,
+    int *prot,
+    MemTxAttrs attrs);
+
+MemoryRegion *address_space_translate_attr(AddressSpace *as, hwaddr addr,
+           hwaddr *xlat, hwaddr *plen,
+           bool is_write, MemTxAttrs *attr);
+
 /* address_space_access_valid: check for validity of accessing an address
  * space range
  *
diff --git a/include/system/system.h b/include/system/system.h
index 03a2d0e900..1bc17e94f3 100644
--- a/include/system/system.h
+++ b/include/system/system.h
@@ -57,6 +57,8 @@ bool is_mlock_on_fault(MlockState);
 
 extern MlockState mlock_state;
 
+extern uint64_t global_sync_quantum;
+
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
     const char *name;
diff --git a/qemu-options.hx b/qemu-options.hx
index 10567c5c45..82e45207b3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -763,6 +763,27 @@ SRST
     Preallocate memory when using -mem-path.
 ERST
 
+DEF("sync-quantum", HAS_ARG, QEMU_OPTION_sync_quantum,
+    "-sync-quantum Max time between synchroniation, nanoseconds.\n",
+    QEMU_ARCH_ALL)
+SRST
+``-sync-quantum val``
+    Maximum time between synchronization <val>.
+    This value is used to drive periodic synchronization with remote port peers.
+    It is also used to set device models sync-quantum properties controlling
+    the maximum amount of ahead of time simulation that is prefered (only a hint).
+ERST
+
+DEF("machine-path", HAS_ARG, QEMU_OPTION_machine_path,
+    "-machine-path DIR A directory in which to create machine nodes\n",
+    QEMU_ARCH_ALL)
+SRST
+``-machine-path path``
+    Selects the machine path.
+    Multi-arch machine nodes will be created in <path>.
+    This option also sets -mem-shared-path to the given path.
+ERST
+
 DEF("k", HAS_ARG, QEMU_OPTION_k,
     "-k language     use keyboard layout (for example 'fr' for French)\n",
     QEMU_ARCH_ALL)
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..0323352242 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -528,6 +528,63 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
     return *section;
 }
 
+/* This function is called from RCU critical section */
+MemoryRegion *ats_do_translate(AddressSpace *as,
+                               hwaddr addr,
+                               hwaddr *xlat,
+                               hwaddr *plen_out,
+                               AddressSpace **target_as,
+                               int *prot,
+                               MemTxAttrs attrs)
+{
+    MemoryRegionSection *section;
+    IOMMUMemoryRegion *iommu_mr;
+    hwaddr plen = (hwaddr)(-1);
+    FlatView *fv = address_space_to_flatview(as);
+    IOMMUMemoryRegionClass *imrc;
+    IOMMUTLBEntry iotlb;
+    int iommu_idx = 0;
+
+    if (!plen_out) {
+        plen_out = &plen;
+    }
+
+    /* This can be MMIO, so setup MMIO bit. */
+    section = address_space_translate_internal(
+            flatview_to_dispatch(fv), addr, xlat,
+            plen_out, true);
+
+    /* Illegal translation */
+    if (section->mr == &io_mem_unassigned) {
+        return NULL;
+    }
+
+    iommu_mr = memory_region_get_iommu(section->mr);
+    if (!iommu_mr) {
+        return NULL;
+    }
+
+    imrc = memory_region_get_iommu_class_nocheck(iommu_mr);
+
+    if (imrc->attrs_to_index) {
+        iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
+    }
+
+    if (imrc->translate_attr) {
+        iotlb = imrc->translate_attr(iommu_mr, addr, false, &attrs);
+    } else {
+        iotlb = imrc->translate(iommu_mr, addr, IOMMU_RO, iommu_idx);
+    }
+
+    *xlat = ((iotlb.translated_addr & ~iotlb.addr_mask)
+            | (addr & iotlb.addr_mask));
+    *plen_out = MIN(*plen_out, (addr | iotlb.addr_mask) - addr + 1);
+    *prot = iotlb.perm;
+    *target_as = iotlb.target_as;
+
+    return section->mr;
+}
+
 /* Called from RCU critical section */
 IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
                                             bool is_write, MemTxAttrs attrs)
diff --git a/system/vl.c b/system/vl.c
index c18306e914..76d08d2078 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -183,6 +183,8 @@ static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 static bool nographic = false;
 static int mem_prealloc; /* force preallocation of physical target memory */
+uint64_t global_sync_quantum = 0;
+const char *machine_path = NULL;
 static const char *vga_model = NULL;
 static DisplayOptions dpy;
 static int num_serial_hds;
@@ -3129,6 +3131,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_mem_prealloc:
                 mem_prealloc = 1;
                 break;
+            case QEMU_OPTION_sync_quantum:
+                global_sync_quantum = strtoull(optarg, (char **) &optarg, 10);
+                break;
             case QEMU_OPTION_d:
                 log_mask = optarg;
                 break;
-- 
2.43.0


