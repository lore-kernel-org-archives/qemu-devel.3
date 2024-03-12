Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644D1C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2tA-0000Z5-1C; Tue, 12 Mar 2024 10:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t7-0000VN-JM
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t3-00029u-Sb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OM00T1Pe8+CaWeDlAtTihcYEFsDDW+UhOBfAxqqzog=;
 b=fJjP7bFHas0AtQrkHx5UX51kQZgN1eWT+Uxi+aVVbqK7XEj4wOjrmjPrWW4RWOAYZZSeMr
 A+U93oAcrX/X4p8tTEkgWQfrN0zhgLDMTNknUQcl2s3tfmqLY0IO/Z5fDOOTqgZ6TEKNZJ
 hGewUBSm/xOFYCsFYbkFgxtg7MXJmKk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-x9u-_q8AOoq7Ym154Pz92A-1; Tue,
 12 Mar 2024 10:13:46 -0400
X-MC-Unique: x9u-_q8AOoq7Ym154Pz92A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCB8A3814EB3;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9351C060D0;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3802B21E688F; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-block@nongnu.org,
	philmd@linaro.org
Subject: [PATCH 06/10] qapi: Inline QERR_INVALID_PARAMETER_TYPE definition
 (constant value)
Date: Tue, 12 Mar 2024 15:13:39 +0100
Message-ID: <20240312141343.3168265-7-armbru@redhat.com>
In-Reply-To: <20240312141343.3168265-1-armbru@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using the following
coccinelle semantic patch:

    @match@
    expression errp;
    expression param;
    constant value;
    @@
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);

    @script:python strformat depends on match@
    value << match.value;
    fixedfmt; // new var
    @@
    fixedfmt = f'"Invalid parameter type for \'%s\', expected: {value[1:-1]}"'
    coccinelle.fixedfmt = cocci.make_ident(fixedfmt)

    @replace@
    expression match.errp;
    expression match.param;
    constant match.value;
    identifier strformat.fixedfmt;
    @@
    -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
    +    error_setg(errp, fixedfmt, param);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 32 ++++++++++++++++----------------
 qapi/string-input-visitor.c  |  8 ++++----
 qom/object.c                 | 12 ++++++++----
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 3e8aca6b15..f110a804b2 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -288,8 +288,8 @@ static bool qobject_input_start_struct(Visitor *v, const char *name, void **obj,
         return false;
     }
     if (qobject_type(qobj) != QTYPE_QDICT) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "object");
+        error_setg(errp, "Invalid parameter type for '%s', expected: object",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -326,8 +326,8 @@ static bool qobject_input_start_list(Visitor *v, const char *name,
         return false;
     }
     if (qobject_type(qobj) != QTYPE_QLIST) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "array");
+        error_setg(errp, "Invalid parameter type for '%s', expected: array",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -405,8 +405,8 @@ static bool qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
     }
     qnum = qobject_to(QNum, qobj);
     if (!qnum || !qnum_get_try_int(qnum, obj)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "integer");
+        error_setg(errp, "Invalid parameter type for '%s', expected: integer",
+                   full_name(qiv, name));
         return false;
     }
     return true;
@@ -494,8 +494,8 @@ static bool qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     }
     qbool = qobject_to(QBool, qobj);
     if (!qbool) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "boolean");
+        error_setg(errp, "Invalid parameter type for '%s', expected: boolean",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -534,8 +534,8 @@ static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
     }
     qstr = qobject_to(QString, qobj);
     if (!qstr) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "string");
+        error_setg(errp, "Invalid parameter type for '%s', expected: string",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -565,8 +565,8 @@ static bool qobject_input_type_number(Visitor *v, const char *name, double *obj,
     }
     qnum = qobject_to(QNum, qobj);
     if (!qnum) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "number");
+        error_setg(errp, "Invalid parameter type for '%s', expected: number",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -587,8 +587,8 @@ static bool qobject_input_type_number_keyval(Visitor *v, const char *name,
 
     if (qemu_strtod_finite(str, NULL, &val)) {
         /* TODO report -ERANGE more nicely */
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "number");
+        error_setg(errp, "Invalid parameter type for '%s', expected: number",
+                   full_name(qiv, name));
         return false;
     }
 
@@ -623,8 +623,8 @@ static bool qobject_input_type_null(Visitor *v, const char *name,
     }
 
     if (qobject_type(qobj) != QTYPE_QNULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-                   full_name(qiv, name), "null");
+        error_setg(errp, "Invalid parameter type for '%s', expected: null",
+                   full_name(qiv, name));
         return false;
     }
     *obj = qnull();
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 197139c1c0..3f1b9e9b41 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -353,8 +353,8 @@ static bool parse_type_number(Visitor *v, const char *name, double *obj,
 
     assert(siv->lm == LM_NONE);
     if (qemu_strtod_finite(siv->string, NULL, &val)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "number");
+        error_setg(errp, "Invalid parameter type for '%s', expected: number",
+                   name ? name : "null");
         return false;
     }
 
@@ -371,8 +371,8 @@ static bool parse_type_null(Visitor *v, const char *name, QNull **obj,
     *obj = NULL;
 
     if (siv->string[0]) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "null");
+        error_setg(errp, "Invalid parameter type for '%s', expected: null",
+                   name ? name : "null");
         return false;
     }
 
diff --git a/qom/object.c b/qom/object.c
index d4a001cf41..3d96818f7d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1495,7 +1495,8 @@ char *object_property_get_str(Object *obj, const char *name,
     }
     qstring = qobject_to(QString, ret);
     if (!qstring) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "string");
+        error_setg(errp, "Invalid parameter type for '%s', expected: string",
+                   name);
         retval = NULL;
     } else {
         retval = g_strdup(qstring_get_str(qstring));
@@ -1556,7 +1557,8 @@ bool object_property_get_bool(Object *obj, const char *name,
     }
     qbool = qobject_to(QBool, ret);
     if (!qbool) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "boolean");
+        error_setg(errp, "Invalid parameter type for '%s', expected: boolean",
+                   name);
         retval = false;
     } else {
         retval = qbool_get_bool(qbool);
@@ -1589,7 +1591,8 @@ int64_t object_property_get_int(Object *obj, const char *name,
 
     qnum = qobject_to(QNum, ret);
     if (!qnum || !qnum_get_try_int(qnum, &retval)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "int");
+        error_setg(errp, "Invalid parameter type for '%s', expected: int",
+                   name);
         retval = -1;
     }
 
@@ -1663,7 +1666,8 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
     }
     qnum = qobject_to(QNum, ret);
     if (!qnum || !qnum_get_try_uint(qnum, &retval)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "uint");
+        error_setg(errp, "Invalid parameter type for '%s', expected: uint",
+                   name);
         retval = 0;
     }
 
-- 
2.44.0


