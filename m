Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78242C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHU-0006ae-6a; Sat, 24 Feb 2024 04:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHN-0006Wl-CH
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:11 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHJ-0002UW-6g
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:07 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e4e7e2594cso892000b3a.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766703; x=1709371503;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H8o4sAtnRR5uX1iMzz8pEZTUAdiHV73SVw/pyfxc/jI=;
 b=OH7bXYw7FyVrH2CXtzxfvvew0tmF82MWnK2gbQbXteSdtGY6Q8Wt23npus1mtlMLPE
 jKbdx0vLIaZxmVTceWMo6O37k4/vt+rKHNoGb1TxBymwssHM0pWVyR7CZsrZpBWM2oL+
 zXHY6EIHWefPZKf7NuWDwU7ClMRPG1ktIabA/ORJ4/sma/ajzFFfVAQivgG975Abezwj
 GcIwjOOxBZYAXyEaX7DwWh0oXIO+O52XTD2eqgUXsDiQEeXv6sA0c4FnO8t8dw0ONDsh
 IzsVShX9nikmUoRTtugLPYfO4pZFWP1kuY5pRs3QPXe9sbzrexmKWY8D4wmdOAHqrTdA
 iidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766703; x=1709371503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8o4sAtnRR5uX1iMzz8pEZTUAdiHV73SVw/pyfxc/jI=;
 b=Kx2Lgr8y0YjvtCPrcQ15E6+t6n3bhd3YpvtWW4P0TWvfG+32U8YhOoFnMTDmTCEB25
 hmjeD5cY8QfelctAZuMXHNbPrbpmL6Zim4NHmlF1lHb0WNSzbeN0jmqYvCCPdoKsVZfu
 epXUNxviOZiz8UvsG4viDs8HCy+AjtSdfQFpIa4/BlzPB50rUzCBymylhHwj3mliNwEO
 0LTunVGqjlQV1iPiEIMNFG7APt+umpj5EoBO5kAmd0abfJBjZa7YQO6BO95IUWsLxK+V
 tbTe0PTONgUHkwhGEqoBWzTxUCpCO0bu4bhZnLLkwFWIXS3iAUFxkAm/XGNE1Jii5Oeo
 EThA==
X-Gm-Message-State: AOJu0YywNE5SehDz/3bgywmThwqCBxK49IVxtcvbhTxBJsjTEHbZ70EU
 IBkJOKxjwDnScsCSQKXRiytq4uNVHLLlf+Z2aH7SjiJFEGZAYCHOxNwLBwYgqx0=
X-Google-Smtp-Source: AGHT+IFxWYhWwJ3yLpTl0z5CKKWQCSgSeLdyjmMtfxjQGzkQ2lWZ98/82dejen86VPpSALU2iAMYYA==
X-Received: by 2002:a05:6a00:90a9:b0:6e3:53f4:3ab3 with SMTP id
 jo41-20020a056a0090a900b006e353f43ab3mr2539932pfb.2.1708766703156; 
 Sat, 24 Feb 2024 01:25:03 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 m19-20020a056a00081300b006e464b8aa31sm748647pfk.155.2024.02.24.01.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:36 +0900
Subject: [PATCH v7 04/16] pcie_sriov: Do not reset NumVFs after disabling VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-4-29c14bcb952e@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

The spec does not NumVFs is reset after disabling VFs except when
resetting the PF. Clearing it is guest visible and out of spec, even
though Linux doesn't rely on this value being preserved, so we never
noticed.

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 51b66d1bb342..e9b23221d713 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -215,7 +215,6 @@ static void unregister_vfs(PCIDevice *dev)
     g_free(dev->exp.sriov_pf.vf);
     dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
-    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -260,6 +259,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
     unregister_vfs(dev);
 
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+
     /*
      * Default is to use 4K pages, software can modify it
      * to any of the supported bits

-- 
2.43.2


