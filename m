Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A213EC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbj-0002Bc-TD; Tue, 12 Mar 2024 18:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbH-0000Rx-QC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbF-0004U3-1q
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVAzYUdYDXeS1BjbLwTo4D9WpXNY+EQLjqjS51o2N6Q=;
 b=dyeOiIPaaJs1SJrXaolOdlEYq1SGkqvNo3TDI0Nz2WS/LmHIkt3Re6IeTB0uAl7S53+K4A
 I6KVB3Yoiu6RZDaxhB+E9TcV5xfAuYChrTBuvgf79iV6QsPnNoUwRuWpuKcgXvRNjRIvk1
 hsXL0dGiisQGm5sU8EJxSoZZ2Hzhls4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-MaE45JF1ObmG0yAQj-e9VA-1; Tue, 12 Mar 2024 18:27:54 -0400
X-MC-Unique: MaE45JF1ObmG0yAQj-e9VA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d45ce4457eso10603441fa.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282473; x=1710887273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVAzYUdYDXeS1BjbLwTo4D9WpXNY+EQLjqjS51o2N6Q=;
 b=WoxXyDY90gM4984Mwu1QbpcsBrj7xPx8JQk6NCuSNnaEZiukBxeozUQKOqnjyVpmdI
 4GaOB398cHwC+g6LLJRWbVXuFeRHe037UFNhqcOA+jr4zHSKw91bWy+B39GmZBVeqH7Z
 hrC+GIMC2pfCcxYtUx0oYOdQ31MtG9LsxygBag6C/KGBsbWdhElgRlu4ZTUeSz2O3kkX
 m4rRdceVVujgxRceWZD2mmwGeT2UvE3R4RpbrrlsPNckcyu2KlvTHaJ8onplbxY+BUH0
 MplCVbW46Cs+BjQ/TzEjBI5GFZHKCxLIb8mGZRjPrinU8boocrEfQxjDzUpJ9k/Fq/i3
 fFNg==
X-Gm-Message-State: AOJu0Yxgyz475RQjDnmwexwUvBfdlkQza2NdbMDBmrHsK513dfRYavH9
 tlVQRRGL33KHMXfih/uYClzZ9mD3F7amfv7JMb6w7CFXWNkI2P14B0zZYpONn1GMKGxD50CwnXg
 ImwohoaCmFaO40vAFdA9tiTvfS/iAGPeIO0kn9Ox74VcyN9WY5SkEre3a9vzjwcjJWg6LMyfxfa
 1fJiLvsxMeWlkUwPT94PWuKykckAMeWidB
X-Received: by 2002:a05:651c:19a9:b0:2d4:2b05:a671 with SMTP id
 bx41-20020a05651c19a900b002d42b05a671mr7668447ljb.32.1710282472818; 
 Tue, 12 Mar 2024 15:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaakUsdseKRtUZRtuj29cuQXD8qIflaps60yPx+hhLx32+EVGLUZdyRhKZBfmHXm9/KF77LQ==
X-Received: by 2002:a05:651c:19a9:b0:2d4:2b05:a671 with SMTP id
 bx41-20020a05651c19a900b002d42b05a671mr7668417ljb.32.1710282472155; 
 Tue, 12 Mar 2024 15:27:52 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 f8-20020a056402004800b00568550a0762sm2805826edu.6.2024.03.12.15.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:51 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org
Subject: [PULL 44/68] pcie_sriov: Reset SR-IOV extended capability
Message-ID: <c8bc4db403e17663b69d811e69f88c9dfc6f7be2.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pcie_sriov_pf_disable_vfs() is called when resetting the PF, but it only
disables VFs and does not reset SR-IOV extended capability, leaking the
state and making the VF Enable register inconsistent with the actual
state.

Replace pcie_sriov_pf_disable_vfs() with pcie_sriov_pf_reset(), which
does not only disable VFs but also resets the capability.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240228-reuse-v8-3-282660281e60@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 include/hw/pci/pcie_sriov.h |  4 ++--
 hw/net/igb.c                |  2 +-
 hw/nvme/ctrl.c              |  2 +-
 hw/pci/pcie_sriov.c         | 26 ++++++++++++++++++--------
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 095fb0c9ed..b77eb7bf58 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -58,8 +58,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
-/* Reset SR/IOV VF Enable bit to unregister all VFs */
-void pcie_sriov_pf_disable_vfs(PCIDevice *dev);
+/* Reset SR/IOV */
+void pcie_sriov_pf_reset(PCIDevice *dev);
 
 /* Get logical VF number of a VF - only valid for VFs */
 uint16_t pcie_sriov_vf_number(PCIDevice *dev);
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 0b5c31a58b..9345506f81 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -493,7 +493,7 @@ static void igb_qdev_reset_hold(Object *obj)
 
     trace_e1000e_cb_qdev_reset_hold();
 
-    pcie_sriov_pf_disable_vfs(d);
+    pcie_sriov_pf_reset(d);
     igb_core_reset(&s->core);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 2860a9bed1..447c4de6fd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7116,7 +7116,7 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
             }
 
             if (rst != NVME_RESET_CONTROLLER) {
-                pcie_sriov_pf_disable_vfs(pci_dev);
+                pcie_sriov_pf_reset(pci_dev);
             }
         }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index da209b7f47..51b66d1bb3 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -249,16 +249,26 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
 }
 
 
-/* Reset SR/IOV VF Enable bit to trigger an unregister of all VFs */
-void pcie_sriov_pf_disable_vfs(PCIDevice *dev)
+/* Reset SR/IOV */
+void pcie_sriov_pf_reset(PCIDevice *dev)
 {
     uint16_t sriov_cap = dev->exp.sriov_cap;
-    if (sriov_cap) {
-        uint32_t val = pci_get_byte(dev->config + sriov_cap + PCI_SRIOV_CTRL);
-        if (val & PCI_SRIOV_CTRL_VFE) {
-            val &= ~PCI_SRIOV_CTRL_VFE;
-            pcie_sriov_config_write(dev, sriov_cap + PCI_SRIOV_CTRL, val, 1);
-        }
+    if (!sriov_cap) {
+        return;
+    }
+
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
+    unregister_vfs(dev);
+
+    /*
+     * Default is to use 4K pages, software can modify it
+     * to any of the supported bits
+     */
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
+
+    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
+        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
+                     dev->exp.sriov_pf.vf_bar_type[i]);
     }
 }
 
-- 
MST


