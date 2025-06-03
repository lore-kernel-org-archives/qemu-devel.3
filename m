Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A67C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRFU-0000M1-59; Tue, 03 Jun 2025 09:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMREr-0008Ff-3H; Tue, 03 Jun 2025 08:59:34 -0400
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uMREg-0003Th-M5; Tue, 03 Jun 2025 08:59:24 -0400
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id DCA881140115;
 Tue,  3 Jun 2025 08:59:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 03 Jun 2025 08:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1748955558; x=1749041958; bh=thymeK7c1mvZgZPPEew359m0shfKHaZX
 O1HiLDjnKAU=; b=DsjFrxUmtfSifVoLK3HQ9bKEtfA3fmzM7v03m/8w5MDAqL0v
 oz14A77aFX3DvQaDvZH3XWsbXWiVYQr0gef6MgS4VM3553rWICaFqYK1G0A8z6zs
 QKhPdlgOFFOzQWK1mb2gI28ZSBpI3VIlWNNqNBXPrdptjzctlw7FibtAfGHbeZJB
 FqejhVj+0Ez7N4xaXKaz/kTRSIV7UM2Hr19Es8PmLD/Es3zBJqQCRfWMmGHCZeCb
 /PyKDPTeadF+MUxRxe+1kxc340cmo/+1cdZ7x4QVlYCl/Xzg2ftAyDuwuZAWQrM0
 Nm+jz1DwrANXVEGYqHrO7NIxEUsoJwMLZboCvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748955558; x=
 1749041958; bh=thymeK7c1mvZgZPPEew359m0shfKHaZXO1HiLDjnKAU=; b=E
 n/TuCBNC4UjDA+OYvZHCyVPCD3weMroe3HhGuvBXlICjXV/uwegMTtWi6LEZXdmt
 rrIu9vW9Spcn4kxBZNNYGE8tXT9LkTtg2WoZ6mzb+G7BX6f3pbR/8V619v+SzFp5
 S5ujL786tbzQhfP/7dSz3q5hOWgxaHoBGbHMGKQ1z3Xz6fY/oy9vxptLcoel5bKY
 APMnQZyHqennklN8BAYjX4FRaubvOChoB4Xdt2HWA7VbScrvF7pLRrqek9Xuj0M8
 KFdis+4+Zucxwd5E/d2D23wNaTxJ+S85lFrI61ji0YevOWGyPR1Wr70QVTQToQMm
 JZyp9IqO8JHwYKU7cacwA==
X-ME-Sender: <xms:pvE-aNQxuzcHB6MIelptiqjG6dkP9smeGDGvwxr9_nDHwa2EJyLf7g>
 <xme:pvE-aGzL3vjqSmbhkl5XQbHq1cHIGX7Nv5A1yOFj4HiXqOA3J4GFiTrHIzi7E0Ouh
 E2auMTao5DjahFWdrU>
X-ME-Received: <xmr:pvE-aC39j0jQmStNW5bFVGxLwtywvP5Fc4XjMlBh7JN7Zl-XYEzWFdK6cYlGdJS65XdL7fo1urLUmdMFZ77PSzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlse
 hnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtth
 hopegrlhgrnhdrrggurghmshhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepkhdr
 jhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepfhhoshhsseguvghfmh
 grtghrohdrihhtpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pvE-aFCmJPNAxeQdaldLWt_IWa77qd_Swwr5Xy8gOkwlulxLlY9EKw>
 <xmx:pvE-aGh0CmJLS3l2veSzoNra7q9Vm6teJTrya5NGSEaSp46F04WaWQ>
 <xmx:pvE-aJqczyNwSW2iB1setf4bawavE-Q2C_BhAkt5a1heDod78dCJtw>
 <xmx:pvE-aBibrSIhrj8yy3HT_RfPSACXwx9OyD7G5iSGmFjGLueJi9Be2A>
 <xmx:pvE-aLR_u06L24weNuvsFeb7Psj8nFe4qNH7IpoVuJmtEHzuAPorDEB8>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 08:59:17 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 03 Jun 2025 14:59:06 +0200
Subject: [PATCH 2/2] hw/nvme: revert CMIC behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-nvme-fixes-v1-2-01d67258ffca@samsung.com>
References: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
In-Reply-To: <20250603-nvme-fixes-v1-0-01d67258ffca@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, 
 Alan Adamson <alan.adamson@oracle.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=sfVJrKEZ5+//8Wz3ktwFZCgoW22WpBDfS1jRpDHzq4o=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2crOGFDS2tHcklZRXA4QnNiZlprNWpVMHgvCldaN1AxQURPMU93UlptSDRD
 TTdHOUlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKb1B2R2d
 BQW9KRUUzaHJ6RnRUdzNwZFFzSCtnUDYwamhNQkpDZEx6QllCMzdJTGRqMGVqdk1SMEFGMVdpTg
 pTRHd4Qk5LMFlvdGxUQ3E2VzZCRXl0aGtvWERoc2VodjFiK0FqTkpoWVc5V3JabnczMTk3cFZQe
 kZ3a0I2TnF0CjRBRU5hdURyRTQwZ0RRMVNYT010dGJreDRaRkFxSzQyU2Zwczdrdlc5N1Y3Uk54
 N1QvYjZFVkgzU1FVNXdhbHgKWU8vQk8xR3JjT3FnbmxFTjF1RmUrMVhBNW8vTm82QmxSVnUzY1Z
 vOWRvZktERDB0V1BZMklnem1zazRXcmwycwo3NEt4c08zNnVnNWxhbFBzVDdvTGIrN2FVR09CUH
 MxQjFWdjhLNnpTVnFjRjBRU0twMG9zS3VsMm5GemVnYWxjCmxZK2VTWGJuSlJ0T3kzWUxkaG9aY
 jE1UC9UVEdEV2E1ZTNFN25xM2VXaUM0cFhDRzdGUjJuS3dKCj1RKzdWCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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

Commit cd59f50ab017 ("hw/nvme: always initialize a subsystem") causes
the controller to always set the CMIC.MCTRS ("Multiple Controllers")
bit. While spec-compliant, this is a deviation from the previous
behavior where this was only set if an nvme-subsys device was explicitly
created (to configure a subsystem with multiple controllers/namespaces).

Revert the behavior to only set CMIC.MCTRS if an nvme-subsys device is
created explicitly.

Reported-by: Alan Adamson <alan.adamson@oracle.com>
Fixes: cd59f50ab017 ("hw/nvme: always initialize a subsystem")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8de900ef8aca9b510b072892f9f82c01acee4f7d..0637e29ec9fdcfe65a97b8bdcff7851091096d44 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8780,7 +8780,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint8_t *pci_conf = pci_dev->config;
     uint64_t cap = ldq_le_p(&n->bar.cap);
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
-    uint32_t ctratt;
+    uint32_t ctratt = le32_to_cpu(id->ctratt);
     uint16_t oacs;
 
     memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
@@ -8798,10 +8798,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
 
-    ctratt = NVME_CTRATT_ELBAS;
+    ctratt |= NVME_CTRATT_ELBAS;
     if (n->params.ctratt.mem) {
         ctratt |= NVME_CTRATT_MEM;
     }
+    id->ctratt = cpu_to_le32(ctratt);
 
     id->rab = 6;
 
@@ -8884,17 +8885,6 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
 
-    id->cmic |= NVME_CMIC_MULTI_CTRL;
-    ctratt |= NVME_CTRATT_ENDGRPS;
-
-    id->endgidmax = cpu_to_le16(0x1);
-
-    if (n->subsys->endgrp.fdp.enabled) {
-        ctratt |= NVME_CTRATT_FDPS;
-    }
-
-    id->ctratt = cpu_to_le32(ctratt);
-
     NVME_CAP_SET_MQES(cap, n->params.mqes);
     NVME_CAP_SET_CQR(cap, 1);
     NVME_CAP_SET_TO(cap, 0xf);
@@ -8927,6 +8917,20 @@ static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
         }
 
         n->subsys = NVME_SUBSYS(dev);
+    } else {
+        NvmeIdCtrl *id = &n->id_ctrl;
+        uint32_t ctratt = le32_to_cpu(id->ctratt);
+
+        id->cmic |= NVME_CMIC_MULTI_CTRL;
+        ctratt |= NVME_CTRATT_ENDGRPS;
+
+        id->endgidmax = cpu_to_le16(0x1);
+
+        if (n->subsys->endgrp.fdp.enabled) {
+            ctratt |= NVME_CTRATT_FDPS;
+        }
+
+        id->ctratt = cpu_to_le32(ctratt);
     }
 
     cntlid = nvme_subsys_register_ctrl(n, errp);

-- 
2.47.2


