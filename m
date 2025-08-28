Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95103CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOhp-0006S0-MF; Sat, 30 Aug 2025 12:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1url1D-0000U6-Dn
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:22:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1url18-00013R-HK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 18:22:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3c7ba0f6983so914132f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756419767; x=1757024567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mNQRzSAzy6KyWZYfTJ0AVWqmvWU67KGsSIif9jZcJ9k=;
 b=CinL5wQdiQBJVHT0c0FlRrfHAnIS+2Qs9dT7tC10QpmieDRNakMLqLhkOfz7DlOHHT
 IlzLth2cg9flarWVhfVjikuxsR1a5ftDERAhYsDRg3XA5sRtRAfY0MWHINVJK4xq0nTh
 OaL7QcItCRxHxPh/+jtf5RccfynjPs/9LVeUhF9gW6/hhemPpiqCuKh7FoUpXftMekI5
 PsVHPvkndHG4yE5RIgYSjmeCj78W6ZXbrlnzqW/i29v119PzWeK5IodrC0FQ+cQbQ8KR
 hHaf7VdervOS26wU18bG9ugRiJNZqmt3K/epHZP+8xNdN7Lec+WvawvutNPE7ZufSg6m
 5EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756419767; x=1757024567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mNQRzSAzy6KyWZYfTJ0AVWqmvWU67KGsSIif9jZcJ9k=;
 b=JaAypurE9364uc47Uhw3qJv3BWP7IbSJnaSS7yGFp/RhVBAqB5Dkcq5bGzNbJuct7o
 hLxxFHSHIa8eKUfKAlDuw0MwS0faP27k0UFL1LX4iQa8o5w17vXdEVvJIAIPXy7RCjSu
 zgnZd+7tmos9Lk/aohVcw0uHNm+quDBkpxcsYGMfZ1kqFD8/+HWpAOZo9r8a+0rLv/rm
 A3NdDePPtNmqVOT7bd93xi2faeDWPH2HF6Z/+vVPMZf0ZiqQvd/eSJ2+iZsp5dG/uKun
 ldddgkCtfNyg/OZxdgIRLbSqqKW8Q6riyxXji3sO4bt/PdBwrNQSI/v8fNe/KT1FEji9
 s2Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC29w+Eu14vAcUWaWylD4Q0s5WVhWIBZXN3ExTk0xPlxyPOePj3MU3gVZDqOzsYT2oEyN3k/FKRDuI@nongnu.org
X-Gm-Message-State: AOJu0Yz4k2IeVqREqau4lMHmwnmRmjj0dFWOP485ClGe1L1v499Z607W
 +aiPfDgum4A9OXUqBxV6dBBFQ9gV2UA2e56sZbjaKCdiQwaqDN2AN5ETTCqRHrsaRXs=
X-Gm-Gg: ASbGncvdW4oWAMP3/gbLYLpC/TSyysgqjYpHyne5Mix93OuJpxs11HtnbUIVykISWaF
 kRtDsfvOS+SjVjNQjiLn5q0LBcTRMWD59KUO26BwW3P+XhNButwV5jW99LXqKFb9B8Ixuw/wBKY
 rpt1z32EW4ETSzPcke3gingX44mNBx8gQwBatn0Zi5uy5bGhkIEmC5cJXuKBZHgeU5ZFyPZy6b0
 CAn4jH6VTzHh4dSWW/fyM0eyCzmOXIO5JVN8JNvK1C9rQq8gXXFXCJFmEs4UxCyvsSg4TU218yf
 wD48gHP3v1oZ5robeIS1KZN2ytuHVoyW3zXeCvw9bu/DZArhNNiXkCTRzqdbhsN8tzMxRNz65qU
 qJikQdC4pLUtto3/4DR4NgXvPY/XG6GFrVVbts3qOJ3GvCKi16VQk48+SUGaa1HaANQ==
X-Google-Smtp-Source: AGHT+IEmvQ6v4+OqIhe7+M0xUh5l0EQtWrbLQrwa4BM1RyiwlGGaZu36YO0k5fbUFIFjx1l9JyHqBA==
X-Received: by 2002:a05:6000:24c6:b0:3b9:14f2:7edf with SMTP id
 ffacd0b85a97d-3cbb15c9fd1mr6976120f8f.1.1756419766703; 
 Thu, 28 Aug 2025 15:22:46 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a65sm792450f8f.56.2025.08.28.15.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 15:22:45 -0700 (PDT)
Message-ID: <f5aeb950-47b6-47e2-8b6d-cdd01004f1f6@linaro.org>
Date: Fri, 29 Aug 2025 00:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 36/47] hw/misc/xlnx-versal-crl: add the versal2 version
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-37-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822151614.187856-37-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 22/8/25 17:16, Luc Michel wrote:
> Add the versal2 version of the CRL device. For the implemented part, it
> is similar to the versal version but drives reset line of more devices.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   include/hw/arm/xlnx-versal-version.h |   1 +
>   include/hw/misc/xlnx-versal-crl.h    | 329 ++++++++++++++++++++++
>   hw/misc/xlnx-versal-crl.c            | 392 +++++++++++++++++++++++++++
>   3 files changed, 722 insertions(+)


> +static DeviceState **versal2_decode_periph_rst(XlnxVersalCRLBase *s,
> +                                               hwaddr addr, size_t *count)
> +{
> +    size_t idx;
> +    XlnxVersal2CRL *xvc = XLNX_VERSAL2_CRL(s);
> +
> +    *count = 1;
> +
> +    switch (addr) {
> +    case A_VERSAL2_RST_RPU_A ... A_VERSAL2_RST_RPU_E:
> +        idx = (addr - A_VERSAL2_RST_RPU_A) / sizeof(uint32_t);
> +        idx *= 2; /* two RPUs per RST_RPU_x registers */
> +        return xvc->cfg.rpu + idx;
> +
> +    case A_VERSAL2_RST_ADMA:
> +        /* A single register fans out to all DMA reset inputs */
> +        *count = ARRAY_SIZE(xvc->cfg.adma);
> +        return xvc->cfg.adma;
> +
> +    case A_VERSAL2_RST_SDMA:
> +        *count = ARRAY_SIZE(xvc->cfg.sdma);
> +        return xvc->cfg.sdma;
> +
> +    case A_VERSAL2_RST_UART0 ... A_VERSAL2_RST_UART1:
> +        idx = (addr - A_VERSAL2_RST_UART0) / sizeof(uint32_t);
> +        return xvc->cfg.uart + idx;
> +
> +    case A_VERSAL2_RST_GEM0 ... A_VERSAL2_RST_GEM1:
> +        idx = (addr - A_VERSAL2_RST_GEM0) / sizeof(uint32_t);
> +        return xvc->cfg.gem + idx;
> +
> +    case A_VERSAL2_RST_USB0 ... A_VERSAL2_RST_USB1:
> +        idx = (addr - A_VERSAL2_RST_USB0) / sizeof(uint32_t);
> +        return xvc->cfg.usb + idx;
> +
> +    case A_VERSAL2_RST_CAN0 ... A_VERSAL2_RST_CAN3:
> +        idx = (addr - A_VERSAL2_RST_CAN0) / sizeof(uint32_t);
> +        return xvc->cfg.can + idx;
> +
> +    default:
> +        /* invalid or unimplemented */
 > +        return NULL;

Can that happen?

Note count=1 when returning. Should we set to 0?

> +    }
> +}

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


