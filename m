Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EAD48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghsq-00035m-Oo; Fri, 16 Jan 2026 06:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsO-0002G0-IB
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:30 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsL-0006uv-Gp
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso9357545e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562417; x=1769167217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JqMxH9hKNHMGm8UIIiwO7kE7bFNqCnI01NlYSC3IPms=;
 b=J/4eknik2DeKuTrBDwBdOs3uhoQt9CS8dz+0xRJffV0PwdOj4UuPF/bOklJchEM5zi
 7GzEXSkRBzYCWCjy7vMoNV7f/mpf4iaHSNvikzY5xARysB5o+jlRg0duX0kQ9FDJD+a+
 1s3jdAvIb3ocQ084Uff+dp3lewDwevd1Nov8WM242riFhcTn9xj92TbR2J9qTcq+WcaJ
 eVoXXzHE38YGv4Vg0YhsPtz8uy0GlYn3Fk9TvekU9Vk0S5W5o9gYsx94DJKBMUFpqd/J
 ArY17pR5eyMTe18RTfT+PaM8aKlzCpDgDbjD2RZ1ABXCuy7hc8jYd4oFm0bOQBNyhl0k
 tlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562417; x=1769167217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JqMxH9hKNHMGm8UIIiwO7kE7bFNqCnI01NlYSC3IPms=;
 b=s843EvqC9RntROuqKV5PxE2rvDUtgOjo2DmOVK47OQBmV6Bi4BD7wxt1lOjyAMa7kA
 RM6IalckvFFIrHxmPcwbX5023C0NkWkOjkkCI1zMYxkczjl18PsW6qPWuATkz7MiTtw+
 wg/5aIcF7bBIvARBSlWLx/oBiy38UliVuvGQ/nswKavZsuRsG1KtTbTq59UvXhDwiqzE
 SFPlNLklb7pSed383QoQs4PR4vpwjPOyXycZErs3jhK/5NVV63mqbZbJPLmc5zziX79f
 jJq2MnMt234pbsuNMsMIa84O/ZQvw1RyN7KJ/871Q8VCxD0sZrTbAclU4eazrgHii5p+
 kJUg==
X-Gm-Message-State: AOJu0YwYIrICNoYu39trwyoeXQ3xtHQnCL7DOK/0pOpOvR6uiVnDBjoZ
 IdibKwgR2UuEBUdF1lzwBzoMS08vaWbGk3zHNzO0dVAzZ5U1o81EaYkhyjN7uHf5ooUMgHcYBX4
 tVuLk1HI=
X-Gm-Gg: AY/fxX4ZxwJjfCGABBBvxZlPlYuKDQUhHrfH9f2ynmczi3y7C/NsHxL6+beiSd77BPo
 FF/OFdFBPNf4eCtZLrNRrxHj8jxk9VsXTfm4uocyeK9gIDAkB8g3gxJqENO9FNzDsqEc9p7ZOm0
 YeU1jWt/q2qRmnVK9R/dNNXnprXB72v4ny27gtYxtZhcfiY2gcZGrdc6k6Ub9RLBCKWXy+XlXnb
 jFC+eifVzHxu4aFGvZQ/1kcfpSmBVFQF/4oPJovWb0MXA1M9UZC+FwzE2uEfUgd2EZ1DYv3efBW
 Q+kEvz9YQIJExJfS5bJ/OQeUiUSvwzeOAgR0LvvUU+3kPaG6OMam4TYm1HwmO10OGtP0ExGX6gO
 efpLBpm8oEWXHXsS2KRB9ZhrnndzcKOhEzzn4fykVyO4/EOhdmMucanRo6g7YWCbXpnIYL1UsXy
 EdEj1S3PLDn7VGVC0NviRaWe4VEOpbj6yoVtHHtokUsqJ8WNOT6CSmFHyUD+kY
X-Received: by 2002:a05:600c:3554:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-4801e34cac0mr28814305e9.28.1768562417052; 
 Fri, 16 Jan 2026 03:20:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e879542sm39864435e9.4.2026.01.16.03.20.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/30] accel/hvf: Skip WFI if CPU has work to do
Date: Fri, 16 Jan 2026 12:17:56 +0100
Message-ID: <20260116111807.36053-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Avoid sleeping vCPU thread for any pending work, not just IRQs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-13-philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index af28b8e8825..d74703a3d55 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1737,8 +1737,11 @@ static void hvf_wfi(CPUState *cpu)
     uint64_t nanos;
     uint32_t cntfrq;
 
-    if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
-        /* Interrupt pending, no need to wait */
+    if (cpu_has_work(cpu)) {
+        /*
+         * Don't bother to go into our "low power state" if
+         * we would just wake up immediately.
+         */
         return;
     }
 
-- 
2.52.0


