Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13482D172CC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmh3-0003wC-Vs; Mon, 02 Feb 2026 00:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgx-0003to-1h
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:44 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgv-0003z5-Cb
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:42 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3530715386cso2863061a91.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770010899; x=1770615699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCHQR4xlgTSLYVszeaZ7g5UbfvlQ1I5qPfGO9QKrVmk=;
 b=E3pLOzibcUxC0e7GOU1Zk1W2L2hR27t5rv7nvl9pusRp3htu0iXfceWYmB5kCLEWlT
 s+4uih19KNVueomeCsKbWFWVGhbpWjzn69Cd/elk0glVLIF10AIz4gZQaG1M9NxW/mmL
 SCRd6rdTJMV6/Q/Cp8mvf9NCX76TkUK/GsGzpMoPRU4GVaKJmSJE3M85zVVtB+OULrw2
 SN7LZrUr0wUJuSFWVB7B6AGJd2Er1LxN+pLVOh5ufHY4b9hVGQM4K9WX380NVqWUhwfr
 xDqFSCaXh9u8P7j2rkPzpjHHnzDThXZvcJOZGtzcC997wPzpf+WPMCvx4mHDFqVi0pQs
 5LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010899; x=1770615699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vCHQR4xlgTSLYVszeaZ7g5UbfvlQ1I5qPfGO9QKrVmk=;
 b=oDMx//QDJA/6joNL9QoDaAtRjK6QpAVyKFfea2E8JqHvea5p10SNvzBlyBsDJL26ba
 bLkgZt0EgKPS6S/LImEWg4j8KV19nOK0vtCBfzKBvzMdLFxAgbtOVbY6SQsR//P2vMBT
 KLhDLTeOI4+9YEm8mSvCwlkFMCorKkBwt7V6RWpGmzuDRQvRsOKT6sXkO4fAWHw112/O
 YY/rwS4fQbntfGSINMWhaKtYwXxUuUDxQwLpnd0NRaQmW86Z1GDZFkjP1jQ/fRbAEO6J
 rRm3hzDEyTGYof5IAZCzrW99WU+S2J5Y5MXCrE8ZkKkjflJA/pQOuzQ1Ns0G7zbC4Q5Q
 ys7w==
X-Gm-Message-State: AOJu0YzFM/GsUK6mbehtwbNWWFun+EjLt7hukpWXVe4EmlNT2rE22NX6
 7UledBecVMaem4TcvX3PU8J1Z07X2aN+onZBBZrsixcH8bc58x3w/ysH+/EDZQ==
X-Gm-Gg: AZuq6aK9+/murb8IBy9oN/VuTrnnZ/7jujnez3f5Bm/EtmrCyrQjP1d+CAimz0RCQpV
 BC86OP4Rp6tdTJwFkeRSRYWV0d7iW0pH8nluzs1OWX0euPmGPSyUZ2uxA2d8CWKTP4oSbiZbbaT
 3wie+7JBB/tgtq6bifnzSCa2AMOyyR37fNMXvEn2eEDn2FRHHi3YGn8WLwUDhWiUKWM4vVOr8a+
 IWKaqYvgkPw3KmaZns7I5cxjbBiD+GzF/dRTSgNztct9VPFmCU9iTWhZSEbDcz8OGyaCMF/wVEk
 72jcP/D7fdL9YJSZGRa0ZEx5D8vDLP2BGA6h/k1L+n7iaUi8gWu3NbLllPMUPWqBUz+KynRXukq
 LsAIHkFRIwt/9t274+0/4hvtZFnnau8uT0Tg2KY4H0Kxu2jeuk3ccJbAS0N19Aokz9nsFtJ4pCT
 A/swdmO8ZtSF1yQCe5Zp7pepxt
X-Received: by 2002:a17:90a:fc4f:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-3543b30827emr9777357a91.13.1770010899526; 
 Sun, 01 Feb 2026 21:41:39 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f610266esm17804018a91.4.2026.02.01.21.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 21:41:39 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, jeuk20.kim@samsung.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com,
 Ilia Levi <ilia.levi@intel.com>
Subject: [PULL v2 3/4] hw/ufs: Fix mcq completion queue wraparound
Date: Mon,  2 Feb 2026 14:41:13 +0900
Message-ID: <f78762a3cc81ca9842907a5fc1b2280083ac51ba.1770010668.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770010668.git.jeuk20.kim@samsung.com>
References: <cover.1770010668.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1029.google.com
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

From: Ilia Levi <ilia.levi@intel.com>

Currently, ufs_mcq_process_cq() writes to the CQ without checking whether
there is available space. This can cause CQ entries to be discarded and
overwritten. The solution is to stop writing when CQ is full and exert
backpressure on the affected SQs. This is similar to how NVMe CQs operate.

Signed-off-by: Ilia Levi <ilia.levi@intel.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 20 +++++++++++++++++++-
 hw/ufs/ufs.h |  9 +++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 9cf7eab9b0..cb74cb56bc 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -447,6 +447,10 @@ static void ufs_mcq_process_cq(void *opaque)
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next)
     {
+        if (ufs_mcq_cq_full(u, cq->cqid)) {
+            break;
+        }
+
         ufs_dma_write_rsp_upiu(req);
 
         /* UTRD/CQE are LE; round-trip through host to keep BE correct. */
@@ -478,6 +482,12 @@ static void ufs_mcq_process_cq(void *opaque)
         tail = (tail + sizeof(req->cqe)) % (cq->size * sizeof(req->cqe));
         ufs_mcq_update_cq_tail(u, cq->cqid, tail);
 
+        if (QTAILQ_EMPTY(&req->sq->req_list) &&
+            !ufs_mcq_sq_empty(u, req->sq->sqid)) {
+            /* Dequeueing from SQ was blocked due to lack of free requests */
+            qemu_bh_schedule(req->sq->bh);
+        }
+
         ufs_clear_req(req);
         QTAILQ_INSERT_TAIL(&req->sq->req_list, req, entry);
     }
@@ -787,10 +797,18 @@ static void ufs_write_mcq_op_reg(UfsHc *u, hwaddr offset, uint32_t data,
         }
         opr->sq.tp = data;
         break;
-    case offsetof(UfsMcqOpReg, cq.hp):
+    case offsetof(UfsMcqOpReg, cq.hp): {
+        UfsCq *cq = u->cq[qid];
+
+        if (ufs_mcq_cq_full(u, qid) && !QTAILQ_EMPTY(&cq->req_list)) {
+            /* Enqueueing to CQ was blocked because it was full */
+            qemu_bh_schedule(cq->bh);
+        }
+
         opr->cq.hp = data;
         ufs_mcq_update_cq_head(u, qid, data);
         break;
+    }
     case offsetof(UfsMcqOpReg, cq_int.is):
         opr->cq_int.is &= ~data;
         break;
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 3799d97f30..13d964c5ae 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -200,6 +200,15 @@ static inline bool ufs_mcq_cq_empty(UfsHc *u, uint32_t qid)
     return ufs_mcq_cq_tail(u, qid) == ufs_mcq_cq_head(u, qid);
 }
 
+static inline bool ufs_mcq_cq_full(UfsHc *u, uint32_t qid)
+{
+    uint32_t tail = ufs_mcq_cq_tail(u, qid);
+    uint16_t cq_size = u->cq[qid]->size;
+
+    tail = (tail + sizeof(UfsCqEntry)) % (sizeof(UfsCqEntry) * cq_size);
+    return tail == ufs_mcq_cq_head(u, qid);
+}
+
 #define TYPE_UFS "ufs"
 #define UFS(obj) OBJECT_CHECK(UfsHc, (obj), TYPE_UFS)
 
-- 
2.43.0


