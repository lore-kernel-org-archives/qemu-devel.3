Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4C9C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 20:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1AIY-0001Yc-Mx; Sat, 05 Apr 2025 16:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u1AIW-0001YK-C6
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 16:39:24 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u1AIU-0001Pq-A0
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 16:39:24 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso2191092a91.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743885560; x=1744490360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=iZsonS/kOWHIUp+BrZBU1lBdfOTVJjmc9AumjjIRQrE=;
 b=dEYrAZPogcmJPkl/BDXMwLrgCCd9nnjGz4PzZmvMzUdr0zoFNIE9JFu/byatlyHu+7
 8nN3HtbSavNCI3VL4patdZ4JsvU6ZUFUeUBRWS/Y5xYvdPpbzBp97QrGW241PdXc0qPi
 TSq7e9z8PqPzagZ9uaDhABwgiUY47R8zN1/ui4SmUueiFqZyg1WfRkqfggvdnRbgI7um
 YXiDhYbIh3tZT0D1KOhek0vmtkxnn4kvrUyKRxW7N92t+pw94Qfujx/TnlUwVtZbiLDg
 CoEN1XAHRQ5DjgVMOWGifk84RH7xD745NmHDX9ssmi64FxMqmS3iSGVW0BGreK6kdry9
 9+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743885560; x=1744490360;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZsonS/kOWHIUp+BrZBU1lBdfOTVJjmc9AumjjIRQrE=;
 b=jdFWN8CLxRiaLVrZs8clXxSxZPk3lHNmzUjHMfnmJJiq2pthm/Qe2H7q8EiJYQWLcT
 xSob7dQtm+WyWeYE7fu9t+skkUUrFly0oHSzg8CzzAxjIZv4rz2ojXrZEPsczAB40P2V
 XZ7ztvDN8E9Qpi0cAkfuSHu1v2xU0gngQ+KucllZOeLre+oXSSdObGlXZvMWuzrhTobj
 9HXT0Po34lvlOp9B3Vjq2AurNkOLjNaZh+vHnDCKkG7Js2lyULgQ6g1sFAoxe6ZHklIF
 jO4soH4Mk/NDG/Jgvpdo0cMlXUuQ+OjLRQjgqbvLgGbcznlm/mmPZt/Rt+fRSr37JB3E
 pY+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHMry9Mn6Zg2U7wXOWZKcapb7y0PAOkfEh+MW/LtOczcLqcZ0LRI1IaaOtzYNYoOBnAVRHV+pXLDP4@nongnu.org
X-Gm-Message-State: AOJu0YyLphHOCm+46WdRutQBP2mIQ3cDq1YhsreL0vCTDyJaDuDvjDaf
 aC/Bjo3KH2bPaXxXeq35OEiRxuukOc/8NmXL7c2KhP0OZ/ofO6EU
X-Gm-Gg: ASbGncuUeNhvmV2yGSk5O/Y4QSRmAr1B2fZms0n38P3QYhOSCxk8zWkbTVW0Q46MQMx
 y3N+Hi7KcfPnG9ZY0ONkTfgQ6ts3wrTJP0ZOjKQ449e1BondtEev0OumcnlUTVtj1NVujr4/YV0
 Wx85/s+uM50TPQNQyn3mMbM+ta6BmVinSXb5NySKgAxpnhAeIBPdFlBeLSAOgrPITcLwFiHdlBX
 1WqjPNqkojoinOnaEP9e0HU253/hqTh/p07idTbKfilZf7anEbZrNwtoSNGUziHBUQ4LGSjgCRV
 wd4yBE8ytqogSDoIyBfv8DJIu+sEiLoxOgs6LcWEuBzBklU55Ir1CW3hwQqRf/rOAVFxAv5uE8w
 lW41XXL5ISnzNoBgzbQ==
X-Google-Smtp-Source: AGHT+IFezPDbprZtyR4qSx3uaqScP8CCsHxTbqOVP15yfblZNf42peam3JTETjlKqe1lP1t3aSr5ZQ==
X-Received: by 2002:a17:90b:5385:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-306a621086amr11357660a91.33.1743885559610; 
 Sat, 05 Apr 2025 13:39:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca1f4b5sm6088926a91.7.2025.04.05.13.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 13:39:19 -0700 (PDT)
Message-ID: <dec6e8a6-ed91-4a93-b1ab-e592062e6f89@roeck-us.net>
Date: Sat, 5 Apr 2025 13:39:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add property to support writing ERSTBA in high-low
 order
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Bernhard,

On 4/5/25 12:28, Bernhard Beschow wrote:
> 
> 
> Am 5. April 2025 17:26:14 UTC schrieb Guenter Roeck <linux@roeck-us.net>:
>> On 4/5/25 07:25, Philippe Mathieu-Daudé wrote:
>>> Hi Guenter,
>>>
>>> On 5/4/25 16:00, Guenter Roeck wrote:
>>>> This series is needed to support the USB interface on imx8mp-evk when
>>>> booting the Linux kernel.
>>>>
>>>> According to the XHCI specification, ERSTBA should be written in Low-High
>>>> order. The Linux kernel writes the high word first. This results in an
>>>> initialization failure.
>>>>
>>>> The following information is found in the Linux kernel commit log.
>>>>
>>>> [Synopsys]- The host controller was design to support ERST setting
>>>> during the RUN state. But since there is a limitation in controller
>>>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>>>> It is supported when the ERSTBA is programmed in 64bit,
>>>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>>>
>>>> [Synopsys]- The internal initialization of event ring fetches
>>>> the "Event Ring Segment Table Entry" based on the indication of
>>>> ERSTBA_LO written.
>>>>
>>>> Add property to support writing the high word first. Enable it
>>>> for dwc3.
>>>>
>>>> ----------------------------------------------------------------
>>>> Guenter Roeck (2):
>>>>         hw: usb: xhci: Add property to support writing ERSTBA in high-low order
>>>>         hw/usb/hcd-dwc3: Set erstba-hi-lo property
>>>
>>> What about using .impl.min_access_size = 8 instead?
>>>
>>> Could you try this patch, or provide me with a reproducer?
>>>
>>
>> You should find everything you need to reproduce the problem at
> 
> Hi Guenter,
> 
> thanks for testing the new board, much appreciated.
> 
>>
>> http://server.roeck-us.net/qemu/xhci/
> 
> I like your approach of pruning the device tree automatically: <http://server.roeck-us.net/qemu/xhci/patches/0002-imx8mp-evk-Remove-unimplemented-properties-and-nodes.patch> Would you mind if I upstream it with a few modifications like in <https://github.com/shentok/qemu/commits/upstream/imx8mp-test/> ? If yes, please let me know if I attribute your work there correctly.
> 

Please feel free to go ahead. Attribution is fine.

Note that I had submitted a similar patch a couple of years ago; that
was rejected with the argument that I should not use the dts file
from the Linux kernel in the first place. That is why I did not bother
to submit the patch myself.

Anyway, just for reference: the inspiration for this change is from
commit bf1da4b308 ("hw/arm/raspi4b: Temporarily disable unimplemented
rpi4b devices").

Thanks,
Guenter


