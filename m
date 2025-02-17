Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBDAC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 05:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjtSA-0007OP-3s; Mon, 17 Feb 2025 00:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtS7-0007OH-0N
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 00:13:55 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtS5-0006Zj-5R
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 00:13:54 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-868f18a629bso1020861241.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 21:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739769231; x=1740374031; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYBpVMZqhpCDWukXAAqTxSRB9H5W2DcST9YxgP/3iRI=;
 b=kIy766UCDFXDCC+P83sDwGgLxJNeP4wTNCOnRiFSS4xV1mENgFAijZ4QC/zhijKZu9
 CuyiEmzRxBPRevGf1r3Il2s5Qxm+kNRspgxf2lADfdEFfCZrnvmeuJ44QqKkp56Ux2Md
 oqYEtIWI2gEP0CLcN/DRpEdLPzm6Qbs/ttRKSZvW9qV97RDHeRW5cTxF20vnnzvcPZXx
 cOKtCDKIAqZYP+vtsEeAg+yD1yjeIJgUIRqnrZb0SxQuudg79y8pQNh16kpNxIS9mJO5
 hFRpTxZk8WF+tTQB/OOw+git1o1gouma/HuivS7Aw+00Gwf8B+y4iFFNIQPcjv6ZHkoe
 R9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739769231; x=1740374031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NYBpVMZqhpCDWukXAAqTxSRB9H5W2DcST9YxgP/3iRI=;
 b=KjLdaKCELAg6Zb+TQ+99zbvEVYFDLR6NhWJRuNFevShVgPs9P//t06Cnpy8i7NWZVR
 Z6n/oFLpEhX5lTTQ7NVfxyGpWFNU3Fh/KDwGpBX5w382tIXVH2hMvnlihHbUxcY3l1SC
 AxAG08xMi4Ngm8bcjV7FebQJ8+bwUZExjVQf6wEEGoFPx4//Cky6SfXBSM9tEeaqeiFA
 dP0mlDE5zxAkrsVbVk7JDeSBEzRh68FDSW1BKWv848IkFbSEveawg1w3j9Mm4m2owGaj
 H1e5bsMZ3Raujv8QPGb4rkT46vfomu5DqH/pAltRNt7gIODZRh4nM6X7uFJmn02JiFiK
 CO9w==
X-Gm-Message-State: AOJu0YwFBb0ZnbMgZWUyTQQvu7rXzoB/U0Jt+zZ/FCpQa0GXE2sGgl/o
 uvwg6xXQPO5nJrN5HDenTCEgb+A8F2cRPezTYWXPmAeVoRNqbEhWLFdwQ9AVrsjjSMM3efw7UFI
 5z/7yAY0MYkHUQbyI2kpF7WxpOdE=
X-Gm-Gg: ASbGnct4WmxUYbHaD6NpSbU+nPTAT9x3sRxfVaGhWy/lia7YnVlaG6DTwFHpHd9i3Ky
 5ZCO8DTb4LB1Q0soUeKzDAVk5gbLPP2jfxfhpJC8zajztSimWxhWLCHCrhQS65QpmiFKC33VJFm
 T/5I7Y2ntGjX20jFFp9NwD79KW/A==
X-Google-Smtp-Source: AGHT+IHL5cHRSCIquL9ORCbNtngnCkLjqkUoXYm2S2/KiaraxicBNXQ4N3cBVHe2Vw47kD0dNgF3RI5+4X8K8nkaVtE=
X-Received: by 2002:a05:6102:2910:b0:4bb:c24b:b63c with SMTP id
 ada2fe7eead31-4bd3fdfb87amr4112584137.17.1739769230780; Sun, 16 Feb 2025
 21:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20250212213249.45574-1-philmd@linaro.org>
 <20250212213249.45574-8-philmd@linaro.org>
In-Reply-To: <20250212213249.45574-8-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Feb 2025 15:13:24 +1000
X-Gm-Features: AWEUYZmv67m3XmTIits4RJB-bziIKwvj9-Z5SoI2Gg3n5V1DOu6g7cZ4JnKw4-o
Message-ID: <CAKmqyKN33mRHYY44Cw7341x48MM8=TCPsR8EvWNFTsyrgqSQBw@mail.gmail.com>
Subject: Re: [PATCH v3 07/19] target/riscv: Convert misa_mxl_max using GLib
 macros
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Thu, Feb 13, 2025 at 7:34=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Use GLib conversion macros to pass misa_mxl_max as
> riscv_cpu_class_init() class data.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f3ad7f88f0e..9fe1b23a297 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, vo=
id *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
>
> -    mcc->misa_mxl_max =3D (RISCVMXL)(uintptr_t)data;
> +    mcc->misa_mxl_max =3D (RISCVMXL)GPOINTER_TO_UINT(data);
>      riscv_cpu_validate_misa_mxl(mcc);
>  }
>
> @@ -3057,7 +3057,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_CPU,                           \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  #define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
> @@ -3066,7 +3066,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
> @@ -3075,7 +3075,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  #define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
> @@ -3084,7 +3084,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D (void *)(misa_mxl_max)                \
> +        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
>      }
>
>  #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
> @@ -3093,7 +3093,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
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
> 2.47.1
>
>

