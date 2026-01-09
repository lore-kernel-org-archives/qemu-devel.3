Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5C3D277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLU3-0004JH-P1; Fri, 09 Jan 2026 18:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLU1-0004J3-Hz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:01:29 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLTz-0002mq-Sx
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:01:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81f39438187so169102b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767999686; x=1768604486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=apmx6EgK3pQWmZ3IVfjf71CEiXe6w0QAAzRX6XLNMUc=;
 b=CCMWv+wKETzoSJoJVaR0splcS+bf6AJ3iywCJYgPoBOAu8N7xjI7/N+Lx8L68vrkO9
 yPYiGrDXADG7HguVNDPufzAZCV7IpYPRjQGMPGLNp65MROrK3A5o3bNTIOZjKBffv2Z+
 ehr/+/DHF8rv6Ajnd48myzvRlIz66CqlnVaAy0Edng96hl+VbitcGA/sQo5FSUW+Bdg1
 avi3tDMwP2ksZHnaws7BEQ1ZKLzSRMtFq4P0PzSApdhil1dG8hFfA5VaGRzlS1LGWylX
 Bic6lFNIwDiO2GgHyBMmxSDh6XrYyLGcTnNCHRttgoX55yJaH0BnscCb2vtxMj0SqAoI
 Ws0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767999686; x=1768604486;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=apmx6EgK3pQWmZ3IVfjf71CEiXe6w0QAAzRX6XLNMUc=;
 b=FjJxLxrDsi8q+hpWcdYm3c+4dEvolYRJoDDBQ9hPCzVsVoKAiDk9oH/ZHS2Di4peHY
 OGziq38+f4DKlHw7qsJ0TwvDyUNk3jyF5J4vVhV7ttSzpOk+LeMt9+pYE5hOmVCd3uqS
 MM9KzeZpg5rFZa5yCciH3qIJ02BSElwfTMdAktlsuuaf2IC/IaUgM2GZ1JRjOizT/rV2
 ycBKmBD+C6fv+KyUcLt/t9KZY+ZL7sfAp3/YHMbMsNiGlPM7/iC42lBZCQufdpkrKlQW
 Uxo6sfNr5DTt8bE2tJp2CSornkJlJwz8+lX1Kfev5byfMmGn1ViHqXK6xK8B060fbi9N
 oHMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR9260h9j8enW2dKsa06dtn6zu7fK5RqGwYP4/B5aTfAIK7HkZJrc4OqyXdAkjHvfk7EYFVv5R2+cS@nongnu.org
X-Gm-Message-State: AOJu0YwIxHUxzOR5TFy+eSSLnTs+9GVoQRKWE+JDCBy700h8+g0kPHZT
 HHskw6FH+3d40hDv4/aj5OmtjTxXClqQHJzXs9fQRYBOTF1PNKXePVi7+bTT3h2hza0=
X-Gm-Gg: AY/fxX6xOBndS+W0u+bf/aXjVqzLl3ycAF5lVW5UbJhnjz66rhgD/WtfHKstWJFEoKK
 ZpW3fGLMsXFZEO6K5JZ+IOONLIMLZxX8lSbiCw6JKqNk+ZHZKb2WzuZmUTTaECbPxxO00Kxj7yX
 VE13sTiGX1tFrkh7XeHMz9k4CF5ppy4C7T3olBddTmZvxzVF2nenGu5hRtbmEpWSEM8DMn3wgBC
 4++q4983re/VCpC0rdIo9A5WwL4AW+kfyWQJLxQFaQ/oka1OfCCpLzBwsAcDMJD0P360kJGZuDC
 W945NcMXGk8b+4BOmRO0we8gjnD6DvcPVg18xmyRZlHsfuuT/n7byaaBKIjTdhnkNwGwgPdpvre
 ATjzVJ0Yo64hBVDf4vf3RhcstkGge1d1U7paiuBdFNo0wz3Z7VdIFI48vsFBYzK1l0QL2bLMDPb
 jzsJPaNodGyfOg11fjoI3pyL15sEzqguNX4j8Y
X-Google-Smtp-Source: AGHT+IEFXnBAeYrrEz1hq9zZZS6hp+w7FhiGpOqn4ljl+vYVb2uYj04ZrbFxH9z+CfxsRi0ZrXH9mw==
X-Received: by 2002:a05:6a00:4c9a:b0:7e8:4398:b36e with SMTP id
 d2e1a72fcca58-81b7ffd148bmr8174387b3a.65.1767999685794; 
 Fri, 09 Jan 2026 15:01:25 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81efe4a95c7sm1110999b3a.37.2026.01.09.15.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:01:25 -0800 (PST)
Message-ID: <76745f45-3176-4371-9b91-1db1c7e6073f@linaro.org>
Date: Sat, 10 Jan 2026 10:01:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/29] target/arm/tcg/translate.c: remove TARGET_AARCH64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-29-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-29-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> We now need to stub aarch64_translator_ops. Those ops will never be
> called anyway for 32 bit target.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/stubs32.c   | 2 ++
>   target/arm/tcg/translate.c | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
> index c5a0bc61f47..ddb0610992b 100644
> --- a/target/arm/tcg/stubs32.c
> +++ b/target/arm/tcg/stubs32.c
> @@ -15,3 +15,5 @@ void a64_translate_init(void)
>   {
>       /* Don't initialize for 32 bits. Call site will be fixed later. */
>   }
> +
> +const TranslatorOps aarch64_translator_ops;

This is unused data.


> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 7128c633290..3cd05682ce8 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6863,11 +6863,9 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>       if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
>           ops = &thumb_translator_ops;
>       }
> -#ifdef TARGET_AARCH64
>       if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
>           ops = &aarch64_translator_ops;
>       }
> -#endif
>   
>       translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base);
>   }

Perhaps better with a function wrapper, making aarch64_translator_ops static.


void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
                             int *max_insns, vaddr pc, void *host_pc)
{
     DisasContext dc = { };
     translator_loop(cpu, tb, max_insns, pc, host_pc,
                     &aarch64_translator_ops, &dc.base);
}

void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc)
{
     CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);

     if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
         aarch64_translate_code(cpu, tb, max_insns, pc, host_pc);
     } else {
         DisasContext dc = { };
         translator_loop(cpu, tb, max_insns, pc, host_pc,
                         (EX_TBFLAG_AM32(tb_flags, THUMB)
                          ? &thumb_translator_ops
                          : &arm_translator_ops),
                         &dc.base);
     }
}

And then your stub file gets an assert for aarch64_translate_code.


r~

