Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7461CC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlSOT-0003rL-97; Fri, 21 Feb 2025 07:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlSOO-0003q7-9T
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:44:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tlSOM-0001UT-MC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:44:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso1455340f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740141868; x=1740746668; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QkFqKyhO+UNGfTQB/aIiReQiVSLy+zuj4ed6HdbTGkI=;
 b=Ou7JNUSRKNnhg7VyZlvaT33ompvL9Em/jzpWRRUSuJICwQD5S+jntxwN2z+rA6BNFN
 9ro4XmaRtBQRyM/ZgWdX8hFSeJT9Wmd4c7GwZIMyMEBD4aTc5WKLGT+InbRhEneRXqX4
 MLJvZMBzIO9YA2fHCappjFhwCELLGttvAFZ++/j0d3FU+j4KyFgdGI0Vbmy1f8psEpB5
 RzwEiaEMf+zx8HwvdOo3Y3HAEy/WSWhm5WNSR0Ep0JveL+HXix+kjzOTah0m/L1GI2vF
 vxvicY5AOFQni1nPAIkBy1gIaewRE+lqIshGMiBggCMyupGnPTdt39K34/t5HALSWBpC
 jvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740141868; x=1740746668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QkFqKyhO+UNGfTQB/aIiReQiVSLy+zuj4ed6HdbTGkI=;
 b=OuZhuYv0MMGwzc8ZcrrH8Hz9Q2bgITNFnqwaXhdXz1Hp6jYeTqE7iKieKIyoxCt9ts
 8mTHlcavAHLktkf1i0OpXTxFqrZWhdGBh6HMKVIYH6+0DQcUUrD8rYdw+TvM3ji14tDq
 LTXtPAN8mKgXzYA3o3BygdppcIDGT/EbXOLi+VLYskirG62hYQUZp8FRaVNFMDMz2pPa
 jJtMbndEMiuFfjn6RBamp6r+UrzuHMVopEjd3KeC3RG2CeyqKcVwBEzwCK3T60YwO3Vs
 mBZSICDRSLgWqR70X6kUnqHotZDINKRzLhfiUfGRQ7EJbGOHTTKSpXaBnGpjxN8lfHf1
 Fxkg==
X-Gm-Message-State: AOJu0YxUk338A+RNZSZAt6dY2QJj6HKyjt1GFOh34SYMOGZLmGgAxG7/
 7vXeY1smLUeNXqNkDRyyFA5OyssqeiV/XVtOAo4Vt8/s5YSdPX9H1eQ9Bswyu7k=
X-Gm-Gg: ASbGncvRybYnGupo0djZaDOT3zQTB+Cr4XHwZe0Advq4icm5uIk7LCvbCUxpJfcPY/I
 tz2MRMLce8L0BlexBrv/ueULG2jf7bx1bloNMoRRDOt+9VL6qUH4JVGy71a/nJjY+n/HE4U7dbS
 6gQ7UyRYGesL/Gc1YaMk05jGN4bPDCPihHpDfCNUUFMr1VBJbZ6c6Z8WvKieskRrSdOE7HtzoHt
 hccmQJCxknLOXyx0o67bqupnlK8Bi5p/DoXGpyyvaDJCfmUioJM+2J3pI1xdleDQmIxh+n6LMKl
 z6HJ7An2R6MJ7Q==
X-Google-Smtp-Source: AGHT+IFqSENDtEvRgG43k9iMiYLMOe5sDtKia0Dtjo+U6yoF7xtts0hwmAmfYg7gaG9LMq5ZmZA8tw==
X-Received: by 2002:a5d:5985:0:b0:38d:d3e2:db32 with SMTP id
 ffacd0b85a97d-38f70783f03mr1672448f8f.7.1740141868226; 
 Fri, 21 Feb 2025 04:44:28 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::766e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm3640123f8f.27.2025.02.21.04.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:44:27 -0800 (PST)
Date: Fri, 21 Feb 2025 13:44:27 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 2/3] target/riscv/kvm: add kvm_riscv_reset_regs_csr()
Message-ID: <20250221-94f103225a50973887399620@orel>
References: <20250221122623.495188-1-dbarboza@ventanamicro.com>
 <20250221122623.495188-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221122623.495188-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x429.google.com
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

On Fri, Feb 21, 2025 at 09:26:22AM -0300, Daniel Henrique Barboza wrote:
> We're setting reset vals for KVM csrs during kvm_riscv_reset_vcpu(), but
> in no particular order and missing some of them (like env->mstatus).
> 
> Create a helper to do that, unclogging reset_vcpu(), and initialize
> env->mstatus as well. Keep the regs in the same order they appear in
> struct kvm_riscv_csr from the KVM UAPI, similar to what
> kvm_riscv_(get|put)_regs_csr are doing. This will make a bit easier to
> add new KVM CSRs and to verify which values we're writing back to KVM
> during vcpu reset.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 484b6afe7c..f14fcc58bb 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -605,6 +605,19 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>      return ret;
>  }
>  
> +static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
> +{
> +    env->mstatus = 0;
> +    env->mie = 0;
> +    env->stvec = 0;
> +    env->sscratch = 0;
> +    env->sepc = 0;
> +    env->scause = 0;
> +    env->stval = 0;
> +    env->mip = 0;
> +    env->satp = 0;
> +}
> +
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
>  {
>      CPURISCVState *env = &RISCV_CPU(cs)->env;
> @@ -1609,14 +1622,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      env->pc = cpu->env.kernel_addr;
>      env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
>      env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
> -    env->satp = 0;
> -    env->mie = 0;
> -    env->stvec = 0;
> -    env->sscratch = 0;
> -    env->sepc = 0;
> -    env->scause = 0;
> -    env->stval = 0;
> -    env->mip = 0;
> +
> +    kvm_riscv_reset_regs_csr(env);
>  }
>  
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
> -- 
> 2.48.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

