Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE382E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAbp-0006XT-DT; Mon, 16 Dec 2024 07:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbl-0006Sc-Fo; Mon, 16 Dec 2024 07:53:58 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbj-0004pS-7M; Mon, 16 Dec 2024 07:53:57 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6807A254015A;
 Mon, 16 Dec 2024 07:53:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 07:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353632; x=1734440032; bh=pmWWCm3m8jeU1oMs4H2oiEOb++we7L+n
 lOhbpCWCeNo=; b=IX8KlVS6CuqL7wF9QdlCow42LyHVQO+2jWtG6IFnwLhrUKq1
 +rJ0fzriHWbZXPIaEGBCtRzc+q1YnKKf4YA1oSPYYGIDn4cOe8l1gAVT9c/uvVRL
 VMHwIdvNOpf9//wyeFCvTzIJ9kij0g8Yuw/L5tAMxem7yKQcN1hZghNCYAia4DCx
 mQaL/bg5a31f6/8lS9OERx9pK18a3rdvzawSB1TMRh1VVFg6yqom2H+aJIJ9eCT7
 KgWFh0NCs1tXOPwgmfd32vXZJ6RlgfVEiOmImffIlgE9PgHaSoA8QSRwph8C+Oal
 RPgXKWnRqj+reTbzwnzb+9Vmd6cNLqhcE2L3Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353632; x=
 1734440032; bh=pmWWCm3m8jeU1oMs4H2oiEOb++we7L+nlOhbpCWCeNo=; b=w
 82YFqCATjQs3a+j6kjYHZeFJkxXp3CVCFV9NJNmgpcE5xPxN+BM/Eh2hZPpPrAlZ
 XHZ5ZseXD63IFl/hGwlPtqavGAloW5cb+wLyf4m9jgulnTD1EU1RGa7g/oqy9osh
 qvHXfs5SnpiWMx6EJWeaHx05Tgp4pHUUwXI25XgCaTm60e8K74kJR2j8O5O/Iz93
 kHSkARKQ4WLVdFnUUMuCh8XX3Zi/4OoaCXXj4v4F3IgYeCgNLOLwIPZcXC4xuNP+
 QM0Snh/ulQfyMewMFz2/GSH89tNT7JdsWa+frEpQnBbF2jpSWyQGOCUuUgCfcv5I
 T2YdfJPv4fEBbzCswLEdw==
X-ME-Sender: <xms:3yJgZ6hc-N22J76uc5zrYeixOhv9twbYdHPt1FfB-Ql2YwI8P0JaSw>
 <xme:3yJgZ7B_1AjdhVgfK9xuZxrrUhVJ-pjZQ60ySGz_Tw115TO1EUZVew80mP71dWXPV
 LpxdeQuMAtuYNkwtC8>
X-ME-Received: <xmr:3yJgZyHW0vqmh7Cf1yf6wFUAFZtY9O8jzD1Sd3XCVWDdRfAINkIxI5Wc3yx07snebMSK5bqwR_hzix5IMc6sMAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:3yJgZzQ-doHcNLusPEem7XvkTHdZby7z4c5q-9-iPpHBwjC29KOQOA>
 <xmx:3yJgZ3z4bgfeeKQ1FSt7Q8s3njbOPqt4T34WogNQQyX2DGCSrMHpwQ>
 <xmx:3yJgZx7RtfgvjmtB_wr4zx5jjyxqmE8_7W268mOfRaGoN8cdbAafWQ>
 <xmx:3yJgZ0yPkH0eL-PX7LYpEsL0jJFYdtIo2b7Y-b9J6GKHh1BvTMrljg>
 <xmx:4CJgZ-k7VvQVA-9UbEdXL9DXMy3-v8QUFfwLBtA90-rCW2B3LCu6ZCmu>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:53:50 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:02 +0100
Subject: [PATCH 1/9] hw/nvme: always initialize a subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-1-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5512; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=tJcP0mdagt+ZzbYB8t7jIv/wqlWN9cCEPZnTndma+9E=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRqdmI3eFBFWmhoRzYvOWlaMnJTSkN3CmFHSHlCMjZlN2xlNTkvZ2hX
 Ry9RUzRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTFl
 BQW9KRUUzaHJ6RnRUdzNwRm9RSC8yM2t6MXBGRjRvVWNZNTl1QkdTQUJzSVlSd3BhcGlMem11Vg
 pJNHZGYytKS1lMNmRJVFhUd3l2bFF2a09MR0tNd3Jwb21uK2YwQUlVQkVWbzBOUnU5S0Z6U0VSZ
 3JPbnVINzdMClU0dFNHV3E4MG1hRUp4bnNHUzF1SUN5WWZRZy9vMXFHSHBmQytFdG4vOUEwQnVV
 UmZEbzhTNTJnSkVnVWZEb0EKaUdkaVdvdUVsb0hkaXlDQU14MkcyK0M0STRGRGl0SWp6VHhwTzl
 pVi9pcFZzUG9ocnVhSG9CRVMrTnVlUlh5UgpWYUJCQWQzd3lpL01pSCtUdEkzeEpmMzRaSHN3UH
 hXUmF5UzQyVzJHRkZYelgxR2Y4UFoxUEh4NzBFR1J6cTZBCno2UnBVNVV5SVgzRll2NkUyVmVye
 Wh0aXhZdUN4bG0va2xFWEF4SUhWbXZWU05qTzIzU2lmcWFWCj1ZOE5OCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

If no nvme-subsys is explicitly configured, instantiate one.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 36 ++++++++++++++++++---------------
 hw/nvme/ns.c   | 64 ++++++++++++++++++++--------------------------------------
 2 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ec754195669598082dd573ff1237dbbfb9b8aff5..e1d54ee34d2cd073821ac398bc5b4a51cb79e0e9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8759,15 +8759,13 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
 
-    if (n->subsys) {
-        id->cmic |= NVME_CMIC_MULTI_CTRL;
-        ctratt |= NVME_CTRATT_ENDGRPS;
+    id->cmic |= NVME_CMIC_MULTI_CTRL;
+    ctratt |= NVME_CTRATT_ENDGRPS;
 
-        id->endgidmax = cpu_to_le16(0x1);
+    id->endgidmax = cpu_to_le16(0x1);
 
-        if (n->subsys->endgrp.fdp.enabled) {
-            ctratt |= NVME_CTRATT_FDPS;
-        }
+    if (n->subsys->endgrp.fdp.enabled) {
+        ctratt |= NVME_CTRATT_FDPS;
     }
 
     id->ctratt = cpu_to_le32(ctratt);
@@ -8796,7 +8794,15 @@ static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
     int cntlid;
 
     if (!n->subsys) {
-        return 0;
+        DeviceState *dev = qdev_new(TYPE_NVME_SUBSYS);
+
+        qdev_prop_set_string(dev, "nqn", n->params.serial);
+
+        if (!qdev_realize(dev, NULL, errp)) {
+            return -1;
+        }
+
+        n->subsys = NVME_SUBSYS(dev);
     }
 
     cntlid = nvme_subsys_register_ctrl(n, errp);
@@ -8886,17 +8892,15 @@ static void nvme_exit(PCIDevice *pci_dev)
 
     nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
 
-    if (n->subsys) {
-        for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-            ns = nvme_ns(n, i);
-            if (ns) {
-                ns->attached--;
-            }
+    for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
+        ns = nvme_ns(n, i);
+        if (ns) {
+            ns->attached--;
         }
-
-        nvme_subsys_unregister_ctrl(n->subsys, n);
     }
 
+    nvme_subsys_unregister_ctrl(n->subsys, n);
+
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 526e15aa80187b82f9622445849b03fd472da8df..3be43503c50798db0ab528fe30ad901bb6aa9db3 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -727,25 +727,14 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
     uint32_t nsid = ns->params.nsid;
     int i;
 
-    if (!n->subsys) {
-        /* If no subsys, the ns cannot be attached to more than one ctrl. */
-        ns->params.shared = false;
-        if (ns->params.detached) {
-            error_setg(errp, "detached requires that the nvme device is "
-                       "linked to an nvme-subsys device");
-            return;
-        }
-    } else {
-        /*
-         * If this namespace belongs to a subsystem (through a link on the
-         * controller device), reparent the device.
-         */
-        if (!qdev_set_parent_bus(dev, &subsys->bus.parent_bus, errp)) {
-            return;
-        }
-        ns->subsys = subsys;
-        ns->endgrp = &subsys->endgrp;
+    assert(subsys);
+
+    /* reparent to subsystem bus */
+    if (!qdev_set_parent_bus(dev, &subsys->bus.parent_bus, errp)) {
+        return;
     }
+    ns->subsys = subsys;
+    ns->endgrp = &subsys->endgrp;
 
     if (nvme_ns_setup(ns, errp)) {
         return;
@@ -753,7 +742,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
     if (!nsid) {
         for (i = 1; i <= NVME_MAX_NAMESPACES; i++) {
-            if (nvme_ns(n, i) || nvme_subsys_ns(subsys, i)) {
+            if (nvme_subsys_ns(subsys, i)) {
                 continue;
             }
 
@@ -765,38 +754,29 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "no free namespace id");
             return;
         }
-    } else {
-        if (nvme_ns(n, nsid) || nvme_subsys_ns(subsys, nsid)) {
-            error_setg(errp, "namespace id '%d' already allocated", nsid);
-            return;
-        }
+    } else if (nvme_subsys_ns(subsys, nsid)) {
+        error_setg(errp, "namespace id '%d' already allocated", nsid);
+        return;
     }
 
-    if (subsys) {
-        subsys->namespaces[nsid] = ns;
+    subsys->namespaces[nsid] = ns;
 
-        ns->id_ns.endgid = cpu_to_le16(0x1);
-        ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
+    ns->id_ns.endgid = cpu_to_le16(0x1);
+    ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
 
-        if (ns->params.detached) {
-            return;
-        }
+    if (ns->params.detached) {
+        return;
+    }
 
-        if (ns->params.shared) {
-            for (i = 0; i < ARRAY_SIZE(subsys->ctrls); i++) {
-                NvmeCtrl *ctrl = subsys->ctrls[i];
+    if (ns->params.shared) {
+        for (i = 0; i < ARRAY_SIZE(subsys->ctrls); i++) {
+            NvmeCtrl *ctrl = subsys->ctrls[i];
 
-                if (ctrl && ctrl != SUBSYS_SLOT_RSVD) {
-                    nvme_attach_ns(ctrl, ns);
-                }
+            if (ctrl && ctrl != SUBSYS_SLOT_RSVD) {
+                nvme_attach_ns(ctrl, ns);
             }
-
-            return;
         }
-
     }
-
-    nvme_attach_ns(n, ns);
 }
 
 static Property nvme_ns_props[] = {

-- 
2.45.2


