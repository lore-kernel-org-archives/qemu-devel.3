Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52295C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 07:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXbfH-0006Wv-Ea; Sat, 27 Jul 2024 03:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXbf3-0006RH-FS
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 03:16:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXbf0-0001Ht-IR
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 03:16:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc692abba4so10924375ad.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2024 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722064563; x=1722669363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IfuzwiUHCK0yOqno5KoQ7HBsfGxxOGDSKsnCp6Lq1AM=;
 b=P/QBZgzMheT8pGenXVKI7OgWrJC0z9gDZAPqD5X+9qtCeaRVnHNTMsaf/O8ZvK931U
 wWS9qA7lJ2gfqNX8Bfy4Vw5JTBf07trdw9wMjaUEoiLHjb6qDNNZm3x0pQZYZyeNyjU1
 kb5c5FZmxHYrU9QlnxOd4hmJ1H7QFuSHIbI1hJzMdVsYkhZXnSqxf5KuuEKJiJPAKVrJ
 PzkKp2up853f+iXSi3cFwOQ69mT0WH8oQj4hxPdkm+vhlUZhT5IyTUQTXslxlhHNLfCO
 zUd1FNUJrzcsdJW7xWi+gq8/nTrXXxfO+DEBzj7MOxHK4+2YAt8NzcrNnI030269rKff
 UUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064563; x=1722669363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IfuzwiUHCK0yOqno5KoQ7HBsfGxxOGDSKsnCp6Lq1AM=;
 b=XM0x7Qxy2/hKIRrqaXI5CS/Jfp1Dw7P7NyQfYlYqM2YsdeZyllsQgZICnWM20iS1A4
 Ik1jFz1qEB3x1rkF2rcEachAGHNg1WVl3y+djDSvV19QXrqlGjNtYKDd+neSpZjs0Xdv
 gY6MOPW/Kv5NKdnJZr5sZ+G6d4ghj9r36yCXw8viSRF3kHfEF54Ef+za05fFdzJkUy4f
 NBlG/5ZK3RDdkQJGEXa7uPI8gx065wmcTFOvtQd8Oa9kFLFOXJo9ecZNTSGf7md1bwdZ
 M7ZEQPJiVpvXxoCn4mdAXKSnAbZuU63BTK0ueOUFW1qKyi8/cnGf9cF0f3/930dy/7vw
 uwZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVwAwXl+ifxyDnL290at7yjaqJZaqqkE/laMciqkf/BQfKACqC76oms/dgBktUU1XstWrhlcu9xc4nW/Yb6pBFjfRcMxA=
X-Gm-Message-State: AOJu0Yyp+wWY/O4hEVysMJWJBAiBQxPcTq9wDvp3PH+9J6wevb+qcpYO
 HvqWCUZmOUGsCs9qgt2yM0kvfc0J5qITLAf5JQIp4JUyG0gzMToX0vVV3fO3MIw=
X-Google-Smtp-Source: AGHT+IFph++8jvlmnu60isKoplDdqalQCLdl9k9chqhAM3dRblXxcAkJQUX1QyYxmEoMbW2dBwpbDg==
X-Received: by 2002:a17:902:db12:b0:1fb:57e7:5bc6 with SMTP id
 d9443c01a7336-1ff047a614amr21783875ad.23.1722064563124; 
 Sat, 27 Jul 2024 00:16:03 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c7f66esm44503595ad.15.2024.07.27.00.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jul 2024 00:16:02 -0700 (PDT)
Message-ID: <8e0c2afd-4c31-47f8-ade9-60a83ca20859@linaro.org>
Date: Sat, 27 Jul 2024 17:15:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] target/riscv: rvv: improve performance of RISC-V vector
 loads and stores on large amounts of data.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
 <20240717153040.11073-3-paolo.savini@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240717153040.11073-3-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/18/24 01:30, Paolo Savini wrote:
> This patch optimizes the emulation of unit-stride load/store RVV instructions
> when the data being loaded/stored per iteration amounts to 64 bytes or more.
> The optimization consists of calling __builtin_memcpy on chunks of data of 128
> and 256 bytes between the memory address of the simulated vector register and
> the destination memory address and vice versa.
> This is done only if we have direct access to the RAM of the host machine.
> 
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 4b444c6bc5..7674972784 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -486,7 +486,22 @@ vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
>       }
>   
>       fn = fns[is_load][group_size];
> -    fn(vd, byte_offset, host + byte_offset);
> +
> +    if (byte_offset + 32 < byte_end) {
> +      group_size = MO_256;
> +      if (is_load)
> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + byte_offset), 32);
> +      else
> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + byte_offset), 32);
> +    } else if (byte_offset + 16 < byte_end) {
> +      group_size = MO_128;
> +      if (is_load)
> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + byte_offset), 16);
> +      else
> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + byte_offset), 16);
> +    } else {
> +      fn(vd, byte_offset, host + byte_offset);
> +    }
>   

This will not work for big-endian hosts.

This may have atomicity issues, depending on the spec, the compiler options, and the host 
capabilities.


r~


