Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E18606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=gyfw5Qq/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=IIWZmeeL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4bH-0000Mf-SI; Mon, 16 Nov 2026 16:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4b1-00008m-EO
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:41 -0500
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xT4av-0004jN-JP
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:37 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DF9837A00E2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 16:50:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 16:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794865831; x=1794952231; bh=b1Juhu3qxew8tjIuou3iICQX7wqIaOox
 olHBzixobkY=; b=gyfw5Qq/BUw3rn7LNnwDA8yA/c56ZXbfSuVucVyrX+1ZrRjA
 q3r0Sa+oWPqa3rUL3HDpXwXgLPzdsIUfoYkEuy7PHvCe6m6p6bAuvni4feuxy2X4
 5+/aYRqY7eRRIVwbXziVsltE34rlBtv40I8sqvoVl4pWu8Lehc/rRbEiKKzo2ELd
 rYVZZk9wvX5HzKyUyYYSAqHGjCI8P+Hu6zxccZslJ2jd+PJqR3mU90UZDY71bS50
 IDqr1CY0NTfB2qxT1t8IZheU2Ur03B9VCwym7vW8aq2vuKJ2tnvkBVts8GvDjp+a
 jYnpywTHr7tj0dCUFEME+iZt07GFTwvwwA/GiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794865831; x=
 1794952231; bh=b1Juhu3qxew8tjIuou3iICQX7wqIaOoxolHBzixobkY=; b=I
 IWZmeeLQpGh6Shzhpk7WVJo/fhJJAzLAPKp6Go1uq09oRiJZbmJbAaFBw5XFKpLv
 yVmoFD94FY77Zes0QuapuE2H71CEFFtxFZDWmVIJs+vte1wmrQOXYRgihSWvewyN
 Syw2qW9aZFge+9K3CiO6gI1bcZNNGwxAoIwwq0htZR0u+LHZVXCXtKHI4KLDzv6M
 7BJQ+bT69DW0kZ1jHTIn3Sby5QRxNC1Pv0cKFA+jJ6yzzI3Mp2qD4KorgZqJq5Yl
 Otc5WYS82dJU5+TcM2Qp7LSdUaxRv5MoWI80qBiRgMDDtWtXRfDWszOzDB10f0Wc
 C0rC2lsdi0IcNpzdE8+fQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794865831; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:ccx8sF1ughIQPXUC/caILN0JsOI0M+MTxeGvFBjymqRa6LA
 XULB66S4qVevbyGK1rLVuh+BO3xR/uLO+SMJlJvpS0+loCZwGZoQ0S3zXaE+QDDq
 VEkqgxKgXdw3Z8Vn55X150bLuGcp8jsfY4Az0PAJ6eCKbTygFCcOzn11nzgtSMzE
 aMF7zuswxqdZeTBrOUDGDqgeir1VyRLyT5F9/6Ly0hd6EdxBzo0N4w4q9jPgBVVa
 j+sp92lAEEOlwGaMwMPFoZpBZgSESwLcyVu+CrgU+QAGB852OCCKPvqJxaB2JcDg
 mJPOg77o336sMcYNo44CNbZf94xm/1+PkhIObKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:OWHWO0E1xIyGkpdaJc/N3aFguCSVNQmSPFOKvwkO3dc=:ZK04NA9ju8Lgay7uIBnFmOIVxHjBYqCLtVVoisgbBqY=;
X-ME-Sender: <xms:p3r7alsj2si8WiiF-Tnbp8eQGOe4CVIh3DXdB2-5lD8YiG4abiQ37Q>
 <xme:p3r7aqfNQOPgr6s2_9eCuiHDlVlnQ5jZkcBaOe02W1591JXTWemv7b6zNJ4Ar2M3U
 wxM1rsgWcp9iOb5qDOTerJ5DhFL3oxUv4MMWNz4DyvYRYCCqAtuefU>
X-ME-Received: <xmr:p3r7aq_qEuZJzxP2Qa-EJjpetmh3-8xkzu-LS4qd0_aElnxxQTQYDRGzCNxUkZFq3JAWyPT9vP4Pf3HiY00vQNbeG1_OVYEH4daFI9877-d-i11YRko4D6N5kw>
X-ME-Proxy-Cause: dmFkZTEOTEsRhshwhFhjGm0XmTp8Zk3rpv3WK1ppJyRPrpT2j0EYQcbyI7e8QRql8kaTJb
 tRNriysCz8DIG6YaRalW/jIfFJO5QkQzQdcdOPUvs9TBMP5MGBovYTCm5QIC6MhperCZy6
 C5gBRDj+CTj34knB28w5xR0SyLo840auzLqb8rUUvaBi7msJsk4wSei8+stZCDXcuGvJ6j
 6UTxvdGJ6FBwpjjzfGYE2DWkobeknWhtC0aVUuOr2Z3Vn1DJ72j0DB4nMvXV8Tv+3QYUOQ
 /kn7BPCLM4cybsOiLvAHfXGUCNBAsifUM75P9GfPBlE2YetPNtOD/3cqARq9HskToQ5AG7
 Wu8xpOPqM81o6vXWgy6tNEoFXRhGvwat3WxMQFpSqM3Apkq5tb4jpBuipg1IjJ+gCl3fjL
 2XU3TO2OiULrKmEzY2HOh+E3RlcOzEtDpNeo590twhcI8q5MbzuhYg668eLEYxVWytpSVs
 H6obf7mcwvx4taC4nnRUDuY4+/2YbDEVHnxTcrkWvUYhxiiEn0j4nZ06gyGuEAzdrmmf9d
 4S7uHXlUwe8oARQ9EMkFxsgLBRnmRxdbZCSh7V9I2LXotCNAVvNiB4Vdwolk61y4qJCNqu
 zg8Gb3JRym6OLkMLctx7IvIxbVioMulYpPbYuzGlZpjW+VtM8FGrcGLqqj6A
X-ME-Proxy: <xmx:p3r7atQG70KdsZtkYXw_NqJoiCrT9TzqTFQkVLANxQbkTzfpQoHJBA>
 <xmx:p3r7ajo1dupJJIZFuS3-q3X95RKNegw_6RuECddsRgUBMNflNgCznA>
 <xmx:p3r7ail7K3PZjLDHw6IcXQQeMosudnYOfyGBYQNC_y4KvSwp7cJwqA>
 <xmx:p3r7akd2drMIhus3vbm4e7ilmXaTiSA_r4vAZglE_UrZ0nzAyaS-pA>
 <xmx:p3r7agFXTRyKf5BqD-VxNnxPqv-laYPQFPij1DLnrCiARqgD_DaBQIZW>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 16:50:29 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?= <mankku@gmail.com>,
 qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 1/7] hw/nvme: prevent cq_pending underflow
Date: Mon, 16 Nov 2026 22:50:07 +0100
Message-ID: <20261116215014.59993-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116215014.59993-1-its@irrelevant.dk>
References: <20261116215014.59993-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markku Ahvenjärvi <mankku@gmail.com>

cq_pending counts interrupt-enabled completion queues with unconsumed
entries. nvme_cq_notifier() and nvme_process_db() decrement it whenever
a CQ becomes empty, but they may also process a notification or doorbell
write for a CQ that was already empty.

Decrement cq_pending only when the CQ contained pending completions
before its head update. Otherwise cq_pending may underflow and
prevent legacy INTx from being deasserted.

Cc: qemu-stable@nongnu.org
Fixes: 83d7ed5c570d ("hw/nvme: fix pin-based interrupt behavior (again)")
Fixes: 2e53b0b45024 ("hw/nvme: Use ioeventfd to handle doorbell updates")
Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 10e5d976a84b..e591842a4a33 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4783,6 +4783,7 @@ static void nvme_cq_notifier(EventNotifier *e)
 {
     NvmeCQueue *cq = container_of(e, NvmeCQueue, notifier);
     NvmeCtrl *n = cq->ctrl;
+    bool pending = cq->tail != cq->head;
 
     if (!event_notifier_test_and_clear(e)) {
         return;
@@ -4791,7 +4792,7 @@ static void nvme_cq_notifier(EventNotifier *e)
     nvme_update_cq_head(cq);
 
     if (cq->tail == cq->head) {
-        if (cq->irq_enabled) {
+        if (cq->irq_enabled && pending) {
             n->cq_pending--;
         }
 
@@ -8565,6 +8566,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         uint16_t new_head = val & 0xffff;
         NvmeCQueue *cq;
+        bool pending;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
         if (unlikely(nvme_check_cqid(n, qid))) {
@@ -8619,13 +8621,14 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             qemu_bh_schedule(cq->bh);
         }
 
+        pending = cq->tail != cq->head;
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
             stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
         }
 
         if (cq->tail == cq->head) {
-            if (cq->irq_enabled) {
+            if (cq->irq_enabled && pending) {
                 n->cq_pending--;
             }
 
-- 
2.53.0


