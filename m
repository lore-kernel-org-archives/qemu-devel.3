Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2406BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 18:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryy6S-0002To-I9; Mon, 22 Apr 2024 14:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryy6O-0002TT-Qt
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 14:09:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryy6M-0007N3-Rm
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 14:09:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso3178105ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713809353; x=1714414153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IMIE18mmd54ysN8nkIpXjq5zKL5L7OUH39O7uUaM6rw=;
 b=LLstLvGTnFcVC3KtJJrvVPaoPH6D3nNzFHQ2o5oAGQlICR+hKgnIVpKZMsFWo5QfSV
 q/7pGgnT0snHVhn2ZFt+69H1TW6qOLgq3cuRH51vkHM162dandY2EnHvi7hyvQLlgZfB
 yHFyHiYZJwuV84DkgggOxJ7bbYo/UdJmVBJc3RpWsI93csJHGVRXgvFlh1XSZaX3T4NP
 dTrEUumylYzQ30h/CrO3bDZOEVh/IGegHQjilBjhBoUEx+SFs7yK9z2OwWKQM0bmxUDA
 oTKScQ97jQCSLDGXPAiXWwmmrdond6hYI3T2VedBZ7RsjIQBla2ap6x7h/opaFtPAKOJ
 s+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713809353; x=1714414153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IMIE18mmd54ysN8nkIpXjq5zKL5L7OUH39O7uUaM6rw=;
 b=R02+t3obkY3ZCrsUN7L5NnEt+c3x/CicL0zuFIENzsTZRaJ33d3pvo3JSq1UkAcF0E
 jmB4BxYDbYPZtKTjS0nEfzX16IX6Mxmguvyzj4M7H31ux5ZxL5XUyvEdQM2SJwj21ydH
 zix038z8cTB0mE8RlzC4cBnpnCki6ydzcgQow8K9WSup2iVEbHp2ezknYKT+ZDy/Hq5h
 sj3cWgCizBBQMHrrYSGmZBtfpYYb3JTic4fgsOpM2jZ21umRhugrvJW8FJFH5Au3s2JN
 s7thin6Ol7yBGM04i+DVlzRh6XS8myKrXghvWTCa+RZg0rvJeNPMbyPfVQI7FRkRkG4F
 QaKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgR1R90yLnjI71+fcSiImQiJRPBTL7I17+3FBbA7BrPpvSe++4H/hsQ3LbeMz1lUKF+FXaIbd7k6cVD1woXaysFzy5krU=
X-Gm-Message-State: AOJu0YwDkMGrOPJ6Cxi+yrYQjDQ8VKFutA/RUVgyQweCHWqpq7uNA6WA
 e19eloodHMKR12NIWz7jjlYCnwFKe85iDWqYxy4CuIOmRBoYPOI0MR2mZzz1Yg8=
X-Google-Smtp-Source: AGHT+IHJN2+XmqLMECpcl1MUbSTQXtVGKHXwOUf3KuUCeO+/DT+o6GDUwfKK3M0/TIHNGLtDjAiU6w==
X-Received: by 2002:a17:902:d3c5:b0:1e4:3df0:38a5 with SMTP id
 w5-20020a170902d3c500b001e43df038a5mr10126919plb.65.1713809353163; 
 Mon, 22 Apr 2024 11:09:13 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.121])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a17090322c200b001ea00cce974sm327643plg.135.2024.04.22.11.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 11:09:12 -0700 (PDT)
Message-ID: <4486114c-89f0-4d13-acfd-20b606cf1b20@ventanamicro.com>
Date: Mon, 22 Apr 2024 15:09:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: Fix exposure of Zkr
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, kvm-riscv@lists.infradead.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, apatel@ventanamicro.com
References: <20240422134605.534207-2-ajones@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240422134605.534207-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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



On 4/22/24 10:46, Andrew Jones wrote:
> The Zkr extension may only be exposed to KVM guests if the VMM
> implements the SEED CSR. Use the same implementation as TCG.
> 
> Without this patch, running with a KVM which does not forward the
> SEED CSR access to QEMU will result in an ILL exception being
> injected into the guest (this results in Linux guests crashing on
> boot). And, when running with a KVM which does forward the access,
> QEMU will crash, since QEMU doesn't know what to do with the exit.
> 
> Fixes: 3108e2f1c69d ("target/riscv/kvm: update KVM exts to Linux 6.8")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h         |  3 +++
>   target/riscv/csr.c         | 18 ++++++++++++++----
>   target/riscv/kvm/kvm-cpu.c | 25 +++++++++++++++++++++++++
>   3 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b9449a..52fb8c15d08f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -821,6 +821,9 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
>   
>   void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>   
> +target_ulong riscv_new_csr_seed(target_ulong new_value,
> +                                target_ulong write_mask);
> +
>   uint8_t satp_mode_max_from_map(uint32_t map);
>   const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>   
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444fae..829d8346ed4e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4267,10 +4267,8 @@ static RISCVException write_upmbase(CPURISCVState *env, int csrno,
>   #endif
>   
>   /* Crypto Extension */
> -static RISCVException rmw_seed(CPURISCVState *env, int csrno,
> -                               target_ulong *ret_value,
> -                               target_ulong new_value,
> -                               target_ulong write_mask)
> +target_ulong riscv_new_csr_seed(target_ulong new_value,
> +                                target_ulong write_mask)
>   {
>       uint16_t random_v;
>       Error *random_e = NULL;
> @@ -4294,6 +4292,18 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
>           rval = random_v | SEED_OPST_ES16;
>       }
>   
> +    return rval;
> +}
> +
> +static RISCVException rmw_seed(CPURISCVState *env, int csrno,
> +                               target_ulong *ret_value,
> +                               target_ulong new_value,
> +                               target_ulong write_mask)
> +{
> +    target_ulong rval;
> +
> +    rval = riscv_new_csr_seed(new_value, write_mask);
> +
>       if (ret_value) {
>           *ret_value = rval;
>       }
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80f1..50bdbd24a878 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1418,6 +1418,28 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
>       return ret;
>   }
>   
> +static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
> +{
> +    target_ulong csr_num = run->riscv_csr.csr_num;
> +    target_ulong new_value = run->riscv_csr.new_value;
> +    target_ulong write_mask = run->riscv_csr.write_mask;
> +    int ret = 0;
> +
> +    switch (csr_num) {
> +    case CSR_SEED:
> +        run->riscv_csr.ret_value = riscv_new_csr_seed(new_value, write_mask);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: un-handled CSR EXIT for CSR %lx\n",
> +                      __func__, csr_num);
> +        ret = -1;
> +        break;
> +    }
> +
> +    return ret;
> +}
> +
>   int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>   {
>       int ret = 0;
> @@ -1425,6 +1447,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>       case KVM_EXIT_RISCV_SBI:
>           ret = kvm_riscv_handle_sbi(cs, run);
>           break;
> +    case KVM_EXIT_RISCV_CSR:
> +        ret = kvm_riscv_handle_csr(cs, run);
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                         __func__, run->exit_reason);

