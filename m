Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1415D1BDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81ap-0001Ba-66; Mon, 04 Nov 2024 13:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81ac-00019g-7I; Mon, 04 Nov 2024 13:14:10 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81aa-0004p5-M8; Mon, 04 Nov 2024 13:14:09 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 364EF254012F;
 Mon,  4 Nov 2024 13:14:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 04 Nov 2024 13:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730744047; x=
 1730830447; bh=MpG4NTZT+5UYGt1Sh7x7MRcpMX3wvO7yYEwaQpC2Kmk=; b=Z
 iPuCjQwZu3mNmz09FYZrskoBPZnn7b4Rxq4bxXsYihm5ZPuw55kOiKW2PBQ6h9/2
 vFug9VvvSyI3ylFKxPXA/+O0CUBlWflj2vSlzkcyncDKUlpE2iC7NMbdVHQD5OB3
 30KtGafVczuKzJD8TeTDdsik2r3OlMWsMJsn8PMyuZZvS15NhuY8GJibBg5YQAI5
 Y1gdIiE0iekTZQNXSR53TB0TrNBFA7xbeM5BSrKmNHeZAZ+gM3pr3HNJAq+W9c5R
 9YJ+PvRNXn5lKYv0zmPh2hvB5TjmgVscStAkLumTYm2eAkWsBCYe9Hn38sYyYICZ
 +zqddmnQDuiuTZct8IiOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1730744047; x=1730830447; bh=M
 pG4NTZT+5UYGt1Sh7x7MRcpMX3wvO7yYEwaQpC2Kmk=; b=k/GvdYw0Fe7YiQC0k
 H2jrsygLcEv5y7V3CHH9J4OuXK2iFvP9IfMmCvX1y8eNN4OFJbHZTKKOzNh312dt
 Ax8wt7wdCbIiBZb/Hy5xTUVpezaLkOHmH8I4F0+5y0rjviEquqWyrEwo0FRnWqkQ
 4Yu6KScCqBn3tA7AJA+iju247K8Y8g7cxGTfUs/JZ0mX8nRgTtUXvXPOBmRofvRn
 oM5wW5VfgkLhhwuEB9ORU3QuEOjrHKiWFlnjUsWBCdsFzcrxGVWDILD5cyD66lJY
 gYsDAxf7UCeHP4aIaqSpWbyuZ3Chdck+BP67qCgPv0jsevpwaP8O9u+YkA6VMfSi
 dlaaQ==
X-ME-Sender: <xms:7g4pZzhNlDhHNXt58Io51nur1b83JLkunu-xVQ4oPkRRJgJV-kNN_g>
 <xme:7g4pZwBNG1w6dPbkckdV7y-wrLdWUORD1jktHd_zZoQZNuo4b-a9k6zurZoEQtj1e
 Mby15Gh4duS-2C09no>
X-ME-Received: <xmr:7g4pZzEhLrKY32ueS3SkKHJiHpuuHmh4dl6cNRGhWyNoADtX-auTYDloTNoB7Y6RU5h6Q_YQLrcYIiPNI7VUdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeehfeekgfejjeejjedutdeigeegteefveekudef
 heevjeekieeuffeuleeiheeugeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhr
 rhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghp
 thhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtoh
 eprgihuhhshhdrmhehheesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehkrdhjvghn
 shgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvg
 hlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphht
 thhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehsthgvfhgrnhhhrg
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrmhesvghuphhhohhnrdhnvght
X-ME-Proxy: <xmx:7g4pZwSUhasiAnOeCrBLbRIIMOsjdQd1-GrXajSvDwBkfrV1JUJv0w>
 <xmx:7g4pZwxizzJunYkKjsRC1AefjjiPhs_9ow_wTPwsrvJKAtDqI_vaYQ>
 <xmx:7g4pZ24jWkA6mHgBVPkeCvnl_-eIZqcI4Nmi9GH8rN6C5MRqdRllAg>
 <xmx:7g4pZ1x7O-I9CADv8sLNNxN-YP4S45vdQC0AAxboZb6N1ohDcpP7mw>
 <xmx:7w4pZ8go6qPXqpV6wbFlKQ4e9kx0uJENUfl0oZUfrL8nYZ6kBZrappIA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 13:14:04 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ayush Mishra <ayush.m55@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 2/3] hw/nvme: add NPDAL/NPDGL
Date: Mon,  4 Nov 2024 19:13:05 +0100
Message-ID: <20241104181306.2329-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104181306.2329-1-its@irrelevant.dk>
References: <20241104181306.2329-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
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

From: Ayush Mishra <ayush.m55@samsung.com>

Add the NPDGL and NPDAL fields to support large alignment and
granularities.

Signed-off-by: Ayush Mishra <ayush.m55@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Link: https://lore.kernel.org/r/20241001012833.3551820-1-ayush.m55@samsung.com
[k.jensen: renamed the enum values]
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c         |  5 ++++-
 include/block/nvme.h | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 6dbdcb49bfc1..526e15aa8018 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -30,6 +30,7 @@
 void nvme_ns_init_format(NvmeNamespace *ns)
 {
     NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdNsNvm *id_ns_nvm = &ns->id_ns_nvm;
     BlockDriverInfo bdi;
     int npdg, ret;
     int64_t nlbas;
@@ -55,6 +56,8 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+    id_ns_nvm->npdal = npdg;
+    id_ns_nvm->npdgl = npdg;
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
@@ -73,7 +76,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     ns->id_ns.dlfeat = 0x1;
 
     /* support DULBE and I/O optimization fields */
-    id_ns->nsfeat |= (0x4 | 0x10);
+    id_ns->nsfeat |= (NVME_ID_NS_NSFEAT_DAE | NVME_ID_NS_NSFEAT_OPTPERF_ALL);
 
     if (ns->params.shared) {
         id_ns->nmic |= NVME_ID_NS_IND_NMIC_SHRNS;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 39955a63455f..f4d108841bf5 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1418,7 +1418,12 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
     uint8_t     pic;
     uint8_t     rsvd9[3];
     uint32_t    elbaf[NVME_MAX_NLBAF];
-    uint8_t     rsvd268[3828];
+    uint32_t    npdgl;
+    uint32_t    nprg;
+    uint32_t    npra;
+    uint32_t    nors;
+    uint32_t    npdal;
+    uint8_t     rsvd288[3808];
 } NvmeIdNsNvm;
 
 typedef struct QEMU_PACKED NvmeIdNsInd {
@@ -1536,6 +1541,16 @@ enum NvmeIdNsMc {
     NVME_ID_NS_MC_SEPARATE = 1 << 1,
 };
 
+enum NvmeIdNsNsfeat {
+    NVME_ID_NS_NSFEAT_THINP         = 1 << 0,
+    NVME_ID_NS_NSFEAT_NSABPNS       = 1 << 1,
+    NVME_ID_NS_NSFEAT_DAE           = 1 << 2,
+    NVME_ID_NS_NSFEAT_UIDREUSE      = 1 << 3,
+    NVME_ID_NS_NSFEAT_OPTPERF_ALL   = 3 << 4,
+    NVME_ID_NS_NSFEAT_MAM           = 1 << 6,
+    NVME_ID_NS_NSFEAT_OPTRPERF      = 1 << 7,
+};
+
 #define NVME_ID_NS_DPS_TYPE(dps) (dps & NVME_ID_NS_DPS_TYPE_MASK)
 
 enum NvmePIFormat {
-- 
2.45.2


