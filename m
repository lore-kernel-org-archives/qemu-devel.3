Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA376C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 16:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0et-0008Ml-SK; Wed, 02 Jul 2025 12:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX0eq-0008ME-In
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:50:04 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX0el-0001cX-B5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 12:50:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so4083320f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751474996; x=1752079796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MFWihvNMKycK7txqjnxVgUQ86ta0v8e4dq6MRRK4k74=;
 b=sqQapJusJ0CnduB+Kw8rzxMODOuV/cJBQTPGQjrLePRLW5JFMzsYVe0LDJLQebkxEV
 0tM4N4rOThT4XYXZ/eY0bVe/wpxD70/niu2s0aJ1cQA7PrWBfenI/c/+MEpaINKsspHU
 +1sRpX5N47FT3BCJZkVQr861BJQhKLArJjiZQT2n+xetjw+lwnuPUw76VuJH6MyOwmsc
 67QWMEZWcfYHSSQbSOxuI945J7JRvJT4QJjvwmQM4SGlRtZ5OQmSC91+a8iSVGhVnpuk
 SGl1v4+5jz5L2VWu84Ecu9yCk4OxZt7wp7C/FeLSAm0iEfsiR7fBTMCjS/bVRb8/6ZFc
 zZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751474996; x=1752079796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MFWihvNMKycK7txqjnxVgUQ86ta0v8e4dq6MRRK4k74=;
 b=N5CFoFMn7n9YI744N1AtQJfB5Qhm2PTTNLjr5aGC1FxcHU3Npwj12pTIVCNqsazRbA
 /xwQsJzYY5sQ7eBzvWDWxon2Q+5XNDoMbgwCEV0JoDnxzeRzUSPqEvlvnADhdpfvRy5W
 Dw/dQDQYSJmErAbzXcAze4HwHNTnnR7jKi8HmzpqAY1YM0QV3PZFNy9Q2Ua5TDIji7wD
 FUiGjkHEMJLxdLXLaBoitTQvaLwsON87YEmBaq4mudxhUscWjqrY2TmwRj0g05EfKNPC
 BtKIELfiisJw2cq55V+fF2Aktru0QqbbImkdOX4dMsycjY2HkuAyC4kDNnkZ6B2lg2au
 /j9A==
X-Gm-Message-State: AOJu0YwM3NOB8iDnWfw2b8qjy3HarWyiqz+MRIwG3JSB6aGnk3ALIQrC
 8RRJq/JZEEXX2v4ZZE2H0NHdeI8jjJgYbLG0U+2CMqDa5ekVoXaUe77ZpBisI2B1qKEZsMOInmL
 94jGO
X-Gm-Gg: ASbGnctKHPgnbuJcwvIyNzouIX6Cz3BxwcQopWn1DMmYUNwfnEMkn9nw/tkVMdcN3k1
 i3dofvWjIobbxCXHcN4iYLQo6dajMoiqXVNOmVAtSC57Fsms7SUA42odKDtUtZkPxtQcSzslGTV
 QmawRjurk89UderhVYI0K32WFEBlZ7YfNilha/eG6B6QcUqwwULWgn1Ac5WnR1iGYpw8dByoc7k
 i7kLmAXkqsVEH/qDgqHOOC5OJkHTt0FnpJYOtmX0zj1YPwUcT2rKLFYMujLtO80mgu/OjYrQHwt
 oMTzmh+FzW45GnwBOWYR4V9RIV9ls5CGOcE+gfZseVsG9IvECPybirBn/1a/I659qOjgcN8srqL
 lrJwkp0n3uZeZk4hqE/r7OB1/1NRSLZhZho5+hSa4POXUQyc=
X-Google-Smtp-Source: AGHT+IHoaAU9PEDThI30xWG40n34dCfof1lDAvUootAWGQGX2c4q0BuAfGYiYYGiADu1tWYOdJ3cOQ==
X-Received: by 2002:a05:6000:2511:b0:3a4:ed62:c7e1 with SMTP id
 ffacd0b85a97d-3b1fdf025dbmr3294173f8f.12.1751474995678; 
 Wed, 02 Jul 2025 09:49:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e598d2sm16363159f8f.76.2025.07.02.09.49.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 09:49:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] hw/mips: Restrict ITU to TCG
Date: Wed,  2 Jul 2025 18:49:53 +0200
Message-ID: <20250702164953.18579-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

MIPS Inter-Thread Communication Unit is implemented using
TCG. Check for TCG both in Kconfig and CPS source.

Fixes: 2321d971b6f ("hw/mips: Add dependency MIPS_CPS -> MIPS_ITU")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/cps.c   | 4 ++--
 hw/mips/Kconfig | 2 +-
 hw/misc/Kconfig | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 2a3ba3f58d2..e47695e2b0a 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -24,7 +24,7 @@
 #include "hw/mips/mips.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
-#include "system/kvm.h"
+#include "system/tcg.h"
 #include "system/reset.h"
 
 qemu_irq get_cps_irq(MIPSCPSState *s, int pin_number)
@@ -59,7 +59,7 @@ static bool cpu_mips_itu_supported(CPUMIPSState *env)
 {
     bool is_mt = (env->CP0_Config5 & (1 << CP0C5_VP)) || ase_mt_available(env);
 
-    return is_mt && !kvm_enabled();
+    return is_mt && tcg_enabled();
 }
 
 static void mips_cps_realize(DeviceState *dev, Error **errp)
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index b09c89a0175..f84fffcd323 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -76,7 +76,7 @@ config LOONGSON3V
 
 config MIPS_CPS
     bool
-    select MIPS_ITU
+    select MIPS_ITU if TCG
 
 config MIPS_BOSTON
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f8..e9a9405d2f1 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -107,6 +107,7 @@ config STM32L4X5_RCC
 
 config MIPS_ITU
     bool
+    depends on TCG
 
 config MPS2_FPGAIO
     bool
-- 
2.49.0


