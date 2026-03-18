Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B5810854DB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nBQ-0005bg-35; Wed, 18 Mar 2026 05:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2nBN-0005aa-Uu; Wed, 18 Mar 2026 05:27:17 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2nBL-0000Fh-8q; Wed, 18 Mar 2026 05:27:17 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 38A661D00127;
 Wed, 18 Mar 2026 05:27:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 18 Mar 2026 05:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1773826030; x=
 1773912430; bh=n+B+y2foUNRdG/7TFn2seka0zeg+wKm7i3VoPZFDAUA=; b=S
 pCsqqKZboGbb4waqU/fdkCnumAIw7vlWOx4xFrFPPCTXvupPR3Gn0zsN1S52+HtL
 jjmFoyPmH3cQ5xmbcuhGIUBXXJvsihjbmlveWWjq5EOpaf3BKmajVa3AXTK9MT3T
 WZvCJbTPySjbhs+im1e2sFLXKufq+//O1GGMtGzMJjA9nPHaxA5s/FdI46yl2MfF
 Xq7YI8TipI7qJ9ecgcDrN1cR9nqBUN6OCRYULr0mox0YW0hxLmuXvNhmJn1C6HEO
 fvWwnSTKzZNxlF4Wv5ObPtxf9TA3R8/k4Bl5A8S4HxaehzENCtGMBP8/Zt8Cb+rS
 TiTAbM7E2kV/maqYcgBZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1773826030; x=1773912430; bh=n+B+y2foUNRdG/7TFn2seka0zeg+
 wKm7i3VoPZFDAUA=; b=O4IEzxJvzEZYmLGgyc39qst7ySAxs2cndnT6cTGLE5G3
 6rG3xAhF2AYnlhqz5QQOT0NuWeJDaOy02MoK03IHT0ih0VyZjmUWpub+t8khAPE+
 RT1vVBaptbc93pb0CPIHR6+Ac0iJmTSCBccz5wco2fXJffSbpkMLGMVRU21J1KBC
 BpaMkMUAd2JtFPAmQ5zuEV3dOvG/RYRbufEqabuhrNFj4uqTqHBwQXMl/zdW8OfA
 a8TLQ1M8IUTjQt+VCy/6TBgE2elEywKDscePsu9LdLQ8yZ00YekqZq+nnZtJxIJf
 6A1xcSIn1KM1zeDfQ1FAqD5AvlaEbe8pu1YDv1TAig==
X-ME-Sender: <xms:7W-6aVQGVRPYjWNkz6kMqWaT0busN80vtD6RlEAnwzcXWkTUiBkNXA>
 <xme:7W-6aY2JoJ411fWPyv8nF_c0G2PceVyM9XFkEFksLLbEVpAejt-EXrJtt4ugnbGyM
 Jksl3uUkRkWMWuZkdIHG3ADRxrZbGuirWgfDN66TvbJa1Sjj7rOwSA>
X-ME-Received: <xmr:7W-6aauaxU09Fc-K4N0N4eo-xZnWCmdH3ORnn0V4_jC02qynQPHT0Hn43WJIsyDW09Ub0mO_fYpZWJe3KyXEptg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdefjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpedtheevjeeihffggeeihfefheeuiefguefglefhtdffveehffekhfekgeetteffteen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhope
 hithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotghk
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorh
 hgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehkrd
 hjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhr
 ghesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:7W-6aeh3JRSJpHEjw4GlkfDdi8Hd6C7jqNnWz8rVeheUzclWtXwNbg>
 <xmx:7W-6ab87G4uk5dNCGHDSBPglr8r-QEtw0VqgDugtmpz2uibR1CmV5g>
 <xmx:7W-6aRsoQ91m1l_ry3ZMk6gW-RUbDLr5DtxlcOfjkCXmp1hrOisvjg>
 <xmx:7W-6afrjwhYd7T6nfVf6GzVFF6lxx6kn5aku18nhSBswyE0llfctkQ>
 <xmx:7m-6abw2NGQzvENFNmZSik_QXfVUqwolI531MNQu2-wA7c88KaTqGp3i>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 05:27:08 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 18 Mar 2026 10:26:58 +0100
Subject: [PATCH] hw/nvme: fix admin cq msix setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-fix-adminq-msix-v1-1-404b7c27c378@samsung.com>
X-B4-Tracking: v=1; b=H4sIAOFvumkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ML3bTMCt3ElNzMvELd3GIgO9XC0tzSJMkkzTDRQAmoq6AoFagEbGJ
 0bG0tAFpkUGRhAAAA
X-Change-ID: 20260318-fix-adminq-msix-e89794b4f1a0
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org, 
 Andreas Hindborg <a.hindborg@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=3kzkNNtu486PTttuL5Vcla/AHAvi6ouN4gxsgkP69MI=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR202Yit6YzIxUGFuV2I2aG02ZWt6cEtaREk5Ckh0VVJoS2ZvOUZTYkllUUJN
 Um1rZm9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcHVtL3N
 BQW9KRUUzaHJ6RnRUdzNwZHBJSC9qVW9WRnR0SnQ1cXl1RDhtcFMwQ1g1WXExdExCSmY5cGlCaw
 puOWcxRXJwTHVsTElkeE9GMWZZYktnUmNKaUk4ZG83Q3Rnei95OTlxV1FLMm01d1ZBSDA1cUVxV
 UQxUmY0WjYxCllwbjRGdHBTb1RkYlZLRE9XSVg2RDNaZXlRMFp2VytXdHMwVHgyL05QZ1hPUUhu
 d0xHT2xMVnVVbHRENkJqR0EKS2NjT1JpT1N2UmVZY1BNRkw0cTN3YWZGY2JtSFFZemNBbkVrMU5
 UZUlsQjh1bzBZTDlLdmc4cVdlWGxXaXRGMwpQeGZIMWptNDRLRW1EV2VqYXNOZ0tnQm9pcjJxWk
 s4VW1yM2Y0MVJBaGtpdlVYTll6NTJMZUd1U1JOU0pMQjQ0CnFJenRvSk5zdlpIaWprRGlVdXU3U
 zFESm14MFQ3aU0vZEs5YjdqeTVsbDRySk5jTzBLbHV6NmYxCj1lcW9jCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.144; envelope-from=its@irrelevant.dk;
 helo=fout-b1-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index cc4593cd427a..7af4059c62e2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5517,7 +5517,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
         event_notifier_set_handler(&cq->notifier, NULL);
         event_notifier_cleanup(&cq->notifier);
     }
-    if (msix_enabled(pci) && cq->irq_enabled) {
+    if (msix_present(pci) && cq->irq_enabled) {
         msix_vector_unuse(pci, cq->vector);
     }
     if (cq->cqid) {
@@ -5558,7 +5558,7 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
 {
     PCIDevice *pci = PCI_DEVICE(n);
 
-    if (msix_enabled(pci) && irq_enabled) {
+    if (msix_present(pci) && irq_enabled) {
         msix_vector_use(pci, vector);
     }
 

---
base-commit: 559919ce54927d59b215a4665eda7ab6118a48aa
change-id: 20260318-fix-adminq-msix-e89794b4f1a0

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


