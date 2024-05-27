Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FDBC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZ2s-0006YH-8N; Mon, 27 May 2024 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZ2D-00060R-DC
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:01:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZ28-0007Dd-EW
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:00:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f082d92864so144769835ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716811250; x=1717416050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6BMFqYpo8MBQkQ6MBfZ9WA69oq28kia1XGb/ZyHvw1E=;
 b=mbjrNpvmvQzmvW8B00CIBjfIzK5molsQ1ZkcRmQ6laPBlWQwFlcY9ZETlBrcrL3txD
 4a+mWM1peejJb2ojzQxrGtRdrve07zr4zBPm+iskMp6lhjbEShWfV76ZgFQHEfusFKf8
 qub6D9+qaYcq6HpLVJC44XKwJzTmBDBfdiJSFkd7Rn4vnTofB+a4cV1sQsdNgEtXYzqF
 5gRC05EBhx7xvMcvn54c+ruI4JTCIpwajLHG5C8PWY9c5/Oath6YXHtB+bH3FWzvqclC
 gwU8Gv49fFHnXBSyHI30/eqxflfaHDYWESmN6Dr5HfYC/vBVGMdf5F8+E1lObdpCJ5uQ
 rKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716811250; x=1717416050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6BMFqYpo8MBQkQ6MBfZ9WA69oq28kia1XGb/ZyHvw1E=;
 b=lF/NR/O2/Y+3VmOATXaXDI+lOK6G6hdiEg4gBaBtJbfXOH0o4NxXlwIQyK2g0Nb1Fx
 4NSPxduc+Et9FfozG6HJFLpB54SfXAQY1aWba/G6Ny7Tt6I8h2WbIdU8dIkBGGGmolPQ
 xd7pSGE7cVa/DrocVUS/a4SpdZJN31Q8t3rKQ9HUYPgK0kk9PixfOP3SFlXoX0hJkuGo
 46a7qUO23U55E/+ZpZE0ppPx6BZzYwq8N3EAA+4Y8gcnoUU/2RbC/OtvKiExqGuqiJeR
 JB740F0mEv7ShCXpx586UJgNHitKXDNNrFIsgM/6gU92BHRlrLBDv3EvSJNmP/Kca1A3
 jgpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc5cYaTsGKZv5Y6poFwVUHP6TCWFcmWw9aNOsJRH7XL/J2psJZ1bprPGKVBrulK9ivQIKOowOFdM7Msa2Jhqzh2Vs6QBw=
X-Gm-Message-State: AOJu0YzEGRK6BGPQK0BmFA3RwdwhizmQY1z1APsNzgbmLnV2YN4NTi60
 6gLhef9V/1OLObrgDpzcwPTf4awwGWL7U0EgL5o6vEpty5IG/ov4nDkkS/iG/pM=
X-Google-Smtp-Source: AGHT+IE3ywLnU4sqPlQ5YEwz3KluI9U4V/kBOTVdS4ZWJGxjLKDid6G54UjH57S3esHyzELABKf4dw==
X-Received: by 2002:a17:902:fa46:b0:1f3:4232:76df with SMTP id
 d9443c01a7336-1f4487400b4mr78660675ad.36.1716811250152; 
 Mon, 27 May 2024 05:00:50 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c75783asm59408945ad.23.2024.05.27.05.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 05:00:49 -0700 (PDT)
Message-ID: <9ae2d604-e22e-4fa0-b830-8e12772fe08d@ventanamicro.com>
Date: Mon, 27 May 2024 09:00:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] target/riscv/kvm: handle the exit with debug reason
To: Chao Du <duchao@eswincomputing.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, pbonzini@redhat.com, alistair23@gmail.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, anup@brainfault.org, duchao713@qq.com
References: <20240527021916.12953-1-duchao@eswincomputing.com>
 <20240527021916.12953-4-duchao@eswincomputing.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240527021916.12953-4-duchao@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 5/26/24 23:19, Chao Du wrote:
> If the breakpoint belongs to the userspace then set the ret value.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 0bc3348b91..0c45e520b2 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1555,6 +1555,21 @@ static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
>       return ret;
>   }
>   
> +static bool kvm_riscv_handle_debug(CPUState *cs)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
> +
> +    /* Ensure PC is synchronised */
> +    kvm_cpu_synchronize_state(cs);
> +
> +    if (kvm_find_sw_breakpoint(cs, env->pc)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>   {
>       int ret = 0;
> @@ -1565,6 +1580,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>       case KVM_EXIT_RISCV_CSR:
>           ret = kvm_riscv_handle_csr(cs, run);
>           break;
> +    case KVM_EXIT_DEBUG:
> +        if (kvm_riscv_handle_debug(cs)) {
> +            ret = EXCP_DEBUG;
> +        }
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                         __func__, run->exit_reason);

