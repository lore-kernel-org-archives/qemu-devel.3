Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15616C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXft1-0002tx-G3; Wed, 07 Feb 2024 06:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsz-0002tM-Ts
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXfsy-0003S1-AC
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707304475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYJ8/tFAmrh3VcWdElUpsPrqIWISPJqBMUPEWn4+ITY=;
 b=YvgT/9jiMsqoPdL2cP2Qu5AuyGHRuNSsUPq6p/ElzKSnYegQErt63+5alO/TFX4VgeSUSV
 9LzCo1kbyVKHS+ir0E+FFvlj5hR5UE/QMLQJ51pFPF0qb5VGEgOcSLelMFCE0Vq4vwwpf8
 RllXJscE5sy9gQD0ECQvNyFqlGSdg18=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-zrJ0iPp5NpipG2Z8S5kTNQ-1; Wed, 07 Feb 2024 06:14:33 -0500
X-MC-Unique: zrJ0iPp5NpipG2Z8S5kTNQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3821399b38so28030666b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707304472; x=1707909272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYJ8/tFAmrh3VcWdElUpsPrqIWISPJqBMUPEWn4+ITY=;
 b=WAnw7UNj1sXixR0EDZbOCx3yvilbyU0qxxMTWHWzKPh1Ua5HhwTNlvjUjiEMB6KZlt
 nITtkpOfte2TIHu/PmVur9LDK2+7djuFOm6MYGAty4386THBNX7I1WtG9lgwnGrjERYL
 BKFNceJBLYwrPIQoyyYjv/kmwcT8hX1ey2J+FPEJ8karPurKmLlg2s0w4NpdLTtte+YL
 H+25Ciybh4a6ogPvm4mNMnJ8oWGM0iJ7dQ8a+lQ8Vtn52gGdosEp/cLv6RqIWYdNNCbf
 45iZaFHJ90qYWeqQ9UzOPzvDdgLn/hm5ZP/aF5g/XjWonhfyyTCI+V4ITRYsxbTND1we
 hn8Q==
X-Gm-Message-State: AOJu0YzpjUfIm80Hx4NFaK5i4IHqesLbaOhgYyfvBb01dxcygahtTrBh
 P4RSLl6rDmlmMrgmxb0NuL9xcb5QgrLjhXLevCfGNAF5BiwAUSRZOOBLp0denfzfMY7f1dSoRvx
 Ea4yeGHpk3ffdYNtte76JXAsAIg3TFjtavC1XFHnIJCqtfES7CuPvoQ7YT0JPdMHbkc6uQSbIIV
 obS7/5oB3LC7y/RRFgcxvSS5edwwq4eU4uNJ4G
X-Received: by 2002:a17:906:710e:b0:a36:5079:d6c9 with SMTP id
 x14-20020a170906710e00b00a365079d6c9mr3434321ejj.76.1707304472282; 
 Wed, 07 Feb 2024 03:14:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt7d4EUP9ian+AzAurGomldHgYv/TOxXdYxnsVEfgwtCbrhkVmhIs/bTF4DV+is4tnLJFb9g==
X-Received: by 2002:a17:906:710e:b0:a36:5079:d6c9 with SMTP id
 x14-20020a170906710e00b00a365079d6c9mr3434303ejj.76.1707304471966; 
 Wed, 07 Feb 2024 03:14:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUJTewOuL7R/I4PQlNiLbtrZ0paX3w1QGY9OKOKEXs53zrJ+BvTOeoDukpggfQsDeXSp1CyxA2BD77zequ1CO1QfQ==
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 ty13-20020a170907c70d00b00a338fedb9ebsm650303ejc.54.2024.02.07.03.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:14:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: shentey@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 8/8] mips: do not list individual devices from configs/
Date: Wed,  7 Feb 2024 12:14:10 +0100
Message-ID: <20240207111411.115040-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207111411.115040-1-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add new "select" and "imply" directives if needed.  The resulting
config-devices.mak files are the same as before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/mips-softmmu/common.mak      | 28 +++-----------------
 configs/devices/mips64el-softmmu/default.mak |  3 ---
 hw/mips/loongson3_virt.c                     |  5 ++--
 hw/display/Kconfig                           |  2 +-
 hw/mips/Kconfig                              | 20 +++++++++++++-
 5 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/configs/devices/mips-softmmu/common.mak b/configs/devices/mips-softmmu/common.mak
index 1a853841b27..416a5d353e8 100644
--- a/configs/devices/mips-softmmu/common.mak
+++ b/configs/devices/mips-softmmu/common.mak
@@ -1,28 +1,8 @@
 # Common mips*-softmmu CONFIG defines
 
-CONFIG_ISA_BUS=y
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_VGA_ISA=y
-CONFIG_VGA_MMIO=y
-CONFIG_VGA_CIRRUS=y
-CONFIG_VMWARE_VGA=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_PARALLEL=y
-CONFIG_I8254=y
-CONFIG_PCSPK=y
-CONFIG_PCKBD=y
-CONFIG_FDC=y
-CONFIG_I8257=y
-CONFIG_IDE_ISA=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_I8259=y
-CONFIG_MC146818RTC=y
-CONFIG_MIPS_CPS=y
-CONFIG_MIPS_ITU=y
+# Uncomment the following lines to disable these optional devices:
+# CONFIG_PCI_DEVICES=n
+# CONFIG_TEST_DEVICES=n
+
 CONFIG_MALTA=y
-CONFIG_PCNET_PCI=y
 CONFIG_MIPSSIM=y
-CONFIG_SMBUS_EEPROM=y
-CONFIG_TEST_DEVICES=y
diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
index d5188f7ea58..88a37cf27f1 100644
--- a/configs/devices/mips64el-softmmu/default.mak
+++ b/configs/devices/mips64el-softmmu/default.mak
@@ -3,8 +3,5 @@
 include ../mips-softmmu/common.mak
 CONFIG_FULOONG=y
 CONFIG_LOONGSON3V=y
-CONFIG_ATI_VGA=y
-CONFIG_RTL8139_PCI=y
 CONFIG_JAZZ=y
-CONFIG_VT82C686=y
 CONFIG_MIPS_BOSTON=y
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 33eae01eca2..da47af2fa71 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -447,8 +447,9 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
 
     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         pci_create_simple(pci_bus, -1, "pci-ohci");
-        usb_create_simple(usb_bus_find(-1), "usb-kbd");
-        usb_create_simple(usb_bus_find(-1), "usb-tablet");
+        Object *usb_bus = object_resolve_path_type("", TYPE_USB_BUS, NULL);
+        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
+        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
     }
 
     for (i = 0; i < nb_nics; i++) {
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1aafe1923d2..5b2b3840f7a 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -55,7 +55,7 @@ config VGA_MMIO
 
 config VMWARE_VGA
     bool
-    default y if PCI_DEVICES && PC_PCI
+    default y if PCI_DEVICES && (PC_PCI || MIPS)
     depends on PCI
     select VGA
 
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index e57db4f6412..5c83ef49cf6 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,8 +1,15 @@
 config MALTA
     bool
+    imply PCNET_PCI
+    imply PCI_DEVICES
+    imply TEST_DEVICES
     select FDC37M81X
     select GT64120
+    select MIPS_CPS
     select PIIX
+    select PFLASH_CFI01
+    select SERIAL
+    select SMBUS_EEPROM
 
 config MIPSSIM
     bool
@@ -31,17 +38,26 @@ config JAZZ
 
 config FULOONG
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    imply ATI_VGA
+    imply RTL8139_PCI
     select PCI_BONITO
+    select SMBUS_EEPROM
     select VT82C686
 
 config LOONGSON3V
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    imply VIRTIO_PCI
+    imply VIRTIO_NET
     imply VIRTIO_VGA
     imply QXL if SPICE
+    imply USB_OHCI_PCI
     select SERIAL
     select GOLDFISH_RTC
     select LOONGSON_LIOINTC
-    select PCI_DEVICES
     select PCI_EXPRESS_GENERIC_BRIDGE
     select MSI_NONBROKEN
     select FW_CFG_MIPS
@@ -53,6 +69,8 @@ config MIPS_CPS
 
 config MIPS_BOSTON
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
     select FITLOADER
     select MIPS_CPS
     select PCI_EXPRESS_XILINX
-- 
2.43.0


