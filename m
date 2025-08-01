Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD423C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 07:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhjv3-0001QW-4q; Fri, 01 Aug 2025 03:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhjtE-0008U6-KP
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 03:09:18 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhjt7-0008OQ-9P
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 03:09:15 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-31ef50d8d57so347584a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754032143; x=1754636943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RiBPygWw7NI2DOpExLRAwXOFFeluA8xLarYe/OSRtwg=;
 b=Gs8zT3uMpPZCcmrZocQ+lgUtZSUAFd/yLqJi2Nb6qDzGyt7pQWmmhX4kOhmuMbkMZ+
 NUJuGUpGTvSLIDXG3GGW07+A/1PvRQ9saGWs8pGejHsXvznoWo7Tsav33M4ovLqTPVBn
 iY/UaBe8nEBbW1UaF3JuwDsYoxQA8Ef+RlPhXxC+5YM7Z14O+VbYTqModKVpGeFQUZP+
 H498+rtqYliO4SFWHyKm8m+aPS/1IFsW+nDR8aKXwHObICxKyTfv4nuCPLocmEqT1lrn
 wfAyHwdsIWf3Sfzd1FYTINGxngijuvzirwfrD34ElaQW5Fkkv9ncDv/AsfAzZdX6MHkf
 8JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754032143; x=1754636943;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RiBPygWw7NI2DOpExLRAwXOFFeluA8xLarYe/OSRtwg=;
 b=I4I5XyQOi8VKEBwn/CTKidctvTaDoPzB/fGaaw3D9E/VjpeTAE9x2dXK6uz60oIAST
 1vVT3kSH28JBvvKO5+orAZYH4v85djzXNFChFhJSTctIbgYJSpmqDpN9EovvRAHq8GL2
 pZVYLO1Y6S/wOY8vUtv5eYLe3LX9PlGghv4uiFpPCQTx7E7oZOqbVMPzzxqZyfbBaN8p
 PQlBxK1N6CA5dRAOHvk8J5TNGBS7ryl2tMFTOFNi9Eh9/0MqZFtQtkEzcnYk9Jeir9GE
 +S0/PZsjVJa25D7iooPy/6LPvQpSFLT7sxOswJBbqqSy8e9jE8xcH+Qfa89AyBslbhI/
 DeGA==
X-Gm-Message-State: AOJu0YyGBbSL8XX+tcN1FBiukc1p/vCy69T/eH4ZDt9hU1wAVUWmVSqL
 zRiR5xH0HvAOPDGH/QL6JLSoS3L1CVo5l25cU8jG+7unTluRH5FU4fvRDtlB7Q3ZtFQqz1C/RPn
 LUIs0oLk=
X-Gm-Gg: ASbGncs5CvMywRbigh4WRZUEH5/3IBcRd8Orl6dJLVeMBeN1c1mMzODoYDfNdf5UKlz
 h/ZpigB/sRnUVh3jNKGuZj4TwNg0/Hb8lDIyV1450CFztKT8TvWnTDCRfgdXoyUrpzixWOiXsNN
 J8wJ1jClidkfONPR4V+WqYh0kmNNx8MfsWQEEamPmsWjZwVKXx1sro9kyGhlegWqGwWfvV0TUjs
 WHlYHkDoPZfHTdvnjAMCgPVAWTRwYTNRc2gwrwP82DlnoVhmzT6eVqsAyoHmXYDJklZRUBuB8xI
 eG3NeQTt107Pi8JHfHdCHB3j7hBGI+EeKlo7FVncLB4Vo91N7hXw2kkNweRv1vY2yTWbhcp3354
 t+EGUGElYoJwstmhMtGBf/maclejagtCIQuhhLQlwkA2CGay8oiA=
X-Google-Smtp-Source: AGHT+IHQ4bEOePPFrcabSuHtIgHc7Afy2m45d7R4Ex19mLjPiYAOFlDxDXXNbnduHYfBAugXsfZzkA==
X-Received: by 2002:a17:90b:1dc1:b0:31e:e3e1:3686 with SMTP id
 98e67ed59e1d1-31f5de31435mr13299071a91.19.1754032143296; 
 Fri, 01 Aug 2025 00:09:03 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207ebc3266sm3819979a91.13.2025.08.01.00.09.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 00:09:02 -0700 (PDT)
Message-ID: <58205293-8d2f-42ba-b7ed-6d91f1c16bfd@linaro.org>
Date: Fri, 1 Aug 2025 17:08:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 02/11] hw/sd/sdbus: Provide buffer size to
 sdbus_do_command()
To: qemu-devel@nongnu.org
References: <20250731212807.2706-1-philmd@linaro.org>
 <20250731212807.2706-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250731212807.2706-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 8/1/25 07:27, Philippe Mathieu-Daudé wrote:
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 226ff133ff9..f1e149f46f3 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -346,7 +346,7 @@ static void sdhci_send_command(SDHCIState *s)
>       request.arg = s->argument;
>   
>       trace_sdhci_send_command(request.cmd, request.arg);
> -    rlen = sdbus_do_command(&s->sdbus, &request, response);
> +    rlen = sdbus_do_command(&s->sdbus, &request, response, sizeof(response));

Change rlen to size_t to match.

> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 6c90a86ab41..3aba0e08ffe 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -146,7 +146,8 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>               /* manually issue cmd12 to stop the transfer */
>               request.cmd = 12;
>               request.arg = 0;
> -            s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
> +            s->arglen = sdbus_do_command(&s->sdbus, &request,
> +                                         longresp, sizeof(longresp));
>               if (s->arglen <= 0) {
>                   s->arglen = 1;
>                   /* a zero value indicates the card is busy */
> @@ -171,8 +172,9 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>               request.cmd = s->cmd;
>               request.arg = ldl_be_p(s->cmdarg);
>               DPRINTF("CMD%d arg 0x%08x\n", s->cmd, request.arg);
> -            s->arglen = sdbus_do_command(&s->sdbus, &request, longresp);
> -            if (s->arglen <= 0) {
> +            s->arglen = sdbus_do_command(&s->sdbus, &request,
> +                                         longresp, sizeof(longresp));
> +            if (s->arglen == 0) {
>                   s->arglen = 1;
>                   s->response[0] = 4;
>                   DPRINTF("SD command failed\n");

arglen is int32_t, and the comparison <= 0 is now wrong.


r~

