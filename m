Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32544C28B22
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzTl-0005dN-2N; Wed, 05 Mar 2025 19:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzTi-0005dB-Ta
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:52:46 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzTh-00031N-BI
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:52:46 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-523b7d9749eso47582e0c.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741222364; x=1741827164; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9RpSKUR2+gH+PyEKHIj6do7LKZZnnUuEUqHLtLo//4=;
 b=f4vr/deYmv3R94V5DpquEWOtbOKSi4bqMvRc3aJclAGPqeN/CspSjIy0B8+VKqVBOi
 TT4Dw0WqGu9F0yRt5JpvXtFas/1lATTLdqMDdKoU+MFmaRuw2iunH9IMeig3QRTDIoc2
 tit6haQLQFsdUkVjWwbwmVOQ6PylmHCRw/Pi2lLAjA+CzN6fMRR79KK5rfBsYJUTR04Q
 6zTR6NkXK69Y4ut6lSJp4Tg+q0f2djYnkcD4CuC91cDIO1sw7cuipAuien0hOYon6oiR
 +739hM/lmUQQ9JKC+MnTJxMLbBB2Ydr7MlsDXo1ZBg0j8oH8daMU5lNJFKtGZh/aIQwl
 mCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741222364; x=1741827164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9RpSKUR2+gH+PyEKHIj6do7LKZZnnUuEUqHLtLo//4=;
 b=FisA1rLgrPyzP81YNlN0q+z1ecydLk5VlyJKf4W5xUX0wU5mS7SgGBsqBOthmRHaKl
 Etodk7dg8Na9pV4SAmGATJFSJq2K1hzcRNeD8qSeOG1RtKVsD6KuQY/dSTZXHapT3V98
 6BSxllsxnN8bqjDFiJI4YVI682cCW1n9s7aJW1LwpmjJoB3dxGTFSwYzx2HJ7C2tiHCR
 BoUzkKp5xHEeHRFhE+wH9v89cmnNEmeZsImX9FpN6XXYIQA0Yq2jOlc4/XeS4zqNqa1I
 zXIz5Uyh4iy37cibgfpe8G7Vg22wLkK77kDCmY3gjzr85ThNQ9w01rtXfQBxzrvZbLAD
 FXWg==
X-Gm-Message-State: AOJu0YzlGCh+Z7RK5HGhcmYrxainmlTnYLALme6V5RDGZehJ/q1mW2rv
 iROch1VqbxN5C0Ao9uGVCPxkD9IAY5aL1+KInPrXTkIvIQTYojhCNEDd/z7qWkJhvU/8ROdh4sz
 Yzwdlyq3RBcTF9dBd5rwuxE/Sl/s=
X-Gm-Gg: ASbGncuvKE/p5CM7Pgv/l3g920Oy0W1iZXQ89ZM+XwCq0Bn8hsj523sSrXBdGO1pf89
 0sV73yT3pkt53sWeg/QUC8epXsW1bjifdDQNhKPhxDa1wGB7A6smEook61EvQmD2I69PVFpUANk
 Zr2X3l0O9RCr5v+uFKwZQJUCVKRLERMwTZ1XBWASEhMuYrNU7y4rfphlvG
X-Google-Smtp-Source: AGHT+IEF6w39hlwo2z3x+RAhBcIgS10/n6Ha+BCeh4baSQ14mbwikhqIxLBFy4dx739v2Jxxd+R/sMKgnqeIOwAVBNY=
X-Received: by 2002:a05:6122:d21:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-523c6281025mr3621784e0c.9.1741222364112; Wed, 05 Mar 2025
 16:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20250228102747.867770-1-pbonzini@redhat.com>
 <20250228102747.867770-6-pbonzini@redhat.com>
In-Reply-To: <20250228102747.867770-6-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 10:52:18 +1000
X-Gm-Features: AQ5f1JpLwDQnFNcfK5roT0JHKvQX03A7HuUApvvwt0BbRPqTTXv8C5UesBFBw94
Message-ID: <CAKmqyKMoYBijwP364B7gkB6Ji9DQs8YH03uOQbDN-H5zw+Gkog@mail.gmail.com>
Subject: Re: [PATCH 05/22] target/riscv: merge riscv_cpu_class_init with the
 class_base function
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Fri, Feb 28, 2025 at 8:33=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Since all TYPE_RISCV_CPU subclasses support a class_data of type
> RISCVCPUDef, process it even before calling the .class_init function
> for the subclasses.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 51acce07752..91dd63edc9f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2967,15 +2967,18 @@ static void riscv_cpu_class_base_init(ObjectClass=
 *c, void *data)
>      } else {
>          mcc->def =3D g_new0(RISCVCPUDef, 1);
>      }
> -}
>
> -static void riscv_cpu_class_init(ObjectClass *c, void *data)
> -{
> -    RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> -    const RISCVCPUDef *def =3D data;
> +    if (data) {
> +        const RISCVCPUDef *def =3D data;
> +        if (def->misa_mxl_max) {
> +            assert(def->misa_mxl_max <=3D MXL_RV128);
> +            mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> +        }
> +    }
>
> -    mcc->def->misa_mxl_max =3D def->misa_mxl_max;
> -    riscv_cpu_validate_misa_mxl(mcc);
> +    if (!object_class_is_abstract(c)) {
> +        riscv_cpu_validate_misa_mxl(mcc);
> +    }
>  }
>
>  static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
> @@ -3075,7 +3078,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> @@ -3086,7 +3088,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> @@ -3097,7 +3098,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> @@ -3108,7 +3108,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, =
char *nodename)
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
> -        .class_init =3D riscv_cpu_class_init,                 \
>          .class_data =3D (void*) &((const RISCVCPUDef) {       \
>               .misa_mxl_max =3D (misa_mxl_max_),               \
>          }),                                                 \
> --
> 2.48.1
>
>

