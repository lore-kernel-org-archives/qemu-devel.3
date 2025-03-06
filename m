Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048C3C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzPy-00045L-WB; Wed, 05 Mar 2025 19:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzPh-00043L-JT
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:48:37 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzPb-0002VB-2D
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:48:36 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-51eb1a6ca1bso44316e0c.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741222105; x=1741826905; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJIxgGcmsHfi4xxhDUKac2s9O88JEn6+Y9+97eSEgFw=;
 b=NLbAbKM4+qrFjX9J/f4Btuq+v+lCFx+3hzFtgqHz6VAGFuIBDs5nZQfUZdNuub/GgU
 A0YwaAmVjOdx4hARrw+3/GHsWwSOqHyduNabwZhcuXAEzZuqNX2Dl/s1E3ZAjFe5daG3
 MFzAtXxD+jriFObkLfHfy9IPbhgHg5G2L7/XXmeiO2q+Dic63Gm9wDWaz7PLZbDoPPEw
 U9igHSxh3y+tKrvaDtenIjYaXqVmyNQRXjU7LPJXjJjgxiqzIxHoUbdhURIPancCTnW8
 //kyEcLKGtbEXXc5RDR5yVOJUf7iykcX70WU4+wgoanXXLiG7fUL+dSitnF3KLhYm5qD
 RFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741222105; x=1741826905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJIxgGcmsHfi4xxhDUKac2s9O88JEn6+Y9+97eSEgFw=;
 b=Qk65HX/uRPK/SDaivV0EkWjuPyfhNVkd5WfB9R6ynFT1q9gAe1STFZEpaRTLkB6+M1
 uJvIvJxn34iKJln5ew+d78QsL62BeOCmWPEAvtKplpNWSKLNxqO9H1DD2ylFOoe0Klj9
 l43asfcY+B+vQ1c8rgWoT5UN0+6uT/uy8eugloQgN87WMhkDpyMPaE0dvhmbkzRofFUM
 mBTmGl4Fm1cUtwu0D284nphOEacVX0awPxcHBoxJr40A+P+UtZdJ6Ivy7KaYiqTRa+K1
 ZNPzEU5Ns75i0PyCAm9yGdufEdDH+Wf3Euefo3FQlrhBsaWaCecbwC3C5qmVaeo2IQLk
 x+iw==
X-Gm-Message-State: AOJu0YwX0S0vJOK1faWlL2M9BIZF74t67qXwzCndM9qEeQc5IXfJJ5a7
 MZNgkn6lIscS2pq1+Qkttit0/Zsye9NXgrEKX/DVYOj3MeV90ddNr3sMGAXslD0RrK5An7u+W2L
 K2cX1AN3heNJ46KGiK16KaGBss+GP7CBp8mM=
X-Gm-Gg: ASbGncvMBgJJc/T31VsFpJvdzFw5OToPjoud0YixOhrSZIKm33RRmcMfQFWcAxI0OSP
 LB3gQMAl1VrxabTTh+iMNiU3VN9G/aYqTYVa12UEB88+JdtbeaQaBHVS/A1DYeNxte1QQnaJLJZ
 PxdH2aZQn1nlgEnJIWNjf9atx92ajtvHzBaQj3imfiYJmbTsLJPD6cbCxL
X-Google-Smtp-Source: AGHT+IHRqYPY7SNFyytaHA574Av5ZbO+pgJMGnqEFK5nLFQBvHNA2HAT/t2rTSMHUWx953xMuknYfQBC3wKeqt/hRMc=
X-Received: by 2002:a05:6122:608e:b0:520:5a87:66fd with SMTP id
 71dfb90a1353d-523c6271ae0mr3553862e0c.7.1741222105297; Wed, 05 Mar 2025
 16:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20250228102747.867770-1-pbonzini@redhat.com>
 <20250228102747.867770-3-pbonzini@redhat.com>
In-Reply-To: <20250228102747.867770-3-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 10:47:59 +1000
X-Gm-Features: AQ5f1JrWoZSl0Tq5t9FSTHaIuke0WrtpaxMEAH5nfn1ykQKV8QbhVmH0r_zsYlo
Message-ID: <CAKmqyKPjf6Z7r+iRjrjYt5C3H1ophMcj=y-1WWvFaKrKse9ZSg@mail.gmail.com>
Subject: Re: [PATCH 02/22] target/riscv: Convert misa_mxl_max using GLib macros
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Fri, Feb 28, 2025 at 8:30=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Use GLib conversion macros to pass misa_mxl_max as
> riscv_cpu_class_init() class data.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Link: https://lore.kernel.org/r/20250212213249.45574-8-philmd@linaro.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 85dc2fe3bec..f05b72ac873 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2961,7 +2961,7 @@ static void riscv_cpu_class_init(ObjectClass *c, vo=
id *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
>
> -    mcc->misa_mxl_max =3D (RISCVMXL)(uintptr_t)data;
> +    mcc->misa_mxl_max =3D (RISCVMXL)GPOINTER_TO_UINT(data);
>      riscv_cpu_validate_misa_mxl(mcc);
>  }
>
> @@ -3063,7 +3063,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
> @@ -3072,7 +3072,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  #define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
> @@ -3081,7 +3081,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
> @@ -3090,7 +3090,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
> --
> 2.48.1
>
>

