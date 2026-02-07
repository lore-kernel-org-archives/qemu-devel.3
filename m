Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA354EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8h-0007FR-76; Sat, 07 Feb 2026 07:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8d-0007DV-GK
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:12 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8a-00036L-TH
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:10:10 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3530e7b3dc2so2570090a91.3
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466207; x=1771071007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H78Df0v0meU3GDrKU4J2lfRzsB4Ror34DjemRoX9SzM=;
 b=fKn5MkuZlDjaeZwMGaXkYQl+JYdNYMv0Ljh8y+pwyqAW42XUroEEpyOQb+rXR2SC0L
 rTveQBD8nZvh8sX/C9Xe06by/uuN4PEIPeINxdNj7HPcF+KI28iBXSDl/w83CaL7exbB
 CwxMJ/ha0lypORF3mW+DSAzVcf41i661BChEcx0718/J3he6Q6s7lnIgA/WB/MdjAk4H
 A9S8biGAhMitiiQSWQue1x47ErzL4czESS5mZsc0nB4ylItrUQdZ5atOHibrFLU6wVBZ
 Qtxzy2myHK32MWxgLZNxmGpKucPGDuKQL6MJRsbTEvNz5HYnCQcj5LEJWh3TxFBMVY8C
 uNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466207; x=1771071007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H78Df0v0meU3GDrKU4J2lfRzsB4Ror34DjemRoX9SzM=;
 b=ngQyok/NClFUyJYi4BXkwy2efA9nqh0SZye/KNTeHXtSA7c2QmG8712irl8u6bEbde
 4Oni6dCs+uL8+jfhz0Wd9Z6D5/dMhM63MOJFQu5nto0FUWi9rv2MBTw3skXV4CNIKGDn
 imjHAWi3uUUPe5oddmtdfDLxu9CEWbr0dCwaCYqSqa5JLH4OU9FJyE/TBuQJ/XUCJ+0v
 QUbZvyCod14s9G6x+9wiRFykm36fHn2Oy0sQnz/uvejQY9GpoePo39fKDSbTGpt6hVbB
 Ux37OL/UHLl3SRJedWjL0D/2slh7SHTRD1meir68C5IG3bBOqZrcAVqOOIJOdWVy+uSv
 FNAQ==
X-Gm-Message-State: AOJu0YwraELw4cgNbsLGhTYtARwsDoA+/Tn5kSeyQpl6U9A8tLCW3dDb
 NlHsBbpWu18ulAdUZPc+BiHtIyQl7ZRCsIUlyDHLXbQORD/+ZQYsHizf
X-Gm-Gg: AZuq6aKIyl/8aJm2RAm+kB3fxrVkMBfHO4qPxXcCnPDJejs3bUfBGb+N7uOmzGSSH0k
 NcNcafnvXWsXvRL2zq8UE1N06jaj2QhZiseJV315r1ujRxqQCrSSgOTuB8EZ3vcyyXBifYYM8XH
 2RqFpCNhDtmqYdAK7L229t4R3xCz1zOSlki7OVP0wYK4dZzq1ljYSydsTxeCDWwt1NuEeCLUpYW
 ZVvCm71JSexaKsjQmmf/KGqpzhi02+HAMoV2fUIlhL2ufxIgBdSo6qfGthVctY1g5WVnhIwMW8D
 BJvtgBzB7d9j36sT4J7XEuSnoLLKFJsq+OsEjLueBlWUnfEH5xIMUh7CTeLxizOUciDzykJK/+N
 dEx4b+34+59wsEW+WU+6TEyz0l0wQ6drW+LG9p6ezlbW+M9WOIFvC7K/wHDIcjWcgNe7xSmKBlU
 ZUxtxcJHrOim6Lh3WdmX4F13XLsiqIbDenh2V2UHEnwqBK5W6Q
X-Received: by 2002:a17:90b:35cc:b0:353:5595:3247 with SMTP id
 98e67ed59e1d1-354b3c74a3fmr6051387a91.12.1770466207514; 
 Sat, 07 Feb 2026 04:10:07 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:10:06 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [Patch v4 5/6] fuse: safe termination for io_uring
Date: Sat,  7 Feb 2026 20:08:59 +0800
Message-ID: <20260207120901.17222-6-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207120901.17222-1-hibriansong@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=hibriansong@gmail.com; helo=mail-pj1-x1034.google.com
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

When a termination signal is received, the storage-export-daemon stops
the export, exits the main loop (main_loop_wait), and begins resource
cleanup. However, some FUSE_IO_URING_CMD_COMMIT_AND_FETCH SQEs may
remain pending in the kernel, waiting for incoming FUSE requests.

Currently, there is no way to manually cancel these pending CQEs in the
kernel. As a result, after export termination, the related data
structures might be deleted before the pending CQEs return, causing the
CQE handler to be invoked after it has been freed, which may lead to a
segfault.

As a workaround, when submitting an SQE to the kernel, we increment the
block reference (blk_exp_ref) to prevent the CQE handler from being
deleted during export termination. Once the CQE is received, we
decrement the reference (blk_exp_unref).

However, this introduces a new issue: if no new FUSE requests arrive,
the pending SQEs held by the kernel will never complete. Consequently,
the export reference count never drops to zero, preventing the export
from shutting down cleanly.

To resolve this, we schedule a Bottom Half (BH) for each FUSE queue
during the export shutdown phase. The BH closes the fuse_fd to prevent
race conditions, while the session is unmounted during the remainder of
the shutdown sequence. This explicitly aborts all pending SQEs in the
kernel, forcing the corresponding CQEs to return. This triggers the
release of held references, allowing the export to be freed safely.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c | 100 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c117e081cd..abae83041b 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -934,6 +934,57 @@ static void read_from_fuse_fd(void *opaque)
     qemu_coroutine_enter(co);
 }

+#ifdef CONFIG_LINUX_IO_URING
+static void fuse_export_delete_uring(FuseExport *exp)
+{
+    exp->is_uring = false;
+    exp->uring_started = false;
+
+    for (int i = 0; i < exp->num_uring_queues; i++) {
+        FuseUringQueue *rq = &exp->uring_queues[i];
+
+        for (int j = 0; j < FUSE_DEFAULT_URING_QUEUE_DEPTH; j++) {
+            g_free(rq->ent[j].req_payload);
+        }
+        g_free(rq->ent);
+    }
+
+    g_free(exp->uring_queues);
+}
+#endif
+
+/**
+ * The Linux kernel currently lacks support for asynchronous cancellation
+ * of FUSE-over-io_uring SQEs. This can lead to a race where an IOThread may
+ * access fuse_fd after it is closed but before pending SQEs are canceled,
+ * potentially operating on a newly reused file descriptor.
+ *
+ * Therefore, schedule a BH in the IOThread to close and invalidate fuse_fd,
+ * to avoid races on fuse_fd.
+ */
+#ifdef CONFIG_LINUX_IO_URING
+static void close_fuse_fd(void *opaque)
+{
+    FuseQueue *q = opaque;
+
+    if (q->fuse_fd >= 0) {
+        close(q->fuse_fd);
+        q->fuse_fd = -1;
+    }
+}
+#endif
+
+/**
+ * During exit in FUSE-over-io_uring mode, qemu-storage-daemon requests
+ * shutdown in main() and then immediately tears down the block export.
+ * However, SQEs already submitted under FUSE-over-io_uring may still complete
+ * and generate CQEs that continue to hold references to the block export,
+ * preventing it from being freed cleanly.
+ *
+ * Since the Linux kernel currently lacks support for asynchronous cancellation
+ * of FUSE-over-io_uring SQEs, this function aborts the connection and cancels
+ * all pending SQEs to ensure a safe teardown.
+ */
 static void fuse_export_shutdown(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
@@ -949,18 +1000,42 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
          */
         g_hash_table_remove(exports, exp->mountpoint);
     }
+
+#ifdef CONFIG_LINUX_IO_URING
+    if (exp->uring_started) {
+        for (size_t i = 0; i < exp->num_fuse_queues; i++) {
+            FuseQueue *q = &exp->queues[i];
+
+            /* Queue 0's FD belongs to the FUSE session */
+            if (i > 0) {
+                aio_bh_schedule_oneshot(q->ctx, close_fuse_fd, q);
+            }
+        }
+
+        /* To cancel all pending SQEs */
+        if (exp->fuse_session) {
+            if (exp->mounted) {
+                fuse_session_unmount(exp->fuse_session);
+            }
+            fuse_session_destroy(exp->fuse_session);
+        }
+        g_free(exp->mountpoint);
+    }
+#endif
 }

 static void fuse_export_delete(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);

-    for (int i = 0; i < exp->num_fuse_queues; i++) {
+    for (size_t i = 0; i < exp->num_fuse_queues; i++) {
         FuseQueue *q = &exp->queues[i];

-        /* Queue 0's FD belongs to the FUSE session */
-        if (i > 0 && q->fuse_fd >= 0) {
-            close(q->fuse_fd);
+        if (!exp->uring_started) {
+            /* Queue 0's FD belongs to the FUSE session */
+            if (i > 0 && q->fuse_fd >= 0) {
+                close(q->fuse_fd);
+            }
         }
         if (q->spillover_buf) {
             qemu_vfree(q->spillover_buf);
@@ -968,15 +1043,20 @@ static void fuse_export_delete(BlockExport *blk_exp)
     }
     g_free(exp->queues);

-    if (exp->fuse_session) {
-        if (exp->mounted) {
-            fuse_session_unmount(exp->fuse_session);
+    if (exp->uring_started) {
+#ifdef CONFIG_LINUX_IO_URING
+        fuse_export_delete_uring(exp);
+#endif
+    } else {
+        if (exp->fuse_session) {
+            if (exp->mounted) {
+                fuse_session_unmount(exp->fuse_session);
+            }
+            fuse_session_destroy(exp->fuse_session);
         }

-        fuse_session_destroy(exp->fuse_session);
+        g_free(exp->mountpoint);
     }
-
-    g_free(exp->mountpoint);
 }

 /**
--
2.43.0


