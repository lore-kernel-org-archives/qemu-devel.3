Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061B8C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmfL-0005Dj-UT; Tue, 30 Jan 2024 06:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmfK-0005AZ-Ka
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:52:34 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmfJ-0000Lb-2y
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:52:34 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a359446b57dso288432666b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706615551; x=1707220351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8HLIQQPmg6yO2wkf1cfqMKx5WiKcA+VI6/DWk59FUWg=;
 b=Y35JQPeM0i7y+ex3zRwTozMV9WJO1T6F1nMjfV6zQrRjQvwcXCfqmj7cemNaIZLvD8
 bIZV6S9jlZVUOmdLZ2kWnOz1VhUqDDeMlgmbJzzp8lr/SxKr2wn3+6rENsmV4F2jqQ34
 xgzQI2FxmOPF5JIdE6+yJygMrPzmh8rtO5pMzMOC6LWxkXpW+ocDBh7Hxmq6CHSmrr90
 EQOQDN2cYSPmSe3K0Zf6k1S1oyOj8gq1miyHF6b7LlfOx+aC58k0svdQefPgB20x/k0g
 inkxkB2N6EBGlFYorxW8NiD6jonrqNiSEMWgjgxt2W/D8EaTv5oJ5TS4Q8Pv1j8M2fX7
 SPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706615551; x=1707220351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8HLIQQPmg6yO2wkf1cfqMKx5WiKcA+VI6/DWk59FUWg=;
 b=gA8ehsYWxAHZASowOXw1qph5cg4dHSYJMg3zf2JLF1ajQdkALn4Qgc5ilAqegfFdP3
 fFufGmVJpjKm/m7hyu+3Ow63DpRMyfl2pT56vzgGVogMzInkn5gjMy3vWFP+JQErOCpb
 YIJ3Vg4UoMEVDAArm7Zn/Ofpv31X2b58FVM050Vn+FrWpVal7doHfF0D6g1f5CdZIWJZ
 kF/dMc27ibR8eR93p6KHRyE9mNMuwcwlvJcCAJnxD8fecpUlW4gCnKQHmCA8cf7pKRof
 t2QKP2O68YfhjJtssGC7kVPeNtrozWyK4YHw8noG4tHIRuoY/cSp1wcdEDJJgnYmtoN4
 tEXg==
X-Gm-Message-State: AOJu0YywHXI0ISqO0OHxfkLYA/3MpbLbT0Dqb8nJsIhOV9kgYA79s2bo
 Z9ARuWCbRk8g9pi2CSA8mAskN5fyb2zLPGQqtgtQwk/k/Eme6cRwabUIfpxgGes=
X-Google-Smtp-Source: AGHT+IF7lov476QgHN3pZ69W8EVDvycBxOy3JXvGQs4eXH0Zmbgq62Bt6yI/ALZ3m59objRFT+tUww==
X-Received: by 2002:a17:906:9904:b0:a2f:2867:dabe with SMTP id
 zl4-20020a170906990400b00a2f2867dabemr6106795ejb.1.1706615551362; 
 Tue, 30 Jan 2024 03:52:31 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 hd10-20020a170907968a00b00a35cd148c7esm1872893ejc.212.2024.01.30.03.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:52:30 -0800 (PST)
Message-ID: <cbc72601-31c8-456f-886b-641d746499c8@linaro.org>
Date: Tue, 30 Jan 2024 12:52:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] leon3: implement multiprocessor
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-7-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-7-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 16/1/24 14:02, Clément Chigot wrote:
> This allows to register more than one CPU on the leon3_generic machine.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/sparc/leon3.c | 106 +++++++++++++++++++++++++++++++++--------------
>   1 file changed, 74 insertions(+), 32 deletions(-)


> +static void leon3_start_cpu(void *opaque, int n, int level)
> +{
> +    CPUState *cs = CPU(opaque);
> +
> +    if (level) {
> +        async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);
> +    }


What about instead:

     assert(level == 1);
     async_run_on_cpu(cs, leon3_start_cpu_async_work, RUN_ON_CPU_NULL);

since per patch #3:

  +    /*
  +     * Transitionning from 0 to 1 starts the CPUs. The opposite can't
  +     * happen.
  +     */

> +}


