Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00351C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKQA-0001Ip-0C; Thu, 02 Jul 2026 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wfKQ7-0001Hg-Kr; Thu, 02 Jul 2026 12:37:47 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wfKQ5-0000Df-Dy; Thu, 02 Jul 2026 12:37:47 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8CF437A0096;
 Thu,  2 Jul 2026 12:37:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 12:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1783010261; x=
 1783096661; bh=pEe9Gqbks+KXQu2kt1LWely0QbJJc8/SE6K/1nmYUV8=; b=F
 gjku1XG8QpTGSXu88VAe6A4mvllDSxACKMacF6B9tmUH8paRl/VYJKg6hrh0Fkk3
 o5m1EWgDZQWv6ultuh+joHx0D4tpayC5l2Gw2rvpDmZX0DrYbvil9hvtKOkM9TMB
 ZXeBsoqD7fmFFV58DinR8IhpK04udBgLT6ICUmJoF/kMMJNzIzKT3hcfEyUsymtL
 dF8wnu+5JTWwjRbgGrqdcLa2Oi5uziMxDvBzyEMSo0mBcBTOSIdGA+v+TWPN5h87
 zcqFzVIGlJNm2sLIM/4XdHW5MQK7Yzw+NvjCjqCn9ErH3MeHbdxQseJ0pmiFsCKj
 PYl5r+vTwvXxa07NvzJIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1783010261; x=1783096661; bh=pEe9Gqbks+KXQu2kt1LWely0QbJJ
 c8/SE6K/1nmYUV8=; b=bRvs9AQS5JMV5zpyBwIFv7uTKgmYhEtoJc4XDOKvEJr4
 fxgFp71JD7H6kFL5+dWQRBzATNd5wJGzg81tHrvbOjL7JDks8Ux2ovqWG7aOkjN1
 gTgIetdMg/4yp0YwhVz/pyrRoInAWEtpjNnBD+Eh4eHLxq38LQQlOkHnTvc6If1S
 rkjf76QruKdhz24XxViI979WlkDNqvLJiVLJ9yUXAoNBjp9Y74N3dNuRKhspKkck
 CYYSdSzp1XsYfAI4U00bhSKfmYG/7p0UH/77Elo6TLIz5znjjo7/0Cv9pRXEB3rB
 Jg70VMNWObt570GVkFObKLepMJ/06x9LS6IlLGVTyQ==
X-ME-Sender: <xms:05NGahEPdiO2WgyoOsBSJJZNq-upDo7C5tWXMLhBEzVjeC476wIpzw>
 <xme:05NGao6QLf8cdxL08CypKbxy8ze-85lorDvy0ecgI9t3URcQXiH4b0XZ6bqy1EogC
 Qr5YS4pHP0Mg02w0a1PYMOeuS_2TzZinyDVf5Om2NLhpUMsj9HpEe5I>
X-ME-Received: <xmr:05NGamz1S4RQ9KSga-Ic5T5xAtUyXPx9YwKecnve79z0DxPV5EjC8GV1xVn5YFKdARhcgDet2XojTWq89RhAdBZEhvwZWPlmtKykWJzqxuP0ChW3PPIEJnR3RQ>
X-ME-Proxy-Cause: dmFkZTEGpCMIq1VM5KCmNJ0priJJpmIyiJJVydD6IeuKyEAM8N7MmDHVeFw8oodO+GHDXK
 he3XFWoWTwj1r9Aj7cSx8afkOdlO1GXSfobZtKLe7F6J9K/KIXBaTVE1JtnZ4wpnp0W2Aj
 gN6wMjKxBkG+EuWDWFDaK3No3mXp/3h4jwC6oCrSHOSlPW7GPvvkXTzoNfFilzDRt/MvHn
 1MkUmTFfCb1HYRsmMFx7lb95PY4cdhCzEL+JNnRf9zyyjbyom90lkaG39YVfpbX/BHTxlk
 WrWAcOT3vVZl/1I7+1xl6CLmh/CAJ9vFLZiFTtLHN4PsnBMOlZ2eG6kZ6AHQyljae/5HCi
 QajcmagnpsqjWNwGAaRLJ0x0+oWVYT+LaPvWyNd/iBA4PaZDKBpkfZSv/Ea9RAi/sNiz9m
 zZy20f4aGhtr6LjiSsRD780lPIbhQ/AuG5TxUjXGTNruRccjl4yvorfwXZuqL84gw4oO++
 A6AIO+Gc3B/8BSEcWcYWMWVKDodu4VKvWRLDv+2P0iTNyPwUZp4lzhM2Z3tzID/5dhZsTN
 VY7xLZvT9erhrGXa1LcOKOJespHrkz7uurmmOlUZJKVwnRrJDC6pqzDvEBp7cso/tU7QSz
 3pqOxq/Kci0EDrRS3aZkA1jxe4ma+ggdocUuKjrx1km4etKENXD+cbVjp54g
X-ME-Proxy: <xmx:05NGanM884dVwZ30HILrq_2l64oh-6B_COgYdqrpRI63RpdSaM0rKQ>
 <xmx:05NGask-ZGC0ovyfVxbvUMLh2x0nxdhjbZ55tKmFTjZnBoYuX8Fb0g>
 <xmx:05NGasQHBVwz0SEg6oNEyiFDIrghBhFCwG838XqsTLIV9mgkDLvXhg>
 <xmx:05NGarVi1Zx_DWbSlcTwKLwHTEyXkuP084_KWVWzvDwz5u6YXNcBsQ>
 <xmx:1ZNGar705nuS14e1Dxg9gHT-3yUdCK4pb2SwfQam-LOg21839Ckkau4n>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 12:37:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 02 Jul 2026 18:37:24 +0200
Subject: [PATCH v2] hw/nvme: fix potential use-after-free doing controller
 reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-fix-heap-uaf-ctrl-reset-v2-1-ace38ad63a2e@samsung.com>
X-B4-Tracking: v=1; b=H4sIAMOTRmoC/4WNSw6DMAxEr4K8rqskEil01XsgFqljIFL5KA6oF
 eLuTblAl28082YH4RhY4F7sEHkLEuYpg7kUQIObesbgM4NRxiqrK+zCGwd2C66uQ0rxhZGFE1K
 nSnqS4pupIa+XyLl6mps28xAkzfFzHm36l/53bho1Vsoyqcr7utQPcaOsU3+leYT2OI4vo0ZIE
 cAAAAA=
X-Change-ID: 20260618-fix-heap-uaf-ctrl-reset-cf05cbc0e729
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Jia Jia <physicalmtea@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3672; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=A0IMnNRo2D1svX+Gr63ycrz3O2Cdhw4vTgvn/x+nMVY=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3BHazlKeHdKZVdrSXVBZGRVSEczekVhVmdhCm5ZK05aVUpMb0x2ZXJiYnd1
 Z0lGRElrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcVJwUFN
 BQW9KRUUzaHJ6RnRUdzNwbGVvSUFJQk1tTFJsVm1IZU9KZGhpcS95RzkzdTJnRkVtYWVMQ3R4WA
 p2ZkZDVDRZQWE4UmhGclRNTDcyVTQzWHJ1Z1EyakFtTHhFWllkOWJsU0ZuaGl6ci9nQXFUWExBS
 WRXakY0N3ZLCkNLZnlkcDI3Z0NMVkU3aU9sZ0IzekRPOERnejNWZDQ3R2huZll3OFpXK3loRjJR
 K0RKZXNIcFRRZHVGOUVRQkIKUTRsMUpSbU9WaGxvWmZGRUl2Y2xKSWdZRCtzRmNPZ0FFMTVsT3M
 vNVlqWDRxUnJSWUM5UndkcDJjM0RlOXJFbwpyMU9Xd2RTUDVvb0hray9sY0JvT3BLbkxiYTVQaF
 Zoekt1ZTlBRXNNTG5DcFNPZ0RHbWV1RDVJS3lZT0VlS2FIClhvUXBJcFJ0Z0FHTUdSa3RwZEYwL
 1pyb0I1MmRjbDJ4em82bzdURGg3Uk9kU2FGUTBtRDJzYVBCCj1nNDVjCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-b1-smtp.messagingengine.com
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
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3398
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Changes in v2:
- Factor out code from nvme_del_sq and reuse (Philippe)
- Link to v1: https://lore.kernel.org/qemu-devel/20260618-fix-heap-uaf-ctrl-reset-v1-1-806ec08dd951@samsung.com
---
 hw/nvme/ctrl.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..7ff0fef41e46 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4840,6 +4840,20 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
     }
 }
 
+static void nvme_iosq_cancel_all(NvmeSQueue *sq, uint16_t status)
+{
+    assert(sq->sqid);
+
+    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
+        NvmeRequest *req = QTAILQ_FIRST(&sq->out_req_list);
+
+        assert(req->aiocb);
+        blk_aio_cancel(req->aiocb);
+
+        req->status = status;
+    }
+}
+
 static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeDeleteQ *c = (NvmeDeleteQ *)&req->cmd;
@@ -4856,14 +4870,8 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_del_sq(qid);
 
     sq = n->sq[qid];
-    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
-        r = QTAILQ_FIRST(&sq->out_req_list);
-        assert(r->aiocb);
-        r->status = NVME_CMD_ABORT_SQ_DEL;
-        blk_aio_cancel(r->aiocb);
-    }
 
-    assert(QTAILQ_EMPTY(&sq->out_req_list));
+    nvme_iosq_cancel_all(sq, NVME_CMD_ABORT_SQ_DEL);
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
@@ -8022,11 +8030,45 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
         nvme_ns_drain(ns);
     }
 
-    for (i = 0; i < n->num_queues; i++) {
-        if (n->sq[i] != NULL) {
-            nvme_free_sq(n->sq[i], n);
+    /*
+     * The ASQ can be immediately freed since the only requests that may linger
+     * in the out_req_list are AERs.
+     */
+    if (n->sq[0]) {
+        nvme_free_sq(n->sq[0], n);
+    }
+
+    /*
+     * The IOSQs need more care since they may have AIOCBs lingering that needs
+     * to be completed before we can free the sqes.
+     */
+    for (i = 1; i < n->num_queues; i++) {
+        NvmeRequest *req, *next;
+
+        NvmeSQueue *sq = n->sq[i];
+        NvmeCQueue *cq;
+
+        if (!sq) {
+            continue;
         }
+
+        nvme_iosq_cancel_all(sq, NVME_NO_COMPLETE);
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
     for (i = 0; i < n->num_queues; i++) {
         if (n->cq[i] != NULL) {
             nvme_free_cq(n->cq[i], n);

---
base-commit: ef18d154e626a5c4f868493b6d7f722065fa16b9
change-id: 20260618-fix-heap-uaf-ctrl-reset-cf05cbc0e729

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


