Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AEFC44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3h-0001xT-BS; Mon, 06 Jul 2026 18:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3e-0001uZ-QA; Mon, 06 Jul 2026 18:44:58 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3d-0000yl-8I; Mon, 06 Jul 2026 18:44:58 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 179707A01DB;
 Mon,  6 Jul 2026 18:44:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 18:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377895; x=
 1783464295; bh=C33rOZh3CoainYRieTpjM0jlcmLSHcuqY5ULDaTI+q8=; b=j
 8wOHw+CbZBtLsdQqsXwXuSz76D5DjasHZKHbkz6B5GietnesVCvxIEkhuWy3TCTL
 iGbN7gdpQAtq1rubGup6675iboix+0S5vW69igUdcX5hnPajkh81vAGX2q+aZp2R
 7RyidXH4I84x/7YYP3EWKS3hW9f5VfjmuhTLPPRw4hub4hEa9SJy/oob8NnA5hbA
 qJWc/eo7bopZdN7/+rQc/9kLGXeTha/7nO8XfdLteTUKm/T0S3nt5dQ+j26urZCs
 3E/A7SBf5eqBzB4cFxX2piVqlbwva51Zm/2dt5KO6I8cGrLSGXhoqXXNfIhfTp2Q
 //qRTTNgQ9f4AvUXp1CmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377895; x=1783464295; bh=C
 33rOZh3CoainYRieTpjM0jlcmLSHcuqY5ULDaTI+q8=; b=TisbtbdgeFZSBoI3y
 lXtE7gLvrV/SBHVeVLYFaoyErUxMo3+uQaOgInh/C8+oyDoYj0oIPgyTxrwVOXd1
 q31mnupBQhgNtDha3EXIoq0O/HgNi11ttb1Q5IUhLpKBJPYIJdV/SKQghlb0oaSl
 lygE4NsuaI+joafOXOnDDoGYPtDDed3UFsuCx6TPw66lzhaLbFmVPiHR29RDMNfI
 PcFTI/PK53M53fvGtBeP1fSIBr6kevFGewSC+/1C7xyiTUWdtjabYZXuRH48BPcv
 HsbTsQH4JN69TQK9nku6sT6A9hf7SEpZE6Wi77kZEX/oRIovAm5OWbudMPnweumT
 zva+A==
X-ME-Sender: <xms:5y9MasmITr8e8M9vFyoSjmYZXNzR6Ug-jEYdxJsosSgDRIRSUc6F5g>
 <xme:5y9Man3RWEtPCgSRK3hg9ReFjUAiu1iWkHDaHM30ceDtvMFa-Z-zXL6j0VQBlW-SE
 4v0iLzKvikx9y4vxBJhc-rJIjfW5ZRiYPvxQ6hhesQ0jZW4ZjfMMA>
X-ME-Received: <xmr:5y9Mas3QBunFxra9fx_sfu-PK67uu4TrfJZR0sZxULfxcJVyNXX75NWqljYsfam56Au4z74WjD_OWaH4OUVO17Y9Aqzo8ODPKdBlEpUmALysWa1iwQZcAhyAXw>
X-ME-Proxy-Cause: dmFkZTFj5JQpqUxJDcUJ2sWCsKZKclPuT2bVB0FQRjAKIF/sKDLIeA//H/SeuNaNsjsyI/
 GLovIo1aiXSUcVFWzisNrFSjyButVeujuMJk3VZ3IDFeCssXdFFEWUGnPDYbOHrceoCBwt
 PdKgkdL50wU/Kuc2nXFaj9t58LBXlQ4p+egWMertNslLurP+Gzi2ngjrnO4NmxwVp3q0Gu
 podh3AKtGUg+x1TtnfBbfnMUe5kA1K2nN9DRBU3fCZO1vv5XOO+7/JlEq0i4CES6GCR0vD
 hV1pA1aerjW9YEabuc5sq43NfFDlKcLEXtgRzp0jwDe7Yjs1HqLdvCEIdxeBfq8fBzmcsC
 Hi3yJheuLEcDsUbdy09eYWogjKa5102zF+QeYBF++bdjJgcwXJ5HrORSUj9O6mGTAKphHQ
 sBQb3NDHwNSa6pVOe6sKNLiHQMQWOiegin8hxNrBvTgB3EI8yYvQjegHYxgXYieCnwLmBL
 bKAEsn2se6O1ktpcHZmXmdiZAi609ARQA3yxDUPb9cgd0UfzC0VMGCchite5+322mwynVt
 /6dZjQYQprrdRWPFVrl4g6p+iO6sJNJEvKf6kvdllFkitiX/sr2BRK4heQU1go8WTnb1cD
 x0n4dz8L5esU+WSaFhDBDwmR+DhjqNyf8F4z3EaNqSDsInUEgT7+MVE8RzfA
X-ME-Proxy: <xmx:5y9Mapr1Ls3mYDGKCOHgt5T5WMbYm-qX2NTFgItTR6B19lL8kDzaLQ>
 <xmx:5y9MaojDvApNGZ-a7LZ3o1JRmNaOB0b05JId-98-yFRjLiJe-qrKJw>
 <xmx:5y9Mal8m-Gj8fy6hL0Rr4vQ8zPqYCH800oYHQGc8W5a9Izl1yVmTtg>
 <xmx:5y9MakXgNedywZVT_p8TWtSqlJViJmXjSVqMO3kLeZzoMoWgpBgBwA>
 <xmx:5y9Maq4zFBQRC8RrLz9B0GEqhL0qI3w_JynZKLOFVf4PUUZdP0cjYeSN>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:54 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 05/11] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Tue,  7 Jul 2026 00:44:17 +0200
Message-ID: <20260706224426.14156-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

We will make a benefit from this split in later patches.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 59 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d2096eb49d97..386a698ba858 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4869,18 +4869,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
-static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
-                         uint16_t sqid, uint16_t cqid, uint16_t size)
+static void __nvme_init_sq(NvmeSQueue *sq)
 {
+    NvmeCtrl *n = sq->ctrl;
+    uint16_t sqid = sq->sqid;
+    uint16_t cqid = sq->cqid;
     int i;
     NvmeCQueue *cq;
 
-    sq->ctrl = n;
-    sq->dma_addr = dma_addr;
-    sq->sqid = sqid;
-    sq->size = size;
-    sq->cqid = cqid;
-    sq->head = sq->tail = 0;
     sq->io_req = g_new0(NvmeRequest, sq->size);
 
     QTAILQ_INIT(&sq->req_list);
@@ -4910,6 +4906,18 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     n->sq[sqid] = sq;
 }
 
+static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
+                         uint16_t sqid, uint16_t cqid, uint16_t size)
+{
+    sq->ctrl = n;
+    sq->dma_addr = dma_addr;
+    sq->sqid = sqid;
+    sq->size = size;
+    sq->cqid = cqid;
+    sq->head = sq->tail = 0;
+    __nvme_init_sq(sq);
+}
+
 static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeSQueue *sq;
@@ -5570,25 +5578,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
-static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
-                         uint16_t cqid, uint16_t vector, uint16_t size,
-                         uint16_t irq_enabled)
+static void __nvme_init_cq(NvmeCQueue *cq)
 {
+    NvmeCtrl *n = cq->ctrl;
     PCIDevice *pci = PCI_DEVICE(n);
+    uint16_t cqid = cq->cqid;
 
-    if (msix_present(pci) && irq_enabled) {
-        msix_vector_use(pci, vector);
+    if (msix_present(pci) && cq->irq_enabled) {
+        msix_vector_use(pci, cq->vector);
     }
 
-    cq->ctrl = n;
-    cq->cqid = cqid;
-    cq->size = size;
-    cq->dma_addr = dma_addr;
-    cq->phase = 1;
-    cq->irq_enabled = irq_enabled;
-    cq->vector = vector;
-    cq->head = cq->tail = 0;
-    QTAILQ_INIT(&cq->req_list);
     QTAILQ_INIT(&cq->sq_list);
     if (n->dbbuf_enabled) {
         cq->db_addr = n->dbbuf_dbs + (cqid << 3) + (1 << 2);
@@ -5605,6 +5604,22 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
                                  &DEVICE(cq->ctrl)->mem_reentrancy_guard);
 }
 
+static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
+                         uint16_t cqid, uint16_t vector, uint16_t size,
+                         uint16_t irq_enabled)
+{
+    cq->ctrl = n;
+    cq->cqid = cqid;
+    cq->size = size;
+    cq->dma_addr = dma_addr;
+    cq->phase = 1;
+    cq->irq_enabled = irq_enabled;
+    cq->vector = vector;
+    cq->head = cq->tail = 0;
+    QTAILQ_INIT(&cq->req_list);
+    __nvme_init_cq(cq);
+}
+
 static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
-- 
2.53.0


