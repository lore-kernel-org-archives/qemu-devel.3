Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FD4D10F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 02:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCr3k-0007pr-Vw; Sun, 17 Nov 2024 21:00:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr3i-0007od-Ry; Sun, 17 Nov 2024 21:00:11 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr3g-0005nN-Iw; Sun, 17 Nov 2024 21:00:10 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-855eeff6448so511420241.0; 
 Sun, 17 Nov 2024 18:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731895207; x=1732500007; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RrUaLQL7nf8hsiTj2ZoC0nxH5GlLa7XuGaM637Z1z8=;
 b=EqJjEAaNRd4RqhLKcV2mpdIowgOF6tPD393kY97HoXb2FhxtePu5n7USIX/gW73c8Y
 nlemMfz5v4oY5E0JEtD1Xhg1NHpORS3wou4GOWI0pBGOkaOXj4DL1bDANeC7Yqwuazxu
 zNmqAotokoWDYwms0wJ/DYmN7cPQ+u5mWFqXDLonV9xjE2B/+Rn22o7UcRBkYaz3WHVG
 zwbao2OI2UELv+ch+bkXmXVHpvhaWTdPF4gonn0c+03kppKhDNoTcfJ2cC/A3+l4BKB6
 tfjU39ghj4EsMOWeSNk8PKPtDGs9KQ8OXb1dxvEfmQ8yLV0s7x9dH7dAowlpqYFXy9Cl
 Dgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731895207; x=1732500007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RrUaLQL7nf8hsiTj2ZoC0nxH5GlLa7XuGaM637Z1z8=;
 b=Gx69RgJuyimPu7OeWOcAzJhCENPf4HTLsKBkA061RHmG8PLBkYQQacfJ/9+rkGDCIp
 IysWTiaK5aSdW/VrWPCdAbOS4ExceSThUvDtEebgEYcXgfmPt2jRLbkcqoCWNNQBH7ku
 dMa7ceOJDiJUxrhwotJXNxFGwW/TlinM+NWBYizCwNAn6U+3xBNqDTzFMFZB/rERcSdU
 1bUCPEP7Mq+RSO+FWSobrWyFATEPAn9kqM2GqU1ZJB4U3Eg8NdJ2uUtKojckri0b5TaI
 PVCyzTGOAQ7VMa5zEEaV2ai7gXh9smJxtI7iJIVRNRYqNpDn/8NaM9ExXFILunksSz4V
 SfgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2oEGZuFsiJHw/0q1V200Q3hi+DtelPHiulYyzbYprZvNY03pkAbJwJD4r0U8HkYAfAsBgwDkZaMwk@nongnu.org
X-Gm-Message-State: AOJu0Yz2Lmb9hXi8I1s4pUNZH2DwnIvR9q9ACMIWM71hQPVuN1LxRtjw
 OlQxAdzJIL13o03ODEpg+6PGVAEmZODDHBhJIl0YrYA+4WGTxLIfnYfbOmz8+ljUPSGW1iORuW7
 L+HRbVj5UWKfEyw1ekbSqDZKm/Gk=
X-Google-Smtp-Source: AGHT+IH7+iXgs66asrLX4D8+1NN81epQL3K2MRfy4n0Sx8ux6/WqLI8hjXvGKavO/+jLCavhoO5CYBpHb8FcNJepDmU=
X-Received: by 2002:a05:6102:26c5:b0:4a3:dd83:c0ac with SMTP id
 ada2fe7eead31-4ad62d334b6mr7559925137.20.1731895206788; Sun, 17 Nov 2024
 18:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-8-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 11:59:40 +1000
Message-ID: <CAKmqyKNU_8g0jiLGKSSVWh5uwxs7Nt+_ZFuNzmbuGHeGJY=Y-g@mail.gmail.com>
Subject: Re: [PATCH 7/8] target/riscv/kvm: remove irqchip_split() restriction
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Fri, Oct 11, 2024 at 5:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Remove the 'irqchip_split()' restriction in kvm_arch_init() now that
> we have support for "-accel kvm,kernel-irqchip=3Dsplit".
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index a92a46694a..3d0584277c 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1401,11 +1401,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>
>  int kvm_arch_irqchip_create(KVMState *s)
>  {
> -    if (kvm_kernel_irqchip_split()) {
> -        error_report("-machine kernel_irqchip=3Dsplit is not supported o=
n RISC-V.");
> -        exit(1);
> -    }
> -
>      /*
>       * We can create the VAIA using the newer device control API.
>       */
> --
> 2.45.2
>
>

