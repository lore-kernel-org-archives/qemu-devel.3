Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F4ACEACCC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdcE-0008Lx-Fz; Tue, 01 Oct 2024 10:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbo-0007fG-97; Tue, 01 Oct 2024 10:12:14 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbc-000340-OB; Tue, 01 Oct 2024 10:12:11 -0400
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 86B191381F44;
 Tue,  1 Oct 2024 03:04:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 03:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727766279; x=
 1727852679; bh=5XqoLTAFqCtY2x87btFp3v8D5GoR0hqn0xoHj6uIjac=; b=i
 2PtjMJwsyizlr60ds1MHGn/u5tQPDIqPJ4iT97iBdQyK1FDKwxTZNPwlERQED775
 4xrb/XdKkkTfvTW5ucNomhpz+Ktwoz8O3Y8Zrll6aVtUoB2et5Tt9NABR1AMbuxk
 PYCR9ZQhW6Esjj1/iOxLYc5RaPQAPTXJyWEbMe1oJAnEVFC03pAwluGY05qBbGhz
 1+SZhJT1/uToZ/Z1Y0Ug/gWnZJgLJyW8hQMfJdQ/6NbMhBxvqj+xUT1r6ipGrpq3
 O+C/dcjh6JOenQAoB3za9sIgMo8RptAVmknEYtw6ZtoYyDPGihHpxlFiZ4n9FiCn
 jRE6a214FCpCYUMpwacyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727766279; x=
 1727852679; bh=5XqoLTAFqCtY2x87btFp3v8D5GoR0hqn0xoHj6uIjac=; b=R
 QmSEW90OBx9LCgVcL/X1VOcbyZurRcOrpC7ucTydNqnDruxNZSY0NLrrSc6BjinZ
 JMQDcvQuGSPUVZiMLrdvT76fOINC4uWfaySj4oTupiBuYVBDFbmFgMvlH2Z0nKtY
 ult2u5ztmTFfgzHYgkx95CJ+zH2f1YMni+vePGUhdm3lwW2+XClV6YsQjgvER6gB
 VqznFM2+57it5pow4E3BXhENjr99+a7OoPwTP0i7DDocsHgAXKUqHQ4GRaNeLXqA
 FNADr8YK+L15x17GreIHJH5K/XXLKK0MA8zyMC5QZp/HKfpeJi3ZZe86sP3GVyf8
 9yPAyj9XihyYZ3qMqGq1g==
X-ME-Sender: <xms:B5_7Zn6oHnt4qudOmkEQveEjEZPz2PN69n5uN8HN6PxdUdXB06Cr3w>
 <xme:B5_7Zs4Njdc6NlIqUBs1i0HKLTwMKUDdR2rbwX-QasYzhy27qvI7rvWd-Cix_Sx3_
 acpIagp8lgsj8KhzF0>
X-ME-Received: <xmr:B5_7ZudMvtY6qLT5RAC6b-NQElcCeYvqru8kOWxfk63wNd9veeQJdbQoV_z56Fr_EInO4tfu1TQytCkxYlqVgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgudduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhi
 nhgrrhhordhorhhgpdhrtghpthhtoheprghruhhnrdhkkhgrsehsrghmshhunhhgrdgtoh
 hmpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthht
 ohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvg
 hlvghvrghnthdrughkpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhr
 tghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:B5_7ZoK09eN0s8ouv7Uu9V9nfU8omTKnS7YHWZjYjXLfLQY0SBjGlQ>
 <xmx:B5_7ZrJr5i_yAD5yXByVNQDyIG5OBgje4TqtdUGYOEL-kdthKuApow>
 <xmx:B5_7Zhxj3I4l-82QLv2mcRlK8kNxzuHC2d_y1UWL81KYo2s2G6f5Yw>
 <xmx:B5_7ZnLsTu1cXRlwl-J-iEiBcGiWWSs_Mbq5FUjJNqi_rHdBPjanRA>
 <xmx:B5_7Zi89RrNOFIz-nZsnVUkpjs0P3MZ7HXS2SP4U4pB58N9MeIMSCj-7>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 03:04:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arun Kumar <arun.kka@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 2/5] hw/nvme: clear masked events from the aer queue
Date: Tue,  1 Oct 2024 09:04:14 +0200
Message-ID: <20241001070418.28737-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001070418.28737-1-its@irrelevant.dk>
References: <20241001070418.28737-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Clear masked events from the aer queue when get log page is issued with
RAE 0 without checking for the presence of outstanding aer requests.

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
[k.jensen: remove unnecessary QTAILQ_EMPTY check]
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d5ea9ad653f2..a720dbc354a2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1649,9 +1649,16 @@ static void nvme_smart_event(NvmeCtrl *n, uint8_t event)
 
 static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
 {
+    NvmeAsyncEvent *event, *next;
+
     n->aer_mask &= ~(1 << event_type);
-    if (!QTAILQ_EMPTY(&n->aer_queue)) {
-        nvme_process_aers(n);
+
+    QTAILQ_FOREACH_SAFE(event, &n->aer_queue, entry, next) {
+        if (event->result.event_type == event_type) {
+            QTAILQ_REMOVE(&n->aer_queue, event, entry);
+            n->aer_queued--;
+            g_free(event);
+        }
     }
 }
 
-- 
2.45.2


