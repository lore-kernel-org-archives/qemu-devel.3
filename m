Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C696ACD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRG8-0000Wo-1n; Mon, 11 May 2026 10:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFs-0000Am-Ie
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFd-000708-8W
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2bcd730e090so5699495ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508291; x=1779113091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBCjD83HlngVBkTZV44gg9NW8YEfb7AZIJBhF0teGz8=;
 b=JB6ptxV7UFcw/hvtlK8gUAYGvGLmY9wFbrA4d0lNasH0HkzoOUF4tXA/ZqKv0+E9Ra
 HkaHYtjLpZs2IxaMINJd/DQPgGzPK7k72KosysaVfdUCFmsbv43Ls3EjhQrXdIqQ0h7V
 ReY9WE5R7wq5Kc/GhOWKWuLcV+w87BF0GqIMVtkITozC7Xt8Kze4UO3GUtDsXfAmqTRO
 2vGyEb9gPbl4eB0WrihVCaXOFap4F3j9+E+KVMkQT7xkwLU5RTMdIjRneNmjqzQUDPR3
 Irx5mySf9ZsBdHMsB6/YHsGazsjvuPNeUXsyPD6zs6AkG6Z5F0MqgDzBsweQXsLV8kUO
 ++LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508291; x=1779113091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nBCjD83HlngVBkTZV44gg9NW8YEfb7AZIJBhF0teGz8=;
 b=HmO8fdPCvXxHcv06QEv+pzI9X06XzbrmIlGIbw/wwevfvjNMntRvzxiAuPtLLI1obQ
 T8AecNihIEMZgfVPnq4iq6zm1qwweH3VTUJxuRCKFivNCJ2pwApbKKGu/nPbS5a2OOSb
 b+TOWRHMuXplH1kzwQmxUiEK2V9J1nuyeTr/Op1mT0UMTUnnU5kIeR9UKHAOacC1+U3u
 wngOmYP/BfGqrFIBX6bw5jmCo7dDaf5NV/cySG2nwKo6aqTGAOiPa0afasoUdfT4TD4r
 dgCCH2h0iwsPrGdRVXVk356mupW67XxXt95l5FhgNaYTlWpgoVX/sGS39EZ0M0Znj581
 8Hdg==
X-Gm-Message-State: AOJu0YyTCszyUxVZlpQY9leHJbZikO4kbWSHb/Fy3RJ06xXFr1ito1cY
 Blmu7oDokbDI1cL8ARqqKyjWQg433oL40qhKktGSsfS3YVVHAtmaShIm9Srjl0vdQZ4=
X-Gm-Gg: Acq92OFCamTZRhsxvY+TxDaNF5kHqwEaX+QLnxAg/zBjjbWUTwk/JH9S4Ace3jxwnGH
 vu6M4yohclLoK6D8eQ/qeJeRPf9bhVaZZ3btX15qkOQpbAemwmvrLfqGbdnFJkGEoivuDAQxSbO
 Mog4TXoHGKGXvWP2zTK8AN293s11ivYsD57dHymGgqYsM7yTuLnK5/14diib2RUKifI5cxhPQxC
 8bp6iLu//NVc3Vk0i0Jn5aVBWywdV7MhtUNnoW598ZN/ukhJnQs3f3Y44hTr/R1kpmPf6MrELuV
 yYZKhc124qV/CBMg0BBWGGSymwIkzydDJLzhHDz9pOpxxrc0Imk0a44ZYJVED9ojN+wM55alKmI
 21JT+sOt+VQJRaRTZEIybeU/sgQ/inPJKD2YI2hSzNgFKUAiG4BqZuiE1lzzYKO/fQNTRjyWvNQ
 CchdDZ/Tixc70ibPfFiAV7dZlF4aYzAs3L0jukC33cb4btT8gKNlG4eUb9
X-Received: by 2002:a17:903:b0d:b0:2b4:5ddf:24f with SMTP id
 d9443c01a7336-2ba793bf9fbmr275134495ad.10.1778508289716; 
 Mon, 11 May 2026 07:04:49 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.04.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:04:49 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 02/14] iothread: introduce iothread_ref/unref to track
 attached devices
Date: Mon, 11 May 2026 22:04:04 +0800
Message-ID: <20260511140416.28271-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x629.google.com
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

A later commit will add QMP commands to let management applications
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  5 +++
 iothread.c                | 67 +++++++++++++++++++++++++++++++++++++++
 qapi/misc.json            | 48 ++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index a1ef7696cb..2871b06edc 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -50,6 +50,11 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    /*
+     * The list elements are of type IoThreadHolder, which can
+     * represent either a QOM path or a block node name.
+     */
+    GList *holders;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
diff --git a/iothread.c b/iothread.c
index 3558535b40..b805e4f97d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -25,6 +25,66 @@
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
 
+/*
+ * Add the @holder path to the iothread's tracking list.
+ * The @holder is a QOM path if it starts with '/', else a block node name.
+ */
+static void iothread_ref(IOThread *iothread, const char *holder)
+{
+    IoThreadHolder *h = g_new0(IoThreadHolder, 1);
+
+    assert(holder);
+
+    if (holder[0] == '/') {
+        h->type = IO_THREAD_HOLDER_KIND_QOM_OBJECT;
+        h->u.qom_object.data = g_strdup(holder);
+    } else {
+        h->type = IO_THREAD_HOLDER_KIND_BLOCK_NODE;
+        h->u.block_node.data = g_strdup(holder);
+    }
+
+    iothread->holders = g_list_prepend(iothread->holders, h);
+}
+
+static int iothread_holder_compare(gconstpointer a, gconstpointer b)
+{
+    const IoThreadHolder *holder_node = a;
+    const char *target_name = b;
+    const char *current_name;
+
+    if (holder_node->type == IO_THREAD_HOLDER_KIND_QOM_OBJECT) {
+        current_name = holder_node->u.qom_object.data;
+    } else if (holder_node->type == IO_THREAD_HOLDER_KIND_BLOCK_NODE) {
+        current_name = holder_node->u.block_node.data;
+    } else {
+        /*
+         * This should not happen. If it does, current_name remains
+         * NULL and g_strcmp0 will handle it safely.
+         */
+        current_name = NULL;
+    }
+
+    return g_strcmp0(current_name, target_name);
+}
+
+/*
+ * This function removes the @holder from the @iothread's tracking list.
+ * The @holder string must match the one used previously in iothread_ref().
+ * It is a programming error to call this with a @holder that is not
+ * currently associated with the @iothread.
+ */
+static void iothread_unref(IOThread *iothread, const char *holder)
+{
+    GList *link = g_list_find_custom(iothread->holders, holder,
+                                     (GCompareFunc)iothread_holder_compare);
+
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
@@ -108,6 +168,9 @@ static void iothread_instance_finalize(Object *obj)
 
     iothread_stop(iothread);
 
+    /* We don't support finalize without holders */
+    assert(iothread->holders == NULL);
+
     /*
      * Before glib2 2.33.10, there is a glib2 bug that GSource context
      * pointer may not be cleared even if the context has already been
@@ -356,6 +419,10 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
+    /* Remove in next patch for build */
+    iothread_ref(iothread, "tmp");
+    iothread_unref(iothread, "tmp");
+
     return iothread->ctx;
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index c71a5fe657..5fb7dcfcad 100644
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
+# Since: 11.1
+#
+##
+{ 'struct': 'IoThreadHolderBlockNode',
+  'data': { 'data': 'str' } }
+
+##
+# @IoThreadHolderQomObject:
+#
+# @data: Absolute @qom-path.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IoThreadHolderQomObject',
+  'data': { 'data': 'str' } }
+
+##
+# @IoThreadHolderKind:
+#
+# @block-node: Block node name.
+# @qom-object: Absolute @qom-path.
+#
+# Since: 11.1
+##
+{ 'enum': 'IoThreadHolderKind',
+  'data': [ 'block-node', 'qom-object' ] }
+
+##
+# @IoThreadHolder:
+#
+# @type: the kind of I/O thread holder.
+#
+# Since: 11.1
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


