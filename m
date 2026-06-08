Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7532CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaIx-0001by-RY; Mon, 08 Jun 2026 09:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaIx-0001bk-0Q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:15 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaIv-0001lc-3k
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:14 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1370417c01cso5706337c88.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926371; x=1781531171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zEGuC+Jny7b6IIsRk4dbcY53yUmkyzYkwxTav5FaldA=;
 b=cAIIALSWhSDuh4IgOeLGEgnbN+ZFbftHtf1t27iEup41L5ds3E9vmk1pbg+EsAoHNE
 eC/YyX62O77zotbxkpXRKdopI6ooM5lnq1UounApKZMNV5+TnIceTM1pJgsLZuXbapN4
 yEoxi6TZoHQzdGE7OVqHXKC+vbI0vIp1E9okAA/56jUiPhHIaHO5jnYsT8wKnHe1DTMv
 UQs4vHSOQ6ajhVkPJSZXwI+fos2zYiWGrOy4jn4zgYxPmA+6GHjOenbvIklk04nwMci+
 sZpvCL02Q/TF2wUxwGRmhISSlRMBuhZNYyPeRQ4EJ24avA5I54XY9YMp0os0BNyVhoeg
 j3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926371; x=1781531171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEGuC+Jny7b6IIsRk4dbcY53yUmkyzYkwxTav5FaldA=;
 b=hpm9f8dYFwfSUeKUY7W8ZsbnFP2jTAkWUucO7bybeP9SRXOcv+1x63ASsr5+eMVlAI
 mLx11gA4WRi08CtIbUkzpKfczaSHhkK9vNrFhaMI2pLTAYiLkP5qlSGxVDJSentFKm6w
 fXdUEDecDFj5EY6se0CiKAFlG5mVsqWe3t82XyOAA8hK03XCYSkpmobd2kKryR7NnAeg
 aS79Rd+KUHdSFidvZs6rXQh9ScmujS3O7WtfJgiNe9xC0lDAi0XncFiNY3M6/Y4+Q3eX
 ymhWcInPBHe/0Y96gxU8fqdOz3VMYbTQtPnAqjYc3+Z3VW8DOby2AOKU2ZFIcZxtTtst
 n/qA==
X-Gm-Message-State: AOJu0YxlqbxE8IXRCiywo37LZ5F18NW07Nn9t0O42d2qQEONJ7BpMmlN
 hILXSk9/DH/ZiZhiOEMZ+KgBJeL3NBpPtTUlY+fI2bw1epQ7GaoNBIzbFzzAbjm8ig==
X-Gm-Gg: Acq92OGDN2DSCKI4Hcm2cI7onaEs+4PgKOp4eDnybGSDpVUttoJDgZ8zGzN3SSQIC3j
 7HHFjhxUNa0bt/1yERDDsPiWTu86rD9EnThpXbosiT7TJegNGxMtZX6/qEvW+dQHPF8lXy78TFF
 MYISDcE1BBzW5/jqx4aScvgH22XrL+cP2rcEgKBjqsi/Bcibukab02ataRnFGfyeLiT2A5Xs2AN
 LYk/OgDfTjbcDwRkq6VF/YpuuiM7PD+oJbSdj1bSmRLiRp94lDW110mjINM2CWrHExGDds4PLVL
 EbJs8Q40w+Wj6+xAfq1Nu/9eBR2ALMCcU9TXt9jsvLF5lIHFoQaHiL8a/Ud2DFqN6JO1Es42i76
 zSvy4+0pSKJECcTO5LSKRV6S/opHNMfsMYDjfZ7NMC+/IJBHPXc+ZOfaALrFq4RDmgTlQ+ZT1v8
 ntERfvArKO0bLzE5HpUq/LJxO5tqviQDMslSDIZ6sX8g==
X-Received: by 2002:a05:7022:b9b:b0:137:f958:c072 with SMTP id
 a92af1059eb24-138066dfd6emr7995208c88.20.1780926370503; 
 Mon, 08 Jun 2026 06:46:10 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:09 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 0/7] vfio/igd: Fix garbled screen on IGD passthrough with
 legacy VBIOS
Date: Mon,  8 Jun 2026 21:45:51 +0800
Message-ID: <20260608134559.23971-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1243.google.com
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
v2:
* New patch 2/7 to fix regression with EFI option ROMs
* Refine logic in ROM ID and checksum patching
* Reorder patch 4 and 5 for cleaner bisection
* Address comments from v1
Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t

Tomita Moeko (7):
  hw/pci: Recalculate option ROM checksum before patching ID
  hw/pci: Skip EFI option ROM in pci_patch_ids()
  hw/pci: Introduce rom_need_patch_id flag in PCIDevice
  hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
  vfio/igd: Toggle rom_need_patch_id flag on IGD devices
  vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
  vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time

 hw/pci/pci.c                |  58 ++++++++++------
 hw/vfio/igd-stubs.c         |   5 ++
 hw/vfio/igd.c               | 132 ++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c        |   5 ++
 hw/vfio/pci.c               |  33 ++-------
 hw/vfio/pci.h               |   3 +
 hw/vfio/trace-events        |   1 +
 include/hw/pci/pci.h        |   3 +
 include/hw/pci/pci_device.h |   1 +
 9 files changed, 188 insertions(+), 53 deletions(-)

-- 
2.53.0


