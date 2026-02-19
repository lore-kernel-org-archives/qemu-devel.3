Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1AEE9A04D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvFK-0008U0-Ix; Wed, 18 Feb 2026 23:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF8-0008PN-02
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF5-0001FF-N8
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:21 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2aadc18f230so2810575ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473738; x=1772078538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvHffU5N51i03Mxn26mXTr3v2G/A6vAtzhoWHQnpn8U=;
 b=BKYyVRfIu1c7TzH9qNhJWrjI+YwKsFQk18Jvfvzr3pWoB/QLpgUIcbwcAu2WNQiiXG
 z+NzLjTSqSVfwgoCeo+/TFuc8KKmoiCv/s3hPfA+QpLHx8tHHXW/NwNa9jarosVCWmp0
 JnNjudbzGTTPTwAYJfL/kST09mLqSIKuivx7Su7s/HU298WGugd3Wwhw0NcBU6JV6Qs9
 iyYruCqeb9Lsvf/+qfLiQ5Ib63R5lw4fw8C1E2fRsjLUyOcewY4ykDqWs9wPFSJWHWCR
 GQDEQ/JusXs+77PgIRT2ucRZILe0e7BGCxYPdGV43QbCAV/2YIPNLx8Fi6S0PlT4MdEU
 asSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473738; x=1772078538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uvHffU5N51i03Mxn26mXTr3v2G/A6vAtzhoWHQnpn8U=;
 b=iXEgNZgKtLOaEWyJa5zI7d140sWsGe5kKm9/JMMtt1r8xZhGHJF+jlLdKWUw4YaQVe
 Tu071sLgWaJIhbcwsCLx4heS/mQ3I/olr92F7b+WghOsiC2THsWS09O1ESlKO+JCpYX1
 /E77shx5dtaSuVj2tjHahOw+FdmSyNs+2CdkfyVBYjk2uTS+uZYb47wjVJn6TMXUcC0f
 z5j0n80n4KegSQottWHTl1Z0J4cor9iFHaOLCyDePdnBbBD0tizEYf+lUAi2Ew5b4A1s
 5BBrIBy3rmUGIRHuuJQUbQ2lFkLUr5PrHHk4QfaA6ySmdsAm8HKjik/CkQtxf696aEVe
 DLIQ==
X-Gm-Message-State: AOJu0YzxGYtcFgYX5T+VY05too8t6VFkvre767KvHEtYv9Kk0Bv4CUr5
 eCxotcgMHv4o/hkb+BCQrOzqrochgk7m9sR+fjrVk89rCxkBln8pc0tLrE+pgbg8YeyjnOYkxf6
 gvtcT
X-Gm-Gg: AZuq6aL+T5ud1+qridKWmsR8rNVGgyawURZKwJ+TXC6I1DiYu6DLOccIMpTaVkVsjDv
 nL6MS9RgKixG7s8mgk5zjjHqlfKNRPM2ILA5vQ6DvfDM5+tkjlC/HoP/WhWPRteBNKgXoAPTC65
 0RLPHYQNsqpuxWGv/0xrXB6mf2Qebb7ky5HXSp7p7clMH8/zoJ9vo2KC2np8XqK3XHLFPmYdHCO
 0Cq6YiqEdA/A23QCoIPtISePRaWmqsnO3Nvf+zD3exHqaw8Dy50DzRkyiJBysnJ9I2jWGtVv9ch
 DcBgKacWB1tDlVCE2DyV3wMCQ47/Ge+m4Ruc8YDzXDrqkkI9kcle+6HyBIk628MqLI0X0e2Pr0O
 yK/6A4Jpn4bH858bVBm6eHXT+4tH9C0kFm2Tc+rpvla9hwDi1CpNf0awWoDR9guqV47NuSbbJKw
 CU1eBtaA80ANBFCsFUJ6NHGyWRh1uEyD17zOoOhU+MROo2fyN1/we6O7xll1ZWB0LLlxiQv9bcy
 TXA
X-Received: by 2002:a17:902:e748:b0:2a0:acf6:3de9 with SMTP id
 d9443c01a7336-2ad175a51d3mr155834565ad.58.1771473738159; 
 Wed, 18 Feb 2026 20:02:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 09/14] target/arm/tcg/psci.c: make compilation unit common
Date: Wed, 18 Feb 2026 20:01:45 -0800
Message-ID: <20260219040150.2098396-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that helper.h does not contain TARGET_AARCH64 identifier, we can
move forward with this file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/psci.c      | 2 +-
 target/arm/tcg/meson.build | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index bca6058e41a..56754bde951 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -68,7 +68,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     uint64_t param[4];
     uint64_t context_id, mpidr;
-    target_ulong entry;
+    uint64_t entry;
     int32_t ret = 0;
     int i;
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 6e9aed3e5de..85277dba8da 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -49,10 +49,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sve_helper.c',
 ))
 
-arm_system_ss.add(files(
-  'psci.c',
-))
-
 arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
@@ -68,6 +64,7 @@ arm_common_system_ss.add(files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
   'vfp_helper.c',
-- 
2.47.3


