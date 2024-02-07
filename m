Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EFDC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwQ-0002x9-15; Wed, 07 Feb 2024 11:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwN-0002uW-8J
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:27 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwL-0006Al-DI
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41008ab427fso7701325e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323904; x=1707928704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bsz/mh6XyPunNIOKbf6F3e4icAT2FQKVXxwZaYNEmKM=;
 b=rhHFl7tw2jpXI13lBCgMSK1yP/oh1HLPsr4H3127lyXODA1a8EAEN4IWXq9Q40Ut3u
 EDVZukVm3ltYiE5Ld679algo9UL6/6yyloBa5Z6Uvr/zVppdzWCTDCZPnKmFJfPEeQIV
 E2aM9oJqfiEaLhT5a8ImuHzAQhopdWmwYNfE989qX8oVfFXgYd8KRtf8duFvTfLqLJFd
 P3XqBx98LmXdKo/QxjWVout2zqm1fSL3S5plgAM1inwipYFiEab6yMgGIM6joIDWmZkf
 1qdnyKwit1pTinebN0gh56KOMUrjt/gyA506gOH8eEbK2YrypZyHovQBp1R4kCfrjMwT
 mH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323904; x=1707928704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bsz/mh6XyPunNIOKbf6F3e4icAT2FQKVXxwZaYNEmKM=;
 b=dS7XxJepe1jRKU1tOyrPqGvMl570xTATaPftHYicwerEFxcPPSmZ1eQdcjmUNN5rRZ
 1bHaFPl4/S5qgUB+DYpjG2ZY2kQ1J9YxM7/uNoTrb2JjgBoFaATvC46KDqa+BjLmNBqs
 rtf2OPudEM5wS/vlBn6g5trGpQbkwWYEAO8ZrjpZngl8CIV2+skZq8V1o5uag+8b/cc2
 qLYF3Q/SZJfoW1HC5V+30m37uYOQiAHFrSVRj9FoVADf7796cgDXYr/bUE+is1RbyrxU
 XBoOk0X5C0Swkt4YT5qCW0ARu+xnCo2MANHBqmCNGCUUSO0+wDRxVMFtRLJ21k+Zc3ss
 iyZw==
X-Gm-Message-State: AOJu0YyVQFHlzvu7Kbf/wdoAzhvUdOu3VmxmOuDuBzLm3jG+Y3ONdQsC
 K2d43J4nh+9CUYZjq2rY8F+LZyKt9JHf1Jg287WXLKoQad3EZn+qGPSrz1+5NR8=
X-Google-Smtp-Source: AGHT+IHUFtCZuhHFqo6Q6cjDY4IATjHiYwqiO6zG4jeJc8GNcO6eSaJzHUJoIOMR4DtLxcaJg2fQ5Q==
X-Received: by 2002:adf:ab09:0:b0:33b:26b7:5aa8 with SMTP id
 q9-20020adfab09000000b0033b26b75aa8mr4468170wrc.56.1707323904126; 
 Wed, 07 Feb 2024 08:38:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWKSKDs5pFpnSwz763rVAHqlB9UGVUPt3IyjFem9exc2KAdyjjmiMgWAn9O++Jv2MmvSBlVZJRubAZ2726Mx7oJ9uAy2fzCzZKz1HQiEzhp3HIq9JxCcnXjo0zTjpLPTyCz8kwIryVlDxSizi6pmIXOU5PMz6AD/Y9IXFi9xTVbjYzIUh/4MtnlGCDNoTLKFyhokg5jvgPXKu5CjBjmvkXtG5W80kKvE6thf2V9HNG3ODrZhjtq9oG6DPS+Ftuhjl1wSlkOJvylzyg2Pm4mVqv6zLtY3c4XGnygxaQWlWz8YXWGw3p64RCzbzexytTnHgOq1P2eFWTctPZIcJ1U74+3DEbd3ruzM6a9JcZgRlwt+ZX+iznBtwRd/QC7UM9si2cSy4YFjbsA1+SA66w7FB0CqR0hJI51473jjFI2hkKvmIUyzFtHoPSUo2dwVigMJw/qN4JihI9klknFMcbtDDOqSsm4Ywt+OlwvMUHGYbVphy3gZQY9OcPV93u3xCI+IGHY7KnGEGy7lp9bxlwvop+RkM7o/MzyYUFy08cMgqcGDJAjfnwrHyvduXNLqGC/LKJgLvK61S4fY9zJRClQ2madZr9clhNIRc94SIfuWTTHyHLexvAQ2hknO1HeAA2lfIF3TMh0gPk+oVkf6n+88s3dhqDbmZeytoNct91Hf1a/UfOr6WxrRrj8RP4k17hBzhM9rhUyXMpJwXYHPVmpDZRJxQckFqOJehI0lpxzAZXsrYqynWbo28ft3y/YNDp/PsD4pDqlqJyXDYKMsO5bV+7Odf8dMJp7NiazSfKFCMdsk27uzi/LAUirJwMoUiHmk1qQK8CLIroF3cI=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h6-20020adffa86000000b0033b0d2ba3a1sm1849517wrr.63.2024.02.07.08.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F07435F944;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH v2 09/14] kconfig: use "select" to enable semihosting
Date: Wed,  7 Feb 2024 16:38:07 +0000
Message-Id: <20240207163812.3231697-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Just like all other dependencies, these can be expressed in Kconfig
files rather than in the default configurations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240201122835.1712347-6-alex.bennee@linaro.org>
Message-Id: <20240129115809.1039924-1-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.2


