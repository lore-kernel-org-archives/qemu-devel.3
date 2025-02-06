Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76172C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Tr-00014H-6p; Thu, 06 Feb 2025 13:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6TY-0000aI-MT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:19:49 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6TV-0006uu-Pp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:19:44 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385dece873cso573851f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865978; x=1739470778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rLMKHfpwsmRq9cvK/Unfd2Atjehb+xWOik9/MUFQQbw=;
 b=vp4SXV++8vmekOwKO32h5DTjIf+HIbah9BXCwbUeShvYbP4NwsVWX0AT0CuADCMBkb
 6sCzEsXuM3WvGa+VC0RdzfCbJHywXNOK/YnjtdTYS+qH+DyGafP28NktrU9MjSYIc4hI
 gUMX+joAIPTqTMSRwrSmHYp0Wf/Zwy2zNJ10tweV6q33P5VsFiM85cnRSqJxxF7rkm3y
 NH5p25wx5F7XjnPP7GA05TPdfQ0sEpl+kzj6Fsy1wWyanlrR+FH/U7lxkIT1/waC4/YJ
 pH0RaAcB7yVOi7v76JQO15Zso0VA5+fz1z2Uv3nsRon9X2IaE2xZO2abjrx6phtMZp6w
 IEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865978; x=1739470778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLMKHfpwsmRq9cvK/Unfd2Atjehb+xWOik9/MUFQQbw=;
 b=DdUqcmPImpf7NCJVIRcaGkUDXgpDTrgnoID153KJG7+FrglSy7h4UGCMYQvEBSsmMO
 VJV/AjUxjGZ/4X3AcEuUekn0JSVfb7tbXXGAD8hmfy9QxsvhoSuZmiyhjycnGMTlz0FJ
 ZwgsyOmGwHOSQnVH+JVeHFTnyY9FDq3GFPxicBzNYY0eiiQltahYALRjgn+IXatWvEaf
 0Q7D5RrsjuQ/WEKUpfPHe+lcPDumaVNO/ygHj6f2bxXVxvJ4MprTA3VooFo+H92Wgx2F
 6p5MlE91oifKjby567EMtdRmi4pLzsx7+41+rZ6KeziUv4vkWlAazokODLfz43OmEO1r
 a8dA==
X-Gm-Message-State: AOJu0YyObKPHoDQklHXCrCPB+L8M9rwE9O8GFUjM4953zUbJLIZI8iX0
 dOEImULXUS34ZqNsarWSKUyygtQ6CR8p2xlXDRsL68344V3sQbTHi9uRUuOEgyE2nlxkL/IaPrV
 KXZI=
X-Gm-Gg: ASbGncuDJtSHFImNNN1PpUyvSaiFUVbfrEBCSjgTGE8hm4kGdBtaNcEpDuracGdJU1c
 n/OAiNadtdhRoBgZKriuTKLOHdADvSeVilEJBU7TTPYTl+kW0i4jZCeRyoMuMRN/bfRWXZX9kX9
 VTiILN4mzwLFE+y/jJszCcF+DhECr3AnXxlirN4EDXhpMIRAC3mhwKYOax6OfRC7Mdq+CHCRQPr
 ZsgERZnuVtcq0obY/TSEIA2f3CP58y6pnEGMWmRJCURCqwmpk0/2s4M0pI7Rhuyxh6JOR2PKj7R
 ZxWrDY7NTltuQ1Q/ssJZd12FyL4x5PYqAHUxpBgq2l4I9PQdmUd5sA4G/qA=
X-Google-Smtp-Source: AGHT+IEX9XgRQKxCwwoo+fjKGwF6p4g6vZiIw0RmtERh0y0RhN08POvBePfkazta5gkMmeyikgSoSg==
X-Received: by 2002:a05:6000:1865:b0:38c:5fbf:10d6 with SMTP id
 ffacd0b85a97d-38dc90e19e9mr8592f8f.7.1738865978389; 
 Thu, 06 Feb 2025 10:19:38 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd35bd6sm2317204f8f.22.2025.02.06.10.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 10:19:37 -0800 (PST)
Message-ID: <5574afe4-191b-454f-bbd2-cd7b26a0d581@linaro.org>
Date: Thu, 6 Feb 2025 19:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] MAINTAINERS: Unify Alistair's professional email
 address
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250206181827.41557-1-philmd@linaro.org>
 <20250206181827.41557-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206181827.41557-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 6/2/25 19:18, Philippe Mathieu-Daudé wrote:
> Alistair's email is typed differently, so the get_maintainer.pl
> script add it twice :) Unify to reduce traffic.
> 
>    $ git grep -h 'Alistair Francis' -- MAINTAINERS | sort -u
>    M: Alistair Francis <Alistair.Francis@wdc.com>
>    M: Alistair Francis <alistair.francis@wdc.com>
>    M: Alistair Francis <alistair@alistair23.me>
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cf37fce7b5..b7ac1519ee3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -318,7 +318,7 @@ F: tests/functional/test_ppc_74xx.py
>   
>   RISC-V TCG CPUs
>   M: Palmer Dabbelt <palmer@dabbelt.com>
> -M: Alistair Francis <alistair.francis@wdc.com>
> +M: alistair.francis <alistair.francis@wdc.com>

Grr this isn't the version I wanted to post, sorry for the noise...


