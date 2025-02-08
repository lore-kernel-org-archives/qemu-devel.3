Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AEFC0219E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 07:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgfcf-0005xv-JC; Sat, 08 Feb 2025 02:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfce-0005vT-4S
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:28 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tgfcc-0007VL-3W
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 02:51:27 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fa21145217so3595364a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 23:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1739001084; x=1739605884;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KZyqVN9RpjPMwnzyGHN4dKQm8h3LMbjbUFr2jjDnuTQ=;
 b=1R+kr0bVn3SJZtXYk3fYGYd841eQImoo4dinsgtj/x8H3OW3r/JwrWqlGaK/mwyEb/
 rlIs0VLzN+dOGziERAFkY/ri13tH/3EBjl26sEB3ZkfX3sotYpj+oFpwB9ptbL1h5X1e
 zEa5a4j1/eUgzAiYXDAE1M9NVrR0yoHtD66hr0tAKyvNlsWAZzWng90my7AE0no90DSJ
 a6qIZoVRsetoGhK7HlHvrUCiVK8zFsFHX8D0slXbEW5tu8zTLQ78hZcPve7t4SeQ/U/a
 uOyyBGLAvhJijFkU7O1ePfQ45b9qxljygNEFpiTq0szKbNMC9rJybLA19Q3Id9KDHmsQ
 zrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739001084; x=1739605884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZyqVN9RpjPMwnzyGHN4dKQm8h3LMbjbUFr2jjDnuTQ=;
 b=gf4TlOAXupfC9Jobc6BuxeRctouOxWSUNeY4eg5YEyXe6ChWI6tXOWGkbCgDtfsksn
 Sv1zX6ZjyfooDWVeDenXxx+sBhdsRB2aqnIBwMfAveG0K7lyxA2iOpY7+PzS0lvO2nau
 iqLGIpUkKQhZ0gSAOXd9d5YbQu34p+cOGRinwJ+m8aAonpljzWYaC/9Vn+eQzC8/EwOj
 WCeIpHDyTS4wc5bm7ilEGujcg7LkgAbFEwIucmkMx4+zAXAZsRMrN3L+fplJwuRXjFbS
 K2F/STmeNchcyE9Ke3v1nrePPWjjcaodH1EAftTTgHoans4INVXCXWNkK18jlY6b0htH
 9usQ==
X-Gm-Message-State: AOJu0YzigwKTmOhZyNnHd0BGOGW7pxQDRt332iDK7v1i8rhgR6Zdquph
 Hu9oOxFIiWmhbe3btGcJri1Mkg4kfwzENngRtX4GK2qrIqzNGcCahFx3Wx/iP3s=
X-Gm-Gg: ASbGncvjZFS4dxu8QqRgoh6J7xEtgG7vCjXCramUyhLf8ejF3ugm10KDvJzPRguYXTZ
 5ZVMZ0iaru3T29QSVvKCVuE7ZntP1kiJrRhgwTbPUu1SV4VE1wgZ3Dvbi+eJ3tXMyG0Tn8kBtge
 kBIay1GbkrENorHOHuhoSy3XccR0HATBj2ffSNH6iwRugSIVgERkqyxAqJpTJRJQcbA63iqQ7c8
 dOYrRSBzkkiBRZD2LbP0j4u5taSsI5kPse/4uO1nqRNAhLvSqY2m1RahrloNql78U+4+HHpIdgW
 JMTCrn1UJHVNbb21wog=
X-Google-Smtp-Source: AGHT+IHPrU85QsIRqJLCtguhWbqF3bbTUKbJ5D/sFO+5WJzVuQMTsodkADu3jFdgFFtRVU72+OYw0A==
X-Received: by 2002:a05:6a00:3d51:b0:729:35b:542e with SMTP id
 d2e1a72fcca58-7305d51c6a5mr8372289b3a.16.1739001084579; 
 Fri, 07 Feb 2025 23:51:24 -0800 (PST)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7307cf77a3asm68331b3a.68.2025.02.07.23.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 23:51:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 08 Feb 2025 16:51:07 +0900
Subject: [PATCH v5 1/4] qapi: Do not consume a value if failed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-virtio-v5-1-4376cb218c0f@daynix.com>
References: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
In-Reply-To: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not consume a value if interpreting one failed so that we can
reinterpret the value with a different type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qapi/qobject-input-visitor.c | 103 +++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 34 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f110a804b2ae0f3f75122775ddbc5ec7cc5de230..799c1c9bd6bde0676d6b028b485de13cb4884395 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -116,9 +116,8 @@ static const char *full_name(QObjectInputVisitor *qiv, const char *name)
     return full_name_nth(qiv, name, 0);
 }
 
-static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,
-                                             const char *name,
-                                             bool consume)
+static QObject *qobject_input_try_get_object(const QObjectInputVisitor *qiv,
+                                             const char *name)
 {
     StackObject *tos;
     QObject *qobj;
@@ -138,34 +137,19 @@ static QObject *qobject_input_try_get_object(QObjectInputVisitor *qiv,
     if (qobject_type(qobj) == QTYPE_QDICT) {
         assert(name);
         ret = qdict_get(qobject_to(QDict, qobj), name);
-        if (tos->h && consume && ret) {
-            bool removed = g_hash_table_remove(tos->h, name);
-            assert(removed);
-        }
     } else {
         assert(qobject_type(qobj) == QTYPE_QLIST);
         assert(!name);
-        if (tos->entry) {
-            ret = qlist_entry_obj(tos->entry);
-            if (consume) {
-                tos->entry = qlist_next(tos->entry);
-            }
-        } else {
-            ret = NULL;
-        }
-        if (consume) {
-            tos->index++;
-        }
+        ret = tos->entry ? qlist_entry_obj(tos->entry) : NULL;
     }
 
     return ret;
 }
 
 static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
-                                         const char *name,
-                                         bool consume, Error **errp)
+                                         const char *name, Error **errp)
 {
-    QObject *obj = qobject_input_try_get_object(qiv, name, consume);
+    QObject *obj = qobject_input_try_get_object(qiv, name);
 
     if (!obj) {
         error_setg(errp, QERR_MISSING_PARAMETER, full_name(qiv, name));
@@ -173,6 +157,38 @@ static QObject *qobject_input_get_object(QObjectInputVisitor *qiv,
     return obj;
 }
 
+static void qobject_input_consume_object(QObjectInputVisitor *qiv,
+                                         const char *name)
+{
+    StackObject *tos;
+    QObject *qobj;
+
+    if (QSLIST_EMPTY(&qiv->stack)) {
+        /* Starting at root, name is ignored. */
+        return;
+    }
+
+    /* We are in a container; find the next element. */
+    tos = QSLIST_FIRST(&qiv->stack);
+    qobj = tos->obj;
+    assert(qobj);
+
+    if (qobject_type(qobj) == QTYPE_QDICT) {
+        assert(name);
+        if (tos->h) {
+            bool removed = g_hash_table_remove(tos->h, name);
+            assert(removed);
+        }
+    } else {
+        assert(qobject_type(qobj) == QTYPE_QLIST);
+        assert(!name);
+        if (tos->entry) {
+            tos->entry = qlist_next(tos->entry);
+        }
+        tos->index++;
+    }
+}
+
 static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
                                             const char *name,
                                             Error **errp)
@@ -180,7 +196,7 @@ static const char *qobject_input_get_keyval(QObjectInputVisitor *qiv,
     QObject *qobj;
     QString *qstr;
 
-    qobj = qobject_input_get_object(qiv, name, true, errp);
+    qobj = qobject_input_get_object(qiv, name, errp);
     if (!qobj) {
         return NULL;
     }
@@ -233,6 +249,7 @@ static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
         tos->index = -1;
     }
 
+    qobject_input_consume_object(qiv, name);
     QSLIST_INSERT_HEAD(&qiv->stack, tos, node);
     return tos->entry;
 }
@@ -279,7 +296,7 @@ static bool qobject_input_start_struct(Visitor *v, const char *name, void **obj,
                                        size_t size, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     if (obj) {
         *obj = NULL;
@@ -316,7 +333,7 @@ static bool qobject_input_start_list(Visitor *v, const char *name,
                                      Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     const QListEntry *entry;
 
     if (list) {
@@ -382,7 +399,7 @@ static bool qobject_input_start_alternate(Visitor *v, const char *name,
                                           Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, false, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     if (!qobj) {
         *obj = NULL;
@@ -397,7 +414,7 @@ static bool qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
                                      Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QNum *qnum;
 
     if (!qobj) {
@@ -409,6 +426,7 @@ static bool qobject_input_type_int64(Visitor *v, const char *name, int64_t *obj,
                    full_name(qiv, name));
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -428,6 +446,7 @@ static bool qobject_input_type_int64_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "integer");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -435,7 +454,7 @@ static bool qobject_input_type_uint64(Visitor *v, const char *name,
                                       uint64_t *obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QNum *qnum;
     int64_t val;
 
@@ -448,12 +467,14 @@ static bool qobject_input_type_uint64(Visitor *v, const char *name,
     }
 
     if (qnum_get_try_uint(qnum, obj)) {
+        qobject_input_consume_object(qiv, name);
         return true;
     }
 
     /* Need to accept negative values for backward compatibility */
     if (qnum_get_try_int(qnum, &val)) {
         *obj = val;
+        qobject_input_consume_object(qiv, name);
         return true;
     }
 
@@ -479,6 +500,7 @@ static bool qobject_input_type_uint64_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "integer");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -486,7 +508,7 @@ static bool qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
                                     Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QBool *qbool;
 
     if (!qobj) {
@@ -500,6 +522,7 @@ static bool qobject_input_type_bool(Visitor *v, const char *name, bool *obj,
     }
 
     *obj = qbool_get_bool(qbool);
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -518,6 +541,7 @@ static bool qobject_input_type_bool_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "'on' or 'off'");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -525,7 +549,7 @@ static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
                                    Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QString *qstr;
 
     *obj = NULL;
@@ -540,6 +564,7 @@ static bool qobject_input_type_str(Visitor *v, const char *name, char **obj,
     }
 
     *obj = g_strdup(qstring_get_str(qstr));
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -549,15 +574,20 @@ static bool qobject_input_type_str_keyval(Visitor *v, const char *name,
     QObjectInputVisitor *qiv = to_qiv(v);
     const char *str = qobject_input_get_keyval(qiv, name, errp);
 
+    if (!str) {
+        return false;
+    }
+
     *obj = g_strdup(str);
-    return !!str;
+    qobject_input_consume_object(qiv, name);
+    return true;
 }
 
 static bool qobject_input_type_number(Visitor *v, const char *name, double *obj,
                                       Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
     QNum *qnum;
 
     if (!qobj) {
@@ -571,6 +601,7 @@ static bool qobject_input_type_number(Visitor *v, const char *name, double *obj,
     }
 
     *obj = qnum_get_double(qnum);
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -593,6 +624,7 @@ static bool qobject_input_type_number_keyval(Visitor *v, const char *name,
     }
 
     *obj = val;
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -600,7 +632,7 @@ static bool qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
                                    Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     *obj = NULL;
     if (!qobj) {
@@ -608,6 +640,7 @@ static bool qobject_input_type_any(Visitor *v, const char *name, QObject **obj,
     }
 
     *obj = qobject_ref(qobj);
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -615,7 +648,7 @@ static bool qobject_input_type_null(Visitor *v, const char *name,
                                     QNull **obj, Error **errp)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_get_object(qiv, name, true, errp);
+    QObject *qobj = qobject_input_get_object(qiv, name, errp);
 
     *obj = NULL;
     if (!qobj) {
@@ -628,6 +661,7 @@ static bool qobject_input_type_null(Visitor *v, const char *name,
         return false;
     }
     *obj = qnull();
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
@@ -647,13 +681,14 @@ static bool qobject_input_type_size_keyval(Visitor *v, const char *name,
                    full_name(qiv, name), "size");
         return false;
     }
+    qobject_input_consume_object(qiv, name);
     return true;
 }
 
 static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
-    QObject *qobj = qobject_input_try_get_object(qiv, name, false);
+    QObject *qobj = qobject_input_try_get_object(qiv, name);
 
     if (!qobj) {
         *present = false;

-- 
2.48.1


