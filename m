Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF89D19511
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd4-0001Z8-La; Mon, 26 Jan 2026 12:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQck-0001M1-6F
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQch-0008WD-IC
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so2766587f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449413; x=1770054213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aM6zWLKlmtgCmD6m3GCHJyyGI3WEHXBduIqZsS8oug=;
 b=c+0n3tco8qdT95arUobksKieFrqoh74Q8VZBGLeDG3+QcFLUAA1WV4hVz7Xk+KD+Mo
 wCpBkcJiMflrPpqFIWAMMoglKwaPr/du2L7NE1VzKWqhFD5MgvKy3Si7KkJT14Xxrsr6
 0GLnIRiHPIOtr2PPgoCC9ZfDCm1MZa2WNiLHVHfmSx3ZtwqfvWDJLM9WfHGBOdeP/dsY
 9ZD54wu0i+5iETvgrPXiSz9cnYh8GwFR2P+4yVSq03n7ZS7ZytuBJG87FY8sEwegKPv7
 AlY/2dyi6aErGFFYigkmPjUiGlc1EgDDffobJ3N4Ml/goHcIm+X8u1A/NwyO+gQynEM8
 UqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449413; x=1770054213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9aM6zWLKlmtgCmD6m3GCHJyyGI3WEHXBduIqZsS8oug=;
 b=P1qUtuQGfLCskQfuyJAvNVmM8Vb2r6h/wsKjDjmYpchXG4Eu2fO4HvOpI4nIFMzdUS
 3PwAFQnTmj5j9M6IYrl2vAhwoNcY0/H0OSZr1iRzJ+AvgjTw5idQ+CxDduZwYxT+OotN
 43mD3le1OiLyyGw/ZkBK+zI20ayy10FUgdNSHOtqLtJpvxemeuqhOXYgVWclLtKwrU4X
 DLWIET1serWkh/4eGFox0uHAt2j6RSak+N/qp5tC0s6sD+e9L7xh0mfsSoCafxf37jiM
 dloINRgbne/iZVLTHflBInAnFX4N7e3AbV7cho0i0QbIiYzMW02mAgIj4Tto1lVeFRZF
 dOhw==
X-Gm-Message-State: AOJu0Yw63n795NisgXs6fNdGf567mxvEJcL9REP87cMM1hu3YS2VEO1e
 qx1iBrPB5wrn35ASxDtEGyytdTLBSxOyq/fJWJHDUhLCIhiF2OGGeNWqstVrOJjn
X-Gm-Gg: AZuq6aLuWPVp/spgX6xylkPlVLsdZBVEeiGrSG1RZQFfc8fem2gqP6CFiwEoIJbcdep
 0CDnRWMDhW+61ugxJZDQHAqyjl25hL0oST8QYsGB7BaKa47MVMLc3dgaQLUZSrNSpipHCuYufAJ
 6jlX0DFJZG0aePWe8bmMCioho9qV/If0dxCYjAiWAVk0JOM0uAUARmAAwD8lGc2PjuHHS+4qc2u
 5n/+TO25DOmkVIau6tj737wloXb19u6CADHOQ8Vh6KDpnLQcg4KiH35XEDYPiOYdYqJhdb5Xy3T
 mIYpfHm4fQFTknOtGbzSF16KQbsmtOE1aUw16rOImXdrfDcpJFbyUwR0bQbYQ1/w07Aq4Dqd94W
 wiEWxNUZSeScQ7dm39o/fIT7JVCq4enZIntvQfI/7oCXbbwbJiGgfHGiFclFD+2GJmgFa4buwDX
 7EVAzmCeNgdIJrrNfDqJh5x8A5e7lAy+f9mH/9uA0SSWhK1A08UI4INCkZAigVuvdl
X-Received: by 2002:a05:6000:1849:b0:435:8fe2:e690 with SMTP id
 ffacd0b85a97d-435ca3a8ffdmr9751383f8f.58.1769449413091; 
 Mon, 26 Jan 2026 09:43:33 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:32 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 09/27] hw/core/fdt_generic_util: initilize qdev properties
 from fdt
Date: Mon, 26 Jan 2026 18:42:55 +0100
Message-ID: <20260126174313.1418150-10-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42d.google.com
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

The patch adds possibility to read and parse device tree
node properties and set them to newly created object.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 282 +++++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 74310e9eb3..c1d6ed9105 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -40,6 +40,7 @@
 #include "qemu/config-file.h"
 #include "hw/core/boards.h"
 #include "qemu/option.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/cpu/cluster.h"
 
 #ifndef FDT_GENERIC_UTIL_ERR_DEBUG
@@ -59,6 +60,8 @@
     } \
 } while (0)
 
+#define PROP_ARRAY_LEN_PREFIX "len-"
+
 /* FIXME: wrap direct calls into libfdt */
 
 #include <libfdt.h>
@@ -339,6 +342,25 @@ static Object *fdt_create_from_compat(const char *compat, char **dev_type)
     return ret;
 }
 
+/*FIXME: roll into device tree functionality */
+
+static inline uint64_t get_int_be(const void *p, int len)
+{
+    switch (len) {
+    case 1:
+        return *((uint8_t *)p);
+    case 2:
+        return be16_to_cpu(*((uint16_t *)p));
+    case 4:
+        return be32_to_cpu(*((uint32_t *)p));
+    case 8:
+        return be32_to_cpu(*((uint64_t *)p));
+    default:
+        fprintf(stderr, "unsupported integer length\n");
+        abort();
+    }
+}
+
 /*
  * Error handler for device creation failure.
  *
@@ -368,10 +390,248 @@ static void fdt_dev_error(FDTMachineInfo *fdti, char *node_path, char *compat)
     }
 }
 
+static void fdt_init_qdev_link_prop(Object *obj, ObjectProperty *p,
+                                    FDTMachineInfo *fdti,
+                                    const char *node_path,
+                                    const QEMUDevtreeProp *prop)
+{
+    int len = prop->len;
+    void *val = prop->value;
+    const char *propname = prop->name;
+
+    Object *linked_dev, *proxy;
+    char target_node_path[DT_PATH_LENGTH];
+    g_autofree char *propname_target = g_strconcat(propname, "-target", NULL);
+    Error *errp = NULL;
+
+    if (qemu_devtree_get_node_by_phandle(fdti->fdt, target_node_path,
+                                         get_int_be(val, len))) {
+        abort();
+    }
+
+    while (!fdt_init_has_opaque(fdti, target_node_path)) {
+        fdt_init_yield(fdti);
+    }
+    linked_dev = fdt_init_get_opaque(fdti, target_node_path);
+
+    proxy = linked_dev ? object_property_get_link(linked_dev,
+                                                  propname_target,
+                                                  &errp) : NULL;
+    if (!errp && proxy) {
+        DB_PRINT_NP(0, "detected proxy object for %s connection\n", propname);
+        linked_dev = proxy;
+    }
+
+    if (!linked_dev) {
+        return;
+    }
+
+    errp = NULL;
+    object_property_set_link(obj, propname, linked_dev, &errp);
+    if (errp) {
+        /* Unable to set the property, maybe it is a memory alias? */
+        MemoryRegion *alias_mr;
+        int offset = len / 2;
+        int region = 0;
+
+        if (len > 4) {
+            region = get_int_be(val + offset, len - offset);
+        }
+
+        alias_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(linked_dev), region);
+
+        object_property_set_link(obj, propname, OBJECT(alias_mr), &error_abort);
+
+    }
+
+    DB_PRINT_NP(0, "set link %s\n", propname);
+}
+
+static void fdt_init_qdev_scalar_prop(Object *obj, ObjectProperty *p,
+                                      FDTMachineInfo *fdti,
+                                      const char *node_path,
+                                      const QEMUDevtreeProp *prop)
+{
+    const char *propname = trim_vendor(prop->name);
+    void *val = prop->value;
+    int len = prop->len;
+
+    /* FIXME: handle generically using accessors and stuff */
+    if (!strncmp(p->type, "link", 4)) {
+        fdt_init_qdev_link_prop(obj, p, fdti, node_path, prop);
+        return;
+    }
+
+    if (!strcmp(p->type, "uint8") || !strcmp(p->type, "uint16") ||
+        !strcmp(p->type, "uint32") || !strcmp(p->type, "uint64") ||
+        !strcmp(p->type, "int8") || !strcmp(p->type, "int16") ||
+        !strcmp(p->type, "int32") || !strcmp(p->type, "int64")) {
+        object_property_set_int(obj, propname,
+                                get_int_be(val, len), &error_abort);
+        DB_PRINT_NP(0, "set property %s to 0x%llx\n", propname,
+                    (unsigned long long)get_int_be(val, len));
+        return;
+    }
+
+    if (!strcmp(p->type, "boolean") || !strcmp(p->type, "bool")) {
+        object_property_set_bool(obj, propname,
+                                 !!get_int_be(val, len), &error_abort);
+        DB_PRINT_NP(0, "set property %s to %s\n", propname,
+                    get_int_be(val, len) ? "true" : "false");
+        return;
+    }
+
+    if (!strcmp(p->type, "string") || !strcmp(p->type, "str")) {
+        object_property_set_str(obj, propname,
+                                (const char *)val, &error_abort);
+        DB_PRINT_NP(0, "set property %s to %s\n", propname, (const char *)val);
+        return;
+    }
+
+    DB_PRINT_NP(0, "WARNING: property is of unknown type\n");
+}
+
+static size_t fdt_array_elem_len(FDTMachineInfo *fdti,
+                                 const char *node_path,
+                                 const char *propname)
+{
+    g_autofree char *elem_cells_propname = NULL;
+    Error *err = NULL;
+    uint32_t elem_cells;
+
+    /*
+     * Default element size to 1 uint32_t cell, unless it is explicitly
+     * given in the same FDT node (not inherited).
+     */
+    elem_cells_propname = g_strconcat("#", propname, "-cells", NULL);
+    elem_cells = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                       elem_cells_propname, 0, false, &err);
+
+    return (err ? 1 : elem_cells) * 4;
+}
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
+{
+    /*
+     * Starting QEMU 8.2.0, the array-scheme has changed to be a single
+     * property of list.  See:
+     *   https://mail.gnu.org/archive/html/qemu-devel/2023-09/msg01832.html
+     *
+     * Thus, fdt_init_qdev_array_prop() below will have to be changed
+     * substantially.
+     *
+     * So for now, use a temporary hack to work around DEFINE_PROP_ARRAY() not
+     * creating the proper elements of type "link" (see set_prop_arraylen()).
+     */
+    g_autofree char *elem_name = g_strdup(e->name);
+    void *elem_ptr = object_field_prop_ptr(obj, e->opaque);
+
+    object_property_del(obj, elem_name);
+    e = object_property_add_link(obj, elem_name,
+                                 elem_link_type, elem_ptr,
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+
+    return e;
+}
+
+static void fdt_init_qdev_array_prop(Object *obj,
+                                     FDTMachineInfo *fdti,
+                                     const char *node_path,
+                                     QEMUDevtreeProp *prop)
+{
+    const char *propname = trim_vendor(prop->name);
+    int nr = prop->len;
+    Error *local_err = NULL;
+    char *len_name;
+    uint32_t elem_len;
+    g_autofree char *elem_link_type = NULL;
+    ObjectProperty *e;
+
+    if (!prop->value || !nr) {
+        return;
+    }
+
+    elem_len = fdt_array_elem_len(fdti, node_path, propname);
+    if (nr % elem_len) {
+        return;
+    }
+
+    nr /= elem_len;
+
+    /*
+     * Fail gracefully on setting the 'len-' property, due to:
+     * 1. The property does not exist, or
+     * 2. The property is not integer type, or
+     * 3. The property has been set, e.g., by the '-global' cmd option
+     */
+    len_name = g_strconcat(PROP_ARRAY_LEN_PREFIX, propname, NULL);
+    object_property_set_int(obj, len_name, nr, &local_err);
+    g_free(len_name);
+
+    if (local_err) {
+        error_free(local_err);
+        return;
+    }
+
+    e = fdt_array_elem_prop(obj, propname, 0);
+    if (!e) {
+        return;
+    }
+
+    elem_link_type = fdt_array_elem_type(e);
+
+    while (nr--) {
+        QEMUDevtreeProp q;
+
+        e = fdt_array_elem_prop(obj, propname, nr);
+        if (!e) {
+            continue;
+        }
+
+        q = (QEMUDevtreeProp){.name = e->name,
+                              .value = prop->value + nr * elem_len,
+                              .len = elem_len,
+                             };
+
+        if (elem_link_type) {
+            e = fdt_array_link_elem_prop(obj, e, elem_link_type);
+            q.name = e->name;
+            fdt_init_qdev_link_prop(obj, e, fdti, node_path, &q);
+        } else {
+            fdt_init_qdev_scalar_prop(obj, e, fdti, node_path, &q);
+        }
+    }
+}
+
 static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 {
     Object *dev, *parent;
     char *dev_type = NULL;
+    QEMUDevtreeProp *prop, *props;
     char parent_node_path[DT_PATH_LENGTH];
 
     if (!compat) {
@@ -459,6 +719,28 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     }
     fdt_init_set_opaque(fdti, node_path, dev);
 
+    props = qemu_devtree_get_props(fdti->fdt, node_path);
+    for (prop = props; prop->name; prop++) {
+        const char *propname = trim_vendor(prop->name);
+        ObjectProperty *p = NULL;
+
+        p = object_property_find(OBJECT(dev), propname);
+        if (p) {
+            DB_PRINT_NP(1, "matched property: %s of type %s, len %d\n",
+                                            propname, p->type, prop->len);
+        }
+        if (!p) {
+            fdt_init_qdev_array_prop(dev, fdti, node_path, prop);
+            continue;
+        }
+
+        if (!strcmp(propname, "type")) {
+            continue;
+        }
+
+        fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
+    }
+
     g_free(dev_type);
 
     return 0;
-- 
2.43.0


