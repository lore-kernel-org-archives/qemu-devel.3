Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5145BEA4E09
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx4KB-0001ao-8K; Mon, 02 Mar 2026 09:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1vx4GE-0000O7-0X
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:28:38 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1vx4GC-0007OO-9i
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:28:37 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4398c7083d7so3991208f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scylladb.com; s=google; t=1772461714; x=1773066514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7nu/t173dv7JRu8XE9IPkA5154FrLdxcPVhdNmGcIlE=;
 b=0uwetulAD0o7XziwuqqB4MQ3NGp+naE4njxAGdauE6hlsRvnx62+tomG1zG3Hun6TB
 wW2cTk7hTc6UfaZpqPF5YvAn2dM6VHTMsT1eLWB8LsY0BWqfyb286O288KAEJqXj39T7
 pgs4DoazInoOJqz7ievzHrhG1xtuOGLRHqfsTtmEanETzGDG2zUQT+vjD86lu0CcMLyP
 6j5BOwt/wqDSHjYr4klXflFk2D0hA2XVc89+aiDMRdLb6T383wGfG77Mwj2NWwPYRArW
 2UOZIk/KVAbXjbn0qT5uF44nQc4QzLZBOUfwAXWklTe42EUuQQ42Db6H8num3PblLRwS
 bsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772461714; x=1773066514;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nu/t173dv7JRu8XE9IPkA5154FrLdxcPVhdNmGcIlE=;
 b=og8REDgL6RRSXbO1HK7Q1COjLhgoYEouq31s0TefV/RmPpUrYyOz5zeW8mYZdHCU8N
 O8OmGo4E5FJkQV+KgalYY1KYkC1YyjIMlcld/jM/Mm8qKFK/X86nq3OaLRl04dqTeNVp
 yPMuebj4vPgfMF9YtJHLgpl/16y5c+yJ4zucbf8HYnYjDHJ2hp7MpDJKXJrsXyCPWQI6
 9KBMQ6rFOvNEZi22R8pt91zoas8/6LZyWJTBjhhZ+XyRjbfggbg0b5n751qnWPdtkvDE
 c/IDVFLP7dRlGRmw9D9zg+fvdFBNDS0Y13PEwxKRkN5tQHInLG6jSkIECvortlS7Sqrj
 k60g==
X-Gm-Message-State: AOJu0YwHCv6ksx7RL60QRYL0B56SboWquS8oPJNrK67Jf55tFqO22cGU
 q4v/r+rJNCNKU7ax7LgKc+/NtUmJrvYIMMVuM4Uh3Muy8vDxbek7e9oobuC/VSG4eKZMRy5QM2g
 8FjPzSATgHTL3rwS/7Jh6UomLF1Khurx45qpxiz6b3Ifur1hgEFQYNVUY2VNdNgx7yDSOXfuIg5
 0+quAn6W12rax8JLNnMyWddloV8IgFvGrbJMoTP+hI1bE4gUOrsa3VPXAkkQ7HO/QLEifYoO37u
 QY1Sh8P6RjTa44BeDYk4XnOcEaVuIHnBRDG1bnohPDOKt67KLmVT6eXdije9dOBawF55gMlIUBx
 hAhxlDgXrb5KhtNNyeFe/R2FfqHriJ46t9w=
X-Gm-Gg: ATEYQzzeJLGVDPB/RnJA4w7taO1bhIbzX8t0ODOD2SzJa50m2rBsAqSodcY8MJvdOpp
 G/yNPdr8uGxwB8xT5KxaQa+2Qn86VUd5e6YpqyN5oeyqCwgPXpDYI374k8+tdYyfVlGmzKcAFnm
 LUXJ9fbVjFiIHEPHsh6MLtsq4Leob9pDobsy9NZjt+uIeO4njbAQFZtUdqDxstMxo+aOv0goGOw
 vVwwXfdE/AzJIieyp8humoRzFJlXNLX5znG8UUtGlQt3dQ+wi1dN5spgmA4bOobNnbRQ0msxzZ7
 yyrqc5hQUHlbR2srXeEHvPVieqUB4uhczYmc6KKgsK3CW4lyo0GCH03kAywIana4LXvZNm5ii8R
 ORrogH+PqhBa0pMd2zvXCHJ4eUp0fe8bldoRF1fBwuF7kNZSRE2zbCMRpWR+MmWa1VIJcpcvtgV
 vg7G2r6G5AmsCgzv3/2wjHC4FwAd8T00RPneA=
X-Received: by 2002:a05:6000:420f:b0:439:b3ff:9abb with SMTP id
 ffacd0b85a97d-439b3ff9bcdmr8326360f8f.57.1772461713457; 
 Mon, 02 Mar 2026 06:28:33 -0800 (PST)
Received: from avi.scylladb.com ([77.137.21.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c764546sm30258707f8f.29.2026.03.02.06.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 06:28:32 -0800 (PST)
From: Avi Kivity <avi@scylladb.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/nvme: add `model` parameter
Date: Mon,  2 Mar 2026 16:27:48 +0200
Message-ID: <20260302142831.1269291-1-avi@scylladb.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: permerror client-ip=2a00:1450:4864:20::42e;
 envelope-from=avi@scylladb.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Mar 2026 09:32:18 -0500
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

Add a `model` parameter, readable with nvme-cli. This allows
impersonating other disk manufacturers or hypervisors, similar
to the the -smbios option.

Signed-off-by: Avi Kivity <avi@scylladb.com>
---

Disclosure: prepared with AI assistance. I believe it to be of good
quality.

 docs/system/devices/nvme.rst | 8 ++++++++
 hw/nvme/ctrl.c               | 4 +++-
 hw/nvme/nvme.h               | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 6509b35fcb..1d4dd66d65 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -58,10 +58,18 @@ parameters.
   sits on top of NVMe. It describes additional commands and NVMe behaviors
   specific for the Datacenter. When this option is ``on`` OCP features such as
   the SMART / Health information extended log become available in the
   controller. We emulate version 5 of this log page.
 
+``model`` (default: ``QEMU NVMe Ctrl``)
+  Set the model name reported in the Identify Controller data structure (field
+  ``MN``). The value is visible to the guest as
+  ``/sys/class/nvme/<name>/model``. This is useful for emulating specific
+  NVMe devices; for example, setting ``model=Amazon Elastic Block Store``
+  allows guest software to distinguish emulated EBS volumes from instance
+  storage.
+
 Additional Namespaces
 ---------------------
 
 In the simplest possible invocation sketched above, the device only support a
 single namespace with the namespace identifier ``1``. To support multiple
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd42..2d1fb7a209 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9092,11 +9092,12 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     memcpy(n->cse.iocs.zoned, nvme_cse_iocs_zoned_default,
            sizeof(n->cse.iocs.zoned));
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
-    strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
+    strpadcpy((char *)id->mn, sizeof(id->mn),
+              n->params.model ? n->params.model : "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), QEMU_VERSION, ' ');
     strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
 
     id->cntlid = cpu_to_le16(n->cntlid);
 
@@ -9372,10 +9373,11 @@ static const Property nvme_props[] = {
     DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmr.dev, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_LINK("subsys", NvmeCtrl, subsys, TYPE_NVME_SUBSYS,
                      NvmeSubsystem *),
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
+    DEFINE_PROP_STRING("model", NvmeCtrl, params.model),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
     DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
     DEFINE_PROP_UINT16("msix_qsize", NvmeCtrl, params.msix_qsize, 65),
     DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index d66f7dc82d..ebf1fcfdcd 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -540,10 +540,11 @@ typedef struct NvmeCQueue {
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
 
 typedef struct NvmeParams {
     char     *serial;
+    char     *model;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
     uint16_t mqes;
     uint32_t cmb_size_mb;
-- 
2.53.0


