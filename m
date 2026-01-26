Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE73D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd9-0001f9-ND; Mon, 26 Jan 2026 12:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcy-0001UC-Bd
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcw-0000EN-A7
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:52 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-435903c4040so2927399f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449429; x=1770054229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rs6OZbCjNekEZyKGP1riYjsv7cAl0YSLCjdr3zwLJfM=;
 b=SRZBOSfRUfHOwUjz2gGRdbjYqcCWwRXkk9gCzRbRUgrNIZ4waiX6WebLS4hlxeWAH9
 /gfFluvLwX3k6bO2emN8Q9CyCHIfuFNNh+o/QTDh1GG1DRGS5TbSrmGAHTh7tGYqZFUv
 nwNvZIAaDOcPt/WJFCVkPWyUzzsN4PjH3xg7gab/n3NgMzKzPj1HvY0ixxmI2P5GmYp7
 Fhfb+zbtMtk0HqWT/bTTGaH4ngiiVelMQ8iM8luVThwCnxdq8K2vMpENI5HbnltugvUs
 hQn60birWlh9BIrYHnznwfcWV6m5CU1aGRQdLt6HhnzlS//VexDkcrTYXYy1gjO+P+jY
 2lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449429; x=1770054229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rs6OZbCjNekEZyKGP1riYjsv7cAl0YSLCjdr3zwLJfM=;
 b=AANaTUTM479Z7pSL799G6Dz1J8gRn7Vn+8F/Gxgq7Mrod44SdXhWqrMP/aBYNkEvz5
 Vx/LCx+TFG9b3C8nDSWv0ScXsp4Imrp7B9cY+CJ0y4eG5EWR7paDdVBvQ9JnvN6ik3pU
 4WVcp7eJzOrqXiGcHiSuYFmSJGVDIKLJhjcyM9YialIA2uY1cEJJwahvQGb399B0y6Zi
 tpkrb4QxSP5ew0DrqVbVZMeKfYDE8rotXNU6Yi9xZM1lQ+K1lHNzMiEqK4tDfqkpetEK
 4mNPIj4C1DCXpJ2EW2K9vimMywKUJwaETavb5zJOuhzSOayaJMLga4RPy6aoO4t2rPJ6
 8F6Q==
X-Gm-Message-State: AOJu0YxoSxGo4K7SmghQ7xlV738QmvB2Knj7aW6TrodIy2B2UN4EwYEA
 IP0yfaURJrDI1ekwj0XDX78AMHjqHpo2dDtsmld0g8WQP8xKppdiCIKcraokoFyb
X-Gm-Gg: AZuq6aLi+GwZ+vlxD2ozEqF2MGgZU7uaUpJ+JDL9YUu7YAG5a5L/VrorOIeLkoFUNPm
 2My8pY0CdZ9wzqpN9aYJsY5PhIeL/RMZTUfcK39qAnsQXhHKlpIotEkp0xD44oED17kyXtUMgPj
 FEfJkptCUhOFHdSaC2hE4au834O27KvZu3FEaAFRzp3UmQjdMi5wMpLOhBdsIW2JvSZM+/RP1fh
 y3cmFoKN9YE1i7Ntfh9aunVuYx7R/uIok+1+geDQeZHVng0Tc9cFHarpjGzPB5mc8Fd8wuq2FJk
 llc/g5QCJcIb+Sylwd3cIToGcqYzt63r9aBOr6nD/KkREIucIPhoCHphKLHOiKFcyguBXpW0nSd
 JFhsgdElKQ81l0dX1wL6RRYuC7ONiAhkILU216Y74sn4pQFxKulcKsbYW2bahWDeP0tkeymWBuk
 jQOcgeu9P4LXOkumqpw0tlgBhuxig0xqI9GVCf8FVMcfyp9aHi2E+hpQ==
X-Received: by 2002:a05:6000:22c4:b0:430:f463:b6ae with SMTP id
 ffacd0b85a97d-435ca1ae140mr9940306f8f.53.1769449428436; 
 Mon, 26 Jan 2026 09:43:48 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:48 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 24/27] system/memory: add setters for MemoryRegion properties
Date: Mon, 26 Jan 2026 18:43:10 +0100
Message-ID: <20260126174313.1418150-25-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x433.google.com
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
 system/memory.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 161 insertions(+), 5 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4bf00d82bc..a683af525a 100644
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
@@ -1285,6 +1355,70 @@ static void memory_region_get_priority(Object *obj, Visitor *v,
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
@@ -1294,6 +1428,19 @@ static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
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
@@ -1309,19 +1456,25 @@ static void memory_region_initfn(Object *obj)
     op = object_property_add(OBJECT(mr), "container",
                              "link<" TYPE_MEMORY_REGION ">",
                              memory_region_get_container,
-                             NULL, /* memory_region_set_container */
+                             memory_region_set_container,
                              NULL, NULL);
     op->resolve = memory_region_resolve_container;
 
-    object_property_add_uint64_ptr(OBJECT(mr), "addr",
-                                   &mr->addr, OBJ_PROP_FLAG_READ);
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
 
@@ -2751,6 +2904,9 @@ void memory_region_set_size(MemoryRegion *mr, uint64_t size)
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


