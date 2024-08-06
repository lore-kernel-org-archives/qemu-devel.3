Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF58C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEgX-0000Vt-1g; Tue, 06 Aug 2024 03:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbEgV-0000Q9-JE
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:32:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbEgT-0004BG-HP
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:32:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7105043330aso264554b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722929559; x=1723534359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+pB1ILbLQxz3WhUA3kvRMP32yn3VDwTFc5aFAi1MPM=;
 b=BVHpOo0oIbrlRSU00n1ugbpPquCUMPYCXrC8cKS8rjZ9KnAxar1nhi46fWYJJXzLy9
 6eVxXqQxorslA5Y1opKjGSxnBUj+79MlhdsHU8YxKiIlZXXcOne1vDbU38KKJyhNQ3e8
 QIh7hnK8qU+zrlsWRv5NdTShCQgW1puSPRY/HE7DlsY6jaRRyn2vriLNBZQPi8g2/UMi
 KunlFCEdRLmAXopATukmTCKI+WdaTcvTpOndx3MfoE+bjezEIflRKxPFLlVX0dxt+JBV
 foPr+dE4M/C0x7XO3Ejbe+M3O2jM+ip8UQy4WAh/Ar7wwuokagLl2SJn5xsKI/7rkcyL
 FyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722929559; x=1723534359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+pB1ILbLQxz3WhUA3kvRMP32yn3VDwTFc5aFAi1MPM=;
 b=g3+cE/Vq8lzel1OG0Kx8tbdhV+LvHHPPEV6aEF6Wm51sbSvlLiIlhiXf287LxmdNKW
 Cm77jEzjebJ1fVDtHJHJ3GF88o6TL+meVcaV/3qQpjmEgUEoWb1rQGA7467KGJiILxm1
 591jRjN/OIxKoxNK0dZVUBKBD8OAOJ/E1iuz2/0CzCKWOUwYL2sx4VmcXw3OjGPa8zGv
 upc2WY9nskthH7swnL0j0sac/sNVfr6ULvHn4pGYulRAScaO1RkC3MBWJmBU9DRGSJPU
 odcoEMS1UfxqphmqVR7HPn3t7VWRFBK6WfHKGWvKlafZNPalekej74r1wyvjlpc0mrS/
 aXNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEmyakURI4v8RuAYUKrf58nbutGYYxRlDDfmetO0llou2bc3m5XFU1FZAts7Kg1+U4O9i1Re0oYOVpBre+MwyLu+o1Knk=
X-Gm-Message-State: AOJu0Yy7xNUPcrCdC17V8j9r13FmmB0mUaXOVwYMDZ4lCkCTY3Z1pjNV
 t7uENny0U3KSdx0hM4Mjjd9SPmKeq/K9W0Y+rt3vnjQpqs4O4GmAaAuh1q09uGHR29uYjcdW/rp
 Gb5I=
X-Google-Smtp-Source: AGHT+IG9LTD1TG9OvNZXRrlPD5OO9e47LAmpJ/EyjxB9WjjK0idowjVTtQWP5Fkj8rn7iEN8FmYeVA==
X-Received: by 2002:a05:6a21:628:b0:1c6:ba9c:5d7b with SMTP id
 adf61e73a8af0-1c6ba9c6e34mr5467476637.23.1722929558652; 
 Tue, 06 Aug 2024 00:32:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f53985sm80989285ad.76.2024.08.06.00.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:32:38 -0700 (PDT)
Message-ID: <9da48ab0-d88e-4d80-aca6-79dfa083bb9b@linaro.org>
Date: Tue, 6 Aug 2024 17:29:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include: bitops: Add mask extract64/deposit64
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, zhiwei_liu@linux.alibaba.com,
 Alistair Francis <alistair.francis@wdc.com>, atishp@rivosinc.com,
 bmeng.cn@gmail.com, qemu-riscv@nongnu.org
References: <20240805043336.72548-1-alistair.francis@wdc.com>
 <20240805043336.72548-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240805043336.72548-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/5/24 14:33, Alistair Francis wrote:
> Based on the RISC-V get_field() and set_field() macros add
> mask_extract64() and mask_deposit64() bitop functions. These can extrac
> and deposit values into fields using a bit field mask directly instead
> of a length and shift.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   include/qemu/bitops.h | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 2c0a2fe751..dd26f4a6b5 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -409,6 +409,22 @@ static inline uint64_t extract64(uint64_t value, int start, int length)
>       return (value >> start) & (~0ULL >> (64 - length));
>   }
>   
> +/**
> + * mask_extract64:
> + * @value: the value to extract the bit field from
> + * @mask: the mask bit field to extract
> + *
> + * Extract from the 64 bit input @value the bit mask specified by the
> + * @mask parameter, and return it. The value returned is shifted
> + * so that only the bit field is returned.
> + *
> + * Returns: the value of the bit field extracted from the input value.
> + */
> +static inline uint64_t mask_extract64(uint64_t value, uint64_t mask)
> +{
> +    return (value & mask) / (mask & ~(mask << 1));
> +}

Adding these miss the point of using "standard" qemu operations.

But if we were going to add this, avoid the division.

  (value & mask) >> ctz64(mask)

I presume the original formulation is so that the macro can be used in the context of a 
compile-time constant.


r~

