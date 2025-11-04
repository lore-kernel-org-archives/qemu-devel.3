Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7E7CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 10:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGEdv-0003kx-SB; Tue, 04 Nov 2025 05:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vGEdt-0003kk-VX; Tue, 04 Nov 2025 05:52:02 -0500
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vGEdr-0005pe-47; Tue, 04 Nov 2025 05:52:01 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A8D981400022;
 Tue,  4 Nov 2025 05:51:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 04 Nov 2025 05:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1762253516; x=
 1762339916; bh=K5aCI3Xv7R1iybktvtGITeilDNMWJW80tn1GvbngQjE=; b=g
 guwGUESmyV0brakBSjHbxoyJ/33+F5GsalTYr7YvH99/LVg51a+AZ0kp82uK6YcF
 oNz3qOu0Q/HmC/bC4Xj1sh52rB1JsrnBR9F/0yWHdaK4id4TRwU7frLZY4VPWi4R
 VITxOVqa0mDc45EY85wXQYqSA2wZhu7x+Fx+KQmYDe6dSASx3KkilQwukAMhwGjD
 m1Onr6v0A2S1Pm5Imds75jjGGoQbMz3mHpsaqCfAtydgnIuwOJ+QBMWobIFzzf4D
 UItO8Nz6i7vndA1611tsq/yB8vT8CR8WaThKmpbMsjl2F+xg7O+ndGl+AsvJfuVD
 kOtlEhgPRaLVHpL++a4GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1762253516; x=1762339916; bh=K5aCI3Xv7R1iybktvtGITeilDNMW
 JW80tn1GvbngQjE=; b=ExumnDEFv1dTi8qNM66iEC72GrIYHtdobkFG4vFlK5WF
 2GPtYtk5Er1luk8vAByaLe2/B6ZqB2kI80GEkvWBB16m+lZvdOVpYcIJfDs3IG66
 NzkVKwZ2QaN04u4o4KAWXYMvUKcH0n/y8eeulJH46CVA6iA3skHzIu7DHoqpyz3X
 z8uloU/yIFKDb1E5mqyVTK46pVwoKb3XTWV8i+cOlNsdBMb1g9gpKNzM2m9X7El5
 rMayByR5AtRi/c4uPxUb6JvkufANKQuvECvLLGNn2o7Fb1Uao6RWe6gC5tAoD00p
 amgla3P1SICU02zh7eVNZzB+QBnMwrHCSqav5b7sHw==
X-ME-Sender: <xms:y9oJaSUkg-hdED_V-aIhfx6QmwOIiS4eKBa_MsFqvgVeV7FwJnlwdg>
 <xme:y9oJaZjAm8lRpVa3FyzPnoURl37L83LMAO2RTZ97Kt-FBdOPyE98ir5fvY5S7pxqr
 YKmtKkQvIBr9GYo9SjZWUKJM-gUSWjiS3nsm6_ByTp-sKsC4zSm5DQ>
X-ME-Received: <xmr:y9oJaVYHgjBYWb2GEieOLnS6goa35Imh9-9yxAVUohl0D29DJGitPNGflG0q8MuYT8Rm7NlGwUVL4llKJGwBPfSy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpedtheevjeeihffggeeihfefheeuiefguefglefhtdffveehffekhfekgeetteffteen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgh
 dprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthho
 pehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfhhoshhsse
 guvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:y9oJaepnCtCzNoTJ6iaTN_EMsOLJyFqjOT53BostuDAbNiM3xBqdMQ>
 <xmx:y9oJaaNWxpChgN6EVZhF9sh0yRhscw17D_8iIrTaj_mCY0JrIRqkFA>
 <xmx:y9oJaZrDPJ2g4X5we4R5O-A9n7zAu95D_cRI6eBhXQWdTkQxeaWxiQ>
 <xmx:y9oJafd4SLAkwQ1ks8nzVIwU4Lc10gX5O7ApOichcLqyEodF9wLQ_Q>
 <xmx:zNoJaQ42Ga5E5iHHMiOwVRvC-6TM0xnWUmSLp1nbHoXZir0O33hi9Mtc>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 05:51:53 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 04 Nov 2025 11:51:45 +0100
Subject: [PATCH for-10.2] hw/nvme: fix namespace atomic parameter setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-nvme-fix-atomics-v1-1-fe13be5a8339@samsung.com>
X-B4-Tracking: v=1; b=H4sIAMDaCWkC/x2MQQqAMAzAviI9W2mHIvgV8TBd1R7cZBMRhn93e
 AwhyZAkqiQYqgxRbk0afAGuK1h26zdBdYXBkOmYqUV/H4KrPmivcOiS0DnqRTriubVQsjNK0f9
 yhDVEZGoMTO/7ARys17RsAAAA
X-Change-ID: 20251104-nvme-fix-atomics-dd07ee501b4a
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17005; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=1X1VLmfszRNHnf2nyhM2UfM9lIB1xkAPv2WyHENjROQ=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2tKMnNtUWplVThOaVFqNC9qLzdMSi9hUitGCnN3ZzIyMlU1SmhRUWFBQ3Bq
 MTc4R1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcENkckp
 BQW9KRUUzaHJ6RnRUdzNwZXQ0SC9qdVR6MURVMnJXNmNuWnhoOFU0MUpuL012VjlObjV3YTg5Ug
 p0dnZidkZNT050Qy80RXNjNXd3WEV4Qk5VbE9oaklxSUNkM3ZJb20yMEtDUDBtS3IxZ0k0Vmp5O
 GozTFNlTjRICmNQMldZLzd1QVFKbnRKOHA1Vk8yM0JrRmFiWDRybTFKa1pEMzUzTUlXU0dkZmhj
 b1JUZGxiV25GeUYxT2xPRUYKZHRWTTVzOW95V0JMMzVOMFQ5M2tQOUNpd3hLTDc5cjZQRTNaa29
 1SGdCd2U2VmYxYndqa2UvOHBTK3VHY1ZNVApCNmpPVmdLTnJJUUhJK2lWK3prUlk4b1NQb0hSa1
 M5MFc3TVBYaUdycTA3RnF0bndlNy84V1krNFhycjhya3N5CkdNM1QzSklOMEszc2E5bkdsWlc2e
 DhzbGhQSUsvZGhxSCs3NnZYdEVGY0MxRnIxQ1lpYW8zNi8yCj1rVktxCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-a5-smtp.messagingengine.com
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

Coverity complains about a possible copy-paste error in the verification
of the namespace atomic parameters (CID 1642811). While the check is
correct, the code (and the intention) is unclear.

Fix this by reworking how the parameters are verified. Peter also
identified that the realize function was not correctly erroring out if
parameters were misconfigured, so fix that too.

Lastly, change the error messages to be more describing.

Coverity: CID 1642811
Fixes: bce51b83709b ("hw/nvme: add atomic boundary support")
Fixes: 3b41acc96299 ("hw/nvme: enable ns atomic writes")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 115 +++++++++++++++----------------
 hw/nvme/ns.c         | 189 +++++++++++++++++++++++++++++++--------------------
 hw/nvme/nvme.h       |  25 ++++---
 include/block/nvme.h |   2 +-
 4 files changed, 185 insertions(+), 146 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4d150c7206ad..901d4d863355 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6524,6 +6524,53 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     return NVME_SUCCESS;
 }
 
+void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
+                                          uint16_t awupf, NvmeAtomic *atomic)
+{
+    atomic->atomic_max_write_size = (dn ? awupf : awun) + 1;
+
+    if (atomic->atomic_max_write_size > 1) {
+        atomic->atomic_writes = 1;
+    }
+}
+
+static uint16_t nvme_set_feature_write_atomicity(NvmeCtrl *n, NvmeRequest *req)
+{
+    NvmeCmd *cmd = &req->cmd;
+
+    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
+
+    uint16_t awun = le16_to_cpu(n->id_ctrl.awun);
+    uint16_t awupf = le16_to_cpu(n->id_ctrl.awupf);
+
+    n->dn = dw11 & 0x1;
+
+    nvme_atomic_configure_max_write_size(n->dn, awun, awupf, &n->atomic);
+
+    for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        uint16_t nawun, nawupf, nabsn, nabspf;
+
+        NvmeNamespace *ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+
+        nawun = le16_to_cpu(ns->id_ns.nawun);
+        nawupf = le16_to_cpu(ns->id_ns.nawupf);
+
+        nvme_atomic_configure_max_write_size(n->dn, nawun, nawupf,
+                                             &ns->atomic);
+
+        nabsn = le16_to_cpu(ns->id_ns.nabsn);
+        nabspf = le16_to_cpu(ns->id_ns.nabspf);
+
+        nvme_ns_atomic_configure_boundary(n->dn, nabsn, nabspf,
+                                          &ns->atomic);
+    }
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns = NULL;
@@ -6536,8 +6583,6 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t save = NVME_SETFEAT_SAVE(dw10);
     uint16_t status;
     int i;
-    NvmeIdCtrl *id = &n->id_ctrl;
-    NvmeAtomic *atomic = &n->atomic;
 
     trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
 
@@ -6691,50 +6736,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     case NVME_FDP_EVENTS:
         return nvme_set_feature_fdp_events(n, ns, req);
     case NVME_WRITE_ATOMICITY:
-
-        n->dn = 0x1 & dw11;
-
-        if (n->dn) {
-            atomic->atomic_max_write_size = le16_to_cpu(id->awupf) + 1;
-        } else {
-            atomic->atomic_max_write_size = le16_to_cpu(id->awun) + 1;
-        }
-
-        if (atomic->atomic_max_write_size == 1) {
-            atomic->atomic_writes = 0;
-        } else {
-            atomic->atomic_writes = 1;
-        }
-        for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-            ns = nvme_ns(n, i);
-            if (ns && ns->atomic.atomic_writes) {
-                if (n->dn) {
-                    ns->atomic.atomic_max_write_size =
-                        le16_to_cpu(ns->id_ns.nawupf) + 1;
-                    if (ns->id_ns.nabspf) {
-                        ns->atomic.atomic_boundary =
-                            le16_to_cpu(ns->id_ns.nabspf) + 1;
-                    } else {
-                        ns->atomic.atomic_boundary = 0;
-                    }
-                } else {
-                    ns->atomic.atomic_max_write_size =
-                        le16_to_cpu(ns->id_ns.nawun) + 1;
-                    if (ns->id_ns.nabsn) {
-                        ns->atomic.atomic_boundary =
-                            le16_to_cpu(ns->id_ns.nabsn) + 1;
-                    } else {
-                        ns->atomic.atomic_boundary = 0;
-                    }
-                }
-                if (ns->atomic.atomic_max_write_size == 1) {
-                    ns->atomic.atomic_writes = 0;
-                } else {
-                    ns->atomic.atomic_writes = 1;
-                }
-            }
-        }
-        break;
+        return nvme_set_feature_write_atomicity(n, req);
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -7669,6 +7671,10 @@ static int nvme_atomic_boundary_check(NvmeCtrl *n, NvmeCmd *cmd,
 
         imask = ~(atomic->atomic_boundary - 1);
         if ((slba & imask) != (elba & imask)) {
+            /*
+             * The write crosses an atomic boundary and the controller provides
+             * no atomicity guarantees unless AWUN/AWUPF are non-zero.
+             */
             if (n->atomic.atomic_max_write_size &&
                 ((nlb + 1) <= n->atomic.atomic_max_write_size)) {
                 return 1;
@@ -8709,7 +8715,6 @@ static void nvme_init_state(NvmeCtrl *n)
     NvmeSecCtrlEntry *list = n->sec_ctrl_list;
     NvmeSecCtrlEntry *sctrl;
     PCIDevice *pci = PCI_DEVICE(n);
-    NvmeAtomic *atomic = &n->atomic;
     NvmeIdCtrl *id = &n->id_ctrl;
     uint8_t max_vfs;
     int i;
@@ -8781,19 +8786,9 @@ static void nvme_init_state(NvmeCtrl *n)
             id->awupf = 0;
         }
 
-        if (n->dn) {
-            atomic->atomic_max_write_size = id->awupf + 1;
-        } else {
-            atomic->atomic_max_write_size = id->awun + 1;
-        }
-
-        if (atomic->atomic_max_write_size == 1) {
-            atomic->atomic_writes = 0;
-        } else {
-            atomic->atomic_writes = 1;
-        }
-        atomic->atomic_boundary = 0;
-        atomic->atomic_nabo = 0;
+        nvme_atomic_configure_max_write_size(n->dn, n->params.atomic_awun,
+                                             n->params.atomic_awupf,
+                                             &n->atomic);
     }
 }
 
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 86f5ab0a7572..253e7b406b4e 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -718,85 +718,119 @@ static void nvme_ns_unrealize(DeviceState *dev)
     nvme_ns_cleanup(ns);
 }
 
+void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
+                                       uint16_t nabspf, NvmeAtomic *atomic)
+{
+    atomic->atomic_boundary = dn ? nabspf : nabsn;
+
+    if (atomic->atomic_boundary > 0) {
+        atomic->atomic_boundary += 1;
+    }
+}
+
+static bool nvme_ns_set_nab(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdCtrl *id_ctrl = &n->id_ctrl;
+
+    uint16_t nabsn = ns->params.atomic.nabsn;
+    uint16_t nabspf = ns->params.atomic.nabspf;
+    uint16_t nabo = ns->params.atomic.nabo;
+
+    if (nabsn && nabsn < le16_to_cpu(id_ctrl->awun)) {
+        error_setg(errp, "nabsn must be greater than or equal to awun");
+        return false;
+    }
+
+    if (nabspf && nabspf < le16_to_cpu(id_ctrl->awupf)) {
+        error_setg(errp, "nabspf must be greater than or equal to awupf");
+        return false;
+    }
+
+    if (id_ns->nsfeat & NVME_ID_NS_NSFEAT_NSABP) {
+        if (nabsn && nabsn < le16_to_cpu(id_ns->nawun)) {
+            error_setg(errp, "nabsn must be greater than or equal to nawun");
+            return false;
+        }
+
+        if (nabspf && nabspf < le16_to_cpu(id_ns->nawupf)) {
+            error_setg(errp, "nabspf must be great than or equal to nawupf");
+            return false;
+        }
+    }
+
+    if (nabo && (nabo > nabsn || nabo > nabspf)) {
+        error_setg(errp, "nabo must be less than or equal to nabsn and nabspf");
+        return false;
+    }
+
+    id_ns->nabsn = cpu_to_le16(nabsn);
+    id_ns->nabspf = cpu_to_le16(nabspf);
+    id_ns->nabo = cpu_to_le16(nabo);
+
+    ns->atomic.atomic_nabo = nabo;
+
+    nvme_ns_atomic_configure_boundary(n->dn, nabsn, nabspf, &ns->atomic);
+
+    return true;
+}
+
+static bool nvme_ns_set_nsabp(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
+{
+    NvmeIdNs *id_ns = &ns->id_ns;
+    NvmeIdCtrl *id_ctrl = &n->id_ctrl;
+
+    uint16_t awun = le16_to_cpu(id_ctrl->awun);
+    uint16_t awupf = le16_to_cpu(id_ctrl->awupf);
+
+    uint16_t nawun = ns->params.atomic.nawun;
+    uint16_t nawupf = ns->params.atomic.nawupf;
+
+    if (nawupf > nawun) {
+        if (nawun == 0) {
+            nawun = nawupf;
+        } else {
+            error_setg(errp, "nawupf must be less than or equal to nawun");
+            return false;
+        }
+    }
+
+    /* neither nawun or nawupf is set */
+    if (nawun == 0) {
+        return true;
+    }
+
+    if (nawun < awun) {
+        error_setg(errp, "nawun must be greater than or equal to awun");
+        return false;
+    }
+
+    if (nawupf < awupf) {
+        error_setg(errp, "nawupf must be greater than or equal to awupf");
+        return false;
+    }
+
+    id_ns->nsfeat |= NVME_ID_NS_NSFEAT_NSABP;
+
+    id_ns->nawun = cpu_to_le16(nawun);
+    id_ns->nawupf = cpu_to_le16(nawupf);
+
+    nvme_atomic_configure_max_write_size(n->dn, nawun, nawupf, &ns->atomic);
+
+    return true;
+}
+
 static void nvme_ns_realize(DeviceState *dev, Error **errp)
 {
     NvmeNamespace *ns = NVME_NS(dev);
     BusState *s = qdev_get_parent_bus(dev);
     NvmeCtrl *n = NVME(s->parent);
     NvmeSubsystem *subsys = n->subsys;
-    NvmeIdCtrl *id = &n->id_ctrl;
-    NvmeIdNs *id_ns = &ns->id_ns;
     uint32_t nsid = ns->params.nsid;
     int i;
 
     assert(subsys);
 
-    /* Set atomic write parameters */
-    if (ns->params.atomic_nsfeat) {
-        id_ns->nsfeat |= NVME_ID_NS_NSFEAT_NSABPNS;
-        id_ns->nawun = cpu_to_le16(ns->params.atomic_nawun);
-        if (!id->awupf || (id_ns->nawun && (id_ns->nawun < id->awun))) {
-            error_report("Invalid NAWUN: %x AWUN=%x", id_ns->nawun, id->awun);
-        }
-        id_ns->nawupf = cpu_to_le16(ns->params.atomic_nawupf);
-        if (!id->awupf || (id_ns->nawupf && (id_ns->nawupf < id->awupf))) {
-            error_report("Invalid NAWUPF: %x AWUPF=%x",
-                id_ns->nawupf, id->awupf);
-        }
-        if (id_ns->nawupf > id_ns->nawun) {
-            error_report("Invalid: NAWUN=%x NAWUPF=%x",
-                id_ns->nawun, id_ns->nawupf);
-        }
-        id_ns->nabsn = cpu_to_le16(ns->params.atomic_nabsn);
-        id_ns->nabspf = cpu_to_le16(ns->params.atomic_nabspf);
-        id_ns->nabo = cpu_to_le16(ns->params.atomic_nabo);
-        if (!id->awun || (id_ns->nabsn && ((id_ns->nabsn < id_ns->nawun) ||
-            (id_ns->nabsn < id->awun)))) {
-            error_report("Invalid NABSN: %x NAWUN=%x AWUN=%x",
-                id_ns->nabsn, id_ns->nawun, id->awun);
-        }
-        if (!id->awupf || (id_ns->nabspf && ((id_ns->nabspf < id_ns->nawupf) ||
-            (id_ns->nawupf < id->awupf)))) {
-            error_report("Invalid NABSPF: %x NAWUPF=%x AWUPF=%x",
-                id_ns->nabspf, id_ns->nawupf, id->awupf);
-        }
-        if (id_ns->nabo && ((id_ns->nabo > id_ns->nabsn) ||
-            (id_ns->nabo > id_ns->nabspf))) {
-            error_report("Invalid NABO: %x NABSN=%x NABSPF=%x",
-                id_ns->nabo, id_ns->nabsn, id_ns->nabspf);
-        }
-        if (id_ns->nawupf > id_ns->nawun) {
-            error_report("Invalid: NAWUN=%x NAWUPF=%x", id_ns->nawun,
-                id_ns->nawupf);
-        }
-    }
-
-    if (id_ns->nawun || id_ns->nawupf) {
-        NvmeAtomic *atomic = &ns->atomic;
-
-        if (n->dn) {
-            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawupf) + 1;
-            if (id_ns->nabspf) {
-                atomic->atomic_boundary = cpu_to_le16(id_ns->nabspf) + 1;
-            } else {
-                atomic->atomic_boundary = 0;
-            }
-        } else {
-            atomic->atomic_max_write_size = cpu_to_le16(id_ns->nawun) + 1;
-            if (id_ns->nabsn) {
-                atomic->atomic_boundary = cpu_to_le16(id_ns->nabsn) + 1;
-            } else {
-                atomic->atomic_boundary = 0;
-            }
-        }
-        if (atomic->atomic_max_write_size == 1) {
-            atomic->atomic_writes = 0;
-        } else {
-            atomic->atomic_writes = 1;
-        }
-        atomic->atomic_nabo = cpu_to_le16(id_ns->nabo);
-    }
-
     /* reparent to subsystem bus */
     if (!qdev_set_parent_bus(dev, &subsys->bus.parent_bus, errp)) {
         return;
@@ -804,6 +838,14 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     ns->subsys = subsys;
     ns->endgrp = &subsys->endgrp;
 
+    if (!nvme_ns_set_nsabp(n, ns, errp)) {
+        return;
+    }
+
+    if (!nvme_ns_set_nab(n, ns, errp)) {
+        return;
+    }
+
     if (nvme_ns_setup(ns, errp)) {
         return;
     }
@@ -872,12 +914,11 @@ static const Property nvme_ns_props[] = {
     DEFINE_PROP_BOOL("eui64-default", NvmeNamespace, params.eui64_default,
                      false),
     DEFINE_PROP_STRING("fdp.ruhs", NvmeNamespace, params.fdp.ruhs),
-    DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic_nawun, 0),
-    DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic_nawupf, 0),
-    DEFINE_PROP_UINT16("atomic.nabspf", NvmeNamespace, params.atomic_nabspf, 0),
-    DEFINE_PROP_UINT16("atomic.nabsn", NvmeNamespace, params.atomic_nabsn, 0),
-    DEFINE_PROP_UINT16("atomic.nabo", NvmeNamespace, params.atomic_nabo, 0),
-    DEFINE_PROP_BOOL("atomic.nsfeat", NvmeNamespace, params.atomic_nsfeat, 0),
+    DEFINE_PROP_UINT16("atomic.nawun", NvmeNamespace, params.atomic.nawun, 0),
+    DEFINE_PROP_UINT16("atomic.nawupf", NvmeNamespace, params.atomic.nawupf, 0),
+    DEFINE_PROP_UINT16("atomic.nabsn", NvmeNamespace, params.atomic.nabsn, 0),
+    DEFINE_PROP_UINT16("atomic.nabspf", NvmeNamespace, params.atomic.nabspf, 0),
+    DEFINE_PROP_UINT16("atomic.nabo", NvmeNamespace, params.atomic.nabo, 0),
 };
 
 static void nvme_ns_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index a7d225d2d80b..8f8c78c85036 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -218,12 +218,14 @@ typedef struct NvmeNamespaceParams {
     struct {
         char *ruhs;
     } fdp;
-    uint16_t atomic_nawun;
-    uint16_t atomic_nawupf;
-    uint16_t atomic_nabsn;
-    uint16_t atomic_nabspf;
-    uint16_t atomic_nabo;
-    bool     atomic_nsfeat;
+
+    struct {
+        uint16_t nawun;
+        uint16_t nawupf;
+        uint16_t nabsn;
+        uint16_t nabspf;
+        uint16_t nabo;
+    } atomic;
 } NvmeNamespaceParams;
 
 typedef struct NvmeAtomic {
@@ -288,11 +290,7 @@ typedef struct NvmeNamespace {
         /* reclaim unit handle identifiers indexed by placement handle */
         uint16_t *phs;
     } fdp;
-    uint16_t  atomic_nawun;
-    uint16_t  atomic_nawupf;
-    uint16_t  atomic_nabsn;
-    uint16_t  atomic_nabspf;
-    uint16_t  atomic_nabo;
+
     NvmeAtomic  atomic;
 } NvmeNamespace;
 
@@ -742,4 +740,9 @@ void nvme_rw_complete_cb(void *opaque, int ret);
 uint16_t nvme_map_dptr(NvmeCtrl *n, NvmeSg *sg, size_t len,
                        NvmeCmd *cmd);
 
+void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
+                                          uint16_t awupf, NvmeAtomic *atomic);
+void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
+                                       uint16_t nabspf, NvmeAtomic *atomic);
+
 #endif /* HW_NVME_NVME_H */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9fa2ecaf281c..8640dfa8269f 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1589,7 +1589,7 @@ enum NvmeIdNsMc {
 
 enum NvmeIdNsNsfeat {
     NVME_ID_NS_NSFEAT_THINP         = 1 << 0,
-    NVME_ID_NS_NSFEAT_NSABPNS       = 1 << 1,
+    NVME_ID_NS_NSFEAT_NSABP         = 1 << 1,
     NVME_ID_NS_NSFEAT_DAE           = 1 << 2,
     NVME_ID_NS_NSFEAT_UIDREUSE      = 1 << 3,
     NVME_ID_NS_NSFEAT_OPTPERF_ALL   = 3 << 4,

---
base-commit: a8e63c013016f9ff981689189c5b063551d04559
change-id: 20251104-nvme-fix-atomics-dd07ee501b4a

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


