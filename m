Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525D9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wezYR-00086p-6H; Wed, 01 Jul 2026 14:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYK-00084R-Hn
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:54 -0400
Received: from mail-pj2-x02.google.com ([2607:f8b0:4864:39::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYI-0007H4-Fp
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:51 -0400
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-37fd7db8cf1so469274a91.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782930049; x=1783534849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ghb/SNZpSBJ7yxU8U8gwuUxJ/trOYWhvix8hFHF3tTw=;
 b=WsG7tjvLv8NSM0njGsySo22XThcy+JQ3CXJtRxNBY3Ul8LG62WlLC4/rKd2HQQML2L
 emlAFu5mHaA879/V9Luvew2tQKkK1lYwTFoVZt3YIjq3nt/OD2neCZJztM2Te+6RWuG4
 DloSrMlQeVdWJWXvt3vmzfLHOVwYydqsK134spL5Jq45iEyMEpA3pnrabdfc174txsV0
 acVXj85GbKK2nj5of/kZpmUdPN0yGABGmf6hA++o0TyvhAodtNxPp2o0zkuM+X7baWjy
 +/QQ5EEF9aRnrrMWJluOR7Bgtf3+wTTxd40S94YouMdy03sCav54+PWfgRFjHm3PGgUN
 WAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930049; x=1783534849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ghb/SNZpSBJ7yxU8U8gwuUxJ/trOYWhvix8hFHF3tTw=;
 b=tBn3qfqDycd2EcqwqQtLONTPwUNSiXK9UIpVuqw/1aoUEiBTP1nMhfSTaoJ+wS/ANt
 G//pP9vmipMCBREdZFtgtVzqD6zptebJhl0FFUbDFK5Y9mJzYJaOesz1hfyAWgHg3dVL
 r5uVYM7wKSNJDgLXzeabxllIf0SSoHO0dSvpxXe5lY/ixQP9n2cQPyvinxrfnMD45YbT
 ykaLHR59rJcGeYHalCtABQewxCzQjZzLaR0sNxUsiDkxM9YfiONnTRHcEltYCga+rBHI
 8JYQjWpqnR1EUcciwGzz/zFvkyQedlp3vJNrA30LLsfqI/F8Bz8G1IUuoaUIlgph2a4g
 mnYA==
X-Gm-Message-State: AOJu0YyXih0WSE8xTcIqH2bPhpB8hTdIO5DqC/2Vem4ojxyPesLPyhSn
 vnLrRHH3LzXlzD1203J5iBUeWRxbuKUbPxLKzEvNFzSJVGornDNu3Iy+tKWslQTxUA==
X-Gm-Gg: AfdE7ckwrMIhZ667G8JQDG55Y7Nskl2tfbEISSpIRgInmgL0hwJkzQT1gt0W9LgP+kA
 dVp5ft7OutmtbwtO1QXb0FxI30rV3kxTS1NN+wm/vieGl9KCCxsi9RQbT/qnYfKT+Nt5k1WAz8B
 k6HNUyFGoHS3mEjxguMcF0Ns5mwyJjlq1rmz6bJHl2tx6bG5egKXBDV5I2Glipv+GsMpxXEi8eh
 1Sf7MKuBOe9CE5XLvR6LQTA03NhqMg0SV3OVO9NVUw0ol/3gXqAVwAjNFhcP4PrqP5S+yp+7LTB
 LjLrvd6ViV5X9rWfGJDZLsd9npbQuGfeUSM5PGLK0lfILLVgNpsPoMXKeA+/hAeRq1fZoqdpjuC
 DQVXtpKxZS6UnxxJgls0Oes+7g7AXaF95fWz8E8nTT6oyKqW8D8c3uFYxzv4r8rbwGBossbb3U6
 tAUQ4ohTzH4SsbZ1eP7g==
X-Received: by 2002:a17:90b:5487:b0:37f:e1e9:2b0b with SMTP id
 98e67ed59e1d1-380aa184626mr2732716a91.16.1782930049009; 
 Wed, 01 Jul 2026 11:20:49 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590:494:7c85:ae9c:cba8])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm187109eec.27.2026.07.01.11.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:20:48 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v4 1/4] hw/pci: Introduce romfile_fixup hook in PCIDevice
Date: Thu,  2 Jul 2026 02:20:32 +0800
Message-ID: <20260701182035.96010-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701182035.96010-1-tomitamoeko@gmail.com>
References: <20260701182035.96010-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x02.google.com
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

Some devices, such as VFIO IGD passthrough, require device-specific
fixups on the romfile provided by user. Add an optional romfile_fixup
hook to PCIDevice. When set, it is invoked from pci_add_option_rom()
right after the image is loaded, receiving the ROM buffer and its
size. This provides a place to post-process a loaded romfile without
leaking device-specific logic into the generic PCI core.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c                | 4 ++++
 include/hw/pci/pci_device.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4298adf5a0..7d30d44411 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2632,6 +2632,10 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
             /* Only the default rom images will be patched (if needed). */
             pci_patch_ids(pdev, ptr, size);
         }
+
+        if (pdev->romfile_fixup) {
+            pdev->romfile_fixup(pdev, ptr, size);
+        }
     }
 
     pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e1688..a65e77018c 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -159,6 +159,7 @@ struct PCIDevice {
     bool has_rom;
     MemoryRegion rom;
     int32_t rom_bar;
+    void (*romfile_fixup)(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
-- 
2.53.0


