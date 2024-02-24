Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A43DC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoIC-00089d-Gh; Sat, 24 Feb 2024 04:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoI8-00082q-Ev
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:56 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoI0-0002ze-6p
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:54 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e332bc65b3so975470b3a.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766746; x=1709371546;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aXVXrZfj4eKut/1F5S6KzL9XetrG4kGGwxBLnYRlsmU=;
 b=koKY5rCILSXIDf7Q7f5lWcZY2QsT1yQP61oz1CnAxMdM/z9uzkgEn4aWpZ2DBiNN5H
 CpNm/8HCjzNCJT2O95x+bQwuwPDkc7v/yZrRn9aNnl6dislyzEw7gqJaCtNibuIRsvgH
 OMuCFkgTd4r29AJorDAcaM4ERBOmjAUr6SiHDLmopSdVYR09ZnUGZrvlmhvts81hSyRb
 QqvwawZyIBqkLm1DnqUZHciFYiUCmS6pEu4lA1KTKQ0byxaJIk8n2DeOarFc4G5Cu6Ab
 FjW4hJ+ie/wHm3CGB7fL6mRakb+uYj+l+bHFSmAfrBkYV4VAULEqyee4kgWNcjWopGRe
 6vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766746; x=1709371546;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXVXrZfj4eKut/1F5S6KzL9XetrG4kGGwxBLnYRlsmU=;
 b=XnrXG2viEnMv8uUcKVXkPTQ+XhhVwY/MTJy/mKJn7gSjsMQVdCTOYdwxRuRXv0BEIH
 c2YPrVyq1IFjV8qVA+QsUSjeiSPUzg0KHIP9MMiDzS7ipC/Lwv1iyJ8vlELw1fJ10CFC
 TERd9E1RcVUdgQDLJOL4CuCCiPxN+lAH27lum0GfFJOXDQ9TZFeRhMjRmkPQaQcC0S5t
 avKqx5dOgjD2YYLhrdPF5/VbVO2rx83nyWNkO+au34Yh5iQ5K9QudAluRs+r4HcBLZYD
 2lCA6xK+ucPIkNjfI1aI0vuGKY08acfedcgU/hwaI+I8uvgr1jjpSiqyxI+8Frns9Dos
 5fTA==
X-Gm-Message-State: AOJu0YzEflw7Fc0IIoWv/tHuTIAhpgtVXEF53C0ZmaDHZwzYnveuzfDu
 AilRYQhYr5dYxU+smN+dKIfXuX884pa98NcoI6CiOkvUGuPufMn1PVZ3RLjpJxI=
X-Google-Smtp-Source: AGHT+IG8Fg1diNL+lpUWIgGXrNLRULOAB+Rl/E2osOya7ajPjPG14rnRAW1Wc2fIUq5U4H5OgdT/hw==
X-Received: by 2002:a05:6a20:9c9b:b0:1a0:e70d:2e3 with SMTP id
 mj27-20020a056a209c9b00b001a0e70d02e3mr2314310pzb.23.1708766746658; 
 Sat, 24 Feb 2024 01:25:46 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 z11-20020a1709028f8b00b001db4433ef95sm668912plo.152.2024.02.24.01.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:45 +0900
Subject: [PATCH v7 13/16] hw/pci: Use UINT32_MAX as a default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-13-29c14bcb952e@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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

This changes the semantics of UINT32_MAX, which has always been a valid
value to explicitly say rombar is enabled to denote the implicit default
value. Nobody should have been set UINT32_MAX to rombar however,
considering that its meaning was no different from 1 and typing a
literal UINT32_MAX (0xffffffff or 4294967295) is more troublesome.

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
2.43.2


