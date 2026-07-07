Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51FFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Hr-0005X0-9q; Tue, 07 Jul 2026 04:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hi-0005Ji-R2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:07 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hg-0001p6-W0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:06 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-381072761d4so941537a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783413362; x=1784018162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q+8L/1Mhrh8RPvJ2L2F8WHPLOoDi9uISG906ORgxxCc=;
 b=crtV6/MCjNZ6LSjlxlccAD34N3Q/E2XkflTLLyKiMzjUHZdPJQVLT38uBGX1pywo+J
 FmFLgoxisjVceFYyc+pIEKVTbh5bjk+U+NmE5SJQosEEKfs+vlSreXtjXOdRF196FPKi
 njZXotjvS3gS+mzo0vM0FjC8NuBcbLlgWf8yAtgELJb8FnMZ9B5EdC54N2J9jgfIHZm0
 ZI+kxOG2HTVl5ivKDjztuvDazfw7UCHfWyVUT38LKrVvD+hQcUWPkFhuG48811hiO8zB
 uoKOUo2HCgq+C6Tg/xqpsu0fjm08yWhL55P+JSUYzOyzQ9GMtKiKNbxLKj2rrazMspfv
 i/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413362; x=1784018162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+8L/1Mhrh8RPvJ2L2F8WHPLOoDi9uISG906ORgxxCc=;
 b=PyzwxvMdTzRTvTEKjbnE1Hyl7IB5Fn2UnMo9CqBmtzYyrE5o3C27fqjn7kiVVJ6xKa
 Z6wa/KKFisNs2+zI+nvnB0CNgrCpt3ctt7hwdQXq8SZiXUeY7lyIOWqlk4THjRkxUqWl
 Wl4ouoJMpfIwhPwBb/MX7nv+jJgqZKgGKzZ9Lwk8Oc3X/qeFibnOrFNV3Wn24RCbwp8y
 EnFtzsxrRz0iWuPtsrIriM6BXzHubIFKy9lKUx80gWlU7SDfXuhjJknySMJy544DPGx9
 hg8y294K2sbABTAXASmH3KKuz7qEKDNmfPOFGcWicVBBMp/tRXneIW814hBbKwybOTDR
 z6lA==
X-Gm-Message-State: AOJu0YzOA7TuAnF/1cdMZ4ITJva3CavRr4Nm0lICKvFiH8ZAF4Qanc0L
 PuAqxyQE1jaOVZh+slrUemVelU38HfQ6PIVWyT8NBBeSKn1BWKJv80AYA2/D96g=
X-Gm-Gg: AfdE7cnCqJ5ptm4CLxaI4kWGT0m7ggGuERYDz9O3r3fLdBmpFoAqGaMUBBgyyqJDCxv
 Tqw75vpD5zMC6xcl+7tG0tHO1IV6LcZqCsRH3WX4SHci2vHGlIBqRzUCM98eBOKBvUivM0WYu4w
 tIpyvV25UihJRs6VfPDWI5fx8IbGv4BCN63vHFmbp75ymmsV3q9D8q4eV+G4+Kxyi/DfdCn5eQi
 aG3Wx68/MViwgWlc7W/OeJEtXr4Mzen5e1mua9ygwQ5HRjFgpv3H+HHBwsUNttMYn2C5xUZgmiC
 6/1u3QwV9/jbWvDJlTdUyxVSewZH1Gumk1f9CIgN2OSaQPJoYY+sQEVbADWUoMmpRHpz1fTI26z
 tNitShT8hb0/xzz4N3OdtgOETy/L871dg76HAJBPavgLg/5i34gF2stfPaa1lfyVNcmV4a6zApN
 U=
X-Received: by 2002:a05:6a20:9151:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c08ed07f2cmr5144770637.21.1783413360802; 
 Tue, 07 Jul 2026 01:36:00 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590::9a0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483e0a2sm5435221eec.12.2026.07.07.01.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:36:00 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v5 0/3] vfio/igd: Fix garbled screen on IGD passthrough with
 legacy VBIOS
Date: Tue,  7 Jul 2026 16:35:47 +0800
Message-ID: <20260707083550.25765-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series fixes the regression that on IGD passthrough with legacy
BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
(which uses standard VGA output routines), starting from QEMU 10.0.
Though the kernel i915 driver still works, it reports an error about
the initial GTT programmed by VBIOS is using invalid address.

i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])

With the help of AI disassembling the VBIOS image dumped from host, it
is found that the VBIOS itself implements a routine like:

    uint32_t get_BDSM() {
        static uint32_t saved = 0;
        if (saved != 0) {
            return saved;
        }
        return read_pci_config(BDSM_REG);
    }

And the saved value is not cleared after initialization. Given that IGD
devices don't have a real ROM BAR, the VBIOS image read by default from
host is actually the VBIOS shadow RAM region, containing host-side
modifications like the saved BDSM value above during POST. When the
image is executed in guest, it still uses the saved host BDSM (HPA)
instead of the value programmed by SeaBIOS in config space (GPA). This
address mismatch leads to the garbled screen and i915 error.

The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
to guest, a ROM quirk clearing the saved value in VBIOS image is
introduced to fix the issue.

During debugging, it is also found that IGD VBIOS ROM doesn't always
match the actual IGD device ID, due to the fact that IGD of the same
CPU family has multiple device IDs but shares the same ROM image.
However, SeaBIOS checks the device ID strictly and refuses to run if
IDs does not match. Currently only the default path, reading ROM from
kernel patches the device ID, but the romfile path doesn't. So the ROM
ID patching logic is also refactored in this patch series to also handle
the romfile path.

These changes are tested on Haswell platform with legacy BIOS boot, by
K S Maan. Thanks to K S Maan for continuous help on locating and testing
the issue!

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>

Changelog:
v5:
* Keep the current ID and checksum patching logic in vfio_pci_load_rom()
  since it is not IGD-specific, as pointed out by Alex. The IGD-specific
  quirk is now invoked after the generic patching. The ID and checksum
  patching is duplicated in vfio_igd_legacy_rom_quirk() to handle the
  romfile path, since the generic patching is not invoked on romfile.
* Picked up the Michael's Acked-by on patch 1.
* Reduced from 4 to 3 patches.
Link: https://lore.kernel.org/all/20260701182035.96010-1-tomitamoeko@gmail.com/t

v4:
* Reworked per review feedback to keep IGD-specific workarounds out of
  the generic PCI code. Instead of recalculating the checksum in
  hw/pci/pci.c, a single generic romfile_fixup hook is added for device-
  specific ROM patching. Now both kernel ROM BAR and romfile paths share
  the same quirk, so the saved BDSM in user-provided romfile will also
  get cleared.
* Reduced from 7 to 4 patches.
Link: https://lore.kernel.org/all/20260617100646.28326-1-tomitamoeko@gmail.com/t

v3:
* Refactor ROM checksum calculation and patching logic as Alex's comment
* Fix boundary checks as comments in v2.
Link: https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t

v2:
* New patch 2/7 to fix regression with EFI option ROMs
* Refine logic in ROM ID and checksum patching
* Reorder patch 4 and 5 for cleaner bisection
* Address comments from v1
Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t

Tomita Moeko (3):
  hw/pci: Introduce romfile_fixup hook in PCIDevice
  vfio/igd: Patch device ID for romfile-provided VBIOS
  vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time

 hw/pci/pci.c                |   4 ++
 hw/vfio/igd-stubs.c         |   5 ++
 hw/vfio/igd.c               | 129 ++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c        |   5 ++
 hw/vfio/pci.c               |   2 +
 hw/vfio/pci.h               |   3 +
 hw/vfio/trace-events        |   1 +
 include/hw/pci/pci_device.h |   1 +
 8 files changed, 150 insertions(+)

-- 
2.53.0


