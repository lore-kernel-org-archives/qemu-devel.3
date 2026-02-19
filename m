Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36351E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvF4-0008Mb-Vg; Wed, 18 Feb 2026 23:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvF3-0008Lx-V3
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:17 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvEy-0001D2-FO
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:17 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aaf9191da3so2854115ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473731; x=1772078531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+EWQStl3OxtO/agizp2TzeqNHuyOddWzArd5felHRI=;
 b=QWL0H7Kce/kelE9D1liCOoc+wHrwa+TpZDX/4mvSF3JWPlYnQsoFF7q/eoWNC1Eg5S
 S2p82B8E72nA4pcDNK8KKfWipKm46PaiTrC2lp4XIui7JcvEDrVK1TR8v8k87NqjU0Cf
 zUo2o52as15wgTGZpNROxyfpz2cBCrdsGvZeG6LMeXjgmRgabCgPMd597U6AA354KhZR
 i4f9i48ccOFL+ytLBO+3QHTB1MY+k+TpDq98V/YLmJXZ1hfHEdLaAtyquHc61XyOP/XP
 lFY8iajxS7U5ExZFbgUjqE9bV+ER7kM+Dq5LDTV4AQdKIn2HBV49yDpSZSZxT/9VMb00
 SPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473731; x=1772078531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+EWQStl3OxtO/agizp2TzeqNHuyOddWzArd5felHRI=;
 b=rSRw5VVvvZT99gABsIDOqdOQKK+b8f+aT7ylsZevPlKWLyRM5AbxFAucVCGJpph3KA
 PDJBH9dHwj1mf+XfFGRmPk66CisF7Ku7iRw1bppaNtSAPANq8AFJmX5Csb+vV+OYnoMa
 1Kd1F2NNHob8b2bvOA8xyAGEd8sV4AaKlfEJz2izg9n7/eHwql+NI0uEjw0wheIX5VMT
 tsdDSfVtGrc3lP8pNrKwyoAvBZD7pnOOnuSD9ENu+pvqk7FT7pHMN0bmiVOos/hbWOr7
 gHG4FZWCkornGQ9j9/AGq3Fg9fe8oIpv+fY5fNxqYLjixlva07R9m8L+WxburfcKKtMx
 8vFA==
X-Gm-Message-State: AOJu0YyHvUC1HvWCiR0xZ8YtC9c5N3Cme+MxiH9sdyysoVAM17uSWPBJ
 oDqjUB58hA6cPJqP6Qr0tbAhUkGaxN3dXfN0DWLR0dHed2PReKOIK0UdRPWYcH4yzrSF/EXaY09
 /MXEW
X-Gm-Gg: AZuq6aJ/gh9DpezHmjV26q2JNUYSJ9KXbrYK11Zvt5hS0mZzFqQNYjan3bGHhdPKYMN
 Zd2yhBB+b+clhYSZGVZTO3pWZJkMghWy2Z0tyPuMUj9P4Vx104daoF22UYb433JB/Vh/MpOlcak
 MZKkVDT6F1XWUytD7gqOiGFwSXeeBxl0w7m86cb39j9Bi4ITxlYWd4MQ+v2R2TM4zrDqGBe5/VE
 phnytbXEdPh0tZYs8sgdH+Ed7BEuwdhaGFC/ttCLLM2bbrKKspjMCbx+KlYYscFc1wejj/tMvBd
 d5wyXcQMlTwrkozgxVG4M/4CeJQ/wUp9fLYFMKsFgGp5TdST0Ac70pZChL+fg6yvv/Qs/3USDZV
 tiV4W3YcM2VcHcnXTnkywZVXKN9BftjsN3bJTJoQau6FIgEYXhHUg0ndUJ/TZ0xtotAFQnGAwrB
 Q++4VgtG7ocTt4RajDSu7D6jfq3Scg4nnoYuzkpjDBl1a83t/uKXLKL6RRx+H9Oo10hYC2crBE+
 zRR
X-Received: by 2002:a17:903:32c7:b0:2aa:d60c:d48a with SMTP id
 d9443c01a7336-2ad50e77664mr37975015ad.7.1771473730975; 
 Wed, 18 Feb 2026 20:02:10 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 02/14] target/arm: Don't require helper prototypes in
 helper.c
Date: Wed, 18 Feb 2026 20:01:38 -0800
Message-ID: <20260219040150.2098396-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In arm_cpu_do_interrupt_aarch64() we call the TCG helper function
helper_rebuild_hflags_a64(), which requires helper.c to include the
TCG helper function prototypes even when this file is being compiled
with TCG disabled.

We don't actually need to do this -- because we have already written
the new EL into pstate and updated env->aarch64, we can call
aarch64_rebuild_hflags() to achieve the same effect. This is the
function we use everywhere else in this file to update hflags.

Switch to aarch64_rebuild_hflags() and drop the include of the
TCG helper headers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c5769477cf..033baf7e715 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -36,9 +36,6 @@
 #include "target/arm/gtimer.h"
 #include "qemu/plugin.h"
 
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
 static void switch_mode(CPUARMState *env, int mode);
 
 int compare_u64(const void *a, const void *b)
@@ -9473,7 +9470,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     aarch64_restore_sp(env, new_el);
 
     if (tcg_enabled()) {
-        helper_rebuild_hflags_a64(env, new_el);
+        arm_rebuild_hflags(env);
     }
 
     env->pc = addr;
-- 
2.47.3


