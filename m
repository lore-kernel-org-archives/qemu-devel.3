Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CACC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HDZ-0001s9-Nh; Sun, 28 Apr 2024 22:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HDX-0001rK-CZ; Sun, 28 Apr 2024 22:58:11 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HDV-0007gU-Px; Sun, 28 Apr 2024 22:58:11 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7f043c9ac21so511823241.0; 
 Sun, 28 Apr 2024 19:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714359488; x=1714964288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWwcOUI0Ski8rwAVhPLbh2YHTrVkrbfZzVtbEfFr5e8=;
 b=lVmXr9IosFhfbgl4i1A0T4xZyxMuOFAdNHGIlxNe4OS01RD+EWM7ygcr1fQBqEorOs
 pIveYHaeDyGk8zxZtrtVthG1x4NVCdLYA0a9RGv6pNS6mGOvzf14fgg4uP2ZNsqb7/g2
 D5DX2GFOAuLtMmzJaBrgetSvUu78BP34UpnqllDMzMFzsNXF5+opJ7OdS8GCijH798Oo
 W2u25P3PB4asg3SaphSgpj4dbt5pwvPtbi/On6sSTusTDfwBtYgKWnuuSyGsNR5ySlSf
 ZPO4evndwic1gRDLx7uJheuUPacjLXAneedSsB2T9hgJ6M56NmP/iO0l6WOFaR/h1yGG
 yPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714359488; x=1714964288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWwcOUI0Ski8rwAVhPLbh2YHTrVkrbfZzVtbEfFr5e8=;
 b=pcQwBgW8fmHQsxmATi98EuncqTRUfQzpjqpPyZedH/SVa5LVtRs/lFPtWkjxPAu+rJ
 PDoIztou0lplAwVfhk7JjHrT7JN/RB8T6kjc1ZRNdJfonlqQAGeBxZDAxIu0tERN88GF
 eftDMOPjdqPYIDXspgVFhMyq96mgEzl2Pj1D1ycmcMzdsvyJwDoXZaPDKNtnhdyDK8uD
 OqbNMyhq3lyboXB0vhSszUSBOHh2oAaMm7or6cr1XVZINsy0iM44K+qRTiSkVdYtlvDx
 cTubMYhCTfMV2BySE5DRtFh0AOh4svzX/LcI+PM4/4XHwoiEZkioMr0Pj/F46ODeuPvI
 Iyiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmhXACN7FtK1a/1GO4fyuMDM1LyaSuy+ugc1RODRAX2TzQ85K4x8mlBVU2gEAwNG8i0i/8KUnbZvWQTyqNenoxSGM1mxs=
X-Gm-Message-State: AOJu0Yz2lZC675MyUSJiYwWwlzsI1TV145IlxKrzkwR5TvFhWrbnd9Zh
 zTr0aioSl/LdKXLgRum/fdSgAbdJLKj5hiT+EJ3pXKmv2GdqgEZPJ/wMBONqfd9BFG10reAqESV
 vWdDwScdHaquh+l3hwz1mfq+KQ1yE+4gS
X-Google-Smtp-Source: AGHT+IGgKoM3PG6+wqWCWgIdRdJEEqKmo9aaz9ziQzhmcxOgnY5TmI0yaRkWlMfGDejfEuDFeRTmb4xSm/bnh+/yc7Q=
X-Received: by 2002:a05:6122:328f:b0:4d4:1e99:7c8f with SMTP id
 cj15-20020a056122328f00b004d41e997c8fmr10814123vkb.6.1714359487237; Sun, 28
 Apr 2024 19:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240422171425.333037-1-dbarboza@ventanamicro.com>
 <20240422171425.333037-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240422171425.333037-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:57:40 +1000
Message-ID: <CAKmqyKOAx-DuEe3dP9T8GcWt_Vm4RLLJFOZm8FXzRqKm1DwE-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv/kvm: tolerate KVM disable ext errors
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Tue, Apr 23, 2024 at 3:15=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Running a KVM guest using a 6.9-rc3 kernel, in a 6.8 host that has zkr
> enabled, will fail with a kernel oops SIGILL right at the start. The
> reason is that we can't expose zkr without implementing the SEED CSR.
> Disabling zkr in the guest would be a workaround, but if the KVM doesn't
> allow it we'll error out and never boot.
>
> In hindsight this is too strict. If we keep proceeding, despite not
> disabling the extension in the KVM vcpu, we'll not add the extension in
> the riscv,isa. The guest kernel will be unaware of the extension, i.e.
> it doesn't matter if the KVM vcpu has it enabled underneath or not. So
> it's ok to keep booting in this case.
>
> Change our current logic to not error out if we fail to disable an
> extension in kvm_set_one_reg(), but show a warning and keep booting. It
> is important to throw a warning because we must make the user aware that
> the extension is still available in the vcpu, meaning that an
> ill-behaved guest can ignore the riscv,isa settings and  use the
> extension.
>
> The case we're handling happens with an EINVAL error code. If we fail to
> disable the extension in KVM for any other reason, error out.
>
> We'll also keep erroring out when we fail to enable an extension in KVM,
> since adding the extension in riscv,isa at this point will cause a guest
> malfunction because the extension isn't enabled in the vcpu.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80..03e3fee607 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -427,10 +427,14 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVC=
PU *cpu, CPUState *cs)
>          reg =3D kvm_cpu_cfg_get(cpu, multi_ext_cfg);
>          ret =3D kvm_set_one_reg(cs, id, &reg);
>          if (ret !=3D 0) {
> -            error_report("Unable to %s extension %s in KVM, error %d",
> -                         reg ? "enable" : "disable",
> -                         multi_ext_cfg->name, ret);
> -            exit(EXIT_FAILURE);
> +            if (!reg && ret =3D=3D -EINVAL) {
> +                warn_report("KVM cannot disable extension %s",
> +                            multi_ext_cfg->name);
> +            } else {
> +                error_report("Unable to enable extension %s in KVM, erro=
r %d",
> +                             multi_ext_cfg->name, ret);
> +                exit(EXIT_FAILURE);
> +            }
>          }
>      }
>  }
> --
> 2.44.0
>
>

