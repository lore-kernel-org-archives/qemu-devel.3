Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AADEC19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4k6D-00081V-LQ; Wed, 08 May 2024 12:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4k6C-00081K-9n
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:24:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4k6A-0008Fp-CD
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:24:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41b79451153so35813985e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715185493; x=1715790293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQVQ9a5/LPHfOM4Jm9gfp6a8oj6hk4reUKjxiKFEQiE=;
 b=QWvF0IjUiZ2S+4GUCmsJnceu2ljJh8umEmrjwf0IYZGyETASNejD17tOTr7HpmPQmr
 I1F+EARh4bfj3YOSiMgU/rH2X85KaiveQEr8uKTErNtBjHunraqP6XqaAFa/1CxUhs8a
 nDNXBQ9xwvK/h1TtC6GaO81N0SoYZodsqdSTvkSLm0X0RQXRHHqHNvQXk7eSJyjrFEZO
 Oc4B++HcoacgKG42mNXK3y3O/+eJeaVFmQW19WPLViWMwax1EXF+Re39pCsR704L1Qvd
 80d0kcU623/ZMSpWroDWI5DpfQpGK7pvBUbJKfElMXuUVAt8+jOqcO0lGK7jVQMK5Td2
 pN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715185493; x=1715790293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQVQ9a5/LPHfOM4Jm9gfp6a8oj6hk4reUKjxiKFEQiE=;
 b=YS2XRDjnpsO+aOSrOkW04u5C9X4sHK+XyqfY588Hkdz7OK2sSDgPQ3IjH92+RhEga4
 YiePidCMrCmow/4J0nzPCcA1M0MrVfhqe/Jmq7PTMmQ3Tn+a5g9/pa1D6iIWvdoCmGP0
 9eSw2RBAhMjHH/SKNj/Pgqg9Ccy+DVXqOp5S1ZIcUEQe6AaIcmADxQlGPmrW1e7KOtk7
 1wn+U7ABqXS4AEa9ARUOWPJUCNNrnUxaIiK58ut8N7DLfCPvBV2RZZgscOqL1SsPmU8i
 bIiPiRrLKhMiJ8VxpXW85aSWkYwhgeEKvwUU36z0YU9ri598HAOmAlPskN8WYBRsTc7O
 MaYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUabhQ/LJKOCitLBcp3/bIuyi/Cculcm2HQ+AG4r+GTBOOIaw+fX/pdS64dkCYrWuzRmdypaLNlsMMMsqc7d+wB7fqCNaM=
X-Gm-Message-State: AOJu0YzNgYypIZ95Y/qpHzHsm7ZaWt0Cqx2TIbbkvW2SaKalp+J57uSZ
 NWaZNAE6rfuGbosAfxjz5gOLTRGKTSF6MGKs6u/l3mM/FoAR2aaHZWkTR4cpYno=
X-Google-Smtp-Source: AGHT+IHpbuR+jN4ApOfFR8yWYz30DkRwzsnHbgxpVC1fkQH2f1QaCimbtCJ+kwMiwOYNS9E49+bLhw==
X-Received: by 2002:a05:600c:3511:b0:41b:f022:8e69 with SMTP id
 5b1f17b1804b1-41f71bca2e1mr24696445e9.19.1715185492817; 
 Wed, 08 May 2024 09:24:52 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 h21-20020a05600c351500b0041be4065adasm2847114wmq.22.2024.05.08.09.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 09:24:52 -0700 (PDT)
Message-ID: <43a6ad48-49b0-499e-8fa7-2d391fc6a4bf@linaro.org>
Date: Wed, 8 May 2024 18:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] hw/intc/loongarch_ipi: Rename as loongson_ipi
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <20240508-loongson3-ipi-v1-2-1a7b67704664@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508-loongson3-ipi-v1-2-1a7b67704664@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/5/24 15:06, Jiaxun Yang wrote:
> This device will be shared among LoongArch and MIPS
> based Loongson machine, rename it as loongson_ipi
> to reflect this nature.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   MAINTAINERS                                        |   4 +
>   hw/intc/Kconfig                                    |   2 +-
>   hw/intc/loongson_ipi.c                             | 347 +++++++++++++++++++++
>   hw/intc/meson.build                                |   2 +-
>   hw/intc/trace-events                               |   6 +-
>   hw/loongarch/Kconfig                               |   2 +-
>   hw/loongarch/virt.c                                |   4 +-
>   .../hw/intc/{loongarch_ipi.h => loongson_ipi.h}    |  12 +-
>   include/hw/loongarch/virt.h                        |   2 +-
>   9 files changed, 366 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


