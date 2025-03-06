Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EFEC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 02:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq1RQ-0000Po-ME; Wed, 05 Mar 2025 21:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1RH-0000Oj-F2
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:58:24 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1RE-0007TE-27
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:58:23 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86b6be2c480so53740241.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 18:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741229897; x=1741834697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dx41IxRFuGBO9NbXaW5qACYj+Ex+B8ynmTNGCr8UAgw=;
 b=nF12E7XniPeA4BeIZmtIFstVPYr4iQerlBIvfsjbz6H0YohMbPVMDmakee+cLUCHge
 FUV7xfBH9SfLt8vzuyqUvIpBizBm+5uJqZgAPD8JT1ctgKYcvvWOZ6LVXpLXTsEuTYec
 l3hOfh8anCc0Lg8yw/Sa8uW5pfMzu1DX15Yw7zQ9oZkBIfdQIkLZ3e7cCKFTMQe4U6En
 VvfVNd+kQM2aBx3jvZkXeOy3wr5EuSF6lYWhNlIjB+HRYbujjOCkLGOtGFAB1R1oRIcT
 Q0Z5hcau/El5ByKIpVJm9n0vlt5IRr2AnZ6LjGYQtEAkKoe0yFPvdMajnbCguNPfMaKC
 cjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741229897; x=1741834697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dx41IxRFuGBO9NbXaW5qACYj+Ex+B8ynmTNGCr8UAgw=;
 b=ADr54AVtASg6So3ze/M2ahxAlLzgxxlX9CrxYm6VrGy/IppzfYRRhBwlAb6f4aRLL8
 OvJkC39bqeYMB4BlFKJ9FyN/J1DZnNnk/V2TA7Y6cOnqyfqB2206RY1C8CMCJRhUTJtn
 8v9lJORjnsMMtLJ/7BrtiG6FqRM9BFeqPKF04t2eX8vwkdOhPb6O7gWZb45zOcC6slTx
 P2zN3iX8j12BanvZ4qRw35l4rEvhtHfu1w5YEYSFUqSQmZqW7gw71bkd3l0jMFz/4AYN
 VJUkYrD5JI708oqAwkH9ijdiBm+mY1520YgNJuJ1BdLt/RDLjBtUvmi9gS8ciiEMCsCt
 gpLw==
X-Gm-Message-State: AOJu0Yys9nmoO2ex6qZvwS4wtiRfitpIB2oDwMbRHJd5evLvNJHmf3F5
 flh/MGP/MHsitpqpVxgSST+PTWpxoBmCO0eymcFPtdzo4QSaSt5IgX353zPlzUX29d/N93695UC
 lfd/OnikoV8OKJpO5M/omx5xssCklzB4y8B4d8w==
X-Gm-Gg: ASbGncv5KFPSvWo5YZFkNJrbeC1KA+baVCm/JyResckhYLnQXrDNHBkOXCVR83d/kFm
 BsirO1xhdVWqP+aVwoAcHw6u9xlzx/IhBKVWtk32rw58UHY6/DZm+vcp/TZcQGs9f4NRXB28TfH
 Jp49qWVgE0/k1G5ldB4epIPllva+tG0BNll78+aGjNkH1posncUIl9aJQv
X-Google-Smtp-Source: AGHT+IGHvwPwzrjpOckGPQes+SQHhVyOpm2xNb0Q6lTKDm+mipeXhNfHPCoP2BKVamozS85tXhruUKFRH6PplA7QLE8=
X-Received: by 2002:a05:6102:3a0c:b0:4c1:924e:1a2a with SMTP id
 ada2fe7eead31-4c2e2980bfcmr3652666137.25.1741229897193; Wed, 05 Mar 2025
 18:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-5-pbonzini@redhat.com>
In-Reply-To: <20250218165757.554178-5-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 12:57:50 +1000
X-Gm-Features: AQ5f1JrI7z49rkFLxcRFLkSQ3QMR8GE2GIuI9233eWmkRe8cJ3zGQVF9CU7dUpo
Message-ID: <CAKmqyKP7YpCz7gCdLepZ-BAAihUt3QzHePyo+UC8c-acB=n_+w@mail.gmail.com>
Subject: Re: [PATCH 4/7] target/riscv: cpu: store max SATP mode as a single
 integer
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Wed, Feb 19, 2025 at 3:00=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> The maximum available SATP mode implies all the shorter virtual address s=
izes.
> Store it in RISCVCPUConfig and avoid recomputing it via satp_mode_max_fro=
m_map.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This fails to build on the latest riscv-to-apply.next
(https://github.com/alistair23/qemu/tree/riscv-to-apply.next)

../target/riscv/cpu.c: In function =E2=80=98riscv_cpu_init=E2=80=99:
../target/riscv/cpu.c:1481:13: error: =E2=80=98RISCVCPUConfig=E2=80=99 has =
no member
named =E2=80=98max_satp_mode=E2=80=99
 1481 |     cpu->cfg.max_satp_mode =3D -1;
      |             ^

Do you mind rebasing?

Alistair

> ---
>  target/riscv/cpu_cfg.h     |  1 +
>  target/riscv/cpu.c         | 11 +++++------
>  target/riscv/tcg/tcg-cpu.c |  3 ++-
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index b410b1e6038..28d8de978fa 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -192,6 +192,7 @@ struct RISCVCPUConfig {
>      bool short_isa_string;
>
>  #ifndef CONFIG_USER_ONLY
> +    int8_t max_satp_mode;
>      RISCVSATPMap satp_mode;
>  #endif
>  };
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7950b6447f8..2d06543217a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -444,6 +444,7 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu=
,
>      }
>
>      assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
> +    cpu->cfg.max_satp_mode =3D satp_mode;
>  }
>
>  /* Set the satp mode to the max supported */
> @@ -1177,16 +1178,13 @@ static void riscv_cpu_disas_set_info(CPUState *s,=
 disassemble_info *info)
>  static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>  {
>      bool rv32 =3D riscv_cpu_is_32bit(cpu);
> -    uint8_t satp_mode_map_max, satp_mode_supported_max;
> +    uint8_t satp_mode_map_max;
>
>      /* The CPU wants the OS to decide which satp mode to use */
>      if (cpu->cfg.satp_mode.supported =3D=3D 0) {
>          return;
>      }
>
> -    satp_mode_supported_max =3D
> -                    satp_mode_max_from_map(cpu->cfg.satp_mode.supported)=
;
> -
>      if (cpu->cfg.satp_mode.map =3D=3D 0) {
>          if (cpu->cfg.satp_mode.init =3D=3D 0) {
>              /* If unset by the user, we fallback to the default satp mod=
e. */
> @@ -1215,10 +1213,10 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU=
 *cpu, Error **errp)
>      satp_mode_map_max =3D satp_mode_max_from_map(cpu->cfg.satp_mode.map)=
;
>
>      /* Make sure the user asked for a supported configuration (HW and qe=
mu) */
> -    if (satp_mode_map_max > satp_mode_supported_max) {
> +    if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
>          error_setg(errp, "satp_mode %s is higher than hw max capability =
%s",
>                     satp_mode_str(satp_mode_map_max, rv32),
> -                   satp_mode_str(satp_mode_supported_max, rv32));
> +                   satp_mode_str(cpu->cfg.max_satp_mode, rv32));
>          return;
>      }
>
> @@ -1477,6 +1475,7 @@ static void riscv_cpu_init(Object *obj)
>      cpu->cfg.cbom_blocksize =3D 64;
>      cpu->cfg.cbop_blocksize =3D 64;
>      cpu->cfg.cboz_blocksize =3D 64;
> +    cpu->cfg.max_satp_mode =3D -1;
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>  }
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 0a137281de1..a9f59a67e00 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -693,8 +693,9 @@ static bool riscv_cpu_validate_profile_satp(RISCVCPU =
*cpu,
>                                              RISCVCPUProfile *profile,
>                                              bool send_warn)
>  {
> -    int satp_max =3D satp_mode_max_from_map(cpu->cfg.satp_mode.supported=
);
> +    int satp_max =3D cpu->cfg.max_satp_mode;
>
> +    assert(satp_max >=3D 0);
>      if (profile->satp_mode > satp_max) {
>          if (send_warn) {
>              bool is_32bit =3D riscv_cpu_is_32bit(cpu);
> --
> 2.48.1
>
>

