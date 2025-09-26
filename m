Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F31CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298a-0007Se-5i; Fri, 26 Sep 2025 10:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298T-0007Fg-Bk
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298F-0005g2-Pj
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e2562e8cbso18100265e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895742; x=1759500542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VxQiWPxgRZW6uBnWtQ/kGJQ5keFUmGiXnVzbaP/rmfU=;
 b=tjxqvG+9KsUvHrQP56IQL/YUgIut5xrWyuaXc0AZMpEov0IPiu8Q76L4rCacShKm7S
 2wai/OLPAmsCvkpfhIt8zmQeutoIfTnQKDZ2qMFj6ONGIHYqwCe8S6qfz3tzI9GdeC3T
 EMQ2/cBPzsH2eCFX+O9eS5SnmcwgD7XjgOcQkJaR7XaW5/G2rbluSmZsZzECGYugpjvJ
 aAHUaJRfUR6bj2Jg8ZjQ1l1RCkwEm8THuPqPHZm2ZFM1cgOiXZ9RJscNdG9vc07qxnFR
 bgGkjP0ue8MlrFcz0+eQIPFxzJhX9qZG2mev/RuoDD+12wvwY3V+1TAjD4fcxEaTQx0k
 2jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895742; x=1759500542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxQiWPxgRZW6uBnWtQ/kGJQ5keFUmGiXnVzbaP/rmfU=;
 b=cWYXQVpDBd9JhIJj7Vv/LPLv3x8dWKXc9hXaz/GYCw+THMnE3Nn9nhLlolvYlg4t/5
 f07p0vf47JcRt8o6QsGm9mDhweCgmTzUGvLwxtu7cQMd6mN6Y9p23UW32+uCP7taAiDG
 clAmJcM6PDIsLdpUHePNlF5Ep1CevVbCACsViQD4NQntR4S4TYezWCv9Ev/15bYiTLCs
 bSjTHIs2IuCKkdpC9DkMqPDzfk5X7bs8gZPixR9VD++HvwE/g4Idt/k33venT3KEBVdq
 lIWam8wB5Y/55Ky19UkCz4Dk7Sy+BklCYabK2lOfXV+4CK760zUPKRZmyz2aUQkjJyPI
 /RfQ==
X-Gm-Message-State: AOJu0YwtFEo8Gbs4I4SXlP0RYnxaziepGITOX2zRTFlYJOAqHDu10r5l
 MwkTihHYZdzk8sVDbYE/kiLwCPUIfiofFhLhy1WiRzpvVfpIhk/oBDGplZgCU8WimzMTUuPYHW/
 anouG
X-Gm-Gg: ASbGncsdUCYz7Z4PHhI6suaynnk3xjxfC8Ef29EAYAFW7w2OVFE1+YBR8BzscEwWxRW
 pzhtqDlkjBHd5y/AYS4PISjOzto8hwITKzn7HnbFe8fhtqlm3jXu1d36616KhFOpuytpzsBbUbw
 WuunTplhpbd9jm/FC/EPWccflZW+zXm+Ois7ckC2M+jXwwHxZPi1jAghjcTVDcORJdaf+8X7fVy
 G2ned7I0kEmDv+P5JVJ2ns7JLXK4dYRRARJnIjpg4UUSZEc5RBYJ3FFFa6zwcQdF8fGODIIjmFm
 gAT6RHBmHvfijxDTvQYeQEig18mzLMBWRyOGGuGolFF5+H9EHN+9tMO5I+//oTQ2inItITncV/a
 dPsMBb1r9G8gtz5JYmQXSqGFfaNsb
X-Google-Smtp-Source: AGHT+IGAiqSl9wdBWm0A2Cyo0uatttYTty124jqpugkOivDeomrLuv0Ex8ejccBqvV40nYAuYRaM8Q==
X-Received: by 2002:adf:9bce:0:b0:411:3c14:3aac with SMTP id
 ffacd0b85a97d-4113c1440f0mr3141449f8f.7.1758895742114; 
 Fri, 26 Sep 2025 07:09:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/44] target/arm: Restrict the scope of CPREG_FIELD32,
 CPREG_FIELD64
Date: Fri, 26 Sep 2025 15:08:15 +0100
Message-ID: <20250926140844.1493020-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h |  9 ---------
 target/arm/helper.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index d02d74f1f5d..6fb1994afa0 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1016,15 +1016,6 @@ struct ARMCPRegInfo {
     CPAccessFn *orig_accessfn;
 };
 
-/*
- * Macros which are lvalues for the field in CPUARMState for the
- * ARMCPRegInfo *ri.
- */
-#define CPREG_FIELD32(env, ri) \
-    (*(uint32_t *)((char *)(env) + (ri)->fieldoffset))
-#define CPREG_FIELD64(env, ri) \
-    (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
-
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
 void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b76a0edb0f4..fe298670f12 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -51,6 +51,15 @@ int compare_u64(const void *a, const void *b)
     return 0;
 }
 
+/*
+ * Macros which are lvalues for the field in CPUARMState for the
+ * ARMCPRegInfo *ri.
+ */
+#define CPREG_FIELD32(env, ri) \
+    (*(uint32_t *)((char *)(env) + (ri)->fieldoffset))
+#define CPREG_FIELD64(env, ri) \
+    (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
+
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     assert(ri->fieldoffset);
@@ -71,6 +80,9 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     }
 }
 
+#undef CPREG_FIELD32
+#undef CPREG_FIELD64
+
 static void *raw_ptr(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     return (char *)env + ri->fieldoffset;
-- 
2.43.0


