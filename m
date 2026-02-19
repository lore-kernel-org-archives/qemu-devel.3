Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE52E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5ML-00041t-60; Thu, 19 Feb 2026 09:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5M4-0003mG-Ra
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lw-00084P-8d
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:07 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso807109f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512589; x=1772117389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGdJDqeEFRiYE7+mNqWDgSi4YGcdtyU590w+gpZTD7A=;
 b=IR3FBchGob9JzTbm/FzfTsPpNKicxynB1HrWuiMWuPYzbzZdolNdN/+x9qHnj0xV2T
 1XE3pVQvXG2X2xNefXjBFkWqm8lpIvesEufiAkOfzwJvAmWGi43V+5Lghy7G5bGLeQK+
 8Dtd548xd7IuScTXbdV+PBuGvV6GWUGMx4ItOHmShwNAAssRoJcTpUWZVe/5GteUDBwL
 ZZHJomdjxz/SIq8k+hdmC/18YlxWGTxdnLUcMrlcooyaJRMNMwSe0pXD2gwGbA5dB+kY
 2ixPgIjzZLzVZU39ZbFv1AK/815Ao7VfWBJyDxRbL4kdVBaR+1qgH9/7Q81uy3RhN3mS
 gkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512589; x=1772117389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CGdJDqeEFRiYE7+mNqWDgSi4YGcdtyU590w+gpZTD7A=;
 b=D43ikmiWFN5sVTAbEVqcOV7xZw62SsPYRSv5VXQWIREEpOjdwrvF7Ovvx2zS5F6Ja/
 NChY7eTeuX5jMfpmJkewS5yXroWlP3/BmGV9Gs/usMKeZr98UoA3yDLApffmt4dfvl5S
 /kmSGGjS+hm2Lg+GkB0fHrRITotuX+HA3GVPc8WY43Ft52qEeQJNVrjA7Tjazc2bFH15
 Ty/F/TEaV+9uLAUZZbHeT6iFu/o4Y1IhQqYdwPo6pIvCGyZN+3l5Uy2rLMll1TVK4o1T
 wKTAz3xnC2s/Inh+cTyz+cLSM+haUxvtTDMWCxTCgeo1OcD/IPDLRAyPScQ5ZxNO/1/A
 zqog==
X-Gm-Message-State: AOJu0YxsDhnKK9v/wVCHsMph6uqJMA6eMYGMFzXFmieEedvrEh/UCFif
 +Jd1UopkMQU1jwHrNqz1++CBWomdB4DnRq5ZWEzD3MvF3vv+EhCHtjaKwwBPZJyx
X-Gm-Gg: AZuq6aIM0QBwczzp72w3OgS0byhmkjqJggmAuLrM16uhdMtOVFBlpLwPNg+irUI2Lyo
 34vWAxYcUfhpP603r9fVPx/AZMiIxfcYF8onDuuvCQrwWtgSTy++Od2JtICPliD2GyCWGNlPpx+
 XLlqognlG+w4CwSCMwtwnrRraRJjbbpL6CKDBPQ4NNLP7F/Cse5uMBXYwFkQ/KY/pFHbmxnZ1sO
 VK0v/HPr6go4CVFFmZ28tobUzvjVFOupUiN00H+/CzhKrL4Oul9RMDjhqffYX5hGRRuF5v7JazO
 NJns7DnmkD47rcfaT9Anm8cOocgpS/8Ru7e35p+kC4ojW6SbyMoOARB4kV8c0YAvGcQNvpJqvjf
 YVnwGMwg/UdCwcgV1zcnx8JiQpC0tzJA0yRmcdihBQwkvWbVH90YQ/N50DvHPagyOlDWrT9veU2
 A2ZlSiUQGhi5B+FDGiI7fb2JFjrwPWjJn+qqpb91xkowy96cs1Dc7qSO+0SJmp9k1ITkye
X-Received: by 2002:a05:6000:430a:b0:436:549:e15d with SMTP id
 ffacd0b85a97d-439626e3608mr4046912f8f.18.1771512588665; 
 Thu, 19 Feb 2026 06:49:48 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:48 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 25/33] system/memory: add setters for MemoryRegion
 properties
Date: Thu, 19 Feb 2026 15:48:53 +0100
Message-ID: <20260219144901.3317747-7-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42e.google.com
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

Currently, MemoryRegion properties such as addr, size,
priority and container are read-only and don't have setters.

This patch implements the missing setters function, so that
properties can be modified dynamically.

The changes allow MemoryRegions objects to be fully configured
via properties, which enables them be created from a device
tree description.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 system/memory.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 216 insertions(+), 5 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index c51d0798a8..fc1f6cff0c 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -55,6 +55,9 @@ static GHashTable *flat_views;
 
 typedef struct AddrRange AddrRange;
 
+static void memory_region_update_container_subregions(MemoryRegion *subregion);
+static void memory_region_readd_subregion(MemoryRegion *mr);
+
 /*
  * Note that signed integers are needed for negative offsetting in aliases
  * (large MemoryRegion::alias_offset).
@@ -1251,6 +1254,73 @@ void memory_region_init(MemoryRegion *mr,
     memory_region_do_init(mr, owner, name, size);
 }
 
+static void memory_region_get_addr(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    uint64_t value = mr->addr;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void memory_region_set_addr(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    Error *local_err = NULL;
+    uint64_t value;
+
+    visit_type_uint64(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    memory_region_set_address(mr, value);
+}
+
+static void memory_region_set_container(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    Error *local_err = NULL;
+    MemoryRegion *old_container = mr->container;
+    MemoryRegion *new_container = NULL;
+    char *path = NULL;
+
+    visit_type_str(v, name, &path, &local_err);
+
+    if (!local_err && strcmp(path, "") != 0) {
+        new_container = MEMORY_REGION(object_resolve_link(obj, name, path,
+                                      &local_err));
+        while (new_container->alias) {
+            new_container = new_container->alias;
+        }
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    object_ref(OBJECT(new_container));
+
+    memory_region_transaction_begin();
+    memory_region_ref(mr);
+    if (old_container) {
+        memory_region_del_subregion(old_container, mr);
+    }
+    mr->container = new_container;
+    if (new_container) {
+        memory_region_update_container_subregions(mr);
+    }
+    memory_region_unref(mr);
+    memory_region_transaction_commit();
+
+    object_unref(OBJECT(old_container));
+}
+
 static void memory_region_get_container(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
@@ -1275,6 +1345,53 @@ static Object *memory_region_resolve_container(Object *obj, void *opaque,
     return OBJECT(mr->container);
 }
 
+static void memory_region_set_alias(const Object *obj, const char *name,
+                                    Object *val, Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    MemoryRegion *subregion, *next;
+
+    /*
+     * Be conservative and only allow one shotting for the mo
+     * FIXME: Use a softer error than assert
+     */
+    assert(!mr->alias);
+
+    /*
+     * FIXME: check we don't already have subregions and
+     * anything else that might be mutex with aliasing
+     */
+
+    memory_region_transaction_begin();
+    QTAILQ_FOREACH_SAFE(subregion, &mr->subregions, subregions_link, next) {
+        object_property_set_link(OBJECT(subregion), "container",
+                                 OBJECT(val), errp);
+    }
+    memory_region_ref(mr);
+    mr->alias = MEMORY_REGION(val);
+    mr->alias->mapped_via_alias++;
+    memory_region_unref(mr);
+    memory_region_transaction_commit();
+    /* FIXME: add cleanup destructors etc etc */
+}
+
+static void memory_region_set_alias_offset_prop(Object *obj, Visitor *v,
+                                                const char *name,
+                                                void *opaque, Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    Error *local_err = NULL;
+    uint64_t value;
+
+    visit_type_uint64(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    memory_region_set_alias_offset(mr, value);
+}
+
 static void memory_region_get_priority(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -1285,6 +1402,70 @@ static void memory_region_get_priority(Object *obj, Visitor *v,
     visit_type_int32(v, name, &value, errp);
 }
 
+static void memory_region_set_priority(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    Error *local_err = NULL;
+    int32_t value;
+
+    visit_type_uint32(v, name, (uint32_t *)&value, &error_abort);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (mr->priority != value) {
+        mr->priority = value;
+        memory_region_readd_subregion(mr);
+    }
+}
+
+static void memory_region_do_set_ram(MemoryRegion *mr)
+{
+    if (mr->addr) {
+        qemu_ram_free(mr->ram_block);
+    }
+    if (int128_eq(mr->size, int128_make64(0))) {
+        return;
+    }
+    if (mr->ram) {
+        mr->ram_block = qemu_ram_alloc(int128_get64(mr->size),
+                                       RAM_SHARED, mr, &error_abort);
+    }
+}
+
+static void memory_region_set_ram(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    Error *local_err = NULL;
+    uint8_t value;
+
+    visit_type_uint8(v, name, &value, &error_abort);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    mr->dirty_log_mask |= tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+    /* FIXME: Sanitize error handling */
+    /* FIXME: Probably need all that transactions stuff */
+    if (mr->ram == value) {
+        return;
+    }
+
+    mr->ram = value;
+    mr->terminates = !!value; /*FIXME: Wrong */
+
+    if (int128_eq(int128_2_64(), mr->size)) {
+        return;
+    }
+
+    memory_region_do_set_ram(mr);
+}
+
 static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
@@ -1294,6 +1475,19 @@ static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
+static void memory_region_set_object_size(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    Error *local_err = NULL;
+    uint64_t size;
+
+    visit_type_uint64(v, name, &size, &local_err);
+
+    memory_region_set_size(mr, size);
+}
+
 static void memory_region_initfn(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
@@ -1309,19 +1503,33 @@ static void memory_region_initfn(Object *obj)
     op = object_property_add(OBJECT(mr), "container",
                              "link<" TYPE_MEMORY_REGION ">",
                              memory_region_get_container,
-                             NULL, /* memory_region_set_container */
+                             memory_region_set_container,
                              NULL, NULL);
     op->resolve = memory_region_resolve_container;
 
-    object_property_add_uint64_ptr(OBJECT(mr), "addr",
-                                   &mr->addr, OBJ_PROP_FLAG_READ);
+    object_property_add_link(OBJECT(mr), "alias", TYPE_MEMORY_REGION,
+                             (Object **)&mr->alias,
+                             memory_region_set_alias,
+                             0);
+    object_property_add(OBJECT(mr), "alias-offset", "uint64",
+                        NULL,  /* FIXME: Add getter */
+                        memory_region_set_alias_offset_prop,
+                        NULL, NULL);
+    object_property_add(OBJECT(mr), "addr", "uint64",
+                        memory_region_get_addr,
+                        memory_region_set_addr,
+                        NULL, NULL);
     object_property_add(OBJECT(mr), "priority", "uint32",
                         memory_region_get_priority,
-                        NULL, /* memory_region_set_priority */
+                        memory_region_set_priority,
+                        NULL, NULL);
+    object_property_add(OBJECT(mr), "ram", "uint8",
+                        NULL, /* FIXME: Add getter */
+                        memory_region_set_ram,
                         NULL, NULL);
     object_property_add(OBJECT(mr), "size", "uint64",
                         memory_region_get_size,
-                        NULL, /* memory_region_set_size, */
+                        memory_region_set_object_size,
                         NULL, NULL);
 }
 
@@ -2730,6 +2938,9 @@ void memory_region_set_size(MemoryRegion *mr, uint64_t size)
     }
     memory_region_transaction_begin();
     mr->size = s;
+    if (mr->ram) {
+        memory_region_do_set_ram(mr);
+    }
     memory_region_update_pending = true;
     memory_region_transaction_commit();
 }
-- 
2.43.0


