Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB1CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCI5S-0001qR-Cu; Fri, 24 Oct 2025 09:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCI5J-0001pv-DJ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:44:01 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vCI5B-0000TY-Sl
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:44:01 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78487b0960bso22927167b3.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761313426; x=1761918226; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=95i4oZgLg/VvWq9kaSxHTnN7P5gIDyXEX4/LTYsaoTo=;
 b=canrMWLggYHLxaPjqaaml1QgdoxqzV6/ud+sbqY9vcZyHrxjbwB54qyC8u2Z1N2WxC
 UvvEb9xDL4nj81vh8BQMHhHfJe3MU903vHFDQV8bazElqzGTo0PQUoeUzOJUOKnRQfcy
 FFreY7sqOEf7IHN82iFrthJFoK4oJnkD3BrZA1AY1APZA8721STVxXiQiwLlyD4Ocfat
 qw1nefO/hgmqq4MWncwSky/a4XPBFj5D2mtCm84++PKngkb+CiTFBbJPXbsVSImrnH3A
 cFUKTcQTDImEqD6fb6+Jz7W/S3fFEI6NsSJlnhMUiWh4P9opiwakYhErh1Q/oijdNd6Z
 toig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761313426; x=1761918226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=95i4oZgLg/VvWq9kaSxHTnN7P5gIDyXEX4/LTYsaoTo=;
 b=kVXMmEQQl3SKWQVgoDvdPSlxo3ainrrzf8dPER54QijwIJae/QKJNyzGq38vfnDk3j
 1RZu0Osilv2q0bG6oiyuCchW6CY7l48Ub+5kMM48hKpcn+ePwNk04PJrrIxpr1f6Xn9y
 9i8tdHb2blXibBzrotA3VrMIiK9TYWkCQbZlep/h9QqURXopGd38fW/PtC62/GOhvZDT
 R2AzqgGB7Je2/Vjj0X5CaYciOzRmWSiE+j7y9MI5jl7UQdnQbPJyN9C1GQQOl8glGHET
 GJx2xC0ZGy8hlBJG244AJNBtPyLB3GLaHVSDJ70BnR8nS/HcfeTPfRlJIr3WuVWZ8mvk
 zIow==
X-Gm-Message-State: AOJu0Yxm8PMXfkiT+RqgLDuEom6NBCtrrk7tl8B1A/pGIRsZCPyH/VIW
 9bR4e8sXNLlLVKgCFqQXqrKkYRsRYsjRhf/70vrloMyLTHWsnFmwi3/ona3E7dLB6uNOjvaynVt
 S4blyIcAe12+ta2omW33vLAANWoBnnR1t2wmdvtxXxw==
X-Gm-Gg: ASbGncuPR6afWXoyAU6133LI3M4SzowsktIpgqBhr1GxBLNA/BW64ZMat2d+lT+OdqH
 /8DguFyLIedcJR1KCccE/jMmue7cfuOoTjOpye1Gl3U/wzb1ElVVWk+RBKS9urt0v3Q/KQF/fcQ
 8pTdO2XHBxB1RBqIHdC/l2yINmVVs9gP3Y9LJ2WMSwLprYa0mFwPg2hfzBRglvMBQvgVJaDJL1F
 nDbgk4E4trdyK158oP9pbaUCc+SJv9M1ywd75MBnkXZ8HdQQgVDDV3OL9aJ1Q==
X-Google-Smtp-Source: AGHT+IF4imKZDiln1CIJoaFP96KWNoe6nwx5ZGtf/BDCMCppXHvrGFzh3iAZnBPaaYXXQxgM/UVFTn+IPErZ0o6CT/I=
X-Received: by 2002:a05:690c:6185:b0:785:bfd8:c4b1 with SMTP id
 00721157ae682-785cd9f9694mr54932517b3.2.1761313425711; Fri, 24 Oct 2025
 06:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
 <20250519040555.3797167-48-alistair.francis@wdc.com>
In-Reply-To: <20250519040555.3797167-48-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Oct 2025 14:43:33 +0100
X-Gm-Features: AS18NWCcljQhAZTolQhlN9OmytpTIn0TSdhfyammXmZrXXNx2ZyBx-SjWML4Ngo
Message-ID: <CAFEAcA_6zma2=nsBWB7ebb35Jt1cNAChiMG0xnkT3WPEY8csiw@mail.gmail.com>
Subject: Re: [PULL 47/56] target/riscv/kvm: add scounteren CSR
To: alistair23@gmail.com
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 19 May 2025 at 05:25, <alistair23@gmail.com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> Add support for the scounteren KVM CSR. Note that env->scounteren is a
> 32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
> to 32 bits read/writes.
>
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20250429124421.223883-10-dbarboza@ventanamicro.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index ca171d5457..82f9728636 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -251,6 +251,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
>      KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
>      KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
>      KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
> +    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
>      KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
>  };
>
> @@ -701,6 +702,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
>      env->stval = 0;
>      env->mip = 0;
>      env->satp = 0;
> +    env->scounteren = 0;
>      env->senvcfg = 0;
>  }

Hi -- this came up in a conversation on IRC. Does this new
CPU state field need migration support adding in machine.c ?

thanks
-- PMM

