Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A8C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7R-00032M-6x; Thu, 15 Feb 2024 01:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7P-0002ww-DH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:11 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7N-0005bQ-ES
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:11 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso4607945ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978068; x=1708582868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uW4mSrnyRkLcpmuT0B32llPRivoOZrRn2N/1ffLpPkI=;
 b=fednZYHjNTaq6wbLI8smTVXFlwEDTUgaM+pKT871n49izPOZ2/I3JYyQ0L6uCz99O+
 co3FYzvumfdaGjpUwVgAzoz0RLVmPB2v07QwzvM9rfsFh0B5xOeCJlqK2+m8lQ/YAM1Q
 D4p8K9BCbwUm20d4mbRW1AfX4B5Ez9IX3OT4ae/nk7Gj9OzWQaCnmmaa7SDzj6VdpkpQ
 i2q4XZiH/j5PTpSxDZ2hg7NOg8N1H2lzD+Gu2UD6R7uHKgQJ9k/ItFW4bP4f9C6hKVA1
 90SbzT899xHTqVbpOkcBMqcBOwCJKyWg24IxiQx/gdgyeoQzJ80ZHbkx1QRRsouQi862
 7/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978068; x=1708582868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uW4mSrnyRkLcpmuT0B32llPRivoOZrRn2N/1ffLpPkI=;
 b=q2bEoOQ8vPvS6Af/EXsqUTUO1TTo9WKV8iblc7YF6+QIestSu1m4A/FIIyWirVPfT+
 R7CiklC7cYWmzQJd5U6a+clssvGXeCz/jhPjFVvPoWyo18sIP3MxE9Q4LsDiXUH0mBIq
 vkCDYU+Cc6+wDjiSsfBr2mvnNc4oQR3+caiBmjvX54HmTnJ5ENBvXKVoT0PbuwqJ3oRB
 UtMIyIjP4QrZvmu38FlC7qKAroUZpUZPrIKRaZSjIfobhC2gJ1jghufjP+1L4oRDgT0u
 KfrIjp0j6imX+o6X9etLVF4nwa00a5eMbizPbilEL8aXy3xhG+jyubFmWRWAOMxmXVv9
 Irrg==
X-Gm-Message-State: AOJu0YxoVBHaLQ5LVZDK2Th8aYG9yBN8On5IE06iDhVdbzhz+Nuv93a7
 N7/4iLyDPS4bYIzWvD0mN7twlcJCp7cXxgnsRo+81Wp+MLVnK2RqjLSXfui/6Kk82EzV7JoXVo3
 S
X-Google-Smtp-Source: AGHT+IE5XdO5r8T3pvBqL/J24t1MrA9SfpIOp9zaB4GTj0fBXclR41YLskF6XBLbgsDqZ3D9iSmG7g==
X-Received: by 2002:a17:902:aa0b:b0:1d9:5371:bc with SMTP id
 be11-20020a170902aa0b00b001d9537100bcmr798940plb.37.1707978067971; 
 Wed, 14 Feb 2024 22:21:07 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v4 32/36] target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64
 user-only
Date: Wed, 14 Feb 2024 20:20:14 -1000
Message-Id: <20240215062018.795056-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Since aarch64 binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-31-richard.henderson@linaro.org>
---
 target/arm/cpu-param.h |  6 ++++-
 target/arm/cpu.c       | 51 ++++++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index f9b462a98f..da3243ab21 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -19,9 +19,13 @@
 #endif
 
 #ifdef CONFIG_USER_ONLY
-#define TARGET_PAGE_BITS 12
 # ifdef TARGET_AARCH64
 #  define TARGET_TAGGED_ADDRESSES
+/* Allow user-only to vary page size from 4k */
+#  define TARGET_PAGE_BITS_VARY
+#  define TARGET_PAGE_BITS_MIN  12
+# else
+#  define TARGET_PAGE_BITS 12
 # endif
 #else
 /*
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5fa86bc8d5..2325d4007f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1809,7 +1809,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     ARMCPU *cpu = ARM_CPU(dev);
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
-    int pagebits;
     Error *local_err = NULL;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
@@ -2100,28 +2099,36 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
            !cpu_isar_feature(aa32_vfp_simd, cpu) ||
            !arm_feature(env, ARM_FEATURE_XSCALE));
 
-    if (arm_feature(env, ARM_FEATURE_V7) &&
-        !arm_feature(env, ARM_FEATURE_M) &&
-        !arm_feature(env, ARM_FEATURE_PMSA)) {
-        /* v7VMSA drops support for the old ARMv5 tiny pages, so we
-         * can use 4K pages.
-         */
-        pagebits = 12;
-    } else {
-        /* For CPUs which might have tiny 1K pages, or which have an
-         * MPU and might have small region sizes, stick with 1K pages.
-         */
-        pagebits = 10;
-    }
-    if (!set_preferred_target_page_bits(pagebits)) {
-        /* This can only ever happen for hotplugging a CPU, or if
-         * the board code incorrectly creates a CPU which it has
-         * promised via minimum_page_size that it will not.
-         */
-        error_setg(errp, "This CPU requires a smaller page size than the "
-                   "system is using");
-        return;
+#ifndef CONFIG_USER_ONLY
+    {
+        int pagebits;
+        if (arm_feature(env, ARM_FEATURE_V7) &&
+            !arm_feature(env, ARM_FEATURE_M) &&
+            !arm_feature(env, ARM_FEATURE_PMSA)) {
+            /*
+             * v7VMSA drops support for the old ARMv5 tiny pages,
+             * so we can use 4K pages.
+             */
+            pagebits = 12;
+        } else {
+            /*
+             * For CPUs which might have tiny 1K pages, or which have an
+             * MPU and might have small region sizes, stick with 1K pages.
+             */
+            pagebits = 10;
+        }
+        if (!set_preferred_target_page_bits(pagebits)) {
+            /*
+             * This can only ever happen for hotplugging a CPU, or if
+             * the board code incorrectly creates a CPU which it has
+             * promised via minimum_page_size that it will not.
+             */
+            error_setg(errp, "This CPU requires a smaller page size "
+                       "than the system is using");
+            return;
+        }
     }
+#endif
 
     /* This cpu-id-to-MPIDR affinity is used only for TCG; KVM will override it.
      * We don't support setting cluster ID ([16..23]) (known as Aff2
-- 
2.34.1


