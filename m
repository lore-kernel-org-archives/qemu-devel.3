Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10000D10399
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 09:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOBe7-0003sG-4r; Wed, 26 Nov 2025 04:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOBdy-0003o6-Bh
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 04:16:58 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vOBdv-0001s8-BN
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 04:16:58 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b9a5b5b47bfso5379289a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 01:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764148613; x=1764753413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJiBJyD+EKlH9P23zr7fIV9G9RXve7uf9tA7ZQIquFQ=;
 b=Gq+YMxP9XN52stgR8ShMSJjPbXcU7qQu3HaYyXKMrem7ykZCBGBtpDmgZ3zsi1umYX
 PhblqJT/LAv9jaoA+jQbUsDBEam1h9RUM1XJTyPsRXMhat0WIb/Ifax/MiqpvdKglpC0
 WLibaG+ZwYPOPSeYRyy8Xpl4cjqw1yCXVb6YBkBAZ4rnPGUMiCcpBTxM+3lFysLB9IEZ
 Rd25kbC9Hs6jRjlHRO73tCqvBmgu6y7In60SFj0L1kScQ/CsnxaUO9puJTgpxI6ja/n+
 3W454CsT8+r8ygyL+b2dcbeS9pLxmAYVpUEBfcYe1L3uI59yLu/NuOzVQHd5qoK6ce7o
 alPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764148613; x=1764753413;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJiBJyD+EKlH9P23zr7fIV9G9RXve7uf9tA7ZQIquFQ=;
 b=qea8HnHJs53uS24dJcUnmNI+2z3wcLZd3qtxQHtJdpjOjEcMCMsIH8oKj5Ug2y2mnH
 xRaGSD0ZJCJsU/aywTukS7dXdaq+fshmrY0W9lL1YnBMIKwjcs16qTOtMbEeOizoqO33
 ck2bMMNkll+3ToYWW+/ZmaiYmf/hFXvNDe+uEdw5KKC9KUFGE+FJbdm+arPEKykAvssB
 75yQ7tx2VKbpwRPM2jY6usBlbGwS/75DCY+19qEhx9WHzkdaX+FP0dv1OS+VEWzkMmlQ
 HG9px3MyeyDLf/Up2N0UjYEeMx5ABKUUjOdrtcXS2EynHo69TvQ0bvG758FQCk84aaGj
 OkuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg8IuEFbMFrkDdSJqJ9XZXcfSUJhih062sE87UN1J7UWVBbdg8k9l6iSoEL17t9NL93nrgwgbZHIwK@nongnu.org
X-Gm-Message-State: AOJu0YzTHBYLnkzc/4gB3+bQzYMQVhf1Fs1LzWJZTi8I2cnoyE2TnO3a
 ofLcGzEu+qKXhFTadgFw1YuzqDyXosJ/wLy6C6QSfU7f4O1oYJCR1HFhzbR98+havpI=
X-Gm-Gg: ASbGncvhvjsBIN1ftUw6Cthm06HBzr1Q3cbXpjjBoAiiXEhXmx84soGzZ25bkO20Yzj
 ucW52jvDqehDs+lI2M1vqviId+2jeOa2is2T00qEGwViDAWH/f4hRvUUDTjegNizNDHw+3pEsFl
 9DAmqAgzQcqgNBBoYJK/Uaxj9/wD1/2mfw47MEDLrvKfItxzf5koGH/s2/OTjGAGIZcU1A1QzRC
 6KAZAHzI5hsPB/wUgzHHS+wmysDNwd3IfkElaeKIQ6Pt6gpSQK1FOFUY9BJdpmTHFRv0Ih8kA1o
 0nmHH508WFf/1sja1fKkanMneTHW+3zD2cZFg0Mj+nUkTaFuLtq53dzV7y3ifE0wwHvllRUxtbS
 4ql/smJZLcQoYUQbc48pqhQmZXLqTzAsuAtrSAFIlLfYxj4jwDPO1lgkf6kYMfVFSv6ThDK27Y6
 xYpGT7/hZalgB2y46VyHKIV60PgQ==
X-Google-Smtp-Source: AGHT+IHVPI+0tuGT8VHvL0O0YiOPAzUHgynt0s1wpUriuIVK9rFte6UGr1ATJDyH6TN83PYzmAzubw==
X-Received: by 2002:a05:7301:a08:b0:2a4:5129:feaf with SMTP id
 5a478bee46e88-2a719560b71mr9084918eec.10.1764148613415; 
 Wed, 26 Nov 2025 01:16:53 -0800 (PST)
Received: from [192.168.68.110] ([179.133.97.212])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc38a66bsm69332364eec.1.2025.11.26.01.16.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 01:16:53 -0800 (PST)
Message-ID: <fa118b78-681e-4e32-bc1c-98375a268a97@ventanamicro.com>
Date: Wed, 26 Nov 2025 06:16:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v2 04/12] target/riscv: Use little-endian variant
 of cpu_ld/st_data*() for vector
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20251126075003.4826-1-philmd@linaro.org>
 <20251126075003.4826-5-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251126075003.4826-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52b.google.com
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



On 11/26/25 4:49 AM, Philippe Mathieu-Daudé wrote:
> RISC-V vector "elements are simply packed in order from
> the least-signicant to most-signicant bits of the vector
> register" [*] which is little endianness, therefore the
> cpu_ld/st_data*() definitions expand to the little endian
> declarations. Use the explicit little-endian variants.
> 
> [*] RISC-V "V" Vector Extension v1.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 2de3358ee86..caa8dd9c125 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -193,9 +193,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
>   }
>   
>   GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
> -GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
> -GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
> -GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
> +GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
> +GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
> +GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
>   
>   #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
>   static inline QEMU_ALWAYS_INLINE                            \
> @@ -214,9 +214,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
>   }
>   
>   GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
> -GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
> -GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
> -GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
> +GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
> +GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
> +GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
>   
>   static inline QEMU_ALWAYS_INLINE void
>   vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,


