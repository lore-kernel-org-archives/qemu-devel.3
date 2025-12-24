Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C19E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRDG-0004Pq-CN; Wed, 24 Dec 2025 10:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRDA-0004Kj-LL
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:55:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRD7-0004nT-VO
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:55:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so59109905e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766591736; x=1767196536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=npEbExO2NPwcQFEpbQtKNlF6vQFYnvhFMMub0gaojOc=;
 b=qCKZ+6FrBgMeiAOHndLjNjB7WrOj1ctFr28PSQwwL6XV9by2laHpuOZ9ONBiZCFpCh
 Ndp6Ewth71VjhS/lnngkBZaq+ftOtlItuklP6XC1TlW/4De6mQesVQMRT223hJy0SvE9
 yrLpupWOXcpu+WMCEblfbmy7J3WUKlvLQKS006W3moCITus8vRhaz4RItC5RsosCTYnB
 dYOGV+lmhgeyUCowICKT0fcH3cd1MnaOuvzXMG3q2Z7x+NnAAFi1QWRPGlQzL9JeD87+
 5xCO8cRR0dsMFZO+ljGRZtyGDXg+vXyBPamee70o40uSBNj9HiCaz1ElleWHdYEJTSKT
 3w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766591736; x=1767196536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=npEbExO2NPwcQFEpbQtKNlF6vQFYnvhFMMub0gaojOc=;
 b=NPqO8lj8J2qrw5P6Bjy3p8oPw+rzQa5i3NHc9MDHuQbDqcMGBnQu3U+y/IcsapsehY
 iAQXC5I6bnWOAk3lZrywbXGqXMPvmzyYR85nMzvKFFhyDH6sRBAH2vQvmK1iOlaRNp3q
 7MkjGWk3gFCzvXtft6iIgS16kdQg1CEgff+lrtzeT1NcS9rSC1N7BylQ/gpnworSJ6xH
 scsA20T503bVOnzLDFgjBUGxXNJnQtAZKKszsg0BzXRMMNXzFS3remk4tsI0kL5Ot1/8
 YBj9gs888k/SfxRJofwwLPbrM13yyE1Mb6tIy3n+kPpA0O55grq7EpHWrkgaWxPoMFdb
 GtwQ==
X-Gm-Message-State: AOJu0YwxHwNAhEZfMCfDVkRMxEZa7NMb/5VvkcknLeR0g80DwiEUZ9ZB
 E8pU8e0r3lT2K9UVhzpxdwPxnheV6EQLqe7bhQ7NrT5nTBJ1HLgkPgvfmoUJb/8UQT5LPN4axUX
 vQoT3CNE=
X-Gm-Gg: AY/fxX6K29+S9Kp3B9qEhUkv2Q9F/Z2/LpWuDSLpA2jinBLi6KoO/tt6dGCLGnTV+ZX
 EeSaItI4oPEoGqI6ewjO7fEWARdfyre6JT4aI8/JuOYkNh7674uM1MixPqFYisSBJi2wDORgM+g
 54T4ydfusV/hcWFmopqn/fOnNWgOuHyvPZ83XAb50Z8sqbs1kN0vnXboIYcJbAbtI9qvWaqNK13
 XQ+O4qffOnWWN/Dj8SSYo7O9UeRqsjmkOTHniYWCCM5zZCk9Jma9K1IQY+rp2BDYp9eBiSN18Hn
 GBpkwPF6U8nG1pAgAeT6yraC1csoa9WEvz+aZUB6nTGePmPrc56BAIK6ITcCBgKBGsYEZ1x0fhX
 phwV7nHcWEc7j7gafanuFH5hR2xBcBJU0LtYn0mVCkZyMg6jWiK/LUZxkk4DdGWlhiHA0pkSd2L
 7LtWRu9xUTfFw5eSnmQDZuUSotCIeh8fmNEq+/CVTbxwK4
X-Google-Smtp-Source: AGHT+IH6YrP0J7OoNLwUVIhNEOOPWCTfWqIOTI8ZSx8Bpr7EAFysGzuq3ZWayQGGhbHdz1UWTDjoaA==
X-Received: by 2002:a05:600c:35c1:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-47d19553912mr223584775e9.15.1766591735986; 
 Wed, 24 Dec 2025 07:55:35 -0800 (PST)
Received: from [10.156.6.66] (188.171.88.92.rev.sfr.net. [92.88.171.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723d19sm381168325e9.2.2025.12.24.07.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 07:55:35 -0800 (PST)
Message-ID: <16ed1aa3-ada4-4c66-8e22-8d1a2fcf6b62@linaro.org>
Date: Wed, 24 Dec 2025 16:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] hw/misc/pvpanic: Expose MMIO interface as
 little-endian
Content-Language: en-US
To: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251224134644.85582-1-philmd@linaro.org>
 <20251224134644.85582-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251224134644.85582-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

+Alex/Phil

On 24/12/25 14:46, Philippe Mathieu-Daudé wrote:
> Make the PVPanic MMIO interface behave like the ISA and PCI
> variants: access it using little endianness.
> 
> Fixes: a89607c4d0e ("hw/misc/pvpanic: Add MMIO interface")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/pvpanic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index c83247c4087..3e60b226e18 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -62,6 +62,7 @@ static void pvpanic_write(void *opaque, hwaddr addr, uint64_t val,
>   }
>   
>   static const MemoryRegionOps pvpanic_ops = {
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>       .read = pvpanic_read,
>       .write = pvpanic_write,
>       .impl = {


