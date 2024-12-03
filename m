Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0817E6C60B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMRY-00009y-4X; Tue, 03 Dec 2024 01:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRV-00009A-Oz; Tue, 03 Dec 2024 01:31:29 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRU-0008Dj-9h; Tue, 03 Dec 2024 01:31:29 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 0D3F61140151;
 Tue,  3 Dec 2024 01:31:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 03 Dec 2024 01:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1733207486; x=
 1733293886; bh=klFTB9dqy/Ul1ii3Nfs6pPyOKPDqyo7MID2lSw63fCs=; b=A
 dneuFeOYSFo1u/zAcQJW8P6rd5rm5gmMR1sdYKOgBYIYJBZx2ReNm/Ky9XJS8Ki4
 4NuP3X7niUhF3DnVBogveIwh5nwBvJQOtT/zcOAWKlPc2MZGXUmhWAlbhXAYhm65
 jUPMldDev9jgPbs6yU2mXuWa8cn159WrezHmLudvJNmWWuMgtH7EC7+gxuzjJXU0
 FCQMu2IFnADKF/mshM9jEBGVc9wghXr4qYbg8QCjoO+DcfG8zjx2wuGVsv05DMbE
 QGf1efef91odhWmDvcGgUcHh2VTKwdhM3kO4vYrLE9XVWMFGH0obLkNLYLP00azp
 jOTHDiv4w9ZMCj7/W+mwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1733207486; x=1733293886; bh=k
 lFTB9dqy/Ul1ii3Nfs6pPyOKPDqyo7MID2lSw63fCs=; b=wWiexdHkTWmTZAhdy
 bjNcUsRz05Vjfe9h6VJTg/YRBH2RsgVkESQZW8iGASr3+jVIglmFlQH0/0CZHXli
 0wv/kF5hj/e9ZYqEwGeNw7oN2sZLXSMgEVFxMtzg7VWgFz8jPnAPU3e6XIxMzBnj
 jj6Dcye2Vqr9qP796SNaEiEq6HdT4N1jZodTTknsRqz4kH5YxbA+YnaSMqlDaaTh
 3QFzMmN3C+Bn87skpke1M0aDSNeSzeQsz6YCokB9aQmdVzzmhbbG5rS/xmb28e8K
 mal8J+RZdZFQ1JjSWxXErBq7ZLAXFUYG9ccuBsYX0NeXPaUGLou8nYQuHJWGgz4g
 rgxnQ==
X-ME-Sender: <xms:vqVOZ7FwlNtafLo2TSV2ElHlq8fcY7gG4YhQA37dApJguStg2-1aog>
 <xme:vqVOZ4UdlYQMPOaEW1MUqJCYZHZRFm3f3zA4hwPsy_1-Y7AfOxqS48Fmqkn46XXTp
 fMZtZFL1Xc-8br7PRg>
X-ME-Received: <xmr:vqVOZ9Jn_-9ROiV8YfsIPftfWBG4dxU6I9140bjrldjkZw_hvwei_aNcJGfd9XacxeBMwa8fhDmYhrF72rSlq6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugddujecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:vqVOZ5FMgb06hQICn4rF8808y-5MQ9LQYrR8RRM55zwzC-5Nduz5AQ>
 <xmx:vqVOZxWkx2ociaw-uUJhWDZxGXUsbi_iLIEE0q0-P5OaVRRgOeS9kw>
 <xmx:vqVOZ0NXrs56UjcPKbF57IQDIKbaifEf5F5Drvv7lABIoZjbvRYL7g>
 <xmx:vqVOZw3rAqGGwvKylKqn3V2V3USeG0TCuXrYTE70vs80-ARaSusMPQ>
 <xmx:vqVOZwETxQaozpCp2vhLFi510lHB-CqYGhGEQJMkod09HopGPYwh7MFV>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 01:31:25 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 3/4] hw/nvme: SR-IOV VFs must hardwire pci interrupt pin
 register to zero
Date: Tue,  3 Dec 2024 07:31:10 +0100
Message-ID: <20241203063112.9135-4-its@irrelevant.dk>
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

The PCI Interrupt Pin Register does not apply to VFs and MUST be
hardwired to zero.

Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a38f460a7859..61c114c66d15 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -656,6 +656,12 @@ static void nvme_irq_check(NvmeCtrl *n)
     if (msix_enabled(pci)) {
         return;
     }
+
+    /* vfs does not implement intx */
+    if (pci_is_vf(pci)) {
+        return;
+    }
+
     if (~intms & n->irq_status) {
         pci_irq_assert(pci);
     } else {
@@ -8544,7 +8550,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     unsigned nr_vectors;
     int ret;
 
-    pci_conf[PCI_INTERRUPT_PIN] = 1;
+    pci_conf[PCI_INTERRUPT_PIN] = pci_is_vf(pci_dev) ? 0 : 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
 
     if (n->params.use_intel_id) {
-- 
2.45.2


