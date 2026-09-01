Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D21C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Qxe-0008Im-2X; Tue, 01 Sep 2026 12:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1Qxc-0008Ie-JW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:03:44 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1x1Qxa-0001Vj-NF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:03:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b2e029912so1988135e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1788278621; x=1788883421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MtXOjocUSBmy5iGrbplfxQD72F9xwg0KbRg8o9SR3zk=;
 b=d82LhicieyDWnzQRj0sAzqlWZsrI8wnf5rEKsitiXCDSsdMVTzgokCErekiExab51v
 kpqyfqKz/JYMip6iJgMB0UHeVbzwan/QZtj7G2VoEGDPi2LFxIIyWI5BXbj1QGcszM/K
 Px6D7y6KGB4YrLDOPcL73qhyVjLPkd1/GqAJv5KBDLZXXFguvasVJxSG734KL3/m5KH1
 sqNHoIdGOcjxD0zSsMPzYSC1if3N695IpaCbbWwFYeiMshiMNLD487fIT2ubwMSn3j/U
 W5G/ekGnjiKMs9F9DFExL0pv62wOysqNYIOi62ubw90yaopSuEEvTmry+zEyGCybKjC2
 d64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788278621; x=1788883421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MtXOjocUSBmy5iGrbplfxQD72F9xwg0KbRg8o9SR3zk=;
 b=nHi6QayTgroCBxPnCV7wn2QC2wNNYsa3ZvxezTupZUD9uMvjVsBbMip9/WGJvsINag
 uG6Q2hDWpDujP4uUYTnpyqlV3OU8Aes7P/k8pPgG7GqJGCYw6Q0718q7FzPwPgnjRhUk
 LDPNJHB4LDD1xA4aFdbJley8c4LHJY1JDgLn+8pQpvU7RQ1EKWh1WHkZb1CsaJW/k62B
 Ff8lNgmiawtSrlJqkkHLqIZtsqB3XLdKaqInXys+uEOuu2KzIEm+0ccFDFQRshaScn/o
 jCy5y1ew+rkFgv4qyXuuN+1HNyv6LOsG6D8vsXdrXYDxRgkhQyqXtb9DC0YkQzzps8E8
 tIZg==
X-Gm-Message-State: AFuF++nFi9V9odnocn7/QZ0CqjNIOBQlzFKV7hBL3Oloq3idxIOkaME+
 YetbAicZ633JLWDWNTE6h7BeYw7wmiDDdPnKQzAKO3pVP60A2dp9k1Fq+ckeZGN3QWbSzzOmesw
 oUR3GMrs=
X-Gm-Gg: AR+sD12hw3mork5NemFKFtmD8a7yWYOF9gyIsCebQk61Pbnl/ROM57KmDsns1QZNnKa
 zqsHHd2QAiDg4nuz9IPtLk24NGXyv8R/wwLDmeD/E0uflG7Y2UGyMSKcJmbyIO/Cb3BhtQxs9tP
 eBXH2jCyVzSlQppgRy6ybgqxGpqIJEdSrWg/z5snAeAPjcK0Cu5zPZoqrkRvc8OITbgfqfhI3E0
 d8kW8OPpnYSaPGDBkjGlKOahGFt+HbQ6GEkkEhdE/F67vVg/bscv86jnRZc+iyVh2kEMawwCEi2
 4dHBToGijr4t9UNCmB4bQYzCFv8bTQ8XPe4K7jHimfxQJ54Hz1Ubk1Z2YtJMU5nrb3iQugoNt0H
 ugbivaI3sMPwIxpOs4yUMBSeFek1BdsDjqRdfRgOtEEUo6qM+XGVMnq+9ej4ZWzuM5xhExaIrnQ
 WaQTxLTbA1zByr3QynQkuM8n5yBaIB2honhOV2IxmXP0ylKg6Df1ghCXZSn0kAykibGxGHBERNj
 YDTc+YJfFapq9uCb14CBT075wbBE++4bqkD
X-Received: by 2002:a05:600c:c0c2:b0:49c:cbf4:572b with SMTP id
 5b1f17b1804b1-49ccbf4575cmr176591655e9.2.1788278617996; 
 Tue, 01 Sep 2026 09:03:37 -0700 (PDT)
Received: from jwang-ThinkPad-T14-Gen-6.fkb.profitbricks.net
 ([2001:9e8:1471:a200:e095:5b15:7c12:5f73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce0b456sm87367435e9.2.2026.09.01.09.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 09:03:37 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, yanfei.xu@bytedance.com,
 Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH 2/2] migration/rdma: avoid memcpy for inline control sends
Date: Tue,  1 Sep 2026 17:51:21 +0200
Message-ID: <20260901160333.29859-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901160333.29859-1-jinpu.wang@ionos.com>
References: <20260901160333.29859-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::32e;
 envelope-from=jinpu.wang@ionos.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jack Wang <jinpu.wang@cloud.ionos.com>

qemu_rdma_post_send_control() always copied the header and payload
into a pre-registered scratch buffer before sending, even though
inline sends don't need a registered region at all -- the HCA copies
straight out of the given SGEs at post_send() time.

When a message fits inline, point two SGEs directly at a stack-local
header and the caller's payload instead of copying either into the
scratch buffer. Confirmed against the mlx4/mlx5 driver source
(providers/mlx5/qp.c:set_data_inl_seg(), providers/mlx4/qp.c) that
inline SGEs never dereference lkey and are copied in a plain loop over
num_sge, so this works for any SGE count the QP was created with.
Falls back to the old copy-into-registered-buffer path when a message
is too big to inline.

This needs the QP to actually support 2 SGEs on a send, which the
previous commit's QP creation didn't request (max_send_sge was still
1) -- bump it to 2. RDMA WRITEs are unaffected; they still always post
exactly 1 SGE.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 migration/rdma.c | 68 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 08f3b901be4a..88c4981804c3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -943,7 +943,13 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
 
     attr.cap.max_send_wr = RDMA_SIGNALED_SEND_MAX;
     attr.cap.max_recv_wr = 3;
-    attr.cap.max_send_sge = 1;
+    /*
+     * RDMA WRITEs only ever use 1 SGE. Control sends use up to 2 when
+     * inlined (see qemu_rdma_post_send_control()): one for the header,
+     * one for the caller's payload, both pointing at unregistered
+     * memory that only inline sends can reference directly.
+     */
+    attr.cap.max_send_sge = 2;
     attr.cap.max_recv_sge = 1;
     /*
      * Ask for enough inline data to cover a control header plus the
@@ -1452,39 +1458,55 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
     int ret;
     RDMAWorkRequestData *wr = &rdma->wr_data[RDMA_WRID_CONTROL];
     struct ibv_send_wr *bad_wr;
-    struct ibv_sge sge = {
-                           .addr = (uintptr_t)(wr->control),
-                           .length = head->len + sizeof(RDMAControlHeader),
-                           .lkey = wr->control_mr->lkey,
-                         };
+    RDMAControlHeader net_head = *head;
+    uint32_t total_len = head->len + sizeof(RDMAControlHeader);
+    struct ibv_sge sge[2];
     struct ibv_send_wr send_wr = {
                                    .wr_id = RDMA_WRID_SEND_CONTROL,
                                    .opcode = IBV_WR_SEND,
                                    .send_flags = IBV_SEND_SIGNALED,
-                                   .sg_list = &sge,
+                                   .sg_list = sge,
                                    .num_sge = 1,
                                 };
 
-    if (sge.length <= rdma->max_inline_data) {
-        send_wr.send_flags |= IBV_SEND_INLINE;
-    }
-
     trace_rdma_post_send_control(control_desc(head->type));
 
-    /*
-     * We don't actually need to do a memcpy() in here if we used
-     * the "sge" properly, but since we're only sending control messages
-     * (not RAM in a performance-critical path), then its OK for now.
-     *
-     * The copy makes the RDMAControlHeader simpler to manipulate
-     * for the time being.
-     */
     assert(head->len <= RDMA_CONTROL_MAX_BUFFER - sizeof(*head));
-    memcpy(wr->control, head, sizeof(RDMAControlHeader));
-    control_to_network((void *) wr->control);
+    control_to_network(&net_head);
 
-    if (buf) {
-        memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
+    if (total_len <= rdma->max_inline_data) {
+        /*
+         * Inline data is copied out of these SGEs by the HCA itself at
+         * post_send() time, so no registration (and no local copy into
+         * the pre-registered "control" buffer below) is needed -- point
+         * straight at the header on our stack and the caller's payload.
+         */
+        sge[0].addr = (uintptr_t)&net_head;
+        sge[0].length = sizeof(net_head);
+        sge[0].lkey = 0;
+
+        if (buf && head->len) {
+            sge[1].addr = (uintptr_t)buf;
+            sge[1].length = head->len;
+            sge[1].lkey = 0;
+            send_wr.num_sge = 2;
+        }
+
+        send_wr.send_flags |= IBV_SEND_INLINE;
+    } else {
+        /*
+         * Too big to inline: the HCA will DMA-read this directly, which
+         * requires a registered region, so fall back to copying into
+         * the pre-registered "control" buffer.
+         */
+        sge[0].addr = (uintptr_t)(wr->control);
+        sge[0].length = total_len;
+        sge[0].lkey = wr->control_mr->lkey;
+
+        memcpy(wr->control, &net_head, sizeof(net_head));
+        if (buf) {
+            memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
+        }
     }
 
 
-- 
2.43.0


