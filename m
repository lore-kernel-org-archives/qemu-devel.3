Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CDCC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8zx-0006Ri-S7; Thu, 08 Feb 2024 13:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8zv-0006RI-Cf
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:19:43 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8zt-0007g6-Ue
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:19:43 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51174101765so94647e87.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707416380; x=1708021180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/tGKZ+9GqeHeKeSY3rv7u4L9hfS3bK51O0nLGVHwjA4=;
 b=ywVuU0VHUZvqamkpXfkcutOhoZJiHbr4ltgawq1BHxsJWV5GeQ+C/+M2pcyf1c0yIX
 NdTj74Ed6+DxndKlQPH7e5KgWPewos/sEGzIHbp24WdfEAw0S8G+B2PPkqGPzg8bPcf5
 yLm09uXcccx8DCaUfkaUGcDsLjlAl9xB4tJxjF8JY1MMkw5wN37s2u4zCvitMMRHu/zL
 8NSlK8EhqlC2cRtV/1vqctwub3Jn6CnyAsLfc/B3T4CefT7jsFaRO0sQLFT3mAeUdkOm
 IdlGrshEnZjwdyKyHIg1rSMCi616NSS6faPNJmYFyV3qodGVt2YVVHxa8QV47PvDpjH2
 48gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416380; x=1708021180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/tGKZ+9GqeHeKeSY3rv7u4L9hfS3bK51O0nLGVHwjA4=;
 b=GJIiEXM/w8xfCoJn2wh1WCzv5EBKc1i1gUXTzNrWnBLfqBq7awS42C2M1DDubuhzXo
 8NVbGJfbE9WBSajXfRCX4eYiLIuRK015xJTwM0XTIDpwY764D0my7A+6x9ldLIfoPUdl
 9D5yAa9/X1QauLGcKbnZxwXEXPWF53AZp+ve7Y3K1eZqRACIkuaca0pNBPsVITZtvwnU
 +rtblPzQjtCmzWMwc4VGHVeAf5XVFyJ2Iz0SoRJBWX7zJCIQfqf47OzA1s9UFs3W83pb
 R4UJ1LHfAvNyTYWNiMkdZmUpOQI2LvAFUX3AlcdUmZfBL7aYYeakF4LAFhUgadcLiAQ0
 CEMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXwAeYZ+DinrU7P+xO31nlb4V5hO5+W75RlTKHl6AUbtMsWIV6YWo8n8yoT9czY1TKEvnagb+vqVFwl5D5CLn53LSF8MA=
X-Gm-Message-State: AOJu0YwxHwcmLDlaq3CBQ51NxPCPnQx3dbhIqvYA3qlI+Ivc0Y+BefrT
 pFkQJ02cPexbS1UXOCRZjsByB6/O7CacmOToS+xgTXjShGQdpr4r7G+2aE/D4MQ=
X-Google-Smtp-Source: AGHT+IFiSeTk6aFxZqXQVCHpSCQ6VsApl6ZtU2blVSoothH2ytW4c2iQVyXy7/pfUI8n1aZbQ8rJxg==
X-Received: by 2002:a05:6512:3d8b:b0:511:4b60:a5bf with SMTP id
 k11-20020a0565123d8b00b005114b60a5bfmr30168lfv.7.1707416380066; 
 Thu, 08 Feb 2024 10:19:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUiGphnv/9+bz7wiAS1srwPfWBrRMMvsBMThHyXYedWd9GPfa3ptdo5J/Iz8xusR1GE9zKB5XnVVfeWrntQ8AOBcoGcyH88yzyY0e3dv6CX4/6RUaQm2jEZPtMs8ptFBDAt4GyRSGubyPh+8w5idU7QOuz66ZVQccSgE0rZkb5jd1LojA==
Received: from [192.168.69.100] ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c4e4d00b0040ffd94cd27sm51247wmq.45.2024.02.08.10.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 10:19:39 -0800 (PST)
Message-ID: <86b28c33-4412-4832-a7d7-b5938d945066@linaro.org>
Date: Thu, 8 Feb 2024 19:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/arm/mps3r: Initial skeleton for mps3-an536 board
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-9-peter.maydell@linaro.org>
 <b8fbf313-1b24-4cf3-b5c1-f9289b413a75@linaro.org>
 <CAFEAcA8UqeGKf8pP90i6Jn=AYgqtzFw141ptir=5BEZtpwjD2Q@mail.gmail.com>
 <17a2931a-5b3e-4eed-ae63-63b14032db6f@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <17a2931a-5b3e-4eed-ae63-63b14032db6f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/2/24 18:07, Cédric Le Goater wrote:
> 
>>>> +/*
>>>> + * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
>>>> + * emulation of that much guest RAM, so artificially make it smaller.
>>>> + */
>>>> +#if HOST_LONG_BITS == 32
>>>> +#define MPS3_DDR_SIZE (1 * GiB)
>>>> +#else
>>>> +#define MPS3_DDR_SIZE (3 * GiB)
>>>> +#endif
>>>
>>> Generically, can we migrate a VM started on a 32-bit host to a 64-bit
>>> one?
>>
>> I think it's one of those things that in theory is supposed
>> to be possible and in practice nobody tests so it might well
>> not work. At any rate, this is the same thing we do already
>> in mps2-tz.c for the 2GB DRAM those boards have.
> 
> We could have a common helper may be. Aspeed does:
> 
>    /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
>    #if HOST_LONG_BITS == 32
>    #define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
>    #else
>    #define ASPEED_RAM_SIZE(sz) (sz)
>    #endif

Or deprecate system emulation on 32-bit hosts.


