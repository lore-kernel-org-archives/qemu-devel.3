Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE16FEDF17E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqwmy-0007cy-9n; Fri, 13 Feb 2026 12:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwmu-0007cX-CJ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:17:06 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vqwmr-0006xq-Nl
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:17:03 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so8239165ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771003019; x=1771607819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nragqWZQYCFHAzml/nKwPBaRW79jUqjKSSqj3EtsaSE=;
 b=c6GJBI4vw5ngcZLURTY/NWrzsnrSfkmHEdms2axmXqtqqr4i6l9FN80qBW86rAsT6K
 vZf2nrXA+LrKmyIvGa4uCzm2ZxWi5EcnATmXG4jE9QrvEAaNHGgDwtsYFSlOv8kIKoL1
 fn1bHD8qiEoQRY+jwo5GM6xZHO6kiRi63vODKgxxrODTKhsfmk2zSx9nmU+XcKxyH4bZ
 08Inm/2sOAQSuRRBWx5c4Bm+AUxTJpyrgINgHN8saFL5x8eU81e2KtmIsYdIMzLPV0Ws
 WT5SIleXPTwBJz9WBTaUGHm+7JqM4ZpJfRqxb2y6rruU6DD8LTzVo70BmB4ukQU3erTF
 tb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771003019; x=1771607819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nragqWZQYCFHAzml/nKwPBaRW79jUqjKSSqj3EtsaSE=;
 b=d2rPKHqKBqSLqZxTlRh6UO1o5yLVDWSzyYowgXnUyDiEzkvYzeaQ/wJP0WQIlE00yt
 m2l+ZvFFXQ4QPcZw2hZ36Igp0K+ZmJA/1NEr7ygm/8ktvoWLhEmZmlJOUAL98Anbb6KI
 F7DdMo5qxbm6UnOROHu0zWnLqVfscGoeMSvwWaKw+gD4eFOb0Z8B7TIwRB4iKGRek8oS
 wDGruwL3Lp3WVOrHRsVyevUNZ7Ih50ukqAq433eeZbGiLE0LphS0e+ZkUkFNILB1xLTG
 6U9LwA18sQZDCdvmvJDbAgArbIOWV+UiUSNkhTVfRLjxBgLY730UovOduc2AQoYl9zD6
 SRLQ==
X-Gm-Message-State: AOJu0YxK8l0r2eKrygmC7UQnxe3GXe/45wuOPEQLnxtwimkyBXsPrRWW
 R8+kMRuA5qVpbyqh/V6m6Bm6fUw2p3ni5nM/uPBYd/xtIYa9vnNJ4yir7EVYKZuk
X-Gm-Gg: AZuq6aLlCCnS11hwK3R8HoiPfyBPpYlAY3J39O381GvYBXjX1aEii1exGXeDMleTc70
 mxpDygTtEDSM+/JRmLRDNATFg3vhpu3boZG5r3MjXYBhaboowQJ57mv5y6u5Z+LwnnadxXLZdGy
 35P8cfF4dMPRrgnz1x9XAVLfBkpYSf2+V5Y1TsRGukyGgEZCOlafkwNQzIqX+pQyN4auI2Q8aV9
 ynrgSaxAfJ37OnoUWxm7Kxk8EuvNnq9zBjzlW6eJgJvEAHPdeVqp77bBJ9jjM44ZQOg/totoPWP
 pfxehMxrEZ7LRvPvxNKxLPe+0kpntGcleYpqGgne1/TebwxPcErdbMQK7uHmGQ98gsHAAZJOpvq
 XiR1nH3Wr3+2djU/HKySp81uMbUOH3t+flLIkVB1H4D+LZ17O0vXDsZ6NiEY6TOMSqmqknjpJkC
 CE+Uy3zBu6OdJrCYWlv1RiyCjEcqVLzsKkXVQ=
X-Received: by 2002:a17:902:e788:b0:2a0:8ca7:69de with SMTP id
 d9443c01a7336-2ad17545608mr494045ad.41.1771003018951; 
 Fri, 13 Feb 2026 09:16:58 -0800 (PST)
Received: from localhost.localdomain ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29998c45sm87095575ad.88.2026.02.13.09.16.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 09:16:58 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V4 4/4] qapi: examine IOThread attachment status via
 query-iothreads
Date: Sat, 14 Feb 2026 01:16:22 +0800
Message-ID: <20260213171622.55629-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260213171622.55629-1-zhangckid@gmail.com>
References: <20260213171622.55629-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62d.google.com
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
This allows users to monitor how many devices are associated with
a specific IOThread and identify them by their QOM paths.

New fields added to IOThreadInfo:
- @attached-cnt: An integer representing the number of devices
  currently using this IOThread's AioContext.
- @attached-dev: A string containing a delimited list ("|") of
  QOM paths for the attached devices.

These fields are also exposed via the Human Monitor Interface (HMP)
command 'info iothreads' to assist with manual debugging and
performance tuning.

Example QMP output:
{
    "id": "iothread0",
    "thread-id": 3134,
    "attached-cnt": 2,
    "attached-dev": "/machine/peripheral/blk1/virtio-backend | /machine/peripheral/blk0/virtio-backend",
    ...
}

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 iothread.c         | 24 ++++++++++++++++++++++++
 monitor/hmp-cmds.c |  3 +++
 qapi/misc.json     | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/iothread.c b/iothread.c
index b869637497..4fceed28c5 100644
--- a/iothread.c
+++ b/iothread.c
@@ -71,6 +71,28 @@ void iothread_unref(IOThread *iothread, const char *holder)
     }
 }
 
+static char *iothread_get_attached_dev_list(IOThread *iothread)
+{
+    guint len = g_list_length(iothread->attached_dev);
+
+    if (len == 0) {
+        return g_strdup("none");
+    }
+
+    gchar **array = g_new0(gchar *, len + 1);
+    GList *l;
+    int i = 0;
+
+    for (l = iothread->attached_dev; l != NULL; l = l->next) {
+        array[i++] = l->data;
+    }
+
+    char *result = g_strjoinv(" | ", array);
+    g_free(array);
+
+    return result;
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -388,6 +410,8 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->attached_cnt = iothread->attached_cnt;
+    info->attached_dev = iothread_get_attached_dev_list(iothread);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bad034937a..026bed1545 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -203,6 +203,9 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  attached-cnt=%" PRId64 "\n",
+                       value->attached_cnt);
+        monitor_printf(mon, "  attached-dev=%s\n", value->attached_dev);
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
diff --git a/qapi/misc.json b/qapi/misc.json
index 1f5062df2a..ca53638684 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -76,6 +76,19 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @attached-cnt: The parameter is a counter indicating how many
+#     active devices are currently associated with this iothread
+#     (e.g. virtio-blk).  In hotplug scenarios, users can
+#     pre-allocate multiple iothread objects to serve as a persistent
+#     thread pool.  When a device is hot-unplugged, the corresponding
+#     IOThread is released but remains available, allowing subsequent
+#     hot-plugged devices to attach to and reuse the existing thread.
+#     (since 11.0)
+#
+# @attached-dev: A list of QOM paths for the devices currently
+#     associated with this IOThread, delimited by " | ".
+#     Returns "none" if no devices are attached. (since 11.0)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -93,6 +106,8 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'attached-cnt': 'int',
+           'attached-dev': 'str',
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -118,6 +133,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "attached-cnt":2,
+#                 "attached-dev":/machine/peripheral/blk1/virtio-backend | /machine/peripheral/blk0/virtio-backend,
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -126,6 +143,8 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "attached-cnt":1,
+#                 "attached-dev":/machine/peripheral/blk3/virtio-backend,
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


