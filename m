Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049F6C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 13:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to0G2-0001rB-Rz; Fri, 28 Feb 2025 08:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0Fi-0001ol-Dp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:18:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1to0Ff-0001IV-ER
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 08:18:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43b5859d1f1so12819235e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740748682; x=1741353482; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vfFy+L8iby7WsIIVP+lx+2gVqx7wGt08/h0S2I0Ai+o=;
 b=JHhQPefS8+xCNHfsGOSJH2VLbxP/64g+kUJtA6ygME1AYKB9Ycv2/a2sR4b23YXyWc
 Qbw5o0ks/hwpNNYdiW1NyMEJwzD5BsCJslW3YxhV/W+C0B+qzsvTBtM4ZXRLuuIeyVF/
 VKnUXSxpe0hUiGNrLnZHg6OGFHbKZXjWvduJPYmZ2TYJSPe2hWZ/Q7EEn5u1BsTdkMtq
 5KgKRlhqmKfRNoNDfVNoNykiXCHnbjCTwYd6X57eTL+WUGwmeiZdWWhF2NAoldVOiecV
 6wc2PHrk+rKWvPT0XENQnEHslQTvzwQXJ8TDfRucsKKDAOos3WPeS6fvWUBp+d8CjtqE
 EjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740748682; x=1741353482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfFy+L8iby7WsIIVP+lx+2gVqx7wGt08/h0S2I0Ai+o=;
 b=Ov/6yJCHdmmSek0U5h6IvCVHQi/Xah49Ssa+6aqx5sSUWfLl9ZhfUZPluGBP54ZXBC
 pUdF7kkCBLmGojFQfqAmEfWOtUOUI1hoAWx4s5R2A1UuTo0cqwtGKOvZlwfFywtgsKqR
 IA+KMKcaChLL20lNsnTFTYN3dxvaDtl5CTrp0jV3EQc2Gd7IfVWTNkMzz3LoHWPE2D/K
 hGh5P1K3UiOhHdU11+VAG9JcvjfHNjFCwkQPNSZ77kuTdbT9SrOkr3xuuRYALmtFhnzw
 Ks8nRcV7mJg8XFcTIFos7JVR7W5lCVUyEnp74dgBb2+8TxfTIflFCBae2gzWJKfYEPjl
 P2Fw==
X-Gm-Message-State: AOJu0YwcAefpmuBgbxtFUO1sfPprGKRIS+ns4+SXkZBBjN/uaxwio9DI
 q2HqLeTqDmF+Yuuz4Ypr+IA/drJqxfOWETk/5L8x6/iXEc83vSamvrKrvWyYUz8=
X-Gm-Gg: ASbGncuLK8skYLQYR5+PrztHulD58mhPtVHTcPCnn7rcSzuR2dhTyloOYXeR9EZKtGq
 g/qcWfkc0AGjaYSw9/5ZUECIrrHTXES1anaiOqMXk6cwbVVLogE8+ITYsiBMI5Vk1thOR64G9S2
 38gArDzEWiLOXLiA+A8gP/x7LxQZ+Kli1DAGnC07ZSquznRlJgIFJLw4gSMKidoF6Www7JtcwOK
 jKv1U5FICKyHTK1Mrd22zAWCxJw6pQN32esudZzHQMKb3PwNqHEs407/tdxTpJVnewIGzEK3ASB
 DHZ/5eBOMxq1rQ==
X-Google-Smtp-Source: AGHT+IFvydfhNJuUL46+pNTDXI2wPngp72uDCnOfjdL0+Qm2L7BDfm2bqreZXif9TkY9Sl7pmNWEAw==
X-Received: by 2002:a05:600c:a48:b0:439:99ab:6178 with SMTP id
 5b1f17b1804b1-43ba66da248mr27446245e9.6.1740748681684; 
 Fri, 28 Feb 2025 05:18:01 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::688c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7371701esm58217235e9.17.2025.02.28.05.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 05:18:01 -0800 (PST)
Date: Fri, 28 Feb 2025 14:18:00 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 2/8] target/riscv/kvm: add KVM_REG_RISCV_CSR_AIA
Message-ID: <20250228-7b19a9cfc42f2b5fcc2ab85e@orel>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
 <20250224082417.31382-3-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224082417.31382-3-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32b.google.com
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

On Mon, Feb 24, 2025 at 04:24:09PM +0800, Yong-Xuan Wang wrote:
> Add KVM_REG_RISCV_CSR_AIA support to get/set the context of AIA
> extension in VS mode.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index ff1211d2fe39..c7318f64cf12 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -132,6 +132,9 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
>  #define RISCV_GENERAL_CSR_REG(name) \
>      (KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(name))
>  
> +#define RISCV_AIA_CSR_REG(name) \
> +    (KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(name))
> +
>  #define KVM_RISCV_GET_CSR(cs, env, idx, reg) \
>      do { \
>          int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
> @@ -644,9 +647,50 @@ static int kvm_riscv_put_regs_general_csr(CPUState *cs)
>      return 0;
>  }
>  
> +static int kvm_riscv_get_regs_aia_csr(CPUState *cs)
> +{
> +    CPURISCVState *env = &RISCV_CPU(cs)->env;
> +    uint64_t mask = MAKE_64BIT_MASK(32, 32);
> +    uint64_t val;
> +
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
> +
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(sieh), val);
> +    env->sie = set_field(env->sie, mask, val);
> +    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siph), val);
> +    riscv_cpu_update_mip(env, mask, val);

The *h registers should only s/r on 32-bit targets.

> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_put_regs_aia_csr(CPUState *cs)
> +{
> +    CPURISCVState *env = &RISCV_CPU(cs)->env;
> +    uint64_t mask = MAKE_64BIT_MASK(32, 32);
> +    uint64_t val;
> +
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
> +
> +    val = get_field(env->sie, mask);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(sieh), val);
> +    val = get_field(env->mip, mask);
> +    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(siph), val);
> +
> +    return 0;
> +}
> +
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
>  {
>      kvm_riscv_get_regs_general_csr(cs);
> +    kvm_riscv_get_regs_aia_csr(cs);
>  
>      return 0;
>  }
> @@ -654,6 +698,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>  static int kvm_riscv_put_regs_csr(CPUState *cs)
>  {
>      kvm_riscv_put_regs_general_csr(cs);
> +    kvm_riscv_put_regs_aia_csr(cs);
>  
>      return 0;
>  }
> -- 
> 2.17.1
>

Thanks,
drew

