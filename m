Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74049C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmKk-0003gq-AF; Wed, 24 Jan 2024 18:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmKc-0003f3-7A
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:06:54 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmKY-0008EC-VF
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:06:53 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29041136f73so3236613a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137609; x=1706742409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZ1IRVJ+J8fP3n+3NMnre9iiPDxgX73g7q2tr64l6fc=;
 b=vC0+llXXQGDmzdG185111G/tKn7h471iMPtNxXs2nx8mqHMTjcWI2VpAkms2bbq9zo
 K282j7CMhric7/vVU/nLSNkGS0qM1EnUvb0fwo5upqvStSX/RFJ7d+mBwFLrxyY5SOvL
 w2wQB6m/Fxh8Gb31Er9M2ccwfSSE3K46PiUMCnMfaLjA8dt8aSUAf9197mpEgMOML1rI
 LJU8lNlkI9KxBiC7CO8aY9EJYW9XQEeEdyfyq2yHvdOWcz+pNxhR6DiHZw10D+7OGkjo
 uaspO5J5Ojk6WOxo6RdesZoxFl/1+atS5bB129L9BjVJVMWU++K8urcsqs3hhSaHNt39
 Z9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137609; x=1706742409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZ1IRVJ+J8fP3n+3NMnre9iiPDxgX73g7q2tr64l6fc=;
 b=GhwVoXdSQ3t4TjuLQ+HGWdQL6viTwh/XeGd6lPsn2nblIwrD+gQxPQrT2YaUtHflbK
 2HLInD5JU7JpsQFoB9i/7UdhQa9iZrTs9jQLDQxziE5SYJsUlwhoMlxoE84pHy4WdD5k
 zpUBb8Zkc32MsfDotsCx2FpIrI8ZG1Yfqky4BFRwPLTRhf819VYcquaujfwGCP0OoLvP
 qpEhcqR6dRZ7psz6k6P2xxq68oAPiz8CspFTrYBWGICJY5dbqrXqWKh9t51sifGxRQKk
 eMo8odVH641p9+1NHASP9gSPERU3QOIeQ+w/O/Tg7Pqt35hKKnAb4weEEhFMzdvrcWrS
 PM3g==
X-Gm-Message-State: AOJu0Ywq0hQSb8DaM6V7Ma5JTs3hCDjqY8zzUqINPP+HmMBhvuGt6Q+z
 QcqkMYjrMk8LrslYSqrsQBeBbr78sQWjTZgQZArIsVEDxxsPeQpLYBcdpOqqSLo=
X-Google-Smtp-Source: AGHT+IGOV5cbemDd/NrGy4NqliB/79RdGRwB09f/xS/q+roN7SE5EM4ZbG41tuWPO2z/DryBZvA6Yw==
X-Received: by 2002:a17:90a:ea05:b0:28b:86a1:b8d0 with SMTP id
 w5-20020a17090aea0500b0028b86a1b8d0mr247470pjy.58.1706137609554; 
 Wed, 24 Jan 2024 15:06:49 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a17090a2bc200b0028be1050020sm180008pje.29.2024.01.24.15.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:06:49 -0800 (PST)
Message-ID: <e9da4961-5d46-4cf3-9736-185e913b2c74@linaro.org>
Date: Thu, 25 Jan 2024 09:06:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/arm/highbank: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123222508.13826-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> Restrict MachineClass::valid_cpu_types[] to the single
> valid CPU types.
> 
> Instead of ignoring invalid CPU type requested by the user:
> 
>    $ qemu-system-arm -M midway -cpu cortex-a7 -S -monitor stdio
>    QEMU 8.2.50 monitor - type 'help' for more information
>    (qemu) info qom-tree
>    /machine (midway-machine)
>      /cpu[0] (cortex-a15-arm-cpu)
>      ...
> 
> we now display an error:
> 
>    $ qemu-system-arm -M midway -cpu cortex-a7
>    qemu-system-arm: Invalid CPU model: cortex-a7
>    The only valid type is: cortex-a15
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/highbank.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

