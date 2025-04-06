Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD62DC36002
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 23:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ZJI-0005jh-9D; Sun, 06 Apr 2025 19:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZJF-0005jU-Cv
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 19:21:49 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZJD-00024e-Ni
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 19:21:49 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-524125f6cadso3635482e0c.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 16:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743981706; x=1744586506; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzWH4p4WrwqYp+u1AO+prUMimKIZsduf0eSLku3hp50=;
 b=Cq8vIpy/b0C9A1XTIlsQSyRbLRQITz0j0zSByk+aHDxZ7R6ltBMc83wjsYkdIaMvcc
 FeLBJfqrh3QOzFnnuc0C9iu30/cMsqHSq2n1u/THmiyz6tc3ejnhAyp/Z6eJmRYxfYUi
 W5jFMdeEdpICoBQ0e3lrUG9g4xVa24699ZZptSzh7pEwFK2QXR7vPgm1oVDWH1FZzpva
 AbMlIB6kZMhFX7F+AMlsva79FJXAwS3tOz8F9M1Sl7KCr8ER/oCEuOGg1s4b8/8KCJVa
 FfKSun3p2AdZZRxTqWWLvjSiwySPy9oW9OYsYLxxp9VaYrwezmEOQRB2gaqm3v+I2ePT
 rY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743981706; x=1744586506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzWH4p4WrwqYp+u1AO+prUMimKIZsduf0eSLku3hp50=;
 b=TH3WIms03ATtApte4+FfxQTDXFtXr4iqi4b1akhDfT2e2wNE3lpVfzEDATK2t9WRn4
 74hTu17DHlvnwgFl5xgscrSbTDlEtbvxw3bNt7zwzmpjCyOoF9JNSjEPJNEF1zs5KCot
 hUxFRjFi/umSbkLIGol85rZ5HWhfOwRy/XWOt+KxmGkvgHeeYXBmabpl2PmMWyT1HUiJ
 a7Zju+RppSMVIkF8hofzRoEaRgSg9WVxvVKdZaHaaFfHI9AEpRT2NMSbbaDBr8Z7r5U5
 SV9wWrAsgG8dMWywr7rBZMooJLiUoU1hLl8+cx2jZur3QWy+rpnlrGJZpl4XeF+teJLG
 f4EA==
X-Gm-Message-State: AOJu0YwrE2jioUyjWz3LL5JYJyfMyhnR7AUw3eP8xAFTlZpfygGzPrQw
 sul1xAi0krMDy7VRPXuuHPxkcrJBH+POgJ2w3Ju3uAnzg+3BjdNupyQpGC8CNrTOKsBEtqTmSoT
 nPUpJmnRMqbvxy8eVzJcXRpHnHnc=
X-Gm-Gg: ASbGncubr6rOSaHNoNaQ06mLSTwDU+Xt3YorInDN2yfhkgtNl3U3CmF3czcipE7EKRb
 xxmnZ5IzT5d6dgEt1LjIWa47J3c4gdD+4Nbo8drqULDRaKgolPXi8hWOHztHHQ6J7STSJvmkpsv
 xnD29UpfOHR5TiPsLCpv9uWjsHVJKdV8+6M8OTLg1hwDtzfQprlP5FLkdB
X-Google-Smtp-Source: AGHT+IFx3+WH5xqYewO+T5eLfSyYS71od87zzX6+yw/ByojVhnuXCqBZ/Md8oF5AAj1jU5RZRKSqJ11eOggws4nBkqM=
X-Received: by 2002:a05:6102:3f11:b0:4c1:b3a5:9fa with SMTP id
 ada2fe7eead31-4c856a2201bmr7372043137.16.1743981706061; Sun, 06 Apr 2025
 16:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-8-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-8-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 7 Apr 2025 09:21:19 +1000
X-Gm-Features: ATxdqUGM_dbjZrMiy6XRtlJfbyZp2oz4KLCGrmlhUzZbkWIVVOotYGAVr6XhiSM
Message-ID: <CAKmqyKONiANs7KZchDjdmdjJtP6qMNiZSuoMB7Sz6n4Tdp2C-Q@mail.gmail.com>
Subject: Re: [PATCH 07/27] target/riscv: introduce RISCVCPUDef
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
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

On Sun, Apr 6, 2025 at 5:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Start putting all the CPU definitions in a struct.  Later this will repla=
ce
> instance_init functions with declarative code, for now just remove the
> ugly cast of class_data.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h |  4 ++++
>  target/riscv/cpu.c | 27 ++++++++++++++++++---------
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7e10c08a771..65c8d6855ec 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -541,6 +541,10 @@ struct ArchCPU {
>      const GPtrArray *decoders;
>  };
>
> +typedef struct RISCVCPUDef {
> +    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
> +} RISCVCPUDef;
> +
>  /**
>   * RISCVCPUClass:
>   * @parent_realize: The parent class' realize handler.
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9603f8985b3..3bd2bff1328 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3082,8 +3082,9 @@ static void riscv_cpu_common_class_init(ObjectClass=
 *c, void *data)
>  static void riscv_cpu_class_init(ObjectClass *c, void *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
> +    const RISCVCPUDef *def =3D data;
>
> -    mcc->misa_mxl_max =3D (RISCVMXL)GPOINTER_TO_UINT(data);
> +    mcc->misa_mxl_max =3D def->misa_mxl_max;
>      riscv_cpu_validate_misa_mxl(mcc);
>  }
>
> @@ -3179,40 +3180,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt=
, char *nodename)
>  }
>  #endif
>
> -#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
> +#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_DYNAMIC_CPU,                   \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        }),                                                 \
>      }
>
> -#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
> +#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_VENDOR_CPU,                    \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        }),                                                 \
>      }
>
> -#define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
> +#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        }),                                                 \
>      }
>
> -#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
> +#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
>      {                                                       \
>          .name =3D (type_name),                                \
>          .parent =3D TYPE_RISCV_BARE_CPU,                      \
>          .instance_init =3D (initfn),                          \
>          .class_init =3D riscv_cpu_class_init,                 \
> -        .class_data =3D GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data =3D (void*) &((const RISCVCPUDef) {       \
> +             .misa_mxl_max =3D (misa_mxl_max_),               \
> +        }),                                                 \
>      }
>
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
> --
> 2.49.0
>

