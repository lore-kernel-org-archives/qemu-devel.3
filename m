Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9E4C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyAD-0007HJ-7s; Thu, 11 Jul 2024 14:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyA9-0007B6-Qy; Thu, 11 Jul 2024 14:05:02 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyA8-0003xf-0l; Thu, 11 Jul 2024 14:05:01 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id ADFDB138815B;
 Thu, 11 Jul 2024 14:04:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Thu, 11 Jul 2024 14:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720721098; x=
 1720807498; bh=BKUuf6//UbpYmLZqAbqnAhGjR5i4tJ9ytdfz09jbFdE=; b=o
 VmeWd8tpX148ruqfSDSSadtVnT22m91uky+j0cUc/3M1clIGQOh9jijVOEGo6n3S
 kEfoiX4w4aPBW6rastgvQ47ZCy8ecS8YRsOJGFPLoCOarTX5xwoMvBnVVDlU2lz3
 dHUziAEZHHT2Zn7ztP3YMxP+L7egh83IIh8RRYRvxHmqvV5MxLnX67y2zEj6wrbO
 abuWbAp+QL56dbibSMLfmED+rx+pNSOrchqF7XNYa/4KGJLGLRDxthhEDnWGI/vF
 sHnDblJCzB0vhw/hd2jdtJ886NkTYuihNdWxgJjWZ6I/8bWZgAvRGmEqzYlEqQAl
 5wMnv7WFS7xO8eK7WAYKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720721098; x=
 1720807498; bh=BKUuf6//UbpYmLZqAbqnAhGjR5i4tJ9ytdfz09jbFdE=; b=K
 q4meD7/NYmnwmxbXYqLWSJHeyuPAzdYA9t/ee4U7ZZjUz+fMIbXOORkwyx6p7wOB
 IWF8M1HBtc7Wfs/Utw8t82YtbdI5sUfoFGEKOBWLba71g7/F5V/B8rET5SLLg9ZI
 6JVleF60NbRr9mu4on/zzAgXQAQEa+WpXjkTt0D905n/pjMWfsfQQ/aIix2w6aSH
 hI066ZbS9HsxzaCI5foPJTciELbHAVJuUYVMhfFQM6j42+jZjrRByU09s5uiE2eP
 izHwrwgDUfyEhInH7V1CH1g5AtxlBWlAa5gGA9evEFYDjnVvkOV52SfpKP+DQYQk
 BDNL5dJZUfWjW0EyjSVmg==
X-ME-Sender: <xms:yR6QZttmV0oPS8mC5cpnwRB4yhzsSKPIAHOICVsFr2UbMN8IBpEitw>
 <xme:yR6QZmepeTGCl48k_Zxxja_pYNmI_Qp0-bFqMTlE1rEJd_5Lrz6oYXKyZzu4kGCcH
 vMCDkwsYmL86zvR_sU>
X-ME-Received: <xmr:yR6QZgwDVNPZj0JetAylcGtrU-V5qKlRl6SGiadBXReGtc6EemMfk9MP6CG24WAo_Zf3hhFYig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:yR6QZkOAdfEV9nqJKosMyMzwyX1_s7URMVngarWCFGEQsV5rhxct2g>
 <xmx:yR6QZt-SS_R0ezgL2rDWuezqasDbed-ocHO5jay0OCv2Nod6XXSAQA>
 <xmx:yR6QZkV_nDLBb2_NBxdnwsmXro0p4sPIoMmSR1mJC0JnIqtHqr4Khw>
 <xmx:yR6QZue_M8PtJ_FC7i44-cl03fit4P10Ii2IMeujVfOdc4NgXSgljg>
 <xmx:yh6QZrfjStaWnmIfOpwCrvQVB85H448uDzS4pHFOXvsNpDSxCLOadLT9>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:04:55 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 5/7] hw/nvme: separate identify data for sec. ctrl list
Date: Thu, 11 Jul 2024 20:04:42 +0200
Message-ID: <20240711180436.8532-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
References: <20240711180436.8532-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6763; i=k.jensen@samsung.com;
 h=from:subject; bh=rH0hF3TT/+xqP5ifmpt5IZWcD7feHCeFEaDZHk42zFo=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaQHrVLqBVL4LozslJlQqqPXUZApasNAsKto
 zgw1C8UhS8Fd4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmkB61AAoJEE3hrzFt
 Tw3pHSsH/0mNL2CS4CXNMrnTASwnIv50k6qzqbERlBvshx8Odpu9y9JfVis1zGS0J2SEFyIyAt/
 XrBQkb9HjvWB6rbPUXkO2FxS0yByw7ZxPlx1aZhTWQ3N9hFbTt9B+p+egc6DQehnOFzt4y67VDS
 2RO0cZtTiCtqgx8swIlSZ2PrPQ+CrosMkLr0lTHJw2dGBrO9LUP+OVkikHcEsQapDdIJY/4B/9c
 YOsh3IguX+Sa6bgH2YDgVb7epK97xre5fPAzt1bUJ17pjFOtRtGk/ImiF4RpqGtvTzRkUGwoHDX
 ZzXTQoypyCIQGaCplV4RCYbSVC5IU5cWi62jtxhfOaFUDclIvMRBtaLB
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

Secondary controller list for virtualization has been managed by
Identify Secondary Controller List data structure with NvmeSecCtrlList
where up to 127 secondary controller entries can be managed.  The
problem hasn't arisen so far because NVME_MAX_VFS has been 127.

This patch separated identify data itself from the actual secondary
controller list managed by controller to support more than 127 secondary
controllers with the following patch.  This patch reused
NvmeSecCtrlEntry structure to manage all the possible secondary
controllers, and copy entries to identify data structure when the
command comes in.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c   | 21 ++++++++++-----------
 hw/nvme/nvme.h   | 14 ++++++++------
 hw/nvme/subsys.c |  8 ++++----
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 50f8cc90b038..8a838e5b658b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -219,7 +219,6 @@
 #define NVME_TEMPERATURE_CRITICAL 0x175
 #define NVME_NUM_FW_SLOTS 1
 #define NVME_DEFAULT_MAX_ZA_SIZE (128 * KiB)
-#define NVME_MAX_VFS 127
 #define NVME_VF_RES_GRANULARITY 1
 #define NVME_VF_OFFSET 0x1
 #define NVME_VF_STRIDE 1
@@ -5480,14 +5479,14 @@ static uint16_t nvme_identify_sec_ctrl_list(NvmeCtrl *n, NvmeRequest *req)
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint16_t pri_ctrl_id = le16_to_cpu(n->pri_ctrl_cap.cntlid);
     uint16_t min_id = le16_to_cpu(c->ctrlid);
-    uint8_t num_sec_ctrl = n->sec_ctrl_list.numcntl;
+    uint8_t num_sec_ctrl = n->nr_sec_ctrls;
     NvmeSecCtrlList list = {0};
     uint8_t i;
 
     for (i = 0; i < num_sec_ctrl; i++) {
-        if (n->sec_ctrl_list.sec[i].scid >= min_id) {
-            list.numcntl = num_sec_ctrl - i;
-            memcpy(&list.sec, n->sec_ctrl_list.sec + i,
+        if (n->sec_ctrl_list[i].scid >= min_id) {
+            list.numcntl = MIN(num_sec_ctrl - i, 127);
+            memcpy(&list.sec, n->sec_ctrl_list + i,
                    list.numcntl * sizeof(NvmeSecCtrlEntry));
             break;
         }
@@ -7144,8 +7143,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
 
     if (n->params.sriov_max_vfs) {
         if (!pci_is_vf(pci_dev)) {
-            for (i = 0; i < n->sec_ctrl_list.numcntl; i++) {
-                sctrl = &n->sec_ctrl_list.sec[i];
+            for (i = 0; i < n->nr_sec_ctrls; i++) {
+                sctrl = &n->sec_ctrl_list[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }
         }
@@ -7939,7 +7938,7 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
 static void nvme_init_state(NvmeCtrl *n)
 {
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
     uint8_t max_vfs;
@@ -7964,9 +7963,9 @@ static void nvme_init_state(NvmeCtrl *n)
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
     QTAILQ_INIT(&n->aer_queue);
 
-    list->numcntl = max_vfs;
+    n->nr_sec_ctrls = max_vfs;
     for (i = 0; i < max_vfs; i++) {
-        sctrl = &list->sec[i];
+        sctrl = &list[i];
         sctrl->pcid = cpu_to_le16(n->cntlid);
         sctrl->vfn = cpu_to_le16(i + 1);
     }
@@ -8559,7 +8558,7 @@ static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
     int i;
 
     for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
-        sctrl = &n->sec_ctrl_list.sec[i];
+        sctrl = &n->sec_ctrl_list[i];
         nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
     }
 }
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 2e7d31c0ae6d..9da5343ffe90 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,6 +26,7 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
+#define NVME_MAX_VFS 127
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -613,7 +614,8 @@ typedef struct NvmeCtrl {
     } features;
 
     NvmePriCtrlCap  pri_ctrl_cap;
-    NvmeSecCtrlList sec_ctrl_list;
+    uint32_t nr_sec_ctrls;
+    NvmeSecCtrlEntry sec_ctrl_list[NVME_MAX_VFS];
     struct {
         uint16_t    vqrfap;
         uint16_t    virfap;
@@ -663,7 +665,7 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
     NvmeCtrl *pf = NVME(pcie_sriov_get_pf(pci_dev));
 
     if (pci_is_vf(pci_dev)) {
-        return &pf->sec_ctrl_list.sec[pcie_sriov_vf_number(pci_dev)];
+        return &pf->sec_ctrl_list[pcie_sriov_vf_number(pci_dev)];
     }
 
     return NULL;
@@ -672,12 +674,12 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
 static inline NvmeSecCtrlEntry *nvme_sctrl_for_cntlid(NvmeCtrl *n,
                                                       uint16_t cntlid)
 {
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     uint8_t i;
 
-    for (i = 0; i < list->numcntl; i++) {
-        if (le16_to_cpu(list->sec[i].scid) == cntlid) {
-            return &list->sec[i];
+    for (i = 0; i < n->nr_sec_ctrls; i++) {
+        if (le16_to_cpu(list[i].scid) == cntlid) {
+            return &list[i];
         }
     }
 
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index d30bb8bfd5b4..561ed04a5317 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -17,13 +17,13 @@
 static int nvme_subsys_reserve_cntlids(NvmeCtrl *n, int start, int num)
 {
     NvmeSubsystem *subsys = n->subsys;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     int i, cnt = 0;
 
     for (i = start; i < ARRAY_SIZE(subsys->ctrls) && cnt < num; i++) {
         if (!subsys->ctrls[i]) {
-            sctrl = &list->sec[cnt];
+            sctrl = &list[cnt];
             sctrl->scid = cpu_to_le16(i);
             subsys->ctrls[i] = SUBSYS_SLOT_RSVD;
             cnt++;
@@ -36,12 +36,12 @@ static int nvme_subsys_reserve_cntlids(NvmeCtrl *n, int start, int num)
 static void nvme_subsys_unreserve_cntlids(NvmeCtrl *n)
 {
     NvmeSubsystem *subsys = n->subsys;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     int i, cntlid;
 
     for (i = 0; i < n->params.sriov_max_vfs; i++) {
-        sctrl = &list->sec[i];
+        sctrl = &list[i];
         cntlid = le16_to_cpu(sctrl->scid);
 
         if (cntlid) {
-- 
2.44.0


