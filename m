Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A817C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7ak-0005oH-NH; Wed, 14 Feb 2024 00:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7aj-0005ns-6n
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:13:53 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7ag-0007oq-N9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:13:52 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d7393de183so11843855ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887629; x=1708492429;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=izEY9a2th2CCeu2Q299I2utX7A1cTWXGb6PxvgTVHgg=;
 b=sBQw5F9WFlFOw42oYt7DGO91nc4vwJVJ6LjQJrRVaKQlHIaM2C8ipv/YGQh18C2euQ
 7zX6mP7iR1tRPdBjbFQr8DKiPNchMJWpcwNkyw8TGpxbHpmyM9vJnAxy+L08bQ6emeKL
 iWIkaJZIfWvHhFf0vD/N0dwd1P1XUeZDgpxnP2Ucasi/3xcivEwqUAvC16/6mdcMuIZt
 zXRq+LzBw1HTpMOZiKmgnCnxzaggo8h4O/syDlYXgbnS6IrC6bL5S5nIRPwu9MH8wV2M
 bHUX1qopXeLp2lqmrfaOGk9gVkuAv8dsyObotkxehBu5KiVN7zm6BoKZutOHf1kD6siP
 LtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887629; x=1708492429;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izEY9a2th2CCeu2Q299I2utX7A1cTWXGb6PxvgTVHgg=;
 b=vViEFt+Ds/E2HCY7zfqkkwKV/oZ+1U2MaIbMBe/cUK5/nKv1KS5Wk/3W68mv38xHRM
 +yU34pQVCndyPG2B1uNxoLkdZfv924aiNxXuiqkiiaGlwXDCupC791fOZXD4bPOd1rNC
 bBiIKVVHxWkciWZt9xhYn6YeQkxvVrfj9LZCLhO2YRNh7dhQIhaqetBs4vEhyIlltKlg
 DCb5aCWOPXNj0ZynwG7DmELX6BMLDsMfQXG+iol15gEy3SAk/ZRzP32zXS8vAuKIHGYq
 fBBiNKKDPVdok0LdjsDYzK3uzqd9v3fbKE5bpTftzjnH58YYpxVpUqU83X1HfmAsxVDW
 E7vA==
X-Gm-Message-State: AOJu0Yx05N2jlxHh7kwM2hHAXvCXmo4dTU7yGGWXGce+08Dd7fI4iJA0
 MU2twpGa5PezCA0lEgb8gcY2cypX0Qtrgq/y/rgfaRA4H0gTSj5GjvLJEHgLT+5RPimnkNzVsxK
 0
X-Google-Smtp-Source: AGHT+IEilZlzkpak2Q/+B9Nxii1tWMpMCbZgo0JMZnOuotqp/pL7966w26A5/a6VCM2mGUGvlOKrKA==
X-Received: by 2002:a17:902:d507:b0:1d9:5cfc:ac6a with SMTP id
 b7-20020a170902d50700b001d95cfcac6amr1590510plg.69.1707887629400; 
 Tue, 13 Feb 2024 21:13:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWP2eXgsHAdF4zTkFVmUWm2/dCf3NzpqgT9WSQzkuazJLtclDHkbu6LZMm6JLDx2U6PrU/hwu9yGwn8wm5q5Nbrv/BearPcpmdHY+m4mM93sbWBiP1CxpIh+mCinHO8vvW55Oqil5iLCY7a4iRFbY3Lr/bNmPiQXnmZRlrt6LWC6D2niSVxjnKtPgjUQhMBbz45fRXkWqZjuG/RiVfmu1CFAE/lUDAG6v5XA+xbD5ntv9KxcroMn0isySbCgfF+sA3btmnBDO0IfAS5BCr2j00LzYpjRIJe+WpXuQGl3s7FxgY0Dztfde7tzUKaTjV1rEnVqDnwpZOJd6TyHEKztM2HucsXkuUEhwWE71tZ3u7AuU0mVVBIG64GyPEV5B6aAQga/l2NyYWEYC/bWAa8uY9dSi5udiTsCsFhdrku7lgLmwrV+5qzqN+hv3yJrKk=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 kh13-20020a170903064d00b001da2924e576sm2874122plb.204.2024.02.13.21.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:13:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:39 +0900
Subject: [PATCH v4 1/9] hw/pci: Use -1 as a default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-reuse-v4-1-89ad093a07f4@daynix.com>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
In-Reply-To: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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

Currently there is no way to distinguish the case that rombar is
explicitly specified as 1 and the case that rombar is not specified.

Set rombar -1 by default to distinguish these cases just as it is done
for addr and romsize. It was confirmed that changing the default value
to -1 will not change the behavior by looking at occurences of rom_bar.

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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca61..47f38375bb09 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,

-- 
2.43.0


