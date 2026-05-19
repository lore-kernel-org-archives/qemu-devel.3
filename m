Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAA8CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJyN-0000vl-UW; Tue, 19 May 2026 08:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJxr-0000OA-1O
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPJxl-0001W6-8J
 for qemu-devel@nongnu.org; Tue, 19 May 2026 08:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779195260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9wLB4CLym9nrvKDYBwDKPAx6VH+gv3KlNnDNRnFKzg=;
 b=iOvtlIpxBEFWRfJ9KJ/9bZ6We/L9K/iWD6RAcn9g4ljFLnd2eppcVdb+RhS2D22IuyKQ3Q
 7PLi+XUUwnQ4coPsCs4y1KpIGMx1gLPa01ph/Csv2YH2BHbkqCnI99gH2pIIYgt63wWwaQ
 B9I2Fq70599QPR85Y4GLHE/AFU5g+Uw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-r1gPPgMNOqGRmvZpfF8k8A-1; Tue,
 19 May 2026 08:54:11 -0400
X-MC-Unique: r1gPPgMNOqGRmvZpfF8k8A-1
X-Mimecast-MFC-AGG-ID: r1gPPgMNOqGRmvZpfF8k8A_1779195245
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40EF11954AD9; Tue, 19 May 2026 12:53:52 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E3376180075D; Tue, 19 May 2026 12:53:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 28/28] qom: drop user_creatable_add_type method
Date: Tue, 19 May 2026 13:51:52 +0100
Message-ID: <20260519125153.1015315-29-berrange@redhat.com>
In-Reply-To: <20260519125153.1015315-1-berrange@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This can be replaced by object_new_with_props_from_qdict, which does
functionally the same job, but the caller does not own the returned
reference, instead the parent object owns it.

In one case we can use object_new_with_props_from_qdict_owned instead
since the object is not intended to have any parent.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 authz/listfile.c                |  4 +-
 include/qom/object_interfaces.h | 18 ---------
 qom/object_interfaces.c         | 70 ++-------------------------------
 tests/unit/check-qom-proplist.c |  5 +--
 4 files changed, 7 insertions(+), 90 deletions(-)

diff --git a/authz/listfile.c b/authz/listfile.c
index 13741d5a72..23655f8663 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -79,8 +79,8 @@ qauthz_list_file_load(QAuthZListFile *fauthz, Error **errp)
 
     v = qobject_input_visitor_new(obj);
 
-    ret = (QAuthZ *)user_creatable_add_type(TYPE_QAUTHZ_LIST,
-                                            NULL, pdict, v, errp);
+    ret = QAUTHZ(object_new_with_props_from_qdict_parentless(
+                     TYPE_QAUTHZ_LIST, pdict, v, errp));
 
  cleanup:
     visit_free(v);
diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index 02b11a7ef0..e2b8615617 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -69,24 +69,6 @@ bool user_creatable_complete(UserCreatable *uc, Error **errp);
  */
 bool user_creatable_can_be_deleted(UserCreatable *uc);
 
-/**
- * user_creatable_add_type:
- * @type: the object type name
- * @id: the unique ID for the object
- * @qdict: the object properties
- * @v: the visitor
- * @errp: if an error occurs, a pointer to an area to store the error
- *
- * Create an instance of the user creatable object @type, placing
- * it in the object composition tree with name @id, initializing
- * it with properties from @qdict
- *
- * Returns: the newly created object or NULL on error
- */
-Object *user_creatable_add_type(const char *type, const char *id,
-                                const QDict *qdict,
-                                Visitor *v, Error **errp);
-
 /**
  * user_creatable_add_qapi:
  * @options: the object definition
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e0a3cd8d0f..7080f85f95 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -44,75 +44,11 @@ bool user_creatable_can_be_deleted(UserCreatable *uc)
     }
 }
 
-Object *user_creatable_add_type(const char *type, const char *id,
-                                const QDict *qdict,
-                                Visitor *v, Error **errp)
-{
-    ERRP_GUARD();
-    Object *obj;
-    ObjectClass *klass;
-    Error *local_err = NULL;
-
-    if (id != NULL && !id_wellformed(id)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
-        error_append_hint(errp, "Identifiers consist of letters, digits, "
-                          "'-', '.', '_', starting with a letter.\n");
-        return NULL;
-    }
-
-    klass = module_object_class_by_name(type);
-    if (!klass) {
-        error_setg(errp, "invalid object type: %s", type);
-        return NULL;
-    }
-
-    if (!object_class_dynamic_cast(klass, TYPE_USER_CREATABLE)) {
-        error_setg(errp, "object type '%s' isn't supported by object-add",
-                   type);
-        return NULL;
-    }
-
-    if (object_class_is_abstract(klass)) {
-        error_setg(errp, "object type '%s' is abstract", type);
-        return NULL;
-    }
-
-    assert(qdict);
-    obj = object_new_with_class(klass);
-    object_set_props_from_qdict(obj, qdict, v, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    if (id != NULL) {
-        object_property_try_add_child(object_get_objects_root(),
-                                      id, obj, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
-
-    if (!user_creatable_complete(USER_CREATABLE(obj), &local_err)) {
-        if (id != NULL) {
-            object_property_del(object_get_objects_root(), id);
-        }
-        goto out;
-    }
-out:
-    if (local_err) {
-        error_propagate(errp, local_err);
-        object_unref(obj);
-        return NULL;
-    }
-    return obj;
-}
-
 void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
 {
     Visitor *v;
     QObject *qobj;
     QDict *props;
-    Object *obj;
 
     v = qobject_output_visitor_new(&qobj);
     visit_type_ObjectOptions(v, NULL, &options, &error_abort);
@@ -124,9 +60,9 @@ void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
     qdict_del(props, "id");
 
     v = qobject_input_visitor_new(QOBJECT(props));
-    obj = user_creatable_add_type(ObjectType_str(options->qom_type),
-                                  options->id, props, v, errp);
-    object_unref(obj);
+    object_new_with_props_from_qdict(ObjectType_str(options->qom_type),
+                                     object_get_objects_root(),
+                                     options->id, props, v, errp);
     qobject_unref(qobj);
     visit_free(v);
 }
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 954c898ce1..89de92b7d9 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -461,10 +461,9 @@ static void test_dummy_createlist_parentless(void)
 static bool test_create_obj(QDict *qdict, Error **errp)
 {
     Visitor *v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
-    Object *obj = user_creatable_add_type(TYPE_DUMMY, "dev0", qdict, v, errp);
-
+    Object *obj = object_new_with_props_from_qdict(
+        TYPE_DUMMY, object_get_objects_root(), "dev0", qdict, v, errp);
     visit_free(v);
-    object_unref(obj);
     return !!obj;
 }
 
-- 
2.54.0


