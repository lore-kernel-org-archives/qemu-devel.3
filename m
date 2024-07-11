Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E804C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyAR-0007uh-RY; Thu, 11 Jul 2024 14:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyAE-0007Kk-2t; Thu, 11 Jul 2024 14:05:06 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyAC-0003yC-Aq; Thu, 11 Jul 2024 14:05:05 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id CFB76138815B;
 Thu, 11 Jul 2024 14:05:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 11 Jul 2024 14:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720721101; x=
 1720807501; bh=Fq1LlHL5Af2WmagmF5wE56kSRxwIsdDG12xAo8ifsT0=; b=P
 uurNt7Zos6RC5jsWSPBpjUqveuGaQmz59pgq9eDw9ziZuYW44uxYSvFIi0kzQSqO
 md6FTRCsPYRoWaYK2KT65d1RTxyi5LENbBLeDIgMKX61PlrBfMYWHJIvp+agiV6W
 TLEZbtGJ24xhvRabSUDvPT+kOGUF6AoKDzR8Xod4/Meiiy7UOP9HgSduqFM0LeVz
 ifHgU3BBw8wgxpf5OHjnd9TjkZlapuPi5fBbK1ib/7LniGwzqOABqpaYpYT6UhkO
 AZERJVCU489PJaw7OvuI0d/guInFnrV9IuiWgZJELZB3ztNgQNlQemMhtIVHIYRO
 BkgmnoML/5BU3VkWLLhhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720721101; x=
 1720807501; bh=Fq1LlHL5Af2WmagmF5wE56kSRxwIsdDG12xAo8ifsT0=; b=G
 9o/CJnrYz3SKZIvwCEwtblxQqR5Cgn9hvith2+ahS+9PeO84t47MxuPCnJAQVjLC
 fwjTnR3g+QXR2xyuNJHDELRngvdP/+hD2/5wT0GofHOLr84WNXIeJkP3diKxB4QN
 AavRBezVZiNlnJbDL3axUeFMPoipX3lrDp7UUfc62895g8L6Ibk0ww476p8veL/p
 gUeUgLD/P/My94G4vy3IHkNTtaoGfET4xiVL1KeknYGT4axpAzkZfX3Z3HddELDi
 MDh2nnHE+9pAB0377pAb7hThhOjCLUzl2Z5Yb0QxBDVxFXQRx/hcquQ4tfRDv5As
 Vsg1axC3vpr7Ru264cFLA==
X-ME-Sender: <xms:zB6QZsvHiikPjZmEVBFSXK6YF15rX1rsflPKf_9cRuwoUuWA4nLV_g>
 <xme:zB6QZpePseDLGoz98AZxfgKICY03jvvyUxifytG4i9BljWp4deepvKN0kuj5escwb
 4YZk4JnCwAyaGGnybI>
X-ME-Received: <xmr:zB6QZnwlMHu8wtMFo-ZrQrMlkipNXg-b-IcZdPd4OSBN8jBSuIOicW6-L0-Yiz4pwSabdKnx4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:zB6QZvPJYBA-mtMi6uSM9kPSBh5W3FEGbohB_Pfd2Y1YZYDJlVpYyQ>
 <xmx:zB6QZs8S7hDauhHy6KTEYT14dfRAqkQX5jjRvLnBbfvWl7m5XudRsg>
 <xmx:zB6QZnWY_nMHX_S_1cauWneR4j-nYPNwxAQ9saUsISsdYdjQbdSPGg>
 <xmx:zB6QZleZ2ZQoFFfU6Ppc735K5nTMxBffpn0SmFwpk8Q_k4zLkWc8kg>
 <xmx:zR6QZmekuQwHbGk8WdZ1pCkWeRhg-ynGYnen4bSQf6qzkRQaFdtGL-cC>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:04:58 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 6/7] hw/nvme: Allocate sec-ctrl-list as a dynamic array
Date: Thu, 11 Jul 2024 20:04:43 +0200
Message-ID: <20240711180436.8532-15-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
References: <20240711180436.8532-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=k.jensen@samsung.com;
 h=from:subject; bh=k8m80l/QsMvWexioTVhcTPvnL8hEaDZKufoo+Ej37ds=;
 b=owJ4nJvAy8zAxej7cL1hrj/vS8bTakkMaRPkts689SH5mPuNEPuCKWtl3qvvbd9Rd4ltyo38b
 LcALpu972w7GY1ZGBi5GGTFFFmCNIxXlT6682yRe9oBmEGsTCBTGLg4BWAiF+M5GLaHxHqIVR7X
 UZYXXVd2SErqf+WvhqNswikZIim6M1MPaNp56rCf/cFuHdQVkD/9UNsGfYWVn1S+v/ppoXX+JO9
 WtpCdFf8msZ187H80SfOXZPSRiS+YDGsjvZqMrXM/mDgoxYjxnjvmKyz10Wdvut2J0g1FUp4XSh
 9wLFOTS2vfJtFttro5n7erf8qCr22LHjrPmb9ackX/r5rSNcm1IZzR+5Qe8q43erH6ctddA9lrD
 0y+R75szHOOmFBdF7zQlEPp7eGTz3baWrncCQnY9uTLwpqWtJ76zvgE031WtQImpnMFEjY7xHre
 qr20UnLtr5lvK6q063kfbHP++pn3eOX7OToSLUyc3pLsOhEAbzKhiw==
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: Minwoo Im <minwoo.im@samsung.com>

To prevent further bumping up the number of maximum VF te support, this
patch allocates a dynamic array (NvmeCtrl *)->sec_ctrl_list based on
number of VF supported by sriov_max_vfs property.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c   | 8 +-------
 hw/nvme/nvme.h   | 5 ++---
 hw/nvme/subsys.c | 2 ++
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8a838e5b658b..1e50b57707ba 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7868,12 +7868,6 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
             return false;
         }
 
-        if (params->sriov_max_vfs > NVME_MAX_VFS) {
-            error_setg(errp, "sriov_max_vfs must be between 0 and %d",
-                       NVME_MAX_VFS);
-            return false;
-        }
-
         if (params->cmb_size_mb) {
             error_setg(errp, "CMB is not supported with SR-IOV");
             return false;
@@ -8485,7 +8479,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("zoned.zasl", NvmeCtrl, params.zasl, 0),
     DEFINE_PROP_BOOL("zoned.auto_transition", NvmeCtrl,
                      params.auto_transition_zones, true),
-    DEFINE_PROP_UINT8("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
+    DEFINE_PROP_UINT16("sriov_max_vfs", NvmeCtrl, params.sriov_max_vfs, 0),
     DEFINE_PROP_UINT16("sriov_vq_flexible", NvmeCtrl,
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 9da5343ffe90..180df26ccea0 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,7 +26,6 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
-#define NVME_MAX_VFS 127
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -533,7 +532,7 @@ typedef struct NvmeParams {
     bool     auto_transition_zones;
     bool     legacy_cmb;
     bool     ioeventfd;
-    uint8_t  sriov_max_vfs;
+    uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
@@ -615,7 +614,7 @@ typedef struct NvmeCtrl {
 
     NvmePriCtrlCap  pri_ctrl_cap;
     uint32_t nr_sec_ctrls;
-    NvmeSecCtrlEntry sec_ctrl_list[NVME_MAX_VFS];
+    NvmeSecCtrlEntry *sec_ctrl_list;
     struct {
         uint16_t    vqrfap;
         uint16_t    virfap;
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 561ed04a5317..77deaf2c2c97 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -61,6 +61,8 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)
     if (pci_is_vf(&n->parent_obj)) {
         cntlid = le16_to_cpu(sctrl->scid);
     } else {
+        n->sec_ctrl_list = g_new0(NvmeSecCtrlEntry, num_vfs);
+
         for (cntlid = 0; cntlid < ARRAY_SIZE(subsys->ctrls); cntlid++) {
             if (!subsys->ctrls[cntlid]) {
                 break;
-- 
2.44.0


