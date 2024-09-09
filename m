Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53911ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snidb-0006cD-MR; Mon, 09 Sep 2024 13:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snidM-0005Ts-TH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:57:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snidL-0000bs-AW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:57:04 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so4923747a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904622; x=1726509422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ASf6OKEwmziId2z0p4KONvCUimuiov06dqN0ChpJkI=;
 b=stOXcRTpBF8prAZqAzGf+nWTFgTXUctqQL1UhwwqAZM/1WhTZBILJ7N6Wvd8R+Cz+X
 lRwcBJmpc1WFRXSauIZAgyVGFRKZtxJ/04S3l+LMFMG4Z8UfQfCnboegmkyOiAgNtOKU
 epu8ICfpedYq2NGGm0xPwJBYRbcdez7ZhS1QeJzftfl7ai39PqYrabwHtyC69aVw0Nb2
 fyTmvjkwL5YtOrsfUxati8paxh3CHwxjhvdEN/Jgi6uHkqZ6Oii8+rs/oYdtu2OkH/Wn
 LinBOL4Z6JFyDH9NBcwb9RnsUveouD7mEBRprwQ6ad2kk0pGPDug++dvQEIj3x9p6vNx
 C12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904622; x=1726509422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ASf6OKEwmziId2z0p4KONvCUimuiov06dqN0ChpJkI=;
 b=EHHf3BY0SllCWaH7Lkbm/VVLFnmMkBauqREs2h4LcQhRI5nppyGM0S6ioFNUMF+moN
 0JM3eGTQBMwnfw6rmwqRKdWk5v8nhjq8cvcKfw7od0jOgbZzBqbljI2v4PiOvD0eDHu9
 TRBehikegPgLip4SVMLNG7cpexTE1VuIOlirQFjHEbpUIkgTReMq6TrfF4RF5sF/nzjc
 QHfn3j524AOTTQ63RuqJ28dpvhYP6E5O7kcbwrvoZf8l/MGvwXOEqC52rF6Zr6Si5S4H
 UFgZkFOhIWb2qwNmj8rdyAheqe+O6IzzlW4e2z77v6Y/WsjqUfW5r835O5Jcl5+e/OL4
 O+dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx3cJJZ9fU/BSVL6KBQuFyjnkoaGmFby1qVfw67VrLJNbo0sIhLH8aMHBLgkZcww8wqSZL28v3FSwU@nongnu.org
X-Gm-Message-State: AOJu0YzlL6weAkS/vyIYXoPZWqaWVh7yF7VcKjidkh/6X9EWHmZtS15c
 KBYM4SuPGadJQy0+Aa6tIl5OAsDxAl9XZxv5cIsryh7n+P80EUWQ9d0x+TYOQis=
X-Google-Smtp-Source: AGHT+IFgDZdOiqJr0meU40WNH7evSaqa7M8jx3WnQibex8+fiRnqN9/JUK/deBmstOlEejsJX0wN2w==
X-Received: by 2002:a17:907:3188:b0:a86:6d39:cbfd with SMTP id
 a640c23a62f3a-a8a88858b3cmr853965366b.57.1725904621575; 
 Mon, 09 Sep 2024 10:57:01 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d64880sm365718966b.219.2024.09.09.10.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:57:00 -0700 (PDT)
Message-ID: <e39f8b71-f8b0-4679-b970-0eb1ff7c62d2@linaro.org>
Date: Mon, 9 Sep 2024 19:56:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 50/53] hw/misc: Remove omap_l4 device
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-51-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-51-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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
> The omap_l4 device is OMAP2 only, so we can remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |  42 -----------
>   hw/misc/omap_l4.c     | 162 ------------------------------------------
>   hw/misc/meson.build   |   1 -
>   3 files changed, 205 deletions(-)
>   delete mode 100644 hw/misc/omap_l4.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

