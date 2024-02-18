Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1130DC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZF7-0001yv-RP; Sat, 17 Feb 2024 23:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZF6-0001sn-JK
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:32 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZF5-0004Bl-6i
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:32 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e459b39e2cso94489b3a.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232249; x=1708837049;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R79mO33FGl2f95tPTOgT74nDibLPhhkP4godfeJT6W4=;
 b=s/XYYmwnj4s98OcEfcxZ/hvxI/6lZXNXB9U7dnsKPDGukpUjc5E08UbNXxVxhu9rUF
 awj9N1Aha99V0CmgChzwIT56y6XYhQHfA+QQGPsAutDEHIvjMxjD6SwGh+xezHGiZUMr
 PQOkGLnl0sSwCyZMxf/eZxbU1TuehuE9vwSYPokBYgLv0zt8hZHXukRqDBCHpUiGoyDb
 Iy/+ob1oW0FJt6AY1JUkK8aTDXqK/7rp9+I3YQYRH8iM7kUtTh8RMHWLN+tR7OjWaIc6
 DH6LDLrJeXwrak5I3uVtnpMIuSKJKb4cP18Ot8EfhmBExSnyKJ7ppuqNItlp8kbGUGF9
 30Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232249; x=1708837049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R79mO33FGl2f95tPTOgT74nDibLPhhkP4godfeJT6W4=;
 b=gOjT0yMCISL9Xx+I/TpRIhx6AnI7w0pYQY7fNXwx1RgBGh5MHWZFxI4tKjrX9QEj6/
 ajJORd6q6+PhdqCd8g1e0S2Z2olFVuMu7v4WZ9dBPv53BAwj/YhsWbYcLy9jG+S8bLjy
 cnRwzWBxfP3uFHwgxzx1frKpssfG/eF0+I6i53xQIqX6JAjmVYD87ZBSedxGRW8sAfvr
 5Av8aq7o5w132IUp1TNtJdWx0gqIvWavjHMX+M2M0pKjnWpSF4fakh0Dkvaon/52JAOz
 pUTMtWkpvuDzO+oef43ETTzj9wceGzl+RtUomY6mnsPyXzHck03K7hsPdjndnHYySu01
 m4rw==
X-Gm-Message-State: AOJu0Yw9pA/pkWVJ6y7O+Z0ylZbNz815vWfF0S/m9z0e63EwmFy9dTQt
 iC4n1TrLMxvAexFclDE7ABI0W0ZCanjLwzUPS61OyuEad/h4PPP8ujkFD2mfQVw=
X-Google-Smtp-Source: AGHT+IGHB/HJUnrx/X5NEY1k3D03b9ZH8VfO0fkZOnSq3YXgVkMQDHeqzcPDjnD+OEBJlMD0ZSh6VA==
X-Received: by 2002:a05:6a20:93a2:b0:19e:5dda:6bd with SMTP id
 x34-20020a056a2093a200b0019e5dda06bdmr14200854pzh.8.1708232249507; 
 Sat, 17 Feb 2024 20:57:29 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 c18-20020a056a00009200b006dff3ca9e26sm2385102pfj.102.2024.02.17.20.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:57:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:14 +0900
Subject: [PATCH v5 09/11] hw/pci: Always call pcie_sriov_pf_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-9-e4fc1c19b5a9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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
index 47f38375bb09..3d37ddbb101e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -409,6 +409,7 @@ static void pci_do_device_reset(PCIDevice *dev)
 
     msi_reset(dev);
     msix_reset(dev);
+    pcie_sriov_pf_reset(dev);
 }
 
 /*

-- 
2.43.1


