Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F56C5DF9A
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtM0-0003dj-Kb; Sat, 22 Aug 2026 17:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtLz-0003dH-73
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtLx-0000fO-92
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso13008715ad.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434452; x=1788039252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P21I7BlC9KiDPWorOkMHQQSb9zd3quXLdeYsYZUoeoU=;
 b=n/3PYQM/S3jBCTltDhErD9Nt5dWyxGXUuqY6eZcqIx3yU5auhlpe+BdoLVv/tZA1RO
 dBpbMS7OZm20wD2yYGyNxFCaGfBirqEQx44Y6uY9j+8S637IDHJtAFNxmN+JgX22b6Lr
 Itk9CoQbQyWMzdpMGFnLMKGfoJBU1IGZm8iKOb7f/1Qsqc/pKm+Uy8HYGqR/YRjEOMy1
 wqfbfcxLGxQcYxvHi/1yRzl38kmmHyVrJCwfDUbz1s5g4euwiXYow9UGqgCKM3V9ep2Z
 /m2eRA3QjpiNr/umkqqGptu+KMldyyoRNB44Gv3bnh1+p1r0t2UK2+sBbF5nPQh8cOw6
 wTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434452; x=1788039252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P21I7BlC9KiDPWorOkMHQQSb9zd3quXLdeYsYZUoeoU=;
 b=cT5l3Jqo/JqjAZ9XNpdydfM6hXrDdD9IZljAM5bhGwxzbITRCn6xQ6pypELrXFnO6Q
 5EilSMHk82x+hmu8GleNBNT8/HOOjRmu7e5TTGShEByNbWJIYKMJEAf4G05Khobhhr8j
 ftPB2E/C4oic1gdDbSPRG/9de12DO4UtGslwEG1BhVCj5LpGHNih5/b0vjstdu4rcoDf
 syzkOwVET5/gP/sT/PdlA6I6jff2uf1yCWFRBlM9qg2F6nt9dR+HiybX1luAcLgrdz2B
 4/LxrfFiphF2o3PeRLcz9AEVLfgf63GiYTFRrTGnuwzpsadDjGv6iYnXKtd/nhQ/D3AV
 V5Cg==
X-Gm-Message-State: AFuF++k64Cu1vIFlhN+4ocaPi0rheq2IadZqxjdIZsJ2flDbcZbHf1oM
 Cj7WavSu1BvGVmSP3oIoCpSLMcuqlP46uzg+CW8TeV4DKrbg3jNsj8j6kOQ4OwFrvOFdgqIW
X-Gm-Gg: AR+sD11ASBPUraWr4TvMzXwsMXY4OpS7lmBQVjGtC/TVj2BEuGCtnqJQtznuedH+HI+
 YgspZZMNMiv8ZURT4/QSf834M1FKju5msB78m2zurlg/DnGK7ZIXwxpSCDCrePVfKy/AMIDbVrs
 ze7OHmpe1O0rO4gtL/eKQi6sP6vt/b7c7b747hBtoPzolcDSKKJYX/Wz/HovK4e0GjGFRasZb+A
 pAM2igteaj7nK5y7ZqtLzFvV5lUnA9HXve/r/fgo4vu3wCo+crCrUvKLRHCGTe2cg2KQZAAQoc8
 bCnMEoAAdWf1PEOG03zynp9qcXnptAHA5/XnSZ5XdOYMl5TMwnDPdfwNx5VUR/OEhOHIiIZqi1g
 1s5VRb8KcEPMLafE07P2DI8eUUbGoWuNmXk5uDretqlSSPuqrFeS7i9Mhsd9rloXb9JgR+yi0QZ
 HreSD0nOzc1ByHENi3lXYtzb70K7BpFoNlTVr+LsJDI+1tN0lrX5q+Ywha/V9nbDyaeG3Cuafhr
 StuJoC3
X-Received: by 2002:a17:902:ebc3:b0:2ca:1479:d9dc with SMTP id
 d9443c01a7336-2d64b0427fdmr307893565ad.12.1787434451746; 
 Sat, 22 Aug 2026 14:34:11 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:11 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 02/15] iothread: introduce holder tracking
Date: Sun, 23 Aug 2026 05:33:25 +0800
Message-ID: <20260822213343.661939-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

IOThreads do not record the QOM objects and block exports that use
them, making runtime introspection and hotplug debugging difficult.

Add:

- holders: a list describing what is holding an iothread
- iothread_ref(): add a holder to the list
- iothread_unref(): remove a holder from the list

A holder can identify either a QOM object or a block export. A later
patch will expose this information through query-iothreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
index 3558535b40..66dfde626e 100644
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
index c71a5fe657..eb3b89293d 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -67,6 +67,55 @@
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
 #
@@ -76,6 +125,10 @@
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
@@ -98,6 +151,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IOThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -122,20 +176,36 @@
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
2.55.0


