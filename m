Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EDCC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqY3-0001RE-KD; Mon, 24 Jun 2024 16:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3n9p5ZgQKCnYZfqoaiiafY.WigkYgo-XYpYfhihaho.ila@flex--flwu.bounces.google.com>)
 id 1sLqY1-0001Qq-2f
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:44:21 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3n9p5ZgQKCnYZfqoaiiafY.WigkYgo-XYpYfhihaho.ila@flex--flwu.bounces.google.com>)
 id 1sLqXx-00082j-VP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:44:20 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-6c7e13b6a62so5985842a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719261855; x=1719866655; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=aGBmKKB8Yopl1v8VAiSVpQWd9YHkPrf32V7NGqIxem8=;
 b=K8LL589AMRHEOpei+FJ0PRPXakVNYW8RNP+zCnxIpO3Qd73/svq3vmYcw7VNIIPRX0
 VsBb5RQRlwcrE/mBLbKVGFrvzd4T0yclv3AZwEMOl86voWwC7jy8W2U0Cw4GEZvaqGXP
 OXYAKo1dz+LmUTw9F5GEORKT3+eIseZnNFBRESIYc2Nw2+oNssVmOGpVyOfNckmQIM5o
 7JLyWFXbEWg8Uca+0vrGatgDFcyu2GouzroWg9Gaj96zgp4mQjchA95ak8JRRpJs/iJN
 pza6hUXQkVT9zCxXoJ7xmRg0qvKfVC0/HdLM1zSnfC7+iL/PumgscXCt2SuAbYu9dTRY
 xIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719261855; x=1719866655;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aGBmKKB8Yopl1v8VAiSVpQWd9YHkPrf32V7NGqIxem8=;
 b=swZkakm1EgMEKC8IQz743nAGVRj1Nib3PoX5Ha21GHdbhUTXPjIe1NTI2+3dM5dSOu
 GZG866fDny3I/dHHcP7VP4f+JTnvyN+HgIeO+7AAohYcQJnoSxygh7X/N94ewko4/7Ss
 DmhGfMYFdOO0I6orWV9lcb2M8O6Mdho3viAReRi2CPWNclcopsZW5axgKZHHKg++lN9j
 E4kvZcjAvy+5cznOpp32lgTyxox/zUfzAEvztHeXgMeoGxDeAFg13d1eHsCaE9b4Tmfw
 RYYkmY9FOGLmEbuE/SJlGgO6D2nVAm1P3Aydvw8xzTi1K54E8xAhbpQr0yc7nPjLTO7Z
 ibGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbvkAYjx37KtHHtUb2QidGCk1KAzwA3AcHBgH8cumv9LecgO86EGtyyEUF5Z6RGSQjG8wbk2fvXtJVkXWnfSVZCTCR0q0=
X-Gm-Message-State: AOJu0YyUo4jxn5EXmubJ0r40ORTUtz9u3283V2tVed1mrWXdF9nBoJez
 yPCyZiHENzj8estCuCwJrwQP3US3k95eKEN8gj2GsR/lQtnHD2jNEEbtQh5Z3yzkwxsuYQ==
X-Google-Smtp-Source: AGHT+IEAk6sT9FFCXRvCNIdFBSZB74TWu/ymh7vLL6bB6f85CZdvNdm0rToiggbBk9YBZ50SoVAVSkXk
X-Received: from flwu-kvm.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ceb])
 (user=flwu job=sendgmr) by 2002:a65:6645:0:b0:717:7d1e:63d0 with SMTP id
 41be03b00d2f7-71b5fe16796mr17478a12.12.1719261855283; Mon, 24 Jun 2024
 13:44:15 -0700 (PDT)
Date: Mon, 24 Jun 2024 20:44:00 +0000
In-Reply-To: <20240624204400.103747-1-flwu@google.com>
Mime-Version: 1.0
References: <20240624204400.103747-1-flwu@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624204400.103747-2-flwu@google.com>
Subject: [PATCH 2/2] include/qom: Rename typename into type_name
From: Felix Wu <flwu@google.com>
To: peter.maydell@linaro.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 Roman Kiryanov <rkir@google.com>, Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3n9p5ZgQKCnYZfqoaiiafY.WigkYgo-XYpYfhihaho.ila@flex--flwu.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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

`typename` is a C++ keyword and it prevents from
using the QEMU headers with a C++ compiler.

Google-Bug-Id: 331190993
Change-Id: Iff313ca5ec157a1a3826b4f5665073534d961a26
Signed-off-by: Felix Wu <flwu@google.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 hw/core/bus.c          |   8 +--
 include/hw/qdev-core.h |   4 +-
 include/qom/object.h   |  78 +++++++++++++--------------
 qom/object.c           | 120 ++++++++++++++++++++---------------------
 4 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index b9d89495cd..07c5a83673 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -152,18 +152,18 @@ static void bus_unparent(Object *obj)
     bus->parent = NULL;
 }
 
-void qbus_init(void *bus, size_t size, const char *typename,
+void qbus_init(void *bus, size_t size, const char *type_name,
                DeviceState *parent, const char *name)
 {
-    object_initialize(bus, size, typename);
+    object_initialize(bus, size, type_name);
     qbus_init_internal(bus, parent, name);
 }
 
-BusState *qbus_new(const char *typename, DeviceState *parent, const char *name)
+BusState *qbus_new(const char *type_name, DeviceState *parent, const char *name)
 {
     BusState *bus;
 
-    bus = BUS(object_new(typename));
+    bus = BUS(object_new(type_name));
     qbus_init_internal(bus, parent, name);
 
     return bus;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5336728a23..ede4b74bd8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -867,9 +867,9 @@ DeviceState *qdev_find_recursive(BusState *bus, const char *id);
 typedef int (qbus_walkerfn)(BusState *bus, void *opaque);
 typedef int (qdev_walkerfn)(DeviceState *dev, void *opaque);
 
-void qbus_init(void *bus, size_t size, const char *typename,
+void qbus_init(void *bus, size_t size, const char *type_name,
                DeviceState *parent, const char *name);
-BusState *qbus_new(const char *typename, DeviceState *parent, const char *name);
+BusState *qbus_new(const char *type_name, DeviceState *parent, const char *name);
 bool qbus_realize(BusState *bus, Error **errp);
 void qbus_unrealize(BusState *bus);
 
diff --git a/include/qom/object.h b/include/qom/object.h
index 7afdb261a8..4e69a3506d 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -617,7 +617,7 @@ Object *object_new_with_class(ObjectClass *klass);
 
 /**
  * object_new:
- * @typename: The name of the type of the object to instantiate.
+ * @type_name: The name of the type of the object to instantiate.
  *
  * This function will initialize a new object using heap allocated memory.
  * The returned object has a reference count of 1, and will be freed when
@@ -625,11 +625,11 @@ Object *object_new_with_class(ObjectClass *klass);
  *
  * Returns: The newly allocated and instantiated object.
  */
-Object *object_new(const char *typename);
+Object *object_new(const char *type_name);
 
 /**
  * object_new_with_props:
- * @typename:  The name of the type of the object to instantiate.
+ * @type_name:  The name of the type of the object to instantiate.
  * @parent: the parent object
  * @id: The unique ID of the object
  * @errp: pointer to error object
@@ -673,7 +673,7 @@ Object *object_new(const char *typename);
  *
  * Returns: The newly allocated, instantiated & initialized object.
  */
-Object *object_new_with_props(const char *typename,
+Object *object_new_with_props(const char *type_name,
                               Object *parent,
                               const char *id,
                               Error **errp,
@@ -681,7 +681,7 @@ Object *object_new_with_props(const char *typename,
 
 /**
  * object_new_with_propv:
- * @typename:  The name of the type of the object to instantiate.
+ * @type_name:  The name of the type of the object to instantiate.
  * @parent: the parent object
  * @id: The unique ID of the object
  * @errp: pointer to error object
@@ -689,7 +689,7 @@ Object *object_new_with_props(const char *typename,
  *
  * See object_new_with_props() for documentation.
  */
-Object *object_new_with_propv(const char *typename,
+Object *object_new_with_propv(const char *type_name,
                               Object *parent,
                               const char *id,
                               Error **errp,
@@ -755,13 +755,13 @@ bool object_set_propv(Object *obj, Error **errp, va_list vargs);
  * object_initialize:
  * @obj: A pointer to the memory to be used for the object.
  * @size: The maximum size available at @obj for the object.
- * @typename: The name of the type of the object to instantiate.
+ * @type_name: The name of the type of the object to instantiate.
  *
  * This function will initialize an object.  The memory for the object should
  * have already been allocated.  The returned object has a reference count of 1,
  * and will be finalized when the last reference is dropped.
  */
-void object_initialize(void *obj, size_t size, const char *typename);
+void object_initialize(void *obj, size_t size, const char *type_name);
 
 /**
  * object_initialize_child_with_props:
@@ -834,19 +834,19 @@ void object_initialize_child_internal(Object *parent, const char *propname,
 /**
  * object_dynamic_cast:
  * @obj: The object to cast.
- * @typename: The @typename to cast to.
+ * @type_name: The @type_name to cast to.
  *
- * This function will determine if @obj is-a @typename.  @obj can refer to an
+ * This function will determine if @obj is-a @type_name.  @obj can refer to an
  * object or an interface associated with an object.
  *
  * Returns: This function returns @obj on success or #NULL on failure.
  */
-Object *object_dynamic_cast(Object *obj, const char *typename);
+Object *object_dynamic_cast(Object *obj, const char *type_name);
 
 /**
  * object_dynamic_cast_assert:
  * @obj: The object to cast.
- * @typename: The @typename to cast to.
+ * @type_name: The @type_name to cast to.
  * @file: Source code file where function was called
  * @line: Source code line where function was called
  * @func: Name of function where this function was called
@@ -857,7 +857,7 @@ Object *object_dynamic_cast(Object *obj, const char *typename);
  * This function is not meant to be called directly, but only through
  * the wrapper macro OBJECT_CHECK.
  */
-Object *object_dynamic_cast_assert(Object *obj, const char *typename,
+Object *object_dynamic_cast_assert(Object *obj, const char *type_name,
                                    const char *file, int line, const char *func);
 
 /**
@@ -948,7 +948,7 @@ void object_set_properties_from_keyval(Object *obj, const QDict *qdict,
 /**
  * object_class_dynamic_cast_assert:
  * @klass: The #ObjectClass to attempt to cast.
- * @typename: The QOM typename of the class to cast to.
+ * @type_name: The QOM typename of the class to cast to.
  * @file: Source code file where function was called
  * @line: Source code line where function was called
  * @func: Name of function where this function was called
@@ -960,26 +960,26 @@ void object_set_properties_from_keyval(Object *obj, const QDict *qdict,
  * the wrapper macro OBJECT_CLASS_CHECK.
  */
 ObjectClass *object_class_dynamic_cast_assert(ObjectClass *klass,
-                                              const char *typename,
+                                              const char *type_name,
                                               const char *file, int line,
                                               const char *func);
 
 /**
  * object_class_dynamic_cast:
  * @klass: The #ObjectClass to attempt to cast.
- * @typename: The QOM typename of the class to cast to.
+ * @type_name: The QOM typename of the class to cast to.
  *
- * Returns: If @typename is a class, this function returns @klass if
- * @typename is a subtype of @klass, else returns #NULL.
+ * Returns: If @type_name is a class, this function returns @klass if
+ * @type_name is a subtype of @klass, else returns #NULL.
  *
- * If @typename is an interface, this function returns the interface
+ * If @type_name is an interface, this function returns the interface
  * definition for @klass if @klass implements it unambiguously; #NULL
  * is returned if @klass does not implement the interface or if multiple
  * classes or interfaces on the hierarchy leading to @klass implement
  * it.  (FIXME: perhaps this can be detected at type definition time?)
  */
 ObjectClass *object_class_dynamic_cast(ObjectClass *klass,
-                                       const char *typename);
+                                       const char *type_name);
 
 /**
  * object_class_get_parent:
@@ -1007,23 +1007,23 @@ bool object_class_is_abstract(ObjectClass *klass);
 
 /**
  * object_class_by_name:
- * @typename: The QOM typename to obtain the class for.
+ * @type_name: The QOM typename to obtain the class for.
  *
- * Returns: The class for @typename or %NULL if not found.
+ * Returns: The class for @type_name or %NULL if not found.
  */
-ObjectClass *object_class_by_name(const char *typename);
+ObjectClass *object_class_by_name(const char *type_name);
 
 /**
  * module_object_class_by_name:
- * @typename: The QOM typename to obtain the class for.
+ * @type_name: The QOM typename to obtain the class for.
  *
  * For objects which might be provided by a module.  Behaves like
  * object_class_by_name, but additionally tries to load the module
  * needed in case the class is not available.
  *
- * Returns: The class for @typename or %NULL if not found.
+ * Returns: The class for @type_name or %NULL if not found.
  */
-ObjectClass *module_object_class_by_name(const char *typename);
+ObjectClass *module_object_class_by_name(const char *type_name);
 
 void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
                           const char *implements_type, bool include_abstract,
@@ -1452,7 +1452,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * object_property_get_enum:
  * @obj: the object
  * @name: the name of the property
- * @typename: the name of the enum data type
+ * @type_name: the name of the enum data type
  * @errp: returns an error if this function fails
  *
  * Returns: the value of the property, converted to an integer (which
@@ -1460,7 +1460,7 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
  * value is not an enum).
  */
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp);
+                             const char *type_name, Error **errp);
 
 /**
  * object_property_set:
@@ -1594,7 +1594,7 @@ Object *object_resolve_path(const char *path, bool *ambiguous);
 /**
  * object_resolve_path_type:
  * @path: the path to resolve
- * @typename: the type to look for.
+ * @type_name: the type to look for.
  * @ambiguous: returns true if the path resolution failed because of an
  *   ambiguous match
  *
@@ -1604,12 +1604,12 @@ Object *object_resolve_path(const char *path, bool *ambiguous);
  * ambiguous.
  *
  * For both partial and absolute paths, the return value goes through
- * a dynamic cast to @typename.  This is important if either the link,
- * or the typename itself are of interface types.
+ * a dynamic cast to @type_name.  This is important if either the link,
+ * or the @type_name itself are of interface types.
  *
  * Returns: The matched object or NULL on path lookup failure.
  */
-Object *object_resolve_path_type(const char *path, const char *typename,
+Object *object_resolve_path_type(const char *path, const char *type_name,
                                  bool *ambiguous);
 
 /**
@@ -1797,25 +1797,25 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
  * object_property_add_enum:
  * @obj: the object to add a property to
  * @name: the name of the property
- * @typename: the name of the enum data type
+ * @type_name: the name of the enum data type
  * @lookup: enum value namelookup table
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
  *
  * Add an enum property using getters/setters.  This function will add a
- * property of type '@typename'.
+ * property of type '@type_name'.
  *
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_enum(Object *obj, const char *name,
-                              const char *typename,
+                              const char *type_name,
                               const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **));
 
 ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
-                                    const char *typename,
+                                    const char *type_name,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
@@ -2034,11 +2034,11 @@ Object *container_get(Object *root, const char *path);
 
 /**
  * object_type_get_instance_size:
- * @typename: Name of the Type whose instance_size is required
+ * @type_name: Name of the Type whose instance_size is required
  *
- * Returns the instance_size of the given @typename.
+ * Returns the instance_size of the given @type_name.
  */
-size_t object_type_get_instance_size(const char *typename);
+size_t object_type_get_instance_size(const char *type_name);
 
 /**
  * object_property_help:
diff --git a/qom/object.c b/qom/object.c
index 133cd08763..17f5bf11f4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -42,7 +42,7 @@ typedef struct TypeImpl TypeImpl;
 
 struct InterfaceImpl
 {
-    const char *typename;
+    const char *type_name;
 };
 
 struct TypeImpl
@@ -130,7 +130,7 @@ static TypeImpl *type_new(const TypeInfo *info)
     ti->abstract = info->abstract;
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
-        ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
+        ti->interfaces[i].type_name = g_strdup(info->interfaces[i].type);
     }
     ti->num_interfaces = i;
 
@@ -262,9 +262,9 @@ static size_t type_object_get_align(TypeImpl *ti)
     return 0;
 }
 
-size_t object_type_get_instance_size(const char *typename)
+size_t object_type_get_instance_size(const char *type_name)
 {
-    TypeImpl *type = type_get_by_name(typename);
+    TypeImpl *type = type_get_by_name(type_name);
 
     g_assert(type != NULL);
     return type_object_get_size(type);
@@ -371,10 +371,10 @@ static void type_initialize(TypeImpl *ti)
         }
 
         for (i = 0; i < ti->num_interfaces; i++) {
-            TypeImpl *t = type_get_by_name(ti->interfaces[i].typename);
+            TypeImpl *t = type_get_by_name(ti->interfaces[i].type_name);
             if (!t) {
                 error_report("missing interface '%s' for object '%s'",
-                             ti->interfaces[i].typename, parent->name);
+                             ti->interfaces[i].type_name, parent->name);
                 abort();
             }
             for (e = ti->klass->interfaces; e; e = e->next) {
@@ -563,23 +563,23 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
     object_post_init_with_type(obj, type);
 }
 
-void object_initialize(void *data, size_t size, const char *typename)
+void object_initialize(void *data, size_t size, const char *type_name)
 {
-    TypeImpl *type = type_get_by_name(typename);
+    TypeImpl *type = type_get_by_name(type_name);
 
 #ifdef CONFIG_MODULES
     if (!type) {
-        int rv = module_load_qom(typename, &error_fatal);
+        int rv = module_load_qom(type_name, &error_fatal);
         if (rv > 0) {
-            type = type_get_by_name(typename);
+            type = type_get_by_name(type_name);
         } else {
-            error_report("missing object type '%s'", typename);
+            error_report("missing object type '%s'", type_name);
             exit(1);
         }
     }
 #endif
     if (!type) {
-        error_report("missing object type '%s'", typename);
+        error_report("missing object type '%s'", type_name);
         abort();
     }
 
@@ -790,15 +790,15 @@ Object *object_new_with_class(ObjectClass *klass)
     return object_new_with_type(klass->type);
 }
 
-Object *object_new(const char *typename)
+Object *object_new(const char *type_name)
 {
-    TypeImpl *ti = type_get_by_name(typename);
+    TypeImpl *ti = type_get_by_name(type_name);
 
     return object_new_with_type(ti);
 }
 
 
-Object *object_new_with_props(const char *typename,
+Object *object_new_with_props(const char *type_name,
                               Object *parent,
                               const char *id,
                               Error **errp,
@@ -808,14 +808,14 @@ Object *object_new_with_props(const char *typename,
     Object *obj;
 
     va_start(vargs, errp);
-    obj = object_new_with_propv(typename, parent, id, errp, vargs);
+    obj = object_new_with_propv(type_name, parent, id, errp, vargs);
     va_end(vargs);
 
     return obj;
 }
 
 
-Object *object_new_with_propv(const char *typename,
+Object *object_new_with_propv(const char *type_name,
                               Object *parent,
                               const char *id,
                               Error **errp,
@@ -825,14 +825,14 @@ Object *object_new_with_propv(const char *typename,
     ObjectClass *klass;
     UserCreatable *uc;
 
-    klass = object_class_by_name(typename);
+    klass = object_class_by_name(type_name);
     if (!klass) {
-        error_setg(errp, "invalid object type: %s", typename);
+        error_setg(errp, "invalid object type: %s", type_name);
         return NULL;
     }
 
     if (object_class_is_abstract(klass)) {
-        error_setg(errp, "object type '%s' is abstract", typename);
+        error_setg(errp, "object type '%s' is abstract", type_name);
         return NULL;
     }
     obj = object_new_with_type(klass->type);
@@ -900,36 +900,36 @@ bool object_set_propv(Object *obj,
 }
 
 
-Object *object_dynamic_cast(Object *obj, const char *typename)
+Object *object_dynamic_cast(Object *obj, const char *type_name)
 {
-    if (obj && object_class_dynamic_cast(object_get_class(obj), typename)) {
+    if (obj && object_class_dynamic_cast(object_get_class(obj), type_name)) {
         return obj;
     }
 
     return NULL;
 }
 
-Object *object_dynamic_cast_assert(Object *obj, const char *typename,
+Object *object_dynamic_cast_assert(Object *obj, const char *type_name,
                                    const char *file, int line, const char *func)
 {
     trace_object_dynamic_cast_assert(obj ? obj->klass->type->name : "(null)",
-                                     typename, file, line, func);
+                                     type_name, file, line, func);
 
 #ifdef CONFIG_QOM_CAST_DEBUG
     int i;
     Object *inst;
 
     for (i = 0; obj && i < OBJECT_CLASS_CAST_CACHE; i++) {
-        if (qatomic_read(&obj->klass->object_cast_cache[i]) == typename) {
+        if (qatomic_read(&obj->klass->object_cast_cache[i]) == type_name) {
             goto out;
         }
     }
 
-    inst = object_dynamic_cast(obj, typename);
+    inst = object_dynamic_cast(obj, type_name);
 
     if (!inst && obj) {
         fprintf(stderr, "%s:%d:%s: Object %p is not an instance of type %s\n",
-                file, line, func, obj, typename);
+                file, line, func, obj, type_name);
         abort();
     }
 
@@ -940,7 +940,7 @@ Object *object_dynamic_cast_assert(Object *obj, const char *typename,
             qatomic_set(&obj->klass->object_cast_cache[i - 1],
                        qatomic_read(&obj->klass->object_cast_cache[i]));
         }
-        qatomic_set(&obj->klass->object_cast_cache[i - 1], typename);
+        qatomic_set(&obj->klass->object_cast_cache[i - 1], type_name);
     }
 
 out:
@@ -949,7 +949,7 @@ out:
 }
 
 ObjectClass *object_class_dynamic_cast(ObjectClass *class,
-                                       const char *typename)
+                                       const char *type_name)
 {
     ObjectClass *ret = NULL;
     TypeImpl *target_type;
@@ -961,11 +961,11 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
 
     /* A simple fast path that can trigger a lot for leaf classes.  */
     type = class->type;
-    if (type->name == typename) {
+    if (type->name == type_name) {
         return class;
     }
 
-    target_type = type_get_by_name(typename);
+    target_type = type_get_by_name(type_name);
     if (!target_type) {
         /* target class type unknown, so fail the cast */
         return NULL;
@@ -997,20 +997,20 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
 }
 
 ObjectClass *object_class_dynamic_cast_assert(ObjectClass *klass,
-                                              const char *typename,
+                                              const char *type_name,
                                               const char *file, int line,
                                               const char *func)
 {
     ObjectClass *ret;
 
     trace_object_class_dynamic_cast_assert(klass ? klass->type->name : "(null)",
-                                           typename, file, line, func);
+                                           type_name, file, line, func);
 
 #ifdef CONFIG_QOM_CAST_DEBUG
     int i;
 
     for (i = 0; klass && i < OBJECT_CLASS_CAST_CACHE; i++) {
-        if (qatomic_read(&klass->class_cast_cache[i]) == typename) {
+        if (qatomic_read(&klass->class_cast_cache[i]) == type_name) {
             ret = klass;
             goto out;
         }
@@ -1021,10 +1021,10 @@ ObjectClass *object_class_dynamic_cast_assert(ObjectClass *klass,
     }
 #endif
 
-    ret = object_class_dynamic_cast(klass, typename);
+    ret = object_class_dynamic_cast(klass, type_name);
     if (!ret && klass) {
         fprintf(stderr, "%s:%d:%s: Object %p is not an instance of type %s\n",
-                file, line, func, klass, typename);
+                file, line, func, klass, type_name);
         abort();
     }
 
@@ -1034,7 +1034,7 @@ ObjectClass *object_class_dynamic_cast_assert(ObjectClass *klass,
             qatomic_set(&klass->class_cast_cache[i - 1],
                        qatomic_read(&klass->class_cast_cache[i]));
         }
-        qatomic_set(&klass->class_cast_cache[i - 1], typename);
+        qatomic_set(&klass->class_cast_cache[i - 1], type_name);
     }
 out:
 #endif
@@ -1061,9 +1061,9 @@ const char *object_class_get_name(ObjectClass *klass)
     return klass->type->name;
 }
 
-ObjectClass *object_class_by_name(const char *typename)
+ObjectClass *object_class_by_name(const char *type_name)
 {
-    TypeImpl *type = type_get_by_name(typename);
+    TypeImpl *type = type_get_by_name(type_name);
 
     if (!type) {
         return NULL;
@@ -1074,17 +1074,17 @@ ObjectClass *object_class_by_name(const char *typename)
     return type->klass;
 }
 
-ObjectClass *module_object_class_by_name(const char *typename)
+ObjectClass *module_object_class_by_name(const char *type_name)
 {
     ObjectClass *oc;
 
-    oc = object_class_by_name(typename);
+    oc = object_class_by_name(type_name);
 #ifdef CONFIG_MODULES
     if (!oc) {
         Error *local_err = NULL;
-        int rv = module_load_qom(typename, &local_err);
+        int rv = module_load_qom(type_name, &local_err);
         if (rv > 0) {
-            oc = object_class_by_name(typename);
+            oc = object_class_by_name(type_name);
         } else if (rv < 0) {
             error_report_err(local_err);
         }
@@ -1673,7 +1673,7 @@ typedef struct EnumProperty {
 } EnumProperty;
 
 int object_property_get_enum(Object *obj, const char *name,
-                             const char *typename, Error **errp)
+                             const char *type_name, Error **errp)
 {
     char *str;
     int ret;
@@ -1684,10 +1684,10 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    if (!g_str_equal(prop->type, typename)) {
+    if (!g_str_equal(prop->type, type_name)) {
         error_setg(errp, "Property %s on %s is not '%s' enum type",
                    name, object_class_get_name(
-                       object_get_class(obj)), typename);
+                       object_get_class(obj)), type_name);
         return -1;
     }
 
@@ -2127,16 +2127,16 @@ Object *object_resolve_path_component(Object *parent, const char *part)
 
 static Object *object_resolve_abs_path(Object *parent,
                                           char **parts,
-                                          const char *typename)
+                                          const char *type_name)
 {
     Object *child;
 
     if (*parts == NULL) {
-        return object_dynamic_cast(parent, typename);
+        return object_dynamic_cast(parent, type_name);
     }
 
     if (strcmp(*parts, "") == 0) {
-        return object_resolve_abs_path(parent, parts + 1, typename);
+        return object_resolve_abs_path(parent, parts + 1, type_name);
     }
 
     child = object_resolve_path_component(parent, *parts);
@@ -2144,19 +2144,19 @@ static Object *object_resolve_abs_path(Object *parent,
         return NULL;
     }
 
-    return object_resolve_abs_path(child, parts + 1, typename);
+    return object_resolve_abs_path(child, parts + 1, type_name);
 }
 
 static Object *object_resolve_partial_path(Object *parent,
                                            char **parts,
-                                           const char *typename,
+                                           const char *type_name,
                                            bool *ambiguous)
 {
     Object *obj;
     GHashTableIter iter;
     ObjectProperty *prop;
 
-    obj = object_resolve_abs_path(parent, parts, typename);
+    obj = object_resolve_abs_path(parent, parts, type_name);
 
     g_hash_table_iter_init(&iter, parent->properties);
     while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&prop)) {
@@ -2167,7 +2167,7 @@ static Object *object_resolve_partial_path(Object *parent,
         }
 
         found = object_resolve_partial_path(prop->opaque, parts,
-                                            typename, ambiguous);
+                                            type_name, ambiguous);
         if (found) {
             if (obj) {
                 *ambiguous = true;
@@ -2184,7 +2184,7 @@ static Object *object_resolve_partial_path(Object *parent,
     return obj;
 }
 
-Object *object_resolve_path_type(const char *path, const char *typename,
+Object *object_resolve_path_type(const char *path, const char *type_name,
                                  bool *ambiguousp)
 {
     Object *obj;
@@ -2196,12 +2196,12 @@ Object *object_resolve_path_type(const char *path, const char *typename,
     if (parts[0] == NULL || strcmp(parts[0], "") != 0) {
         bool ambiguous = false;
         obj = object_resolve_partial_path(object_get_root(), parts,
-                                          typename, &ambiguous);
+                                          type_name, &ambiguous);
         if (ambiguousp) {
             *ambiguousp = ambiguous;
         }
     } else {
-        obj = object_resolve_abs_path(object_get_root(), parts + 1, typename);
+        obj = object_resolve_abs_path(object_get_root(), parts + 1, type_name);
     }
 
     g_strfreev(parts);
@@ -2418,7 +2418,7 @@ static void property_set_enum(Object *obj, Visitor *v, const char *name,
 
 ObjectProperty *
 object_property_add_enum(Object *obj, const char *name,
-                         const char *typename,
+                         const char *type_name,
                          const QEnumLookup *lookup,
                          int (*get)(Object *, Error **),
                          void (*set)(Object *, int, Error **))
@@ -2429,7 +2429,7 @@ object_property_add_enum(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, typename,
+    return object_property_add(obj, name, type_name,
                                get ? property_get_enum : NULL,
                                set ? property_set_enum : NULL,
                                property_release_data,
@@ -2438,7 +2438,7 @@ object_property_add_enum(Object *obj, const char *name,
 
 ObjectProperty *
 object_class_property_add_enum(ObjectClass *klass, const char *name,
-                                    const char *typename,
+                                    const char *type_name,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **))
@@ -2449,7 +2449,7 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, typename,
+    return object_class_property_add(klass, name, type_name,
                                      get ? property_get_enum : NULL,
                                      set ? property_set_enum : NULL,
                                      NULL,
-- 
2.45.2.741.gdbec12cfda-goog


