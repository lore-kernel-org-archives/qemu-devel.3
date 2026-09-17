Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BC6C982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GXL-0000hy-U9; Thu, 17 Sep 2026 14:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x7GXL-0000hc-6B
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:08:43 -0400
Received: from mail-ej2-x29.google.com ([2a00:1450:4864:34::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x7GXI-0006p0-8t
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:08:42 -0400
Received: by mail-ej2-x29.google.com with SMTP id
 a640c23a62f3a-c294af0caa8so190405366b.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1789668519; x=1790273319;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=32Fkd6ZHAaqWVx7kItExss6YwXiuwpZufmwVbTcjIK8=;
 b=IrxkXM+71jHRBD8f3wyuw3RGNa/n91BOux+uJLoDhXJePmRQUgstvYtBhEdJi6L30O
 EbD42NYBK6xLPCS2z1x2s417DtklKYzTpTwMW9RWfbWXgAMexuffe7goB0fGYsM/Mwte
 gulP12OVztgBpj7ZIQTcrWZ6l1EGAU38UIGAbrMSYHCi7C35NimGC4S1gy8KbEw15dyi
 roO7WtuTKdJy+LSOZJ3+cVOHCc5upX49SftIMmCqqkyMklyTpG4hLs0u8/8a4chdmNSY
 sZfqUuoqaGcbR/vdWRHNdr6Zh/shg9hlPNxkiQ73JNNXWn2JvWUj8rxkCe4HPYapM5q4
 94ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789668519; x=1790273319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=32Fkd6ZHAaqWVx7kItExss6YwXiuwpZufmwVbTcjIK8=;
 b=zliJ518A6+83NNQAXbDmRKQeKhwJR1U14wQWwBe0ULAeTZusLlra+7hnu1xMCVTZg5
 58wz2PY6lW5egmpu/KC/DqiRVRaI3zs8+Uz9VmscAGsWDk7uhN0poBj51ad1+OD7iHM5
 W4K6QWZDNgyDAsXrkhVYB4pGY7ezFXE/Pwyi3SWHqJL/VmaETMODCNZrmGZNkxPM9d7J
 ZiN8bVFLAVmEWJcki8WWWoAnBuITrob+33gVZbBaCjChBuJRSKEtPaeuX6I84aaVpki1
 de+D2j8BP6MiHMwFEKlDOwOcQUlcGCljMXM67s1jYYFXKngi3OAAUik59EP3gP1SgggO
 us1A==
X-Gm-Message-State: AFuF++mxwtTLJPIgL8pG14r9BCLf2EOMbQXpcEea5b1fX21DaC8qecHZ
 edKUxXuLkm7ajnOOYGxOpl8sqpxOR2PYrYKBG10MOwfE1Mdl8PtYzNHUrg7bp7ivuBsI1/6OScP
 lbagW
X-Gm-Gg: AYBFou2jwUSCJxc+1M9PLM4JD4ubIYgd/2csKv0Xd86ujbdonhqW1bvDRvVAFJxmN+w
 qCCMpXUOpc+AeuUql4B7oX+xDjGuXM9g6TcsfTDoN7hWIMq+iFCKuCmSsoEnpYHvoqVGNOAwpCr
 X/lhWqcLoEThWT4b/vX/zFwTG5uq0T4P2pNUt4RAF1bfOSs3YWBeOHBe+3GUcllnD8hk8WUNmkr
 bivvNSzhC+/gXB9ve8ucr8eFeeQ1IJ0IrVHMU/7eIJPUMftIu5Vi01m4NERhQlBs2t+vY6Oq+y0
 JjN5vGFPu86ElbakryaHLy77oM6JVMf7C9mPvzyLDa9r6VC/H52PGkQ/T6jVUoOktmpiCQWKzcV
 sI0QpHWJ4GzEDmjpiyuvE8Ls6lcdnF5iNFYmGWfdsCNEhnjfYfLdXyvTe91MPlxzj7qZjS1rs6w
 mz3hpjZThA2w6S7MR86xo4JC6CHXHLercsc97uEdpWcRTw6zzvrvCaNfUrwWG0sRZfwQRD37V8A
 vbl+Hk9vxqdCpBlkeMCFKu8HpiWnBvwlbCOpPz0ksYn61XjHyQl3BmFR71bbezHLg==
X-Received: by 2002:a17:907:970f:b0:c26:207d:8a8f with SMTP id
 a640c23a62f3a-c2a157fcec6mr590166b.27.1789668518707; 
 Thu, 17 Sep 2026 11:08:38 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de5a5337sm334676466b.34.2026.09.17.11.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:08:38 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>,
	kraxel@redhat.com
Subject: [PATCH 1/2] pci: Add device ID for CnuasNIC RDMA network adapter
Date: Thu, 17 Sep 2026 18:08:28 +0000
Message-ID: <20260917180831.3142920-2-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917180831.3142920-1-weqaar.janjua@packetfive.com>
References: <20260917180831.3142920-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:34::29;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ej2-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

PCI device ID under QEMU vendor ID 0x1b36, device ID 0x0015

Request is for the CnuasNIC non-virtio QEMU device model of the Cnuas project.

CnuasNIC (QEMU device name: cnuas-vnic) is a software-emulated RDMA NIC supporting RoCEv2 and native InfiniBand, with guest Linux network and RDMA drivers and a standard verbs provider.

Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/

The allocation is requested in preparation for public release and upstream submission.

Cnuas is an experimental rack-scale AI/HPC emulation platform for functional experimentation in academic and industrial research and development. Its architecture and device interfaces are described in the public arXiv preprint paper:

Cnuas: A Software-Defined AI/HPC Rack-scale Emulation Platform and Hyperscale Data Center Facility Twin
https://doi.org/10.48550/arXiv.2609.15889

Website: https://cnuas.io

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 261b0f359f..ec65a0e9ab 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -100,6 +100,8 @@ PCI devices (other than virtio):
   PCI UFS device (``-device ufs``)
 1b36:0014
   PCI RISC-V IOMMU device
+1b36:0015
+  CnuasNIC RDMA network adapter
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a..51b3f83514 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -121,6 +121,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
+#define PCI_DEVICE_ID_REDHAT_CNUASNIC    0x0015
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.43.0


