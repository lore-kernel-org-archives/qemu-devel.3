Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D440DC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv4P-0004p6-AN; Tue, 13 Feb 2024 10:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv4M-0004Tn-UQ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv4L-0005bx-4m
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fPwNvvXXF0dWdZecUWUuSYxtRjzXrWvMaH/cl1RwQEE=;
 b=hW0jNePJMS9Ekl5QPyNkA8ENoIAWinMb054VBkemeVflxwKE72IazFbvMB1+zArfhHtroi
 5JkNwDWJZHZQ4ohvurCOhUs9o9SOUJtjx7MXZ5hpNMwbSUhAW3BeME4EBmRsbq3AB7PfC8
 5HS/CoDRVxsTJelLgGJHdjGQAAU9/Ek=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-VBFM214HPfyfBxFGipNfEg-1; Tue, 13 Feb 2024 10:51:35 -0500
X-MC-Unique: VBFM214HPfyfBxFGipNfEg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3c2a65d99eso159986766b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839491; x=1708444291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPwNvvXXF0dWdZecUWUuSYxtRjzXrWvMaH/cl1RwQEE=;
 b=oUYIH3fiwpAAi+QD7zRJGbjGssGM+Vqq/0BIbqvTaonsvksRXg+MTUmLHpY3YorC3m
 FqK472MfEbGgqlAq4Lx3O3aeQbEcAl2Ob/ehGbUI6mpTHEsrmZd/bBP5RSkYw1aU9R+B
 eq+/XtIkn8BNV7oJ+/An2Sr5sTNXV4zIvIsj0AZKss0CWTDNGSYXx1S6XFIe0+zPIC9Y
 bNpotwfOfgDJnUK6adiGs+HFxCjhl2916+Gilww+dI+9a0fQAvQtXeKR9cZaFT2k8yNg
 5d1g3bVJv54Gik2zLfGiLQGTgAyTZyRKIZXE1yAblLEVAz9LyAiTJjHo6m4PG/iWPHI6
 xvyg==
X-Gm-Message-State: AOJu0YzBY/mSqNxblY6eiY5cZMJw9YK/8Bt1SsJlDQ7chnf2ZYomSXxl
 yzHPmc9/7RcGYmCQemNM/0pj2OspKuy8UbnZn04jLmF/yX9bUnDg3MAFKz+cybYM/b/XqPWAplh
 j5QIcG+RDCOLXlmrT8dub1qDxDM9M7e9goThE90Qj2FpP91Ul85VwXEafG/D/dSCnOLDSYzUJWN
 oDNp1MzGNjTXziGPyWIZvwiKczTATpT2eBsNdN
X-Received: by 2002:a17:906:a298:b0:a38:891b:4a69 with SMTP id
 i24-20020a170906a29800b00a38891b4a69mr6595606ejz.51.1707839491042; 
 Tue, 13 Feb 2024 07:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw8q89/cws1gngyxhv3bvEwr5N7/cooAfB7n+RJ5w9n5m41ZyixHbYXxqUAJZIXw+OT7jsZQ==
X-Received: by 2002:a17:906:a298:b0:a38:891b:4a69 with SMTP id
 i24-20020a170906a29800b00a38891b4a69mr6595586ejz.51.1707839490747; 
 Tue, 13 Feb 2024 07:51:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXXX6Sd/OX+j8uC88pYTmAsbNl/VEgXUm9brurIzGAcJrSOqR1xSilIBS+rl3nuiVz0awuMgiWgojYLu9rcilabFYMVYhlrH29mvWdp6d6fj+McItI4
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 cx2-20020a170907168200b00a3cee467307sm1038341ejd.95.2024.02.13.07.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:51:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 9/9] mips: do not list individual devices from configs/
Date: Tue, 13 Feb 2024 16:50:04 +0100
Message-ID: <20240213155005.109954-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
References: <20240213155005.109954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Note that builds without default devices will become much smaller
than before; for this reason, it's necessary to use only the bare
minimum of USB functions, in particular only those that are inlined.
For this reason, usb_bus_find() must be removed, as it only exists
if CONFIG_USB is selected by a host controller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/mips-softmmu/common.mak      | 28 +++-----------------
 configs/devices/mips64el-softmmu/default.mak |  3 ---
 .gitlab-ci.d/buildtest.yml                   |  2 +-
 hw/display/Kconfig                           |  2 +-
 hw/mips/Kconfig                              | 20 +++++++++++++-
 5 files changed, 25 insertions(+), 30 deletions(-)

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
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f56df59c949..3aead277246 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -659,7 +659,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: avr-softmmu mips64-softmmu s390x-softmmu sh4-softmmu
+    TARGETS: avr-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu hexagon-linux-user i386-linux-user s390x-linux-user
     MAKE_CHECK_ARGS: check
 
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


