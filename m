Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B152CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 04:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5cag-0002nA-Hk; Mon, 06 Oct 2025 00:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5cae-0002mu-2S
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 00:12:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5cab-0004wq-VB
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 00:12:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so2608099f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 21:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759723963; x=1760328763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7TL2S4y4tBH1AYTrLDVwmbGtgIo2li3NtoPmqfxWBfQ=;
 b=p6WouMXmVPWMJt0uaIYo6dv1V+aI2EBXO/fWCC94mUWGmnMYU6xephYCUw4gFuTXej
 3/nXSobOva7pee3PnDjBpHKN53PpG1Xrub1Tm9FCvu8VGAXmsTAni7b2FAJlSHKSTQ8f
 ny8s7kfKFPeMIKZJV47V4TRX6zJDmslwTugMfYIx+tp/kmZCuRWUiEUt/7OsIXO/lCOM
 DMFeD5+b/44XLiis0opEFK3jH2y5KjC6VAFJK2L2Jf8OIx6hsFkm7mfttq3leR6Lyukj
 TVIFpHL2nQcK1mK+LoP5e7IcoiKC8IvDLXRsGNwUAbIELXxAZ3/Rm2wj/ilteLfG52d4
 K5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759723963; x=1760328763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7TL2S4y4tBH1AYTrLDVwmbGtgIo2li3NtoPmqfxWBfQ=;
 b=hacSS/c7qKM0y46UuGtfTA6m4t9eBXO4N91E90c+MRyqnGtsZNuNlFt9B0UtiLXLbC
 1QLKyPii1dEmh1VaneRvupbegyXp4Vu0y3k02bGU7w7tomMRvlpvkRcPoz26kBt6mx+N
 EFMSPIk3N9vnP4WGoDCdqSb2sO8JBFoirKmISTcy9sNuHBSfBL4iC8+bbjfxhJeIS90i
 2tFIFv8+Bv64vDJNeLX6Q+znppUea8ZMxFcqnCLeXkQE8TiCguGjiH0OCY7Z5ETKLvtI
 qq7Lj4MbO0nn1F/4D9vkfHnZ+76Zx/OTYBCGfh0mNbORTKBuVBR3X0stDcwUZnMZqPHA
 CnoA==
X-Gm-Message-State: AOJu0YzfbKhmDpm1X7kEVtPlmJaucxcDMNAPymVkDdfUbCAHzj/BKYww
 3ngpQ9B6RL7LK0kHwcS/W1eUERC7gFlL3CFQvBrGJarEfGTYJU1ZY5cXsJ5sbHw2UrshFJ7miX1
 by1gq9yPZog==
X-Gm-Gg: ASbGncvdrsKIUWJmeNP1Cl5CvdQkjjSz5Q4omS1V1AaVnC1vDVAx3zVQP079Lp4qzDS
 cIFKtWDOmZT37zy2t08KvU5c/FDIp0Ha0TnaTR8hkk1ErMXQIbFxqRiuj8CPAPskFiYc1LI1x/z
 brTWkZdRiMagMh5T3UCAmQ49aYok/Zdru0szy+oefYesCw/KhZPldoXHd/arxFaPeRIT8pEL7/I
 yePZkCWp7Wk0XQKX7wNESXOYlFtJX/KluY23kFLtW8ihkZIWDWRGZMduWLVzZrhg0z/XagidNH2
 AhBNSLiIWp0bWc4TGJ/OnXQNGRd1KfVSuB7U7KDipWcym0bkZFz0m0XgSL4NnXten1koF7ZV/II
 HyUIJMXeNCylZ/klcnFuIw71cMeRhVUGjCmUUl7NFBTC9G//5Ry4U7B1W9uG/8QYBjJmZPinufn
 CtaznUbGNYJCzJZC5lNQ==
X-Google-Smtp-Source: AGHT+IHZV0DGVaUFFaPFtQVuPHq2KDQfzU/Ec7UYX4RHRi/ByDFrehd4adXxQmkiq/TizARbrI/RaQ==
X-Received: by 2002:a5d:584c:0:b0:3f5:453:77e3 with SMTP id
 ffacd0b85a97d-4256713a129mr6016831f8f.6.1759723963633; 
 Sun, 05 Oct 2025 21:12:43 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72359e0asm143195045e9.12.2025.10.05.21.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Oct 2025 21:12:43 -0700 (PDT)
Message-ID: <d65a63ca-9c54-4855-979c-56b1c1b351a7@linaro.org>
Date: Mon, 6 Oct 2025 06:12:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/openrisc: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT32()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Stafford Horne <shorne@gmail.com>,
 qemu-trivial@nongnu.org
References: <20250925004855.59084-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925004855.59084-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

ping

On 25/9/25 02:48, Philippe Mathieu-Daudé wrote:
> Both OpenRISCTLBEntry fields are of uint32_t type. Use the
> appropriate VMSTATE_UINT32() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the OpenRISC targets are only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/or1k-*
>    configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
>    configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/machine.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
> index 081c706d02c..fa054e528bd 100644
> --- a/target/openrisc/machine.c
> +++ b/target/openrisc/machine.c
> @@ -26,8 +26,8 @@ static const VMStateDescription vmstate_tlb_entry = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
> -        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
> +        VMSTATE_UINT32(mr, OpenRISCTLBEntry),
> +        VMSTATE_UINT32(tr, OpenRISCTLBEntry),
>           VMSTATE_END_OF_LIST()
>       }
>   };


