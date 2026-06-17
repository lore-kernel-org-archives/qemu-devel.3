Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092B1CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnAk-0003ov-R3; Wed, 17 Jun 2026 06:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAi-0003oJ-CS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:00 -0400
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAg-0008Ny-Eo
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:00 -0400
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1370417c01cso7227092c88.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690816; x=1782295616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gVL7sFFHpbCPmiC5axwMOU1jI0SPrKvF1e9kwllJLYs=;
 b=lYzIB9ZCODcgbdKvb45JYqkNeFReHLQYHtXB8DGVCep+lCfO0SkHgt5aU202yFqEFn
 Y40J2a66pdLEUQ21Zl/hOBCxbyk9bK/hLNcszdl/YBdkl+iswzgpuegf8ZCZepslLbfq
 Cxy1zMSED+JdP4QqK2S+xH93EaDR86JZmdDhYqlktOHAvNu48YMnYRGBPzUPR1SmBuwD
 AesqHrXYXhhfoVpjvoiiSXGcTE00v2QgzeHBo6J47NxFkdW7sCELRTdvC2Wai7uzH4s2
 thrjyZbDI/FzvacBtSG8P2TPp80jwuex55bZBBo5DzOA+9gwp10MuqNzhbiBiR8jUTts
 Wauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690816; x=1782295616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVL7sFFHpbCPmiC5axwMOU1jI0SPrKvF1e9kwllJLYs=;
 b=LgBCLynoDKa+skyhUCYUQ4W1WDdS1jpslEUMnkQsgbYxiGVRft/H7PJjlb8UM84JML
 UWRXYKZz766n9YC/jTzglPZd6PQ/FnRW0t0HnfMh0oq8/781CGcsZ2krX3gAalxDWcPJ
 dhm0fhw/m7xTWBy1EgAJzX8c+spB/j2F6NwYJOTgFSqXqJe8Q8VZ+TEn1YeKra2Ta/+W
 sqVkWLJBihzYpjeOBJd77dUC9RMVZqtPYp3vfFjkfUSZs0S8lPw8du8fOddmX2XBXk9G
 gOrmshqEDhbQ7nJfybEgbnoF23jzODV30CqGz9aged7zo1CjaxGwU2IaqaHfvr4PN2E8
 3NLA==
X-Gm-Message-State: AOJu0YxZl0AhWwJYknSzjO/hVv9FvgmiBbIoz6BGyLAmDqSPEoEGDcQX
 4HKxLA6FNOQEL1EwHBCN7HKYSBmRIe4mZ5gsbmT7FPsProx5egDos1eQTmUIFBqvVQ==
X-Gm-Gg: AfdE7ckSQ0pJE0ekglBJKKR8MRaW9SqwCUo9r/qtuCI8RuPngxtcW4jheNhusJT6pZU
 iaAZqZgOmBY2WO9dg+cMzCOLhnxTUyW0d6yB8/Uij1QBgo1pahibPl/yGsCVgOwOOdTKhTwh0Dt
 m2m6NOiBh9wUQGUxvfTcNbCzQWTVP3uL9cl4lon+RSm4kLLPwoIpmDs1P5j3jqeEYs/cZ4NjQ2E
 iU1oPn7DtE+3uxuBd/uqicU0ToquWTprrjKL6Jfta9SxJ0giw17Iowxf6AZdIlj7sgEUPSuoh27
 Q+1qjJ8nNhuVa2Yo1rORcfQABl/xMsl6ERu1kyxZJu678p4bnLHJje1bG0yYRthoZZZMRabdEHA
 GpaE2ESSkEy8NU6ezGA92eNJcc8tHujRLRbLmLblzBdhEhIv4/OY0rA6C/UuQJHbRPGamLIPyaw
 pSMyb2j7wq2IZoR8EcOfzh
X-Received: by 2002:a05:7300:324d:b0:307:156f:268c with SMTP id
 5a478bee46e88-30bc9ce9b8emr1524086eec.13.1781690815693; 
 Wed, 17 Jun 2026 03:06:55 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:06:55 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough with
 legacy VBIOS
Date: Wed, 17 Jun 2026 18:06:37 +0800
Message-ID: <20260617100646.28326-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1244.google.com
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

Tomita Moeko (7):
  hw/pci: Recalculate option ROM checksum before patching ID
  hw/pci: Skip EFI option ROM in pci_patch_ids()
  hw/pci: Introduce rom_need_patch_id flag in PCIDevice
  hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
  vfio/igd: Toggle rom_need_patch_id flag on IGD devices
  vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
  vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time

 hw/pci/pci.c                |  57 ++++++++++------
 hw/vfio/igd-stubs.c         |   5 ++
 hw/vfio/igd.c               | 132 ++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c        |   5 ++
 hw/vfio/pci.c               |  33 ++-------
 hw/vfio/pci.h               |   3 +
 hw/vfio/trace-events        |   1 +
 include/hw/pci/pci.h        |   3 +
 include/hw/pci/pci_device.h |   1 +
 9 files changed, 186 insertions(+), 54 deletions(-)

-- 
2.53.0


