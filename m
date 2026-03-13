Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579A9106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vtx-00018o-9f; Fri, 13 Mar 2026 02:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtv-0000vB-2M
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtt-0006uC-Gm
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b7a87fb5so1373915f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382891; x=1773987691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+WHHt02yh5HM3gfct0GZi2/vm8WofO1AC/T0t0ve0Y=;
 b=FmXTwUSPd1WhULpRobwopYRD57oC9jCLeFUJp3u5CDlS56Kpdj9VUdasUaye942uyt
 e19/pWrlGlO2yTZ2XBJ6Yjzn3P44B0KZPdaIbrD00KEgNfS4OaefumHZDolwkZ81G0Fr
 m0uFjalkZW8bcozByPQjTsa9LPztV+CTW4TsHRu+dEtgPxfneRCLeVJm3d7KNLe3Esyh
 vaG/Brkro9fKcaTPWfoXb6gxplXtGugQXHQaXEWXzcJcsp+ut+LFcN2jSFCmoMjsD8ta
 s3BE2FmjJ8s9thza+/gMxM6xC2SdPY5JziFwYYYJ/e2XjNBIY0h1/K/vXNoeTmy5FVGA
 3AtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382891; x=1773987691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t+WHHt02yh5HM3gfct0GZi2/vm8WofO1AC/T0t0ve0Y=;
 b=s+70Q49Io+G/ORr8iBSZemd+Vllt3YMJoZaMEIZVBZFiCS88EvX/QJJtJXBkf/EnfS
 czJ4U0a/w1NkXGnHm5FAeMYh6ERxLR2+TuzyU8qdAen9KHKq6OpNesVUTOb3zRRZ7iOl
 TLZ0uFMgF4BM8ChsB7I8Nwgam6NOAxM32NxdVl8L3E68jHh8wwBuFV6e0e5PNfhOuSZ0
 rZBUtNqMLlasMPnrAQYF9qaUVrYj2qDGBATNNJmDqwoYROO+chJobpSVgslwlySCEaq1
 ODsmw5zM3F13phOLJkqJeOv70nT62ZZVqp4mXRjHmZbBkOsj1WpIjvd+Fy/4sgj4Ukzx
 3jtA==
X-Gm-Message-State: AOJu0YxvAdW3GKKpBpeGQ1vb+ghLXk76PAaCxGVjIQdjgVpiLZNxiH//
 QpzfmTuo4VOmNA3yW9sjAIIPbE6WVPjgH/2JAACjCaNZrelAF66lXp+9cH7a15pu9pUTdOlEs1i
 JbWJZCvs=
X-Gm-Gg: ATEYQzzW/94E5+oiLv2auk0DOhTDUEStIrLXvjPeWXtaRv6Ho/v7Sq2bZUrM1WtlMcv
 0y8hEE8EPk16l7gT3U5+o5FwO4snwZmgOM4dKh0u/3DfJicbtib54n00Pd4+6N2fUnsCmbUZy1R
 0Ca2wHI0dOTKR+Q2PqomKo7EnkWu789LjI1eTxRSWddYx0eSZVHArJLPOrPjs9SfZ8/DYGWUuRW
 U04wIwUPpCs5ndIa2Wt6FkRkuFdkM83lmvZpnPoTV/8KJ2nzfmfqeo0RnXjcDr6mSTb9nhMte/x
 3QBUrE9QfGgKs4Ec1O6tNrotdh3/2UeNkHKCzBlRJHLsPdMCUexIWn4ap9py2Hp2V0L1gV8yNny
 X61hsrlB4qtdZFBvG0aM90F9y9gpwgnxVSyPjLAsuBFwHyp1AAsjXj7D3JAhnvbY+BnwqoDqkYA
 Z/mfvnLIEVB32HOIcjL6ObJT7Xyhwz6573NTMSmIhKDDjGguSYLDyXOZHnexUjdg2DWWCGAB1ca
 3BLlQ==
X-Received: by 2002:a05:6000:4e9:b0:43a:4e5:73b0 with SMTP id
 ffacd0b85a97d-43a04e585b8mr2848974f8f.17.1773382891442; 
 Thu, 12 Mar 2026 23:21:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe226473sm13342583f8f.32.2026.03.12.23.21.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 05/38] target-info: Include 'exec/cpu-defs.h' explicitly
Date: Fri, 13 Mar 2026 07:20:21 +0100
Message-ID: <20260313062055.2188-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "cpu.h" -> "exec/cpu-defs.h". Include it explicitly otherwise
we'd get when removing the latter:

  ../target-info-stub.c:39:23: error: use of undeclared identifier 'TARGET_PAGE_BITS'
     39 |     .page_bits_init = TARGET_PAGE_BITS,
        |                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target-info-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target-info-stub.c b/target-info-stub.c
index f5896a72621..07d8647ed8e 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -11,6 +11,7 @@
 #include "qemu/target-info-impl.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
+#include "exec/cpu-defs.h"
 #include "exec/page-vary.h"
 
 /* Validate correct placement of CPUArchState. */
-- 
2.53.0


