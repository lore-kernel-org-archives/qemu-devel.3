Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03171E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mo-0007O5-8p; Thu, 19 Feb 2026 05:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mi-0007Kp-WF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-00068N-IQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48371119eacso7373875e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497271; x=1772102071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tl1QTdBu/A3YjP4FZP2qrs7CaNqhB3P7oxPurKt73ug=;
 b=tdbXIUbdV/8fv5aKs8Xq29Eex05BAVZ5c5yscVhbs3fEeUWz2prlUhRB/Ylv+DSD74
 bFVkN7i3Fvv0IyzkXZnkKcmOItifJ0xUOby0W/gA+Afi66eMH53VYn646cUbywIuUv5J
 rTwRJGZNpvPsGAK9683QAoJGOEdW4xJ5KF1kP06BEv0zW5JA/fZ9jUMf+BdgDhwcLeFH
 PhXgFyjtv0KjUTSBWatro2vZWiWdGUnrg6qT6Lshl0LhWfoBb2TkxbHgm8FeSM7lqSlV
 KZc7Yk+PQqM/VatnGcf9DSzfMowRMtelwuU+yjcw2YpXiogRzpDdliPsP9kQhe9YOHpv
 yKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497271; x=1772102071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tl1QTdBu/A3YjP4FZP2qrs7CaNqhB3P7oxPurKt73ug=;
 b=E1yHHa8gI2JjfmSIZM+1omMLLToJS0XeOnX72hN3cCQPY2UOO+8Oq1dW559t2n2bYr
 fAqOT/ULRt7k18EhjanAE0k1S/6TLoDiiIkR/mRbj5ugXjZgrya3qo5l1oMCEYBlCibk
 qqYZJA+Uzq2md/itnQW6mjnlp72yxEMDIMbrj1k2qiiO5/FulzQffF6g/56HH5JP9A4K
 m6OFgK8m+Rlwrud/R7jOlnx1AVaerTApd+pwSquYYBxSDGFv88xa8HBydJZsYmqXl+3M
 e2u618Z8AkA4q7e1fPz4+9UHjWffCzXEys+ECa5mxbOJMCmL1i7Pc91oBKxlmN21Uhaa
 catA==
X-Gm-Message-State: AOJu0YwEAma87HDUy1USYgfpHUz9OznlmvZr7a/sg046PgXJVInNXOEn
 M+mB1j3rXqSfHIYARw+sckrmnVflmcXaXEGFBtAzH/nmqiXJQ3KN7x0SswKtnLYQbZk5cdwHxqD
 d3eM5
X-Gm-Gg: AZuq6aJQRUTDK5CrOxOj0OxYSlsRsRCwwFvcwbkZI9zRFzC1/NkuRtx6HCOvTCVPopY
 VuTFYrlUv8uKmoylZF+YxiNsVZ2EAJ5crbbu6RQj7NQ5sukHGZqyLFP3HwSgf9PCL8TIz6synCp
 YKK6sJUyqSQ2EJzO2Vaiv7HPhM8eFvoqEPx3Z33FWbgdhxTYA3MW3Ck+0eies2hsAs5HHVPDJhs
 pcCRh3WZOKMis3o3dNshCImAswP9z/CySevGZNVe/RG1uHsFIXrnBNC4GPvU/lFLJMT80ZnmFTD
 h5QUMihidVHPtMFdJCcF1YeKi+L3FqEyVz76Km/aDXWalZdxQfADFAQf3JQc5A7PI4ns4IJhjPp
 U1Phwa2OyQmNaEJAt22VN+DV9pEPxErmei8VvxxozAbkfg9F965Xlsz538JcnCvL/aHPfLc4XdN
 6mpshXi8UZNShshPX23SwAN+Q2no2sGdI6QZrD0ZzFDOuU0vqpcwuwTfArroX0yuzocivNlSYZi
 32mZLlexbc9kljtZknkYXCFyyyZhxyg3DpOmsNaSA==
X-Received: by 2002:a05:600c:8b0c:b0:483:4a95:66da with SMTP id
 5b1f17b1804b1-48398b0ace7mr81554765e9.13.1771497271061; 
 Thu, 19 Feb 2026 02:34:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] target/arm/tcg/psci.c: make compilation unit common
Date: Thu, 19 Feb 2026 10:34:00 +0000
Message-ID: <20260219103405.3793357-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Now that helper.h does not contain TARGET_AARCH64 identifier, we can
move forward with this file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-10-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 5 +----
 target/arm/tcg/psci.c      | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 6e9aed3e5d..85277dba8d 100644
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
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index bca6058e41..56754bde95 100644
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
 
-- 
2.43.0


