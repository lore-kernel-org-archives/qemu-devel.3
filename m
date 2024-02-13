Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F177C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnuH-0000ZS-D5; Tue, 13 Feb 2024 03:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuF-0000Yd-30
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:43 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnuB-0000st-Be
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:40 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d0c7e6b240so55080381fa.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811957; x=1708416757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4ug+gqIzlvgMFvPTiM99Fr6Vu5lvApMTDFifyvx+0U=;
 b=hJl4/HnIRU9x3VmCmxM5Z8T/YkhtZbh5hcTPb9q8aWZFzMXcw6d70z5/eLM/3s025o
 ldyVN3XBbDC/gs0Eoi8z01F5AZrd2BvliFPciS8/md782TwExvsRN2K7vXwHDHljkztu
 xluKixYyA5VfP2wLuRO+uswJx04DeZMw0ZgAfHHAdT3XwO99AN0F1LgR74UnzwZOlIQm
 Tt0CVKHGWHR5UsBY8lOwwG0EjeeAjGlMb1gxpC0dSJcac7sA0vm/xMoWJlOkqLRcdGeA
 v3np/E5OwOCKW5CaiyWkEceLqgGZCdF5YRPV0CvbMWDIrSl+kM3nqOWpL87Z9Pa71Tw4
 plxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811957; x=1708416757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4ug+gqIzlvgMFvPTiM99Fr6Vu5lvApMTDFifyvx+0U=;
 b=AxIUvbmCY769G75LvBVmHz0xVe4sCDM0RmCkH2laxbIdOBW9cRuq9kyiKAxViIJo1e
 XK1KmNDuAaOB0Jkcvma7z6dGpJWoK8agjOIrbkN7M/mhFt/hL+yhAMs51AqGbPKkAu2Q
 JP9Wfol4/ZqMYDPjNprSszpouFnFWbtBuitK3JPn6Kvp6c6OGQwDwvAPEguuoq+TNPNZ
 pjShPif3WkXiuqbo6pzgRFo9K0cRWSOwmEVlIHGuPbGfL8mo/vnbH7/2DaYv2ksEYcAd
 G3gzZxMBMbuXkcfAV1sYWT3Y6VbtMUzus8PnpJhFAJjS0hZPMgoOQf/Fc04slg4G3e9W
 u0eg==
X-Gm-Message-State: AOJu0YyBVoFtwwysRpSeVZ4sPRvwkJy/lJ5YFflhaQoS8FclAO9mGnob
 Sl8xJJhyMSACbt2OBjORFdk1MkVKd64KUv+FiKCnY+OSLPyLMupIlc6lV2iAQKdnbDjBWwyHbEV
 G
X-Google-Smtp-Source: AGHT+IEJyR1/NSHaM8MjcChXRFU7hPhO7FghqblDA3fTM2+2r8J2LM2UuQasp2PYeFcfsp1KlOo9jg==
X-Received: by 2002:a2e:86c5:0:b0:2d0:f8d7:a91c with SMTP id
 n5-20020a2e86c5000000b002d0f8d7a91cmr3119336ljj.52.1707811957191; 
 Tue, 13 Feb 2024 00:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXEBS51Yaa0dYKasaqeIyfMKcL4ZSG91xMTOHjNyeFwjuSoeUHGg2W0J45PZpF5sfTAWq4O7AamRSKu609B/uMQ0dwdKcligWmgyYw+B1eZ1e0o1Qyo4jN+2Ca5SrEGs+QpQDodMAsoIXcuPsdTshJicxnT3SzNCyXxIOat2WLZCrvklPdpd4yk2fjH4fAN4rE2LDHyB4g0zgdPmpfvQF3wIHKYtNGLnrPcVvbo5Q4pmqJlW13N9k2pymquFbpYzntB00J7RTT+2KF/cbG+KPcHwz3/gzptU3ilBaIfZ1+Aund3yXUmu2L89n1kPqnkORWVYvUcHMYBoFo+n8y87PvH9xABqy0aSv3GKQ==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 fa1-20020a056000258100b0033b79d385f6sm6566745wrb.47.2024.02.13.00.12.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:36 -0800 (PST)
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
Subject: [PATCH 5/9] hw/ide/ahci: Pass AHCI context to ahci_ide_create_devs()
Date: Tue, 13 Feb 2024 09:11:56 +0100
Message-ID: <20240213081201.78951-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Since ahci_ide_create_devs() is not PCI specific, pass
it an AHCIState argument instead of PCIDevice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ide/ahci.h | 2 +-
 hw/i386/pc_q35.c      | 2 +-
 hw/ide/ahci.c         | 5 +----
 hw/mips/boston.c      | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index dbef377f3d..8cd55b1333 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -52,7 +52,7 @@ typedef struct AHCIState {
 } AHCIState;
 
 
-void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
+void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd);
 
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
 OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c50e3bfc42..7f4f51fcdf 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -316,7 +316,7 @@ static void pc_q35_init(MachineState *machine)
         idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
         g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
         ide_drive_get(hd, ich9->ahci.ports);
-        ahci_ide_create_devs(pdev, hd);
+        ahci_ide_create_devs(&ich9->ahci, hd);
     } else {
         idebus[0] = idebus[1] = NULL;
     }
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 8b97c6b0e7..bac1871a31 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1896,10 +1896,8 @@ static void sysbus_ahci_register_types(void)
 
 type_init(sysbus_ahci_register_types)
 
-void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
+void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd)
 {
-    AHCIPCIState *d = ICH9_AHCI(dev);
-    AHCIState *ahci = &d->ahci;
     int i;
 
     for (i = 0; i < ahci->ports; i++) {
@@ -1908,5 +1906,4 @@ void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
         }
         ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
     }
-
 }
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index a6c7bc18ff..1b44fb354c 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -775,7 +775,7 @@ static void boston_mach_init(MachineState *machine)
     ich9 = ICH9_AHCI(pdev);
     g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
     ide_drive_get(hd, ich9->ahci.ports);
-    ahci_ide_create_devs(pdev, hd);
+    ahci_ide_create_devs(&ich9->ahci, hd);
 
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
-- 
2.41.0


