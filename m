Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8842CC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jBr-0007QK-P7; Wed, 08 May 2024 11:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4jBo-0007P4-J9
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:26:40 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4jBm-0005U9-LM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:26:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59cdf7cd78so934910266b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715181997; x=1715786797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8yrkXUx80MzjUBiXjjhVxMVwQxWyhVHLFybrRVar0g=;
 b=U0cYuDfhW8bNraNyUSgvppbqoOXQfvhk5vHh9z3ruA7KbrwoXjEi0p3KLO7wMU9DsP
 XWZcdzkXsXqBsfEi3rP132znza+2A3CHzDvYXpJZdIFVMHQyZS3LId2/vXxqWEMQ51Go
 IE/bnlCkwwph/NeZ6D2bBnBa7acuj/Wgjw25DMN2Kq+2+7WH4GscCX1BEkj919TRLu+6
 mQW0EvDpcru/NFFccY13F14dY6rhU2GcU5axAFRXUURncjvRjO0nQS0/PM4cdQvA7PK/
 A1W5LiOakiHZwAZQ3sClTvVN6HAvfW8QwCAJUJt3nTTqRhWQc1pSqAmg7pAW75uw7MUZ
 58zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715181997; x=1715786797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8yrkXUx80MzjUBiXjjhVxMVwQxWyhVHLFybrRVar0g=;
 b=OIdwvtOS9+urMIk1Tq9fJ2Bsj9lTDyYKAj5wc9/GJ0kfrDTVjVn8QKTa6WkJF6CpYS
 /SwPNo7xWSWxO4qO/Y8wtGkQIPv/bwxT6PeOPYc///0bePtYWfPqfRYOVvFEaCndvKCF
 GlU6hXuRnwQ1UBbedCsvNdgYNtQnYxp5aqe2zmgt/3l4gOaoMbWDhTEw9NgqalXbcKZH
 9rnsxPjZWK2LqBiNfgOG/lUMMelN/h+wyCLE0hfQ1KQd3bHtuqDFPlibzOjmlHSLI+ao
 AH1QEfGsMmuXX8/m6anmdC/5xJ01DyA4oFBghXbxR4E6lNJOiCrBrZVMpi5yrr0yrSBV
 Xw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKF289b6oAU4O1GQiKEo0uLBVBHn/zJJwRKxBIJ43D/CjXOjgXGGqYQc/0czZACTSzFdZnvnfKJhdy8EgaH2pE9sICh+o=
X-Gm-Message-State: AOJu0YxFQ6TCgs17ZFPW0zW8ks1aanh+gfgTDhGdxLrYE4xVCXE7Lx2h
 lNjUp1eJ9Q33vG53svgZ3ac+IyqkS9+ly7S4n9p3BpRh8wXfmX0xsZFdnZvDfIo=
X-Google-Smtp-Source: AGHT+IHP7XIu8ddKMQSmBeNRFaO8JzQ/DvAVUOBnyHaFxfB/NttJ0XR6nmXOyQwgGmxkSlaoHKw7Pg==
X-Received: by 2002:a17:906:2551:b0:a59:c9ce:3390 with SMTP id
 a640c23a62f3a-a59fb9595d8mr177464466b.30.1715181996629; 
 Wed, 08 May 2024 08:26:36 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 kt1-20020a170906aac100b00a52295e014bsm7763190ejb.92.2024.05.08.08.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 08:26:36 -0700 (PDT)
Message-ID: <a73858d1-c744-4a9b-b688-098e5dda9e12@linaro.org>
Date: Wed, 8 May 2024 17:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/33] disas: Split disas.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> The routines in disas-common.c are also used from disas-mon.c.
> Otherwise the rest of disassembly is only used from tcg.
> While we're at it, put host and target code into separate files.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   disas/disas-internal.h |   4 +
>   include/disas/disas.h  |   4 +
>   disas/disas-common.c   | 117 ++++++++++++++
>   disas/disas-host.c     | 129 ++++++++++++++++
>   disas/disas-target.c   |  84 ++++++++++
>   disas/disas.c          | 337 -----------------------------------------
>   disas/objdump.c        |  37 +++++
>   disas/meson.build      |   8 +-
>   8 files changed, 381 insertions(+), 339 deletions(-)
>   create mode 100644 disas/disas-common.c
>   create mode 100644 disas/disas-host.c
>   create mode 100644 disas/disas-target.c
>   delete mode 100644 disas/disas.c
>   create mode 100644 disas/objdump.c


> diff --git a/include/disas/disas.h b/include/disas/disas.h
> index 176775eff7..54a5e68443 100644
> --- a/include/disas/disas.h
> +++ b/include/disas/disas.h
> @@ -2,13 +2,17 @@
>   #define QEMU_DISAS_H
>   
>   /* Disassemble this for me please... (debugging). */
> +#ifdef CONFIG_TCG
>   void disas(FILE *out, const void *code, size_t size);
>   void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size);
> +#endif
>   
>   void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
>                      int nb_insn, bool is_physical);
>   
> +#ifdef CONFIG_PLUGIN

Although implied, could be within the previous CONFIG_TCG block.

>   char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size);
> +#endif

Reviewed using git-diff --color-moved=dimmed-zebra:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


