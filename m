Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B789AE8FDCD
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 17:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZXhv-0005al-Iz; Sat, 27 Dec 2025 12:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZXhk-0005Ye-Al
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 12:03:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZXhi-0005Yl-NV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 12:03:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so49680485e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 09:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766855025; x=1767459825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4rNuDrDyhM92NT7gi6C0tsfCg6e6l3TlNjxQ/pNi5s4=;
 b=Hi+FV34hlJvZ2fnJ47FBhlmEwpOHVuLujr2kHC6fnN0iyL4ewY3Xh90ldg5K0VQbdb
 cmZmmXz5WinJu/KhaeXc8q26cY8jOSe6AlIG9iuDeWQKGj6SgK9bmkkTeE4sTal5GXnG
 MVLk9EdUzxzH1TY1EOWVSVddWf3Kxz5pn6MY9fvflIHKx/Amu9F9l2bJsqEy+acda9zW
 E7BvE3f9PpoHjV3ENdcalBmJ5hshfqK7R3ldLhXtAS/u7v/KLSfuNgsG4opVKkYzqAzN
 NYvQSmiSdWUnJ26XuKzhNp5ntpFm+gakCJcoNJ4dcKMrJycGHuU+jsa3R3xRrWCGy6uR
 g3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766855025; x=1767459825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4rNuDrDyhM92NT7gi6C0tsfCg6e6l3TlNjxQ/pNi5s4=;
 b=UNjmTCf/UkdQJBpAdxYIsuCpM6hJuP9tRn51tEgVo04lBDOvHTAxs4bfT1f2Iium0j
 6M0iN2P0TY4bGu5u75t2rgyh5auG2AGLB8Fvs5RPQTLKYqdVRi0RnNgnfC4fBBeMtzAe
 ehnkFzlizBkeGpVtzpQ9zaCeoCNtGVj9mYhR/n9Jo7u2uQEZYNbWWjqwD0TpAqG2Otwm
 c6YQpB6mMcOHv9IEGG/tyZR3oK1iX4BI8tXjM379KneulOP3hX6GqkGgbeI2uqkLenAJ
 FYAuMOdKaG4hqBMoOJwK0ezIvUvRI5hHPjsLRnyq7X7vhlsPvJyFSFPMXhiXixqJkL3g
 gKKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUikS9rmJ11fRHYpzEofBap2iLAD2nwurB/i+t+sE8bd2A63KXh0S4F+3SPXuLHAQp05E/YWn3I0Bi4@nongnu.org
X-Gm-Message-State: AOJu0YzMWhTV5/gpaEVJfvEEpXEIQsj7k38dWfsCb//8ggUb4yz3L31q
 b5wL2w8Q3FtaWzDzgyJMGEM1oANTVz5MMjF7Wdp1VpC3QV6wfsedxv17208MALkwsek=
X-Gm-Gg: AY/fxX75aAppNT8iCmnkVY3DDS+ZgbYTG6TmFyQvLSlUT33dRIvMPdoUcAG/K/28JdD
 mXT5xulnvUKDaJsoA8AFJdwACnfvy7J2XW+OlzUc+TtBIzI3Yowsz4AJBCILFp6vMvLnm5prRbv
 cu+BFkTQ1W9PtUHRcM7TkBEWZnVdpEmH6jVgkYUrKKC3MBKwP02yLiHpstxqkmGSjC52H2dXkpS
 IJPc/owEsCcUnFpePHHZ2QHL/GI0bktOP5rcvPtjQeIDQA0/XR6FwjrD4BS96jkGLJI14/AkMX/
 DGCvqry71mv6fhxYxobFQLgmsPl3iJI3qblcBDqsU4sGp4A7IHJwiBxbpOuuxTz+Wz8rrKWqmSx
 eWB0NWXdLi98JyXxEml6y5ZB4caYy0kqfVrJKmvonnMEoYRi8ldx/w11mTTkGX/j4tNDc346JkG
 pB0wEhG315nsCHR8COIzCn/y62l6r95FS+cZ5ASFwu7c6Nes8zLw9I4BNSH2tXuA==
X-Google-Smtp-Source: AGHT+IGUBiPlwtkQqRa6DTDSQOsnf/54cATGMU0h9k8wwQIRA99GSem8D0D/2702T0AyGQRtZCPTBA==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d1958a43fmr266477315e9.19.1766855025011; 
 Sat, 27 Dec 2025 09:03:45 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346d33sm462719815e9.3.2025.12.27.09.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 09:03:43 -0800 (PST)
Message-ID: <9eeda21f-f7ba-4908-84a2-4daccc4af6a8@linaro.org>
Date: Sat, 27 Dec 2025 18:03:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Align pmp size to pmp-granularity
Content-Language: en-US
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20251223102547.13337-1-jay.chang@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251223102547.13337-1-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

On 23/12/25 11:25, Jay Chang wrote:
> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> value is smaller than the PMP granularity, it automatically aligned
> to the PMP granularity.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/pmp.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3ef62d26ad..01b337f529 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -167,11 +167,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>               uint8_t a_field = pmp_get_a_field(val);
>               /*
>                * When granularity g >= 1 (i.e., granularity > 4 bytes),
> -             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> +             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
> +             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
>                */
>               if ((riscv_cpu_cfg(env)->pmp_granularity >
>                   MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
> -                    return false;
> +                    val |= PMP_AMATCH;
>               }
>               env->pmp_state.pmp[pmp_index].cfg_reg = val;
>               pmp_update_rule_addr(env, pmp_index);
> @@ -251,6 +252,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>           break;
>   
>       case PMP_AMATCH_NAPOT:
> +        /* Align to pmp_granularity */
> +        if (g >= 2) {
> +            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);

Could we use QEMU_ALIGN_UP() here?

> +        }
> +
>           pmp_decode_napot(this_addr, &sa, &ea);
>           break;
>   


