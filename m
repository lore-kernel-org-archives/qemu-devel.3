Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FC7C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribeQ-0003WT-Kc; Fri, 08 Mar 2024 09:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribe0-0003ED-1a
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdx-0005TA-QQ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KoCC3GLxKllev6oWHU5ANiWBK8CXBJdkMjLAQdqd4w=;
 b=gs9Ew1agtIEk4oYd5CzHkkadsULTJCMmgxfpUiAqlfsTaK8ZrNwmqzJ2W8R+WQegiyOmTa
 EcNrEbQf3ESCQOfocvpaSX1Hb6cf2WpRmq918p3VaWA19TuvxelqdBIHUvlDfqF2BlfHL8
 iU09Oun4mZS7zmVhFSuSZAMdqoZHGd8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-y2RrXjsOPyuhNrYwNnA2xw-1; Fri, 08 Mar 2024 09:56:14 -0500
X-MC-Unique: y2RrXjsOPyuhNrYwNnA2xw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d33a42c1f9so13730631fa.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909772; x=1710514572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KoCC3GLxKllev6oWHU5ANiWBK8CXBJdkMjLAQdqd4w=;
 b=F3X7YuZca8OV9GBG/4go11nV3ec2Ve/ZVqPOnMJ3ZggyBuTCHxjWvyKTB4PeB2H2MD
 A95UAlpktwaOAdcZnlunxiF+fuV/GV46ZLCH7FGeI2YjEZbWMthiJEu/0u37/dlwvitY
 DS/0znwa9Q3nFBNrB3ZTiO60gXV5yx/X/uiZw9VXqPHUrQrtVhKgA9tdH/fD3I59uDKu
 teW8RTAEI2o/VKw8oDdmoS4el+lK9RdyFGWE71jCaqF0Xt1xkXn+pZ6/YWbtdUSMuJBX
 AxqUuOtAm2O1nSspBzVKJpkdxm8+Wh5ZtUUYr6Qx2mVo2zslNTW2IA3SRepriyHi/YOy
 fcjA==
X-Gm-Message-State: AOJu0YyCuFAVF1ja4auSOd86kEDyhs18PgGrYsJSGWWb49xLQGoTJP1y
 KCLgc4QMNtQNVDbViIDnYX9EZid5SbAo6wpxUlSbobakJWUeUxXUEg+kKIkPz+/+zdhctNgGWi8
 db0dAnnI1MkPTgDUVz2LKT1mAP2u0FYEiNA7l9fs1Easpnol5R1DICFvX1C0SQwVnl2pa0PpVKG
 MS1Edq3x3urAy5okjLr7XAj+8CdCGDPRZCHH0j
X-Received: by 2002:a2e:9086:0:b0:2d2:a38c:d706 with SMTP id
 l6-20020a2e9086000000b002d2a38cd706mr3524489ljg.17.1709909772272; 
 Fri, 08 Mar 2024 06:56:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHijXF/FjI95bj6eq+GJznKzg26lWK6CM4VadJWHveEyYmaJdet9SVyOUiDjVgljWVcq5/JGw==
X-Received: by 2002:a2e:9086:0:b0:2d2:a38c:d706 with SMTP id
 l6-20020a2e9086000000b002d2a38cd706mr3524481ljg.17.1709909771900; 
 Fri, 08 Mar 2024 06:56:11 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a170906094c00b00a3e5adf11c7sm9340780ejd.157.2024.03.08.06.56.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] mips: do not list individual devices from configs/
Date: Fri,  8 Mar 2024 15:55:49 +0100
Message-ID: <20240308145554.599614-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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
Builds without default devices will become much smaller
than before, and qtests fail (as expected, though suboptimal)
for mips64-softmmu because most tests do not use -nodefaults,
so remove it from build-without-defaults

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
index a1c030337b1..901265af95d 100644
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
index 07acb37dc66..234c7de027c 100644
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
2.43.2


