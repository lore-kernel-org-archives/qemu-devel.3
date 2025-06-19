Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784D3C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF62-0003uv-Ty; Thu, 19 Jun 2025 09:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF60-0003rC-UA
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5z-0003zk-9U
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:24 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so6047105e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338861; x=1750943661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgE23ZXjPhbz5eEFEhot27ybZ4s2rDCHGkAaeKo3otQ=;
 b=JXdUwcRTDo67R7rjPc5bx8fDn7+C/rem3YfsUExafMH5yUMtAXNV0nkDYt3BVuPHfZ
 148mrh7kmfULJbtFOyjlsH6u/NFwAz9SCv7z0QVFSUNv8XkIEi9GFhsz242ErZJsVua3
 nJQttQjPR6/e3RR+lDoA0hY7Fr0+fbnmRy6GJpN+l2e4K3A56YP1L2367ZKEUkwiCqAb
 Z9W5KKsED38dNiVsi0ewL/BkgyxrXywKyxcjQztb7Rru5U0nIe0nHRGWnBm1c88MF/oE
 Q56D4ssrkyR5XylNZWI0KWreoPquWiCxxFp5T/M/kfDex+BvwJaCIjFg6WEKbnJ7cutL
 yY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338861; x=1750943661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgE23ZXjPhbz5eEFEhot27ybZ4s2rDCHGkAaeKo3otQ=;
 b=pAYUhD20PcEUV/7xUyfeOafuV5ru7JYOaJlwct6+HkW6PZ3AeLuJUU16R8k4z1K52x
 6mWMs7mCh2y+H6uoibtP9HaC3M7HuLYqH+m12fLE4hVgjTjFg5Bpv1F4DEqsMeM7RaSz
 8V4e8mYcTI7xQMgHHbWuKlUkJ2W5KzUR5g3FzpQtLI7OAeTYz/WXXIZ/OoPd4H2z8dWh
 A1PQOIFTTnWDmf3c8246MaZu5cVJplaYrkPjnN7vIjC2X7uXNVATBkVHQKMZVapduwKQ
 tTRikjm3KwvgC0NWSC22DtDVF2sTmIi4HBq22gpUwmYdXRcDGf2IbYrjjRlBGWuon1xe
 fpOQ==
X-Gm-Message-State: AOJu0YzE0UDFmqbYl/UFiyQ+hCN8MlEcl2OK6/9TkUZD+s+REeZhawsg
 7qPFuup+XmPFLBuTgeihLKN7xW1ChXe8pqrmiFKBzOujA3LtJrlRhwkFwLXphfoC3bXObA9YdyA
 xvew6oW0=
X-Gm-Gg: ASbGnctT7Ff6ka2bUydyFVpzLh6RWucdyFu6u7ce0yJXeyvNWXzRODpKXvlVZ6/ABPO
 afybyMUzQ5ixCmLUxGlyUjzLgCYp1qrOAgv1Z2+g0//xtQhLsRQWCsDb5uVmAHzYCQkLBkxoZI2
 8DAlBAfMcttaaJ+b/QS9yxG5vIsmYNaht1Rds1TQ2gH8Fr4R9gCQiDkUS5hH1PZ2FiE1PSgn9Sx
 mXFsr6idlZtbfpg9vtLy9USsKewcak2rBjZhg/ohcwus02JiD/xyGlAALgTwHtrunozmZmRlqjK
 Za3rqJXRfS56pHM/LzrNLxHFK0Ro9HSxaSrRdnl0XRNKQGEofe0j6a8zLS4qA42KZcsSBnOF9O0
 rDn71bkTpz5VPa1KvrDPc7x8u0M9qFqkGo6tO
X-Google-Smtp-Source: AGHT+IG/UYI2TYIa9RXcwUa0fUfFK7JoPAY2HMaE1zI4A9LwhSOJHHI/mUd44vJwEgaSqgrYnYu8MA==
X-Received: by 2002:a05:6000:4021:b0:3a4:f5f6:b4ab with SMTP id
 ffacd0b85a97d-3a5723a2e2bmr16674306f8f.30.1750338861305; 
 Thu, 19 Jun 2025 06:14:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535b683b49sm29415425e9.1.2025.06.19.06.14.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 11/20] target/arm: Create GTimers *after* features finalized /
 accel realized
Date: Thu, 19 Jun 2025 15:13:10 +0200
Message-ID: <20250619131319.47301-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Call generic (including accelerator) cpu_realize() handlers
*before* setting @gt_cntfrq_hz default

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c99981d88f8..102f45442a9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1986,26 +1986,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!cpu->gt_cntfrq_hz) {
-        /*
-         * 0 means "the board didn't set a value, use the default". (We also
-         * get here for the CONFIG_USER_ONLY case.)
-         * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
-         * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
-         * which gives a 16ns tick period.
-         *
-         * We will use the back-compat value:
-         *  - for QEMU CPU types added before we standardized on 1GHz
-         *  - for versioned machine types with a version of 9.0 or earlier
-         */
-        if (arm_feature(env, ARM_FEATURE_BACKCOMPAT_CNTFRQ) ||
-            cpu->backcompat_cntfrq) {
-            cpu->gt_cntfrq_hz = GTIMER_BACKCOMPAT_HZ;
-        } else {
-            cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
-        }
-    }
-
 #ifndef CONFIG_USER_ONLY
     /* The NVIC and M-profile CPU are two halves of a single piece of
      * hardware; trying to use one without the other is a command line
@@ -2052,7 +2032,40 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             return;
         }
     }
+#endif
 
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    arm_cpu_finalize_features(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+#ifndef CONFIG_USER_ONLY
+    if (!cpu->gt_cntfrq_hz) {
+        /*
+         * 0 means "the board didn't set a value, use the default". (We also
+         * get here for the CONFIG_USER_ONLY case.)
+         * ARMv8.6 and later CPUs architecturally must use a 1GHz timer; before
+         * that it was an IMPDEF choice, and QEMU initially picked 62.5MHz,
+         * which gives a 16ns tick period.
+         *
+         * We will use the back-compat value:
+         *  - for QEMU CPU types added before we standardized on 1GHz
+         *  - for versioned machine types with a version of 9.0 or earlier
+         */
+        if (arm_feature(env, ARM_FEATURE_BACKCOMPAT_CNTFRQ) ||
+            cpu->backcompat_cntfrq) {
+            cpu->gt_cntfrq_hz = GTIMER_BACKCOMPAT_HZ;
+        } else {
+            cpu->gt_cntfrq_hz = GTIMER_DEFAULT_HZ;
+        }
+    }
     {
         uint64_t scale = gt_cntfrq_period_ns(cpu);
 
@@ -2073,18 +2086,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    arm_cpu_finalize_features(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
 #ifdef CONFIG_USER_ONLY
     /*
      * User mode relies on IC IVAU instructions to catch modification of
-- 
2.49.0


