Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BCBC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gS9-0005dY-UR; Wed, 08 May 2024 08:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gS8-0005d6-JH; Wed, 08 May 2024 08:31:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1s4gS6-0003AB-Kf; Wed, 08 May 2024 08:31:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so3343450b3a.0; 
 Wed, 08 May 2024 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171477; x=1715776277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HoXn8Mk/Gcs09/vO/7dO0ihbgiIg45aLeVlxtEb0Kk=;
 b=gEpNDtl8lh/1gq492yPDxZ8rxYFePaaotk1puyGFzX8ALr26TLcZEz/jJIp5A4KAfM
 N5ptSqQpe/7xp2qpQGx5qdYyhyuKi8yeCmsDKmtIX95RNPgYmdgwXDW/hrvLPSQcXpj7
 FDdbWfJCvEkRHnLEgblgISOBBF5ykahiq5Ph3zDMHnj/xT/OPMQ1YFv3k7+KYzClycVW
 oGGISGmBw83Ja+wBec9RttnLC7+mXiU7BT7+8xCpCZe0xcIb3MHzCb/+JGzijYELfmoY
 qq1/j+XVLYfAtCRmnMLNf+fgjSDbNM5nZxUNVQJxfssMrkgNkwrU9zJUtHWZrt2ypFz5
 hWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171477; x=1715776277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HoXn8Mk/Gcs09/vO/7dO0ihbgiIg45aLeVlxtEb0Kk=;
 b=T20Q9xWcMUAdlODuXM5f8rdExpdx+cr+7o7KT231VqfLWnCXNCnjrIYfKAq5JEUq1W
 5dG2Tb7IebbS0WZ9G3KDclafZMQ6wTeDlla1lE2vwmQ16MiNEh3857V5GRjbwBLROqUc
 aFif+1caXuUb5bUooEmbotTzofqq98uRQ+dUTGAEeO25sxwi0+kavXT5aVr+cX6sdaeE
 XUrOT5R5glYaIJgTrndxrnXX5p6LFleluyNk6twqJIirFbhCCOzbbeAJlv9lapmQJfFM
 4pk8KW/RLXvjSAr3VagL9zHt8hxm5TPdpyHkx503mu3CPI6lgVuf+FUvDyY4V08q3Jlm
 Rb8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWu7Ihc5wgdHabk9eEK9UgAq6UFw0XG7FH2lPIjFCAMGjsH4shkacNGUQgO2776x+uax/Ct/ZVh2KVMwuOZHSuK3xCFa0=
X-Gm-Message-State: AOJu0YxvYT1vL4rSQ7PajD5cSEILT5VigtHtyMcGvLuU4LjuwznGQ4Cq
 THq2EwHLXCmb01pK9rQD5PScysXTM/0lYfQz0Uva6kzgC2JmyIqk
X-Google-Smtp-Source: AGHT+IHIbxD5ij1CxUeyNExWah7Gtt2TATt5ozvSjSHQ32xafeJHKpgR8o0+8b6KsgYVIPRYPFV9Nw==
X-Received: by 2002:a05:6a00:4e8b:b0:6ea:ed70:46b4 with SMTP id
 d2e1a72fcca58-6f49c2afde9mr2278878b3a.29.1715171476642; 
 Wed, 08 May 2024 05:31:16 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 p4-20020a056a0026c400b006f448272ae0sm9794621pfw.4.2024.05.08.05.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:31:16 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v3 2/4] hw/nvme: separate identify data for sec. ctrl list
Date: Wed,  8 May 2024 21:31:05 +0900
Message-Id: <20240508123107.87919-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
References: <20240508123107.87919-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c   | 21 ++++++++++-----------
 hw/nvme/nvme.h   | 14 ++++++++------
 hw/nvme/subsys.c |  8 ++++----
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 18672f66193f..7cf1e8e384b7 100644
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
@@ -7934,7 +7933,7 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
 static void nvme_init_state(NvmeCtrl *n)
 {
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
     uint8_t max_vfs;
@@ -7959,9 +7958,9 @@ static void nvme_init_state(NvmeCtrl *n)
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
@@ -8534,7 +8533,7 @@ static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
     int i;
 
     for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
-        sctrl = &n->sec_ctrl_list.sec[i];
+        sctrl = &n->sec_ctrl_list[i];
         nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
     }
 }
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5fd..485b42c104ea 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,6 +26,7 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
+#define NVME_MAX_VFS 127
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -612,7 +613,8 @@ typedef struct NvmeCtrl {
     } features;
 
     NvmePriCtrlCap  pri_ctrl_cap;
-    NvmeSecCtrlList sec_ctrl_list;
+    uint32_t nr_sec_ctrls;
+    NvmeSecCtrlEntry sec_ctrl_list[NVME_MAX_VFS];
     struct {
         uint16_t    vqrfap;
         uint16_t    virfap;
@@ -662,7 +664,7 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
     NvmeCtrl *pf = NVME(pcie_sriov_get_pf(pci_dev));
 
     if (pci_is_vf(pci_dev)) {
-        return &pf->sec_ctrl_list.sec[pcie_sriov_vf_number(pci_dev)];
+        return &pf->sec_ctrl_list[pcie_sriov_vf_number(pci_dev)];
     }
 
     return NULL;
@@ -671,12 +673,12 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
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
2.34.1


