Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17366CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 08:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upMla-0005yZ-L0; Fri, 22 Aug 2025 04:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upMlY-0005vx-Mr
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:04:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upMlW-0003nf-57
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 04:04:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45a1abf5466so11697375e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755849888; x=1756454688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i55v84+D1aIhLWaISs7kPJXEHC/nZMjQ2iH3IDO+O+M=;
 b=quJhmPYf68m6hakaES7j4rTinaHHOxvBsVGxUvuUzIWY0MizWmmH8ht4b5JG9+xgHS
 85ldJIgqR2NK9wRIl2FffmtZc+wCEwM4t1+827CaVWGRvqQd4Gxc+a3pUyasvLz4Ncs8
 3kx81oDFgN7zP+FNZXTa2JMcakF1eorai71XaDnE7Z9rwimGsfp0ekG6q+sD/+3rU9aQ
 kq9yCT1CoOZz2Q9CdS6IyCLM1+gtmJumMl3fTr6b+c/6p4FpDbTOo8Qr21yBCyIok9Dr
 lzxrFXaOLMKQd/VahTlHuIgkG12yn3IZdoNHdRVHFvaMYQ+XovGtMQKPNoJFP7Mdasxp
 kzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755849888; x=1756454688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i55v84+D1aIhLWaISs7kPJXEHC/nZMjQ2iH3IDO+O+M=;
 b=NKjA414fiCmOlcnwoWgBNnMEh1y1vB+NW76rBV1xYCvF3sXw/BP5owVIPygw9A2AwM
 vPYcSJfx1GOfT+vGHOhYjybegkbiCOM0/tqKehbJLKe0+sjEEu04f1w8HbybubIgUFLK
 zynhRqfLQEbINbJwYtVPMlBPRIDlUi6rVq4y9Vqmqz2rxHwqzbt9kon4uJtIWNUlf6pL
 /MawV9ks+vVcOlMbf7IY6nT4FFzxbfoUbG6KYAKgEm911IxW1TkubeKIkq0nmFaWQPLV
 I80l54pJ0s58p3TS/EKQwkYWY2SE3T6CbIEbOeTOiT0yxUxQUiyTDpluK1JuUQIXgzda
 saTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxqAz53XRdhUT3gBMfUyVh+UIPkXxiMd6NXiVLny/7VUyyTG9Yhvwcjer4sC4YYnc+6r+iThUFvdJi@nongnu.org
X-Gm-Message-State: AOJu0Yx4MUnPmJ8ft2tNyANVI1rXg8Ds6XqumQi3IpYSK4XJELbLF1aG
 Of1gVcK+EpYkjUaaMebqOqtjDMrk6cNc+1qfEtt35fSw4d62DZlwpVP0KMYTuTovxPw=
X-Gm-Gg: ASbGnctqVmEa9RSGiC5va80AnRrCoCLxCLABfD40VosVPCEOGqNr2Mj6o7pps1kA/Aa
 N2z4szKVEunUvpreuvsx9M8WJ4CiyAEDJ3ndHFJ4+H0ygVhT9sniFMNh5/f851/kMJOg4Tg6sk5
 SuDkAu+D3vytUvacEzxdIN2gvbaJq3B4h7+YRywfzQCNzM5X7Znscw5ITvMLNYq7YACLZRWmcMP
 WRdm4Gm/ArQldJFMn59SI8lorkPMru7VSK/Er9iaC+yBzOw08cvGTY/lmEVPPZoPm7dJdrjvdyW
 YmSRJdbtrOH0WsulCZXaRq3Xz8Kw0EX9Engri6hHdRJ2cmvOcJ7dDVH0wyMNINVN7IiAZjsiGgp
 XHV5UOLqMfSJfKO1Ap9NuyPcT2oQt0iHCbvSqK9uo9gVAqdqhC28wdyP5E85BNP4uDr0niZ8=
X-Google-Smtp-Source: AGHT+IF1nO+qLVews9F+WIZmIjxVrJhXKqNm7D7tMzsLEOekHMW8rBvd+leoNi0JOov182YJsNM7dQ==
X-Received: by 2002:a05:600c:c084:b0:458:b4a9:b024 with SMTP id
 5b1f17b1804b1-45b4d7eb83emr38984035e9.11.1755849887898; 
 Fri, 22 Aug 2025 01:04:47 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50dc023dsm28258955e9.5.2025.08.22.01.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 01:04:47 -0700 (PDT)
Message-ID: <a7291f23-16fd-48d7-bfe5-516237696eb1@linaro.org>
Date: Fri, 22 Aug 2025 10:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>
References: <20250821154229.2417453-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250821154229.2417453-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 21/8/25 17:42, Peter Maydell wrote:
> In stm32f250_soc_initfn() we mostly use the standard pattern
> for child objects of calling object_initialize_child(). However
> for s->adc_irqs we call object_new() and then later qdev_realize(),
> and we never unref the object on deinit. This causes a leak,
> detected by ASAN on the device-introspect-test:
> 
> Indirect leak of 10 byte(s) in 1 object(s) allocated from:
>      #0 0x5b9fc4789de3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (BuildId: 267a2619a026ed91c78a07b1eb2ef15381538efe)
>      #1 0x740de3f28b09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x740de3f3e4d8 in g_strdup (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x784d8) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #3 0x5b9fc70159e1 in g_strdup_inline /usr/include/glib-2.0/glib/gstrfuncs.h:321:10
>      #4 0x5b9fc70159e1 in object_property_try_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1276:18
>      #5 0x5b9fc7015f94 in object_property_add /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:1294:12
>      #6 0x5b9fc701b900 in object_add_link_prop /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2021:10
>      #7 0x5b9fc701b3fc in object_property_add_link /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2037:12
>      #8 0x5b9fc4c299fb in qdev_init_gpio_out_named /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/gpio.c:90:9
>      #9 0x5b9fc4c29b26 in qdev_init_gpio_out /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/gpio.c:101:5
>      #10 0x5b9fc4c0f77a in or_irq_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/or-irq.c:70:5
>      #11 0x5b9fc70257e1 in object_init_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:428:9
>      #12 0x5b9fc700cd4b in object_initialize_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:570:5
>      #13 0x5b9fc700e66d in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:774:5
>      #14 0x5b9fc700e750 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
>      #15 0x5b9fc68b2162 in stm32f205_soc_initfn /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/stm32f205_soc.c:69:26
> 
> Switch to using object_initialize_child() like all our
> other child objects for this SoC object.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: b63041c8f6b ("STM32F205: Connect the ADC devices")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/stm32f205_soc.h |  2 +-
>   hw/arm/stm32f205_soc.c         | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


