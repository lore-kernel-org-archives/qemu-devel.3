Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2116EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8S-000790-Bu; Sat, 07 Feb 2026 07:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8Q-000783-6z
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:09:58 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8M-0002sV-Nr
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:09:57 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35621aa8c7fso132049a91.2
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466193; x=1771070993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mn0RB42m9zsHgb+ce7030OB0UfjmmGHf633GU5gQoUo=;
 b=eJfUJj05Pc8AxFXL/9BSj5LIRwOiLT2mPA7JeeMJH4ACXYsqkJOLIDR0H8h514IA9W
 ZFHdi0wz+X98A8thMi9lVoCzOWD8QtqumN2gtmj8HgUcYNfC8xTRvBmwsZWb8oIxTv+0
 uVBwrU0Trj10UmeCfkv3rEMovtfHdLysmPmahhFKYaOSe8DZOuYpGk42GMZV0OhfuHE7
 1Z+1aTTWGdxPM9zKl1GiR3Am/sEN9FGKy+a0yVeNJWEg1xHMvjiRj6L6g0JxAB/8EzsP
 +SayyyY0DdeoZzqsu5v0AE3FDERX1YTlJ08Ht1W9O67G2Wrd/fjRsornlyLa+SxGJOCm
 SFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466193; x=1771070993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mn0RB42m9zsHgb+ce7030OB0UfjmmGHf633GU5gQoUo=;
 b=JnU9XLh/bm7fXS4DbynF4395eqpdWUscvCAzkzN4O+OSUJdZ9R/YLT+oVEIzv4ZSZK
 hrX9Qui1VIxCNyrqnI71nAId8Gxb3vkWFjCEfjYNojrCKZNJ1oX4ZCGkWvgwXnvEixSt
 ByyXARn/FI9DClib57Dq5V1GB3+W8zfdLo8nkSQfb8/M/30IuGx1ug4gHd49Sbpl6C0f
 fqCuDApjT7Kvsa1cIMVrW/XKYVAsoAwtyhkMA9a2KhLUvnB0cMKNUBdEZiY5yn233jUz
 MDlyREPXYx4r7xz+CJUN5VMNt4ROF3K2n0r9eHPqknZKmtbBD/eOHdbONRpWiC8OR/dv
 3yFA==
X-Gm-Message-State: AOJu0YxQQzGm5o9lsElBBU1TTZzEZigUnplwEHbNsbQw/QO3Rk+RIm/U
 0bWoZtHuPDgGZpC0dGf/dx4gVrEprl4J8/rFZchv8gnFH1CrYMLjN22iyG64ZdanuMEJpw==
X-Gm-Gg: AZuq6aKolsGMPPxqo+vG6z+81SOoTHCf5xYaTG9oI/GGDMe5ztklitU7ciUGsegxLP+
 KHPMn+mMO2rz+n6vLyNZeWnut/wcFROyp50CUnglSZbB7OrifLY1WNOgld0kdE8CxGbjQ5/6o+C
 xihHG3pqkOK5QP9E6r9he2BOnfjQmMQUEEAuXZz8eeS3Ggefg5mpUqayBDwFZWfcVHKyqQroqjx
 JkhKtE3JyjCmQecbY4KezUOpYOLSKYZ/lEPqaLFFB0tRO3jGO2piD46QELni/Q5h+4uexUo+Ghw
 1qkoDQ1eQyQkdBKP8n6YSltToXvjcJYPQxPB3YswZXpYBff0VugpRdb5PfnYIWhv0ocYeZk5v2G
 T7QLFKNh0/8sxFbI2Au4jQNrXmaHVcC8F1zxMxypMOkM86zMByiGl3OifCEl9W4pz0Yb/mCB7MT
 F2mVGgoCHYyzPd3nPpjq+Bp7A+K0Hh6uwzsjt7
X-Received: by 2002:a17:90b:350d:b0:34e:5516:6655 with SMTP id
 98e67ed59e1d1-354b3c5bb83mr4950926a91.9.1770466193180; 
 Sat, 07 Feb 2026 04:09:53 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:09:52 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [Patch v4 2/7] fuse: io_uring mode init
Date: Sat,  7 Feb 2026 20:08:56 +0800
Message-ID: <20260207120901.17222-3-hibriansong@gmail.com>
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

The kernel documentation describes in detail how FUSE-over-io_uring
works: https://docs.kernel.org/filesystems/fuse/fuse-io-uring.html

This patch utilizes the legacy FUSE interface (/dev/fuse) during the
initialization phase to perform a protocol handshake with the kernel
driver. Once FUSE-over-io_uring support is negotiated, the
FUSE_IO_URING_CMD_REGISTER command is submitted to register the
io_uring queues.

Support for multiple IOThreads is also added to boost concurrency.
Since the current Linux kernel implementation requires registering one
uring queue per CPU core, we allocate the required number of
queues (nproc) and distribute them across the user-specified IOThreads
in a round-robin manner. To support concurrent in-flight requests per
io_uring queue, each ring queue is configured with
FUSE_DEFAULT_RING_QUEUE_DEPTH entries.

Specifically, the workflow is as follows:

- Initialize the io_uring queue depth when creating storage exports.
- Upon receiving a FUSE initialization request via the legacy path:
    - Perform the protocol handshake to confirm feature support.
    - Complete FUSE-over-io_uring registration, which includes:
        - Pre-allocating uring queue entries and payload buffers.
        - Binding the CQE handler to process incoming file operations.
        - Initializing Submission Queue Entries (SQEs).
        - Distributing the uring queues across FUSE IOThreads using a
          round-robin strategy.

After successful registration, the FUSE-over-io_uring CQE handler
takes over the processing of FUSE requests.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c | 430 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 414 insertions(+), 16 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c0ad4696ce..ae7490b2a1 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -2,6 +2,7 @@
  * Present a block device as a raw image through FUSE
  *
  * Copyright (c) 2020, 2025 Hanna Czenczek <hreitz@redhat.com>
+ * Copyright (c) 2025, 2026 Brian Song <hibriansong@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -39,6 +40,7 @@

 #include "standard-headers/linux/fuse.h"
 #include <sys/ioctl.h>
+#include <sys/sysinfo.h>

 #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
 #include <linux/falloc.h>
@@ -63,12 +65,69 @@
     (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)

 typedef struct FuseExport FuseExport;
+typedef struct FuseQueue FuseQueue;
+
+#ifdef CONFIG_LINUX_IO_URING
+#define FUSE_DEFAULT_URING_QUEUE_DEPTH 64
+#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
+/*
+ * Under FUSE-over-io_uring mode:
+ *
+ * Each FuseUringEnt represents a FUSE request. It exposes two iovec entries for
+ * communication between the kernel driver and the userspace server:
+ *
+ * - The first iovec contains the request header (FUSE_BUFFER_HEADER_SIZE),
+ *   holding metadata describing the request.
+ * - The second iovec contains the payload, used for READ/WRITE operations.
+ */
+#define FUSE_BUFFER_HEADER_SIZE 0x1000
+
+typedef struct FuseUringQueue FuseUringQueue;
+
+typedef struct FuseUringEnt {
+    /* back pointer */
+    FuseUringQueue *rq;
+
+    /* commit id of a fuse request */
+    uint64_t req_commit_id;
+
+    /* fuse request header and payload */
+    struct fuse_uring_req_header req_header;
+    void *req_payload;
+    size_t req_payload_sz;
+
+    /* used for retry */
+    enum fuse_uring_cmd last_cmd;
+
+    /* The vector passed to the kernel */
+    struct iovec iov[2];
+
+    CqeHandler fuse_cqe_handler;
+} FuseUringEnt;
+
+/*
+ * In the current Linux kernel, FUSE-over-io_uring requires registering one
+ * FuseUringQueue per host CPU. These queues are allocated during setup
+ * and distributed to user-specified IOThreads (FuseQueue) in a round-robin
+ * fashion.
+ */
+struct FuseUringQueue {
+    int rqid;
+
+    /* back pointer */
+    FuseQueue *q;
+    FuseUringEnt *ent;
+
+    /* List entry for uring_queues */
+    QLIST_ENTRY(FuseUringQueue) next;
+};
+#endif /* CONFIG_LINUX_IO_URING */

 /*
  * One FUSE "queue", representing one FUSE FD from which requests are fetched
  * and processed.  Each queue is tied to an AioContext.
  */
-typedef struct FuseQueue {
+struct FuseQueue {
     FuseExport *exp;

     AioContext *ctx;
@@ -109,7 +168,11 @@ typedef struct FuseQueue {
      * Free this buffer with qemu_vfree().
      */
     void *spillover_buf;
-} FuseQueue;
+
+#ifdef CONFIG_LINUX_IO_URING
+    QLIST_HEAD(, FuseUringQueue) uring_queue_list;
+#endif
+};

 /*
  * Verify that FuseQueue.request_buf plus the spill-over buffer together
@@ -133,7 +196,7 @@ struct FuseExport {
      */
     bool halted;

-    int num_queues;
+    int num_fuse_queues;
     FuseQueue *queues;
     /*
      * True if this export should follow the generic export's AioContext.
@@ -149,6 +212,17 @@ struct FuseExport {
     /* Whether allow_other was used as a mount option or not */
     bool allow_other;

+    /* Whether to enable FUSE-over-io_uring */
+    bool is_uring;
+    /* Whether FUSE-over-io_uring is active */
+    bool uring_started;
+
+#ifdef CONFIG_LINUX_IO_URING
+    int uring_queue_depth;
+    int num_uring_queues;
+    FuseUringQueue *uring_queues;
+#endif
+
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
@@ -205,7 +279,7 @@ static void fuse_attach_handlers(FuseExport *exp)
         return;
     }

-    for (int i = 0; i < exp->num_queues; i++) {
+    for (int i = 0; i < exp->num_fuse_queues; i++) {
         aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
                            read_from_fuse_fd, NULL, NULL, NULL,
                            &exp->queues[i]);
@@ -218,7 +292,7 @@ static void fuse_attach_handlers(FuseExport *exp)
  */
 static void fuse_detach_handlers(FuseExport *exp)
 {
-    for (int i = 0; i < exp->num_queues; i++) {
+    for (int i = 0; i < exp->num_fuse_queues; i++) {
         aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
                            NULL, NULL, NULL, NULL, NULL);
     }
@@ -237,7 +311,7 @@ static void fuse_export_drained_end(void *opaque)
     /* Refresh AioContext in case it changed */
     exp->common.ctx = blk_get_aio_context(exp->common.blk);
     if (exp->follow_aio_context) {
-        assert(exp->num_queues == 1);
+        assert(exp->num_fuse_queues == 1);
         exp->queues[0].ctx = exp->common.ctx;
     }

@@ -257,6 +331,248 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
     .drained_poll  = fuse_export_drained_poll,
 };

+#ifdef CONFIG_LINUX_IO_URING
+static void coroutine_fn fuse_uring_co_process_request(FuseUringEnt *ent);
+static void fuse_uring_resubmit(struct io_uring_sqe *sqe, void *opaque);
+
+/**
+ * fuse_inc_in_flight() / fuse_dec_in_flight():
+ * Wrap the lifecycle of FUSE requests being processed. This ensures the
+ * block layer's drain operation waits for active requests to complete
+ * and prevents the export from being deleted prematurely.
+ *
+ * blk_exp_ref() / blk_exp_unref():
+ * Prevent the export from being deleted while there are outstanding
+ * dependencies.
+ *
+ * FUSE-over-io_uring mapping details:
+ *
+ * 1. SQE/CQE Lifecycle:
+ * blk_exp_ref() is called on SQE submission, and blk_exp_unref() on
+ * CQE completion. This protects the export until the kernel is done
+ * with the entry.
+ *
+ * 2. Request Processing:
+ * The coroutine processing a FUSE request must allow the drain operation
+ * to track it.
+ *
+ * - fuse_inc_in_flight() must be called *before* the coroutine starts
+ * (i.e., before qemu_coroutine_enter).
+ * - fuse_dec_in_flight() is called after processing ends.
+ *
+ * There is a small window where a CQE is pending in an iothread
+ * but the coroutine hasn't started yet. If we don't increment in_flight
+ * early, the main thread's drain operation might see zero in-flight
+ * requests and return early, falsely assuming the section is drained
+ * even though a request is about to be processed.
+ */
+static void coroutine_fn co_fuse_uring_queue_handle_cqe(void *opaque)
+{
+    FuseUringEnt *ent = opaque;
+    FuseExport *exp = ent->rq->q->exp;
+
+    /* A uring entry returned */
+    blk_exp_unref(&exp->common);
+
+    fuse_uring_co_process_request(ent);
+
+    /* Request is no longer in flight */
+    fuse_dec_in_flight(exp);
+}
+
+static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
+{
+    Coroutine *co;
+    FuseUringEnt *ent =
+        container_of(cqe_handler, FuseUringEnt, fuse_cqe_handler);
+    FuseExport *exp = ent->rq->q->exp;
+
+    if (unlikely(exp->halted)) {
+        return;
+    }
+
+    int err = cqe_handler->cqe.res;
+
+    if (unlikely(err != 0)) {
+        switch (err) {
+        case -EAGAIN:
+        case -EINTR:
+            aio_add_sqe(fuse_uring_resubmit, ent, &ent->fuse_cqe_handler);
+            break;
+        case -ENOTCONN:
+            /* Connection already gone */
+            break;
+        default:
+            fuse_export_halt(exp);
+            break;
+        }
+
+        /* A uring entry returned */
+        blk_exp_unref(&exp->common);
+    } else {
+        co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqe, ent);
+        /* Account this request as in-flight */
+        fuse_inc_in_flight(exp);
+        qemu_coroutine_enter(co);
+    }
+}
+
+static void
+fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
+                            const unsigned int rqid,
+                            const unsigned int commit_id)
+{
+    req->qid = rqid;
+    req->commit_id = commit_id;
+    req->flags = 0;
+}
+
+static void
+fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q, __u32 cmd_op)
+{
+    sqe->opcode = IORING_OP_URING_CMD;
+
+    sqe->fd = q->fuse_fd;
+    sqe->rw_flags = 0;
+    sqe->ioprio = 0;
+    sqe->off = 0;
+
+    sqe->cmd_op = cmd_op;
+    sqe->__pad1 = 0;
+}
+
+static void fuse_uring_prep_sqe_register(struct io_uring_sqe *sqe, void *opaque)
+{
+    FuseUringEnt *ent = opaque;
+    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
+
+    ent->last_cmd = FUSE_IO_URING_CMD_REGISTER;
+    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
+
+    sqe->addr = (uint64_t)(ent->iov);
+    sqe->len = 2;
+
+    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
+}
+
+static void fuse_uring_resubmit(struct io_uring_sqe *sqe, void *opaque)
+{
+    FuseUringEnt *ent = opaque;
+    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
+
+    fuse_uring_sqe_prepare(sqe, ent->rq->q, ent->last_cmd);
+
+    switch (ent->last_cmd) {
+    case FUSE_IO_URING_CMD_REGISTER:
+        sqe->addr = (uint64_t)(ent->iov);
+        sqe->len = 2;
+        fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
+        break;
+    case FUSE_IO_URING_CMD_COMMIT_AND_FETCH:
+        fuse_uring_sqe_set_req_data(req, ent->rq->rqid, ent->req_commit_id);
+        break;
+    default:
+        error_report("Unknown command type: %d", ent->last_cmd);
+        break;
+    }
+}
+
+static void fuse_uring_submit_register(void *opaque)
+{
+    FuseUringQueue *rq = opaque;
+    FuseExport *exp = rq->q->exp;
+
+    for (int j = 0; j < exp->uring_queue_depth; j++) {
+        /* Register a uring entry */
+        blk_exp_ref(&exp->common);
+
+        aio_add_sqe(fuse_uring_prep_sqe_register, &rq->ent[j],
+                    &rq->ent[j].fuse_cqe_handler);
+    }
+}
+
+/**
+ * Distribute uring queues across FUSE queues in the round-robin manner.
+ * This ensures even distribution of kernel uring queues across user-specified
+ * FUSE queues.
+ *
+ * num_uring_queues > num_fuse_queues: Each IOThread manages multiple uring
+ * queues (multi-queue mapping).
+ * num_uring_queues < num_fuse_queues: Excess IOThreads remain idle with no
+ * assigned uring queues.
+ */
+static void fuse_uring_setup_queues(FuseExport *exp, size_t bufsize)
+{
+    int num_uring_queues = get_nprocs_conf();
+
+    exp->num_uring_queues = num_uring_queues;
+    exp->uring_queues = g_new(FuseUringQueue, num_uring_queues);
+
+    for (int i = 0; i < num_uring_queues; i++) {
+        FuseUringQueue *rq = &exp->uring_queues[i];
+        rq->rqid = i;
+        rq->ent = g_new(FuseUringEnt, exp->uring_queue_depth);
+
+        for (int j = 0; j < exp->uring_queue_depth; j++) {
+            FuseUringEnt *ent = &rq->ent[j];
+            ent->rq = rq;
+            ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
+            ent->req_payload = g_malloc0(ent->req_payload_sz);
+
+            ent->iov[0] = (struct iovec) {
+                &ent->req_header,
+                sizeof(struct fuse_uring_req_header)
+            };
+            ent->iov[1] = (struct iovec) {
+                ent->req_payload,
+                ent->req_payload_sz
+            };
+
+            ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
+        }
+
+        /* Distribute uring queues across FUSE queues */
+        rq->q = &exp->queues[i % exp->num_fuse_queues];
+        QLIST_INSERT_HEAD(&(rq->q->uring_queue_list), rq, next);
+    }
+}
+
+static void
+fuse_schedule_ring_queue_registrations(FuseExport *exp)
+{
+    for (int i = 0; i < exp->num_fuse_queues; i++) {
+        FuseQueue *q = &exp->queues[i];
+        FuseUringQueue *rq;
+
+        QLIST_FOREACH(rq, &q->uring_queue_list, next) {
+            aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_register, rq);
+        }
+    }
+}
+
+static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
+{
+    assert(!exp->uring_started);
+    exp->uring_started = true;
+
+    /*
+     * Since we dont't enable the FUSE_MAX_PAGES feature, the value of
+     * fc->max_pages should be FUSE_DEFAULT_MAX_PAGES_PER_REQ, which is set by
+     * the kernel by default. Also, max_write should not exceed
+     * FUSE_DEFAULT_MAX_PAGES_PER_REQ * PAGE_SIZE.
+     */
+    size_t bufsize = out->max_write + FUSE_BUFFER_HEADER_SIZE;
+
+    if (!(out->flags & FUSE_MAX_PAGES)) {
+        bufsize = FUSE_DEFAULT_MAX_PAGES_PER_REQ * qemu_real_host_page_size()
+                         + FUSE_BUFFER_HEADER_SIZE;
+    }
+
+    fuse_uring_setup_queues(exp, bufsize);
+    fuse_schedule_ring_queue_registrations(exp);
+}
+#endif /* CONFIG_LINUX_IO_URING */
+
 static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
                               AioContext *const *multithread,
@@ -270,12 +586,24 @@ static int fuse_export_create(BlockExport *blk_exp,

     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);

+#ifdef CONFIG_LINUX_IO_URING
+    /* TODO Add FUSE-over-io_uring Option */
+    exp->is_uring = false;
+    exp->uring_queue_depth = FUSE_DEFAULT_URING_QUEUE_DEPTH;
+#else
+    if (args->io_uring) {
+        error_setg(errp, "FUSE-over-io_uring requires CONFIG_LINUX_IO_URING");
+        return -ENOTSUP;
+    }
+    exp->is_uring = false;
+#endif
+
     if (multithread) {
         /* Guaranteed by common export code */
         assert(mt_count >= 1);

         exp->follow_aio_context = false;
-        exp->num_queues = mt_count;
+        exp->num_fuse_queues = mt_count;
         exp->queues = g_new(FuseQueue, mt_count);

         for (size_t i = 0; i < mt_count; i++) {
@@ -283,6 +611,10 @@ static int fuse_export_create(BlockExport *blk_exp,
                 .exp = exp,
                 .ctx = multithread[i],
                 .fuse_fd = -1,
+#ifdef CONFIG_LINUX_IO_URING
+                .uring_queue_list =
+                    QLIST_HEAD_INITIALIZER(exp->queues[i].uring_queue_list),
+#endif
             };
         }
     } else {
@@ -290,12 +622,16 @@ static int fuse_export_create(BlockExport *blk_exp,
         assert(mt_count == 0);

         exp->follow_aio_context = true;
-        exp->num_queues = 1;
+        exp->num_fuse_queues = 1;
         exp->queues = g_new(FuseQueue, 1);
         exp->queues[0] = (FuseQueue) {
             .exp = exp,
             .ctx = exp->common.ctx,
             .fuse_fd = -1,
+#ifdef CONFIG_LINUX_IO_URING
+            .uring_queue_list =
+                QLIST_HEAD_INITIALIZER(exp->queues[0].uring_queue_list),
+#endif
         };
     }

@@ -383,7 +719,7 @@ static int fuse_export_create(BlockExport *blk_exp,

     g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);

-    assert(exp->num_queues >= 1);
+    assert(exp->num_fuse_queues >= 1);
     exp->queues[0].fuse_fd = fuse_session_fd(exp->fuse_session);
     ret = qemu_fcntl_addfl(exp->queues[0].fuse_fd, O_NONBLOCK);
     if (ret < 0) {
@@ -391,7 +727,7 @@ static int fuse_export_create(BlockExport *blk_exp,
         goto fail;
     }

-    for (int i = 1; i < exp->num_queues; i++) {
+    for (int i = 1; i < exp->num_fuse_queues; i++) {
         int fd = clone_fuse_fd(exp->queues[0].fuse_fd, errp);
         if (fd < 0) {
             ret = fd;
@@ -618,7 +954,7 @@ static void fuse_export_delete(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);

-    for (int i = 0; i < exp->num_queues; i++) {
+    for (int i = 0; i < exp->num_fuse_queues; i++) {
         FuseQueue *q = &exp->queues[i];

         /* Queue 0's FD belongs to the FUSE session */
@@ -685,17 +1021,37 @@ static bool is_regular_file(const char *path, Error **errp)
  */
 static ssize_t coroutine_fn
 fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
-             uint32_t max_readahead, uint32_t flags)
+             uint32_t max_readahead, const struct fuse_init_in *in)
 {
-    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+    uint64_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO
+                                     | FUSE_INIT_EXT;
+    uint64_t outargflags = 0;
+    uint64_t inargflags = in->flags;
+
+    if (inargflags & FUSE_INIT_EXT) {
+        inargflags = inargflags | (uint64_t) in->flags2 << 32;
+    }
+
+#ifdef CONFIG_LINUX_IO_URING
+    if (exp->is_uring) {
+        if (inargflags & FUSE_OVER_IO_URING) {
+            supported_flags |= FUSE_OVER_IO_URING;
+        } else {
+            exp->is_uring = false;
+            return -EOPNOTSUPP;
+        }
+    }
+#endif
+
+    outargflags = inargflags & supported_flags;

     *out = (struct fuse_init_out) {
         .major = FUSE_KERNEL_VERSION,
         .minor = FUSE_KERNEL_MINOR_VERSION,
         .max_readahead = max_readahead,
         .max_write = FUSE_MAX_WRITE_BYTES,
-        .flags = flags & supported_flags,
-        .flags2 = 0,
+        .flags = outargflags,
+        .flags2 = outargflags >> 32,

         /* libfuse maximum: 2^16 - 1 */
         .max_background = UINT16_MAX,
@@ -1404,11 +1760,24 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
         req_id = in_hdr->unique;
     }

+#ifdef CONFIG_LINUX_IO_URING
+    /*
+     * Enable FUSE-over-io_uring mode if supported.
+     * FUSE_INIT is only handled in legacy mode.
+     * Failure returns -EOPNOTSUPP; success switches to io_uring path.
+     */
+    bool uring_initially_enabled = false;
+
+    if (unlikely(opcode == FUSE_INIT)) {
+        uring_initially_enabled = exp->is_uring;
+    }
+#endif
+
     switch (opcode) {
     case FUSE_INIT: {
         const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, q);
         ret = fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
-                           in->max_readahead, in->flags);
+                           in->max_readahead, in);
         break;
     }

@@ -1513,7 +1882,36 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
     }

     qemu_vfree(spillover_buf);
+
+#ifdef CONFIG_LINUX_IO_URING
+    if (unlikely(opcode == FUSE_INIT) && uring_initially_enabled) {
+        if (exp->is_uring && !exp->uring_started) {
+            /*
+             * Handle FUSE-over-io_uring initialization.
+             * If io_uring mode was requested for this export but it has not
+             * been started yet, start it now.
+             */
+            struct fuse_init_out *out = FUSE_OUT_OP_STRUCT(init, out_buf);
+            fuse_uring_start(exp, out);
+        } else if (ret == -EOPNOTSUPP) {
+            /*
+             * If io_uring was requested but the kernel does not support it,
+             * halt the export.
+             */
+            error_report("System doesn't support FUSE-over-io_uring");
+            fuse_export_halt(exp);
+        }
+    }
+#endif
+}
+
+#ifdef CONFIG_LINUX_IO_URING
+static void coroutine_fn fuse_uring_co_process_request(FuseUringEnt *ent)
+{
+    /* TODO */
+    (void)ent;
 }
+#endif /* CONFIG_LINUX_IO_URING */

 const BlockExportDriver blk_exp_fuse = {
     .type               = BLOCK_EXPORT_TYPE_FUSE,
--
2.43.0


