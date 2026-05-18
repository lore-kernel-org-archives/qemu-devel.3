Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1E6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwmy-0004Fk-EL; Mon, 18 May 2026 08:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlu-0003MS-3G; Mon, 18 May 2026 08:08:34 -0400
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wOwlr-00074A-2x; Mon, 18 May 2026 08:08:33 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 5001C1D00134;
 Mon, 18 May 2026 08:08:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 08:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779106109; x=1779192509; bh=R9FXlLmUfHZYMjYxeo3bsF4ZrgUGQXj7
 M9rLfpvDIts=; b=lGA/dYvgGMhIdZzY7621qaFFVb78przulj0Qu4T3LFiPzWeT
 X/52zup7muTI02viSgugmMMDRQpB8HJ/aA6JxPALfgVkhuxkYjE9pxz8kFeVekuV
 BdI4AxTEP6VBpYUgj0+GawbiPvZB/f/b7dRed6vD2XJD5cAbWuqeo6kAOCCFQC4P
 FKviggywF/eQyNUCS3UN0elAMcJrQ/2i1hLwwgkaXQEA4b0Hobb4g6Axp4o8hDIK
 lZLUZIWGHaGYic4ivntAk6Vs8z40igZvcPqVZlumTLioSmUsQ2B+wJvtChO/l4+K
 Y0w6ZBmxjH2bXPw/UYUqpPzxlye3T7U8kOAG9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779106109; x=
 1779192509; bh=R9FXlLmUfHZYMjYxeo3bsF4ZrgUGQXj7M9rLfpvDIts=; b=A
 C4NfvOi0TqUoKp3GZxPzgK9Xy8NU0Jf5Aakfc2fMZCIVKrrFE5Hp80GHJwxTZVZ8
 Zdm4UR9M44eUSVxXiFyrx3EhaSCsSWBCeNHTMqXI6TItu8tDww0Q8ngXJ0yby0SP
 XT3QNABmgFcVwMHaM1zjDE4izLqSTLW8FUMeDEIz0+numqTz0IOqLX4kEPyFUSC/
 c1yp0wzjSUbeEap3YXXvtXWcAfLEMBAlP5hgRntk2Mvn10r1tpcWlptO1yVa7wrj
 lNbTI8EfLOK7GsVz1kO/ZgeHT9XaTYHQDgP+MKcbGxtn8/M03KsGQ13Hxq/4vgmU
 ZQWZG2S8hTU6rKj7pmLNg==
X-ME-Sender: <xms:PAELajA5cci0wFbt7xM-BGYnqmck81jQyq6tjgBEJ41F7kG29cYBKA>
 <xme:PAELamZO9PD1MCCL-PJZk8X4iJdOe0rMJPQ7242ImjAM5I0e0qA9UJr2m70bDQu7X
 G6695ILdd2ZHGF6XJQwPti3onrt2ebrzc11LWgxZJHs79KyVTW4>
X-ME-Received: <xmr:PAELauW6Cd58xu-Qkzt9SkfefXjoCQLFwDY1Dx8d65SgOB850xEWBtD9u-PxKVgDzJ2wd9VfBA6Q1ZThx2Act7ym>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeefvedtueetueduffevgffgtdeftdeuleffhfeigeffkeegfeejfeffteejiefh
 vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpd
 hrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghp
 thhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkrdhjvg
 hnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtph
 htthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehpihgvrhhrihgt
 khdrsghouhhvihgvrhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepqh
 gvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:PAELalOBqqoxAzQgQZt3-RJyAyfq5JqlX_EUQATVwMQWEgm5stnxqg>
 <xmx:PAELaoZY7x4U0CaKvnzLSOV-X_heqA1TYmY-KJ6sGHYiFmHUW0druQ>
 <xmx:PAELak8RAM6tktYRMEy4eos7aJVFpF2WcyIB4_ezsMlEZieeb2FClw>
 <xmx:PAELapQ_NLQaohv-RTa15Dy8KR5Vsnv2LI2QpScQJ2AJniwau69ieQ>
 <xmx:PQELal2teXYk5EHwSdjzv6ugw4l4FW3y9FqA_rkUjx_J9OBTdN-YQvjW>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:08:27 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org
Subject: [PULL 4/5] hw/nvme: add user controlled 'firmware-version' property
Date: Mon, 18 May 2026 14:07:47 +0200
Message-ID: <20260518120748.14831-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518120748.14831-1-its@irrelevant.dk>
References: <20260518120748.14831-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
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

This enables overriding the built in default QEMU project version string
with a user specified string. The value can be at most 8 characters
in length.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 docs/system/devices/nvme.rst |  5 +++++
 hw/nvme/ctrl.c               | 14 ++++++++++++--
 hw/nvme/nvme.h               |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 109c01a70d50..98a44010438b 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -65,6 +65,11 @@ parameters.
   to more closely impersonate a particular device type. The model name
   can be a maximum of 40 characters in length.
 
+``firmware-version`` (default: current QEMU version number)
+  Override the default reported firmware version, which can be used when
+  needing to more closely impersonate a particular device type. The version
+  can be a maximum of 8 characters in length.
+
 Additional Namespaces
 ---------------------
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4822bc0a99b1..5b03929451d0 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -44,7 +44,8 @@
  *              atomic.awun<N[optional]>, \
  *              atomic.awupf<N[optional]>, \
  *              subsys=<subsys_id>, \
- *              model=<model-str>
+ *              model=<model-str>, \
+ *              firmware-version=<version-str>
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
  *              subsys=<subsys_id>,shared=<true|false[optional]>, \
@@ -8616,6 +8617,13 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         return false;
     }
 
+    if (params->firmware_version &&
+        strlen(params->firmware_version) > NVME_ID_CTRL_FR_MAX_LEN) {
+        error_setg(errp, "'firmware-version' parameter '%s' can be at most '%d' characters",
+                   params->firmware_version, NVME_ID_CTRL_FR_MAX_LEN);
+        return false;
+    }
+
     if (params->mqes < 1) {
         error_setg(errp, "mqes property cannot be less than 1");
         return false;
@@ -9111,7 +9119,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn),
               n->params.model ? n->params.model : "QEMU NVMe Ctrl", ' ');
-    strpadcpy((char *)id->fr, sizeof(id->fr), QEMU_VERSION, ' ');
+    strpadcpy((char *)id->fr, sizeof(id->fr),
+              n->params.firmware_version ? n->params.firmware_version : QEMU_VERSION, ' ');
     strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
 
     id->cntlid = cpu_to_le16(n->cntlid);
@@ -9391,6 +9400,7 @@ static const Property nvme_props[] = {
                      NvmeSubsystem *),
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
     DEFINE_PROP_STRING("model", NvmeCtrl, params.model),
+    DEFINE_PROP_STRING("firmware-version", NvmeCtrl, params.firmware_version),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
     DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index ebf1fcfdcde0..5ef3ebee29e5 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -543,6 +543,7 @@ typedef struct NvmeCQueue {
 typedef struct NvmeParams {
     char     *serial;
     char     *model;
+    char     *firmware_version;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
-- 
2.53.0


