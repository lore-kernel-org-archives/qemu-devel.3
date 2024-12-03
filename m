Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EC8E6C60D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMRY-0000Ai-TQ; Tue, 03 Dec 2024 01:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRW-00009J-DD; Tue, 03 Dec 2024 01:31:30 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRS-0008D9-51; Tue, 03 Dec 2024 01:31:30 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id DC0411140120;
 Tue,  3 Dec 2024 01:31:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 03 Dec 2024 01:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1733207484; x=
 1733293884; bh=hbBVSV9xWSk05cpTGufFRYoJ/rmXTFdWFCfj28mgebw=; b=n
 7tj9VqcZb7opHxW+YlALo4yFi1uXhMSy9auOV/hO33puPKgK+Ku/+vI5KyPkZyGk
 JuOjE4HdskAYkibIDs+iucs44gRD3jh2qoaQvEZh7sh97jumxKKWksZnKbCHdy4k
 0zRgz+DF//u7FpY/aZqJSyFLltcZ2rCgPGJrM+Phqb+6WO3EaxwOBeudvR7W81X4
 6RCfdl25F+6KVNHtkz2eWgoASLCD/it0ma8wJWy9M17+m2tocY4Z4qFeVRvEvcj0
 fT9tNSPkYw7oFOUeV9xP4KoDqZe/tYFTtImhT/7dfTth31OVgpYhp9YH9kkRzW5K
 4qSyKxZHL3mMPECOP8zfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1733207484; x=1733293884; bh=h
 bBVSV9xWSk05cpTGufFRYoJ/rmXTFdWFCfj28mgebw=; b=d1pD3w6BIEwPkBp6f
 kQM1nT2532CnMjDlX7PCezhDLPGDy+PafIjfQTOQ93fg8PmPVhWy+q1qtzNsGvmt
 wUM3O1zfYMTe4o2lvMP6VIEYfLQ5Xl4sRKFNneONCJ3apzzaBhCTyTeAO1Oi+zlb
 7E8aurOw6fapZgpSine7IMB3qRT/LTyZ8Bfw4H2NJR4xcBZ6AUYjsVCUGDbumJdp
 kSgr6XIP3S3PnxJLCUvR70HnlVkBd4el3bDAgc0PnzT12MR0EKRUiDY3VqDaZLna
 voCoTEfIe3Y5zUzVayy4q1APkNUMkDgvdTci3wbpyOsKD7lw8M/2VMpWWlE8FkKW
 yYXHA==
X-ME-Sender: <xms:vKVOZx3cFBuBwGnZNQlCGpYruwNhQsyqGeQcT-ewZlLBcTqtLwkVtg>
 <xme:vKVOZ4HiVZ5i9Z01b37QpM14YhofVxce-RKU-23uGVmCKZydBtaLW40T_6-jWtYDD
 b_5Z-NEgwK8U-UnI9k>
X-ME-Received: <xmr:vKVOZx6vXTh5slXiZIOIUok-3uVB0bgOx8hFXarlzRVNEpTz4oylkpkubCG6kCBslTKfHUr8FiZMyH1wmELiLLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugdduiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheef
 gfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthho
 peejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgr
 rhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpd
 hrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgsuhhs
 tghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnth
 drughkpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:vKVOZ-3vw-PFTf-UbVYGDwy9F4N1JRP7792cuB4UjQVIqCfrhV74KQ>
 <xmx:vKVOZ0Hau_RYh9li7SVgtpD0CHwopl4o05nhIVqm55gUrqg3Bva-mg>
 <xmx:vKVOZ__v5Az-LW2SQ-eUz5Cq1OSKOVMqXiJASQFE3KwpVaE1lq_UHA>
 <xmx:vKVOZxnbygBKy7Mi2_KWLohUWkd_LNfaAcJkftvpnhbecfa6MIFAFg>
 <xmx:vKVOZ_0OcdQM461StdkRUGBzymRIU-TIGQog-et0cs41LHbIzKOTc-bw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 01:31:23 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 2/4] hw/nvme: fix use/unuse of msix vectors
Date: Tue,  3 Dec 2024 07:31:09 +0100
Message-ID: <20241203063112.9135-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203063112.9135-1-its@irrelevant.dk>
References: <20241203063112.9135-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=its@irrelevant.dk;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Only call msix_{un,}use_vector() when interrupts are actually enabled
for a completion queue.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 13898d58278e..a38f460a7859 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5423,7 +5423,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
         event_notifier_set_handler(&cq->notifier, NULL);
         event_notifier_cleanup(&cq->notifier);
     }
-    if (msix_enabled(pci)) {
+    if (msix_enabled(pci) && cq->irq_enabled) {
         msix_vector_unuse(pci, cq->vector);
     }
     if (cq->cqid) {
@@ -5464,9 +5464,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
 {
     PCIDevice *pci = PCI_DEVICE(n);
 
-    if (msix_enabled(pci)) {
+    if (msix_enabled(pci) && irq_enabled) {
         msix_vector_use(pci, vector);
     }
+
     cq->ctrl = n;
     cq->cqid = cqid;
     cq->size = size;
-- 
2.45.2


