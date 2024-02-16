Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B783C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayB1-0003jN-Dl; Fri, 16 Feb 2024 08:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayAy-0003iS-8z
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:22:48 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayAw-0004LB-MA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:22:47 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e0f803d9dfso474421b3a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708089765; x=1708694565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Za5F62vP2mvSbCc4pjCqygeGWbZ1PJZK5hh8fylHmO0=;
 b=CjnHDfp2PSTyKqZTyYESMT9Mo2e8Nzghbir4i3jcVye80+6cC0sRtMJAP+J2kF/ZG9
 w8dih85Jl3bRYptgFjXMzeZ/qPucKwl78v9bBc/0m8EOkZ0azaGSNdY+z5Fngsi2Lzuj
 ub4B0OJjaV1gFvINHXMaevtEbWq5+EiFQNJw8b6BXgKnbYg0uf6FlIlC0ZFcaEN7EAa8
 YD1ZqSLV5eXX2DJOOTKsLJXeNFdhT+W9jtGJ1ApNlRUPwlMlpohPHYnLrMHVwvUkLKoL
 OIxynJ2xu0bC5H2/uUuloOg5afeFKqs1l8Ua/82s/NC/va/I5caLnPG0/2xXGrz1bYJA
 vKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089765; x=1708694565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Za5F62vP2mvSbCc4pjCqygeGWbZ1PJZK5hh8fylHmO0=;
 b=mGXRv1m3ve37cbSeKPbFaUoRIVXZVMxQ+sSrwcOfklphn843bjk39W+ekSX3KvPUt1
 aOCmto57FyjS79yW6THu5mRzN5SEab1wAHE5y6nf4Qcr/dXB+ltvuJBGv3QEyuIBlqI4
 owkY4ttFNve69gTFUqHjk+RXNcu1H7e0QwSH+2IRY+uPnpM//bqr+CDtYQnrccPUhVZz
 em9GpPOUcmEmL9aWpmjWG8Xlhy3jsOC8PoMD1ntOnFpqeOe1LrFc45TIyGTRiwMUmWCb
 9GRtziFrb/NgzgGsq3RUkLznxhBGIsf6eS1Hh29ZQUPXRgMyQ5d4yxFQWYE11mv6eTMw
 7VHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdxN8CObIU2T4QnV686SjSNsIkGtOvZ/VZmi1McsaQR/EdjiG3WL37x69zZOD9DDNAZQv17+pvQfvyY9o2ePIPysVH9zM=
X-Gm-Message-State: AOJu0YygB08UO8RKKNlYUjRVgeZvvxQWGvDaYioQqyUCPL5TZF9rOW4u
 bv3lYN8lFn+GjYlurfVybtetyLQo0LT/YYky6ao44X0iYL1WiWu+3aYzNScQ9I4=
X-Google-Smtp-Source: AGHT+IEyfuax8z66JPgBNZNwr8pyrt/Ei2A+wTb3wbRcLuCcNwVGFX+SPVdbFlrlTPtKZAQTYc2INA==
X-Received: by 2002:aa7:87d3:0:b0:6e1:2b1:54eb with SMTP id
 i19-20020aa787d3000000b006e102b154ebmr4301370pfo.9.1708089765155; 
 Fri, 16 Feb 2024 05:22:45 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a056a001b5a00b006e0e35c1e55sm3054626pfv.79.2024.02.16.05.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 05:22:44 -0800 (PST)
Message-ID: <4428f5b0-b2fb-4520-9e8f-b17ba09fd076@ventanamicro.com>
Date: Fri, 16 Feb 2024 10:22:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/riscv: Reset CSR tcontrol when the trigger
 module resets
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240216061332.50229-1-alvinga@andestech.com>
 <20240216061332.50229-3-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240216061332.50229-3-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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



On 2/16/24 03:13, Alvin Chang wrote:
> When the trigger module resets, reset the value of CSR tcontrol as zero.
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/debug.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..e3832a643e 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -941,5 +941,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>           timer_del(env->itrigger_timer[i]);
>       }
>   
> +    env->tcontrol = 0;
>       env->mcontext = 0;
>   }

