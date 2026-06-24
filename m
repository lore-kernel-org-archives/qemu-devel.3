Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31348CDE004
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHjZ-0004zO-Al; Wed, 24 Jun 2026 03:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjX-0004z2-E3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:15 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjV-0002wI-3R
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:15 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c89370405aaso261487a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284951; x=1782889751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9zFq1iyzk05zoEMX2h9nWXYnORUY596qmXYMUCTaFo=;
 b=mPJW1IFlVE2Skr3f1hN4mmiO3kvfpEvqbmXECp99di/0I6D3LS19R0ky64FgzZ+ODO
 nnFKUZtX4HGZwn1fL0nh2b0oM6f9ibDtiG4pgK+u7xxoLjT9JJUfgA5I+30lO3o2pzJt
 Ll8W+oI9C6M5fbCDwWGbZMxmPVf2Q8B5nc4pgoPQVwd79deQCnV722bu7n243TY9JjUD
 21bgOmYBMf46OLwXOqDpyAMCGGPsYBMVpE/0TDNNrFZ/bPz/T/ue+XczlFB9/5MFdYLG
 1nbyBbRWQLfBm6RKAKLLj83VxDIHAAyIEri+g+BP1thQVHaUYFFXqqSadXYgRBkeECTr
 oy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284951; x=1782889751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H9zFq1iyzk05zoEMX2h9nWXYnORUY596qmXYMUCTaFo=;
 b=bxSQ1BwmmAaadCQ66+PyB4KlA0BoSVV4JtlW9B+dlwN3GhMIs+ylRES9PAo3WaW8ss
 bt155jPtZUCh0deQTD5QPtAv6/UMtCSP4QA4+s3isuUWhA0GSGVQj1W0knyPuEuRD6Nl
 eEwGarSldThckQK2J0upWck94IQTOoq5Qb5Wkc6+6uLACknJi7wmKk6S0bbCpILYyrDo
 KQ8t9kRIr6bUQwMH/AFNTfU62nQ0NGRnsOzil5MLLYFrCAE82Tt49bxBQ+QMTlM7wgur
 T2OM7IrHAZtjZN1oBT0yRS0DwqjfOfAXyZpJog6MCj/LZLiok7RcwZPgubzKgMmRB04h
 V1Vg==
X-Gm-Message-State: AOJu0YzdhnPI9fkQZ2OlX7XqebfKUWrR2w+7oMI+V42nnRE38ePxXNlG
 f1vpZL8gC0QOvsseZotIsXUdVuAMhrqY6NLPmliZyBTxBys7DyontzKLc/nVJ74nc4E=
X-Gm-Gg: AfdE7ckoFOzW/zIY4O3KmluzqUlL/rqKKOEFB1HjAdbsk3zaTKNpVBw6GNXGHT/mwIU
 IYPVOgocUnXCFtsWnJHvsyHWMH9sFBDO6ZWSuS6VDPj7WVHI5s9+FOsq1kxI6EL26NV0ul4FoTJ
 FbU2FMHn6J/NJZSBKJImDxG/0x9WW+STe6wJJJ3Kt5jiym3mKaCGh1vhikujlVthEvtFM5/5QpP
 pF3cXxFvaUVhcqFPTW8L+dOcJ3fKSZK8iYvV6Cc94DW5/S1DRZkN7k4gOSLw4fst4h/Fr3/SG1y
 H4uIUOaBjdMqZ9jqF/tOzTd+8u/TG+MteV+GxaSEjeKTpghY0Is4lCkIH6EvTdl63IkBI8o0kRc
 f/NkHq0XpUtSvf0O0d9ks2Q0Onmx7cXnKcS7EDUF6c7aiG8Ws4ZzJWQrc8dgjcpHruFhe3SGiEp
 YB0FKepHE7uAVxpY39WLWCR+yglu4XJx7V6pLdJnArGGlxVFAUXIUo
X-Received: by 2002:a05:6a21:648c:b0:3b3:1c7b:ff9 with SMTP id
 adf61e73a8af0-3bd152914a0mr8102967637.46.1782284951377; 
 Wed, 24 Jun 2026 00:09:11 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:10 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 02/17] iothread: introduce iothread_ref/unref to track
 attached devices
Date: Wed, 24 Jun 2026 15:08:36 +0800
Message-ID: <20260624070851.13342-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52f.google.com
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
- iothread_unref(): Searches for the IOThreadHolder using a custom
  string comparison (g_strcmp0), releases the associated memory
  upon a successful match.
- holders: A GList storing the IOThreadHolder of attached devices
  for runtime introspection.

A later commit will add QMP commands to let management applications
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  5 +++
 iothread.c                | 94 +++++++++++++++++++++++++++++++++++++++
 qapi/misc.json            | 61 +++++++++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index a1ef7696cb..b9207ad829 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -50,6 +50,11 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    /*
+     * The list elements are of type IOThreadHolder, which can
+     * represent either a QOM path or a block node name.
+     */
+    GList *holders;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
diff --git a/iothread.c b/iothread.c
index 3558535b40..3301b8d495 100644
--- a/iothread.c
+++ b/iothread.c
@@ -25,6 +25,92 @@
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
 
+/*
+ * iothread_ref:
+ * @iothread: the iothread to track
+ * @holder: the IOThreadHolder object initialized by the caller
+ *
+ * Add the @holder to the iothread's tracking list.
+ */
+static void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    assert(holder);
+    IOThreadHolder *h = g_new0(IOThreadHolder, 1);
+
+    h->type = holder->type;
+    switch (holder->type) {
+    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+        h->u.qom_object.qom_path = g_strdup(holder->u.qom_object.qom_path);
+        break;
+    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
+        h->u.block_node.node_name =
+            g_strdup(holder->u.block_node.node_name);
+        break;
+    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
+        h->u.monitor_name.monitor_name =
+            g_strdup(holder->u.monitor_name.monitor_name);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    iothread->holders = g_list_prepend(iothread->holders, h);
+}
+
+static int iothread_holder_compare(gconstpointer a, gconstpointer b)
+{
+    const IOThreadHolder *holder_a = a;
+    const IOThreadHolder *holder_b = b;
+    const char *name_a, *name_b;
+
+    if (holder_a->type != holder_b->type) {
+        return -1;
+    }
+
+    switch (holder_a->type) {
+    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+        name_a = holder_a->u.qom_object.qom_path;
+        name_b = holder_b->u.qom_object.qom_path;
+        break;
+    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
+        name_a = holder_a->u.block_node.node_name;
+        name_b = holder_b->u.block_node.node_name;
+        break;
+    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
+        name_a = holder_a->u.monitor_name.monitor_name;
+        name_b = holder_b->u.monitor_name.monitor_name;
+        break;
+    default:
+       /*
+        * This should not happen. If it does, name_a/b remains
+        * NULL and g_strcmp0 will handle it safely.
+        */
+        name_a = NULL;
+        name_b = NULL;
+    }
+
+    return g_strcmp0(name_a, name_b);
+}
+
+/*
+ * This function removes the @holder from the @iothread's tracking list.
+ * The @holder must match the one used previously in iothread_ref().
+ * It is a programming error to call this with a @holder that is not
+ * currently associated with the @iothread.
+ */
+static void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    assert(holder);
+    GList *link = g_list_find_custom(iothread->holders, holder,
+                                     (GCompareFunc)iothread_holder_compare);
+
+    assert(link);
+
+    IOThreadHolder *h = (IOThreadHolder *)link->data;
+    qapi_free_IOThreadHolder(h);
+    iothread->holders = g_list_delete_link(iothread->holders, link);
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -356,6 +442,14 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
+    /* Remove in next patch for build */
+    IOThreadHolder holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)"tmp_path",
+    };
+    iothread_ref(iothread, &holder);
+    iothread_unref(iothread, &holder);
+
     return iothread->ctx;
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index c71a5fe657..d9f82f0922 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -67,6 +67,67 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
+
+##
+# @IOThreadHolderBlockNode:
+#
+# @node-name: A block node.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderBlockNode',
+  'data': { 'node-name': 'str' } }
+
+##
+# @IOThreadHolderQomObject:
+#
+# @qom-path: A QOM Object.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderQomObject',
+  'data': { 'qom-path': 'str' } }
+
+##
+# @IOThreadHolderMonitor:
+#
+# @monitor-name: A HMP/QMP monitor.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderMonitor',
+  'data': { 'monitor-name': 'str' } }
+
+##
+# @IOThreadHolderKind:
+#
+# @block-node: A block node.
+# @qom-object: A QOM Object.
+# @monitor-name: A HMP/QMP monitor.
+#
+# Since: 11.1
+##
+{ 'enum': 'IOThreadHolderKind',
+  'data': [ 'block-node', 'qom-object', 'monitor-name' ] }
+
+##
+# @IOThreadHolder:
+#
+# @type: the kind of I/O thread holder.
+#
+# Since: 11.1
+##
+{ 'union': 'IOThreadHolder',
+  'base': { 'type': 'IOThreadHolderKind' },
+  'discriminator': 'type',
+  'data': {
+    'block-node': 'IOThreadHolderBlockNode',
+    'qom-object': 'IOThreadHolderQomObject',
+    'monitor-name': 'IOThreadHolderMonitor' } }
+
 ##
 # @IOThreadInfo:
 #
-- 
2.49.0


