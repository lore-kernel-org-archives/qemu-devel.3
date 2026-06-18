Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A068ECD98F0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa7cE-0000xh-AE; Thu, 18 Jun 2026 03:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wa7c1-0000qZ-NV; Thu, 18 Jun 2026 03:56:33 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wa7bz-0005Ry-KE; Thu, 18 Jun 2026 03:56:33 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 4BC6A1D0012B;
 Thu, 18 Jun 2026 03:56:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 18 Jun 2026 03:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1781769386; x=
 1781855786; bh=VyAslQitiUQ2rIN4BzBYGPLKvHsPIFFDEuTAJa/cPn8=; b=P
 vaWuxjGGJFA0lyY61DkbWyvlLoQSfhTxuPOzIsQ2VG43kbpnKVKxWHx2y7nayDXS
 w5oixuuFERW1OhfGZoaPohqVmMq0vPOGOHqA8oOh4h1MJZ7Of3jEfN+HUp0XQndG
 gRqHd0kb+igfsM+u4hdrmWhtbjnhaHdymf1CFnGFLuUsX7W2GzfBJnHQXnVD79IV
 Mo+iO3cYy9qKc6GxrZzvtOY3ejcMtZ26J2FLWLnTcFGBUWhZRDH9HqcSvGdrw8xs
 qpPJHIv2aKcftE06zBoJVbGQyJ8ekniyN5fswR8M70ArQIUEwnNF6QenW5mUwIAx
 5KJH0D0qO5Hu2bmGDqxxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1781769386; x=1781855786; bh=VyAslQitiUQ2rIN4BzBYGPLKvHsP
 IFFDEuTAJa/cPn8=; b=DBgrqAMXWGxvelpw/9w5u06bjivomv10MPimzf6MHGWc
 aOcEp9BYWBDSdDB582bPi0PCwSI+u6HiVcbVB+xu9GxZ9V6ye5+L1ZJB1aOXwCka
 pj4CnWxY8PMB7PsaDpUMSESmZgIKaJx/qL3tBOdMTmIPuKyZwza8wrG43Q2m5waS
 tO0Bqe7LaOU80tGRLyGXci32qA75J7E8F8hLJG+DP3DQ8uyX9u3qjcRocGv5Cu0Q
 eFmwThUVDXtYZ924d+w2nR5iZN3vFfPtvvx4Oz/Ks/Wpi5YUwMnMCQdfpYtKiT61
 OisaWRDnhBSJwWJgoMQc2BHJvriAJxVl4gQ/NRV80Q==
X-ME-Sender: <xms:qKQzagm76MUswZ0VcVhBzP7wP7FMXrN5YpAKOpjwmL5HNyyMjM1akw>
 <xme:qKQzap4Yu-iYvBdbtiP3miWWijIAWxN8WgxgSRlZx7GujxJUfQzoGwXpEyQGYE16X
 I-aaXCGSvXL0AvKGfYH439wCr3uiyEH7F7FzhXg9B-oa32IYFh7Ddo>
X-ME-Received: <xmr:qKQzaujKSVmwq25Cpgnl58mkJWlY7ht8aiaddpfm11vUnHWxpNZAUUvxdmucJfm2iVuPzNSGvMjB-9dm9zMz3sKd>
X-ME-Proxy-Cause: dmFkZTEhgopaSph5IhWsLd0nqLfLKpBkeQiClnTD6bh4QSNNgHii3wDJ4Ixoo5WbtP/fpB
 QohJNpDL2AXp5Nitd11LwGSjcUlY466bV0bYkVXkFk4t6o86BrZ1QHYv/hJuMZBQSAL8Q4
 fwacQE7meRcQ54u2+hK9qhwiCIYonZp961lpdTHKLOrtat9MpfwHI8FXSitqgRvGxxC6Nf
 /G4S8G8Y+Aase+bIslM4lr7ljaQ1JRBxZcPtTFnnbwJGLx6wVrhbFWsdG/t9JUHJP4giwI
 bmTGYYPQ2egdznPE/RE1cjVcY2DlqIBytJ1dM4jJ6lLiLVj/7tIXd978Vylec/+V1fE3Mm
 AKgsOynCa+pfudVMxK0ZSjK7Fzd20cCo6lFBsg5L5vAqVUUB06r/RByDsPPnIXH1z4iCZA
 eEQQ76OnERN8AghlI1SbhvADgquaXERfnRljj3IMNnhSTex3yfVaD2+qitB3CHckbbdsBF
 ZLyOaXggJJtzqeNK/lwdCmA3G+KMVHucaZ82KXL5lNJkvQIMY2IMHEdRHQcb8J3lrMj5OZ
 SKJT5+11jH9afg12PgQPnIdCogtDAX3N2o6M83OmgHw8iiS460mgvhHEAplHESorP78fRF
 pO8oZwpc0kwFOaXhVnXfwuOQtcR6Rl9qSNbaj7UrPGelWhhly9GCiKu+4EoQ
X-ME-Proxy: <xmx:qKQzauHPAB2__gIketbvPSm4fX0_LtnE3s9OIbsT6aZScPuPZIsccQ>
 <xmx:qKQzasRmFWmxVQ_X5E9X5HajfoY7_KC_zQ1hwJcxHKOamEf_AqTxPw>
 <xmx:qKQzajz3CSIEU113cHP09Dr01qac4cqCMEl-PYDgaFgYC_vAykQvGQ>
 <xmx:qKQzage77I05cj72m5bA7qVVomJPMl_uT5Ch7rS8s-BCvAB1NDBtlw>
 <xmx:qqQzalFYY8EDBqaf38OEN-0y7bG-t4BI5D476_uvKQ4XxbHe4rzWt3kU>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 03:56:23 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 18 Jun 2026 09:56:18 +0200
Subject: [PATCH] hw/nvme: fix potential use-after-free doing controller reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-fix-heap-uaf-ctrl-reset-v1-1-806ec08dd951@samsung.com>
X-B4-Tracking: v=1; b=H4sIAKGkM2oC/x2MwQqDMBAFf0X27EIM1Kq/Ih7S9aUuiMrGFkH8d
 4PHgZk5KcEUibriJMNfk65LhqosSKawfME6ZibvfO3qquGoB08IG/9CZNltZkPCzhLdSz7i8PY
 t5XozZPU598N13eRkZNZpAAAA
X-Change-ID: 20260618-fix-heap-uaf-ctrl-reset-cf05cbc0e729
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Jia Jia <physicalmtea@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=wmgxcvvWJKufQZBvoOuKnSWXTHeThpUU021XWZliREA=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR296cEtZZkRjQ2QzakdTZWNvZ2xyRUpSM0EvCndFcWlZZHVmd1NrK3JZcktL
 QUl3bDRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcU02U21
 BQW9KRUUzaHJ6RnRUdzNwS0EwSC8zZjM1SDhQUWhXNkFHbmJaRTRLSUM1WXVsL1E4dVVuVjMwUw
 pDKzdPQnNvS3JibnZQNENoT3Njd3dJMEhURGV4eGRBU1NVeCszT0VHenZWZEdTaSthZlpjZWg1V
 VFZeEVyTmd0CndqamRiTFFwZDc5YnZWd0lUcDBTbDdNZDhaQjZYbWxjdkJ0Qm9hRnBqcEI1Rzkw
 MG1aempybEFNWTdRQVBPUlEKdElLOTBuNjMzeDUvMHJxaDF5bGRpRjRrcmo3WXd4d2pUN2V0dkg
 wS1cxNnZaUjY3Mlo4dTFzVGN3QUVQL3MyYQp3VklxVWY2VG95WlJUTXhYUUF4REM1Sk9rVWVXdk
 pnUHhRUEp0bVB6R2J2RzN4TlJ5c3VFanY2TnNxeDdPbjRWCktDZnIxTzVZbFk4K08yYWpIZUpET
 29qVEtYMjZKV2tGeFdVZEJETDRQNzVCaUkxeW5xL0MvNlBTCj1Xbng3Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

A controller reset may race with inflight DMA I/O. SQ deletion (when
done by the host through the Delete I/O Submission Queue command)
handles this, but the controller reset path does not, which may lead to
the freeing request resources prior to the DMA completing in certain
conditions under large and heavy I/O pressure.

Cc: qemu-stable@nongnu.org
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c8a..75768272f241 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7906,10 +7906,40 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
     }
 
     for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
-        if (n->sq[i] != NULL) {
-            nvme_free_sq(n->sq[i], n);
+        NvmeRequest *req, *next;
+
+        NvmeSQueue *sq = n->sq[i];
+        NvmeCQueue *cq;
+
+        if (!sq) {
+            continue;
         }
+
+        /* cancel any outstanding requests */
+        while (!QTAILQ_EMPTY(&sq->out_req_list)) {
+            req = QTAILQ_FIRST(&sq->out_req_list);
+            assert(req->aiocb);
+            req->status = NVME_NO_COMPLETE;
+            blk_aio_cancel(req->aiocb);
+        }
+
+        assert(QTAILQ_EMPTY(&sq->out_req_list));
+
+        cq = n->cq[sq->cqid];
+
+        /* blk_aio_cancel may enqueue completions on the cq; drop them */
+        QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
+            if (req->sq != sq) {
+                continue;
+            }
+
+            QTAILQ_REMOVE(&cq->req_list, req, entry);
+            QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
+        }
+
+        nvme_free_sq(n->sq[i], n);
     }
+
     for (i = 0; i < n->params.max_ioqpairs + 1; i++) {
         if (n->cq[i] != NULL) {
             nvme_free_cq(n->cq[i], n);

---
base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
change-id: 20260618-fix-heap-uaf-ctrl-reset-cf05cbc0e729

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


