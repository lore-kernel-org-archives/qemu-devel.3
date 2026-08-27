Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5052AC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRXF-00077K-NK; Thu, 27 Aug 2026 00:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXD-00075b-Fm
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:15 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRXB-0006RY-Cl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:16:15 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so259025a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787804172; x=1788408972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mqdk3c9HbzgZWSmcwYY8mMSQqF5s5IhpPUD59+J81rc=;
 b=euGqAjUFXHVeb+oA6rjj27zS3bNC4GP0OYkRQ6DZnB/aVQMog6VVNEFwWKFfx9a1zU
 68O3lsC3q/PLsRvwc119dN6kBjUVFfIQulGpuf6uiUSoOnxokhGottlL407GXpGnS+Er
 tVzjyP3RTyy5d5vaXb7vMp+kYHvO13E3GMHqJKCWQTX/OwOerO8OS5SO8UIoeaLU66X1
 pmnYWRZkIjlUOGQJFE8+UWNMgmBfdNef9M6yER04NyJpsYFoDx/+Sio47kh1m4wqaYu8
 d/MeSzqSZKGTD95qJExhLloSxeiBLR7mZJ/LytvDSBrMK6HHUZoF+RghbD3uugr5uS4r
 oLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787804172; x=1788408972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mqdk3c9HbzgZWSmcwYY8mMSQqF5s5IhpPUD59+J81rc=;
 b=PHm2VoI7XyacA6cpIjQCX/DuSe8LIqbtvsy4aEz2n4liDic0r3m6Ea4fAVEvQzIhFZ
 dMcVMHbO7gpY3TEIs+LRHaTIxpuigr2EBHt1RMttoqvIVEzWCOKPtjIQmpP0tD6can43
 0gRl3IcI4ZEZmNYQXCIcoNyYBkCz9VuvkQSjCaCGI3GyIZ7G+nOS3CXM4oSIQ2bYMVWz
 8r1aFhXZW9F+Hwi1gvXYNEyu2xcW9x6XIfQetIcAJnNpcweDP8PFkhFU0ySyMpxXOhYk
 wGKNgbbWM+73+hnYX9MluuG8pkCrT9upxJ3syxeb9IggbHq7AzxzBpOFiHs7U3jfVIdB
 dNUw==
X-Gm-Message-State: AFuF++lP5OhY0QDMX6ThzgBT7CYojW2/fwsqZeD17+LeomH0h0uCOELh
 lua2VAr+XrUxRScRwvvYUMBoqyiCp583niTh0fKg2g6ccyayfw8MqQGYAGGMfqW6B3Jl+FGiEAv
 5AzUB8rE=
X-Gm-Gg: AR+sD13E7vqMucv6LarGmau6k4xEqUm+CInWBwk2dfAP7q4kN6VgoU9re6cqvE3LvBP
 QMV/aafPUOBJgaeO7zHUkzzgKPLfSO3K6evUA+9Kx53JpTLQq+U4TAyqW59JKEp0nIHNpycm6wY
 76UxGvkUAhTGqRraPW4GCnbRnj9OScGhH5IesLlOhXxEnvEgaqlGcCDG0heHvzxokFNTTc0VwuA
 XPnQKX+RMFzuZgaCWjIxBcH/EtzVsLcYpiMlRKWru11yo4zB8ZrwrrUkbQXMYHhOiAqThobfOrG
 U9Y0M9l25rocDD22aexJlrp/NVIfNqE9zRQ187HZ21AH8VUhsjvsUXacYY/pB4AbYx1COZdPYzm
 g0Vv5j0CRLI68qVp+i3E8gda68xcjHhX7Te5JKVSeqi+3yrXP/Y6KdkmTtHsH4jKmWAUF0+y9b6
 CmWLBx3YxV98sZsL87nNlC5cGiGXXqtfjvY63iI+hcad5nkJbBVbDr7JAMvarISMEsgknUSZnMq
 XGeZvwSIc8no17lvA==
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr25513431a91.15.1787804171995; 
 Wed, 26 Aug 2026 21:16:11 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d81682sm969597a91.7.2026.08.26.21.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:16:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com
Subject: [PATCH v4 2/6] target/arm: Build cpu32.c once in system mode
Date: Wed, 26 Aug 2026 21:15:53 -0700
Message-ID: <20260827041557.775080-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827041557.775080-1-richard.henderson@linaro.org>
References: <20260827041557.775080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

"Move" the ifdef to meson.build rules.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu32.c     |  5 -----
 target/arm/tcg/meson.build | 10 +++++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 34436ad6ec4..2d642ef8787 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -19,9 +19,6 @@
 #include "cpregs.h"
 
 
-/* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -756,5 +753,3 @@ static void arm_tcg_cpu_register_types(void)
 }
 
 type_init(arm_tcg_cpu_register_types)
-
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 35e70b004d9..a3e9d55e853 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,10 +30,6 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
-arm_ss.add(files(
-  'cpu32.c',
-))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'gengvec64.c',
   'translate-a64.c',
@@ -49,7 +45,10 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 ))
 
 arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
-arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu-v7m.c',
+  'cpu32.c',
+))
 
 arm_common_ss.add(zlib)
 arm_common_ss.add(files(
@@ -86,6 +85,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 ))
 
 arm_common_system_ss.add(files(
+  'cpu32.c',
   'cpregs-at.c',
   'gicv5-cpuif.c',
   'psci.c',
-- 
2.53.0


