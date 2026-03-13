Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F962106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vuc-00032c-FB; Fri, 13 Mar 2026 02:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuV-0002pv-1C
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuT-0006zm-4b
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so4031095e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382926; x=1773987726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvA5jqTy1ioKhzpL2bu/AZYU3EWgiK+iY+eG1Q/56y0=;
 b=itP962o8kVk1K6jpJCL1g+vkZ9fWeDdynWG5rHhqP2O0uyqVJAWP1tsDat0ZU+XsRK
 bnzYOTHtVctmoV+VqShTDIjzRHX/6Jflx8AHFGvLfTkNCP4q6NrLqpnVfynmyRLDM9pT
 kYneRsdTnYRzsOFlvi2ny0BV9nfRkB0JZ/qxgBIOdK+ipbFnHpFDG7+BLPEPsIfLG85e
 rDiiq2/eWWMh2VClys5cxqZjUSlJdKCcQMWZ0MKgFZbac0PkaBtp1f7savEL7ei7a4k1
 5c6jxuHOdTcVYL8tJ29yizkUd2VLtxQWdMa8CBOjKUTL7LwZDK3PWIy5nfJlgwPXLBfb
 aXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382926; x=1773987726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TvA5jqTy1ioKhzpL2bu/AZYU3EWgiK+iY+eG1Q/56y0=;
 b=K5JHQKb/Kptrqjh4vEFLmdv2FeGvXWCQPjsSElO/Iji3Rjx2RsKIqYAGhhO4bQS1sg
 FhpK5zgp2fRlW1qhjYKq4ccbdtVvOFTCH7/YqCOd+YWGKbdOYNIZy+jaTmXtU8eHorIR
 CrLPzeApaQpA/cnrur7Nh6+g2bHYLWTzxetECOJG8Sp7uLykITfGnRCQOtACgqyPx8G9
 U0AazSQ7fLoF6QOJ8n6YoyNikCJfih4kxar+OIxXdaeLdTYDcdeVgFhLvjUp5OGXzNR+
 IqQ8RlYkhkI46QRIl1O3Q0Cq1/V+psY2PlB5fBdrmFkp5S5U0OcDhTJfpRqDJrUd6vPr
 Nt6Q==
X-Gm-Message-State: AOJu0YwaNwWNBePkZzgJkM3WR1wFDVcBf0FeHnKw7aKy198w8E+gJh+j
 Vdy+A9p4fut7lMOnjYAXk6ehAWvm6EhxDC2KjvFiK/R1pvKdjQdGk/0Zsn5UiagPWUQ9LfTgXX0
 1FX+shkQ=
X-Gm-Gg: ATEYQzxlN1JV3+ZoxCCuoOr64/9ayLt+rfWC0t7RC0ZOSk9G6iC0ez2ny1uvm95sY4L
 ZdoLUP0rbF+G+NAmAsIdkaqiv/J+gBY6TU3HtrnbUBPTufU9KKh02QZRYamUYbutq4QOmT+P6Ku
 x4hUjCl7ddtwdMJXiCKQE509VJYR0imV1yBA6NmBsc/0C7OAgNtDYVSeJltqU2yRqHholRe2ZQG
 pZo/juacwIym6uL9Z+LziXgDLZp3+aKfW58xYpu6Mtt3Y1KsDdBLfMcCtwlhYi3S9WchK492CDw
 YFu1OjnFxkPhh8zXpwnQh96ZBfhDOpuIGRn23yGPwDlLanrUfItnVwVXx3By0uaWRt5rL2bv0dU
 4pE/gsay6GMv5n8O4qLXOyGpaMl5Onbsl1WsYYZafratENEUcpSFmP0oU4onVGYr9sKkK80fQku
 jPgFXT1uGapqcxwTHmQZ7MeM4xfdh1uDDa47UbcffT1zGdvg9bE9JIQJfuYTelXEP7IO4hxNSQ2
 zzuPw==
X-Received: by 2002:a05:600c:1f16:b0:485:3471:cffb with SMTP id
 5b1f17b1804b1-485566e2401mr30789975e9.15.1773382926068; 
 Thu, 12 Mar 2026 23:22:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fd3dsm188232145e9.10.2026.03.12.23.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 10/38] target/m68k: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:26 +0100
Message-ID: <20260313062055.2188-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/m68k/m68k-semi.c:53:5: error: use of undeclared identifier 'target_ulong'
     53 |     target_ulong args = env->dregs[1];
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/m68k-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index bdc798a28cb..d2a071ea677 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -22,7 +22,7 @@
  */
 
 #include "qemu/osdep.h"
-
+#include "exec/target_long.h"
 #include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/helpers.h"
-- 
2.53.0


