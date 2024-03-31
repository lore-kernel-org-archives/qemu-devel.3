Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3670FCD128A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 19:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr0tK-0000JO-UG; Sun, 31 Mar 2024 15:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tJ-0000J3-1m; Sun, 31 Mar 2024 15:30:53 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tH-0001QE-5J; Sun, 31 Mar 2024 15:30:52 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so2024589a12.1; 
 Sun, 31 Mar 2024 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711913449; x=1712518249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/Oz4nAb4eNMYZyk5vmRGZoOtdjU0VylSe0dYHONRL4=;
 b=OqWl/1u2clk8ud8gIBINY6l1/ZzXPusrfirPe/LFGitR9/QzR31sdwsI9QiFNFxfJI
 PVY4DwpCzZLzwv6SebjEYWox5jdjpdO70hfeqR4AVNZrIq+d4+iMplZo/vQ7pHDB4FK/
 DVq4E7xIFH8g5iC2CE1CSMi9IqNnEfFnDb3c1tJ7XamAbWZjxuVwV6natnu1FiR5xqv4
 5vdQoNVsNQuWCv4YNK7WgTqz9yNW/ZE/Nlv8X6m+u9IkE353FPFsYatot5gt3HnzMyhb
 /CEIuCtipwYO6C/lWyS0AuvKKIpzQasU3iYxoApEN90JuASWTOeblKvzdSGpuwZehLsB
 sCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711913449; x=1712518249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/Oz4nAb4eNMYZyk5vmRGZoOtdjU0VylSe0dYHONRL4=;
 b=oz2WUUvD4eGEET45lKkjCIBovETopvS2Otl1Zf/I8PRLb71YNjY6/Xs7G25Awy4HDi
 bzciKOFWZxLNlgQWOXNHP4OlNOC14gm66ruoKspII6JntSef93Zpp1mAgNkzVZZ/ZKTA
 wqc/bxYhCQOEjog/NTBDBIauK+AJGQqoBxnnVNB0oOUVJK8NKcTvM9LtNeQpRfUONwzS
 lWmUADXmQ5EFxlUHGyMNL0eax3KHKmjYfP0ErKDsnPlqtHNotxLLjh9WiXHmiC37lZnn
 4hTOtSiDt00nOF0f+wrAQIOuaVJWZGqhinuHub4Vsj0fV6lfcT8V4fanViIKap3BMaKQ
 8VHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyAB6yS+MEMMAjg6tbigVGE+rPvh+hpell8D6pJQ1Phk3e1O/BWF+IDRMqOzqKjiEy8ImZEMv4P/Lfq4usmq0+ecGuwIw=
X-Gm-Message-State: AOJu0Yy4jDjRGxfeDD1GfoSykdwZ3GalICsVqKSfL4rYUpm85+gRUIyJ
 7BzZHTSdTBxrvYsOzGSt7qarYTMNi557LCe1UqoBjVHcY2vVg+YP
X-Google-Smtp-Source: AGHT+IG2j1TIVw0Vgmf4x6RolE+0PsvCpr3ZNbaC/aL/IT5s+NDmMlzdmpUnJl10HcLJLa0QppRY5g==
X-Received: by 2002:a17:903:32cb:b0:1e0:7bbf:bef4 with SMTP id
 i11-20020a17090332cb00b001e07bbfbef4mr9192272plr.41.1711913449363; 
 Sun, 31 Mar 2024 12:30:49 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 h15-20020a170902680f00b001dd6f305a81sm7339566plk.293.2024.03.31.12.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 12:30:49 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v2 2/4] hw/nvme: separate identify data for sec. ctrl list
Date: Mon,  1 Apr 2024 04:30:30 +0900
Message-Id: <20240331193032.5186-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
References: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x52f.google.com
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
index cfe53a358871..7e60bc9f2075 100644
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
@@ -7132,8 +7131,8 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
 
     if (n->params.sriov_max_vfs) {
         if (!pci_is_vf(pci_dev)) {
-            for (i = 0; i < n->sec_ctrl_list.numcntl; i++) {
-                sctrl = &n->sec_ctrl_list.sec[i];
+            for (i = 0; i < n->nr_sec_ctrls; i++) {
+                sctrl = &n->sec_ctrl_list[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }
 
@@ -7921,7 +7920,7 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
 static void nvme_init_state(NvmeCtrl *n)
 {
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
-    NvmeSecCtrlList *list = &n->sec_ctrl_list;
+    NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
     uint8_t max_vfs;
@@ -7946,9 +7945,9 @@ static void nvme_init_state(NvmeCtrl *n)
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
     QTAILQ_INIT(&n->aer_queue);
 
-    list->numcntl = cpu_to_le16(max_vfs);
+    n->nr_sec_ctrls = max_vfs;
     for (i = 0; i < max_vfs; i++) {
-        sctrl = &list->sec[i];
+        sctrl = &list[i];
         sctrl->pcid = cpu_to_le16(n->cntlid);
         sctrl->vfn = cpu_to_le16(i + 1);
     }
@@ -8505,7 +8504,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
         if (!(val & PCI_SRIOV_CTRL_VFE)) {
             num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
             for (i = 0; i < num_vfs; i++) {
-                sctrl = &n->sec_ctrl_list.sec[i];
+                sctrl = &n->sec_ctrl_list[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }
         }
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5f2ae7b28b9c..02c11d909cd1 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -26,6 +26,7 @@
 
 #define NVME_MAX_CONTROLLERS 256
 #define NVME_MAX_NAMESPACES  256
+#define NVME_MAX_VFS 127
 #define NVME_EUI64_DEFAULT ((uint64_t)0x5254000000000000)
 #define NVME_FDP_MAX_EVENTS 63
 #define NVME_FDP_MAXPIDS 128
@@ -597,7 +598,8 @@ typedef struct NvmeCtrl {
     } features;
 
     NvmePriCtrlCap  pri_ctrl_cap;
-    NvmeSecCtrlList sec_ctrl_list;
+    uint32_t nr_sec_ctrls;
+    NvmeSecCtrlEntry sec_ctrl_list[NVME_MAX_VFS];
     struct {
         uint16_t    vqrfap;
         uint16_t    virfap;
@@ -647,7 +649,7 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
     NvmeCtrl *pf = NVME(pcie_sriov_get_pf(pci_dev));
 
     if (pci_is_vf(pci_dev)) {
-        return &pf->sec_ctrl_list.sec[pcie_sriov_vf_number(pci_dev)];
+        return &pf->sec_ctrl_list[pcie_sriov_vf_number(pci_dev)];
     }
 
     return NULL;
@@ -656,12 +658,12 @@ static inline NvmeSecCtrlEntry *nvme_sctrl(NvmeCtrl *n)
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


