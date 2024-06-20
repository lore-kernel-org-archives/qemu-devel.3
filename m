Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00E9C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 04:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK9ZR-0003r3-Il; Thu, 20 Jun 2024 00:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9ZN-0003pH-5C
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:38:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9ZK-0007YB-A4
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:38:44 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-706354409e1so461732b3a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 21:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718858320; x=1719463120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Im8yJA/+Zd1PBYEorHzfG1mN4IAbdyoHRV2y4xjnmjc=;
 b=P5+R55zycGoz/UJ7xLiBw03RMJE5kcIjgv976wTzx8iixo1NPf9dLAIc1vtuxBTcGW
 TLf4mANusQpRp4YRxWqHkb27HClX2i61lSg5Mia1DOp+0eCCYWBCUFc6uTD2wVt9dvZc
 JQEuySpCFJCIbPX4LuLGLjEML9B0TbNWWLikZDUEa3G2hT4ioFw6YB28k0FohDdeyCk2
 cNUMw5AZXkBLIbCG7QnphrxbLQA75yIsKc5QBSUADxT6yLM+4YaO8oIxQDda0HTUOD6O
 HKLzfsvVFBPPUKZl9ha2ogyPE9p/j6TopbaB4wTi6/q/h4W3GulwREYAuPsSB77vcA7e
 3jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718858320; x=1719463120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Im8yJA/+Zd1PBYEorHzfG1mN4IAbdyoHRV2y4xjnmjc=;
 b=xHgxNRBvIVYfE2Sad/fvJmwUQfZA7RR6OJUGqBlgOmsi7u4u4KbALI9XuXhHiv4M4P
 m7sp6hL4dWwCwCBwA6dcSNM37V8zxkdX3xS9v2AoRTwZV92Ew1a+D2T3pDfOJTJO0UOb
 TC6Gcwcxti3EdWmNtO1Rr12GO6j59i1WuyshX5QUvf2G2Oy/mPrFJzmNux/HVJYOcEOh
 MQKL5Ix2Mwov0ZaazAr+ykrb7vpVr/NF7bbsbzU3SypmKiU913rvE+Tb6gO0CF9sX8KH
 Ms6vASGh5tumxlu8TdBZO2h9eDxdn2PdU7ccdW6V9NnqBLZ7Ra6vr6yBmCpuYQ26g9um
 7ClA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm95FrhZLO4e7Kxbb58HiQcQ5Qq7CKZrWlqGpWyy12JEWSzvgl7ymO9/p+Xk2es/bJ4HQQgOqOeefvzQsvfWdF7mnPR7E=
X-Gm-Message-State: AOJu0YyQeSZMrUdg6U/KcNN32IdZSoqPmF2DxtM1nLP4uTT9YBUVo4G5
 96QDOarCGpSs16x0nqGHjWT1gdu1X4AUZ0w+IVbgatIaT3bNQRrvMZOlXiHaLEY=
X-Google-Smtp-Source: AGHT+IESnB1vMyfI+qXvjru1WmnR+bzkfrIo/5KB28nV3sJ6INxVcXusHoI2QgfY56APZMdpbW505A==
X-Received: by 2002:a62:ee11:0:b0:706:3204:fa4e with SMTP id
 d2e1a72fcca58-70632050bb2mr3433780b3a.0.1718858320349; 
 Wed, 19 Jun 2024 21:38:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb6af7fsm11489604b3a.159.2024.06.19.21.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 21:38:39 -0700 (PDT)
Message-ID: <acbf0fae-51be-4aa1-ba79-94345ecfbb21@linaro.org>
Date: Wed, 19 Jun 2024 21:38:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/5] target/riscv: rvv: Provide group continuous
 ld/st flow for unit-stride ld/st instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
 <20240613175122.1299212-5-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240613175122.1299212-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/13/24 10:51, Max Chou wrote:
> The vector unmasked unit-stride and whole register load/store
> instructions will load/store continuous memory. If the endian of both
> the host and guest architecture are the same, then we can group the
> element load/store to load/store more data at a time.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/vector_helper.c | 160 +++++++++++++++++++++++++----------
>   1 file changed, 117 insertions(+), 43 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 793337a6f96..cba46ef16a5 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -457,6 +457,69 @@ GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
>   GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
>   GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
>   
> +static inline uint32_t
> +vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
> +                     uint32_t byte_offset, void *host, uint32_t esz,
> +                     bool is_load)
> +{
> +    uint32_t group_size;
> +    static vext_ldst_elem_fn_host * const fns[2][4] = {
> +        /* Store */
> +        { ste_b_host, ste_h_host, ste_w_host, ste_d_host },
> +        /* Load */
> +        { lde_b_host, lde_h_host, lde_w_host, lde_d_host }
> +    };
> +    vext_ldst_elem_fn_host *fn;
> +
> +    if (byte_offset + 8 < byte_end) {
> +        group_size = MO_64;
> +    } else if (byte_offset + 4 < byte_end) {
> +        group_size = MO_32;
> +    } else if (byte_offset + 2 < byte_end) {
> +        group_size = MO_16;
> +    } else {
> +        group_size = MO_8;
> +    }
> +
> +    fn = fns[is_load][group_size];
> +    fn(vd, byte_offset, host + byte_offset);

This is a really bad idea.  The table and indirect call means that none of these will be 
properly inlined.  Anyway...

> +
> +    return 1 << group_size;
> +}
> +
> +static inline void
> +vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
> +                       void *vd, uint32_t evl, target_ulong addr,
> +                       uint32_t reg_start, uintptr_t ra, uint32_t esz,
> +                       bool is_load)
> +{
> +    for (; reg_start < evl; reg_start++, addr += esz) {
> +        ldst_tlb(env, adjust_addr(env, addr), reg_start * esz, vd, ra);
> +    }
> +}
> +
> +static inline void
> +vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
> +                        void *vd, uint32_t evl, uint32_t reg_start, void *host,
> +                        uint32_t esz, bool is_load)
> +{
> +#if TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN
> +    for (; reg_start < evl; reg_start++) {
> +        uint32_t byte_off = reg_start * esz;
> +        ldst_host(vd, byte_off, host + byte_off);
> +    }
> +#else
> +    uint32_t group_byte;
> +    uint32_t byte_start = reg_start * esz;
> +    uint32_t byte_end = evl * esz;
> +    while (byte_start < byte_end) {
> +        group_byte = vext_group_ldst_host(env, vd, byte_end, byte_start, host,
> +                                          esz, is_load);
> +        byte_start += group_byte;
> +    }

... this is much better handled with memcpy, given that you know endianness matches.


r~

