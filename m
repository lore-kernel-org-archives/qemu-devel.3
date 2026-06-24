Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E990CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHlp-0006ms-5m; Wed, 24 Jun 2026 03:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkK-0005OA-Dg
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:10:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkH-00037M-Iu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:10:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84232e83ca9so338308b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782285000; x=1782889800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71CuRIyESyO5quaZSuqFa09qzy2utu3KI73qQbYqwt0=;
 b=R4t0MBVvyD/8udSo6qE3ebkRDke+rYmRb8PNHGhQx9bJTfYMspyPO9IVfS0EEslHN5
 pM/Nb+xJpBiRNyVRiARFssg29KEwPuWSNNrYdndDi72NjQ6RRf6ElVaiuL1e+aMhXqez
 /AkT5jfuq7ZXGDGOUxBdTVA0c+iE1PijxUYLOWBeM8IMt7WaZW7iz9+grTOZYxIjnET5
 SQme0MqYssf+CJhhFFgp4jdofKAPjiozMcNGr6faqa4h3EpuC9KYTizN+x6DSVtjznwN
 B361sgIli4I6siwMie5Die+XobNYPKIhtxUpdaG1MSk8Jc0KyfafBO/2Q06v7SPZNoY2
 ALmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782285000; x=1782889800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=71CuRIyESyO5quaZSuqFa09qzy2utu3KI73qQbYqwt0=;
 b=U9ruxket9E28kEcaoN3uUIDFsiH2AT/eCVcl8vh/A34779MZzUAp5WnxF1R+kP7Vq0
 2lRaCxB+/Hbu7CS+cmp589nH7jJ/cI8NmcQJ9FT1P5hromU9quVWyoj2NsTu7uFxJdRs
 DF2cyi0zAU2b8DV9dybcBgq6ke/Eu8NX9ov744MsV2OwP5q80iUfvLIn2kSPueGQTX+D
 j1DeGLRPMHN1oJgO3wLgvBrp9Td81g5PuwZ4dBDUsxDQQ86kknMstQ/Vn8EXRGQYpGBz
 JyOWgtVX5/0UYltP0Pm8zry//3mJQHZzxAog/q0EAf6ouh4KxzVg9QwbZuPMLbe2F4au
 flEA==
X-Gm-Message-State: AOJu0YywsBKgo1jhaXNigQ3t2mcjx1FI+Ryg1K+uP6zmKGYo9ezkmBop
 jsaZc1gGiHMzjjCvLQdn+Q2nyO0JRWY6Y29gG1af5/g9mcEP1XYtVbCAv/bGfp/g2Ik=
X-Gm-Gg: AfdE7cmYkAo+Alfcyz8yGtrbTYd2WTuk2vEKd4R4sX2DJiMTpkdzPyU9E06aSdKD+BD
 q8Il3WZ5VbJd+XffMTQbT2hh3DVO0iVz5fqX9p9L0hIZMixQACRhEnRsVdy6/UoJOVEh6gkG5Ie
 aePxSxgcPlH1B2wb7vhmZV+mr2RWiH1Zwmh7BbNx87eRtI0wjUloHqoYZ9ljNLZSribmdt5iTAv
 kDSt1dhl806sgw3KEseoX1D2qr5AGOEyN+blblG+Kxn9Z7B+YqcMfp685Tr1GFhHxQUpUafjO/A
 odNA6XEs4kYZ8WdUZ8vsEmDqxGY85wLCbZKCwuN18JbL2ZfcpOyjsBtPsNpB+HlluHg6Xd5P6cS
 k0ppLRi4kfDr1hUDpPYShMHUTvJYsREDLbWyUEzouHYSfWVY57/xB2Yd6nP7M/gZdgNkEc3/2vG
 N80XK0Ou4rUV7wXg6FhmIY6QwzwmHe2GoXwLK714fZh9Oqj1u/iPNE
X-Received: by 2002:a05:6a20:918d:b0:398:c0ba:9ceb with SMTP id
 adf61e73a8af0-3bd14f5b67cmr8101002637.12.1782285000249; 
 Wed, 24 Jun 2026 00:10:00 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:59 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 15/17] qapi: examine IOThread attachment status via
 query-iothreads
Date: Wed, 24 Jun 2026 15:08:49 +0800
Message-ID: <20260624070851.13342-16-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x435.google.com
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

Extend the 'IOThreadInfo' structure to include attachment metrics.
This allows users to monitor the associated devices by identify them
by their QOM paths, block nodes or monitors.

New fields added to IOThreadInfo:
 @holders: IOThreadHolder of the devices currently associated with
     this iothread.  Users can pre-allocate multiple iothread objects
     to serve as a persistent thread pool.  When a device is hot-unplugged,
     it is detached from its iothread, but the iothread remains available,
     allowing future hot-plugged devices to attach to it.  (Since 11.1)

These fields are also exposed via the Human Monitor Interface (HMP)
command 'info iothreads' to assist with manual debugging and
performance tuning.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 iothread.c         | 22 ++++++++++++++++++++++
 monitor/hmp-cmds.c | 26 ++++++++++++++++++++++++++
 qapi/misc.json     |  9 +++++++++
 3 files changed, 57 insertions(+)

diff --git a/iothread.c b/iothread.c
index a85e960e45..5949785b32 100644
--- a/iothread.c
+++ b/iothread.c
@@ -24,6 +24,8 @@
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-misc.h"
 
 /*
  * iothread_ref:
@@ -119,6 +121,25 @@ static void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
     object_unref(OBJECT(iothread));
 }
 
+static IOThreadHolderList *iothread_get_holders_list(IOThread *iothread)
+{
+    IOThreadHolderList *head = NULL;
+    IOThreadHolderList **prev = &head;
+    GList *l;
+
+    for (l = iothread->holders; l; l = l->next) {
+        IOThreadHolder *src = l->data;
+        IOThreadHolderList *entry = g_new0(IOThreadHolderList, 1);
+
+        entry->value = QAPI_CLONE(IOThreadHolder, src);
+
+        *prev = entry;
+        prev = &entry->next;
+    }
+
+    return head;
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -488,6 +509,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = iothread_get_holders_list(iothread);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 443b8c785d..1b5883147b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -237,11 +237,37 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IOThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  holders=");
+        if (value->holders) {
+            for (h = value->holders; h; h = h->next) {
+                IOThreadHolder *holder = h->value;
+
+                switch (holder->type) {
+                case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
+                    monitor_printf(mon, "[block-node: %s]",
+                                   holder->u.block_node.node_name);
+                    break;
+                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                    monitor_printf(mon, "[qom-path: %s]",
+                                   holder->u.qom_object.qom_path);
+                    break;
+                case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
+                    monitor_printf(mon, "[monitor-name: %s]",
+                                   holder->u.monitor_name.monitor_name);
+                    break;
+                default:
+                    monitor_printf(mon, "[unknown]");
+                    break;
+                }
+            }
+            monitor_printf(mon, "\n");
+        }
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
diff --git a/qapi/misc.json b/qapi/misc.json
index d9f82f0922..6486c62ab5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -137,6 +137,11 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: the QOM objects, block nodes or monitors currently
+#     associated with this iothread.  When an associated component is
+#     detached or destroyed, it is removed from this list.
+#     (Since 11.1)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -159,6 +164,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IOThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -185,6 +191,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "holders":[{"qom-path": "/machine/peripheral/blk1/virtio-backend", "type": "qom-object"},
+#                            {"monitor-name": "compat_monitor0", "type": "monitor-name"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -193,6 +201,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "holders":[{"node-name": "fmt_qcow2", "type": "block-node"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


