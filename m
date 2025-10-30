Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F062FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEN7g-000377-On; Thu, 30 Oct 2025 03:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN7N-0002ru-3y; Thu, 30 Oct 2025 03:30:49 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1vEN7D-00053m-Bp; Thu, 30 Oct 2025 03:30:43 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 568D6EC01C6;
 Thu, 30 Oct 2025 03:30:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 03:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1761809428; x=
 1761895828; bh=KhorpwEocnvX4t05YmWp1XsrdvahA+RzlOhcQFSb+fs=; b=A
 3kz80Vwh1h2aqPi/V4cGy8i9f7d9FDLym4Kxqe34F+tdwAd2KdCmDo+6pK09oQcB
 MINupweqRNOjfUln0IATJRCWWfxWQboUvOfAIkaeRaupjFs18dPVw9booXOifR7h
 5FbOcOHejkrMnWB7SoxcURFfHrrRpJ/VbIFmXN1azx+ybxi+QWMglUpvJlZilfWQ
 t0WUmGPt3Z99S0aOtpL8Yk/Sfcs5ooKnjFZKy2XG1sIneeSyQCnGmTbAbl9VEznr
 SRzvcEJTWKSLbTGvGXC6ox3bio9HG5Emewz7f9ubOq8UWcBHrZEF7KdXZZ8FOoGR
 2fpsNtL3jA0CcOh6uMeOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1761809428; x=1761895828; bh=K
 horpwEocnvX4t05YmWp1XsrdvahA+RzlOhcQFSb+fs=; b=NB4dnymwaZDC1JrMl
 7fekvYaNP0Tw7Xt3h9dWnXa0kHXlqvxm+DFW38LFgOqCW2+ud6UmmiB22t2YCDOW
 UBt6s4jS1zdSJKos43PEZdKD6OWvCW4pE90u7dwWf3xn1E6V/mczlIvBjpzYPku7
 s3CvqR0daQ8lAkuWnkVdNzCdJI/hIRGsdx4OZq+UwyYebEF+Cw6No8M+4gRGHkI0
 3H41BgA1slftJlALSM/Sg3O+6/P9rtcZnIktEHynt3ldgRALSDhYCToyHv0iXGJv
 r/wPLKgH7dvk+37x7YzbvJwgYZpiDfBCZ9eIO783YuSDoovFTTx8lNqISfwa01y+
 QQp7g==
X-ME-Sender: <xms:ExQDaTKLLOKlXpTFjZPA4q8tXZ51TT1rzyhxL8eWg4O5ygQCKDqMUQ>
 <xme:ExQDaTADA_dfU7gCvtNcqEaT9JbIaPFjIE49L1xvQQB4aGIFQmzE8_7KdJF8AqbuJ
 dCQTY1Znd40tuX1nzjaEW1W2ddoAO9sEXHrAr19ijuqfFZ9-MiJew>
X-ME-Received: <xmr:ExQDaYuWMEFPaS8ZvFAxJbdUVSXdyf5UO2Dbt_PPAelp515KvyXnMGtkPz6zDUNE7jpU95xAYClCwbBRVzzGN-a8esfipUELb2xCvxI9vES2GbpPIzjpcB7v2uBfcgMbBx1jpow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnheptdeuhedvueegtdettdevudefleejudefteeitdffheegveehfeeiueevkedtleeu
 necuffhomhgrihhnpegumhhtfhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggp
 rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqd
 guvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggv
 lhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopeifihhlfhhrvggurdhmrghllhgrfi
 grseifuggtrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehh
 uhgrfigvihdrtghomhdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomhdp
 rhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhho
 rdhith
X-ME-Proxy: <xmx:ExQDaRRmRnjH8XADM8Vw3tK6Uw9yhYERi09glm0HeouR49Prll-K2A>
 <xmx:ExQDafKncLDuKieRm5Bfv07t-_E4DAZYCOi_j4KIi8aSLiYGUpgMFA>
 <xmx:ExQDaUsroTgFY7D9jQ5kHrHv2UxcBUrD9h2rMzNx2qMQQ2qWICTyWw>
 <xmx:ExQDaW9nMyN72OuH4os9HbExMoz7SSmQihJWfb3pCG8RyomOG2pKtg>
 <xmx:FBQDaeB5NVIf0Sv-UkPCWMFUVRHHzYzvQkcn7BrjkEUN5CujwHqNoc-1>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:30:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 5/7] hw/nvme: connect SPDM over NVMe Security Send/Recv
Date: Thu, 30 Oct 2025 08:29:53 +0100
Message-ID: <20251030072956.1194-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030072956.1194-1-its@irrelevant.dk>
References: <20251030072956.1194-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This patch extends the existing support we have for NVMe with only DoE
to also add support to SPDM over the NVMe Security Send/Recv commands.

With the new definition of the `spdm-trans` argument, users can specify
`spdm_trans=nvme` or `spdm_trans=doe`. This allows us to select the SPDM
transport respectively. SPDM over the NVMe Security Send/Recv commands
are defined in the DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
[k.jensen: fix declaration in case statement; fix quotes in docs]
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/specs/spdm.rst         | 10 ++++++--
 hw/nvme/ctrl.c              | 47 ++++++++++++++++++++++++++++---------
 include/hw/pci/pci_device.h |  2 ++
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/docs/specs/spdm.rst b/docs/specs/spdm.rst
index 0e3ad25bc698..477ff9ef36c7 100644
--- a/docs/specs/spdm.rst
+++ b/docs/specs/spdm.rst
@@ -98,7 +98,7 @@ Then you can add this to your QEMU command line:
 .. code-block:: shell
 
     -drive file=blknvme,if=none,id=mynvme,format=raw \
-        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe
 
 At which point QEMU will try to connect to the SPDM server.
 
@@ -113,7 +113,13 @@ of the default. So the entire QEMU command might look like this
         -append "root=/dev/vda console=ttyS0" \
         -net none -nographic \
         -drive file=blknvme,if=none,id=mynvme,format=raw \
-        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323
+        -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe
+
+The ``spdm_trans`` argument defines the underlying transport type that is
+emulated by QEMU. For an PCIe NVMe controller, both "doe" and "nvme" are
+supported. Where, "doe" does SPDM transport over the PCIe extended capability
+Data Object Exchange (DOE), and "nvme" uses the NVMe Admin Security
+Send/Receive commands to implement the SPDM transport.
 
 .. _DMTF:
    https://www.dmtf.org/standards/SPDM
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e450e785ea10..fa003031e719 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8943,19 +8943,33 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     pcie_cap_deverr_init(pci_dev);
 
-    /* DOE Initialisation */
+    /* SPDM Initialisation */
     if (pci_dev->spdm_port) {
-        uint16_t doe_offset = n->params.sriov_max_vfs ?
-                                  PCI_CONFIG_SPACE_SIZE + PCI_ARI_SIZEOF
-                                  : PCI_CONFIG_SPACE_SIZE;
+        uint16_t doe_offset = PCI_CONFIG_SPACE_SIZE;
 
-        pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
-                      doe_spdm_prot, true, 0);
+        switch  (pci_dev->spdm_trans) {
+        case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
+            if (n->params.sriov_max_vfs) {
+                doe_offset += PCI_ARI_SIZEOF;
+            }
 
-        pci_dev->doe_spdm.spdm_socket = spdm_socket_connect(pci_dev->spdm_port,
-                                                            errp);
+            pcie_doe_init(pci_dev, &pci_dev->doe_spdm, doe_offset,
+                          doe_spdm_prot, true, 0);
 
-        if (pci_dev->doe_spdm.spdm_socket < 0) {
+            pci_dev->doe_spdm.spdm_socket =
+                spdm_socket_connect(pci_dev->spdm_port, errp);
+
+            if (pci_dev->doe_spdm.spdm_socket < 0) {
+                return false;
+            }
+            break;
+        case SPDM_SOCKET_TRANSPORT_TYPE_NVME:
+            n->spdm_socket = spdm_socket_connect(pci_dev->spdm_port, errp);
+            if (n->spdm_socket < 0) {
+                return false;
+            }
+            break;
+        default:
             return false;
         }
     }
@@ -9246,9 +9260,14 @@ static void nvme_exit(PCIDevice *pci_dev)
         g_free(n->cmb.buf);
     }
 
+    /* Only one of the `spdm_socket`s below should have been setup */
+    assert(!(pci_dev->doe_spdm.spdm_socket > 0 && n->spdm_socket >= 0));
     if (pci_dev->doe_spdm.spdm_socket > 0) {
         spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
+    } else if (n->spdm_socket >= 0) {
+        spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
+                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
     }
 
     if (n->pmr.dev) {
@@ -9303,6 +9322,8 @@ static const Property nvme_props[] = {
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
+    DEFINE_PROP_SPDM_TRANS("spdm_trans", PCIDevice, spdm_trans,
+                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
@@ -9378,7 +9399,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 {
     uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
 
-    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+    /* DOE is only initialised if SPDM over DOE is used */
+    if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
         pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     }
     pci_default_write_config(dev, address, val, len);
@@ -9389,7 +9412,9 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
 {
     uint32_t val;
-    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE)) {
+
+    if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
+        (dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE)) {
         if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
             return val;
         }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index eee03385686c..88ccea501136 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -4,6 +4,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_doe.h"
+#include "system/spdm-socket.h"
 
 #define TYPE_PCI_DEVICE "pci-device"
 typedef struct PCIDeviceClass PCIDeviceClass;
@@ -166,6 +167,7 @@ struct PCIDevice {
 
     /* SPDM */
     uint16_t spdm_port;
+    SpdmTransportType spdm_trans;
 
     /* DOE */
     DOECap doe_spdm;
-- 
2.51.0


