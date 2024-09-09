Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36FECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snibf-0004Ru-JE; Mon, 09 Sep 2024 13:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snibe-0004Mp-3L
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:55:18 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snibc-0000Ro-Hl
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:55:17 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so248548566b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904515; x=1726509315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ScVwQTsTwyqmTUNO5KCubBganFb8MMc0lzuzdGsr4bQ=;
 b=Vk3/djacP1vJLjzF3NG2RR48Yp/4Kjj5LcI/uNj3RTfW3cMFVbLSONBubyyR5bulGU
 3FBBOs6H5qfXewIbvX/GStXfMVjaC4DA2wjkD95cYV89F1jiu2tX//Qg4Q1sU8DJCF8i
 5yM6neJbM2IF31jUoJt1mOfvmMMw1PDFCk1yqzTvGzDSplfw9Dk0TVRETt2xTKTFoEiR
 2pHuV2DsdZKAZDhsOVD0gYJXg+6bzC410uQ4OVVvzCoDJo74QpqdblJHD9HuCKf4QDAA
 dKsrwnjcHOOBIkX6jIEqB0MV1mk0ubhhhynYor33fXFs1v27oDN6aSABruf8CS3iPSjp
 fykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904515; x=1726509315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ScVwQTsTwyqmTUNO5KCubBganFb8MMc0lzuzdGsr4bQ=;
 b=FAVLoh3ALTmu+WItyBYyIG08e2x0Cm0O/Hofd2/siYm8UmbhPM5uiDdgh6SJU1aQXW
 FIFirhVaoQ7mc+Ilx8nXlCFkpByywtqVUTosmJgREhiqFMzRGqACGAu6PAUcUWaZh7b1
 KRh95GTo78emhAVrqARAaqL3xb2BlN5YJCNADx3aVv9Fk5eE1lfyFgFaQ4Sy5kiOMlF1
 Uhy+JXvPRmkvRAZwq/nhLhaXMcbEq9PFfnJFWzsf1kv+0dfuwvGVfFklDRGItslrAy/y
 03jPI/F8Duw3Pk31JMFRXjEtg4J0OU9qu0IrYFO8wuQynVw2AojeilTeLAJ1ywcWrZdg
 kQ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYERy2nXhOFU4N7yPiBODI726X6WStEgDqv6K0yBJVqhXDl17OoPJ5iShGxYrq2vp8m14z5mKyHca/@nongnu.org
X-Gm-Message-State: AOJu0YyzyzxkJUp+UOSQleZE5BiDj9wSqsxJkwLS3eOQCoh0/eU+KsYn
 Ks5hzKa2cSnmTUKUN+yiyf1XNhh+XdjPZctbm3Zu/CpoXbZ0Vlf6sl09aJxHPpg=
X-Google-Smtp-Source: AGHT+IHosWvwZxTEA8L2RM7+klVkqjxIUpLfUZOBFQcJu/JAZka9nB2gCjuqcRq/a9bLaIGjbTmuSg==
X-Received: by 2002:a17:907:3e94:b0:a86:7199:af37 with SMTP id
 a640c23a62f3a-a8a888d98c3mr885900666b.58.1725904514958; 
 Mon, 09 Sep 2024 10:55:14 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c726f8sm371173766b.121.2024.09.09.10.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:55:14 -0700 (PDT)
Message-ID: <fb6a9994-fab5-4045-90f0-d08815743458@linaro.org>
Date: Mon, 9 Sep 2024 19:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 45/53] hw/timer: Remove omap_synctimer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-46-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-46-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the omap_synctimer device, which is only in the OMAP2 SoC.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h     |   8 ---
>   hw/timer/omap_synctimer.c | 110 --------------------------------------
>   hw/timer/meson.build      |   1 -
>   3 files changed, 119 deletions(-)
>   delete mode 100644 hw/timer/omap_synctimer.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

