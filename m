Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D21D1BDD4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81ab-00019H-9F; Mon, 04 Nov 2024 13:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81aZ-00018j-4o; Mon, 04 Nov 2024 13:14:07 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81aX-0004oo-4Y; Mon, 04 Nov 2024 13:14:06 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id C578A1140193;
 Mon,  4 Nov 2024 13:14:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 04 Nov 2024 13:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730744043; x=
 1730830443; bh=bFXuFCqrbvFPf5zmMlrXcMHnOMq7gmdgfhWDCGQFgjI=; b=m
 PSjgKmPXFz3zU58L+aYJbdvXlwqGpyGFojvlve2wsRWUNTqOBgc/NCNdZQK+K0gO
 q7tGOFGwvdLFhiYn9tRN29vKznmiJJ6nnQeSQNnDXsvGkNrP3s+F8+xXihOpsivh
 ayCcwP0aQI034fkh9nnDa9bolpE3D9CVrox36V/3BgSZMJxly2h1qpl0MpWF4hMO
 PI3qh0F5wXIgN6o2Ei2McLBwxStHy1UUfvMgyZEkZc0x1N6XddKCrt2uH6q1PINk
 xJFrC1JY+RKM/vWHvJ/DVZ0Xt++ZPHz0vK90LoxD2giXZte2xto7k6M6l8iWm55i
 U8iSVQsZAd1kb/QzJd11w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1730744043; x=1730830443; bh=b
 FXuFCqrbvFPf5zmMlrXcMHnOMq7gmdgfhWDCGQFgjI=; b=T7a/OKh5AYGeslzoG
 i1XTsb0Dsbe1We+YZAw7ArXjLVJXw5x2qTueCQzRYBBawf1hVkVMWzj2/v6v50dj
 4iLKVyaJCEB077vGcYw8nzGkUw8qxulwnZjfFffAb1wLCQLbbicc5MVbDl20tFhB
 j8/P9VJMgMsokWFRBrsfxAzpkJxqe6vQORVe1ktyb5HKIkgBLmFkJTfeRM/tWa89
 4iDBLb2gr3MOEfnrkutlh2X25nGnOYyvYSnJMBT1WrnLMAEVy/7WKB0PvpCA3i+J
 5SFuYF824J/qMR6i1esRsJzsKpF6wANMofLCMrqB9dEygYoo5TcDkuCRbvEiTWO6
 xH42g==
X-ME-Sender: <xms:6g4pZ6PhPyz8FRBlAPA6PiqJCHxATgU7xaZ64qkLfMqNBBfpbzWJvw>
 <xme:6g4pZ4-gJeDRhJl4bYQNlFLHO1SDLphVp9ghhbiX5oDZ-l-GH0aKzidx0N3u9Uito
 mhWLE3dHIcFHO1AMRI>
X-ME-Received: <xmr:6g4pZxQvejugyn7Mg_bQDaQddrbpuERbtdD43jpnN7QzKT2iomKyslCR3Gjsl-jf5VSwmn15j-V4peCh1fneRg>
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
 eprghruhhnrdhkkhgrsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhdrjhgvnhhs
 vghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlh
 drohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthht
 ohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepshhtvghfrghnhhgrse
 hrvgguhhgrthdrtghomhdprhgtphhtthhopehfrghmsegvuhhphhhonhdrnhgvth
X-ME-Proxy: <xmx:6g4pZ6tvpRySe7ggR4E2DVprEbEfUeT8OizTy2Fi8McxptFFn5MbrA>
 <xmx:6g4pZyfyq0w3_aiHG4Pd-4mE-unY7Kmx32y1AQEIQn6gn2jeXte_5A>
 <xmx:6g4pZ-3An6-Y8D9anymt18tN_Kn54nEzuhkL85UKebqJ4GQ3We7Ydw>
 <xmx:6g4pZ2-kcyGtHcnTBQKN1ZrWDSOD9fKFGvjWbHE4zwWNK7ji_9adhQ>
 <xmx:6w4pZ91tG80hHOwdezY8506oH6sGEeBYUNPTIjlK2Nmn-enak3Rv_wXK>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 13:14:00 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arun Kumar <arun.kka@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 1/3] hw/nvme: i/o cmd set independent namespace data structure
Date: Mon,  4 Nov 2024 19:13:04 +0100
Message-ID: <20241104181306.2329-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104181306.2329-1-its@irrelevant.dk>
References: <20241104181306.2329-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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

From: Arun Kumar <arun.kka@samsung.com>

Add support for the I/O Command Set Independent Namespace Data
Structure (CNS 8h and 1fh).

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Link: https://lore.kernel.org/r/20240925004407.3521406-1-arun.kka@samsung.com
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 31 +++++++++++++++++++++++++++++++
 hw/nvme/ns.c         |  6 +++++-
 hw/nvme/nvme.h       |  1 +
 hw/nvme/trace-events |  1 +
 include/block/nvme.h | 23 +++++++++++++++++++++--
 5 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f4e89203c1a6..8e4612e03567 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5692,6 +5692,33 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCtrl *n, NvmeRequest *req)
     return nvme_c2h(n, (uint8_t *)&list, sizeof(list), req);
 }
 
+static uint16_t nvme_identify_ns_ind(NvmeCtrl *n, NvmeRequest *req, bool alloc)
+{
+    NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
+    uint32_t nsid = le32_to_cpu(c->nsid);
+
+    trace_pci_nvme_identify_ns_ind(nsid);
+
+    if (!nvme_nsid_valid(n, nsid) || nsid == NVME_NSID_BROADCAST) {
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
+        if (alloc) {
+            ns = nvme_subsys_ns(n->subsys, nsid);
+            if (!ns) {
+                return nvme_rpt_empty_id_struct(n, req);
+            }
+        } else {
+            return nvme_rpt_empty_id_struct(n, req);
+        }
+    }
+
+    return nvme_c2h(n, (uint8_t *)&ns->id_ns_ind, sizeof(NvmeIdNsInd), req);
+}
+
 static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
                                      bool active)
 {
@@ -5946,6 +5973,10 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
         return nvme_identify_sec_ctrl_list(n, req);
     case NVME_ID_CNS_CS_NS:
         return nvme_identify_ns_csi(n, req, true);
+    case NVME_ID_CNS_CS_IND_NS:
+        return nvme_identify_ns_ind(n, req, false);
+    case NVME_ID_CNS_CS_IND_NS_ALLOCATED:
+        return nvme_identify_ns_ind(n, req, true);
     case NVME_ID_CNS_CS_NS_PRESENT:
         return nvme_identify_ns_csi(n, req, false);
     case NVME_ID_CNS_CTRL:
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175dbd1..6dbdcb49bfc1 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -62,6 +62,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     static uint64_t ns_count;
     NvmeIdNs *id_ns = &ns->id_ns;
     NvmeIdNsNvm *id_ns_nvm = &ns->id_ns_nvm;
+    NvmeIdNsInd *id_ns_ind = &ns->id_ns_ind;
     uint8_t ds;
     uint16_t ms;
     int i;
@@ -75,7 +76,9 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     id_ns->nsfeat |= (0x4 | 0x10);
 
     if (ns->params.shared) {
-        id_ns->nmic |= NVME_NMIC_NS_SHARED;
+        id_ns->nmic |= NVME_ID_NS_IND_NMIC_SHRNS;
+        id_ns_ind->nmic = NVME_ID_NS_IND_NMIC_SHRNS;
+        id_ns_ind->nstat = NVME_ID_NS_IND_NSTAT_NRDY;
     }
 
     /* Substitute a missing EUI-64 by an autogenerated one */
@@ -770,6 +773,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
         subsys->namespaces[nsid] = ns;
 
         ns->id_ns.endgid = cpu_to_le16(0x1);
+        ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
 
         if (ns->params.detached) {
             return;
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 7566b316d12d..724220691057 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -233,6 +233,7 @@ typedef struct NvmeNamespace {
     int64_t      moff;
     NvmeIdNs     id_ns;
     NvmeIdNsNvm  id_ns_nvm;
+    NvmeIdNsInd  id_ns_ind;
     NvmeLBAF     lbaf;
     unsigned int nlbaf;
     size_t       lbasz;
diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
index 3a67680c6ad1..6be0bfa1c1fc 100644
--- a/hw/nvme/trace-events
+++ b/hw/nvme/trace-events
@@ -56,6 +56,7 @@ pci_nvme_identify(uint16_t cid, uint8_t cns, uint16_t ctrlid, uint8_t csi) "cid
 pci_nvme_identify_ctrl(void) "identify controller"
 pci_nvme_identify_ctrl_csi(uint8_t csi) "identify controller, csi=0x%"PRIx8""
 pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_ns_ind(uint32_t nsid) "nsid %"PRIu32""
 pci_nvme_identify_ctrl_list(uint8_t cns, uint16_t cntid) "cns 0x%"PRIx8" cntid %"PRIu16""
 pci_nvme_identify_pri_ctrl_cap(uint16_t cntlid) "identify primary controller capabilities cntlid=%"PRIu16""
 pci_nvme_identify_sec_ctrl_list(uint16_t cntlid, uint8_t numcntl) "identify secondary controller list cntlid=%"PRIu16" numcntl=%"PRIu8""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a37be0d0da8e..39955a63455f 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1077,6 +1077,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CS_NS                 = 0x05,
     NVME_ID_CNS_CS_CTRL               = 0x06,
     NVME_ID_CNS_CS_NS_ACTIVE_LIST     = 0x07,
+    NVME_ID_CNS_CS_IND_NS             = 0x08,
     NVME_ID_CNS_NS_PRESENT_LIST       = 0x10,
     NVME_ID_CNS_NS_PRESENT            = 0x11,
     NVME_ID_CNS_NS_ATTACHED_CTRL_LIST = 0x12,
@@ -1087,6 +1088,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
     NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
     NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
+    NVME_ID_CNS_CS_IND_NS_ALLOCATED   = 0x1f,
 };
 
 typedef struct QEMU_PACKED NvmeIdCtrl {
@@ -1419,6 +1421,20 @@ typedef struct QEMU_PACKED NvmeIdNsNvm {
     uint8_t     rsvd268[3828];
 } NvmeIdNsNvm;
 
+typedef struct QEMU_PACKED NvmeIdNsInd {
+    uint8_t     nsfeat;
+    uint8_t     nmic;
+    uint8_t     rescap;
+    uint8_t     fpi;
+    uint32_t    anagrpid;
+    uint8_t     nsattr;
+    uint8_t     rsvd9;
+    uint16_t    nvmsetid;
+    uint16_t    endgrpid;
+    uint8_t     nstat;
+    uint8_t     rsvd15[4081];
+} NvmeIdNsInd;
+
 typedef struct QEMU_PACKED NvmeIdNsDescr {
     uint8_t nidt;
     uint8_t nidl;
@@ -1439,8 +1455,10 @@ enum NvmeNsIdentifierType {
     NVME_NIDT_CSI               = 0x04,
 };
 
-enum NvmeIdNsNmic {
-    NVME_NMIC_NS_SHARED         = 1 << 0,
+enum NvmeIdNsIndependent {
+    NVME_ID_NS_IND_NMIC_SHRNS   = 1 << 0,
+    NVME_ID_NS_IND_NMIC_DISNS   = 1 << 1,
+    NVME_ID_NS_IND_NSTAT_NRDY   = 1 << 0,
 };
 
 enum NvmeCsi {
@@ -1873,6 +1891,7 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAF) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeLBAFE) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsInd) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsNvm) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeIdNsZoned) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeSglDescriptor) != 16);
-- 
2.45.2


