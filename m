Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308AEC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdcFY-00008g-6L; Fri, 23 Feb 2024 15:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbvu-0002zx-Eh
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:14:15 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdbvt-0005sU-0g
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 15:14:10 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-364f791a428so2695665ab.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 12:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708719246; x=1709324046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I700NpAcGVLc6L+nJDp9JAzh6V9ItdFTitqNh9gY0Zg=;
 b=oItaXYxVYAcMC898XqkMWQN3mal/g0g1K9PH8V42U5KOvuuzJKoOP/aM5d+G+lGoNQ
 fw9Erl+xEsa7EvyGJAxKlV9tf+U9D2BZM4oS2g0x4eZP6iuLHVL39FfbQ4iChIFB9Uau
 plvzcY/rOhD3axSQVIV2iwJA6zEsh/g2xVDqoINhieLQu5yLyOXDRd2Cxu1kkxUmxNA3
 pq+B8O93DgyZuxeaAD/drOJInbJwkwPVONXgEhqExaztF1oX+jcO9FSC3A5gN216FUIV
 LGvooDWXkQAeBUn/fGSLvrwSOrmD55jy6D9WDicjj/Mod/gdNIjWNOUDOAAh8iUsB/Tj
 LMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708719246; x=1709324046;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I700NpAcGVLc6L+nJDp9JAzh6V9ItdFTitqNh9gY0Zg=;
 b=SDm0qpH8F9QiQCfzsJ+w1yeyrXpBODrEnbdKxatE/UNuPHaDSkI0SIiAMhqcECxdan
 nZtH7VQ1bC1Zh35nXgXtdr7yylC9OcaBO/omoHFbiT3IAR+vNSsHq2gk6fsmY2QA4rZ8
 fZCHksvkP7qZSSyQNZf97fI7BOJNr7UN6ZpS3jyifX/z4W+Ki5NiP6CMhWeqvsB3Jb64
 Xq2bP6LGVR4z145JI9AWESveE6fUYkEOnRhA3yQKzv47a8lISSKuW5DD5UETfyTMfPYW
 JL9x9Ev6SFmvdcANbOv2oEcBLpsS75H/syTAKLhItxtBEmBHWXuybgneRpFhn+aLAleu
 jlXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVGHSlbSioSNeSDJgZkXJSJ4n11ykFXL2CoHSys6teaMO776XrKz/lTvyrky2ffepxIwxF3vMavNmuzE6U9ANzs9vZ7CY=
X-Gm-Message-State: AOJu0Yw8OJD9hD2laaFrHHEqXGnr9PgpANUB1PKzDaXGhZ67ovl4YI/d
 Cbxh7CSl7YZp3eDDkAZuPh6lZekP/Q6CLg7syQSepM6kVVhDvX9wVgSKtIVQid0=
X-Google-Smtp-Source: AGHT+IGEi7UWAcwTpcwedsB6Y5SSbFIW1/dam9DxRmVpvrUCI5L9MhQGo1WK63ufzk3HwwqKUgu4JA==
X-Received: by 2002:a05:6e02:522:b0:363:bb5a:3329 with SMTP id
 h2-20020a056e02052200b00363bb5a3329mr984256ils.1.1708719246654; 
 Fri, 23 Feb 2024 12:14:06 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 z28-20020a637e1c000000b005dccf9e3b74sm12361418pgc.92.2024.02.23.12.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 12:14:06 -0800 (PST)
Message-ID: <ca6cd116-8dae-4ddc-95ae-db19e18ae5b5@linaro.org>
Date: Fri, 23 Feb 2024 10:14:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 14/21] hw/intc/arm_gicv3_redist: Implement
 GICR_INMIR0
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-15-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> Add GICR_INMIR0 register and support access GICR_INMIR0.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   hw/intc/arm_gicv3_redist.c | 23 +++++++++++++++++++++++
>   hw/intc/gicv3_internal.h   |  1 +
>   2 files changed, 24 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
> index 8153525849..87e7823f34 100644
> --- a/hw/intc/arm_gicv3_redist.c
> +++ b/hw/intc/arm_gicv3_redist.c
> @@ -35,6 +35,15 @@ static int gicr_ns_access(GICv3CPUState *cs, int irq)
>       return extract32(cs->gicr_nsacr, irq * 2, 2);
>   }
>   
> +static void gicr_write_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
> +                                  uint32_t *reg, uint32_t val)
> +{
> +    /* Helper routine to implement writing to a "set" register */
> +    val &= mask_group(cs, attrs);
> +    *reg = val;
> +    gicv3_redist_update(cs);
> +}
> +
>   static void gicr_write_set_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
>                                         uint32_t *reg, uint32_t val)
>   {
> @@ -406,6 +415,13 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
>           *data = value;
>           return MEMTX_OK;
>       }
> +    case GICR_INMIR0:
> +        if (!cs->gic->nmi_support) {
> +            *data = 0;
> +            return MEMTX_OK;
> +        }
> +        *data = gicr_read_bitmap_reg(cs, attrs, cs->gicr_isuperprio);
> +        return MEMTX_OK;

Clearer as

     *data = (cs->gic->nmi_support
              ? gicr_read_bitmap_reg(cs, attrs, cs->gicr_isuperprio)
              : 0);
     return MEMTX_OK;

> +    case GICR_INMIR0:
> +        if (!cs->gic->nmi_support) {
> +            return MEMTX_OK;
> +        }
> +        gicr_write_bitmap_reg(cs, attrs, &cs->gicr_isuperprio, value);
> +        return MEMTX_OK;

Likewise,

     if (cs->gic->nmi_support) {
         gicr_write_bitmap_reg(cs, attrs, &cs->gicr_isuperprio, value);
     }
     return MEMTX_OK;


r~

