Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC3CD1950F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQcx-0001TJ-PY; Mon, 26 Jan 2026 12:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQce-0001J3-Ca
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcZ-0008Th-PY
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:31 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so40893015e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449405; x=1770054205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLzeXSL2t2tbTXzCZtblMBZrbAJVOypOntKEo8XJDH4=;
 b=jmRlJmKMp+42ey7w8C3UleibYyOnxZmlb7VO2sX7lvLPBQPciMOzk2Ksuft/GeSAgU
 /AALgom5Jo9aFjEy+id3Sp7Sc3HHUD9tu3rs5VlF7RD9uPjlLSzN2UfL7+0orQuniLFp
 6n2NhnjYXrsza8QiJYnWubyJ93DcoVaLqqMTMzbbPhaYz0zbSmLDHuK5rxeCqLuqOLJo
 vlFEGzSPFVBXztdGRHAHTEBOeYqkZndyoRqloU/Y77RZoDDTLXMCflTMKNMAAZ3Dnyev
 +c9oHighWjuCy1UB7I4xIsQNSr2ATd2XUjoej+EwpJYtlxTwq5g6Blq6pBldfYL3OjmH
 tX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449405; x=1770054205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DLzeXSL2t2tbTXzCZtblMBZrbAJVOypOntKEo8XJDH4=;
 b=maUgLYlep4tme+6usiqW0lwCBbrWo6woQYKH3h9c43uAabb52OlQyBXvXP7r6xcKJv
 2ib0nu3cZizAjZ0u2NhGp8hxLc5DTztPH9pinFCmZlCS1ozMTIvEuVvfBJFkKVoqY+OM
 pWa+eJfi6920h6BHGGaTAGp2Ca3xjvxESLpPAg4bdmKRDiFoIOE3gclQN2tizRlAj7zC
 iHcCRp5+uGKBeTcXc0EZwRGr5ahDFVNHYc76cFDed7auZk22UoCN4y07ZPXIj7sSU/pf
 wVR+2SUY6tafL6uuEqKWfsUsLB7T5TI0UuU8LAqdThxGKn9FfxqaZIucI2f/9S0CmZXF
 f2vA==
X-Gm-Message-State: AOJu0YzSEm5VPO/CWdaFDifaz11zDR7QN5bSPd/1nMJX3I6LKjI/m/m6
 BF27y4d7Rjd+C/D/cTB4cjpfQr0f0cB9Asw5aSzQ2NmL7m5djf0BZbyqXWsbjL23
X-Gm-Gg: AZuq6aJuBqf5DqrIV6tiWNu4HV0WWBYi5/9xKGo76MBx6rsnAuW60ZydVqrqCpzjllp
 FwFB90L96sET0sYgBSxZzYOimyM13fuphEyWKJ/tHbttcJygQ+Mkb+gmDRfAbHsEgBT8OJM9nkm
 DK7olnvObkiLANtIidccRJ+u1mKx84XkyilYRxl54i8moXuzAjFhkryxiOijVU9ggZjMSE9ACYL
 P9/UMg9sHU51rLwnaMZJ9089uyE5TVPkJ1W6G3OJcgBkfVzbozY+uLkjkV5WHassqi/zudQgQLb
 Ubs8djEmAuXpxI69FE1mjCG0cMKB3mEX9Ow8Icse3MhqRsWZHcGmfzJY7JGFEWlzoL5z/LZxydf
 Z2dnk5rLDbaYMYi6OQbWEtg5hr/a09RBGtE3qAAYQx0rICznjIXmTJKxAh2yLHwceBC5CzGqIxD
 DhGm0bIXMiAIsu+dW3gb+MGlJDMqWKSc0XdrW7AqeVDAyW4T1wFsOujA==
X-Received: by 2002:a05:600c:3b9d:b0:47e:de23:dd6f with SMTP id
 5b1f17b1804b1-4805ce42a6dmr88712645e9.12.1769449404881; 
 Mon, 26 Jan 2026 09:43:24 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:24 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, Alistair Francis <alistair@alistair23.me>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 01/27] system/device_tree: update qemu_fdt_getprop/_cell
Date: Mon, 26 Jan 2026 18:42:47 +0100
Message-ID: <20260126174313.1418150-2-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32f.google.com
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

Update 'qemu_fdt_getprop' and 'qemu_fdt_getprop_cell'
to support property inheritence from parent node,
in case 'inherit' argument is set.

Update 'qemu_fdt_getprop_cell' to allow accessing
specific cells within multi-cell property array.

Introduced 'qemu_devtreedd_getparent' as it is needed
by both internal and external users.

This will be used by hardware device tree parsing logic.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/boot.c                |  8 ++++----
 hw/arm/raspi4b.c             |  8 ++++----
 hw/arm/vexpress.c            |  4 ++--
 hw/arm/xlnx-zcu102.c         |  3 ++-
 include/system/device_tree.h | 32 +++++++++++++++++++-------------
 system/device_tree.c         | 33 ++++++++++++++++++++++++---------
 6 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c97d4c4e11..829b8ba12f 100644
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
index 3eeb8f447e..66eba5d667 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -42,10 +42,10 @@ static void raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
     uint32_t acells, scells;
     char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
 
-    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
-                                   NULL, &error_fatal);
-    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
-                                   NULL, &error_fatal);
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells", 0,
+                                   false, &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells", 0,
+                                   false, &error_fatal);
     /* validated by arm_load_dtb */
     g_assert(acells && scells);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index cc6ae7d4c4..823e316f91 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -486,9 +486,9 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
     const VEDBoardInfo *daughterboard = (const VEDBoardInfo *)info;
 
     acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
-                                   NULL, &error_fatal);
+                                   0, false, &error_fatal);
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
-                                   NULL, &error_fatal);
+                                   0, false, &error_fatal);
     intc = find_int_controller(fdt);
     if (!intc) {
         /* Not fatal, we just won't provide virtio. This will
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 3ba2736bab..8f67c8be48 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -88,7 +88,8 @@ static void zcu102_modify_dtb(const struct arm_boot_info *binfo, void *fdt)
                                        &error_fatal);
 
         for (i = 0; node_path && node_path[i]; i++) {
-            r = qemu_fdt_getprop(fdt, node_path[i], "method", &prop_len, NULL);
+            r = qemu_fdt_getprop(fdt, node_path[i], "method", &prop_len,
+                                 false, NULL);
             method_is_hvc = r && !strcmp("hvc", r);
 
             /* Allow HVC based firmware if EL2 is enabled.  */
diff --git a/include/system/device_tree.h b/include/system/device_tree.h
index 49d8482ed4..f34b8b7ef9 100644
--- a/include/system/device_tree.h
+++ b/include/system/device_tree.h
@@ -96,27 +96,28 @@ int qemu_fdt_setprop_phandle(void *fdt, const char *node_path,
  * @node_path: node path
  * @property: name of the property to find
  * @lenp: fdt error if any or length of the property on success
+ * @inherit: if not found in node, look for property in parent
  * @errp: handle to an error object
  *
  * returns a pointer to the property on success and NULL on failure
  */
 const void *qemu_fdt_getprop(void *fdt, const char *node_path,
                              const char *property, int *lenp,
-                             Error **errp);
+                             bool inherit, Error **errp);
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
+* @ofset: the index of 32bit cell to retrive
+* @inherit: if not found in node, look for property in parent
+* @errp: handle to an error object
+*
+* returns the property value on success
+*/
 uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
-                               const char *property, int *lenp,
-                               Error **errp);
+                               const char *property, int offset,
+                               bool inherit, Error **errp);
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
 uint32_t qemu_fdt_alloc_phandle(void *fdt);
 int qemu_fdt_nop_node(void *fdt, const char *node_path);
@@ -193,6 +194,11 @@ int qemu_fdt_setprop_sized_cells_from_array(void *fdt,
     })
 
 
+int qemu_devtree_getparent(void *fdt, char *node_path,
+                           const char *current);
+
+#define DT_PATH_LENGTH 1024
+
 /**
  * qemu_fdt_randomize_seeds:
  * @fdt: device tree blob
diff --git a/system/device_tree.c b/system/device_tree.c
index 1ea1962984..41bde0ba5a 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -429,7 +429,8 @@ int qemu_fdt_setprop_string_array(void *fdt, const char *node_path,
 }
 
 const void *qemu_fdt_getprop(void *fdt, const char *node_path,
-                             const char *property, int *lenp, Error **errp)
+                             const char *property, int *lenp,
+                             bool inherit, Error **errp)
 {
     int len;
     const void *r;
@@ -439,31 +440,35 @@ const void *qemu_fdt_getprop(void *fdt, const char *node_path,
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
     return r;
 }
 
 uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
-                               const char *property, int *lenp, Error **errp)
+                               const char *property, int offset,
+                               bool inherit, Error **errp)
 {
     int len;
     const uint32_t *p;
 
-    if (!lenp) {
-        lenp = &len;
-    }
-    p = qemu_fdt_getprop(fdt, node_path, property, lenp, errp);
+    p = qemu_fdt_getprop(fdt, node_path, property, &len,
+                                         inherit, errp);
     if (!p) {
         return 0;
-    } else if (*lenp != 4) {
+    }
+    if (len < (offset + 1) * 4) {
         error_setg(errp, "%s: %s/%s not 4 bytes long (not a cell?)",
                    __func__, node_path, property);
-        *lenp = -EINVAL;
         return 0;
     }
-    return be32_to_cpu(*p);
+    return be32_to_cpu(p[offset]);
 }
 
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
@@ -633,6 +638,16 @@ out:
     return ret;
 }
 
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
 void qmp_dumpdtb(const char *filename, Error **errp)
 {
     ERRP_GUARD();
-- 
2.43.0


