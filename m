Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7471DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwImO-0002xl-2A; Mon, 15 Apr 2024 05:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwImK-0002xO-J4
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:37:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwIm6-0004n0-3k
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:37:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41868bb713cso3827915e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713173836; x=1713778636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xDZ/ro/K3R8/ot/wwkwB1RK3g02Qt8gfYMy6+gZwKq4=;
 b=NiCQeiBbCFL12THN7zLVM3IxhYj6pbbxtIoVNhRR5FcSma8ThK53UfGO8WLx9NdA9a
 /Lf6G0M9DYLYOMrbKAoALSrKYrOU7eVV2TAVz91w9zt5fOcKU4w7zNKkVWlDsQn7i7mj
 bQhmKHVnHfReV1lyyjQ3km7GPo2m9fS+W+cc6ZgraCJX41rHQMeZ83Ke5yJhlVhEjPUL
 Q99M67ygKQ+3VC5F8pjEqm7aVGieZXD5jt1PMP2lE9cLml1RxADCNLZFGOLlgd8S9ce1
 moQcUWjad9DLwOanQm94kG1eUzyrZW8nj3qi05imlTuBEHEzPJJwTPqU0py5b3mFD5C1
 c5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713173836; x=1713778636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xDZ/ro/K3R8/ot/wwkwB1RK3g02Qt8gfYMy6+gZwKq4=;
 b=Am3iwi8d/hr5WaEHnjtjtH4JFscsZKIjR5nqJ5poWJPafpBbHdFLMtLUUkmrwN1GOn
 dqLJwHZUvsp35S6IdT5NSU6NF8uCEjj0mAXj07xw3OyZWYWRSytg11QUnQ9hGwAOUfdY
 75sScmtSVhHET/FvJZ6Fe/8jQBQAwPGPX+YdPpoMciD3ixYuJx9PXGmdSnAMjt9QWsmJ
 ZEReCgQ8nRJXXP+7r9RC7ETvLVLFm6SNqOGDKrPV7eIuVw6cL/W0OSutDDJD9Os98zbd
 hnGr8k+N+rKRiuipQ5B/hH93R6FlqRgd8k6AS7+xyONwz3CLpv/1sM0Ev6Z2wgmIw5SJ
 TKhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkJ3RW01tG3zPW8isvU5WWYOA05zWxf4MMjEKWoN7yoJOFAlnuUfXMZHJfcnP8EUR9AUccHA+3BH1yhVt7u77OgNoCRFw=
X-Gm-Message-State: AOJu0YyEPCfgilHWW+Ftb4SIVgWGF8HWnu2ACnQ9GKtRbfFSmKXR8uag
 jZJxX0YKHZ7WvKfDydvD95gYHO7FjPN35p9YAjXGab78MZFSncfbGW8gPkVLnFE=
X-Google-Smtp-Source: AGHT+IFBLlaqai0tKpMGj95dCb10gqYTw+rJnNmvbyTEBiVaVRQ2xCNGWm6BJG+4JlUYsoOIkngQ/g==
X-Received: by 2002:adf:ed41:0:b0:343:78d9:ebad with SMTP id
 u1-20020adfed41000000b0034378d9ebadmr7314683wro.27.1713173836319; 
 Mon, 15 Apr 2024 02:37:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 bl40-20020adfe268000000b00346d886f3d8sm10468352wrb.16.2024.04.15.02.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 02:37:15 -0700 (PDT)
Message-ID: <fd8b5165-c508-4ca4-bd4b-d423feacda9d@linaro.org>
Date: Mon, 15 Apr 2024 11:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tests/qtest : Add testcase for DM163
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
 <20240414130604.182059-6-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240414130604.182059-6-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 14/4/24 15:05, Inès Varhol wrote:
> `test_dm163_bank()`
> Checks that the pin "sout" of the DM163 led driver outputs the values
> received on pin "sin" with the expected latency (depending on the bank).
> 
> `test_dm163_gpio_connection()`
> Check that changes to relevant STM32L4x5 GPIO pins are propagated to the
> DM163 device.
> 
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/dm163-test.c | 192 +++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build  |   5 +
>   2 files changed, 197 insertions(+)
>   create mode 100644 tests/qtest/dm163-test.c
> 
> diff --git a/tests/qtest/dm163-test.c b/tests/qtest/dm163-test.c
> new file mode 100644
> index 0000000000..6f88ceef44
> --- /dev/null
> +++ b/tests/qtest/dm163-test.c
> @@ -0,0 +1,192 @@
> +/*
> + * QTest testcase for DM163
> + *
> + * Copyright (C) 2024 Samuel Tardieu <sam@rfc1149.net>
> + * Copyright (C) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (C) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#define SIN 8
> +#define DCK 9
> +#define RST_B 10
> +#define LAT_B 11
> +#define SELBK 12
> +#define EN_B 13

(Preferably enum).

> +static void test_dm163_bank(const void *opaque)
> +{
> +    const long bank = (uintptr_t) opaque;

s/long/unsigned/ is enough.

> +    const int width = bank ? 192 : 144;
> +
> +    QTestState *qts = qtest_initf("-M b-l475e-iot01a");

> +    qtest_irq_intercept_out_named(qts, DEVICE_NAME, "sout");
> +    GPIO_OUT(RST_B, 1);
> +    GPIO_OUT(EN_B, 0);
> +    GPIO_OUT(DCK, 0);
> +    GPIO_OUT(SELBK, bank);
> +    GPIO_OUT(LAT_B, 1);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


