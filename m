Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC01EEEC08
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxFq-0006xl-S0; Thu, 12 Sep 2024 23:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFj-0006Rn-7X
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:48 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxFg-0008IN-Tr
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:46 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so239125a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199144; x=1726803944;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NowZm/EG31u8eyDPWUoV8f+k0nmNu308nWwlnQDkLrY=;
 b=cNKvcU9kMeoBKKUH79KmuNKPLr0PvcQlzk7J9XY7siEldjEvqKgtdcg8BRNDBF78Ob
 TcvHqOQlTIAHmO2yyBfcBpRgN5I0rybs36OCjajUToUdJxqCczaQQZeRiAHkuna7OsXF
 ChT5uRobmESZPkn+IbzhjG+brpe3ufFc9zug1jKO1lS9CLL+vAUZjJm713npFyt6lgsr
 npNBBMxIC8zZyqdmkPAkDhkxTkeHISyfhnOpny8ABzLI5Eqe49U3bNAmsyngjsEU+/eV
 46xQWnEVNGy/FrlV3cT4M24WN7tfkZkfNaazzWjodrVbwWWvGtMWZM5vgKqf9Rr3ZI0l
 Dt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199144; x=1726803944;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NowZm/EG31u8eyDPWUoV8f+k0nmNu308nWwlnQDkLrY=;
 b=mcpy11oybIROKLy/kyJXyD+4V/xFNa0qAiKpXTvD8t4P8VC3zy39Yr+YZPIDl9Y3lS
 bGdbO44iN/8/kJNRqk1CGmsPZV6ca7r/KImmShTbTYSuz9Nzc+6ndJVsgj+wLfM6T6Jk
 KllbVCiHptDrplR0zMSv7D/tr5Y3U+pV1HQ2690+dHmmvAvTw6+3iG1oEN4MU15N09VA
 OUuzFKraT3Zl+AzC8dPIaNXpQIQ54dxVY3gIA2sbF2qd91jbNFSPa1Ai8CEp6vK2s7Vy
 Xdmbu0LpQtff2+YrqvQ/FMMnNihM4kcoC+FnxXj9KLpLwDCpgOkWAu/oyGty5i1VrWuP
 PPzw==
X-Gm-Message-State: AOJu0YyOsTMbdUNAh8uNaBx3X1+iVDP7y4AtLFAafWdP+L3AnYtPhziT
 mYvVefGdjJinVClzQP0PVcgIbZ2VUOqDLf/mm5njtojT4e1y9UuQE6rOCi3nKyHgtIKgHraAfVl
 niug=
X-Google-Smtp-Source: AGHT+IF4cqymPAj9UGIKFAW6jLvPO15hOJ9Vmo1TlJPcBccMmj7tR9ZoIceg4Qeagc4HqR2IWHb/EQ==
X-Received: by 2002:a05:6a21:1798:b0:1cf:51a1:8e89 with SMTP id
 adf61e73a8af0-1d112eaf56amr2201382637.47.1726199143658; 
 Thu, 12 Sep 2024 20:45:43 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71908fca444sm5281511b3a.3.2024.09.12.20.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:45:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:40 +0900
Subject: [PATCH v16 12/13] hw/pci: Use -1 as the default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-12-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

vfio_pci_size_rom() distinguishes whether rombar is explicitly set to 1
by checking dev->opts, bypassing the QOM property infrastructure.

Use -1 as the default value for rombar to tell if the user explicitly
set it to 1. The property is also converted from unsigned to signed.
-1 is signed so it is safe to give it a new meaning. The values in
[2 ^ 31, 2 ^ 32) become invalid, but nobody should have typed these
values by chance.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/pci/pci_device.h | 2 +-
 hw/pci/pci.c                | 2 +-
 hw/vfio/pci.c               | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 1ff3ce94e25b..8fa845beee5e 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -148,7 +148,7 @@ struct PCIDevice {
     uint32_t romsize;
     bool has_rom;
     MemoryRegion rom;
-    uint32_t rom_bar;
+    int32_t rom_bar;
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be5295110..d2eaf0c51dde 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_INT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2407720c3530..dc53837eac73 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1012,7 +1012,6 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
@@ -1046,12 +1045,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (vdev->pdev.rom_bar > 0) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
             error_printf("Proceeding anyway since user specified"
-                         " non zero value for rombar\n");
+                         " positive value for rombar\n");
         } else {
             warn_report("Rom loading for device at %s has been disabled"
                         " due to system instability issues",

-- 
2.46.0


