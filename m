Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D21C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPBN-0004iA-UT; Tue, 20 Feb 2024 07:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBG-0004hU-4r
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:02 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPB0-0005qD-Pq
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:01 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-204f50f305cso4152701fac.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431885; x=1709036685;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3qtvS6V6fNKUkSPChGjLTrgPISzBF9C8NB+nT/PVebg=;
 b=z6VR6TQBfP27/Umv3UOx9WpwB4XOn5sLMGWC5vlhwmPHuV8XA7TR5c4iEnrXL0jz/Z
 miSxy/jtjdGB8U3VrZw/5Q2oc7zbphye9GP+8af/YTRwyxUMH/2xLBWL2JtMbnxJzem3
 3eYPJR3gaaQV6aEELm8VoESCqT82JVvFuSEMO6kudaOQLGabKBxgbQwx/6fjsoIqJ1qs
 uVrAUNNbBWugB+G5kDCqmVclqWU727UUmh77UkmDxef//xCCd6Uvq8ZyRge24ACVJndU
 Fs8qIDoNAuAYZ19x1hvN80krl7LZcMz9F3vp7KgwQAnaRPq4BZBTMxBXLF2f/Op3IS9f
 3xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431885; x=1709036685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qtvS6V6fNKUkSPChGjLTrgPISzBF9C8NB+nT/PVebg=;
 b=QaRwIDu9OD6VLDWFGgfCROsnt3Z0IdytqCNEMEXPy36BndssgDgmvzjhMXAzEtepts
 t2hUw0jIc+46PPaPALFSrU+jGqXXOBje7ILGhYYfEOFQ1yNUIAaeLgy3MrArjDcLvXAA
 WNhC96Y04+3N41lvTUfDQEFG1a1fY2qlFP7LJuDCOjxsCB4NbOcO1tdHO/Ic/FCRyMFD
 psvdMEIGgZoROIp3qIOGGE8nsTQsFxb+zZ4YewJyHD1N0EvvGkZaEeZtC7anB8r7tbKz
 YNUDjmhTVl98tBnmFzNB8NXGnF3GGkb50SisVUrxonWv7+vntcEFcsDX/+nBSQqAeO3i
 jFbw==
X-Gm-Message-State: AOJu0YzW82RUdw+U5JqrsmsvV0fUPePLg/hNaUCA6OseqpXgs1iFmuEa
 4spR4ROsjTtp/JL/6ydFRWy5J6RvDx2eWKs6uMtutNSLsSnhzfbnNSjc/yNbcLA=
X-Google-Smtp-Source: AGHT+IFM6gFQT9fPI38uScPbt9Qs6t+0Tkpq5Gtftp8ECgaK+QOo3Miak9MHKAjWDdOMMC5T860J1g==
X-Received: by 2002:a05:6870:41c4:b0:21e:6b7a:bdcb with SMTP id
 z4-20020a05687041c400b0021e6b7abdcbmr12046277oac.22.1708431885502; 
 Tue, 20 Feb 2024 04:24:45 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 bz3-20020a056a02060300b005dab535fac2sm5375622pgb.90.2024.02.20.04.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:24:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:36 +0900
Subject: [PATCH v6 01/15] hw/nvme: Use pcie_sriov_num_vfs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-1-2e42a28b0cf2@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
configurations to know the number of VFs being disabled due to SR-IOV
configuration writes, but the logic was flawed and resulted in
out-of-bound memory access.

It assumed PCI_SRIOV_NUM_VF always has the number of currently enabled
VFs, but it actually doesn't in the following cases:
- PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never been.
- PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
- VFs were only partially enabled because of realization failure.

It is a responsibility of pcie_sriov to interpret SR-IOV configurations
and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), which it
provides, to get the number of enabled VFs before and after SR-IOV
configuration writes.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2024-26328
Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/nvme/ctrl.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e9e..7a56e7b79b4d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qdev)
     nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
 }
 
-static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
-                                      uint32_t val, int len)
+static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
 {
     NvmeCtrl *n = NVME(dev);
     NvmeSecCtrlEntry *sctrl;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
-    uint32_t off = address - sriov_cap;
-    int i, num_vfs;
+    int i;
 
-    if (!sriov_cap) {
-        return;
-    }
-
-    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (!(val & PCI_SRIOV_CTRL_VFE)) {
-            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-            for (i = 0; i < num_vfs; i++) {
-                sctrl = &n->sec_ctrl_list.sec[i];
-                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
-            }
-        }
+    for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
+        sctrl = &n->sec_ctrl_list.sec[i];
+        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
     }
 }
 
 static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
                                   uint32_t val, int len)
 {
-    nvme_sriov_pre_write_ctrl(dev, address, val, len);
+    uint16_t old_num_vfs = pcie_sriov_num_vfs(dev);
+
     pci_default_write_config(dev, address, val, len);
     pcie_cap_flr_write_config(dev, address, val, len);
+    nvme_sriov_post_write_config(dev, old_num_vfs);
 }
 
 static const VMStateDescription nvme_vmstate = {

-- 
2.43.1


