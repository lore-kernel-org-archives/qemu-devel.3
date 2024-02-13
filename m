Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E4C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnu6-0000WR-8t; Tue, 13 Feb 2024 03:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnu4-0000WH-I0
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZntx-0000ox-RY
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:32 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-410db155e57so11924575e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811944; x=1708416744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xcNsXW9mDVOPPZyrAplUMmD9sMhDYldoYl40GQNnJE=;
 b=bt2K0ORgObQUwQ/rduDMZ9j69987lh8ykygTRCUy27yMi7+xDO4WDSGZpKMIQ1irKY
 ho5QbZps7BNMSMip/1xA6zlY06AULWadYXdbWD2RqNmA0f2LFtDpx9se1pMYbcrxQnQb
 pX2E+U32z33OVzPYDtQgPMoGAtotrsWh5P0en1c1OxzW6UHlNjB6GStDFu4MqXeul7ho
 ClApyxCoaydoxNiyz1f9XPNaR09cFx2oa1SrCq3R23Ab+x83FrjZs624HiaHDCFvKArE
 V7QJcYE2LoNW4YEPInIZL0pn5ZaDgGDT5sSPW7nsYQWnxE4ct57tvIAehDcMzealYg/z
 gVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811944; x=1708416744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xcNsXW9mDVOPPZyrAplUMmD9sMhDYldoYl40GQNnJE=;
 b=RfUP+JvUvDg2PTEWbBv+qShYY1g70hwoTt+d/Pxk2X5K/iG9LokO3oLp7tv/k1YEEv
 9zQWH+Grm8m6MNx8WY5G0LGiAGuP13oPpapzT0O3PZwzPkZJ665MtThTAWX00rJORm7c
 114gTkoXmBrwgdb/yMRES2w5/cO0R0z816ywSrxbiobr0iKN7e8d+SXzueLvj/zQpEkK
 pY48p7b0oTCmuN+KvdOnxETXJbaRfXQfpSqiw1i2UXOWYefiB8/7ulUBJrOTnGe4Oyn5
 OTY8CmDtRQNQ29FR9e5dFmFVb2SLRi9rz0nr3+nrAjR0+FfZtGkBGPJcALfdJm6Ie1yI
 TIfQ==
X-Gm-Message-State: AOJu0Yz42aez2SStlNqTEMX7Qo0dFtAgu4DrjGK0JpAYZeJKmIuInKWp
 R4ASfg2B1KtsplNzFpFgfhQXbKekyDTVXh2IlQ4tdvwnKPFKdMVQA+hiYvqqYURqHGrM1rnxvpb
 R
X-Google-Smtp-Source: AGHT+IHUgXjWKVkLSv8p8cXoc5vypzCWO63Lxaes9a06wmmfuYsMechJ7NOhAiyGsOUL5/JAzdB7Uw==
X-Received: by 2002:a05:600c:c89:b0:410:888f:f342 with SMTP id
 fj9-20020a05600c0c8900b00410888ff342mr7260646wmb.4.1707811944206; 
 Tue, 13 Feb 2024 00:12:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVNvjQ2bTAysAnkRoMSOG0D/8BnRZOKyOXKKUUDRAjHR003X98VUGsTFLG1MZRTMGHUj0MA3wj5i3qAmdxzaTWa6ynfVBwGZe/4fbu7HwBdQzILKZxcruW9IAQc78iTES5IPL6vRAxDSV9J3xLrS9lrYunSRrqof3GoWxqO7C7zbdfZOZf982xJN4tLX7P0eX6aEQ/6GWbZFQpiOnBT+ijlCTmMJgQ//q7NLry/xEni/wbV9ZWfILxMFdBRDOchW66fYjqR+yvFIUxoAlUr7jW9TbUIn+09I6g1U86Leepp1tw6HGlsQz1kQbJkKVnPMAT2GZV9IAyML9aG3nxoQ9Vp+W7i/mXv2aqY3w==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8318048wrb.79.2024.02.13.00.12.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 3/9] hw/ide/ahci: Rename AHCI PCI function as 'pdev'
Date: Tue, 13 Feb 2024 09:11:54 +0100
Message-ID: <20240213081201.78951-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We want to access AHCIPCIState::ahci field. In order to keep
the code simple (avoiding &ahci->ahci), rename the current
'ahci' variable as 'pdev'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 15 ++++++++-------
 hw/mips/boston.c | 10 +++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index ace8d3839a..e298f4ff32 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -135,7 +135,6 @@ static void pc_q35_init(MachineState *machine)
     GSIState *gsi_state;
     ISABus *isa_bus;
     int i;
-    PCIDevice *ahci;
     ram_addr_t lowmem;
     DriveInfo *hd[MAX_SATA_PORTS];
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -304,16 +303,18 @@ static void pc_q35_init(MachineState *machine)
                          0xff0104);
 
     if (pcms->sata_enabled) {
+        PCIDevice *pdev;
+
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        ahci = pci_create_simple_multifunction(host_bus,
+        pdev = pci_create_simple_multifunction(host_bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
-        idebus[0] = qdev_get_child_bus(DEVICE(ahci), "ide.0");
-        idebus[1] = qdev_get_child_bus(DEVICE(ahci), "ide.1");
-        g_assert(MAX_SATA_PORTS == ahci_get_num_ports(ahci));
-        ide_drive_get(hd, ahci_get_num_ports(ahci));
-        ahci_ide_create_devs(ahci, hd);
+        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
+        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
+        g_assert(MAX_SATA_PORTS == ahci_get_num_ports(pdev));
+        ide_drive_get(hd, ahci_get_num_ports(pdev));
+        ahci_ide_create_devs(pdev, hd);
     } else {
         idebus[0] = idebus[1] = NULL;
     }
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index cbcefdd693..0ec0b98066 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -677,7 +677,7 @@ static void boston_mach_init(MachineState *machine)
     MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
-    PCIDevice *ahci;
+    PCIDevice *pdev;
     DriveInfo *hd[6];
     Chardev *chr;
     int fw_size, fit_err;
@@ -769,11 +769,11 @@ static void boston_mach_init(MachineState *machine)
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
 
-    ahci = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
+    pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
-    g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(ahci));
-    ide_drive_get(hd, ahci_get_num_ports(ahci));
-    ahci_ide_create_devs(ahci, hd);
+    g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(pdev));
+    ide_drive_get(hd, ahci_get_num_ports(pdev));
+    ahci_ide_create_devs(pdev, hd);
 
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
-- 
2.41.0


