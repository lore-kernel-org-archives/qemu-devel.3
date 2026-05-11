Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFFDCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHW-0002eb-11; Mon, 11 May 2026 10:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGO-0000xA-EQ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRGJ-0007KR-Ds
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so39840825ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508333; x=1779113133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3N5Xo9vISZc6fDn2rpqzE+2yy09KDkC5TvyoHeOVaQ=;
 b=ZWLKWEurYyc2gtlsbpjL4o9qKah++ft9ifqQTJFHNtmp2YRPIgnu+eGDXoAQFX1ChR
 XLQUiK5jkmWTe5kluTegptjRvA8nO5lUk7aXKaRj5oYkKx427Ifeb9oFeVnr3/7yvQfZ
 A/uKrQMnKJtryxUxTAtcYoKMVbaNWx9KuB/lVMOiqyCgJTlPBn13UlYLRGzlp+cHUa6q
 idI1KVu+dCec9a4e6xg3BhBF+apbzcn8Z0tLwsWuxrgQAchRIPQQs9H3B6DSGplUY+QT
 X8cWOrWrLAIHLn2rmh3k+X7UD+w+sUHghVtqgrPv4oZVAYVkErQK14EFfOgEQIO3n8b0
 KrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508333; x=1779113133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R3N5Xo9vISZc6fDn2rpqzE+2yy09KDkC5TvyoHeOVaQ=;
 b=ZhQ0he8VQetFC87YX5k2UVDhCe5aAkHViQmHKOOh2ZSo8zKwUL3qQXTUBvheE86OPr
 aeFBHNZBxW5rSFFk6SE9KxoEPNkZdTNq/Vfx60NgAaBYRVcZZogGh57Gx6mhgCpWSjZC
 TG5wvGswMzCpapKIOUSQxdd7nAZkVOuwYuyc+EYZ3FrPjkQW4cbP9UvrZabqK273q4Ii
 7dGc+f0rttsUiQKvGaLhJsQInvjPYV2TkadiRKHuNkLKUWEiesPnvSpBdkUuB836BHuO
 OVLXyKkM6JaSqat8ZD6sT8Jy7l4x6eOl0oReIz0dLyYxto0LGP15IARZ+J17+Y97cpVm
 azgA==
X-Gm-Message-State: AOJu0YzE8ffNg/4AUcQqkoP5SrzoCn7RFSc9j2vex9MctvRa6L+3/Jdy
 4Rh1B107Lrk43jHR9mtKTfDV87J+LarHb9KEpAv8hJyoznI3+nzKKlVFqF2OM61Udno=
X-Gm-Gg: Acq92OF8ArV+Qxd2L6qqVOVqFvUI9KVPcvovdPN+r71p+bt/dBemWfr0R11dY926+zP
 URrSsp5yjzjUfBx4AoN4GaaZC2G+6pC3Q4JRaLOLgb3K4jRGsQ9vmK/QcykobNbsfPc85x9c6zP
 HrzlH2PxOv6IyPpak7JF+ysZbSwAeSzkaa/sAOe0jfaoFZ/PvFCgjO4bHPnyU2C6NT52f7U9xR7
 ab2ioPe9Otwof39ZJ7mL8od9c7uaM6uv8miClNS4dumhY+GcAnkMyOS3s6SIP94h7CKKzNCb1C/
 eR61fBJ6SIbkRPko25Z7UshyTrSqh203UxZa1mn5ez1dgKGJaskQuHBdH2iHo9vwNBERCUU11Eh
 oK6GRCJTXOj8DX+EROv9w9tbfJMBOEyfBSO2xC1GlkWl5771gx4jC3ozgV2g6m0V5CG5aUxAi+E
 cFSG26nTEf+LX5Ie79dax/hTp5VRM0/TYNkoGR2EIL6Whm0Q==
X-Received: by 2002:a17:902:c406:b0:2bc:f2ae:e122 with SMTP id
 d9443c01a7336-2bcf2aee2d3mr7705795ad.2.1778508333187; 
 Mon, 11 May 2026 07:05:33 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:32 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 13/14] qapi: examine IOThread attachment status via
 query-iothreads
Date: Mon, 11 May 2026 22:04:15 +0800
Message-ID: <20260511140416.28271-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
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
by their QOM paths.

New fields added to IOThreadInfo:
  @holders: IoThreadHolder (QOM path or block node name) of the devices
      currently associated with this iothread.  Users can pre-allocate
      multiple iothread objects to serve as a persistent thread pool.
      When a device is hot-unplugged, it is detached from its
      iothread, but the iothread remains available, allowing future
      hot-plugged devices to attach to it. (Since 11.1)

These fields are also exposed via the Human Monitor Interface (HMP)
command 'info iothreads' to assist with manual debugging and
performance tuning.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 iothread.c         | 22 ++++++++++++++++++++++
 monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
 qapi/misc.json     | 11 +++++++++++
 3 files changed, 55 insertions(+)

diff --git a/iothread.c b/iothread.c
index 5d6f46d286..a78744284b 100644
--- a/iothread.c
+++ b/iothread.c
@@ -24,6 +24,8 @@
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-misc.h"
 
 /*
  * Add the @holder path to the iothread's tracking list.
@@ -93,6 +95,25 @@ static void iothread_unref(IOThread *iothread, const char *holder)
     object_unref(OBJECT(iothread));
 }
 
+static IoThreadHolderList *iothread_get_holders_list(IOThread *iothread)
+{
+    IoThreadHolderList *head = NULL;
+    IoThreadHolderList **prev = &head;
+    GList *l;
+
+    for (l = iothread->holders; l; l = l->next) {
+        IoThreadHolder *src = l->data;
+        IoThreadHolderList *entry = g_new0(IoThreadHolderList, 1);
+
+        entry->value = QAPI_CLONE(IoThreadHolder, src);
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
@@ -465,6 +486,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = iothread_get_holders_list(iothread);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index db92d6cb86..be799766d6 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -237,11 +237,33 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
     IOThreadInfo *value;
+    IoThreadHolderList *h;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  holders=");
+        if (value->holders) {
+            for (h = value->holders; h; h = h->next) {
+                IoThreadHolder *holder = h->value;
+
+                switch (holder->type) {
+                case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
+                    monitor_printf(mon, "[block-node: %s]",
+                                   holder->u.block_node.data);
+                    break;
+                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+                    monitor_printf(mon, "[qom: %s]",
+                                   holder->u.qom_object.data);
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
index 5fb7dcfcad..39ec19362c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -124,6 +124,13 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: IoThreadHolder (QOM path or block node name) of the
+#     devices currently associated with this iothread.  Users can
+#     pre-allocate multiple iothread objects to serve as a persistent
+#     thread pool.  When a device is hot-unplugged, it is detached
+#     from its iothread, but the iothread remains available, allowing
+#     future hot-plugged devices to attach to it.  (Since 11.1)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -146,6 +153,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IoThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -172,6 +180,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "holders":["/machine/peripheral/blk1/virtio-backend",
+#                            "/machine/peripheral/blk0/virtio-backend"],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -180,6 +190,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "holders":["/machine/peripheral/blk2/virtio-backend"],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


