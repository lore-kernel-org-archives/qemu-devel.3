Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B73C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSW-0006j4-L3; Fri, 04 Jul 2025 06:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSU-0006d1-Gl
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSS-0006nE-CI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso5092905e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624150; x=1752228950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mGJ2ndj0RHyzDpqgO8Q1/q0oLyFwkpR41xzkhPCtx98=;
 b=m/AEnrdkeh6my6vbbp7SKtH/5KTPcU7ZVrLLlrM4YolHJEAmGH6nYr891S0ojdgjFw
 2/LLyAUh8JB+9ENsm62iEIIHGZbmR4Ej8cQv2lcLT47WUZ1mQf9V/OKYTzGsf2Umrefh
 YJrtkUVMISK3FHomT+QICo5b0+km9tTbLHk2N7sw9CxiMc48IqVzBLnKZe07BKWY1HhY
 rlvx/xHwmKWmUzm3GOxcjppyJWCUFGqZGdLL7EZFPxpjffwoq5ENEWmUdDjQOFVQ1y+Q
 Ji/HyyoXmQU3/EV2rOMwY64l4b4pXrB6qWC+Q3rrR6XfZMIVoi0ibqP5TlFNc3h5eNfg
 /KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624150; x=1752228950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGJ2ndj0RHyzDpqgO8Q1/q0oLyFwkpR41xzkhPCtx98=;
 b=M9f+PGK0Kju1lhaJldJknQV14YCdK2bG1SrRO6b5CkpUFgXEFAh50XOcDGi424ArM2
 48ZQjMqiIkdHHv4uiRQrE/CyNgEWEuy4QzZzqUjbBH4mRw0wkWoR1Gw6OoRIq/RgNmO/
 u+y6/q8HDcDJ7K2d7FecFGGN0M5gmyY1NguvvpRNEwEdyAPIQ+Tj4M1bls3J/qfaRdI/
 TSHa2NHATMQ7iDNOLu/drtfsZJWBCPW/0zaj7xrW4w+Cb3KAn8XMxqhYDICqpNQnHm0q
 nchosfKfl6n4cHFh1izuFncY1u5WMeoIqH3IIhtOXyPZ/0jVDqXAb3t8VMSa87LG2tjA
 8r1Q==
X-Gm-Message-State: AOJu0Ywqle0I+GfETc5xDv0LyTovuThAF7DC57nN7vX3EzR9B82Bx9E4
 8hmt1+qobeeAKnpdodgUbMyLUes+yWM4FqOMtgC8VhjJNsHOyQXv5mjT3ROHwrnZrK71sPzEORs
 ZI7g2Rvg=
X-Gm-Gg: ASbGncuMiK5TRDolAsdUddqOi7T5epjGgjUZHi7rs5dMHeIxJkZlHWoCZxHyAs/agSs
 fdoMJJm1WG9NMaSanxuQDTFq0eFP0ZQaFaa5gSvy11cfZvfwfcM1nL8pHzzmnoFqE9FLrLCIINX
 uhaYmzYsZfX/6O6OfDti1vA+bgX6pv/mBee6QtniULgJ/zn3325UfNPv6wIx/f2pnEKyW1zozKx
 L3nyts2Nl8W1dyvQXfyHzYQGDR7RhDTcjFtYAh5DS3MTYpXdQI8AKD7cEGpg2J66LZbHJHdAS/B
 l2txY3ci1o+3I9SMHOZTbMXxzJEmxPh9l9NYYKagHsHN2CftDQX9W8JFZiz+93xZWawndRTt2ea
 Car6B3nA9iHGKRzOYlBLeUvZpm/D/kT8P23y6
X-Google-Smtp-Source: AGHT+IGLmM8cD1LeWEaayfFc0aeQhjLhK+u09bE8yd14lSdZM8yo2HonEhKuqKwPZA23KZvUpSbwRQ==
X-Received: by 2002:a05:600c:1d81:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-454b319566emr15894515e9.33.1751624149966; 
 Fri, 04 Jul 2025 03:15:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96731sm2113555f8f.55.2025.07.04.03.15.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/31] accel/system: Document cpu_synchronize_state()
Date: Fri,  4 Jul 2025 12:14:17 +0200
Message-ID: <20250704101433.8813-17-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-23-philmd@linaro.org>
---
 include/system/accel-ops.h |  8 ++++++++
 include/system/hw_accel.h  | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 4c99d25aeff..55f91cea25d 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -42,6 +42,14 @@ struct AccelOpsClass {
 
     void (*synchronize_post_reset)(CPUState *cpu);
     void (*synchronize_post_init)(CPUState *cpu);
+    /**
+     * synchronize_state:
+     * synchronize_pre_loadvm:
+     * @cpu: The vCPU to synchronize.
+     *
+     * Request to synchronize QEMU vCPU registers from the hardware accelerator
+     * (the hardware accelerator is the reference).
+     */
     void (*synchronize_state)(CPUState *cpu);
     void (*synchronize_pre_loadvm)(CPUState *cpu);
     void (*synchronize_pre_resume)(bool step_pending);
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 380e9e640b6..574c9738408 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -17,9 +17,18 @@
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
+/**
+ * cpu_synchronize_state:
+ * cpu_synchronize_pre_loadvm:
+ * @cpu: The vCPU to synchronize.
+ *
+ * Request to synchronize QEMU vCPU registers from the hardware accelerator
+ * (the hardware accelerator is the reference).
+ */
 void cpu_synchronize_state(CPUState *cpu);
-void cpu_synchronize_post_reset(CPUState *cpu);
-void cpu_synchronize_post_init(CPUState *cpu);
 void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
+void cpu_synchronize_post_reset(CPUState *cpu);
+void cpu_synchronize_post_init(CPUState *cpu);
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.49.0


