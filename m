Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D53E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt576-0008Sl-Q9; Thu, 19 Feb 2026 09:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt575-0008Rc-FN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt573-0002uf-Fc
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:34:43 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43945763558so631832f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771511680; x=1772116480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EInj+fhc6M2pb85jhJLuLr62nyN+XzT/wpGcmMowrRw=;
 b=EN2JNFGW8WWQam9yEepLvVWDalY2tGR7A1uzQNYo9kUbUUdg8Z4cte8/ryXNrR0uCo
 KN3qeyfX1UQCy7v3cvOqxAOQtHuJsGE+y+6VLi6RfGTIBPcc3jhsVm2WBM780MY900hM
 yYGL3ZJXvkTPsEghlbkuwANzmsOVF3xiHEgTSVlliiopg0BHABvpnnedEsN/bGcmi2yD
 +FJXmFJ/pLUsVkIgRU4iljgK4DW0vh2+zLlL0QIHne7NyR8ooKhwnO9+alp8xG4sAj5S
 jDO6tMcB72J9HEMZva/iSUjg8aRY3tWT0N+gXBXRF5raacl4f9ZKVvquDtLh5vfNsamC
 +SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511680; x=1772116480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EInj+fhc6M2pb85jhJLuLr62nyN+XzT/wpGcmMowrRw=;
 b=ZoijrrIU7/anJ4ma+2xklTTWnTiIgeHwcc+zo9yp8JhUreat1Lo95eqXJWCzaFC/ve
 Wea6TGiKQaT3YIF0CnHe3Jp6COgeo9L0uXdFWIzH3HygX8fy8df7shRh3B7rKcjjeVkC
 Gx+93jYZm970WZ1C2P9BtnAqZ5oBpjrrCDxfl37Z5+jHcb1mZxAJwmOUY710Y+gGAZXV
 1NluT/IA8LS+fjBsoy5E3WNva+OGiLM04MVy9NNrPy+xL9gi6B1Rzuyz+Um8JGp3sgUX
 +qGqmASAnD98nSra9+zfo1zA+iHVGYRiZlAizspgTeueZdg3uJt3JaxUCV/1FjAALoNj
 t9yA==
X-Gm-Message-State: AOJu0YxSTExdBIl8+GyU3wpGYI+wbyh/5tee6U5sZaZ/7ntfX1apyJP5
 /L2zdYC7gCT8iKRCzAEdm+RhNpZAgGMeGG7qU4I+Kzy+c9LoPo0Gbb4z6KPI0RgN
X-Gm-Gg: AZuq6aIGXTus5126d6ac+2r3uApsIYPmGru6PJ2ZStxJjJhjRgo2ChisD8ms6miJMjc
 TMKIrYQbPYQUWdO2QIKkQM7Ax3iDtXC2PsC9slGtHj8tnBsgKrb7KANxs4mfrWwbRjLFLB+aMr5
 tDsYe505G4Ru30ypFj4cT0mwnS2WPk0jlA2KgXfLBwZ72CxcmXIphgIda6mEffIEtaHamcN1CAa
 IsqU9cfM5DY6yJpfQ79fPZqIVKkX21PzMl0WeB5E0kcDDgrNKyrVfYNbU137WGAVM/gzukbtxhc
 1c3AHovsheEUIHQ/FZG563Dc4leEhwe+u0yl6erjYm+Ho81HbglyNjMUYT3WFsCXyJWAfksLEhR
 DavpK9PRDmune76L4xuGmPFMiyDJtE+6rpQhPojVidgb4jn/RjMkdNRHH5VNhpcn4aFQK1ypyWv
 Wo7L2eDJRRDwyop8t3ZPv6OfzKDr/pBH6Ki8Cz3+fwCAzPB7XcTtkWFioz1V5LqPnZieK6
X-Received: by 2002:a05:6000:2dc9:b0:435:960c:5286 with SMTP id
 ffacd0b85a97d-43796b0539emr38003517f8f.58.1771511679534; 
 Thu, 19 Feb 2026 06:34:39 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm52022770f8f.24.2026.02.19.06.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:34:39 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 02/33] system/device_tree: add few parsing and traversal
 helpers
Date: Thu, 19 Feb 2026 15:33:01 +0100
Message-ID: <20260219143332.3316679-3-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The patch adds few utility functions for parsing FDT nodes.
The helpers are required for upcoming Hardware device tree
feature.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/system/device_tree.h |  30 +++++
 system/device_tree.c         | 221 +++++++++++++++++++++++++++++++++++
 2 files changed, 251 insertions(+)

diff --git a/include/system/device_tree.h b/include/system/device_tree.h
index 5667ff9538..9d6b570bdb 100644
--- a/include/system/device_tree.h
+++ b/include/system/device_tree.h
@@ -116,6 +116,11 @@ const void *qemu_fdt_getprop(void *fdt, const char *node_path,
 uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
                                const char *property, int cell_id,
                                Error **errp);
+
+const void *qemu_fdt_getprop_inherited(void *fdt, const char *node_path,
+                             const char *property, int *lenp, Error **errp);
+uint32_t qemu_fdt_getprop_cell_inherited(void *fdt, const char *node_path,
+                               const char *property, int cell_id, Error **errp);
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
 uint32_t qemu_fdt_alloc_phandle(void *fdt);
 int qemu_fdt_nop_node(void *fdt, const char *node_path);
@@ -191,6 +196,31 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fdt,
                                                 qdt_tmp);                 \
     })
 
+typedef struct QEMUDevtreeProp {
+    const char *name;
+    int len;
+    const void *value;
+} QEMUDevtreeProp;
+
+/* node queries */
+
+int qemu_devtree_get_num_children(void *fdt, const char *node_path);
+int qemu_devtree_get_children(void *fdt, const char *node_path,
+                                     int max_paths, char **returned_paths);
+int qemu_devtree_num_props(void *fdt, const char *node_path);
+QEMUDevtreeProp *qemu_devtree_get_props(void *fdt, const char *node_path);
+
+/* node getters */
+
+int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int phandle);
+int qemu_devtree_getparent(void *fdt, char *node_path,
+                           const char *current);
+
+/* misc */
+
+int devtree_get_num_nodes(void *fdt);
+
+#define DT_PATH_LENGTH 1024
 
 /**
  * qemu_fdt_randomize_seeds:
diff --git a/system/device_tree.c b/system/device_tree.c
index d2db7bd355..fc34c660db 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -464,6 +464,103 @@ uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
     return be32_to_cpu(p[cell_id]);
 }
 
+const void *qemu_fdt_getprop_inherited(void *fdt, const char *node_path,
+                             const char *property, int *lenp, Error **errp)
+{
+    const void *found_val = NULL;
+    int found_len = 0;
+    int curr_offset = 0;
+    int temp_len;
+    char **tokens;
+    char **iter;
+
+    found_val = fdt_getprop(fdt, 0, property, &found_len);
+
+    tokens = g_strsplit(node_path + 1, "/", -1);
+
+    for (iter = tokens; *iter != NULL; iter++) {
+        if (**iter == '\0') {
+            continue;
+        }
+
+        curr_offset = fdt_subnode_offset(fdt, curr_offset, *iter);
+        if (curr_offset < 0) {
+            error_setg(errp, "%s: Path '%s' not found",
+                       __func__, *iter);
+            g_strfreev(tokens);
+            return NULL;
+        }
+
+        const void *val = fdt_getprop(fdt, curr_offset, property, &temp_len);
+        if (val) {
+            found_val = val;
+            found_len = temp_len;
+        }
+    }
+    g_strfreev(tokens);
+
+    if (!found_val) {
+        error_setg(errp, "%s: Property '%s' not found",
+                   __func__, property);
+        return NULL;
+    }
+
+    if (lenp) {
+        *lenp = found_len;
+    }
+
+    return found_val;
+}
+
+uint32_t qemu_fdt_getprop_cell_inherited(void *fdt, const char *node_path,
+                               const char *property, int cell_id, Error **errp)
+{
+    int len;
+    const uint32_t *p;
+
+    p = qemu_fdt_getprop_inherited(fdt, node_path, property, &len, errp);
+    if (!p) {
+        return 0;
+    }
+    if (len < (cell_id + 1) * 4) {
+        error_setg(errp,
+                   "%s: %s/%s is too short, need %d bytes for cell ind %d",
+                   __func__, node_path, property, (cell_id + 1) * 4, cell_id);
+        return 0;
+    }
+    return be32_to_cpu(p[cell_id]);
+}
+
+int qemu_devtree_getparent(void *fdt, char *node_path, const char *current)
+{
+    const char *sep;
+    int len;
+
+    if (!current || !node_path) {
+        return -FDT_ERR_NOTFOUND;
+    }
+
+    if (current[0] == '/' && current[1] == 0) {
+        return -FDT_ERR_NOTFOUND;
+    }
+
+    sep = strrchr(current, '/');
+    if (!sep) {
+        return -FDT_ERR_BADPATH;
+    }
+
+    if (sep == current) {
+        len = 1;
+    } else {
+        len = sep - current;
+    }
+
+    memcpy(node_path, current, len);
+    node_path[len] = '\0';
+
+    return 0;
+}
+
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
 {
     uint32_t r;
@@ -631,6 +728,130 @@ out:
     return ret;
 }
 
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
+        ret[i].name = propname;
+        ret[i].value = val;
+        i++;
+    }
+    return ret;
+}
+
+int qemu_devtree_get_children(void *fdt, const char *node_path,
+                                     int max_paths, char **returned_paths) {
+    int count = 0;
+    int subnode;
+    const char *name;
+    int offset = fdt_path_offset(fdt, node_path);
+
+    if (offset < 0) {
+        return offset;
+    }
+
+    bool is_root = (strcmp(node_path, "/") == 0);
+
+    fdt_for_each_subnode(subnode, fdt, offset) {
+        if (count >= max_paths) {
+            break;
+        }
+        name = fdt_get_name(fdt, subnode, NULL);
+        if (returned_paths) {
+            returned_paths[count] = g_strdup_printf("%s/%s",
+                                                is_root ? "" : node_path, name);
+        }
+
+        ++count;
+    }
+
+    return count;
+}
+
+int qemu_devtree_get_num_children(void *fdt, const char *node_path)
+{
+    int count = 0;
+    int subnode;
+    int offset = fdt_path_offset(fdt, node_path);
+
+    if (offset < 0) {
+        return offset;
+    }
+
+    fdt_for_each_subnode(subnode, fdt, offset) {
+        ++count;
+    }
+
+    return count;
+}
+
+int qemu_devtree_get_node_by_phandle(void *fdt, char *node_path, int phandle)
+{
+    int offset = 0, cur_depth = 0;
+    int path_lens[64] = { 0 };
+
+    for (offset = 0; offset >= 0; offset = fdt_next_node(fdt, offset,
+                                                         &cur_depth)) {
+        if (cur_depth > 64) {
+            break;
+        }
+        const char *name = fdt_get_name(fdt, offset, NULL);
+
+        int parent_len = (cur_depth > 0) ? path_lens[cur_depth - 1] : 0;
+        int len = snprintf(node_path + parent_len,
+                             DT_PATH_LENGTH - parent_len,
+                             "%s%s",
+                             (parent_len > 1) ? "/" : "",
+                             (cur_depth == 0) ? "/" : name);
+
+        path_lens[cur_depth] = parent_len + len;
+
+        if (fdt_get_phandle(fdt, offset) == phandle) {
+            return 0;
+        }
+    }
+
+    return -FDT_ERR_NOTFOUND;
+}
+
+int devtree_get_num_nodes(void *fdt)
+{
+    int num_nodes = 0;
+    int depth = 0, offset = 0;
+
+    for (;;) {
+        offset = fdt_next_node(fdt, offset, &depth);
+        num_nodes++;
+        if (offset <= 0 || depth <= 0) {
+            break;
+        }
+    }
+    return num_nodes;
+}
+
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
     ERRP_GUARD();
-- 
2.43.0


