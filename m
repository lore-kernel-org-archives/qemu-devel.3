Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BFCD6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q28-0008IK-OF; Thu, 02 Apr 2026 17:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q26-0008HA-2Y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q23-00074q-W7
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:57 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so215721366b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167014; x=1775771814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2VB2KnW0z4RzTP8lm44NrAlc23AvjlzFHSTzJSgaMs=;
 b=dT7VhH+maMdQnEJyyjkivkP8ududpkdHYEzmED5jlxC2kFmCxw1NkCgrRY+CxW4oKU
 jSaSmMAcpAI4p2LfgWUekO2GRcgLZZJ9RpIVXzj1JJ9uJvccuizUcMxke8ZPT/xLMfSJ
 vWZ3+SbXTk3eEWfH6IXhfMwqfBRh1LqZAoQfUgEuMHv3yugAH0V+vnVITwpnwatD+4Uj
 lf25Cx5as6tLI1w00VEYFPLurDL9ACz4FcMdGvEzCmxcHXi7R1Q3wqyawixvOtFXV34g
 GAHIgknnwlrzKjlFWIyJqugDVPiZs29xJkbaz7yUx5gtzyDd0fGCH7TLaTAltVDuSsmz
 9Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167014; x=1775771814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s2VB2KnW0z4RzTP8lm44NrAlc23AvjlzFHSTzJSgaMs=;
 b=J15QlmkZgjwl08cugVtP1JubC9+DlmjG+6YLA1XTKCgyEDW1pFKmrhgi89dLovQqq8
 WVphJ18rglsEycWYqIrUwB6kqw3whn1rPZW90tk1JfQPe+AHFl0H9BTgliLGpdCNhovt
 whj4ZrqfKCcpqb+I7dIGwB1rkDE4u/sroyZ0zMy6xSKihCQcHYsJkIGMSKPFSdQX2QVK
 75VH0YJXiwSu0LKRl+GZIkU3MNTGE24UkgHzmbYNeY9vsnbrHfH9S7mXgNupHqM9glW/
 fLUzakNhgmm2mYu/i+BVbv12hmC5NwuqaAl8RTjjo+zsUkCKRI5LQK4iL8SjLUKRUK9k
 +gbw==
X-Gm-Message-State: AOJu0YyFvdaGSg32uDOV7ZmT0RuEJWEAHuGfDb8Y4Dd7n+W3N2fbA41v
 u57ceWHv6jSFPAO7dt55bjQE1K7fPD5YXClYDQLbX0PSOPSTa7VCrUUFDx3Vkxph
X-Gm-Gg: ATEYQzwE7DgJCnMObvyiIw+xgxHLRU+Ch+MUW6QIOzoXFGtuDYM7cwUkq6Oul5nS1/K
 HH5ryWKDgYCj78lNTfpg6AQpnYCJnaBxu0v6dMKPj6QQCVA/iCr5k3y+gSrtbvQ21+G7NlmEe6G
 rkmC7MozWFcdwx+mgfDxH2ctecRmXeENEJ54Zfrs91gbTzNJy2bOE5S5YqkhWkbqDd3VQukvV4z
 lB1K69a31yveBsY18kXEYInle8lA/XSBJorhWMJZWqjwgNhvWvy46y3JGAzdnoIwXFigYHBaRSH
 O5BV6wuyk/1qmOEm9WM3zPSBKYyVBXowbNzSWWFw4uQcTIgyLkwr64WDJmTbvQcWs936OVli0DB
 Wi/ZUu8PDjPT3xn/Vj85LTo2n5KkD0WbUfiWLROm+jZXDVq1z9KTyouCjPq9sU7sqOVCGJcjhF/
 WOusNlxcsAXJ2nzBUnorCSRwkiZMV+rJ+7KLWoG1fVByb9q8zh2SjwKyWcnCgwCidmpvkW0Q==
X-Received: by 2002:a17:906:f581:b0:b9b:1b9e:1e99 with SMTP id
 a640c23a62f3a-b9c679580b6mr27709066b.34.1775167013952; 
 Thu, 02 Apr 2026 14:56:53 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:53 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 07/33] hw/core/fdt_generic_util: implement main fdt parse
 routine
Date: Thu,  2 Apr 2026 23:55:52 +0200
Message-ID: <20260402215629.745866-8-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x636.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement main fdt_generic_create_machine() routine.

As of now do the following:

- parse each node and subnode in device tree
- check node has correct compatible or device types
- call fdt_init_qdev() which will eventually create
  device object.

The MIT license of fdt_generic_util.c preserved as in original
file from https://github.com/Xilinx/qemu.git repo.

The license for fdt_generic_util.h derived from matching
fdt_generic_util.c file.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c         | 233 +++++++++++++++++++++++++++++
 include/hw/core/fdt_generic_util.h |  19 +++
 2 files changed, 252 insertions(+)
 create mode 100644 hw/core/fdt_generic_util.c
 create mode 100644 include/hw/core/fdt_generic_util.h

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
new file mode 100644
index 0000000000..2f7a3fc3dd
--- /dev/null
+++ b/hw/core/fdt_generic_util.c
@@ -0,0 +1,233 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
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
+#include "qemu/osdep.h"
+#include "hw/core/fdt_generic_util.h"
+#include "system/memory.h"
+#include "system/address-spaces.h"
+#include "hw/core/sysbus.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "system/system.h"
+#include "system/reset.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+#include "qemu/config-file.h"
+#include "hw/core/boards.h"
+#include "qemu/option.h"
+
+#define fdt_debug(...) do { \
+    qemu_log_mask(LOG_FDT, ": %s: ", __func__); \
+    qemu_log_mask(LOG_FDT, ## __VA_ARGS__); \
+} while (0)
+
+#define fdt_debug_np(...) do { \
+    qemu_log_mask(LOG_FDT, "%s", node_path); \
+    fdt_debug(__VA_ARGS__); \
+} while (0)
+
+/* FIXME: wrap direct calls into libfdt */
+
+#include <libfdt.h>
+#include <stdlib.h>
+
+static int fdt_generic_num_cpus;
+
+static int simple_bus_fdt_init(const char *bus_node_path, FDTMachineInfo *fdti);
+
+FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq)
+{
+    FDTMachineInfo *fdti = fdt_init_new_fdti(fdt);
+
+    fdti->irq_base = cpu_irq;
+
+    /* parse the device tree */
+    memory_region_transaction_begin();
+    fdt_init_set_opaque(fdti, "/", NULL);
+    simple_bus_fdt_init("/", fdti);
+    while (qemu_co_enter_next(fdti->cq, NULL)) {
+        ;
+    }
+    memory_region_transaction_commit();
+
+    /* FIXME: Populate these from DTS and create CPU clusters.  */
+    current_machine->smp.cores = fdt_generic_num_cpus;
+    current_machine->smp.cpus = fdt_generic_num_cpus;
+    current_machine->smp.max_cpus = fdt_generic_num_cpus;
+
+    fdt_debug("FDT: Device tree scan complete\n");
+    return fdti;
+}
+
+struct FDTInitNodeArgs {
+    char *node_path;
+    char *parent_path;
+    FDTMachineInfo *fdti;
+};
+
+static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat);
+
+static int check_compat(const char *prefix, const char *compat,
+                        char *node_path, FDTMachineInfo *fdti)
+{
+    char *compat_prefixed = g_strconcat(prefix, compat, NULL);
+    const int done = !fdt_init_compat(node_path, fdti, compat_prefixed);
+    g_free(compat_prefixed);
+    return done;
+}
+
+static void fdt_init_node(void *args)
+{
+    struct FDTInitNodeArgs *a = args;
+    char *node_path = a->node_path;
+    FDTMachineInfo *fdti = a->fdti;
+    g_free(a);
+
+    simple_bus_fdt_init(node_path, fdti);
+
+    const char *prop;
+    char *all_compats = NULL, *node_name;
+    char *device_type = NULL;
+    int prop_len;
+
+    fdt_debug_np("enter\n");
+
+    /* try instance binding first */
+    node_name = strrchr(node_path, '/') + 1;
+    fdt_debug_np("node with name: %s\n", node_name ? node_name : "(none)");
+    if (!node_name) {
+        fdt_debug("FDT: ERROR: nameless node: %s\n", node_path);
+    }
+    if (!fdt_init_inst_bind(node_path, fdti, node_name)) {
+        fdt_debug_np("instance bind successful\n");
+        goto exit;
+    }
+
+    /* fallback to compatibility binding */
+    prop = qemu_fdt_getprop(fdti->fdt, node_path, "compatible",
+                                       &prop_len, NULL);
+    all_compats = g_memdup2(prop, prop_len);
+    if (all_compats) {
+        char *compat = all_compats;
+        char * const end = &all_compats[prop_len - 1]; /* points to nul */
+
+        while (compat < end) {
+            if (check_compat("compatible:", compat, node_path, fdti)) {
+                goto exit;
+            }
+
+            if (!fdt_init_qdev(node_path, fdti, compat)) {
+                check_compat("postinit:", compat, node_path, fdti);
+                goto exit;
+            }
+
+            /* Scan forward to the end of the current compat. */
+            while (compat < end && *compat) {
+                ++compat;
+            }
+
+            /* Replace nul with space for the debug printf below. */
+            if (compat < end) {
+                *compat++ = ' ';
+            }
+        };
+    } else {
+        fdt_debug_np("no compatibility found\n");
+    }
+
+    /*
+     * Try to create the device using device_type property
+     * Not every device tree node has compatible  property, so
+     * try with device_type.
+     */
+    prop = qemu_fdt_getprop(fdti->fdt, node_path,
+                            "device_type", &prop_len, NULL);
+    device_type = g_memdup2(prop, prop_len);
+    if (device_type) {
+        if (check_compat("device_type:", device_type, node_path, fdti)) {
+            goto exit;
+        }
+
+        if (!fdt_init_qdev(node_path, fdti, device_type)) {
+            goto exit;
+        }
+    }
+
+    if (all_compats) {
+        fdt_debug_np("FDT: Unsupported peripheral invalidated - "
+                    "compatibilities %s\n", all_compats);
+        qemu_fdt_setprop_string(fdti->fdt, node_path, "compatible",
+                                "invalidated");
+    }
+exit:
+
+    fdt_debug_np("exit\n");
+
+    if (!fdt_init_has_opaque(fdti, node_path)) {
+        fdt_init_set_opaque(fdti, node_path, NULL);
+    }
+    g_free(node_path);
+    g_free(all_compats);
+    g_free(device_type);
+    return;
+}
+
+static int simple_bus_fdt_init(const char *node_path, FDTMachineInfo *fdti)
+{
+    int i;
+    char **children;
+    int num_children = qemu_devtree_get_num_children(fdti->fdt, node_path);
+
+    if (num_children <= 0) {
+        return 0;
+    }
+
+    children = g_malloc0(sizeof(*children) * num_children);
+
+    num_children = qemu_devtree_get_children(fdti->fdt, node_path, num_children,
+                                             children);
+
+    fdt_debug_np("num child devices: %d\n", num_children);
+
+    for (i = 0; i < num_children; i++) {
+        struct FDTInitNodeArgs *init_args = g_malloc0(sizeof(*init_args));
+        init_args->node_path = children[i];
+        init_args->fdti = fdti;
+        qemu_coroutine_enter(qemu_coroutine_create(fdt_init_node, init_args));
+    }
+
+    g_free(children);
+    return 0;
+}
+
+static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
+{
+    return 0;
+}
+
diff --git a/include/hw/core/fdt_generic_util.h b/include/hw/core/fdt_generic_util.h
new file mode 100644
index 0000000000..71bedb6631
--- /dev/null
+++ b/include/hw/core/fdt_generic_util.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef FDT_GENERIC_UTIL_H
+#define FDT_GENERIC_UTIL_H
+
+#include "qemu/help-texts.h"
+#include "fdt_generic.h"
+#include "system/memory.h"
+#include "qom/object.h"
+
+/*
+ * create a fdt_generic machine. the top level cpu irqs are required for
+ * systems instantiating interrupt devices. The client is responsible for
+ * destroying the returned FDTMachineInfo (using fdt_init_destroy_fdti)
+ */
+
+FDTMachineInfo *fdt_generic_create_machine(void *fdt, qemu_irq *cpu_irq);
+
+#endif /* FDT_GENERIC_UTIL_H */
-- 
2.43.0


