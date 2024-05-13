Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8FC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Tsk-0001sl-44; Mon, 13 May 2024 07:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Tsg-0001pL-Tm
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:30:11 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Tse-0000U2-EI
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:30:10 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a599c55055dso1079855566b.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715599806; x=1716204606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZmLvRXK0FCwWlt1B2QRZCqcVYxltvjjhpOY+E1LmgE4=;
 b=Y/7rHvLsz2u0wttDDZXm7UuCKcdmOJevNsALDc8Do2tpA38KObEYn1LyVCVTUYlSll
 z0IjUY/DDy29YtNGGQAadde80Cpxx9BmvvkyhoL9jx4jmAk4+hrfGEMOoEo8j26bLsVK
 uEik9zymgHlLCV/ls7tdlPuy4/rLC9Kq1C5QE7sHkUPM2LTUIVFEkZtzJkPYWixOa8Xm
 coU7KAQ2Gnt2OUjscwrmSPRsZwUfOfxgKH+R5iKZvWe+Olocx9VUN0AFLuzz4LTii4Oy
 Q1WB7vBr/gZ5poD3vUldCWtMYqUUkB+N72fEbz/GodbU/pvMzWYH9YbGMIThW+9bkFI1
 GTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715599806; x=1716204606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmLvRXK0FCwWlt1B2QRZCqcVYxltvjjhpOY+E1LmgE4=;
 b=lwAPBy8mTS//segAGHDJ9NARROIz6E7e+PB+CApIKjjMPLaz5y2dxEzk1jHHRsrVje
 SfjRGkJVm4KXMD3PTNEvKW146De5xmUvaLomu5gtDOO5M5GYmE4QA2K3TVIALNIp9zdq
 XDMRiOYYn9AMyZM+1y6i3mmewBsBE2RmFg+htcq8JEDdM8DokpJjwOCljnRqSVxoC8g6
 Xypl7CtIJgqxBL7TiRyVw1SqmTFQ4Uvl1TNSbPpsUBhfkM+1jXzS6miKYXbehNyLI0gA
 tXrut6gZoluBbllO1TYChvMf94ZivtrMDeRsKeQ1v7LrH9yvBtXNAqA9MleO9Zc2bQj8
 MOWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4fcn/yRVuSctwUImcAwl1IgyQlYupKHGrk2eekgP+w+8WrpbzK7RmpT06waqA1rmK6Y3I3r3mUao8UuzhFP0ESkcRf6E=
X-Gm-Message-State: AOJu0YwEZi77ibIsnA+7qVe83khsfyGA+4pq9wvfTqB5B/Ya1LjsRHQd
 8HdWVjwFf+RUJP1G811BllS70rcN1482aSwFJztaMSKzP/GRG/SKH4uVX1OZEPA=
X-Google-Smtp-Source: AGHT+IGBKXkFRFvZYQhxjkXXV9Y9/xze5o8Sa1h1x/4Ff4sbuAZej/N8MQDj+Oofch31SsIWxyFqmA==
X-Received: by 2002:a50:9b4f:0:b0:572:3b15:a40 with SMTP id
 4fb4d7f45d1cf-5734d67eba3mr6906023a12.33.1715599806583; 
 Mon, 13 May 2024 04:30:06 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c323887sm6195805a12.89.2024.05.13.04.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:30:05 -0700 (PDT)
Message-ID: <c77aba57-19cd-4724-83e2-6d5a289de4b7@linaro.org>
Date: Mon, 13 May 2024 13:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/timer/imx_gpt: Convert DPRINTF to trace events
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org
References: <20240513101108.5237-1-shentey@gmail.com>
 <20240513101108.5237-3-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513101108.5237-3-shentey@gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/5/24 12:11, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/timer/imx_gpt.c    | 18 +++++-------------
>   hw/timer/trace-events |  6 ++++++
>   2 files changed, 11 insertions(+), 13 deletions(-)


> @@ -317,7 +310,7 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr offset, unsigned size)
>           break;
>       }
>   
> -    DPRINTF("(%s) = 0x%08x\n", imx_gpt_reg_name(offset >> 2), reg_value);
> +    trace_imx_gpt_read(imx_gpt_reg_name(offset >> 2), reg_value);
>   
>       return reg_value;
>   }
> @@ -384,8 +377,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
>       IMXGPTState *s = IMX_GPT(opaque);
>       uint32_t oldreg;
>   
> -    DPRINTF("(%s, value = 0x%08x)\n", imx_gpt_reg_name(offset >> 2),
> -            (uint32_t)value);
> +    trace_imx_gpt_write(imx_gpt_reg_name(offset >> 2), (uint32_t)value);


> @@ -49,6 +49,12 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
>   cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>   cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
>   
> +# imx_gpt.c
> +imx_gpt_set_freq(uint32_t clksrc, uint32_t freq) "Setting clksrc %d to %d Hz"

'%d' is signed, for unsigned you want '%u'.

> +imx_gpt_read(const char *name, uint32_t value) "%s -> 0x%08x"
> +imx_gpt_write(const char *name, uint32_t value) "%s <- 0x%08x"

I'd avoid the cast and use uint64_t/PRIx64 here to KISS, regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +imx_gpt_timeout(void) ""
> +


