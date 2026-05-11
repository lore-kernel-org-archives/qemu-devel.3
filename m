Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E13FCD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRPB-00037g-Nj; Mon, 11 May 2026 10:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMRP7-00034w-6B
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMRP5-00012F-4D
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778508878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Qw95Rr2nhMPOvK9li1D/zcB3kAu9EHrXRsUOSiefiQ=;
 b=SAf1EqjvhDacIOL3Qc2k3lgl2gFB8K11TNsH0Zu4Jl4myyG4JSC8ifl1ZeQ+ALhpwFy+Ye
 z3LRihfs8XPEhWAyhQm4mzclBWsSIAEE2xhkhT+jxpQpiWlirez6vX+GkHdGJ1659BULRb
 2BB4YYOrGmcC0a8zTOmbci3Gy+bEuww=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-2wNPMLsgNlW4MLNNoNDM4Q-1; Mon,
 11 May 2026 10:14:36 -0400
X-MC-Unique: 2wNPMLsgNlW4MLNNoNDM4Q-1
X-Mimecast-MFC-AGG-ID: 2wNPMLsgNlW4MLNNoNDM4Q_1778508876
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB15A18002E3; Mon, 11 May 2026 14:14:35 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1E6519560A2; Mon, 11 May 2026 14:14:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 04/10] qom: shorten name of
 object_set_properties_from_keyval
Date: Mon, 11 May 2026 15:14:14 +0100
Message-ID: <20260511141420.229023-5-berrange@redhat.com>
In-Reply-To: <20260511141420.229023-1-berrange@redhat.com>
References: <20260511141420.229023-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This matches the convention established by the object_set_props and
object_set_propv methods.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h    |  6 +++---
 qom/object_interfaces.c | 12 ++++++------
 system/qdev-monitor.c   |  4 ++--
 system/vl.c             |  7 ++++---
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index c7d80914fb..d841c338a2 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -915,7 +915,7 @@ type_init(do_qemu_init_ ## type_array)
 bool type_print_class_properties(const char *type);
 
 /**
- * object_set_properties_from_keyval:
+ * object_set_props_from_keyval:
  * @obj: a QOM object
  * @qdict: a dictionary with the properties to be set
  * @from_json: true if leaf values of @qdict are typed, false if they
@@ -925,8 +925,8 @@ bool type_print_class_properties(const char *type);
  * For each key in the dictionary, parse the value string if needed,
  * then set the corresponding property in @obj.
  */
-void object_set_properties_from_keyval(Object *obj, const QDict *qdict,
-                                       bool from_json, Error **errp);
+void object_set_props_from_keyval(Object *obj, const QDict *qdict,
+                                  bool from_json, Error **errp);
 
 /**
  * object_class_dynamic_cast_assert:
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 415cbee8c5..4377d65b76 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -44,8 +44,8 @@ bool user_creatable_can_be_deleted(UserCreatable *uc)
     }
 }
 
-static void object_set_properties_from_qdict(Object *obj, const QDict *qdict,
-                                             Visitor *v, Error **errp)
+static void object_set_props_from_qdict(Object *obj, const QDict *qdict,
+                                        Visitor *v, Error **errp)
 {
     const QDictEntry *e;
 
@@ -62,8 +62,8 @@ out:
     visit_end_struct(v, NULL);
 }
 
-void object_set_properties_from_keyval(Object *obj, const QDict *qdict,
-                                       bool from_json, Error **errp)
+void object_set_props_from_keyval(Object *obj, const QDict *qdict,
+                                  bool from_json, Error **errp)
 {
     Visitor *v;
     if (from_json) {
@@ -71,7 +71,7 @@ void object_set_properties_from_keyval(Object *obj, const QDict *qdict,
     } else {
         v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     }
-    object_set_properties_from_qdict(obj, qdict, v, errp);
+    object_set_props_from_qdict(obj, qdict, v, errp);
     visit_free(v);
 }
 
@@ -110,7 +110,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
 
     assert(qdict);
     obj = object_new_with_class(klass);
-    object_set_properties_from_qdict(obj, qdict, v, &local_err);
+    object_set_props_from_qdict(obj, qdict, v, &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index e5b55e3004..dfc95a08c1 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -730,8 +730,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     qdict_del(properties, "bus");
     qdict_del(properties, "id");
 
-    object_set_properties_from_keyval(&dev->parent_obj, properties, from_json,
-                                      errp);
+    object_set_props_from_keyval(&dev->parent_obj, properties, from_json,
+                                 errp);
     qobject_unref(properties);
     if (*errp) {
         goto err_del_dev;
diff --git a/system/vl.c b/system/vl.c
index d2f4044e5d..288819c409 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2009,7 +2009,8 @@ static bool object_create_early(const char *type)
 
 static void qemu_apply_machine_options(QDict *qdict)
 {
-    object_set_properties_from_keyval(OBJECT(current_machine), qdict, false, &error_fatal);
+    object_set_props_from_keyval(OBJECT(current_machine), qdict,
+                                 false, &error_fatal);
 
     if (semihosting_enabled(false) && !semihosting_get_argc()) {
         /* fall back to the -kernel/-append */
@@ -2224,8 +2225,8 @@ static void qemu_create_machine(QDict *qdict)
             keyval_parse(machine_class->default_machine_opts, NULL, NULL,
                          &error_abort);
         qemu_apply_legacy_machine_options(default_opts);
-        object_set_properties_from_keyval(OBJECT(current_machine), default_opts,
-                                          false, &error_abort);
+        object_set_props_from_keyval(OBJECT(current_machine), default_opts,
+                                     false, &error_abort);
         qobject_unref(default_opts);
     }
 }
-- 
2.54.0


