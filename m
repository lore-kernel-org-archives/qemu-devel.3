Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F90ACD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSJs-0006ol-PO; Mon, 11 May 2026 11:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIL-0005p6-19
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:46 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIJ-0001q5-Fh
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso2909965f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1778512302; x=1779117102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdKjGUvxwDyenN9C+PKFKdrIeRGRcm18kTsUgAEHB4A=;
 b=VnHdilDO84u3O/iIX9Twdz231Kfp7wZF+3IoY9smi+Fqwtd6yrF8DPJG/vjsW50Q1i
 anEMp5DkunjVZPKbkXDsJ25aeayX274rIlvowtYPPCJhrSms1lk4j2lVtKzLbo1xSE7G
 8F4Zp2zVhntuiUb6lvX8s0nkcJvCOGLRssqZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512302; x=1779117102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KdKjGUvxwDyenN9C+PKFKdrIeRGRcm18kTsUgAEHB4A=;
 b=VqQGSR8JJ40DPV6x6iIFEr7pxBrDT/7wz5qErN8yeoV0rFnQms6I+CZcWYkUYpmmca
 PFP5dHycNJDCVvgsu0EIY8xqp/M2KgGGFbo7QyjZCr38S3YGDey783kCdzzWoiapKZEe
 lMKlApJvXJYhhyMw9s3JeSDLIl62VmiZpOi8ap/tf1CRXSlnA4JBxf+Kqne9Q0iYBiy5
 UEQVJRZEzLkhbaICQErnnKf55GiEb1GiyL0ePZk8z8v/U6B8JGBP7r1u76qg4pjD7zux
 CP7bNhXsiHzxzDK8ctOFMyRe1+/6JKJmMTtosXxsjm0/DhX5gx303oekAz1/oSsYdCC0
 GOFQ==
X-Gm-Message-State: AOJu0YwlUStGNDZTh1q7774RMaNZiBYUtKcE5Ah43M+0rU1QQNnSNoMU
 GZNTSzuYZFmOAyLj9EbGynaxpProHlEWre7lsIu2AsTZILgMmLU2BkPV/OC3BHlhMrb3q+lFSn7
 AZn0yp2k=
X-Gm-Gg: Acq92OHUwH34pNSErsSBXTBwC4q9UtARa+ArqSR8LQE7xzgBq9HxA9w3AYSPgicIU1Z
 YCTei6Zj+wL7GoWw1EbJrNXgrNF3fuktyJZi027rKqCamWybv5SM6O4SQpflCI2HCs4ka5B5Mbo
 xiM9X8eSD9sNmRtwcpp3DJna/I/tELzy7syS77PotF4ArIoa+OT2Sm/IqjqfHKnMbzEXGbi8lB6
 SJwZcTdiLNWNl0vkFugqXGmGc8tqTbABWIDvWMji/lnNfyhl+g96higg4Ar+G8pcDbNCtSQq+XX
 FLvRftCPew2yGTizz1wMwP7C0cPvAueRu+H6XyKTjha643+Ys3QrFwEyPcKyXCUEpLRVKd3hPiL
 Jk57eijclWdLGlq3GF8XpWYULeZm0jYBaxNtXGCldwbBBQqc9vVM6FVWBkbr1kuWWn0SUQ5hQOm
 nH3b4lv7PMS1jhpFNbi4kLhrId0byMHwFybaNpeQghhK/eVbCSufW4gPLaRbRDTlOYZFgus+NJ/
 7nj2eigwBM9Do3zwcPj
X-Received: by 2002:a05:600c:8b62:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48e6748afe8mr216558655e9.5.1778512297175; 
 Mon, 11 May 2026 08:11:37 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00267b069c8b2d0c7b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:267b:69c:8b2d:c7b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6813sm65766925e9.6.2026.05.11.08.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:11:36 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v7 3/8] hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
Date: Mon, 11 May 2026 17:11:26 +0200
Message-ID: <20260511151131.483217-4-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511151131.483217-1-alexander@mihalicyn.com>
References: <20260511151131.483217-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

We will make a benefit from this split in later patches.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 59 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 167b8da6342..e79ef536ef8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4854,18 +4854,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
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
@@ -4895,6 +4891,18 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
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
@@ -5555,25 +5563,16 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
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
 
-    if (msix_enabled(pci) && irq_enabled) {
-        msix_vector_use(pci, vector);
+    if (msix_enabled(pci) && cq->irq_enabled) {
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
@@ -5590,6 +5589,22 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
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
2.47.3


