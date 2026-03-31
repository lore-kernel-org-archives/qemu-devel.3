Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C76109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Ywm-0005rb-7m; Tue, 31 Mar 2026 09:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Ywe-0005fT-Ty
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Ywc-00048j-1N
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so70356665e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962944; x=1775567744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DI7LzFR4D/yawQQLsJ8n06quUuh4C8hWMkZm7c2PHUM=;
 b=PQomi4BEueTmCatOo/sunKTKXeczDoWrAm13c8C80j7aPJ4PUv06OIf2TGuF1xF2uT
 amzw57uR91niUGVDFJSUY5YLK+pz0GPwTYhJMEkpFeUiyFo7QOL9dDb85dWZzsg/euDa
 xG2HQl/ss2VDR9sRsg6YrCVhraaV4EY09wiFlFi5bFuJzXLrAWuAEOZstwtiTtWT/lS1
 0uU+F4zLFFObMTjdOY1eTjwpiaKs3YMmQrLoh9xBVdsSlnKWxBhKDiz7VKcMgZ0ROK4y
 AxVGNz9k26KebOnk8kELb6jHmGQ0gvGelVk3qBqpI6aeAwRs4zII/U8vEuEkM63g9gf5
 +Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962944; x=1775567744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DI7LzFR4D/yawQQLsJ8n06quUuh4C8hWMkZm7c2PHUM=;
 b=MoX4k97i2hKCql4G+COxw2l1xTF7M1PCsr6Eyhp2pi9ntNhuPCMq5/fBZRJgbEoZ4u
 bDS7nlEGjkqmdFgQedRXbvjkMuK+5ojYMCNqCnsTW4aIlEExzm3RpZNb+kZwu1ISri50
 Zj5s6o3MOstXVYxSX9r8AIO1Jz1csPmP1eOp6hJU+/J/XYM7AlwBS9OWeEp8ZuG1hwsv
 4idQpDGcWJ1RfGkG1mL5lRD4xVss8r1e+aWAWZtaSfaU6KhdDTrhwEZAtiw6lMpbulbf
 idLJ2q1l8LSz3tWQkGBqorbCF8/2FCzyMoO4n4FT5YPG4MN+ULKw1Lt3frtceqJZ+lcK
 2kQw==
X-Gm-Message-State: AOJu0YzAzZvsvKvfFvZc/JvypzZnBn/zJsji45gXYV0DyZ93EC+AlpWB
 dmkymLXGSWmohbzdTGNFt2hJJA8mZLoiv4NhsQwUFp5Ufn/r7p5Wf5gVQ/oMxn/mlAC27aXFwpM
 +is7QCw8=
X-Gm-Gg: ATEYQzwyf9/+IAX7ZlFvCNs1AW/XlJjQ15x50qmGapI2kFNPaR/ZgldO5LHm6xCNIlp
 bOvuvy1P9CwGoyI+bUn+FhnvbsvwkYMgU27vB9RwH+O4YU3GwfPjWWsQUt55uufQoHkqVQ/ZHjs
 M5ZfuhIPam89Bfw3IHPnq49C+R767fa9cm1A9C4w3B6IRrlqGQZGMDXyojPDHJfV9vDqp9Wvxws
 eOC5UKf1Ku+75gT9EDooH3dyLBp9Kck1Ns1Lmd0JlorWCTqij2wvqjYQ9UKYaZINzSNDF+kS9qD
 zgUpfVG9wnmbYzizqvT6YlbAt8st68q1koHBjgOIsn2v6d/mGlVHVWSePtK4uf99lsss11xEPVQ
 hYKsY6gp19crjrf+JuPEv2AtcEYlqFpM+tfIqh/ghxfL0M6x+HGod8/kvqdL/aEe7b/AnGpMHCM
 boo+vp2pvBixy7ckEwbWqFnr5OBgsT69AMtyWMaQ58Pv8x8nefr6DKm5CHzAgbIBKXYvktQO1x9
 7iFmg==
X-Received: by 2002:a05:600c:6487:b0:487:1c2:6a4c with SMTP id
 5b1f17b1804b1-48727d6790dmr262055985e9.4.1774962943810; 
 Tue, 31 Mar 2026 06:15:43 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c884f77sm15178225e9.20.2026.03.31.06.15.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:15:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] target/mips: save CP0 timer in vmstate
Date: Tue, 31 Mar 2026 15:15:05 +0200
Message-ID: <20260331131514.21152-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Trieu Huynh <vikingtc4@gmail.com>

The MIPS R4K CP0 timer (env->timer) is not included in vmstate_mips_cpu,
so after loadvm the QEMUTimer has no scheduled expiry. This causes
qemu_poll_ns() to block indefinitely and the guest to freeze until an
external I/O event (e.g. a keypress) wakes the main loop.

Fix by adding an optional vmstate subsection for the timer, following
the same pattern used by ARM (gt_timer), RISC-V (env.stimer), SPARC
(qtimer), and OpenRISC (timer).

The .needed callback returns false when env->timer is NULL (KVM mode),
keeping the subsection optional for backwards compatibility with
existing snapshots.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1987
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260329113732.482619-1-vikingtc4@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/system/machine.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 8af11fd896b..473d3ab0363 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -3,6 +3,7 @@
 #include "internal.h"
 #include "migration/cpu.h"
 #include "fpu_helper.h"
+#include "qemu/timer.h"
 
 static int cpu_post_load(void *opaque, int version_id)
 {
@@ -219,6 +220,23 @@ static const VMStateDescription vmstate_tlb = {
 
 /* MIPS CPU state */
 
+static bool mips_timer_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+    return cpu->env.timer != NULL;
+}
+
+static const VMStateDescription mips_vmstate_timer = {
+    .name = "cpu/timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_timer_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(env.timer, MIPSCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -333,4 +351,8 @@ const VMStateDescription vmstate_mips_cpu = {
 
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &mips_vmstate_timer,
+        NULL
+    }
 };
-- 
2.53.0


