Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446C9C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMq1-0006AX-G3; Fri, 09 Feb 2024 04:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpz-00060U-IE
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:23 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpx-0000k1-H6
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4106ccf0effso2198355e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469579; x=1708074379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoZvEPhif8MxqPqYvi0f+lZWa93ax0j+gUCJerzTQQw=;
 b=L/DsYVm/rCvK+mekIUPycmaUjBqq5sKtuWHqRy2RrnSRcrkDzMXOJjmJRRMZgjuBeO
 PILdSj8/9GQLrnzs1C6RL45RMEM0rml2yt1vxU0hxWOkbVJgW4MkGJ2qgulCjm/DuFdE
 sUqcviKSZUergDgw2XL5p2fy1onqfTuOq6lim/Cu1tCdUe/NwHWmkkXW48EIEXnJDvTi
 xNo5eK9qCkCus3AC+9qYaqlui3mlhOJ9ICQday6FogsH6aojKVhpZh9AASrbxmrqDeyp
 n+i4l0tneUzQwpRdxHExuN3GhXT1fIM533ic7Bca2q9Yrd9rqDU+e3A+TS7mvAl2OO+i
 aC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469579; x=1708074379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yoZvEPhif8MxqPqYvi0f+lZWa93ax0j+gUCJerzTQQw=;
 b=eKTF46mnty1ItVJFu7oUUmsWlr0nA0ua7knQabLXSeVQJid2qpyOaKX5RQO/0Qqx9q
 BOX2y+nogHrwHr/TS2kmouevwse4+/B85CbYLCQy58HMsljxvmRbZbJ5WmiGNGuKHe+Y
 rVfLOn4Px5FSRXuLKhwwOIsA9CKhP6vsqcQx6ecagXG06njAPVEGs6PJsFS6WJhK6fa1
 WagnYyapspu0Z87/mIyMztDg4LUnV+vSgQOEsNGnqhosfXM50B+8Ko8sNM4syPVtmiE4
 vNTz3Q8u0w2eInBnaWlbPp2JWXCfgVRm9aDYH2R7KSsxirk1GkYQwbf/ufWWwEBS1Adl
 WcMQ==
X-Gm-Message-State: AOJu0YxDXcJx9wICXOS5Qrkhq9GyC726iEI206bO7VDT4E/OEB+2Y/CF
 lg10L/ImMd6tzPn8eszOM7v7VqI88YJtFK4r6wxBKst/4h2RsGmI2y1AAaeDeJeFPDUFyZcGOvR
 XAwA=
X-Google-Smtp-Source: AGHT+IEmXdF8rRsssY91LA0tX1MN+Dl7bs4tGKLyQkHrB+9gOp0J/NI53qrkrthNwuCOeS5uTYdPtQ==
X-Received: by 2002:a05:600c:4688:b0:40f:ddc8:f283 with SMTP id
 p8-20020a05600c468800b0040fddc8f283mr717277wmo.38.1707469579539; 
 Fri, 09 Feb 2024 01:06:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXba0bkHEBVCjQNvRx1q2Nyy1RCIXN2+qbY3wMawd5vW8KefPyxQZtoRKCwm2YTNMjWaL6UQGqa60SkXsCL1UI7lKrpUt6B5I/bPdKjHoEAKz07aIOK+SQ7NlXVRj1kJaPVgDjnmyFmkJmjkPXYtzolEM14QXS5SCl+pMQRdUIw+3gr8G8k2nRRaqb4AseREJ1qrDc7JF+11uUm0YuetxxQQ4MujXLJeaLYhBqD27SBz+V+iHGMNXdrDt+H0kLdQdesGAeJzb4PfsRNLf9H1jK6Q1MIF6o7z9s3zacfNEw8sB9egUiGmiru6EbMKqI3vJWTCdQQaj/S7/Nk9HEQDvmqbWLnq1I=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c19cf00b0041044e130bfsm1930482wmq.33.2024.02.09.01.06.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:06:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 11/11] target/mips: Remove I6500 CPU definition
Date: Fri,  9 Feb 2024 10:05:12 +0100
Message-ID: <20240209090513.9401-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

I6500 support is incomplete as it lacks SAAR (Special Address
Access Register) and DSPRAM (Data Scratch Pad RAM) features.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  5 +++++
 tests/qtest/machine-none-test.c |  2 +-
 target/mips/cpu-defs.c.inc      | 40 ---------------------------------
 3 files changed, 6 insertions(+), 41 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 54081a6c19..d61b4c92dd 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -727,6 +727,11 @@ x86 ``Icelake-Client`` CPU (removed in 7.1)
 There isn't ever Icelake Client CPU, it is some wrong and imaginary one.
 Use ``Icelake-Server`` instead.
 
+MIPS I6500 CPU (removed in 9.0)
+'''''''''''''''''''''''''''''''
+
+The I6500 support was never fully contributed.
+
 System accelerators
 -------------------
 
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 31cc0bfb01..b653a0dd5c 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -37,7 +37,7 @@ static struct arch2cpu cpus_map[] = {
     { "mips", "4Kc" },
     { "mipsel", "I7200" },
     { "mips64", "20Kc" },
-    { "mips64el", "I6500" },
+    { "mips64el", "I6400" },
     { "nios2", "FIXME" },
     { "or1k", "or1200" },
     { "ppc", "604" },
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index fbf787d8ce..ce2c01cbfa 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -778,46 +778,6 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS64R6,
         .mmu_type = MMU_TYPE_R4000,
     },
-    {
-        .name = "I6500",
-        .CP0_PRid = 0x1B000,
-        .CP0_Config0 = MIPS_CONFIG0 | (0x2 << CP0C0_AR) | (0x2 << CP0C0_AT) |
-                       (MMU_TYPE_R4000 << CP0C0_MT),
-        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (15 << CP0C1_MMU) |
-                       (2 << CP0C1_IS) | (5 << CP0C1_IL) | (3 << CP0C1_IA) |
-                       (2 << CP0C1_DS) | (5 << CP0C1_DL) | (3 << CP0C1_DA) |
-                       (0 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
-        .CP0_Config2 = MIPS_CONFIG2,
-        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
-                       (1 << CP0C3_CMGCR) | (1 << CP0C3_MSAP) |
-                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
-                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
-        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
-                       (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
-        .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
-                                  (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
-        .CP0_LLAddr_rw_bitmask = 0,
-        .CP0_LLAddr_shift = 0,
-        .SYNCI_Step = 64,
-        .CCRes = 2,
-        .CP0_Status_rw_bitmask = 0x30D8FFFF,
-        .CP0_PageGrain = (1 << CP0PG_IEC) | (1 << CP0PG_XIE) |
-                         (1U << CP0PG_RIE),
-        .CP0_PageGrain_rw_bitmask = (1 << CP0PG_ELPA),
-        .CP0_EBaseWG_rw_bitmask = (1 << CP0EBase_WG),
-        .CP1_fcr0 = (1 << FCR0_FREP) | (1 << FCR0_HAS2008) | (1 << FCR0_F64) |
-                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
-                    (1 << FCR0_S) | (0x03 << FCR0_PRID) | (0x0 << FCR0_REV),
-        .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
-        .CP1_fcr31_rw_bitmask = 0x0103FFFF,
-        .MSAIR = 0x03 << MSAIR_ProcID,
-        .SEGBITS = 48,
-        .PABITS = 48,
-        .insn_flags = CPU_MIPS64R6,
-        .mmu_type = MMU_TYPE_R4000,
-    },
     {
         .name = "Loongson-2E",
         .CP0_PRid = 0x6302,
-- 
2.41.0


