Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2000C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 13:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5P20-0006l7-Iw; Thu, 17 Apr 2025 09:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0u-0005hq-Hh
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5P0r-0007xu-Kz
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 09:10:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso5885655e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744895439; x=1745500239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qdv1Q8OqgsTLOugo6mmCmTGNXh3d6gbPE71uRqE0Aik=;
 b=JaYB4M5nPkvv34GOCdzYgtOLnIcq7TdsEWG88SPPvDYhXjjdC+ZDB0H1z7DCVvHXZ/
 PcvUqIW4Xz4cNmKl0PLyJMRFCwRhpoqW6PjrE7mIU7EA7PNjrqfkaZnIMbZJk8NUoNZy
 ERBpEoQakQ8BVZ8mK/ASYbPs3zzkJRjwn41h5uQtj0NNb6OHzT9Hox9SRQjDAKqSxD7x
 WtpIRt6p9FOLqoMfFlEOWxHwMIAjEbZVOv4RbIydJ4936GCSzUqlyyAjT01FBgg1RsWj
 OXRjA2rA9snyl+tHJopRsjoVYoiWisJlF1vI3Ao798obfxlMQR8q07Qdmq53iU4ofUIy
 aqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744895439; x=1745500239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qdv1Q8OqgsTLOugo6mmCmTGNXh3d6gbPE71uRqE0Aik=;
 b=tTQg/3k/Poqyl5m7AD2N3ZAYWO6qWQCcyRhPgQ80G9/qX3wdVVYhP+elJCfakuuDRZ
 OgTGuNE4PkKhGkOa240wcHbrVab/POqthyxPwL/eD5/KCAY4Q/JYyVL5aO4LGcVARYar
 JUJA6V/lYkBgec8XM+5IY/pePigdqBJ/IU2ckURT/62upBdQKC/ZD4lYZMro1ogJqvYl
 3ZL3sC1+c2o3qOyYrBcFyfe7QWT2fcVVyT6Q1mySMIhCbO5VPHaQPdNeLHzPKEzvxOqS
 vN1cBtJiQqwq6rLfPzvSxxqZouGi0tAY5njBhY+b2hq9j/XkVsZfZWC7jHIYr1mknyWO
 XLFQ==
X-Gm-Message-State: AOJu0Ywnm7k/sM2Rk6kc06jG2rL312n+NyHYn9Bhpa+uup2ofcEu1wSy
 LwcbylQXmXxKFVIpg3ocRsIOigzpKEnofoPv2z/5gMVukuuUPobkABdyFSZK5onvPKWdFyApfoH
 A
X-Gm-Gg: ASbGncsm41CCKvB84dRo1JRHvXcgOL9ciXEW5ppc9yfoUIhgLqV5JcgPd8FmUGzVnol
 EotbZSS9WH91tGHVYMidyJ/ufzG3OruvLzPLJ37yBVmnDWMdJ/c156Gb8WxcTm9/QTxFDuW9eM0
 z9xCaC86h/Hbmh56m7xLsMu1gHWY12oDxAx9AsLycLV3YVr6vsD1+m/Cnto6e8Pivo0xea4ovEc
 6xQ+WtIdjebLCm1UnqE4zr5h6sg8EGqwu0eiSRTu9YVgckv0uuOWY/qBU1BxblFoM6M79ejxRku
 rQngJ0KGwzq36oDYnEupdHK10eE9HXK1JOyIXLXVE2u1+1TKzqyX43LLzbo7pbFlZsHanHNGzAW
 u9D1bvOqFBZcOZyo=
X-Google-Smtp-Source: AGHT+IF5/9vJ99MpqrOOVPFcTBYoRg+RCBEGx4RWHPdrsLEtSm9Ny0nNd/+SJTWvcedosuOICt/z7Q==
X-Received: by 2002:a05:600c:3ecb:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-4405d625054mr63801305e9.13.1744895438894; 
 Thu, 17 Apr 2025 06:10:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b5abc3fsm54034405e9.37.2025.04.17.06.10.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 06:10:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] hw/microblaze: Evaluate TARGET_BIG_ENDIAN at compile time
Date: Thu, 17 Apr 2025 15:10:03 +0200
Message-ID: <20250417131004.47205-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417131004.47205-1-philmd@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
time via #ifdef'ry, do it in C at compile time

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c | 12 ++++++------
 hw/microblaze/xlnx-zynqmp-pmu.c     | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index c887c7a99ed..bea6b689fd1 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -218,12 +218,12 @@ petalogix_ml605_init(MachineState *machine)
 
 static void petalogix_ml605_machine_init(MachineClass *mc)
 {
-#if TARGET_BIG_ENDIAN
-    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (big endian)";
-    mc->deprecation_reason = "big endian support is not tested";
-#else
-    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
-#endif
+    if (TARGET_BIG_ENDIAN) {
+        mc->desc = "PetaLogix linux refdesign for xilinx ml605 (big endian)";
+        mc->deprecation_reason = "big endian support is not tested";
+    } else {
+        mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
+    }
     mc->init = petalogix_ml605_init;
 }
 
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 0922c652957..2efacc53feb 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -181,12 +181,12 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
 
 static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
 {
-#if TARGET_BIG_ENDIAN
-    mc->desc = "Xilinx ZynqMP PMU machine (big endian)";
-    mc->deprecation_reason = "big endian support is not tested";
-#else
-    mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
-#endif
+    if (TARGET_BIG_ENDIAN) {
+        mc->desc = "Xilinx ZynqMP PMU machine (big endian)";
+        mc->deprecation_reason = "big endian support is not tested";
+    } else {
+        mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
+    }
     mc->init = xlnx_zynqmp_pmu_init;
 }
 
-- 
2.47.1


