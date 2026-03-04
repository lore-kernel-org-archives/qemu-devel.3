Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67645EF8FF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxoC3-0002kE-MC; Wed, 04 Mar 2026 10:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxoBz-0002i7-BI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:31:19 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxoBx-0007Fx-Gz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:31:19 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso2450821f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772638276; x=1773243076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ysmRF9yv3lOY7o0FUAU0tglVZic911AQ64oFh2PLsI=;
 b=AXOeRUrIKTflZOCQ5/IVw39ww46zRxgsUY23ZEIhk8VRfWCYEIRoGYxDo0/pHEHirW
 j6j6bNOWULJYruEX8r9x1Q1hj/6V3QsZC+C1q3YMeKBOjrUqRs0yy/1kYS8+3YCytEaw
 5L+o6nKYp8Z6bx7M0wervhP4WtYaxQ8Tdti6+2pVTLkrbLcpoyyhOmP00lc1F9J9AHzf
 vIx+IUhBgIm/sQdx2tqcPgR9GVPU1l/8HeiE3YiR1nLI+R0T6NEQMy+L4b5FiSZNSshy
 wgapQnlZG3AXFiv+ctYFL4ffJBpJNfDDkfxQJifyIYGYiAORJYf4oeqwJJrMCyG7ENAY
 EHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772638276; x=1773243076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ysmRF9yv3lOY7o0FUAU0tglVZic911AQ64oFh2PLsI=;
 b=SJe3f7aDIrk6161PadjjBEuWp14HDcAxy32G82j7vxGMGtC3I3VFfN+Lts5vP4z7JJ
 FFJaH8MKfNy6m4yq2K23xPNLypuktF2JwTbtFuCKXla69+lvPHxRGOAkH9vRTcp177Th
 Rqj4DWa6+BHQqErot6ePlZyV8UoCn6PbGgW76jjcOZgMI2hgsTTK57Ff1Ovd3WcXoxnO
 NMA9npLuJTuiAAL0rQoupyzdxs3RqgDZw2BiKDduV4z9yQQFDQs7VKITXLgULueOWKbX
 sGkEaXJBJQHuan+50TDyHz4XcKS/3gvKQR8iWUAZsRw1vAVukwdpIB7dVgcFU0+eyt/F
 xWEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMIKufTxoe7aSQyn4OR1rm7uUYZAgtYCdhthdAqvG6Sg6QVgn56VupzzdWDnsxQxBkdVmX6MSyB7iZ@nongnu.org
X-Gm-Message-State: AOJu0YwlLzQuv63Nxtc3l8CdtdlmY99Z2/ygpRbkworWjxh3weiILSra
 XYrnknOiRfT/Lnqv3WgYE3sfSQpi4CSBAbDfiBNEs5+FG81PpTqD2/68naw/HCxnASQ=
X-Gm-Gg: ATEYQzzjQ/Pa+F7m45gm84cwe4Jhd0OvGUTEyhocDYSiqmbT+CmOisPSgvivHZS/nUL
 EIJ4LFt5VEVZSuXRNEbzIeGm+LqMq5rtPpFUfrJ3IBbz6z7MUgUgeQopNyxuaWsfsigWFb2M2/2
 TaOfdEYwd9xFqh9G8trlg1Ttgp3w5LQ/3nx+qW0my7JrV8FMz+YnT7eSGyTPtJSlhiPiHdNtBF9
 s3GJElmvLMBYGheWoPFNIZQAOD7O540iuWeHWtIObr0tzMSvO1VL1OHZRDavZXufCFoC1VHhz8f
 Mz0LJn5bULXLh5GeXE/iGsZExgOjyF/WFZ/N/kADg2hY7ic1w3EM+fJzZzbHb0t75NVWEtEkleJ
 KOaCdd23X6trAyC3cLuFMmEB/b7eUHvhCcDtozyIjIdfsXPStD/GTXJ6Xsd45kwSP5EIsyvUU2c
 UJYlEGJQbRMtd29n3dG9mpaXt2agzh40iOgjD3YZZ96oMzMeeq8zpjN+JEb4cbuAMcMA==
X-Received: by 2002:a05:6000:200e:b0:439:ac8f:5da5 with SMTP id
 ffacd0b85a97d-439c7f8f89dmr4942398f8f.8.1772638275851; 
 Wed, 04 Mar 2026 07:31:15 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b0549600sm29525291f8f.35.2026.03.04.07.31.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 07:31:15 -0800 (PST)
Message-ID: <977a9933-caf9-4fb0-823a-cd8503d5e25f@linaro.org>
Date: Wed, 4 Mar 2026 16:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] hppa: Restructure CPU Class heirarchy
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260303-hppa-c3600-v5-0-277bfe6b40b8@rev.ng>
 <20260303-hppa-c3600-v5-1-277bfe6b40b8@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303-hppa-c3600-v5-1-277bfe6b40b8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 3/3/26 17:11, Anton Johansson via qemu development wrote:
> Clarifies current CPU model names, assuming 32-bit HPPA runs a PA-7300LC
> whereas 64-bit runs a PA-8700.  The PA-8500 model is added, which will
> later be used by the A400 machine.  All CPU models are made into children
> of the now abstract TYPE_HPPA_CPU base class.
> 
> References to "hppa/hppa64" models in test cases are also updated.
> 
> Reviewed-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu-qom.h           |  8 +++++++-
>   hw/hppa/machine.c               | 21 +++++++++++++--------
>   linux-user/hppa/elfload.c       |  2 +-
>   target/hppa/cpu.c               | 25 ++++++++++++++++++++-----
>   tests/qtest/machine-none-test.c |  2 +-
>   5 files changed, 42 insertions(+), 16 deletions(-)


> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 714f3bbdaf..910a919923 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -207,7 +207,9 @@ static void hppa_cpu_initfn(Object *obj)
>   {
>       CPUHPPAState *env = cpu_env(CPU(obj));
>   
> -    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
> +    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA_CPU_PA_8500) ||
> +                   !!object_dynamic_cast(obj, TYPE_HPPA_CPU_PA_8700);

Don't we have an architectural bit to test? Does this scale? Could we
propagate in per-CPU_TYPE class_init handler?

> +
>   }


>   #ifndef CONFIG_USER_ONLY
> @@ -314,12 +321,20 @@ static const TypeInfo hppa_cpu_type_infos[] = {
>           .instance_size = sizeof(HPPACPU),
>           .instance_align = __alignof(HPPACPU),
>           .instance_init = hppa_cpu_initfn,
> -        .abstract = false,
> +        .abstract = true,
>           .class_size = sizeof(HPPACPUClass),
>           .class_init = hppa_cpu_class_init,
>       },
>       {
> -        .name = TYPE_HPPA64_CPU,
> +        .name = TYPE_HPPA_CPU_PA_7300LC,
> +        .parent = TYPE_HPPA_CPU,
> +    },
> +    {
> +        .name = TYPE_HPPA_CPU_PA_8500,
> +        .parent = TYPE_HPPA_CPU,
> +    },
> +    {
> +        .name = TYPE_HPPA_CPU_PA_8700,
>           .parent = TYPE_HPPA_CPU,
>       },
>   };

