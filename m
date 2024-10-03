Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E76CF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swU1i-0000VK-En; Thu, 03 Oct 2024 18:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swU1h-0000V4-15
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:10:25 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swU1e-00005q-9M
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:10:24 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso990194a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993408; x=1728598208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8u9qMfYZxroBy9mHnClmosS6R0MwGwmGv0ISj97G4E=;
 b=v6iWkq4u3Fi/FSSZnHp58TRAAM9wKK1Kqa8cEhBQj7N+6ko9vzliFE3Mv7+zMGJWIt
 pGfbQ8BS4pDeK+9NDGV2rHbWN9ZbI5u5OELokKtltJM6gt2hv8+rJRmSb59xiMEbzIG2
 fV6QZK+pLLVhmtQDvzlR7+ol0EdcmT6qxWG+9BQp+dMBS4K3EjLPYAWVvWAh+xhtqcnr
 74xuwpy674OIn/olcsXc6tNryH+eZZ0I1dID76aA2ChcuvdfuC0zxgMpUExU9j6soxoM
 P7AKgMxmfuZhGMacu2OCjUrbau7vgNrcm9orvpRwqmjBt5KSUAFiT26h5dJ7Z9BdySgL
 ycGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993408; x=1728598208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8u9qMfYZxroBy9mHnClmosS6R0MwGwmGv0ISj97G4E=;
 b=tLawan54GbGnfzmrYE2Gn4oM7ux3ifNITN0bY2+4P3QQTj4qY+A3hUjoYYpdYs5XzV
 sTtqj4QUgZPBtu5WB2cR7e+DN4ZqJjrowRQxiHF5QD8fUhSFyhoGNrcllLtWcvRHu+Vm
 4ype/6jjnk9Mi4jMNEVzdq2H5vj3wA46AyuOYn3b8deB9ZS5KY+B8BlDw+PgWthFULhi
 FGLfBWRg38Exg44URZmY/qk6k5S8JQOq5rXlhn+A5wmQhiNDwd9DyNAnWTrb9RURImSP
 0HFsMKP0qc2+6WRsVOBKGnQu6uU2an3OdJUHHnzDirzXg1BxS3n1q0YLcUE4dPOE0s9R
 9J0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaZdbXAohNmGlGqmfzfUDxN3bOe+u0sDbfuD6kqb7SiygIElsT1H33f8n6SIO5niTYQE/okcbxma33@nongnu.org
X-Gm-Message-State: AOJu0YwXP85pE0NkX5cXXY1dbLidHso7znLoDTn4ErMT9E87Es3DqvnL
 phanRgwxA07rZlDJZVR/SwzVKZjt6rhaeCxeJjuo71t00epjlNS4q1LDbVAQB9mplc+UXiwZy1Z
 N
X-Google-Smtp-Source: AGHT+IFixD9FfMaON9fIOgDrvLIDV24URfBkRGh25iDw9NWZ0Rkyw6v+s1vE0r4vqsRdMJMsBPGu3w==
X-Received: by 2002:a05:6a20:4e08:b0:1d4:e65a:2cdb with SMTP id
 adf61e73a8af0-1d6dfa25973mr880452637.2.1727993406662; 
 Thu, 03 Oct 2024 15:10:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9d6e0aesm1882051b3a.32.2024.10.03.15.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:10:06 -0700 (PDT)
Message-ID: <b7b77e03-bf6b-49f9-a896-2432803d3560@linaro.org>
Date: Thu, 3 Oct 2024 15:10:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] hw/net/tulip: Use ld/st_endian_pci_dma() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930073450.33195-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 9/30/24 00:34, Philippe Mathieu-Daudé wrote:
> Refactor to use the recently introduced ld/st_endian_pci_dma()
> API. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/tulip.c | 32 ++++++++++----------------------
>   1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index 9df3e17162..6c67958da7 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -71,36 +71,24 @@ static void tulip_desc_read(TULIPState *s, hwaddr p,
>           struct tulip_descriptor *desc)
>   {
>       const MemTxAttrs attrs = { .memory = true };
> +    bool use_big_endian = s->csr[0] & CSR0_DBO;
>   
> -    if (s->csr[0] & CSR0_DBO) {
> -        ldl_be_pci_dma(&s->dev, p, &desc->status, attrs);
> -        ldl_be_pci_dma(&s->dev, p + 4, &desc->control, attrs);
> -        ldl_be_pci_dma(&s->dev, p + 8, &desc->buf_addr1, attrs);
> -        ldl_be_pci_dma(&s->dev, p + 12, &desc->buf_addr2, attrs);
> -    } else {
> -        ldl_le_pci_dma(&s->dev, p, &desc->status, attrs);
> -        ldl_le_pci_dma(&s->dev, p + 4, &desc->control, attrs);
> -        ldl_le_pci_dma(&s->dev, p + 8, &desc->buf_addr1, attrs);
> -        ldl_le_pci_dma(&s->dev, p + 12, &desc->buf_addr2, attrs);
> -    }
> +    ldl_endian_pci_dma(use_big_endian, &s->dev, p, &desc->status, attrs);
> +    ldl_endian_pci_dma(use_big_endian, &s->dev, p + 4, &desc->control, attrs);
> +    ldl_endian_pci_dma(use_big_endian, &s->dev, p + 8, &desc->buf_addr1, attrs);
> +    ldl_endian_pci_dma(use_big_endian, &s->dev, p + 12, &desc->buf_addr2, attrs);

I don't know if I'm keen on replacing 1 conditional with 4.
I had the same thought vs patch 3, in target/arm/ptw.c.

I suppose it's not exactly performance sensative code, and the compiler might be able to 
do something, given that the conditional is invariant, but it strikes me as untidy.

Anyone else care to weigh in?


r~

