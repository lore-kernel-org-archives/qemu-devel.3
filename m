Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A202C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGhP-0001wA-LX; Wed, 30 Apr 2025 19:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGhN-0001vq-OX
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:18:41 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGhL-0000xX-F3
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:18:41 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86d42f08135so97713241.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746055117; x=1746659917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPJFTyr2oxy3PHpUb+m8//45gtX6j2I97iOLW0mr5dY=;
 b=dixGyjSkBv5rhfzTxMai2Q6X7GfuZDrOWu55XbuUl2zqLGdxf/awf+oSRsHWL/AhHL
 /3n24qMU/w5VyhIu984TtJb8kkFm4Agqsb96RHF7R5zc7MM+YFxE/wUm1Tn0U+uW5A1r
 ki3mHY+PAB1TGVD0tvxSXwzvCvx8aE4y20YWFlSeVUuKx2NVKfZbEkNp4aUQ3tbQTNEv
 954Mg05mUNe+4WR/NKYKEZPrPcZxrQBVwGCQeHIakvaiiLIAL5zZrNd9WD+JBWrqppYm
 mKdUkq9i/5JeEkAqk6aPsoBVz8/iV/13YpahcNS4WWW+JKnGmZGkYauvV/QuiL1W/MMD
 WzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746055117; x=1746659917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xPJFTyr2oxy3PHpUb+m8//45gtX6j2I97iOLW0mr5dY=;
 b=BUdwGKnAB5ENtyJ4SzankdwQ7XvTuM8fsu+n2+MsrmPbYzRu5bp1AP6FZj+rxRfEpG
 uipFyswrtr81VqcvVnyugrsfcSuotRJagccYzVmYimCYyWA3EBzjlM6JDIHWtTmX8P5d
 HRK0lctOPOZ9TeLiHDqBMQz6i8hG8JOSKjs4pilejZjkU2IdraLCyrK8ypqbTlreXJcz
 wgVhlNDpje/yqa4yEoyDs7y9ZgHB3Oa/Mo9MEUt0NlFEswpWRASZfGfcFDt4LKp7Q7d9
 EZck9t2RiKrSLLh7K2DbbvzE0Y8ACUAkGzPgpAWZyqhm9W65XSuSA7VfyZ3sK8nl6Yzl
 4xnQ==
X-Gm-Message-State: AOJu0YzuRmvycUPGLrE6usqc7URgzn90+MP8DYMiAT/eA6WpJufEUDj7
 95jc8OfMAtbfFjjRJTYR/ZGGf2kHKFF6tZYIt9/h5S+wq7E6aYruJFxapxTIINKK1lww2r2yjWK
 QsIHHruW8CipgDqOc8nFjTVSzHi4=
X-Gm-Gg: ASbGncvYn/qjSXp/4Qe4qsEAF5I5mLqfiydMEDeLnNV9+zq5TtHIJOmDhbj2Gyezr4o
 FnTbmptKnQjFjlQWsAGr24glcVskcooQ8kpnNcGcF60+3TaAmM7OmpSmjiix8cFNv6EZg1QZ3zW
 +KE8DXBmFVL77s5CJabfxpz6Fgjjjc0y966+kgIsE65MHUp7w4YIjU
X-Google-Smtp-Source: AGHT+IE2OuC0dVzPjw3XWvuXWyaJWTPUhjJPTlnlN2suzDXhGGe5+4Bz1H2mlVN9WgD5b+Y/s38A0x3L9lenPGk5fbU=
X-Received: by 2002:a05:6102:f91:b0:4c2:f972:b699 with SMTP id
 ada2fe7eead31-4dae534dec3mr1017552137.5.1746055116840; Wed, 30 Apr 2025
 16:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
 <20250429124421.223883-9-dbarboza@ventanamicro.com>
In-Reply-To: <20250429124421.223883-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 09:18:10 +1000
X-Gm-Features: ATxdqUF-dGxlopOh90ND0t9TkPnDPimM2a1O3NMYVuqwxvg_SN3egEixBv8Lilg
Message-ID: <CAKmqyKMVXUZ2U14hL3s4k2ZA6NE8xroimsWo8b1V7uodGzoXLw@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] target/riscv/kvm: read/write KVM regs via env size
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Tue, Apr 29, 2025 at 10:46=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're going to add support for scounteren in the next patch. KVM defines
> as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
> field. This will cause the current code to read/write a 64 bit CSR in a
> 32 bit field when running in a 64 bit CPU.
>
> To prevent that, change the current logic to honor the size of the QEMU
> storage instead of the KVM CSR reg.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5efee8adb2..d55361962d 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
>      const char *description;
>      target_ulong offset;
>      uint64_t kvm_reg_id;
> +    uint32_t prop_size;
>      bool user_set;
>      bool supported;
>  } KVMCPUConfig;
> @@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *c=
pu, CPUState *cs)
>
>  #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
>      {.name =3D _name, .offset =3D ENV_CSR_OFFSET(_env_prop), \
> +     .prop_size =3D sizeof(((CPURISCVState *)0)->_env_prop), \
>       .kvm_reg_id =3D reg_id}
>
>  static KVMCPUConfig kvm_csr_cfgs[] =3D {
> @@ -646,9 +648,9 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>              return ret;
>          }
>
> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint32_t)) {
> -            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint6=
4_t)) {
> +        if (csr_cfg->prop_size =3D=3D sizeof(uint32_t)) {
> +            kvm_cpu_csr_set_u32(cpu, csr_cfg, (uint32_t)reg);
> +        } else if (csr_cfg->prop_size =3D=3D sizeof(uint64_t)) {
>              kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
>          } else {
>              g_assert_not_reached();
> @@ -671,9 +673,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>              continue;
>          }
>
> -        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint32_t)) {
> +        if (csr_cfg->prop_size =3D=3D sizeof(uint32_t)) {
>              reg =3D kvm_cpu_csr_get_u32(cpu, csr_cfg);
> -        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) =3D=3D sizeof(uint6=
4_t)) {
> +        } else if (csr_cfg->prop_size =3D=3D sizeof(uint64_t)) {
>              reg =3D kvm_cpu_csr_get_u64(cpu, csr_cfg);
>          } else {
>              g_assert_not_reached();
> --
> 2.49.0
>
>

