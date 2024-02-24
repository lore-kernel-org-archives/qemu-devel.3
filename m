Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04B8C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHo-0006zo-RB; Sat, 24 Feb 2024 04:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHn-0006sB-Hq
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:35 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHl-0002oK-KA
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:35 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e480d8fb5eso613222a34.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766732; x=1709371532;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n60IjDHaz7q1D7DDq4+a1GNpkeEaPlCZ35n5E8Xd1EI=;
 b=hawbZw3ltC1vLqu7Y1Km9MzJ5lRFV+TkAqTj6N6J+CbMdkPH0Dkalv3bmOC1OAWJXh
 TucbFC28RPaCw6R1O2XNZHwEbl5u/mVB8APnQIBKjiYIkaIhWJPqgJud9JB140Pm+MN1
 7FzNIZHnAsJC1EKe+b0TJGUr//1xgo3EtTg7MuEp9ykp65AdcLg/qr9LlQh0n4gCm2ZH
 GnOaUv+MtEommQnxQC6TMVrln2cZs9fTIZzn6zcx72ZmAmcjfKd0efokbaY4PVJxmRgD
 B+cJ2KNaSC146HsiuDQBzAYH12lj319aqNOCkbakJENPejs4C2hE9lsfSP4aJNVSf8L6
 tDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766732; x=1709371532;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n60IjDHaz7q1D7DDq4+a1GNpkeEaPlCZ35n5E8Xd1EI=;
 b=N/F5ifPusHiltjHDsfCrbE8xMAeZhlLEAb5/zRZLvZupPAAiXlhrAjn4a4kBXjcLso
 HHpFvLM5JVSs/rpFpCMu6oHlxF4hSnhbGLsCU2/ojxLNEJu9kHQObQSk5sRbbBYpaUUK
 XA64RxPRz2AmPvYtaIMYm6yQA6x2p6ujvVulQmAVVMlyXRGHuzL5oxPbNO1piBwsyJHd
 oYPN2BrV4QcAi/2MSaoPy8KRHX4XoW9QGGemE4M6nJjOqnyCPLgKa+KmWvPQbDxL86KP
 UXNR1ToTUgD4NJqeHjnvlWy+ZK6FqNRLWWxO4vmknHFTluQ25WTpYqXrAuRuY0YP5DAO
 Yusw==
X-Gm-Message-State: AOJu0YyXJuAWU2atnn+DDMoUG3YBygvuSOcbJwLlOtUIJBAc/g+n/lrT
 DCvrSJxjBrC0jOJeHVOgjDRiJo3KXJElT030vlI0fOWR2m07ywYmAYHJY3tm1oI=
X-Google-Smtp-Source: AGHT+IHjN4F7A3iO7k2KwRkpU+hK7lgyuweJIrrQ16RFAFo6eQbcfyn+o1peZZIm9GWiMDES/xHCxA==
X-Received: by 2002:a05:6358:7618:b0:17b:304f:b3d with SMTP id
 r24-20020a056358761800b0017b304f0b3dmr2568082rwg.23.1708766731909; 
 Sat, 24 Feb 2024 01:25:31 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 gu17-20020a056a004e5100b006e4e584ed59sm743082pfb.116.2024.02.24.01.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:42 +0900
Subject: [PATCH v7 10/16] pcie_sriov: Remove num_vfs from PCIESriovPF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-10-29c14bcb952e@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
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

num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pcie_sriov.c         | 28 ++++++++++++++++++++--------
 hw/pci/trace-events         |  2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 4b1133f79e15..793d03c5f12e 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -16,7 +16,6 @@
 #include "hw/pci/pci.h"
 
 struct PCIESriovPF {
-    uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 };
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 8710ee95b26d..fb48c1a18c9a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -44,7 +44,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
-    dev->exp.sriov_pf.num_vfs = 0;
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -173,6 +172,12 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
     }
 }
 
+static void clear_ctrl_vfe(PCIDevice *dev)
+{
+    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
+    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
+}
+
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
@@ -182,6 +187,7 @@ static void register_vfs(PCIDevice *dev)
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
     if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        clear_ctrl_vfe(dev);
         return;
     }
 
@@ -190,20 +196,18 @@ static void register_vfs(PCIDevice *dev)
     for (i = 0; i < num_vfs; i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
-    dev->exp.sriov_pf.num_vfs = num_vfs;
 }
 
 static void unregister_vfs(PCIDevice *dev)
 {
-    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
     uint16_t i;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
-    dev->exp.sriov_pf.num_vfs = 0;
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -229,6 +233,9 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
         } else {
             unregister_vfs(dev);
         }
+    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
+        clear_ctrl_vfe(dev);
+        unregister_vfs(dev);
     }
 }
 
@@ -291,7 +298,7 @@ PCIDevice *pcie_sriov_get_pf(PCIDevice *dev)
 PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 {
     assert(!pci_is_vf(dev));
-    if (n < dev->exp.sriov_pf.num_vfs) {
+    if (n < pcie_sriov_num_vfs(dev)) {
         return dev->exp.sriov_pf.vf[n];
     }
     return NULL;
@@ -299,5 +306,10 @@ PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 
 uint16_t pcie_sriov_num_vfs(PCIDevice *dev)
 {
-    return dev->exp.sriov_pf.num_vfs;
+    uint16_t sriov_cap = dev->exp.sriov_cap;
+    uint8_t *cfg = dev->config + sriov_cap;
+
+    return sriov_cap &&
+           (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) ?
+           pci_get_word(cfg + PCI_SRIOV_NUM_VF) : 0;
 }
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 42430869ce05..b30e31619787 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -14,5 +14,5 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
 
 # hw/pci/pcie_sriov.c
 sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
-sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
+sriov_unregister_vfs(const char *name, int slot, int function) "%s %02x:%x: Unregistering vf devs"
 sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"

-- 
2.43.2


