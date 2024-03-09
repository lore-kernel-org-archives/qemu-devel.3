Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D87C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 18:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj14S-00039S-Id; Sat, 09 Mar 2024 13:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj14O-00038s-TR
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 13:05:17 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj14L-0006si-Sg
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 13:05:16 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29b70bf6c58so1476719a91.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 10:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710007509; x=1710612309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tni9d/HuC2dhmeHV1PA6VdgaMUsYq9VIjRAdiwF/iYI=;
 b=r1lbADEy65KBbxucDsEFnWKUnQfIwYW/3fKuP4lYgNlOcpvjEssrEUgMMhRoBxzegs
 3YX4MOqAo3S0mpBeSnfm/nJiXZj7n09veV4CX8o2DvzPky4+P8mQWsSYLl1D6rw5myER
 WKNmn/mX1IdVpBWeeAYUExPX2JWgT0IFdiEahnW1be9spuBl0+KaBcq+UjlZRee5ZjkC
 4fYBu3MYcs9668Ozl6O5ugIhbmvQE5knp1ZinWlfgJ9WhyH9nht38YDovsssAvrwhg2y
 1UitR1qxJ5fYqti26zcMFxjPCHXI2yGL3LM0ThmT6Ccup0vFGL2Vr8hVT9F+GyPFaUY2
 jmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710007509; x=1710612309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tni9d/HuC2dhmeHV1PA6VdgaMUsYq9VIjRAdiwF/iYI=;
 b=RDwQHW5m3OWDq4R52LlxxUydyiXmwXM6kgGihcMy+dXyucvesIIsd9FsXmQDOCVoLJ
 XlAy7vQSfiQYAj77/btQDSuGbXNzysBsud1RxgBzLXkXMqbxxSKV7Ey9kId+eOuUR01C
 9kw/U+FQUuCzFliPR7kbJKDFh6mAKmET+kj8pgNIItgfuZ9yvioO4XPoqVWDLz8XbkSr
 +5p5t3vyyTCy4X7p/WsemDsLkWcr+Cb0oXBxgp8r8x/nHF48iCmF+Up5MBgGt1yF0eJF
 5L12wLm31d/9xs/6NMEkO8r6pZepjKxNiuTlIPpAZMXKohhjbFzaIaw8n33IMHfFTfC9
 W9WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcuko1n6vV/saMngbeEeeTECQQH4KW5D+vEhE+rPEgu344PirriL70ZftJcST9P/TaE51+deLk/qNppNoVH/zM83UU8nU=
X-Gm-Message-State: AOJu0YxYzI3Z9Rr82EZrp0pWP0Adpk2MLIF4EnHMS1aMqAM1NgI9rIGb
 YHYpWzBS8R3lj/eFlx9Sb85M+/kdTRzR+b4MiB5AwEtEFfXuq39Boj7O+SSdd0k=
X-Google-Smtp-Source: AGHT+IFZAyzgLawsBIwfLPtxqn2/PpQaNnZ97HHWp/wvlMwIyWoKC53dQbkiWustJj9e1U/RUs0f9Q==
X-Received: by 2002:a17:90b:b15:b0:29b:2c12:6b6f with SMTP id
 bf21-20020a17090b0b1500b0029b2c126b6fmr1866679pjb.16.1710007509150; 
 Sat, 09 Mar 2024 10:05:09 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 w35-20020a17090a6ba600b0029bc319f7c9sm1777105pjj.39.2024.03.09.10.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 10:05:08 -0800 (PST)
Message-ID: <124ce5f8-bdb4-4086-8af8-73d20bdc33c0@linaro.org>
Date: Sat, 9 Mar 2024 08:05:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: raise an exception when CSRRS/CSRRC writes
 a read-only CSR
To: Yu-Ming Chang <yumin686@andestech.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20240308084014.22054-1-yumin686@andestech.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240308084014.22054-1-yumin686@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/7/24 22:40, Yu-Ming Chang via wrote:
> Both CSRRS and CSRRC always read the addressed CSR and cause any read side
> effects regardless of rs1 and rd fields. Note that if rs1 specifies a register
> holding a zero value other than x0, the instruction will still attempt to write
> the unmodified value back to the CSR and will cause any attendant side effects.
> 
> So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specifies
> a register holding a zero value, an illegal instruction exception should be
> raised.
> 
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
>   target/riscv/cpu.h       |  3 +++
>   target/riscv/csr.c       | 18 +++++++++++++++---
>   target/riscv/op_helper.c |  2 +-
>   3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5d291a7092..087ef64889 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -710,6 +710,9 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>   void riscv_cpu_update_mask(CPURISCVState *env);
>   bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>   
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                          target_ulong *ret_value,
> +                          target_ulong new_value, target_ulong write_mask);
>   RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                              target_ulong *ret_value,
>                              target_ulong new_value, target_ulong write_mask);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d4e8ac13b9..3e49cf0df1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4306,7 +4306,7 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
>   
>   static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
>                                                  int csrno,
> -                                               bool write_mask)
> +                                               bool write)
>   {
>       /* check privileges and return RISCV_EXCP_ILLEGAL_INST if check fails */
>       bool read_only = get_field(csrno, 0xC00) == 3;
> @@ -4328,7 +4328,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
>       }
>   
>       /* read / write check */
> -    if (write_mask && read_only) {
> +    if (write && read_only) {
>           return RISCV_EXCP_ILLEGAL_INST;
>       }
>   
> @@ -4415,11 +4415,23 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                           target_ulong *ret_value,
> +                           target_ulong new_value, target_ulong write_mask)

Remove new_value and write_mask arguments, as they don't make sense for read.

> +{
> +    RISCVException ret = riscv_csrrw_check(env, csrno, false);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    return riscv_csrrw_do64(env, csrno, ret_value, new_value, write_mask);

... and pass zeros ...

> -    RISCVException ret = riscv_csrrw(env, csr, &val, 0, 0);
> +    RISCVException ret = riscv_csrr(env, csr, &val, 0, 0);

... like you do from the only caller.


r~


