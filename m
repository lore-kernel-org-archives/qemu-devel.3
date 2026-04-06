Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2FAFB5175
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9shz-0001aU-KY; Mon, 06 Apr 2026 18:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9shr-0001Td-TN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:46:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9shp-0002ys-P7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:46:06 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so3400289b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775515562; x=1776120362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aA/IE560uSHgVPD/2um/9U/x5rMxhaZPgmWdbT6P4aE=;
 b=TtwAWfBZ3DFcKPv/Xpcm5xGq4ww1QdXFgeEdEmhnUYRhFPR51Q7rINcjQAS25cnSlT
 Kmud1ladsH/17SmSoxS0Hk+/STXoO3HCJPi8EFD9O6FYu5haQQ1myTdFanC9hwOx7CZH
 ZQdt5fcNDramSwA2cMwVXWkN+2t3M4KaIgMEKgmgc2fu+5xSHWrdtWwFV1fbBysOSe1R
 qySvE02Sqs1OFjB4y0n9j6EayrdfTl/MTT93ZUtDtqwMIQyhna0KrjUtERbsPXJMxhv/
 CRlhi4bYJe0xxDOue7PBREMuG7hfzKt0FN0VHK4BiRRVUoCK4W59wlBg6MtW3+kDrqMC
 GSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775515562; x=1776120362;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aA/IE560uSHgVPD/2um/9U/x5rMxhaZPgmWdbT6P4aE=;
 b=J4/AihegJ175vT750v2Y8CnmcAgVrgLJYUsS1h7hPvZpRAVoq2p/QBqO1T0l5RJgur
 +QM1oopKBGVPyz4iqJco+A8NuV7CaQyBcoMSSCw7W16wHidY78iTZOIhgEqwmowhgjbv
 uVPpbyvNLiQe9zbwiA+n0zR+lEoTkbfry2Ol6p2eGe+C0zpAxFIHoH+GQyL5dDsZpP/v
 KTrJDXus6nLs+y8PAaVzDmWRJYjvVIhjWGbEJwvTWWHoGydFF1MyL7uL+y2+Uf/4oPjZ
 bKKKaci76Fkn+bYe7B9prSBQxYOE/LBOCzxCdTnMXkSxfxwcuXPoLiwzD66i8Xdq3Uei
 26zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHKEP8yUMra+k4Y+4spOXJ2PCNCFfsFWWvWWU88qoLrxesojTvx8ZyFsxm2kTdcj8/og9yj9oGLkOO@nongnu.org
X-Gm-Message-State: AOJu0YxNdfmewHQI1bu+ShMssS6ZoX1jEBC98BVfRX4htUQI0k40OSq4
 Y7MQMPhq2Z7C7/ky+QWsmlnwyziKfot8qoJEqOt7l5aHr5WacC+rwq7q7X4QDGMBteA=
X-Gm-Gg: AeBDiet5GZxLk/DA7dnsHzohe3HK9xZEgybGj1BtXz/LL0iT7GJcnegpdPMeIIR0ByY
 5OLR3l5/h1BIRDW6SKDCXiUHEx5LCieqndrazAtU+lZRCNxAoiI+JUlsx3UjHdFU3DcrFCkOtfG
 Ievf/UNo4qlGUIk6atxMmLx+uiD27S72vEn6ThdcTHUlGPQg0HJXHh5IYBndOl5iVA9GYpSZ/D0
 z4NGzqhgtuUput31zU9SDW8csqFcCLUdQUVVHmqr3yac0Ic+68aVCzDDs/QXlWmbhoTsST165jE
 dGRj+CAgbFMSzGE5MS0RM8AZTzjC0MRMjPAUULNLZ2WcRSucgzieNL2KHqrEEWALP6nE0rHB0z9
 3ONxLmfNxIOQAn4aKrhpWlyceyvWZPF0gBrP2FoCqySrzh7ZHCVBlrZoTHZQYm1D6OKTUXotsjD
 6VN/2q1Z8AKjtpmaOK3qliVDdTqweTl7MZRAjT2JknXkBC7uZPdjKOViGbwHGBrliOsyY=
X-Received: by 2002:a05:6a00:2282:b0:82c:da94:eb54 with SMTP id
 d2e1a72fcca58-82d0db3472bmr13748476b3a.27.1775515561675; 
 Mon, 06 Apr 2026 15:46:01 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9cf065asm14340562b3a.8.2026.04.06.15.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:46:01 -0700 (PDT)
Message-ID: <4941d436-847c-438e-8e58-30d6664d865d@linaro.org>
Date: Tue, 7 Apr 2026 08:45:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/20] target/arm/tcg/translate.c: make compilation
 unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-21-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406182609.193886-21-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/7/26 04:26, Pierrick Bouvier wrote:
> We removed all target specifics, and can finally compile this file only
> once.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

