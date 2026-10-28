Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDD606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTyvbUG4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzvd-0006t8-63; Wed, 28 Oct 2026 05:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvW-0006rw-R0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvU-0006ev-Mo
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso5893165ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179591; x=1793784391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Krd7grsLTJX6cCkk0wUoy4Fk0r9YaYiEi+tyS6I7OD0=;
 b=jTyvbUG4Gf1gWsiMNfartB7z+0tBvKwfqy4pMwq1zXF/uhsdhCJtxg7VgD3/53S4Ol
 EJsHJwvguWvsLTRNrX4mrySn85V5X3uTtTgLjloyOkWDk0AntoxEqzSIrmc0tL57APIP
 O7pYmjsdhKF0vo8QeOCLJpNiMad5zU3jOn7PeekEqb5BTOvfv406b8Cj24L2icZlMlIh
 gx876nmjDjnqsu4aoQ+JUoycSeRK0mlGk6rzFGtIIZBmxoR6+cczFmk8x2v0H8C8Ld/p
 SUX6v8E6ibNOoakbrt5Y1ei6UNSKaGsHFHH4jGlm3hhn9esu5YFh86aC2Z3EqU7P1pwf
 q/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179591; x=1793784391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Krd7grsLTJX6cCkk0wUoy4Fk0r9YaYiEi+tyS6I7OD0=;
 b=QMtrGJba7BhZRkjwQ3UEaA6dZFxvYIEQNx1iFKg7lsK3+fELsXypHD2pTSPKKnQD0+
 CFG5gUbPi854VIQ2Cvys66tVTDQnypuDAiAZ8u2VnQLoCGuR/L6hD9n1kEz7SwO61Wt3
 BGcfJ3uapD1Hc3pRob2/sgEbd6V0ip8h5VfylXg1C6zSMWX16C5zjNHveZhreALLutgn
 Q9s9e2DBPV4y80GplVjnDt6j6itpVZHqZWEf+M+VWyOWPAL6/+zSj04sOi8OyJaf2kAA
 tE5pfWFtAXFlFC4RM5idGqyXzh4DYWbL4mTYUaQ353vs8apFI5/nBAzfVgGVBMcEEXfu
 kAXg==
X-Gm-Message-State: AFq9FYITiDNpq11Wfi5FLcwEcrXIH7UxHuvoUKfVE+MWpwJzpTFRujfK
 mM3OI2cM4wMUjkAAFqJ9atNRosnBipMdZ8X2iv2GxCjaa3JJ0Sj05SSvWqHyScmB
X-Gm-Gg: AYBFou33bHFkDk8Gx1SMFtNJWSn1KsTb9Bx2s3LzLnBZ5tBsW2pThkuK7hNpOQ4gGDj
 oGkh7ZLrvPTRExH/G14NZEOo/eQ60HbOLzKTb2+SQZjtBlwhSlkCPE5lPJBDNQ0QxCTj+QVX2uc
 C9Pu1FbrDWJ3YeGgm6SFNe5OLROdIUCP4SWgUnXU6Qh7md4T/Ok8Tqj3EdBA41wG8Xs+wq9WPJV
 HMNyrb2oBgpRBA21eU/QcQIdvyTk/kKJB7WObzKWvXID9PVJoZzhHG8SNAW6WRuovsaQlRq1DJH
 fHhypY/0jS75OathNVcLyTFRaLiFDQ5arMQ00042EH4BqJWmayT6AMLCnzE0Go7Iwf8b4iWVAUT
 751opVWjmOOs4LZhKxGK/cunYCZpkvYALtt8gYi5gpPyF+1nbhX/wvyfznLcmpCOcg78tQCh0qW
 NpNS12ltKIWDNhD6kyGRbRMo1WpaqOLfpFajIIvpnF3OqOgeQAGKiqRv6BUQHiN/hsJlwPG5/KL
 8xsLgeiIq03/i7RckdhjKt/7QPkfZeuU/hOC3GPL/bWhoKH6DfBKc5Fvbv8+zYMOR4O8gH+0Q4c
 EOLtSab/VUkGU3b3aCKdBZD37sOnWJSQUIw7Bc+9EEyhZaDRMbLyOW6wqf0=
X-Received: by 2002:a17:903:3708:b0:2e9:3c24:999 with SMTP id
 d9443c01a7336-2eb0058e067mr18345325ad.40.1793179591006; 
 Wed, 28 Oct 2026 02:26:31 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:26:30 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 01/14] iothread: introduce holder tracking
Date: Wed, 28 Oct 2026 17:26:06 +0800
Message-ID: <20261028092619.1654474-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x636.google.com
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

IOThreads do not record the QOM objects and block exports that use
them, making runtime introspection and hotplug debugging difficult.

Add:

- holders: a list describing what is holding an iothread
- iothread_ref(): add a holder to the list
- iothread_unref(): remove a holder from the list

A holder can identify either a QOM object or a block export. A later
patch will expose this information through query-iothreads.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  5 +++
 iothread.c                | 63 ++++++++++++++++++++++++++
 qapi/misc.json            | 94 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 150 insertions(+), 12 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index a1ef7696cb..b8aeb32b0e 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -18,6 +18,7 @@
 #include "qemu/thread.h"
 #include "qom/object.h"
 #include "system/event-loop-base.h"
+#include "qapi/qapi-types-misc.h"
 
 #define TYPE_IOTHREAD "iothread"
 
@@ -50,6 +51,7 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    IOThreadHolderList *holders;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
@@ -82,4 +84,7 @@ void iothread_destroy(IOThread *iothread);
  */
 bool qemu_in_iothread(void);
 
+void iothread_ref(IOThread *iothread, const IOThreadHolder *holder);
+void iothread_unref(IOThread *iothread, const IOThreadHolder *holder);
+
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index 76eea6df38..6b0a7c557a 100644
--- a/iothread.c
+++ b/iothread.c
@@ -21,10 +21,71 @@
 #include "system/iothread.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
 
+/* Add a deep copy of @holder to @iothread's list of holders. */
+void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    assert(holder);
+
+    QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
+}
+
+static int iothread_holder_compare(const IOThreadHolder *holder_a,
+                                   const IOThreadHolder *holder_b)
+{
+    const char *name_a, *name_b;
+
+    if (holder_a->type != holder_b->type) {
+        return holder_a->type - holder_b->type;
+    }
+
+    switch (holder_a->type) {
+    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+        name_a = holder_a->u.qom_object.qom_path;
+        name_b = holder_b->u.qom_object.qom_path;
+        break;
+    case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+        name_a = holder_a->u.block_export.export_id;
+        name_b = holder_b->u.block_export.export_id;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return strcmp(name_a, name_b);
+}
+
+/*
+ * Remove @holder from @iothread's list of holders.
+ *
+ * It is a programming error if @holder is not present.
+ */
+void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    IOThreadHolderList **prev = &iothread->holders;
+    IOThreadHolderList *curr;
+
+    assert(holder);
+
+    while (*prev) {
+        curr = *prev;
+        if (iothread_holder_compare(curr->value, holder) == 0) {
+            *prev = curr->next;
+            curr->next = NULL;
+            qapi_free_IOThreadHolderList(curr);
+            return;
+        }
+        prev = &curr->next;
+    }
+
+    g_assert_not_reached();
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -129,6 +190,7 @@ static void iothread_instance_finalize(Object *obj)
         iothread->main_loop = NULL;
     }
     qemu_sem_destroy(&iothread->init_done_sem);
+    qapi_free_IOThreadHolderList(iothread->holders);
 }
 
 static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
@@ -373,6 +435,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = QAPI_CLONE(IOThreadHolderList, iothread->holders);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/qapi/misc.json b/qapi/misc.json
index 4469e44d05..4a3eff4685 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -64,6 +64,55 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
+##
+# @IOThreadHolderBlockExport:
+#
+# @export-id: The unique block export identifier.
+#
+# Since: 11.2
+#
+##
+{ 'struct': 'IOThreadHolderBlockExport',
+  'data': { 'export-id': 'str' } }
+
+##
+# @IOThreadHolderQomObject:
+#
+# @qom-path: Path to the object in the QOM tree.
+#
+# Since: 11.2
+#
+##
+{ 'struct': 'IOThreadHolderQomObject',
+  'data': { 'qom-path': 'str' } }
+
+##
+# @IOThreadHolderKind:
+#
+# @block-export: A block export.
+# @qom-object: A QOM object.
+#
+# Since: 11.2
+##
+{ 'enum': 'IOThreadHolderKind',
+  'data': [ 'block-export', 'qom-object' ] }
+
+##
+# @IOThreadHolder:
+#
+# The block export or QOM object holding the iothread.
+#
+# @type: the kind of iothread holder.
+#
+# Since: 11.2
+##
+{ 'union': 'IOThreadHolder',
+  'base': { 'type': 'IOThreadHolderKind' },
+  'discriminator': 'type',
+  'data': {
+    'block-export': 'IOThreadHolderBlockExport',
+    'qom-object': 'IOThreadHolderQomObject' } }
+
 ##
 # @IOThreadInfo:
 #     Information about an iothread
@@ -72,6 +121,10 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: the QOM objects or block exports currently holding this
+#     iothread.  When a holder is detached or destroyed, it is removed
+#     from this list.  (Since 11.2)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -94,6 +147,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IOThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -117,20 +171,36 @@
 #     -> { "execute": "query-iothreads" }
 #     <- { "return": [
 #              {
-#                 "id":"iothread0",
-#                 "thread-id":3134,
-#                 "poll-max-ns":32768,
-#                 "poll-grow":0,
-#                 "poll-shrink":0,
-#                 "aio-max-batch":0
+#                 "id": "iothread0",
+#                 "thread-id": 3134,
+#                 "holders": [
+#                     {
+#                         "qom-path": "/machine/peripheral/blk1/virtio-backend",
+#                         "type": "qom-object"
+#                     },
+#                     {
+#                         "qom-path": "/machine/peripheral/blk2/virtio-backend",
+#                         "type": "qom-object"
+#                     }
+#                 ],
+#                 "poll-max-ns": 32768,
+#                 "poll-grow": 0,
+#                 "poll-shrink": 0,
+#                 "aio-max-batch": 0
 #              },
 #              {
-#                 "id":"iothread1",
-#                 "thread-id":3135,
-#                 "poll-max-ns":32768,
-#                 "poll-grow":0,
-#                 "poll-shrink":0,
-#                 "aio-max-batch":0
+#                 "id": "iothread1",
+#                 "thread-id": 3135,
+#                 "holders": [
+#                     {
+#                         "export-id": "export0",
+#                         "type": "block-export"
+#                     }
+#                 ],
+#                 "poll-max-ns": 32768,
+#                 "poll-grow": 0,
+#                 "poll-shrink": 0,
+#                 "aio-max-batch": 0
 #              }
 #           ]
 #        }
-- 
2.53.0


