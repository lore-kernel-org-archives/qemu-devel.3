Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBB8CE8E94
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 16:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4193-0003w8-5n; Thu, 24 Oct 2024 12:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418Y-0003tq-Vm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t418W-0002wO-A6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 12:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729788994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bMrWu6ahu03dVa1Nj/jzCJZxr91okbKkHKlA528y4A=;
 b=OrO0cHPqVM94vNtjuAEBHFavHoylBbxGmHKTXKX/jYMaa9yalX81sKAWdrCGDUNJiaaqDH
 SrKN1puoC++4z8g7+hCGCC+S1f4KJ+jXDsaO2KUQ0ag8y1eDJ+bSpS1eml2QxCTKBsNGyT
 LJtOHtz6QZb4+Oyjdq3wI+OyYdLvvr4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Oh-9LA8yPLqGwszaBFln7g-1; Thu, 24 Oct 2024 12:56:33 -0400
X-MC-Unique: Oh-9LA8yPLqGwszaBFln7g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ce30559894so13964146d6.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 09:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788992; x=1730393792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bMrWu6ahu03dVa1Nj/jzCJZxr91okbKkHKlA528y4A=;
 b=CjQtq+zv0ZhvGSwoE6auuBZdlxV9xPPRXPF5RenfGOEtAdzU7hNhnGBC3Xoy8utWFh
 rKWfjoHDNjWBsMKT2/zLjJBgdaKDaPr35o7q2INwNKcFo4VaYa/RUp4gjNgEVSWqKrse
 1qJPMoMWUfjr7yzCjotpDNz7k+jA2ZaWEDrvaF1//lDfQHqtlATU8o6sc5LXNY7uI0XL
 B178UYRa9WRBKgYTalWIr7pkU76M/VFS227XKeTQkglMq3VvPT3YQ64TDR94XbGJ6Fau
 0ioypfAYOMHzx6QVYawTCmEac3WLmzyNYL0Qi3jIFG9wIVUYhZkawLT6+AsITr5ZKQcX
 EWdQ==
X-Gm-Message-State: AOJu0YzZzxfeNgOoHDNOMfpF8LmXLcf0dz6MlsqObAxa7f8o/SuyT022
 ALnpVPxCkkWYJMT3oiOz2arUX+WBq8McurxdhPVqPLyJjFteLjYNmgHaUHwcP88aH14SQ7PLTEv
 NbkewcEIRG34RfzCrx3UB7SvTvLPVWvWWqBxhTHnYPtDIifJTwQvCn+vxhXeEle5E9+9oPSZ4Kx
 EA6aImcrO+2XOJ8pSxc4GImwbzyByeX6ri8Q==
X-Received: by 2002:a05:6214:3985:b0:6cb:e4d3:10a0 with SMTP id
 6a1803df08f44-6ce342f3d8emr75447226d6.48.1729788992005; 
 Thu, 24 Oct 2024 09:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf1VpAhGoD2rZyxmYQA3w3jyukDSTjdLMRt5w8yisKLcg8DBqkDDjYiV2dzwF3CNZ8AZ2Zfg==
X-Received: by 2002:a05:6214:3985:b0:6cb:e4d3:10a0 with SMTP id
 6a1803df08f44-6ce342f3d8emr75446786d6.48.1729788991457; 
 Thu, 24 Oct 2024 09:56:31 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008aff31sm51871076d6.12.2024.10.24.09.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 09:56:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/4] qom: TYPE_SINGLETON interface
Date: Thu, 24 Oct 2024 12:56:24 -0400
Message-ID: <20241024165627.1372621-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024165627.1372621-1-peterx@redhat.com>
References: <20241024165627.1372621-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qom/object_interfaces.h | 47 +++++++++++++++++++++++++++++++++
 qom/object.c                    |  3 +++
 qom/object_interfaces.c         | 24 +++++++++++++++++
 qom/qom-qmp-cmds.c              | 22 ++++++++++++---
 system/qdev-monitor.c           |  7 +++++
 5 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index 02b11a7ef0..9b2cc0e554 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -177,4 +177,51 @@ bool user_creatable_del(const char *id, Error **errp);
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
+ * @get_instance: fetch the singleton instance if it is created,
+ *                NULL otherwise.
+ *
+ * Singleton class describes the type of object classes that can only
+ * provide one instance for the whole lifecycle of QEMU.  It will fail the
+ * operation if one attemps to create more than one instance.
+ *
+ * One can fetch the single object using class's get_instance() callback if
+ * it was created before.  This can be useful for operations like QMP
+ * qom-list-properties, where dynamically creating an object might not be
+ * feasible.
+ */
+struct SingletonClass {
+    /* <private> */
+    InterfaceClass parent_class;
+    /* <public> */
+    Object *(*get_instance)(Error **errp);
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
+ * Returns: the object* if the class is a singleton class and the singleton
+ *          object is created, NULL otherwise.
+ */
+Object *singleton_get_instance(ObjectClass *class);
+
 #endif
diff --git a/qom/object.c b/qom/object.c
index 11424cf471..ded299ae1a 100644
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
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0833c8bfe..6766060d0a 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -354,6 +354,23 @@ void user_creatable_cleanup(void)
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
+    return singleton->get_instance(&error_abort);
+}
+
 static void register_types(void)
 {
     static const TypeInfo uc_interface_info = {
@@ -362,7 +379,14 @@ static void register_types(void)
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
index e91a235347..ecc1cf781c 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -126,6 +126,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
     ObjectPropertyInfoList *prop_list = NULL;
+    bool create;
 
     klass = module_object_class_by_name(typename);
     if (klass == NULL) {
@@ -141,7 +142,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
         return NULL;
     }
 
-    obj = object_new(typename);
+    /* Avoid creating multiple instances if the class is a singleton */
+    create = !object_class_is_singleton(klass) ||
+        !singleton_get_instance(klass);
+
+    if (create) {
+        obj = object_new(typename);
+    } else {
+        obj = singleton_get_instance(klass);
+    }
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
@@ -172,7 +181,9 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
         QAPI_LIST_PREPEND(prop_list, info);
     }
 
-    object_unref(obj);
+    if (create) {
+        object_unref(obj);
+    }
 
     return prop_list;
 }
@@ -199,7 +210,12 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         return NULL;
     }
 
-    if (object_class_is_abstract(klass)) {
+    /*
+     * Abstract classes are not for instantiations, meanwhile avoid
+     * creating temporary singleton objects because it can cause conflicts
+     * if there's already one created.
+     */
+    if (object_class_is_abstract(klass) || object_class_is_singleton(klass)) {
         object_class_property_iter_init(&iter, klass);
     } else {
         obj = object_new(typename);
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e1..1310f35c9f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -36,6 +36,7 @@
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
 #include "qemu/option_int.h"
+#include "qom/object_interfaces.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
 #include "qemu/cutils.h"
@@ -643,6 +644,12 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
+    if (singleton_get_instance(OBJECT_CLASS(dc))) {
+        error_setg(errp, "Class '%s' only supports one instance",
+                   driver);
+        return NULL;
+    }
+
     /* find bus */
     path = qdict_get_try_str(opts, "bus");
     if (path != NULL) {
-- 
2.45.0


