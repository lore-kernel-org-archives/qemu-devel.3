Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9D7C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 11:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQHL-0000cz-41; Mon, 29 Jan 2024 06:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUQHJ-0000cV-AV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUQHH-00075D-Jp
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 06:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706529494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=omAvM3PegbqmdLPmco3Fj0DToHPcNm98Z5iF58HrLIo=;
 b=Y0xWjq3oEhDL+kUT2Qh78GBw39eU0RRi228xrPOGIJcvqWjui5FnfUMlAfQuHmquviZbET
 6TOyaPBEwPBXV3QfcJlR5AotItkaHgRsjIWXfIP8Yi+35jFU3jwtNu+gF6CPDZiwQwgfPs
 LTppfWhqYiXDA4cN5aZ3Zk2QRfvctZY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ZoEut7NjM2C4XwcYGNXNbQ-1; Mon, 29 Jan 2024 06:58:13 -0500
X-MC-Unique: ZoEut7NjM2C4XwcYGNXNbQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a35902091bfso55992466b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 03:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706529491; x=1707134291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=omAvM3PegbqmdLPmco3Fj0DToHPcNm98Z5iF58HrLIo=;
 b=OLv4MCbwHWYlvDwXPihP3E4vWaPLfIXNadmtFsXeJE+4L9XwTTN5L4xUruM0fteT7z
 nJqqsY/7j6ZldWSunzJHAqnp12XWpGicBRrkazJqlKfI9DdSP5/2UA0OW1WN+XazqCa2
 8NqEFn+zXHiXN35oNqdV+uBQgbOaW+0643pMWVLPNiVDjvTOdBmpRT8kww9xFG1tTJXx
 fRgERV63SvA97s5WInLEH6/FZLTXOBEg2LSBvOB0EVNuVjAdEvGNcNzdycvKmjesNwIE
 t8x7wsFjY9xPQ6Nj/4RaFu5XceZdVxNKJZ+ZyM3C/S/rMy4j/Df9Bp2Tr1sYi/iMecQ4
 mh0Q==
X-Gm-Message-State: AOJu0YxLTOMq4jcrt95qhhCcQR0vkpk7UW5QNkbpiJE/XEPTKSWJ8UwO
 2VqayEzSW4VClTD/LwZxHg7TiWjr3YFIzJUWJV46iXQGgO5U3qelGnxI+c4iiS4mYhegfhxd4QY
 FJ8Ge7WlWbAZs6Op4WqSn7GG0if5T4Hnp3F04rhPo6xQsy90zxiZIbY5EG1jloCvDHsIRJq4LJU
 f2KlhcqtCOXhGgPU/34XtGxnDuE2yzHVTb2S4K
X-Received: by 2002:a17:906:134f:b0:a2c:88d3:754c with SMTP id
 x15-20020a170906134f00b00a2c88d3754cmr4388168ejb.40.1706529491390; 
 Mon, 29 Jan 2024 03:58:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCTvfdVmUTxBU83/4GWpKhu54LK6NRJECwz8nWxNcoSu3l6hMosq/FlM2dageEoCXw4xkeZA==
X-Received: by 2002:a17:906:134f:b0:a2c:88d3:754c with SMTP id
 x15-20020a170906134f00b00a2c88d3754cmr4388146ejb.40.1706529490884; 
 Mon, 29 Jan 2024 03:58:10 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 vh11-20020a170907d38b00b00a35e6802bdfsm373913ejc.183.2024.01.29.03.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 03:58:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] kconfig: use "select" to enable semihosting
Date: Mon, 29 Jan 2024 12:58:09 +0100
Message-ID: <20240129115809.1039924-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just like all other dependencies, these can be expressed in Kconfig
files rather than in the default configurations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/m68k-softmmu/default.mak    | 2 --
 configs/devices/mips-softmmu/common.mak     | 3 ---
 configs/devices/nios2-softmmu/default.mak   | 2 --
 configs/devices/riscv32-softmmu/default.mak | 2 --
 configs/devices/riscv64-softmmu/default.mak | 2 --
 configs/devices/xtensa-softmmu/default.mak  | 2 --
 target/m68k/Kconfig                         | 1 +
 target/mips/Kconfig                         | 1 +
 target/nios2/Kconfig                        | 1 +
 target/riscv/Kconfig                        | 2 ++
 target/xtensa/Kconfig                       | 1 +
 11 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/configs/devices/m68k-softmmu/default.mak b/configs/devices/m68k-softmmu/default.mak
index 7f8619e4278..8dcaa28ed38 100644
--- a/configs/devices/m68k-softmmu/default.mak
+++ b/configs/devices/m68k-softmmu/default.mak
@@ -1,7 +1,5 @@
 # Default configuration for m68k-softmmu
 
-CONFIG_SEMIHOSTING=y
-
 # Boards:
 #
 CONFIG_AN5206=y
diff --git a/configs/devices/mips-softmmu/common.mak b/configs/devices/mips-softmmu/common.mak
index 7da99327a77..1a853841b27 100644
--- a/configs/devices/mips-softmmu/common.mak
+++ b/configs/devices/mips-softmmu/common.mak
@@ -1,8 +1,5 @@
 # Common mips*-softmmu CONFIG defines
 
-# CONFIG_SEMIHOSTING is always required on this architecture
-CONFIG_SEMIHOSTING=y
-
 CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
diff --git a/configs/devices/nios2-softmmu/default.mak b/configs/devices/nios2-softmmu/default.mak
index 1bc4082ea99..e130d024e62 100644
--- a/configs/devices/nios2-softmmu/default.mak
+++ b/configs/devices/nios2-softmmu/default.mak
@@ -1,7 +1,5 @@
 # Default configuration for nios2-softmmu
 
-CONFIG_SEMIHOSTING=y
-
 # Boards:
 #
 CONFIG_NIOS2_10M50=y
diff --git a/configs/devices/riscv32-softmmu/default.mak b/configs/devices/riscv32-softmmu/default.mak
index d847bd5692e..94a236c9c25 100644
--- a/configs/devices/riscv32-softmmu/default.mak
+++ b/configs/devices/riscv32-softmmu/default.mak
@@ -3,8 +3,6 @@
 # Uncomment the following lines to disable these optional devices:
 #
 #CONFIG_PCI_DEVICES=n
-CONFIG_SEMIHOSTING=y
-CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 
 # Boards:
 #
diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
index bc69301fa4a..3f680594484 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -3,8 +3,6 @@
 # Uncomment the following lines to disable these optional devices:
 #
 #CONFIG_PCI_DEVICES=n
-CONFIG_SEMIHOSTING=y
-CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 
 # Boards:
 #
diff --git a/configs/devices/xtensa-softmmu/default.mak b/configs/devices/xtensa-softmmu/default.mak
index 4fe1bf00c94..49e4c9da88c 100644
--- a/configs/devices/xtensa-softmmu/default.mak
+++ b/configs/devices/xtensa-softmmu/default.mak
@@ -1,7 +1,5 @@
 # Default configuration for Xtensa
 
-CONFIG_SEMIHOSTING=y
-
 # Boards:
 #
 CONFIG_XTENSA_SIM=y
diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
index 23debad519a..9eae71486ff 100644
--- a/target/m68k/Kconfig
+++ b/target/m68k/Kconfig
@@ -1,2 +1,3 @@
 config M68K
     bool
+    select SEMIHOSTING
diff --git a/target/mips/Kconfig b/target/mips/Kconfig
index 6adf1453548..eb19c94c7d4 100644
--- a/target/mips/Kconfig
+++ b/target/mips/Kconfig
@@ -1,5 +1,6 @@
 config MIPS
     bool
+    select SEMIHOSTING
 
 config MIPS64
     bool
diff --git a/target/nios2/Kconfig b/target/nios2/Kconfig
index 1529ab8950d..c65550c861a 100644
--- a/target/nios2/Kconfig
+++ b/target/nios2/Kconfig
@@ -1,2 +1,3 @@
 config NIOS2
     bool
+    select SEMIHOSTING
diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index b9e5932f13f..adb7de3f37d 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,5 +1,7 @@
 config RISCV32
     bool
+    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
 
 config RISCV64
     bool
+    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
index a3c8dc7f6d7..5e46049262d 100644
--- a/target/xtensa/Kconfig
+++ b/target/xtensa/Kconfig
@@ -1,2 +1,3 @@
 config XTENSA
     bool
+    select SEMIHOSTING
-- 
2.43.0


