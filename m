Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51FEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3f-0001v7-7q; Mon, 06 Jul 2026 18:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3d-0001uB-Fq; Mon, 06 Jul 2026 18:44:57 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3b-0000yW-A5; Mon, 06 Jul 2026 18:44:57 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 0BF061D0019A;
 Mon,  6 Jul 2026 18:44:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 18:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783377893; x=
 1783464293; bh=5VWvCrV1Tc3tNKrgFFIAsHgM/VO34Wk/bRBMZdeiKMM=; b=B
 q+uwpTEN4nB1K7E5+kBLCNyxYQScxECqHdmo5LBGfmudcboNp2Myq5RTTepklpJg
 Fv4g3UnIjOTZrdZi58XY2Z6g2L9FgqSi0n1LcmnSDSWXwQnjrZDheuB9IjsI7Ywz
 5kKc2gJp810TKlXqm5h4yuLciAMh91hyQN+0DsDvNE/KWb0vskb6Fj4g28I2tHQU
 SiVn9XzHccqITslSuUMb/kmevuGK9P8MAr1V2JH7MhqE9fLNPZnA5+LxAnb+Iq/T
 CGgaQEtkG/7649f2a6HbWSjPIlscdUgQCuhBwzDMrznIlme3en30lCF7hmkJXUI6
 q0fx/5MdD3bJn6NxuFHAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1783377893; x=1783464293; bh=5
 VWvCrV1Tc3tNKrgFFIAsHgM/VO34Wk/bRBMZdeiKMM=; b=bgRc2dwTWoxK9B66J
 vanr2mKLPoo/zr0AUNtopMsIJcRLkRFSj3IgVXfLYYvU2twInghzLZDDLyiZPEGm
 WhVUp7wWe0NhlV0pL8vl7rncxZN+ZxMBBkPRFSWSAVkF4G7c/4lVTgMuTnFZc8Hf
 Gev2I2Y1256rD+M3daob0ijZJ8UyK1ok3Wzbw1QOGBcn5o7/p9Uh9SqmcrRE9uuR
 GSw2y4tN9eLL1uF8CrY19IO+R2anpT0psRu2qIf43+O5PDjHnqC1hF4I6QMLFsN4
 wmabCJZxbWlOXIuWMFQplYeu0tyfH8wvAMBEP8FCdUWon07BX0MEx3ybC/YFyXU+
 s+XuA==
X-ME-Sender: <xms:5S9Mang5cbEGvrqwfv5lVjS2DJRuouEsu_ZeD7MmnJekSxHLgSMqPg>
 <xme:5S9Mav4aXEiPVFc3OZ26IzY6shOi1LVJDco-YRFlia4jQWIsUoAZm0Zp34KNGNwwG
 dxDhSVUfjXmukCqeCMVTwvfTM_q0F4hf4jZ0_tDBPoGyOSZuo-LmA>
X-ME-Received: <xmr:5S9MakHNaoVndpQDd6qhP1z-2xWTgGjiffcRQUaRm0i0sLTFEzuokALmFd9ti_kH2p6BIcbTsFgchMyR1HS16f_tBcmn5RFN41_qXuwQVgdMsmxfi3-gjTp2Dg>
X-ME-Proxy-Cause: dmFkZTECAh4m0OxgoGkgiRC+isJUP1GDqnIO5UvUOWif0bQdjPXB8qf1GZ0hHupTDw4R0Y
 g4mitjEJUEwEak/fEVpJ3XdKJwV0M29eYINll4VGi0GLuYpFdQvU7g3fLsndCqVAoXlSA2
 fJ9DNBS8taF/f1VxYX64HMHD2uh/IXyGFce7JruI/qWIL7fAJ/T2UfbBi2iBDDO/ZrArI0
 UH2dyvWfd6nJlU49f2ukXEjjFgACuhiWXgWCQrE4kDYzmMHRkIN+qEu9HbnfildN69oXiZ
 PxVlZ9B9zMrq0W1FRie4V10xhzbLCTAL6A1M8qp7WD5EzbKNNgklY03slvRtLYDyRub/On
 6FsL4XPn/mp5oU0rqJnPsAOCCLfh7Ad1ldvIEC/54tMUOgqZ6O/cFr4ndNXWcTYPgsjH0B
 voSG5cVhUwwF1I5ivlKHctYa5BgIvsX/UWos2I+ErVyf/+JIsOkZvxxsp36v27ornmwJ3l
 PrOdoRmqghBonzFpuo/EK+bOc52Joao8700To8vpPOtfTdx0AbwfdH/VexqTFGzlTY+3Ca
 ZgYNlrY5LbnYczL/2ZgjlLFZR+YKsRQ/Pw+NWcO55RxbjSpjTxlBn6kjLrrGMPaad12+RX
 AoKg7Jk/cxop07Vqy9KKPAbbXVIyFD2xJ3jN0eA6V0SJpnEG7kVoKe+bwxeg
X-ME-Proxy: <xmx:5S9MapI1_xU2FrYf5_i-8aaSKJV1iVquAWGYZKzYUOJ5HHf1h6gyzA>
 <xmx:5S9Mapg0tG4Issfwk-vj5C_GbkrKe7FbAm_sgWNUqSlWFJ-0sCPN9g>
 <xmx:5S9MavkxyYhi5Uh-M2iEf-XTIbJPvvVCbO8JCLUGhwKe5K9IM4mn_A>
 <xmx:5S9MaoWTpkZoegW-TATj9HX26-PB7FryBR5E2JkSlwr04Kbi0dEtpg>
 <xmx:5S9MahqC8rb57J7SXIUkb7FLBp0kBYLmKN-zrPaB4zHjv16P06Kxb4Xp>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:44:51 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 04/11] hw/nvme: add migration blockers for non-supported cases
Date: Tue,  7 Jul 2026 00:44:16 +0200
Message-ID: <20260706224426.14156-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Let's block migration for cases we don't support:
- SR-IOV
- CMB
- PMR
- SPDM

No functional changes here, because NVMe migration is
not supported at all as of this commit.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 212 +++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h       |   3 +
 include/block/nvme.h |  12 +++
 3 files changed, 227 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7845e59e4b08..d2096eb49d97 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -209,6 +209,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
 #include "system/spdm-socket.h"
+#include "migration/blocker.h"
 #include "migration/vmstate.h"
 
 #include "nvme.h"
@@ -252,6 +253,7 @@ static const bool nvme_feature_support[NVME_FID_MAX] = {
     [NVME_COMMAND_SET_PROFILE]      = true,
     [NVME_FDP_MODE]                 = true,
     [NVME_FDP_EVENTS]               = true,
+    /* if you add something here, please update nvme_set_migration_blockers() */
 };
 
 static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
@@ -4616,6 +4618,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
         return 0;
     case NVME_IOMS_MO_RUH_UPDATE:
         return nvme_io_mgmt_send_ruh_update(n, req);
+    /* if you add something here, please update nvme_set_migration_blockers() */
     default:
         return NVME_INVALID_FIELD | NVME_DNR;
     };
@@ -7545,6 +7548,10 @@ static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
 {
+    /*
+     * When adding a new dtype handling here,
+     * please also update nvme_set_migration_blockers().
+     */
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
@@ -9256,6 +9263,205 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     }
 }
 
+#define BLOCKER_FEATURES_MAX_LEN 256
+
+static inline void nvme_add_blocker_feature(char *blocker_features,
+                                            const char *feature)
+{
+    if (strlen(blocker_features) > 0) {
+        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
+    }
+    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
+}
+
+static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
+                                        Error **errp)
+{
+    uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
+    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
+    bool adm_cmd_security_checked = false;
+    bool cmd_io_mgmt_checked = false;
+    bool cmd_zone_checked = false;
+
+    /*
+     * Idea of this function is simple, we iterate over all Command Sets and
+     * for each supported command we provide a special handling logic to
+     * determine if we should block migration or not.
+     *
+     * For instance, we have NVME_ADM_CMD_NS_ATTACHMENT and it is always
+     * available to the guest, but if there is only 1 namespace, then it is
+     * safe to allow migration, but if there are more, then we need to block
+     * migration because we don't handle this in migration code yet.
+     */
+    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.acs); opcode++) {
+        /* Is command supported? */
+        if (!n->cse.acs[opcode]) {
+            continue;
+        }
+
+        switch (opcode) {
+        case NVME_ADM_CMD_DELETE_SQ:
+        case NVME_ADM_CMD_CREATE_SQ:
+        case NVME_ADM_CMD_GET_LOG_PAGE:
+        case NVME_ADM_CMD_DELETE_CQ:
+        case NVME_ADM_CMD_CREATE_CQ:
+        case NVME_ADM_CMD_IDENTIFY:
+        case NVME_ADM_CMD_ABORT:
+        case NVME_ADM_CMD_SET_FEATURES:
+        case NVME_ADM_CMD_GET_FEATURES:
+        case NVME_ADM_CMD_ASYNC_EV_REQ:
+        case NVME_ADM_CMD_DBBUF_CONFIG:
+        case NVME_ADM_CMD_FORMAT_NVM:
+        case NVME_ADM_CMD_DIRECTIVE_SEND:
+        case NVME_ADM_CMD_DIRECTIVE_RECV:
+            break;
+        case NVME_ADM_CMD_NS_ATTACHMENT: {
+            int namespaces_num = 0;
+            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+                if (!ns) {
+                    continue;
+                }
+
+                namespaces_num++;
+            }
+
+            if (namespaces_num > 1) {
+                nvme_add_blocker_feature(blocker_features,
+                                         "Namespace Attachment");
+            }
+
+            break;
+        }
+        case NVME_ADM_CMD_VIRT_MNGMT:
+            if (n->params.sriov_max_vfs) {
+                nvme_add_blocker_feature(blocker_features, "SR-IOV");
+            }
+
+            break;
+        case NVME_ADM_CMD_SECURITY_SEND:
+        case NVME_ADM_CMD_SECURITY_RECV:
+            if (adm_cmd_security_checked) {
+                break;
+            }
+
+            if (pci_dev->spdm_port) {
+                nvme_add_blocker_feature(blocker_features, "SPDM");
+            }
+
+            adm_cmd_security_checked = true;
+
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.nvm); opcode++) {
+        if (!n->cse.iocs.nvm[opcode]) {
+            continue;
+        }
+
+        switch (opcode) {
+        case NVME_CMD_FLUSH:
+        case NVME_CMD_WRITE:
+        case NVME_CMD_READ:
+        case NVME_CMD_COMPARE:
+        case NVME_CMD_WRITE_ZEROES:
+        case NVME_CMD_DSM:
+        case NVME_CMD_VERIFY:
+        case NVME_CMD_COPY:
+            break;
+        case NVME_CMD_IO_MGMT_RECV:
+        case NVME_CMD_IO_MGMT_SEND:
+            if (cmd_io_mgmt_checked) {
+                break;
+            }
+
+            /* check for NVME_IOMS_MO_RUH_UPDATE */
+            if (n->subsys->params.fdp.enabled) {
+                nvme_add_blocker_feature(blocker_features, "FDP");
+            }
+
+            cmd_io_mgmt_checked = true;
+
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    for (int opcode = 0; opcode < ARRAY_SIZE(n->cse.iocs.zoned); opcode++) {
+        /*
+         * If command isn't supported or we have the same command
+         * in n->cse.iocs.nvm, then we can skip it here.
+         */
+        if (!n->cse.iocs.zoned[opcode] || n->cse.iocs.nvm[opcode]) {
+            continue;
+        }
+
+        switch (opcode) {
+        case NVME_CMD_ZONE_APPEND:
+        case NVME_CMD_ZONE_MGMT_SEND:
+        case NVME_CMD_ZONE_MGMT_RECV:
+            if (cmd_zone_checked) {
+                break;
+            }
+
+            for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+                NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
+                if (!ns) {
+                    continue;
+                }
+
+                if (ns->params.zoned) {
+                    nvme_add_blocker_feature(blocker_features,
+                                             "Zoned Namespace");
+                    break;
+                }
+            }
+
+            cmd_zone_checked = true;
+
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    /*
+     * Try our best to explicitly detect all not supported caps,
+     * to let users know what features cause migration to be blocked,
+     * but in case we miss handling here, everything else will be
+     * covered by unsupported_cap check.
+     */
+    if (NVME_CAP_CMBS(cap)) {
+        nvme_add_blocker_feature(blocker_features, "CMB");
+        cap &= ~((uint64_t)CAP_CMBS_MASK << CAP_CMBS_SHIFT);
+    }
+
+    if (NVME_CAP_PMRS(cap)) {
+        nvme_add_blocker_feature(blocker_features, "PMR");
+        cap &= ~((uint64_t)CAP_PMRS_MASK << CAP_PMRS_SHIFT);
+    }
+
+    unsupported_cap = cap & ~NVME_MIGRATION_SUPPORTED_CAP_BITS;
+    if (unsupported_cap) {
+        nvme_add_blocker_feature(blocker_features, "unknown capability");
+    }
+
+    assert(n->migration_blocker == NULL);
+    if (strlen(blocker_features) > 0) {
+        error_setg(&n->migration_blocker,
+                   "Migration is not supported for %s", blocker_features);
+        if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
 {
     int cntlid;
@@ -9361,6 +9567,10 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
         n->subsys->namespaces[ns->params.nsid] = ns;
     }
+
+    if (!nvme_set_migration_blockers(n, pci_dev, errp)) {
+        return;
+    }
 }
 
 static void nvme_exit(PCIDevice *pci_dev)
@@ -9413,6 +9623,8 @@ static void nvme_exit(PCIDevice *pci_dev)
     }
 
     memory_region_del_subregion(&n->bar0, &n->iomem);
+
+    migrate_del_blocker(&n->migration_blocker);
 }
 
 static const Property nvme_props[] = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 9de9f347c542..40a9726546dc 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -675,6 +675,9 @@ typedef struct NvmeCtrl {
 
     /* Socket mapping to SPDM over NVMe Security In/Out commands */
     int spdm_socket;
+
+    /* Migration-related stuff */
+    Error *migration_blocker;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index e4e7be51205e..17a7c7818d77 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -141,6 +141,18 @@ enum NvmeCapMask {
 #define NVME_CAP_SET_CMBS(cap, val)   \
     ((cap) |= (uint64_t)((val) & CAP_CMBS_MASK)   << CAP_CMBS_SHIFT)
 
+#define NVME_MIGRATION_SUPPORTED_CAP_BITS ( \
+      ((uint64_t)CAP_MQES_MASK   << CAP_MQES_SHIFT)   \
+    | ((uint64_t)CAP_CQR_MASK    << CAP_CQR_SHIFT)    \
+    | ((uint64_t)CAP_AMS_MASK    << CAP_AMS_SHIFT)    \
+    | ((uint64_t)CAP_TO_MASK     << CAP_TO_SHIFT)     \
+    | ((uint64_t)CAP_DSTRD_MASK  << CAP_DSTRD_SHIFT)  \
+    | ((uint64_t)CAP_NSSRS_MASK  << CAP_NSSRS_SHIFT)  \
+    | ((uint64_t)CAP_CSS_MASK    << CAP_CSS_SHIFT)    \
+    | ((uint64_t)CAP_MPSMIN_MASK << CAP_MPSMIN_SHIFT) \
+    | ((uint64_t)CAP_MPSMAX_MASK << CAP_MPSMAX_SHIFT) \
+)
+
 enum NvmeCapCss {
     NVME_CAP_CSS_NCSS    = 1 << 0,
     NVME_CAP_CSS_IOCSS   = 1 << 6,
-- 
2.53.0


