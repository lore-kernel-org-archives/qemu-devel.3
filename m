Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE6CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwmx-00042d-3a; Mon, 18 May 2026 08:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlu-0003NF-Ns; Mon, 18 May 2026 08:08:36 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlt-00079n-6f; Mon, 18 May 2026 08:08:34 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6C9427A00A4;
 Mon, 18 May 2026 08:08:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 08:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1779106111; x=
 1779192511; bh=tbXFTi8YS7dwA1aT84yOrBaUVntxEmAQl1rJumHbdj4=; b=L
 qXQqM9lExpkh7M7lvxYI+JIcK90g03aDvHKgNmsUI//jW9xIwxem3YRF4CvxtbWo
 j3n4mEAUkdnsFfCBRUmWYs5KUnO9b/7qAF3teXv8+MUgJGauIMfNn3lzUXPnv9Ld
 Fz9lQvSz4XCP68lk1IZ8lrxjV0TkY8XhNskmsmVnd1hIekRP7iVqIPdo8K4v7RMM
 P6mFMxHWF9iYfd8sBnBHqFZ+Dr1yqCCoXG4PQPMtmudG7rGO94m6Qig3su++tUWJ
 h/zwtiI7SCSq6MyIYBGU3l5MTfiZffqICU9leBf7mJwEr4stILd1CMruRwuocazF
 6Xi9LJH1jbVHLgFUgD/mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779106111; x=1779192511; bh=t
 bXFTi8YS7dwA1aT84yOrBaUVntxEmAQl1rJumHbdj4=; b=oYlsUdkol+RRw9nHB
 8dXJlesmKxMmcC9GlPBqnxkq3lCwIZr2Fbtok+ORA5kut/yvqSJo4gEULwCenPuP
 DuHItlbFDW9puDsSDxE3FUs0vNG3c9mz0Eeb/HLgnyHhoZNoiSR917HNbbPRSYhS
 5CLvzSojZnTHcM21o6QgbCTYiyu9HNLDV7QJ1SIhFJ/+0efeBaPZxfpC1NypRSHA
 UlHnr+lschk/o8GZWABeqMwqp51wEEaS+jaE/TaiQXBTNhTDTEnTBso6FFjcaA+4
 0ziIdiusBkO9pH8H+ksN14rG9KXIuj2viai90alPPA1Swz7Mp4D2lZ+Vddi8QHhQ
 8BXZA==
X-ME-Sender: <xms:PwELapt6GHhVGbFF6YbuVyVOoXa7UcaVzLKwNQzEKWMcWBzgFAWBaw>
 <xme:PwELaudzL3IRy0cyw7A5KuGgLjcj80jWLQ6CMwmZGS2QPvLGhYY4f-B8CBJsk24iW
 sh6m5Q8rzzIm6L3CE6ctQcy0bKGGUMjXLNqJYyB9pHWUrteILd0hP0>
X-ME-Received: <xmr:PwELau8zDe7KGTeTwalbXxklrt3rt1Qh6MDeBaD-bLG9wWjaY8wN6nvGq0_LCxqJPXpN-IRPxOGvlbNWxbmO3MPF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuh
 dqshhtrggslhgvsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhr
 ghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrd
 horhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthho
 pehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehqvghmuhdqsghlohgtkh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:PwELahS3T41YygW9Dgbsit3LmukClWZlR3b6_XQdrlEtC1VLTWfSgg>
 <xmx:PwELanrA-m6i0CrONb3caMlNtQd3osqQMszW4_k9xf-im08ZUuG_Zg>
 <xmx:PwELamlFttNmirpyGWao6l_H7vmZu9CTiTp1A0I87_FuTbmwyzIEhA>
 <xmx:PwELaocTRHMh6nEyi87Hcc6ZmiknG-l04AanLzrun62Fl9u33-f5SA>
 <xmx:PwELajxgnB7-SdUotudFsaZvr7XOVIq2Rhg8_LY4wLlEMxEWeE__9phc>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:08:29 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Andreas Hindborg <a.hindborg@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 5/5] hw/nvme: fix admin cq msix setup
Date: Mon, 18 May 2026 14:07:48 +0200
Message-ID: <20260518120748.14831-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518120748.14831-1-its@irrelevant.dk>
References: <20260518120748.14831-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
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

If MSI-X is not enabled when the admin completion queue is created,
msix_vector_use() is not called. But, if MSI-X is subsequently enabled,
msix_notify() will fail to fire the interrupt because the use count for
the vector remains at 0.

msix_vector_use/unuse should be called if MSI-X is *present*, not
*enabled*. Fix this.

Cc: qemu-stable@nongnu.org
Reported-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5b03929451d0..815f39173c8a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5519,7 +5519,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
         event_notifier_set_handler(&cq->notifier, NULL);
         event_notifier_cleanup(&cq->notifier);
     }
-    if (msix_enabled(pci) && cq->irq_enabled) {
+    if (msix_present(pci) && cq->irq_enabled) {
         msix_vector_unuse(pci, cq->vector);
     }
     if (cq->cqid) {
@@ -5560,7 +5560,7 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
 {
     PCIDevice *pci = PCI_DEVICE(n);
 
-    if (msix_enabled(pci) && irq_enabled) {
+    if (msix_present(pci) && irq_enabled) {
         msix_vector_use(pci, vector);
     }
 
-- 
2.53.0


