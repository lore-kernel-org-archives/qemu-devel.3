Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC28C54E4F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoH7-0006NN-Iq; Sat, 24 Feb 2024 04:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoH6-0006Mx-Ob
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:24:52 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoH4-0002OO-4A
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:24:52 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso994374a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766689; x=1709371489;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WM47wdy4Cb/mp1eobpOxgb3rFoDQbhprTWLPDZcJhAo=;
 b=Jw5VziREcZXm+KaeC7Nz/u4JKI8auv6uWSEVcFwK4zFd7Mm1K5/WRPBLx5Pcs7KACJ
 tOu8sGkBZuZmvgZ4wl4Iy7xrhQGymoYLpdTlLqr+yyxj6UR8hLbbund0sdac7oIjAuOH
 2lkmE7veBV5kR8pbfiJdygDO5y4azYzmpmZfLRAhn6OS1CjYdtH1NLqaWHLUdLmTXjWw
 t2DhWSf3NT4EJJfjVb+iWUIAFIV275h31y5yHiWXhzTgYSTBqj0LIFucLkyD3QRlw05O
 A7cDBpheOCVu3IzRBawf5ZSisaSVxKLjqVJRpl8mWufUK6XLfmUmz/uAbTNTDF3kfE1M
 6OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766689; x=1709371489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WM47wdy4Cb/mp1eobpOxgb3rFoDQbhprTWLPDZcJhAo=;
 b=wmrsQScFZO+TCGtKD/itlvHuEyVn+LNbSJ7SV729WzHg5viUWe9RZUBzNaEUBisVeC
 h6+U/3dHOpJlnzrU+/mMi6mQcvj0kIjGroiLVgn7KuukYG4CVy/sKL5XnBeBIkIosy1c
 MUYF4laEovCsvYLDQaVO3PeS9HfNfMFq1zSWiuPcd1fFS5DxQU78hM34mtf7sNxzP5jG
 UGC6o6Z0KglSieZnoRz0sg59ghh/bxaZDRzLtG8+Cd9DjyvmHEc6t3Cfw8BKEy/cyOXA
 mfrGbDrLdZMaNG7v8URfhIzsj0t8UdsbV7WUnmKIDBuGU/mbSCGtAcYHzYTtDIj6RL0J
 GbOg==
X-Gm-Message-State: AOJu0YzYPYAIuegVBLMw/bikxuQ4h/D9pySJmpXIoVxKXbMwdXTQN/Ig
 /tnpQ4I7qMNXgsZpwFyjwdm8dgzY3csmfUp9BqGUpor9oEY75OMLfxdwlrbkUjo=
X-Google-Smtp-Source: AGHT+IE0yG8WWCvGvj47WhDiA+0B4UNhyixLdJAXLuDFT+Ng66ZIyT7oP0LQaIceIuM1RtGwsf3BfQ==
X-Received: by 2002:a05:6a20:e507:b0:1a0:cce6:d526 with SMTP id
 ne7-20020a056a20e50700b001a0cce6d526mr1998665pzb.41.1708766688891; 
 Sat, 24 Feb 2024 01:24:48 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 fx3-20020a056a00820300b006e47e57d976sm745892pfb.166.2024.02.24.01.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:24:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:33 +0900
Subject: [PATCH v7 01/16] hw/nvme: Use pcie_sriov_num_vfs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-1-29c14bcb952e@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
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
2.43.2


