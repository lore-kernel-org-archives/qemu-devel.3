Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33A2D74941
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 21:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tZq-0002Oz-Cr; Tue, 29 Oct 2024 17:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZh-0002MK-NE
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5tZf-0007ci-I6
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 17:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730236582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+pcnIucz22VKrCtERmTjcQct9vNMkt9sbGgjhKvJik=;
 b=HTYb6cVbK9BHYLsfj5FS7M4UvXV5G7Qlnf80tRu+91lLRLKnNKZi19gW8+pFByZi5rrA3w
 ZxfWOR7Enkz7PPxkXN0wJfP4aUW3M36O4fgMEvylpCeRbBKtDlWMjn2/9uJW8NPS4OKjGe
 yuY+14UYYlpGomfeG2wEzHx9fMm6SnA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-4Yp79fQPO0qDDGreN1-6Ng-1; Tue, 29 Oct 2024 17:16:18 -0400
X-MC-Unique: 4Yp79fQPO0qDDGreN1-6Ng-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e30c637c956so1591825276.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 14:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730236577; x=1730841377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+pcnIucz22VKrCtERmTjcQct9vNMkt9sbGgjhKvJik=;
 b=Q+XbowoG7Iw61uFBOQy09PbcRpvGLPoJtOyTzw1radtSirjSz1RdZniWN0CHtoYWQC
 jvX9zZc+4vRSYfjb7ZGOmQclILmjjs5dzly/nDs3sP+SeKuPLGTUKfkhkP93+t0bCboC
 YTI7QUF0Q4CeAcj7m8OCc97erPjoQte6PwOp6zNQFXo5z0q4vHd+P0C6E3R+g2NH7TiV
 MQRQYtx5CBAbO+C89QmgbE+HyP/71Oe/SZQcqXI8O5qUghozqdjl8ypEI/t+euuqgBG3
 eHgh66+NOhW+fOQhTMemSkluy5l50BqdnDJejDWjHCtcfHENibEtQvnKH/ds8EHeHkgQ
 HFrQ==
X-Gm-Message-State: AOJu0YwzKddKSUTs5c/W/FqKeXCXaYQ9jcSCpi2nHUlDlLLCLDRwCX4h
 XCLkQczLqewJAgykzqr0mft0/8wtZF70lQK/wpIi9bmehpz6r3k9kSKa2aCpfXZmnMSoZmauPK6
 pYmsvrC5GgmLcBL95GW5DOjwuCVLI5IHG91rWo1LLgPYj5YK2Gr7w6cDFMOcoRIxmrtwxS6updF
 xEmhyCS7A5uSWn4ykbq0XahmVcHea3fECJ7Q==
X-Received: by 2002:a05:6902:188c:b0:e29:48ae:562 with SMTP id
 3f1490d57ef6-e3087a5b026mr14497847276.21.1730236576565; 
 Tue, 29 Oct 2024 14:16:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUFZ1rqENjX+R5z32YsreDF/F/tZw+JxeIpCIjETWIeEC+0TK2+FnyW/8tRZTXqkVxXCD7NQ==
X-Received: by 2002:a05:6902:188c:b0:e29:48ae:562 with SMTP id
 3f1490d57ef6-e3087a5b026mr14497742276.21.1730236574862; 
 Tue, 29 Oct 2024 14:16:14 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132292c97sm48481691cf.49.2024.10.29.14.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 14:16:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC v2 2/7] qom: TYPE_SINGLETON interface
Date: Tue, 29 Oct 2024 17:16:02 -0400
Message-ID: <20241029211607.2114845-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241029211607.2114845-1-peterx@redhat.com>
References: <20241029211607.2114845-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch introduces a new QOM interface called SINGLETON.

The singleton interface declares an object class which can only create one
instance globally.

Backgrounds / Use Cases
=======================

There can be some existing classes that can start to benefit from it.  One
example is vIOMMU implementations.

QEMU emulated vIOMMUs are normally implemented on top of a generic device,
however it's special enough to normally only allow one instance of it for
the whole system, attached to the root complex.

These vIOMMU classes can be singletons in this case, so that QEMU can fail
or detect yet another attempt of creating such devices for more than once,
which can be fatal errors to a system.

We used to have some special code guarding it from happening.  In x86,
pc_machine_device_pre_plug_cb() has code to detect when vIOMMU is created
more than once, for instance.  With singleton class, logically we could
consider dropping the special code, but start to rely on QOM to make sure
there's only one vIOMMU for the whole system emulation.

There is a similar demand raising recently (even if the problem existed
over years) in migration.

Firstly, the migration object can currently be created randomly, even
though not wanted, e.g. during qom-list-properties QMP commands.  Ideally,
there can be cases where we want to have an object walking over the
properties, we could use the existing migration object instead of
dynamically create one.

Meanwhile, migration has a long standing issue on current_migration
pointer, where it can point to freed data after the migration object is
finalized.  It is debatable that the pointer can be cleared after the main
thread (1) join() the migration thread first, then (2) release the last
refcount for the migration object and clear the pointer.  However there's
still major challenges [1].  With singleton, we could have a slightly but
hopefully working workaround to clear the pointer during finalize().

Design
======

The idea behind is pretty simple: any object that can only be created once
can now declare the TYPE_SINGLETON interface. Then, QOM facilities will
make sure it won't be created more than once for the whole QEMU lifecycle.
Whenever possible (e.g., on object_new_allowed() checks), pretty error
message will be generated to report an error.  QOM also guards at the core
of object_new() so that any further violation of trying to create a
singleton more than once will crash QEMU as a programming error.

For example, qom-list-properties, device-list-properties, etc., will be
smart enough to not try to create temporary singleton objects if the class
is a singleton class and if there's existing instance created.  Such usages
should be rare, and this patch introduced object_new_or_fetch() just for
it, which either create a new temp object when available, or fetch the
instance if we found an existing singleton instance.  There're only two
such use cases.

Meanwhile, we also guard device-add or similar paths using the singleton
check in object_new_allowed(), so that it'll fail properly if a singleton
class instantiate more than one object.

Glib Singleton implementation
=============================

One note here to mention the Glib implementation of singletons [1].

QEMU chose not to follow Glib's implementation because Glib's version is
not thread safe on the constructor, so that two concurrent g_object_new()
on a single can race.  It's not ideal to QEMU, as QEMU has to not only
support the event-driven context which is normally lock-free, but also
the case where threads are heavily used.

It could be QEMU's desire to properly support multi-threading by default on
such new interface.  The "bad" side effect of that is, QEMU's object_new()
on singletons can assert failures if the singleton existed, but that's also
part of the design so as to forbid such from happening, taking which as a
programming error.  Meanwhile since we have pretty ways to fail elsewhere
on qdev creations, it should already guard us in a clean way, from anywhere
that the user could try to create the singleton more than once.

The current QEMU impl also guarantees object_new() always return a newly
allocated object as long as properly returned, rather than silently return
an existing object as what Glib's impl would do.  I see it a benefit, so as
to avoid unknown caller manipulate a global object, wrongly assuming it was
temporarily created.

[1] https://lore.kernel.org/qemu-devel/20190228122822.GD4970@work-vm/
[2] https://lore.kernel.org/r/ZxtqGQbd4Hq4APtm@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/qdev.json                  |  2 +-
 qapi/qom.json                   |  2 +-
 include/qom/object.h            | 12 ++++++++
 include/qom/object_interfaces.h | 51 +++++++++++++++++++++++++++++++++
 qom/object.c                    | 33 +++++++++++++++++++++
 qom/object_interfaces.c         | 30 +++++++++++++++++++
 qom/qom-qmp-cmds.c              |  4 +--
 7 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 53d147c7b4..f9ca1aa1df 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -22,7 +22,7 @@
 #
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
-#    properties are not included in the output of this command.
+#    properties may or may not be included in the output of this command.
 #
 # Since: 1.2
 ##
diff --git a/qapi/qom.json b/qapi/qom.json
index 321ccd708a..00345b0715 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -197,7 +197,7 @@
 #
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
-#    properties are not included in the output of this command.
+#    properties may or may not be included in the output of this command.
 #
 # Returns: a list of ObjectPropertyInfo describing object properties
 #
diff --git a/include/qom/object.h b/include/qom/object.h
index 32f1af2986..e0d4173dfd 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -640,6 +640,18 @@ Object *object_new(const char *typename);
  */
 bool object_new_allowed(ObjectClass *klass, Error **errp);
 
+/**
+ * object_new_or_fetch:
+ * @klass: The class to instantiate, or fetch instance from.
+ *
+ * This function will either initialize a new object using heap allocated
+ * memory, or fetch one object if the object is a singleton and the only
+ * instance has already been created.
+ *
+ * Returns: The fetched object (either newly initiated or existing).
+ */
+Object *object_new_or_fetch(ObjectClass *klass);
+
 /**
  * object_new_with_props:
  * @typename:  The name of the type of the object to instantiate.
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index 02b11a7ef0..48b77cf6c4 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -177,4 +177,55 @@ bool user_creatable_del(const char *id, Error **errp);
  */
 void user_creatable_cleanup(void);
 
+#define TYPE_SINGLETON "singleton"
+
+typedef struct SingletonClass SingletonClass;
+DECLARE_CLASS_CHECKERS(SingletonClass, SINGLETON, TYPE_SINGLETON)
+
+/**
+ * SingletonClass:
+ *
+ * @parent_class: the base class
+ * @get_instance: fetch the singleton instance and elevate its refcount if
+ *                it is created, NULL otherwise.
+ *
+ * Singleton class describes the type of object classes that can only
+ * provide one instance for the whole lifecycle of QEMU.  It will fail the
+ * operation if one attemps to create more than one instance.
+ *
+ * One can fetch the single object using class's get_instance() callback if
+ * it was created before.  This can be useful for operations like QMP
+ * qom-list-properties, where dynamically creating an object might not be
+ * feasible.
+ *
+ * Classes with TYPE_SINGLETON must provide get_instance() implementation,
+ * make sure the refcount is elevanted before returning, so that the
+ * instance (if existed) can never be freed concurrently once returned.
+ */
+struct SingletonClass {
+    /* <private> */
+    InterfaceClass parent_class;
+    /* <public> */
+    Object *(*get_instance)(void);
+};
+
+/**
+ * object_class_is_singleton:
+ *
+ * @class: the class to detect singleton
+ *
+ * Returns: true if it's a singleton class, false otherwise.
+ */
+bool object_class_is_singleton(ObjectClass *class);
+
+/**
+ * singleton_get_instance:
+ *
+ * @class: the class to fetch singleton instance
+ *
+ * Returns: the Object with elevated refcount if the class is a singleton
+ *          class and the singleton object is created, NULL otherwise.
+ */
+Object *singleton_get_instance(ObjectClass *class);
+
 #endif
diff --git a/qom/object.c b/qom/object.c
index 4f3739fd85..c7c6f3e397 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -553,6 +553,9 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
     g_assert(type->abstract == false);
     g_assert(size >= type->instance_size);
 
+    /* Singleton class can only create one object */
+    g_assert(!singleton_get_instance(type->class));
+
     memset(obj, 0, type->instance_size);
     obj->class = type->class;
     object_ref(obj);
@@ -808,9 +811,39 @@ bool object_new_allowed(ObjectClass *klass, Error **errp)
         return false;
     }
 
+    if (object_class_is_singleton(klass)) {
+        Object *obj = singleton_get_instance(klass);
+
+        if (obj) {
+            object_unref(obj);
+            /*
+             * TODO: Enhance the error message.  E.g., the singleton class
+             * can provide a per-class error message in SingletonClass.
+             */
+            error_setg(errp, "Object type '%s' conflicts with "
+                       "an existing singleton instance",
+                       klass->type->name);
+            return false;
+        }
+    }
+
     return true;
 }
 
+Object *object_new_or_fetch(ObjectClass *klass)
+{
+    Object *obj;
+
+    if (object_class_is_singleton(klass)) {
+        obj = singleton_get_instance(klass);
+        if (obj) {
+            return obj;
+        }
+    }
+
+    return object_new_with_class(klass);
+}
+
 Object *object_new_with_props(const char *typename,
                               Object *parent,
                               const char *id,
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index d68faf2234..548e1f344f 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -353,6 +353,29 @@ void user_creatable_cleanup(void)
     object_unparent(object_get_objects_root());
 }
 
+bool object_class_is_singleton(ObjectClass *class)
+{
+    return !!object_class_dynamic_cast(class, TYPE_SINGLETON);
+}
+
+Object *singleton_get_instance(ObjectClass *class)
+{
+    SingletonClass *singleton =
+        (SingletonClass *)object_class_dynamic_cast(class, TYPE_SINGLETON);
+
+    if (!singleton) {
+        return NULL;
+    }
+
+    /*
+     * NOTE: it's only safe to do object_ref() in the ->get_instance()
+     * callback, because logically speaking any object* returned here might
+     * get free()ed concurrently if without the elevated refcount.  The
+     * hooks need to provide proper locking if a race condition is possible.
+     */
+    return singleton->get_instance();
+}
+
 static void register_types(void)
 {
     static const TypeInfo uc_interface_info = {
@@ -361,7 +384,14 @@ static void register_types(void)
         .class_size = sizeof(UserCreatableClass),
     };
 
+    static const TypeInfo singleton_interface_info = {
+        .name          = TYPE_SINGLETON,
+        .parent        = TYPE_INTERFACE,
+        .class_size = sizeof(SingletonClass),
+    };
+
     type_register_static(&uc_interface_info);
+    type_register_static(&singleton_interface_info);
 }
 
 type_init(register_types)
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e91a235347..3aa51c4c95 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -141,7 +141,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
         return NULL;
     }
 
-    obj = object_new(typename);
+    obj = object_new_or_fetch(klass);
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
@@ -202,7 +202,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
     if (object_class_is_abstract(klass)) {
         object_class_property_iter_init(&iter, klass);
     } else {
-        obj = object_new(typename);
+        obj = object_new_or_fetch(klass);
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
-- 
2.45.0


