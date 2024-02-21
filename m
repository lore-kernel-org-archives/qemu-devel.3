Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D178CC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcq6O-0002Rr-6g; Wed, 21 Feb 2024 12:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcq6M-0002N3-Jh
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:09:46 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcq6H-0005k9-1f
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:09:46 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dc1e7c0e29so12509715ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708535377; x=1709140177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YfL7cBA2MxklBcazFZ6/g0zy0GOnL3nvfP1PZytwtv0=;
 b=k7HtaUTL8kxe9fjyFijCnABaktMmtXrDJKy0zUQD4tWSF9Fe/3uiMtA2PvchqbsWvH
 Q9r6YqXnu9Tipny3qcq8Aoi1gS/FMnONU3Bz5A27GDjwlBZaqtSjDT0CIjK069af/Kzz
 /s6X4Q6MO6adOKbIfKHoTmpJC2eLnXo4JPfNacEvoRv4Z5UE4sMiUBKeFaHpoWooaLQV
 XO3SQhsT/scOS3tXw53snvBSoKYTk6WpmTvmByIDEMjj6sXF/Hqs+zNLVfnm9aq8Ikuh
 3EUL7MZ8rm8NCAd3f+Thr6sZ0r9D7vemAf7gdjMPN8IcrqYlHjikif8ukoWNQjPEEQyF
 G6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708535377; x=1709140177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfL7cBA2MxklBcazFZ6/g0zy0GOnL3nvfP1PZytwtv0=;
 b=XuvgXBj4C69TJ5D4naTqU1uyYWc5X02+ym6qELC4MN04b3/n403Fr5ChxZDNei+ryf
 BHXEea9JGwUd8TCxp2Yzq/AGhl94BhwEYgunCY3gw18NNWJpnDP/Uh8So/s1FhriezqY
 E5nQ3LkqvZSQ4/AVk5e3RaQAmDK6MSFAMBVPN+Mm5yJwDkmikzcxI9JwNsqCv23b7vBb
 IoZcdAcJt25I5Xd5VkGL+MZjMRrw8H6zHRCd5j286NxqRgfKtd/sGCbjkxDZqxNor5mg
 0BUoS3wFCXp+OsFXr0EP9ULd4LhW/AEgn8YX6C/vSiF0MJF/WBPP6iHD3zJgCwxDEtHY
 HSLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQwtjqZfWe/5AxDoLsaZfXsx7dTpiHcVqhxS8m+9mAbT9N1qSYyW5mDHiQHQnJCmSbaT+KetjyMS7ycHehI5ZEs6f+VC8=
X-Gm-Message-State: AOJu0YxgpPowGXeuHsP9fZQ4mo0ew7iGjAFE4Mu9ZAL2rFjuc8iQy6wG
 cp/QQHnp0Q39ajng1u5UqvHEhvVn1FXLL/4Cvv6kbarVfdX63+On3pO+NqC1iEc=
X-Google-Smtp-Source: AGHT+IF+CtVmmDfxlCOhZzD0tZ5s4tvqNCYHmTEvQHeBr033MQLY6vO3rj+oHw7rlaEZuQeNqg8Hgg==
X-Received: by 2002:a17:903:2b0d:b0:1dc:7ca:36de with SMTP id
 mc13-20020a1709032b0d00b001dc07ca36demr8909838plb.9.1708535377135; 
 Wed, 21 Feb 2024 09:09:37 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 jd20-20020a170903261400b001d94a3f3987sm8290329plb.184.2024.02.21.09.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:09:36 -0800 (PST)
Message-ID: <eff4982a-2952-4979-af88-303e49ae837f@ventanamicro.com>
Date: Wed, 21 Feb 2024 14:09:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/riscv: Add functions for common matching
 conditions of trigger
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240219032559.79665-1-alvinga@andestech.com>
 <20240219032559.79665-2-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240219032559.79665-2-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 2/19/24 00:25, Alvin Chang wrote:
> According to RISC-V Debug specification, there are several common
> matching conditions before firing a trigger, including the enabled
> privilege levels of the trigger.
> 
> This commit adds trigger_common_match() to prepare the common matching
> conditions for the type 2/3/6 triggers. For now, we just implement
> trigger_priv_match() to check if the enabled privilege levels of the
> trigger match CPU's current privilege level.
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
>   target/riscv/debug.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..7932233073 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -241,6 +241,76 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
>       }
>   }
>   
> +/*
> + * Check the privilege level of specific trigger matches CPU's current privilege
> + * level.
> + */
> +static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
> +                               int trigger_index)
> +{
> +    target_ulong ctrl = env->tdata1[trigger_index];
> +
> +    switch (type) {
> +    case TRIGGER_TYPE_AD_MATCH:
> +        /* type 2 trigger cannot be fired in VU/VS mode */
> +        if (env->virt_enabled) {
> +            return false;
> +        }
> +        /* check U/S/M bit against current privilege level */
> +        if ((ctrl >> 3) & BIT(env->priv)) {
> +            return true;
> +        }
> +        break;
> +    case TRIGGER_TYPE_AD_MATCH6:
> +        if (env->virt_enabled) {
> +            /* check VU/VS bit against current privilege level */
> +            if ((ctrl >> 23) & BIT(env->priv)) {
> +                return true;
> +            }
> +        } else {
> +            /* check U/S/M bit against current privilege level */
> +            if ((ctrl >> 3) & BIT(env->priv)) {
> +                return true;
> +            }
> +        }
> +        break;
> +    case TRIGGER_TYPE_INST_CNT:
> +        if (env->virt_enabled) {
> +            /* check VU/VS bit against current privilege level */
> +            if ((ctrl >> 25) & BIT(env->priv)) {
> +                return true;
> +            }
> +        } else {
> +            /* check U/S/M bit against current privilege level */
> +            if ((ctrl >> 6) & BIT(env->priv)) {
> +                return true;
> +            }
> +        }
> +        break;
> +    case TRIGGER_TYPE_INT:
> +    case TRIGGER_TYPE_EXCP:
> +    case TRIGGER_TYPE_EXT_SRC:
> +        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n", type);
> +        break;
> +    case TRIGGER_TYPE_NO_EXIST:
> +    case TRIGGER_TYPE_UNAVAIL:
> +        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
> +                      type);

I believe you meant 'does not exist'.


Thanks,

Daniel

> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return false;
> +}
> +
> +/* Common matching conditions for all types of the triggers. */
> +static bool trigger_common_match(CPURISCVState *env, trigger_type_t type,
> +                                 int trigger_index)
> +{
> +    return trigger_priv_match(env, type, trigger_index);
> +}
> +
>   /* type 2 trigger */
>   
>   static uint32_t type2_breakpoint_size(CPURISCVState *env, target_ulong ctrl)

