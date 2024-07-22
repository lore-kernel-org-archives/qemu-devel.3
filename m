Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB0BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrzz-0002zf-I8; Mon, 22 Jul 2024 08:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVrzr-0002Sr-HE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:18:33 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVrzo-0001vr-5v
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:18:30 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efa9500e0so1826878e87.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721650703; x=1722255503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nAYQf5D48DFLt9cwFqb/2mZtQgNYOqa+v7g18kjzPNs=;
 b=cz7/zuTyMF3Aj/9B/E9/P7w4TlqHCNFVjdfdgqvN5H+E/ATybImNQwSgJ2/CUSKj6N
 M6pjHhjJHra9yke67xZCvxq45wZEuDGUNqA87bYxsEfi/iUkctItbrs/PUW5u5BqSbib
 Yo8om84vSqrSoYzPiC5i8PKtWg/0TZjbunaS8sUP0uJVJZ3Tz7k94htiY1gOtC2Xi8TM
 5iYAkA35cjjl4GD5nS2YBeZJKxNMLCYWd88aF5ztqXxw2T9ouUszIWG1CVbSUHcwsxtL
 H2I2TEiT1LncV/3a386787rB7G7Yr4k7nKj8+43MPRnXxSjz7hiQHNFRO8gA6O2pmDBu
 Vsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721650703; x=1722255503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAYQf5D48DFLt9cwFqb/2mZtQgNYOqa+v7g18kjzPNs=;
 b=md5PrTBgoEA0TRe+EncXLajREciRLpdSnfzsReZbl6pQmO4sEcZF9qR7BtQhnB9gsG
 jNqI46L2Y0a0RI+gcrnxCdFeI7wLEq/TUmxKNzigs9OoLP9jl97tk6eX+A7mBESekWEk
 BOAsl0q8UYUxWat9sy9BfKnRHfCn14PI9P2eMx3foRmEZiWBBxmO8WrOvmzDPE4OyD/v
 ZwFQwZtQznAUp2bTRCP4b7LzqehLF6YSViaZsY2MDcsSI0HVhtKavsSkt8L1pKRgmxrM
 /SvmFkMLQa29VSgRGvEuYpLSIpXMSgXKD7GajaXk7jrMRAyorarIfbhYaI0vlhQgPcAs
 Khzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpSvinZJxmOpz+kLqcwPA/EI7tJWdL9OcjrjytLFzYS0ou3WnuRHytI68PT6KpV8uKZdj3HDsCQWSgQoLHIdnYvauC+tY=
X-Gm-Message-State: AOJu0Yy+k1hO5y4+goshG6ScUbhK3lf3OvixYsKCd7BmfmiWYd+TRPEy
 +CeVMYiAXASv9o4LeTmPpxoY9F90QjJSbJIgw1YCFCoSGZdP7L9+TjIjce3ff6DyrDBNTw+Eg18
 +
X-Google-Smtp-Source: AGHT+IEZASNFKQKCHOyyjz2ZCVf21ECbb5vH56YPAH6p7I4MAwKkT4c+xKK7pAAxpL6dIbAySEjWBg==
X-Received: by 2002:ac2:4e10:0:b0:52e:f4b4:6ec1 with SMTP id
 2adb3069b0e04-52efb7c847dmr4102432e87.46.1721650702863; 
 Mon, 22 Jul 2024 05:18:22 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ef5578506sm1207900e87.295.2024.07.22.05.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 05:18:22 -0700 (PDT)
Message-ID: <0450331f-7bf2-4a6b-9503-d3b13229f216@linaro.org>
Date: Mon, 22 Jul 2024 14:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] sparc/ldst_helper: make range overlap check more
 readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-9-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-9-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 22/7/24 06:07, Yao Xingtao via wrote:
> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   target/sparc/ldst_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 2d48e98bf468..d92c9f15934e 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -19,6 +19,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
> +#include "qemu/range.h"
>   #include "cpu.h"
>   #include "tcg/tcg.h"
>   #include "exec/helper-proto.h"
> @@ -240,9 +241,7 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
>               if (new_ctx == ctx) {
>                   uint64_t vaddr = tlb[i].tag & ~0x1fffULL;
>                   uint64_t size = 8192ULL << 3 * TTE_PGSIZE(tlb[i].tte);
> -                if (new_vaddr == vaddr

Please mention in the patch description why it is safe to remove this
equality check. With that:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -                    || (new_vaddr < vaddr + size
> -                        && vaddr < new_vaddr + new_size)) {
> +                if (ranges_overlap(new_vaddr, new_size, vaddr, size)) {
>                       DPRINTF_MMU("auto demap entry [%d] %lx->%lx\n", i, vaddr,
>                                   new_vaddr);
>                       replace_tlb_entry(&tlb[i], tlb_tag, tlb_tte, env1);


