Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243FBD1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rd-0004x4-9p; Mon, 04 Nov 2024 12:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rZ-0004ua-C1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rV-0008WV-FJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G41Gm1r+0jL4g/l3GF6vapafdMpPd/OeL9O59Yu11q4=;
 b=A/FoQApo8Grux92CLl7o4LTWUyrxTDoYlG9nABC9yuxy+PmMQT2WqRcS/NM5MGgC5FUV1Z
 No42eM+NJWaFT/q/cHJtrPL8j+94IpveNEJAckUWP+HAargMZKNY5U/+zrTz7VLFd054Lk
 tesPAefPcOHjGY7uFjewyCU+TyeSM5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-u0w2FweHMjGCnM4ZIG4QoQ-1; Mon, 04 Nov 2024 12:27:27 -0500
X-MC-Unique: u0w2FweHMjGCnM4ZIG4QoQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so33007565e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741245; x=1731346045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G41Gm1r+0jL4g/l3GF6vapafdMpPd/OeL9O59Yu11q4=;
 b=DApphZGjU76OmFKek01HHs1wOqnTu8TVx6y/ckX61mtazUA0DcI0QVVR0UD/IM25mZ
 rArH/HCPPQsduTJEJbW4pCmEUfk2U9Y/B2RwhP0V3BtWzXwMxHAKvG0qe4L5vwuYzZ7p
 tbki+iWLodpw6FR8XHPt+JBYBXI8nSH4n1ROgqx10+LO7fWIn5iC4lWN+saYGnIwpfTj
 /QH6cHSUjg/ZuZJbFA1KuLUv+ypkGZqkwGk1LPNHDFK7X5GNmG1GWZiuNMQVBvVMJRqh
 o/HYeKAdYiOmYal7J5DAyuLTwIl8uL8wOYRZZpUWBMXFd+xQvu5icS4lrWf2OQG31PFb
 Xxig==
X-Gm-Message-State: AOJu0Yy2e8hhfl1l2ThUxjCKvvOtr9IXPSuhEeZzyOazjSMoc2F/1zN5
 xcj8xAol2TRALf9XFzmU/HzfHe1DmdcW4GlrfzBIh+EQ4Z771wFVoX2nsrVvHskGNfQ6wMKbBD5
 do+tXzXNU7FzFSlkUvUyY81VgioCRHBU2TGxl/xK+31GQ8eec/gZ/KTHwyZXsi7wvKGlsBCj+y6
 5BqLhMiYi+VVw9+FOLQ4dtw1JPpAatJq2yg+v3MXk=
X-Received: by 2002:a05:600c:1c26:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-4329fdb1571mr13327515e9.7.1730741245437; 
 Mon, 04 Nov 2024 09:27:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzz9GgleBcTafAicin2kz0iC+UtA+M7wUEwIO6MNw397w0/jl3xahcJZD/4DU2sTYCH3EtjQ==
X-Received: by 2002:a05:600c:1c26:b0:432:9fdb:1490 with SMTP id
 5b1f17b1804b1-4329fdb1571mr13327265e9.7.1730741245051; 
 Mon, 04 Nov 2024 09:27:25 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d40casm13763407f8f.27.2024.11.04.09.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 01/40] qdev: make properties array "const"
Date: Mon,  4 Nov 2024 18:26:40 +0100
Message-ID: <20241104172721.180255-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Constify all accesses to qdev properties, except for the
ObjectPropertyAccessor itself.  This makes it possible to place them in
read-only memory, and also lets Rust bindings switch from "static mut"
arrays to "static"; which is advantageous, because mutable statics are
highly discouraged.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h       |  4 ++--
 include/hw/qdev-properties.h |  4 ++--
 hw/core/qdev-properties.c    | 26 +++++++++++++-------------
 system/qdev-monitor.c        |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aa97c34a4be..f9fa291cc63 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -132,7 +132,7 @@ struct DeviceClass {
      * ensures a compile-time error if someone attempts to assign
      * dc->props directly.
      */
-    Property *props_;
+    const Property *props_;
 
     /**
      * @user_creatable: Can user instantiate with -device / device_add?
@@ -935,7 +935,7 @@ char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
  * you attempt to add an existing property defined by a parent class.
  * To modify an inherited property you need to use????
  */
-void device_class_set_props(DeviceClass *dc, Property *props);
+void device_class_set_props(DeviceClass *dc, const Property *props);
 
 /**
  * device_class_set_parent_realize() - set up for chaining realize fns
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 09aa04ca1e2..26ebd230685 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -37,7 +37,7 @@ struct PropertyInfo {
     int (*print)(Object *obj, Property *prop, char *dest, size_t len);
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
-                              Property *prop);
+                              const Property *prop);
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyRelease *release;
@@ -223,7 +223,7 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
  * On error, store error in @errp.  Static properties access data in a struct.
  * The type of the QOM property is derived from prop->info.
  */
-void qdev_property_add_static(DeviceState *dev, Property *prop);
+void qdev_property_add_static(DeviceState *dev, const Property *prop);
 
 /**
  * qdev_alias_all_properties: Create aliases on source for all target properties
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 86a583574dd..315196bd85a 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -749,7 +749,7 @@ const PropertyInfo qdev_prop_array = {
 
 /* --- public helpers --- */
 
-static Property *qdev_prop_walk(Property *props, const char *name)
+static const Property *qdev_prop_walk(const Property *props, const char *name)
 {
     if (!props) {
         return NULL;
@@ -763,10 +763,10 @@ static Property *qdev_prop_walk(Property *props, const char *name)
     return NULL;
 }
 
-static Property *qdev_prop_find(DeviceState *dev, const char *name)
+static const Property *qdev_prop_find(DeviceState *dev, const char *name)
 {
     ObjectClass *class;
-    Property *prop;
+    const Property *prop;
 
     /* device properties */
     class = object_get_class(OBJECT(dev));
@@ -840,7 +840,7 @@ void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
 
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
 {
-    Property *prop;
+    const Property *prop;
 
     prop = qdev_prop_find(dev, name);
     object_property_set_str(OBJECT(dev), name,
@@ -956,7 +956,7 @@ const PropertyInfo qdev_prop_size = {
 /* --- object link property --- */
 
 static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
-                                            Property *prop)
+                                            const Property *prop)
 {
     return object_class_property_add_link(oc, name, prop->link_type,
                                           prop->offset,
@@ -969,7 +969,7 @@ const PropertyInfo qdev_prop_link = {
     .create = create_link_property,
 };
 
-void qdev_property_add_static(DeviceState *dev, Property *prop)
+void qdev_property_add_static(DeviceState *dev, const Property *prop)
 {
     Object *obj = OBJECT(dev);
     ObjectProperty *op;
@@ -980,7 +980,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
                              field_prop_getter(prop->info),
                              field_prop_setter(prop->info),
                              prop->info->release,
-                             prop);
+                             (Property *)prop);
 
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -994,7 +994,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop)
 }
 
 static void qdev_class_add_property(DeviceClass *klass, const char *name,
-                                    Property *prop)
+                                    const Property *prop)
 {
     ObjectClass *oc = OBJECT_CLASS(klass);
     ObjectProperty *op;
@@ -1007,7 +1007,7 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
                                        field_prop_getter(prop->info),
                                        field_prop_setter(prop->info),
                                        prop->info->release,
-                                       prop);
+                                       (Property *)prop);
     }
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);
@@ -1046,7 +1046,7 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
  * Do not use this in new code!  QOM Properties added through this interface
  * will be given names in the "legacy" namespace.
  */
-static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
+static void qdev_class_add_legacy_property(DeviceClass *dc, const Property *prop)
 {
     g_autofree char *name = NULL;
 
@@ -1058,12 +1058,12 @@ static void qdev_class_add_legacy_property(DeviceClass *dc, Property *prop)
     name = g_strdup_printf("legacy-%s", prop->name);
     object_class_property_add(OBJECT_CLASS(dc), name, "str",
         prop->info->print ? qdev_get_legacy_property : prop->info->get,
-        NULL, NULL, prop);
+        NULL, NULL, (Property *)prop);
 }
 
-void device_class_set_props(DeviceClass *dc, Property *props)
+void device_class_set_props(DeviceClass *dc, const Property *props)
 {
-    Property *prop;
+    const Property *prop;
 
     dc->props_ = props;
     for (prop = props; prop && prop->name; prop++) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e16..c346ea6ae4b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -751,7 +751,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
 
-static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
+static void qdev_print_props(Monitor *mon, DeviceState *dev, const Property *props,
                              int indent)
 {
     if (!props)
-- 
2.47.0


