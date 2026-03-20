Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241D01093191
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Vsf-00070R-B7; Fri, 20 Mar 2026 05:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Vsb-00070D-FE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsZ-0003fZ-Sv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso14845855e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773997850; x=1774602650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oi0H+6KseD1hRtBZv6iO1IsvVSa42TMjSazjxCizyJc=;
 b=jqyRNjtqoPJlAzNEM/FgPJBYnXL3kN+JNox9lJPtg3qZ6nUlhfFYV4YAFtjUFxqY2C
 +llZosO0DLE3peCvKrMdkpkEDL0zlATHtaknfty+dtq5f1hFDYUv9NCIvKsF0s6N+hay
 mQx6PGB+A0WLEwd7wN+WvuJjjcFtZHvSv5i8l/cxe8FqeArIA8oodv0/JZZMMaZ5X5tb
 lX8ik/hoZoHk4RwvM6GBByKP47a1EM5v6Vq8keGuwn5cwHIlGF5qXufRoVD2qbIh7OnG
 ZMksH+j3rJT1It0PuqS+qkIUPVLJJnatMEBFiobHG9/ZtFUDheFk5p1X4mzWmvftuDl4
 sjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773997850; x=1774602650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oi0H+6KseD1hRtBZv6iO1IsvVSa42TMjSazjxCizyJc=;
 b=MZQoYzQVLcs59CmP734hrchp4ZVXSWVEsG5rAEGP7fPM/nABoO+3j/ZhdrnUr269BI
 BCEJ84cfqVXcxy+Qn4FWSgoFnLRr6Jg81a+g4LhzGIG6eLA/omAI2NWuGK386tRzTSqy
 GbQ8TT7OhhjavHB957VRWicC9agDxLPis4EF02vDJjGoaEK4lVWWKX64FdVLIDRzOgya
 UBKk8J1GdCQZ8vzLRXT7A5t0tqIRuTxwoqqoltI/B00MW3L562jN/kCtqy+OY5z+lo/a
 GceP/VoGdCVgU+6yuEQhAm7A3S3wTHxzZdVpwdXoU+WFsqa70Th/vjfLALIKPtSbWFRd
 wtIg==
X-Gm-Message-State: AOJu0YzQSnF3ZT6RKhRPPb1h18PEUh/Hj0QVRKddg4swXXvVANXorqKY
 OBSM44a5ltBwZfHOfyLzjmYtPjBD5Uk1DcRO4I4HYAWvNslMg1br5qRiqqbNlqzsTM5h4hEhcHz
 jZR2VeeY=
X-Gm-Gg: ATEYQzwrQT/hN459COfGjxgpKPVF7cHA4GbawCn/0F5giTH5YNA7yfpCPH2+sCKwxry
 9u6VxVyXKFYY9S4zXrVpA9tU4rZcpTj2iEL+XEUQdsqBe/Cq4KYiz7USQSvFjqNxMvJzRyWow9d
 0o0sKN+k/gnxTj3T9nEIaFnaU05eCWbii5r/tmknBinW0J7F8DneO6rYUd/V0b+vg1rQTF1G+Z5
 TSmiOD5I0Zkw80Xxu7IT0XwOeDdt8+DZLzRc21VRc9OvDqlqS4UQJWrZvKEi3jn88Z9k826Dk6J
 6lRzx0xY06SlGXUArEgZWmHwGTbdUinIetD1/uqpgeoqbUVqQ3qJ0P639nXJicxSrfcO8wlZA4o
 XytdilQFYiBSuuB6fue/EvYSIt47psBT8CuKztadZm5F/bvTm/+HB2fUBMp9nr1TeS1PuMKGgCB
 mtck4Kiodj4jU022kwNtY8lDzxhZGSAh7g9ASbfAKKSrGJ/c6zpHeQe/nH5JfQHzuHtavgjSFY
X-Received: by 2002:a05:600c:19d4:b0:485:4278:24f0 with SMTP id
 5b1f17b1804b1-486ff03d9d4mr30032235e9.30.1773997849701; 
 Fri, 20 Mar 2026 02:10:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff19d387sm11884785e9.17.2026.03.20.02.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 02:10:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v6 4/6] monitor: Remove last target_long use in
 get_monitor_def()
Date: Fri, 20 Mar 2026 10:10:16 +0100
Message-ID: <20260320091019.59902-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320091019.59902-1-philmd@linaro.org>
References: <20260320091019.59902-1-philmd@linaro.org>
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

Truncate manually, removing the need of target-specific
code in get_monitor_def().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 monitor/hmp-target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 155caedd784..5e9f1b0db5b 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -34,7 +34,6 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-machine.h"
-#include "exec/target_long.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
@@ -93,7 +92,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_long) tmp;
+        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
 
     return ret;
-- 
2.53.0


