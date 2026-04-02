Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F599D6AB18
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q3C-0001Iu-3p; Thu, 02 Apr 2026 17:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2d-0000BE-GM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2a-0007Eq-0U
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:30 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c1da7ac63so234958366b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167046; x=1775771846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8ZREsUktJ+jWPapDw6PB5NQmm74pQN/VTasE9D0cnk=;
 b=Dc0icwgpvpqvvpW3+72803p5YmOe0ooA2lLuA7tRXQDlx2Kj+wotv5Yw6G5+go54bW
 xThElLEWvWsDwukoJxmafyeDW3tIqTA1g+KxrlwmSJiIzC0l57XTwZDg8zXncVp5hW6s
 i1ZRRoCmqyBO3aOXj62hjTnQttftiEKeDIq+90DvjwedHnORBii1+m28P0i3mIJC1MT1
 1Qz5h09OkllU/iV1zcC+n3E7IBqyE0lUxThLbdslRR/mS0dO9WS4f/FCGA09eO7KrLBW
 b3hHITOv+G3eypDn+fskzkv8Qp6N/pAyNSM5aXulfN//1tJf0Eom4sO8MNI3+tnK2Jyn
 TGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167046; x=1775771846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x8ZREsUktJ+jWPapDw6PB5NQmm74pQN/VTasE9D0cnk=;
 b=jbmYuMzXeN/FJ5fdK0E0ZZ2DxyI59JaAHVxBpf2De99Aq2AgsHacSbwcIf3bqVF3yR
 TMh7iUtrnFNiWgFlt9cqKE8HItGa2vXvkj2MTlYienKoYkob1UszfzIKMsFFMI00nl9g
 dbqFdlXL5WSCeqrCfFa7GBj7ra1caLyzRSKkg6WskzKH9FljJBQ2WWxYXxifbJeIrCZd
 VlCV1DlaU2oV38MgmApYN6qtImb/5pVC/GXLcDwQoMi8qwGAkCEp88IVsD+Oo9YTOgwl
 9vqRC9/ff0UAMazSmkGa48GAaWzeLsDznGUbttK9KNqjq03D700skc/XZpmzS4ZDFVsI
 7bPQ==
X-Gm-Message-State: AOJu0YwTSG/DF73KBclLdWKU06ZtzmuLU+eBw+wli3g102xKRTdYhvud
 rVbptcw3IIQcLQHW3Iv5118bmJ4cvMMKj1FWR92WYize3LXH/RUn0KhQnP1Fk9BS
X-Gm-Gg: ATEYQzxSfg8xFZjV0FRmVRIeNCYNsRBetOGfhg9pPrdvc5J0C+UbYJ/5E/pqavDiCN6
 QWaM9FwA7F9HmuoJ15HUynnyIDkqqtoPweDbbiTZ8Xfl9Hmc7/0mYuMWDEAug3fA4e+71Igyp8i
 IpFYU5lit2QlInpIruHYNQcVcbrWfkgnonutCEMO1SfB3YtfTfTlI8BEPcW/ENc4L1XRwVwg1OW
 bTBT2KaYSVopq20BrD4h43OCOc9V5IE5eRpqH+T0LcG5NKntCv/txoWng1OVRpLgxoQROWYWQj2
 CnDnt8L+BOJGPPkbKB4X/94cmwj55XFUA7KGxJjHBVxFsr8dRAV45oncxScH5dFrifhPe2vYGOj
 jAd648q4R1qOudZEbLzv+kwSTTf2IY9m5Lrp2Uo8h/EoL3e59uwLCc9/kOwhEshiYUJbtpsCb+G
 aFGYIZ0S/aKu7UItZd7Pr4GsvFpprxs0/DQjzCQoAGisFg7FnVR8HCV8pE1AcIBKvdUw58QMCeP
 83GiPZQ
X-Received: by 2002:a17:907:6093:b0:b94:858:5807 with SMTP id
 a640c23a62f3a-b9c679adc2fmr25890166b.25.1775167046059; 
 Thu, 02 Apr 2026 14:57:26 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:25 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 25/33] system/memory: add setters for MemoryRegion
 properties
Date: Thu,  2 Apr 2026 23:56:10 +0200
Message-ID: <20260402215629.745866-26-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x631.google.com
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
index 56f3225b21..cd463a3dde 100644
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
 
@@ -2666,6 +2874,9 @@ void memory_region_set_size(MemoryRegion *mr, uint64_t size)
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


