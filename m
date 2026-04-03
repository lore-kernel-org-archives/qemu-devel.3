Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FC0E88D63
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8lpD-0002xl-BW; Fri, 03 Apr 2026 17:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8lpC-0002wO-6w
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:13:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8lpA-0002zz-La
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:13:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b2494440f3so8069855ad.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775250783; x=1775855583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YlM81UClSODC3PUGwgTmzGQSdH3/mRuoDdQN+XtCFbU=;
 b=QZ9wvE98mc246nLP271+4mAycqe14d0oO1ELWKvoYhT6DW9xAXGsWmSfaELb1QAvxF
 DEltaQRxOhNJc9eZzzN2uBCgVu1Vjsp8Uo5GCoy3IGWR0uD0iJ/OZNYbVD/nRd1qub27
 RRK09bbcpEe+KYnQjAla44UTZ9xqxS+B5697LEYk1HYirsCCI7MZdAwDH5Jl8t5kZ1yv
 DF7UizXdqO8Axd1KhRmm8DnFY8iCOXSnE92nnRQJzHl/tFGA9ZbvOGCult+r1wyF8Eu1
 Or3SHQqoHEn4LfJiz0jl6eQ/4KM5HmV5KSHtIf0NhYEa9zPzs4cDe+FxfntET67joxsf
 lK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775250783; x=1775855583;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlM81UClSODC3PUGwgTmzGQSdH3/mRuoDdQN+XtCFbU=;
 b=r184+r/Qnijw7Na2HyX2L778IfaA9fQGdN4eo3/w96iswVSCHZQ4x7ALYXk4B4j4ls
 qVk6MVwAVC6MfxUDQu7ec5S138XTvLCsrqV0GY3o4e14oaso8gOFO7o4WSHEFYaYKQhm
 xzT409wpTfpcDx/BCTVY4vr/d6vDQLzsW6JsOHlnDNjmlbld/bcMwIeUeGTkaXVdQs+X
 kZqSjWyCIGDHKuYbXKZ1XoRuxEeFJzExiFvaz+stlwQWIyEygararP8rDRFW6AsNIkAr
 6zWEw6URsRR1WoAyZ0xB7rP8i4N6XYwy5FLvDbstNdYhyExlqyc43e7WvNqf/ex7uHlj
 dhCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzC/Onjtup9Wv5kiFvNjAqIMxzgknBTpxk8kf6xjE+JiKQFz75QOXGfkVkTgNfCoVVHGzjU78NDlgO@nongnu.org
X-Gm-Message-State: AOJu0YxyJxwtpr8sd2loUvL7kNl/oj/4WQn/inxI1JEccu9P8AFIUkHG
 /RaT+jb6UCXg7IW21lUEdretff3eEPKXXmESlKMQCv1UqlQzzkgE8lZ6mzh+NY+t5Io=
X-Gm-Gg: AeBDiesu0UCvOfGc43FNsROsHw4LzHbeU9/yWJO+IGr/mGL8kf+ATG0hpod1zoQ52mq
 l3/CDQnpASHsEi1Qe8eQATTvN7SqaVKW8Z91qf0DKUZ7Qxr27mBVf8POircSpwRphIUXSnl4RZ6
 wkquJhkWLJu6h0ozWPR+LMRtjpftU40YZ17joH2zUyZHxwY1k7YseB5pCp+knX5k/vBrLBVuSWb
 uOxa+5CDFTwzd140aZRKCIXfGLOIVKO4fnqx3vJwiJvjohp2yFdK4hT0TQYg1hgzrPcV3/qavyE
 Acq8rpD3DIxbfE++N1dt8PuRgy7YC3bul7o1OWfFqMIrjfhOOAI4uyoskYEmDhyzLK96eea0Lfx
 ZmjrwQgG29vNteUPiKYFZH+YwNqdYpWDSK+fYrJRrMNecJLiTvxoeS0aMbBD9I4yt/eAuikI+Aq
 /qqt6IKMhykK/d4K8dqFWesKSbnFWmaJg9/dliP9g/TaXntJkFprTCFJnChwqbnXYPAKI=
X-Received: by 2002:a17:903:944:b0:2b2:6df1:111d with SMTP id
 d9443c01a7336-2b2816d82c0mr45812485ad.21.1775250783198; 
 Fri, 03 Apr 2026 14:13:03 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472ddd0sm68126615ad.4.2026.04.03.14.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:13:02 -0700 (PDT)
Message-ID: <529ccb22-10f9-41e0-b567-0ddc72822bb9@linaro.org>
Date: Sat, 4 Apr 2026 07:12:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/12] target/arm/tcg/translate-m-nocp.c: make
 compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
 <20260401192057.1182724-9-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401192057.1182724-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/2/26 05:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


> 
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 89c3b476822..70beec7a6c9 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -18,8 +18,9 @@ neon_d = [
>   
>   mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
>   
> +m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
> +
>   gen_a32 = [
> -  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
>     decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
>     decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
>     decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
> @@ -34,7 +35,6 @@ arm_ss.add(files(
>     'cpu32.c',
>     'gengvec.c',
>     'translate.c',
> -  'translate-m-nocp.c',
>     'm_helper.c',
>     'mve_helper.c',
>     'op_helper.c',
> @@ -65,6 +65,7 @@ arm_common_ss.add(files(
>   ))
>   
>   arm_common_system_ss.add(
> +  m_nocp_d,
>     mve_d,
>     neon_d,
>     vfp_d,
> @@ -76,6 +77,7 @@ arm_common_system_ss.add(
>     'psci.c',
>     'tlb_helper.c',
>     'tlb-insns.c',
> +  'translate-m-nocp.c',
>     'translate-mve.c',
>     'translate-neon.c',
>     'translate-vfp.c',
> @@ -83,6 +85,7 @@ arm_common_system_ss.add(
>     'vfp_helper.c',
>   ))
>   arm_user_ss.add(
> +  m_nocp_d,
>     mve_d,
>     neon_d,
>     vfp_d,
> @@ -91,6 +94,7 @@ arm_user_ss.add(
>     'hflags.c',
>     'neon_helper.c',
>     'tlb_helper.c',
> +  'translate-m-nocp.c',
>     'translate-mve.c',
>     'translate-neon.c',
>     'translate-vfp.c',


