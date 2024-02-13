Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79248C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnuF-0000Yc-JX; Tue, 13 Feb 2024 03:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuB-0000YC-6c
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnu5-0000sD-Bl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:38 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33b2960ff60so2867094f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811950; x=1708416750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/ev/rbWgQ4Tjt8IzrgKY2Bj8EwxwI7ToduD8QMlTVc=;
 b=OmHPij1nMHWSDXhbNPXLWOaTIXovogV9PHuX1FZW+fYdJVATVdvVltVi1jht9RthS4
 XdcwIb41iBvJEIxqMNGyofBHCjKd8lHOYhOllKycnaBRmLBBgx9V3pqwqh0OSYuEHr41
 6K7OPKjS7N/7jkxxIs3T9Pb+4n5CabKDAGVS404+eW4QEizUKa3I28V6H9vrOqCHa0b3
 iPbvqROYJxK9DNhEBdxmVWlx6TiaNl7wc9cb0wJXE0ey7BaGOFNjgAU08WczsiGQ157e
 Hg/gyGQ85Lcstbug83SiRZQmi3eYtfJpsxK7rnqqrNEQRGVHod5r1MF50lvIttfG0Nbb
 71YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811950; x=1708416750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/ev/rbWgQ4Tjt8IzrgKY2Bj8EwxwI7ToduD8QMlTVc=;
 b=a0QXeoH1tUILqoFqazB458eJHLcyt9N4GNbrn8i40rJhlVkIicBe8+EKZAXuw/L/ex
 o9mlqVNUD+abow8C7Lko/UnVs2W5D8QAHSwX0nr3snSf26UF0iq/8Fk55dBiue3fmts8
 KcFosCJAFV3ZpdV/tEM+gG4ifN5PgodUgmWcgQqmE9vE9XTkMIudaY149ZfyL25Osz7g
 KblP/5ncVIxMlTdw8EdWIq32yeuovdAS6FsxHMK10meWBUFcAXIl0A63/WXvD4GHXbb4
 BJ4oZ4vIWGgD94eMI4Cx5WqWA9hHVEERF+ZgxamdVAxfucz2MXUbHWI7L+2D+CBNDurP
 hH6w==
X-Gm-Message-State: AOJu0YzdiiKdV9Uo+4H+4tKf0DQA/YEKf1/SeJi/iNc5bHtxKMjKB9os
 WH+5sdEzlNVTI9pYQZGAWVobr8BcSVfXShzIw2kQCAuYp3inQbB6IBbAxkTuEgZVQwfQT0h6q7G
 V
X-Google-Smtp-Source: AGHT+IEQVsQGdzrP7RSHqH0TBhnl6ksx0LanFFlHXQmhRngSIxfCPqj+n0QHADhzaF/JarC7lUOFeA==
X-Received: by 2002:a5d:5f93:0:b0:33c:cfb5:aab9 with SMTP id
 dr19-20020a5d5f93000000b0033ccfb5aab9mr1450931wrb.3.1707811950579; 
 Tue, 13 Feb 2024 00:12:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUclnUpMmQ39qAeZEAkb6sL8xgztDx1rzjwtf7Mfp8iT9JZOckg0N4x1PPNg5rcSdh/CMdkEZN3pUnqsMVRRbwXVBLyLl/l8QcQ92qu7bHn6MXYLFQIezJlt3My341sDdbD3YM/2vqqgkyRygJdkGITRO5Senfo30QrcInMKJxCBJHh3vkaeyhtLpu1pdnXCZZ+3gLbxvRKsfP6TergMLepXAZznBYqkWhORjvvY9g1g6enTBS+ok/kZFpQOadYTMALjGOgloJbxvWITsLnw4ZJEk8YbjQfXp05oO4TvLrJY61zEFcphHYcZCvSyCPH40HdDmxs5ss6+5T1Pnh+qAqZ3WhJLj2r8BdvXA==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a5d4708000000b0033b507b0abdsm8799389wrq.32.2024.02.13.00.12.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:30 -0800 (PST)
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
Subject: [PATCH 4/9] hw/ide/ahci: Inline ahci_get_num_ports()
Date: Tue, 13 Feb 2024 09:11:55 +0100
Message-ID: <20240213081201.78951-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Introduce the 'ich9' variable and inline ahci_get_num_ports().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ahci.h | 1 -
 hw/i386/pc_q35.c      | 6 ++++--
 hw/ide/ahci.c         | 8 --------
 hw/mips/boston.c      | 6 ++++--
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 6818d02063..dbef377f3d 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -52,7 +52,6 @@ typedef struct AHCIState {
 } AHCIState;
 
 
-int32_t ahci_get_num_ports(PCIDevice *dev);
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
 
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e298f4ff32..c50e3bfc42 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -304,16 +304,18 @@ static void pc_q35_init(MachineState *machine)
 
     if (pcms->sata_enabled) {
         PCIDevice *pdev;
+        AHCIPCIState *ich9;
 
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
         pdev = pci_create_simple_multifunction(host_bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
+        ich9 = ICH9_AHCI(pdev);
         idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
         idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
-        g_assert(MAX_SATA_PORTS == ahci_get_num_ports(pdev));
-        ide_drive_get(hd, ahci_get_num_ports(pdev));
+        g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
+        ide_drive_get(hd, ich9->ahci.ports);
         ahci_ide_create_devs(pdev, hd);
     } else {
         idebus[0] = idebus[1] = NULL;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index aa9381a7b2..8b97c6b0e7 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1896,14 +1896,6 @@ static void sysbus_ahci_register_types(void)
 
 type_init(sysbus_ahci_register_types)
 
-int32_t ahci_get_num_ports(PCIDevice *dev)
-{
-    AHCIPCIState *d = ICH9_AHCI(dev);
-    AHCIState *ahci = &d->ahci;
-
-    return ahci->ports;
-}
-
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
 {
     AHCIPCIState *d = ICH9_AHCI(dev);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 0ec0b98066..a6c7bc18ff 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -678,6 +678,7 @@ static void boston_mach_init(MachineState *machine)
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
     PCIDevice *pdev;
+    AHCIPCIState *ich9;
     DriveInfo *hd[6];
     Chardev *chr;
     int fw_size, fit_err;
@@ -771,8 +772,9 @@ static void boston_mach_init(MachineState *machine)
 
     pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
-    g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(pdev));
-    ide_drive_get(hd, ahci_get_num_ports(pdev));
+    ich9 = ICH9_AHCI(pdev);
+    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
+    ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(pdev, hd);
 
     if (machine->firmware) {
-- 
2.41.0


