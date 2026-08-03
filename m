Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FCDC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr1P8-0005Ao-7v; Mon, 03 Aug 2026 18:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1P5-00058y-VD; Mon, 03 Aug 2026 18:45:04 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wr1P4-00056n-Gr; Mon, 03 Aug 2026 18:45:03 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 604011400149;
 Mon,  3 Aug 2026 18:45:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 03 Aug 2026 18:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1785797100; x=
 1785883500; bh=Fexyhnzj/u9gD63iqTRm7949vPST9u199nO6W6D81do=; b=u
 ngDhISJpYXUzS2MPuKMV/ytFI+SsW8/k7PFz3XHcO+mqp0nlJGkhNX9b91MTzyNp
 BZxJjGGWuD6r3A57+fIlnAJjVBygleW/7TFblY1v6Awfs7AHCypQuh1W/sO+9fYu
 CDNBay64e0usKQEh+O86V+SgE9AZt+E1r/7XQiOP6RInteFEztl/gsWes2xJsnUO
 sdLcI+zJdMXJ1DcxjNx0wxPCgdzvvvR5/uCk2S/s4XDj25Q3KY6mmZlFyy10ZIWw
 y4nyydVzg63MOKtuxcd4is8aFh8ymEsa1r8G2SdiocUfJSmgjE8/7nlQY1NPpHX2
 W7Uafr+m/k5Wf1jeRiPRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1785797100; x=1785883500; bh=F
 exyhnzj/u9gD63iqTRm7949vPST9u199nO6W6D81do=; b=k7v0IiungaMZ7/rDS
 Ex/wkYUEcGXEjDeumBqTsz568lnDajcVxK1HSpiLzNddOkbslYbMIfRgFpQuCo2+
 JCfsPOyjLbjGWXoTcZGHaX1W8vgFoeXcecwFQ2EqC49447qJNm+sxaDSK/8A7eqK
 uf96gLI8nMaV0xxAJeUDusxrAYwJ4IUFV57q9h5TxWtDBQfFMQc6fjZIQmV4aZeL
 joCF+Sd87eswRLG25pa61nDIUsqbPrsCWphWipQKnCm8ysWIBjIotEO8Yetw4Uyp
 FWhLIc5vlTRj2WJBaDv5h681ypVV/LpokXtPDgtjjeLmH3aX5esPu0J4jhs6VoPE
 TtBeQ==
X-ME-Sender: <xms:7BlxarhYKo32G_GUZOVPPzg3XO6zlDa4p1-0Rl5XSmhiC5UT9Z0Jfg>
 <xme:7BlxaofM_pEjjKqh9_INTJz__hw3JrKsXOB_6UBrYuOtVyil_PPF6gwYY-M6Wu-kn
 RHYFkT7gH98LfaTEQej6P8I-E_2vbv3JjOitz0kQ1FTedWcbXAhC3kp>
X-ME-Received: <xmr:7BlxarxbuXyVjvkkd-fFnENitL3Ei_17VspndiuXBEZPAQKnpJ6funpRvzeXf0P1GuhuT7u0MaSYDhOaKzMIU4PicJAR64kCVS25ebYNPh0mDA>
X-ME-Proxy-Cause: dmFkZTGBwBi/Yeu/peMq8Ngc1wQNqPR0owGT6TsXi5P//CvcIH3VpbZD6k72frfNrTPmJ1
 HzAsw0Nek94AFz6/hyId/n2vFnSsULLz/dCExBxAVF7Wkns8SSKeussPL693jItbJPhw8W
 9NppZ+VdrXsTJGGeIhQeFbTsRWyq6tXwlEwPv3OovYpL6WbYzUeIGapD881h3iwBuhQzBL
 yggvH+NPIaYLOPLKtGfICRUCi/Zgm1F30tHBJPANJnYoIv44XJEtXG1AV01WR8YvxuSn6v
 uVaspQ8TgNHfAnkT968W4FZr2dNYnNGf8Y/bmzegupv3TawcKvMGnuXBPLbFA9djhX2mAB
 g68EkAKlwOiCbPuEu7uQn9EIrPTBsSsHOdqLqddS4yczrdS3P79U2mjwSaqN+r6RgY1KYP
 sZ8fndK7W7CTCDw9mrN/sagsE8DHP41/Q0d7aLW0cMhtOF6Kbj04NhC3tzj/cbVHQ966R0
 w1sau87+PQmY/hBLflMsZuT9EjNmYX1B/l08IulRHxkNKYhNImxSdvB+HjpnqBld2VrhE0
 k4n2U66uOM+Irquz4tmDawTWBgi33JLwVEqtoKH0gc4WQ6I4vQHPFpOe5exssyTJwLY1H0
 Wh7DLTNqU0lD3xPpjCEn/QCoI0ZjeewHfQwe0ULRnrc//eVAjCwZeCFRMCqA
X-ME-Proxy: <xmx:7Blxav3dcrTbspJs6-VM1bPKK-Wn2hY_MOST_n3ZN2cArKLFPedL6w>
 <xmx:7BlxapwLPIc0v0OLB4i_IgHelAEzb_Fq9D9ZWxKMTj1ndSd_RT7UJg>
 <xmx:7BlxasUaRLPJQ4NlhlMzx1k23x-EV7LL7fKSOsWP0RGeVSWHzWwohQ>
 <xmx:7Blxat87xmO5RJ3V1dI-ALhmBXV1fTScuHafFSi_hrLyv7f5QehloQ>
 <xmx:7BlxauPi_Ue1g-a4WdtTgOqrwJMhZKl-TZxAAJb84Mt4I977-yLaREF1>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 18:44:55 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Minwoo Im <minwoo.im.dev@gmail.com>, qemu-stable@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 2/4] hw/nvme: factor out nvme_sq_cancel_inflight()
Date: Mon,  3 Aug 2026 15:44:33 -0700
Message-ID: <20260803224436.38768-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803224436.38768-1-its@irrelevant.dk>
References: <20260803224436.38768-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-a7-smtp.messagingengine.com
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

From: Minwoo Im <minwoo.im.dev@gmail.com>

Factor the cancel-and-wait loop used by nvme_del_sq() into
nvme_sq_cancel_inflight(), so it can be reused to drain queues on
controller reset.

Cc: qemu-stable@nongnu.org
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e3eadf3d1dd0..e355c256a561 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4826,6 +4826,26 @@ static int nvme_init_sq_ioeventfd(NvmeSQueue *sq)
     return 0;
 }
 
+/*
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
@@ -4860,16 +4880,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_del_sq(qid);
 
     sq = n->sq[qid];
-    while (!QTAILQ_EMPTY(&sq->out_req_list)) {
-        r = QTAILQ_FIRST(&sq->out_req_list);
-        r->status = NVME_CMD_ABORT_SQ_DEL;
-
-        if (r->aiocb) {
-            blk_aio_cancel(r->aiocb);
-        } else {
-            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
-        }
-    }
+    nvme_sq_cancel_inflight(sq, NVME_CMD_ABORT_SQ_DEL);
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
-- 
2.53.0


