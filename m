Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD5AC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBj3-0003Z5-Mn; Tue, 21 Jan 2025 05:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taBj2-0003Yk-4q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:43:16 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taBj0-0003Gr-IM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:43:15 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3862d161947so2898386f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737456193; x=1738060993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XWvjNI+oquW7gOCu3bcr0rKpVqFmdDU9b/bmzWiVX1g=;
 b=IfJAMC+lRTd8PDZF5zH+bx+C/BwPuqzNg8CRtjaMPmN/6jEeWMQtot6agTv9Z7mwZ1
 xNspTdvakaE+mwiFN5k3M26PfBQr/zCn2uoAkfOHEmt6Njd1RZ90kSnB/bZzz1nwrb1W
 vGnPMNgj24L8lWQf6E3ezh6T1Iqz3vPxK02Mnu3y/S9UvZKdA3gKLRt5a938TxXttdC1
 DKkfx3DHiQyh+sD3skbLO4oVPev1uVCkBdmZPy42pV7odrfMtfrOY7Adz+NkNahLUtml
 6NZMOtU7eEzht7O1fsZKkgA1oeVek4XbbifHzjMUsp12aLdB43zE/jOJLyhvuTTgSCVU
 PjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737456193; x=1738060993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XWvjNI+oquW7gOCu3bcr0rKpVqFmdDU9b/bmzWiVX1g=;
 b=LDHmYm1AagvnqBg6P9ukPEEMIvWBeNQkdZJnR+aP3GQwcQlNRIH3SbgtcdxUKUqXGX
 xquwx8Y/92XVi97Bo9mR3Hy9jDRTcvJEsfOz+0AZ7S+1PtpTedsv6wyMz87cnedHv1sa
 sHJT+iD3FewJPCnL0/t2+9S7jCiCNdiI2Vh9rMk2uK5OcBbFp3WEgQS0xIx+9zBCTVvC
 +5G2AKlWmwrWXxqwXXf6kcgfunjaa9vg17uTpmgO4JcwFzSBEf5Pt4Mzt6QKR+OSfSCw
 cgsDqh50M5Y+d35JbbmOdUFGmlZSsiEZpI9zBiI9GKv/2hkbe7gJLmRp8+yTGm3vbtQ/
 qS9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHzSNFioWksI1XqoUR+/DeA4d5zrhm4jWE5BmjKVokNfqHxa7qkGjP2Jz8lWSyppCkBKdN/G3aC6p+@nongnu.org
X-Gm-Message-State: AOJu0Yyy/8chQmWHXXPIWdTA9xJ4YhhtqmoSNWRY6rDARRT6XLwpaxEd
 0fFxsONU7gStQr4LSEwZrz45izxOibcJSyWnGluAE8Wyh4jxiQnb1TQjtFGirUuwKKq+/G51BtZ
 avm8=
X-Gm-Gg: ASbGncvLQNAEqvmCKi8R6lhU4sBwOKGKXcLxa08Jt+eQMZQycEqeujBv/cInt+MPEq5
 ooxr/vBSwtKyhMyybKzl9t2U83ghSiaTYU8G+Pmu3nGC/2Ef6hne+yviQGq/Eak4lFO6OU7TGFe
 /hYdQINXsWRoor7bqctBAKwiIJqnSyMwBQ8NXdZ/8yAmtzih4VDKn0Em27BwbrkNnTWqLD2NyE/
 LkBJ3CxoyuZjmRz3D8HyYCBj0sWSEN/7X2miUMbxja/H7sl+ZAS54AWlZtdfsKh1fm3f+6l64zI
 g6rZrxr0XTxFLQz/UqlVfTvwAX8xkMxsn9E2ZQ==
X-Google-Smtp-Source: AGHT+IHDpmImTd/EIp/+IDDLF/YRZUUp2MkUGxFGAy0YgV6RSjySzRo1LDcN1LSUtcOcfdjbZLYZhw==
X-Received: by 2002:a5d:5f4d:0:b0:38a:614b:8632 with SMTP id
 ffacd0b85a97d-38bf57a6969mr17110881f8f.39.1737456192304; 
 Tue, 21 Jan 2025 02:43:12 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327de62sm12693987f8f.85.2025.01.21.02.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 02:43:11 -0800 (PST)
Message-ID: <bfa02ef0-12a3-46b5-9749-c9e367145dc3@linaro.org>
Date: Tue, 21 Jan 2025 11:43:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc: i2c-echo: add tracing
To: Titus Rwantare <titusr@google.com>, minyard@acm.org, its@irrelevant.dk
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
References: <20250121103608.3056288-1-titusr@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121103608.3056288-1-titusr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Hi Titus,

On 21/1/25 11:36, Titus Rwantare wrote:
> This has been useful when debugging when unsure if the guest is
> generating i2c traffic.
> 
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>   hw/misc/i2c-echo.c   | 13 +++++++++++++
>   hw/misc/trace-events |  5 +++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
> index 5ae3d0817e..06110e0f8e 100644
> --- a/hw/misc/i2c-echo.c
> +++ b/hw/misc/i2c-echo.c
> @@ -13,6 +13,7 @@
>   #include "qemu/main-loop.h"
>   #include "block/aio.h"
>   #include "hw/i2c/i2c.h"
> +#include "trace.h"
>   
>   #define TYPE_I2C_ECHO "i2c-echo"
>   OBJECT_DECLARE_SIMPLE_TYPE(I2CEchoState, I2C_ECHO)
> @@ -80,11 +81,19 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_event event)
>       case I2C_START_RECV:
>           state->pos = 0;
>   
> +        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_RECV");
>           break;
>   
>       case I2C_START_SEND:
>           state->pos = 0;
>   
> +        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_SEND");
> +        break;
> +
> +    case I2C_START_SEND_ASYNC:
> +        state->pos = 0;
> +
> +        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_SEND_ASYNC");

This patch is doing a bit more that what it describes, since now
START_SEND_ASYNC returns 0x00 instead of 0xff (besides updating pos).

Please split as one patch per logical change.

Thanks!

Phil.

>           break;
>   
>       case I2C_FINISH:

