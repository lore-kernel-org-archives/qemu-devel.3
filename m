Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6B7606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cYFvzZ8l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2lh-0004yJ-I5; Thu, 05 Nov 2026 14:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kx-0004rg-Ao
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:23 -0500
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kr-0003lU-Ey
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:11 -0500
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1b244fb7fffso2939439c88.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793905448; x=1794510248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IHT+WPtb//sv+C4Z0/0CcEv9y3TcznwdA9jfvTtJKdo=;
 b=cYFvzZ8l62LPlbUq3H4oOPeRiYaLqdxR+tHXqivQI/BlWSDKSbI77hnfyPDPzMXwuN
 aaUbtTV85DsyA8/qGjBFqJEOX/bDKXqetemrSrD01geRMQWegquYMKfud6dPMIiBJApW
 ZgkSzuLVwHTdvse4GZ2oopY3LUDj7Kg/GRaiHOP0z6LqYsfhJWzIztkmLbhw9TCjMhDm
 MgaG+0luhTQFcptODYseQcAyAuD8tSpLkHG8eE9c4i7KwMiyWtDkiin3pO6sn7GJJF+H
 CcvvNE6XEPn4NU2dkSWmldOoxQnj0Z+ar8dXu0SuGw2CY9YTzU0cHOsZA2QW/aV1l2nW
 BKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905448; x=1794510248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IHT+WPtb//sv+C4Z0/0CcEv9y3TcznwdA9jfvTtJKdo=;
 b=pLFQQFwzPe+nadDp3nQIUUxD8BDtM6racBW4gxiiwMuju1CxvukgR95OcVCOyabnTa
 rFkURXCqBUINDwl8ErfteFECYoxqeIMCLqoe9L02BjPZQW5/cs/1Ni03XV90GTOxwug7
 /uOgQ7tcH0tP7I5OR4UZD2dodzQ97gE/znesXTbvLG0tETaJi/XwwmeFCO0xLgMvDZlv
 7gNQ3Bv0Hri6CiLRbArg+3u+DtHRblzQ2p21zn16GT2s9BtVA93r1Jy472Yug4N9gNIo
 uTwJPmv1orPZCveaGPH0JuZqoA+yathSdifxnvB2Ztdib5cw/UiJ1UvS1FpiC15OpyZy
 e5yg==
X-Gm-Message-State: APuU4Z8MDkgWOVj9emqtAMZK3kczOu+/n7Mz3hal3yEoE+ul6bnb/kpr
 +uRZoLwfeeOV+xlCdsIqNMb2tISfApBD+D17VjqMTEaK5woWxnnPd9jEKJrxWUZJcEU=
X-Gm-Gg: AYBFou3PV1dQngpY3+hMbtziC5aUkis/b2bLYpJ6D+lSH2ClA7eyvhs4/ETLO6luljK
 SdawyWH7ajyP/v/Js8neJyno3smchEbt/zZn0dZikIFiQ7Xlc7+lcwR/024Q9K87YG4GYSqRC1w
 tzKnqGsaLgv1vSeLLinXw+XUA2YlR6R821Zwnp33S4/sUT6nJkxQXMx6qwXhwWhPI+XFRQk1c4V
 yQfeLUq3R5FaFzyAZ/0CrPG6NLY12BcDIKq422xiZW0vp6nrwELOJrB1NNlHCI9+X+0WIXtPceO
 pmdQLrHF4eRkEj/FCt1zwchsBAXgEF1A2ETaTcgyeuUHmWmXb+IqhUfRGP3HjZQMf651h4alb4z
 ZSH0J9ZCt7ze1iaYKpdsg+SNTxk9t9z7qH9IG50MTWUAxyOCqfReFpJrdKetNCjtqqkqoEFA0ps
 +KjCK1ELVDM4MyxszrcJ9mls7M+ljNoBxN3ZZXcfnyn1FVSbd2bb0BrVvX7a6Z8N6IQzC4UoEdA
 xeYHMFaJldkOTVGncG7KrIBfPk9sJxDUO9OFmgBo9iswNwAljU6OyR3K8ZFuGdhuqnv2VfbnFMQ
 4tZ2gh48CthckXitsoccJxk6OH2RxjrDYM7STIMbr/ZLFa7H
X-Received: by 2002:a05:7022:68f:b0:169:3706:d61b with SMTP id
 a92af1059eb24-1ac5bbba040mr39986535c88.16.1793905447520; 
 Thu, 05 Nov 2026 11:04:07 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm22924284c88.15.2026.11.05.11.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:04:06 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH 4/5] qom: filter type lookup with TypeBucket
Date: Fri,  6 Nov 2026 03:03:45 +0800
Message-ID: <20261105190346.1539-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105190346.1539-1-luoyonggang@gmail.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

type_table maps each name to a TypeBucket of TypeImpl variants and
the union of their target masks. Registration aborts when the new
mask overlaps a variant already in the bucket, so same-name types
for disjoint targets can coexist.

Bare-name lookup, class enumeration, and parent, interface, and
dynamic cast resolution walk that bucket. Enumeration and bare-name
lookup keep a variant when target_mask_filter() of its mask is
non-empty. With no target selected, bare-name lookup returns the
variant only when the bucket holds one.

type_list_lookup() returns those variants. need == 0 does not
require any architecture bits. Any other need keeps the variant
whose mask contains every bit of need, which is at most one.
type_lookup_current() passes 0 and returns that variant only when
one remains. type_table_lookup() passes the class mask for parent,
interface, and dynamic cast resolution.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 qom/object.c | 107 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 22 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index c224263112..265cf19041 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -19,6 +19,7 @@
 #include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
 #include "qemu/memalign.h"
+#include "qemu/queue.h"
 #include "qapi/visitor.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
@@ -74,6 +75,7 @@ struct TypeImpl
     bool secure;
 
     uint64_t targets;
+    QSLIST_ENTRY(TypeImpl) next;
 
     const char *parent;
     TypeImpl *parent_type;
@@ -84,6 +86,11 @@ struct TypeImpl
     InterfaceImpl interfaces[MAX_INTERFACES];
 };
 
+typedef struct TypeBucket {
+    uint64_t targets;
+    QSLIST_HEAD(, TypeImpl) variants;
+} TypeBucket;
+
 static Type type_interface;
 
 static GHashTable *type_table;
@@ -113,15 +120,56 @@ static uint64_t target_mask_filter(uint64_t mask)
     return mask & target_mask_selected();
 }
 
-static void type_table_add(TypeImpl *ti)
+static void type_table_add(TypeBucket *bucket, TypeImpl *ti)
 {
     assert(!enumerating_types);
-    g_hash_table_insert(type_table, (void *)ti->name, ti);
+    if (!bucket) {
+        bucket = g_new0(TypeBucket, 1);
+        g_hash_table_insert(type_table, (void *)ti->name, bucket);
+    }
+    bucket->targets |= ti->targets;
+    QSLIST_INSERT_HEAD(&bucket->variants, ti, next);
+}
+
+static GSList *type_list_lookup(const char *name, uint64_t need)
+{
+    TypeBucket *bucket;
+    TypeImpl *ti;
+    GSList *list = NULL;
+
+    if (!name) {
+        return NULL;
+    }
+    bucket = g_hash_table_lookup(type_table, name);
+    if (!bucket) {
+        return NULL;
+    }
+    QSLIST_FOREACH(ti, &bucket->variants, next) {
+        if (!target_mask_filter(ti->targets)) {
+            continue;
+        }
+        /* need == 0 keeps all variants; any other need matches at most one mask. */
+        if ((ti->targets & need) != need) {
+            continue;
+        }
+        list = g_slist_append(list, ti);
+    }
+    return list;
+}
+
+static TypeImpl *type_table_lookup(const char *name, uint64_t need)
+{
+    g_autoptr(GSList) list;
+
+    g_assert(need != 0);
+    list = type_list_lookup(name, need);
+    return list ? list->data : NULL;
 }
 
-static TypeImpl *type_table_lookup(const char *name)
+static TypeImpl *type_lookup_current(const char *name)
 {
-    return g_hash_table_lookup(type_table, name);
+    g_autoptr(GSList) list = type_list_lookup(name, 0);
+    return g_slist_length(list) == 1 ? list->data : NULL;
 }
 
 static TypeImpl *type_new(const TypeInfo *info, uint64_t targets)
@@ -131,11 +179,6 @@ static TypeImpl *type_new(const TypeInfo *info, uint64_t targets)
 
     g_assert(info->name != NULL);
 
-    if (type_table_lookup(info->name) != NULL) {
-        fprintf(stderr, "Registering `%s' which already exists\n", info->name);
-        abort();
-    }
-
     ti->name = g_strdup(info->name);
     ti->parent = g_strdup(info->parent);
 
@@ -188,6 +231,7 @@ static bool type_name_is_valid(const char *name)
 
 static TypeImpl *type_register_internal(const TypeInfo *info, uint64_t targets)
 {
+    TypeBucket *bucket;
     TypeImpl *ti;
 
     if (!type_name_is_valid(info->name)) {
@@ -212,9 +256,15 @@ static TypeImpl *type_register_internal(const TypeInfo *info, uint64_t targets)
         return NULL;
     }
 
+    bucket = g_hash_table_lookup(type_table, info->name);
+    if (bucket && (bucket->targets & targets)) {
+        fprintf(stderr, "Registering '%s' which already exists\n", info->name);
+        abort();
+    }
+
     ti = type_new(info, targets);
 
-    type_table_add(ti);
+    type_table_add(bucket, ti);
     return ti;
 }
 
@@ -233,24 +283,24 @@ void type_register_static_array(const TypeInfo *infos, int nr_infos)
     }
 }
 
-static TypeImpl *type_get_by_name_noload(const char *name)
+static TypeImpl *type_get_by_name_noload(const char *name, uint64_t need)
 {
     if (name == NULL) {
         return NULL;
     }
 
-    return type_table_lookup(name);
+    return type_table_lookup(name, need);
 }
 
 static TypeImpl *type_get_or_load_by_name(const char *name, Error **errp)
 {
-    TypeImpl *type = type_get_by_name_noload(name);
+    TypeImpl *type = type_lookup_current(name);
 
 #ifdef CONFIG_MODULES
     if (!type) {
         int rv = module_load_qom(name, errp);
         if (rv > 0) {
-            type = type_get_by_name_noload(name);
+            type = type_lookup_current(name);
         } else {
             error_prepend(errp, "could not load a module for type '%s'", name);
             return NULL;
@@ -267,7 +317,7 @@ static TypeImpl *type_get_or_load_by_name(const char *name, Error **errp)
 static TypeImpl *type_get_parent(TypeImpl *type)
 {
     if (!type->parent_type && type->parent) {
-        type->parent_type = type_get_by_name_noload(type->parent);
+        type->parent_type = type_get_by_name_noload(type->parent, type->targets);
         if (!type->parent_type) {
             fprintf(stderr, "Type '%s' is missing its parent '%s'\n",
                     type->name, type->parent);
@@ -422,7 +472,7 @@ static void type_initialize(TypeImpl *ti)
         }
 
         for (i = 0; i < ti->num_interfaces; i++) {
-            TypeImpl *t = type_get_by_name_noload(ti->interfaces[i].typename);
+            TypeImpl *t = type_get_by_name_noload(ti->interfaces[i].typename, ti->targets);
             if (!t) {
                 error_report("missing interface '%s' for object '%s'",
                              ti->interfaces[i].typename, parent->name);
@@ -1097,7 +1147,7 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
         return class;
     }
 
-    target_type = type_get_by_name_noload(typename);
+    target_type = type_get_by_name_noload(typename, type->targets);
     if (!target_type) {
         /* target class type unknown, so fail the cast */
         return NULL;
@@ -1201,7 +1251,7 @@ const char *object_class_get_name(ObjectClass *klass)
 
 ObjectClass *object_class_by_name(const char *typename)
 {
-    TypeImpl *type = type_get_by_name_noload(typename);
+    TypeImpl *type = type_lookup_current(typename);
 
     if (!type) {
         return NULL;
@@ -1246,13 +1296,14 @@ typedef struct OCFData
     void *opaque;
 } OCFData;
 
-static void object_class_foreach_tramp(gpointer key, gpointer value,
-                                       gpointer opaque)
+static void object_class_foreach_type(TypeImpl *type, OCFData *data)
 {
-    OCFData *data = opaque;
-    TypeImpl *type = value;
     ObjectClass *k;
 
+    if (!target_mask_filter(type->targets)) {
+        return;
+    }
+
     type_initialize(type);
     k = type->class;
 
@@ -1268,6 +1319,18 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
     data->fn(k, data->opaque);
 }
 
+static void object_class_foreach_tramp(gpointer key, gpointer value,
+                                       gpointer opaque)
+{
+    OCFData *data = opaque;
+    TypeBucket *bucket = value;
+    TypeImpl *type;
+
+    QSLIST_FOREACH(type, &bucket->variants, next) {
+        object_class_foreach_type(type, data);
+    }
+}
+
 void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
                           const char *implements_type, bool include_abstract,
                           void *opaque)
-- 
2.55.0.windows.3


