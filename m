Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D6AD6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2N-0008MR-2R; Thu, 02 Apr 2026 17:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2C-0008KU-TA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:06 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2A-000775-Tb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:04 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b982518b73fso207710766b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167021; x=1775771821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvbFky2zZfy6uWbutZgX2420LHSIwSgmweRO7s9n4J0=;
 b=imBtiMBTvEe6pleliwXgPhkyV1IOv/ClelSRewE6e0Qy4szFUBpdES+KYN9gmeaNg6
 yY7YbulxREdkD4ObUSeDzP6ABZch50UqbknJmaEZgTSIesZA+Anlmgvv4YWHf1CCliw/
 m9Qg9uWjMgG5g5ZqJ1BV/sNTMcGFUvFtnasaesgS+YvLi0h8RE/WPVr0MtnSguqE+CMV
 yoOsKUOZPU8MAaEsP/4d9vwYXPcD/A8r6b3GcJ/GvfD9C2qdmVUVIyC1KIjiODSbzX3e
 /WJoShwGu1OdYeO9JKR4goe0xagFWJPmrki6cfJ+kbbSB5PXtrt29/nsvqhkxWNUq5PT
 vwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167021; x=1775771821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvbFky2zZfy6uWbutZgX2420LHSIwSgmweRO7s9n4J0=;
 b=DPzr1+WbBMpZo+Wgjc7tGJAqWIpp676UDUs3JyHJ5a8pAKMqW8R8UP39WQZQhDZyIr
 aCsmN8rcEXKMJERpDaWkh/Cl0+prGvYrxHkpvVveDxZ1/DoX2Pd+6QN7npEL5LaNM2sQ
 Zs54RqfVgbGVwlR3sJziKZHLqTJwAfqk1LS5G9efuUzm/RBaBX3J5MYPbHf6+SDFsAGW
 EtgauxgKcuScJsYvbRcRANLjtmnZcqDYq45QWDsx+SbK5diE19vu5/OtIqwAPRAvBG3q
 4skvuuV+LHK60+YqOH085pH7OEaegXE7xCgYdhTPIvgG9j7NSfA0XOY6BrnH1EQBkas6
 wDAQ==
X-Gm-Message-State: AOJu0Yzs5J8pLd9Ie5dPmGbQVZLyFFUb4RNNXKYumIepDfeHCgdPmee8
 iJpUgTNugfmstjcqwjnAYemD0LcVYazKOYiWix6LpLXzC9PCARzJqNK34J/Dskxo
X-Gm-Gg: ATEYQzyxzQpA+jyqWadrzvHGpZNGm1uxVQGUuP2HiqkExaPImKomSesRpHOHgYm20X9
 2I5q80h+qLLCfJaDjt0Rz8FX3AkIkXHIfZZUVxEDZpoXkkKj4Q92ufa0M7qzs38QehTN2qflXVs
 dou+QUPZSRh5cc6L1PiAqoaC9mKmbvbU2m0A5SGPnd6+7as0IoyaCt7EonztDueyAtFKIcGk5cT
 ggqvj9WJmAtpwd0+cVv0VsH+TmJSoLTZoWKxhJTMTXJnrR+aTC2nSFSXhLYoCvw4Ek5UkhjoEM8
 P5/Erxpw6RdWp8gSQ1EZKxwJOSA9JGv5UCuOgZhuBCFbT0Z4dq2eoFKM3kjia/1Jb3ZwBpxzSFH
 NQ7IgGvgvVZkioV/mVH5JDBsjzTcH8XdydjMaFjgEeM1rInjhRCsK9sRkN9AEhnXa0vXTw3v4JD
 NqwhxgdzAuVzDGiMdltHBkWP4CBnOr+vtNqVJBDuTAk76bdcWyMcNhehbfEqvdAVZZ+dL+PQ==
X-Received: by 2002:a17:907:894f:b0:b98:5648:e68a with SMTP id
 a640c23a62f3a-b9c679b35d8mr25738366b.36.1775167020939; 
 Thu, 02 Apr 2026 14:57:00 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:00 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 11/33] hw/core/fdt_generic_util: initilize qdev properties
 from fdt
Date: Thu,  2 Apr 2026 23:55:56 +0200
Message-ID: <20260402215629.745866-12-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62a.google.com
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
 hw/core/fdt_generic_util.c | 236 +++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 565f577238..6f0a1e1e4b 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -41,7 +41,9 @@
 #include "qemu/config-file.h"
 #include "hw/core/boards.h"
 #include "qemu/option.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/cpu/cluster.h"
+#include "qobject/qlist.h"
 
 #define fdt_debug(...) do { \
     qemu_log_mask(LOG_FDT, ": %s: ", __func__); \
@@ -250,6 +252,238 @@ static Object *fdt_create_from_compat(const char *compat)
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
+static void fdt_init_qdev_link_prop(Object *obj, ObjectProperty *p,
+                                    FDTMachineInfo *fdti,
+                                    const char *node_path,
+                                    const char *propname, const void* val,
+                                    int len)
+{
+    Object *linked_dev;
+    char target_node_path[DT_PATH_LENGTH];
+    Error *errp = NULL;
+
+    if (qemu_devtree_get_node_by_phandle(fdti->fdt, target_node_path,
+                                         get_int_be(val, len))) {
+        error_report("FDT: Invalid phandle in property '%s' of node '%s'",
+                     propname, node_path);
+        return;
+    }
+
+    while (!fdt_init_has_opaque(fdti, target_node_path)) {
+        fdt_init_yield(fdti);
+    }
+
+    linked_dev = fdt_init_get_opaque(fdti, target_node_path);
+
+    object_property_set_link(obj, propname, linked_dev, &errp);
+    if (!errp) {
+        fdt_debug_np("set link %s\n", propname);
+        return;
+    }
+
+    error_free(errp);
+    errp = NULL;
+
+    if (object_dynamic_cast(linked_dev, TYPE_DEVICE)) {
+        BusState *child_bus;
+
+        /* Check if target has a child bus that satisfies the link type */
+        QLIST_FOREACH(child_bus, &DEVICE(linked_dev)->child_bus, sibling) {
+            object_property_set_link(obj, propname, OBJECT(child_bus), &errp);
+            if (!errp) {
+                fdt_debug_np("found matching bus link %s\n",
+                                child_bus->name);
+                return;
+            }
+
+            error_free(errp);
+            errp = NULL;
+        }
+    }
+
+    fdt_debug_np("failed to set link %s\n", propname);
+}
+
+static void fdt_init_qdev_scalar_prop(Object *obj, ObjectProperty *p,
+                                      FDTMachineInfo *fdti,
+                                      const char *node_path,
+                                      const char *propname, const void* val,
+                                      int len)
+{
+
+    /* FIXME: handle generically using accessors and stuff */
+    if (!strncmp(p->type, "link", 4)) {
+        fdt_init_qdev_link_prop(obj, p, fdti, node_path, propname, val, len);
+        return;
+    }
+
+    if (!strcmp(p->type, "uint8") || !strcmp(p->type, "uint16") ||
+        !strcmp(p->type, "uint32") || !strcmp(p->type, "uint64") ||
+        !strcmp(p->type, "int8") || !strcmp(p->type, "int16") ||
+        !strcmp(p->type, "int32") || !strcmp(p->type, "int64")) {
+        object_property_set_int(obj, propname,
+                                get_int_be(val, len), &error_abort);
+        fdt_debug_np("set property %s to 0x%llx\n", propname,
+                    (unsigned long long)get_int_be(val, len));
+        return;
+    }
+
+    if (!strcmp(p->type, "boolean") || !strcmp(p->type, "bool")) {
+        object_property_set_bool(obj, propname,
+                                 !!get_int_be(val, len), &error_abort);
+        fdt_debug_np("set property %s to %s\n", propname,
+                    get_int_be(val, len) ? "true" : "false");
+        return;
+    }
+
+    if (!strcmp(p->type, "string") || !strcmp(p->type, "str")) {
+        object_property_set_str(obj, propname,
+                                (const char *)val, &error_abort);
+        fdt_debug_np("set property %s to %s\n", propname, (const char *)val);
+        return;
+    }
+
+    fdt_debug_np("WARNING: property is of unknown type\n");
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
+                                       elem_cells_propname, 0, &err);
+
+    return (err ? 1 : elem_cells) * 4;
+}
+
+static void fdt_init_qdev_array_prop(Object *obj,
+                                     FDTMachineInfo *fdti,
+                                     const char *node_path,
+                                     const char *propname,
+                                     const void *value,
+                                     int len)
+{
+    int nr = len;
+    uint32_t elem_len;
+    QList *qlist = qlist_new();
+    const char *prop_type;
+    const void *prop_value = value;
+
+    if (!value || !nr) {
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
+    prop_type = qdev_prop_get_array_elem_type(DEVICE(obj), propname);
+    if (!prop_type) {
+        fdt_debug_np("fail to get property array elem type\n");
+        return;
+    }
+
+    while (nr--) {
+        if (!strcmp(prop_type, "uint8") || !strcmp(prop_type, "uint16") ||
+            !strcmp(prop_type, "uint32") || !strcmp(prop_type, "uint64") ||
+            !strcmp(prop_type, "int8") || !strcmp(prop_type, "int16") ||
+            !strcmp(prop_type, "int32") || !strcmp(prop_type, "int64")) {
+                qlist_append_int(qlist, get_int_be(prop_value, elem_len));
+        } else if (!strcmp(prop_type, "boolean") ||
+                                            !strcmp(prop_type, "bool")) {
+            qlist_append_bool(qlist, !!get_int_be(prop_value, elem_len));
+        } else if (!strcmp(prop_type, "string") || !strcmp(prop_type, "str")) {
+            qlist_append_str(qlist, (const char *)prop_value);
+        }
+
+        prop_value += elem_len;
+
+        /* TBD: add link type support */
+    }
+
+    qdev_prop_set_array(DEVICE(obj), propname, qlist);
+    fdt_debug_np("set property %s propname to <list>\n", propname);
+}
+
+static void fdt_init_qdev_properties(char *node_path, FDTMachineInfo *fdti,
+                                     Object *dev)
+{
+    int node_offset, prop_offset;
+
+    node_offset = fdt_path_offset(fdti->fdt, node_path);
+    if (node_offset < 0) {
+        return;
+    }
+
+    fdt_for_each_property_offset(prop_offset, fdti->fdt, node_offset) {
+        const char *fdt_propname;
+        const void *value;
+        const char *propname;
+        int len;
+        ObjectProperty *p = NULL;
+
+        value = fdt_getprop_by_offset(fdti->fdt, prop_offset,
+                               &fdt_propname, &len);
+        if (!value) {
+            continue;
+        }
+
+        propname = trim_vendor(fdt_propname);
+
+        p = object_property_find(dev, propname);
+        if (p) {
+            fdt_debug_np("matched property: %s of type %s, len %d\n",
+                                            propname, p->type, len);
+        }
+        if (!p) {
+            continue;
+        }
+
+        if (!strcmp(p->type, "list")) {
+            fdt_init_qdev_array_prop(dev, fdti, node_path,
+                                     propname, value, len);
+        }
+
+        if (!strcmp(propname, "type")) {
+            continue;
+        }
+
+        fdt_init_qdev_scalar_prop(dev, p, fdti, node_path,
+                                  propname, value, len);
+    }
+}
+
 static void fdt_init_parent_node(Object *dev, Object *parent, char *node_path)
 {
     if (dev->parent) {
@@ -346,6 +580,8 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
 
     fdt_init_set_opaque(fdti, node_path, dev);
 
+    fdt_init_qdev_properties(node_path, fdti, dev);
+
     g_free(parent_node_path);
 
     return 0;
-- 
2.43.0


