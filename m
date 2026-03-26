Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D102106F2F3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5g1L-00036r-EC; Thu, 26 Mar 2026 04:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w5g1H-000353-1I; Thu, 26 Mar 2026 04:24:47 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w5g1F-0006lh-DS; Thu, 26 Mar 2026 04:24:46 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id BA9021D0020E;
 Thu, 26 Mar 2026 04:24:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 04:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1774513483; x=
 1774599883; bh=Xe0NNasWuj7ft2jRrG9JeA8yj0VbUSM2GM8CLq1zSVQ=; b=P
 vVR5vTSATXKZk3n4O6TfjQCs4V8MnYV/W2AMDYjO/RIPJgCwRoVDpvFGI5XWmFr4
 TmBV7sLc5gqHWRz0eDOZnu68zgYdXStkwm6BrUzPIp6QhRBopWVLp+gfUWqw9KKm
 z+j9zuMW9VwmnMHHEPWBIIJLvK9A8RnDedqFLk0oM/vCGvR3HbLQ3vJrB/OHmKuB
 0bEpN8w66m6kT6Pd8sqvlWJ2lJHiUQGuWk4ReaMIbKtTbXD9jE4FCSz8vQSI2taH
 RGxXUqzJpSJC1AY31CTP2vBVUgdRLlIYDIKgNSxjRymkv8RVU2n1rysxos/+pX9i
 /VfUNLe9DLptLX35CGijQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1774513483; x=1774599883; bh=X
 e0NNasWuj7ft2jRrG9JeA8yj0VbUSM2GM8CLq1zSVQ=; b=4r7XUjcsh7f2Az6P1
 ucQpKFAxhOdfc2ecNoq0knbrNJXi656iGZ/vsc465E0wLumao13tj2eZDRIdWKLe
 /coFwKQ0Ayh6Vk/S/59uGbvWL52PmHatRhlaWPetP+oacJeR0Yr4DIlt/q9EhGVK
 kTrX3IyoSi5PTihQohWu0UwrV265T8tGe2nYCAF5chQIOjhu5Nok62l5Ca8XGBVo
 1a88HmJejXAHIjZC1lD7CpyOB2UhhrW+qhzSzKcwB7djQ6MdNWSHF0BJm3uBa+8a
 UjZEiHlSct7PYDlBSZ/IVQ8NLl1XhAeXR9c80AYmyAM2J3UiyZrjWBLlO8jsYXD6
 mFaQw==
X-ME-Sender: <xms:S-3EaZBvXI38EkuLUBZ37m6I7fY9koSmc_K5Iyu2njuLp1XyNk-OUA>
 <xme:S-3EaaHACigIOLEWbdHf5Nv2DEk19vJGYZs8csNs0g09dI7K8_FhR84E49Cp6KRgG
 KLfKHDDpUMqHAeJZzDbEcK-EJhAcyDgal2yc7ag-oTCYODk1wJgE-M>
X-ME-Received: <xmr:S-3EaYN_Lm--BxIpmABEzDkU9NkDU5AOwNPI7DzWmDLe9EWTA--B_VJqtqzNXwysx4aOPVP78hryR_rv2fk7_Nrj-mH3OVZevQFXsTC0a6y3MEjGxwT2n3H7Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeikeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeehteeghefffeegkefghfegieejkeevfffhjeevfeekudeiieevheetledujedu
 necuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhn
 sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuh
 dquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhigu
 vghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhgrihiguhgrnhhlihesnhhtuh
 drvgguuhdrshhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdho
 rhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpth
 htohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhr
 vghlvghvrghnthdrughkpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpd
 hrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:S-3EaT6yrFHGjVQALKI-GqDB7-a1gaW0oktv7A2L7WFEFnrzAdsyhA>
 <xmx:S-3EaTjIU4VsHQ0hrRoE0rLqjRGuK1SvamTnJo-_VfAImktr5Xpjbw>
 <xmx:S-3EaQdG0D_vmqslvCjJheKErZ1cwPj_8sgJM5_6N3mt3Ee_3euD9Q>
 <xmx:S-3EaTwXE7SgqB99-iDtD1wmPPTW8XmBni5RyKjxL4j6Z1CYg-HgsQ>
 <xmx:S-3EacrfNQh-7fcektdACvyQ6jgtVbq-1277xhgbvEw8y7QkhZI1q-oI>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 04:24:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Kaixuan Li <kaixuanli@ntu.edu.sg>, qemu-stable@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 2/2] hw/nvme: fix heap-buffer-overflow in nvme_abort
Date: Thu, 26 Mar 2026 09:23:49 +0100
Message-ID: <20260326082350.17374-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326082350.17374-1-its@irrelevant.dk>
References: <20260326082350.17374-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=its@irrelevant.dk;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kaixuan Li <kaixuanli@ntu.edu.sg>

In nvme_abort(), the submission queue pointer is dereferenced from the
guest-controlled sqid before validating it with nvme_check_sqid():

    NvmeSQueue *sq = n->sq[sqid];

Since sqid is a 16-bit value (range 0-65535) taken directly from CDW10,
and n->sq[] is typically only max_ioqpairs+1 (65) entries, a malicious
guest can trigger an out-of-bounds heap read by sending an Abort command
with a large sqid.

ASan reports this as heap-buffer-overflow in nvme_abort.

Fix this by moving the array dereference to after the nvme_check_sqid()
bounds validation.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3348
Fixes: 75209c071a ("hw/nvme: actually implement abort")
Cc: qemu-stable@nongnu.org
Signed-off-by: Kaixuan Li <kaixuanli@ntu.edu.sg>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd427a..be6c7028cb58 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6111,7 +6111,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
     uint16_t cid  = (le32_to_cpu(req->cmd.cdw10) >> 16) & 0xffff;
-    NvmeSQueue *sq = n->sq[sqid];
+    NvmeSQueue *sq;
     NvmeRequest *r, *next;
     int i;
 
@@ -6120,6 +6120,8 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    sq = n->sq[sqid];
+
     if (sqid == 0) {
         for (i = 0; i < n->outstanding_aers; i++) {
             NvmeRequest *re = n->aer_reqs[i];
-- 
2.53.0


