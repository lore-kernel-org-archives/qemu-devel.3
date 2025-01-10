Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9CDE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJRe-0004u4-3X; Fri, 10 Jan 2025 13:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJRc-0004tf-GX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:09:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJRa-0004ev-Ii
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:09:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso25165045e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736532551; x=1737137351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=94dPOddxHoStyFe5gHQ+E8+YoIAsJ120fCrM5/9xEVo=;
 b=d6x/+AdLWP8z9/4jpms8hXb73jsxCZXGcsvxuxI7699/5kr2r/pttL56RZZu5Q2FPW
 g6DN4olr12eEkqS94CND8TdSVpSiM4B4LqoDUHYCkU02r2AeKMbC6ulA+ebdgoYytduH
 fyncjNJYbjbecNiWhEHCDUap3P08EusOHuXYKP9cOTBVtasor3MJGBAgfTr/tJn65N7Q
 AJOZejM+jFCZGilIXkwDXBUTlJ6EhBxOwq8XgLAMXXMRwKKsyb547LTg+bCuki4IgTTE
 TLBrR3U/9ojCKw65qauAnQgIdJ0h8To86/C2l7JGLDKQmh96oUzjTt2wcePNwbcx2Ecg
 FMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736532551; x=1737137351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94dPOddxHoStyFe5gHQ+E8+YoIAsJ120fCrM5/9xEVo=;
 b=kbSUbYlCw0A07+Qy8RUYa4YzFU7ZWCl+G+W+9I1T/zW7kfKPdfzUXWOChqYvc2jquZ
 w6YytF3Oong3PgDmAuiLx+vc5RNVrpVFwmwsXuAwlAXGIYmc/SYLq32dbI1R2KjXnfQ7
 vmcn/CarBV3TLpidnKX/yWdHfCHFSlzjkSc9/WFf5fG5uH1O8nTAC5vJTHaqq2WPXQVg
 6/E3JK01as7Pj1RhMxuUlzS7Q3mWfjYjk0ehjhiKPZ+LYsCmLJ/3hcFHaJyDetWEVU97
 mj/3Qm6Ok2Q3rKOLUR3CcjUAKzawoIGtExb3ba0zMgXLrI+qIlB2yYqPxxROdECKIqGa
 sArA==
X-Gm-Message-State: AOJu0Yyd24Ez2rh8oE2rlEEWeKttS3vK6KgG3bS1bPgIXXwqMaunqxEM
 5kUZzM+psFnjZLDzpHd1wyGvxwmY0aRjQl+LMa9dkn2AnIlwUwH2FUwe8tNm1Bun5vY4MfQgTuk
 XHjQ=
X-Gm-Gg: ASbGncsiTKu6oT4SoLkTGe42iiqUzFIjeoROkLwWw7C4F5E4NAEBzururcCdshblOKT
 1EawW62fczGVJRjtSytauHffBMvpn5aWhvPmQgnKAqvpf2opsDHNVUd/WlFMH6ttRb9IqczN0yu
 u8KeKoJgLdayVmRhfVq53yad5VMZh1YuGTIFMUcDI2LB1PpGhvkK6VkWEWPINgF0+2IjlglzSv1
 ODnc34nXvCgetVW3f46kRC8T0i65W1Fysvz5GEIU87gLxdfVmGjiCauoXnRJPZTSetJszN21zA0
 tBaX3jiE0+meEy5znV56ARjsxozVmrY=
X-Google-Smtp-Source: AGHT+IF9h+Lg5s+kt+FlASSUD6NcoF2rY4aiumH+tpQl5hpRX2ojK6j8XlCCdlesClpThrG4vTwTog==
X-Received: by 2002:a05:600c:1d07:b0:434:fa73:a907 with SMTP id
 5b1f17b1804b1-436e269a5f5mr111516085e9.13.1736532550547; 
 Fri, 10 Jan 2025 10:09:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da66e6sm94655495e9.4.2025.01.10.10.09.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 10:09:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/tricore/triboard: Remove use of &first_cpu
Date: Fri, 10 Jan 2025 19:09:09 +0100
Message-ID: <20250110180909.83165-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

triboard_machine_init() has access to the single CPU via:

  TriBoardMachineState {
    TC27XSoCState {
      TriCoreCPU cpu;
      ...
    } tc27x_soc;
  } ms;

Pass it as argument to tricore_load_kernel() so we can
remove the &first_cpu global use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/tricore/triboard.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 4dba0259cd3..9cc8d282ff2 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -31,11 +31,10 @@
 #include "hw/tricore/triboard.h"
 #include "hw/tricore/tc27x_soc.h"
 
-static void tricore_load_kernel(const char *kernel_filename)
+static void tricore_load_kernel(TriCoreCPU *cpu, const char *kernel_filename)
 {
     uint64_t entry;
     long kernel_size;
-    TriCoreCPU *cpu;
     CPUTriCoreState *env;
 
     kernel_size = load_elf(kernel_filename, NULL,
@@ -46,7 +45,6 @@ static void tricore_load_kernel(const char *kernel_filename)
         error_report("no kernel file '%s'", kernel_filename);
         exit(1);
     }
-    cpu = TRICORE_CPU(first_cpu);
     env = &cpu->env;
     env->PC = entry;
 }
@@ -62,7 +60,7 @@ static void triboard_machine_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&ms->tc27x_soc), &error_fatal);
 
     if (machine->kernel_filename) {
-        tricore_load_kernel(machine->kernel_filename);
+        tricore_load_kernel(&ms->tc27x_soc.cpu, machine->kernel_filename);
     }
 }
 
-- 
2.47.1


