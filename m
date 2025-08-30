Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B62CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNqE-0000MB-4x; Sat, 30 Aug 2025 11:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg3-0003as-VW; Fri, 29 Aug 2025 22:50:51 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg1-00087L-Bu; Fri, 29 Aug 2025 22:50:51 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7fd454e65cdso100275485a.2; 
 Fri, 29 Aug 2025 19:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756522248; x=1757127048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3cm0Mg08qHhHYH4vjziiJMKFR53qXZs+LCPZ4kO6b4=;
 b=jGVuTtrPgH51kBPoitQbSPItYsrSqJK008uQtHVrrTxiJceMnSM4PqP/HMWPfWGkUV
 gu4B3guORIJjKkN8217syqjXSdD7DJ2Cw8wmfpuZSNiCkKGK8SKK3+MrRqWVsSygNQGN
 aJ4dvcYvM6RSCGD9J+7FrY8DZMvhCe4DMOlTe8YAVq4mDh6wYFc3NaPrSEn2THoyja6u
 9Reis9IT+6fELUAK665nbWmd4qZxZRnspi73r2WLrsyUgcPYgJWVjD850DPSiRJwZXDK
 eKJC/l271NUlWumsuVDIwdFcIsCqARlvyKM70z6T1uPz5/IFGVEGxopIe9QY+SfTvkfE
 0DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756522248; x=1757127048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3cm0Mg08qHhHYH4vjziiJMKFR53qXZs+LCPZ4kO6b4=;
 b=sgVYkrh7wj8O1eLxXhyjxY2k8aHXlZUIDwD4EPFetzsWQCieCKkS3FQetV1gLONo2U
 X2E0ws/73H4KyQNgpOl6DtbVSzB5FLpvNIhyEiMRK6BKqP+3nCniGZ2WKC7SdGBW5IW1
 9PA3h337lRvtUW9a0L7SDJdkWkQZOJo2rsvLl7a4f5Cnnl6xic+ObXWcpDeFVSXtG19x
 WuoNgOUQag+pNK3l4+O4mKug1aT/kMtKim2ZkG0p4Dg9OcJP2RXeBL7dxUepX8+5bhxr
 cmRodm5nxl+qBI4Wf1/xta6hCl+XtnF/wr+TuIItFbLeWSUR56IkB36gVSgReimEUpkw
 B3Ug==
X-Gm-Message-State: AOJu0Yyp+MchIrSHAKo12Qfm9mNPG8keD/8wWOGfpfQ8WqY/w/AGUpKY
 u6lSkbrCZLElTk8Cf9B9lEPF9mQCF63iKLc990MPxVn0KVTvvLxyDHkWXheL6Q==
X-Gm-Gg: ASbGnctwTEdMHasVYdoiXqrguKVwEwZYEPz6DhZtQGdJUZnJgcAipx9xpNBRvUwk+sy
 RXMVBUVQanVTQfNEbNMaO3EA0Q5LVO6RK0bvK+e8Gq0+bQxl0hUFCXjoGgsR/LZqpl4bb93UopY
 rJSI1L4C1H3qFAwLdk0Gygt8zuYh/pk4miUaJecj0frVgZcREWR8zzo4EW7yqmLuMLSc3SXylz4
 FfLHW482oKpWxKeOYbWmOfDN2RybvIRBv3WcE7BIEx/SpPnq8R01bCNGqpFbooehD0fO/MxqIE4
 wSAoBN+gKXCp2Y8hVxCq3rlcgjyo4TuMv372eWn5dNNRENlrU0EH2H8KLG38tbBGKp8I9Q7+gc0
 0cfM9UlVkP1epE7g+LhMRGXpl0vf8Gca/o9NYfxXKWvkqxBvwtX7WVGGo0EKhYl4v9h/MHs9VV+
 Ljee4toOu2GtfQulF6
X-Google-Smtp-Source: AGHT+IGm5K3vhxn/n2Iuhyh9GwzoTKCBXM4mGj0Uu7vc/4P+n2Idoa5ygxR+fWN6Qt9MfFUKK2jbOg==
X-Received: by 2002:a05:620a:4016:b0:7e8:2604:bdab with SMTP id
 af79cd13be357-7ff2b0d75f3mr88206485a.47.1756522247554; 
 Fri, 29 Aug 2025 19:50:47 -0700 (PDT)
Received: from localhost.localdomain
 (wn-campus-nat-129-97-124-90.dynamic.uwaterloo.ca. [129.97.124.90])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0eacf1b4sm299457085a.21.2025.08.29.19.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 19:50:47 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 1/4] export/fuse: add opt to enable FUSE-over-io_uring
Date: Fri, 29 Aug 2025 22:50:22 -0400
Message-ID: <20250830025025.3610-2-hibriansong@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250830025025.3610-1-hibriansong@gmail.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x735.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds a new export option for storage-export-daemon to enable
FUSE-over-io_uring via the switch io-uring=on|off (disableby default).
It also implements the protocol handshake with the Linux kernel
during the FUSE-over-io_uring initialization phase.

See: https://docs.kernel.org/filesystems/fuse-io-uring.html

The kernel documentation describes in detail how FUSE-over-io_uring
works. This patch implements the Initial SQE stage shown in thediagram:
it initializes one queue per IOThread, each currently supporting a
single submission queue entry (SQE). When the FUSE driver sends the
first FUSE request (FUSE_INIT), storage-export-daemon calls
fuse_uring_start() to complete initialization, ultimately submitting
the SQE with the FUSE_IO_URING_CMD_REGISTER command to confirm
successful initialization with the kernel.

We also added support for multiple IOThreads. The current Linux kernel
requires registering $(nproc) queues when setting up FUSE-over-io_uring
To let users customize the number of FUSE Queues (i.e., IOThreads),
we first create nproc Ring Queues as required by the kernel, then
distribute them in a round-robin manner to the FUSE Queues for
registration. In addition, to support multiple in-flight requests,
we configure each Ring Queue with FUSE_DEFAULT_RING_QUEUE_DEPTH
entries/requests.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c                  | 310 +++++++++++++++++++++++++--
 docs/tools/qemu-storage-daemon.rst   |  11 +-
 qapi/block-export.json               |   5 +-
 storage-daemon/qemu-storage-daemon.c |   1 +
 util/fdmon-io_uring.c                |   5 +-
 5 files changed, 309 insertions(+), 23 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c0ad4696ce..19bf9e5f74 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -48,6 +48,9 @@
 #include <linux/fs.h>
 #endif
 
+/* room needed in buffer to accommodate header */
+#define FUSE_BUFFER_HEADER_SIZE 0x1000
+
 /* Prevent overly long bounce buffer allocations */
 #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 /*
@@ -63,12 +66,59 @@
     (FUSE_MAX_WRITE_BYTES - FUSE_IN_PLACE_WRITE_BYTES)
 
 typedef struct FuseExport FuseExport;
+typedef struct FuseQueue FuseQueue;
+
+#ifdef CONFIG_LINUX_IO_URING
+#define FUSE_DEFAULT_RING_QUEUE_DEPTH 64
+#define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
+
+typedef struct FuseRingQueue FuseRingQueue;
+typedef struct FuseRingEnt {
+    /* back pointer */
+    FuseRingQueue *rq;
+
+    /* commit id of a fuse request */
+    uint64_t req_commit_id;
+
+    /* fuse request header and payload */
+    struct fuse_uring_req_header req_header;
+    void *op_payload;
+    size_t req_payload_sz;
+
+    /* The vector passed to the kernel */
+    struct iovec iov[2];
+
+    CqeHandler fuse_cqe_handler;
+} FuseRingEnt;
+
+struct FuseRingQueue {
+    int rqid;
+
+    /* back pointer */
+    FuseQueue *q;
+    FuseRingEnt *ent;
+
+    /* List entry for ring_queues */
+    QLIST_ENTRY(FuseRingQueue) next;
+};
+
+/*
+ * Round-robin distribution of ring queues across FUSE queues.
+ * This structure manages the mapping between kernel ring queues and user
+ * FUSE queues.
+ */
+typedef struct FuseRingQueueManager {
+    FuseRingQueue *ring_queues;
+    int num_ring_queues;
+    int num_fuse_queues;
+} FuseRingQueueManager;
+#endif
 
 /*
  * One FUSE "queue", representing one FUSE FD from which requests are fetched
  * and processed.  Each queue is tied to an AioContext.
  */
-typedef struct FuseQueue {
+struct FuseQueue {
     FuseExport *exp;
 
     AioContext *ctx;
@@ -109,15 +159,11 @@ typedef struct FuseQueue {
      * Free this buffer with qemu_vfree().
      */
     void *spillover_buf;
-} FuseQueue;
 
-/*
- * Verify that FuseQueue.request_buf plus the spill-over buffer together
- * are big enough to be accepted by the FUSE kernel driver.
- */
-QEMU_BUILD_BUG_ON(sizeof(((FuseQueue *)0)->request_buf) +
-                  FUSE_SPILLOVER_BUF_SIZE <
-                  FUSE_MIN_READ_BUFFER);
+#ifdef CONFIG_LINUX_IO_URING
+    QLIST_HEAD(, FuseRingQueue) ring_queue_list;
+#endif
+};
 
 struct FuseExport {
     BlockExport common;
@@ -133,7 +179,7 @@ struct FuseExport {
      */
     bool halted;
 
-    int num_queues;
+    size_t num_queues;
     FuseQueue *queues;
     /*
      * True if this export should follow the generic export's AioContext.
@@ -149,6 +195,12 @@ struct FuseExport {
     /* Whether allow_other was used as a mount option or not */
     bool allow_other;
 
+#ifdef CONFIG_LINUX_IO_URING
+    bool is_uring;
+    size_t ring_queue_depth;
+    FuseRingQueueManager *ring_queue_manager;
+#endif
+
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
@@ -205,7 +257,7 @@ static void fuse_attach_handlers(FuseExport *exp)
         return;
     }
 
-    for (int i = 0; i < exp->num_queues; i++) {
+    for (size_t i = 0; i < exp->num_queues; i++) {
         aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
                            read_from_fuse_fd, NULL, NULL, NULL,
                            &exp->queues[i]);
@@ -257,6 +309,189 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
     .drained_poll  = fuse_export_drained_poll,
 };
 
+#ifdef CONFIG_LINUX_IO_URING
+static void fuse_uring_sqe_set_req_data(struct fuse_uring_cmd_req *req,
+                    const unsigned int rqid,
+                    const unsigned int commit_id)
+{
+    req->qid = rqid;
+    req->commit_id = commit_id;
+    req->flags = 0;
+}
+
+static void fuse_uring_sqe_prepare(struct io_uring_sqe *sqe, FuseQueue *q,
+               __u32 cmd_op)
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
+    FuseRingEnt *ent = opaque;
+    struct fuse_uring_cmd_req *req = (void *)&sqe->cmd[0];
+
+    fuse_uring_sqe_prepare(sqe, ent->rq->q, FUSE_IO_URING_CMD_REGISTER);
+
+    sqe->addr = (uint64_t)(ent->iov);
+    sqe->len = 2;
+
+    fuse_uring_sqe_set_req_data(req, ent->rq->rqid, 0);
+}
+
+static void fuse_uring_submit_register(void *opaque)
+{
+    FuseRingEnt *ent = opaque;
+    FuseExport *exp = ent->rq->q->exp;
+
+
+    aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_handler));
+}
+
+/**
+ * Distribute ring queues across FUSE queues using round-robin algorithm.
+ * This ensures even distribution of kernel ring queues across user-specified
+ * FUSE queues.
+ */
+static
+FuseRingQueueManager *fuse_ring_queue_manager_create(int num_fuse_queues,
+                                                    size_t ring_queue_depth,
+                                                    size_t bufsize)
+{
+    int num_ring_queues = get_nprocs();
+    FuseRingQueueManager *manager = g_new(FuseRingQueueManager, 1);
+
+    if (!manager) {
+        return NULL;
+    }
+
+    manager->ring_queues = g_new(FuseRingQueue, num_ring_queues);
+    manager->num_ring_queues = num_ring_queues;
+    manager->num_fuse_queues = num_fuse_queues;
+
+    if (!manager->ring_queues) {
+        g_free(manager);
+        return NULL;
+    }
+
+    for (int i = 0; i < num_ring_queues; i++) {
+        FuseRingQueue *rq = &manager->ring_queues[i];
+        rq->rqid = i;
+        rq->ent = g_new(FuseRingEnt, ring_queue_depth);
+
+        if (!rq->ent) {
+            for (int j = 0; j < i; j++) {
+                g_free(manager->ring_queues[j].ent);
+            }
+            g_free(manager->ring_queues);
+            g_free(manager);
+            return NULL;
+        }
+
+        for (size_t j = 0; j < ring_queue_depth; j++) {
+            FuseRingEnt *ent = &rq->ent[j];
+            ent->rq = rq;
+            ent->req_payload_sz = bufsize - FUSE_BUFFER_HEADER_SIZE;
+            ent->op_payload = g_malloc0(ent->req_payload_sz);
+
+            if (!ent->op_payload) {
+                for (size_t k = 0; k < j; k++) {
+                    g_free(rq->ent[k].op_payload);
+                }
+                g_free(rq->ent);
+                for (int k = 0; k < i; k++) {
+                    g_free(manager->ring_queues[k].ent);
+                }
+                g_free(manager->ring_queues);
+                g_free(manager);
+                return NULL;
+            }
+
+            ent->iov[0] = (struct iovec) {
+                &(ent->req_header),
+                sizeof(struct fuse_uring_req_header)
+            };
+            ent->iov[1] = (struct iovec) {
+                ent->op_payload,
+                ent->req_payload_sz
+            };
+
+            ent->fuse_cqe_handler.cb = fuse_uring_cqe_handler;
+        }
+    }
+
+    return manager;
+}
+
+static
+void fuse_distribute_ring_queues(FuseExport *exp, FuseRingQueueManager *manager)
+{
+    int queue_index = 0;
+
+    for (int i = 0; i < manager->num_ring_queues; i++) {
+        FuseRingQueue *rq = &manager->ring_queues[i];
+
+        rq->q = &exp->queues[queue_index];
+        QLIST_INSERT_HEAD(&(rq->q->ring_queue_list), rq, next);
+
+        queue_index = (queue_index + 1) % manager->num_fuse_queues;
+    }
+}
+
+static
+void fuse_schedule_ring_queue_registrations(FuseExport *exp,
+                                            FuseRingQueueManager *manager)
+{
+    for (int i = 0; i < manager->num_fuse_queues; i++) {
+        FuseQueue *q = &exp->queues[i];
+        FuseRingQueue *rq;
+
+        QLIST_FOREACH(rq, &q->ring_queue_list, next) {
+            for (int j = 0; j < exp->ring_queue_depth; j++) {
+                aio_bh_schedule_oneshot(q->ctx, fuse_uring_submit_register,
+                                        &(rq->ent[j]));
+            }
+        }
+    }
+}
+
+static void fuse_uring_start(FuseExport *exp, struct fuse_init_out *out)
+{
+    /*
+     * Since we didn't enable the FUSE_MAX_PAGES feature, the value of
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
+    exp->ring_queue_manager = fuse_ring_queue_manager_create(
+        exp->num_queues, exp->ring_queue_depth, bufsize);
+
+    if (!exp->ring_queue_manager) {
+        error_report("Failed to create ring queue manager");
+        return;
+    }
+
+    /* Distribute ring queues across FUSE queues using round-robin */
+    fuse_distribute_ring_queues(exp, exp->ring_queue_manager);
+
+    fuse_schedule_ring_queue_registrations(exp, exp->ring_queue_manager);
+}
+#endif
+
 static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
                               AioContext *const *multithread,
@@ -270,6 +505,11 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
 
+#ifdef CONFIG_LINUX_IO_URING
+    exp->is_uring = args->io_uring;
+    exp->ring_queue_depth = FUSE_DEFAULT_RING_QUEUE_DEPTH;
+#endif
+
     if (multithread) {
         /* Guaranteed by common export code */
         assert(mt_count >= 1);
@@ -283,6 +523,10 @@ static int fuse_export_create(BlockExport *blk_exp,
                 .exp = exp,
                 .ctx = multithread[i],
                 .fuse_fd = -1,
+#ifdef CONFIG_LINUX_IO_URING
+                .ring_queue_list =
+                    QLIST_HEAD_INITIALIZER(exp->queues[i].ring_queue_list),
+#endif
             };
         }
     } else {
@@ -296,6 +540,10 @@ static int fuse_export_create(BlockExport *blk_exp,
             .exp = exp,
             .ctx = exp->common.ctx,
             .fuse_fd = -1,
+#ifdef CONFIG_LINUX_IO_URING
+            .ring_queue_list =
+                QLIST_HEAD_INITIALIZER(exp->queues[0].ring_queue_list),
+#endif
         };
     }
 
@@ -685,17 +933,39 @@ static bool is_regular_file(const char *path, Error **errp)
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
+    ssize_t ret = 0;
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
+            ret = -ENODEV;
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
@@ -717,7 +987,7 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
         .map_alignment = 0,
     };
 
-    return sizeof(*out);
+    return ret < 0 ? ret : sizeof(*out);
 }
 
 /**
@@ -1506,6 +1776,14 @@ fuse_co_process_request(FuseQueue *q, void *spillover_buf)
         fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
                                 out_data_buffer, ret);
         qemu_vfree(out_data_buffer);
+#ifdef CONFIG_LINUX_IO_URING
+    /* Handle FUSE-over-io_uring initialization */
+    if (unlikely(opcode == FUSE_INIT && exp->is_uring)) {
+        struct fuse_init_out *out =
+            (struct fuse_init_out *)FUSE_OUT_OP_STRUCT(out_buf);
+        fuse_uring_start(exp, out);
+    }
+#endif
     } else {
         fuse_write_response(q->fuse_fd, req_id, out_hdr,
                             ret < 0 ? ret : 0,
diff --git a/docs/tools/qemu-storage-daemon.rst b/docs/tools/qemu-storage-daemon.rst
index 35ab2d7807..c5076101e0 100644
--- a/docs/tools/qemu-storage-daemon.rst
+++ b/docs/tools/qemu-storage-daemon.rst
@@ -78,7 +78,7 @@ Standard options:
 .. option:: --export [type=]nbd,id=<id>,node-name=<node-name>[,name=<export-name>][,writable=on|off][,bitmap=<name>]
   --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=unix,addr.path=<socket-path>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
   --export [type=]vhost-user-blk,id=<id>,node-name=<node-name>,addr.type=fd,addr.str=<fd>[,writable=on|off][,logical-block-size=<block-size>][,num-queues=<num-queues>]
-  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto]
+  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>[,growable=on|off][,writable=on|off][,allow-other=on|off|auto][,io-uring=on|off]
   --export [type=]vduse-blk,id=<id>,node-name=<node-name>,name=<vduse-name>[,writable=on|off][,num-queues=<num-queues>][,queue-size=<queue-size>][,logical-block-size=<block-size>][,serial=<serial-number>]
 
   is a block export definition. ``node-name`` is the block node that should be
@@ -111,10 +111,11 @@ Standard options:
   that enabling this option as a non-root user requires enabling the
   user_allow_other option in the global fuse.conf configuration file.  Setting
   ``allow-other`` to auto (the default) will try enabling this option, and on
-  error fall back to disabling it.
-
-  The ``vduse-blk`` export type takes a ``name`` (must be unique across the host)
-  to create the VDUSE device.
+  error fall back to disabling it. Once ``io-uring`` is enabled (off by default),
+  the FUSE-over-io_uring-related settings will be initialized to bypass the
+  traditional /dev/fuse communication mechanism and instead use io_uring to
+  handle FUSE operations. The ``vduse-blk`` export type takes a ``name``
+  (must be unique across the host) to create the VDUSE device.
   ``num-queues`` sets the number of virtqueues (the default is 1).
   ``queue-size`` sets the virtqueue descriptor table size (the default is 256).
 
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 9ae703ad01..37f2fc47e2 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -184,12 +184,15 @@
 #     mount the export with allow_other, and if that fails, try again
 #     without.  (since 6.1; default: auto)
 #
+# @io-uring: Use FUSE-over-io-uring.  (since 10.2; default: false)
+#
 # Since: 6.0
 ##
 { 'struct': 'BlockExportOptionsFuse',
   'data': { 'mountpoint': 'str',
             '*growable': 'bool',
-            '*allow-other': 'FuseExportAllowOther' },
+            '*allow-other': 'FuseExportAllowOther',
+            '*io-uring': 'bool' },
   'if': 'CONFIG_FUSE' }
 
 ##
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index eb72561358..0cd4cd2b58 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -107,6 +107,7 @@ static void help(void)
 #ifdef CONFIG_FUSE
 "  --export [type=]fuse,id=<id>,node-name=<node-name>,mountpoint=<file>\n"
 "           [,growable=on|off][,writable=on|off][,allow-other=on|off|auto]\n"
+"           [,io-uring=on|off]"
 "                         export the specified block node over FUSE\n"
 "\n"
 #endif /* CONFIG_FUSE */
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index d2433d1d99..68d3fe8e01 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -452,10 +452,13 @@ static const FDMonOps fdmon_io_uring_ops = {
 void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
     int ret;
+    int flags;
 
     ctx->io_uring_fd_tag = NULL;
+    flags = IORING_SETUP_SQE128;
 
-    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
+    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES,
+                            &ctx->fdmon_io_uring, flags);
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Failed to initialize io_uring");
         return;
-- 
2.45.2


