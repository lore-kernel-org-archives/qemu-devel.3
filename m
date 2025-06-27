Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54E2C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 14:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVA5Z-00036E-Dy; Fri, 27 Jun 2025 10:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uVA5X-00035j-9y
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 10:29:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uVA5S-0007BF-3K
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 10:29:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4537fdec33bso14179315e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751034589; x=1751639389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3jkl0RSixfcpJWBKVGrfoh6ZVQrLew26EIKrobEHG18=;
 b=o4MdEnRD75+aFK3CUAMoqwQsfQ7MhNL2JIGdJDwjl3Lhf5ipmW0cvIsH7RsBaPvEw4
 hOHjSpl5qeqOq55iJ+yC4iw2yb3WYvmIQTwFiD56kQXeO5KCui1YxxXGgNIFE8Q/pHY4
 iop+DitprpagyJB8GxgsMkq/s9R4Fq4cO8YINIq4+MrdAuweSGCSfRwSKkWjyY/bykmC
 x17U04Ar3xVLTz2rhZMDCX/9gTTqmZEeRhMcmzcVRoez4MFS1fvqCkNPJiqoLVpwbrOY
 NBtESCQSTZ/alSMrWOtjL6Emi/xriR7HxQq0n/CiN4EPulEMrFc3tnq269uIcxii2Gls
 qg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751034589; x=1751639389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jkl0RSixfcpJWBKVGrfoh6ZVQrLew26EIKrobEHG18=;
 b=qKiMQp7/qzFIddKHTQNB5vfXMKC4CWHwg7PoFAW3gsYywzSjhDFBIn4NvqpGgN6c1x
 wNOKFe2rwSctSE3Vi5IAbQHiAJ5XArgJjpqE763ctig7aV4DbYjQLoDMt3jx6pAGCyke
 P9Jp85l3ynUapyOWIi6WPeG6J3UIVQ9aXCGooqJcVNDaRDBr5+2Tfe9M6KZXJ58ttHNv
 KOJeav76tKXoS7Hr96bXk3pcluajiudjd1BBSU3CHzc+gHiRibjhNrsMexQ8YIW+I3QG
 kznhLMMFU1LMeuvigq+swCV/bmxl/laMqkJ76IRo+tyfzWZzQMC7wWDZosDH6xdlYKwk
 xP4A==
X-Gm-Message-State: AOJu0YzQvJWZp7kSRJE2Aoo0UAk9VB7uK1V82KXi1Hz7iCryfcMCw1+0
 iQR6Pc+KhFL4OJSZVHiCDQ3vcLfxB67cCuYbFaBizlPljHBorhmyJwr1GniFqLNK+fc=
X-Gm-Gg: ASbGnctRQDeVUqLT+3UVLIQHT9TpiBzWlWB/7r2REevgkrW/qFgkk2I7pMVZ4DwIS63
 r/4XDNvG05L14G3tMNtJBXlRXxcSCULHMxx/Cqin/Y2Ai477mXF1/tJvN3d2ulR/AFr96BL4CAu
 vxzFMRR9o/jbRJRggtLaKam9wVGuXURGMDPiwanAGJY1KtpAXcDKUtjBZZ6IW2+ie4dDdohoMvw
 StmJMEpA8iD30cu5EH8DI8ZAaMRLH1WaY3SPKvUcpMUYjlMRsUylqjILOXI7lZWApkvdjAcEwJ9
 UFkuXMjYZPwlQvjHvgvBpiA7XHoL6LVhwBG8kCsUb8IxfhruiDJ3VZPuPrQUhRbbqnR9gBYc9v8
 v9BNtALsKmnAmngzs6Nnw3+s5vQrWZA==
X-Google-Smtp-Source: AGHT+IGjW/FLEX9dV8z1u55CzE3ajyLNw/6vIWJ+2pcpmVjgb2BFS0pHqOk9vh9ONAkmiODA89stFg==
X-Received: by 2002:a05:600c:6307:b0:453:745:8534 with SMTP id
 5b1f17b1804b1-4538fbe93e5mr29457905e9.12.1751034589333; 
 Fri, 27 Jun 2025 07:29:49 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e6214fsm2863157f8f.98.2025.06.27.07.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 07:29:48 -0700 (PDT)
Message-ID: <9234117e-1a81-4561-a69a-9ead63d5d4b9@linaro.org>
Date: Fri, 27 Jun 2025 16:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 093/163] tcg: Convert extract to TCGOutOpExtract
To: Richard Henderson <richard.henderson@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-94-richard.henderson@linaro.org>
 <CABJz62OFyaXitSdge4M9_oTk34a5aocLJLFYfkOGXc0BToOgVA@mail.gmail.com>
 <CABJz62OMmmbDjWpp6YkXu2d+hB4HeShgqaa05ZigAVqNQSwjZA@mail.gmail.com>
 <c3a2c4f9-c750-4a0a-b6bc-e94b55784952@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c3a2c4f9-c750-4a0a-b6bc-e94b55784952@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 27/6/25 15:16, Richard Henderson wrote:
> On 6/26/25 09:20, Andrea Bolognani wrote:
>> On Mon, Jun 09, 2025 at 06:52:21AM -0700, Andrea Bolognani wrote:
>>> On Tue, Apr 15, 2025 at 12:24:04PM -0700, Richard Henderson wrote:
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   tcg/tcg.c                        | 20 +++++++++
>>>>   tcg/aarch64/tcg-target.c.inc     | 28 +++++++-----
>>>>   tcg/arm/tcg-target.c.inc         | 23 +++++-----
>>>>   tcg/i386/tcg-target.c.inc        | 77 ++++++++++++++++ 
>>>> +---------------
>>>>   tcg/loongarch64/tcg-target.c.inc | 33 +++++++-------
>>>>   tcg/mips/tcg-target.c.inc        | 35 +++++++--------
>>>>   tcg/ppc/tcg-target.c.inc         | 35 +++++++--------
>>>>   tcg/riscv/tcg-target.c.inc       | 54 +++++++++++-----------
>>>>   tcg/s390x/tcg-target.c.inc       | 14 +++---
>>>>   tcg/sparc64/tcg-target.c.inc     | 16 ++++---
>>>>   tcg/tci/tcg-target.c.inc         |  8 ++--
>>>>   11 files changed, 191 insertions(+), 152 deletions(-)
>>>
>>> Hi Richard,
>>>
>>> this seems to have introduced a regression when running on a riscv64
>>> host.
>>>
>>> Before the change:
>>>
>>>    $ timeout --foreground 1 \
>>>      ./build/qemu-system-riscv64 -machine virt,accel=tcg \
>>>      -display none -serial stdio 2>&1 | grep -i opensbi
>>>    OpenSBI v1.5.1
>>>
>>> After the change, no output is produced.
>>>
>>> This causes the
>>>
>>>    qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
>>>
>>> test to stall and eventually fail due to the built-in test suite
>>> timeout kicking in.
>>>
>>> Interestingly, I can't reproduce this by running the exact same
>>> commands and using the exact same git commits on an x86_64 host.
>>>
>>> Do you have any idea what could be going wrong? I'll happily
>>> investigate further if you give me pointers.
>>
>> Hi,
>>
>> this is still an issue as of f9a3def17b2a.
>>
>> Any idea where to look?
> 
> tcg/riscv/tcg-target.c.inc, tgen_extract(), must be at fault.
> 
> Oh, I see it:
> 
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2502,7 +2502,7 @@ static void tgen_extract
>           }
>       }
>       if (ofs + len == 32) {
> -        tgen_shli(s, TCG_TYPE_I32, a0, a1, ofs);
> +        tgen_shri(s, TCG_TYPE_I32, a0, a1, ofs);

Glad I figured the same :>

>           return;
>       }
>       if (len == 1) {
> 
> 
> Please test.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


