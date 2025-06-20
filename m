Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E911C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfLo-000314-2d; Fri, 20 Jun 2025 13:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfLB-00025q-2k
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfL9-0004YJ-CF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so19850935e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439745; x=1751044545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7h4sfO68wbzpruBkUxQWCgRm12x3C8WvrPovqJx+6vY=;
 b=JiXpMKINmWi2zglSVTBeDViCjBwzTsWXyxltcTkhkz1+IZaMmF9wli5tPNh3GG2nOf
 HpXS0zLVULsDMyHYjAbffNtntnke3rbfeq0QNEW4QNPxL2VdhTVgZevev+rc22z0hN1s
 X93HfCL2azT0pwO7uEtQapHwc1OvFmJmT7LogRsumbMRuGj65B7VqcERfi7V3iRgumBI
 WmHYgBmy5jeu8t357w8zqp9e4yV7CaflpP0XLRz2f52gVwzHYd8Kf8rZiStUchvF3aGi
 ZayJngL/rto/PzZ7wgD+uWXWd5pLr9OKa5fLHutgSE3ETeXiUKxaBBycEl4QpN+DqcTv
 6FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439745; x=1751044545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7h4sfO68wbzpruBkUxQWCgRm12x3C8WvrPovqJx+6vY=;
 b=gxDlQTUms9qnUKzRSp++DKZKtYpGms9mC4Q4NA/Qd6GbMYFHkr/QvMmUK5btXkgd3Z
 swRlSN+z2N8WVrDgPsfGLEbi3h3sdiQttWFqWjdq89cHkey87GoqM6TEkAc9mffN9NQG
 /wA5QnM8Qr+nZ+Z2KhWUgbO6rxkA/RxoeEPv+ViB2fyOs8ajw8/e7C8I/ZrF7VQwx2Ag
 a2Ip4pACIphR6nYRfQTwG2pk/wTg2wEtmjI8Oz2efv8jnXL+dkXaDKuXyj2/q/G15Sy8
 SerKlibxiQcW+odXMW+a/9J4GHplQ5JDEHycl9cBufXrmM4cWekO7uGvAmW+q23nw0lH
 otVg==
X-Gm-Message-State: AOJu0Yz9UMoaSHKhJ925tXoAojNZtT0ezaGdDaLN+khREfqAH1bacmvV
 9Mz0Yj4wsItBUhrfYrSQ2O6Sbd8AhmBwcyXJK1Gm8axeooU4jHm4UbZyDUShH3zanLB2wMUMJjq
 r4TBFThw=
X-Gm-Gg: ASbGncuU1CDB8CJXHM1CUxJwA3X9VCqZ2FB0QzLvbAvsL9yuHmBdGg2Y5k3jF9d9OfN
 1H0WVxVJBEilIqMCBlsJeneNwc1nD6IEqQzuZ4/TwUHgVHkxiGab6bqT4ll9mzLBspfFzAbEcor
 No9qcvFsOD6C1YzWalpft902IB2C79zBxYsp4MD6W5l9FX16JHdrx3thTmeCif4II7gi5Myq5hb
 ogkMo+nuQIY31WuTOtbAN1byLTDTlGj8gd1t/CMjIi/N5A5sjSEoHFAQGEdm4mTinVjLwaAXP3j
 M2QLE0Nje5jIkqdN+bwZkZ2ZL6SeICXhpyyj0tApVCujZUbfFfHR5xUf7mAFX9Jj9kTxKJzVq5n
 GA/F7FaepScx3Y2Fq0HTrrHia/xkaHiSbkGOl
X-Google-Smtp-Source: AGHT+IGN1zeEZd/r2ZaILLRcb84MXuSrJFb81WTzuEJKYEEK0vdRO+6ZamYaHgHzgwu2sq8TbN1vYA==
X-Received: by 2002:a05:600c:c10d:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-4536877ffb5mr13683025e9.21.1750439745343; 
 Fri, 20 Jun 2025 10:15:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f104f6sm2675848f8f.12.2025.06.20.10.15.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 25/48] accel/system: Document cpu_synchronize_state()
Date: Fri, 20 Jun 2025 19:13:18 +0200
Message-ID: <20250620171342.92678-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
---
 include/system/accel-ops.h |  8 ++++++++
 include/system/hw_accel.h  | 13 +++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 5c5171ea5b5..f40098c1c92 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -45,6 +45,14 @@ struct AccelOpsClass {
 
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


