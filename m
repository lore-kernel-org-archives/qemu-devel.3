Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DDDC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaE1-0007lP-2f; Thu, 27 Feb 2025 04:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaDv-0007dP-8d; Thu, 27 Feb 2025 04:30:31 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaDs-0008En-UD; Thu, 27 Feb 2025 04:30:30 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id E86E01382F79;
 Thu, 27 Feb 2025 04:30:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 27 Feb 2025 04:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648627; x=
 1740735027; bh=71nKXCD5HsDTXriIYfUqdPCUY2WpZZReasEE7dQsRn0=; b=t
 2vOz4MlzB/lTMX8TkFXmLx4netKrImAkvFd22oO5ul6mt9kois3g+8Z2T+0PL+Un
 d80xfJabpPMk7ejjlVzFXkOtVM99x64akPIMkUKVB/eEM0GGwIGa1xIB+/e+Jx1J
 5x7iomzfsr+gW1rM1GBJgTqgmnWD7oz6ahV4XbF0cvX7zQ9ffut+KIq4DLVl2Ock
 9haISL8O9xu83sOWzf3EVdL9vIdDR8uX6Ths9e4MoG/XWvAjTD9kN/no9C+4kKHY
 V3ZMABimoug4oAw4Sa/idiKtv8wHIz+hNA1v94Jfd9vCT5I+MDpVAN0s2PQZYoYr
 gBNMLUqMCCKhO8F9InTCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648627; x=1740735027; bh=7
 1nKXCD5HsDTXriIYfUqdPCUY2WpZZReasEE7dQsRn0=; b=pFXbrCj9kJUJz2+BF
 NqWE4OdSb7yPuFhx10rqYHLjVyqgcDbRDSim8vY7EsttdxI0JlycmjqHm/JEHZ/Y
 fiLr5QzYDJVubo6A30rSYkHGScEJMQ4BipJjgJWeqZ+MwFLOIDQ73Kkv4yAhGnIP
 nfl5lpK20vS2tXNG+KuKeP0PGDo/QZF+4RQFEBaW6/rO+C8ZbsvWyFuVuhLjLC8t
 V/c+u4/eCWmn33Dp314ckb9J0yim2W2nv+IxP9SBpYqteQfcZXTy+shiwDhTG1YT
 BTOZ6a+LxTEVdw+eJ664Z7Pv3W4EBgoU9K02ZYKt23RkI3AmUAQ+dkk+VOmt5TuB
 xpAMA==
X-ME-Sender: <xms:szDAZ4H8RxUSHXS71CQHbq6Ve__wIL6SNu2hgzJcvvU44N3Apse9bQ>
 <xme:szDAZxWFZKnvCTGizX0TUM9FUkzdDuthHOTxUKk_E1Ch93axxpR4w01qvKlquIjdG
 o3ZV1wUlgyqIiBxTWY>
X-ME-Received: <xmr:szDAZyLgGUybwn4qY1-pSkAlYsl7HkBqlYWNsLN2YuEI-Kq06Q9TcqKsEH8QY-55mp8Uaio3RNYMGe716ZmO5m-m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhi
 nhgrrhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hmpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgs
 uhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrg
 hnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:szDAZ6FmngYCl-EUyAXFhc3fPf9llyVLbQ03qEP1btaeqvLthg-l8Q>
 <xmx:szDAZ-UcVpjBWnNcrTVpZjIUto6EeiCbhrYc7t7lvyAFQ1kY8zdqHg>
 <xmx:szDAZ9OnovTQ-8eoBe0uFQm8D_RtvRL5Z710_pAcXuhbIzcqvEXitQ>
 <xmx:szDAZ12YKm_o-RogISZ_w7VsPq--Ub29RU19uINZi6iNGqpGtJTu5A>
 <xmx:szDAZ5F-fetq_pwJ4YD_ERrtKJdQnzKL4sL-ASRGKnrHGlGipnFTQbhS>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:26 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 02/10] hw/nvme: always initialize a subsystem
Date: Thu, 27 Feb 2025 10:30:09 +0100
Message-ID: <20250227093018.11262-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

If no nvme-subsys is explicitly configured, instantiate one.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 36 +++++++++++++++-------------
 hw/nvme/ns.c   | 64 +++++++++++++++++---------------------------------
 2 files changed, 42 insertions(+), 58 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 11687e597a11..5a7ccbcc1b80 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8823,15 +8823,13 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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
@@ -8860,7 +8858,15 @@ static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
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
@@ -8950,17 +8956,15 @@ static void nvme_exit(PCIDevice *pci_dev)
 
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
index 410df2959192..94cabc6a5b8d 100644
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
 
 static const Property nvme_ns_props[] = {
-- 
2.47.2


