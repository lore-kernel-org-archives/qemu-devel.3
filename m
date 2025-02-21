Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70274C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUF2-0003Qb-3X; Fri, 21 Feb 2025 09:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlUEy-0003QJ-5w
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:42:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlUEw-0006mw-Fu
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:42:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso13477305e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740148973; x=1740753773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gNShaiPzhqV/EFmCPv76FQIw/kjy+a6Uc1ZpouiZ2BY=;
 b=Y+6XdWpeDi97NiGmcpqCnPTaTy5dtVcWJu0NRxcgXvqx2xCi0A0cXbdP+1CkQ0bYbF
 c8lA7EotV3LMrLRNadZCIqMFgjqaVBA5CweG5YlD9r2iKVR9iBvwxBFHYqLQJuvaT1Tu
 YaQWereXwEUs8m1kM8JwyLmNzIaPbhH+Ot4aWguaWqO4Ioarkm7dZ24V4mMzBEtmOI2f
 FN4DlZRO8w+W2orP7z8o2lOEjbMn+i8YzNWLctKXl9fpm0BNcmiliIEHm0Njb1chBTeQ
 Vjur8xfnoQuH6Vs404qv3qjq4l1XY3tOt9z/mhpQ6x9d6cgnDHTCxLC4BdR24USqSZse
 KTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740148973; x=1740753773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gNShaiPzhqV/EFmCPv76FQIw/kjy+a6Uc1ZpouiZ2BY=;
 b=lv1ETP64Ci1hAObgJIECjzOMt30VkEqFd3yWnDxgW+7XnalARJKvQjr3z38WzowFsH
 jyWl0OzixEQbT2pea3G1TwAAIXyOkaP1TB8Rq80KyGMHIsg4D+CqNLDQeIQUB6aE+Vqf
 oFhU+tH4bZOeinEPRugREQ+P65UyvBnR7JlTjyqSZ9Irx4245UjeEWchdLWvY33+MMIx
 Lui6ZGoP6n8/1jDQASw/Fwa/Fwrmo4ZW7cAKgv6rBYeF6V35K8CUM3mpnSPmChJQNcDt
 3jyC7crycKya4FBWrCbQ9oHiMglSEDXPklwRknEJNpfBRZUmHgnxHLMfxpj2sbaPkl0O
 Xh/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXEtjT33MR7TgI+fFGTW2wXMGLRGay6DKfoiBShK3Gklf05/Y/5hdVXJ7slOm/tOh/e6yX0kAiQ2Rc@nongnu.org
X-Gm-Message-State: AOJu0Yy2k5l2MSG0aaTzgXlDkMy2Av+ECHHTZcL4GB8NLHIQEwJMLdTW
 cYPRcGNioAwvoqaIeMJ4hhjtr4od/du61OGLrWOuaUmegbVhsNrvmj9wlnXgmsc=
X-Gm-Gg: ASbGnctfPAgNhF5R4IONXif1Betm4Wc6np+F//A/no7dlWO1mOKn7EEEXlstCfhWNT+
 jn57b2+c2rWFNmqgaaYdRZhIm5pcqIYyRJNDJXnLjdu01Y3RzWYMaV4QQpfRRjJqtpmCywzX844
 nd4IWONtP+qd+wnhEbUDQAX+uc9UsW1+6hdvzt+O/xKlZZeY2LE+DCmaIZdyZ4GXaf0b3Vrzni+
 1gfrwQuGJjUp0xAXXC9CwBCfRFUmcbAqMNPw8mfbLODfqjV4iT9adPReuBiUAg/dtF26Xy1nDde
 o6jRqjV+PXfHbc/+7q1j930JnSdJbFjlhN73Uep6UFYNgo0BMNCaL79fHym0GPKtnCrjnQ==
X-Google-Smtp-Source: AGHT+IEHCdapK8P2YkP0+8+ScrfwfMp/hDdim0PCC/Ivk35owr5myltZ1yGmfbHojzB+EPhavX6fqw==
X-Received: by 2002:a05:600c:4f0f:b0:439:9bed:9cfd with SMTP id
 5b1f17b1804b1-439ae1e678bmr36002695e9.11.1740148972789; 
 Fri, 21 Feb 2025 06:42:52 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbbdsm23700723f8f.37.2025.02.21.06.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 06:42:52 -0800 (PST)
Message-ID: <fa37f960-ff1c-49d5-a0d3-06cd2f0421e5@linaro.org>
Date: Fri, 21 Feb 2025 15:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] fpu: Make targets specify floatx80 default Inf at
 runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> Currently we hardcode at compile time whether the floatx80 default
> Infinity value has the explicit integer bit set or not (x86 sets it;
> m68k does not).  To be able to compile softfloat once for all targets
> we'd like to move this setting to runtime.
> 
> Define a new FloatX80Behaviour enum which is a set of flags that
> define the target's floatx80 handling.  Initially we define just one
> flag, for whether the default Infinity has the Integer bit set or
> not, but we will expand this in future commits to cover the other
> floatx80 target specifics that we currently make compile-time
> settings.
> 
> Define a new function floatx80_default_inf() which returns the
> appropriate default Infinity value of the given sign, and use it in
> the code that was previously directly using the compile-time constant
> floatx80_infinity_{low,high} values when packing an infinity into a
> floatx80.
> 
> Since floatx80 is highly unlikely to be supported in any new
> architecture, and the existing code is generally written as "default
> to like x87, with an ifdef for m68k", we make the default value for
> the floatx80 behaviour flags be "what x87 does".  This means we only
> need to change the m68k target to specify the behaviour flags.
> 
> (Other users of floatx80 are the Arm NWFPE emulation, which is
> obsolete and probably not actually doing the right thing anyway, and
> the PPC xsrqpxp insn.  Making the default be "like x87" avoids our
> needing to review and test for behaviour changes there.)
> 
> We will clean up the remaining uses of the floatx80_infinity global
> constant in subsequent commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h | 12 ++++++++++++
>   include/fpu/softfloat-types.h   | 13 +++++++++++++
>   include/fpu/softfloat.h         |  1 +
>   fpu/softfloat.c                 |  7 +++----
>   target/m68k/cpu.c               |  6 ++++++
>   fpu/softfloat-specialize.c.inc  | 10 ++++++++++
>   6 files changed, 45 insertions(+), 4 deletions(-)


> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index f4fed9bfda9..b12ad2b42a9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -1860,7 +1860,8 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
>   
>       case float_class_inf:
>           /* x86 and m68k differ in the setting of the integer bit. */
> -        frac = floatx80_infinity_low;
> +        frac = s->floatx80_behaviour & floatx80_default_inf_int_bit_is_zero ?
> +            0 : (1ULL << 63);

Indent off, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


