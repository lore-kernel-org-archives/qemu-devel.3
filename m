Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E50EC54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wom6Y-0004TK-TF; Tue, 28 Jul 2026 14:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6R-0004QL-TB; Tue, 28 Jul 2026 14:00:32 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wom6P-0001WE-Vq; Tue, 28 Jul 2026 14:00:31 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 88DF2EC03E9;
 Tue, 28 Jul 2026 14:00:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 14:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785261628; x=
 1785348028; bh=N3AjwQ2YXrOmvBgcUI67g7DlkOf8MSg692sYg8/6/U8=; b=K
 MWbqE8nbTWEkEBQz8dUKxRZaSu5qTNU/cguLCiiRXkK2MmsoP6YY7nUl5HswdvLo
 sIlHRtSK8WQ2/dYWw8+lo+xNbMhdd9t77L7OvVzdnrUkWT8cQ7RRQmurBdEFc40E
 Zto4Jchd0jQyk+aw2ihlc5wFRUUrOc09l+rygonSfvB+OLFyaysSLDK7A68LcSsU
 92yNgHRrLYjwhcOHF9v8PpgiyhqBQTsu9Xkir93KX8CnUgKlGHquCHn/3o0wWFPr
 RNF1TBsXnMISU0gvUaY5+2aUkDCdXnvNAVebEsixwQ2kfdjxh7kC9uhviU+HZxo5
 1qCe9/bi8Nj0LFnbsqnHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1785261628; x=1785348028; bh=N
 3AjwQ2YXrOmvBgcUI67g7DlkOf8MSg692sYg8/6/U8=; b=LmzaHa4Dnv0yGj66O
 A9vXRG5ObDcufpBYLcJ5tmM0pSDygcN4dY+b8E8nTgVQ2ObdJni1F74xtBEvntHa
 Vi5+PTRBVScVDm6Jczz6roIiYE9gS7p4rjWkDlkN11VN5IirSHfGU0OBo9bJtYQU
 /wnyZMv71+61vpiiet0F7YgyVp33mE/fXEiZ3bgJ/PV2qZsMlxpPgJM5afV0S8YH
 4qmK7RloC3eJvN8OmdHzmPA5ugebbpO829oquFizhQcuZVZmeO9Hkyea9k/00JG/
 3RoAUZGkoHPb4rIwSyzm8iY8BqBuU6ehRm4eTcPzsXDG6LyzvDnYIIUbYGxqQuHx
 b1w4w==
X-ME-Sender: <xms:O-5oahs96QYGNh0pW7ZnYiPQy7TXdtetTWyMCfYOEoijy41sFcRY2g>
 <xme:O-5oakimZo_FDG9s8P1lIR7IyIO1Yx7vm3j8PAxMm-VG0HODWmkWdRlwjQR1xsEIP
 sg2nGRxahP9rBjEyYLNcLDCJVrMCzeGiR986lNNykvuduU3eyvJf1U>
X-ME-Received: <xmr:O-5oakrYU3Z-wcRXz4WGWNwUbL96WfocnbgWrG1FUsUdTYEKkpl9nT6vTVayCIMXnFgs2MfQ3sCcPkYop-BcA9GjSVedKFW6ey5bP-3dJe47NF_8wF6GeJrE3w>
X-ME-Proxy-Cause: dmFkZTE+3hDLj3fhqmx2xVW/U2sM+l/4n8Sn6klj+qZ2iqjdmW4eucHD5k5TBFgLS9xjCq
 3AKS7HvLJmPnWhELLGGSJWqeN03CJ9fsA/OohVLhj1E7BFjsETMhrdkEx/vNSgVFxpw3Bs
 xhYYUmzJ6Jl2BqypFDmF/69E9V2f9rIe5bNvXVMCa4QGnFL/+itcI3ycHE53rOaEoHF8Z0
 Rgcsgg12Xr7OD0YP/WQ+/lcqHdUTJYFTpdir9bQtwN0tRU1u5lvqJ4XizGq+m7GvoRLnhH
 icC65qISA/oMUgTjlMJZ9qqHF+WWxcp2O9D8i57nDJStdXrfOCKEeQOcpjVFgPZBWFB9jA
 xvijsaIzzcMac7nN0a1v1cSiEsxVh0KRYG+JWTKoRvpeV9WFhaozY++BqEEIr3JNL+lW1p
 i6B025llb6pfeHCEJTxLIm178vziE6efZRIs00gNEK/DiW10zrZ/Wca05PflzLA/NwGtjl
 AonTqlTRcAfa762H9S+HXGEigkPOmN4INU+l/kmZv3ElRrUpKl7+fU91e5i16v4BUqP3di
 KyZnNs7hUMATYGs7EhhJAjo8OMt5Ib0C3kRACGegx/UcNm3TJ72C4dseJQcSuMf4m0/2qr
 TdEYgXYZ2K83PweT06Z1JRHiiQsY3t6M+77fwTfThroJ0Z7BiJFf1lVVRaAA
X-ME-Proxy: <xmx:O-5oapuOptTF4U3zDvTp-32nu5EiZaE8sSNIE9gnESIDpenEebYkzg>
 <xmx:O-5oava3eqNGIQOQPmeGQ2bvRS7Qp7aybhz7YNsTIlbSNq5bAMF9FQ>
 <xmx:O-5oaoZ1ODx_WRk0xh8-YvwZVBkKz9JUbcBXgKxVyCUJcn8w7tQcbw>
 <xmx:O-5oaon8ZhFJkpJSiKJfEe1nlFOyXXuMh0-wtvdRfOPEnYoY_YEFLA>
 <xmx:PO5oak3m-bJEn75ywrJiOeaitdczHV3Y25Qx6AnrRcIL3VijdhO_5TQO>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:00:26 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 1/4] hw/nvme: use GPtrArray for blocker_features
Date: Tue, 28 Jul 2026 20:00:15 +0200
Message-ID: <20260728180018.3574-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728180018.3574-1-its@irrelevant.dk>
References: <20260728180018.3574-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.146; envelope-from=its@irrelevant.dk;
 helo=fout-a3-smtp.messagingengine.com
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

Let's use GPtrArray to build a list of blocker features and then
g_strjoinv() to build a final comma-delimited string.

While previous approach was technically correct, it is fragile
(because we need to take care of static buffer size choice) and
Coverity dislikes it too.

Note, that we use g_ptr_array_new() to allocate array which means
that GDestroyNotify callback is not set, so we can pass pointers to
a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") without
any problems as there won't be any attempt to free that memory.

Resolves: Coverity CID 1663673
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
[k.jensen: change cast from gpointer to void ptr]
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..086048b689d3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9352,22 +9352,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     }
 }
 
-#define BLOCKER_FEATURES_MAX_LEN 256
-
-static inline void nvme_add_blocker_feature(char *blocker_features,
-                                            const char *feature)
-{
-    if (strlen(blocker_features) > 0) {
-        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
-    }
-    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
-}
-
 static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
                                         Error **errp)
 {
     uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
-    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
+    g_autoptr(GPtrArray) blocker_features = g_ptr_array_new();
     bool adm_cmd_security_checked = false;
     bool cmd_io_mgmt_checked = false;
     bool cmd_zone_checked = false;
@@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
             }
 
             if (namespaces_num > 1) {
-                nvme_add_blocker_feature(blocker_features,
-                                         "Namespace Attachment");
+                g_ptr_array_add(blocker_features,
+                                (void *) "Namespace Attachment");
             }
 
             break;
         }
         case NVME_ADM_CMD_VIRT_MNGMT:
             if (n->params.sriov_max_vfs) {
-                nvme_add_blocker_feature(blocker_features, "SR-IOV");
+                g_ptr_array_add(blocker_features, (void *) "SR-IOV");
             }
 
             break;
@@ -9435,7 +9424,7 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
             }
 
             if (pci_dev->spdm_port) {
-                nvme_add_blocker_feature(blocker_features, "SPDM");
+                g_ptr_array_add(blocker_features, (void *) "SPDM");
             }
 
             adm_cmd_security_checked = true;
@@ -9469,7 +9458,7 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
 
             /* check for NVME_IOMS_MO_RUH_UPDATE */
             if (n->subsys->params.fdp.enabled) {
-                nvme_add_blocker_feature(blocker_features, "FDP");
+                g_ptr_array_add(blocker_features, (void *) "FDP");
             }
 
             cmd_io_mgmt_checked = true;
@@ -9504,8 +9493,8 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
                 }
 
                 if (ns->params.zoned) {
-                    nvme_add_blocker_feature(blocker_features,
-                                             "Zoned Namespace");
+                    g_ptr_array_add(blocker_features,
+                                    (void *) "Zoned Namespace");
                     break;
                 }
             }
@@ -9525,24 +9514,28 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
      * covered by unsupported_cap check.
      */
     if (NVME_CAP_CMBS(cap)) {
-        nvme_add_blocker_feature(blocker_features, "CMB");
+        g_ptr_array_add(blocker_features, (void *) "CMB");
         cap &= ~((uint64_t)CAP_CMBS_MASK << CAP_CMBS_SHIFT);
     }
 
     if (NVME_CAP_PMRS(cap)) {
-        nvme_add_blocker_feature(blocker_features, "PMR");
+        g_ptr_array_add(blocker_features, (void *) "PMR");
         cap &= ~((uint64_t)CAP_PMRS_MASK << CAP_PMRS_SHIFT);
     }
 
     unsupported_cap = cap & ~NVME_MIGRATION_SUPPORTED_CAP_BITS;
     if (unsupported_cap) {
-        nvme_add_blocker_feature(blocker_features, "unknown capability");
+        g_ptr_array_add(blocker_features, (void *) "unknown capability");
     }
 
     assert(n->migration_blocker == NULL);
-    if (strlen(blocker_features) > 0) {
+    if (blocker_features->len > 0) {
+        g_autofree char *blocker_list = NULL;
+
+        g_ptr_array_add(blocker_features, NULL);
+        blocker_list = g_strjoinv(", ", (void *)blocker_features->pdata);
         error_setg(&n->migration_blocker,
-                   "Migration is not supported for %s", blocker_features);
+                   "Migration is not supported for %s", blocker_list);
         if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
             return false;
         }
-- 
2.53.0


