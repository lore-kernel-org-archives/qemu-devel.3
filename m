Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D67E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMRa-0000Ax-7y; Tue, 03 Dec 2024 01:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRY-0000Ae-Mc; Tue, 03 Dec 2024 01:31:32 -0500
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRW-0008Dy-VF; Tue, 03 Dec 2024 01:31:32 -0500
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 395F9254008B;
 Tue,  3 Dec 2024 01:31:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Tue, 03 Dec 2024 01:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1733207489; x=
 1733293889; bh=uZjMjLzm/+S0ku36xYAPx/8twvAIyV80i/25NBJC6GE=; b=H
 /dJKjfaLeTEAsRYlkDv/ocy/laATw33BWzEY9AqturCRCryAB04QtB4XtIzxbzSj
 hnKiT5U+kepWoh4W/nmq+fF/Uc2L9H0rUCaoASC9fYbfM1PMI9jw53/CPqhgu0JA
 3N0wyAFJ1qZ+pmbZ/M9Jd+BX/CAgR9blS2Ef5J5dtPhGNJpfuAZL2qzE8E+pelo3
 GM1pFuY1mXB+NLGh0HCaVt7HoFEUqJCWk/A2OxXFrXukSRovVOiS+bRUO1aF0/qJ
 N/B+57//M3k1cNNq2a97KuNoa5rZ9VmAuK3cZSYrCUMFkjUKd+iKrqRYpCmxeTJV
 OH2P4KTKTu/aRqdzTJBhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1733207489; x=1733293889; bh=u
 ZjMjLzm/+S0ku36xYAPx/8twvAIyV80i/25NBJC6GE=; b=RUD3CHAEcczlAZyP2
 k0LAOJdMeuXd3vFWWVRJKY8EWn0+Nfe8A/8kCjvuxNi73bF2Oo/oxq8Gqnzb2Hh5
 xXskd+lH8WDw/sxRwtQjDQxxhNXAtjgEDWoRfxGrkMmclJWxAw94ynFVk0fPDRWG
 yY3hUz0shO7SwYD1HNvXCx7Hp6bWSm4UzqoQL7b6XTct6qdnRdGvyVOSGNeQCgj1
 8PUOUwZ4qXISEN8bmpYra/SzCz/St/TTiXqLVvSRAulj941NMEc7+UDSo4z20AkJ
 5YpFREvDQVJ9L58HbktYrceclv9QKVkYqlrVKL0cYOfTX5MDIBlddGK1w7heFU3e
 Ufgvw==
X-ME-Sender: <xms:wKVOZ5hPS_jig_iq9CO_KEwOqmApxjHYhVZV01C3w_2lD4S3K35TvQ>
 <xme:wKVOZ-CPqdkXKS2E73_WEqqjMWKJtcQayJpZPp9K9R-G92v0R_qAnyn1cisIPplBE
 NI6x5Lyf4-W39ogbas>
X-ME-Received: <xmr:wKVOZ5HaVd4aj72pPEGchvefl_GpUU5VkfI1zQr_Ux1Wzt_Fc-jrHnHanHL1eHXz5dMURACuHKIQj-MUMYSmhYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheef
 gfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthho
 peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgr
 rhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpd
 hrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgsuhhstghhsehkvg
 hrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhr
 tghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:wKVOZ-TBe03aaeZFGe5v_Ouc5ddGPLjgoxfnKZK0udLNgBMrXTAN7w>
 <xmx:wKVOZ2wqWOCZdlys5XMkOoU-s0Jkz_re-AwoaiGmhKLIuUPaZG2nWw>
 <xmx:wKVOZ060HQA-Mu0U4JzNnBEH1cxUyu1UyVjkJTaEM8FQquriKtZVbA>
 <xmx:wKVOZ7xqKQsc3NEkWjkCMCTByNyKTFXSxwRZNiS8gKhE634iZLSxWg>
 <xmx:waVOZ1mJ5MB9782XVNnvBtasvCvKGkZ5b6WnsfPZ6prSbVhvVh7QktAf>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 01:31:27 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 4/4] hw/nvme: take a reference on the subsystem on vf
 realization
Date: Tue,  3 Dec 2024 07:31:11 +0100
Message-ID: <20241203063112.9135-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203063112.9135-1-its@irrelevant.dk>
References: <20241203063112.9135-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-b1-smtp.messagingengine.com
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

Make sure we grab a reference on the subsystem when a VF is realized.
Otherwise, the subsytem will be unrealized automatically when the VFs
are unregistered and unreffed.

This fixes a latent bug but was not exposed until commit 08f632848008
("pcie: Release references of virtual functions"). This was then fixed
(or rather, hidden) by commit c613ad25125b ("pcie_sriov: Do not manually
unrealize"), but that was then reverted (due to other issues) in commit
b0fdaee5d1ed, exposing the bug yet again.

Cc: qemu-stable@nongnu.org
Fixes: 08f632848008 ("pcie: Release references of virtual functions")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 61c114c66d15..ec7541956695 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8841,6 +8841,13 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
          */
         n->params.serial = g_strdup(pn->params.serial);
         n->subsys = pn->subsys;
+
+        /*
+         * Assigning this link (strong link) causes an `object_unref` later in
+         * `object_release_link_property`. Increment the refcount to balance
+         * this out.
+         */
+        object_ref(OBJECT(pn->subsys));
     }
 
     if (!nvme_check_params(n, errp)) {
-- 
2.45.2


