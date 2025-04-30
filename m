Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DFAC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGfr-00016Y-3l; Wed, 30 Apr 2025 19:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGfn-00010M-Mm
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:17:03 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGfl-0000PF-JM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:17:03 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-877d7fa49e0so261378241.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746055020; x=1746659820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeWr9fL5VDgejJjtu23XFvEMVdcMEWmxm5aqShvpj5Y=;
 b=EoMR3FcfiLDv4vdMgKwCwwncclh3KDCLR9oAwacv/pUk7zAClAwuP+FmpQi9173QEY
 irmTrJ85L4rmHeQ46W5oTsAmJzrxIZXodtQyxR2wqPMz9zcoOpJ2WhylZaghbS63NbgG
 RfO/zFGy6vXbpuHh10c/Ff0eaNjem1x2UX/wvr0/EfdN7t1Md9AHJdggs5z3BZRMNo7x
 f2e+TxfH2mfOcNwePZl9uBLKiSTxzSjjeLsiYX0Qq5iNk6Jsq2MWZepm4Oy0R+G9BM31
 yE0JkZrrVeuS+YzwZ+hwL6lbh626FdivwlCH07Qy1EpSkOFIWbHqj+iAuszbBBD5ZdZJ
 y78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746055020; x=1746659820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeWr9fL5VDgejJjtu23XFvEMVdcMEWmxm5aqShvpj5Y=;
 b=FR1/D1/+sisjAJnQEivE7696P6MMatMx7RlZnd/qsMp16V0TwNQ0nFdjUzU2pgOMkD
 EmtKDd92yxfyVDdwr0pz747k1SjLQcJvRczEzO+UDd+g47H9uhJBO8IlWZLsmLLpSxBz
 /om7QZRs442sh0YOxsTt4nDs3S1fTbCJQ/mL46hKFNp203+leRXHpWz17H+3MgokHMj5
 H5VqT9RH9+vwyoyKIa6S2ttvMKl6VClOfjgFsDiEbkiW8XndZK/L0R3XKffriqGG7IJ3
 41rvJ3b9NEdUqlhlbZka3F66Y/vcshaMUHzkIG0I3sayXYGkJ6XcYICy8Wgkagv3Wvi7
 uI0Q==
X-Gm-Message-State: AOJu0YwyTIn+APVNP1iWqxuDCJ7frNmQSpW8ZQcefl1OINPj54GYCVDs
 AGbe6KnUobsyMZM6FGTuHDkFBSaS/DIF9LeMO/3qEvU6B8YPSFTfZnZ4P0VQOeOrZlpaXwWaNSh
 KOAJSHqJmHAU4060cwJ1RG9GLzEI=
X-Gm-Gg: ASbGncuzx9dIe+1FyU/2s1GzNAsB2HBsEVcLziGLYGg8AAG4z2uzH5nXUkd9cq/cW8c
 00OXkNruaijP7OSTmyOFo05+3parizRBbHwECHEuhtmn7wRgECYLd7I7FCBHL34CUhvpOvjcPaH
 y5v9fTlfCgbGhejm/ebciQDq87bi0Mkg2EVExxXaw7/mo0B3b1Z6aq
X-Google-Smtp-Source: AGHT+IE8XP5ccvy7h5MTig4yhZnqDFOsqM7A+M47vuVwpWZ9d32q9tUbZGMNiAwkTo0dgpXa400V1zrx+HJbTSJp0+A=
X-Received: by 2002:a05:6102:5793:b0:4c1:a15c:ab5c with SMTP id
 ada2fe7eead31-4dae926f1f3mr182743137.20.1746055020206; Wed, 30 Apr 2025
 16:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
 <20250429124421.223883-8-dbarboza@ventanamicro.com>
In-Reply-To: <20250429124421.223883-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 09:16:34 +1000
X-Gm-Features: ATxdqUEqR_V5SILlQcfOIfa3BScV1ZphvmTXunQOX99hcO3fNYq0OMq2kjBUoAQ
Message-ID: <CAKmqyKPRvz6vdwdGP=cyNMYY3+CbE_Uq1A=fydqXw_-ziRjD7g@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] target/riscv/kvm: add senvcfg CSR
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Apr 29, 2025 at 10:47=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're missing the senvcfg CSRs which is already present in the
> KVM UAPI.
>
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 1ce747d047..5efee8adb2 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -249,6 +249,7 @@ static KVMCPUConfig kvm_csr_cfgs[] =3D {
>      KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
>      KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
>      KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
> +    KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
>  };
>
>  static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg=
)
> @@ -698,6 +699,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *e=
nv)
>      env->stval =3D 0;
>      env->mip =3D 0;
>      env->satp =3D 0;
> +    env->senvcfg =3D 0;
>  }
>
>  static int kvm_riscv_get_regs_fp(CPUState *cs)
> --
> 2.49.0
>
>

