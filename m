Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76275EE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voThB-0002Pe-KZ; Fri, 06 Feb 2026 16:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTg9-0008Jn-Nm
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTg7-0002n7-JY
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:53 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so38949125e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414464; x=1771019264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qh/jGNOFL36SPCOnJbcD7RTE8Lj8lLAf+zxavfinp3s=;
 b=GENeRUaVepPu3fVZirY9DFT8rzBNrldXXgbrllSfECMZI1yDmr4kHXdFM+cD2sPFSU
 7wGdKeCyoBremED7uqblLMXMWCoP8RlZz1mH4+sZDXJqtbagoSLXkfj3cjR2eddKqLKL
 RxxPc8U13qlVYYvZCWH6KV9i0FjNf4vFL6Lqcdj4nKltQgY/Ktiu2wQ1wF42vw2996Wm
 CTHeHDQBsUBzXAb0G5mHZfn+ZvpOAgu+hzQdDwxXwfHe5zRP4CYqEyjNsPg/BVa2Xkkk
 ItTXY0bqfVNvZljTg7qbCNo782a+dkPXmnls9WRCfyAvEXI/+rkMkKv5wTccuiFLjlxk
 FMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414464; x=1771019264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qh/jGNOFL36SPCOnJbcD7RTE8Lj8lLAf+zxavfinp3s=;
 b=V8dJg/pPmK7quQbzsgHsA7HKob+fOFHOLo75bWvHoEFocmpMEC7mK+nhVAZ5daCuB1
 j940ZvBc0iYCtinUjQ4q2h0XNVqnHupKeHVT4Au/LwGkyNybbuWOLCAUbol/ZGNmuv4H
 W64F4EADHMXVWEcdljU+VGGg6NDbDzH0jPTelwYxsD3eS1xgCLIiZ2rkgFp2i2v5We+I
 N7voJ6fB462Jhg3hRwV0DmInRgGe36ChrmDoXeUKOWwE+x6zCbI5ywvE4aahH0Eqzzkb
 cvNOJv1x+tju8FwtYToQnNwY2ICbOAzEXzDOJ2KUsxh4l5Ie/Ry/DTkUn4Vzrhi0Ummz
 CSXQ==
X-Gm-Message-State: AOJu0Yy1ddtPpTnmv8oznr04eS7MmW8f/r/KKuWkImdVgRJbZO9VkOSW
 MRIZ6lr9TZcn6Q8ACzAueuuUBhnkoaL+aJ8rVvPmNTFzskqo9+cpnSQB+qmDlL2jcwd64/jfKvj
 M3zyysoo=
X-Gm-Gg: AZuq6aJ8clHlGsZ+Oj0v2q9mhl5EizqDRrJF0XPwgwHLLq0lCy++SGD76mDK78EajXz
 4tEOdOOgo5VB67RJ79OVF8kaPKgmF4km35Gf2AbTnpmXHvtNqShEZa57uIw9mORH3pOUL4aW/jz
 21JQpC9zqKSpfoVmcEUKU4H766T8EZWDhqZwzRIWmLGoN3oZfCp5/rg6IEPDTNKANfY+hLYbup0
 Je9opL2VZTCMmNXK9Yf+x1EsCqOxVlOhD8mlaUE668qzT0WToYENHFWukdznTHQYS8JnqDcGiJS
 yHKJggMYlqzXKyUJCyqG50Xn6jb/JfRJ2sfqZLyH4F35wW07zzqaba6V/3Q8Jqbfh6tqQiuLiOE
 ihheybStDAny+R+5qhz60HeCa97TFB7QoZ9WgiMgX6vBVXzDnI8drIBkk6MgHCM3r6QJy5rso9s
 NenM+O8cJB/mTX+trAq2cIftKwsni5XS1G6MM/nStkc8tS47EQ2X59S0aEwkrt
X-Received: by 2002:a05:600c:64c6:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-483201fffeamr57407595e9.3.1770414464261; 
 Fri, 06 Feb 2026 13:47:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43629756bc3sm7971718f8f.39.2026.02.06.13.47.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 26/30] docs/system/or1k: Rename from openrisc
Date: Fri,  6 Feb 2026 22:44:44 +0100
Message-ID: <20260206214448.22008-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Also rename docs/system/target-or1k.rst from target-openrisc.rst,
and update all toctree entries to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stafford Horne <shorne@gmail.com>
Message-ID: <20260205030244.266447-6-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                          | 4 ++--
 docs/system/{openrisc => or1k}/cpu-features.rst      | 0
 docs/system/{openrisc => or1k}/emulation.rst         | 0
 docs/system/{openrisc => or1k}/or1k-sim.rst          | 0
 docs/system/{openrisc => or1k}/virt.rst              | 0
 docs/system/{target-openrisc.rst => target-or1k.rst} | 8 ++++----
 docs/system/targets.rst                              | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename docs/system/{openrisc => or1k}/cpu-features.rst (100%)
 rename docs/system/{openrisc => or1k}/emulation.rst (100%)
 rename docs/system/{openrisc => or1k}/or1k-sim.rst (100%)
 rename docs/system/{openrisc => or1k}/virt.rst (100%)
 rename docs/system/{target-openrisc.rst => target-or1k.rst} (96%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 660a0c78461..e973e21709a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -302,7 +302,7 @@ F: tests/tcg/mips/
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
-F: docs/system/openrisc/cpu-features.rst
+F: docs/system/or1k/cpu-features.rst
 F: target/or1k/
 F: hw/or1k/
 F: include/hw/or1k/
@@ -1493,7 +1493,7 @@ OpenRISC Machines
 or1k-sim
 M: Jia Liu <proljc@gmail.com>
 S: Maintained
-F: docs/system/openrisc/or1k-sim.rst
+F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/or1k/openrisc_sim.c
 F: tests/functional/or1k/test_sim.py
diff --git a/docs/system/openrisc/cpu-features.rst b/docs/system/or1k/cpu-features.rst
similarity index 100%
rename from docs/system/openrisc/cpu-features.rst
rename to docs/system/or1k/cpu-features.rst
diff --git a/docs/system/openrisc/emulation.rst b/docs/system/or1k/emulation.rst
similarity index 100%
rename from docs/system/openrisc/emulation.rst
rename to docs/system/or1k/emulation.rst
diff --git a/docs/system/openrisc/or1k-sim.rst b/docs/system/or1k/or1k-sim.rst
similarity index 100%
rename from docs/system/openrisc/or1k-sim.rst
rename to docs/system/or1k/or1k-sim.rst
diff --git a/docs/system/openrisc/virt.rst b/docs/system/or1k/virt.rst
similarity index 100%
rename from docs/system/openrisc/virt.rst
rename to docs/system/or1k/virt.rst
diff --git a/docs/system/target-openrisc.rst b/docs/system/target-or1k.rst
similarity index 96%
rename from docs/system/target-openrisc.rst
rename to docs/system/target-or1k.rst
index 22cb2217a68..b1ee2a34a2e 100644
--- a/docs/system/target-openrisc.rst
+++ b/docs/system/target-or1k.rst
@@ -55,17 +55,17 @@ Board-specific documentation
 .. toctree::
    :maxdepth: 1
 
-   openrisc/or1k-sim
-   openrisc/virt
+   or1k/or1k-sim
+   or1k/virt
 
 Emulated CPU architecture support
 =================================
 
 .. toctree::
-   openrisc/emulation
+   or1k/emulation
 
 OpenRISC CPU features
 =====================
 
 .. toctree::
-   openrisc/cpu-features
+   or1k/cpu-features
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index 38e24188018..5b12858b216 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -21,8 +21,8 @@ Contents:
    target-loongarch
    target-m68k
    target-mips
+   target-or1k
    target-ppc
-   target-openrisc
    target-riscv
    target-rx
    target-s390x
-- 
2.52.0


