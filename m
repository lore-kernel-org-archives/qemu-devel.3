Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD80F459ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQp-0007xW-G5; Fri, 10 Apr 2026 11:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQo-0007x0-1N
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:06:02 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQm-0002b7-8E
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:06:01 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso1410096a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833558; x=1776438358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQnCW2Bu1yv/B7cGDrJMYN0CGO9ZnuxGzsyVppnfZAU=;
 b=OIJBjZn5kfXeiuqcp4cwfONmtQi1QlAJJqhrgIFjChCIY+pTU+/cIpville1z9twoj
 4uyFihNryUz8vCXP7ftR6rxlhuDEgmSX0A/w3qbDnNKeHrkvFV2W10+Dhr1weDsWpMh+
 2zlG0r09WqxJGaOyXeqjahmqQZqxuQ+OjPvwASzSGIVOuODO2IQnNjocZoTx5U65C4yA
 Q3l6I70sp7nnudb+CbfmJAaniz6tnnra7z2+uBcNq84aAVMF/K9ZBwOVsiK5gJz/nmx7
 ra2TpaK3HtLRYkP7IKSGE7g+4RN1T6Is6EhbSLQ6GoojmJ2O+eFbWSLAIJzpjJAY7IPQ
 ia5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833558; x=1776438358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RQnCW2Bu1yv/B7cGDrJMYN0CGO9ZnuxGzsyVppnfZAU=;
 b=ePViVxhmfT28mFkOx/jH4RW5tZ4CFWpO7WSmTZGh1mdHFVqLXvzjavPRANkG0fgl6S
 oK4nTt7U8BgUvUEE+ugP1Huz6Fx/+lHZMrt5tbeqn6WOeK5dp1WOLz4XxvAowmYH6uP/
 Ur34rdHpA+osWpw43s+IQseGG8vpw3dNaS/xN3ij8JFKPy/CEwcredodRgn/HTumpyOe
 0O6adWFIbzNCtOW4SvbBsawMuLUVo91dCHo1hki5Rgar1g92pErSV/VSrlNhUZYNPzS8
 45+cgmqteyR8p63+FV0GmRi0AJwkTbl5kwwqY42hb/FlZHKGvrDfIf1+SamgZxdimbcO
 AAZQ==
X-Gm-Message-State: AOJu0YxR22gStdrTxRnT/Ibgfs8lmCB36dnqRhntyKdw3hujASdjoWDl
 xcec6YBHnBkKXgv+6Gv7QaLucnX4iZYBR5LbOuRBpWY9JX5oKLCr/SmpjG4nN5CF
X-Gm-Gg: AeBDiesArshEtvIUWJKUIF/Dimu9eqoljTgeyyLhxWJzbRhx0j6QKjs28HghV79s1L1
 PnXwVHQozysbAVsp0YVbKtmvXSww8HbF9WSTvOYF2PJpxLIGT7XDJmIL3Xk1R08SPFtVIkQlkXQ
 wPAFiHbTx5k60UJrEyUjhiS6kxGDOSjZ3MQIs+8/tssXJ9kOgnxi3tSTSErKxzpfQY19G/O3zkX
 e/pNQqwI9E/Vhwm0DkJOPXJI3k8YWMSVEj6XKpXInZ8zlted74q16uRH5ue8otBqThTDfumylkQ
 oe+AzqkIFWoeqF3tLHi3MTfGuVhcZQEP1HFqi3qHhHP3cIH4QxR+tql6mByUGyzFyBmeCETo4Jv
 hh5+hGgFjktXT+whTGCOOje53hBWDzuH6ygAFNGU3oMmsVh5ZyeXbrA9qL9R89ftpdlPUtjrhxq
 +oC6zoUViz45a0TxMotY0XIc+FKoElQiWOQ2BSvz5QZ6wRktN1mha6
X-Received: by 2002:a17:90b:3dcb:b0:35d:997c:8ec0 with SMTP id
 98e67ed59e1d1-35e4282bdb6mr3792959a91.18.1775833558292; 
 Fri, 10 Apr 2026 08:05:58 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:57 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 13/14] qapi: examine IOThread attachment status via
 query-iothreads
Date: Fri, 10 Apr 2026 23:04:56 +0800
Message-ID: <20260410150457.85190-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102e.google.com
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
- @holders: IoThreadHolder(QOM path or block node name) of the devices
            currently associated with this iothread.

These fields are also exposed via the Human Monitor Interface (HMP)
command 'info iothreads' to assist with manual debugging and
performance tuning.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 iothread.c         | 22 ++++++++++++++++++++++
 monitor/hmp-cmds.c | 22 ++++++++++++++++++++++
 qapi/misc.json     | 16 ++++++++++++++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/iothread.c b/iothread.c
index 60a024f770..70bc5fb62a 100644
--- a/iothread.c
+++ b/iothread.c
@@ -24,6 +24,8 @@
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-misc.h"
 
 
 #ifdef CONFIG_POSIX
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
@@ -434,6 +455,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = iothread_get_holders_list(iothread);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bc26b39d70..344eaf330b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -198,11 +198,33 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
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
index d65d8012b2..e173d54a5e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -94,7 +94,8 @@
 # @IoThreadHolderKind:
 #
 # @block-node: Block node name.
-# @qom-object: Standard QOM path.
+#
+# @qom-object: QOM path.
 #
 # Since: 11.0
 ##
@@ -104,7 +105,7 @@
 ##
 # @IoThreadHolder:
 #
-# @type: Current IoThread holder type support QOM path and Block node.
+# @type: Current IoThread holder type support QOM path and block node.
 #
 # Since: 11.0
 ##
@@ -124,6 +125,13 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: IoThreadHolder(QOM path or block node name) of the devices
+#     currently associated with this iothread.  Users can pre-allocate
+#     multiple iothread objects to serve as a persistent thread pool.
+#     When a device is hot-unplugged, it is detached from its
+#     iothread, but the iothread remains available, allowing future
+#     hot-plugged devices to attach to it.
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -141,6 +149,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IoThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -166,6 +175,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "holders":["/machine/peripheral/blk1/virtio-backend",
+#                            "/machine/peripheral/blk0/virtio-backend"],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -174,6 +185,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "holders":["/machine/peripheral/blk2/virtio-backend"],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


