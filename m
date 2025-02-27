Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79637C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaE7-0007tj-BQ; Thu, 27 Feb 2025 04:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaE1-0007mj-BA; Thu, 27 Feb 2025 04:30:37 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaDy-0008HX-7W; Thu, 27 Feb 2025 04:30:37 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 01E871140BC6;
 Thu, 27 Feb 2025 04:30:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 27 Feb 2025 04:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648632; x=
 1740735032; bh=nJtS3p8VcX/Jbbm825Qp1j6N3CnFWdb3PT2YenvEOwQ=; b=B
 zlSpBYIB4mE0pXH3EMe4Ys7zS8nmZVT8/JPkO9I/rVfixkUAXt4N3MOyKh8IYr4w
 Eq5yGzY/WmIFQzIN/D47DfPBVgOS5uDilF2AtNEhgu61Lk4bSW+fLEv4j8k6M6Cb
 fh4UygSEZNsXuFEp/5AZRpOplm4pleAFnH8wJX8Fqz+ROygD8P7IbIhQChJSluqn
 mOciBUsFOy4Y4S1D+NekLFWMgg8n4pijFd86KtXF5Mttgr+xHyoNLLRAkJrBoLyL
 hMErXXQvXGnBSLdEqj+bYncKiPLBMpPtpkMuXXizO2u4POgSMBdwhH+c9KrTdQFO
 5QgHMO+lqI7Wczp93PJjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648632; x=1740735032; bh=n
 JtS3p8VcX/Jbbm825Qp1j6N3CnFWdb3PT2YenvEOwQ=; b=aibhcqKcPeSTvT/Mo
 1lrrIuhNnAZGAjDafOXD3dJCiLuAjHNsET+CQ5Gl9ge2+7arFrfOCEvOdlDbrN46
 bnf0A7Ib0nmBI1XHogtada6x4ni2wbdADrqpsqIYCO5Z85f+stARI53koATMAyEg
 7EG9po65fct7oiLn53z6K7Dz6ferrIASr5Js1aeaLDT91HOJO6vD10nAZr6rOOuf
 doijHhlyKKOyajHrvWLL/3/rQxVLyYORlOTfEybtLEG0/zfH87dmEPo62ekAk/qT
 Iw26mviTbAdna6ddI4gpbHfv5A0LAi24uu63/n1hQC8+Q9CXjjAIOnFQyjMooI9u
 TtYKg==
X-ME-Sender: <xms:uDDAZxkoVPuidJ1-8Gx1uGG-jIPxG8oSRWg481LZ1G5E1XTqJF7Mvw>
 <xme:uDDAZ82k3Yv3tRcrKOjrW4R60EFRIpjcjS7TpuRT8wDVTp3iNhvYE8HZv8YSLFPdJ
 iA0OBdbTw6CkSxX-gU>
X-ME-Received: <xmr:uDDAZ3qxy1nFN7YINKESqs3ih2IK-DjnHyjUVBSaE110-v5pqAsPM7BI80EZfxGXt3mpLQiEKYeVEdHfPsv6vD1J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehk
 sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:uDDAZxmZieoff3GvK3QFoD-YyiPG9cMExZrWrF7XcfLmiDgmDK8JOA>
 <xmx:uDDAZ_1pcongKXjBwo6EU7QgZQkGmSwM9lkpCgFMXL3iKb9OhcrgqQ>
 <xmx:uDDAZwsLE-2vx6A4GMfuE1xp73agfgMCCS6xrcKkvFO3a4tTphKiNg>
 <xmx:uDDAZzUnyTcPFECEn9ypyxNzaNycOyPGGT0ePTPb4ROkLlr_io6ltQ>
 <xmx:uDDAZ9NeEQd54h70AAiEmnVLjWGhJSFxcH885rjylZnwb86tsJmf7Nz7>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:30 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 04/10] hw/nvme: add knob for doorbell buffer config support
Date: Thu, 27 Feb 2025 10:30:11 +0100
Message-ID: <20250227093018.11262-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
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

Add a 'dbcs' knob to allow Doorbell Buffer Config command to be
disabled.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 11 ++++++++---
 hw/nvme/nvme.h       |  1 +
 include/block/nvme.h |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4ee8588ca9ae..1ad76da943a6 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -278,7 +278,6 @@ static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_GET_FEATURES]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_ASYNC_EV_REQ]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_NS_ATTACHMENT]    = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_NIC,
-    [NVME_ADM_CMD_DBBUF_CONFIG]     = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
@@ -8773,8 +8772,13 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
 
-    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DBBUF |
-        NVME_OACS_DIRECTIVES;
+    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES;
+
+    if (n->params.dbcs) {
+        oacs |= NVME_OACS_DBCS;
+
+        n->cse.acs[NVME_ADM_CMD_DBBUF_CONFIG] = NVME_CMD_EFF_CSUPP;
+    }
 
     if (n->params.sriov_max_vfs) {
         oacs |= NVME_OACS_VMS;
@@ -9024,6 +9028,7 @@ static const Property nvme_props[] = {
     DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
     DEFINE_PROP_BOOL("legacy-cmb", NvmeCtrl, params.legacy_cmb, false),
     DEFINE_PROP_BOOL("ioeventfd", NvmeCtrl, params.ioeventfd, false),
+    DEFINE_PROP_BOOL("dbcs", NvmeCtrl, params.dbcs, true),
     DEFINE_PROP_UINT8("zoned.zasl", NvmeCtrl, params.zasl, 0),
     DEFINE_PROP_BOOL("zoned.auto_transition", NvmeCtrl,
                      params.auto_transition_zones, true),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index b86cad388f5a..b8d063a027a9 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -539,6 +539,7 @@ typedef struct NvmeParams {
     bool     auto_transition_zones;
     bool     legacy_cmb;
     bool     ioeventfd;
+    bool     dbcs;
     uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 80fbcb420d48..63eb74460eac 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1235,7 +1235,7 @@ enum NvmeIdCtrlOacs {
     NVME_OACS_NMS           = 1 << 3,
     NVME_OACS_DIRECTIVES    = 1 << 5,
     NVME_OACS_VMS           = 1 << 7,
-    NVME_OACS_DBBUF         = 1 << 8,
+    NVME_OACS_DBCS          = 1 << 8,
 };
 
 enum NvmeIdCtrlOncs {
-- 
2.47.2


