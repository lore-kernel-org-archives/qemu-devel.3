Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402F1C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4Gl-0005Ue-Fk; Fri, 28 Feb 2025 12:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to4Gc-0005TI-Gv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:35:19 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to4Ga-0003oN-Fs
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:35:18 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-219f8263ae0so46968315ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740764115; x=1741368915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GxXx7T7jklXQqpqM5K9757lno7B+qbrFZsLUnNRksTU=;
 b=D+6rLWHxe0yUFayk6Zh4WI4d2upLGUUh58Xr1/jDWCQGSZL8//5mPav2wQIMkM02Uo
 O+adUUKFi8Qa1nSz5GxYLPaDG8+mg9LhnPTHXcSnsG8pmoZTVNujNcq8covPgSY9Butd
 +o6EsFIdVjG3fzNLWkqkQVTnrYALe1BgoB7Ik7WVGaOfAbotgsh2jY0SyVLmj6rqQ34r
 APfxVh7Heo08GigM9JxSZ/K3rvsKR5bwouGYfCXBLl/2ykhuR38xfhoTGvHt9/WVyGLY
 DPFeOYJ6G8X4mfXwN61YNVzgXGnR4gX0OAgywFY2XmD4LZNIJm7Rp8EFVl31eXIyHjIG
 DSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740764115; x=1741368915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GxXx7T7jklXQqpqM5K9757lno7B+qbrFZsLUnNRksTU=;
 b=wWCM0Dl5RvjDKDjb5cLptT471tsQIm5mFvPvPIZIu/SmsXRAMq7bTX60E7zaTzt7jz
 5PdUzvJkypLsBiEqGYEnl3Ey6ZhQtzZgvdQOBj2CdzGXlbcPJA2Y/5ifc2T1iEbVgUk7
 wNKkmwkyjUIhdH3y26uTqbHS+xDTf1acHRRHTGAdRsCgiDJ/j1pQx1WXmBMKW2v+MDrL
 gsMeDvwtjlFVKaHNQk53AtvN8SWMZBHyDqEARZEqy8tS59Be0mhtGWlJWAPqQtVPiTAL
 kidWgP/Mhn/yq4xVQZFW1hC3/3NmgFwFdJwgRijaFsZRmFnxGSvRQz9wAqHrfk0vYxsC
 XAnQ==
X-Gm-Message-State: AOJu0YxtIO2EpYBoKUPUKBvShGaXWlIfinwmwIY/e7Kc2QFLSNbU9M/p
 b1Ta56jOmvwB3f/NkSPn2TzGqFnnGjrB6kFK6MWfUp5Xv0Wqu4SGr8dvZXm/knI=
X-Gm-Gg: ASbGnctSjupzpIhTd3XacSVAXAxm0yX9lq+nn2rA7Lu5qACXKo8sfAEGpEOdTHMflRl
 r+eSNcIFNlooUm2wYJuhnU/EF6Bwks54E4aLd/PiCOWGOGqaf+kyxrrHZ4kXDEKOHFbvzOjxe45
 n0koojiLNWv9vDauaftIa8kvhKxF139qhiWf4rwM0q0qeY+bcNszM+y27o7Cdz7Hru7ZunTKTeZ
 Yg7MGVn2Bjywh7wPzw800fBZ2fsvvd+51ISwbA0KLyHS9Kd3F7cX3k0wuS5Ke073Lzzqpj3G/pN
 UiSqKOydjEPBkyZKYyFo4DR+LPQYnil5wlXOO5CHDZulsPcLz5MJBZF6INgbI4K0UAquyLPE3de
 9cxYZYsQ=
X-Google-Smtp-Source: AGHT+IE5z9t5MjA9Y+QJ+ebocpgdSbB5MwdOTamxvi/2s+yJaUlW+7nwpmeoOsp385JJZuT068uUpw==
X-Received: by 2002:a17:903:2ca:b0:21f:55e:ed64 with SMTP id
 d9443c01a7336-22368f6a609mr67312515ad.3.1740764114789; 
 Fri, 28 Feb 2025 09:35:14 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235050f5a7sm35749205ad.206.2025.02.28.09.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 09:35:14 -0800 (PST)
Message-ID: <0d7bfd63-0633-4cb0-8b71-37bd080a7970@linaro.org>
Date: Fri, 28 Feb 2025 09:35:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] tests/tcg: fix constraints in test-i386-adcox
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-14-alex.bennee@linaro.org>
 <5facb17d-c559-46df-be17-b37d22a212bc@linaro.org>
 <87y0xquwsh.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87y0xquwsh.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/28/25 03:35, Alex Bennée wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 2/26/25 06:03, Alex Bennée wrote:
>>> Clang complains:
>>>     clang -O2 -m64 -mcx16
>>> /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c -o
>>> test-i386-adcox -static
>>>     /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:32:26: error: invalid input constraint '0' in asm
>>>             : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>>>                              ^
>>>     /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:57:26: error: invalid input constraint '0' in asm
>>>             : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>>>                              ^
>>>     2 errors generated.
>>> Pointing out a numbered input constraint can't point to a read/write
>>> output [1]. Convert to a read-only input constraint to allow this.
>>> [1]
>>> https://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20101101/036036.html
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    tests/tcg/i386/test-i386-adcox.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>> diff --git a/tests/tcg/i386/test-i386-adcox.c
>>> b/tests/tcg/i386/test-i386-adcox.c
>>> index 16169efff8..b56dbc00f2 100644
>>> --- a/tests/tcg/i386/test-i386-adcox.c
>>> +++ b/tests/tcg/i386/test-i386-adcox.c
>>> @@ -28,7 +28,7 @@ void test_adox_adcx(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
>>>            "adox %3, %2;"
>>>            "adcx %3, %1;"
>>>            "pushf; pop %0"
>>> -        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
>>> +        : "=r"(flags), "=r"(out_adcx), "=r"(out_adox)
>>>            : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>>
>> Alternately, drop all of the matching constraints as redundant.
>> That's what "+r" does, anyway.
> 
> You mean like this:
> 
>      asm("push %0; popf;"
>          "adox %3, %2;"
>          "adcx %3, %1;"
>          "pushf; pop %0"
>          : "+r"(flags), "+r"(out_adcx), "+r"(out_adox));
> 
> Because that breaks the test:

You dropped the 4th argument: "r"((REG)-1).


r~

