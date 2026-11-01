Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74114606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=wFTva6z1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWML-0002YY-2a; Sun, 01 Nov 2026 09:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNWMJ-0002Y0-GI
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:16:31 -0500
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <holypumpkin@foxmail.com>)
 id 1xNWMF-0006zw-PV
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1793542580;
 bh=7G9+9wQmr5T1Iwb3fmEZ5Ag0CKBbvSVK8Gf9nECjtTs=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=wFTva6z11Ip14BETx2l3TUzaDFWzv2bFBSYRzBSJxbHR3h/jYwB0JaMsl9a9GMLek
 NrcGEMVqmJOGZ1hPtK2EFP8fLUzyjqI0m8ca0VQ2TCxXhWoDcG1KQdxvPGxZSUgDwh
 ZUdw4eCQpqnnYWOBRQ4lXQNgv5jQIzO6h3ZbD5sY=
Received: from localhost.localdomain ([113.200.174.63])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 3F3BBA98; Sun, 01 Nov 2026 22:15:51 +0800
X-QQ-mid: xmsmtpt1793542577tnmlh198h
Message-ID: <tencent_8B0A452E398A9BB5FD5BD51A4F87190EB407@qq.com>
X-QQ-XMAILINFO: ObqHjTnQtDvTELuQh3XUq9efcoSmjX8ZvAInsXqK+2uL6+yuoQzf1YSUS5OWYE
 LaapLTrMT5MxhLDNHJoSPyGNqZbSvXaVAKA4xZNHrX4gUZZGevfSJwwI4CJ5pHDH+PdBT1nloFqT
 RcykHK/VbnsLt9Q3pOW2G4Xe0AbTKlVafxsy+1gWx3K5sxw8kz2cd/audbjZY4gMquzUPvnOFWrH
 oTdylCc4+xmGmOphM0tmpjNpm+nrx8OKlE5cRq1BLMeu5HQHXYB4lTCD6wQtGBNAlpAnJeVxl9aX
 /pc4Rv7QUJT7Ss66Xfu1JxYe6+5NMdhdnM70AeF/VseLFJ8VHZP/UaAPjUtmrrTdTa6uJsyVu/Qf
 0YObpyYwLigIBHhSBV1pGUJe/cdFn0gD3oPlNccReAaNLPIrzztIKYk6hbpMGtusx8jKYC7n9Rxm
 d0z4XMZz9j4NNZgEaTQIX3IgFPZ0n9hhFukW9gZjCp1Iy6jCtfse6S6NYnTl2ss/hRoje7m3Tiv5
 v9MOCZKKJ+VEJ8+GE7noZI+KaegfuTHmuLSrpzsVhz1W0pBD9mNUYfqWR7pDSEN1NBLcENSI9wzY
 HyeiiR6nteMeFM7w9QL1nf5+VWxDvcDQMiRy13qpLyRLJClcQTQKDD+6yx0cTU/c44Zxg5IhiIgH
 TrGsuChtFXKYfzz8w7oul2fdnM0jpIIbjY6cBJZqW1x+lxwOcvMaFrt+nJ3+mX1GmgBVUk6TDH8t
 BMkycECdGQhOtO5garJU+ffCQ52BSh+EyLJEzHzgkaIDzp7XxiGZPIIqHbUnLG01aanLeDhOY0C8
 iyGi4MDuK51RSoG7XiHQuMwzhHkc4hd78JVIznCaT0Pw3W8Aoduwv7CJ/xEjc9shXJdjc+BPq/2u
 TRoyxqBeWpfX+ebUD9d9jarzPS7EGqq82u2UJObKw3oR95po0Y7GDe41L4yW46WBx9KSfeWq6qce
 h0b9rKV4914hdrLNWdzaWvlyohYHQzB1/4e8wzyUS4CDAg2VUjFJBN6pMr3DZuhYUkXClbNgxPiF
 F3yXEEG7JlhdvyyonG0wRzP/tThOmFNU3heekKiu3c8091XV6S6YitNv64bzI6U4sdUmFCkVydnl
 XvwqDqnIEMVrXBs4ATW2DlvX6+TUcLdMjb7qPlwMILZePbzhaAOM28k2sOJXq3JEqDSP0WrPAxiM
 HTeFSBKmN27ryCtQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Haoyu Nan <Holypumpkin@foxmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] qom: filter unrelated classes before initializing them
Date: Sun,  1 Nov 2026 22:15:39 +0800
X-OQ-MSGID: <20261101141540.2021-2-Holypumpkin@foxmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20261101141540.2021-1-Holypumpkin@foxmail.com>
References: <20261101141540.2021-1-Holypumpkin@foxmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.58.211;
 envelope-from=holypumpkin@foxmail.com; helo=out162-62-58-211.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

object_class_foreach() initializes every registered class before
applying its implements_type filter. A query for one ordinary class
hierarchy can therefore initialize classes that cannot match it.

Resolve an already registered filter type without loading modules.
For a non-interface filter, use TypeImpl ancestry to reject unrelated
types before invoking type_initialize(). Keep the existing abstract
class check and dynamic cast for the remaining candidates.

Interface filters retain the original initialization and cast path,
including inherited interfaces and ambiguous casts. Unknown filters
and unfiltered enumeration also retain their existing behavior. No
registered type is removed, and later registrations are considered
by subsequent walks of the type table.

This defers unrelated class initialization rather than changing the
set of classes returned by a filtered enumeration. Add a unit test
covering initialization counts, abstract classes, interface matching,
late registration and subsequent direct instantiation.
---
 qom/object.c                       |  17 +++-
 tests/unit/check-qom-enumeration.c | 138 +++++++++++++++++++++++++++++
 tests/unit/meson.build             |   1 +
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/check-qom-enumeration.c

diff --git a/qom/object.c b/qom/object.c
index 96498f3d00..abb3c6d23f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1203,6 +1203,7 @@ typedef struct OCFData
     const char *implements_type;
     bool include_abstract;
     void *opaque;
+    TypeImpl *class_filter;
 } OCFData;
 
 static void object_class_foreach_tramp(gpointer key, gpointer value,
@@ -1212,6 +1213,11 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
     TypeImpl *type = value;
     ObjectClass *k;
 
+    /* Class ancestry is available before class initialization. */
+    if (data->class_filter && !type_is_ancestor(type, data->class_filter)) {
+        return;
+    }
+
     type_initialize(type);
     k = type->class;
 
@@ -1231,7 +1237,16 @@ void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
                           const char *implements_type, bool include_abstract,
                           void *opaque)
 {
-    OCFData data = { fn, implements_type, include_abstract, opaque };
+    TypeImpl *filter = type_get_by_name_noload(implements_type);
+    OCFData data = {
+        .fn = fn,
+        .implements_type = implements_type,
+        .include_abstract = include_abstract,
+        .opaque = opaque,
+        /* Interface casts still require initialization and ambiguity checks. */
+        .class_filter = filter && !type_is_ancestor(filter, type_interface)
+                        ? filter : NULL,
+    };
 
     enumerating_types = true;
     g_hash_table_foreach(type_table, object_class_foreach_tramp, &data);
diff --git a/tests/unit/check-qom-enumeration.c b/tests/unit/check-qom-enumeration.c
new file mode 100644
index 0000000000..0482a1c4a7
--- /dev/null
+++ b/tests/unit/check-qom-enumeration.c
@@ -0,0 +1,138 @@
+/*
+ * Check filtered QOM enumeration and deferred class initialization.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "qemu/module.h"
+
+static unsigned initialized[4];
+
+static void count_init(ObjectClass *klass, const void *opaque)
+{
+    unsigned index = GPOINTER_TO_UINT(opaque);
+
+    initialized[index]++;
+}
+
+static const TypeInfo types[] = {
+    {
+        .name = "enum-base", .parent = TYPE_OBJECT, .abstract = true,
+        .class_init = count_init, .class_data = GUINT_TO_POINTER(0),
+    }, {
+        .name = "enum-child", .parent = "enum-base",
+        .class_init = count_init, .class_data = GUINT_TO_POINTER(1),
+    }, {
+        .name = "enum-grandchild", .parent = "enum-child",
+    }, {
+        .name = "enum-unrelated", .parent = TYPE_OBJECT,
+        .class_init = count_init, .class_data = GUINT_TO_POINTER(2),
+    }, {
+        /* Zero instance size makes this interface abstract. */
+        .name = "enum-if", .parent = TYPE_INTERFACE,
+        .class_size = sizeof(InterfaceClass),
+        .class_init = count_init, .class_data = GUINT_TO_POINTER(3),
+    }, {
+        .name = "enum-if-a", .parent = "enum-if",
+    }, {
+        .name = "enum-if-b", .parent = "enum-if",
+    }, {
+        .name = "enum-impl", .parent = "enum-child",
+        .interfaces = (InterfaceInfo[]) { { "enum-if-a" }, { } },
+    }, {
+        .name = "enum-impl-child", .parent = "enum-impl",
+    }, {
+        .name = "enum-ambiguous", .parent = TYPE_OBJECT,
+        .interfaces = (InterfaceInfo[]) {
+            { "enum-if-a" }, { "enum-if-b" }, { }
+        },
+    },
+};
+
+static bool has_class(GSList *list, const char *name)
+{
+    for (; list; list = list->next) {
+        if (!strcmp(object_class_get_name(list->data), name)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void enumeration_test(void)
+{
+    GSList *list;
+    static const TypeInfo late = {
+        .name = "enum-late", .parent = "enum-child",
+    };
+
+    /* Run before looking up or instantiating any of the test classes. */
+    list = object_class_get_list("enum-base", false);
+    g_assert_cmpuint(g_slist_length(list), ==, 4);
+    g_assert_false(has_class(list, "enum-base"));
+    g_assert_true(has_class(list, "enum-child"));
+    g_assert_true(has_class(list, "enum-grandchild"));
+    g_assert_true(has_class(list, "enum-impl"));
+    g_assert_true(has_class(list, "enum-impl-child"));
+    g_assert_cmpuint(initialized[0], ==, 1);
+    g_assert_cmpuint(initialized[1], ==, 1);
+    g_assert_cmpuint(initialized[2], ==, 0);
+    g_assert_cmpuint(initialized[3], ==, 1);
+    g_slist_free(list);
+
+    list = object_class_get_list("enum-base", true);
+    g_assert_cmpuint(g_slist_length(list), ==, 5);
+    g_assert_true(has_class(list, "enum-base"));
+    g_assert_cmpuint(initialized[2], ==, 0);
+    g_slist_free(list);
+
+    list = object_class_get_list("enum-if", false);
+    g_assert_cmpuint(g_slist_length(list), ==, 2);
+    g_assert_true(has_class(list, "enum-impl"));
+    g_assert_true(has_class(list, "enum-impl-child"));
+    g_assert_false(has_class(list, "enum-ambiguous"));
+    g_assert_false(has_class(list, "enum-if"));
+    g_assert_cmpuint(initialized[2], ==, 1);
+    g_slist_free(list);
+
+    list = object_class_get_list("enum-if", true);
+    g_assert_cmpuint(g_slist_length(list), ==, 5);
+    g_assert_true(has_class(list, "enum-if"));
+    g_assert_true(has_class(list, "enum-if-a"));
+    g_assert_true(has_class(list, "enum-if-b"));
+    g_slist_free(list);
+
+    list = object_class_get_list("enum-no-such-type", true);
+    g_assert_null(list);
+    list = object_class_get_list(NULL, true);
+    for (unsigned i = 0; i < G_N_ELEMENTS(types); i++) {
+        g_assert_true(has_class(list, types[i].name));
+    }
+    for (unsigned i = 0; i < G_N_ELEMENTS(initialized); i++) {
+        g_assert_cmpuint(initialized[i], ==, 1);
+    }
+    g_slist_free(list);
+
+    type_register_static(&late);
+    list = object_class_get_list("enum-base", false);
+    g_assert_cmpuint(g_slist_length(list), ==, 5);
+    g_assert_true(has_class(list, "enum-late"));
+    g_slist_free(list);
+    Object *obj = object_new("enum-unrelated");
+
+    g_assert_nonnull(obj);
+    object_unref(obj);
+    obj = object_new("enum-late");
+    g_assert_nonnull(object_dynamic_cast(obj, "enum-base"));
+    object_unref(obj);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    module_call_init(MODULE_INIT_QOM);
+    type_register_static_array(types, G_N_ELEMENTS(types));
+    g_test_add_func("/qom/enumeration/lazy-and-compatible", enumeration_test);
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 37b561d4a7..b8c4dfd753 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -42,6 +42,7 @@ tests = {
   'test-bitcnt': [],
   'test-qgraph': ['../qtest/libqos/qgraph.c'],
   'check-qom-interface': [qom],
+  'check-qom-enumeration': [qom],
   'check-qom-proplist': [qom],
   'test-qemu-opts': [],
   'test-keyval': [testqapi],
-- 
2.47.0.windows.1


