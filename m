Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A833DD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd4-0001Ys-2A; Mon, 26 Jan 2026 12:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcj-0001Lk-7m
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:40 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcg-0008Vr-CH
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so40893925e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449412; x=1770054212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlJN0+7cHw6gzdkYqCEdBJkW8sO5/Cp3u22Anlum/aE=;
 b=Q0DTvAeUbjYRbljlEhRA4E+YWADBpxiA72//BNwDQv1Hjh+87pEtwO02UGTkfV7YA9
 xz2Ps/awO13k3jyF5a2Wwfmp4xGuKx53CAQ1IYzpAT7OJ6ThsIttK0pVJ31c3fhFuTxI
 d3decElPRAcC29OQJNgXhlgVtLcLN1bcCBKvhb7HoRyaho/Q4TNMZ8m8mWJJQ+tMhrX4
 jaNJ96cETZ8UQCOXv+92wXtvf6XlX3klI1IG1lxlfXfqKuhGs+qPP/rlsduNjNzaiRpv
 wbN3nqmQkaVjyL0UhVr6VcrDHy0lwZJ5nNiSJm8NxWoGOFuQkpjJQ3PHbkIA3xTa4C3w
 xNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449412; x=1770054212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BlJN0+7cHw6gzdkYqCEdBJkW8sO5/Cp3u22Anlum/aE=;
 b=ejG/K0jjC5jFLEOHeKR7NlCSOLRxQUD0Asii1MlNa3zsyQAgXZSnXzBmFOzbyKMsVY
 mS/YZrBDC8aVxT5t7GbvehEYou3eBnMYRfCCVtvFUJK3uyBkHfwzmHOT9s8AEeymCkFh
 YYs2nkwmha9RkzTemnaSiKyL1MrzidZgDaIobLaGgVk0d86uquwDoM4qkhemGsDzLruP
 xNr04X/pJr2sJqpdM6LyPZEte7/zdT58KAv5GK1YtHaREfRcnIaprWo5jBk06Lkc5x3z
 cU2XR6peTYxXvHufj6xpMZ/oP0Bq3jxYAIXjiC8TepgOUUcSiR1hgTtsf28C2VZHF8iG
 VelA==
X-Gm-Message-State: AOJu0Yxu+YOh6uElJiNITB+f/bffXatPBJ3CESLIjRiljDRCuIAQqjLI
 FQNevcDUjPbch6pJONwdPaU50nvOlTGNEqmkxdYc9p8iTpp4J/JT6LwzGZNrQ2VX
X-Gm-Gg: AZuq6aJN+jP2fqJ9EhQHdH64B3qIhtk7SB3N8NB/Z+7cTIK+b+l7+6VwxQ1RuWr8AP7
 wII6Ep3WIi7YHCix+fpfZr2PeOXJD8A14HyUgWcSPBieu1IguO52QM+RMoXTyx+DCFOhlzi0m02
 JXDUxKeM4PAU4dZQG1gAEeYnuw9TH1KxBf9ShEBWD6HGNsAymMgpWES+F6TbBgG5JJMe1dg0tz7
 /OHgzHWODIk+A/zaUqeW+sl79zeDrMJH5wpsQzpI26MEovxFAjYKp3dWH1H1cfTyItQl3fpxMQP
 h4LU/+xJUXCOsX0vPg79UzJK0akYYRbMVVEdUEz5I1K317z7ZmFtcnUnIV2HmEwZkYCkrb4OEzS
 HYEYN9/LXaXhgYniTvwyXoBepyIF1Hpgz+wxng4nZn6ZP2zS2NmX9NRzLLpZnwdZ13gJCLLAVLx
 qNFCtK+a3eM7AtQR6h7hTYtD1xRoBENWVN7UAY5+rRqE8stX7LeZ3lXg==
X-Received: by 2002:a05:600c:4f09:b0:480:4a5a:bd53 with SMTP id
 5b1f17b1804b1-4805cf5f8famr77269185e9.21.1769449411982; 
 Mon, 26 Jan 2026 09:43:31 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:31 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 08/27] hw/core/fdt_generic_util: implement fdt_init_qdev
Date: Mon, 26 Jan 2026 18:42:54 +0100
Message-ID: <20260126174313.1418150-9-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x330.google.com
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

Implement main routine to create device object from
compat.

The following steps implemented:

- parse node compatible and device types
- try to create object from compat
- set correct parent based on device tree.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 224 +++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 4338dc956b..74310e9eb3 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -40,6 +40,7 @@
 #include "qemu/config-file.h"
 #include "hw/core/boards.h"
 #include "qemu/option.h"
+#include "hw/cpu/cluster.h"
 
 #ifndef FDT_GENERIC_UTIL_ERR_DEBUG
 #define FDT_GENERIC_UTIL_ERR_DEBUG 3
@@ -235,8 +236,231 @@ static int simple_bus_fdt_init(char *node_path, FDTMachineInfo *fdti)
     return 0;
 }
 
+/* FIXME: figure out a real solution to this */
+
+#define DIGIT(a) ((a) >= '0' && (a) <= '9')
+#define LOWER_CASE(a) ((a) >= 'a' && (a) <= 'z')
+
+static void trim_version(char *x)
+{
+    long result;
+
+    for (;;) {
+        x = strchr(x, '-');
+        if (!x) {
+            return;
+        }
+        if (DIGIT(x[1])) {
+            /* Try to trim Xilinx version suffix */
+            const char *p;
+
+            qemu_strtol(x + 1, &p, 0, &result);
+
+            if (*p == '.') {
+                *x = 0;
+                return;
+            } else if (*p == 0) {
+                return;
+            }
+        } else if (x[1] == 'r' && x[3] == 'p') {
+            /* Try to trim ARM version suffix */
+            if (DIGIT(x[2]) && DIGIT(x[4])) {
+                *x = 0;
+                return;
+            }
+        }
+        x++;
+    }
+}
+
+static void substitute_char(char *s, char a, char b)
+{
+    for (;;) {
+        s = strchr(s, a);
+        if (!s) {
+            return;
+        }
+        *s = b;
+        s++;
+    }
+}
+
+static inline const char *trim_vendor(const char *s)
+{
+    /* FIXME: be more intelligent */
+    const char *ret = memchr(s, ',', strlen(s));
+    return ret ? ret + 1 : s;
+}
+
+static Object *fdt_create_from_compat(const char *compat, char **dev_type)
+{
+    Object *ret = NULL;
+    char *c = g_strdup(compat);
+
+    /* Try to create the object */
+    ret = object_new(c);
+
+    if (!ret) {
+        /* Trim the version off the end and try again */
+        trim_version(c);
+        ret = object_new(c);
+
+        if (!ret) {
+            /* Replace commas with full stops */
+            substitute_char(c, ',', '.');
+            ret = object_new(c);
+        }
+    }
+
+    if (!ret) {
+        /*
+         * Restart with the orginal string and now replace commas with full
+         * stops and try again. This means that versions are still included.
+         */
+        g_free(c);
+        c = g_strdup(compat);
+        substitute_char(c, ',', '.');
+        ret = object_new(c);
+    }
+
+    if (dev_type) {
+        *dev_type = c;
+    } else {
+        g_free(c);
+    }
+
+    if (!ret) {
+        const char *no_vendor = trim_vendor(compat);
+
+        if (no_vendor != compat) {
+            return fdt_create_from_compat(no_vendor, dev_type);
+        }
+    }
+    return ret;
+}
+
+/*
+ * Error handler for device creation failure.
+ *
+ * We look for qemu-fdt-abort-on-error properties up the tree.
+ * If we find one, we abort with the provided error message.
+ */
+static void fdt_dev_error(FDTMachineInfo *fdti, char *node_path, char *compat)
+{
+    const char *abort_on_error;
+    const char *warn_on_error;
+
+    warn_on_error = qemu_fdt_getprop(fdti->fdt, node_path,
+                                   "qemu-fdt-warn-on-error", 0,
+                                   true, NULL);
+    abort_on_error = qemu_fdt_getprop(fdti->fdt, node_path,
+                                   "qemu-fdt-abort-on-error", 0,
+                                   true, NULL);
+    if (warn_on_error) {
+        if (strncmp("device_type", compat, strlen("device_type"))) {
+            warn_report("%s: %s", compat, warn_on_error);
+        }
+    }
+
+    if (abort_on_error) {
+        error_report("Failed to create %s", compat);
+        error_setg(&error_fatal, "%s", abort_on_error);
+    }
+}
+
 static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
+    Object *dev, *parent;
+    char *dev_type = NULL;
+    char parent_node_path[DT_PATH_LENGTH];
+
+    if (!compat) {
+        return 1;
+    }
+    dev = fdt_create_from_compat(compat, &dev_type);
+    if (!dev) {
+        DB_PRINT_NP(1, "no match found for %s\n", compat);
+        fdt_dev_error(fdti, node_path, compat);
+        return 1;
+    }
+    DB_PRINT_NP(1, "matched compat %s\n", compat);
+
+    /* Do this super early so fdt_generic_num_cpus is correct ASAP */
+    if (object_dynamic_cast(dev, TYPE_CPU)) {
+        fdt_generic_num_cpus++;
+        DB_PRINT_NP(0, "is a CPU - total so far %d\n", fdt_generic_num_cpus);
+    }
+
+    if (qemu_devtree_getparent(fdti->fdt, parent_node_path, node_path)) {
+        abort();
+    }
+    while (!fdt_init_has_opaque(fdti, parent_node_path) &&
+           !object_dynamic_cast(dev, TYPE_CPU)) {
+        fdt_init_yield(fdti);
+    }
+
+    parent = fdt_init_get_opaque(fdti, parent_node_path);
+
+    if (object_dynamic_cast(dev, TYPE_CPU)) {
+        parent = fdt_init_get_cpu_cluster(fdti, parent, compat);
+    }
+
+    if (dev->parent) {
+        DB_PRINT_NP(0, "Node already parented - skipping node\n");
+    } else if (parent) {
+        DB_PRINT_NP(1, "parenting node\n");
+        object_property_add_child(OBJECT(parent),
+                              qemu_devtree_get_node_name(fdti->fdt, node_path),
+                              OBJECT(dev));
+        if (object_dynamic_cast(dev, TYPE_DEVICE)) {
+            Object *parent_bus = parent;
+            unsigned int depth = 0;
+
+            DB_PRINT_NP(1, "bus parenting node\n");
+            /* Look for an FDT ancestor that is a Bus.  */
+            while (parent_bus && !object_dynamic_cast(parent_bus, TYPE_BUS)) {
+                /*
+                 * Assert against insanely deep hierarchies which are an
+                 * indication of loops.
+                 */
+                assert(depth < 4096);
+
+                parent_bus = parent_bus->parent;
+                depth++;
+            }
+
+            if (!parent_bus
+                && object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+                /*
+                 * Didn't find any bus. Use the default sysbus one.
+                 * This allows ad-hoc busses belonging to sysbus devices to be
+                 * visible to -device bus=x.
+                 */
+                parent_bus = OBJECT(sysbus_get_default());
+            }
+
+            if (parent_bus) {
+                qdev_set_parent_bus(DEVICE(dev), BUS(parent_bus),
+                                    &error_abort);
+            }
+        }
+    } else {
+        DB_PRINT_NP(1, "orphaning node\n");
+        if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
+            qdev_set_parent_bus(DEVICE(dev), BUS(sysbus_get_default()),
+                                &error_abort);
+        }
+
+        /* FIXME: Make this go away (centrally) */
+        object_property_add_child(
+                              object_get_root(),
+                              qemu_devtree_get_node_name(fdti->fdt, node_path),
+                              OBJECT(dev));
+    }
+    fdt_init_set_opaque(fdti, node_path, dev);
+
+    g_free(dev_type);
+
     return 0;
 }
 
-- 
2.43.0


