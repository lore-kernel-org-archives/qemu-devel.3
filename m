Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7BED5E148
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KAX-0008Gp-Ee; Fri, 08 Nov 2024 03:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t9KAU-0008Fj-Rp; Fri, 08 Nov 2024 03:16:34 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t9KAS-0005d0-IG; Fri, 08 Nov 2024 03:16:34 -0500
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 1685C13801D4;
 Fri,  8 Nov 2024 03:16:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Fri, 08 Nov 2024 03:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1731053789; x=
 1731140189; bh=WlgXQUygLgE7ehTwEfiTQycbbYddI23qPLhDsak68s0=; b=H
 3Wpy30cufmliRyhkyKvnpElbX9qRE6MvCdLLR3BmgGmreTcNKa1COy4Z6LAepKqL
 eYbHzxMwFQpEuTGyG+PT1uhzXLa8vsK14P+v0RCAIegjCPRtygBWyeVdIE/jd7SJ
 WYkwnJauK2uO0cWxbgu57f5PIfEuXCpMnnh9jS9SpeSl72uyr8jDoNj3EumsBlIB
 qoYHtF4z1EMb1y3RNKtMSoo1Sv4uLRRPuF7VSqQl0MxF/D3TvB2zXDDBQAyNvM8G
 LJwJ/RHOGAeVWvS6heC5HmS2EvSYqJFzalsP7auc3j9KfsUB6yAC1KOtvWBSsnBI
 pAScwNxDYTD0BWdZF3V2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1731053789; x=1731140189; bh=W
 lgXQUygLgE7ehTwEfiTQycbbYddI23qPLhDsak68s0=; b=Kj+G9Y5OEWF4plk2y
 2XYrTdBdnEV3t2duB+rUbwmKqzY0pTiQq4ub5CCSDmNK8+1VG6tWC29H5SvGVYkV
 2BBxLIqiFH9rbKeZf8cPVyglY54JA3DUquCXZSOoVLIMgm0RM1CgpVawo6rd7Q4u
 sYhQXW0PDTpFre385d2Frm1XIasT4N9Nv4dLt9tzacqNRKz67XdLBCyRZWdo6jaz
 H5fjSBUzJOVeV2/nOd4qf9SWgOtbcUpXNVgbR5Ko39Z0UymfLWep05JKtBWRIYt5
 efX0TAs30yXWQgFpj7R2UQpN5Vd5dCFe7AsqmzEycclYVVZcYIyTEyVXmxBAiNuS
 u3PaQ==
X-ME-Sender: <xms:3MgtZ26LYuzpLbh8XT58TsKETy5Yj8h9NIDe6fK_4AlkTj7Agjb0EQ>
 <xme:3MgtZ_5NmGS7n1_IAQU0hEDawTz7YbUBjQsZ0x5Su-DFViPSTyCr0OlV1xQ3zVMZc
 s4WoZ_rd4sRIKvdljw>
X-ME-Received: <xmr:3MgtZ1fBc8yTyeVsVNxe_TxJMmfPb5JQnowcxj24XNCV0Jm47Hih_5ZM7Pmm32yODQcTvvUrXtaHZ63-neZRs78>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepfeehteeghefffeegkefghfegieejkeevfffhjeev
 feekudeiieevheetledujedunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuth
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepkh
 drjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepqhgvmhhuqdhsthgr
 sghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhifkhhoiigrtgiiuhhksehgmh
 grihhlrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgt
 phhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepfhhoshhsse
 guvghfmhgrtghrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhn
 uhdrohhrgh
X-ME-Proxy: <xmx:3MgtZzLoFADCYwWxfm0Coatb6DQCr0CV2R1xgjhbLLq-qLNWYPS42Q>
 <xmx:3MgtZ6KN33cx14MFh0ppYktdkV-nKjL9NVoacwqenMq_kX9_EbT9Pg>
 <xmx:3MgtZ0x2rXHp7LvcVdo7hwSpvBwZsW2GUmKCzSFr-4I1_tGyGRPvTw>
 <xmx:3MgtZ-I30adSvQUvIYDfjK22hsbbivaD8lJj0fdBSZuoUdr_S1l6_Q>
 <xmx:3cgtZ3V53EIm8vaMBu3T1BRQeBO0fNkzGGIVqU4naXI59E74-TiymNQp>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:16:26 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Waldemar Kozaczuk <jwkozaczuk@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 1/1] hw/nvme: fix handling of over-committed queues
Date: Fri,  8 Nov 2024 09:16:19 +0100
Message-ID: <20241108081620.3663-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108081620.3663-1-its@irrelevant.dk>
References: <20241108081620.3663-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

If a host chooses to use the SQHD "hint" in the CQE to know if there is
room in the submission queue for additional commands, it may result in a
situation where there are not enough internal resources (struct
NvmeRequest) available to process the command. For a lack of a better
term, the host may "over-commit" the device (i.e., it may have more
inflight commands than the queue size).

For example, assume a queue with N entries. The host submits N commands
and all are picked up for processing, advancing the head and emptying
the queue. Regardless of which of these N commands complete first, the
SQHD field of that CQE will indicate to the host that the queue is
empty, which allows the host to issue N commands again. However, if the
device has not posted CQEs for all the previous commands yet, the device
will have less than N resources available to process the commands, so
queue processing is suspended.

And here lies an 11 year latent bug. In the absense of any additional
tail updates on the submission queue, we never schedule the processing
bottom-half again unless we observe a head update on an associated full
completion queue. This has been sufficient to handle N-to-1 SQ/CQ setups
(in the absense of over-commit of course). Incidentially, that "kick all
associated SQs" mechanism can now be killed since we now just schedule
queue processing when we return a processing resource to a non-empty
submission queue, which happens to cover both edge cases. However, we
must retain kicking the CQ if it was previously full.

So, apparently, no previous driver tested with hw/nvme has ever used
SQHD (e.g., neither the Linux NVMe driver or SPDK uses it). But then OSv
shows up with the driver that actually does. I salute you.

Fixes: f3c507adcd7b ("NVMe: Initial commit for new storage interface")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2388
Reported-by: Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8e4612e03567..69bce20f6692 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
             stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
             break;
         }
+
         QTAILQ_REMOVE(&cq->req_list, req, entry);
+
         nvme_inc_cq_tail(cq);
         nvme_sg_unmap(&req->sg);
+
+        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
+            qemu_bh_schedule(sq->bh);
+        }
+
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail != cq->head) {
@@ -7981,7 +7988,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
         /* Completion queue doorbell write */
 
         uint16_t new_head = val & 0xffff;
-        int start_sqs;
         NvmeCQueue *cq;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
@@ -8032,19 +8038,16 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
 
-        start_sqs = nvme_cq_full(cq) ? 1 : 0;
-        cq->head = new_head;
-        if (!qid && n->dbbuf_enabled) {
-            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
-        }
-        if (start_sqs) {
-            NvmeSQueue *sq;
-            QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
-                qemu_bh_schedule(sq->bh);
-            }
+        /* scheduled deferred cqe posting if queue was previously full */
+        if (nvme_cq_full(cq)) {
             qemu_bh_schedule(cq->bh);
         }
 
+        cq->head = new_head;
+        if (!qid && n->dbbuf_enabled) {
+            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
+        }
+
         if (cq->tail == cq->head) {
             if (cq->irq_enabled) {
                 n->cq_pending--;
-- 
2.45.2


