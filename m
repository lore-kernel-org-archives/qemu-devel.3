Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28C9D6AB1A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q1v-0008BH-Sl; Thu, 02 Apr 2026 17:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q1u-0008AW-9P
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:46 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q1r-000711-PC
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:45 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso189431166b.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167002; x=1775771802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osWMhevUw1N3AseQErboNOG5dweWBMW0zK7zEVOFBV8=;
 b=YJOr7YX6AYABsdsfH6OwSk8CA7jZH+blEhoGQ/n50u9qmVan71BwhXhkd7kd6ojk9F
 VnxIwbrLDL4SCTFf3USdyBAAhZ7WhuOfyk3QkW+egZWLIA72cMc4RYWIRbzCq/2SD6bn
 1OHtqrgSa4NjQU5xQXQLCUnbxyClYA5K3tTbKpdk9XOI00AndoknbdKez+RWpFGCxfZj
 f4faqv4ODucChpwWRHseYHDzD9p/gKAY0XgE3Q+JdBZ4fZf5HIMpR8S30Yr1RQWXqRRR
 51eOLDSMxD99y9djGCg7/bh9T2X/OcXgRyhyuJjtke06ppjkAUUy4JllDz3FI4C7dnm7
 u8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167002; x=1775771802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=osWMhevUw1N3AseQErboNOG5dweWBMW0zK7zEVOFBV8=;
 b=BvWKDruslvrAemUWK4PhyJQ0usojgxyFbCnTT5RqGqyUHvK5S4qA1FU0/6p1WR+Sfc
 fpPn/+vWIzGZQC90h05wJydxJsoEYdqFG5KPMvXFfAn4reZ/LM8weQ4SpwjkT2qo2Qc9
 BFTVgyJRa+adYNNlGzoFIKFXkuXeca8/wjATJSETqCKM9/ps7ICBpnSmfO0+DfX6o8DR
 CXg78eOxUm5IrIQgnqE+YT7PmWncNBUGTU6HRkg7BZRRa8auay3lkGdsu4xY3WoXnvyF
 +pKEil8whQMnZ8NFhbfnJD93B6rwRvc7TlZ0/Z6CIRc2ir+9CXQgVTqnKHqz477KAvfW
 M0XQ==
X-Gm-Message-State: AOJu0YyXI1vDhPeCDj9Lc3fY3huiKeQ0sfRkah5gaGZ+gXhoLrZwiiWH
 3U16/8MYjZMzAWSf90yt95GW2c4sjAIzyNPIbiCgDPOJgsN4zdxkw/rmLu2YiA72
X-Gm-Gg: ATEYQzzTBMN+DBlwsfdPqv965NL/0zFAYA8c9pOdTLbjnLJWZa/8vSZPvQBLL5o8rHb
 gOE3WdmRsVhK6EwjVWI1GQFAGzL8jyT9N9r+0qWk/x0yk+D9PQfc9pfwBUlH655pSj6jNWIdpvn
 aeBgFKczZ3n2kld1CEpUDtx0mxZCgl/wuwavm67AUZ9o4qg2QulWS2ZE+HV5cOSA1eOlOVjXsel
 X+kmkvbIO1bKZapBh3gA5dgPK61bDL3w4c2L0qobf3iIPUGTXlPj4mEYHhpI91brdLgiOek3DX+
 ql2oWI0ep9ltyTjvfCXwb8MRMCgwBUxOT+gF+JExWHm3ayXJYcyZaMkB87l4HpQyz2G28/pRCMw
 B7XaTvZrw9ti4m77JDEGIuGAOMLyF0Br1xWO9YmxFPvCBPgDr72kC0hpCJJKHegnpx73CBcAxu1
 /4a0uFFvT1qXE/9r7Hxc0qwGsYEX8KmmJoA3PeTtLLOsZV+bHWnop2G3ijv53m8YrT8JfGEA==
X-Received: by 2002:a17:907:1903:b0:b95:894b:46e4 with SMTP id
 a640c23a62f3a-b9c679adcccmr27187566b.34.1775167001790; 
 Thu, 02 Apr 2026 14:56:41 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:41 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 01/33] system/device_tree: update qemu_fdt_getprop_cell
Date: Thu,  2 Apr 2026 23:55:46 +0200
Message-ID: <20260402215629.745866-2-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x634.google.com
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

Update 'qemu_fdt_getprop_cell' to allow accessing
specific cells within multi-cell property array.

This will be used by hardware device tree parsing logic.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/boot.c                |  8 ++++----
 hw/arm/raspi4b.c             |  8 ++++----
 hw/arm/vexpress.c            |  4 ++--
 include/system/device_tree.h |  5 ++---
 system/device_tree.c         | 18 ++++++++----------
 5 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c97d4c4e11..36fefd06d5 100644
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
+                                   &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells", 0,
+                                   &error_fatal);
     if (acells == 0 || scells == 0) {
         fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
         goto fail;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 3eeb8f447e..58ddd103b7 100644
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
+                                   &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells", 0,
+                                   &error_fatal);
     /* validated by arm_load_dtb */
     g_assert(acells && scells);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index cc6ae7d4c4..23d2d7deff 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -486,9 +486,9 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
     const VEDBoardInfo *daughterboard = (const VEDBoardInfo *)info;
 
     acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
-                                   NULL, &error_fatal);
+                                   0, &error_fatal);
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
-                                   NULL, &error_fatal);
+                                   0, &error_fatal);
     intc = find_int_controller(fdt);
     if (!intc) {
         /* Not fatal, we just won't provide virtio. This will
diff --git a/include/system/device_tree.h b/include/system/device_tree.h
index 49d8482ed4..5667ff9538 100644
--- a/include/system/device_tree.h
+++ b/include/system/device_tree.h
@@ -108,14 +108,13 @@ const void *qemu_fdt_getprop(void *fdt, const char *node_path,
  * @fdt: pointer to the device tree blob
  * @node_path: node path
  * @property: name of the property to find
- * @lenp: fdt error if any or -EINVAL if the property size is different from
- *        4 bytes, or 4 (expected length of the property) upon success.
+ * @cell_id: the index of 32bit cell to retrive
  * @errp: handle to an error object
  *
  * returns the property value on success
  */
 uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
-                               const char *property, int *lenp,
+                               const char *property, int cell_id,
                                Error **errp);
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path);
 uint32_t qemu_fdt_alloc_phandle(void *fdt);
diff --git a/system/device_tree.c b/system/device_tree.c
index 1ea1962984..d2db7bd355 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -446,24 +446,22 @@ const void *qemu_fdt_getprop(void *fdt, const char *node_path,
 }
 
 uint32_t qemu_fdt_getprop_cell(void *fdt, const char *node_path,
-                               const char *property, int *lenp, Error **errp)
+                               const char *property, int cell_id, Error **errp)
 {
     int len;
     const uint32_t *p;
 
-    if (!lenp) {
-        lenp = &len;
-    }
-    p = qemu_fdt_getprop(fdt, node_path, property, lenp, errp);
+    p = qemu_fdt_getprop(fdt, node_path, property, &len, errp);
     if (!p) {
         return 0;
-    } else if (*lenp != 4) {
-        error_setg(errp, "%s: %s/%s not 4 bytes long (not a cell?)",
-                   __func__, node_path, property);
-        *lenp = -EINVAL;
+    }
+    if (len < (cell_id + 1) * 4) {
+        error_setg(errp,
+                   "%s: %s/%s is too short, need %d bytes for cell ind %d",
+                __func__, node_path, property, (cell_id + 1) * 4, cell_id);
         return 0;
     }
-    return be32_to_cpu(*p);
+    return be32_to_cpu(p[cell_id]);
 }
 
 uint32_t qemu_fdt_get_phandle(void *fdt, const char *path)
-- 
2.43.0


