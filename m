Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A69EA795C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpz6-0003Fj-U5; Wed, 04 Feb 2026 22:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpz4-0003FZ-Rz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:24:46 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpz3-0003AM-09
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:24:46 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so3061215ad.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770261883; x=1770866683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lG3CL1RGA9OXsCATAM+EB+UkCHmSnfbwYz9SWKMkJ5E=;
 b=qB0hu8LP7948mus0QR/g0OG/IzLGwT/GZNaG7ByMSYA8bj0jpPNAPsl1tfaDIu2PDZ
 JYwfwPYLGBvT99KHxLapOAA2NdrweeU0Uv9dEqVAQerMhXwsstyaOpnwbYDyu1xqffzx
 wgiahF3YDgjnRT3S5iUmStxpM+rF69TZe0GmZPeQyVFOwGDdpWHpp+T9mb2FvIAIUj+3
 Vd2LtUofuunXCEGmCj9muq08UQuF7E0X9/+HmIDXgiml9VsGFNoGUBdauvOUQJiCtqOs
 8UqXDNAcjUuGFk/01/XM5IX9T/u8R4hSB3YslkFUj3hv4rXKwNq0GgY8NIurZTkgOCFc
 ZkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770261883; x=1770866683;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lG3CL1RGA9OXsCATAM+EB+UkCHmSnfbwYz9SWKMkJ5E=;
 b=m7o0pKPvNQgbf+vuTK/AuIfe1asj+5LBimD54+OllVBDrXvbl2TUu+gF3sSUHpv3kX
 XplmMJyltCsRzOE+AZOma5Lne7uN7nJ2nSZlWdXxpltJ05Uic53edWEoe5T1pVIZP+Ce
 BLoJ/JwEYJY1EIuX1mK4dYciFYZuNyivuQ/0m2M/nop+6xkr/2dL1rvGCt1d9+i7VOv+
 lsBrTNVYdKtXkNOeSSDQqxXiKeRJMFRu0/WVpoP4qRg4nTteJkI/f6BhJ6Mn7S7oROrU
 76xLvgcUP6wPPAOldZuyA8wsm2tAojbRMTCHhJqyI3ak2z+0i8AJvwmw2ieWFJFo+/qZ
 ZARw==
X-Gm-Message-State: AOJu0YxJQJ9PkXpjLlDnpT42CGjvYBnJktt6AgwsKDm4VSlX3zdgE6v3
 mE1YLRMlZwunkwosWEYtSNUWwSMxAn+RWltxcvvw/sq9ZsC2xXG5+zyNA8LqRFhR9pobZPtfBB4
 /R+cU8MA7Ig==
X-Gm-Gg: AZuq6aLknKhwhmeOE1AwgbvAN8pyz66v8qpruOpkIKV2FoZFnhWNNSpxJfNSYnW/u2r
 xK6ePdBAUXlojJNUO3ehNLqdMC5Neuezl48mpgemM5c7yxb0TKwm33gtx9OlerLBUqoHg/E/pFP
 d9LRuYxO9Tvef+ktfh8cMSoKfW0pgyK2n3MUr6NXXUzpflqhBycOKOTauXZNyXwCh534MgoQw9j
 TwKhIXQT0xc5Kr5RpQRP3QKof3y4YxycGkFf4LnKKpoHjdMMYx48X740hnyiM+9Gq3aIn1skUmv
 48tYo1bxOaxEiZp4CGGDTUG1930kFicFypS+TcBNlhFGWGFS7Ef0aCtxjFceCrzS313jz1LyARY
 tnkp+O1vZJVnaSQYPm1RIA15X/cRtinoIjjDVZt7ehDuhfjYx/9/3VT0Fvo6zeAq7hR1SMvb588
 M3BrFhVSiQ0aa45TYW35o+34ybCEn4HOcrntlSEQrAsBQkHxt4t7yMw2TanKBQV938JndjtoPZ
X-Received: by 2002:a17:903:2f4c:b0:295:ceaf:8d76 with SMTP id
 d9443c01a7336-2a933fecee3mr58897225ad.47.1770261883076; 
 Wed, 04 Feb 2026 19:24:43 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338b71b7sm34253135ad.44.2026.02.04.19.24.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 19:24:42 -0800 (PST)
Message-ID: <8ecca07b-7ff0-4a46-8de3-6a3f21173a00@linaro.org>
Date: Thu, 5 Feb 2026 13:24:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm: handle demuxed ID registers
To: qemu-devel@nongnu.org
References: <20260204133229.297061-1-cohuck@redhat.com>
 <20260204133229.297061-2-cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204133229.297061-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/4/26 23:32, Cornelia Huck wrote:
> For some registers, we do not have a single ID register, but actually
> an array of values (e.g. CCSIDR_EL1, where the actual value is
> determined by whatever CSSELR_EL1 points to.) If we want to avoid
> using a different way to handle registers like that for every
> instance, we should provide some kind of infrastructure. Therefore,
> add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
> we already use for regular ID registers.
> 
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/cpu-sysregs.h | 13 +++++++++++++
>   target/arm/cpu.h         | 20 ++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index 7877a3b06a8e..911f54bc8a4f 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -35,6 +35,19 @@ typedef enum ARMSysRegs {
>   
>   #undef DEF
>   
> +/* ID registers that vary based upon another register */
> +typedef enum ARMIDRegisterDemuxIdx {
> +    NUM_ID_DEMUX_IDX,
> +} ARMIDRegisterDemuxIdx;
> +
> +/*
> + * Number of register variants per demuxed register, trying to accommodate
> + * possible use cases.
> + * CCSIDR_EL1 currently needs 7*2, could be 7 more with FEAT_MTE2, in which
> + * case we would need to bump this number.
> + */
> +#define ID_DEMUX_ARRAYLEN 16
> +
>   extern const uint32_t id_register_sysreg[NUM_ID_IDX];
>   
>   int get_sysreg_idx(ARMSysRegs sysreg);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 21fee5e840b7..f9d51c0fc187 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -906,6 +906,25 @@ typedef struct {
>           i_->idregs[REG ## _EL1_IDX];                                    \
>       })
>   
> +#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX] = VALUE;         \
> +    })
> +
> +#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX];                 \
> +    })
> +
> +#define COPY_IDREG_DEMUX(ISAR, REG, FROM_INDEX, TO_INDEX)               \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][TO_INDEX] =             \
> +            i_->idregs_demux[REG ## _EL1_DEMUX_IDX][FROM_INDEX];        \
> +    })
> +
>   /**
>    * ARMCPU:
>    * @env: #CPUARMState
> @@ -1084,6 +1103,7 @@ struct ArchCPU {
>           uint32_t dbgdevid1;
>           uint64_t reset_pmcr_el0;
>           uint64_t idregs[NUM_ID_IDX];
> +        uint64_t idregs_demux[NUM_ID_DEMUX_IDX][ID_DEMUX_ARRAYLEN];

I'm not keen on this.  Surely we don't expect all multiplexed ID registers to have the 
same number of sub-registers?  A rectangular matrix isn't a great representation.  Also, 
you're wasting a hole in idregs[] with CSSIDR_EL1_IDX.

Why not just have the N sub-registers occupy N entries within the regular idregs[]? 
Something like

#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM) \
     NAME##_DEMUX_IDX,                               \
     NAME##_DEMUX_LAST = NAME##_DEMUX_IDX + NUM - 1,

#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
     ({                                                                  \
         ARMISARegisters *i_ = (ISAR);                                   \
         i_->idregs_demux[REG ## _EL1_DEMUX_IDX + INDEX] = VALUE;        \
     })

etc.


r~

