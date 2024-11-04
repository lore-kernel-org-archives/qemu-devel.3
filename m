Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585D1D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JX-0006oD-FQ; Mon, 04 Nov 2024 16:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JU-0006Zj-K1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JS-0005Tf-Ne
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mdw6lQ9M8p1WeqXba2/OeJnW0hlNdaOFpMUqZq3tSr4=;
 b=Z4/mvhqWRkBxt6vFZRWSotZBExrte40PtCdbLWDgURIZQ35EndJDBkw0ftO9qg1C5pHBFO
 9EQr7qmjYyCDovPCobccNEerU/CXQpmsUQ87Kb7u+Cc//GjETascb41kJQzkFdukZc/l5f
 1ZVs61KkFzzH3ha9JZHMN7zVLh9X+SY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-iOe0z21GN5ao25qUdaoV4Q-1; Mon, 04 Nov 2024 16:08:35 -0500
X-MC-Unique: iOe0z21GN5ao25qUdaoV4Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43159c07193so39601445e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754514; x=1731359314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdw6lQ9M8p1WeqXba2/OeJnW0hlNdaOFpMUqZq3tSr4=;
 b=SMPzb5Is2W+qdWsPjq/WLUeWUL7rKZ/GXKMZIb7ZR/HLeOIk646UPzfcGNoBR4J1ZI
 OQRvuL8sculuLSTmG3jQeHoqsyiwHIrAePN3DuwOQQkff0nVK5c2JLxUyMb64NeHbwD+
 YG2on2wilCtr4qIVv1DsS4Bmp/MoJC9jx/iFD4WKAlOPNQb5HqCclwLvTwJujTg5ecSq
 Qn5HVswMwnssW5CXiJWtTMN7Sh+adOfkn5if/l1wkXUgko+Cyrm+0QD6F1j60KvlgJVm
 fPu6JeSa4iF4SAu42ttR0LUaKDCtvqH++DSLOaD2l8DubI5iPnM7KYPVx2qOz5ieJXEY
 dCiw==
X-Gm-Message-State: AOJu0Yz4wXf8MW8DuS40Fl92rYyCglcSZ+mvLjn5RWoZSGUvyRhiuBIZ
 hsXNkEkKnfxjE2LsrPtK3JkUE66SrH6SEIYBa/Md4RD2JbhPT1J3vECtazdN/we/Hmdlusgh+Jt
 JmRTiQrZZhRBgHKgxDyt1Nio7htU9d9IcGv7j6YHnOrdO6Fwu5kjxuWIiuzD11uAp2avBmGXwv9
 KOBNT72LcgP5qB0ugYB03io3WPB/vaNg==
X-Received: by 2002:a05:600c:198e:b0:42a:a6b8:f09f with SMTP id
 5b1f17b1804b1-4328327cddamr140621405e9.23.1730754513684; 
 Mon, 04 Nov 2024 13:08:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdwE17M97elbwB59Nb4RbWNc5mhpzKi0UFKHyTAEwlPrRXy4FW8eyN8xu8EGH5pGDH5+xQMQ==
X-Received: by 2002:a05:600c:198e:b0:42a:a6b8:f09f with SMTP id
 5b1f17b1804b1-4328327cddamr140621175e9.23.1730754513271; 
 Mon, 04 Nov 2024 13:08:33 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c13sm14339305f8f.13.2024.11.04.13.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:32 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 44/65] pcie: enable Extended tag field support
Message-ID: <449dca6ac93afbed1af00b6a29c9729f6cb18c35.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

>From what I read PCI has 32 transactions, PCI Express devices can handle
256 with Extended tag enabled (spec mentions also larger values but I
lack PCIe knowledge).

QEMU leaves 'Extended tag field' with 0 as value:

Capabilities: [e0] Express (v1) Root Complex Integrated Endpoint, IntMsgNum 0
        DevCap: MaxPayload 128 bytes, PhantFunc 0
                ExtTag- RBE+ FLReset- TEE-IO-

SBSA ACS has test 824 which checks for PCIe device capabilities. BSA
specification [1] (SBSA is on top of BSA) in section F.3.2 lists
expected values for Device Capabilities Register:

Device Capabilities Register     Requirement
Role based error reporting       RCEC and RCiEP: Hardwired to 1
Endpoint L0s acceptable latency  RCEC and RCiEP: Hardwired to 0
L1 acceptable latency            RCEC and RCiEP: Hardwired to 0
Captured slot power limit scale  RCEC and RCiEP: Hardwired to 0
Captured slot power limit value  RCEC and RCiEP: Hardwired to 0
Max payload size                 value must be compliant with PCIe spec
Phantom functions                RCEC and RCiEP: Recommendation is to
                                 hardwire this bit to 0.
Extended tag field               Hardwired to 1

1. https://developer.arm.com/documentation/den0094/c/

This change enables Extended tag field. All versioned platforms should
have it disabled for older versions (tested with Arm/virt).

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-Id: <20241023113820.486017-1-marcin.juszkiewicz@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 2 ++
 hw/core/machine.c    | 4 +++-
 hw/pci/pci.c         | 2 ++
 hw/pci/pcie.c        | 8 +++++++-
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 35d4fe0bbf..38ffa7bcee 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -214,6 +214,8 @@ enum {
     QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
 #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
     QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
+#define QEMU_PCIE_EXT_TAG_BITNR 13
+    QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
 };
 
 typedef struct PCIINTxRoute {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17eba..8ccc74067a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,7 +34,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_1[] = {};
+GlobalProperty hw_compat_9_1[] = {
+    { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
+};
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
 GlobalProperty hw_compat_9_0[] = {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0b6bdaa0d7..1416ae202c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -100,6 +100,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
     DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
                      max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
+    DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
+                    QEMU_PCIE_EXT_TAG_BITNR, true),
     { .name = "busnr", .info = &prop_pci_busnr },
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 2738dbb28d..0b455c8654 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -86,7 +86,13 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
      * Specification, Revision 1.1., or subsequent PCI Express Base
      * Specification revisions.
      */
-    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
+    uint32_t devcap = PCI_EXP_DEVCAP_RBER;
+
+    if (dev->cap_present & QEMU_PCIE_EXT_TAG) {
+        devcap = PCI_EXP_DEVCAP_RBER | PCI_EXP_DEVCAP_EXT_TAG;
+    }
+
+    pci_set_long(exp_cap + PCI_EXP_DEVCAP, devcap);
 
     pci_set_long(exp_cap + PCI_EXP_LNKCAP,
                  (port << PCI_EXP_LNKCAP_PN_SHIFT) |
-- 
MST


