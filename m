Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4924BC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbT-00010x-51; Tue, 12 Mar 2024 18:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAb9-00006S-92
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAb7-0004Sz-Qa
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WT7mvIjYqgBHqdRAbqMYX7U4dE3tDIe5od3vvmggkX8=;
 b=Mc0LDPwX/PNonZ4OTxYXWi7WIzCjZdJACgOhETrwM4zOgwu1pTRWvnlZrJoeiKOCaaPept
 ccgbCVZqOwGq4qS7ystiE+1OgybwQysJRttZoMAYCWat+knwk5lKXCkXQdNhLib7T2TeL2
 6H/bKZHGnX0rkacnA41mkP3h4lf6WRE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-CmHP_ilWMQatFu2tJRwRwQ-1; Tue, 12 Mar 2024 18:27:47 -0400
X-MC-Unique: CmHP_ilWMQatFu2tJRwRwQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513b15ac4e0so363610e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282466; x=1710887266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WT7mvIjYqgBHqdRAbqMYX7U4dE3tDIe5od3vvmggkX8=;
 b=VIMXEwCHd07RDxQIXUZjwfpjYfn9573pBgQpdo6VStUri4tQtheuk7OQuApxuKUar9
 SmqR+i2wzkgjw8lYmDDk4leXZQNm0XBZ6A1vKLwZ7n9Dven3PconuOqb0Qj2UlsH8w7J
 7HXaqH82VZEYeblEEBJuYz1wDiXzOhQ8ygFrtlNocGUIl0yWG3JEORsn9btQ8BMPJ9BH
 VZobcuUcPE4lirjIw9UiYoe8WRs1gMw++8X/65tzM3Bhc9ob/ueD1JZzT/1dbNi41y6r
 FUo6zRkeqCntrE7lC27sCaAaNxBcog01DgPOLArObq40Qcn+WK3aSv8BMw5ohOyJ9vAl
 8X0Q==
X-Gm-Message-State: AOJu0Yyt2DgxQzRnkqIMTNmbvEwmzjIoQQUuVk8+WP91xOGOWPqNhfp5
 vs+YfchOWBbnS0Js/m/kJcx+3bm8JUjialJwidvpFHn+0xTvUh5d0lqG7eBy8Dcgrth3C0DcubV
 MrAEwn1pwx5lMabUY/6hb+Y+bdDNn2rMtYzXjGJfcwQm9L/9o8wWA8mex9tjLDny2f9D/YTLcte
 Nn+HZyeZnAVIGuWXACeMVyMiC9fahlIkt0
X-Received: by 2002:ac2:5e39:0:b0:513:b574:9421 with SMTP id
 o25-20020ac25e39000000b00513b5749421mr845673lfg.21.1710282465729; 
 Tue, 12 Mar 2024 15:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSYfmj84CJPxIWoLHx29PhQWusG/lj1ODWAbotGSB73/UOaFyGdPnX9oM19wKN5iNZxfLJtw==
X-Received: by 2002:ac2:5e39:0:b0:513:b574:9421 with SMTP id
 o25-20020ac25e39000000b00513b5749421mr845660lfg.21.1710282465220; 
 Tue, 12 Mar 2024 15:27:45 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 la18-20020a170907781200b00a43e8e76825sm4299260ejc.149.2024.03.12.15.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:44 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 42/68] hw/nvme: Use pcie_sriov_num_vfs()
Message-ID: <91bb64a8d2014fda33a81fcf0fce37340f0d3b0c.1710282274.git.mst@redhat.com>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

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
Message-Id: <20240228-reuse-v8-1-282660281e60@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/nvme/ctrl.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 76fe039704..2860a9bed1 100644
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
MST


