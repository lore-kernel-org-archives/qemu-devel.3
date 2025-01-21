Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC45C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFB4-0000aF-2z; Tue, 21 Jan 2025 09:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFAr-0000Uv-CG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFAp-00033O-CI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:12 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862a921123so4053260f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469448; x=1738074248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uL4Y+z6DzTKVC74EB8XgyjJw99XhZeyPYSd4sWJmzog=;
 b=kyyNbtL7qPBGpgMfbNJwFYYqeqULyktpceO19h6lQvNTWMgFX7/jLfVke35PIlf54u
 PYeJRNAIwzOxDqFp4kaeaUsG7pWxS+r/E+Jk0bj40R0zmiQK6Hpuj6ti+vuNfcm4WeUg
 zIC3n4/PniBI9/IhV4xUFPdNeA73lad829+63X6lObpPjo4I4/b3qquHzJHrBcQKrgn7
 DHzvHjyAHH70v7UhMWzjDYKWxuJnQdkorRXSYa5EQOieF7/YE5zq6WGhdxkpvpYwJgnS
 2NFF4Gf/VT41UeCVkC28jczrcaoTQHYvck9pGJGlp14IjFWNYF9yQMnv4+FtOhKVuPOA
 FpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469448; x=1738074248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uL4Y+z6DzTKVC74EB8XgyjJw99XhZeyPYSd4sWJmzog=;
 b=jCgf0ULPdtyLnUoI5utxR6mvkFNYY7dzfB+orljh+haLtV4t8KLD1NbbIO8HyYka6t
 Zs9GsUCfUo9hGbNQ++Zk5Jn37xIifmyRXCKB/PUevu4ohD/ygz3LTEn8cNJBXiE8JoqX
 f/6YlNFhzqk5ki9MKbxuoY73Zn3SvaEw2XdouRYk8o0yOqt9ncIuMiB8SpLt5VX9Y5jX
 rv+YHOscPffCCMbZeudQS4pwEuRLpTEXcNVpGtYfQIrTC0iTbLm/G87wD2iHpesNSL12
 5NWgBtDQBEj5jyoPL3o95JZEEQjAY7P+31s05NMcv4IVxQ5mDwF2Op4jKuDM1ctCknDr
 CXZg==
X-Gm-Message-State: AOJu0YxU++8uD+ytxaCpAG/dZKQfLpLPJs3d31RMHN6yLMpmfOIK13z7
 A1ohMyXpn9TaCRsMKcNAxxxmxYdUYMobXWO11WEsQX+eQSnbnuSXBHtx3EOIKsodaf25OxRKG6M
 xVDs=
X-Gm-Gg: ASbGnctGikYZqn0LZpSubU03Tn99X2PQNd6zeOiX0oKsXCuxZtX+9NctV+WZV8rlRrA
 BD8hPww+8C9kK7peWF8G2TD5AgR+y0Um/W3Z92lw1v9nPpPIouiUbRNSnye4OGX58rQZz+sq+R0
 /FkF3/Jl6Joq8vYUgUe0zzuXkhUQ7CbsODzel1pezFryR50I3Z+XlQk5Ey0hR3+FT8YAtfgP9Ry
 L0PFTjbQ9QH+eN6hQUJjRU2l7lk7SfFw4aHrvTzxeg3RNB4kfdEbVyyovlsECnniCdjqY2RtfrQ
 bfebNysXi2jwvMcK3DAOrgLvZOO0Qipm1WJLvUj4ZBwM
X-Google-Smtp-Source: AGHT+IG2J+fBTwBjziF/CKK3YvS7IkMDlLeRzzR/kuQ3HqnpmWiqykgSetll2TWOSALFBgnl02mvBg==
X-Received: by 2002:a05:6000:1849:b0:38a:8888:c0b6 with SMTP id
 ffacd0b85a97d-38bf57bfcf5mr18393431f8f.51.1737469447276; 
 Tue, 21 Jan 2025 06:24:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3214fbdsm13815861f8f.19.2025.01.21.06.24.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/28] cpus: Restrict cpu_has_work() to system emulation
Date: Tue, 21 Jan 2025 15:23:18 +0100
Message-ID: <20250121142341.17001-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

This method is not used on user emulation, because there
is always work to do there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2402706c7d9..e094d54949d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -748,6 +748,20 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
  */
 bool cpu_virtio_is_big_endian(CPUState *cpu);
 
+/**
+ * cpu_has_work:
+ * @cpu: The vCPU to check.
+ *
+ * Checks whether the CPU has work to do.
+ *
+ * Returns: %true if the CPU has work, %false otherwise.
+ */
+static inline bool cpu_has_work(CPUState *cpu)
+{
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
+}
+
 #endif /* CONFIG_USER_ONLY */
 
 /**
@@ -814,20 +828,6 @@ CPUState *cpu_create(const char *typename);
  */
 const char *parse_cpu_option(const char *cpu_option);
 
-/**
- * cpu_has_work:
- * @cpu: The vCPU to check.
- *
- * Checks whether the CPU has work to do.
- *
- * Returns: %true if the CPU has work, %false otherwise.
- */
-static inline bool cpu_has_work(CPUState *cpu)
-{
-    g_assert(cpu->cc->has_work);
-    return cpu->cc->has_work(cpu);
-}
-
 /**
  * qemu_cpu_is_self:
  * @cpu: The vCPU to check against.
-- 
2.47.1


