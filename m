Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C868CAC587
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxzfN-0004l0-9h; Sun, 14 Sep 2025 23:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzfK-0004kV-NN
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:14:06 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzf6-0005Xz-MN
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:14:05 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso664982866b.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757906023; x=1758510823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EgP1maVVrfSdNFLzOv+Up8mZ/T60j6DzA8MvihJxCQ=;
 b=NooRkHOVBDHaaMhSHvuYrB9GpJi+VLbk9VuIOoXSQ9uVi8expQUk2iC1HPcR124Un/
 JeS4mYVw15YZ7NeE0AcBWg6dpLpdm8YnNMh7C3g0df1Z/bDU/hkGFPoMN1+GPGLOUfmw
 ZK9zWVGIw5KTj2hiOpxs6oC0khDwGr87zv7Wu7SPdFVQZm3n3NA0FIdQYr8LH6FZNQ/t
 VuXC4EWK4a2f/0AKh6aunUxLOEtH7iBIldcy3qkwoZL5jzaqAH9ab60NFnu9FMY7zDwe
 UgYD24vyjOqTQY4UFF57ebRQip+dL2L2OXP3W8liNkxeYVgOzRIB/YUtZOY5I3CgxW9M
 0uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757906023; x=1758510823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EgP1maVVrfSdNFLzOv+Up8mZ/T60j6DzA8MvihJxCQ=;
 b=iDV4sNF2ARvgVvcSWUmbUU7AehSI1yWKbNV2LejUKEYZ6vIZF6i/e2N/W6wFx+LdJ1
 UmxVXPe8+pU5IiZMbSa8tBPE96JvCX5B76vg+MWX0iAWrZ6GX46Rc/HwTHmeUycQkb26
 n4FevKGiNMZ+xUdM6tK4BjGT4wBr6ktO/9uVGpklAwjQ+PiZ65M2UVW1sN3+ag1V8wDy
 nOwf8hib8wA8KCmsnL2CMJBf0hnDVJEaLbwcm0eVVC2U5yjsc//265fuWb6pto00E9xD
 epj0N09aKW5Ukhl7PpquB+/A8Zzr5RbEYVq+ZiboybpvApF9FAxvteO1PXc2pGbvmn/r
 npMQ==
X-Gm-Message-State: AOJu0Ywbj+JC/Qv08Dw7S4CDqPAIUC+BhdvY+shhCrs4ZHfhBfAm5LwS
 dva0/lk01+HCyqTWa90cvlUj6evlcw2Y+ZO+sX2PtXmUhTY3l7i1RGSObDHbxLNRaq3QznCRWa1
 GXdkwPscOtn1QjM3iQM+gmSmIsqbet9I=
X-Gm-Gg: ASbGncsl21ofiM7SC5iaTbbue3HyJnjYV8T2goOoX8xBOYMrCYO65YzDaATU8/j0Ks+
 Jxf1NGgJHnimca0dtvy9FaLcitEpb3Ot1SgrEGudaLFZN6TFk7oDo4nqY5a6YnyY3ayQ+4D7HqJ
 6sFxzTbaPLQG//HzK81afVFw5XM3AfFWzF940lAwNpMzo56rDU2rIIjEwRnrIDbIs4qJIbJYMsw
 Lc83uLgxrubROPHxrzVTsyUp74Cb5iaLAlXfF/RNRF+cvU5+vdGMuEvVrU=
X-Google-Smtp-Source: AGHT+IFjwniv8z7k9rKcNsMnIqvRgrGw2CUCjd3gOl+cgzWTmgRVmQRj1fwNewqtnc0dogKNeHiPEr7Rhg5B6iGIGEU=
X-Received: by 2002:a17:907:d8c:b0:b0d:416e:2892 with SMTP id
 a640c23a62f3a-b0d416e2b83mr498103466b.32.1757906022546; Sun, 14 Sep 2025
 20:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
 <20250623172119.997166-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250623172119.997166-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 13:13:15 +1000
X-Gm-Features: Ac12FXwN5CsHDFGCT1kbKOS4i4abkn6bigd4oShMg-IP1xRVlA34DRuSWYoHYHk
Message-ID: <CAKmqyKNhsgRRJ5o8WrSPe50kq2uqMOm6dnfQZ5r1J9RYCstgtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv/cpu: add riscv_dump_csr() helper
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 24, 2025 at 3:22=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> riscv_cpu_dump_state() is using the same pattern to print a CSR given
> its number. Add a helper to avoid code repetition.
>
> While we're at it fix the identation of the 'flags & CPU_DUMP_VPU'
> block.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 54 +++++++++++++++++++---------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e3f8ecef68..67e4eda4f9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -515,6 +515,21 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
>      return cpu_model_from_type(typename);
>  }
>
> +static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
> +{
> +    target_ulong val =3D 0;
> +    RISCVException res =3D riscv_csrrw_debug(env, csrno, &val, 0, 0);
> +
> +    /*
> +     * Rely on the smode, hmode, etc, predicates within csr.c
> +     * to do the filtering of the registers that are present.
> +     */
> +    if (res =3D=3D RISCV_EXCP_NONE) {
> +        qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> +                     csr_ops[csrno].name, val);
> +    }
> +}
> +
>  static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> @@ -565,18 +580,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE =
*f, int flags)
>          };
>
>          for (i =3D 0; i < ARRAY_SIZE(dump_csrs); ++i) {
> -            int csrno =3D dump_csrs[i];
> -            target_ulong val =3D 0;
> -            RISCVException res =3D riscv_csrrw_debug(env, csrno, &val, 0=
, 0);
> -
> -            /*
> -             * Rely on the smode, hmode, etc, predicates within csr.c
> -             * to do the filtering of the registers that are present.
> -             */
> -            if (res =3D=3D RISCV_EXCP_NONE) {
> -                qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> -                             csr_ops[csrno].name, val);
> -            }
> +            riscv_dump_csr(env, dump_csrs[i], f);
>          }
>      }
>  #endif
> @@ -589,12 +593,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE =
*f, int flags)
>          }
>      }
>      if (flags & CPU_DUMP_FPU) {
> -        target_ulong val =3D 0;
> -        RISCVException res =3D riscv_csrrw_debug(env, CSR_FCSR, &val, 0,=
 0);
> -        if (res =3D=3D RISCV_EXCP_NONE) {
> -            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> -                    csr_ops[CSR_FCSR].name, val);
> -        }
> +        riscv_dump_csr(env, CSR_FCSR, f);
> +
>          for (i =3D 0; i < 32; i++) {
>              qemu_fprintf(f, " %-8s %016" PRIx64,
>                           riscv_fpr_regnames[i], env->fpr[i]);
> @@ -612,22 +612,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE=
 *f, int flags)
>                      CSR_VL,
>                      CSR_VTYPE,
>                      CSR_VLENB,
> -                };
> -        for (i =3D 0; i < ARRAY_SIZE(dump_rvv_csrs); ++i) {
> -            int csrno =3D dump_rvv_csrs[i];
> -            target_ulong val =3D 0;
> -            RISCVException res =3D riscv_csrrw_debug(env, csrno, &val, 0=
, 0);
> +        };
> +        uint16_t vlenb =3D cpu->cfg.vlenb;
>
> -            /*
> -             * Rely on the smode, hmode, etc, predicates within csr.c
> -             * to do the filtering of the registers that are present.
> -             */
> -            if (res =3D=3D RISCV_EXCP_NONE) {
> -                qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> -                             csr_ops[csrno].name, val);
> -            }
> +        for (i =3D 0; i < ARRAY_SIZE(dump_rvv_csrs); ++i) {
> +            riscv_dump_csr(env, dump_rvv_csrs[i], f);
>          }
> -        uint16_t vlenb =3D cpu->cfg.vlenb;
>
>          for (i =3D 0; i < 32; i++) {
>              qemu_fprintf(f, " %-8s ", riscv_rvv_regnames[i]);
> --
> 2.49.0
>
>

