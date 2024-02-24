Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81081C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHR-0006WO-N0; Sat, 24 Feb 2024 04:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHF-0006RY-H0
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:01 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHD-0002Rm-QK
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:01 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5a04bbe0a18so535011eaf.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766698; x=1709371498;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CWn2MCi797aQrb9iMuPcNohCGcLthp8Y3kdNV7UN6ps=;
 b=IJSBWiP3lq2Ew4U2Pu/mnUZBjHQyLWREXzzHcr5r0t3H/gXCZPMe6XpUH5+Cmw5c91
 LLwF19wSTt6hMP3XTfSBuAKamjiEJXf4Kq/LeOKgzYiFLO5OydPAqadKIjTCDRnXSYrC
 eQofCNzQhFjv2RPBq93qAL8HBodpzlnWMJI/Onh96LnL32FARu6MtDu7AIfdVbuDkyQX
 pYtcIjk/0tE6fDJGqoV6wlolpOUCR/RvM22O/uDsA/ee4xfeCd+qh6cZTHySyr5q+bux
 XMTKE4MLOtgtp1D+2il8Xgp9ncq3nOH8aP1y0ypjv5i1iheE8YcwBmxQ3XGfB7OfAEP/
 fapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766698; x=1709371498;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWn2MCi797aQrb9iMuPcNohCGcLthp8Y3kdNV7UN6ps=;
 b=THRhgXqYehwCrpupxfkbWH9vvKwJUUMZyT1MW4/xjplsS13aoug9vie6wquUmmvGkb
 OwEDt7mHeaTdtwwwRl1e6YOa315YrSqkRITzwVpITAljFfLqNj4rZcozphuZQhGu8WeF
 eD01YIEgjyal0ktCtOvYDeemVPsY51LIlFLJX89b5OyIq42m54gwEm7eYeNTZgE60ps/
 VSi3jeUGUkzYQCfl50iL72QPABGCIdopp+bHoYKYbNAry1W2GrAH4iG73Hd7Jlfin5NM
 dccZDlMF6z2h7sZ3BkVd1wEISaysmYh4ZGkDJiFzFgWJwgIUjvTnFLUhGcaxjZKfTO96
 0t0g==
X-Gm-Message-State: AOJu0YxV1UX0g9xqzHCNVejM+21LNsxkIYo3UY2nhB+u8aI4lTsfPDqT
 syDQTrOYX5zm+W1uTY1+VAeukU+hO2+zcL1nbMDGTbU1C+egw0v344zRxdayL5M=
X-Google-Smtp-Source: AGHT+IFK9A3xjCeaFRlUSkHY5zWMYnsvLRbPLzBpfeiGhXyW7Peb2e52PydHvLDqa6rUeCfRTN8Isg==
X-Received: by 2002:a05:6358:b395:b0:177:afce:b12 with SMTP id
 pa21-20020a056358b39500b00177afce0b12mr2564758rwc.31.1708766698539; 
 Sat, 24 Feb 2024 01:24:58 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 y1-20020a17090ad70100b0029a71e7ef55sm845013pju.10.2024.02.24.01.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:24:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:35 +0900
Subject: [PATCH v7 03/16] pcie_sriov: Reset SR-IOV extended capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-3-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

pcie_sriov_pf_disable_vfs() is called when resetting the PF, but it only
disables VFs and does not reset SR-IOV extended capability, leaking the
state and making the VF Enable register inconsistent with the actual
state.

Replace pcie_sriov_pf_disable_vfs() with pcie_sriov_pf_reset(), which
does not only disable VFs but also resets the capability.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h |  4 ++--
 hw/net/igb.c                |  2 +-
 hw/nvme/ctrl.c              |  2 +-
 hw/pci/pcie_sriov.c         | 26 ++++++++++++++++++--------
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 095fb0c9edf9..b77eb7bf58ac 100644
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
index 0b5c31a58bba..9345506f81ec 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -493,7 +493,7 @@ static void igb_qdev_reset_hold(Object *obj)
 
     trace_e1000e_cb_qdev_reset_hold();
 
-    pcie_sriov_pf_disable_vfs(d);
+    pcie_sriov_pf_reset(d);
     igb_core_reset(&s->core);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7a56e7b79b4d..7c0d3f108724 100644
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
index da209b7f47fd..51b66d1bb342 100644
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
2.43.2


