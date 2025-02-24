Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA7BC021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 10:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmVFW-0003hM-T3; Mon, 24 Feb 2025 04:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmVFV-0003hA-6B
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:59:41 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmVFN-0003G3-KH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:59:39 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6fb7d64908fso35203687b3.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 01:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740391170; x=1740995970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m3KglIjf6ji1bqOAeWAwF/JZZNcLvsq10cRCA75mzVk=;
 b=uLIooGi7gbStv9NF2wE2Lt1EYZ7RJbiUC+UPdNpsO+lx76u9tBkHtgAUk6qiqGlloN
 QaPXiby+fzNRx/AepVzEjzC4ayhMMtTK6m94JNX3dAUBhLh9W73e5EiIoTnmO0hJFIiY
 WEuHezPXjQRAP1bmO9JbGmm760maMQ0G5kXS16RbsE01ukhQboUlfDtXfpfMhXs3pEOL
 YbxOT0QvgbT9mHSxlcfdcvkGMR3mf+jWbFK+Nk5lM380E5z3DicKT6yow/JmgDEY2guv
 TiAVngMX7BeEg1Dpx7shmnm4orijTSIhPGoWHxS0c/KJQ94oAeQi8nhKSZ7FY8JccmR7
 NlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740391170; x=1740995970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m3KglIjf6ji1bqOAeWAwF/JZZNcLvsq10cRCA75mzVk=;
 b=o5kWUtHBXYKX+7OAwVkRb2gUEEbwb6F/pFZioilw4CgCXvWqsGjvHrCJuohwLAVshz
 C0AuVZNCabSfpWVXmVhJtsCSSs8aZASRiuVb+neIZOx1NIZGSidN9Tl4Mmr5Gww+K7Rp
 JbXBs+kQ3yjHENAw1eOAl5/JIQqOVPsQCSJkms8uPDaZc4cs2sE78xRlysYzVuf/9VHN
 5cNnW3XTmvrOl/oCoFTkPSGiEVJCzVU71gvVj4oXhOhWzMQ2KvIHNy4bPiy5jKoxcQoq
 wKZaza4fvkvF7HuyKliOIqBi4oU47nojNf5scfP8cSgminpfGzoSeyVaPRvTPkiN3HL8
 8agQ==
X-Gm-Message-State: AOJu0YyIMYWpIbILuxwpqrO9RZfYGnR+JvW9KODufVdPaKdQxNY1B1Kq
 ZW94ViX8BQs05iXYRUI8wVrNvuEQW1FrQ799br7tAI6GzeG1Ul3btyOLNTJWGziZ1blqAjtA8Rx
 q8U2ixGqpQWv4jAyCfn5gjvh37W/lXeA2a7q5Ww==
X-Gm-Gg: ASbGncsD/g9ZsaXHdvaGPIyGhU2We1kvmokMqJaDaaoZ6ICgo8CA4rubsKHSOsmxuOU
 CaKUnj2CSthyZ5syJW0rE2bYam42S069jWjJ8kZxtCwFH5kCOmgH8hUMOJjJw86nd0atUlars93
 bGKWMnKXZB
X-Google-Smtp-Source: AGHT+IGEMB6D+o0cve05P8d+NfPG7k59awKr5Pd3Gx5SsXMgueMOD3P1ut3nv40cQENY9PMNrX4qoixQeYUlVAdUkDo=
X-Received: by 2002:a05:690c:8f:b0:6fb:4648:3425 with SMTP id
 00721157ae682-6fbcc2346ecmr105900067b3.16.1740391170219; Mon, 24 Feb 2025
 01:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
 <20250220161313.127376-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250220161313.127376-2-dbarboza@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2025 09:59:19 +0000
X-Gm-Features: AWEUYZlmWOg2HUqpWcSmaYSeZOOkYTsiwHUa8UCdt5WGgYLiHlnNtscgSp6yLbA
Message-ID: <CAFEAcA8u8C2HTRjOBReSQ7oN7L248034VrfTHYgHCxBPy0gwDg@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv/cpu: ignore TCG init for KVM CPUs in
 reset_hold
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 20 Feb 2025 at 16:14, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> riscv_cpu_reset_hold() does a lot of TCG-related initializations that
> aren't relevant for KVM, but nevertheless are impacting the reset state
> of KVM vcpus.
>
> When running a KVM guest, kvm_riscv_reset_vcpu() is called at the end of
> reset_hold(). At that point env->mstatus is initialized to a non-zero
> value, and it will be use to write 'sstatus' in the vcpu
> (kvm_arch_put_registers() then kvm_riscv_put_regs_csr()).
>
> Do an early exit in riscv_cpu_reset_hold() if we're running KVM. All the
> KVM reset procedure will be centered in kvm_riscv_reset_vcpu().
>
> While we're at it, remove the kvm_enabled() check in
> kvm_riscv_reset_vcpu() since it's already being gated in
> riscv_cpu_reset_hold().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         | 9 +++++----
>  target/riscv/kvm/kvm-cpu.c | 3 ---
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 522d6584e4..8e6e629ec4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1050,6 +1050,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>          mcc->parent_phases.hold(obj, type);
>      }
>  #ifndef CONFIG_USER_ONLY
> +    if (kvm_enabled()) {
> +        kvm_riscv_reset_vcpu(cpu);
> +        return;
> +    }
> +
>      env->misa_mxl = mcc->misa_mxl_max;
>      env->priv = PRV_M;
>      env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> @@ -1146,10 +1151,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>          env->rnmip = 0;
>          env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
>      }
> -
> -    if (kvm_enabled()) {
> -        kvm_riscv_reset_vcpu(cpu);
> -    }
>  #endif
>  }

This looks super odd, from an "I don't know anything about
riscv specifics" position. Generally the idea is:
 * reset in QEMU should reset the CPU state
 * what a reset CPU looks like doesn't differ between
   accelerators
 * when we start the KVM CPU, we copy the state from QEMU
   to the kernel, and then the kernel's idea of the reset state
   matches

This patch looks like it's entirely skipping basically
all of the QEMU CPU state reset code specifically for KVM.
So now you'll have two different pieces of code controlling
reset for different accelerators, and the resulting CPU
state won't be consistent between them...

thanks
-- PMM

