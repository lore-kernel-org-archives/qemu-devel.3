Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83E9C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcaF-0005bx-EE; Thu, 29 Feb 2024 04:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfcaD-0005ar-Ko
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:20:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfcaB-0000Al-FP
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:20:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412b7bb0bd3so3573355e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709198401; x=1709803201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z1z1DBHFDIZJTJlOaTNzPF21iI9pevQLCi2nGSefCHQ=;
 b=Em79LiBuITesJkuHCPTOGXNAA8yig2mW26Jf5lD5MOXLRxuTvJHQ5Qvvq/Gawg2wO+
 giPTCWtXNDX+1OEAi2hsGf3pVI1kf8De6HwmmDpTxOd1ycEwL7Dg2rQeUjcoubod2b22
 +lyrRkB32wkPKXI1ntVgXZg3pUBcnYzr9QVPTjfAkAAVKQU8bX8IEBB9l1nnCqDbgXZl
 J2moppANlOErpZsr4pIqMN9lqUfFQAV3kA3hILCfLIeURrimTpkryyltyTYV/ymry6pt
 srNyPPyHUGITD0VuUcbsU2XFxD+Dqt2GQDLPpz+cbqKgk86xPOxmnEeJMFAsj9dROGmA
 ZUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709198401; x=1709803201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z1z1DBHFDIZJTJlOaTNzPF21iI9pevQLCi2nGSefCHQ=;
 b=a9Wz52PxHWg7b7XyQlZW+0q7yAIxwY9D17pml8VxWlmBhfjCbiA2gkO6UbiNgSyDzU
 UhfhBO/BFynMwJmVpPytI+XR5H/5JzMzdBp7EUcXjqQYq1mlgCZFIH4bn2FyUBkMgjTr
 tLoeY8XkbhAZg4+2GYu/wOqQeZ4d6e0nH9ccMA+MfXLD5MILoepUi+VzULw66wZ5J6ZT
 gQ2LAaKfbgbeysWhJ2qwH74akVfpOpEnIcayts1DYO/7HutbASZlucoDtX56CGmomduK
 5nJWrl9GgrZDPc7ZCSTylBhjW6fIGQ12WOctZrqGbfQqysYl/VqWcQYIp4il3YuciiQY
 2wFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQbpsTtlf7Tp8EuxxMkzZv9ikVMFDgHnNzTdjfpDoiIaBeUXFj5u9Bms6aw7jrShp+yD3VlO9F83IZMif5qMtmq9IhGuo=
X-Gm-Message-State: AOJu0YyLONh4Uz5HoY2yzLGBfd9ytoWHn0qGEz2HVG7Qm38gYWDCvTXV
 i3Rs0OuZAj81/goASTN0Kl6ykofr/S+WSuA6Pzr1NKSALg7uqBc1MwTnWZXGaqs=
X-Google-Smtp-Source: AGHT+IEeK11KdATDKEKS5DULWbdTVy1QzK3RxPcsV5k1LZsnRKZXlkR+cNLcHizs9CieFK1gAfulqA==
X-Received: by 2002:a05:600c:3d10:b0:412:9a51:d5a5 with SMTP id
 bh16-20020a05600c3d1000b004129a51d5a5mr1339604wmb.7.1709198401699; 
 Thu, 29 Feb 2024 01:20:01 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c510e00b00412aff7874esm1480448wms.48.2024.02.29.01.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 01:20:01 -0800 (PST)
Message-ID: <4562b377-ee7d-49c4-a875-e14f971b7e85@linaro.org>
Date: Thu, 29 Feb 2024 10:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] aspeed/intc: Add AST2700 support
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240229072315.743963-1-jamin_lin@aspeedtech.com>
 <20240229072315.743963-7-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240229072315.743963-7-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Jamin,

On 29/2/24 08:23, Jamin Lin via wrote:
> AST2700 interrupt controller(INTC) provides hardware interrupt interfaces
> to interrupt of processors PSP, SSP and TSP. In INTC, each interrupt of
> INT 128 to INT136 combines 32 interrupts.
> 
> Introduce a new aspeed_intc class with instance_init and realize handlers.
> 
> QEMU supports ARM Generic Interrupt Controller, version 3(GICv3)
> but not support Shared Peripheral Interrupt (SPI), yet.
> This patch added work around to set GICINT132[18] which was BMC UART interrupt
> if it received GICINT132, so users are able to type any key from keyboard to
> trigger GICINT132 interrupt until AST2700 boot into login prompt.
> It is a temporary solution.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/intc/aspeed_intc.c        | 135 +++++++++++++++++++++++++++++++++++
>   hw/intc/meson.build          |   1 +
>   include/hw/intc/aspeed_vic.h |  29 ++++++++
>   3 files changed, 165 insertions(+)
>   create mode 100644 hw/intc/aspeed_intc.c


> +#define TO_REG(N) (N >> 2)


> +static const MemoryRegionOps aspeed_intc_ops = {
> +    .read = aspeed_intc_read,
> +    .write = aspeed_intc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

Please be also explicit with the implementation:

       .impl.min_access_size = 4,
       .impl.max_access_size = 4,

> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .valid.unaligned = false,
> +};


