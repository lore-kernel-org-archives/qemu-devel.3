Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4362FD637B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVe8c-0001j5-LG; Tue, 16 Dec 2025 18:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vVd4O-0004jW-Uy
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:59:01 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vVd4J-0006b2-U9
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 16:59:00 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so10138844a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 13:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765922334; x=1766527134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEOAi+E+RsrXy3+DewpltEC8elA5fEd6cmGhrcTCr4c=;
 b=h3W3nfpcf6Gp7BEie0fJLP9w2XW0NTkRbrzvNWytwW4Ha5fqooz8qJkFOFYDQ3XOmw
 OcXigjZo0D8x8VmVXplPdDzeN/q6hv2HvAt113NSqZ432Sx0ObvtZ2cjuoStu7mTOx02
 JMB6VYJt+TyQ7Ozj6K9JQaKsMbSlx+8Jo7mEIDHBpdvgom241w0LNujduiosRcx6BDzg
 Omxbltl3QnW6Tap1m7L0RcUv5yf33DKI9312vzEKHR0XJMj7B/m5dnvskRsi05Q9V78Q
 wn5WbbiaVayqCce2hM3VmNQUjnhgTfqpcP8HBJmxAJ8hV6Ia/q+avavumlrb2fA0kX0J
 vh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922334; x=1766527134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SEOAi+E+RsrXy3+DewpltEC8elA5fEd6cmGhrcTCr4c=;
 b=HoO6CSGCt5Nw1AwfJJImEOxoZz1/dVatk4+Pq1zwNWodDOYYA35H9IE+6uRGWD5F75
 lUxlgMO06SADEa4pC3amL2G1l3iqbCNPsi83K5hV3usg5y8W3jJbr9EGoJJm9l7Uy0LZ
 BPTW2JwVqDvgSsyP8bhvrMCkdJAfYbo+RTAEaEbpw9bZ6tYzDHn2LFAjAyLk+q5/3Xtp
 uuQMopkPkwMqxIaxU9i68gpGrc9VwoPAwvmnpfIaBymPO+3uwnEt0r7xO4uhe9+ICZKf
 DnUtL663HUOzjj3BcBIce5k2+BYkGKZOqhQGEC6JGgJB2Tsrr4Cx33KTehnE+azc5zO5
 F2yA==
X-Gm-Message-State: AOJu0Yzq6ZPCSwz03ASHJkL119pF/VxXkVC7wIahx0u4i1k9vJt9jeL8
 dzPvgpiT/zbdsdmTKkMy0OoF8eCGaQsVNnlGcVgolVvRQ4rDp58aab0sRd5CgeYY
X-Gm-Gg: AY/fxX7HNGnmPTtxzO/5Q5IcDm2tCOTsKq80gqCTvvYy9DVb+RX6Zwr4yQ7Ktvv45UR
 D+5S3K3cypnsTr59DQHUfdaDF7ySBmqlMjmLcTN3iAzRSDtkbAxwW7+4jmcZoTzBTxa9w35aj1X
 nqaw88WouNapufVPMPhuMCUOrIlBtihkR/7EHlsT8Eko3vwSrILW18nhtxeYx0WNJdaE3eLt7wh
 gjCR9x75m/R0hKdRpkabI6h9/S8rYiIDT/rNwD+8aSemcVSJiz1p1d8JSNJi6UCHGamU0qJTRfC
 2nr5G9/0ni1eg3EYIcG7ylwSO1GQZp+v1duY77o0OSVwOvisVJwp93jE337/97WnNCn/ypdI9Bz
 uQHzqx4rCtK7WCJuLv2/4k5+BHDfMabWjxfbHeFGh6aKGjMcBoUVQvh9w4OF6ffJNSEc2cl4pxs
 dtr8nyoDi5Ctlk3EPO58j7dOwgHewu0BN/tM65yMafQYkgb6bKX2zWuxNLR7mwvQ==
X-Google-Smtp-Source: AGHT+IHyhzrBvzOUaORfWxEKm+xEAsScvyub5V1qaMSNcgAp0ablwcGtQ3xUsaiPxGY2GvmaLxNbqg==
X-Received: by 2002:a17:907:9411:b0:b76:74b6:dbf8 with SMTP id
 a640c23a62f3a-b7d236af43amr1709594666b.14.1765922332801; 
 Tue, 16 Dec 2025 13:58:52 -0800 (PST)
Received: from thinkpad-t470s.. (93-140-170-188.adsl.net.t-com.hr.
 [93.140.170.188]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b7fe8a956a5sm420898166b.29.2025.12.16.13.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:58:52 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: Ruslan_Ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 edgar.iglesias@amd.com, peter.maydell@linaro.org,
 volodymyr_babchuk@epam.com, artem_mygaiev@epam.com
Subject: [PATCH RFC 1/2] hw/core: Add support for loading a Hardware Device
 Tree
Date: Tue, 16 Dec 2025 22:58:34 +0100
Message-ID: <20251216215835.208036-2-Ruslan_Ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216215835.208036-1-Ruslan_Ruslichenko@epam.com>
References: <20251216215835.208036-1-Ruslan_Ruslichenko@epam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52d.google.com
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

This feature allows QEMU to dynamically instantiate
hardware model, instead of relying on static configs.

Key changes:

- Added a new global option '-hw-dtb' to the QEMU
  command-line parser.
- Implemented logic in the fdt-generic to parse this
  DTB and dynamically instantiate devices,
  memory regions, and interrupts based on the node
  definitions.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 blockdev.c                       |   12 +
 hw/arm/boot.c                    |    8 +-
 hw/arm/raspi4b.c                 |    4 +-
 hw/arm/vexpress.c                |    4 +-
 hw/arm/xlnx-zcu102.c             |    3 +-
 hw/core/fdt_generic.c            |  283 +++++
 hw/core/fdt_generic_devices.c    |  130 +++
 hw/core/fdt_generic_util.c       | 1883 ++++++++++++++++++++++++++++++
 hw/core/machine.c                |   19 +
 hw/core/meson.build              |    3 +
 include/hw/boards.h              |    1 +
 include/hw/fdt_generic.h         |  126 ++
 include/hw/fdt_generic_devices.h |   22 +
 include/hw/fdt_generic_util.h    |  283 +++++
 include/hw/qdev-properties.h     |    1 +
 include/net/net.h                |    4 +
 include/qemu/log.h               |    3 +
 include/system/blockdev.h        |    2 +
 include/system/device_tree.h     |  101 +-
 net/net.c                        |    4 +-
 qemu-options.hx                  |    9 +
 system/device_tree.c             |  377 +++++-
 system/globals.c                 |    2 +
 system/vl.c                      |    3 +
 24 files changed, 3248 insertions(+), 39 deletions(-)
 create mode 100644 hw/core/fdt_generic.c
 create mode 100644 hw/core/fdt_generic_devices.c
 create mode 100644 hw/core/fdt_generic_util.c
 create mode 100644 include/hw/fdt_generic.h
 create mode 100644 include/hw/fdt_generic_devices.h
 create mode 100644 include/hw/fdt_generic_util.h

diff --git a/blockdev.c b/blockdev.c
index dbd1d4d3e8..fb97951149 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -306,6 +306,18 @@ int drive_get_max_bus(BlockInterfaceType type)
     return max_bus;
 }
 
+/* Xilinx: keep for fdt_generic */
+/* Get a block device.  This should only be used for single-drive devices
+ * (e.g. SD/Floppy/MTD).  Multi-disk devices (scsi/ide) should use the
+ *  appropriate bus.
+ */
+DriveInfo *drive_get_next(BlockInterfaceType type)
+{
+    static int next_block_unit[IF_COUNT];
+   
+    return drive_get(type, 0, next_block_unit[type]++);
+}
+
 static void bdrv_format_print(void *opaque, const char *name)
 {
     qemu_printf(" %s", name);
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index b91660208f..a2125efc7f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -509,10 +509,10 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         return 0;
     }
 
-    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
-                                   NULL, &error_fatal);
-    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
-                                   NULL, &error_fatal);
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells", 0,
+                                   false, &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells", 0,
+                                   false, &error_fatal);
     if (acells == 0 || scells == 0) {
         fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
         goto fail;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 0422ae0f00..c06dc88d1b 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -42,9 +42,9 @@ static void raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
     uint32_t acells, scells;
     char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
 
-    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells", 0,
                                    NULL, &error_fatal);
-    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells", 0,
                                    NULL, &error_fatal);
     /* validated by arm_load_dtb */
     g_assert(acells && scells);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 3492e03a65..e5cb884a50 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -486,9 +486,9 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
     const VEDBoardInfo *daughterboard = (const VEDBoardInfo *)info;
 
     acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
-                                   NULL, &error_fatal);
+                                   0, 0, &error_fatal);
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
-                                   NULL, &error_fatal);
+                                   0, 0, &error_fatal);
     intc = find_int_controller(fdt);
     if (!intc) {
         /* Not fatal, we just won't provide virtio. This will
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 06a3d7dfe7..64b77d041a 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -88,7 +88,8 @@ static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
                                        &error_fatal);
 
         for (i = 0; node_path && node_path[i]; i++) {
-            r = qemu_fdt_getprop(fdt, node_path[i], "method", &prop_len, NULL);
+            r = qemu_fdt_getprop(fdt, node_path[i], "method", &prop_len,
+                false, NULL);
             method_is_hvc = r && !strcmp("hvc", r);
 
             /* Allow HVC based firmware if EL2 is enabled.  */
diff --git a/hw/core/fdt_generic.c b/hw/core/fdt_generic.c
new file mode 100644
index 0000000000..fbf8c802fc
--- /dev/null
+++ b/hw/core/fdt_generic.c
@@ -0,0 +1,283 @@
+/*
+ * Tables of FDT device models and their init functions. Keyed by compatibility
+ * strings, device instance names.
+ *
+ * Copyright (c) 2010 PetaLogix Qld Pty Ltd.
+ * Copyright (c) 2010 Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>.
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
+#include "hw/fdt_generic.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "qemu/coroutine.h"
+#include "qemu/log.h"
+#include "hw/cpu/cluster.h"
+#include "system/reset.h"
+
+#ifndef FDT_GENERIC_ERR_DEBUG
+#define FDT_GENERIC_ERR_DEBUG 0
+#endif
+#define DB_PRINT(lvl, ...) do { \
+    if (FDT_GENERIC_ERR_DEBUG > (lvl)) { \
+        qemu_log_mask(LOG_FDT, ": %s: ", __func__); \
+        qemu_log_mask(LOG_FDT, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define FDT_GENERIC_MAX_PATTERN_LEN 1024
+
+typedef struct TableListNode {
+    struct TableListNode *next;
+    char key[FDT_GENERIC_MAX_PATTERN_LEN];
+    FDTInitFn fdt_init;
+    void *opaque;
+} TableListNode;
+
+/* add a node to the table specified by *head_p */
+
+static void add_to_table(
+        FDTInitFn fdt_init,
+        const char *key,
+        void *opaque,
+        TableListNode **head_p)
+{
+    TableListNode *nn = malloc(sizeof(*nn));
+    nn->next = *head_p;
+    strcpy(nn->key, key);
+    nn->fdt_init = fdt_init;
+    nn->opaque = opaque;
+    *head_p = nn;
+}
+
+/* FIXME: add return codes that differentiate between not found and error */
+
+/*
+ * search a table for a key string and call the fdt init function if found.
+ * Returns 0 if a match is found, 1 otherwise
+ */
+
+static int fdt_init_search_table(
+        char *node_path,
+        FDTMachineInfo *fdti,
+        const char *key, /* string to match */
+        TableListNode **head) /* head of the list to search */
+{
+    TableListNode *iter;
+
+    for (iter = *head; iter != NULL; iter = iter->next) {
+        if (!strcmp(key, iter->key)) {
+            if (iter->fdt_init) {
+                return iter->fdt_init(node_path, fdti, iter->opaque);
+            }
+            return 0;
+        }
+    }
+
+    return 1;
+}
+
+TableListNode *compat_list_head;
+
+void add_to_compat_table(FDTInitFn fdt_init, const char *compat, void *opaque)
+{
+    add_to_table(fdt_init, compat, opaque, &compat_list_head);
+}
+
+int fdt_init_compat(char *node_path, FDTMachineInfo *fdti, const char *compat)
+{
+    return fdt_init_search_table(node_path, fdti, compat, &compat_list_head);
+}
+
+TableListNode *inst_bind_list_head;
+
+void add_to_inst_bind_table(FDTInitFn fdt_init, const char *name, void *opaque)
+{
+    add_to_table(fdt_init, name, opaque, &inst_bind_list_head);
+}
+
+int fdt_init_inst_bind(char *node_path, FDTMachineInfo *fdti,
+        const char *name)
+{
+    return fdt_init_search_table(node_path, fdti, name, &inst_bind_list_head);
+}
+
+static void dump_table(TableListNode *head)
+{
+    TableListNode *iter;
+
+    for (iter = head; iter != NULL; iter = iter->next) {
+        printf("key : %s, opaque data %p\n", head->key, head->opaque);
+    }
+}
+
+void dump_compat_table(void)
+{
+    printf("FDT COMPATIBILITY TABLE:\n");
+    dump_table(compat_list_head);
+}
+
+void dump_inst_bind_table(void)
+{
+    printf("FDT INSTANCE BINDING TABLE:\n");
+    dump_table(inst_bind_list_head);
+}
+
+void fdt_init_yield(FDTMachineInfo *fdti)
+{
+    static int yield_index;
+    int this_yield = yield_index++;
+
+    DB_PRINT(1, "Yield #%d\n", this_yield);
+    qemu_co_queue_wait(fdti->cq, NULL);
+    DB_PRINT(1, "Unyield #%d\n", this_yield);
+}
+
+void fdt_init_set_opaque(FDTMachineInfo *fdti, char *node_path, void *opaque)
+{
+    FDTDevOpaque *dp;
+    for (dp = fdti->dev_opaques;
+        dp->node_path && strcmp(dp->node_path, node_path);
+        dp++);
+    if (!dp->node_path) {
+        dp->node_path = strdup(node_path);
+    }
+    dp->opaque = opaque;
+}
+
+int fdt_init_has_opaque(FDTMachineInfo *fdti, char *node_path)
+{
+    FDTDevOpaque *dp;
+    for (dp = fdti->dev_opaques; dp->node_path; dp++) {
+        if (!strcmp(dp->node_path, node_path)) {
+            return 1;
+         }
+    }
+    return 0;
+}
+
+static int get_next_cpu_cluster_id(void)
+{
+    static int i;
+
+    return i++;
+}
+
+void fdt_init_register_user_cpu_cluster(FDTMachineInfo *fdti, Object *cluster)
+{
+    int i = get_next_cpu_cluster_id();
+    DeviceState *dev = DEVICE(cluster);
+    FDTCPUCluster *cl;
+
+    qdev_prop_set_uint32(dev, "cluster-id", i);
+
+    cl = g_new0(FDTCPUCluster, 1);
+    cl->cpu_cluster = cluster;
+    cl->next = fdti->clusters;
+    cl->user = true;
+
+    fdti->clusters = cl;
+
+    DB_PRINT(0, "%s: Registered user-defined cpu cluster with id %d\n",
+             object_get_canonical_path(cluster), i);
+}
+
+static void *fdt_init_add_cpu_cluster(FDTMachineInfo *fdti, char *compat)
+{
+    FDTCPUCluster *cl = g_malloc0(sizeof(*cl));
+    int i = get_next_cpu_cluster_id();
+    char *name = g_strdup_printf("cluster%d", i);
+    Object *obj;
+
+    obj = object_new(TYPE_CPU_CLUSTER);
+    object_property_add_child(object_get_root(), name, OBJECT(obj));
+    qdev_prop_set_uint32(DEVICE(obj), "cluster-id", i);
+
+    cl->cpu_type = g_strdup(compat);
+    cl->cpu_cluster = obj;
+    cl->next = fdti->clusters;
+
+    fdti->clusters = cl;
+
+    g_free(name);
+
+    return obj;
+}
+
+void *fdt_init_get_cpu_cluster(FDTMachineInfo *fdti, Object *parent, char *compat)
+{
+    FDTCPUCluster *cl = fdti->clusters;
+
+    if (object_dynamic_cast(parent, TYPE_CPU_CLUSTER)) {
+        /* The direct parent of this CPU is a CPU cluster. Use it. */
+        return parent;
+    }
+
+    while (cl) {
+        if (!cl->user && !strcmp(compat, cl->cpu_type)) {
+            return cl->cpu_cluster;
+        }
+        cl = cl->next;
+    }
+
+    /* No cluster found so create and return a new one */
+    return fdt_init_add_cpu_cluster(fdti, compat);
+}
+
+void *fdt_init_get_opaque(FDTMachineInfo *fdti, char *node_path)
+{
+    FDTDevOpaque *dp;
+    for (dp = fdti->dev_opaques; dp->node_path; dp++) {
+        if (!strcmp(dp->node_path, node_path)) {
+            return dp->opaque;
+        }
+    }
+    return NULL;
+}
+
+FDTMachineInfo *fdt_init_new_fdti(void *fdt)
+{
+    FDTMachineInfo *fdti = g_malloc0(sizeof(*fdti));
+    fdti->fdt = fdt;
+    fdti->cq = g_malloc0(sizeof(*(fdti->cq)));
+    qemu_co_queue_init(fdti->cq);
+    fdti->dev_opaques = g_malloc0(sizeof(*(fdti->dev_opaques)) *
+        (devtree_get_num_nodes(fdt) + 1));
+    return fdti;
+}
+
+void fdt_init_destroy_fdti(FDTMachineInfo *fdti)
+{
+    FDTCPUCluster *cl = fdti->clusters;
+    FDTDevOpaque *dp;
+
+    while (cl) {
+        FDTCPUCluster *tmp = cl;
+        cl = cl->next;
+        g_free(tmp->cpu_type);
+        g_free(tmp);
+    }
+    for (dp = fdti->dev_opaques; dp->node_path; dp++) {
+        g_free(dp->node_path);
+    }
+    g_free(fdti->dev_opaques);
+    g_free(fdti);
+}
diff --git a/hw/core/fdt_generic_devices.c b/hw/core/fdt_generic_devices.c
new file mode 100644
index 0000000000..b0ca2ee06b
--- /dev/null
+++ b/hw/core/fdt_generic_devices.c
@@ -0,0 +1,130 @@
+#include "qemu/osdep.h"
+#include "hw/fdt_generic_util.h"
+#include "hw/fdt_generic_devices.h"
+#include "qom/object.h"
+#include "system/blockdev.h"
+#include "system/memory.h"
+#include "system/address-spaces.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "qemu/coroutine.h"
+
+#include "hw/char/serial.h"
+#include "hw/block/flash.h"
+#include "hw/qdev-core.h"
+
+/* FIXME: This file should go away. When these devices are properly QOMified
+ * then these FDT creations should happen automatically without need for these
+ * explict shim functions
+ */
+
+/* Piggy back fdt_generic_util.c ERR_DEBUG symbol as these two are really the
+ * same feature
+ */
+
+#ifndef FDT_GENERIC_UTIL_ERR_DEBUG
+#define FDT_GENERIC_UTIL_ERR_DEBUG 0
+#endif
+#define DB_PRINT(lvl, ...) do { \
+    if (FDT_GENERIC_UTIL_ERR_DEBUG > (lvl)) { \
+        qemu_log_mask(lvl, ": %s: ", __func__); \
+        qemu_log_mask(lvl, ## __VA_ARGS__); \
+    } \
+} while (0);
+
+#define DB_PRINT_NP(lvl, ...) do { \
+    if (FDT_GENERIC_UTIL_ERR_DEBUG > (lvl)) { \
+        qemu_log_mask(lvl, "%s", node_path); \
+        DB_PRINT((lvl), ## __VA_ARGS__); \
+    } \
+} while (0);
+
+int fdt_generic_num_cpus;
+
+static int i2c_bus_fdt_init(char *node_path, FDTMachineInfo *fdti, void *priv)
+{
+    Object *parent;
+    DeviceState *dev;
+    char parent_node_path[DT_PATH_LENGTH];
+    char *node_name = qemu_devtree_get_node_name(fdti->fdt, node_path);
+
+    DB_PRINT_NP(1, "\n");
+    /* FIXME: share this code with fdt_generic_util.c/fdt_init_qdev() */
+    if (qemu_devtree_getparent(fdti->fdt, parent_node_path, node_path)) {
+        abort();
+    }
+    while (!fdt_init_has_opaque(fdti, parent_node_path)) {
+        fdt_init_yield(fdti);
+    }
+    parent = fdt_init_get_opaque(fdti, parent_node_path);
+    dev = (DeviceState *)object_dynamic_cast(parent, TYPE_DEVICE);
+    if (parent && dev) {
+        while (!dev->realized) {
+            fdt_init_yield(fdti);
+        }
+        DB_PRINT_NP(0, "parenting i2c bus to %s bus %s\n", parent_node_path,
+                 node_name);
+        fdt_init_set_opaque(fdti, node_path,
+                            qdev_get_child_bus(dev, node_name));
+    } else {
+        DB_PRINT_NP(0, "orphaning i2c bus\n");
+    }
+    return 0;
+}
+
+static int sysmem_fdt_init(char *node_path, FDTMachineInfo *fdti,
+                           void *priv)
+{
+    fdt_init_set_opaque(fdti, node_path, OBJECT(get_system_memory()));
+    return 0;
+}
+
+fdt_register_compatibility(sysmem_fdt_init, "compatible:qemu:system-memory");
+
+static const void *null;
+
+fdt_register_compatibility_n(null, "compatible:marvell,88e1111", 1);
+fdt_register_compatibility_n(null, "compatible:arm,pl310-cache", 2);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-cortexa9-1.00.a", 3);
+fdt_register_compatibility_n(null, "compatible:xlnx,zynq_remoteproc", 4);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-smcc-1.00.a", 5);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-smc", 6);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-nand-1.00.a", 7);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-ram-1.00.a", 8);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-ocm", 9);
+fdt_register_compatibility_n(null, "compatible:marvell,88e1118r", 10);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-clkc", 11);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-ddrc", 12);
+fdt_register_compatibility_n(null, "compatible:xlnx,ps7-scuc-1.00.a", 13);
+fdt_register_compatibility_n(null, "compatible:fixed-clock", 14);
+fdt_register_compatibility_n(null, "compatible:xlnx,pinctrl-zynq", 15);
+fdt_register_compatibility_n(null, "compatible:ulpi-phy", 16);
+fdt_register_compatibility_n(null, "compatible:xlnx,zynq-efuse", 17);
+fdt_register_compatibility_n(null, "compatible:qemu:memory-region-spec", 18);
+fdt_register_compatibility_n(null, "compatible:shared-dma-pool", 19);
+
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@0", 0);
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@1", 1);
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@2", 2);
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@3", 3);
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@4", 4);
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@5", 5);
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@6", 6);
+fdt_register_instance_n(i2c_bus_fdt_init, "i2c@7", 7);
+
+static const TypeInfo fdt_qom_aliases [] = {
+    {   .name = "qemu-memory-region",       .parent = "memory-region"  },
+    {   .name = "simple-bus",               .parent = "memory-region"  },
+};
+
+static void fdt_generic_register_types(void)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(fdt_qom_aliases); ++i) {
+        type_register_static(&fdt_qom_aliases[i]);
+    }
+}
+
+type_init(fdt_generic_register_types)
diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
new file mode 100644
index 0000000000..8af3cabe51
--- /dev/null
+++ b/hw/core/fdt_generic_util.c
@@ -0,0 +1,1883 @@
+/*
+ * Utility functions for fdt generic framework
+ *
+ * Copyright (c) 2009 Edgar E. Iglesias.
+ * Copyright (c) 2009 Michal Simek.
+ * Copyright (c) 2011 PetaLogix Qld Pty Ltd.
+ * Copyright (c) 2011 Peter A. G. Crosthwaite <peter.crosthwaite@petalogix.com>.
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
+ #include "qemu/osdep.h"
+ #include "hw/fdt_generic_util.h"
+ #include "hw/fdt_generic_devices.h"
+ #include "net/net.h"
+ #include "system/memory.h"
+ #include "system/address-spaces.h"
+ #include "hw/sysbus.h"
+ #include "qapi/error.h"
+ #include "qemu/error-report.h"
+ #include "system/system.h"
+ #include "system/reset.h"
+ #include "qemu/cutils.h"
+ #include "system/blockdev.h"
+ #include "system/block-backend.h"
+ #include "chardev/char.h"
+ #include "qemu/log.h"
+ #include "qemu/config-file.h"
+ #include "block/block.h"
+ #include "hw/ssi/ssi.h"
+ #include "hw/nvram/xlnx-bbram.h"
+ #include "hw/nvram/xlnx-efuse.h"
+ #include "hw/boards.h"
+ #include "qemu/option.h"
+ #include "hw/qdev-properties.h"
+ #include "hw/cpu/cluster.h"
+ 
+ #ifndef FDT_GENERIC_UTIL_ERR_DEBUG
+ #define FDT_GENERIC_UTIL_ERR_DEBUG 3
+ #endif
+ #define DB_PRINT(lvl, ...) do { \
+     if (FDT_GENERIC_UTIL_ERR_DEBUG > (lvl)) { \
+         qemu_log_mask(LOG_FDT, ": %s: ", __func__); \
+         qemu_log_mask(LOG_FDT, ## __VA_ARGS__); \
+     } \
+ } while (0);
+ 
+ #define DB_PRINT_NP(lvl, ...) do { \
+     if (FDT_GENERIC_UTIL_ERR_DEBUG > (lvl)) { \
+        qemu_log_mask(LOG_FDT, "%s", node_path); \
+        DB_PRINT((lvl), ## __VA_ARGS__); \
+     } \
+ } while (0);
+ 
+ /* FIXME: wrap direct calls into libfdt */
+ 
+ #include <libfdt.h>
+ #include <stdlib.h>
+ 
+ int fdt_serial_ports;
+ 
+ static int simple_bus_fdt_init(char *bus_node_path, FDTMachineInfo *fdti);
+ 
+ static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
+                                        char *intc_node_path,
+                                        uint32_t *cells, uint32_t num_cells,
+                                        uint32_t max, Error **errp);
+ 
+ 
+ typedef struct QEMUIRQSharedState {
+     qemu_irq sink;
+     int num;
+     bool (*merge_fn)(bool *, int);
+ /* FIXME: remove artificial limit */
+ #define MAX_IRQ_SHARED_INPUTS 256
+     bool inputs[MAX_IRQ_SHARED_INPUTS];
+ } QEMUIRQSharedState;
+ 
+ static bool qemu_irq_shared_or_handler(bool *inputs, int n)
+ {
+     int i;
+ 
+     assert(n < MAX_IRQ_SHARED_INPUTS);
+ 
+     for (i = 0; i < n; ++i) {
+         if (inputs[i]) {
+             return true;
+         }
+     }
+     return false;
+ }
+ 
+ static bool qemu_irq_shared_and_handler(bool *inputs, int n)
+ {
+     int i;
+ 
+     assert(n < MAX_IRQ_SHARED_INPUTS);
+ 
+     for (i = 0; i < n; ++i) {
+         if (!inputs[i]) {
+             return false;
+         }
+     }
+     return true;
+ }
+ 
+ static void qemu_irq_shared_handler(void *opaque, int n, int level)
+ {
+     QEMUIRQSharedState *s = opaque;
+ 
+     assert(n < MAX_IRQ_SHARED_INPUTS);
+     s->inputs[n] = level;
+     qemu_set_irq(s->sink, s->merge_fn(s->inputs, s->num));
+ }
+ 
+ static void fdt_init_all_irqs(FDTMachineInfo *fdti)
+ {
+     while (fdti->irqs) {
+         FDTIRQConnection *first = fdti->irqs;
+         qemu_irq sink = first->irq;
+         bool (*merge_fn)(bool *, int) = first->merge_fn;
+         int num_sources = 0;
+         FDTIRQConnection *irq;
+ 
+         for (irq = first; irq; irq = irq->next) {
+             if (irq->irq == sink) { /* Same sink */
+                 num_sources++;
+             }
+         }
+         if (num_sources > 1) {
+             QEMUIRQSharedState *s = g_malloc0(sizeof *s);
+             s->sink = sink;
+             s->merge_fn = merge_fn;
+             qemu_irq *sources = qemu_allocate_irqs(qemu_irq_shared_handler, s,
+                                                    num_sources);
+             for (irq = first; irq; irq = irq->next) {
+                 if (irq->irq == sink) {
+                     char *shared_irq_name = g_strdup_printf("shared-irq-%p",
+                                                             *sources);
+ 
+                     if (irq->merge_fn != merge_fn) {
+                         fprintf(stderr, "ERROR: inconsistent IRQ merge fns\n");
+                         exit(1);
+                     }
+ 
+                     object_property_add_child(OBJECT(irq->dev), shared_irq_name,
+                                               OBJECT(*sources));
+                     g_free(shared_irq_name);
+                     irq->irq = *(sources++);
+                     s->num++;
+                 }
+             }
+         }
+         DB_PRINT(0, "%s: connected to %s irq line %d (%s)\n",
+                  first->sink_info ? first->sink_info : "",
+                  object_get_canonical_path(OBJECT(first->dev)),
+                  first->i, first->name ? first->name : "");
+ 
+         qdev_connect_gpio_out_named(DEVICE(first->dev), first->name, first->i,
+                                     first->irq);
+         fdti->irqs = first->next;
+         g_free(first);
+     }
+ }
+ 
+ static void fdt_init_cpu_clusters(FDTMachineInfo *fdti)
+ {
+     FDTCPUCluster *cl = fdti->clusters;
+ 
+     while (cl) {
+         qdev_realize(DEVICE(cl->cpu_cluster), NULL, &error_fatal);
+         cl = cl->next;
+     }
+ }
+ 
+ FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
+ {
+     char node_path[DT_PATH_LENGTH];
+     FDTMachineInfo *fdti = fdt_init_new_fdti(fdt);
+ 
+     fdti->irq_base = cpu_irq;
+ 
+     fdt_serial_ports = 0;
+ 
+     /* parse the device tree */
+     if (!qemu_devtree_get_root_node(fdt, node_path)) {
+         memory_region_transaction_begin();
+         fdt_init_set_opaque(fdti, node_path, NULL);
+         simple_bus_fdt_init(node_path, fdti);
+         while (qemu_co_enter_next(fdti->cq, NULL));
+         fdt_init_cpu_clusters(fdti);
+         fdt_init_all_irqs(fdti);
+         memory_region_transaction_commit();
+     } else {
+         fprintf(stderr, "FDT: ERROR: cannot get root node from device tree %s\n"
+             , node_path);
+     }
+ 
+     /* FIXME: Populate these from DTS and create CPU clusters.  */
+     //current_machine->smp.cores = fdt_generic_num_cpus;
+     //current_machine->smp.cpus = fdt_generic_num_cpus;
+     //current_machine->smp.max_cpus = fdt_generic_num_cpus;
+ 
+     bdrv_drain_all();
+     DB_PRINT(0, "FDT: Device tree scan complete\n");
+     return fdti;
+ }
+ 
+ struct FDTInitNodeArgs {
+     char *node_path;
+     char *parent_path;
+     FDTMachineInfo *fdti;
+ };
+ 
+ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat);
+ 
+ static int check_compat(const char *prefix, const char *compat,
+                         char *node_path, FDTMachineInfo *fdti)
+ {
+     char *compat_prefixed = g_strconcat(prefix, compat, NULL);
+     const int done = !fdt_init_compat(node_path, fdti, compat_prefixed);
+     g_free(compat_prefixed);
+     return done;
+ }
+ 
+ static void fdt_init_node(void *args)
+ {
+     struct FDTInitNodeArgs *a = args;
+     char *node_path = a->node_path;
+     FDTMachineInfo *fdti = a->fdti;
+     g_free(a);
+ 
+     simple_bus_fdt_init(node_path, fdti);
+ 
+     char *all_compats = NULL, *node_name;
+     char *device_type = NULL;
+     int compat_len;
+ 
+     DB_PRINT_NP(1, "enter\n");
+ 
+     /* try instance binding first */
+     node_name = qemu_devtree_get_node_name(fdti->fdt, node_path);
+     DB_PRINT_NP(1, "node with name: %s\n", node_name ? node_name : "(none)");
+     if (!node_name) {
+         printf("FDT: ERROR: nameless node: %s\n", node_path);
+     }
+     if (!fdt_init_inst_bind(node_path, fdti, node_name)) {
+         DB_PRINT_NP(0, "instance bind successful\n");
+         goto exit;
+     }
+ 
+     /* fallback to compatibility binding */
+     all_compats = qemu_fdt_getprop(fdti->fdt, node_path, "compatible",
+                                    &compat_len, false, NULL);
+     if (all_compats) {
+         char *compat = all_compats;
+         char * const end = &all_compats[compat_len - 1]; /* points to nul */
+ 
+         while (compat < end) {
+             if (check_compat("compatible:", compat, node_path, fdti)) {
+                 goto exit;
+             }
+ 
+             if (!fdt_init_qdev(node_path, fdti, compat)) {
+                 check_compat("postinit:", compat, node_path, fdti);
+                 goto exit;
+             }
+ 
+             /* Scan forward to the end of the current compat. */
+             while (compat < end && *compat) {
+                 ++compat;
+             }
+ 
+             /* Replace nul with space for the debug printf below. */
+             if (compat < end) {
+                 *compat++ = ' ';
+             }
+         };
+     } else {
+         DB_PRINT_NP(0, "no compatibility found\n");
+     }
+ 
+     /* Try to create the device using device_type property
+      * Not every device tree node has compatible  property, so
+      * try with device_type.
+      */
+     device_type = qemu_fdt_getprop(fdti->fdt, node_path,
+                                    "device_type", NULL, false, NULL);
+     if (device_type) {
+         if (check_compat("device_type:", device_type, node_path, fdti)) {
+             goto exit;
+         }
+ 
+         if (!fdt_init_qdev(node_path, fdti, device_type)) {
+             goto exit;
+         }
+     }
+ 
+     if (all_compats) {
+         DB_PRINT_NP(0, "FDT: Unsupported peripheral invalidated - "
+                     "compatibilities %s\n", all_compats);
+         qemu_fdt_setprop_string(fdti->fdt, node_path, "compatible",
+                                 "invalidated");
+     }
+ exit:
+ 
+     DB_PRINT_NP(1, "exit\n");
+ 
+     if (!fdt_init_has_opaque(fdti, node_path)) {
+         fdt_init_set_opaque(fdti, node_path, NULL);
+     }
+     g_free(node_path);
+     g_free(all_compats);
+     g_free(device_type);
+     return;
+ }
+ 
+ static int simple_bus_fdt_init(char *node_path, FDTMachineInfo *fdti)
+ {
+     int i;
+     int num_children = qemu_devtree_get_num_children(fdti->fdt, node_path,
+                                                         1);
+     char **children;
+ 
+     if (num_children == 0) {
+         return 0;
+     }
+     children = qemu_devtree_get_children(fdti->fdt, node_path, 1);
+ 
+     DB_PRINT_NP(num_children ? 0 : 1, "num child devices: %d\n", num_children);
+ 
+     for (i = 0; i < num_children; i++) {
+         struct FDTInitNodeArgs *init_args = g_malloc0(sizeof(*init_args));
+         init_args->node_path = children[i];
+         init_args->fdti = fdti;
+         qemu_coroutine_enter(qemu_coroutine_create(fdt_init_node, init_args));
+     }
+ 
+     g_free(children);
+     return 0;
+ }
+ 
+ static qemu_irq fdt_get_gpio(FDTMachineInfo *fdti, char *node_path,
+                              int* cur_cell, qemu_irq input,
+                              const FDTGenericGPIOSet *gpio_set,
+                              const char *debug_success, bool *end) {
+     void *fdt = fdti->fdt;
+     uint32_t parent_phandle, parent_cells = 0, cells[32];
+     char parent_node_path[DT_PATH_LENGTH];
+     DeviceState *parent;
+     int i;
+     Error *errp = NULL;
+     const char *reason = NULL;
+     bool free_reason = false;
+     const char *propname = gpio_set->names->propname;
+     const char *cells_propname = gpio_set->names->cells_propname;
+ 
+     cells[0] = 0;
+ 
+     parent_phandle = qemu_fdt_getprop_cell(fdt, node_path, propname,
+                                            (*cur_cell)++, false, &errp);
+     if (errp) {
+         reason = g_strdup_printf("Cant get phandle from \"%s\" property\n",
+                                  propname);
+         *end = true;
+         free_reason = true;
+         goto fail_silent;
+     }
+     if (qemu_devtree_get_node_by_phandle(fdt, parent_node_path,
+                                          parent_phandle)) {
+         *end = true;
+         reason = "cant get node from phandle\n";
+         goto fail;
+     }
+     parent_cells = qemu_fdt_getprop_cell(fdt, parent_node_path,
+                                          cells_propname, 0, false, &errp);
+     if (errp) {
+         *end = true;
+         reason = g_strdup_printf("cant get the property \"%s\" from the " \
+                                  "parent \"%s\"\n",
+                                  cells_propname, parent_node_path);
+         free_reason = true;
+         goto fail;
+     }
+ 
+     for (i = 0; i < parent_cells; ++i) {
+         cells[i] = qemu_fdt_getprop_cell(fdt, node_path, propname,
+                                          (*cur_cell)++, false, &errp);
+         if (errp) {
+             *end = true;
+             reason = "cant get cell value";
+             goto fail;
+         }
+     }
+ 
+     while (!fdt_init_has_opaque(fdti, parent_node_path)) {
+         fdt_init_yield(fdti);
+     }
+     parent = DEVICE(fdt_init_get_opaque(fdti, parent_node_path));
+ 
+     if (!parent) {
+         reason = "parent is not a device";
+         goto fail_silent;
+     }
+ 
+     while (!parent->realized) {
+         fdt_init_yield(fdti);
+     }
+ 
+     {
+         const FDTGenericGPIOConnection *fgg_con = NULL;
+         uint16_t range, idx;
+         const char *gpio_name = NULL;
+         qemu_irq ret;
+ 
+         if (object_dynamic_cast(OBJECT(parent), TYPE_FDT_GENERIC_GPIO)) {
+             const FDTGenericGPIOSet *set;
+             FDTGenericGPIOClass *parent_fggc =
+                         FDT_GENERIC_GPIO_GET_CLASS(parent);
+ 
+             for (set = parent_fggc->controller_gpios; set && set->names;
+                  set++) {
+                 if (!strcmp(gpio_set->names->cells_propname,
+                             set->names->cells_propname)) {
+                     fgg_con = set->gpios;
+                     break;
+                 }
+             }
+         }
+ 
+         /* FIXME: cells[0] is not always the fdt indexing match system */
+         idx = cells[0] & ~(1ul << 31);
+         if (fgg_con) {
+             range = fgg_con->range ? fgg_con->range : 1;
+             while (!(idx >= fgg_con->fdt_index
+                      && idx < (fgg_con->fdt_index + range))
+                    && fgg_con->name) {
+                 fgg_con++;
+                 range = fgg_con->range ? fgg_con->range : 1;
+             }
+ 
+             idx -= fgg_con->fdt_index;
+             gpio_name = fgg_con->name;
+         }
+ 
+         if (input) {
+             FDTIRQConnection *irq = g_new0(FDTIRQConnection, 1);
+             bool (*merge_fn)(bool *, int) = qemu_irq_shared_or_handler;
+ 
+             /* FIXME: I am kind of stealing here. Use the msb of the first
+              * cell to indicate the merge function. This needs to be discussed
+              * with device-tree community on how this should be done properly.
+              */
+             if (cells[0] & (1 << 31)) {
+                 merge_fn = qemu_irq_shared_and_handler;
+             }
+ 
+             DB_PRINT_NP(1, "%s GPIO output %s[%d] on %s\n", debug_success,
+                         gpio_name ? gpio_name : "unnamed", idx,
+                         parent_node_path);
+             *irq = (FDTIRQConnection) {
+                 .dev = parent,
+                 .name = gpio_name,
+                 .merge_fn = merge_fn,
+                 .i = idx,
+                 .irq = input,
+                 .sink_info = NULL, /* FIMXE */
+                 .next = fdti->irqs
+             };
+             fdti->irqs = irq;
+         }
+ 
+         if (!strcmp(propname, "interrupts-extended") &&
+             object_dynamic_cast(OBJECT(parent), TYPE_FDT_GENERIC_INTC) &&
+             parent_cells > 1) {
+             qemu_irq *irqs = g_new0(qemu_irq, fdt_generic_num_cpus);
+            // int i;
+ 
+             fdt_get_irq_info_from_intc(fdti, irqs, parent_node_path, cells,
+                                     parent_cells, fdt_generic_num_cpus, &errp);
+             if (errp) {
+                 reason = "failed to create gpio connection";
+                 goto fail;
+             }
+ 
+             ret = NULL;
+             for (i = 0; i < fdt_generic_num_cpus; i++) {
+                 if (irqs[i]) {
+                     ret = irqs[i];
+                     break;
+                 }
+             }
+             g_free(irqs);
+         } else {
+             ret = qdev_get_gpio_in_named(parent, gpio_name, idx);
+         }
+ 
+         if (ret) {
+             DB_PRINT_NP(1, "wiring GPIO input %s on %s ...\n",
+                         fgg_con ? fgg_con->name : "unnamed", parent_node_path);
+         }
+         return ret;
+     }
+ fail:
+     if (reason) {
+         fprintf(stderr, "%s Failed: %s\n", node_path, reason);
+     }
+ 
+ fail_silent:
+     if (free_reason) {
+         g_free((void *)reason);
+     }
+     return NULL;
+ }
+ 
+ static void fdt_get_irq_info_from_intc(FDTMachineInfo *fdti, qemu_irq *ret,
+                                        char *intc_node_path,
+                                        uint32_t *cells, uint32_t num_cells,
+                                        uint32_t max, Error **errp)
+ {
+     FDTGenericIntcClass *intc_fdt_class;
+     DeviceState *intc;
+ 
+     while (!fdt_init_has_opaque(fdti, intc_node_path)) {
+         fdt_init_yield(fdti);
+     }
+     intc = DEVICE(fdt_init_get_opaque(fdti, intc_node_path));
+ 
+     if (!intc) {
+         goto fail;
+     }
+ 
+     while (!intc->realized) {
+         fdt_init_yield(fdti);
+     }
+ 
+     intc_fdt_class = FDT_GENERIC_INTC_GET_CLASS(intc);
+     if (!intc_fdt_class) {
+         goto fail;
+     }
+ 
+     intc_fdt_class->get_irq(FDT_GENERIC_INTC(intc), ret, cells, num_cells,
+                             max, errp);
+ 
+     return;
+ fail:
+     error_setg(errp, "%s", __func__);
+ }
+ 
+ static uint32_t imap_cache[32 * 1024];
+ static bool imap_cached = false;
+ 
+ qemu_irq *fdt_get_irq_info(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                           char *info, bool *map_mode) {
+     void *fdt = fdti->fdt;
+     uint32_t intc_phandle, intc_cells, cells[32];
+     char intc_node_path[DT_PATH_LENGTH];
+     qemu_irq *ret = NULL;
+     int i;
+     Error *errp = NULL;
+ 
+     intc_phandle = qemu_fdt_getprop_cell(fdt, node_path, "interrupt-parent",
+                                          0, true, &errp);
+     if (errp) {
+         errp = NULL;
+         intc_cells = qemu_fdt_getprop_cell(fdt, node_path,
+                                            "#interrupt-cells", 0, true, &errp);
+         *map_mode = true;
+     } else {
+         if (qemu_devtree_get_node_by_phandle(fdt, intc_node_path,
+                                              intc_phandle)) {
+             goto fail;
+         }
+ 
+         /* Check if the device is using interrupt-maps */
+         qemu_fdt_getprop_cell(fdt, node_path, "interrupt-map-mask", 0,
+                               false, &errp);
+         if (!errp) {
+             errp = NULL;
+             intc_cells = qemu_fdt_getprop_cell(fdt, node_path,
+                                                "#interrupt-cells", 0,
+                                                true, &errp);
+             *map_mode = true;
+         } else {
+             errp = NULL;
+             intc_cells = qemu_fdt_getprop_cell(fdt, intc_node_path,
+                                                "#interrupt-cells", 0,
+                                                true, &errp);
+             *map_mode = false;
+         }
+     }
+ 
+     if (errp) {
+         goto fail;
+     }
+ 
+     DB_PRINT_NP(2, "%s intc_phandle: %d\n", node_path, intc_phandle);
+ 
+     for (i = 0; i < intc_cells; ++i) {
+         cells[i] = qemu_fdt_getprop_cell(fdt, node_path, "interrupts",
+                                          intc_cells * irq_idx + i, false, &errp);
+         if (errp) {
+             goto fail;
+         }
+     }
+ 
+     if (*map_mode) {
+         int k;
+         ret = g_new0(qemu_irq, 1);
+         int num_matches = 0;
+         int len;
+         g_autofree uint32_t* imap_mask = g_new(uint32_t, intc_cells);
+         uint32_t *imap_p;
+         uint32_t *imap;
+         bool use_parent = false;
+ 
+         for (k = 0; k < intc_cells; ++k) {
+             imap_mask[k] = qemu_fdt_getprop_cell(fdt, node_path,
+                                                  "interrupt-map-mask", k + 2,
+                                                  true, &errp);
+             if (errp) {
+                 goto fail;
+             }
+         }
+ 
+         /* Check if the device has an interrupt-map property */
+         imap = qemu_fdt_getprop(fdt, node_path, "interrupt-map", &len,
+                                   use_parent, &errp);
+ 
+         if (!imap || errp) {
+             /* If the device doesn't have an interrupt-map, try again with
+              * inheritance. This will return the parents interrupt-map
+              */
+             use_parent = true;
+             errp = NULL;
+ 
+             imap_p = qemu_fdt_getprop(fdt, node_path, "interrupt-map",
+                                       &len, use_parent, &errp);
+             if (!imap_cached) {
+                 memcpy(imap_cache, imap_p, len);
+                 imap_cached = true;
+             }
+             imap = imap_cache;
+ 
+             if (errp) {
+                 goto fail;
+             }
+         }
+ 
+         len /= sizeof(uint32_t);
+ 
+         i = 0;
+         assert(imap);
+         while (i < len) {
+             if (!use_parent) {
+                 /* Only re-sync the interrupt-map when the device has it's
+                  * own map, to save time.
+                  */
+                 imap = qemu_fdt_getprop(fdt, node_path, "interrupt-map", &len,
+                                           use_parent, &errp);
+ 
+                 if (errp) {
+                     goto fail;
+                 }
+ 
+                 len /= sizeof(uint32_t);
+             }
+ 
+             bool match = true;
+             uint32_t new_intc_cells, new_cells[32];
+             i++; i++; /* FIXME: do address cells properly */
+             for (k = 0; k < intc_cells; ++k) {
+                 uint32_t  map_val = be32_to_cpu(imap[i++]);
+                 if ((cells[k] ^ map_val) & imap_mask[k]) {
+                     match = false;
+                 }
+             }
+             /* when caching, we hackishly store the number of cells for
+              * the parent in the MSB. +1, so zero MSB means non cachd
+              * and the full lookup is needed.
+              */
+             intc_phandle = be32_to_cpu(imap[i++]);
+             if (intc_phandle & (0xffu << 24)) {
+                 new_intc_cells = (intc_phandle >> 24) - 1;
+             } else {
+                 if (qemu_devtree_get_node_by_phandle(fdt, intc_node_path,
+                                                      intc_phandle)) {
+                     goto fail;
+                 }
+                 new_intc_cells = qemu_fdt_getprop_cell(fdt, intc_node_path,
+                                                        "#interrupt-cells", 0,
+                                                        false, &errp);
+                 imap[i - 1] = cpu_to_be32(intc_phandle |
+                                             (new_intc_cells + 1) << 24);
+                 if (errp) {
+                     goto fail;
+                 }
+             }
+             for (k = 0; k < new_intc_cells; ++k) {
+                 new_cells[k] = be32_to_cpu(imap[i++]);
+             }
+             if (match) {
+                 num_matches++;
+                 ret = g_renew(qemu_irq, ret, num_matches + 1);
+                 if (intc_phandle & (0xffu << 24)) {
+                     if (qemu_devtree_get_node_by_phandle(fdt, intc_node_path,
+                                                          intc_phandle &
+                                                          ((1 << 24) - 1))) {
+                         goto fail;
+                     }
+                 }
+ 
+                 DB_PRINT_NP(2, "Getting IRQ information: %s -> 0x%x (%s)\n",
+                             node_path, intc_phandle, intc_node_path);
+ 
+                 memset(&ret[num_matches], 0, sizeof(*ret));
+                 fdt_get_irq_info_from_intc(fdti, &ret[num_matches-1], intc_node_path,
+                                            new_cells, new_intc_cells, 1, NULL);
+                 if (info) {
+                    sprintf(info, "%s", intc_node_path);
+                    info += strlen(info) + 1;
+                 }
+             }
+         }
+         return ret;
+     }
+ 
+     DB_PRINT_NP(2, "Getting IRQ information: %s -> %s\n",
+                 node_path, intc_node_path);
+ 
+     ret = g_new0(qemu_irq, fdt_generic_num_cpus + 2);
+     fdt_get_irq_info_from_intc(fdti, ret, intc_node_path, cells, intc_cells,
+                                fdt_generic_num_cpus, &errp);
+ 
+     if (errp) {
+         goto fail;
+     }
+ 
+     /* FIXME: Phase out this info bussiness */
+     if (info) {
+         sprintf(info, "%s", intc_node_path);
+     }
+ 
+     return ret;
+ 
+ fail:
+     if (errp) {
+         sprintf(info, "%s", error_get_pretty(errp));
+     } else {
+         sprintf(info, "(none)");
+     }
+     return NULL;
+ }
+ 
+ qemu_irq *fdt_get_irq(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                       bool *map_mode)
+ {
+     return fdt_get_irq_info(fdti, node_path, irq_idx, NULL, map_mode);
+ }
+ 
+ /* FIXME: figure out a real solution to this */
+ 
+ #define DIGIT(a) ((a) >= '0' && (a) <= '9')
+ #define LOWER_CASE(a) ((a) >= 'a' && (a) <= 'z')
+ 
+ static void trim_version(char *x)
+ {
+     long result;
+ 
+     for (;;) {
+         x = strchr(x, '-');
+         if (!x) {
+             return;
+         }
+         if (DIGIT(x[1])) {
+             /* Try to trim Xilinx version suffix */
+             const char *p;
+ 
+             qemu_strtol(x + 1, &p, 0, &result);
+ 
+             if ( *p == '.') {
+                 *x = 0;
+                 return;
+             } else if ( *p == 0) {
+                 return;
+             }
+         } else if (x[1] == 'r' && x[3] == 'p') {
+             /* Try to trim ARM version suffix */
+             if (DIGIT(x[2]) && DIGIT(x[4])) {
+                 *x = 0;
+                 return;
+             }
+         }
+         x++;
+     }
+ }
+ 
+ static void substitute_char(char *s, char a, char b)
+ {
+     for (;;) {
+         s = strchr(s, a);
+         if (!s) {
+             return;
+         }
+         *s = b;
+         s++;
+     }
+ }
+ 
+ static inline const char *trim_vendor(const char *s)
+ {
+     /* FIXME: be more intelligent */
+     const char *ret = memchr(s, ',', strlen(s));
+     return ret ? ret + 1 : s;
+ }
+ 
+ /*
+  * Try to attach by matching drive created by '-blockdev node-name=LABEL'
+  * iff the FDT node contains property 'blockdev-node-name=LABEL'.
+  *
+  * Return false unless the given node_path has the property.
+  *
+  * Presence of the property also disables the node from ever attached
+  * to any drive created by the legacy '-drive' QEMU option.
+  *
+  * For more on '-blockdev', see:
+  *   http://events17.linuxfoundation.org/sites/events/files/slides/talk_11.pdf
+  */
+ static bool fdt_attach_blockdev(FDTMachineInfo *fdti,
+                                 char *node_path, Object *dev)
+ {
+     static const char propname[] = "blockdev-node-name";
+     char *label;
+ 
+     /* Inspect FDT node for blockdev-only binding */
+     label = qemu_fdt_getprop(fdti->fdt, node_path, propname,
+                              NULL, false, NULL);
+ 
+     /* Skip legacy node */
+     if (!label) {
+         return false;
+     }
+ 
+     /*
+      * Missing matching bdev is not an error: attachment is optional.
+      *
+      * error_setg() aborts, never returns: 'goto ret' is just sanity.
+      */
+     if (!label[0]) {
+         error_setg(&error_abort, "FDT-node '%s': property '%s' = <empty>",
+                    node_path, propname);
+         goto ret;
+     }
+ 
+     if (!bdrv_find_node(label)) {
+         goto ret;
+     }
+ 
+     object_property_set_str(OBJECT(dev), "drive", label, NULL);
+  ret:
+     g_free(label);
+     return true;
+ }
+ 
+ static void fdt_attach_blockdev_noname(FDTMachineInfo *fdti,
+                                 char *node_path, Object *dev)
+ {
+     char *blockdev_name = NULL;
+ 
+     blockdev_name = qemu_fdt_getprop_string(fdti->fdt, node_path,
+                     "blockdev-node-name", 0, false, NULL);
+     if (!blockdev_name) {
+         blockdev_name = qemu_devtree_get_node_name(fdti->fdt,
+                                                    node_path);
+         substitute_char(blockdev_name, '@', '-');
+         qemu_fdt_setprop_string(fdti->fdt, node_path,
+                                 "blockdev-node-name",
+                                 blockdev_name);
+     }
+     g_free(blockdev_name);
+     fdt_attach_blockdev(fdti, node_path, dev);
+ }
+ 
+ static void fdt_attach_drive(FDTMachineInfo *fdti, char *node_path,
+                              Object *dev, BlockInterfaceType drive_type)
+ {
+     DriveInfo *dinfo = NULL;
+     uint32_t *di_val = NULL;
+     int di_len = 0;
+ 
+     /* Do nothing if the device is not a block front-end */
+     if (!object_property_find(OBJECT(dev), "drive")) {
+         return;
+     }
+ 
+     /* Try non-legacy */
+     if (fdt_attach_blockdev(fdti, node_path, dev)) {
+         return;
+     }
+ 
+     /*
+      * Try legacy with explicit 'drive-index' binding, or next-unit
+      * as fallback binding.
+      */
+     di_val = qemu_fdt_getprop(fdti->fdt, node_path, "drive-index",
+                               &di_len, false, NULL);
+ 
+     if (di_val && (di_len == sizeof(*di_val))) {
+         dinfo = drive_get_by_index(drive_type, be32_to_cpu(*di_val));
+     } else {
+         dinfo = drive_get_next(drive_type);
+     }
+ 
+     if (dinfo) {
+         qdev_prop_set_drive(DEVICE(dev), "drive",
+                             blk_by_legacy_dinfo(dinfo));
+     }
+ 
+     return;
+ }
+ 
+ static void fdt_attach_indexed_drive(FDTMachineInfo *fdti, char *node_path,
+                                      Object *dev, uint32_t di_default,
+                                      BlockInterfaceType drive_type)
+ {
+     static const char prop[] = "drive-index";
+     uint32_t *di_val = NULL;
+     int di_len = 0;
+ 
+     di_val = qemu_fdt_getprop(fdti->fdt, node_path, prop, &di_len, false, NULL);
+     if (!di_val || (di_len != sizeof(*di_val))) {
+         uint32_t di = cpu_to_be32(di_default);
+         int r;
+ 
+         r = qemu_fdt_setprop(fdti->fdt, node_path, prop, &di, sizeof(di));
+         if (r < 0) {
+             error_setg(&error_abort,
+                        "Couldn't set fdt property %s.%s: %s",
+                        node_path, prop, fdt_strerror(r));
+         }
+     }
+ 
+     fdt_attach_drive(fdti, node_path, dev, drive_type);
+ }
+ 
+ static Object *fdt_create_from_compat(const char *compat, char **dev_type)
+ {
+     Object *ret = NULL;
+     char *c = g_strdup(compat);
+ 
+     /* Try to create the object */
+     ret = object_new(c);
+ 
+     if (!ret) {
+         /* Trim the version off the end and try again */
+         trim_version(c);
+         ret = object_new(c);
+ 
+         if (!ret) {
+             /* Replace commas with full stops */
+             substitute_char(c, ',', '.');
+             ret = object_new(c);
+         }
+     }
+ 
+     if (!ret) {
+         /* Restart with the orginal string and now replace commas with full stops
+          * and try again. This means that versions are still included.
+          */
+         g_free(c);
+         c = g_strdup(compat);
+         substitute_char(c, ',', '.');
+         ret = object_new(c);
+     }
+ 
+     if (dev_type) {
+         *dev_type = c;
+     } else {
+         g_free(c);
+     }
+ 
+     if (!ret) {
+         const char *no_vendor = trim_vendor(compat);
+ 
+         if (no_vendor != compat) {
+             return fdt_create_from_compat(no_vendor, dev_type);
+         }
+     }
+     return ret;
+ }
+ 
+ /*FIXME: roll into device tree functionality */
+ 
+ static inline uint64_t get_int_be(const void *p, int len)
+ {
+     switch (len) {
+     case 1:
+         return *((uint8_t *)p);
+     case 2:
+         return be16_to_cpu(*((uint16_t *)p));
+     case 4:
+         return be32_to_cpu(*((uint32_t *)p));
+     case 8:
+         return be32_to_cpu(*((uint64_t *)p));
+     default:
+         fprintf(stderr, "unsupported integer length\n");
+         abort();
+     }
+ }
+ 
+ /* FIXME: use structs instead of parallel arrays */
+ 
+ static const char *fdt_generic_reg_size_prop_names[] = {
+     "#address-cells",
+     "#size-cells",
+     "#bus-cells",
+     "#priority-cells",
+ };
+ 
+ static const int fdt_generic_reg_cells_defaults[] = {
+     1,
+     1,
+     0,
+     0,
+ };
+ 
+ /*
+  * Error handler for device creation failure.
+  *
+  * We look for qemu-fdt-abort-on-error properties up the tree.
+  * If we find one, we abort with the provided error message.
+  */
+ static void fdt_dev_error(FDTMachineInfo *fdti, char *node_path, char *compat)
+ {
+     char *abort_on_error;
+     char *warn_on_error;
+ 
+     warn_on_error = qemu_fdt_getprop(fdti->fdt, node_path,
+                                    "qemu-fdt-warn-on-error", 0,
+                                    true, NULL);
+     abort_on_error = qemu_fdt_getprop(fdti->fdt, node_path,
+                                    "qemu-fdt-abort-on-error", 0,
+                                    true, NULL);
+     if (warn_on_error) {
+         if (strncmp("device_type", compat, strlen("device_type"))) {
+             warn_report("%s: %s", compat, warn_on_error);
+         }
+     }
+ 
+     if (abort_on_error) {
+         error_report("Failed to create %s", compat);
+         error_setg(&error_fatal, "%s", abort_on_error);
+     }
+ }
+ 
+ static void fdt_init_qdev_link_prop(Object *obj, ObjectProperty *p,
+                                     FDTMachineInfo *fdti,
+                                     const char *node_path,
+                                     const QEMUDevtreeProp *prop)
+ {
+     int len = prop->len;
+     void *val = prop->value;
+     const char *propname = prop->name;
+ 
+     Object *linked_dev, *proxy;
+     char target_node_path[DT_PATH_LENGTH];
+     g_autofree char *propname_target = g_strconcat(propname, "-target", NULL);
+     Error *errp = NULL;
+ 
+     if (qemu_devtree_get_node_by_phandle(fdti->fdt, target_node_path,
+                                          get_int_be(val, len))) {
+         abort();
+     }
+ 
+     while (!fdt_init_has_opaque(fdti, target_node_path)) {
+         fdt_init_yield(fdti);
+     }
+     linked_dev = fdt_init_get_opaque(fdti, target_node_path);
+ 
+     proxy = linked_dev ? object_property_get_link(linked_dev,
+                                                   propname_target,
+                                                   &errp) : NULL;
+     if (!errp && proxy) {
+         DB_PRINT_NP(0, "detected proxy object for %s connection\n", propname);
+         linked_dev = proxy;
+     }
+ 
+     if (!linked_dev) {
+         return;
+     }
+ 
+     errp = NULL;
+     object_property_set_link(obj, propname, linked_dev, &errp);
+     if (errp) {
+         /* Unable to set the property, maybe it is a memory alias? */
+         MemoryRegion *alias_mr;
+         int offset = len / 2;
+         int region = 0;
+ 
+         if (len > 4) {
+             region = get_int_be(val + offset, len - offset);
+         }
+ 
+         alias_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(linked_dev), region);
+ 
+         object_property_set_link(obj, propname, OBJECT(alias_mr), &error_abort);
+ 
+     }
+ 
+     DB_PRINT_NP(0, "set link %s\n", propname);
+ }
+ 
+ static void fdt_init_qdev_scalar_prop(Object *obj, ObjectProperty *p,
+                                       FDTMachineInfo *fdti,
+                                       const char *node_path,
+                                       const QEMUDevtreeProp *prop)
+ {
+     const char *propname = trim_vendor(prop->name);
+     void *val = prop->value;
+     int len = prop->len;
+ 
+     /* FIXME: handle generically using accessors and stuff */
+     if (!strncmp(p->type, "link", 4)) {
+         fdt_init_qdev_link_prop(obj, p, fdti, node_path, prop);
+         return;
+     }
+ 
+     if (!strcmp(p->type, "uint8") || !strcmp(p->type, "uint16") ||
+         !strcmp(p->type, "uint32") || !strcmp(p->type, "uint64") ||
+         !strcmp(p->type, "int8") || !strcmp(p->type, "int16") ||
+         !strcmp(p->type, "int32") || !strcmp(p->type, "int64")) {
+         object_property_set_int(obj, propname,
+                                 get_int_be(val, len), &error_abort);
+         DB_PRINT_NP(0, "set property %s to 0x%llx\n", propname,
+                     (unsigned long long)get_int_be(val, len));
+         return;
+     }
+ 
+     if (!strcmp(p->type, "boolean") || !strcmp(p->type, "bool")) {
+         object_property_set_bool(obj, propname,
+                                  !!get_int_be(val, len), &error_abort);
+         DB_PRINT_NP(0, "set property %s to %s\n", propname,
+                     get_int_be(val, len) ? "true" : "false");
+         return;
+     }
+ 
+     if (!strcmp(p->type, "string") || !strcmp(p->type, "str")) {
+         object_property_set_str(obj, propname,
+                                 (const char *)val, &error_abort);
+         DB_PRINT_NP(0, "set property %s to %s\n", propname, (const char *)val);
+         return;
+     }
+ 
+     DB_PRINT_NP(0, "WARNING: property is of unknown type\n");
+ }
+ 
+ static size_t fdt_array_elem_len(FDTMachineInfo *fdti,
+                                  const char *node_path,
+                                  const char *propname)
+ {
+     g_autofree char *elem_cells_propname = NULL;
+     Error *err = NULL;
+     uint32_t elem_cells;
+ 
+     /*
+      * Default element size to 1 uint32_t cell, unless it is explicitly
+      * given in the same FDT node (not inherited).
+      */
+     elem_cells_propname = g_strconcat("#", propname, "-cells", NULL);
+     elem_cells = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                        elem_cells_propname, 0, false, &err);
+ 
+     return (err ? 1 : elem_cells) * 4;
+ }
+ 
+static ObjectProperty *fdt_array_elem_prop(Object *obj,
+                                           const char *propname, int k)
+{
+    g_autofree char *elem_name = g_strdup_printf("%s[%d]", propname, k);
+
+    return object_property_find(obj, elem_name);
+}
+
+static char *fdt_array_elem_type(ObjectProperty *e)
+{
+    size_t n = strlen(e->type);
+
+    if (strncmp(e->type, "link", 4)) {
+        return NULL;
+    }
+    if (n > 6) {
+        return g_strndup(&e->type[5], (n - 6));
+    }
+
+    return g_strdup(TYPE_OBJECT);
+}
+
+static ObjectProperty *fdt_array_link_elem_prop(Object *obj, ObjectProperty *e,
+                                                const char *elem_link_type)
+ {
+     /*
+      * Starting QEMU 8.2.0, the array-scheme has changed to be a single
+      * property of list.  See:
+      *   https://mail.gnu.org/archive/html/qemu-devel/2023-09/msg01832.html
+      *
+      * Thus, fdt_init_qdev_array_prop() below will have to be changed
+      * substantially.
+      *
+      * So for now, use a temporary hack to work around DEFINE_PROP_ARRAY() not
+      * creating the proper elements of type "link" (see set_prop_arraylen()).
+      */
+     g_autofree char *elem_name = g_strdup(e->name);
+     void *elem_ptr = object_field_prop_ptr(obj, e->opaque);
+ 
+     object_property_del(obj, elem_name);
+     e = object_property_add_link(obj, elem_name,
+                                  elem_link_type, elem_ptr,
+                                  qdev_prop_allow_set_link_before_realize,
+                                  OBJ_PROP_LINK_STRONG);
+ 
+     return e;
+ }
+ 
+ static void fdt_init_qdev_array_prop(Object *obj,
+                                      FDTMachineInfo *fdti,
+                                      const char *node_path,
+                                      QEMUDevtreeProp *prop)
+ {
+     const char *propname = trim_vendor(prop->name);
+     int nr = prop->len;
+     Error *local_err = NULL;
+     char *len_name;
+     uint32_t elem_len;
+     g_autofree char *elem_link_type = NULL;
+     ObjectProperty *e;
+ 
+     if (!prop->value || !nr) {
+         return;
+     }
+ 
+     elem_len = fdt_array_elem_len(fdti, node_path, propname);
+     if (nr % elem_len) {
+         return;
+     }
+ 
+     nr /= elem_len;
+ 
+     /*
+      * Fail gracefully on setting the 'len-' property, due to:
+      * 1. The property does not exist, or
+      * 2. The property is not integer type, or
+      * 3. The property has been set, e.g., by the '-global' cmd option
+      */
+     len_name = g_strconcat(PROP_ARRAY_LEN_PREFIX, propname, NULL);
+     object_property_set_int(obj, len_name, nr, &local_err);
+     g_free(len_name);
+ 
+     if (local_err) {
+         error_free(local_err);
+         return;
+     }
+ 
+     e = fdt_array_elem_prop(obj, propname, 0);
+     if (!e) {
+         return;
+     }
+ 
+     elem_link_type = fdt_array_elem_type(e);
+ 
+     while (nr--) {
+         QEMUDevtreeProp q;
+ 
+         e = fdt_array_elem_prop(obj, propname, nr);
+         if (!e) {
+             continue;
+         }
+ 
+         q = (QEMUDevtreeProp){.name = e->name,
+                               .value = prop->value + nr * elem_len,
+                               .len = elem_len,
+                              };
+ 
+         if (elem_link_type) {
+             e = fdt_array_link_elem_prop(obj, e, elem_link_type);
+             q.name = e->name;
+             fdt_init_qdev_link_prop(obj, e, fdti, node_path, &q);
+         } else {
+             fdt_init_qdev_scalar_prop(obj, e, fdti, node_path, &q);
+         }
+     }
+ }
+ 
+ static void fdt_prop_override(char *node_path,
+                               QEMUDevtreeProp *props,
+                               QEMUDevtreeProp *prop,
+                               const char *prefix,
+                               const char *propname)
+ {
+     char *pfxPropname = g_strdup_printf("%s-%s", prefix, propname);
+     QEMUDevtreeProp *pp;
+ 
+     pp = qemu_devtree_prop_search(props, pfxPropname);
+     if (pp) {
+         g_free(prop->value);
+         prop->len = pp->len;
+         prop->value = g_memdup(pp->value, pp->len);
+         DB_PRINT_NP(1, "Found %s property match: %s\n",
+                     prefix, pfxPropname);
+     }
+     g_free(pfxPropname);
+ }
+ 
+ static bool ready_to_realize(DeviceState *dev)
+ {
+     FDTGenericHelperClass *fghc;
+ 
+     if (!object_dynamic_cast(OBJECT(dev), TYPE_FDT_GENERIC_HELPER)) {
+         return true;
+     }
+ 
+     fghc = FDT_GENERIC_HELPER_GET_CLASS(dev);
+ 
+     if (!fghc->ready_to_realize) {
+         return true;
+     }
+ 
+     return fghc->ready_to_realize(dev);
+ }
+ 
+ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
+ {
+     Object *dev, *parent;
+     char *dev_type = NULL;
+     bool is_direct_linux;
+     int is_intc;
+     Error *errp = NULL;
+     int i, j;
+     QEMUDevtreeProp *prop, *props;
+     char parent_node_path[DT_PATH_LENGTH];
+     const FDTGenericGPIOSet *gpio_set = NULL;
+     /* Allocate a large number and assert if something goes over */
+     FDTGenericGPIOSet tmp_gpio_set[64];
+     FDTGenericGPIOClass *fggc = NULL;
+ 
+     if (!compat) {
+         return 1;
+     }
+     dev = fdt_create_from_compat(compat, &dev_type);
+     if (!dev) {
+         DB_PRINT_NP(1, "no match found for %s\n", compat);
+         fdt_dev_error(fdti, node_path, compat);
+         return 1;
+     }
+     DB_PRINT_NP(1, "matched compat %s\n", compat);
+ 
+     /* Are we doing a direct Linux boot? */
+     is_direct_linux = object_property_get_bool(OBJECT(qdev_get_machine()),
+                                                "linux", NULL);
+ 
+     /* Do this super early so fdt_generic_num_cpus is correct ASAP */
+     if (object_dynamic_cast(dev, TYPE_CPU)) {
+         fdt_generic_num_cpus++;
+         DB_PRINT_NP(0, "is a CPU - total so far %d\n", fdt_generic_num_cpus);
+     }
+ 
+     if (qemu_devtree_getparent(fdti->fdt, parent_node_path, node_path)) {
+         abort();
+     }
+     while (!fdt_init_has_opaque(fdti, parent_node_path)) {
+         fdt_init_yield(fdti);
+     }
+ 
+     parent = fdt_init_get_opaque(fdti, parent_node_path);
+ 
+     if (object_dynamic_cast(dev, TYPE_CPU)) {
+         parent = fdt_init_get_cpu_cluster(fdti, parent, compat);
+     }
+ 
+     if (dev->parent) {
+         DB_PRINT_NP(0, "Node already parented - skipping node\n");
+     } else if (parent) {
+         DB_PRINT_NP(1, "parenting node\n");
+         object_property_add_child(OBJECT(parent),
+                               qemu_devtree_get_node_name(fdti->fdt, node_path),
+                               OBJECT(dev));
+         if (object_dynamic_cast(dev, TYPE_DEVICE)) {
+             Object *parent_bus = parent;
+             unsigned int depth = 0;
+ 
+             DB_PRINT_NP(1, "bus parenting node\n");
+             /* Look for an FDT ancestor that is a Bus.  */
+             while (parent_bus && !object_dynamic_cast(parent_bus, TYPE_BUS)) {
+                 /*
+                  * Assert against insanely deep hierarchies which are an
+                  * indication of loops.
+                  */
+                 assert(depth < 4096);
+ 
+                 parent_bus = parent_bus->parent;
+                 depth++;
+             }
+ 
+             if (!parent_bus
+                 && object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+                 /*
+                  * Didn't find any bus. Use the default sysbus one.
+                  * This allows ad-hoc busses belonging to sysbus devices to be
+                  * visible to -device bus=x.
+                  */
+                 parent_bus = OBJECT(sysbus_get_default());
+             }
+ 
+             if (parent_bus) {
+                 qdev_set_parent_bus(DEVICE(dev), BUS(parent_bus),
+                                     &error_abort);
+             }
+         }
+     } else {
+         DB_PRINT_NP(1, "orphaning node\n");
+         if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+             qdev_set_parent_bus(DEVICE(dev), BUS(sysbus_get_default()),
+                                 &error_abort);
+         }
+ 
+         /* FIXME: Make this go away (centrally) */
+         object_property_add_child(
+                               object_get_root(),
+                               qemu_devtree_get_node_name(fdti->fdt, node_path),
+                               OBJECT(dev));
+     }
+     fdt_init_set_opaque(fdti, node_path, dev);
+ 
+     /* Call FDT Generic hooks for overriding prop default values.  */
+     if (object_dynamic_cast(dev, TYPE_FDT_GENERIC_PROPS)) {
+         FDTGenericPropsClass *k = FDT_GENERIC_PROPS_GET_CLASS(dev);
+ 
+         assert(k->set_props);
+         k->set_props(OBJECT(dev), &error_fatal);
+     }
+ 
+     props = qemu_devtree_get_props(fdti->fdt, node_path);
+     for (prop = props; prop->name; prop++) {
+         const char *propname = trim_vendor(prop->name);
+         int len;
+         void *val;
+         ObjectProperty *p = NULL;
+ #ifdef _WIN32
+         fdt_prop_override(node_path, props, prop, "windows", propname);
+ #endif
+         if (is_direct_linux) {
+             /*
+              * We use a short lnx name because device-tree props have a max
+              * length of 30 characters. We already break that limit if using
+              * direct-linux-start-powered-off, for example.
+              */
+             fdt_prop_override(node_path, props, prop, "direct-lnx", propname);
+         }
+ 
+         val = prop->value;
+         len = prop->len;
+ 
+         p = object_property_find(OBJECT(dev), propname);
+         if (p) {
+             DB_PRINT_NP(1, "matched property: %s of type %s, len %d\n",
+                                             propname, p->type, prop->len);
+         }
+         if (!p) {
+             fdt_init_qdev_array_prop(dev, fdti, node_path, prop);
+             continue;
+         }
+ 
+         if (!strcmp(propname, "type")) {
+             continue;
+         }
+ 
+         /* Special case for chardevs. It's an ordered list of strings.  */
+         if (!strcmp(propname, "chardev") && !strcmp(p->type, "str")) {
+             const char *chardev = val;
+             const char *chardevs_end = chardev + len;
+ 
+             assert(errp == NULL);
+             while (chardev < chardevs_end) {
+                 object_property_set_str(OBJECT(dev), propname, (const char *)chardev, &errp);
+                 if (!errp) {
+                     DB_PRINT_NP(0, "set property %s to %s\n", propname,
+                                 chardev);
+                     break;
+                 }
+                 chardev += strlen(chardev) + 1;
+                 errp = NULL;
+             }
+             assert(errp == NULL);
+             continue;
+         }
+ 
+         fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
+     }
+ 
+     if (object_dynamic_cast(dev, TYPE_DEVICE)) {
+         DeviceClass *dc = DEVICE_GET_CLASS(dev);
+         /* connect nic if appropriate */
+         static int nics;
+         const char *short_name = qemu_devtree_get_node_name(fdti->fdt, node_path);
+ 
+         if (object_property_find(OBJECT(dev), "mac") &&
+                     object_property_find(OBJECT(dev), "netdev")) {
+             qdev_set_nic_properties(DEVICE(dev), &nd_table[nics]);
+         }
+         if (nd_table[nics].instantiated) {
+             DB_PRINT_NP(0, "NIC instantiated: %s\n", dev_type);
+             nics++;
+         }
+ 
+         /* We also need to externally connect drives. Let's try to do that
+          * here.
+          */
+         if (object_property_find(OBJECT(dev), "drive")) {
+             uint32_t *use_blkdev = NULL;
+             use_blkdev =  qemu_fdt_getprop(fdti->fdt, node_path,
+                                              "use-blockdev", NULL,
+                                              false, NULL);
+             if (use_blkdev && *use_blkdev) {
+                 fdt_attach_blockdev_noname(fdti, node_path, dev);
+             } else {
+                 /*
+                  *  Remove these after we fully convert to blockdev based
+                  *  drive binding.
+                  */
+                 if (object_dynamic_cast(dev, TYPE_XLNX_BBRAM)) {
+                     /* default drive index: 0 for Versal, 2 for ZU+ */
+                     uint32_t di;
+ 
+                     di = object_property_get_uint(dev, "crc-zpads",
+                                                   &error_abort) == 0
+                          ? 0 : 2;
+                     fdt_attach_indexed_drive(fdti, node_path, dev,
+                                              di, IF_PFLASH);
+                 }
+                 if (object_dynamic_cast(dev, TYPE_XLNX_EFUSE)) {
+                     /* default drive index: 1 for Versal, 3 for ZU+ */
+                     uint32_t di;
+ 
+                     di = object_property_get_uint(dev, "efuse-size",
+                                                   &error_abort) > 2048
+                          ? 1 : 3;
+                     fdt_attach_indexed_drive(fdti, node_path, dev,
+                                              di, IF_PFLASH);
+                 }
+                 if (object_dynamic_cast(dev, TYPE_SSI_PERIPHERAL)) {
+                     fdt_attach_drive(fdti, node_path, dev, IF_MTD);
+                 }
+             }
+             g_free(use_blkdev);
+         }
+ 
+         /* Regular TYPE_DEVICE houskeeping */
+         DB_PRINT_NP(0, "Short naming node: %s\n", short_name);
+         (DEVICE(dev))->id = g_strdup(short_name);
+ 
+         if (object_dynamic_cast(dev, TYPE_CPU_CLUSTER)) {
+             /*
+              * CPU clusters must be realized at the end to make sure all child
+              * CPUs are parented.
+              */
+             fdt_init_register_user_cpu_cluster(fdti, OBJECT(dev));
+         } else {
+             while (!ready_to_realize(DEVICE(dev))) {
+                 fdt_init_yield(fdti);
+             }
+ 
+             object_property_set_bool(OBJECT(dev), "realized", true, &error_fatal);
+             qemu_register_reset((void (*)(void *))dc->legacy_reset, dev);
+         }
+     }
+ 
+     if (object_dynamic_cast(dev, TYPE_SYS_BUS_DEVICE) ||
+         object_dynamic_cast(dev, TYPE_FDT_GENERIC_MMAP)) {
+         FDTGenericRegPropInfo reg = {0};
+         char parent_path[DT_PATH_LENGTH];
+         int cell_idx = 0;
+         bool extended = true;
+ 
+         qemu_fdt_getprop_cell(fdti->fdt, node_path, "reg-extended", 0, false,
+                               &errp);
+         if (errp) {
+             error_free(errp);
+             errp = NULL;
+             extended = false;
+             qemu_devtree_getparent(fdti->fdt, parent_path, node_path);
+         }
+ 
+         for (reg.n = 0;; reg.n++) {
+             char ph_parent[DT_PATH_LENGTH];
+             const char *pnp = parent_path;
+ 
+             reg.parents = g_renew(Object *, reg.parents, reg.n + 1);
+             reg.parents[reg.n] = parent;
+ 
+             if (extended) {
+                 int p_ph = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                                  "reg-extended", cell_idx++,
+                                                  false, &errp);
+                 if (errp) {
+                     error_free(errp);
+                     errp = NULL;
+                     goto exit_reg_parse;
+                 }
+                 if (qemu_devtree_get_node_by_phandle(fdti->fdt, ph_parent,
+                                                      p_ph)) {
+                     goto exit_reg_parse;
+                 }
+                 while (!fdt_init_has_opaque(fdti, ph_parent)) {
+                     fdt_init_yield(fdti);
+                 }
+                 reg.parents[reg.n] = fdt_init_get_opaque(fdti, ph_parent);
+                 pnp = ph_parent;
+             }
+ 
+             for (i = 0; i < FDT_GENERIC_REG_TUPLE_LENGTH; ++i) {
+                 const char *size_prop_name = fdt_generic_reg_size_prop_names[i];
+                 int nc = qemu_fdt_getprop_cell(fdti->fdt, pnp, size_prop_name,
+                                                0, true, &errp);
+ 
+                 if (errp) {
+                     int size_default = fdt_generic_reg_cells_defaults[i];
+ 
+                     DB_PRINT_NP(0, "WARNING: no %s for %s container, assuming "
+                                 "default of %d\n", size_prop_name, pnp,
+                                 size_default);
+                     nc = size_default;
+                     error_free(errp);
+                     errp = NULL;
+                 }
+ 
+                 reg.x[i] = g_renew(uint64_t, reg.x[i], reg.n + 1);
+                 reg.x[i][reg.n] = nc ?
+                     qemu_fdt_getprop_sized_cell(fdti->fdt, node_path,
+                                                 extended ? "reg-extended"
+                                                          : "reg",
+                                                 cell_idx, nc, &errp)
+                     : 0;
+                 cell_idx += nc;
+                 if (errp) {
+                     goto exit_reg_parse;
+                 }
+             }
+         }
+ exit_reg_parse:
+ 
+         if (object_dynamic_cast(dev, TYPE_FDT_GENERIC_MMAP)) {
+             FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_GET_CLASS(dev);
+             if (fmc->parse_reg) {
+                 while (fmc->parse_reg(FDT_GENERIC_MMAP(dev), reg,
+                                       &error_abort)) {
+                     fdt_init_yield(fdti);
+                 }
+             }
+         }
+     }
+ 
+     if (object_dynamic_cast(dev, TYPE_SYS_BUS_DEVICE)) {
+         {
+             int len;
+             fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                                     "interrupt-controller", &len);
+             is_intc = len >= 0;
+             DB_PRINT_NP(is_intc ? 0 : 1, "is interrupt controller: %c\n",
+                         is_intc ? 'y' : 'n');
+         }
+         /* connect irq */
+         j = 0;
+         for (i = 0;; i++) {
+             char irq_info[6 * 1024];
+             char *irq_info_p = irq_info;
+             bool map_mode;
+             int len = -1;
+             qemu_irq *irqs = fdt_get_irq_info(fdti, node_path, i, irq_info,
+                                               &map_mode);
+             /* INTCs inferr their top level, if no IRQ connection specified */
+             fdt_get_property(fdti->fdt, fdt_path_offset(fdti->fdt, node_path),
+                              "interrupts-extended", &len);
+             if (!irqs && is_intc && i == 0 && len <= 0) {
+                 FDTGenericIntc *id = (FDTGenericIntc *)object_dynamic_cast(
+                                         dev, TYPE_FDT_GENERIC_INTC);
+                 FDTGenericIntcClass *idc = FDT_GENERIC_INTC_GET_CLASS(id);
+                 if (id && idc->auto_parent) {
+                     /*
+                      * Hack alert! auto-parenting the interrupt
+                      * controller before the first CPU has been
+                      * realized leads to a segmentation fault in
+                      * xilinx_intc_fdt_auto_parent.
+                      */
+                     while (!DEVICE(first_cpu)) {
+                         fdt_init_yield(fdti);
+                     }
+                     Error *err = NULL;
+                     idc->auto_parent(id, &err);
+                 } else {
+                     irqs = fdti->irq_base;
+                 }
+             }
+             if (!irqs) {
+                 break;
+             }
+             while (*irqs) {
+                 FDTIRQConnection *irq = g_new0(FDTIRQConnection, 1);
+                 *irq = (FDTIRQConnection) {
+                     .dev = DEVICE(dev),
+                     .name = SYSBUS_DEVICE_GPIO_IRQ,
+                     .merge_fn = qemu_irq_shared_or_handler,
+                     .i = j,
+                     .irq = *irqs,
+                     .sink_info = g_strdup(irq_info_p),
+                     .next = fdti->irqs
+                 };
+                 if (!map_mode) {
+                     j++;
+                 } else {
+                     irq_info_p += strlen(irq_info_p) + 1;
+                 }
+                 fdti->irqs = irq;
+                 irqs++;
+             }
+             if (map_mode) {
+                 j++;
+             }
+         }
+     }
+ 
+     if (object_dynamic_cast(dev, TYPE_FDT_GENERIC_GPIO)) {
+         fggc = FDT_GENERIC_GPIO_GET_CLASS(dev);
+         gpio_set = fggc->client_gpios;
+ 
+         /*
+          * Add default GPIOs to the client GPIOs so the device has access to
+          * reset, power, and halt control.
+          */
+         if (gpio_set) {
+             size_t gpio_cnt = 0;
+             const FDTGenericGPIOSet *p_gpio;
+ 
+             for (p_gpio = gpio_set; p_gpio->names; p_gpio++) {
+                 assert(gpio_cnt < ARRAY_SIZE(tmp_gpio_set));
+                 tmp_gpio_set[gpio_cnt] = *p_gpio;
+                 gpio_cnt++;
+             }
+ 
+             for (p_gpio = default_gpio_sets; p_gpio->names; p_gpio++) {
+                 assert(gpio_cnt < ARRAY_SIZE(tmp_gpio_set));
+                 tmp_gpio_set[gpio_cnt] = *p_gpio;
+                 gpio_cnt++;
+             }
+ 
+             gpio_set = tmp_gpio_set;
+         }
+     }
+ 
+     if (!gpio_set) {
+         gpio_set = default_gpio_sets;
+     }
+ 
+     for (; object_dynamic_cast(dev, TYPE_DEVICE) && gpio_set->names;
+            gpio_set++) {
+         bool end = false;
+         int cur_cell = 0;
+ 
+         for (i = 0; !end; i++) {
+             char *debug_success;
+             const FDTGenericGPIOConnection *c = gpio_set->gpios;
+             const char *gpio_name = NULL;
+             uint16_t named_idx = 0;
+             qemu_irq input, output;
+             memset(&input, 0, sizeof(input));
+ 
+             if (c) {
+                 uint16_t range = c->range ? c->range : 1;
+                 while (((c->fdt_index > i) || ((c->fdt_index + range) <= i))
+                        && c->name) {
+                     c++;
+                     range = c->range ? c->range : 1;
+                 }
+                 named_idx = i - c->fdt_index;
+                 gpio_name = c->name;
+             }
+             if (!gpio_name) {
+                 const char *names_propname = gpio_set->names->names_propname;
+                 gpio_name = qemu_fdt_getprop_string(fdti->fdt, node_path,
+                                                     names_propname, i, false,
+                                                     NULL);
+             }
+             if (!gpio_name) {
+                 input = qdev_get_gpio_in(DEVICE(dev), i);
+             } else {
+                 input = qdev_get_gpio_in_named(DEVICE(dev), gpio_name,
+                                                named_idx);
+             }
+             debug_success = g_strdup_printf("Wiring GPIO input %s[%" PRId16 "] "
+                                             "to", gpio_name, named_idx);
+             output = fdt_get_gpio(fdti, node_path, &cur_cell, input, gpio_set,
+                                   debug_success, &end);
+             g_free(debug_success);
+             if (output) {
+                 FDTIRQConnection *irq = g_new0(FDTIRQConnection, 1);
+                 *irq = (FDTIRQConnection) {
+                     .dev = DEVICE(dev),
+                     .name = gpio_name,
+                     .merge_fn = qemu_irq_shared_or_handler,
+                     .i = named_idx,
+                     .irq = output,
+                     .sink_info = NULL, /*FIXME */
+                     .next = fdti->irqs
+                 };
+                 fdti->irqs = irq;
+                 DB_PRINT_NP(1, "... GPIO output %s[%" PRId16 "]\n", gpio_name,
+                             named_idx);
+             }
+         }
+     }
+ 
+     if (dev_type) {
+         g_free(dev_type);
+     }
+ 
+     return 0;
+ }
+ 
+ static const TypeInfo fdt_generic_intc_info = {
+     .name          = TYPE_FDT_GENERIC_INTC,
+     .parent        = TYPE_INTERFACE,
+     .class_size = sizeof(FDTGenericIntcClass),
+ };
+ 
+ static const TypeInfo fdt_generic_mmap_info = {
+     .name          = TYPE_FDT_GENERIC_MMAP,
+     .parent        = TYPE_INTERFACE,
+     .class_size = sizeof(FDTGenericMMapClass),
+ };
+ 
+ static const TypeInfo fdt_generic_gpio_info = {
+     .name          = TYPE_FDT_GENERIC_GPIO,
+     .parent        = TYPE_INTERFACE,
+     .class_size = sizeof(FDTGenericGPIOClass),
+ };
+ 
+ static const TypeInfo fdt_generic_props_info = {
+     .name          = TYPE_FDT_GENERIC_PROPS,
+     .parent        = TYPE_INTERFACE,
+     .class_size = sizeof(FDTGenericPropsClass),
+ };
+ 
+ static const TypeInfo fdt_generic_helper_info = {
+     .name          = TYPE_FDT_GENERIC_HELPER,
+     .parent        = TYPE_INTERFACE,
+     .class_size = sizeof(FDTGenericHelperClass),
+ };
+ 
+ static void fdt_generic_intc_register_types(void)
+ {
+     type_register_static(&fdt_generic_intc_info);
+     type_register_static(&fdt_generic_mmap_info);
+     type_register_static(&fdt_generic_gpio_info);
+     type_register_static(&fdt_generic_props_info);
+     type_register_static(&fdt_generic_helper_info);
+ }
+ 
+ type_init(fdt_generic_intc_register_types)
+ 
\ No newline at end of file
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 27372bb01e..361da5978f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -375,6 +375,20 @@ static void machine_set_dtb(Object *obj, const char *value, Error **errp)
     ms->dtb = g_strdup(value);
 }
 
+static char *machine_get_hw_dtb(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->hw_dtb);
+}
+
+static void machine_set_hw_dtb(Object *obj, const char *value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->hw_dtb = g_strdup(value);
+}
+
 static char *machine_get_dumpdtb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1284,6 +1298,11 @@ static void machine_initfn(Object *obj)
     ms->ram_size = mc->default_ram_size;
     ms->maxram_size = mc->default_ram_size;
 
+    object_property_add_str(obj, "hw-dtb",
+        machine_get_hw_dtb, machine_set_hw_dtb);
+    object_property_set_description(obj, "hw-dtb",
+                "A device tree used to describe the hardware to QEMU.");
+
     if (mc->nvdimm_supported) {
         ms->nvdimms_state = g_new0(NVDIMMState, 1);
         object_property_add_bool(obj, "nvdimm",
diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0ed..cea3b4660e 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -28,6 +28,9 @@ system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutl
 
 system_ss.add(files(
   'cpu-system.c',
+  'fdt_generic.c',
+  'fdt_generic_devices.c',
+  'fdt_generic_util.c',
   'fw-path-provider.c',
   'gpio.c',
   'hotplug.c',
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a48ed4f86a..68711be386 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -402,6 +402,7 @@ struct MachineState {
 
     void *fdt;
     char *dtb;
+    char *hw_dtb;
     char *dumpdtb;
     int phandle_start;
     char *dt_compatible;
diff --git a/include/hw/fdt_generic.h b/include/hw/fdt_generic.h
new file mode 100644
index 0000000000..2376d459cd
--- /dev/null
+++ b/include/hw/fdt_generic.h
@@ -0,0 +1,126 @@
+/*
+ * Tables of FDT device models and their init functions. Keyed by compatibility
+ * strings, device instance names.
+ */
+
+#ifndef FDT_GENERIC_H
+#define FDT_GENERIC_H
+
+#include "qemu/help-texts.h"
+#include "hw/irq.h"
+#include "system/device_tree.h"
+#include "qemu/coroutine.h"
+
+/* This is the number of serial ports we have connected */
+extern int fdt_serial_ports;
+
+typedef struct FDTDevOpaque {
+    char *node_path;
+    void *opaque;
+} FDTDevOpaque;
+
+typedef struct FDTCPUCluster {
+    char *cpu_type;
+    void *cpu_cluster;
+    void *next;
+    bool user;
+} FDTCPUCluster;
+
+typedef struct FDTIRQConnection {
+    DeviceState *dev;
+    const char *name;
+    int i;
+    bool (*merge_fn)(bool *, int);
+    qemu_irq irq;
+    char *sink_info; /* Debug only */
+    void *next;
+} FDTIRQConnection;
+
+typedef struct FDTMachineInfo {
+    /* the fdt blob */
+    void *fdt;
+    /* irq descriptors for top level int controller */
+    qemu_irq *irq_base;
+    /* per-device specific opaques */
+    FDTDevOpaque *dev_opaques;
+    /* recheck coroutine queue */
+    CoQueue *cq;
+    /* list of all IRQ connections */
+    FDTIRQConnection *irqs;
+    /* list of all CPU clusters */
+    FDTCPUCluster *clusters;
+} FDTMachineInfo;
+
+/* create a new FDTMachineInfo. The client is responsible for setting irq_base.
+ * the mutex fdt_mutex is locked on return. Client must call
+ * fdt_init_destroy_fdti to cleanup
+ */
+
+FDTMachineInfo *fdt_init_new_fdti(void *fdt);
+void fdt_init_destroy_fdti(FDTMachineInfo *fdti);
+
+typedef int (*FDTInitFn)(char *, FDTMachineInfo *, void *);
+
+/* associate a FDTInitFn with a FDT compatibility */
+
+void add_to_compat_table(FDTInitFn, const char *, void *);
+
+/* try and find a device model for a particular compatibility. If found,
+ * the FDTInitFn associated with the compat will be called and 0 will
+ * be returned. Returns non-zero on not found or error
+ */
+
+int fdt_init_compat(char *, FDTMachineInfo *, const char *);
+
+/* same as above, but associates with a FDT node name (rather than compat) */
+
+void add_to_inst_bind_table(FDTInitFn, const char *, void *);
+int fdt_init_inst_bind(char *, FDTMachineInfo *, const char *);
+
+void dump_compat_table(void);
+void dump_inst_bind_table(void);
+
+/* Called from FDTInitFn's to inform the framework that a dependency is
+ * unresolved and the calling context needs to wait for another device to
+ * instantiate first. The calling thread will suspend until a change in state
+ * in the argument fdt machine is detected.
+ */
+
+void fdt_init_yield(FDTMachineInfo *);
+
+/* set, check and get per device opaques. Keyed by fdt node_paths */
+
+void fdt_init_set_opaque(FDTMachineInfo *fdti, char *node_path, void *opaque);
+int fdt_init_has_opaque(FDTMachineInfo *fdti, char *node_path);
+void *fdt_init_get_opaque(FDTMachineInfo *fdti, char *node_path);
+
+void *fdt_init_get_cpu_cluster(FDTMachineInfo *fdti, Object *parent, char *compat);
+void fdt_init_register_user_cpu_cluster(FDTMachineInfo *fdti, Object *cluster);
+
+/* statically register a FDTInitFn as being associate with a compatibility */
+
+#define fdt_register_compatibility_opaque(function, compat, n, opaque) \
+static void __attribute__((constructor)) \
+function ## n ## _register_imp(void) { \
+    add_to_compat_table(function, compat, opaque); \
+}
+
+#define fdt_register_compatibility_n(function, compat, n) \
+fdt_register_compatibility_opaque(function, compat, n, NULL)
+
+#define fdt_register_compatibility(function, compat) \
+fdt_register_compatibility_n(function, compat, 0)
+
+#define fdt_register_instance_opaque(function, inst, n, opaque) \
+static void __attribute__((constructor)) \
+function ## n ## _register_imp(void) { \
+    add_to_inst_bind_table(function, inst, opaque); \
+}
+
+#define fdt_register_instance_n(function, inst, n) \
+fdt_register_instance_opaque(function, inst, n, NULL)
+
+#define fdt_register_instance(function, inst) \
+fdt_register_instance_n(function, inst, 0)
+
+#endif /* FDT_GENERIC_H */
diff --git a/include/hw/fdt_generic_devices.h b/include/hw/fdt_generic_devices.h
new file mode 100644
index 0000000000..f5eada89b5
--- /dev/null
+++ b/include/hw/fdt_generic_devices.h
@@ -0,0 +1,22 @@
+#ifndef FDT_GENERIC_DEVICES_H
+#define FDT_GENERIC_DEVICES_H
+
+#include "fdt_generic.h"
+#include "exec/cpu-common.h"
+
+#if !defined(CONFIG_USER_ONLY)
+
+/* XXX: Hack to find the last range in a memory node.  */
+typedef struct FDTMemoryInfo {
+    unsigned int nr_regions;
+    ram_addr_t last_base;
+    ram_addr_t last_size;
+} FDTMemoryInfo;
+
+#endif
+
+int pflash_cfi01_fdt_init(char *node_path, FDTMachineInfo *fdti, void *opaque);
+
+extern int fdt_generic_num_cpus;
+
+#endif /* FDT_GENERIC_DEVICES_H */
diff --git a/include/hw/fdt_generic_util.h b/include/hw/fdt_generic_util.h
new file mode 100644
index 0000000000..231513c43f
--- /dev/null
+++ b/include/hw/fdt_generic_util.h
@@ -0,0 +1,283 @@
+#ifndef FDT_GENERIC_UTIL_H
+#define FDT_GENERIC_UTIL_H
+
+#include "qemu/help-texts.h"
+#include "fdt_generic.h"
+#include "system/memory.h"
+#include "qom/object.h"
+
+/* create a fdt_generic machine. the top level cpu irqs are required for
+ * systems instantiating interrupt devices. The client is responsible for
+ * destroying the returned FDTMachineInfo (using fdt_init_destroy_fdti)
+ */
+
+FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
+
+/* get an irq for a device. The interrupt parent of a device is idenitified
+ * and the specified irq (by the interrupts device-tree property) is retrieved
+ */
+
+qemu_irq *fdt_get_irq(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                      bool *map_mode);
+
+/* same as above, but poulates err with non-zero if something goes wrong, and
+ * populates info with a human readable string giving some basic information
+ * about the interrupt connection found (or not found). Both arguments are
+ * optional (i.e. can be NULL)
+ */
+
+qemu_irq *fdt_get_irq_info(FDTMachineInfo *fdti, char *node_path, int irq_idx,
+                           char * info, bool *map_mode);
+
+#define TYPE_FDT_GENERIC_INTC "fdt-generic-intc"
+
+#define FDT_GENERIC_INTC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(FDTGenericIntcClass, (klass), TYPE_FDT_GENERIC_INTC)
+#define FDT_GENERIC_INTC_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericIntcClass, (obj), TYPE_FDT_GENERIC_INTC)
+#define FDT_GENERIC_INTC(obj) \
+     INTERFACE_CHECK(FDTGenericIntc, (obj), TYPE_FDT_GENERIC_INTC)
+
+typedef struct FDTGenericIntc {
+    /*< private >*/
+    Object parent_obj;
+} FDTGenericIntc;
+
+typedef struct FDTGenericIntcClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    /**
+     * get irq - Based on the FDT generic interrupt binding for this device
+     * grab the irq(s) for the given interrupt cells description. In some device
+     * tree bindings (E.G. ARM GIC with its PPI) a single interrupt cell-tuple
+     * can describe more than one connection. So populates an array with all
+     * relevant IRQs.
+     *
+     * @obj - interrupt controller to get irqs input for ("interrupt-parent")
+     * @irqs - array to populate with irqs (must be >= @max length
+     * @cells - interrupt cells values. Must be >= ncells length
+     * @ncells - number of cells in @cells
+     * @max - maximum number of irqs to return
+     * @errp - Error condition
+     *
+     * @returns the number of interrupts populated in irqs. Undefined on error
+     * (use errp for error checking). If it is valid for the interrupt
+     * controller binding to specify no (or a disabled) connections it may
+     * return 0 as a non-error.
+     */
+
+    int (*get_irq)(FDTGenericIntc *obj, qemu_irq *irqs, uint32_t *cells,
+                   int ncells, int max, Error **errp);
+
+    /**
+     * auto_parent. An interrupt controller often infers its own interrupt
+     * parent (usually a CPU or CPU cluster. This function allows an interrupt
+     * controller to implement its own auto-connections. Is called if an
+     * interrupt controller itself (detected via "interrupt-controller") has no
+     * "interrupt-parent" node.
+     *
+     * @obj - Interrupt controller top attempt autoconnection
+     * @errp - Error condition
+     *
+     * FIXME: More arguments need to be added for partial descriptions
+     */
+
+    void (*auto_parent)(FDTGenericIntc *obj, Error **errp);
+
+} FDTGenericIntcClass;
+
+#define TYPE_FDT_GENERIC_MMAP "fdt-generic-mmap"
+
+#define FDT_GENERIC_MMAP_CLASS(klass) \
+     OBJECT_CLASS_CHECK(FDTGenericMMapClass, (klass), TYPE_FDT_GENERIC_MMAP)
+#define FDT_GENERIC_MMAP_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericMMapClass, (obj), TYPE_FDT_GENERIC_MMAP)
+#define FDT_GENERIC_MMAP(obj) \
+     INTERFACE_CHECK(FDTGenericMMap, (obj), TYPE_FDT_GENERIC_MMAP)
+
+typedef struct FDTGenericMMap {
+    /*< private >*/
+    Object parent_obj;
+} FDTGenericMMap;
+
+/* The number of "things" in the tuple. Not to be confused with the cell length
+ * of the tuple (which is variable based on content
+ */
+
+#define FDT_GENERIC_REG_TUPLE_LENGTH 4
+
+typedef struct FDTGenericRegPropInfo {
+    int n;
+    union {
+        struct {
+            uint64_t *a;
+            uint64_t *s;
+            uint64_t *b;
+            uint64_t *p;
+        };
+        uint64_t *x[FDT_GENERIC_REG_TUPLE_LENGTH];
+    };
+    Object **parents;
+} FDTGenericRegPropInfo;
+
+typedef struct FDTGenericMMapClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    bool (*parse_reg)(FDTGenericMMap *obj, FDTGenericRegPropInfo info,
+                      Error **errp);
+} FDTGenericMMapClass;
+
+#define TYPE_FDT_GENERIC_GPIO "fdt-generic-gpio"
+
+#define FDT_GENERIC_GPIO_CLASS(klass) \
+     OBJECT_CLASS_CHECK(FDTGenericGPIOClass, (klass), TYPE_FDT_GENERIC_GPIO)
+#define FDT_GENERIC_GPIO_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericGPIOClass, (obj), TYPE_FDT_GENERIC_GPIO)
+#define FDT_GENERIC_GPIO(obj) \
+     INTERFACE_CHECK(FDTGenericGPIO, (obj), TYPE_FDT_GENERIC_GPIO)
+
+typedef struct FDTGenericGPIO {
+    /*< private >*/
+    Object parent_obj;
+} FDTGenericGPIO;
+
+typedef struct FDTGenericGPIOConnection {
+    const char *name;
+    uint16_t fdt_index;
+    uint16_t range;
+} FDTGenericGPIOConnection;
+
+typedef struct FDTGenericGPIONameSet {
+    const char *propname;
+    const char *cells_propname;
+    const char *names_propname;
+} FDTGenericGPIONameSet;
+
+typedef struct FDTGenericGPIOSet {
+    const FDTGenericGPIONameSet *names;
+    const FDTGenericGPIOConnection *gpios;
+} FDTGenericGPIOSet;
+
+static const FDTGenericGPIONameSet fdt_generic_gpio_name_set_power_gpio = {
+    .propname = "power-gpios",
+    .cells_propname = "#gpio-cells",
+    .names_propname = "power-gpio-names",
+};
+
+static const FDTGenericGPIONameSet fdt_generic_gpio_name_set_reset_gpio = {
+    .propname = "reset-gpios",
+    .cells_propname = "#gpio-cells",
+    .names_propname = "reset-gpio-names",
+};
+
+static const FDTGenericGPIONameSet fdt_generic_gpio_name_set_resets = {
+    .propname = "resets",
+    .cells_propname = "#reset-cells",
+    .names_propname = "reset-names",
+};
+
+static const FDTGenericGPIONameSet fdt_generic_gpio_name_set_gpio = {
+    .propname = "gpios",
+    .cells_propname = "#gpio-cells",
+    .names_propname = "gpio-names",
+};
+
+static const FDTGenericGPIONameSet fdt_generic_gpio_name_set_clock = {
+    .propname = "clocks",
+    .cells_propname = "#clock-cells",
+    .names_propname = "clock-names",
+};
+
+static const FDTGenericGPIONameSet fdt_generic_gpio_name_set_interrupts = {
+    .propname = "interrupts-extended",
+    .cells_propname = "#interrupt-cells",
+    .names_propname = "interrupt-names",
+};
+
+static const FDTGenericGPIOSet default_gpio_sets [] = {
+    { .names = &fdt_generic_gpio_name_set_gpio },
+    {
+      .names = &fdt_generic_gpio_name_set_reset_gpio,
+      .gpios = (FDTGenericGPIOConnection[]) {
+        { .name = "rst_cntrl", .fdt_index = 0, .range = 6 },
+      },
+    },
+    {
+      .names = &fdt_generic_gpio_name_set_resets,
+      .gpios = (FDTGenericGPIOConnection[]) {
+        { .name = "rst_cntrl", .fdt_index = 0, .range = 6 },
+      },
+    },
+    {
+      .names = &fdt_generic_gpio_name_set_power_gpio,
+      .gpios = (FDTGenericGPIOConnection[]) {
+        { .name = "pwr_cntrl", .fdt_index = 0, .range = 1 },
+      },
+    },
+    { .names = &fdt_generic_gpio_name_set_clock },
+    { .names = &fdt_generic_gpio_name_set_interrupts },
+    { },
+};
+
+typedef struct FDTGenericGPIOClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    /**
+     * Unfortunately, FDT GPIOs aren't named. This allows a device to define
+     * a mapping between a QEMU named GPIO and the FDT GPIO lists. Client GPIOs
+     * name the GPIOs in the fdt 'gpios' property. E.G. An entry in this list
+     * with .name = "foo' and fdt_index = 0 would associated the first element
+     * in the gpios list with named gpio 'foo' on the device.
+     *
+     * controller_gpios is the same but for for gpio controllers. E.g. with the
+     * example above, gpio "foo" would bt the first gpio defined for the device.
+     */
+
+    const FDTGenericGPIOSet *controller_gpios;
+    const FDTGenericGPIOSet *client_gpios;
+} FDTGenericGPIOClass;
+
+#define TYPE_FDT_GENERIC_PROPS "fdt-generic-props"
+
+#define FDT_GENERIC_PROPS_CLASS(klass) \
+     OBJECT_CLASS_CHECK(FDTGenericPropsClass, (klass), \
+                        TYPE_FDT_GENERIC_PROPS)
+#define FDT_GENERIC_PROPS_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericPropsClass, (obj), \
+                     TYPE_FDT_GENERIC_PROPS)
+
+typedef struct FDTGenericPropsClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    void (*set_props)(Object *obj, Error **errp);
+} FDTGenericPropsClass;
+
+
+#define TYPE_FDT_GENERIC_HELPER "fdt-generic-helper"
+
+#define FDT_GENERIC_HELPER_CLASS(klass) \
+    OBJECT_CLASS_CHECK(FDTGenericHelperClass, (klass), \
+                       TYPE_FDT_GENERIC_HELPER)
+#define FDT_GENERIC_HELPER_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(FDTGenericHelperClass, (obj), \
+                     TYPE_FDT_GENERIC_HELPER)
+
+typedef struct FDTGenericHelperClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+
+    /* Return true if the device is ready to be realized */
+    bool (*ready_to_realize)(DeviceState *dev);
+} FDTGenericHelperClass;
+
+#endif /* FDT_GENERIC_UTIL_H */
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 60b8133009..8553abdda1 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -133,6 +133,7 @@ extern const PropertyInfo qdev_prop_link;
                 .bitmask    = (_bitmask),                     \
                 .set_default = false)
 
+#define PROP_ARRAY_LEN_PREFIX "len-"
 /**
  * DEFINE_PROP_ARRAY:
  * @_name: name of the array
diff --git a/include/net/net.h b/include/net/net.h
index 72b476ee1d..3908d8bcb4 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -309,6 +309,10 @@ struct NICInfo {
     int nvectors;
 };
 
+extern int nb_nics;
+extern NICInfo nd_table[MAX_NICS];
+extern const char *host_net_devices[];
+
 /* from net.c */
 extern NetClientStateList net_clients;
 bool netdev_is_modern(const char *optstr);
diff --git a/include/qemu/log.h b/include/qemu/log.h
index 7effba4da4..a0c3b12657 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -39,6 +39,9 @@ bool qemu_log_separate(void);
 #define LOG_TB_OP_PLUGIN   (1u << 22)
 #define LOG_INVALID_MEM    (1u << 23)
 
+/* device entries */
+#define LOG_FDT            (1 << 24)
+
 /* Lock/unlock output. */
 
 FILE *qemu_log_trylock(void) G_GNUC_WARN_UNUSED_RESULT;
diff --git a/include/system/blockdev.h b/include/system/blockdev.h
index 3211b16513..8d07f3a911 100644
--- a/include/system/blockdev.h
+++ b/include/system/blockdev.h
@@ -55,6 +55,8 @@ DriveInfo *drive_get(BlockInterfaceType type, int bus, int unit);
 void drive_check_orphaned(void);
 DriveInfo *drive_get_by_index(BlockInterfaceType type, int index);
 int drive_get_max_bus(BlockInterfaceType type);
+/* Xilinx: keep for fdt_generic */
+DriveInfo *drive_get_next(BlockInterfaceType type);
 
 QemuOpts *drive_add(BlockInterfaceType type, int index, const char *file,
                     const char *optstr);
diff --git a/include/system/device_tree.h b/include/system/device_tree.h
index 49d8482ed4..c6ad90f981 100644
--- a/include/system/device_tree.h
+++ b/include/system/device_tree.h
@@ -90,6 +90,13 @@ int qemu_fdt_setprop_string_array(void *fdt, const char *node_path,
 int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
                              const char *property,
                              const char *target_node_path);
+
+uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
+                                     const char *property, int offset,
+                                     int size, Error **errp);
+char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
+                              const char *property, int cell,
+                              bool inherit, Error **errp);
 /**
  * qemu_fdt_getprop: retrieve the value of a given property
  * @fdt: pointer to the device tree blob
@@ -100,24 +107,25 @@ int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
  *
  * returns a pointer to the property on success and NULL on failure
  */
-const void *qemu_fdt_getprop(void *fdt, const char *node_path,
-                             const char *property, int *lenp,
-                             Error **errp);
+void *qemu_fdt_getprop(void *fdt, const char *node_path,
+    const char *property, int *lenp,
+    bool inherit, Error **errp);
 /**
- * qemu_fdt_getprop_cell: retrieve the value of a given 4 byte property
- * @fdt: pointer to the device tree blob
- * @node_path: node path
- * @property: name of the property to find
- * @lenp: fdt error if any or -EINVAL if the property size is different from
- *        4 bytes, or 4 (expected length of the property) upon success.
- * @errp: handle to an error object
- *
- * returns the property value on success
- */
+* qemu_fdt_getprop_cell: retrieve the value of a given 4 byte property
+* @fdt: pointer to the device tree blob
+* @node_path: node path
+* @property: name of the property to find
+* @lenp: fdt error if any or -EINVAL if the property size is different from
+*        4 bytes, or 4 (expected length of the property) upon success.
+* @errp: handle to an error object
+*
+* returns the property value on success
+*/
 uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
-                               const char *property, int *lenp,
-                               Error **errp);
+      const char *property, int offset,
+      bool inherit, Error **errp);
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
+uint32_t qemu_fdt_check_phandle(void *fdt, const char *path);
 uint32_t qemu_fdt_alloc_phandle(void *fdt);
 int qemu_fdt_nop_node(void *fdt, const char *node_path);
 int qemu_fdt_add_subnode(void *fdt, const char *name);
@@ -192,6 +200,69 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fdt,
                                                 qdt_tmp);                 \
     })
 
+typedef struct QEMUDevtreeProp {
+    char *name;
+    int len;
+    void *value;
+} QEMUDevtreeProp;
+
+/* node queries */
+
+char *qemu_devtree_get_node_name(void *fdt, const char *node_path);
+int qemu_devtree_get_node_depth(void *fdt, const char *node_path);
+int qemu_devtree_get_num_children(void *fdt, const char *node_path, int depth);
+char **qemu_devtree_get_children(void *fdt, const char *node_path, int depth);
+int qemu_devtree_num_props(void *fdt, const char *node_path);
+QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path);
+QEMUDevtreeProp *qemu_devtree_prop_search(QEMUDevtreeProp *props,
+                                            const char *name);
+
+/* node getters */
+
+int qemu_devtree_node_by_compatible(void *fdt, char *node_path,
+                        const char *compats);
+int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
+                        const char *cmpname);
+int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int phandle);
+int qemu_devtree_getparent(void *fdt, char *node_path,
+                        const char *current);
+int qemu_devtree_get_root_node(void *fdt, char *node_path);
+
+/* qemu_devtree_get_child_by_name: Check for the matching node name under
+    * structural block of parent node and returns node path.
+    * args:
+    *     fdt: flatend device tree fp
+    *     parent_path : path of the parent, whose child to be searched
+    *     cmpname : node name of child
+    * return:
+    *     Node path of the child
+    * Note:
+    *     Returned string memory should be deallocated by g_free()
+    */
+char *qemu_devtree_get_child_by_name(void *fdt, char *parent_path,
+                                        const char *cmpname);
+
+/* qemu_devtree_get_n_nodes_by_name: Same as qemu_devtree_get_node_by_name but
+    * returns all the possible node paths matching the node name.
+    * args:
+    *     fdt: flatend device tree
+    *     array: pointer to hold array of strings
+    *     cmpname: node name to search for
+    * return:
+    *     Returns number of matching nodes found
+    * Note:
+    *     Array of strings should be released after usage. Each of the individual
+    *     strings in the array and the array itself should be released.
+    */
+int qemu_devtree_get_n_nodes_by_name(void *fdt, char ***array,
+                                        const char *cmpname);
+
+/* misc */
+
+int devtree_get_num_nodes(void *fdt);
+void devtree_info_dump(void *fdt);
+
+#define DT_PATH_LENGTH 1024
 
 /**
  * qemu_fdt_randomize_seeds:
diff --git a/net/net.c b/net/net.c
index 8aefdb3424..51d96f793a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -78,8 +78,8 @@ static NetdevQueue nd_queue = QSIMPLEQ_HEAD_INITIALIZER(nd_queue);
 
 static GHashTable *nic_model_help;
 
-static int nb_nics;
-static NICInfo nd_table[MAX_NICS];
+//static int nb_nics;
+//static NICInfo nd_table[MAX_NICS];
 
 /***********************************************************/
 /* network device redirectors */
diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74..10567c5c45 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4490,6 +4490,15 @@ SRST(initrd)
 
 ERST
 
+DEF("hw-dtb", HAS_ARG, QEMU_OPTION_hw_dtb, \
+    "-hw-dtb file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
+SRST
+``-hw-dtb file``
+    Use <file> as a device tree binary (dtb) image used to create the
+    emulated machine. This dtb will not be passed to the kernel, use -dtb
+    for that.
+ERST
+
 DEF("dtb", HAS_ARG, QEMU_OPTION_dtb, \
     "-dtb    file    use 'file' as device tree image\n", QEMU_ARCH_ALL)
 SRST
diff --git a/system/device_tree.c b/system/device_tree.c
index 7850b90fa7..7882a0b964 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qobject/qdict.h"
 #include "monitor/hmp.h"
+#include "qemu/log.h"
 
 #include <libfdt.h>
 
@@ -428,8 +429,9 @@ int qemu_fdt_setprop_string_array(void *fdt, const char *node_path,
     return ret;
 }
 
-const void *qemu_fdt_getprop(void *fdt, const char *node_path,
-                             const char *property, int *lenp, Error **errp)
+void *qemu_fdt_getprop(void *fdt, const char *node_path,
+                             const char *property, int *lenp,
+                             bool inherit, Error **errp)
 {
     int len;
     const void *r;
@@ -439,31 +441,109 @@ const void *qemu_fdt_getprop(void *fdt, const char *node_path,
     }
     r = fdt_getprop(fdt, findnode_nofail(fdt, node_path), property, lenp);
     if (!r) {
+        char parent[DT_PATH_LENGTH];
+        if (inherit && !qemu_devtree_getparent(fdt, parent, node_path)) {
+            return qemu_fdt_getprop(fdt, parent, property, lenp, true, errp);
+        }
         error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
                   node_path, property, fdt_strerror(*lenp));
+        return NULL;
     }
-    return r;
+    return g_memdup(r, *lenp);
 }
 
-uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
-                               const char *property, int *lenp, Error **errp)
+char *qemu_fdt_getprop_string(void *fdt, const char*node_path,
+                              const char *property, int cell,
+                              bool inherit, Error **errp)
 {
     int len;
-    const uint32_t *p;
+    void *prop;
+    Error *err= NULL;
 
-    if (!lenp) {
-        lenp = &len;
+    if (!errp) {
+        errp = &err;
+    }
+
+    prop = qemu_fdt_getprop(fdt, node_path, property, &len, inherit, errp);
+    if (*errp) {
+        return NULL;
+    }
+    while (cell) {
+        void *term = memchr(prop, '\0', len);
+        size_t diff;
+
+        if (!term) {
+            error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
+                      node_path, property, fdt_strerror(len));
+            return NULL;
+        }
+        diff = term - prop + 1;
+        len -= diff;
+        assert(len >= 0);
+        prop += diff;
+        cell--;
+    }
+
+    if (!len) {
+        return NULL;
+    }
+
+    if (!*(char *)prop) {
+        error_setg(errp, "%s: Couldn't get %s/%s: %s", __func__,
+                  node_path, property, fdt_strerror(len));
+        return NULL;
     }
-    p = qemu_fdt_getprop(fdt, node_path, property, lenp, errp);
-    if (!p) {
+    return prop;
+}
+
+uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
+                               const char *property, int offset,
+                               bool inherit, Error **errp)
+{
+    int len;
+    uint32_t ret;
+    uint32_t *p = qemu_fdt_getprop(fdt, node_path, property, &len,
+                                         inherit, errp);
+    if (errp && *errp) {
         return 0;
-    } else if (*lenp != 4) {
+    }
+    if (len < (offset+1)*4) {
         error_setg(errp, "%s: %s/%s not 4 bytes long (not a cell?)",
                    __func__, node_path, property);
-        *lenp = -EINVAL;
         return 0;
     }
-    return be32_to_cpu(*p);
+    ret = be32_to_cpu(p[offset]);
+    g_free(p);
+    return ret;
+}
+
+uint64_t qemu_fdt_getprop_sized_cell(void *fdt, const char *node_path,
+                                     const char *property, int offset,
+                                     int size, Error **errp)
+{
+    uint64_t ret = 0;
+    for (;size ;size--) {
+        ret <<= 32;
+        ret |= qemu_fdt_getprop_cell(fdt, node_path, property, offset++, false,
+                                     errp);
+        if (errp && *errp) {
+            return 0;
+        }
+    }
+    return ret;
+}
+
+uint32_t qemu_fdt_check_phandle(void *fdt, const char *path)
+{
+    uint32_t r;
+
+    r = fdt_get_phandle(fdt, findnode_nofail(fdt, path));
+    if (r == 0) {
+        qemu_log("%s: Couldn't find phandle for %s: %s", __func__,
+                 path, fdt_strerror(r));
+    }
+
+    return r;
 }
 
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
@@ -633,6 +713,277 @@ out:
     return ret;
 }
 
+char *qemu_devtree_get_node_name(void *fdt, const char *node_path)
+{
+    const char *ret = fdt_get_name(fdt, fdt_path_offset(fdt, node_path), NULL);
+    return ret ? strdup(ret) : NULL;
+}
+
+int qemu_devtree_get_node_depth(void *fdt, const char *node_path)
+{
+    return fdt_node_depth(fdt, fdt_path_offset(fdt, node_path));
+}
+
+
+int qemu_devtree_num_props(void *fdt, const char *node_path)
+{
+    int offset = fdt_path_offset(fdt, node_path);
+    int ret = 0;
+
+    for (offset = fdt_first_property_offset(fdt, offset);
+            offset != -FDT_ERR_NOTFOUND;
+            offset = fdt_next_property_offset(fdt, offset)) {
+        ret++;
+    }
+    return ret;
+}
+
+QEMUDevtreeProp *qemu_devtree_prop_search(QEMUDevtreeProp *props,
+                                          const char *name)
+{
+    while (props->name) {
+        if (!strcmp(props->name, name)) {
+            return props;
+        }
+        props++;
+    }
+    return NULL;
+}
+
+QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path)
+{
+    QEMUDevtreeProp *ret = g_new0(QEMUDevtreeProp,
+                                    qemu_devtree_num_props(fdt, node_path) + 1);
+    int offset = fdt_path_offset(fdt, node_path);
+    int i = 0;
+
+    for (offset = fdt_first_property_offset(fdt, offset);
+            offset != -FDT_ERR_NOTFOUND;
+            offset = fdt_next_property_offset(fdt, offset)) {
+        const char *propname;
+        const void *val = fdt_getprop_by_offset(fdt, offset, &propname,
+                                                    &ret[i].len);
+
+        ret[i].name = g_strdup(propname);
+        ret[i].value = g_memdup(val, ret[i].len);
+        i++;
+    }
+    return ret;
+}
+
+static void qemu_devtree_children_info(void *fdt, const char *node_path,
+        int depth, int *num, char **returned_paths) {
+    int offset = fdt_path_offset(fdt, node_path);
+    int root_depth = fdt_node_depth(fdt, offset);
+    int cur_depth = root_depth;
+
+    if (num) {
+        *num = 0;
+    }
+    for (;;) {
+        offset = fdt_next_node(fdt, offset, &cur_depth);
+        if (cur_depth <= root_depth) {
+            break;
+        }
+        if (cur_depth <= root_depth + depth || depth == 0) {
+            if (returned_paths) {
+                returned_paths[*num] = g_malloc0(DT_PATH_LENGTH);
+                fdt_get_path(fdt, offset, returned_paths[*num], DT_PATH_LENGTH);
+            }
+            if (num) {
+                (*num)++;
+            }
+        }
+    }
+}
+
+char **qemu_devtree_get_children(void *fdt, const char *node_path, int depth)
+{
+    int num_children = qemu_devtree_get_num_children(fdt, node_path, depth);
+    char **ret = g_malloc0(sizeof(*ret) * num_children);
+
+    qemu_devtree_children_info(fdt, node_path, depth, &num_children, ret);
+    return ret;
+}
+
+int qemu_devtree_get_num_children(void *fdt, const char *node_path, int depth)
+{
+    int ret;
+
+    qemu_devtree_children_info(fdt, node_path, depth, &ret, NULL);
+    return ret;
+}
+
+int qemu_devtree_node_by_compatible(void *fdt, char *node_path,
+                        const char *compats)
+{
+    int offset = fdt_node_offset_by_compatible(fdt, 0, compats);
+    return offset > 0 ?
+        fdt_get_path(fdt, offset, node_path, DT_PATH_LENGTH) : 1;
+}
+
+int qemu_devtree_get_node_by_name(void *fdt, char *node_path,
+        const char *cmpname) {
+    int offset = 0;
+    char *name = NULL;
+
+    do {
+        char *at;
+
+        offset = fdt_next_node(fdt, offset, NULL);
+        name = (void *)fdt_get_name(fdt, offset, NULL);
+        if (!name) {
+            continue;
+        }
+        at = memchr(name, '@', strlen(name));
+        if (!strncmp(name, cmpname, at ? at - name : strlen(name) )) {
+            break;
+        }
+    } while (offset > 0);
+    return offset > 0 ?
+        fdt_get_path(fdt, offset, node_path, DT_PATH_LENGTH) : 1;
+}
+
+int qemu_devtree_get_n_nodes_by_name(void *fdt, char ***array,
+                                     const char *cmpname)
+{
+    int offset = 0;
+    char *name = NULL;
+    uint32_t n = 0;
+    char node_p[DT_PATH_LENGTH];
+    char **node_path = NULL;
+
+    do {
+        char *at;
+
+        offset = fdt_next_node(fdt, offset, NULL);
+        name = (void *)fdt_get_name(fdt, offset, NULL);
+
+        if (!name) {
+            continue;
+        }
+
+        at = memchr(name, '@', strlen(name));
+        if (!strncmp(name, cmpname, at ? at - name : strlen(name))) {
+            if (fdt_get_path(fdt, offset, node_p, DT_PATH_LENGTH) >= 0) {
+                if (node_path == NULL) {
+                    node_path = (char **) g_new(char *, 1);
+                } else {
+                    node_path = (char **) g_renew(char *, *node_path, n);
+                }
+                node_path[n] = g_strdup(node_p);
+                n++;
+            }
+        }
+    } while (offset > 0);
+
+    *array = node_path;
+    return n;
+}
+
+char *qemu_devtree_get_child_by_name(void *fdt, char *parent_path,
+                                     const char *cmpname)
+{
+    int offset = 0;
+    int parent_offset;
+    int namelen = strlen(cmpname);
+    char child_path[DT_PATH_LENGTH];
+
+    parent_offset = fdt_path_offset(fdt, parent_path);
+
+    if (parent_offset > 0) {
+        offset = fdt_subnode_offset_namelen(fdt, parent_offset,
+                                            cmpname, namelen);
+        if (fdt_get_path(fdt, offset, child_path, DT_PATH_LENGTH) == 0) {
+            return g_strdup(child_path);
+        }
+    }
+
+    return NULL;
+}
+
+int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int phandle)
+{
+    return fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, phandle),
+                            node_path, DT_PATH_LENGTH);
+}
+
+int qemu_devtree_getparent(void *fdt, char *node_path, const char *current)
+{
+    int offset = fdt_path_offset(fdt, current);
+    int parent_offset = fdt_supernode_atdepth_offset(fdt, offset,
+        fdt_node_depth(fdt, offset) - 1, NULL);
+
+    return parent_offset >= 0 ?
+        fdt_get_path(fdt, parent_offset, node_path, DT_PATH_LENGTH) : 1;
+}
+
+int qemu_devtree_get_root_node(void *fdt, char *node_path)
+{
+    return fdt_get_path(fdt, 0, node_path, DT_PATH_LENGTH);
+}
+
+static void devtree_scan(void *fdt, int *num_nodes, int info_dump)
+{
+    int depth = 0, offset = 0;
+
+    if (num_nodes) {
+        *num_nodes = 0;
+    }
+    for (;;) {
+        offset = fdt_next_node(fdt, offset, &depth);
+        if (num_nodes) {
+            (*num_nodes)++;
+        }
+        if (offset <= 0 || depth <= 0) {
+            break;
+        }
+
+        if (info_dump) {
+            char node_path[DT_PATH_LENGTH];
+            char *all_compats = NULL;
+            int compat_len;
+            Error *errp = NULL;
+
+            if (fdt_get_path(fdt, offset, node_path, DT_PATH_LENGTH)) {
+                sprintf(node_path, "(none)");
+            } else {
+                all_compats = qemu_fdt_getprop(fdt, node_path, "compatible",
+                                               &compat_len, false, &errp);
+            }
+            if (!errp) {
+                char *i = all_compats;
+                for (;;) {
+                    char *j = memchr(i, '\0', DT_PATH_LENGTH);
+                    compat_len -= ((j+1)-i);
+                    if (!compat_len) {
+                        break;
+                    }
+                    *j = ' ';
+                    i = j+1;
+                }
+            }
+            printf("OFFSET: %d, DEPTH: %d, PATH: %s, COMPATS: %s\n",
+                    offset, depth, node_path,
+                    all_compats ? all_compats : "(none)");
+        }
+    }
+}
+
+void devtree_info_dump(void *fdt)
+{
+    devtree_scan(fdt, NULL, 1);
+}
+
+int devtree_get_num_nodes(void *fdt)
+{
+    int ret;
+
+    devtree_scan(fdt, &ret, 0);
+    return ret;
+}
+
+
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
     ERRP_GUARD();
diff --git a/system/globals.c b/system/globals.c
index 98f9876d5d..32869e65ed 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -46,6 +46,8 @@ int display_opengl;
 const char* keyboard_layout;
 MlockState mlock_state;
 bool enable_cpu_pm;
+int nb_nics;
+NICInfo nd_table[MAX_NICS];
 int autostart = 1;
 int vga_interface_type = VGA_NONE;
 bool vga_interface_created;
diff --git a/system/vl.c b/system/vl.c
index 5091fe52d9..c18306e914 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3021,6 +3021,9 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_dtb:
                 qdict_put_str(machine_opts_dict, "dtb", optarg);
                 break;
+            case QEMU_OPTION_hw_dtb:
+                qdict_put_str(machine_opts_dict, "hw-dtb", optarg);
+                break;
             case QEMU_OPTION_cdrom:
                 drive_add(IF_DEFAULT, 2, optarg, CDROM_OPTS);
                 break;
-- 
2.43.0


