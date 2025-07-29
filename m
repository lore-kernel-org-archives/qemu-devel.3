Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF81C87FCE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguQx-0001Qi-Og; Tue, 29 Jul 2025 20:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEw-0001HS-8f
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEs-0003yv-Ni
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:12 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-75ce780af03so5457455b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833609; x=1754438409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k+/UhXm/gWEv2l8V5Fg2cCxbxcPKP5GDojGjN4Gy2Hg=;
 b=xVfX+S6PHFyeM4Iuvt/zZPLb2V2RbSSFjNSzpN4DP12J1HFIfc2V4vursmocm21MR3
 WBhmRZW5VtP0S9klLcrcOi4IN6CDZN2GUHZT2noJiSZv+JzPAYAXxgeC4SRiU1MRkgtz
 8IQfHX3xz93+ctwYBdjmjVa+//+JpyP7gxOEYerZDtrnHO3A/4wfQ/A2EffdfRCcpadi
 1AK/eBmrZQPRkaQYRq+PkTpkK/FsU2xtAQSoVoExgmKOpLD4nzx1BFj5xniaty4Xnxfn
 QikCUlQKSt4qxwO+jJF7ueU+TRTE0n8lJx/ne2BFNGI1NgvVbkTjJUsa9KtBmN8Lwh0v
 NChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833609; x=1754438409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+/UhXm/gWEv2l8V5Fg2cCxbxcPKP5GDojGjN4Gy2Hg=;
 b=DD0uOLt5RvW0x0r6kj6malXm2e3r4HITbCkmtlBjEf9dsWddhvafHLbR8FTJ9iJ43O
 pKKxp/P20YCv3NHYUe6Lpzf1tp4aS50zRfNcia1/yO+zOMY4z9pEY3xBXlHt3S2HMmSE
 H/5A1UVPtFcBYB3PSww0zFM1nyOauqrbxw+8S2K8dhwtBZc2nwcSi4BEH8E7CH7yCN0j
 G3Ykd1pv5pjT+J/JblJd1mRreNKIF+4UwgE+660r4KP/BHVUUORCbag1WONd7SCLPdyL
 5NOGnuVijuEowoOYjitYpO/paxeCV9wsogXxODI9XfJ+NGv3JCvZAOYeM0neegy3GxV9
 44ng==
X-Gm-Message-State: AOJu0YyyAfX4GlaQhC6mEeWtT9zvfJNU4ariMv9u04gsksoCJoKjeRt5
 E3bPBN+IboxRyz8Y+3wDlwZrS+lYFyFbOixW8BeWRYdnX6+dmKqb0M1uAsVGvifL3/KMQO5ezXI
 I7Plb
X-Gm-Gg: ASbGncvNQQPVLGsMd/kV0QVFXZo1c2PRrU2QoyXNpM3cnwEpPYD5V0uFIJg6W/5v37r
 IUY4gB4VjafGf3RCC+ida3M0aHMyBcIWUTVs8+yuSjkFEjhdqAvGAI/Wm3DPuHZ95RovTt3XD+G
 T9KXAEPHDcoYvG7I55wmXpYY5XXs3f8oBu3cZFdh53nSRYwrhS93zxhCWNrAzJhfAsEaWflN5GP
 /Eqjz6QseM2oTSVUMJymMMSgfOPmniZm404JfYmBhTmVrcUvloyQkPOyLUSQGaEQMyTTcBsySX8
 rAHVhnHTGj4dl4+TaS58IXMLGRhUU+oCVlJrXAjMetS2cqYUkJ3yMoTo/urrDIQ0/KQUWU7sFwj
 iOGiboPwPM+mcsRdjTyMRjqs3ZhTQaMOSppREsYSWk+eNvSFP3KUhdvn7etfIQiiGMkk57N75Nh
 nmwxJD/+IRdw==
X-Google-Smtp-Source: AGHT+IFCBQYFTmAflbiYeCWO3j1Hu9Refh2NAcTy6oxxLpYTfuv0UVbxvY9IM7EkG4LzPT0od0wGzA==
X-Received: by 2002:a05:6a00:ac8:b0:746:24c9:c92e with SMTP id
 d2e1a72fcca58-76ab1614553mr2318474b3a.8.1753833608414; 
 Tue, 29 Jul 2025 17:00:08 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/89] linux-user: Create target/elfload.c files
Date: Tue, 29 Jul 2025 13:58:34 -1000
Message-ID: <20250730000003.599084-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare to split the main linux-user/elfload.c.
Create empty files for each target, and add the
common build rule.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c     | 1 +
 linux-user/alpha/elfload.c       | 1 +
 linux-user/arm/elfload.c         | 1 +
 linux-user/hexagon/elfload.c     | 1 +
 linux-user/hppa/elfload.c        | 1 +
 linux-user/i386/elfload.c        | 1 +
 linux-user/loongarch64/elfload.c | 1 +
 linux-user/m68k/elfload.c        | 1 +
 linux-user/microblaze/elfload.c  | 1 +
 linux-user/mips/elfload.c        | 1 +
 linux-user/mips64/elfload.c      | 1 +
 linux-user/openrisc/elfload.c    | 1 +
 linux-user/ppc/elfload.c         | 1 +
 linux-user/riscv/elfload.c       | 1 +
 linux-user/s390x/elfload.c       | 1 +
 linux-user/sh4/elfload.c         | 1 +
 linux-user/sparc/elfload.c       | 1 +
 linux-user/x86_64/elfload.c      | 1 +
 linux-user/xtensa/elfload.c      | 1 +
 meson.build                      | 6 +++++-
 20 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/aarch64/elfload.c
 create mode 100644 linux-user/alpha/elfload.c
 create mode 100644 linux-user/arm/elfload.c
 create mode 100644 linux-user/hexagon/elfload.c
 create mode 100644 linux-user/hppa/elfload.c
 create mode 100644 linux-user/i386/elfload.c
 create mode 100644 linux-user/loongarch64/elfload.c
 create mode 100644 linux-user/m68k/elfload.c
 create mode 100644 linux-user/microblaze/elfload.c
 create mode 100644 linux-user/mips/elfload.c
 create mode 100644 linux-user/mips64/elfload.c
 create mode 100644 linux-user/openrisc/elfload.c
 create mode 100644 linux-user/ppc/elfload.c
 create mode 100644 linux-user/riscv/elfload.c
 create mode 100644 linux-user/s390x/elfload.c
 create mode 100644 linux-user/sh4/elfload.c
 create mode 100644 linux-user/sparc/elfload.c
 create mode 100644 linux-user/x86_64/elfload.c
 create mode 100644 linux-user/xtensa/elfload.c

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/aarch64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/alpha/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/arm/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/hexagon/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/hppa/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/i386/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/loongarch64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/m68k/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/microblaze/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/mips/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/mips64/elfload.c b/linux-user/mips64/elfload.c
new file mode 100644
index 0000000000..b719555e65
--- /dev/null
+++ b/linux-user/mips64/elfload.c
@@ -0,0 +1 @@
+#include "../mips/elfload.c"
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/openrisc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/ppc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/riscv/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/s390x/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/sh4/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/sparc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/x86_64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/xtensa/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/meson.build b/meson.build
index e53cd5b413..516b1a43c3 100644
--- a/meson.build
+++ b/meson.build
@@ -4325,7 +4325,11 @@ foreach target : target_dirs
     )
     if 'CONFIG_LINUX_USER' in config_target
       dir = base_dir / abi
-      arch_srcs += files(dir / 'signal.c', dir / 'cpu_loop.c')
+      arch_srcs += files(
+        dir / 'cpu_loop.c',
+        dir / 'elfload.c',
+        dir / 'signal.c',
+      )
       if config_target.has_key('TARGET_SYSTBL_ABI')
         arch_srcs += \
           syscall_nr_generators[abi].process(base_dir / abi / config_target['TARGET_SYSTBL'],
-- 
2.43.0


