Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDA4C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSzR-0007Dg-RM; Tue, 19 Mar 2024 02:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSzO-00078V-Gi
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:30:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSzM-0005vi-SE
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:30:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41464711dc8so2554455e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829819; x=1711434619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=95a8RmWWJhCHbGXfxMOgwAw3z/gLUgZ6lpWKi+maq5I=;
 b=ROHaw/AK/YMVYa6zllnu9t630s05SrG56yx5JkJOYcIoIvXDnyNvw4DZwjxTpp+GDk
 MdgL7Sa8UIZkgE/PdZlyQGDqgLVm0Cj6Tib+zEEXWPd/+z79KxKL+08daAdm3oCR6zv7
 VwBvAx4RvFPqtij9nzJEjS1ruw0ostC5OZfa8pOYmM5cyHvAJxaol94aczLmVbVGDIn1
 pTNnew7bF3tmXy4DUqo7G3zTrNPqAynXo0wuyUlWDT8jP12Q/UMIVi+HyG2NWw8YpQbJ
 N6T7zB1wtuOtkzYLAA1GvNxvI+tsDXO2zFiCJHbHInyC7efMRkHXx5fPHm5G60izLHx9
 0tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829819; x=1711434619;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=95a8RmWWJhCHbGXfxMOgwAw3z/gLUgZ6lpWKi+maq5I=;
 b=dS5k6btgd3NM1rjQOWJiDVmTSTXT0cTzNknqa+NM1+lEx8m3lo/p4+2JK9D/PEw8if
 L9aARhUzGQyxwaukQvkXwkHmWG0XQo/xHmRBcinsEKudeRBcyldRrqxKakbeKQjbLmTq
 Cc04mZf/aN9UuvjXnBkvRgprvVzih3AOwOyG3JfNbB2fZzNwaahtQviMUSxeCz8rj8Ze
 6F9iKAx5evDSaB1Y2B7C4z0sD8QFchwuGb8Kw5ojbHIwUk/1JOVrLD3Hrl07QA4g7iNB
 kSuo7eF3xVfdtmJH4B8NLXel669+eNv9BVX8OzQ6/Bko/RR73BQneZZvhQQsD6Hh0m7i
 mYnw==
X-Gm-Message-State: AOJu0YwOdFKS1zJIqsW/ZkXKZVSvA4RV8a3HPjVM5rdOfDSVVkJCN6Jr
 ZRoezA54Zn7Nh/fBwonfXD/V/f0vWegUVa3+NMJJogysUUWk48IYsyNsiNYtTOicB3wLSrBKaZt
 S
X-Google-Smtp-Source: AGHT+IHWeiFwaub1Mb+nd516nQYCvTwv+I2oSE7rFB+kmF5IbmXK+0hEcUBXDLL0P9Lj0caqw1zzLA==
X-Received: by 2002:a05:600c:43d4:b0:413:f1c0:49a8 with SMTP id
 f20-20020a05600c43d400b00413f1c049a8mr1110336wmn.9.1710829818948; 
 Mon, 18 Mar 2024 23:30:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a05600c470f00b004128fa77216sm20446328wmo.1.2024.03.18.23.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 23:30:18 -0700 (PDT)
Message-ID: <76beabbc-e4e2-419d-b647-7d6aa8983c6c@linaro.org>
Date: Tue, 19 Mar 2024 07:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore/helper: Use correct string format in
 cpu_tlb_fill()
Content-Language: en-US
To: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240319051413.6956-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319051413.6956-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

+Anton

On 19/3/24 06:14, Philippe Mathieu-Daudé wrote:
> 'address' got converted from target_ulong to vaddr in commit
> 68d6eee73c ("target/tricore: Convert to CPUClass::tlb_fill").
> Use the corresponding format string to avoid casting.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 6d9e80cc0c..76bd226370 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -76,9 +76,9 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       ret = get_physical_address(env, &physical, &prot,
>                                  address, rw, mmu_idx);
>   
> -    qemu_log_mask(CPU_LOG_MMU, "%s address=" TARGET_FMT_lx " ret %d physical "
> +    qemu_log_mask(CPU_LOG_MMU, "%s address=0x%" VADDR_PRIx " ret %d physical "
>                     HWADDR_FMT_plx " prot %d\n",
> -                  __func__, (target_ulong)address, ret, physical, prot);
> +                  __func__, address, ret, physical, prot);
>   
>       if (ret == TLBRET_MATCH) {
>           tlb_set_page(cs, address & TARGET_PAGE_MASK,


