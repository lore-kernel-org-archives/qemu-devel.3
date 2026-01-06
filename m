Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3659DCDC196
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 13:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd6gs-0002Y4-L9; Tue, 06 Jan 2026 08:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1vd6fj-0001il-72; Tue, 06 Jan 2026 08:00:34 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>)
 id 1vd6fd-0000ld-W9; Tue, 06 Jan 2026 08:00:25 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id CCD7EEC018B;
 Tue,  6 Jan 2026 08:00:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 06 Jan 2026 08:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1767704417; x=1767790817; bh=Mx
 AFadzaOlKRMpIvymiuujJ9fJOdskDIoo9qaXz6z4c=; b=jQZD9M+Bp7nudFAtz/
 R89ipqCeBvUZhDsAeAQVwQrjS6eSAFwpX/VEPWabtMcaYDyDLoBz/vkL4P4OWKzX
 N/wZy2aWBsYCbmQENz59ZABWWH2ked5Acc5whqMN1ZugSeNp1jszAw9gUL7UPIc8
 A1rs4OoYm3V6dgGyEJ2d/ZGI1Aog22zzJK+Qqb7eSYQqeSlf8ZzcBwp+fGASTkdd
 Nx9V1GQjX9/x9KxXtOicaWv3cvZR+vVWmVKwvF6Zaxy/I8ta+ptMNi2XOec63OVb
 oEXViFxRXImkEfTt41C0d3l+JODd6zfmDuNFKQB4e+VtV5rfjg4FRSKnAPphjw26
 FMfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1767704417; x=1767790817; bh=MxAFadzaOlKRMpIvymiuujJ9fJOd
 skDIoo9qaXz6z4c=; b=Z5EfPmz77tD4VcXXjWcsTK4P0VsZk+RMskbSpuOVLKpf
 otKCwUrTRTZ27w6BatphMpD9ScivbVcGlt5duC6dhPcDUc+zqVZMviJGFh/HXtuf
 RTq/X8tk62z5RzgQXieLDu3+N7idnEv1xtGBnS4wP6fi5MtUg32JWrVn1aFKW9qS
 5lumNWYQYz+yVdtemEnkG0J59tFqSAdFOzwXXbNFNyjW6vRVOnvy7ZEzF9yfMmqC
 yjsyPKV6W8sShvcdfqlz5+dbjjdC6PdDiDptCtDBUX7VoZHP/L5MjxoNh3Cq9fyl
 tFyAT8kDuZyLE86C4yov6efjyDbjEhbjs7ILKQvqeA==
X-ME-Sender: <xms:YAddabvyyeucy5_dUq2ed9VpSaBCsmoHYFf1MaBBrWn7TRKrOYX6Yw>
 <xme:YAddaSfTdpz3xXH_pNrw2EeiVxX66H3MgFn-sWNUogrbz12y9ZyRRMj9lkGJX6Fuj
 lTK2Zxo1yxAIVWOI3PcuPa72u7Fc00F48fBrx7ITw6OawEGC9x2ByQ>
X-ME-Received: <xmr:YAddaZlaAW5kC7cGIxUW88htXXkOpnNS-kvYeQKThSELp2-Q2CugLw71XL12ymV0vuWTVoG9JcSOAHP5tVZECGofsl5D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflvghsphgvrhcu
 ffgvvhgrnhhtihgvrhcuoehfohhsshesuggvfhhmrggtrhhordhitheqnecuggftrfgrth
 htvghrnhepheefhedvgeduhfffteekfffggeduuddtueethfevtdfftdfhvdffleetteef
 veefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfohhsshesuggvfhhmrggtrhhordhithdp
 nhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifrg
 hnghihrghnrghnheehsehhuhgrfigvihdrtghomhdprhgtphhtthhopehmrghrtggvlhdr
 rghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphhtthhopegvughurghrughose
 hhrggskhhoshhtrdhnvghtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhn
 uhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtth
 hopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepjhdruggvvhgrnhht
 ihgvrhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehithhssehirhhrvghlvghvrg
 hnthdrughkpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:YAddadAZdwOtBW3K_Pwul1pGCijjr2O8glmW6rol-jgBUgEh37g4JQ>
 <xmx:YAddabOfITDblfyk1Hc4GAb3pCDuN6Wa_uEGT9JHYMLko0sOX5lhwg>
 <xmx:YAddaUNXSIl6AkeNyqLoixguufXbn4almiE-DuHoAThCgFT98j-rTg>
 <xmx:YAddaTmdRfWcDMklTrEc3f_xREq94-4m3o4aOiwr2wZ_Q9JXA_DoRA>
 <xmx:YQddabxyOiv8ylCd6Bygldl8tXKjPv8y5UCGM79jdJHYuL-V0bCNpwr6>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 08:00:14 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Tue, 06 Jan 2026 14:00:11 +0100
Subject: [PATCH] introduce pci.{did,vid,ssid,ssvid} and ieee.oui props
 (changes)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-q-saif-pci-oui-props-v1-1-c8a1a4ec0dfc@samsung.com>
X-B4-Tracking: v=1; b=H4sIAFoHXWkC/x3MQQqAIBBA0avErBtIQdKuEi2sxppNmkMRhHdPW
 r7F/y8IZSaBoXkh083C8ahQbQPL7o+NkNdq0J02SiuHJ4rngGlhjBdjyjEJWuvM6l1vZ6+hpil
 T4OffjlMpHxQ+D8ZmAAAA
X-Change-ID: 20251219-q-saif-pci-oui-props-8895da978ba2
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>, 
 Jesper Wendel Devantier <foss@defmacro.it>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=103.168.172.145; envelope-from=foss@defmacro.it;
 helo=fout-a2-smtp.messagingengine.com
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

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Introduce properties to set PCI device and vendor IDs and
PCI subsystem- and subsystem vendor IDs.
Additionally, make IEEE.OUI configurable through a property.

This replaces the old 'use-intel-id' property, which changed some
of these values and streamlines the code to use these properties
instead of branching on use-intel-id.

The documentation for the NVMe device and the compatibility flags
for QEMU 5.1 (and lower) machines are updated to reflect this
change.

Signed-off-by: Jesper Wendel Devantier <foss@defmacro.it>
---
This is based on V4 of the patch series by Saif Abrar which
adds additional properties for specifying PCI vendor- and
device IDs and PCI subsystem [vendor] IDs and the ability
to specify the IEEE OUI (Organizationally Unique ID) value.
(See link below).

Chiefly, this patch goes a step further, simplifying the
code by removing the old use-intel-id property since these
new properties collectively can achieve the same.

Original Series:
https://lore.kernel.org/qemu-devel/20251127120322.2997269-1-saif.abrar@linux.vnet.ibm.com/

Tested-by: Jesper Wendel Devantier <foss@defmacro.it>
---
 docs/system/devices/nvme.rst | 18 +++++++---
 hw/core/machine.c            |  4 ++-
 hw/nvme/ctrl.c               | 83 +++++++++++---------------------------------
 hw/nvme/nvme.h               | 11 +++---
 4 files changed, 43 insertions(+), 73 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 6509b35fcb4e42d59f04e678d709f83af06f95af..c5f90cb1b409a62fc49433ca5e3e9c1afea4b065 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -48,10 +48,20 @@ parameters.
 ``mdts=UINT8`` (default: ``7``)
   Set the Maximum Data Transfer Size of the device.
 
-``use-intel-id`` (default: ``off``)
-  Since QEMU 5.2, the device uses a QEMU allocated "Red Hat" PCI Device and
-  Vendor ID. Set this to ``on`` to revert to the unallocated Intel ID
-  previously used.
+``pci.vid`` (default: ``0x1b36``, Red Hat)
+  Since QEMU 5.2, the device uses a QEMU allocated "Red Hat" PCI vendor ID.
+  Set this to ``0x8086`` to revert to the unallocated Intel ID.
+  This is one of the parameters replacing the ``use-intel-id`` parameter.
+
+``pci.did`` (default: ``0x0010``, Red Hat)
+  Since QEMU 5.2, the device uses a QEMU allocated "Red Hat" PCI device ID.
+  Set this to ``0x5845`` to revert to the unallocated Intel ID.
+  This is one of the parameters replacing the ``use-intel-id`` parameter.
+
+``ieee.oui`` (default: ``0x525400``, Red Hat)
+  Since QEMU 5.2, the device uses a QEMU allocated "Red Hat" Organization
+  Unique Id (OUI). Set this to ``0xb30200`` to revert to the Intel OUI.
+  This is one of the parameters replacing the ``use-intel-id`` parameter.
 
 ``ocp`` (default: ``off``)
   The Open Compute Project defines the Datacenter NVMe SSD Specification that
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 06e0c9a179bb3e6e140d54cb9687caaa59ee0e61..51ebfd8215eb8824191649ca7289a9b5cb3af90c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -165,7 +165,9 @@ GlobalProperty hw_compat_5_1[] = {
     { "vhost-user-scsi", "num_queues", "1"},
     { "virtio-blk-device", "num-queues", "1"},
     { "virtio-scsi-device", "num_queues", "1"},
-    { "nvme", "use-intel-id", "on"},
+    { "nvme", "pci.did", "0x5845"},
+    { "nvme", "pci.vid", "0x8086"},
+    { "nvme", "ieee.oui", "0x0002b3"},
     { "pvpanic", "events", "1"}, /* PVPANIC_PANICKED */
     { "pl011", "migrate-clk", "off" },
     { "virtio-pci", "x-ats-page-aligned", "off"},
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c66524c78cde4e3176d754a006a476dc56156cb5..a815c0cd74f64e04ecc88280d3be73ebb618de45 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8876,10 +8876,7 @@ out:
 static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
                             Error **errp)
 {
-    uint16_t vf_dev_id = n->params.use_intel_id ?
-                         PCI_DEVICE_ID_INTEL_NVME :
-                         (n->params.id_device ?
-                         n->params.id_device : PCI_DEVICE_ID_REDHAT_NVME);
+    uint16_t vf_dev_id = n->params.pci.did;
 
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
     uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
@@ -8952,27 +8949,11 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pci_conf[PCI_INTERRUPT_PIN] = pci_is_vf(pci_dev) ? 0 : 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
 
-    if (n->params.use_intel_id) {
-        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
-        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_INTEL_NVME);
-    } else {
-        uint16_t id_vendor = n->params.id_vendor ?
-                             n->params.id_vendor : PCI_VENDOR_ID_REDHAT;
-        pci_config_set_vendor_id(pci_conf, id_vendor);
-
-        uint16_t id_device = n->params.id_device ?
-                             n->params.id_device : PCI_DEVICE_ID_REDHAT_NVME;
-        pci_config_set_device_id(pci_conf, id_device);
-
-        if (n->params.id_subsys_vendor) {
-            pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID,
-                                                   n->params.id_subsys_vendor);
-        }
+    pci_config_set_vendor_id(pci_conf, n->params.pci.vid);
+    pci_config_set_device_id(pci_conf, n->params.pci.did);
 
-        if (n->params.id_subsys) {
-            pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, n->params.id_subsys);
-        }
-    }
+    pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID, n->params.pci.ssvid);
+    pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, n->params.pci.ssid);
 
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
     nvme_add_pm_capability(pci_dev, 0x60);
@@ -9103,6 +9084,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
     uint32_t ctratt = le32_to_cpu(id->ctratt);
     uint16_t oacs;
+    uint32_t ieee_oui;
 
     memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
     memcpy(n->cse.iocs.nvm, nvme_cse_iocs_nvm_default, sizeof(n->cse.iocs.nvm));
@@ -9127,19 +9109,10 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->rab = 6;
 
-    if (n->params.use_intel_id) {
-        id->ieee[0] = 0xb3;
-        id->ieee[1] = 0x02;
-        id->ieee[2] = 0x00;
-     } else if (n->params.ieee_oui) {
-        id->ieee[0] = extract32(n->params.ieee_oui, 0,  8);
-        id->ieee[1] = extract32(n->params.ieee_oui, 8,  8);
-        id->ieee[2] = extract32(n->params.ieee_oui, 16, 8);
-    } else {
-        id->ieee[0] = 0x00;
-        id->ieee[1] = 0x54;
-        id->ieee[2] = 0x52;
-    }
+    ieee_oui = cpu_to_le32(n->params.ieee_oui);
+    id->ieee[0] = extract32(ieee_oui, 0, 8);
+    id->ieee[1] = extract32(ieee_oui, 8, 8);
+    id->ieee[2] = extract32(ieee_oui, 16, 8);
 
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
@@ -9388,24 +9361,6 @@ static void nvme_exit(PCIDevice *pci_dev)
     memory_region_del_subregion(&n->bar0, &n->iomem);
 }
 
-static void nvme_prop_ieee_set(Object *obj, Visitor *v, const char *name,
-        void *opaque, Error **errp)
-{
-    Property *prop = opaque;
-    uint32_t *val = object_field_prop_ptr(obj, prop);
-    if (!visit_type_uint32(v, name, val, errp)) {
-        return;
-    }
-}
-
-static const PropertyInfo nvme_prop_ieee = {
-    .type = "uint32",
-    .description = "IEEE OUI: Identify Controller bytes 75:73\
- in LE format. (e.g. ieee_oui=0xABCDEF => Byte[73]=0xEF, Byte[74]=0xCD,\
- Byte[75]=0xAB)",
-    .set = nvme_prop_ieee_set,
-};
-
 static const Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, namespace.blkconf),
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
@@ -9421,7 +9376,6 @@ static const Property nvme_props[] = {
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
     DEFINE_PROP_UINT8("vsl", NvmeCtrl, params.vsl, 7),
-    DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
     DEFINE_PROP_BOOL("legacy-cmb", NvmeCtrl, params.legacy_cmb, false),
     DEFINE_PROP_BOOL("ioeventfd", NvmeCtrl, params.ioeventfd, false),
     DEFINE_PROP_BOOL("dbcs", NvmeCtrl, params.dbcs, true),
@@ -9448,13 +9402,16 @@ static const Property nvme_props[] = {
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
     DEFINE_PROP_UINT16("atomic.awupf", NvmeCtrl, params.atomic_awupf, 0),
     DEFINE_PROP_BOOL("ocp", NvmeCtrl, params.ocp, false),
-    DEFINE_PROP_UINT16("id_vendor", NvmeCtrl, params.id_vendor, 0),
-    DEFINE_PROP_UINT16("id_device", NvmeCtrl, params.id_device, 0),
-    DEFINE_PROP_UINT16("id_subsys_vendor", NvmeCtrl,
-                                                    params.id_subsys_vendor, 0),
-    DEFINE_PROP_UINT16("id_subsys", NvmeCtrl, params.id_subsys, 0),
-    DEFINE_PROP("ieee_oui", NvmeCtrl, params.ieee_oui, nvme_prop_ieee,
-                uint32_t),
+    DEFINE_PROP_UINT16("pci.vid", NvmeCtrl,
+                       params.pci.vid, PCI_VENDOR_ID_REDHAT),
+    DEFINE_PROP_UINT16("pci.ssvid", NvmeCtrl,
+                       params.pci.ssvid, PCI_VENDOR_ID_REDHAT_QUMRANET),
+    DEFINE_PROP_UINT16("pci.did", NvmeCtrl,
+                       params.pci.did, PCI_DEVICE_ID_REDHAT_NVME),
+    DEFINE_PROP_UINT16("pci.ssid", NvmeCtrl,
+                       params.pci.ssid, PCI_SUBDEVICE_ID_QEMU),
+    DEFINE_PROP_UINT32("ieee.oui", NvmeCtrl,
+                       params.ieee_oui, 0x525400),
 };
 
 static void nvme_get_smart_warning(Object *obj, Visitor *v, const char *name,
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index be49acaec6b5e99fbd079790732fdf4c9c46a631..ceae62979a1208045534665b18a5446f0f9b2c9b 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -550,7 +550,6 @@ typedef struct NvmeParams {
     uint32_t aer_max_queued;
     uint8_t  mdts;
     uint8_t  vsl;
-    bool     use_intel_id;
     uint8_t  zasl;
     bool     auto_transition_zones;
     bool     legacy_cmb;
@@ -572,10 +571,12 @@ typedef struct NvmeParams {
     uint16_t atomic_awupf;
     bool     atomic_dn;
 
-    uint16_t id_vendor;
-    uint16_t id_device;
-    uint16_t id_subsys_vendor;
-    uint16_t id_subsys;
+    struct {
+        uint16_t vid;
+        uint16_t ssvid;
+        uint16_t did;
+        uint16_t ssid;
+    } pci;
 
     uint32_t ieee_oui;
 } NvmeParams;

---
base-commit: 39eacce671c1908bc3afcd5a65da0491fe1290e6
change-id: 20251219-q-saif-pci-oui-props-8895da978ba2

Best regards,
-- 
Jesper Wendel Devantier <j.devantier@samsung.com>


