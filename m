Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4E1C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 20:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP6nl-0006Qm-2x; Wed, 03 Jul 2024 16:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sP6ni-0006P8-Ik
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:42:02 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sP6ng-00048l-3o
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 16:42:02 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c965efab0fso1537531a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720039318; x=1720644118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNpLqYZ5qurXpabox+wqpqHB0gpWXD1FHZMvih8SyMs=;
 b=Vcx0VbMqKD1FtWTqDvoPEU+/3qLgmjvWYM+In0AtLqSlKiH3WUaGcF8cucuGY2tipL
 mUw/0BPlXeDWdlx0TtG7Vexu8+kSEuWsZY4z8iKYfd6SY845BW+ndxjiTi9pyCL8Zkx2
 +zPckS5AFdwId9H8uSazL/ebCaOF+uehxNTihcZEChe02yjRahAJjPkC0sRzI53Kadvv
 DHlMt2Vr6cy058/AskFQifT+v0Mf3xMvPG+gHSw5aY7pU0U45603oDslVMWpoDCTvk99
 yao3ouFAYziAQB4OWqfkBDzNIrFR7F/cvRteb04VmVW833GZuuxLz8niXB2tcFpr8bns
 Wexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720039318; x=1720644118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNpLqYZ5qurXpabox+wqpqHB0gpWXD1FHZMvih8SyMs=;
 b=DB5LTAr2P4I8uXk1s/wkEhDMUciDN7wFUboXP0oBTgJSCcPAUEaTaoNH32L/8osKZb
 ROJWlm9BDzWvuhJUl9v2DJbHV2n2Dn4fNS1PD05esVkhpUTLkdtwLRh12hdYNraIxK9Z
 42YDJ3dOxlHechoh92gqU6lW3M51LaTi7qOWtqjKcn9D/30Rym91zY65R2StYotW/TAV
 WdWlw7BdcUJWRqiVEpXPvN2QCOERHhRC2Db4auIEVzPo6KncfI7WN8dbXLjvEuoVfoMM
 5x7kBl67Tyqswsz/xe4TpV+XUw8M69oer6rTV4B9M39/os2wQNQGBii44FazSKqnb25n
 V8XA==
X-Gm-Message-State: AOJu0YxpCn8Yq+yQ/jGoLzrF+egyh8Vv5vJcDBkYa6c82SBqtQPRV03g
 Oa+prTpxRw672SP2BONO2MpzJjoDIo9CIScm080pQwt3BIhc0Ys4YDDbJeuYuCQpWieE/y6fit4
 R
X-Google-Smtp-Source: AGHT+IF5erOBbUMXRMVoVn7hZ2cb3Fvj3Jr5PrZcgHUGrhUbgjHKDdq3uu/kE2SssYTM6N/zdeSNnw==
X-Received: by 2002:a17:90a:840f:b0:2c4:ab32:b71c with SMTP id
 98e67ed59e1d1-2c93d6ed555mr8337500a91.8.1720039318309; 
 Wed, 03 Jul 2024 13:41:58 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce42667sm11284888a91.16.2024.07.03.13.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 13:41:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com,
 eduardo@habkost.net, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/2] qom/object, qdev: move globals functions to object.c
Date: Wed,  3 Jul 2024 17:41:48 -0300
Message-ID: <20240703204149.1957136-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Next patch will add Accel globals support. This means that globals won't be
qdev exclusive logic since it'll have to deal with TYPE_ACCEL objects.

Move all globals related functions and declarations to object.c. Each
function is renamed from 'qdev_' to 'object_':

- qdev_prop_register_global() is now object_prop_register_global()
- qdev_find_global_prop() is now object_find_global_prop()
- qdev_prop_check_globals() is now object_prop_check_globals()
- qdev_prop_set_globals() is now object_prop_set_globals()

For object_prop_set_globals() an additional change was made: the function
was hardwired to be used with DeviceState, where dev->hotplugged is checked
to determine if object_apply_global_props() will receive a NULL or an
&error_fatal errp. The function now receives an Object and an errp, and
logic using dev->hotplugged is moved to its caller (device_post_init()).

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/core/cpu-common.c                |  2 +-
 hw/core/qdev-properties-system.c    |  2 +-
 hw/core/qdev-properties.c           | 71 -----------------------------
 hw/core/qdev.c                      |  2 +-
 include/hw/qdev-core.h              | 27 -----------
 include/hw/qdev-properties.h        |  5 --
 include/qom/object.h                | 34 ++++++++++++++
 qom/object.c                        | 70 ++++++++++++++++++++++++++++
 system/vl.c                         |  6 +--
 target/i386/cpu.c                   |  2 +-
 target/sparc/cpu.c                  |  2 +-
 tests/unit/test-qdev-global-props.c |  4 +-
 12 files changed, 114 insertions(+), 113 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index f131cde2c0..794b18f7c5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -182,7 +182,7 @@ static void cpu_common_parse_features(const char *typename, char *features,
             prop->driver = typename;
             prop->property = g_strdup(featurestr);
             prop->value = g_strdup(val);
-            qdev_prop_register_global(prop);
+            object_prop_register_global(prop);
         } else {
             error_setg(errp, "Expected key=value format, found %s.",
                        featurestr);
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index f13350b4fb..5d30ee6257 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -41,7 +41,7 @@ static bool check_prop_still_unset(Object *obj, const char *name,
                                    const void *old_val, const char *new_val,
                                    bool allow_override, Error **errp)
 {
-    const GlobalProperty *prop = qdev_find_global_prop(obj, name);
+    const GlobalProperty *prop = object_find_global_prop(obj, name);
 
     if (!old_val || (!prop && allow_override)) {
         return true;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 86a583574d..9cba33c311 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -855,77 +855,6 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
     qobject_unref(values);
 }
 
-static GPtrArray *global_props(void)
-{
-    static GPtrArray *gp;
-
-    if (!gp) {
-        gp = g_ptr_array_new();
-    }
-
-    return gp;
-}
-
-void qdev_prop_register_global(GlobalProperty *prop)
-{
-    g_ptr_array_add(global_props(), prop);
-}
-
-const GlobalProperty *qdev_find_global_prop(Object *obj,
-                                            const char *name)
-{
-    GPtrArray *props = global_props();
-    const GlobalProperty *p;
-    int i;
-
-    for (i = 0; i < props->len; i++) {
-        p = g_ptr_array_index(props, i);
-        if (object_dynamic_cast(obj, p->driver)
-            && !strcmp(p->property, name)) {
-            return p;
-        }
-    }
-    return NULL;
-}
-
-int qdev_prop_check_globals(void)
-{
-    int i, ret = 0;
-
-    for (i = 0; i < global_props()->len; i++) {
-        GlobalProperty *prop;
-        ObjectClass *oc;
-        DeviceClass *dc;
-
-        prop = g_ptr_array_index(global_props(), i);
-        if (prop->used) {
-            continue;
-        }
-        oc = object_class_by_name(prop->driver);
-        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
-        if (!oc) {
-            warn_report("global %s.%s has invalid class name",
-                        prop->driver, prop->property);
-            ret = 1;
-            continue;
-        }
-        dc = DEVICE_CLASS(oc);
-        if (!dc->hotpluggable && !prop->used) {
-            warn_report("global %s.%s=%s not used",
-                        prop->driver, prop->property, prop->value);
-            ret = 1;
-            continue;
-        }
-    }
-    return ret;
-}
-
-void qdev_prop_set_globals(DeviceState *dev)
-{
-    object_apply_global_props(OBJECT(dev), global_props(),
-                              dev->hotplugged ? NULL : &error_fatal);
-}
-
 /* --- 64bit unsigned int 'size' type --- */
 
 static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f3a996f57d..894372b776 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -673,7 +673,7 @@ static void device_post_init(Object *obj)
      * precedence.
      */
     object_apply_compat_props(obj);
-    qdev_prop_set_globals(DEVICE(obj));
+    object_prop_set_globals(obj, DEVICE(obj)->hotplugged ? NULL : &error_fatal);
 }
 
 /* Unlink device from bus and free the structure.  */
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5336728a23..656eb220f2 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -397,33 +397,6 @@ struct BusState {
     ResettableState reset;
 };
 
-/**
- * typedef GlobalProperty - a global property type
- *
- * @used: Set to true if property was used when initializing a device.
- * @optional: If set to true, GlobalProperty will be skipped without errors
- *            if the property doesn't exist.
- *
- * An error is fatal for non-hotplugged devices, when the global is applied.
- */
-typedef struct GlobalProperty {
-    const char *driver;
-    const char *property;
-    const char *value;
-    bool used;
-    bool optional;
-} GlobalProperty;
-
-static inline void
-compat_props_add(GPtrArray *arr,
-                 GlobalProperty props[], size_t nelem)
-{
-    int i;
-    for (i = 0; i < nelem; i++) {
-        g_ptr_array_add(arr, (void *)&props[i]);
-    }
-}
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 09aa04ca1e..301debfe79 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -206,11 +206,6 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
 
 void *object_field_prop_ptr(Object *obj, Property *prop);
 
-void qdev_prop_register_global(GlobalProperty *prop);
-const GlobalProperty *qdev_find_global_prop(Object *obj,
-                                            const char *name);
-int qdev_prop_check_globals(void);
-void qdev_prop_set_globals(DeviceState *dev);
 void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
                                     const char *name, const char *value);
 
diff --git a/include/qom/object.h b/include/qom/object.h
index 13d3a655dd..72ee237776 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -695,8 +695,42 @@ Object *object_new_with_propv(const char *typename,
                               Error **errp,
                               va_list vargs);
 
+/**
+ * typedef GlobalProperty - a global property type
+ *
+ * @used: Set to true if property was used when initializing an object
+ * @optional: If set to true, GlobalProperty will be skipped without errors
+ *            if the property doesn't exist.
+ *
+ * When used with devices: an error is fatal for non-hotplugged devices when
+ * the global is applied.
+ */
+typedef struct GlobalProperty {
+    const char *driver;
+    const char *property;
+    const char *value;
+    bool used;
+    bool optional;
+} GlobalProperty;
+
+static inline void
+compat_props_add(GPtrArray *arr,
+                 GlobalProperty props[], size_t nelem)
+{
+    int i;
+    for (i = 0; i < nelem; i++) {
+        g_ptr_array_add(arr, (void *)&props[i]);
+    }
+}
+
 bool object_apply_global_props(Object *obj, const GPtrArray *props,
                                Error **errp);
+void object_prop_set_globals(Object *obj, Error **errp);
+void object_prop_register_global(GlobalProperty *prop);
+int object_prop_check_globals(void);
+const GlobalProperty *object_find_global_prop(Object *obj,
+                                              const char *name);
+
 void object_set_machine_compat_props(GPtrArray *compat_props);
 void object_set_accelerator_compat_props(GPtrArray *compat_props);
 void object_register_sugar_prop(const char *driver, const char *prop,
diff --git a/qom/object.c b/qom/object.c
index 157a45c5f8..60dbd00edd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -472,6 +472,76 @@ bool object_apply_global_props(Object *obj, const GPtrArray *props,
     return true;
 }
 
+static GPtrArray *global_props(void)
+{
+    static GPtrArray *gp;
+
+    if (!gp) {
+        gp = g_ptr_array_new();
+    }
+
+    return gp;
+}
+
+void object_prop_register_global(GlobalProperty *prop)
+{
+    g_ptr_array_add(global_props(), prop);
+}
+
+void object_prop_set_globals(Object *obj, Error **errp)
+{
+    object_apply_global_props(obj, global_props(), errp);
+}
+
+const GlobalProperty *object_find_global_prop(Object *obj,
+                                              const char *name)
+{
+    GPtrArray *props = global_props();
+    const GlobalProperty *p;
+    int i;
+
+    for (i = 0; i < props->len; i++) {
+        p = g_ptr_array_index(props, i);
+        if (object_dynamic_cast(obj, p->driver)
+            && !strcmp(p->property, name)) {
+            return p;
+        }
+    }
+    return NULL;
+}
+
+int object_prop_check_globals(void)
+{
+    int i, ret = 0;
+
+    for (i = 0; i < global_props()->len; i++) {
+        GlobalProperty *prop;
+        ObjectClass *oc;
+        DeviceClass *dc;
+
+        prop = g_ptr_array_index(global_props(), i);
+        if (prop->used) {
+            continue;
+        }
+        oc = object_class_by_name(prop->driver);
+        oc = object_class_dynamic_cast(oc, TYPE_DEVICE);
+        if (!oc) {
+            warn_report("global %s.%s has invalid class name",
+                        prop->driver, prop->property);
+            ret = 1;
+            continue;
+        }
+        dc = DEVICE_CLASS(oc);
+        if (!dc->hotpluggable && !prop->used) {
+            warn_report("global %s.%s=%s not used",
+                        prop->driver, prop->property, prop->value);
+            ret = 1;
+            continue;
+        }
+    }
+    return ret;
+}
+
 /*
  * Global property defaults
  * Slot 0: accelerator's global property defaults
diff --git a/system/vl.c b/system/vl.c
index bdd2f6ecf6..282668b817 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2153,7 +2153,7 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
     g->driver   = qemu_opt_get(opts, "driver");
     g->property = qemu_opt_get(opts, "property");
     g->value    = qemu_opt_get(opts, "value");
-    qdev_prop_register_global(g);
+    object_prop_register_global(g);
     return 0;
 }
 
@@ -2679,7 +2679,7 @@ static bool qemu_machine_creation_done(Error **errp)
         net_check_clients();
     }
 
-    qdev_prop_check_globals();
+    object_prop_check_globals();
 
     qdev_machine_creation_done();
 
@@ -3705,7 +3705,7 @@ void qemu_init(int argc, char **argv)
      * Beware, QOM objects created before this point miss global and
      * compat properties.
      *
-     * Global properties get set up by qdev_prop_register_global(),
+     * Global properties get set up by object_prop_register_global(),
      * called from user_register_global_props(), and certain option
      * desugaring.  Also in CPU feature desugaring (buried in
      * parse_cpu_option()), which happens below this point, but may
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c2e6f3a71..b8838467a3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5789,7 +5789,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
         prop->driver = typename;
         prop->property = g_strdup(name);
         prop->value = g_strdup(val);
-        qdev_prop_register_global(prop);
+        object_prop_register_global(prop);
     }
 
     if (ambiguous) {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 9bacfb68cb..8dffa34701 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -114,7 +114,7 @@ cpu_add_feat_as_prop(const char *typename, const char *name, const char *val)
     prop->driver = typename;
     prop->property = g_strdup(name);
     prop->value = g_strdup(val);
-    qdev_prop_register_global(prop);
+    object_prop_register_global(prop);
 }
 
 /* Parse "+feature,-feature,feature=foo" CPU feature string */
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index c8862cac5f..00a6b887f3 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -96,7 +96,7 @@ static void register_global_properties(GlobalProperty *props)
     int i;
 
     for (i = 0; props[i].driver != NULL; i++) {
-        qdev_prop_register_global(props + i);
+        object_prop_register_global(props + i);
     }
 }
 
@@ -235,7 +235,7 @@ static void test_dynamic_globalprop_subprocess(void)
 
     g_assert_cmpuint(mt->prop1, ==, 101);
     g_assert_cmpuint(mt->prop2, ==, 102);
-    global_error = qdev_prop_check_globals();
+    global_error = object_prop_check_globals();
     g_assert_cmpuint(global_error, ==, 1);
     g_assert(props[0].used);
     g_assert(props[1].used);
-- 
2.45.2


