Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A6C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqXw-0001QS-Ai; Mon, 24 Jun 2024 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mtp5ZgQKCnEUaljVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--flwu.bounces.google.com>)
 id 1sLqXu-0001Q8-Qf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:44:14 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mtp5ZgQKCnEUaljVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--flwu.bounces.google.com>)
 id 1sLqXs-00081A-Hi
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:44:14 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-7065bc8314cso3583998b3a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719261850; x=1719866650; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AAoHWXATQqD7krZTeZlGyYWpnm7i6H7r5viEN+pXzys=;
 b=j8jrYA83I5cd7LIYZfVCeLIWH94pYtEsWJsHbDB2tPTlN/EwT+i2MMWKCSSUQrVytK
 kkQ8Q5a9VBmftkm+ILBe6BsGQb2wo0RstJ/OywC+kTW+8e15MiKY7t9zyU9ZchTrWfyh
 YDoBkIlydqquhDpdQ7QRe74vYHGfHmkT0uSmeAFULtnLsToOEdwV/Gu+o6QKaXeHoRJ/
 DGa/AbYv8zj/SJYACCq1ZrxoMmT56q968m4ZD7UJ03s9JZn9mHngwLky7+3QYshbH4yl
 tN9O8qmwSuClfYHQmi2XT7K4+GPHvfkkHeGSpcZ+Tnmkj4h/ox2MC5zyUI6qYEAe013U
 eXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719261850; x=1719866650;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AAoHWXATQqD7krZTeZlGyYWpnm7i6H7r5viEN+pXzys=;
 b=fDZp2stSysrFEEQPp6c18pEe1nJ+uYgwbWDBIf1T4VhB736WYq2p3UZ8OnR0tKAmcs
 6lqnWfdnMIWNlxCX1f3ZpXRCyucXmytSxX/q8DaRRdvilUby5jsnNLrAZ2yxg+dAN2oM
 rTr4fvi8sUqafbZe+JNzswMmxLboOHCESQsC9kOqrrez5cWLsxXLSW2TT+0RPZYZ0a5o
 hQdJx6t8AC/UZd3cWepD9Uw4BqXck7B92df11oq6CLWSpIsbYhqAaznsAKRbQJWbv+8x
 XVm+Au173S4eFfr6IpeomJqui6nvloukHDJj26QG+TNMMhZO8HpatghDIGO185o5K03Z
 Qu7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU16CmF00ctYjyjLuIUSiHbskqNKxuiIh1yqaQfxUxBCCT0AdMENo3bI4vWDptQfn6f6zMxDEjlcGbfRGdShbxfcwOUVqg=
X-Gm-Message-State: AOJu0YzZDoPMNTtDYQtaqbjjY5qiC+u5QDWPr7lbqVZPvlOacBNHRVrV
 dJ3JUzUz/sfJgeuQGNczdxihxGJADs7Ev0LOSLByIXomS7Pq8u6FbVyUNg/NPCDqRmoUYQ==
X-Google-Smtp-Source: AGHT+IHAjsTf9HCDT5qOpiAN8fZ8KGbCHW0/nyfPSOt+k+fAHQ12l3DNomdOOuXzOckvemXVPCi1wL8+
X-Received: from flwu-kvm.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ceb])
 (user=flwu job=sendgmr) by 2002:a05:6a00:3319:b0:704:2cd2:7822 with SMTP id
 d2e1a72fcca58-7066e721059mr69088b3a.4.1719261850246; Mon, 24 Jun 2024
 13:44:10 -0700 (PDT)
Date: Mon, 24 Jun 2024 20:43:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624204400.103747-1-flwu@google.com>
Subject: [PATCH 1/2] qom: Rename Object::class into Object::klass
From: Felix Wu <flwu@google.com>
To: peter.maydell@linaro.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 Roman Kiryanov <rkir@google.com>, Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3mtp5ZgQKCnEUaljVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--flwu.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Roman Kiryanov <rkir@google.com>

'class' is a C++ keyword and it prevents from
using the QEMU headers with a C++ compiler.

Google-Bug-Id: 331190993
Change-Id: I9ab7d2d77edef654a9c7b7cb9cd01795a6ed65a2
Signed-off-by: Felix Wu <flwu@google.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/core/qdev-properties-system.c |  2 +-
 include/exec/memory.h            |  2 +-
 include/qom/object.h             |  2 +-
 qom/object.c                     | 90 ++++++++++++++++----------------
 4 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index f13350b4fb..a6781841af 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -431,7 +431,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
         }
 
         if (peers[i]->info->check_peer_type) {
-            if (!peers[i]->info->check_peer_type(peers[i], obj->class, errp)) {
+            if (!peers[i]->info->check_peer_type(peers[i], obj->klass, errp)) {
                 goto out;
             }
         }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2d7c278b9f..e5bd75956e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1808,7 +1808,7 @@ static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
 static inline IOMMUMemoryRegionClass *memory_region_get_iommu_class_nocheck(
         IOMMUMemoryRegion *iommu_mr)
 {
-    return (IOMMUMemoryRegionClass *) (((Object *)iommu_mr)->class);
+    return (IOMMUMemoryRegionClass *) (((Object *)iommu_mr)->klass);
 }
 
 #define memory_region_is_iommu(mr) (memory_region_get_iommu(mr) != NULL)
diff --git a/include/qom/object.h b/include/qom/object.h
index 13d3a655dd..7afdb261a8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -153,7 +153,7 @@ struct ObjectClass
 struct Object
 {
     /* private: */
-    ObjectClass *class;
+    ObjectClass *klass;
     ObjectFree *free;
     GHashTable *properties;
     uint32_t ref;
diff --git a/qom/object.c b/qom/object.c
index 157a45c5f8..133cd08763 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -68,7 +68,7 @@ struct TypeImpl
     const char *parent;
     TypeImpl *parent_type;
 
-    ObjectClass *class;
+    ObjectClass *klass;
 
     int num_interfaces;
     InterfaceImpl interfaces[MAX_INTERFACES];
@@ -304,11 +304,11 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
     type_initialize(iface_impl);
     g_free((char *)info.name);
 
-    new_iface = (InterfaceClass *)iface_impl->class;
-    new_iface->concrete_class = ti->class;
+    new_iface = (InterfaceClass *)iface_impl->klass;
+    new_iface->concrete_class = ti->klass;
     new_iface->interface_type = interface_type;
 
-    ti->class->interfaces = g_slist_append(ti->class->interfaces, new_iface);
+    ti->klass->interfaces = g_slist_append(ti->klass->interfaces, new_iface);
 }
 
 static void object_property_free(gpointer data)
@@ -329,7 +329,7 @@ static void type_initialize(TypeImpl *ti)
 {
     TypeImpl *parent;
 
-    if (ti->class) {
+    if (ti->klass) {
         return;
     }
 
@@ -350,7 +350,7 @@ static void type_initialize(TypeImpl *ti)
         assert(!ti->instance_finalize);
         assert(!ti->num_interfaces);
     }
-    ti->class = g_malloc0(ti->class_size);
+    ti->klass = g_malloc0(ti->class_size);
 
     parent = type_get_parent(ti);
     if (parent) {
@@ -360,10 +360,10 @@ static void type_initialize(TypeImpl *ti)
 
         g_assert(parent->class_size <= ti->class_size);
         g_assert(parent->instance_size <= ti->instance_size);
-        memcpy(ti->class, parent->class, parent->class_size);
-        ti->class->interfaces = NULL;
+        memcpy(ti->klass, parent->klass, parent->class_size);
+        ti->klass->interfaces = NULL;
 
-        for (e = parent->class->interfaces; e; e = e->next) {
+        for (e = parent->klass->interfaces; e; e = e->next) {
             InterfaceClass *iface = e->data;
             ObjectClass *klass = OBJECT_CLASS(iface);
 
@@ -377,7 +377,7 @@ static void type_initialize(TypeImpl *ti)
                              ti->interfaces[i].typename, parent->name);
                 abort();
             }
-            for (e = ti->class->interfaces; e; e = e->next) {
+            for (e = ti->klass->interfaces; e; e = e->next) {
                 TypeImpl *target_type = OBJECT_CLASS(e->data)->type;
 
                 if (type_is_ancestor(target_type, t)) {
@@ -393,20 +393,20 @@ static void type_initialize(TypeImpl *ti)
         }
     }
 
-    ti->class->properties = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
+    ti->klass->properties = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
                                                   object_property_free);
 
-    ti->class->type = ti;
+    ti->klass->type = ti;
 
     while (parent) {
         if (parent->class_base_init) {
-            parent->class_base_init(ti->class, ti->class_data);
+            parent->class_base_init(ti->klass, ti->class_data);
         }
         parent = type_get_parent(parent);
     }
 
     if (ti->class_init) {
-        ti->class_init(ti->class, ti->class_data);
+        ti->class_init(ti->klass, ti->class_data);
     }
 }
 
@@ -554,7 +554,7 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
     g_assert(size >= type->instance_size);
 
     memset(obj, 0, type->instance_size);
-    obj->class = type->class;
+    obj->klass = type->klass;
     object_ref(obj);
     object_class_property_init_all(obj);
     obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
@@ -731,7 +731,7 @@ static void object_deinit(Object *obj, TypeImpl *type)
 static void object_finalize(void *data)
 {
     Object *obj = data;
-    TypeImpl *ti = obj->class->type;
+    TypeImpl *ti = obj->klass->type;
 
     object_property_del_all(obj);
     object_deinit(obj, ti);
@@ -912,7 +912,7 @@ Object *object_dynamic_cast(Object *obj, const char *typename)
 Object *object_dynamic_cast_assert(Object *obj, const char *typename,
                                    const char *file, int line, const char *func)
 {
-    trace_object_dynamic_cast_assert(obj ? obj->class->type->name : "(null)",
+    trace_object_dynamic_cast_assert(obj ? obj->klass->type->name : "(null)",
                                      typename, file, line, func);
 
 #ifdef CONFIG_QOM_CAST_DEBUG
@@ -920,7 +920,7 @@ Object *object_dynamic_cast_assert(Object *obj, const char *typename,
     Object *inst;
 
     for (i = 0; obj && i < OBJECT_CLASS_CAST_CACHE; i++) {
-        if (qatomic_read(&obj->class->object_cast_cache[i]) == typename) {
+        if (qatomic_read(&obj->klass->object_cast_cache[i]) == typename) {
             goto out;
         }
     }
@@ -937,10 +937,10 @@ Object *object_dynamic_cast_assert(Object *obj, const char *typename,
 
     if (obj && obj == inst) {
         for (i = 1; i < OBJECT_CLASS_CAST_CACHE; i++) {
-            qatomic_set(&obj->class->object_cast_cache[i - 1],
-                       qatomic_read(&obj->class->object_cast_cache[i]));
+            qatomic_set(&obj->klass->object_cast_cache[i - 1],
+                       qatomic_read(&obj->klass->object_cast_cache[i]));
         }
-        qatomic_set(&obj->class->object_cast_cache[i - 1], typename);
+        qatomic_set(&obj->klass->object_cast_cache[i - 1], typename);
     }
 
 out:
@@ -971,7 +971,7 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
         return NULL;
     }
 
-    if (type->class->interfaces &&
+    if (type->klass->interfaces &&
             type_is_ancestor(target_type, type_interface)) {
         int found = 0;
         GSList *i;
@@ -996,45 +996,45 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
     return ret;
 }
 
-ObjectClass *object_class_dynamic_cast_assert(ObjectClass *class,
+ObjectClass *object_class_dynamic_cast_assert(ObjectClass *klass,
                                               const char *typename,
                                               const char *file, int line,
                                               const char *func)
 {
     ObjectClass *ret;
 
-    trace_object_class_dynamic_cast_assert(class ? class->type->name : "(null)",
+    trace_object_class_dynamic_cast_assert(klass ? klass->type->name : "(null)",
                                            typename, file, line, func);
 
 #ifdef CONFIG_QOM_CAST_DEBUG
     int i;
 
-    for (i = 0; class && i < OBJECT_CLASS_CAST_CACHE; i++) {
-        if (qatomic_read(&class->class_cast_cache[i]) == typename) {
-            ret = class;
+    for (i = 0; klass && i < OBJECT_CLASS_CAST_CACHE; i++) {
+        if (qatomic_read(&klass->class_cast_cache[i]) == typename) {
+            ret = klass;
             goto out;
         }
     }
 #else
-    if (!class || !class->interfaces) {
-        return class;
+    if (!klass || !klass->interfaces) {
+        return klass;
     }
 #endif
 
-    ret = object_class_dynamic_cast(class, typename);
-    if (!ret && class) {
+    ret = object_class_dynamic_cast(klass, typename);
+    if (!ret && klass) {
         fprintf(stderr, "%s:%d:%s: Object %p is not an instance of type %s\n",
-                file, line, func, class, typename);
+                file, line, func, klass, typename);
         abort();
     }
 
 #ifdef CONFIG_QOM_CAST_DEBUG
-    if (class && ret == class) {
+    if (klass && ret == klass) {
         for (i = 1; i < OBJECT_CLASS_CAST_CACHE; i++) {
-            qatomic_set(&class->class_cast_cache[i - 1],
-                       qatomic_read(&class->class_cast_cache[i]));
+            qatomic_set(&klass->class_cast_cache[i - 1],
+                       qatomic_read(&klass->class_cast_cache[i]));
         }
-        qatomic_set(&class->class_cast_cache[i - 1], typename);
+        qatomic_set(&klass->class_cast_cache[i - 1], typename);
     }
 out:
 #endif
@@ -1043,12 +1043,12 @@ out:
 
 const char *object_get_typename(const Object *obj)
 {
-    return obj->class->type->name;
+    return obj->klass->type->name;
 }
 
 ObjectClass *object_get_class(Object *obj)
 {
-    return obj->class;
+    return obj->klass;
 }
 
 bool object_class_is_abstract(ObjectClass *klass)
@@ -1071,7 +1071,7 @@ ObjectClass *object_class_by_name(const char *typename)
 
     type_initialize(type);
 
-    return type->class;
+    return type->klass;
 }
 
 ObjectClass *module_object_class_by_name(const char *typename)
@@ -1093,9 +1093,9 @@ ObjectClass *module_object_class_by_name(const char *typename)
     return oc;
 }
 
-ObjectClass *object_class_get_parent(ObjectClass *class)
+ObjectClass *object_class_get_parent(ObjectClass *klass)
 {
-    TypeImpl *type = type_get_parent(class->type);
+    TypeImpl *type = type_get_parent(klass->type);
 
     if (!type) {
         return NULL;
@@ -1103,7 +1103,7 @@ ObjectClass *object_class_get_parent(ObjectClass *class)
 
     type_initialize(type);
 
-    return type->class;
+    return type->klass;
 }
 
 typedef struct OCFData
@@ -1122,7 +1122,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
     ObjectClass *k;
 
     type_initialize(type);
-    k = type->class;
+    k = type->klass;
 
     if (!data->include_abstract && type->abstract) {
         return;
@@ -1792,8 +1792,8 @@ static void object_finalize_child_property(Object *obj, const char *name,
 {
     Object *child = opaque;
 
-    if (child->class->unparent) {
-        (child->class->unparent)(child);
+    if (child->klass->unparent) {
+        (child->klass->unparent)(child);
     }
     child->parent = NULL;
     object_unref(child);
-- 
2.45.2.741.gdbec12cfda-goog


