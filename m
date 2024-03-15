Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B63BC54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyib-000336-VU; Thu, 14 Mar 2024 23:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyiY-0002vt-DD
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyiR-00027Y-28
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6ca2ac094so1581111b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710475121; x=1711079921;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oLo7FjY3sQapHlGUhu+VfIZ4mAq3zY4BNX3rIrtFMUM=;
 b=AgCYTazLLbNC9L8xeqxlx+IyM7FWYgslaxBAJ26NBRPVXR82Z2Nl/CWf6c8B8s/VU3
 XlYu5wQrk8tddn51pRvmrK7MxLZXq7nAeIk5kYCHjQUtfO99HTM3Y1JqyNP5pb/6e3Xo
 21iHry9h1Nr6mowQr8b+qQpP+BdXM2hhB4NSPEi14dEqiuBOiiiBqUxYeQ5mzGCmw2AH
 7yXBVy7CVPJXQr2SLUluUINSQ6YcHU05n3jQFSo6w9ywczG1zMudHWvsUGhE/IlHwlp4
 bh3pyo7Blu0enerrp/HSgHWR4+k+CnwrtXuaVqeleTjzlicJsq2EplXUyWl4xvBLC6gy
 Zkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475121; x=1711079921;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLo7FjY3sQapHlGUhu+VfIZ4mAq3zY4BNX3rIrtFMUM=;
 b=GY5glCvjYdRf9K4ryAyse7zocbBhRYz6e7tqjI1XL/B9OXmQCIr30t3zxXZwXo6m71
 jeWj3uHN8usGxIonlNg2tzBjyTof0ZUiSmKrcskXNZ+OBXE0o68do5TYTTJL8FDIIT41
 BGCy48QNUPLZxYtY+YgYnF6NvMudMbpeeFkNnClsu88MnzOHXhoN/PwAEwxX/dlsH9BN
 HoKfa5W1+XzwHtxgtej9mFc5+CbX1qkLGQFfbtUKHkJBu96xKSD8bjQGD5NcS9XKt/Ez
 sTGqn4tJfVTal/q5/xm9X4OMsbDPT8qrO3NWSOhMTnLRZ536hX8y4PVUC3hjABuioObQ
 ww4g==
X-Gm-Message-State: AOJu0Yzt3Sugvw1qOnRqQBPHy7RofbC/mxPpzHGRE2CC6aRi+8uON8Gg
 d8n1pjUmtWv+IqIBRLkL9JlQ+SEewi4MAMmFaRq0h0bv2uWTBAbxWx6dzO/Cx4nnD8pu1CV96/e
 5
X-Google-Smtp-Source: AGHT+IFPbjf86OGs/CjfALsurWtt2/8U0OS+FF/bIPdmxeWiKVYOiN2lOHxCMXQGbdELl9Q54lthdQ==
X-Received: by 2002:a05:6a00:181f:b0:6e6:767f:f807 with SMTP id
 y31-20020a056a00181f00b006e6767ff807mr4370583pfa.10.1710475121530; 
 Thu, 14 Mar 2024 20:58:41 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 y125-20020a62ce83000000b006e6b2ba1577sm2434280pfg.138.2024.03.14.20.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 20:58:41 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Mar 2024 12:57:57 +0900
Subject: [PATCH for 9.1 v9 10/11] hw/pci: Determine if rombar is explicitly
 enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-reuse-v9-10-67aa69af4d53@daynix.com>
References: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
In-Reply-To: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
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
index 64780d1b7933..8708d2c1e2a2 100644
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
2.44.0


