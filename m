Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C094C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 01:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGqWT-0003E0-Ox; Mon, 10 Jun 2024 21:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGqWR-0003Ct-EZ; Mon, 10 Jun 2024 21:42:03 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGqWM-0005cP-8A; Mon, 10 Jun 2024 21:42:03 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4ecf11aa0d6so188287e0c.3; 
 Mon, 10 Jun 2024 18:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718070117; x=1718674917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xa+n96y0gDYnND7n3cHGPnTzb6psA8F+bpijnL1i9+0=;
 b=cjIUzSM80NpuLeRES+Mj55yWG5dNwaq/4aVP9/buLqcp1oQ9h+7ZfjKaqLJqUCaQU6
 4fl3pwtLf0iemIOqbohBtUW9mQ+NEoJfM/gRwvct29y09UWm9CPA2Wqp2h7FhPF9l4Fs
 oZqEhajEZovp5OQTRTslN2bvF9GBUjo7AR3tnmjoAf6vkvDuFYLrFEhrqACejptc2Pb8
 1jYWDYJ86/Clnd8/WOdJT3qkdum5m301fqDwzX59tahW382WlJ849JrBsSO1Pucxqut7
 Bg+hwwcejTa6rSh3uXPW9BTm7MinDcMK9OoExw88KHtT9M4SWBSXMGcqmPVmOWyLSvOr
 u2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718070117; x=1718674917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xa+n96y0gDYnND7n3cHGPnTzb6psA8F+bpijnL1i9+0=;
 b=PGxASgfhe819EjORiPNnJMDoBegXhvdaMkhxaIxVJ0q0mpRBYUfN25rE4HUJ3hOqgt
 XDSB+l+EOTKD3AL8Z3WoxDZ296l0O7SQZ4Ovq7U89BmQZPTA+O1GNDYvouf1296smYuT
 009rAe1E6kotkFmgpm17zzuF0R6rzycuCylM5lwV2JacNm7Jb+FGFvNZGkVAK7cnk4dB
 V1XWeCMezdEe07EyGutIwygJP8booJMVOX9YiXn8Qt6ibOwHwfwHDcY9BbhHMsLD4kgZ
 HUZMNZp+1IyBz2lVNSndJFnIHpQq5PXsMVY7O8Q6eMxH2p9MQOBQ6Yic7VttPVYjOgYd
 qaKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw+D55BPgCy1NTTeYQdDiBtndqX1IwXVlDuJKRe77FHZ2YsrwssdzXnTTIMPWaTxTcEMARo8i7uRo4ZCiTW3aYzBrkBs4=
X-Gm-Message-State: AOJu0YwvR7pVn4zmM6KDDlJD0dcH8Z6EMCAP5pdN2ueOctNaGV+Pe+Zn
 6iW93lnYUrtm7MAc5BXsBUNoj3ifNq5KcJEj/Y6LaYEsapbU/7Ccd/RFhfBRm9hSWqL+q1OnbGW
 ccF1FcAzXhp8T3mMmHjXeR5Apx/s=
X-Google-Smtp-Source: AGHT+IEFRQ8KSRo9PFopH22F+oUr9brjH6iwKZLzR3jxIYiP/5iFcuY+TvdcYk45kbGxpv1BRjX8dAMo+AifNWKf6Zk=
X-Received: by 2002:a05:6122:987:b0:4d4:1ec7:76e5 with SMTP id
 71dfb90a1353d-4eb562dbdeamr10693398e0c.16.1718070116793; Mon, 10 Jun 2024
 18:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063154.31298-1-frank.chang@sifive.com>
 <20240605063154.31298-4-frank.chang@sifive.com>
In-Reply-To: <20240605063154.31298-4-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jun 2024 11:41:30 +1000
Message-ID: <CAKmqyKM5qicwaubjrjgT3jduM9Fgyk0raYaACkocfc5cLf6F4g@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/6] target/riscv: Add MISA implied rules
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 5, 2024 at 4:34=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add MISA extension implied rules to enable the implied extensions
> of MISA recursively.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c7e5cec7ef..a6e9055c5f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2242,8 +2242,56 @@ RISCVCPUProfile *riscv_profiles[] =3D {
>      NULL,
>  };
>
> +static RISCVCPUImpliedExtsRule RVA_IMPLIED =3D {
> +    .is_misa =3D true,
> +    .ext =3D RVA,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zalrsc), CPU_CFG_OFFSET(ext_zaamo),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVD_IMPLIED =3D {
> +    .is_misa =3D true,
> +    .ext =3D RVD,
> +    .implied_misas =3D RVF,
> +    .implied_exts =3D { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVF_IMPLIED =3D {
> +    .is_misa =3D true,
> +    .ext =3D RVF,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVM_IMPLIED =3D {
> +    .is_misa =3D true,
> +    .ext =3D RVM,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zmmul),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVV_IMPLIED =3D {
> +    .is_misa =3D true,
> +    .ext =3D RVV,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve64d),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] =3D {
> -    NULL
> +    &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> +    &RVM_IMPLIED, &RVV_IMPLIED, NULL
>  };
>
>  RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] =3D {
> --
> 2.43.2
>
>

