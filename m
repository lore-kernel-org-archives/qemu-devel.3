Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D57CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNoiF-00089Z-QR; Tue, 25 Nov 2025 03:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNoiD-00087w-Vz; Tue, 25 Nov 2025 03:47:50 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vNoiC-0008CM-JA; Tue, 25 Nov 2025 03:47:49 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 817B61D00221;
 Tue, 25 Nov 2025 03:47:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 25 Nov 2025 03:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1764060467; x=
 1764146867; bh=QyUo03bV+OULvhaQCtypRWEx7FCP+TKJrB3LovbCkkk=; b=f
 4MJIz41f2kYgW/pcfH4UNEBOM9IxqFwWPGzj9iiy5jZ07XUNlyuAvnNCucLMDEgC
 BPuITj51AuSiwgjZ/qusbXXgwQWoxvar+6l0FHd0iIdZ0B/dSqD0ASikgGQCjckx
 BErQvUuyK4uasJ7GiiXDs+fNRlNYMFJnuY32Tv+xd8UMRN95sABfcIMQhcmD7SB4
 R3PR3N08cEzWDgBBuwmaQreDFER4v8rS9ckEOX0+7KDF/PA9gaXzioit1T2RVyAU
 Qc1wOiYduo/wSTvpUM94w0zA1l94CY1KuO/OqsYNC6O1Bq8Kvl0yM7nL5+DjqkhU
 LphRqB8yAo2g7E7w0fFPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1764060467; x=1764146867; bh=Q
 yUo03bV+OULvhaQCtypRWEx7FCP+TKJrB3LovbCkkk=; b=0iZe5uolOEQ174nMY
 URp66bvH9iaI5MCs4uyHzJokZjP9W5qh7rMOGodGsBWvqTjh60aO9pqvxqHvtMZT
 YzGXPtk/igpmp4HntgrMzbBVUE7wo+0Zn9r7VnU1wQfP1RJ3LdlSB/kJi/mVkhYf
 YfbE4HKuu9aMRocvlSDzmwHb8QZbr7D/WB0oTNsBHR3MFjW4QzruPPG0Rqs5tYPT
 yB91v1j+3Q1qhS+0nC7WrBbvGN6Us8+K5ZL8AFsW4HAWtoNSXXJnBTztFyqUsC5P
 JZK+vdA4ZsH3Zvyik55JSjxamPOKoqFCoLiMxFOXvypsE/xyA1aPtrW1fGS1BRtg
 24sWg==
X-ME-Sender: <xms:Mm0laUTi1gYmkpVK4hOX6DUU0KeMnHSXNMtrI6NOUg6zp-0Ay3XepQ>
 <xme:Mm0laZLlf5ULADijFLhIMpcRVQtUvjCtcLSauM2oz9xiWxc19-Om2w5g06NL73v7A
 F9Wdf7Cxv17Pgfl-PXkkCSkoxoMzoSX_Z79s3KiIlnY9exifiFVaA>
X-ME-Received: <xmr:Mm0laXbvG81K0FQHTy7IC_HqHasehN4PsphJptRGfLAkyPGacQOpIt1Ij6LhCMrPlSRnLnzBJszTpba6WxS24tJa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedutdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudejudeg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprh
 gtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphht
 thhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvg
 hnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhht
 rdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhope
 hqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:Mm0laT_VFG56AnV_Mr7223BbICxffvO4FBz4dlGuiU-qaQYCmvs-iA>
 <xmx:Mm0laQbUOF1-RuedxDzH4OUgplK2acvSohv4qX5iOvUB9ryZFLCK9g>
 <xmx:Mm0lafN-7LDmFtyu6wcR0EfJALVj-aMonm2tQOO-dblm4v7qkjI0wQ>
 <xmx:Mm0laUC_EeOgATXyQPyGSJb5M0yoHgHoCA9II2HOnLlcOiZ2m_GogA>
 <xmx:M20labgtsfcbiLZNOxV1omjnBsaJe-ahTg95lMUvOxn_9XV6HuUACeVR>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 03:47:45 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 2/3] hw/nvme: fix up extended protection information format
Date: Tue, 25 Nov 2025 09:47:24 +0100
Message-ID: <20251125084725.4632-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125084725.4632-1-its@irrelevant.dk>
References: <20251125084725.4632-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=its@irrelevant.dk;
 helo=fout-b5-smtp.messagingengine.com
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

From: Keith Busch <kbusch@kernel.org>

Set the protection information format (pif) only in the formats that can
support the larger guard types, and update the current in-use format
information when the user changes it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
[k.jensen: fix missing braces and wrong indentation]
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 253e7b406b4e..58800b3414a3 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -32,11 +32,13 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     NvmeIdNs *id_ns = &ns->id_ns;
     NvmeIdNsNvm *id_ns_nvm = &ns->id_ns_nvm;
     BlockDriverInfo bdi;
-    int npdg, ret;
+    int npdg, ret, index;
     int64_t nlbas;
 
+    index = NVME_ID_NS_FLBAS_INDEX(id_ns->flbas);
     ns->lbaf = id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
     ns->lbasz = 1 << ns->lbaf.ds;
+    ns->pif = NVME_ID_NS_NVM_ELBAF_PIF(ns->id_ns_nvm.elbaf[index]);
 
     nlbas = ns->size / (ns->lbasz + ns->lbaf.ms);
 
@@ -112,8 +114,6 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
         id_ns->dps |= NVME_ID_NS_DPS_FIRST_EIGHT;
     }
 
-    ns->pif = ns->params.pif;
-
     static const NvmeLBAF defaults[16] = {
         [0] = { .ds =  9           },
         [1] = { .ds =  9, .ms =  8 },
@@ -129,6 +129,12 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 
     memcpy(&id_ns->lbaf, &defaults, sizeof(defaults));
 
+    for (i = 0; i < ns->nlbaf; i++) {
+        if (id_ns->lbaf[i].ms >= 16) {
+            id_ns_nvm->elbaf[i] = (ns->params.pif & 0x3) << 7;
+        }
+    }
+
     for (i = 0; i < ns->nlbaf; i++) {
         NvmeLBAF *lbaf = &id_ns->lbaf[i];
         if (lbaf->ds == ds) {
@@ -142,13 +148,14 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     /* add non-standard lba format */
     id_ns->lbaf[ns->nlbaf].ds = ds;
     id_ns->lbaf[ns->nlbaf].ms = ms;
+    if (ms >= 16) {
+        id_ns_nvm->elbaf[ns->nlbaf] = (ns->params.pif & 0x3) << 7;
+    }
     ns->nlbaf++;
 
     id_ns->flbas |= i;
 
-
 lbaf_found:
-    id_ns_nvm->elbaf[i] = (ns->pif & 0x3) << 7;
     id_ns->nlbaf = ns->nlbaf - 1;
     nvme_ns_init_format(ns);
 
-- 
2.51.0


