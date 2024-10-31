Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFBED767F4
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLv-00008l-R2; Thu, 31 Oct 2024 13:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLq-0008MX-45
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLn-0007I9-K6
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzYn0DuCH640+/jl+s8xx0DM3IXdyPxXMjX5xdZWxjI=;
 b=IJ0s1Pi/wIXd4f9TiIdhBeChg8+gamefKH9KtNMgt5spLrUPzrjix3BpkFWzedDEn5abfu
 rIoveZAx4TCHEVBy4JjoG2yXncGuL4hJDzJYTHQW5wv3FLQdzFcDRHw4BSuU/IJFUFn5N4
 J+58P6bwTVR5xsMnu6pzyOLaViS1Fb4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-qrFMlxKKOieOjfJcsbDU-g-1; Thu, 31 Oct 2024 13:52:48 -0400
X-MC-Unique: qrFMlxKKOieOjfJcsbDU-g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so523340f8f.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397166; x=1731001966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzYn0DuCH640+/jl+s8xx0DM3IXdyPxXMjX5xdZWxjI=;
 b=niLNAwaPxa+nO+eqxfdviOmE+i2NXQEe4RmXIGp4xZXu2DolVLQLO/g+W2Eeo9P1X9
 Ra4MWWmznpgHQAo6cHlPZhwmxWTK5iFEvdq/err47Cgf46mq98HenRaUK9vZUME+NNxE
 m8ZZSNBXsS8ZIYiQvi3E9Sph8DzJvB/x+GhW1ozIdB9oKmhpFaRpAukpU4wi/D+HmeVe
 298R0sL6A1Gye9T7L9qwNNsHzxAi6lXXYFipagiKEMcr7QfrkEqMLF/VvjbV3P0KpTUa
 GtBUyvmaWUldn79oFkwvHCju2vZPqKGEmc8l7wi3maIqniqv7F3glk4N7h1KBIhSuUHp
 pQ1A==
X-Gm-Message-State: AOJu0YwnSUExbMZjDiHl7bAG8n8sq0EH2+qLjJckb/i8caA3aLPNS6my
 dr+tdIcLf761cs8x1BXQakiyStc7VkRDHEhT4tzB9k0ernNKHYz5HSH3B1DYtdZrqbd7cpgWNAE
 +xWrv7sEbarEJRGaGlGxldMuKfooIMAhJhHJow1eEDO+wCkoxFUebFfGp+zRjhKgYuPsRRcVGu8
 HALqAO0eBqL9rja5kpZj4Q/TqPUhnB4ROmKeyaaCU=
X-Received: by 2002:a5d:6d8a:0:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-381c7a5e8c9mr626363f8f.26.1730397166033; 
 Thu, 31 Oct 2024 10:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEebCiTh7p3jZg6ccOjpE/TLOPm7En0TEirihhIFhgRc89KU9sPs+xyEsxaAA66EquHDF4MbQ==
X-Received: by 2002:a5d:6d8a:0:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-381c7a5e8c9mr626338f8f.26.1730397165564; 
 Thu, 31 Oct 2024 10:52:45 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca7ebsm64418495e9.42.2024.10.31.10.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/49] qom: centralize module-loading functionality
Date: Thu, 31 Oct 2024 18:51:37 +0100
Message-ID: <20241031175214.214455-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

Put together the common code of object_initialize() and
module_object_class_by_name() into a function that supports
Error **.  Rename the existing function type_get_by_name() to
clarify that it will only look at defined types; this is often
okay within object.c to look at the parents, but not outside it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 72 ++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 8b269414488..29155c64639 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -195,7 +195,7 @@ void type_register_static_array(const TypeInfo *infos, int nr_infos)
     }
 }
 
-static TypeImpl *type_get_by_name(const char *name)
+static TypeImpl *type_get_by_name_noload(const char *name)
 {
     if (name == NULL) {
         return NULL;
@@ -204,10 +204,32 @@ static TypeImpl *type_get_by_name(const char *name)
     return type_table_lookup(name);
 }
 
+static TypeImpl *type_get_or_load_by_name(const char *name, Error **errp)
+{
+    TypeImpl *type = type_get_by_name_noload(name);
+
+#ifdef CONFIG_MODULES
+    if (!type) {
+        int rv = module_load_qom(name, errp);
+        if (rv > 0) {
+            type = type_get_by_name_noload(name);
+        } else {
+            error_prepend(errp, "could not load a module for type '%s'", name);
+            return NULL;
+        }
+    }
+#endif
+    if (!type) {
+        error_setg(errp, "unknown type '%s'", name);
+    }
+
+    return type;
+}
+
 static TypeImpl *type_get_parent(TypeImpl *type)
 {
     if (!type->parent_type && type->parent) {
-        type->parent_type = type_get_by_name(type->parent);
+        type->parent_type = type_get_by_name_noload(type->parent);
         if (!type->parent_type) {
             fprintf(stderr, "Type '%s' is missing its parent '%s'\n",
                     type->name, type->parent);
@@ -363,7 +385,7 @@ static void type_initialize(TypeImpl *ti)
         }
 
         for (i = 0; i < ti->num_interfaces; i++) {
-            TypeImpl *t = type_get_by_name(ti->interfaces[i].typename);
+            TypeImpl *t = type_get_by_name_noload(ti->interfaces[i].typename);
             if (!t) {
                 error_report("missing interface '%s' for object '%s'",
                              ti->interfaces[i].typename, parent->name);
@@ -557,23 +579,7 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
 
 void object_initialize(void *data, size_t size, const char *typename)
 {
-    TypeImpl *type = type_get_by_name(typename);
-
-#ifdef CONFIG_MODULES
-    if (!type) {
-        int rv = module_load_qom(typename, &error_fatal);
-        if (rv > 0) {
-            type = type_get_by_name(typename);
-        } else {
-            error_report("missing object type '%s'", typename);
-            exit(1);
-        }
-    }
-#endif
-    if (!type) {
-        error_report("missing object type '%s'", typename);
-        abort();
-    }
+    TypeImpl *type = type_get_or_load_by_name(typename, &error_fatal);
 
     object_initialize_with_type(data, size, type);
 }
@@ -784,7 +790,7 @@ Object *object_new_with_class(ObjectClass *klass)
 
 Object *object_new(const char *typename)
 {
-    TypeImpl *ti = type_get_by_name(typename);
+    TypeImpl *ti = type_get_by_name_noload(typename);
 
     return object_new_with_type(ti);
 }
@@ -957,7 +963,7 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
         return class;
     }
 
-    target_type = type_get_by_name(typename);
+    target_type = type_get_by_name_noload(typename);
     if (!target_type) {
         /* target class type unknown, so fail the cast */
         return NULL;
@@ -1055,7 +1061,7 @@ const char *object_class_get_name(ObjectClass *klass)
 
 ObjectClass *object_class_by_name(const char *typename)
 {
-    TypeImpl *type = type_get_by_name(typename);
+    TypeImpl *type = type_get_by_name_noload(typename);
 
     if (!type) {
         return NULL;
@@ -1068,21 +1074,15 @@ ObjectClass *object_class_by_name(const char *typename)
 
 ObjectClass *module_object_class_by_name(const char *typename)
 {
-    ObjectClass *oc;
+    TypeImpl *type = type_get_or_load_by_name(typename, NULL);
 
-    oc = object_class_by_name(typename);
-#ifdef CONFIG_MODULES
-    if (!oc) {
-        Error *local_err = NULL;
-        int rv = module_load_qom(typename, &local_err);
-        if (rv > 0) {
-            oc = object_class_by_name(typename);
-        } else if (rv < 0) {
-            error_report_err(local_err);
-        }
+    if (!type) {
+        return NULL;
     }
-#endif
-    return oc;
+
+    type_initialize(type);
+
+    return type->class;
 }
 
 ObjectClass *object_class_get_parent(ObjectClass *class)
-- 
2.47.0


