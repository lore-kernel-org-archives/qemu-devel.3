Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8CBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3eM-0001Pv-E3; Wed, 05 Jun 2024 23:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3eL-0001Pk-9O
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:18:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sF3eG-000280-VU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:18:48 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7024494f7daso387117b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 20:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717643918; x=1718248718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UhRX+lEIBZcnZXDfASC+dnhqEh7VMFrCS5B/Ltqgwrs=;
 b=Cz+/DAXs+7alDDkhn+pPrBjSFHlKYRur0+2C67W8X+8S+B3/GBUXIi096niJhgxvs6
 13WA1FnyGKltSdjP+lV+RgkCN6ZpprfT9c6jwO2/VSBt0LRveBDWpAIOPMZPrmMczssd
 i/fGuSFmHi3wg4fRCLljDEbqPCMWLvS03g4qBu5FH6TqzIDmpVP33BJagKIWpY/+/Ya6
 vxzbxfR7lBqi67UToBWS1BtCB2zQII9XkGylqWdo0y2imc6C0IU7EF/N4Ry4NzlBq15+
 Z9Rn1pENG9ZIWlKduFJE1lrnuwbXOPpVozzf1lY5D8djdlknyvJD7Jgou2gGW5nSth0C
 OVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717643918; x=1718248718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhRX+lEIBZcnZXDfASC+dnhqEh7VMFrCS5B/Ltqgwrs=;
 b=BwKrsraUTQMoIv28nAUZKmCsOOZMrWvnMXwiOJllS2jSnSY5s4fM0Bm5nmZH0GEoO/
 LIVOlLHaq9HRk1iCyrg7wj7aVFE43L/53/muMUZAE9d/0Ht3KbZum7LCtw/T73CQ45U9
 J7IsIrcajeRLcTOwOQ2y+loo5LRVtBOkoctz2rXS188l5FpxnuW/7pbM7Sy4BWE2fXt7
 KVxOylsPmrBW7omwXZbSkC43pUDWn8EGOBWyacIFix9izYDSfAsO94nWSufK0NI32MAQ
 CYHUEWuACKBhe4jz3F/c92siFxCPFIPfmItLgH+abu00Uo+o2pJyzuLwJ5kbnyRK4YxH
 FQog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXvEyaOafclWmvjte5xXGAEtA5zxV05etI0ctZqAlwSIfc7Rwv2GtLj5WilrIjUXu8tE8VI6eJOQkxp/lTlEuH6L9FqfE=
X-Gm-Message-State: AOJu0YwmtLC4Shz8oBs3HROPYUc5wlySTBwqYeFBmniEn9s9+6bmGL06
 7LqARNLs7kimHPw3wkSieARxW8e81CKp33uS5jATtpGaRQ7Wpj9LbSBtUzethpY=
X-Google-Smtp-Source: AGHT+IEjth56AJIkpB/yvo9flOukBq14gBSehrRTDMKDOI7do9IbaCU+wT0ITg5ZBAUYI3HFXSrCxQ==
X-Received: by 2002:a05:6a21:3390:b0:1b0:18d1:c46c with SMTP id
 adf61e73a8af0-1b2b6ff5f19mr5412690637.27.1717643917922; 
 Wed, 05 Jun 2024 20:18:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806bd7ddsm2279696a91.40.2024.06.05.20.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 20:18:37 -0700 (PDT)
Message-ID: <58ba9ea7-cc45-47d4-a278-3777b496cb44@linaro.org>
Date: Wed, 5 Jun 2024 20:18:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] util/bufferiszero: Add simd acceleration for
 loongarch64
To: maobibo <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20240605093213.2191929-1-maobibo@loongson.cn>
 <20240605093213.2191929-3-maobibo@loongson.cn>
 <5d78d82d-a939-4103-8411-507b1a0372ac@linaro.org>
 <7b4c6909-40e8-def7-03e8-18a3303295f1@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7b4c6909-40e8-def7-03e8-18a3303295f1@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/5/24 19:30, maobibo wrote:
> 
> 
> On 2024/6/6 上午7:51, Richard Henderson wrote:
>> On 6/5/24 02:32, Bibo Mao wrote:
>>> Different gcc versions have different features, macro CONFIG_LSX_OPT
>>> and CONFIG_LASX_OPT is added here to detect whether gcc supports
>>> built-in lsx/lasx macro.
>>>
>>> Function buffer_zero_lsx() is added for 128bit simd fpu optimization,
>>> and function buffer_zero_lasx() is for 256bit simd fpu optimization.
>>>
>>> Loongarch gcc built-in lsx/lasx macro can be used only when compiler
>>> option -mlsx/-mlasx is added, and there is no separate compiler option
>>> for function only. So it is only in effect when qemu is compiled with
>>> parameter --extra-cflags="-mlasx"
>>>
>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>> ---
>>>   meson.build         |  11 +++++
>>>   util/bufferiszero.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 114 insertions(+)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 6386607144..29bc362d7a 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -2855,6 +2855,17 @@ config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
>>>       void foo(uint8x16_t *p) { *p = vaesmcq_u8(*p); }
>>>     '''))
>>> +# For Loongarch64, detect if LSX/LASX are available.
>>> + config_host_data.set('CONFIG_LSX_OPT', cc.compiles('''
>>> +    #include "lsxintrin.h"
>>> +    int foo(__m128i v) { return __lsx_bz_v(v); }
>>> +  '''))
>>> +
>>> +config_host_data.set('CONFIG_LASX_OPT', cc.compiles('''
>>> +    #include "lasxintrin.h"
>>> +    int foo(__m256i v) { return __lasx_xbz_v(v); }
>>> +  '''))
>>
>> Both of these are introduced by gcc 14 and llvm 18, so I'm not certain of the utility of 
>> separate tests.  We might simplify this with
>>
>>    config_host_data.set('CONFIG_LSX_LASX_INTRIN_H',
>>      cc.has_header('lsxintrin.h') && cc.has_header('lasxintrin.h'))
>>
>>
>> As you say, these headers require vector instructions to be enabled at compile-time 
>> rather than detecting them at runtime.  This is a point where the compilers could be 
>> improved to support __attribute__((target("xyz"))) and the builtins with that.  The i386 
>> port does this, for instance.
>>
>> In the meantime, it means that you don't need a runtime test.  Similar to aarch64 and 
>> the use of __ARM_NEON as a compile-time test for simd support.  Perhaps
>>
>> #elif defined(CONFIG_LSX_LASX_INTRIN_H) && \
>>        (defined(__loongarch_sx) || defined(__loongarch_asx))
>> # ifdef __loongarch_sx
>>    ...
>> # endif
>> # ifdef __loongarch_asx
>>    ...
>> # endif
> Sure, will do in this way.
> And also there is runtime check coming from hwcap, such this:
> 
> unsigned info = cpuinfo_init();
>    if (info & CPUINFO_LASX)

static biz_accel_fn const accel_table[] = {
     buffer_is_zero_int_ge256,
#ifdef __loongarch_sx
     buffer_is_zero_lsx,
#endif
#ifdef __loongarch_asx
     buffer_is_zero_lasx,
#endif
};

static unsigned best_accel(void)
{
#ifdef __loongarch_asx
     /* lasx may be index 1 or 2, but always last */
     return ARRAY_SIZE(accel_table) - 1;
#else
     /* lsx is always index 1 */
     return 1;
#endif
}


r~

