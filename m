Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF83C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgyJ0-0004wW-FR; Tue, 07 Jul 2026 01:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyIw-0004w6-Q3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:25:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgyIv-0000Ny-77
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 01:25:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso1227309f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783401907; x=1784006707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ybXIywk3l228ry1o7u7v3yK7xh72aEX0JHGBvIGX/wc=;
 b=UhvE+gjBS35FVTTutV6tvyyBpa7XYjKoBvh1qsjg+GRzB1ioZFuVng9CNFXWPt4kz0
 FoGjug54eFvU94V9mWyInfh8vPtWAjaQ5taWbqtbg0Rm8VObG3BqXgFCjc8SG/PP1dVk
 5X7aPGSwyasf0fcYrak9Oe06aJj2+cxR5nH/4xGzqnfYRb7OZp137qiGqoqtMNJ+ZN1h
 1wDaY+evxy0K1h1sDPWRLukkRKHZzVj7qHeCP8euP93THkjIc2NK89YUDDekpYHHxMTW
 Ek3f1/GrbthBWPaEeR3shj/czmeF2V65KmHUYhAXClQtDbBd5vtav3iSShknwIPgVbHW
 fTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783401907; x=1784006707;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ybXIywk3l228ry1o7u7v3yK7xh72aEX0JHGBvIGX/wc=;
 b=a/RTLxTQeOQZTptM36s5L/2i5lBEDYLfgGwqLBKB76xxpTfa/OL2aGgr/m1g7MfYKh
 N+WH7QF9QP6jjb0AZQBsFczz8TPVfqlFDQxlECeEIeoIKMof1yY3hB8voMasmEDVWsZc
 LfF0BrTKmeaZaYBV657yKfGu242dKAEm+iiiozKVbBo2Ssc6DRejZJ6aBICQz+/hKQbW
 0IsUOgTmeS+BKEUmsYE398A0nOh1/KhLMf07pd64Z8KaLnAnn0o7oKKhYCEKWE9BjBxD
 CqVboXJVfvQ9KjYlHEzpMbveYt+wL9ipPKcq9wHbhtrw7I+0UhY7AH2gaDYSApKvU4fq
 kdIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrk+Ov5/suLZMBATcIJbL0DRGI+JeUTPOvfBenUzFH1UlHwI7cwJFAwcNscde0oPGA//p0s88kzI9sx@nongnu.org
X-Gm-Message-State: AOJu0YxFZFwbCqEEQlSoCi1NBSJnsmpbEu94Ox4e9Oqgi3ynmNDFtcd2
 yZDjjzJsA6PMgIIhs4wPkV2RFHaCKQfqt/QxNYmBk6rNJvDb7aAUod0ebm8pdvTkn7I=
X-Gm-Gg: AfdE7cnZChjOFwqxQq2vUwZ2v/MyApZl+4vMQI6+bDKFMah0g+n2t2onAnyeA6sQYCb
 EoCKEyYcYfxg8E94ctAf15zXZlZQoQSkHM4F8x3Il2HsAHkVNgVuN3EEwx7KvJBpm3IO2pEfLV7
 OLFBle1Nh4kMkBBW7onhfpazBnege0uSLcoSFjwPH0PYk8NpxN6EwdJvwdf3EsYAFr6EBB3jWD5
 SHpanGClCiaBotkP5LaDq5NFh22gXDi+Z+xb65cz8KjeM/WrxDK6p+TdtV3oEXvHAmcoYEbGwo5
 nHXRrDgwMLQ+3C6Jttqevus0pyib8AJjtp9PE2fXwy/DVYnUUggji4adYh0LElkSa4QhEIK6Ldu
 E6EssWjGTQ5NEuccK19guwGscuuyE1ib7cRCaBhNsuEJE2D4PIHXLx23wF5I1vJ4TEPM2VgPjUZ
 95s6Dq6ImAYoelyF7tmSClJ0raNT7LIrTWTBLdVmmGD81Ryp6ERmBb4VXKXgV5IIM7Hb/2yYl8g
 9jRB1GNq86w3NhYH0g9ls2BgjfBRgdpnHKoaPRA49vp9MK/uPOiQTC/OPdszADhCUyofNFUo4vj
 GMqUO4XwXzHL1d58trOap0lKIDJ2MEDrdldGM1J5JLgfjpA5qy5NyBE=
X-Received: by 2002:a05:600c:5292:b0:493:c10c:22f0 with SMTP id
 5b1f17b1804b1-493df08cd64mr37852015e9.20.1783401907534; 
 Mon, 06 Jul 2026 22:25:07 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm29600812f8f.28.2026.07.06.22.25.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2026 22:25:07 -0700 (PDT)
Date: Tue, 07 Jul 2026 08:24:47 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daud=?UTF-8?B?w6k=?= <philmd@oss.qualcomm.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Alex Benn=?UTF-8?B?w6ll?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 21/91] tests/tcg/meson.build: add logic to skip tests
User-Agent: meli/0.8.13
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-22-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-22-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <thshpu.1d2m5p0a6ip6v@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

On Tue, 07 Jul 2026 01:32, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Instead of skipping tests and not declare them, always declare them and
>simply return an exit code 77 (SKIPPED for meson) and print reason why
>test is skipped.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index 679a69054e4..2bc1fc77775 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -115,11 +115,15 @@ foreach target, plan: tcg_tests
>         endforeach
>       endif
> 
>+      # if set, we'll skip test and print the reason
>+      skip_test = ''
>+
>       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
>         continue
>       endif
> 
>       if 'plugin_test' in setup and not get_option('plugins')
>+        # do not use the skip_test logic, and simply ignore the test
>         continue
>       endif
> 
>@@ -227,6 +231,11 @@ foreach target, plan: tcg_tests
>         cmd = [setup['env_var'], cmd]
>       endif
> 
>+      if skip_test != ''
>+        # still declare test, but skip it and print reason
>+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
>+      endif
>+
>       test(test_name, env, args: cmd,
>            depends: depends,
>            suite: ['tcg', 'tcg-' + target])
>-- 
>2.47.3
>

