Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B25D30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCh-0008Hj-KF; Fri, 18 Oct 2024 10:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCg-0008HX-3n
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCe-0002cS-Gk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6fXeEeyQn++bTLgXgQsS/yFO40vxiI7losxFrd52jU=;
 b=MqD6ZYNY7v1ub4PulnxZIskQslR4ifssMmXmddnuP5aeNVFX4qgXXd3Tzj1uZmkXGRK3ER
 OtYn2byI1Ahl/NcriE5/qCkuJyCDOWmaw65DeppKR5xBfSF6yIRL/jRhMb4mZd1L0Th/gn
 P3iFmP3fWEAxA0LklErVTnu6fY0a8FM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-_rtPBCsLPh29ujAv61_1fA-1; Fri, 18 Oct 2024 10:43:42 -0400
X-MC-Unique: _rtPBCsLPh29ujAv61_1fA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518ae047so16265445e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262620; x=1729867420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6fXeEeyQn++bTLgXgQsS/yFO40vxiI7losxFrd52jU=;
 b=PWgA5te4MBF84uJEK7/0i9zSzEOEbiYG9+4cokqkSjc/XU1BAnXWw5T0YngwLCMbOw
 0NZtiatWvlXaeVkUj2/hXKVgtSJXsswTqmDTav441cU17bI/vKoUCMjalCfn6Yr8JeDU
 +nluJXOos16rJI607EUMTKkHyOEQV/nQUTcVhHMcqcSZz3Cor7p27Eu0pptWHfM3QYWB
 TKZfbz68ItnxpDw3QuXhpnynOvrIKQnlfqK08iyE8/Hy1XqBVYeYyL4XHHr/kUFX0I0P
 3c+zD0CNzJby2RdFANlVNZPgVJza5OtWtyrnIzwW8Jau+UeWulHC8a1NYiAgRKLeQWGN
 U7gg==
X-Gm-Message-State: AOJu0YyQBPzEnvg2QL3U30CMObDhYDLRq1SqPyHI1XutxRJ+ndLGMYbx
 T2HZtK7nDPDnHWfZNzuRjewaZFix/7ruHYknX7f9W5A5hRVNFrp6RLJIcYgk0kiLExP8NjtYWak
 1yo0leEHDeYA5bqFbf45WmUtVAbpCXF/zmB/oxn/l2UN0LImNCeDLchZkQseEl9Yj495rCdt9rm
 hZHF1QTL/drKLqHYWnPuDbVDGNmOiKV4I89iDqPbg=
X-Received: by 2002:a05:600c:4fcd:b0:431:4e33:98b6 with SMTP id
 5b1f17b1804b1-43161624d76mr17988475e9.5.1729262620282; 
 Fri, 18 Oct 2024 07:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKy+uR3ApXqAZBoEmjUeistu/R6u060V5naxL17li2eQl4agU2Fbf8Ya7MPvzQodZVoVCXwg==
X-Received: by 2002:a05:600c:4fcd:b0:431:4e33:98b6 with SMTP id
 5b1f17b1804b1-43161624d76mr17987435e9.5.1729262619392; 
 Fri, 18 Oct 2024 07:43:39 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160dc9365sm25846115e9.11.2024.10.18.07.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 10/13] qdev: make properties array "const"
Date: Fri, 18 Oct 2024 16:43:02 +0200
Message-ID: <20241018144306.954716-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
2.46.2


