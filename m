Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1D1C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaEx-0000o5-NJ; Thu, 27 Feb 2025 04:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaEG-00088s-Bo; Thu, 27 Feb 2025 04:30:55 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaED-0008JC-2K; Thu, 27 Feb 2025 04:30:52 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 92EE61382F81;
 Thu, 27 Feb 2025 04:30:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 27 Feb 2025 04:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648645; x=
 1740735045; bh=Ek139Gu4a814lUKETN8ffYGAAziBjZAe8RnGBT11S9U=; b=G
 fVJvOGt+iaDrFn8MzzN5UDNeUZS9fFp83eRweFGolG1DMiv9YkjCPR1vorlyZ0Bi
 D7Aa1dgfNsZuUY1XcXJwKaH7H+4uYQ8yTF8hMuR6y3+EhXNSx4yYpaiZmrRl1T/D
 smLuqlExs3LgT6xD1qSQ0AiIZa9/fiYELsi9NRP1aiHwKSe6jhUacmDu+y0XESES
 +BwLiwSjVkZihMribkuPYZeYw+0Lw+SqiCKGy0Z6YmIiyk2H4EDNZnOnTvCNFb1P
 pXvmGsDnN7JguNYPmFyq/Y2FOwIW+O4eXOK918DvGEoKVcL2SRnfpnjsIK4IGMVC
 uZV8eUn4xiq+D9JcoUBUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648645; x=1740735045; bh=E
 k139Gu4a814lUKETN8ffYGAAziBjZAe8RnGBT11S9U=; b=HxNfXZOY6422hdno0
 SiAInBPWlv4rMcMMo8DgZXdzv8DvH3f1rHw+CemKZZ43yUzpXTI6JBSJ4a+JepGW
 2GoXU/8e+G9ewqG5XyqQWV8Ge1Lspty6GW8aHzZ7qHhqt1ZAlptUjllpzfvkNVdo
 QCPK1yzJTTsNQLWi2pWK+hvKSWb9h9UtG9BhdgK6ejYEeycfNCPdkX2/rjI1nJQx
 WBnACrGjRaNvMPGNdy5X8CgRv7M4LwCkTRNVaLoWZSkF3270jlOod5YW3IozUKh3
 egmKWLc578W+fk5isMfznyBhDmDBIYgbl0pBT0YJ2JqWazApAlRZ7jz4pjnUphkQ
 Sd9Bg==
X-ME-Sender: <xms:xTDAZxyIegYiV0VS_KTdZ6FAoLBxeoSpvUFtOU8vuuur2HvWcrowZg>
 <xme:xTDAZxQ4O-K9M5EYgsTT1ZO3ALb-QUFccFZ9fqwOpdLsXgfPLSzANZ1FJlYlTeer2
 qJQKwZSCbCcbOVSdT0>
X-ME-Received: <xmr:xTDAZ7UwaYmY3Ccj4esHT_XIL6q78KzbahBpnIn96KlFWw0U4chTj-hZwCYQEOnbEDQsIYTssxp93QpdAEhSaTnt>
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
X-ME-Proxy: <xmx:xTDAZzjHSyVt69p3YbfHsQg8Ul_fLr6iog3eR0IEeVvg2Wwd-ekDAA>
 <xmx:xTDAZzDnI2qvK1_K5eMpkkBcGh1jPBHd6UzGNsZsjtQ1iJ1jMu-hBQ>
 <xmx:xTDAZ8IrJbQ3qZYZuv45ZymqahfA6fOic-AWWAPgXz_mDtY9la_pzA>
 <xmx:xTDAZyB_mR6oTwm2Lystjv09gDLMTCeQjGx4LgZw06goCN2vahs-tw>
 <xmx:xTDAZ1Dv8sISDrDZc7P_KjNVUgHvx4EjfEI4LeOzP2P2ZveHtfmINi-6>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:44 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 10/10] hw/nvme: remove nvme_aio_err()
Date: Thu, 27 Feb 2025 10:30:17 +0100
Message-ID: <20250227093018.11262-11-its@irrelevant.dk>
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

nvme_rw_complete_cb() is the only remaining user of nvme_aio_err(), so
open code the status code setting instead.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 60 +++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index b7222fd9ac02..e62c6a358828 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1762,42 +1762,6 @@ static uint16_t nvme_check_dulbe(NvmeNamespace *ns, uint64_t slba,
     return NVME_SUCCESS;
 }
 
-static void nvme_aio_err(NvmeRequest *req, int ret)
-{
-    uint16_t status = NVME_SUCCESS;
-    Error *local_err = NULL;
-
-    switch (req->cmd.opcode) {
-    case NVME_CMD_READ:
-        status = NVME_UNRECOVERED_READ;
-        break;
-    case NVME_CMD_WRITE:
-    case NVME_CMD_WRITE_ZEROES:
-    case NVME_CMD_ZONE_APPEND:
-    case NVME_CMD_COPY:
-        status = NVME_WRITE_FAULT;
-        break;
-    default:
-        status = NVME_INTERNAL_DEV_ERROR;
-        break;
-    }
-
-    trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), status);
-
-    error_setg_errno(&local_err, -ret, "aio failed");
-    error_report_err(local_err);
-
-    /*
-     * Set the command status code to the first encountered error but allow a
-     * subsequent Internal Device Error to trump it.
-     */
-    if (req->status && status != NVME_INTERNAL_DEV_ERROR) {
-        return;
-    }
-
-    req->status = status;
-}
-
 static inline uint32_t nvme_zone_idx(NvmeNamespace *ns, uint64_t slba)
 {
     return ns->zone_size_log2 > 0 ? slba >> ns->zone_size_log2 :
@@ -2182,8 +2146,30 @@ void nvme_rw_complete_cb(void *opaque, int ret)
     trace_pci_nvme_rw_complete_cb(nvme_cid(req), blk_name(blk));
 
     if (ret) {
+        Error *err = NULL;
+
         block_acct_failed(stats, acct);
-        nvme_aio_err(req, ret);
+
+        switch (req->cmd.opcode) {
+        case NVME_CMD_READ:
+            req->status = NVME_UNRECOVERED_READ;
+            break;
+
+        case NVME_CMD_WRITE:
+        case NVME_CMD_WRITE_ZEROES:
+        case NVME_CMD_ZONE_APPEND:
+            req->status = NVME_WRITE_FAULT;
+            break;
+
+        default:
+            req->status = NVME_INTERNAL_DEV_ERROR;
+            break;
+        }
+
+        trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
+
+        error_setg_errno(&err, -ret, "aio failed");
+        error_report_err(err);
     } else {
         block_acct_done(stats, acct);
     }
-- 
2.47.2


