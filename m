Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9207BF33A70
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9eH-0004bA-Mm; Thu, 05 Mar 2026 09:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9eF-0004Tn-Rv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:55 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9eE-0001p1-5E
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:55 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso2793843a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720752; x=1773325552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKPUpYQFVKWwcABIWJ5VQAQRyHXh0x2xJB9o/DHpt6s=;
 b=fSw8g8DHRaKHywaftjZH0bKZ2bKPnD0e0CclLTcOlmhhu4GVcp5v54rcFEffZW+Bdc
 C7/vjSJ2jDEociyyd/9a3O4bfxP88deN1jy3UqPE1nfTUslPD3OFDRWhEggqdzhjnVaF
 SgJ42RPbven4yT3pdwyJ2Fw7/1+3dRAObnkgeQDlT4hSAqvU+U0hfBe7Ry5x0QGibl8A
 Q+LdkgjcXvENfmyzYgwJkDRJklhd6AqC7hJknMH2fYfw7gwU3JZrcIn81EohB7mwlGoN
 Lk8LODBriBjOd5NYYzTAGimqJCie5pAftqAez1AoRVXVLkHyR1kDGiUHyhIT8C6h7LED
 GNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720752; x=1773325552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LKPUpYQFVKWwcABIWJ5VQAQRyHXh0x2xJB9o/DHpt6s=;
 b=R30TJVDVZ9zVrFMWmC1DaAssX7232YDNi19fHQ8AsNIYMX9Y4uw5KvsSnhZV9ztgPK
 d5tTE1AzxqRMBcHyErRIjzZ62ClMYub1lVqqFDxgAsRTc4f6iZRHrbVZCMHKPAKB3Zaj
 jsXecRXhhUm5ciQv9Oeyv9ZIWsOWTyP38zWAQZcKCuf6WPTwqSWsWBok7wRsJeENhMp2
 LorIvI/QdteqrCyIbo0SEPHfCVzttcaK0zQaB3rOXqbYS87tcEPbuux2PFC7iz6D27qv
 dwAG7WW4B7R8e97OmsDRdi0OOoegkcVrd7k3o8e1LL6bWb/h2v6lIMLd4N2PCPFpsvo8
 bYew==
X-Gm-Message-State: AOJu0YzimjwgdRoYfeXVRAGtMeb8E6BMkdQjgQb21QU34zpIZbINdptv
 /VdG3XqKUlZ4y0E7KCJwyTxq1E89+3ScN8wY+oYXG6ANY9wElGg+cE1+nM8LMrjqMkyx1A==
X-Gm-Gg: ATEYQzwp5BbBvWxYXfsNn6bXuA7kjKWKcZ0gNywciCpsd2JK1I86UtePk2O4qVQO/af
 Kq5GZ4TajhqZsLh5dB37bYeG+3X5GzIoSovMJK9jOcMkASonVMl8jUjf1h7QyRxmw/Ti9MueLS/
 2wDc+YcBF3FXX5TZXxJirQwZfVhSHlGQBTEIu/xYPNdCXQbtnWBoaWIVWJ2d3SeyhGqnt+mUHsl
 raed+o4gjt3JCvSSZQMIAaDe5jqK4N9H5zOzN8vUH3gX98Ezu+rCyMVy25jojXdpEIN34FfSdNi
 1SHnEbOmTJfr0TP3VcPVHdcwEo2Dx0CK4FXhLnMgHEsJRwl7Ofb2GlnLdI3M2z69nweK0FwM9ih
 BoseRqMR5VGsEuqDqfhNBwW+PfLzMiJ2yILP06P4K0ymK4oGkt5Mm+SEV5DmwOFkjaXxsoIkC8g
 32Zkl5eoHbWHr/ujaH1VyBJIqZuddcsVpJ0EXfJrgfCesKzaNK0SUX2HgqoCXJR2JdFs0=
X-Received: by 2002:a17:903:1b64:b0:2ae:7ee0:ab3 with SMTP id
 d9443c01a7336-2ae7ee00b94mr4547735ad.38.1772720752280; 
 Thu, 05 Mar 2026 06:25:52 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:51 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 13/13] qapi: examine IOThread attachment status via
 query-iothreads
Date: Thu,  5 Mar 2026 22:24:59 +0800
Message-ID: <20260305142459.52559-14-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52a.google.com
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
- @holders: A string containing of QOM paths for the attached devices.

These fields are also exposed via the Human Monitor Interface (HMP)
command 'info iothreads' to assist with manual debugging and
performance tuning.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 iothread.c         | 14 ++++++++++++++
 monitor/hmp-cmds.c | 13 +++++++++++++
 qapi/misc.json     | 13 +++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/iothread.c b/iothread.c
index da98fbb9ad..ecd09f396e 100644
--- a/iothread.c
+++ b/iothread.c
@@ -64,6 +64,19 @@ static void iothread_unref(IOThread *iothread, const char *holder)
     }
 }
 
+static strList *iothread_get_holders_list(IOThread *iothread)
+{
+    strList *head = NULL;
+    strList **tail = &head;
+    GList *l;
+
+    for (l = iothread->holders; l != NULL; l = l->next) {
+        QAPI_LIST_APPEND(tail, g_strdup(l->data));
+    }
+
+    return head;
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -405,6 +418,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = iothread_get_holders_list(iothread);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bad034937a..d01ebba94d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -203,6 +203,19 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
         value = info->value;
         monitor_printf(mon, "%s:\n", value->id);
         monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  holders=");
+        if (!value->holders) {
+            monitor_printf(mon, "\n");
+        } else {
+            strList *h;
+            bool first = true;
+            for (h = value->holders; h; h = h->next) {
+                monitor_printf(mon, "%s%s", first ? "" : "\n          ",
+                               h->value);
+                first = false;
+            }
+            monitor_printf(mon, "\n");
+        }
         monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
         monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
         monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
diff --git a/qapi/misc.json b/qapi/misc.json
index 1f5062df2a..a381074c04 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -76,6 +76,15 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: The parameter is an array of QOM paths indicating how many
+#     active devices are currently associated with this iothread
+#     (e.g. virtio-blk).  In hotplug scenarios, users can
+#     pre-allocate multiple iothread objects to serve as a persistent
+#     thread pool.  When a device is hot-unplugged, the corresponding
+#     IOThread is released but remains available, allowing subsequent
+#     hot-plugged devices to attach to and reuse the existing thread.
+#     Returns empty if no devices are attached.  (since 11.0)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -93,6 +102,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['str'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -118,6 +128,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "holders":["/machine/peripheral/blk1/virtio-backend",
+#                            "/machine/peripheral/blk0/virtio-backend"],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -126,6 +138,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "holders":["/machine/peripheral/blk2/virtio-backend"],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


