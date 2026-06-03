Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5C9CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpTl-0003mF-4h; Wed, 03 Jun 2026 13:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTj-0003m4-No
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:07 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTh-0003FH-My
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:07 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304ec41197bso6188107eec.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508044; x=1781112844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pqPcl/JYvq3rLgNrUErWo/N2x2fhU0/Tx15rYv7kzsw=;
 b=nfe4YVsuaI3c6Bk7uFETU3f4sZjCOwANfCkdq6X6e+ybnmXwDKx9JfZQaloW6mlt9e
 FjkDLKF2TtPggh8fw65O2dAkmShStmgBqJRPIvXaG0lrrJMJhpNbA8v29+TPqA8FdMCq
 NylZR1w3JyVslScCoPjltEUyAX04NJxjM+/UwiT1wWCLN13ZJJ5QM09W1LSPPODZPZum
 GaOOe91ppRXcn0oaHp67Yvx9bsqlyVz3BrfC/jky6j/DK74P3qY+kyOvnKFOWpbYszBn
 BsEYc5YgCJVRblOHY31BYXJxirep7UM/EWmlwuE9LGGVK656RYlwFEbVvRFihbGbfxtg
 t63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508044; x=1781112844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqPcl/JYvq3rLgNrUErWo/N2x2fhU0/Tx15rYv7kzsw=;
 b=I9fc6po8vQTzoiTMFLfSTLnzzRfjufRt/AX6IHfylpGa4zD/vbNOyY5+mZZQT6ecpZ
 1YXG6bvV42eGDVc4v5xTOfBQrisMAvECpA2oKbuzkwocTy7aq4sfDORWMjS0itP9MfMT
 RjisOHCE15tEGsFSX6ASBAObekci7+Vc38CDUstzqHk8gvCGp40sQNQxqqqNM+ofKCVm
 eKt6/ZbYcDbH/d/zzVkggrdZIKES3VmqtcYhJPvIbT97EP0oQuYMQsJNM+ywCn/9zuyf
 +aTFHpdr2/4vjXYVB5Vzcepc1dOWZvi0otbHkW3rcJ/1zwUiR+oxPAyqsAfvaa5wney/
 Fk3w==
X-Gm-Message-State: AOJu0YwN/HnRV+hF+sYmccOPdwjI6Li7ky47R1cvd2yAIXp2dOZtL+N+
 AhjrA1fULrp05q/WhSYvsugFybAdzDK/AgbBgTXOrn5VyQ8lgPDifRBqZUVKUp3/mQ==
X-Gm-Gg: Acq92OHWmmoPskSDagGb7h3BM6posz3l4oblF2DrwqvNKmmpcf9aN/sysyLOInG42i+
 uXAUSHIXRn3Lkli13AWMEUSZe4ZbEg4S6I6JK4wB4+rVc/iTs9DbsqMghnXuOz1cAcqz48LFtsb
 QsM1ZTiPxRxq9nfVibYh2E4HTmr+P9rVaeAdFeyHAAljzLGDC5sgEMC95WsS144i3X6dRKrAdYy
 za7gSuzeHoZl0iz7OJ8nTc7VQEzAjMjhDWakoS4jpKDi5TF+I26f6r5D+6OKlwq+EQ3ODcayjUa
 F9S8edamtme2/BS7WMQFF38FklzCNJmiC9bwr1QuZpe+0BWlyeerPl19tXIzx4xKOqFAcnmCXZg
 ccW5zEZbMgOuAR07JHaQyBjW8h9xMXDS20Maw4PRz2Svn3Dia8jAsAWf1RWm1p6+WsqQpnFQF5i
 K1kfhT1keMA3VAwksTbcS66e9RoBLGmfn4Ygl9JmgLEA==
X-Received: by 2002:a05:7300:320c:b0:2ed:e14:e956 with SMTP id
 5a478bee46e88-3074fc018e6mr2722530eec.32.1780508043719; 
 Wed, 03 Jun 2026 10:34:03 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:7da0:c45e:b5c8:d6e8:bd7e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074d9fde90sm4354810eec.0.2026.06.03.10.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:34:03 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH 0/6] vfio/igd: Fix garbled screen on IGD passthrough with
 legacy VBIOS
Date: Thu,  4 Jun 2026 01:33:48 +0800
Message-ID: <20260603173355.36121-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1342.google.com
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
Tested-by: K S Maan <kirandeepmaan45@gmail.com>

Tomita Moeko (6):
  hw/pci: Recalculate option ROM checksum before patching ID
  hw/pci: Introduce rom_need_patch_id flag in PCIDevice
  hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
  vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
  vfio/igd: Toggle rom_need_patch_id flag on IGD devices
  vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time

 hw/pci/pci.c                |  40 ++++++++---
 hw/vfio/igd-stubs.c         |   5 ++
 hw/vfio/igd.c               | 133 ++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c        |   5 ++
 hw/vfio/pci.c               |  33 ++-------
 hw/vfio/pci.h               |   3 +
 hw/vfio/trace-events        |   1 +
 include/hw/pci/pci.h        |   3 +
 include/hw/pci/pci_device.h |   1 +
 9 files changed, 179 insertions(+), 45 deletions(-)

-- 
2.53.0


