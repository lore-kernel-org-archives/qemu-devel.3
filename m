Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE06C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcg5-0001DX-2H; Tue, 05 Mar 2024 16:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcg1-0001Cz-Un
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:50:22 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcg0-0005of-4V
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:50:21 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso53633255ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709675418; x=1710280218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oygv0OkQASVVTaTkHVAoVdc59x6Y64m+u6pKDlUiJ/w=;
 b=VHoX4kvjI26pIFXHfnfhesU95hsI3VhpukLwn3vdW3lp74JRGxh4rkEvoLGVdm3U/n
 Jm2LKSHBbtkBcwUUZ6MMgMQIlOEcT81NdVmrrF7/cHI4J60Z5uWxSUJ0LDcaGOJ4NMhC
 s2XsSEUXwGnoPFKdyB6XGYFt2vGFQZqGOi7aCMT0pHfGxCxJM/cQ4YlVpDzlVIBegDfK
 S6z4FaAh4Yoe3fQC1QxqUiQlTbqfk/6XG+8h5n5A1Fo53FSopbbvX7L0TCzLVnf4R3Nf
 1VJsCA2P2rTcPFNVxslVdM2NqQ7ORr45KZnjaC2yjPLHTO/POqCdmzqGWRhdIoPox7ly
 6W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709675418; x=1710280218;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oygv0OkQASVVTaTkHVAoVdc59x6Y64m+u6pKDlUiJ/w=;
 b=eeZhbgGMCCNi1HZzDhrCPaIzM4irIBu/4IYkMyXS0yCIfx+AIDP3lSj3AxfR+kkTDb
 v7ctBMIJTkBBKO4lSkO+8jo34PrTkLZuQERTQDEO4y0kN07p4giKjE2AYVRaP51UhU+7
 LzKkt5WTt/9K7w8E/VM3uxLOiWw8EPuZ8BzvI23jxhL49o8oVHVnRyNNH2o/zGsRePPQ
 rzxaUCkjPKcBAwkVyMda5ETmSUYCPxQN0e4luhwFLEsVRhMQQj/4WRg6yv/XdXG2SCEn
 Scs6tBfAai+cXfEIlwHSXkqd5UXuWXr2ZHnr/yFOw4ZopFDBxSleiUDlJvcezmRzXqeE
 lcfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRVBwT2bbSopo5Qd0PNZ4kN6+MpZifxhGONy//M8iPqligwQDYjlun4m3TWkTGwzK28ui1g7e0oQpP0vK1bas7LgEYylQ=
X-Gm-Message-State: AOJu0YxMrowBQVwLbe8sT/bQSd4Wn0pDf0rArJaN/WVZBqUhrKRpSFpq
 RgL4oEScNNzrf+n78JsTC/o3JJVDEj7/168cqr7hWWsLbKyXY2b8nBuVU0jxKJBhY1OFScJ8oNE
 W
X-Google-Smtp-Source: AGHT+IFkB5MnLLExQLXCYSmA+P8odQ+YAE/0n9+hkckutywm1Uysnvm8XTBxmUHThCtATx8T2tbmSQ==
X-Received: by 2002:a17:902:c081:b0:1dc:cee2:5ffc with SMTP id
 j1-20020a170902c08100b001dccee25ffcmr2743786pld.6.1709675417677; 
 Tue, 05 Mar 2024 13:50:17 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f2cc00b001dba356b96esm11131789plc.306.2024.03.05.13.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 13:50:17 -0800 (PST)
Message-ID: <1dd86523-572d-45be-baa4-6095981c5923@linaro.org>
Date: Tue, 5 Mar 2024 11:50:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 17/23] hw/intc/arm_gicv3: Add NMI handling CPU
 interface registers
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-18-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305070331.2151131-18-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/4/24 21:03, Jinjie Ruan via wrote:
> Add the NMIAR CPU interface registers which deal with acknowledging NMI.
> 
> When introduce NMI interrupt, there are some updates to the semantics for the
> register ICC_IAR1_EL1 and ICC_HPPIR1_EL1. For ICC_IAR1_EL1 register, it
> should return 1022 if the intid has super priority. And for ICC_NMIAR1_EL1
> register, it should return 1023 if the intid do not have super priority.
> Howerever, these are not necessary for ICC_HPPIR1_EL1 register.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v4:
> - Define ICC_NMIAR1_EL1 only if FEAT_GICv3_NMI is implemented.
> - Check sctrl_elx.SCTLR_NMI to return 1022 for icc_iar1_read().
> - Add gicv3_icc_nmiar1_read() trace event.
> - Do not check icc_hppi_can_preempt() for icc_nmiar1_read().
> - Add icv_nmiar1_read() and call it when EL2Enabled() and HCR_EL2.IMO == '1'
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   hw/intc/arm_gicv3_cpuif.c | 59 +++++++++++++++++++++++++++++++++++++--
>   hw/intc/gicv3_internal.h  |  1 +
>   hw/intc/trace-events      |  1 +
>   3 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index e1a60d8c15..df82a413c6 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -795,6 +795,13 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
>       return intid;
>   }
>   
> +static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /* todo */
> +    uint64_t intid = INTID_SPURIOUS;
> +    return intid;
> +}

Needs to be implemented, similar to icv_iar_read.


r~

