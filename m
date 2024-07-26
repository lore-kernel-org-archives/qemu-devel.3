Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F1AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXK2S-00032S-Gq; Fri, 26 Jul 2024 08:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sXK2R-00031S-Au
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:27:11 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sXK2P-000787-Ig
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:27:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d1a74a43bso753788b3a.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721996828; x=1722601628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFh+G7stIUPYlB2tBNcR+6jw95Oe3yxx4//NYKBPH9w=;
 b=NlADgO3ylgzYNigBr9W0EoXzgYUSX5/uc4BYFxCVoT9EirGtq4x5USgn5PoTOxBomN
 EtZTpBg1iGFfrcpkBK4NMIu3XAgbLKysknjplRwvHwlty6VBB3mVMxO1gZj4X3nAsmz2
 mPN8fY8cyQrJt2kzktAH+1zxMcYJAoQWO+S9X4NLyTTUuVyDFWzclle9gLh/lBgBPbcf
 Ca32gNkzSzKBGVw7W6pHiecsu1/cfJI8ialbN8+oBrfQLWGmTPc35iO6FDvjnKjsji8K
 vpgvAmJEyUjlGHxkSccwTxrC9Kya9oC8L2JtWlq72Xq2j7JPadk445bJeNaWj5gbrxFC
 pF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721996828; x=1722601628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFh+G7stIUPYlB2tBNcR+6jw95Oe3yxx4//NYKBPH9w=;
 b=f+ZALGoHRn43XV7uJuADhMyy3g0rUn7uLsuNYLd6RYbWurdDWU3AYrmaLQH+MhJy0T
 kAGUJE3dJKpv5utFnUA2TdNZWWLI9q/Kt1bU5hu7fSb9YCTDLiDe+tTmqbpt8t3aU8kP
 UCaGf/hQHUogLLZLlYw1yIur0YaOdDnonepAfY7us0gTvfLkwxC5j4chk+S84T/1UvXh
 pnWQMGx0ewQfkjjOCoEyo+LKdmMKpmNNUTYcLxWHxFMYYBq3ip4JoLx6JUnCtb1PsOhj
 SfoSlQAZD1dg8gJDt0gWMzcS6v43tqhpxlQVvdhZvl/y1BkFE4uRbSQ38zsItAOJwuDq
 EE4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpGGXVnoJfaUGzH9LRTulVXNgGjCViXAPAg+DYdtb0dcVkur2XmH758ytHrmwU6piYOq7i+maXsUrRvPG0mrI3CU3nSPo=
X-Gm-Message-State: AOJu0YylJfmonfmIuSrWigSrlwmfJoAs2heTExr6xxcUosmw1TRVZKch
 RFbrZO1mFipCJzW64I+FfPJpVB7qh+9QS8RleTaTv2pZsXU0jXpUwEYYAPgKiSk=
X-Google-Smtp-Source: AGHT+IGmCXVbJVSbYzeRVxK2s0WOn6Ih8V6z91YW4P12NWt5UQ+LDkBILTui/BL3qzgKaY6yWDWOWA==
X-Received: by 2002:a05:6a00:9448:b0:705:9ddb:db6b with SMTP id
 d2e1a72fcca58-70eae8f0dd3mr5193129b3a.13.1721996827981; 
 Fri, 26 Jul 2024 05:27:07 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:54b1:ce70:829:8c74:d7d4?
 ([2804:7f0:bcc0:54b1:ce70:829:8c74:d7d4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8a105bsm2578926b3a.194.2024.07.26.05.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 05:27:07 -0700 (PDT)
Message-ID: <5429e0ae-641e-4500-adde-e4bf8712587c@ventanamicro.com>
Date: Fri, 26 Jul 2024 09:27:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] target/riscv: rvv: improve performance of RISC-V vector
 loads and stores on large amounts of data.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
 <20240717153040.11073-3-paolo.savini@embecosm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240717153040.11073-3-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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



On 7/17/24 12:30 PM, Paolo Savini wrote:
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

I see that we don't have any precedence with this particular built-in in the TCG code. We do have
some instances in other parts of QEMU though (e.g. util/guest-random.c).

If we're ok with adding these builtin calls in the execution helpers in TCG, and aside from the
style warnings that ./scripts/checkpatch.pl will give, LGTM.


Thanks,

Daniel

>       return 1 << group_size;
>   }

