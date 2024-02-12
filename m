Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98416C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 10:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZTQl-0007rs-Ip; Mon, 12 Feb 2024 05:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQa-0007nP-FG
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:46 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZTQY-0007bR-KB
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 05:20:43 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d94323d547so25957365ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 02:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707733241; x=1708338041;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gSvCLJe3gU02YFH7AP/Kc5zVGA3h47XKCXQKtEcX3Dw=;
 b=pRphen4M3zCDA/oghS3+vLSOHSVSnz8IWbpt/XbkefcsSeU/bvBRTRYPUipUcOZRvZ
 VK/jSYTiJK8ik5Tag4sz0TVjqtFbBLlyVfNoItxmcgDnpxuBN+EwuinwcdWn+5TUDb04
 saiTKypXEi17CpmPgIEnPRMaz9i4jdyq5icxzMvHX8Ifa/fKU+16dep9qHvYi+r1DngA
 McDwqaj91Wy96L+psSwMr0zZZth/dEePddxm18PFxOuqTEzd8ZPJxBbli6UebkEku6oV
 prG3N4Fjwn3WPc3Yqmzm+jEH1A+bY8f0s6T1gUUrOfNAbhm6Y6m0TfkYGKxMxIlLyUXt
 RdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707733241; x=1708338041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSvCLJe3gU02YFH7AP/Kc5zVGA3h47XKCXQKtEcX3Dw=;
 b=RlqYfRa3yLgCilyq3plhNig659fe8w3//R292VlONKf+FdUf9DbnI7AacmcLRUWM1O
 TGDVoRoimOyZfgfHmcVdn9AFxSsetrM61fz82e9T+LGYoJnlMjELastBgQLg4EBRS3xc
 Zq9EHzZCS0NuMqu9UvfNX1AJ1+pVmC9e8u4k2LvSD1+5XA0nEmboxQ4AmrKiwrb0H8dR
 8dvJl7RvmR1dmycIGOzN1n/FgTr1xVI4848Q7BEmn27x9lx6WOOC7P4vPvrF/j+b8MQ0
 pGgd2n43xY3GOcJGthCj0vTL6SkBpyzVqnvY2g6mcWbs/powfeH4voSdHysBjUrO4E3B
 KBvQ==
X-Gm-Message-State: AOJu0YxsnaorqfzIPTV867JdghnrBC8lZAnUlo2L/gP1AQ7/TSKN1JSd
 PBcx6M7MDMzoLG4v+jTkNXkLkFVldmYlfARVXSWjJxVOkd56Cj1THkuu1806qBU=
X-Google-Smtp-Source: AGHT+IF329Qld9IgcjTeG6QzYZ0NZQzHxz7cHSatavw6RgIFGZKL6PiS7YKjhOc77vAZs9tfAI7wLA==
X-Received: by 2002:a17:902:da87:b0:1da:22a0:efba with SMTP id
 j7-20020a170902da8700b001da22a0efbamr5070742plx.63.1707733241237; 
 Mon, 12 Feb 2024 02:20:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWZEa3h+k5bqNqfIx3rub4jyfuoeMPNA9BvAT2aSrny3S2EQ29PhpfsGIsAuqpbMo/8Yyb1/A30iUi9ZIKkrJcecbcr+Jws4kDsmRkpnRap/P7Bs0oKlxtWcQOGz04yJkG872NHZlOvNO647Gi4E/NCnL6TBmrUbvxVRt4MkhYc5O/M1J7F+l5Yv8Ce6f92p0Chm4BRGaLlMyKvPg8BYB0+zN2VB0+6KkG6FAsdzkugsL4M1r/3lpDWjukqDk2ds0XumXY1gA0GbttFYmLJvGxXKe8p4Ng16RVpAkoKYsUN5s1swNvMgsOXzC6U28qpwy5w33GFYWI+eyy5shHCX8Nb/t9pudbqvPBNCxV6kbYUrkQ5whK+M8x12KsCyYr3xB+fm5hwE4szJX6TwNNBad7jqvdiLz3aMh562yHRi8We9cCQzWi/b++HZZa1TN8=
Received: from localhost ([157.82.207.134])
 by smtp.gmail.com with UTF8SMTPSA id
 v2-20020a170903238200b001d8f3c7fb96sm50856plh.166.2024.02.12.02.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 02:20:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 12 Feb 2024 19:20:29 +0900
Subject: [PATCH v3 1/7] hw/pci: Use -1 as a default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-reuse-v3-1-8017b689ce7f@daynix.com>
References: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
In-Reply-To: <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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
index 76080af580d7..d08548d8ffe9 100644
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


