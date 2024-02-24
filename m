Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D29FC54E41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHU-0006b3-Bx; Sat, 24 Feb 2024 04:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHS-0006YG-3i
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:14 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHO-0002e8-2h
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d918008b99so9746185ad.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766708; x=1709371508;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NRg9XEk8ieabjRBH3umLjrDCheGnL9tHvYE3lVOEyqg=;
 b=dK2JwLOHbV7DCcb47B4h+tuYxB9QjaTnEHZL2V05y4WKIpahQkBELrCi8YR40MyJs+
 tVNASwEqnpc1T2A9UvX97IWYn/t/Q531xnbT0HKly0JrmfVJcl0ln8hDv7UTD8K+G55G
 Hi9cHpL1gG1LnbNUEwUCpI2HbMDzA/mpmKSo54BEJqj66rf9ZOSyHo34cGmqJ9KMVkyd
 GYrQF+aTqLjf2kk4tD1+NCea6frNA8iRG/c8/5DcnESvBPijOQCJEI9L17cCIQbE1NhU
 Wn29L83GKmG6a9cOlswihA54CqTTeOlGp7UUU9amZfTZkQx/sg08dmGq+WbuX7QXCVXB
 WO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766708; x=1709371508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRg9XEk8ieabjRBH3umLjrDCheGnL9tHvYE3lVOEyqg=;
 b=vO0C6/iDvroMjjF4hP2nLv0PgGA5mBzXWh4llC+MVv1NNe+h1pX4hihPJtw9HtHQOj
 S9S5CMnUGuYTy5Fzrb3Hvpl900ka3MeLUHBCY0UiynMOzs9GjxoOsLiUFemZ/Qlx755p
 Y4/cb3mYeaaY1hIHqTTkP8nghY56uMhjnBgBo/Ii1mTJnqlWmS/3DQjyHyAlZmFqCgGc
 KQLJeMHhI4PHOm6/MaOdW5/VIHLpiPOoPQNRv1mX38x3kRi17qhnfYSroQREgpVNPIFz
 v3dkNbuN1oyib9itbDHdJkxIzetmd/PdL27iuaOtfaZ4GmNfoiBnt29eh3bokccziB/d
 y0uQ==
X-Gm-Message-State: AOJu0YyeOJ48tqQLvSH8mYNN4yjyZ0nRWVE+vmEPQthirSrDs26nEWfN
 cl5d29lKXokpFZHy2DkC4I8hu7Dju3QeCZKNarXycJHnluMERNKhkWT46ny85n4=
X-Google-Smtp-Source: AGHT+IEsLYDf4e6Hm6YWMlTzoUKCB8FgYxsGM1nkXepLJF9CU0TwZdp5g7ToD/Gc+qO3fgAs0oSifg==
X-Received: by 2002:a17:903:1250:b0:1db:d7a8:8508 with SMTP id
 u16-20020a170903125000b001dbd7a88508mr2441932plh.52.1708766707861; 
 Sat, 24 Feb 2024 01:25:07 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 z6-20020a170902834600b001db94dfc2b5sm665384pln.107.2024.02.24.01.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:37 +0900
Subject: [PATCH v7 05/16] hw/pci: Always call pcie_sriov_pf_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-5-29c14bcb952e@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

Call pcie_sriov_pf_reset() from pci_do_device_reset() just as we do
for msi_reset() and msix_reset() to prevent duplicating code for each
SR-IOV PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb.c   | 2 --
 hw/nvme/ctrl.c | 4 ----
 hw/pci/pci.c   | 1 +
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index 9345506f81ec..9b37523d6df8 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -488,12 +488,10 @@ static void igb_pci_uninit(PCIDevice *pci_dev)
 
 static void igb_qdev_reset_hold(Object *obj)
 {
-    PCIDevice *d = PCI_DEVICE(obj);
     IGBState *s = IGB(obj);
 
     trace_e1000e_cb_qdev_reset_hold();
 
-    pcie_sriov_pf_reset(d);
     igb_core_reset(&s->core);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7c0d3f108724..c1af4b87b34a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7114,10 +7114,6 @@ static void nvme_ctrl_reset(NvmeCtrl *n, NvmeResetType rst)
                 sctrl = &n->sec_ctrl_list.sec[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }
-
-            if (rst != NVME_RESET_CONTROLLER) {
-                pcie_sriov_pf_reset(pci_dev);
-            }
         }
 
         if (rst != NVME_RESET_CONTROLLER) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca61..e7a39cb203ae 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -409,6 +409,7 @@ static void pci_do_device_reset(PCIDevice *dev)
 
     msi_reset(dev);
     msix_reset(dev);
+    pcie_sriov_pf_reset(dev);
 }
 
 /*

-- 
2.43.2


