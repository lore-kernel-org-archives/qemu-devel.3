Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AFBFF4931
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 02:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w72Se-0007bE-A9; Sun, 29 Mar 2026 22:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w72Sd-0007aL-BJ
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 22:34:39 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w72Sb-0002Xe-IC
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 22:34:39 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-354bc7c2c46so2274596a91.0
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 19:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774838075; x=1775442875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pytuaqpZSS2QZ94hZSYd2nnaT+jk/UNtp4eSjS8Lv6U=;
 b=sP21zbR4wT4NcMrMq5eqNf0KXuiNlJuyn2aY46jZ/gIIi/vrZRxPV0ybRN8AXXAKmh
 63Udwff8Sp0kW57pPrBKhBRCFr9NTQMG118hqXDhWBza5x17+Z10nrwG23OvU6sxQlQb
 6Y+lkKgnBh/D2+QskJ2pYh9Iidck5t3CpLw3g++HGYy0EvoZn4dJ4UYsHCq8WxKsI6Yk
 m2W5ujO0pjs8dDK986Lb88Pqr2HdM/cGo2Ery80Hq108u6iReQXbIPUC6ccRWWmjhhPa
 IyhnLcEqR48SevuzIM7NujACTbd9F9dWn+MA888MW94hJ7sr0gcnqvK0lxhzUBB/DrZu
 ISog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774838075; x=1775442875;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pytuaqpZSS2QZ94hZSYd2nnaT+jk/UNtp4eSjS8Lv6U=;
 b=lNWBFj5K61QYo8zVouyvf6NozOk8fRmGjyoIAxGOOVgwoZjePutT+iQG46FuhNA88R
 no5Exc10TWmakFKT6VxaYzfYxSq/U4JwxM4sPVa85+Hy+wVHw3tMceXtGR4ZRrmFWmlw
 HPm+6OYZSPm6QS2e/a3g48OoSyGTiCeYgaWOPKCv8Os5p/Ab73JCwGJxC1GdGKUI/ic1
 an2A+1WdKt4qhe2WMR68xp55y/H/js4qgdWLlsZHKVPX0vBVUQCkH3tDRRrT4rzeJR90
 urJxOeWv0tJompNRD7UKNY+029hEWtlgXuugjPuvEhoDuoBzvix6OcmvlYGOuZgNX+bD
 wdSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBbTTShFty1N3s0crWdYaUKwEF3TOzRRt8LtSHxBR6gM/aeFPUPMnYVQ4QoOILlFE3xoKQt+vAGgNO@nongnu.org
X-Gm-Message-State: AOJu0YzF21sFaKUdpdXZPQajkoDV+441+8dBXvOgG5TwdhsZc9UCOzqX
 /vyG+HH13M5CuUAD0kCsGql6HoJ7vRE6nScS4fte7yzn4k4PsHOqJJQwSt7vU81grS8=
X-Gm-Gg: ATEYQzzHxjN8UQEgM9XqF17LtGhaH5ErtD244cb3wrSmZD9hYoNgO5vDG+tl79/Prsf
 0kHK10SLtToCdMWsEibHdwaKqrVJtPO/zhA1LAHkeCZARszjKcpj1XYRJmhfTP5WmiJv7Lr7naE
 RCkWxq3bl8cwe5rR1chGr4pcP5RFOpZqOGPsrATl3Q8yIoc0q2cYzEqpxAVbshg1nceWGojxdwv
 DBteC2fj91PqPSRnNl07OePbI4b5hOz2vex2c0CVPZj0N8JTrizAeC+O6xLiS86h4Cg9zmk3ArS
 84OTglMnbQe0Ih7pS22xLAKDW2gfHvFwCvCom9aeMjI5kcEtkmrCbnoXNaZBk4Tex+hw/X3FwmY
 RSq0WRL3/amtJC2ij+HZ8GiVJE9i99grhDE29jDAileQ2+mLoI6OxKrZtouY+F3/t9g4LGdoFNQ
 a6aZgDH5NxlEHrdowgT6qTwq1UFUDaXqkk28ZC2fvm0ZlUFU9NM8PSoUsnt9maCGWURL1Y
X-Received: by 2002:a17:90b:3d4e:b0:359:f0e1:f8c9 with SMTP id
 98e67ed59e1d1-35c2ff50663mr10821258a91.6.1774838075474; 
 Sun, 29 Mar 2026 19:34:35 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35d9caadaacsm1843601a91.4.2026.03.29.19.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 19:34:34 -0700 (PDT)
Message-ID: <1c34141c-7b26-4e15-885e-27c15382ac07@linaro.org>
Date: Sun, 29 Mar 2026 19:34:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-6-pierrick.bouvier@linaro.org>
 <b6895297-c24b-4605-8d2a-a8566dfd3604@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <b6895297-c24b-4605-8d2a-a8566dfd3604@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/29/26 6:09 PM, Richard Henderson wrote:
> On 3/28/26 02:50, Pierrick Bouvier wrote:
>> Generated decode files must be duplicated between user and system, as
>> they are generated in private folders per libs, and can't be included
>> otherwise, as meson does not give control on output folder.
>> Indeed, meson generator is a different approach than custom_target, and
>> this is a limitation by design.
>>
>> They were already duplicated between arch variants anyway, so nothing
>> new here.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/meson.build | 8 ++++++--
>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
>> index 3e96c77df73..46bf4a6d76b 100644
>> --- a/target/arm/tcg/meson.build
>> +++ b/target/arm/tcg/meson.build
>> @@ -30,7 +30,6 @@ arm_ss.add(files(
>>      'translate-m-nocp.c',
>>      'translate-mve.c',
>>      'translate-neon.c',
>> -  'translate-vfp.c',
>>      'm_helper.c',
>>      'mve_helper.c',
>>      'op_helper.c',
>> @@ -60,7 +59,10 @@ arm_common_ss.add(files(
>>      'crypto_helper.c',
>>    ))
>>    
>> -arm_common_system_ss.add(files(
>> +arm_common_system_ss.add(
>> +  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
>> +  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
> 
> How are you not removing the other decodetree invocations at the top of the file?
>

They are still needed for user binaries.
As explained in commit message, we don't have control in which folder 
those .c.inc are produced, so we have to duplicate them to make them 
visible for system_common code. Since they are not proper compilation 
units but templated C, we don't really have a choice here.

The only alternative, if you prefer it, is to remove them from gen_a32 
array, and add them to arm_user_ss. In all cases, duplication is still 
needed.

Pierrick

