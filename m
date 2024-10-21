Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C84ED15DBB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vOw-0006bu-AC; Mon, 21 Oct 2024 12:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOI-0006Fw-9H
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOG-0006LL-Gh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6fXeEeyQn++bTLgXgQsS/yFO40vxiI7losxFrd52jU=;
 b=f5VoJM674a8AWIC6FcLDvQbLk665Gjce00sd1kXuDW8UCesNJL6xImptyMbbjPAiTxyvKX
 BOgfBfjfVdV+r7ti9549QlQqWsjTE+FhUFKZ7QsHHeomL8c7S5vo6pa6im8TqrI68FB8Rg
 aS9kPdcXeC8AcwIydqgrnQt5VDCZWTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-wo72bBCBOU6_3b8s-vCNKg-1; Mon, 21 Oct 2024 12:36:18 -0400
X-MC-Unique: wo72bBCBOU6_3b8s-vCNKg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so3166889f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528576; x=1730133376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6fXeEeyQn++bTLgXgQsS/yFO40vxiI7losxFrd52jU=;
 b=t6eYaX9volYjCK3imRZhvfIG1yPm+fCwpN6XBzeZaHoipkn5ALvKrfD6oF0g8dN/r3
 C+ozPJE7z96DS2/0OllWB+tlYv00+Vks9lVsrcn0pd4mEIevC0D7q8votBULoS5IZ1zI
 aMVUrwkoGAFjp4NDPR2vCeQ2YsLSFdZMN1/9giDdnObX6bFjONNMAy0kgvm3Tj/UjVvz
 Jtb55BjJUIuiy67OQCR/14uaQRm0g1OcY5fCUkihZW6DA6t/t4MhCDZS9Hu2fxuOuBLw
 OIgePtShcIrZP6F0MpX8dXIwj2CiedVXYk97wa3VKbYz7d2PdcO6BBnrNn2NcRUKobYo
 V0SA==
X-Gm-Message-State: AOJu0Yw+IqJ5dxdI5xc6H/4efCkLOE8xzCSJ0W9E+lPE9JENh8EK10Ql
 l3Drgaa5NTlersiUfH71MGqd6tvgabZLScJD1tKTDvveRfzkLYrzDu32XxZu0cZoe19xuD6REGA
 TZuf+8gz0Nz+WIClUzPHL2RNvd0XGB9H5CaG4/OEEJbhvLeYXlZgwPMRNaTAiyRqYBmb5FUtupi
 vZTNjrnTnjhUQUEclDBi9iZP7ucCMR3hDnssqfxac=
X-Received: by 2002:adf:f10e:0:b0:37e:d92f:c24a with SMTP id
 ffacd0b85a97d-37ef12624ebmr186003f8f.7.1729528575910; 
 Mon, 21 Oct 2024 09:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMK3/foCCFBtMo7wEMvC8DQ/6La2pEr8BWwn0ngNksc+uOYCltyX6UNBYr2vLrTUWfb2nrFQ==
X-Received: by 2002:adf:f10e:0:b0:37e:d92f:c24a with SMTP id
 ffacd0b85a97d-37ef12624ebmr185978f8f.7.1729528575370; 
 Mon, 21 Oct 2024 09:36:15 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a584f7sm4698516f8f.53.2024.10.21.09.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:36:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 10/13] qdev: make properties array "const"
Date: Mon, 21 Oct 2024 18:35:35 +0200
Message-ID: <20241021163538.136941-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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


