Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B793C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWqd-0005Vo-8E; Fri, 09 Feb 2024 14:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqc-0005Ul-7Z
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqa-0005BI-I0
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:41 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33b0e5d1e89so830169f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508059; x=1708112859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5tqpuQsjOSCV46teFHGbLfU2/LuhZbJZLNOyxR8wfM=;
 b=z3c6egYOaZFh8YSHsVkcTglBB5WjWD13xmWt54tLDQvPsW4gUWCJqzQxawPqgyT4Vf
 jpTwWJzWWYExQw1596CVLTntsuAIFz7qUU5VKUjDrcDhDfnWXH0/pO2iIqgl6ZlTUVwk
 4LuipOysoPGNLWL8QeEd7zUSw3pUEjBpTFinwghFhZa78w6yEzLwDjOC9u5G+dDCzBA7
 i5C2eqLH3S1/ndxRim9M/tzD25/NCx8U3iau9KAUYPQv+W/sWzino+JNF9UK8w8gYvlS
 ej1gcIljvN4SIqY9mP8Y+Fm9XMx9qxtanMwZ+LLC4e/j5B+BNlc+FnejEvrN+luP+yAQ
 j5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508059; x=1708112859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5tqpuQsjOSCV46teFHGbLfU2/LuhZbJZLNOyxR8wfM=;
 b=rGnEWP7dfEcrv8FhzwQxjxAXm1qp277cXHzO55IRxan6il0kV+W8Qqsd3ivw7rxHmJ
 Hv+GEtiYxVd+zdQYXQDZgjZF+V1Ske+0izCeno/amiHVWVWTQfN8tE7uw8wLIrigZJ6R
 MHALM1IbVqXQNGi0tgS4sDR+VjfBDyc4Rclp5hA9f0qQob+Dk/3Q4QMhLJ84eoKY8DTy
 RHKRQEc+d69uujtncTPHitgfNKUAIMDLNfe6WoopWzyABDa1+VWw28MCZ4kRNraLPGN4
 k43t91asjh+f2GG/ek9rPDSMTcc4dPLx/JHptKE4VHTd+OaQUDLO6hwjOzf7ceMWo/Xa
 /BTg==
X-Gm-Message-State: AOJu0YzO4o+uoa9j1yoddZzHHlhPJ34b9B/05VB94ME/RCvzHulx4T0n
 W+GHBLVbIxnkwYn9L1KHhg7cU6/nXVwbU1C0biNJz3qlYB71x4Ncc8BQ9oVwDrs=
X-Google-Smtp-Source: AGHT+IHkLnwY1nKtl9ZnfzHH2zcQXhtxFBh/PGdnQaCkZTVKoHePlz+d7CCDMuTFrAp17YnI5B4kfQ==
X-Received: by 2002:adf:e7c7:0:b0:33a:ff90:77ca with SMTP id
 e7-20020adfe7c7000000b0033aff9077camr11062wrn.29.1707508059299; 
 Fri, 09 Feb 2024 11:47:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXtYP2yMbUmNpzljPhpPogBDIDrVhr3RrjB4JGeXC29ZnDUGyVQHl39yAAhaEZ6tK0PkiV+eUlMxhW2/97+V3mEQqdW9h770RZxPLNd6Q4i5WXuE4vYoNAAPLOg9KQUCKdAlrgNamNtln06nHTEcDPZxIRd2IcES3Ade6lna3tYxPQvvJuR+mwGVHt6gloBF2YCjJrd9evixN9REsM0kgnp1B0RW2xVEiDzLxr4uaA2vbgMQZ00xY0HTyGVceusHpBgBQmvfaATz0RNLncFhEwCK6Bnwd3fofjX37PiIg5rHQ8z0D0/rDfMz3IazIBh5Rtd6KODrNPEByvT5KvuO+zdfvI2gPm6bMaBzoAcRYpQgTMHjRvjpS7ou15V4ESjfFsmMP+MWn2PVSzF092NUChFO8EDnuESsDCPAxjCLW1tEgWagLWMA5nly/wPX9M58hlen8dBytLGmWMQBAW0Xfi/WeCY2PhXb6OgqK9n40zzbRaZxicphz8Q5kMYfGKvY8wlHRgn3X6ITbigi+ZIROWwxz1d2RfgjcwjBqKdrwL21cugdmsLtppJ30wvWQ==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c355300b0040ff2933959sm1550368wmq.7.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CFCA5F8A9;
 Fri,  9 Feb 2024 19:47:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 05/10] kconfig: use "select" to enable semihosting
Date: Fri,  9 Feb 2024 19:47:29 +0000
Message-Id: <20240209194734.3424785-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
Message-Id: <20240129115809.1039924-1-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-10-alex.bennee@linaro.org>

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


