Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0139BC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 18:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u032Q-0000v1-4r; Wed, 02 Apr 2025 14:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u032M-0000ue-4b
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:42:06 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u032K-00043a-Cm
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 14:42:05 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301302a328bso96521a91.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743619322; x=1744224122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yaFQR3ZT058M1zPFRr6OXyGbt7Ks4IJbiOzmf+URn5I=;
 b=m4FKO8oDS1gDIaX/QI8gBQCOM3B++7K7la1rGkjSkrplk/HbFqMsDmI88Qm/wXv6ew
 n1fTLMeBFFqlgofd+cu16sz6epr8XwuT1fHXbrd0FuZ3Blh+LaE50pQK8NZxUHnZmWDp
 VzcxLXd57G/FfQmkE4jvIMN5GMma3aTB5KEknsQsTr/uLtK1H/Aub9AbVExMdE756Qrt
 bfaZpongdLK1J2FOD6ICahlwrsMIbpuWzHsj0YvPrWY7WJyLJR3avutEV7z4vTJpir0d
 WayBX1UeaY3xpHlBZnsZO7WAvVRwWsE24XzgUKrsyO9gwBcutA0JvOvcj9RmP/j0yBez
 2bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743619322; x=1744224122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yaFQR3ZT058M1zPFRr6OXyGbt7Ks4IJbiOzmf+URn5I=;
 b=XH6WV/3nxY9o4FdTT+4G8L9lOUzejhr9u9uBRW62RM3YlYs45YYMIlzNUiwOO7E7S4
 DigpYX3so+FynSXjrg/9OEhqdxyr3zfSuJMGtpXy0eaFoJtcfJauAikT5eqylzAgD/Rw
 oNYayO0tuRXVquUHRMbsLNNbIU8cs4aIdyW5KnVmS+I/42P1UHTYmc0vdYlQybfeSKVx
 HewMGSdJZC1JtkWTSGmKKlw0YRtS8zB6sqJBRvdkcQ+H0/e2UnpIec8ybEYqo7PSQnJ1
 7IZRf7kb4sc+eXyeHPgfPW7qhPP+I2Q9PgqnO5Oz7Ua2h7NYoo5kdKIglZ6x6VBsI+C7
 svBg==
X-Gm-Message-State: AOJu0Ywhvue8kyrT2vQbE5ORwWEW2kS0x/Ezbzkf4MrP1Sc0KlP5jRc+
 H0YSoBArYINoQZFW5kcwh0GYmikuyCzDMTg9lEy1g4f0uD013W44wl4h8L4T+Npg0PB1DA/t3cA
 6
X-Gm-Gg: ASbGncu+7Xt3aXwLYfQq+UJoE4iU+8OisQ7XWA+Pckl9/6yvF0mWBjjX7iGdTGlzOkf
 m4CrMCAx/bDVdRo/wZpA6tvFRH4agZJQ3k7GvliMcwhe1IKx7QLLfo35CY/Hgfmz5VjdchVNGlQ
 n1gxTe18lSsmA2UYlctN1iuc1smrvyCwE8sjhie6BZp6DsmaEXWQFzLfIeguwB6nQmdL/gTNw7Q
 SZHFtvhy539uL/pKgNHuAsCAD6E+s6zMtswooHFabgPwbV2znvzixWIKranC2i24XXat17jPKP+
 MvjmWysCFr8Kns04oBvbhZs3ZDNMMdcqbaA6YPM+5wYg+xSJykcvkHEVuFhsIpUssgL6ZLAxEb/
 aiRd7EfsG
X-Google-Smtp-Source: AGHT+IGiFPScF1Qhzy7QvshBDi3fmH8wxdmlESmHrIpBNo5h6Epj7ZBQOh88XvhtZa5asFOp0c9ipA==
X-Received: by 2002:a17:90b:1d50:b0:2fe:b016:a6ac with SMTP id
 98e67ed59e1d1-305320af0d5mr27659455a91.15.1743619322591; 
 Wed, 02 Apr 2025 11:42:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3056f881519sm2001535a91.27.2025.04.02.11.42.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 11:42:02 -0700 (PDT)
Message-ID: <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
Date: Wed, 2 Apr 2025 11:42:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
To: qemu-devel@nongnu.org
References: <20250402135402.14526-1-zhangckid@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250402135402.14526-1-zhangckid@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/2/25 06:54, Zhang Chen wrote:
> Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
> is mistakenly set to the default AARCH64 target.

This is the correct backward compatible setting.
In essence, it means that you *must* supply a -cpu argument.


r~

> 
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>   hw/arm/virt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a96452f17a..63649e9543 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3178,9 +3178,10 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
>   #ifdef CONFIG_TCG
>       mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
> -#else
> +#ifdef TARGET_AARCH64
>       mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
> -#endif
> +#endif /* TARGET_AARCH64 */
> +#endif /* CONFIG_TCG */
>       mc->valid_cpu_types = valid_cpu_types;
>       mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>       mc->kvm_type = virt_kvm_type;


