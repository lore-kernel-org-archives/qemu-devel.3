Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09ACC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICv-0001jo-Eu; Wed, 28 Feb 2024 06:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICu-0001eJ-6k
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:40 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICs-0007KO-Gi
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:39 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2998950e951so3701256a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120077; x=1709724877;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DmGmO2NRoFLE9iEpGFg0X79YxkUKCW6XJ2bCMIxOKKA=;
 b=Xl6iY+M4RZn7lhiflCYj0FZxOP+6huNX0wqyP//5NSE54JiU3eZZEry34u3JWD2Hxc
 vH2jFJHOoTJQvj6pek+NaTX5LOdJL3RgEu3DMl9t9RYnaFNOStjm/KDWGUtyqqgeD1h7
 TQ6IzHLwug+nv0Fo7e6qcyGmZVoZh0dCV5K//zR7EKuN4jGhQzksbwuqf4mNLxp8vhqg
 /15tnDH8n2/HmcKCmNdIjMTivhOSdDCB2ol+bdiUfkgy/17EQNygknk62+kltoJjP3a8
 qwztCrkVS/rYQ/XECHXxVdF0bukkxUf98ZA2hq5u5qOfTjLWfxiViT1M12Zr1zGtipFs
 ad4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120077; x=1709724877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DmGmO2NRoFLE9iEpGFg0X79YxkUKCW6XJ2bCMIxOKKA=;
 b=t68q7/lvEH+Eki26Mr7Lbr+Nn5G+tyyZ2LzMM6A4bYY9eBbuLxad2FwOTQ1kakNpXf
 v++Mfn4wVp6yxQfNi4UgFRbExKiwq1RpBeBOJcOEBMwkpNdsiNq+MMtj8aPkNJiEe3Un
 WEthhfPHfVXX/vTG1mLMM2pQgEFlwFXjbx1/nnYeyFlYCq0Jrukmu8CHNFUgXU6jtOZq
 xeV8kH3nJpd2TbMCOvC5NP127E7RoHMcZMEtQX+FQ8H20kOiUawh3daa3GSb30wmdq73
 LaQEs9A0/IOOQ4/E5QB9OaQ8vIA0aUX9y/VD7X+SmU/WNU7J5xX0C7hjJdwjCz+5+cnC
 cz4g==
X-Gm-Message-State: AOJu0YwHtTI8sB4RK3I6GvYgFEPBhgN2SEb0ZsnyfmvnkdXdOX9L1WWd
 1svQQTKOdCsnClSfr0nU7kP12uci4MxN9LZe1saFEHIUcVnAQREYuwcKzuQdn88=
X-Google-Smtp-Source: AGHT+IHRGtlJAhcokCxkVkcUONGVdKlKQurt6rFhLt/3v61ekpaSbSrfHlrUbj5oklU4lZBOKMdP4Q==
X-Received: by 2002:a17:90a:f308:b0:299:5ebb:1ee0 with SMTP id
 ca8-20020a17090af30800b002995ebb1ee0mr9212723pjb.28.1709120077235; 
 Wed, 28 Feb 2024 03:34:37 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 y32-20020a17090a53a300b0029932d64c2bsm1492351pjh.17.2024.02.28.03.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:25 +0900
Subject: [PATCH v8 14/15] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-14-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci.

This changes the semantics of UINT32_MAX, which has always been a valid
value to explicitly say rombar is enabled to denote the implicit default
value. Nobody should have been set UINT32_MAX to rombar however,
considering that its meaning was no different from 1 and typing a
literal UINT32_MAX (0xffffffff or 4294967295) is more troublesome.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 hw/vfio/pci.c               | 3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index ca151325085d..6be0f989ebe0 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar && dev->rom_bar != UINT32_MAX;
+}
+
 static inline void pci_set_power(PCIDevice *pci_dev, bool state)
 {
     /*
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f0430d..647f15b2a060 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1046,7 +1045,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (pci_rom_bar_explicitly_enabled(&vdev->pdev)) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);

-- 
2.43.2


