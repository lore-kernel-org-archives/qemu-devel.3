Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA61F459ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQF-0006ad-7j; Fri, 10 Apr 2026 11:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQ8-0006Rr-7v
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:20 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQ6-00022W-Dy
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:19 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so1549744a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833516; x=1776438316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbuB4mhESeHjR1sC4osJPiNIB/gMNHKxCFvIHqQzq6k=;
 b=jqNpYybiH6sQEYeJOcR7uPoVureRgkhNyZU/t9ZQ/+GpnTWJthtkV113zVCrsEfntR
 9NcRSxd/+4aUjwaqK2KVmvOuHcXJgeQZ40TGsu0fmoKqa94KoEiY9m0FBu48xHGbKOVa
 xahZLxSgAGj3XEun6xY70IapwjDN/9agABqHnl5bwPXvt2y4GW7t4tYroctqRMxLvleP
 XpBuJ1zTL6CaTNuxSgQMdXmAD1/t7DioBefJ0zq5N0UTrQRBhWgpKJrkpgL8/zf3advt
 yT+pkdc0Gvawx9Bptk8KJG46hoAE4jInCNJWd5f8H8xjXY/HbP6TWq3NIFRWyZZluscX
 sLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833516; x=1776438316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zbuB4mhESeHjR1sC4osJPiNIB/gMNHKxCFvIHqQzq6k=;
 b=goKJOIQu8/ZW61hlMfUuCKUuHZ90Wp/8vXzjojv7gkKBumPt4KcAZfvzgwf6Frqksm
 1Z6JopVw0Fm/qU5hDlDgoC5+pQSqh20AoiGF6g6mFlc9eroDbEIObtdh9wBgKW8PnrDe
 kDPSCo727ySgXFlDU04YFwQLv48pv8ZJ+GBs2fnCCgTULq2jrX0028UAhlV9+La+60dl
 TzeAKR01tA/slUwwbwgvMruOwp2YjROlwoQ9RbLN88tKhFJ3HYlXsOruRKw3eNe9K/KL
 BJ5QG0itBGJVX8qmg2kfGjPJD3+tr9lO1mGf7LXcf3IAkANQUXXdXUrjUnjXCoSyiK9N
 TfNQ==
X-Gm-Message-State: AOJu0YydJYe0x8xdHGTISpETKxVR4hSQOdPV6bxE4eaq3p3XaIki04jC
 9D1ikfm6mgyZDA7aYSs664MH8BY7n+3pKvBRLqwi1TjniC/GdXGFz3NgQslLhSuS
X-Gm-Gg: AeBDiet4bEhd7XI6h2hfjywPnUsa/o0vpTDb6A9X2cofmeND7QL7ug+XcCZLtQ5jMxc
 VB1KxlkByXjzgQfs6s+uJTI8KzQu8eCmCbbmExYrjeCoAz5AU+kFWMuKvcPHL3DnU2LWZ28FBWk
 88nts/NpNcZb9Qla8ch55tyz0EkAcjX0VmaI9C9iE3jJPBLk6CdTNskE9DJcogfwCSUtvib7+z7
 YayT+IxTRx2i7wvyVy3OeAK35s7yWIX0hsPl2AmLDD7gyXWuDQ5eqPGbhe+qKk8DW6DiqzA/HOl
 ko9/28sCzuc9T/gzFUGju09eCHIFafGmOfc/5Z1IT5Q2m/yEUFpaSYiQcKb7UwxfwYGPRPiTSJk
 AV6FOSr0C5wNWXl7kF0P9NuHnS+wTjTd5cNn095nlYPUREThsjCcG9E1UvgVOjt8/uukjXt3YhG
 gWVopI5S7ZVpiSmK5CGpFo4eiePsf8DFcN+D8tf7lirncTNAQcmHpg
X-Received: by 2002:a17:90b:4a04:b0:35b:e550:e68a with SMTP id
 98e67ed59e1d1-35e4254fb13mr3695835a91.3.1775833516088; 
 Fri, 10 Apr 2026 08:05:16 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:15 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 02/14] iothread: introduce iothread_ref/unref to track
 attached devices
Date: Fri, 10 Apr 2026 23:04:45 +0800
Message-ID: <20260410150457.85190-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1031.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, IOThreads do not maintain a record of which devices are
associated with them. This makes it difficult to monitor the
workload distribution of IOThreads, especially in complex
hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.

This patch introduces a reference counting and tracking mechanism
within the IOThread object:

- iothread_ref(): Prepends the device's QOM path to a list.
- iothread_unref(): Searches for the device path using a custom
  string comparison (g_strcmp0), releases the associated memory
  upon a successful match.
- holders: A GList storing the QOM paths of attached devices
  for runtime introspection.

This infrastructure allows management tools and QMP commands to
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  1 +
 iothread.c                | 56 +++++++++++++++++++++++++++++++++++++++
 qapi/misc.json            | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..21a76bd70d 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -33,6 +33,7 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    GList *holders;             /* an array of QOM paths for attached devices */
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
diff --git a/iothread.c b/iothread.c
index caf68e0764..c43266b191 100644
--- a/iothread.c
+++ b/iothread.c
@@ -36,6 +36,55 @@
 #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
 #endif
 
+/*
+ * Add holder device path to the list.
+ */
+static void iothread_ref(IOThread *iothread, const char *holder)
+{
+    IoThreadHolder *h = g_new0(IoThreadHolder, 1);
+
+    if (holder && holder[0] == '/') {
+        h->type = IO_THREAD_HOLDER_KIND_QOM_OBJECT;
+        h->u.qom_object.data = g_strdup(holder);
+    } else {
+        h->type = IO_THREAD_HOLDER_KIND_BLOCK_NODE;
+        h->u.block_node.data = g_strdup(holder ? holder : "unknown");
+    }
+
+    iothread->holders = g_list_prepend(iothread->holders, h);
+}
+
+static int iothread_holder_compare(gconstpointer a, gconstpointer b)
+{
+    const IoThreadHolder *holder_node = a;
+    const char *target_name = b;
+    const char *current_name = NULL;
+
+    if (holder_node->type == IO_THREAD_HOLDER_KIND_QOM_OBJECT) {
+        current_name = holder_node->u.qom_object.data;
+    } else if (holder_node->type == IO_THREAD_HOLDER_KIND_BLOCK_NODE) {
+        current_name = holder_node->u.block_node.data;
+    }
+
+    return g_strcmp0(current_name, target_name);
+}
+
+/*
+ * Delete holder device path from the list.
+ */
+static void iothread_unref(IOThread *iothread, const char *holder)
+{
+    GList *link = g_list_find_custom(iothread->holders, holder,
+                                     (GCompareFunc)iothread_holder_compare);
+
+    /* We don't support unref without a link */
+    assert(link);
+
+    IoThreadHolder *h = (IoThreadHolder *)link->data;
+    qapi_free_IoThreadHolder(h);
+    iothread->holders = g_list_delete_link(iothread->holders, link);
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -115,6 +164,9 @@ static void iothread_instance_finalize(Object *obj)
 
     iothread_stop(iothread);
 
+    /* We don't support finalize without holders */
+    assert(iothread->holders == NULL);
+
     /*
      * Before glib2 2.33.10, there is a glib2 bug that GSource context
      * pointer may not be cleared even if the context has already been
@@ -336,6 +388,10 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
+    /* Remove in next patch for build */
+    iothread_ref(iothread, "tmp");
+    iothread_unref(iothread, "tmp");
+
     return iothread->ctx;
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index 1f5062df2a..d65d8012b2 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -67,6 +67,54 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
+
+##
+# @IoThreadHolderBlockNode:
+#
+# @data: Block node name.
+#
+# Since: 11.0
+#
+##
+{ 'struct': 'IoThreadHolderBlockNode',
+  'data': { 'data': 'str' } }
+
+##
+# @IoThreadHolderQomObject:
+#
+# @data: QOM path.
+#
+# Since: 11.0
+#
+##
+{ 'struct': 'IoThreadHolderQomObject',
+  'data': { 'data': 'str' } }
+
+##
+# @IoThreadHolderKind:
+#
+# @block-node: Block node name.
+# @qom-object: Standard QOM path.
+#
+# Since: 11.0
+##
+{ 'enum': 'IoThreadHolderKind',
+  'data': [ 'block-node', 'qom-object' ] }
+
+##
+# @IoThreadHolder:
+#
+# @type: Current IoThread holder type support QOM path and Block node.
+#
+# Since: 11.0
+##
+{ 'union': 'IoThreadHolder',
+  'base': { 'type': 'IoThreadHolderKind' },
+  'discriminator': 'type',
+  'data': {
+    'block-node': 'IoThreadHolderBlockNode',
+    'qom-object': 'IoThreadHolderQomObject' } }
+
 ##
 # @IOThreadInfo:
 #
-- 
2.49.0


