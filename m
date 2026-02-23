Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6917AEC1111
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKB-0001Dr-BA; Mon, 23 Feb 2026 12:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK9-0001BM-M3
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:21 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK6-0008U8-9u
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:21 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so57107095e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866136; x=1772470936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lfcmTJ7ZFiBmTNCLyk9Egoe7KSwSf53JXY1tR6tWykw=;
 b=n5metzxNLJK2AmRGhdaV1YhvYMl1BHgAxodcMb+8JHGnIfiPROwAFLAaJIOYC4Wrhh
 IdhaLaucYJgfOmI2NlkA2DrFiDAKZX/xpq9COaF23rcTxyNPfIoj0O2yz71iK9dcTIsM
 1pkGzbmbRBb+oOXsK+MVFzV/j/Xa7qBCj7pJvkXbxBnp+0PStBwsXu5HgIEoR2N5/prQ
 UAFHrNcSqw0//ewXArbnfWQklQsM81y9Gx97hO7XDE5Qa3GFCeLcAIE+G/Fvn1uLJstE
 WFCF4IToMEfxAxlYaXcbLvfnboxazCeAnM0EH1jIeh+g7Bbvj9J+5FMCTDA+aWoPXf0O
 xPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866136; x=1772470936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lfcmTJ7ZFiBmTNCLyk9Egoe7KSwSf53JXY1tR6tWykw=;
 b=npSiUMyEnlPzumkjquvfIP7Fc8BobxC0R17NOCluRA43YvibjMly6toc+PNdCWTgAm
 2gaSbHZGfnODBwR6rQwLdhqosqcGQ6VFowAi93jvyZJxjSpUPH9eRg99bu4OnUvU3E1+
 e3SZLG6IkMYYoc9PgQn2EVQmybIAcGQ8Lt9I1/lK1zDB9vyXcox6iRTlg9MqgtVAS0kE
 H2DBa1zVnGhnfdHXxrOMbPJNMa8JIracaxGPFelSTDwlf2FrtY2cfJXitKKF1Vv2HzY5
 tgg7vtLm2grMNcW5PrD8SedJ1pn8wvbs4OUp/IP4pSb7wNVgcEHYec/Yz2ZFIPQ+JVB3
 3dBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJr8k9sNEOJrGMnftgG6RtjD+6x5Jb+bKB99jXwDbjuki75yEO3RkgqUt8E0UB6WkZaYgjBBKn9FHO@nongnu.org
X-Gm-Message-State: AOJu0YxU+hfQw5+vuzAp0SSLgF+wJFTAMG8jnIfhcQ+ZB6fJQqFpyPIm
 shLb6HQ4qdCkEHqFQGTdlDSrSaGesw1tbHtbpDk8KHlrKQpungsXK6fAcd1v6kFU/Ms=
X-Gm-Gg: AZuq6aJWikLDzs+kdiCWpLKGIY/9i13ga1ELiecq94fsfw4GmSeywuz+WJP4LUcnADZ
 lth9urEQIckW1+JSGf+Z0g2i8PpaOpDf/vcMzgA8617Y2ZjdwwMwxYZ2hBU+hIIlHoQGjwqJ8zM
 no7IoQZaLJQjR06UimgtOnNrYfZf7J00oEfFhyVHK1dpxbRrivUV05OdGQ3tE1nHBGZ2F9zdsMt
 k7+W42FHRZFWrbg4DFmVahKm6oLtWznX4MQsPYq+FNNUmuCQyQx6ZmXfel0vNnq6GhkegNTLBWN
 mzgPvLFAEg7dW5G5ovuqwOcxEbsC6fm+8i5erHecO9WFIaNHvTGOhsxMX/VvsHZqst/tVpv+Gxm
 e4jsOnIWmP8xIkcwd2xLxXmzQxCYiW0NRNyz4p2YywaFAk577IF647F23xFlFsDwWfZvFGkHSBS
 FdDcBeG7IwnZ+nEM/kMXB+h5Oh/ObhQ0W+5dwgppU/ZR2esa6Go7tFfHyKbQAynkFmPMWRphlwf
 uy9VaJtDUz/jbOm8niQ5qHHDdLSI5c=
X-Received: by 2002:a05:600c:a11:b0:483:361b:deff with SMTP id
 5b1f17b1804b1-483a95c9e16mr164522645e9.14.1771866135388; 
 Mon, 23 Feb 2026 09:02:15 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/65] hw/core: Permit devices to define an array of link
 properties
Date: Mon, 23 Feb 2026 17:01:08 +0000
Message-ID: <20260223170212.441276-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Currently we allow devices to define "link properties" with
DEFINE_PROP_LINK(): these are a way to give a device a pointer to
another QOM object.  (Under the hood this is done by handing it the
canonical QOM path for the object.)

We also allow devices to define "array properties" with
DEFINE_PROP_ARRAY(): these are a way to give a device a
variable-length array of properties.

However, there is no way to define an array of link properties.  If
you try to do it by passing qdev_prop_link as the arrayprop argument
to DEFINE_PROP_ARRAY() you will get a crash because qdev_prop_link
does not provide the .set and .get methods in its PropertyInfo
struct.

This patch implements a new DEFINE_PROP_LINK_ARRAY(). In
a device you can use it like this:

struct MyDevice {
    ...
    uint32_t num_cpus;
    ARMCPU **cpus;
}

and in your Property array:
    DEFINE_PROP_LINK_ARRAY("cpus", MyDevice, num_cpus, cpus,
                           TYPE_ARM_CPU, ARMCPU *),

The array property code will fill in s->num_cpus, allocate memory in
s->cpus, and populate it with pointers.

On the device-creation side you set the property in the same way as
the existing array properties, using the new qlist_append_link()
function to append to the QList:

    QList *cpulist = qlist_new();
    for (int i = 0; i < cpus; i++) {
        qlist_append_link(cpulist, OBJECT(cpu[i]));
    }
    qdev_prop_set_array(mydev, "cpus", cpulist);

The implementation is mostly in the provision of the .set and
.get methods to the qdev_prop_link PropertyInfo struct. The
code of these methods parallels the code in
object_set_link_property() and object_get_link_property().  We can't
completely share the code with those functions because of differences
in where we get the information like the target QOM type, but I have
pulled out a new function object_resolve_and_typecheck() for the
shared "given a QOM path and a type, give me the object or an error"
code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I want this specifically for the GICv5 interrupt controller device
I'm working on.  I'd like to be able to pass in links to the CPUs
connected to the GIC, so that we don't have to have the code assume
that it's connected to CPU numbers 0,1,2... the way the current
GICv3 code does.

I think Phil also had a proposed series a while back that wanted
to do something similar with one of the existing devices.

I figured I'd post this early for review, though obviously it's a
little unmotivated until I have my new GICv5 code into enough shape
to submit. This is tested, but with my work-in-progress code.
---
 hw/core/qdev-properties.c         | 78 +++++++++++++++++++++++++++++++
 include/hw/core/qdev-properties.h | 40 ++++++++++++++++
 include/qom/object.h              | 19 ++++++++
 qom/object.c                      | 42 ++++++++++-------
 4 files changed, 161 insertions(+), 18 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ba8461e9a4..f8181b0d91 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -669,6 +669,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
          * being inside the device struct.
          */
         .offset = (uintptr_t)elem - (uintptr_t)obj,
+        .link_type = parent_prop->link_type,
     };
 }
 
@@ -950,6 +951,12 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
     qobject_unref(values);
 }
 
+void qlist_append_link(QList *qlist, Object *obj)
+{
+    g_autofree char *path = object_get_canonical_path(obj);
+    qlist_append_str(qlist, path);
+}
+
 static GPtrArray *global_props(void)
 {
     static GPtrArray *gp;
@@ -1059,9 +1066,80 @@ static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
                                           OBJ_PROP_LINK_STRONG);
 }
 
+/*
+ * The logic in these get_link() and set_link() functions is similar
+ * to that used for single-element link properties in the
+ * object_get_link_property() and object_set_link_property() functions.
+ * The difference is largely in how we get the expected type of the
+ * link: for us it is in the Property struct, and for a single link
+ * property it is part of the property name on the object.
+ */
+static void get_link(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    const Property *prop = opaque;
+    Object **targetp = object_field_prop_ptr(obj, prop);
+    g_autofree char *path = NULL;
+
+    if (*targetp) {
+        path = object_get_canonical_path(*targetp);
+        visit_type_str(v, name, &path, errp);
+    } else {
+        path = g_strdup("");
+        visit_type_str(v, name, &path, errp);
+    }
+}
+
+static void set_link(Object *obj, Visitor *v, const char *name, void *opaque,
+                     Error **errp)
+{
+    const Property *prop = opaque;
+    Object **targetp = object_field_prop_ptr(obj, prop);
+    g_autofree char *path = NULL;
+    Object *new_target, *old_target = *targetp;
+
+    ERRP_GUARD();
+
+    /* Get the path to the object we want to set the link to */
+    if (!visit_type_str(v, name, &path, errp)) {
+        return;
+    }
+
+    /* Now get the pointer to the actual object */
+    if (*path) {
+        new_target = object_resolve_and_typecheck(path, prop->name,
+                                                  prop->link_type, errp);
+        if (!new_target) {
+            return;
+        }
+    } else {
+        new_target = NULL;
+    }
+
+    /*
+     * Our link properties are always OBJ_PROP_LINK_STRONG and
+     * have the allow_set_link_before_realize check.
+     */
+    qdev_prop_allow_set_link_before_realize(obj, prop->name, new_target, errp);
+    if (*errp) {
+        return;
+    }
+
+    *targetp = new_target;
+    object_ref(new_target);
+    object_unref(old_target);
+}
+
 const PropertyInfo qdev_prop_link = {
     .type = "link",
     .create = create_link_property,
+    /*
+     * Since we have a create method, the get and set are used
+     * only in get_prop_array() and set_prop_array() for the case
+     * where we have an array of link properties.
+     */
+    .get = get_link,
+    .set = set_link,
 };
 
 void qdev_property_add_static(DeviceState *dev, const Property *prop)
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65..936d06023a 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -168,6 +168,31 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
                 .link_type  = _type)
 
+/**
+ * DEFINE_PROP_LINK_ARRAY:
+ * @_name: name of the array
+ * @_state: name of the device state structure type
+ * @_field: uint32_t field in @_state to hold the array length
+ * @_arrayfield: field in @_state (of type '@_arraytype *') which
+ *               will point to the array
+ * @_linktype: QOM type name of the link type
+ * @_arraytype: C type of the array elements
+ *
+ * Define device properties for a variable-length array _name of links
+ * (i.e. this is the array version of DEFINE_PROP_LINK).
+ * The array is represented as a list of QStrings in the visitor interface,
+ * where each string is the QOM path of the object to be linked.
+ */
+#define DEFINE_PROP_LINK_ARRAY(_name, _state, _field, _arrayfield,      \
+                               _linktype, _arraytype)                   \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+                .set_default = true,                                    \
+                .defval.u = 0,                                          \
+                .arrayinfo = &qdev_prop_link,                           \
+                .arrayfieldsize = sizeof(_arraytype),                   \
+                .arrayoffset = offsetof(_state, _arrayfield),           \
+                .link_type = _linktype)
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
@@ -219,6 +244,21 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* Takes ownership of @values */
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
 
+/**
+ * qlist_append_link: Add a QOM object to a QList of link properties
+ * @qlist: list to append to
+ * @obj: object to append
+ *
+ * This is a helper function for constructing a QList to pass to
+ * qdev_prop_set_array() when the qdev property array is an array of link
+ * properties (i.e. one defined with DEFINE_PROP_LINK_ARRAY).
+ *
+ * The object is encoded into the list as a QString which is the
+ * canonical path of the object; this is the same encoding that
+ * object_set_link_property() and object_get_link_property() use.
+ */
+void qlist_append_link(QList *qlist, Object *obj);
+
 void *object_field_prop_ptr(Object *obj, const Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..48fdbf353e 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1750,6 +1750,25 @@ ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags);
 
+
+/**
+ * object_resolve_and_typecheck:
+ * @path: path to look up
+ * @name: name of property we are resolving for (used only in error messages)
+ * @target_type: QOM type we expect @path to resolve to
+ * @errp: error
+ *
+ * Look up the object at @path and return it. If it does not have
+ * the correct type @target_type, return NULL and set @errp.
+ *
+ * This is similar to object_resolve_path_type(), but it insists on
+ * a non-ambiguous path and it produces error messages that are specialised
+ * to the use case of setting a link property on an object.
+ */
+Object *object_resolve_and_typecheck(const char *path,
+                                     const char *name,
+                                     const char *target_type, Error **errp);
+
 /**
  * object_property_add_str:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a32..90b8f3461e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1895,26 +1895,13 @@ static void object_get_link_property(Object *obj, Visitor *v,
     }
 }
 
-/*
- * object_resolve_link:
- *
- * Lookup an object and ensure its type matches the link property type.  This
- * is similar to object_resolve_path() except type verification against the
- * link property is performed.
- *
- * Returns: The matched object or NULL on path lookup failures.
- */
-static Object *object_resolve_link(Object *obj, const char *name,
-                                   const char *path, Error **errp)
+Object *object_resolve_and_typecheck(const char *path,
+                                     const char *name,
+                                     const char *target_type, Error **errp)
 {
-    const char *type;
-    char *target_type;
     bool ambiguous = false;
     Object *target;
 
-    /* Go from link<FOO> to FOO.  */
-    type = object_property_get_type(obj, name, NULL);
-    target_type = g_strndup(&type[5], strlen(type) - 6);
     target = object_resolve_path_type(path, target_type, &ambiguous);
 
     if (ambiguous) {
@@ -1931,11 +1918,30 @@ static Object *object_resolve_link(Object *obj, const char *name,
         }
         target = NULL;
     }
-    g_free(target_type);
-
     return target;
 }
 
+/*
+ * object_resolve_link:
+ *
+ * Lookup an object and ensure its type matches the link property type.  This
+ * is similar to object_resolve_path() except type verification against the
+ * link property is performed.
+ *
+ * Returns: The matched object or NULL on path lookup failures.
+ */
+static Object *object_resolve_link(Object *obj, const char *name,
+                                   const char *path, Error **errp)
+{
+    const char *type;
+    g_autofree char *target_type = NULL;
+
+    /* Go from link<FOO> to FOO.  */
+    type = object_property_get_type(obj, name, NULL);
+    target_type = g_strndup(&type[5], strlen(type) - 6);
+    return object_resolve_and_typecheck(path, name, target_type, errp);
+}
+
 static void object_set_link_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
-- 
2.43.0


