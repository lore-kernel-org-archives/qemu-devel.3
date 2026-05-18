Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6E1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwmx-00045Y-L0; Mon, 18 May 2026 08:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlq-0003KG-IQ; Mon, 18 May 2026 08:08:32 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlo-00070w-92; Mon, 18 May 2026 08:08:29 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F22BB7A00C5;
 Mon, 18 May 2026 08:08:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 08:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779106106; x=1779192506; bh=n/a+USxh8EdDUhVbtp23PdkSgDZISod4
 7MBbJ4FXVR8=; b=M8ZhGKHl014CICyzN5s6Th6kqYjBpinA8rCEriGTyDV70Esb
 h/nnBeGuWbmQyouFBFWNj+B0Zp579/N54WFDCn3LBoM7WblyhRweZejk20bVwB8D
 FjcimNC1S6/1nGqccqky4kXbHE3SEJNlArow7ErTTydqhgJu5SJKWeBvqZ6rOPP7
 kI/g2VdpMNJjWec2ZohV+WBOhgb9iZfYJ++763BT9zqHOUJTnn+enk0Uw43GxjQK
 1SI5dBufxp7MYQR29b1zvexNyW7IcxovcgWSWXX3wehKQYv/YLQwZVdEVa0nfWOm
 k+gveAzCZalmf+X50rS696oPIiaG36QpF+YZkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779106106; x=
 1779192506; bh=n/a+USxh8EdDUhVbtp23PdkSgDZISod47MBbJ4FXVR8=; b=s
 BLQQFrHwJNao55jYjOO2JoaugCE2iO6aOTzgxVeXChnvwCKfFLoT0R07GPMx2/52
 rZzXsMhZ1/u/mr2978hNkKsYtFlOf4Z2LRG6RZAv3nPr6Rngv1rp1aiTXnTVZqAB
 G23CHqngN2gL+xqm0Wi1kTQNb75MXuFCUdmEKEFf0gIUJcccizxrcjn1s4YATuno
 lV+Hmxc2OhGI/UfuiagjgAacedHRE56tuVW/+MH+tJnWsl3jO5iYjtrv2pgbz6I/
 9Sj+XJxMOX3kFaEcSu5kw0itkIq0UBX+7wxY4vtx3P6bhHIFtdzyb4ewXWxCrZRS
 KOitAlLCqZn7PWniVc3ng==
X-ME-Sender: <xms:OgELam6sILkF_PeOdH-EqHQi1_gJIGjW5EAFvi_w-rM19kutk30K1g>
 <xme:OgELaswTWg6UbXC7E80yYnDKegO8FVJLmyRTOw3ZLZxze-jO4B4IXYoUksB0lyOEX
 6z0aZzA2wK8zeUYuZBKfi_fT4CeyNUq8M5pHg-XdmCsi37QhzR_1YtI>
X-ME-Received: <xmr:OgELalNrwD8lB1J4XzItMWJTIwhTrBnuVnvGliKmlLjjOfWteafOn90e72Zr_A2-YA0Xxs2zTYWrX2Nwoxrqrol0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefvedtueetueduffevgffgtdeftdeuleffhfeigeffkeegfeejfeffteejiefh
 vdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghp
 thhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrdhjvg
 hnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtph
 htthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehpihgvrhhrihgt
 khdrsghouhhvihgvrhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepqh
 gvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:OgELail0XnFK31V5IHEsNvpUS0KJBGp1nHRm2dqNVqSnF0Hub2PD_A>
 <xmx:OgELaqQBAtdkKl8CoBzbT61EJyMglJtRGNH8GaEqmCAaORrZJ3pQcg>
 <xmx:OgELahUHi93hcZz8gjR1NT54F3Dh1MGgSz8eesZimyZmjhhCdy3LAQ>
 <xmx:OgELauLItnGIJZxd5w8d-xZnj1Un1ya2gdFq3Zb8-_GqeMQ6aM0eng>
 <xmx:OgELauZ_TJqgw1vEegLNWDdP8utVwuZYI7Sz_Ew3m7NXPwOJt77BAotq>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:08:25 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org
Subject: [PULL 3/5] hw/nvme: add user controlled 'model' property
Date: Mon, 18 May 2026 14:07:46 +0200
Message-ID: <20260518120748.14831-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518120748.14831-1-its@irrelevant.dk>
References: <20260518120748.14831-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This enables overriding the built in default "QEMU NVMe Ctrl" string
with a user specified string. The value can be at most 40 characters
in length.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/system/devices/nvme.rst |  5 +++++
 hw/nvme/ctrl.c               | 14 ++++++++++++--
 hw/nvme/nvme.h               |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 6509b35fcb4e..109c01a70d50 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -60,6 +60,11 @@ parameters.
   the SMART / Health information extended log become available in the
   controller. We emulate version 5 of this log page.
 
+``model`` (default: ``QEMU NVMe Ctrl``)
+  Override the default reported model, which can be used when needing
+  to more closely impersonate a particular device type. The model name
+  can be a maximum of 40 characters in length.
+
 Additional Namespaces
 ---------------------
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 2556aced2a47..4822bc0a99b1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -43,7 +43,8 @@
  *              atomic.dn=<on|off[optional]>, \
  *              atomic.awun<N[optional]>, \
  *              atomic.awupf<N[optional]>, \
- *              subsys=<subsys_id>
+ *              subsys=<subsys_id>, \
+ *              model=<model-str>
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
  *              subsys=<subsys_id>,shared=<true|false[optional]>, \
@@ -8608,6 +8609,13 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         return false;
     }
 
+    if (params->model &&
+        strlen(params->model) > NVME_ID_CTRL_MN_MAX_LEN) {
+        error_setg(errp, "'model' parameter '%s' can be at most '%d' characters",
+                   params->model, NVME_ID_CTRL_MN_MAX_LEN);
+        return false;
+    }
+
     if (params->mqes < 1) {
         error_setg(errp, "mqes property cannot be less than 1");
         return false;
@@ -9101,7 +9109,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
-    strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
+    strpadcpy((char *)id->mn, sizeof(id->mn),
+              n->params.model ? n->params.model : "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), QEMU_VERSION, ' ');
     strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
 
@@ -9381,6 +9390,7 @@ static const Property nvme_props[] = {
     DEFINE_PROP_LINK("subsys", NvmeCtrl, subsys, TYPE_NVME_SUBSYS,
                      NvmeSubsystem *),
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
+    DEFINE_PROP_STRING("model", NvmeCtrl, params.model),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
     DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index d66f7dc82d5c..ebf1fcfdcde0 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -542,6 +542,7 @@ typedef struct NvmeCQueue {
 
 typedef struct NvmeParams {
     char     *serial;
+    char     *model;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
-- 
2.53.0


