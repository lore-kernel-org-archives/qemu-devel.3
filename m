Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C103C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 04:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyiZ-0002xl-Ag; Thu, 14 Mar 2024 23:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyiO-0002fz-K4
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:42 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyiM-000258-Da
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso11731595ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710475116; x=1711079916;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4udzfC4o8hc15auoNaG3g6zD6/NN7zzxG/2gffAwrMo=;
 b=hmGGEnMpLvMFoLA1Noszt57+RQQwBis0XBgzPLZjEAfTj4hahBsGkD9TUJDgzoXJcH
 7TQcGWAF//jb+EBn7oS8grLPlRJzu6KhCgEnrvyXrIpsPsvPxd77uEt6a1fSeh9dkYyf
 YUoaI3SLolNWraDBRaxPrlnYOT8tlzXRje6GkP8M7PUI7NETKVJQvMoCNX5YeAWzJEEa
 R/xT1FAeL9Vzshj8/PwkC30pP0whPANljshlF0ZeAnHmEDIJq7gxS2X56wrqQ7iyMHfL
 UQRs7Fk1wpufKNmoOELlvdjjZg7/RDFp6HlerYn71C8LEkOIWNiAxNDnvGTdB/ZKHS2D
 Xwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475116; x=1711079916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4udzfC4o8hc15auoNaG3g6zD6/NN7zzxG/2gffAwrMo=;
 b=vABGZKAONIAmFspU01qk8uOqiOguaZnjT+f2J1ElTZHNFif+sTs9HZoWpDScSm9cEI
 i0ccRkPDnprAsdvbxrazU0xMN25zpZ2N1PF98VE1UDj8d3FOVrRq5ne7K69S3TsE0dtB
 b1sOPcCLp9ys3By3ILAmubIvHIGCo3ww6+siuhc9lCfjOiuFThISYYfhGK/MLASPip5Z
 duyc9BVAeeXpLl9GPKTg7Nu2xS/7RFXjP31XkvAYl9frCF9WR1WjOU7sR/a2h2Tpm2zw
 s2yXkQzNa722QCJDnenNeSUE1QMb68EDpgW62ldKBoXtXvJhuQ3jdJk05lKjvqWbhH6f
 s5qA==
X-Gm-Message-State: AOJu0YwJ6f2x+oirAY29U6DD/ql/ZbRhO9Fsq6jcs06yZkVyZe+qQlAi
 BFRcyNdTQGk0sC7mdte2LdKgg4bp0p1pMdP+kINWETQWJoHqYnOxD9uwvIBAJkc=
X-Google-Smtp-Source: AGHT+IG04ULe+P9n7+jUXa7jAVuPiYVC9wXQBgEuc+yRgIUADi0exz2SqtoXxrrHx3tZnnkJmtQdag==
X-Received: by 2002:a17:902:ed0b:b0:1dd:6f4c:c67 with SMTP id
 b11-20020a170902ed0b00b001dd6f4c0c67mr1906323pld.24.1710475116316; 
 Thu, 14 Mar 2024 20:58:36 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 ky6-20020a170902f98600b001dcfbbb1ddesm2609086plb.7.2024.03.14.20.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 20:58:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Mar 2024 12:57:56 +0900
Subject: [PATCH for 9.1 v9 09/11] hw/pci: Use UINT32_MAX as a default value
 for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-reuse-v9-9-67aa69af4d53@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

Currently there is no way to distinguish the case that rombar is
explicitly specified as 1 and the case that rombar is not specified.

Set rombar UINT32_MAX by default to distinguish these cases just as it
is done for addr and romsize. It was confirmed that changing the default
value to UINT32_MAX will not change the behavior by looking at
occurences of rom_bar.

$ git grep -w rom_bar
hw/display/qxl.c:328:    QXLRom *rom = memory_region_get_ram_ptr(&d->rom_bar);
hw/display/qxl.c:431:    qxl_set_dirty(&qxl->rom_bar, 0, qxl->rom_size);
hw/display/qxl.c:1048:    QXLRom *rom = memory_region_get_ram_ptr(&qxl->rom_bar);
hw/display/qxl.c:2131:    memory_region_init_rom(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
hw/display/qxl.c:2154: PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->rom_bar);
hw/display/qxl.h:101:    MemoryRegion       rom_bar;
hw/pci/pci.c:74:    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
hw/pci/pci.c:2329:    if (!pdev->rom_bar) {
hw/vfio/pci.c:1019:    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
hw/xen/xen_pt_load_rom.c:29:    if (dev->romfile || !dev->rom_bar) {
include/hw/pci/pci_device.h:150:    uint32_t rom_bar;

rom_bar refers to a different variable in qxl. It is only tested if
the value is 0 or not in the other places.

If a user explicitly set UINT32_MAX, we still cannot distinguish that
from the implicit default. However, it is unlikely to be a problem as
nobody would type literal UINT32_MAX (0xffffffff or 4294967295) by
chance.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 84df07a2789b..cb5ac46e9f27 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, UINT32_MAX),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,

-- 
2.44.0


