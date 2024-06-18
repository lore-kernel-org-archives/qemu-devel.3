Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DFCC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbDp-0000r6-Q2; Tue, 18 Jun 2024 11:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbDk-0000qK-RA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:58:08 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbDj-00069V-6J
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:58:08 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso884143366b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726285; x=1719331085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vo2r8U0wGbpNP25SjORQeMsDDFRBUkeoBBuJtuFQwg=;
 b=i7rjqMukkjWbuz+g7bXDRJ5EW9IdBdoYmo4isadpCd9PoksmJG25fmDUVciCEpAOZm
 8oAf+Yj5KY/GQioEZF7wrwwn2xR+Z1OoMLFzstctyTMQyfqyCCSGeKmWBEUWUkDf7CFG
 eAVdF2+04Eh/8e2vn2NDU+YWI0pPFSkf7tfHosQYZ8Pe8Yz6jx7G9gOsBS3PP1MU027s
 +RovvQ2EV2HJ3IZq0lpaUz287aRKll1qIWaunRhlig7c3QCXLJ9sAosevQBrok47y6cS
 cHCdk8qfvCiahQvehDTLL56V7AJBVTfK05g7tWnIXjqDz7WSQUgZUu2VWZjDZJmwbxIX
 PGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726285; x=1719331085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5vo2r8U0wGbpNP25SjORQeMsDDFRBUkeoBBuJtuFQwg=;
 b=ispIn1xXALa3BnOebipiTBTyg9W9zG7Suc8ewi/i98tpf9nwrChvBRlbGTgsHaulF2
 qXA25GW1iGa+3Efp/DG6vLiO4cQ5ER0vwTUcWxxtwbk+noxpE9+3Eyg2QmKKpQmlSXgw
 N00XOfCQRmgXFZ6zgWQTzYLF9+ztM6xvGYTUopwK9bTjXAlenEgcMWT375HxliIG0L8U
 xS/KujOyqCxGtJaH1tzoBZA4YNoP4lUr27F2g52rPS7uckXPlk1HhGByRskE7wiV73Oo
 CwOZ2I0N9uTx8czOE8JiefH1LhJ8modGdmLwb1StKZ9chcLyb6e0HqdHHrlDyKtU+i1s
 3mYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHeTX9X4k8iVD/Ihl0H1sMNSOiReiZTtwaOoEn000VmU0yxb5fcDYfFF9US1Aa862uErOcUKI6l0pmRKEyKWELAeIA59Y=
X-Gm-Message-State: AOJu0YyOOOm1FdDs2/P69q5O4fmhaOSof5oRupGnGhh9U++CSYTvwWEH
 6bOxGXkLZyWL2ud8qdtrrPiyiOZa0ng5zbZu6SNiyDX7Cfn/94IfMlzNZG2Q+UM=
X-Google-Smtp-Source: AGHT+IE8JCZ++gpiPbP8Yi+Kd6cQqr9D2PPinFDMd2URr4RLUyI5Zsm3Cb7Exsa/2KEH0++ArKVlhg==
X-Received: by 2002:a17:906:528a:b0:a6f:501c:5da8 with SMTP id
 a640c23a62f3a-a6f60d27e07mr969494166b.22.1718726284945; 
 Tue, 18 Jun 2024 08:58:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db682bsm624711066b.62.2024.06.18.08.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:58:04 -0700 (PDT)
Message-ID: <f870bc0c-595a-4d9f-aac1-8361d70ea18f@linaro.org>
Date: Tue, 18 Jun 2024 17:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc: Set valid access size for Exynos4210 RNG
To: Zheyu Ma <zheyuma97@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240618155159.3183256-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618155159.3183256-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 18/6/24 17:51, Zheyu Ma wrote:
> This commit ensures that accesses to the RNG memory region are properly
> validated and align with expected access sizes.

Please point to the device specifications.

> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=qtest, -m 512M -machine smdkc210 -qtest stdio
> readb 0x10830454
> EOF
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   hw/misc/exynos4210_rng.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
> index 0756bd3205..674d8eece5 100644
> --- a/hw/misc/exynos4210_rng.c
> +++ b/hw/misc/exynos4210_rng.c
> @@ -217,6 +217,8 @@ static const MemoryRegionOps exynos4210_rng_ops = {
>       .read = exynos4210_rng_read,
>       .write = exynos4210_rng_write,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
>   };
>   
>   static void exynos4210_rng_reset(DeviceState *dev)


