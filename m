Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19B0C48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZEu-0001Ws-Nj; Sat, 17 Feb 2024 23:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEs-0001Vh-Pu
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:18 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEr-0004Ai-8r
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:18 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso2670944a12.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232236; x=1708837036;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/1f/zlVn5z3BkLnWlQs+cCnklNwxyMuq+kYjftlM008=;
 b=PWebjoHRU9I+Whdlr6Av2zFySh7Bo4iKJZIZT1CibezDec2WZSrlU7oWOlUWLo5k7o
 6nsMVqaYBQX6jL+5MeQyzPVkeTqE8Du0rWPg3PeDYG2ade2Kzo0yYZWpqtIPlIop386D
 1yBq4fkjZ1VCwliBzPHybjbOdXWgN9VkTBd2jETCGdzDk7OWb7MRmCZMyo9KEXLmwmzL
 QSP0cEltxjBPKktyyE5IpHDHX8AsqbZUWHfGnPhGDLz9rCDmyfmCkj1lLmGUE8zKIS+r
 3KoZg3Cih5xGs4f9Op9XbcEHz3tFB02jweS1jTYFBvjObcMRSYBrSDd8BBBgA+/3YGNl
 8olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232236; x=1708837036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1f/zlVn5z3BkLnWlQs+cCnklNwxyMuq+kYjftlM008=;
 b=bqmf8cT5wBjqg+dQQ3ZfVreDLJM1h2rK6JAZ6owSdcBeYHwbJvChAY5RifLheQAvoY
 HRC8WL9aHMWbmMwPG5W5zjySb1CnnASadwXxWQoY8CaXnh4/DBIuomPPaqKQxf6JcpOU
 psoH3AuX7QkoqeSWuYUtlTym4YtUMYzI0HJ1YTdaN+0I/4x0HnONMS+RBASOI3YzEq49
 KeBe4k3X9gcMTqpb6yB/+cmSbcxFeJKcJ/pt+quPMq8NuruLLmPW+9RZp5rxMz6rokC2
 is05KPnqW+9j7+Y5QfgfsA3XS8XD6cVRZt6Xui+caxsivpxQCe7MIrWhL1HJywkK/tc4
 cYOQ==
X-Gm-Message-State: AOJu0YxXHoNrHQ85DGAy97Dk7iTGuKY59/+dZt1KFVhEkHehdsGaf3VM
 zGIk3pRjPlzV4+2T0bEY0X6yAsmwJu1xFwggNCbgwW2nAce0hvnir18MvRpfn5o=
X-Google-Smtp-Source: AGHT+IG7FzrjS0oKKWb4dIeG3ePHUhAB3uAOvUyCQyd0mPKutzYaV/kogf3lP4BuDMBQS3uEpWcqYw==
X-Received: by 2002:a05:6a20:c90e:b0:1a0:7f3f:8d5d with SMTP id
 gx14-20020a056a20c90e00b001a07f3f8d5dmr9901010pzb.39.1708232236094; 
 Sat, 17 Feb 2024 20:57:16 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 r22-20020aa78456000000b006e24991dd5bsm2157816pfn.98.2024.02.17.20.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:57:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:12 +0900
Subject: [PATCH v5 07/11] pcie_sriov: Reset SR-IOV extended capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-7-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
2.43.1


