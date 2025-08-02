Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C859AC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLtg-0007J9-7h; Sat, 02 Aug 2025 19:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLol-0006Rb-BW
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:11 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoi-0006Uy-Qt
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:11 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-741a254d4a0so895752a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177947; x=1754782747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZELB4+c17Zgz1LBTVaRPLkTpYEUU2ZnNce3ABKyIZzo=;
 b=mYO2mnHTTdnJMV2qUKKrAUu5gk/FoQ+EeKMnANZaQoe0QEcWCS7SGK+S06yWbv5VrC
 JprO0MHsAhyIf19rtm4dt0kAaA1aJHQt6WNvzgRUMNSUozJH61/hzQ1rhCxnOQx38HxU
 rVKqUF1wHUWOJmQ7VL4vGNfyDEUs71Ypa9HV2XL0Xc1zEGRQn/fUr48oN+F3P+7FQW7P
 f1sgnmxP3Rqlb+gqsX0LoNL6NSxrwMY8HKn40wwL9OoFx5Zyy/Aaw5P6ifO/h6kIuWLA
 cs6o1VNC/IhrVAgbxWIk+QIxcfoSt7uPrCGIyw9KyjkLinss6pJf4pRgjgiebwlRNzpZ
 jwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177947; x=1754782747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZELB4+c17Zgz1LBTVaRPLkTpYEUU2ZnNce3ABKyIZzo=;
 b=kPaJr/O7t8wJHLSURoK/D5TKrlK9AeIgwuBjVvIRl+1C8C2Pp687i+UZh/7PIQWSA6
 sGSeBcvzX4uk/TT2idlJhs1UJ0VH5oh+r4X25wgOCbTO4rYVPp2PwxmYSImcGlywmEOg
 i/CjsmPeAQI9/mwiJJyL7MP37Xghy0NVKB1CVrF4HvWa7dGMSAS49V6NPCAKn8iaJrtu
 ZYCEdSZHRqTKdXGjOOXsgJJ1FGktNio20sACVXJJJa+zZKlQLCMZgmzSDUEFBVagLios
 HBHF+gMlVELBZ28kpzzv0Y1kdyTFQMgKjEn6/C17Y6vkUeqN6ZDHwALQw1CK25iG26bA
 Tnnw==
X-Gm-Message-State: AOJu0YzC48E3tht+dnwRZ8u2QH3eP8wEk3etQ8dRf+bwVX112q4lh6TY
 5ToNOJTO07LRW2NpJz4BI5QoRl9uKmj+DJAmNXAGxyTEpMbawAUpFX7I8NTT1bI1+DR0QnaPuo0
 XM1EcQig=
X-Gm-Gg: ASbGncs9vWAi/yiuf9/3tXVsVYNURqFDLELnjuA/2rxd6Xqkf32wGBK6Y1TuOf/Ms3z
 aO4lVZ8urrgYx5gxJ3PKack01pski7RdZK9W+R1GDuROCzTZyyj5G53EKZsOf8eaCjb3FNgOcFh
 dR+LMMBYQX5uuDONughDWfDvEOpR9rTpnP0P+XqropJ9sHmWeliPpdAWWEXwd1mKXp7wTlnbyx6
 lm5EGGSPl/4SIsbvZqabNDVoLwjPtcVtpUhFabrJ7NrcSlnH3MvN5ZznqJViO4I/zxbjRN0mTL1
 m19haWC8UaYBE1z6HNspLcM+8o1509+CSL3FHaxhWi7lQWHiHMRc2YVLknessarvInvJ/cP+GRy
 xLV5OOCNnvB4PpnSOI0dYXqkUgQ2LkSvjyJInFiiYJMMicB1HZ+ST
X-Google-Smtp-Source: AGHT+IHnCCpJSDXAGpmY2SYqxwmeyMlu0IYldiLnS6LWJvYlivhbMTL8TMZTDe1RMcG1s6ZkhQun9Q==
X-Received: by 2002:a05:6830:308a:b0:741:a8f0:db5f with SMTP id
 46e09a7af769-741a8f0dde3mr980023a34.7.1754177947502; 
 Sat, 02 Aug 2025 16:39:07 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:39:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 78/85] target/arm: Enable GCSPR_EL0 for read in user-mode
Date: Sun,  3 Aug 2025 09:29:46 +1000
Message-ID: <20250802232953.413294-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ec63297165..284d1870ec 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -317,6 +317,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* For Linux, GCSPR_EL0 is always readable. */
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            env->cp15.gcscr_el[0] = GCSCRE0_NTR;
+        }
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.43.0


