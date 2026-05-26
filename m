Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3774ACD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYQ-0001rn-6V; Tue, 26 May 2026 16:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXh-00018H-Mx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXf-0007NT-5H
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso94345825e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827902; x=1780432702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skQQWk8vIiv1Thq37qgy7Fxu4qHYyoy6S97p36ux/nQ=;
 b=mDYWnFt0S/HfNvRykVXfQ0n2TJNXvC0fY5ZGeoX19MglI9t+WAAOqkDcT//FnjOzSx
 OZLIWtRvGT1Cs7M1bFTRQURpXfzIDuSRWAZv9oO3R4xdc9Wt4h4gwLOV47s1VbzoVLaC
 SU8Hb4zppGAlckjPVyW+dPNtFCbJFxE6p4O61vYWrHSWOkDIbdoCXtBxS81sQCur0HiZ
 8f8M4AdzVoFvBjs4G3fdAr7xEHFypLI5xtZMdRKgopBHxEq0yP+HCbBYgZEw/mkSiVs7
 70OdqyYgHnmjzp/762kc+rIo6DTxdwLA1LFJGNaNXo0a1O+ImHpUM4dZG2IigmytylfY
 THDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827902; x=1780432702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=skQQWk8vIiv1Thq37qgy7Fxu4qHYyoy6S97p36ux/nQ=;
 b=hfEvh6smcivfszcpV9BV1pN9QYDD5W4W+x5ea/UK2LRfEpU9ZB5JNA7hfVqh1NCOEl
 Gc/YiOrh76sSJfO7jCpQr2GElwEQWgqmPUsXMxCcH/ae4srNMtlW95Cj47kwn295WSzi
 UnjbBGuZnldKT0PHqbLkWtdBbbJ34ua73s50luCxEbW/1y92vo3RVqiEs9eyntudPzLQ
 tsJKZ2xCOMU6PCfampnBisZ8t5gx0xfgmXBKFKQ09BRNKs14/oCWETqlnhu4KWdNXT93
 hJVRXRcNX9YfS+Gp7JbFyRNOCe5RiRx4JkCU83K53SMKYHSnexmEsuHF5ZbKQij/vpnO
 1daQ==
X-Gm-Message-State: AOJu0YyL2av8ISv926hVhPvYMkRnIy7El2LWaenv0VwZG1hJXpT6PjD0
 J0yNt5OBc5/1AamkIBOgr84HOUUuqicxfRJaNRkNh0N3D7natnUy64Fob0qeIwbRj+Df/0tTgdX
 UmNSaFBZzYg==
X-Gm-Gg: Acq92OH418UEREQBBi2j/hbstVjLhYwXiVv6LhtNr4CNWpnJd3GFPPzMOcQw9m67OH9
 bjDkuvlFhebJfpYubS8x7IIGT0V+1qKy1t9BJrNEO89l7PULYgmNd3Ok1rMyJrB5O/v8G/Sdd4O
 3cgui58vRJEeZpMp52qT7YYmyKp42tHwnX5tSiAQitTVFK1WLZZTmk+rn6e5z+Hma7RTYsVsPc2
 JpFlWMtSpPvKBfRDX2gnxgTrXWTwp7SqdxJGUlGKedUX/TrnmZ/n2x7QyE3VNkwE5onSsti4Aqm
 IZ0z/37yU25M5Qpd56nvxmOtIAZPXy46v69TEAL93I2lpjlS+mQZv5XVSq3Tc6tF99js7SObFyE
 jQqkKfNncBf9odw/Tmer4QGvOMDtxbyz6GWUlsMzs/b8IOq/XRwECy4sCckRVQXXJNdUZtKtgep
 ANbQ1bE7BX//RdiM7AwgzjJ6Jvl2jrZDHqLwdMn9rWMgbzHmrSHoOmRbA8zW7phlYHxA==
X-Received: by 2002:a05:600c:1392:b0:490:46bf:17ab with SMTP id
 5b1f17b1804b1-49046ce6026mr321047195e9.29.1779827901732; 
 Tue, 26 May 2026 13:38:21 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490456274ebsm333511295e9.15.2026.05.26.13.38.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:38:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 08/17] target/arm: Build cpu64.o as common object
Date: Tue, 26 May 2026 22:37:13 +0200
Message-ID: <20260526203722.79463-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

While gdbstub64.o is already built once, build it as
common object, reducing target-specific set in arm_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index b0f5342245b..d5a95bf54f2 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -35,7 +35,6 @@ arm_ss.add(files(
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
   'gengvec64.c',
   'translate-a64.c',
   'translate-sve.c',
@@ -80,6 +79,9 @@ arm_common_user_system_ss.add(
   'vec_helper.c',
   'vfp_helper.c',
 ))
+arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+))
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
-- 
2.53.0


