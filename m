Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50C6C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjaO-0002dB-Mt; Sat, 25 Jan 2025 12:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjZ8-0001LT-8Z
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjZ6-0000dO-Ia
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:03:25 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1511657f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824602; x=1738429402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UoGE6unHTvdGpTVXrJG1+71hPq/Dfx21A2EoHEuKVI=;
 b=rHJKJoCAVg5Rbx2yswL0xGHxg5CxDn36g3kXFPxPCenmJPX4gotKOmmLtzjo1X0+sw
 /Jc7SJ8lm274ku09Zb1rWYf4c+ZTz000yjktWH7RDXloUyO2WtSI9BMLe43gTbzisS2L
 GRhkhXpNjuez2QTFcOmP/bTMXzu4OOV4qnkprFPpvFgTWJSEolP2ZWG2BTa4e6QbTcUY
 57Av3taKdJsyefBMkdYgW7maEqtLtOxG5VmDGWvhUq9le/khWcyza32KusJZR2tvAYLY
 1ImvXVgKsdMMZH9Uq8HxilaFZgP4LCeZEGBT5zibI0CVc+18GrOkpJtjrBSw7f7A3XtZ
 SXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824602; x=1738429402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UoGE6unHTvdGpTVXrJG1+71hPq/Dfx21A2EoHEuKVI=;
 b=fVGA/b27BH2/6rQTKuiNGXnOUz2ESHR4YKs8nWjStU3SShF8d6YFG51Q47Bq+i7sbu
 ZJPYV7hqDoc4ZKKI1hYiMjHwZWe36UaeOeOlRoLmfZtKjiM9oiqTh+Bkj8L4ExRzRLVJ
 3Jfsk6U/9M3I3X+3LAuOAgJs/DIjn+hfGpzRgDzM9xCBxyNCB+rVdzPO3Tzqt6KB1Kpd
 B8Oogi9Jq19mGmueb8OO6eImvWvvgUyk37K2ybtBM2DxeAj3XL1mYK43DNgWNxYgnKzc
 wHdeeeS+poYzFQOlfRkmsNTuRb9hvlU6z1VIgJhvdTjy8bKUnQfZFhR0ijks7Jv7bDmx
 Y3dA==
X-Gm-Message-State: AOJu0YzyVSyHK56J/sknkQ3uFedXbxzfUfawPigTT5TheB6tM2jKr+l7
 n/2gSUgtwmIL24rmLgGLXJpb7O1og3sqDsaudqa30Qgo4OLADSKxBDU6mvfLFPHqAj0ivcjFlt2
 7bns=
X-Gm-Gg: ASbGncvz4wN5GgKqAi2I+B2BTXsK6g7AJ/FIRLJIvVJrIT44ywS4YYqcwnCTst1ixkT
 IgAuBrhGvluZ2pYRxc2vUXaTyeqVZnF2o2AbMZfAknRjpUHki6Ge9K7wswzMnz7EXwYB1YCUm8+
 ly2iCVXyoUKqr883Rj+unsaPXCuRr/v7P8yUrev7JgB4hUYfDud0djqa4YPas5MzH/9usFDv4G8
 GWFM2lR44E5P/4wg3aSVHcv8aWYlqfpZ6Dwob4SeYXqjj68PSgIMy9IpVS2NfRomqv/lioQCuLD
 gt+trvOGUqf+u7tDLolsLkkFRabrHnjiabr7oFikmrQSgvnwlRimE5A=
X-Google-Smtp-Source: AGHT+IEInYJsTGlqV2iykNYhg8sbEQVCROB5r5O0Df5tsbMDKfC5jiZtoHru7+z0OcLyTcSxWGuHPg==
X-Received: by 2002:a5d:4007:0:b0:38a:888c:7dec with SMTP id
 ffacd0b85a97d-38bf5675e61mr29143662f8f.28.1737824601802; 
 Sat, 25 Jan 2025 09:03:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb040sm6018422f8f.67.2025.01.25.09.03.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:03:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 23/24] target/xtensa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:24 +0100
Message-ID: <20250125170125.32855-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Move has_work() from CPUClass to SysemuCPUOps, simplifying
xtensa_cpu_has_work() by directly using CPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4eb699d1f45..c5d7682f4bf 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -63,16 +63,14 @@ static void xtensa_restore_state_to_opc(CPUState *cs,
     cpu->env.pc = data[0];
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool xtensa_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
-    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = cpu_env(cs);
 
-    return !cpu->env.runstall && cpu->env.pending_irq_level;
-#else
-    return true;
-#endif
+    return !env->runstall && env->pending_irq_level;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int xtensa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -224,6 +222,7 @@ static const VMStateDescription vmstate_xtensa_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps xtensa_sysemu_ops = {
+    .has_work = xtensa_cpu_has_work,
     .get_phys_page_debug = xtensa_cpu_get_phys_page_debug,
 };
 #endif
@@ -261,7 +260,6 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->has_work = xtensa_cpu_has_work;
     cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
-- 
2.47.1


