Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0945CEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdc7-0007tv-EG; Tue, 01 Oct 2024 10:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbg-0007Ud-St; Tue, 01 Oct 2024 10:12:04 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbc-00033v-Go; Tue, 01 Oct 2024 10:12:04 -0400
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id C2EE41381F42;
 Tue,  1 Oct 2024 03:04:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 01 Oct 2024 03:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727766283; x=
 1727852683; bh=zfxKcGYBWejJhPfihOF8Kc26jktRb/WUlCj6Qb2QhwI=; b=u
 B5DYOVQrypGstT7EfGt7u3xdj1Jahmm4ggX/QO4KHCZmR1eqWNLtRRkj+xhyvDdh
 ux0n65PB74xH9vOHjp3EnipDYdJ9JAhu35tCDT+SRu3A/T+1N0ekOWWlYRvC6S2L
 Za5f5nndtJp6JmvyIdpgmTy2l1WAyAaLKsaRYetjhdJLCRrf4otdlURhRquicAPe
 xIg7N6hCHgCj9f0VaJAOJKuFHWPyYy8UrCO8lxsuHqCXDQ7U3WSxpTBtgDXQuv7D
 n1bcPwxzCOd4nQIc+bxBoBOMLtgYwykxeWUcqOIiNzsJ+endlR0SKo7kccD2w24U
 vH5UL1mOWkLFrorNkDgPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727766283; x=
 1727852683; bh=zfxKcGYBWejJhPfihOF8Kc26jktRb/WUlCj6Qb2QhwI=; b=R
 VUde4rjiMRnvdvgecTbAPjTOzNBgH9SgKRRdLhDvuyEjFCnxXgl8disuU8AiYebM
 3Tx+0eLGSbT0dNwWZIqoa16Jfn4w9giExGPylloj8DX0eTA/k+ndZ089Q+NEY1Jk
 ICYCldQwaBinKo+8wLdLgUw4pmw30UCwuowdNLM8FXg8K6lAt8IXmSXQtRRbt0wl
 eyXVnq9NEw7Zf5s+a9jHH4lZ5Qga887ZqPC+qe2aNj45qEX2c7ayIRKf2SEcGcoG
 ybQwocZ4CuYgVg8LRhi3eI/ZsRiQEGlzF51h9Q7/qcL4dFZ1pw3JThYPL6qChgvq
 jOJX10BP4evg4s1WEeAaQ==
X-ME-Sender: <xms:C5_7Zt0LmgLAwxhf8kJViSHcuemxFGvmTyz4VKHZFJJyNVCWJ2-sqw>
 <xme:C5_7ZkG38V9C9xVrUxMN_l9htg-VHWV9qSrP-YccMSVfaj0Q-KySr1iRl37aptTO-
 pP9niRVB6EWJrcpfGo>
X-ME-Received: <xmr:C5_7Zt7E20lGNSi79BX45QFTEdy4L-ulBcZlEC_aNO7ieuuvy4_TyawuDIukUeYPTTDKqiaI982mCpcZhplHmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhi
 nhgrrhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hmpdhrtghpthhtohepmhhinhifohhordhimhesshgrmhhsuhhnghdrtghomhdprhgtphht
 thhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghush
 gthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhht
 rdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhope
 hqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:C5_7Zq2y_SoOmO36MT-MOjFACVWrxXK4DqCbq0jPxwod6R-_a-egBw>
 <xmx:C5_7ZgFGTDZOaInlyX6cuJXl_DrGR_f6CiFn0vREAFFuahzqbjxDCQ>
 <xmx:C5_7Zr9QMY04Jz8xZNSNQCw3aUM_iWs_RPQPWXiPIelJ7OxS5mo11A>
 <xmx:C5_7ZtmMPPEM6ZgcJ-etk5iRwW7cd6aJ6paxEKVmAIT8rwaQ70_tdA>
 <xmx:C5_7ZrDYSNkKLiDeSCklPMFxi90elpFLJ1FEI7UCqQYijMWyb7m1i3o4>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 03:04:42 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, Minwoo Im <minwoo.im@samsung.com>,
 Arun Kumar <arun.kka@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 4/5] hw/nvme: add knob for CTRATT.MEM
Date: Tue,  1 Oct 2024 09:04:16 +0200
Message-ID: <20241001070418.28737-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001070418.28737-1-its@irrelevant.dk>
References: <20241001070418.28737-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
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

Add a boolean prop (ctratt.mem) for setting CTRATT.MEM and default it to
unset (false) to keep existing behavior of the device intact.

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Arun Kumar <arun.kka@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 7 ++++++-
 hw/nvme/nvme.h | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 050cb63e3390..119adec31274 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8492,7 +8492,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->cntlid = cpu_to_le16(n->cntlid);
 
     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
-    ctratt = NVME_CTRATT_ELBAS | NVME_CTRATT_MEM;
+
+    ctratt = NVME_CTRATT_ELBAS;
+    if (n->params.ctratt.mem) {
+        ctratt |= NVME_CTRATT_MEM;
+    }
 
     id->rab = 6;
 
@@ -8751,6 +8755,7 @@ static Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 781985754d0d..bd3c6ba33a67 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -538,6 +538,10 @@ typedef struct NvmeParams {
     uint32_t  sriov_max_vq_per_vf;
     uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
+
+    struct {
+        bool mem;
+    } ctratt;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
-- 
2.45.2


