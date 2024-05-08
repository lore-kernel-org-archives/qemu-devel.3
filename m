Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ADBC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4k4E-0007Fv-Pk; Wed, 08 May 2024 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4k4D-0007FO-2n
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:22:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4k4B-0007Wf-J5
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:22:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-34db6a299b2so3989659f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715185370; x=1715790170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JFQx/gtl4mrgR25yql7R7/oHLt+CjTIPJA7gnCNnNPQ=;
 b=I2HyeGVOcfbj5T7JXW4duKJ3ykRHuXbkmHyN4dOVpFGt0veEzsu0d9y7syGm8pKhny
 JYDNYfWBM3MNDeRHy+xotWOm0HEYRhXrYK3IoY6LVz1gAQmZEvXWB2cdUnxvUN4cR+xV
 /TjTYn2F4MGK058UgJMYw7H0jkXhRsAbL6+Soh3bQio8OnvOUvsy9Ido7wyBgY4KaKjl
 erB50EwLMEp2+BSn804WztxnhVKPZUUsX2hsFkcClk/vRpmOyQmDo1Jun+o4OSpamzWJ
 7UNSEVqKBD+ABaLfRsZPFcV469uK4vyTFht7VTmlyaaoHHGpepdyBGQm2XGj87pUDIme
 9NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715185370; x=1715790170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFQx/gtl4mrgR25yql7R7/oHLt+CjTIPJA7gnCNnNPQ=;
 b=GgO+DVZdjNlsLlQv6DyVVTBuGebSKrVshtrVC5x4plNpXwPWzNFXPsxfMofQwxSsKl
 ue/6nuh/ow7mm8HfP8Mf9hO+3b1sBLyn0OuWWeq58R0wsoeDBezp4kMLEF5+r7H6sLvJ
 +VM2UgB3NPMZNB9s55QXxF1dP0f6lt2UvkFm5941ZYjwtXVsDqtUDVFJg8p68Am9zM6i
 w4GlaoWgaun3GoLzI2jSTLvjzx6Sm+e4t8urEC9jA1h1eUaJO/eg/aDkWwFTyNecLSra
 55rbXYT5tY8GpzhmoALUuACgZJ9DZS9NRGZe8rNTiKdhvblTvwQkA2CLKhlu5cwSjaiR
 Ytdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMYWV7kRSnsTtfp3oYrNuquL3QWNokVLf3a40lB+2Yh4PKJBMHRbH4Lb1ft9XXyFTwJMltjtemp/lUhlBFGSw2hM9CRiw=
X-Gm-Message-State: AOJu0YwX6tnQSQALGpOXxo4+hkCFQ8D9iIAFmCt4yWQX1bsGcBgqLhii
 yp9vfBSLHRYaPru0aFNyFvdciRkSZ/MXNd93DdW9h2bkxKnOiORiDVPz+R+By2k=
X-Google-Smtp-Source: AGHT+IF0+HNEoO28b+OMqbR3jY+11Jbck867timb9DzHlF4xAn1VAL8v2N/gRc5NHdxOySoWI/HaZg==
X-Received: by 2002:a5d:58f2:0:b0:34d:9fc2:4a81 with SMTP id
 ffacd0b85a97d-34fcaddf8c2mr2051534f8f.5.1715185370074; 
 Wed, 08 May 2024 09:22:50 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 v7-20020a056000144700b0034c66bddea3sm15802841wrx.37.2024.05.08.09.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 09:22:49 -0700 (PDT)
Message-ID: <02d0f3ae-f4c4-437f-91da-10ae17b539ed@linaro.org>
Date: Wed, 8 May 2024 18:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <20240508-loongson3-ipi-v1-1-1a7b67704664@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508-loongson3-ipi-v1-1-1a7b67704664@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 8/5/24 15:06, Jiaxun Yang wrote:
> Since cpuid will be checked by ipi_getcpu anyway, there is
> no point to enforce MAX_CPU here.
> 
> This also saved us from including loongarch board header.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/intc/loongarch_ipi.c | 19 ++-----------------
>   hw/intc/trace-events    |  2 --
>   2 files changed, 2 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


