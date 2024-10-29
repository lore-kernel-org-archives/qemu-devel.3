Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA05CD3A67B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 18:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5rQo-0008Kl-Cy; Tue, 29 Oct 2024 14:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5rQf-0008K9-Lu
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:59:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5rQc-0001Iw-7o
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 14:58:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so4418909b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730228332; x=1730833132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qw4UdNNtwQObg4JlG8MCwyXpXQnOhwxXEln0NfX5zFg=;
 b=DyuZL9QBl7x49df36d+ugYCRdPHT2iCRhl26hZ52yF61+iYdrj3XETe6O3oZeSHAkX
 7jC8vSgu4pq059PxKhWNArpPnM5SV0Gvc9nuT7V9lORn3HllzLTFNiHdZrwE1vQlNaqu
 +pRB9asDhmNicOrenl2AlzMgO8jzwhNsJRCHTXotoHLu9nbW50YrJPFHpsnMknVFFK4X
 ZxRaPUhUPfN08dtW0+bS/u6p77vY+YcDHnXKGxNxB2xSnX/9gDvuHtfswNlcvzAA2MbA
 3PBLD3oXJEUyqYNlzoHIcap18YOqhYNg2CL1nES8Gj4hXHzoI+tD3wuBEmCVeQAn/2Ex
 eZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730228332; x=1730833132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qw4UdNNtwQObg4JlG8MCwyXpXQnOhwxXEln0NfX5zFg=;
 b=GeALLcdKSEQrskRD3lbtu+AXN7e4kKzh9DaHtNWa8g/edwaHKi+/H8MGWaacjDSfPg
 bofrnu02IV17lpRx3BlRwlCrqDZvioER0hvfLUR4ZWywoxbeoi6reJHzBF8RZlacwkTm
 bd8O0Fe9LqdI6XkAKqlNbo7rbiTTEjJj39U4ONwb20sh+2BUbCz/+RP3mSqMtMfYfC66
 jiVaMvhtnvEOjhtH+yXqduh1Ifk4DM5zT9xpChvffGFiv4g6rZgGh4E2CMgu27zgiQQc
 Ee/RjGLZXOa4V2+RhuktpCXKVnwJd0HbWOQOo1b1/R8ioaagkoitqjUZDGhJIBT9nCDP
 f5Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkShyRZvyuMNLjWS/8MRdW91k4SHQjapOUPfYQtCzOCjylhTyfswymAkQRLooWAzFqFwAkySdGuE8s@nongnu.org
X-Gm-Message-State: AOJu0YytiULzdE6ylr4xPL4XaQBm7Zn4K7PjO7+DyD9aDwGtaJmKfu25
 JgqkXveL+amRMfKVP3fqI1r5WbvItx/QJ0NdU8YiyAvdQpNj5Ukj3gF13X9cFzA=
X-Google-Smtp-Source: AGHT+IF3obYZRiBX+d6tvk7bO3NlPZAyjk02TCuUj1nxWyrOhMUadP4jafhXE+huVq1eUky7MOghnQ==
X-Received: by 2002:a05:6a00:985:b0:71e:52ec:638d with SMTP id
 d2e1a72fcca58-72062fb21d1mr19378731b3a.10.1730228332112; 
 Tue, 29 Oct 2024 11:58:52 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8a3e2a4sm7908942a12.88.2024.10.29.11.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 11:58:51 -0700 (PDT)
Message-ID: <8c09e7cd-cecc-40bd-be6e-6043c8f7592a@ventanamicro.com>
Date: Tue, 29 Oct 2024 15:58:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] target/riscv: Set vdata.vm field for vector
 load/store whole register instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 richard.henderson@linaro.org, negge@google.com
References: <20240918171412.150107-1-max.chou@sifive.com>
 <20240918171412.150107-2-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240918171412.150107-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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



On 9/18/24 2:14 PM, Max Chou wrote:
> The vm field of the vector load/store whole register instruction's
> encoding is 1.
> The helper function of the vector load/store whole register instructions
> may need the vdata.vm field to do some optimizations.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

I wonder if we should always encode 'vm' in vdata for all insns. Seems like
helpers are passing 'vm' around in the helpers ...


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 3a3896ba06c..14e10568bd7 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -770,6 +770,7 @@ static bool ld_us_mask_op(DisasContext *s, arg_vlm_v *a, uint8_t eew)
>       /* Mask destination register are always tail-agnostic */
>       data = FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
>       data = FIELD_DP32(data, VDATA, VMA, s->vma);
> +    data = FIELD_DP32(data, VDATA, VM, 1);
>       return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
>   }
>   
> @@ -787,6 +788,7 @@ static bool st_us_mask_op(DisasContext *s, arg_vsm_v *a, uint8_t eew)
>       /* EMUL = 1, NFIELDS = 1 */
>       data = FIELD_DP32(data, VDATA, LMUL, 0);
>       data = FIELD_DP32(data, VDATA, NF, 1);
> +    data = FIELD_DP32(data, VDATA, VM, 1);
>       return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
>   }
>   
> @@ -1106,6 +1108,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>       TCGv_i32 desc;
>   
>       uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
> +    data = FIELD_DP32(data, VDATA, VM, 1);
>       dest = tcg_temp_new_ptr();
>       desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>                                         s->cfg_ptr->vlenb, data));

