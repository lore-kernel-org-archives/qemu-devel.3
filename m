Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CAEC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaKG-0003t8-3r; Wed, 24 Jan 2024 05:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJv-0003NS-3C
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:25 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJt-0003qQ-8j
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:22 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5100b424f8fso1401957e87.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091439; x=1706696239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSQhp0P/DRalBnOPDt7LO9q/NJaOxDtFUMlWyOyZnN8=;
 b=l1L1keZpSxgaSwqjNK8uAs3+/ZEr7MkclSMw1/S/byFZkYEKrKu/TLZD4zM0nhpjAv
 Fi2eSEoM+1+g11TMyzOmDzNt25ZJpwlF1/ZcpMN/r/+ankap4ed6ik0d7TjTzdvLQdr4
 NDzFquoLZemjwRjdI+8QuP9xVGo47ZMYBjC1EBjxrKbFpm7+9mPE1SXZCMx3jsgfw5u1
 oX+ITyz7f3bC6YhE+NacK29ZSzODXSKhoVN6bidlbHlmn8nTyKJiY+dG2r1QqAAiLU4r
 wNhbfUuyRMrrGZNq2QaqJlq7+qdYsnaG6eFSvGMJ12e0KUkRql+Olx1LJxkkO/Mj3lAt
 Blew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091439; x=1706696239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSQhp0P/DRalBnOPDt7LO9q/NJaOxDtFUMlWyOyZnN8=;
 b=PZG0ti4auOF5wDLUYlaOY18LYN+w9qiKLjc3AUXzjrH0qp+v96XB6XIKO0haKfBj64
 VLZ5D6za8KTe3WUT9WD78du9iHxNbdGDT7qUIkhtzhmquZviVQcrdCP4BsSSJLY/MwDK
 1itxVpq5xk+tUvY6Age8Ra2SCmwhx8+pvDfC/LLHKvqcLa/PzmeO6FzfUrJheQ9kQFdY
 yvxe93fs7mo4it2z4W6w9qeg/Y9WvUk8Pn/loPnnWyMX2s9bltoiFPw4X2Mggl8QUzD2
 xS+4l+XcwKoPrqUy4D6v2Lb7HrK9JfmEoZJke0ZpqPIywe3N6DlKrXVrWZEyiwHS6zya
 oDMA==
X-Gm-Message-State: AOJu0Yy35S+sKw7xqvOd/6xToUH+0SfD1xxInYpIEtRi3z2+kXswuOV2
 zjVBApkQstguVi2ySPeDJ1RsFJl98dNJOozK9lJB+ECmy5XmLG/kHr6mXty8EaA=
X-Google-Smtp-Source: AGHT+IGQlAgZaXnyZceE+/sYIMLyuxs6C1gSEEQtHHKiUo7Iy7xOXHaKOHVdL2t70v5IIF7PgTq/IQ==
X-Received: by 2002:a05:6512:4018:b0:50f:da9:16b2 with SMTP id
 br24-20020a056512401800b0050f0da916b2mr3904262lfb.74.1706091439730; 
 Wed, 24 Jan 2024 02:17:19 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 i13-20020a05640200cd00b00559c71e70e3sm9558946edu.79.2024.01.24.02.17.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:17:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/9] accel/tcg: Introduce TCGCPUOps::need_replay_interrupt()
 handler
Date: Wed, 24 Jan 2024 11:16:36 +0100
Message-ID: <20240124101639.30056-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

In order to make accel/tcg/ target agnostic,
introduce the need_replay_interrupt() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 5 +++++
 accel/tcg/cpu-exec.c          | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 479713a36e..2fae3ac70f 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -170,6 +170,11 @@ struct TCGCPUOps {
      */
     bool (*io_recompile_replay_branch)(CPUState *cpu,
                                        const TranslationBlock *tb);
+    /**
+     * @need_replay_interrupt: Return %true if @interrupt_request
+     * needs to be recorded for replay purposes.
+     */
+    bool (*need_replay_interrupt)(int interrupt_request);
 #endif /* !CONFIG_USER_ONLY */
 #endif /* NEED_CPU_H */
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b10472cbc7..4ab7d6c896 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -778,7 +778,10 @@ static inline bool need_replay_interrupt(CPUClass *cc, int interrupt_request)
 #if defined(TARGET_I386)
     return !(interrupt_request & CPU_INTERRUPT_POLL);
 #else
-    return true;
+    if (!cc->tcg_ops->need_replay_interrupt) {
+        return true;
+    }
+    return cc->tcg_ops->need_replay_interrupt(interrupt_request);
 #endif
 }
 #endif /* !CONFIG_USER_ONLY */
-- 
2.41.0


