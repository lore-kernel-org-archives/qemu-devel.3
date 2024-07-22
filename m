Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB65BC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVw5k-0001yY-Hv; Mon, 22 Jul 2024 12:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5f-0001oz-Iw; Mon, 22 Jul 2024 12:40:48 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5b-0005vd-C9; Mon, 22 Jul 2024 12:40:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id A608D1380532;
 Mon, 22 Jul 2024 12:40:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 22 Jul 2024 12:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1721666441; x=
 1721752841; bh=2NT24dZB6HK3qeQzjwOqawaiocs07qtQB/fOJxOl5W4=; b=Q
 XbM4LO0Zxo83OjXejW2S6TCe7Zvy8UMQMb1RIf6fsn+bjsCMzQAMcTNV4a4DljSJ
 OsMassctXsCL/yAT5mCQPPlQaRMK325BgNyphWwtB3/twR1DDaAitudUW2vEd++h
 WcqSgNz+XNMQS9en3xCwVMgkKQkhma6NE8SiYgBr71u9wnOQl2iVxaZn+zdlHOLN
 3LRDxK4vADP1TRv//Za/zU94TE/AHmfVJqqyW2cuLjEUXx6aq+u4ws8Nlt2EE63s
 qpGqGi0y5n8B/jWJ8oGX06nG6C1l1YeavA4d5yVyPRrwoQNfHSYC8HUuUFxrtNcS
 zjuw7A0ft2ItXRO3hA7eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721666441; x=
 1721752841; bh=2NT24dZB6HK3qeQzjwOqawaiocs07qtQB/fOJxOl5W4=; b=Z
 nlS8DHPHCBdaFWEnlcpgkooZxr6oL/0Y3oaoAfquOWZrgXc7QhEItSBTUJcdpa20
 FwDbcm+gzxW8b3wfKXAROhoydzt1zcH/ot+cIAdqmU7GqYIxF9kVpm0/ujnnLfqs
 Oue+3JtkRbF2qNzHbQdRsO0B5DorIWlE+san/Pc8/kJMnAU8QwtvXdkFSP0FPwzx
 2GjJ+f1XCEK4X7QmrS4/lXYY2yAyMfhm/vCiYFoE7Zi5BXpVSQQMt4bCwDQkdWjn
 KsAhSP2BwwDuUECJ3zdhsZw4DKxWpDCz852JOK+euvr7SbkUoqlqxdWJR6tYOe9O
 M0aOTy6iwGvoHDPPCu+3w==
X-ME-Sender: <xms:iYueZpsWVqLfGnVqtvv_Eg5MvQriJSw_D2tUI1xhJ5nj07U9QEs9dQ>
 <xme:iYueZif-0P-eCgGf6_xQH6gD09z6xBGB_fFQ410f-2Xz6oVO4kZkC1dPI4iHPsphw
 6v5FshkaN5tbwqhw4A>
X-ME-Received: <xmr:iYueZsyYp8XCG5F0zDT9aoleQG0xtKv2RfaUD8NTrmzVNb4azhPIYdcDHFMik24dKz6IRpWJ7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgddutdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:iYueZgPDlsTc-Cttp9hJ5Xyet9grhH2O_Sp1dHZXx4hg4luB5avkjw>
 <xmx:iYueZp9-bcRliOoxG80ZGGCZHmZv9c3QTdWq7jVY2i1xa4pSkYKiIA>
 <xmx:iYueZgVg3B_H1c5GSqUCbSyuCoye_PmZ9lDlsaoy4qSUCQleiPGdnA>
 <xmx:iYueZqfxUtzAYB0lBrjVzi7xJ-i3-Aif-7Kfj-vSDrU1b_8M74IbaA>
 <xmx:iYueZnfCTo9FTJx8AeAEB7jjzsGsVbreYU6vD9OdinPgXZHnor6yQsFU>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 12:40:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Arun Kumar <arun.kka@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 2/4] hw/nvme: add cross namespace copy support
Date: Mon, 22 Jul 2024 18:40:29 +0200
Message-ID: <20240722164026.61128-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722164026.61128-6-its@irrelevant.dk>
References: <20240722164026.61128-6-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28459; i=k.jensen@samsung.com;
 h=from:subject; bh=+k2fOQ/tUhIhydW5huOyU1sC9j4Df9xc0B/kMtSlaiI=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaei3vFlQxeHSRs98FIOXtf4kmGKNHzk5i1v
 w++y/vRHBlN5okBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmnot7AAoJEE3hrzFt
 Tw3pDIwH/2aSHB0osCfjPlGLHSLvjXRocccmYHDzFTyeZPOmg6hvYw9KiPdSaa3dodqqpu3fCJD
 SD+JQpGemPrBUcU7wr4TkauCQmyIMGAdgbKmPTucc8KLkjVJ9ebpjTwOYggQDPae0VAaM6TlXYk
 J95I3EiOc0uXx9ZivTHBwHcdHyuZUaiJ2gyy7rc7hSaC7pAUbyISPc7Ha5kJLMWaCptUnSbzp4T
 /GG5ntTeqribmxkkl0a6q9fVynAaTs+ED0hl5QuXvYX+zgl4SFKI7DMDELw5vOL3p7buC0PO9xP
 KFIbFnOecYqYa/YV6Pgtgv6MH9rzNELGwcJvU/dfEmedNm8RiNdHcakT
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout4-smtp.messagingengine.com
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

From: Arun Kumar <arun.kka@samsung.com>

Extend copy command to copy user data across different namespaces via
support for specifying a namespace for each source range

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 369 +++++++++++++++++++++++++++++++------------
 include/block/nvme.h |  37 +++--
 2 files changed, 296 insertions(+), 110 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f7b4e4627dd2..385438a9ae09 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2696,6 +2696,7 @@ typedef struct NvmeCopyAIOCB {
     BlockAIOCB common;
     BlockAIOCB *aiocb;
     NvmeRequest *req;
+    NvmeCtrl *n;
     int ret;
 
     void *ranges;
@@ -2714,6 +2715,8 @@ typedef struct NvmeCopyAIOCB {
     uint64_t slba;
 
     NvmeZone *zone;
+    NvmeNamespace *sns;
+    uint32_t tcl;
 } NvmeCopyAIOCB;
 
 static void nvme_copy_cancel(BlockAIOCB *aiocb)
@@ -2760,13 +2763,19 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 
 static void nvme_do_copy(NvmeCopyAIOCB *iocb);
 
-static void nvme_copy_source_range_parse_format0(void *ranges, int idx,
-                                                 uint64_t *slba, uint32_t *nlb,
-                                                 uint16_t *apptag,
-                                                 uint16_t *appmask,
-                                                 uint64_t *reftag)
+static void nvme_copy_source_range_parse_format0_2(void *ranges,
+                                                   int idx, uint64_t *slba,
+                                                   uint32_t *nlb,
+                                                   uint32_t *snsid,
+                                                   uint16_t *apptag,
+                                                   uint16_t *appmask,
+                                                   uint64_t *reftag)
 {
-    NvmeCopySourceRangeFormat0 *_ranges = ranges;
+    NvmeCopySourceRangeFormat0_2 *_ranges = ranges;
+
+    if (snsid) {
+        *snsid = le32_to_cpu(_ranges[idx].sparams);
+    }
 
     if (slba) {
         *slba = le64_to_cpu(_ranges[idx].slba);
@@ -2789,13 +2798,19 @@ static void nvme_copy_source_range_parse_format0(void *ranges, int idx,
     }
 }
 
-static void nvme_copy_source_range_parse_format1(void *ranges, int idx,
-                                                 uint64_t *slba, uint32_t *nlb,
-                                                 uint16_t *apptag,
-                                                 uint16_t *appmask,
-                                                 uint64_t *reftag)
+static void nvme_copy_source_range_parse_format1_3(void *ranges, int idx,
+                                                   uint64_t *slba,
+                                                   uint32_t *nlb,
+                                                   uint32_t *snsid,
+                                                   uint16_t *apptag,
+                                                   uint16_t *appmask,
+                                                   uint64_t *reftag)
 {
-    NvmeCopySourceRangeFormat1 *_ranges = ranges;
+    NvmeCopySourceRangeFormat1_3 *_ranges = ranges;
+
+    if (snsid) {
+        *snsid = le32_to_cpu(_ranges[idx].sparams);
+    }
 
     if (slba) {
         *slba = le64_to_cpu(_ranges[idx].slba);
@@ -2827,18 +2842,20 @@ static void nvme_copy_source_range_parse_format1(void *ranges, int idx,
 
 static void nvme_copy_source_range_parse(void *ranges, int idx, uint8_t format,
                                          uint64_t *slba, uint32_t *nlb,
-                                         uint16_t *apptag, uint16_t *appmask,
-                                         uint64_t *reftag)
+                                         uint32_t *snsid, uint16_t *apptag,
+                                         uint16_t *appmask, uint64_t *reftag)
 {
     switch (format) {
     case NVME_COPY_FORMAT_0:
-        nvme_copy_source_range_parse_format0(ranges, idx, slba, nlb, apptag,
-                                             appmask, reftag);
+    case NVME_COPY_FORMAT_2:
+        nvme_copy_source_range_parse_format0_2(ranges, idx, slba, nlb, snsid,
+                                               apptag, appmask, reftag);
         break;
 
     case NVME_COPY_FORMAT_1:
-        nvme_copy_source_range_parse_format1(ranges, idx, slba, nlb, apptag,
-                                             appmask, reftag);
+    case NVME_COPY_FORMAT_3:
+        nvme_copy_source_range_parse_format1_3(ranges, idx, slba, nlb, snsid,
+                                               apptag, appmask, reftag);
         break;
 
     default:
@@ -2854,10 +2871,10 @@ static inline uint16_t nvme_check_copy_mcl(NvmeNamespace *ns,
     for (int idx = 0; idx < nr; idx++) {
         uint32_t nlb;
         nvme_copy_source_range_parse(iocb->ranges, idx, iocb->format, NULL,
-                                     &nlb, NULL, NULL, NULL);
+                                     &nlb, NULL, NULL, NULL, NULL);
         copy_len += nlb;
     }
-
+    iocb->tcl = copy_len;
     if (copy_len > ns->id_ns.mcl) {
         return NVME_CMD_SIZE_LIMIT | NVME_DNR;
     }
@@ -2869,11 +2886,11 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *dns = req->ns;
     uint32_t nlb;
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
-                                 &nlb, NULL, NULL, NULL);
+                                 &nlb, NULL, NULL, NULL, NULL);
 
     if (ret < 0) {
         iocb->ret = ret;
@@ -2882,8 +2899,8 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
         goto out;
     }
 
-    if (ns->params.zoned) {
-        nvme_advance_zone_wp(ns, iocb->zone, nlb);
+    if (dns->params.zoned) {
+        nvme_advance_zone_wp(dns, iocb->zone, nlb);
     }
 
     iocb->idx++;
@@ -2896,25 +2913,25 @@ static void nvme_copy_out_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *dns = req->ns;
     uint32_t nlb;
     size_t mlen;
     uint8_t *mbounce;
 
-    if (ret < 0 || iocb->ret < 0 || !ns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0 || !dns->lbaf.ms) {
         goto out;
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
-                                 &nlb, NULL, NULL, NULL);
+                                 &nlb, NULL, NULL, NULL, NULL);
 
-    mlen = nvme_m2b(ns, nlb);
-    mbounce = iocb->bounce + nvme_l2b(ns, nlb);
+    mlen = nvme_m2b(dns, nlb);
+    mbounce = iocb->bounce + nvme_l2b(dns, nlb);
 
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, mbounce, mlen);
 
-    iocb->aiocb = blk_aio_pwritev(ns->blkconf.blk, nvme_moff(ns, iocb->slba),
+    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_moff(dns, iocb->slba),
                                   &iocb->iov, 0, nvme_copy_out_completed_cb,
                                   iocb);
 
@@ -2928,12 +2945,15 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *sns = iocb->sns;
+    NvmeNamespace *dns = req->ns;
+    NvmeCopyCmd *copy = NULL;
+    uint8_t *mbounce = NULL;
     uint32_t nlb;
     uint64_t slba;
     uint16_t apptag, appmask;
     uint64_t reftag;
-    size_t len;
+    size_t len, mlen;
     uint16_t status;
 
     if (ret < 0) {
@@ -2944,43 +2964,51 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
-                                 &nlb, &apptag, &appmask, &reftag);
-    len = nvme_l2b(ns, nlb);
+                                 &nlb, NULL, &apptag, &appmask, &reftag);
 
     trace_pci_nvme_copy_out(iocb->slba, nlb);
 
-    if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps)) {
-        NvmeCopyCmd *copy = (NvmeCopyCmd *)&req->cmd;
+    len = nvme_l2b(sns, nlb);
+
+    if (NVME_ID_NS_DPS_TYPE(sns->id_ns.dps)) {
+        copy = (NvmeCopyCmd *)&req->cmd;
 
         uint16_t prinfor = ((copy->control[0] >> 4) & 0xf);
+
+        mlen = nvme_m2b(sns, nlb);
+        mbounce = iocb->bounce + nvme_l2b(sns, nlb);
+
+        status = nvme_dif_mangle_mdata(sns, mbounce, mlen, slba);
+        if (status) {
+            goto invalid;
+        }
+        status = nvme_dif_check(sns, iocb->bounce, len, mbounce, mlen, prinfor,
+                                slba, apptag, appmask, &reftag);
+        if (status) {
+            goto invalid;
+        }
+    }
+
+    if (NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+        copy = (NvmeCopyCmd *)&req->cmd;
         uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
 
-        size_t mlen = nvme_m2b(ns, nlb);
-        uint8_t *mbounce = iocb->bounce + nvme_l2b(ns, nlb);
-
-        status = nvme_dif_mangle_mdata(ns, mbounce, mlen, slba);
-        if (status) {
-            goto invalid;
-        }
-        status = nvme_dif_check(ns, iocb->bounce, len, mbounce, mlen, prinfor,
-                                slba, apptag, appmask, &reftag);
-        if (status) {
-            goto invalid;
-        }
+        mlen = nvme_m2b(dns, nlb);
+        mbounce = iocb->bounce + nvme_l2b(dns, nlb);
 
         apptag = le16_to_cpu(copy->apptag);
         appmask = le16_to_cpu(copy->appmask);
 
         if (prinfow & NVME_PRINFO_PRACT) {
-            status = nvme_check_prinfo(ns, prinfow, iocb->slba, iocb->reftag);
+            status = nvme_check_prinfo(dns, prinfow, iocb->slba, iocb->reftag);
             if (status) {
                 goto invalid;
             }
 
-            nvme_dif_pract_generate_dif(ns, iocb->bounce, len, mbounce, mlen,
+            nvme_dif_pract_generate_dif(dns, iocb->bounce, len, mbounce, mlen,
                                         apptag, &iocb->reftag);
         } else {
-            status = nvme_dif_check(ns, iocb->bounce, len, mbounce, mlen,
+            status = nvme_dif_check(dns, iocb->bounce, len, mbounce, mlen,
                                     prinfow, iocb->slba, apptag, appmask,
                                     &iocb->reftag);
             if (status) {
@@ -2989,13 +3017,13 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
         }
     }
 
-    status = nvme_check_bounds(ns, iocb->slba, nlb);
+    status = nvme_check_bounds(dns, iocb->slba, nlb);
     if (status) {
         goto invalid;
     }
 
-    if (ns->params.zoned) {
-        status = nvme_check_zone_write(ns, iocb->zone, iocb->slba, nlb);
+    if (dns->params.zoned) {
+        status = nvme_check_zone_write(dns, iocb->zone, iocb->slba, nlb);
         if (status) {
             goto invalid;
         }
@@ -3008,7 +3036,10 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    iocb->aiocb = blk_aio_pwritev(ns->blkconf.blk, nvme_l2b(ns, iocb->slba),
+    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, 0,
+                     BLOCK_ACCT_WRITE);
+
+    iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_l2b(dns, iocb->slba),
                                   &iocb->iov, 0, nvme_copy_out_cb, iocb);
 
     return;
@@ -3023,23 +3054,22 @@ out:
 static void nvme_copy_in_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
-    NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *sns = iocb->sns;
     uint64_t slba;
     uint32_t nlb;
 
-    if (ret < 0 || iocb->ret < 0 || !ns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0 || !sns->lbaf.ms) {
         goto out;
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
-                                 &nlb, NULL, NULL, NULL);
+                                 &nlb, NULL, NULL, NULL, NULL);
 
     qemu_iovec_reset(&iocb->iov);
-    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(ns, nlb),
-                   nvme_m2b(ns, nlb));
+    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb),
+                   nvme_m2b(sns, nlb));
 
-    iocb->aiocb = blk_aio_preadv(ns->blkconf.blk, nvme_moff(ns, slba),
+    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_moff(sns, slba),
                                  &iocb->iov, 0, nvme_copy_in_completed_cb,
                                  iocb);
     return;
@@ -3048,14 +3078,78 @@ out:
     nvme_copy_in_completed_cb(iocb, ret);
 }
 
+static inline bool nvme_csi_supports_copy(uint8_t csi)
+{
+    return csi == NVME_CSI_NVM || csi == NVME_CSI_ZONED;
+}
+
+static inline bool nvme_copy_ns_format_match(NvmeNamespace *sns,
+                                             NvmeNamespace *dns)
+{
+    return sns->lbaf.ds == dns->lbaf.ds && sns->lbaf.ms == dns->lbaf.ms;
+}
+
+static bool nvme_copy_matching_ns_format(NvmeNamespace *sns, NvmeNamespace *dns,
+                                         bool pi_enable)
+{
+    if (!nvme_csi_supports_copy(sns->csi) ||
+        !nvme_csi_supports_copy(dns->csi)) {
+        return false;
+    }
+
+    if (!pi_enable && !nvme_copy_ns_format_match(sns, dns)) {
+            return false;
+    }
+
+    if (pi_enable && (!nvme_copy_ns_format_match(sns, dns) ||
+        sns->id_ns.dps != dns->id_ns.dps)) {
+            return false;
+    }
+
+    return true;
+}
+
+static inline bool nvme_copy_corresp_pi_match(NvmeNamespace *sns,
+                                              NvmeNamespace *dns)
+{
+    return sns->lbaf.ms == 0 &&
+           ((dns->lbaf.ms == 8 && dns->pif == 0) ||
+           (dns->lbaf.ms == 16 && dns->pif == 1));
+}
+
+static bool nvme_copy_corresp_pi_format(NvmeNamespace *sns, NvmeNamespace *dns,
+                                        bool sns_pi_en)
+{
+    if (!nvme_csi_supports_copy(sns->csi) ||
+        !nvme_csi_supports_copy(dns->csi)) {
+        return false;
+    }
+
+    if (!sns_pi_en && !nvme_copy_corresp_pi_match(sns, dns)) {
+        return false;
+    }
+
+    if (sns_pi_en && !nvme_copy_corresp_pi_match(dns, sns)) {
+        return false;
+    }
+
+    return true;
+}
+
 static void nvme_do_copy(NvmeCopyAIOCB *iocb)
 {
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
+    NvmeNamespace *sns;
+    NvmeNamespace *dns = req->ns;
+    NvmeCopyCmd *copy = (NvmeCopyCmd *)&req->cmd;
+    uint16_t prinfor = ((copy->control[0] >> 4) & 0xf);
+    uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
     uint64_t slba;
     uint32_t nlb;
     size_t len;
     uint16_t status;
+    uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
+    uint32_t snsid = dnsid;
 
     if (iocb->ret < 0) {
         goto done;
@@ -3065,40 +3159,124 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
         goto done;
     }
 
-    nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
-                                 &nlb, NULL, NULL, NULL);
-    len = nvme_l2b(ns, nlb);
+    if (iocb->format == 2 || iocb->format == 3) {
+        nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format,
+                                     &slba, &nlb, &snsid, NULL, NULL, NULL);
+        if (snsid != dnsid) {
+            if (snsid == NVME_NSID_BROADCAST ||
+                !nvme_nsid_valid(iocb->n, snsid)) {
+                status = NVME_INVALID_NSID | NVME_DNR;
+                goto invalid;
+            }
+            iocb->sns = nvme_ns(iocb->n, snsid);
+            if (unlikely(!iocb->sns)) {
+                status = NVME_INVALID_FIELD | NVME_DNR;
+                goto invalid;
+            }
+        } else {
+            if (((slba + nlb) > iocb->slba) &&
+                ((slba + nlb) < (iocb->slba + iocb->tcl))) {
+                status = NVME_CMD_OVERLAP_IO_RANGE | NVME_DNR;
+                goto invalid;
+            }
+        }
+    } else {
+        nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format,
+                                     &slba, &nlb, NULL, NULL, NULL, NULL);
+    }
+
+    sns = iocb->sns;
+    if ((snsid == dnsid) && NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+        ((prinfor & NVME_PRINFO_PRACT) != (prinfow & NVME_PRINFO_PRACT))) {
+        status = NVME_INVALID_FIELD | NVME_DNR;
+        goto invalid;
+    } else if (snsid != dnsid) {
+        if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if (!nvme_copy_matching_ns_format(sns, dns, false)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            }
+        }
+        if (NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if ((prinfor & NVME_PRINFO_PRACT) !=
+                (prinfow & NVME_PRINFO_PRACT)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            } else {
+                if (!nvme_copy_matching_ns_format(sns, dns, true)) {
+                    status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                    goto invalid;
+                }
+            }
+        }
+
+        if (!NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if (!(prinfow & NVME_PRINFO_PRACT)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            } else {
+                if (!nvme_copy_corresp_pi_format(sns, dns, false)) {
+                    status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                    goto invalid;
+                }
+            }
+        }
+
+        if (NVME_ID_NS_DPS_TYPE(sns->id_ns.dps) &&
+            !NVME_ID_NS_DPS_TYPE(dns->id_ns.dps)) {
+            if (!(prinfor & NVME_PRINFO_PRACT)) {
+                status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                goto invalid;
+            } else {
+                if (!nvme_copy_corresp_pi_format(sns, dns, true)) {
+                    status = NVME_CMD_INCOMP_NS_OR_FMT | NVME_DNR;
+                    goto invalid;
+                }
+            }
+        }
+    }
+    len = nvme_l2b(sns, nlb);
 
     trace_pci_nvme_copy_source_range(slba, nlb);
 
-    if (nlb > le16_to_cpu(ns->id_ns.mssrl)) {
+    if (nlb > le16_to_cpu(sns->id_ns.mssrl)) {
         status = NVME_CMD_SIZE_LIMIT | NVME_DNR;
         goto invalid;
     }
 
-    status = nvme_check_bounds(ns, slba, nlb);
+    status = nvme_check_bounds(sns, slba, nlb);
     if (status) {
         goto invalid;
     }
 
-    if (NVME_ERR_REC_DULBE(ns->features.err_rec)) {
-        status = nvme_check_dulbe(ns, slba, nlb);
+    if (NVME_ERR_REC_DULBE(sns->features.err_rec)) {
+        status = nvme_check_dulbe(sns, slba, nlb);
         if (status) {
             goto invalid;
         }
     }
 
-    if (ns->params.zoned) {
-        status = nvme_check_zone_read(ns, slba, nlb);
+    if (sns->params.zoned) {
+        status = nvme_check_zone_read(sns, slba, nlb);
         if (status) {
             goto invalid;
         }
     }
 
+    g_free(iocb->bounce);
+    iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
+                              sns->lbasz + sns->lbaf.ms);
+
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    iocb->aiocb = blk_aio_preadv(ns->blkconf.blk, nvme_l2b(ns, slba),
+    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
+                     BLOCK_ACCT_READ);
+
+    iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_l2b(sns, slba),
                                  &iocb->iov, 0, nvme_copy_in_cb, iocb);
     return;
 
@@ -3117,9 +3295,7 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
                                       nvme_misc_cb, req);
     uint16_t nr = copy->nr + 1;
     uint8_t format = copy->control[0] & 0xf;
-    uint16_t prinfor = ((copy->control[0] >> 4) & 0xf);
-    uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
-    size_t len = sizeof(NvmeCopySourceRangeFormat0);
+    size_t len = sizeof(NvmeCopySourceRangeFormat0_2);
 
     uint16_t status;
 
@@ -3128,13 +3304,9 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
     iocb->ranges = NULL;
     iocb->zone = NULL;
 
-    if (NVME_ID_NS_DPS_TYPE(ns->id_ns.dps) &&
-        ((prinfor & NVME_PRINFO_PRACT) != (prinfow & NVME_PRINFO_PRACT))) {
-        status = NVME_INVALID_FIELD | NVME_DNR;
-        goto invalid;
-    }
-
-    if (!(n->id_ctrl.ocfs & (1 << format))) {
+    if (!(n->id_ctrl.ocfs & (1 << format)) ||
+        ((format == 2 || format == 3) &&
+         !(n->features.hbs.cdfe & (1 << format)))) {
         trace_pci_nvme_err_copy_invalid_format(format);
         status = NVME_INVALID_FIELD | NVME_DNR;
         goto invalid;
@@ -3145,14 +3317,14 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
         goto invalid;
     }
 
-    if ((ns->pif == 0x0 && format != 0x0) ||
-        (ns->pif != 0x0 && format != 0x1)) {
+    if ((ns->pif == 0x0 && (format != 0x0 && format != 0x2)) ||
+        (ns->pif != 0x0 && (format != 0x1 && format != 0x3))) {
         status = NVME_INVALID_FORMAT | NVME_DNR;
         goto invalid;
     }
 
     if (ns->pif) {
-        len = sizeof(NvmeCopySourceRangeFormat1);
+        len = sizeof(NvmeCopySourceRangeFormat1_3);
     }
 
     iocb->format = format;
@@ -3188,17 +3360,13 @@ static uint16_t nvme_copy(NvmeCtrl *n, NvmeRequest *req)
     iocb->idx = 0;
     iocb->reftag = le32_to_cpu(copy->reftag);
     iocb->reftag |= (uint64_t)le32_to_cpu(copy->cdw3) << 32;
-    iocb->bounce = g_malloc_n(le16_to_cpu(ns->id_ns.mssrl),
-                              ns->lbasz + ns->lbaf.ms);
 
     qemu_iovec_init(&iocb->iov, 1);
 
-    block_acct_start(blk_get_stats(ns->blkconf.blk), &iocb->acct.read, 0,
-                     BLOCK_ACCT_READ);
-    block_acct_start(blk_get_stats(ns->blkconf.blk), &iocb->acct.write, 0,
-                     BLOCK_ACCT_WRITE);
-
     req->aiocb = &iocb->common;
+    iocb->sns = req->ns;
+    iocb->n = n;
+    iocb->bounce = NULL;
     nvme_do_copy(iocb);
 
     return NVME_NO_COMPLETE;
@@ -4407,10 +4575,6 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
-    if (!nvme_nsid_valid(n, nsid)) {
-        return NVME_INVALID_NSID | NVME_DNR;
-    }
-
     /*
      * In the base NVM command set, Flush may apply to all namespaces
      * (indicated by NSID being set to FFFFFFFFh). But if that feature is used
@@ -4430,10 +4594,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
      * device only supports namespace types that includes the NVM Flush command
      * (NVM and Zoned), so always do an NVM Flush.
      */
+
     if (req->cmd.opcode == NVME_CMD_FLUSH) {
         return nvme_flush(n, req);
     }
 
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
     ns = nvme_ns(n, nsid);
     if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -8288,7 +8457,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_NVMCSA | NVME_ONCS_NVMAFC);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
@@ -8299,7 +8469,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
      */
     id->vwc = NVME_VWC_NSID_BROADCAST_SUPPORT | NVME_VWC_PRESENT;
 
-    id->ocfs = cpu_to_le16(NVME_OCFS_COPY_FORMAT_0 | NVME_OCFS_COPY_FORMAT_1);
+    id->ocfs = cpu_to_le16(NVME_OCFS_COPY_FORMAT_0 | NVME_OCFS_COPY_FORMAT_1 |
+                            NVME_OCFS_COPY_FORMAT_2 | NVME_OCFS_COPY_FORMAT_3);
     id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
 
     nvme_init_subnqn(n);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 7c77d38174a7..5298bc4a2867 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -799,6 +799,8 @@ typedef struct QEMU_PACKED NvmeDsmRange {
 enum {
     NVME_COPY_FORMAT_0 = 0x0,
     NVME_COPY_FORMAT_1 = 0x1,
+    NVME_COPY_FORMAT_2 = 0x2,
+    NVME_COPY_FORMAT_3 = 0x3,
 };
 
 typedef struct QEMU_PACKED NvmeCopyCmd {
@@ -820,25 +822,30 @@ typedef struct QEMU_PACKED NvmeCopyCmd {
     uint16_t    appmask;
 } NvmeCopyCmd;
 
-typedef struct QEMU_PACKED NvmeCopySourceRangeFormat0 {
-    uint8_t  rsvd0[8];
+typedef struct QEMU_PACKED NvmeCopySourceRangeFormat0_2 {
+    uint32_t sparams;
+    uint8_t  rsvd4[4];
     uint64_t slba;
     uint16_t nlb;
-    uint8_t  rsvd18[6];
+    uint8_t  rsvd18[4];
+    uint16_t sopt;
     uint32_t reftag;
     uint16_t apptag;
     uint16_t appmask;
-} NvmeCopySourceRangeFormat0;
+} NvmeCopySourceRangeFormat0_2;
 
-typedef struct QEMU_PACKED NvmeCopySourceRangeFormat1 {
-    uint8_t  rsvd0[8];
+typedef struct QEMU_PACKED NvmeCopySourceRangeFormat1_3 {
+    uint32_t sparams;
+    uint8_t  rsvd4[4];
     uint64_t slba;
     uint16_t nlb;
-    uint8_t  rsvd18[8];
+    uint8_t  rsvd18[4];
+    uint16_t sopt;
+    uint8_t  rsvd24[2];
     uint8_t  sr[10];
     uint16_t apptag;
     uint16_t appmask;
-} NvmeCopySourceRangeFormat1;
+} NvmeCopySourceRangeFormat1_3;
 
 enum NvmeAsyncEventRequest {
     NVME_AER_TYPE_ERROR                     = 0,
@@ -937,6 +944,8 @@ enum NvmeStatusCodes {
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
     NVME_CMD_SIZE_LIMIT         = 0x0183,
+    NVME_CMD_INCOMP_NS_OR_FMT   = 0x0185,
+    NVME_CMD_OVERLAP_IO_RANGE   = 0x0187,
     NVME_INVALID_ZONE_OP        = 0x01b6,
     NVME_NOZRWA                 = 0x01b7,
     NVME_ZONE_BOUNDARY_ERROR    = 0x01b8,
@@ -1195,11 +1204,15 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_TIMESTAMP     = 1 << 6,
     NVME_ONCS_VERIFY        = 1 << 7,
     NVME_ONCS_COPY          = 1 << 8,
+    NVME_ONCS_NVMCSA        = 1 << 9,
+    NVME_ONCS_NVMAFC        = 1 << 10,
 };
 
 enum NvmeIdCtrlOcfs {
     NVME_OCFS_COPY_FORMAT_0 = 1 << NVME_COPY_FORMAT_0,
     NVME_OCFS_COPY_FORMAT_1 = 1 << NVME_COPY_FORMAT_1,
+    NVME_OCFS_COPY_FORMAT_2 = 1 << NVME_COPY_FORMAT_2,
+    NVME_OCFS_COPY_FORMAT_3 = 1 << NVME_COPY_FORMAT_3,
 };
 
 enum NvmeIdctrlVwc {
@@ -1333,7 +1346,9 @@ typedef struct NvmeHostBehaviorSupport {
     uint8_t     acre;
     uint8_t     etdas;
     uint8_t     lbafee;
-    uint8_t     rsvd3[509];
+    uint8_t     rsvd3;
+    uint16_t    cdfe;
+    uint8_t     rsvd6[506];
 } NvmeHostBehaviorSupport;
 
 typedef struct QEMU_PACKED NvmeLBAF {
@@ -1833,8 +1848,8 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeZonedResult) != 8);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat0) != 32);
-    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat1) != 40);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat0_2) != 32);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeCopySourceRangeFormat1_3) != 40);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDeleteQ) != 64);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCreateCq) != 64);
-- 
2.45.2


