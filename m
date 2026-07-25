Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4395EC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 17:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnflo-0007bz-L5; Sat, 25 Jul 2026 13:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wnflm-0007bf-9A
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 13:02:39 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wnflj-0000C9-Cp
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 13:02:38 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9b3f380006so124468a12.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784998952; x=1785603752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vp2Lh64SSUM/SEu0Tjr/Qm7nDFW7wHzjJ2nY135ody0=;
 b=ZkhlHg2yiIcphUVgNIBQdklJ9Wt6jlH3F3Uffbu4WBNcLJVcMhVSZrhLz1hZYWvSEl
 s6iq1D1+Vz9yQ/ooKr2WieoblS59WvE4YwTWmYUlcaOPybcD5DkjuJL23OZqHwRmYQ5F
 Ettcg0gljK1Dj40bKyUT0e1314702X53y6ZtdaqnAV1uosTKTddBJmuAF2NBHOneoArf
 YJeG3s/ID1R0uHYxTVfyIXIDsx4VKbwHvkXY8HuEuQhHNnHSvrfzm10hzNqI6SlPUuKn
 BuU+3fY+iHdU+3Az9fDOKeT7DsC48eu9KhqtcyoRrKshppV6q6uZHa3Y0ZsqCaA8RczU
 VVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784998952; x=1785603752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vp2Lh64SSUM/SEu0Tjr/Qm7nDFW7wHzjJ2nY135ody0=;
 b=cL6vDTUm0H7czy9ilMVn5jZo/yze7V3E1P2VRP6r0Mk2ZeCdJcYydeuhAx4k3FFYBr
 MCPT58DHL6A+F3BCKa4gWdx4pCqXDpYbDPEsl+8VARmotjx42U2LczX9Toa7OjY//mC6
 4XjY0n64JWbLqxuV4BFqjyeM+xR3D6oExfBwRwInAqdpp8lJ2aEAkayPsEuZ+9OWs/5o
 GJS6qVhgetV5BT1lCEDxj+coKhbTCFriVlXHHsHh9qYNrztNAb37bXzzBUbthC94Z+ke
 lIdG1Jzr6Fzw2y3SKDAs2DfkfTx7m43IJnGV5aelIMehv3I3TIE89IfgLmUeDC3IilAK
 0y0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RopmDeQcRRqxQl/mN6wqGUhMeDNCEFLRKXESjGyPUbmbuclmiIh1FzBez4nfE4bdu6K6BhoiZP2sBrc@nongnu.org
X-Gm-Message-State: AOJu0YxwGT/wVee/7fg5rBJunl4GOtZrXSwXuy9NRrwhRH7++gQ3y+m9
 L0r+mH8n7vySaNF2zinoYIKy8BfMUPmAgQbQLpRfmvq7oodmJa4V9smt
X-Gm-Gg: AR+sD13W6NSVAg6X28Uve7HmNjowVonlhbOr8unAxfbUvV/YCnBhA4o3fqqovrboO2x
 GZnqJZWX69Zc7B/RBO86oplVDVk7keo5nQ113WRZcO5KqjEFVqdAltadbVWXwj0z1T+Oilx8iUs
 rkPeb3t+MpdsMn//8hb03s303DA70b3jj/0SRU+zrj1oqXAQB9uxfWZulSOf3SkS1/t1rklK1Al
 k8jyIthg7rrK8iwrYSQAgY50cm5pBMkl7lWIZbydDUripmqlIHMzWGXxNIQ8zFwCbOa+f5i9VJw
 n//lfLqg0rCxAVjBVbv0B7Pbj6htx2VrJS6NnlK71CFfz+Fzi6FkazD5iY3KKY7hPfZy8tS85pm
 9qltQ5utiS/RhXNQvhXYsypJYRIPfNiPayFJS30YAZpY+rku/8+XbfaxFHlJHQw6uO6haIRQ8SP
 FlQUXeXNif3Q==
X-Received: by 2002:a05:6a00:988:b0:848:5451:cfa8 with SMTP id
 d2e1a72fcca58-84e592640c2mr1596383b3a.0.1784998951828; 
 Sat, 25 Jul 2026 10:02:31 -0700 (PDT)
Received: from localhost ([61.98.20.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5327f23csm1199585b3a.17.2026.07.25.10.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 10:02:30 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
X-Google-Original-From: Minwoo Im <minwoo.im@samsung.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH] hw/nvme: cancel inflight requests on controller reset
Date: Sun, 26 Jul 2026 02:02:03 +0900
Message-Id: <20260725170203.100051-1-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

nvme_ctrl_reset() freed every SQ/CQ right after nvme_ns_drain(), which
only waits out requests on a per-namespace BlockBackend. That is safe
as long as the guest first tore down I/O queues gracefully (Delete
I/O SQ/CQ), since nvme_del_sq() already cancels and waits for
anything left on a queue before freeing it.

A reset that happens without that graceful sequence first (e.g. an
abrupt/asynchronous controller reset) can still have commands
inflight on blk_aio_*. Freeing sq/cq before those complete leaves
their completion callbacks (nvme_rw_cb() and friends) to run against
already-freed NvmeRequest/NvmeSQueue/NvmeCQueue memory via
nvme_enqueue_req_completion(), causing a use-after-free/segfault.

Factor the cancel-and-wait loop already used by nvme_del_sq() into
nvme_sq_cancel_inflight(), and run it over every queue in
nvme_ctrl_reset() before the free loops. A pending Async Event
Request has no aiocb (nvme_aer() parks it without issuing any block
I/O), so drop it directly instead of asserting.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..1482da57e4d9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4822,6 +4822,32 @@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
     return 0;
 }
 
+/*
+ * Cancel every command still inflight on sq and block until each one's
+ * completion callback has run. Safe to call regardless of how the queue is
+ * going away (explicit Delete SQ, or a controller reset that never went
+ * through the guest's graceful queue teardown) since it guarantees no
+ * in-flight blk_aio_* callback can fire after sq/req memory is freed.
+ *
+ * A pending Async Event Request has no aiocb (nvme_aer() parks it without
+ * issuing any block I/O), so there is nothing to cancel; just drop it.
+ */
+static void nvme_sq_cancel_inflight(NvmeSQueue *sq, uint16_t status)
+{
+    NvmeRequest *r;
+
+    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
+        r = QTAILQ_FIRST(&sq->out_req_list);
+        r->status = status;
+
+        if (r->aiocb) {
+            blk_aio_cancel(r->aiocb);
+        } else {
+            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
+        }
+    }
+}
+
 static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
 {
     uint16_t offset = sq->sqid << 3;
@@ -4856,14 +4882,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_del_sq(qid);
 
     sq = n->sq[qid];
-    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
-        r = QTAILQ_FIRST(&sq->out_req_list);
-        assert(r->aiocb);
-        r->status = NVME_CMD_ABORT_SQ_DEL;
-        blk_aio_cancel(r->aiocb);
-    }
-
-    assert(QTAILQ_EMPTY(&sq->out_req_list));
+    nvme_sq_cancel_inflight(sq, NVME_CMD_ABORT_SQ_DEL);
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
@@ -8022,6 +8041,18 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
         nvme_ns_drain(ns);
     }
 
+    /*
+     * Cancel and wait out every inflight command on every queue first. A
+     * reset is not required to be preceded by the guest's graceful
+     * Delete I/O SQ/CQ sequence, so sq/cq must not be freed below while a
+     * blk_aio_* completion for them could still be in flight.
+     */
+    for (i = 0; i < n->num_queues; i++) {
+        if (n->sq[i] != NULL) {
+            nvme_sq_cancel_inflight(n->sq[i], NVME_CMD_ABORT_SQ_DEL);
+        }
+    }
+
     for (i = 0; i < n->num_queues; i++) {
         if (n->sq[i] != NULL) {
             nvme_free_sq(n->sq[i], n);
-- 
2.34.1


