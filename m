Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C37C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 14:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXfa-0001M3-AI; Fri, 06 Jun 2025 10:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNXfX-0001L1-7V
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:03:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNXfR-0007hE-13
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:03:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso20503885e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749218610; x=1749823410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E4Dx7676jG+vk71RZAOcqaNYjWAoli2CcW2FAti80KI=;
 b=P5RI//wkgCeDAYop3APp7lTVL/zpRk1PX36UP6As+B2XRqb1RcrXlkL3afT0PQRjZU
 6qNnmiWQELIsln6XRJSrUFl09ie+k/vAjhzoOP1hy9FuPNVfJM0DIiGQxn8lUujVXZgM
 V5SJRnEuZwxX7FPp8hbTE41L+WRIHpTN5jHBFyqTcUzRu//zMlFB2PUWOWDHBSxvMRGA
 L6bQmlo4bbscUc64xVkC/qsPijLEPklZh6bInVptpXLbDh20glEhUmaz4rFzXwwqppmw
 rnQWgPBjhPHBqsh4PIv45AR0puBUPlV5i5YOS3GEukj47ayS58O5XJbzoEPE5NrJcG7C
 K8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749218610; x=1749823410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E4Dx7676jG+vk71RZAOcqaNYjWAoli2CcW2FAti80KI=;
 b=qmBKkd0E+F8ZZfW4RCdZAxSNC40N0RRDp4MP4aqkZ+Q6AgMNcjSxow4iC6zNgfV1No
 jnpDANUzJvS1V0Cn25sQj+6etLzdoQ/sob4GDTXdA3QY1khKhFDYzbFI9bDU0Ce8KVow
 hHCpm0VLNWWasnDlkI61NLTL29mBa8es1Uz1GeuCpnhji9W96IdOZrQAaV6xShrxtcXu
 BfK8LZKGIVDjGPu2mCQWwH+Hwl6OpAEYXpB3+tCHf1u+sGwa/8waI+XYyD/3lTLwcesp
 s4ypXOK41Rz2TvfcmCgf1fNxdMLyp1slipP5AH8UuAwAAxYcU4pGaJU6ooFzZ54sY+d+
 0n2w==
X-Gm-Message-State: AOJu0YwNNeKIwFiHwQ2sP4YVD68oq5UMWOtctPxYRqUGAmXSWi4XL/6o
 s4DS71soqApDmmMzWBVYJz4ynjj1ZldIr6R7A7lQJ6mp5CdrJHQlTqmn+bfhxALh1etOFK92PBx
 ny3kv
X-Gm-Gg: ASbGnctRiBvGyvedkWfA17v2hfZybAESfAN+gX9dtrIuV7yTo7sC1DdTvMUcWknrqo7
 iveE0kcM8T32A0i6nUQfKt+lWuebgFz4aWKyrpdjx2V1nkI/cN6utirmA3njBc2VwzHlLIyidV6
 61UR3xtiOu8CMarYYyv5po5f1RdPT/F3hX9PPXe4anJL56+Fp5i0Xux6aDDF4MYatd6oc/BYTqM
 jwWRxyJw+G1+7/pMTFaOTabaJAWSV6JNDMMyPupgvQcuJBl0XWi+imKp7guQGQJlXpVLWP+Ff7w
 9YashHvNDUTuvXELq+KmVACNmEQphg246V7rc8HdRq3m6Mw1BhwcN5Ypv3ZWLihjiojX
X-Google-Smtp-Source: AGHT+IFYFJn3fkJZPOFNqJUmKht7wl8xcj38FioE+Ow+xPwWZ/8m0FtiE89z1wkkqf3vzmiuq+gLmw==
X-Received: by 2002:a05:6000:420c:b0:3a4:f6ba:51c8 with SMTP id
 ffacd0b85a97d-3a531ca732bmr2953716f8f.14.1749218609987; 
 Fri, 06 Jun 2025 07:03:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5324364f1sm2030346f8f.58.2025.06.06.07.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:03:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] hw/core: Permit devices to define an array of link properties
Date: Fri,  6 Jun 2025 15:03:27 +0100
Message-ID: <20250606140327.1289993-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
 include/hw/qdev-properties.h | 40 ++++++++++++++++++
 include/qom/object.h         | 19 +++++++++
 hw/core/qdev-properties.c    | 80 ++++++++++++++++++++++++++++++++++++
 qom/object.c                 | 42 +++++++++++--------
 4 files changed, 163 insertions(+), 18 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 2c99856caac..8be8ca293fe 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -150,6 +150,31 @@ extern const PropertyInfo qdev_prop_link;
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
@@ -201,6 +226,21 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
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
index 26df6137b91..48fdbf353ee 100644
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
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 147b3ffd16e..47142769179 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -601,6 +601,7 @@ static Property array_elem_prop(Object *obj, const Property *parent_prop,
          * being inside the device struct.
          */
         .offset = (uintptr_t)elem - (uintptr_t)obj,
+        .link_type = parent_prop->link_type,
     };
 }
 
@@ -883,6 +884,12 @@ void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values)
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
@@ -992,9 +999,82 @@ static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
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
+    printf("got path %s ptr %p\n", path, targetp);
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
+    printf("got new_target %p\n", new_target);
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
diff --git a/qom/object.c b/qom/object.c
index 1856bb36c74..6490548bcb1 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1894,26 +1894,13 @@ static void object_get_link_property(Object *obj, Visitor *v,
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
@@ -1930,11 +1917,30 @@ static Object *object_resolve_link(Object *obj, const char *name,
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


