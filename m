Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C461FC9EC7A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKnU-0007Eq-Kw; Mon, 12 Jan 2026 11:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfKnO-0007Dp-O7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:29:35 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfKnM-0000gO-JX
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:29:34 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34f63ad6f51so2512058a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768235370; x=1768840170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TVzFKj5L+YvB/BrFdOmu8AqXFlecRiGXkwutuExEh1k=;
 b=T0kkP+yFGHXSOJA71eCS4L+KYFZBe/Uaz6+l2AiTchSv/j0A/+io5qvH6YaQMmh6gt
 XYLSulA60/Yhq3RwOw+VAwgQFsjPjbmp8inQsWCq6J3KPF/OwdMrkGAEdedFzfnRBfez
 yy6vQRpNFgqN5YiOnTA8m8p+FIS1mFNyZQQvZn6vGLniRclGMjX+QYTJkcDjYDXT/4fx
 +neejuDWOK5HzAjJVu2OpEloIdhBKmyghdlKO9iICNh8kt7jlJbv/YRVBOK31V5Sq1fQ
 ZMz7Fhg4GY4sb5tarmrw+FAljTHDHysRJVlP78uB/dgafm9TDfkn+rSrSlhY/7QNxu8n
 6VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768235370; x=1768840170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TVzFKj5L+YvB/BrFdOmu8AqXFlecRiGXkwutuExEh1k=;
 b=sukuBlYtgla0oALOBHpxJvSsTrrb5X4u6W2mkEoo6HQW08V14s14GJMj3xbGLyJJTN
 xoELLX3ZOfguhfPJNAvGAhEbmTof7nc2TUsDkU2FxF8lijjWwCGLavSoJti3eqVbETOL
 cAFhHvq3VJGGNlxWjOwVYGlie9RyfSCyNUJzOPfWhvyaefCVYMUYkciNtMOZD5A52yaO
 QdPMvBEbSMTA67oSXxLOTEnGodEgzvO07Z9cGhKdLmfXyPF/KqIQe/LJ8Nnag2XwW+eN
 vNYUgJJKxpiEQmzZrAxm9+Dca3xepbw074waH+0gpvI/0rD+mwUuIW5U2NeUUUyxt7DW
 j1lA==
X-Gm-Message-State: AOJu0YxPTAfgJhcZaTi4E0wwqNte9zO/JJmTv8zdHW42Q3a/7edFQOSu
 fpmtna/6xtJk9cjNwk6w7o99FnsFwG11Ao28TWcjthUmabLwjJ6JnMsiDDLObFItWzHyd7kw/qN
 0tNbA
X-Gm-Gg: AY/fxX68psFol38ucxdNzg9R0mU4qtjd+/csNPQRgJvl90kFRXTGMDAf8t8zXEXOIcy
 DkVaKs3LiQT3UdLIR19vjTqr2JaUgwVHtlA9ldA5/1gzf8gdwVAqiKw9ylBcwprOqE9Ud7xsCH2
 yTYz2eSYGxT3gobkNx3mHhTUF3Aovjvlm9llL8b8B0MrSMl4ssc3W0OswCaxWWZLuJ++jNFJY/e
 o4Zh+AEC4JyOYrqKZCRBNvp1PgzM05xm9z8HLlIymgLRQWWs5zpf9OdL6rBnKcNJRvNz+k51Dba
 e4lvvHDquntRYVb/2+s+fCthnn8MQuIkvlHDQIpP+7bR3IYUQisKxWADyZ79IG08XC2bZegaPW0
 beUiee3xehJC+yiqYJzcqGXSwmZxmRkJbDKGwVz/MkouJNTwMGXAbzxqtmwAGSnUl9wEK257LNV
 xdzaVyyMUdSW6ibvufXRqJOPEbb7lC/BCDu041oJn9t0noDoI1qQ4JdLI6
X-Google-Smtp-Source: AGHT+IG/9OqAzC2Ah/WDr+X5+vKKVMXHq6vRdlE2q/mXhMSYxyyxhupuERKRMDju3GUWa45DqkeAgg==
X-Received: by 2002:a17:90b:57f0:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-34f68c277b0mr14677098a91.28.1768235369943; 
 Mon, 12 Jan 2026 08:29:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b29e117sm7237768a91.2.2026.01.12.08.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 08:29:28 -0800 (PST)
Message-ID: <c8e80923-d837-4874-a072-d5ae579576a4@linaro.org>
Date: Mon, 12 Jan 2026 08:29:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/arm: make granule_protection_check usable
 from SMMU
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 12/15/25 4:01 PM, Pierrick Bouvier wrote:
> This series prepare granule_protection_check to be usable from SMMU, for
> implementing RME feature.
> It's based on Tao's commit [1] extracting ARMSecuritySpace from cpu.h header for
> convenience.
> 
> [1] https://lore.kernel.org/qemu-devel/20251012150701.4127034-5-tangtao1634@phytium.com.cn/
> 
> To demonstrate the purpose, this is the (wip) change to use that from SMMU:
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 80f48df3dda..1acff3bbd66 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1055,12 +1056,36 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>       }
> 
>       cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
>       if (desc_s2_translation) {
>           cfg->asid = asid;
>           cfg->stage = stage;
>       }
> 
> +    if (cached_entry) {
> +        /* The fields in SMMU_ROOT_GPT_BASE_CFG are the same as for GPCCR_EL3,
> +         * except there is no copy of GPCCR_EL3.GPC. See SMMU_ROOT_CR0.GPCEN. */
> +        const bool gpc_enabled = FIELD_EX32(s->root.cr0, ROOT_CR0, GPCEN);
> +        if (gpc_enabled) {
> +            hwaddr paddress = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> +            ARMSecuritySpace pspace = sec_sid_to_security_space(cfg->sec_sid);
> +            ARMSecuritySpace ss = ARMSS_Root;
> +            ARMMMUFaultInfo fi;
> +
> +            ARMGranuleProtectionConfig config = {
> +                .gpccr = s->root.gpt_base_cfg,
> +                .gptbr = s->root.gpt_base >> 12,
> +                .parange = 6, /* 52 bits */
> +                .support_sel2 = false,
> +                .gpt_as = &s->smmu_state.as_secure_memory
> +            };
> +            if (!arm_granule_protection_check(config, paddress,
> +                                              pspace, ss, &fi)) {
> +                printf("ERROR: fi.type=%d fi.gpcf=%d\n", fi.type, fi.gpcf);
> +                g_assert_not_reached();
> +            }
> +        }
> +    }
> +
>       if (!cached_entry) {
>           /* All faults from PTW has S2 field. */
>           event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
> 
> v2
> --
> 
> - remove extra boilerplate/include/line from arm-security.h
> - use local var gpccr instead of config.gpccr
> - extract GPC enable check out of arm_granule_protection_check
> - rename as_secure in gpt_as
> - use arm_addresspace to retrieve gpt address space
> 
> Pierrick Bouvier (1):
>    target/arm/ptw: make granule_protection_check usable without a cpu
> 
> Tao Tang (1):
>    target/arm: Move ARMSecuritySpace to a common header
> 
>   include/hw/arm/arm-security.h | 37 ++++++++++++++++++++++
>   target/arm/cpu.h              | 59 +++++++++++++++++++++--------------
>   target/arm/ptw.c              | 59 ++++++++++++++++++++++-------------
>   3 files changed, 110 insertions(+), 45 deletions(-)
>   create mode 100644 include/hw/arm/arm-security.h
> 

Another gentle ping.
This series has been reviewed and should be ready to be pulled.

Regards,
Pierrick

