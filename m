Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00164C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKKi-0007TE-6F; Mon, 28 Jul 2025 05:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKKf-0007P5-Tn
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:39:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKKe-0004qH-18
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:39:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso2136378f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753695581; x=1754300381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YOd4RDJ0CoJqioFxZZeW44OV/lyJoP9UfgmcjzOt9M0=;
 b=Dk/qSuoR6x7hhBjRj4k0EAivAgR4d65Ojz704EvzIC1Q0cky9TEutrJi0AAp1uoCWy
 VSWZzySwQ4Btd2Vm7spRiyEXHK7zHGPII4ZrGsW+4PooNi+FelMhBss7rnxBx1pkiL4h
 CUTOADJ+75C0E4oJ6CUXzey0lout+9a+FBHY2zN3/yvigK/cwxADfkmf3+XsJ6p5vmVu
 5xI5cXbZAiapI4AghI8tOxuR4XdfTjwC9ifxnfRidJHx8LyM/6SB4YQfbpa6+D9iFdim
 8SsggEFsy0f01s7OKu06FkOVnMf0MTPBy2WmnLp/mHTL7KID7J/I4HHLCIn7sYuhW7lv
 QGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753695581; x=1754300381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YOd4RDJ0CoJqioFxZZeW44OV/lyJoP9UfgmcjzOt9M0=;
 b=KPbsqhvYaP8RPtLK0pqiqVwfmbeCBZjsyMSFR13pPtWR1o55pr2H4eVQqWxfqbkfky
 C8C/91VWWBo4qcRitscwcs2mf+9x0KDMnG/vlfOgn7qt9Q2Xq5gbavdRCqvR7V1P6Lv1
 xfmT2IF3cRA2niwL03l2uF2Xx0c9GRftbcW44JQ60eblRFrV4akj5U72/nOwXhb81NgO
 vsNXetoXwguxJh5+/4BAuiAL9+kurGErTyURmyeI3vZF2ZWunKJ6uLbbiKj8dWpHNct1
 PisKuVzx0WdI8KiJJs4dligqDyVr9Kx0GwD7BfVhSSWSV5JvDMWrGDSZLe+iDcTlkryK
 cIJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW00b3TCmjb9u2ARO1K6U3PZHTpJ4AgsNFY5SmffWXkLngjE98UauFEt0uTViKfvCBbSSP1U++61DRm@nongnu.org
X-Gm-Message-State: AOJu0Yxj/+5gMQOsIK05IJrcylWEFSzuFkbRwY9aumL79lyQVplb4L5I
 X6E/JF8/M6fg6sd/Ks81Heehl3vc+n8a3rsqRshj9NMXvkGsb2HsKDmBKhKKBIEgvns=
X-Gm-Gg: ASbGnct87yGinPccKLE+M0EPBc+Pbw6YlizZaK6uw3Q4QOMXpS8PPOEtuds+/e4hMs7
 OpPv88SdHKZvx1NxSqhoQ5hxvJeBWTfiDCxyzUISEo9KHN4bz7J0QnZv0DwTEerJrSBCgTY3Cny
 nqFwN3eFvOkVxiDFFDJTr1ng00s7LazWt2g2EOog8YW+8d1bvig/b+Jx1oozEE5O+ejo0HtI3QZ
 j4RzOy4HMwbQoOdM5c6MM2LsX+xnswbe4lshrcU7icr/tAK2fXsP/2zaANT5yWRSshOFsfN5cdp
 zYd4V2BlAf/AVfh3mIlRySl1H8IAeWofWookSAKAe3yYUpffnzQl2nfQ2fjrD/tFesekbSqzsUd
 VmR/N7r8+76RXXH42BvpunnG2ZEqcM4mqflW3nVdo50rTG4IcslGHXF9CGyTq9crfcA==
X-Google-Smtp-Source: AGHT+IGKhjPUsU8jnQgjjdTsQIS9q5jF3dy+Dy6KmswZAj45qr6AFATRbfEfMH3b+6q+FvSsqIO4Uw==
X-Received: by 2002:a5d:64e4:0:b0:3a6:d967:380c with SMTP id
 ffacd0b85a97d-3b77663e90bmr8073246f8f.36.1753695580893; 
 Mon, 28 Jul 2025 02:39:40 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4dbdsm153307095e9.25.2025.07.28.02.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 02:39:40 -0700 (PDT)
Message-ID: <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
Date: Mon, 28 Jul 2025 11:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/7/25 22:19, Pierrick Bouvier wrote:
> Move those files to hw/arm, as they depend on arm target code.
> 
> Pierrick Bouvier (3):
>    hw/arm/arm_gicv3_cpuif_common: move to hw/arm and compile only once
>    hw/arm/arm_gicv3_cpuif: move to hw/arm and compile only once
>    hw/arm/armv7m_nvic: move to hw/arm and compile only once
> 
>   hw/{intc => arm}/arm_gicv3_cpuif.c        |  2 +-
>   hw/{intc => arm}/arm_gicv3_cpuif_common.c |  2 +-
>   hw/{intc => arm}/armv7m_nvic.c            |  0

Alternatively add arm_common_ss in hw/intc/meson.build?

   arm_common_ss = ss.source_set()
   arm_common_ss.add(when: 'CONFIG_ARM_GIC',
                     if_true: files('arm_gicv3_cpuif_common.c'))
   arm_common_ss.add(when: 'CONFIG_ARM_GICV3',
                     if_true: files('arm_gicv3_cpuif.c'))
   arm_common_ss.add(when: 'CONFIG_ARM_V7M',
                     if_true: files('armv7m_nvic.c'))
   hw_common_arch += {'arm': arm_common_ss}

>   hw/arm/meson.build                        |  3 +
>   hw/arm/trace-events                       | 79 +++++++++++++++++++++++
>   hw/intc/meson.build                       |  3 -
>   hw/intc/trace-events                      | 79 -----------------------
>   7 files changed, 84 insertions(+), 84 deletions(-)
>   rename hw/{intc => arm}/arm_gicv3_cpuif.c (99%)
>   rename hw/{intc => arm}/arm_gicv3_cpuif_common.c (92%)
>   rename hw/{intc => arm}/armv7m_nvic.c (100%)
> 


