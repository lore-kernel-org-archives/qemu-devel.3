Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0AF106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvA-0005Fi-OV; Fri, 13 Mar 2026 02:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vv9-00053g-A6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vv7-00073d-KD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48374014a77so19219225e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382968; x=1773987768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nG5UcRDHpna29G8bHjCIPwu1H4SH1pR2IRh/gZ+5V3s=;
 b=k+DZhZ4ky5rBfdu4XWjRLyj/RU6qOg9yZPXdBqGfZScP8zs1stPAdapjOkgJWbvIZS
 LcbFr4/rJCei8jWDzaFLh+1RdBdlV7XX35D7G7nycy14xG8TU7Go/uPFnRS1MyC1Kqo4
 TWl/GEj8SncCHupu2LIrmzDxib3i4LG37Nup7x4tl89SXPrLlpRe8Dd+MWnx8IO9CRX1
 no1Qh7fJvzQhAm7saWRe9x7qvnsJ5PTk3+beFvgfqECrm1QgRYYdUQ/+c/HcwIUje49o
 4glvsQrl0gF0cecFFvOuk600ng02YHpJRegomXQP03Rr14ZaD/jERGuPrilUIhVRWBe6
 toSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382968; x=1773987768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nG5UcRDHpna29G8bHjCIPwu1H4SH1pR2IRh/gZ+5V3s=;
 b=YD1ALnIZVYQ7QNrsK/g9AMgLfUigbzPLmx4QVN/qnYM2JQr7A68IOQ1quiXmFdkNxN
 AYsew6SrZaOnfT4bUKt8mMp0a4fFGsq+G3/4w2vKx1irM0aINUmBWugfgae6nk1lD3aF
 VbvDYyEOnNSlI0DarECmmoAuRpBTfHwdES1nYei5G39Esik30uB9GxCIUCJ39+mxUYU4
 tXaIGG1s5/7MiDI+vWROemFVmBxHmHwJOOjzYni1k74GWG7gDqGXaav7Hzl82TqHQA6Z
 p4yrHaqZchLzWv/vyirN8Vz2ZYh5S6ijsssSSSORTFPlpL6NL8tRkGUR07Gh28ZTt2+m
 JyeA==
X-Gm-Message-State: AOJu0YxWvcAk+u+7k7KpZEuYVx1W2DIGBVSeiOyE2YDwOCMviaXB4/Bs
 /acaiDfWRKrHO8lBoFIkJxIZQS//XZwBYn550Cq44rY54yH1MmaLUlNt17hSNTVTQMKXfG1T6R1
 zjJyFs0U=
X-Gm-Gg: ATEYQzyL8H7Nyn3UKMmZds6WReQA95gjqiE0iQbQbazkwpPqEBWnlbL1jBHGabw+omj
 Vi+899Q/e2OuzA3IewsgN8b2dKtSGecUuvigX9kQpWr5Pa32Gu3b/CNytSr/WeD8BUNGr3A0zjd
 CoL/zxchgsZUm0C/WeChDjdlfII3HtuNUnMYqm0HYCl6ZIZo7XDCaXSfuBnuN+LkqrFdKSq8ORP
 X6J6haFxs1NeC37l3+0Crz6x68IRRC/21gq8SB6/Xad7pKMxwqlYNiyVuiZdRNkTK3RU3+zI4ya
 sSgM9LdxPcMEiiQ/3SBCoAnLlKPQqPCkZclhRcX/9llrpHhJE5DDe8Nk0SSP8c36MH9G5RxeOhx
 CeBJlj53wgYtT/nmHZptA+FZVgxHAOErnYyJ/yISq/jSa0euFRJNtzu1GAAQ2U2WaQYIZDaKlQw
 gZuMhlcz4auwDZZkQUfCORSlcRqMClnBwkD71lTP/cNnuuTym2WUTzxjxr1Bh9/cHTKvqMlui+9
 6k26g==
X-Received: by 2002:a05:600c:1988:b0:485:3f58:d84 with SMTP id
 5b1f17b1804b1-4855a8d6fd7mr8127055e9.32.1773382966631; 
 Thu, 12 Mar 2026 23:22:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854e2537c3sm177342905e9.15.2026.03.12.23.22.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 16/38] hw/misc/cpc: Include missing 'hw/core/cpu.h' header
Date: Fri, 13 Mar 2026 07:20:32 +0100
Message-ID: <20260313062055.2188-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
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

The "hw/core/cpu.h" header is indirectly included. Include it
explicitly otherwise we get when refactoring unrelated headers:

  ../hw/misc/mips_cpc.c:36:53: error: unknown type name 'run_on_cpu_data'
     36 | static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
        |                                                     ^
  ../hw/misc/mips_cpc.c:40:5: error: call to undeclared function 'cpu_reset'
       40 |     cpu_reset(cs);
          |     ^
  ../hw/misc/riscv_cpc.c:34:54: error: unknown type name 'run_on_cpu_data'
     34 | static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
        |                                                      ^
  ../hw/misc/riscv_cpc.c:39:5: error: call to undeclared function 'cpu_reset'
     39 |     cpu_reset(cs);
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/mips_cpc.c  | 1 +
 hw/misc/riscv_cpc.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 924de855ee2..d092f76f44d 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/core/cpu.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
index 4bf2fd8db16..e04ccdf54fa 100644
--- a/hw/misc/riscv_cpc.c
+++ b/hw/misc/riscv_cpc.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
+#include "hw/core/cpu.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 
-- 
2.53.0


