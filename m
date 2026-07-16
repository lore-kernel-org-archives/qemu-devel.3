Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4934C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNIw-0006fy-Dy; Thu, 16 Jul 2026 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHQ-0005sC-9a
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:45 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNHO-00077T-7f
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:41:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ceb096e675so61034075ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212896; x=1784817696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EWnksNoYUxBUrwcSM/xM8wvQyla6RML0UmckypoRO1Y=;
 b=cKtpJiKAS+9vB+Jj/ozDKG/nrm8/thZgA+304A7jOXIjSXpHhK6Sjgp8THPauV3wZg
 Cm7iC+47OCl1vsPebWd1ImrMER0UpjF9zAtq1/lYu0PCMXEuzsQ8pKBTkSfX/SnFtUGN
 X3BqKK7CNwC4noG5Vg2PJq9byZjp7T7GbfPL/DUfhve7Y4kfotaNY2IngBDrlput0dZ2
 yHgKW9Wc0/f1qssVp5sjtgvei/J4CiewM1KaACLz7LQ007CAThwzKFg2zGM3Tb4BCQ5O
 o2kJ/0dQ+jTcRQ+xn/yVcjXMkygS8FfT03meIkdyHdeHcF0v+8XkPGg81egu8Fgqq++a
 dcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212896; x=1784817696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EWnksNoYUxBUrwcSM/xM8wvQyla6RML0UmckypoRO1Y=;
 b=AzQmrNSax4ebzG5UtL78GZ3XVOGdBRCx0XlaAzb45SvsAarBt2wlMCBcmm1ZDNSnPa
 WI8oHYrKoRcVfd1iqoJjDveZ/nwVHP9bYdkoyeKNWTS0WGpGdUIHfX/hFfUCbTQ/h+VE
 cL9fXRgR+Z8qbyeyMsbeMafA7w5SvyUBecQbsXnAGLaHp5e4GsyxYCZttYJoYg8bl65D
 eKDEe02wt00SakXbUgWi0VK6i9EbExrIIVKYV9t5y5yesxGAqESog+WyOl0ao8C+Lh6s
 wWL/W/ePk+UnY+GGSrFK3nalW6wGKPALsCBjLev0zqi0BrFK+uAVp/n1GprXcek72kL5
 yVaA==
X-Gm-Message-State: AOJu0YyVgxBSZIQGXr7lziq5FNJhbvFemSGk468gk8BJKxpHyvzKgdOO
 sx60CeVSZzFDO5LmiUjv+jfncJUiplh/xKtrCKm4LsKZ/bApm+ao2hFCnYSt8PGFcs8=
X-Gm-Gg: AfdE7clUhczk+v+NlQkf7pbL8DwoR0qjD5skZbYHfOwsgD9wbDFy11xYuL04927KQVi
 7Jy0HiD2F8q/b1r7CFBeO9Q+c8SFttNQWPDeTphrtEXaLvXZaQzwFx9xsP7LLnqBstbeYWbxPSH
 xsMUCcQKDBmXwEfESVrFcJLJThTXPi6YTaFvobNKYJBBp2ian53r3K0a/1Xf3WHKy82p6W/7hFD
 THtU9wXHuwLdEXmn2EQY4+ICwiP8ShURqHMHVT7BM4Jk1O3ocB+frv1e8NBHQQvGxhuTwwkwr8g
 6PmdAz9xNlSamJyPSAOpzAcac6gv4Rt4N10Iydu1WbPShBKn1VmRLwDFnlEF7GhbDKvLFGbB9O8
 SjRJ9xEn5F9UO0+qXvnt/kRWCUAbqNHsB6Ts1KJtVF9K2NTvQx0775t3VFOjaQHiDp8Vmg65a5L
 6eZeIwz2qUS1EQu/CxczgmSuh7MCyVL93LG7w1j9qT
X-Received: by 2002:a17:903:1a45:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2cf03bd51b0mr76449825ad.8.1784212896245; 
 Thu, 16 Jul 2026 07:41:36 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.41.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:41:35 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V10 02/15] iothread: introduce iothread_ref/unref to track
 attached devices
Date: Thu, 16 Jul 2026 22:40:27 +0800
Message-ID: <20260716144043.76414-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
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

- iothread_ref(): Prepends the device's IOThreadHolder to a list.
- iothread_unref(): Searches for the IOThreadHolder using a
  string comparison (strcmp), releases the associated memory
  upon a successful match.
- holders: A IOThreadHolderList storing the IOThreadHolder
  of attached devices for runtime introspection.

A later commit will add QMP commands to let management applications
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/system/iothread.h | 11 ++++++
 iothread.c                | 70 +++++++++++++++++++++++++++++++++++++++
 qapi/misc.json            | 59 +++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index a1ef7696cb..ef0b2f9648 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -38,6 +38,9 @@
 #define IOTHREAD_POLL_WEIGHT_DEFAULT 0ULL
 #endif
 
+typedef struct IOThreadHolder IOThreadHolder;
+typedef struct IOThreadHolderList IOThreadHolderList;
+
 struct IOThread {
     EventLoopBase parent_obj;
 
@@ -50,6 +53,11 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    /*
+     * The list elements are of type IOThreadHolder, which can
+     * represent either a QOM path or a block export name.
+     */
+    IOThreadHolderList *holders;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
@@ -82,4 +90,7 @@ void iothread_destroy(IOThread *iothread);
  */
 bool qemu_in_iothread(void);
 
+void iothread_ref(IOThread *iothread, const IOThreadHolder *holder);
+void iothread_unref(IOThread *iothread, const IOThreadHolder *holder);
+
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index 3558535b40..38f273c0e9 100644
--- a/iothread.c
+++ b/iothread.c
@@ -21,10 +21,78 @@
 #include "system/iothread.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
 
+/*
+ * iothread_ref:
+ * @iothread: the iothread to track
+ * @holder: the IOThreadHolder object initialized by the caller
+ *
+ * Add the @holder to the iothread's tracking list.
+ */
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
+        return holder_b->type - holder_a->type;
+    }
+
+    switch (holder_a->type) {
+    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+        name_a = holder_a->u.qom_object.qom_path;
+        name_b = holder_b->u.qom_object.qom_path;
+        break;
+    case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+        name_a = holder_a->u.block_export.export_name;
+        name_b = holder_b->u.block_export.export_name;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return strcmp(name_a, name_b);
+}
+
+/*
+ * This function removes the @holder from the @iothread's tracking list.
+ * The @holder must match the one used previously in iothread_ref().
+ * It is a programming error to call this with a @holder that is not
+ * currently associated with the @iothread.
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
@@ -129,6 +197,7 @@ static void iothread_instance_finalize(Object *obj)
         iothread->main_loop = NULL;
     }
     qemu_sem_destroy(&iothread->init_done_sem);
+    qapi_free_IOThreadHolderList(iothread->holders);
 }
 
 static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
@@ -373,6 +442,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = QAPI_CLONE(IOThreadHolderList, iothread->holders);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/qapi/misc.json b/qapi/misc.json
index c71a5fe657..096e418b7a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -67,6 +67,56 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
+
+##
+# @IOThreadHolderBlockExport:
+#
+# @export-name: Name of the block export.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderBlockExport',
+  'data': { 'export-name': 'str' } }
+
+##
+# @IOThreadHolderQomObject:
+#
+# @qom-path: Path to the object in the QOM tree.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderQomObject',
+  'data': { 'qom-path': 'str' } }
+
+##
+# @IOThreadHolderKind:
+#
+# @block-export: A block export.
+# @qom-object: A QOM Object.
+#
+# Since: 11.1
+##
+{ 'enum': 'IOThreadHolderKind',
+  'data': [ 'block-export', 'qom-object' ] }
+
+##
+# @IOThreadHolder:
+#
+# The block export or QOM object holding the I/O thread.
+#
+# @type: the kind of I/O thread holder.
+#
+# Since: 11.1
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
@@ -76,6 +126,11 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: the QOM objects or block nodes currently
+#     associated with this iothread.  When an associated component is
+#     detached or destroyed, it is removed from this list.
+#     (Since 11.1)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -98,6 +153,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IOThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -124,6 +180,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "holders":[{"qom-path": "/machine/peripheral/blk1/virtio-backend", "type": "qom-object"},
+#                            {"qom-path": "/machine/peripheral/blk2/virtio-backend", "type": "qom-object"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -132,6 +190,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "holders":[{"export-name": "fmt_qcow2", "type": "block-export"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


