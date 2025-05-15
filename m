Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C943C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVo9-00067W-To; Thu, 15 May 2025 06:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnL-000534-Mk
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnJ-0008Cz-97
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso8445525e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304788; x=1747909588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ScwW0ONtDLcy/cF9TCJ80LU8xn4rp8C/x9ucnaQhaXg=;
 b=Fovwpejc05DAIDpvGZw38MGfA2QUnhFwnK5doZcfy7uWtX4424zZ1G5LQl3cqON3J2
 BmP0Z0XstimJQ2nYAoG2yrGAQz6NO37s9Mz/Zn3RbQoxWON4mIxa6hJ4q7eanxcqPtYh
 5Hbx5G6u83PZZi4xYq4EqJg0j2nV/64AnIcv5Dg2ttJOLUvbJvqmyQpwCqjyDPbtc7Hq
 uLbEzbImD1xcOyswalsX5Bbv/hY6Fty1hYFPIQ1wOiTe6vnv9a4HIgWeoZBiKShN4+n1
 gLL6wMbSb23h0aTKf7Dwqt/glK/zEjceF+wDnIXB6XiVl/615kChUVh3UVGLa+zDQ3iM
 h4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304788; x=1747909588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ScwW0ONtDLcy/cF9TCJ80LU8xn4rp8C/x9ucnaQhaXg=;
 b=NwDJ2EP+JEim1hu1qjVPoOmMFdwqmBhDtN3h5TUl2FmlGD4jHeRZtxi0r/eYKoHXUI
 n3OfMqaZp+6rI1ZDwEWFBFUkVkzhATXDZ+oCxQjdm+1a5RY+CuZnlaghT46N+wwohcxH
 6j8Bg5KkMICqJmYmGv7DyHvUVE843pN+wPk8i80O3h32PceECO08CTc4valOLTTFDJpY
 W/+1MAiuGn2nbyTJId4k4bRMnSyQeUHd7/UDeQ5OQ0DIOnKK8zxyrSLZ5CsKPhJVOMR9
 oXtMcmzOsSo5FBFfKWNU0DdCcUwD1UXkfZE9wG3THkewgDpQf4g9NN3SaqD8K2fzzTwT
 o80Q==
X-Gm-Message-State: AOJu0Yw/vvPIXJ2SURyO3Ox7g+S+oH4yL5ITvxRhNY6hXChXR/1gEwk2
 v4CT9Pm/3wSUO7fg7uSj4sEOxJhx1z+KO2c14o+BvsQl5RgwMuFN6zXFHEdM+vEtUCTSNJcmQNR
 taos=
X-Gm-Gg: ASbGnct+tVz+3Z8H9sORjpqbQtuFmJHqV5lU4MmmSAhI8yR5WULEqNCWZuQ3NHJOn56
 UKfhG0zZIehAjmhwf5NLZ+GLUXNNH+K2WWtz/doXLZ6BLWqYY60w/dNMMQI6TwMg9R7Wego6u5h
 dJXCqQ3mquIBBdcoxNnaxxpUVbnileGP54x4NMhawmixmtLutB1wy8IpM8D9DFPpc4H4ioqu+K3
 6cPqHl/3yKvsuJbZshVxPW58O6oQo9dcr/wIEs2AjIYcmKvlxKoCer+iGk2eElCVPrTOdlK5aTR
 3aYMvpBBRLbCvsrJ4S9ewi/Vhw9CB9h9ZtjuzzumIgOhyVZ/yAWFWqTt7badgD3mf+S2
X-Google-Smtp-Source: AGHT+IEUcnjwezdbNWVebgx8PmuJAHyrNol3jEKiqpMcVZ3T6M2aPt7Lxf3m47khp6v7HZZLWbXFIw==
X-Received: by 2002:a5d:6d4a:0:b0:3a3:5568:b8ca with SMTP id
 ffacd0b85a97d-3a35568bac9mr1148951f8f.0.1747304787763; 
 Thu, 15 May 2025 03:26:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/58] target/arm/helper: replace target_ulong by vaddr
Date: Thu, 15 May 2025 11:25:18 +0100
Message-ID: <20250515102546.2149601-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-21-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3795dccd16b..d2607107eb9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10621,7 +10621,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     unsigned int new_el = env->exception.target_el;
-    target_ulong addr = env->cp15.vbar_el[new_el];
+    vaddr addr = env->cp15.vbar_el[new_el];
     unsigned int new_mode = aarch64_pstate_mode(new_el, true);
     unsigned int old_mode;
     unsigned int cur_el = arm_current_el(env);
-- 
2.43.0


