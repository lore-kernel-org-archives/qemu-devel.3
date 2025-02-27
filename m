Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE12C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaEp-0000Wd-K9; Thu, 27 Feb 2025 04:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaEF-00088m-Vc; Thu, 27 Feb 2025 04:30:55 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaEA-0008It-7W; Thu, 27 Feb 2025 04:30:50 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 6C4271382F7F;
 Thu, 27 Feb 2025 04:30:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 27 Feb 2025 04:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648641; x=
 1740735041; bh=zu2GVWEr7Tf8ty5a+Qx0WF5I6xMcGVmg/nb+edrkqjA=; b=N
 o53tOZNczLSAEEk7cexZU7TiERMwk4BX+zTC3HEkEKJcpazNSjklsBr4vQJwcMp3
 dkiv/rJBup12uEW9CiG3CLKL4W0q+hxQ58K67koKGZpAkGej0X90LsYglkU0CNJo
 kQ2zB49QhrhYqbkbb4ctFxrzdPIo5QXMFAd+ej66imU2bLFdZWThsEDbXUlwxDVK
 uEPKDxRqhmbhN2PR9HkLnj50IgTBqCYz6YlgyKLUvObpkJZceG9+04hECSbsxPsX
 /ImgGBcyE/lC6AijGYkxGmpyWnVLtaMR6QKdAgwnfU5DQuS0Uj6TuVKiDKcZMGHm
 BelWaqe4jk3FIyAZNn82w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648641; x=1740735041; bh=z
 u2GVWEr7Tf8ty5a+Qx0WF5I6xMcGVmg/nb+edrkqjA=; b=dJnNSzeIumhgeF8cM
 h2Pr3lVWUYvNi3RcA8BxL71QORy6yrJezYFVL+pzG/yfG4TYOMXlyoBySO8uZv0S
 NHzFku1B59HthH0ohVDQIhS0Zj9pMSKbDOH6L5etaVEJ4x4iYhQZuGfDJXVgjutS
 OLiJvKyocS2Asqi/qlPyZj8akv34xV2Irfkznco36dfMsqvTdADCfRtyKc7ZhqA/
 dD9mM9/c+AYVGap+LhxzTKYLDAOklOEXUVKQQbTvBgUZRP1ZFdZ5qdZZJDfOMFAj
 xeIAfq8bWC1IJOelkp0SC60gwUQWbJp2pWaOx54CQO+xOFmxAm9n326egfKLS9Jk
 DWVQA==
X-ME-Sender: <xms:wTDAZ5ATT442KcKefODcDYCtmdnqAlICjzGfMNwndGC8k8wKJgNTpg>
 <xme:wTDAZ3jQ9NNIDV3WSx0TR7aXhlkgfAYNlP1Qpdiu3Z50HIX8RrfZEP50WVDFMKK6u
 47kmFU03_k3igjVhXw>
X-ME-Received: <xmr:wTDAZ0nriGiifGuQhprTrn0vpgv6dikNVe2pbwv2_lpRl0607GAY2msS3KvHCfT1Uw-NhK7zoTOy91QFOs9a-14R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhi
 nhgrrhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hmpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgs
 uhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrg
 hnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:wTDAZzww3_8bDnVkBZzEhsw6MpvVtFhEc4mYXCjq4pdfSBGu4dv7wQ>
 <xmx:wTDAZ-Q18TLoAAmRWmr723k8WWIfLAqBp30ty5hRLmSSnrfcuFq1Ig>
 <xmx:wTDAZ2ZmNU7X6TxX-tct8cVnEozV3PU9dw7LFBNnTWQTHH0gJmDkRQ>
 <xmx:wTDAZ_TOYZN1dbd08ZiaNmXbd15V4FrPnpCNdhD0FAiSj6sH5u1b1A>
 <xmx:wTDAZ7RokyMzTNpnsEz3Y2JJV33E68AzPSujF0JtdomPkWFTkNVWj5od>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:40 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 08/10] hw/nvme: only set command abort requested when cancelled
 due to Abort
Date: Thu, 27 Feb 2025 10:30:15 +0100
Message-ID: <20250227093018.11262-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

The Command Abort Requested status code should only be set if the
command was explicitly cancelled due to an Abort command. Or, in the
case the cancel was due to Submission Queue deletion, set the status
code to Command Aborted due to SQ Deletion.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 21496c6b6b81..07cd63298526 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1783,10 +1783,6 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
         break;
     }
 
-    if (ret == -ECANCELED) {
-        status = NVME_CMD_ABORT_REQ;
-    }
-
     trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
 
     error_setg_errno(&local_err, -ret, "aio failed");
@@ -4827,6 +4823,7 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         r = QTAILQ_FIRST(&sq->out_req_list);
         assert(r->aiocb);
+        r->status = NVME_CMD_ABORT_SQ_DEL;
         blk_aio_cancel(r->aiocb);
     }
 
@@ -6137,6 +6134,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
     QTAILQ_FOREACH_SAFE(r, &sq->out_req_list, entry, next) {
         if (r->cqe.cid == cid) {
             if (r->aiocb) {
+                r->status = NVME_CMD_ABORT_REQ;
                 blk_aio_cancel_async(r->aiocb);
             }
             break;
-- 
2.47.2


