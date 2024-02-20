Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED8AC54788
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPBy-0005Au-4T; Tue, 20 Feb 2024 07:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBT-0004k6-EE
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:18 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBB-0005qw-ND
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:09 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1db6e0996ceso39155275ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431896; x=1709036696;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/1f/zlVn5z3BkLnWlQs+cCnklNwxyMuq+kYjftlM008=;
 b=rTPeqZoVVRka5nYY6Rbjh1BH1sqet4zxoVn8COoU4Ue5eIQqFIMB2VtYeUxPNSDWSI
 a/B8Btqaf9JPGWBNVpH5yvPfDIlB/rZ4P7setkYUpZuo/fktqi+AKoJ27seupb9d1Ss9
 a/bT/OQe47I7cwQI1YPX7KOHjVLoPjHO3P06FcjUB4OPFNX5Q4c7xMQpPSazOKgp0ccZ
 d3Q7Kpu8GLoakaCzdHvE4bouWHTZTr3gL0n104gueCMdXgFj/pZfv69a1Km3dIG4T1N3
 Kd6Vqi9nlC9roKOMmrXg7pcbiHudfHp3onpKP1dqaYq1CPgy+pjUxX0d5/UrYaYMX4a+
 8Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431896; x=1709036696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1f/zlVn5z3BkLnWlQs+cCnklNwxyMuq+kYjftlM008=;
 b=VdAvu5qio8gT238olqBuGEqbFtpukNZz7eDg1rPOFfxwQOVnpHHTXkV5PcB64tcMa0
 qr6ja5C5/ecRLQkCPsgbSNzIeznCPopqIzXGDEwjXMa/Ncjzn0KQ2VTVKWjLudl23pkF
 /jYa6UfgXcx2FMWcZuEHbfyfCArw2pQWrivOt1Uilg1qrOyqW77P45l7/c2n/fhHralf
 dTnnOqfPqO+MIBQJVi+fInLYcRGpXG/DCpX50/FeDeYhmLabMNEHXXQJJQFX0Gm7XZbx
 0nPvqElpI9PnoOJSGiVNatvbF3O4WL7sOl2pfcD3er5KYpjeFUyiT1kmlEjjV20Ft6Gp
 GNKA==
X-Gm-Message-State: AOJu0Yw+i+ad/m8B3SpWJwIlI3voLIu8YGmWKv4sRChA00YEaoPlllFP
 kV0h8YklwmmXLpS1uYM8Y/ydSetbF3tw5YBFo3t7IG8G5uUtujZZsWJQoEQcdCM=
X-Google-Smtp-Source: AGHT+IH2Gl1aJq+6M3YnOo7f8OOo3tW/rzlGZBzADeRTwUhxklmAWsjFMLOE0ehXta5sN3gRg+NrYA==
X-Received: by 2002:a17:902:eccf:b0:1db:f513:28cf with SMTP id
 a15-20020a170902eccf00b001dbf51328cfmr6572998plh.23.1708431895859; 
 Tue, 20 Feb 2024 04:24:55 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 kp14-20020a170903280e00b001dbcb39dd69sm5649001plb.298.2024.02.20.04.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:24:55 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:38 +0900
Subject: [PATCH v6 03/15] pcie_sriov: Reset SR-IOV extended capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-3-2e42a28b0cf2@daynix.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
In-Reply-To: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


