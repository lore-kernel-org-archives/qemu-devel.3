Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF303C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc1sc-0004QL-Cg; Mon, 19 Feb 2024 06:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc1sY-0004Px-Mp
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:32:10 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc1sW-0000cB-Tw
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:32:10 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a3e550ef31cso123752266b.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708342326; x=1708947126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NkTnDg+o7EBKrIpIWufvbH2ENBmFowDp9zzc7viSpJY=;
 b=z7lxU7el6VO4FPbrijzwedAZiLUTbdEgvGaQ4txAfpjIuwTsEL2aaNhpqDdf3wDqRZ
 eyYCZ+qmhN+q8aCrjoT69gBkCFWIIhNH64qN8Ldg7u/ckGdsN5RED9JI1mbW4qssvsob
 P0IkivdyRJH7I25+pUJ+ZGycHgTLIKkE3YL34NxeO9WAbK3ozk32db/q27LfVaUlfJC3
 on+PHrXPnhcpwuVIkuMUhB2dKR3lobR52TRVkUrn+9synHiWjwW0XMAFneDTj4hMukgo
 IH4A62yP5RW6YwjKWnGpgEn8Emu6+njVwnQn1DCCo9UguCJ1BX662pEGhQw7POwfnbp4
 Lr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708342326; x=1708947126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NkTnDg+o7EBKrIpIWufvbH2ENBmFowDp9zzc7viSpJY=;
 b=Yc0c/XOgmlSRxOLjnMMnUN0IssEh9RpulsHv1RkoQ1KQLRc51JykvDOg+zTYfk5G9B
 mDp1eQOvP1haEGi7NRktSQ20Icp2OAQATE04iMiq/lIGRg+xS/W2wdPq2W3qLq1gfl7Y
 MiK2SPb2QpDjC6YHGJkn82tP0oDAMCqC4cBHNQHJgHvS1y83Z7hspmE3c3ZjaDBS+eWg
 kxVAsGk61V6aY1WmdLZFy5AtGsoFbE59hP6+YOHwdb5TE1G62nUkDZJBcS9/eV2qdcSf
 JlwnpYM8uaETo4FHL/G7kt+iS/QtgYP08xh/9UWqjMrM8cxtYFmNkug+xtDTc02qwUNV
 LI2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVifpZ+KjbGkAnu5gz5knZ60cSQBRyE1T+4wCi8ETjesyiEYGXRbVsvBWyeXGRiTSuraW5gmUzHNczCmQLHXhJwLMs66hY=
X-Gm-Message-State: AOJu0YyWlpB6aJS+I1ts8Tzj52B0WUJO1Y0+ur1XW3v+SXrVmC/j5EMX
 QaxQGuRS3oCK0+WtVJYWzvWVQgmz75lhwqzBByVWy/z3obEIJAwEibA+FVsrPzc=
X-Google-Smtp-Source: AGHT+IFMupnLYV3o4SG7jyMb1O5bEOP1wucZmo/+4lLDeevm07k9yNPC5bG+KXzQ/3LHOI1+c1627A==
X-Received: by 2002:a17:906:2a91:b0:a3d:7532:15ad with SMTP id
 l17-20020a1709062a9100b00a3d753215admr7783314eje.39.1708342326590; 
 Mon, 19 Feb 2024 03:32:06 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a170906448e00b00a379ef08ecbsm2846778ejo.74.2024.02.19.03.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 03:32:06 -0800 (PST)
Message-ID: <f89c3710-5bb5-4060-93f0-84024ffd5038@linaro.org>
Date: Mon, 19 Feb 2024 12:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hw/ide: Move IDE device related definitions to
 ide-dev.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org
References: <20240219104912.378211-1-thuth@redhat.com>
 <20240219104912.378211-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240219104912.378211-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 19/2/24 11:49, Thomas Huth wrote:
> Let's start to unentangle internal.h by moving public IDE device
> related definitions to ide-dev.h.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/ide/ide-dev.h  | 145 +++++++++++++++++++++++++++++++++++++-
>   include/hw/ide/internal.h | 145 +-------------------------------------
>   hw/ide/ide-dev.c          |   1 +
>   3 files changed, 146 insertions(+), 145 deletions(-)
> 
> diff --git a/include/hw/ide/ide-dev.h b/include/hw/ide/ide-dev.h
> index 7e9663cda9..de88784a25 100644
> --- a/include/hw/ide/ide-dev.h
> +++ b/include/hw/ide/ide-dev.h
> @@ -20,9 +20,152 @@
>   #ifndef IDE_DEV_H
>   #define IDE_DEV_H
>   
> +#include "sysemu/dma.h"

Not required.

>   #include "hw/qdev-properties.h"
>   #include "hw/block/block.h"
> -#include "hw/ide/internal.h"
> +
> +typedef struct IDEDevice IDEDevice;
> +typedef struct IDEState IDEState;

> +typedef struct IDEDMA IDEDMA;
> +typedef struct IDEDMAOps IDEDMAOps;
> +typedef struct IDEBus IDEBus;

Looking at next patches, better forward-declare IDEBus and
IDEDMA in "qemu/typedefs.h".

IDEDMAOps and "sysemu/dma.h" belong to "hw/ide/ide-dma.h.

