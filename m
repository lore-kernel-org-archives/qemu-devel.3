Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38F4C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpznr-0002Pc-KR; Wed, 05 Mar 2025 20:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpznp-0002PK-JO
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:13:33 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzno-0004vB-18
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:13:33 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86929964ed3so87057241.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741223608; x=1741828408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeBI3bM7FCw0yC1kvGAVnnSlIv7euB+xU2FOa3ZxnVE=;
 b=YnWwSk+8DRh0BntOi29crd+1EYSi0elTPsmrw8gyRC/YPGd643x2f1OLcx6SVX7LJD
 KGfyNVQcFSVls13lahwWS05ovaM5iyXvGpHoYrbDRxgLU89i2fzwg00Y2YreB32QVUMh
 NuwaX5HJ6E4Gu1U89oTrGnX65w2j2VXII3K07F5HWiknbtu1lVpO/ygNv2nkH5F91Jh9
 1LzcJIvTcfT93s3BTHUjHKiMNe/GLjdy+OunF3V1M3k07EF1A06ujaib2cQxU0ZOvH/P
 MUrj1BfB9WCiXDg8Cp26I8KAi3q0GXYsUIZdIxfSY001iAxsnEi8ggz9GBViebStJ1sD
 4Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741223608; x=1741828408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeBI3bM7FCw0yC1kvGAVnnSlIv7euB+xU2FOa3ZxnVE=;
 b=Cl/smIZdq6eYkfIluDwDLDFsC4wXAMEwo7DDd5kYl7y4LN6/PBeSqXiJtcAyUNLCuk
 Ke/SZLlHbhWMVXM+CizSi1/HHUuoD8cBk113y6dj9TljxDtYrNaUUSbGlOu/lt7M7bLf
 AqfitGZKy+XUtAE1jehrZgMvgUp8P8RlwSAoYbNS0zIlyj4O+5WwThxCd9z386K+ft9B
 6PSq7Z62ddD4ihad4VSQ7/HDAY/z0Z59Fg0VU17QcyyN8E6oXUcVG0m4dM/TanRwcAxT
 y4hU8atj1skVMKNTvbklDcJfWlgdUe+xwcMOKgiGO5DOCPZmOp8G7Prclg6K5PHASwrV
 CkhA==
X-Gm-Message-State: AOJu0Yw8KCWm1I1Z0eaSki7b9ArtP7Xw3QXL8+kURKUudmrjA3qTSg9H
 LkRwecVhCR/1/spJAKpJnMquLfAc5Shsuds8uaaGiiLuXZsB0xlVh14UoHHqPDft5nndTmR3pGF
 HIX+gfMqqXRE9Z2JYQw9wpC1ALAA=
X-Gm-Gg: ASbGncsQlLf80VVPQAkijTX33SmNI/RPX3n0BPostKQMuJM36Tc7ttS566KQamGAxOc
 8UGifXvbSI410bjv2VFNioBtMDyyiNZJEIcxT7O9VPeu9iysb0ZXqwk0tUY+wA2eIfaWzj4WDOz
 BcevbdK9LGiMLzGLfiY7ipxnjcRlCKH72NzXrCJlG8fdxcxfPa0E9+f5uN
X-Google-Smtp-Source: AGHT+IF6/rQoqj1eu97vDAP4uuhLcjcE7Z6AhL2HWTryQr0i7OEhO8xnbT6q4nKOwN5u7PKYI5nIoalQLXdZUcLX7Dg=
X-Received: by 2002:a05:6102:1498:b0:4bb:9b46:3f92 with SMTP id
 ada2fe7eead31-4c2e273e89fmr4232545137.1.1741223608496; Wed, 05 Mar 2025
 17:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-2-pbonzini@redhat.com>
In-Reply-To: <20250218165757.554178-2-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 11:13:02 +1000
X-Gm-Features: AQ5f1Jr0ZqIWqovlkzmM8h1huF4WwZW3_vzE4Sz6RvP2Exc3H_w_s1_XdeFHkyw
Message-ID: <CAKmqyKPxdUjq1m6C8mZT5Ats3eh01-BMVPAJAdMrOc8foT5mNQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] hw/riscv: acpi: only create RHCT MMU entry for
 supported types
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

On Wed, Feb 19, 2025 at 2:58=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Do not create the RHCT MMU type entry for RV32 CPUs, since it
> only has definitions for SV39/SV48/SV57.  Likewise, check that

I don't have access to the spec, so I'm going to take your word on this

> satp_mode_max_from_map() will actually return a valid value, skipping
> the MMU type entry if all MMU types were disabled on the command line.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 1ad68005085..2b374ebacbf 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -262,6 +262,7 @@ static void build_rhct(GArray *table_data,
>      RISCVCPU *cpu =3D &s->soc[0].harts[0];
>      uint32_t mmu_offset =3D 0;
>      uint8_t satp_mode_max;
> +    bool rv32 =3D riscv_cpu_is_32bit(cpu);
>      g_autofree char *isa =3D NULL;
>
>      AcpiTable table =3D { .sig =3D "RHCT", .rev =3D 1, .oem_id =3D s->oe=
m_id,
> @@ -281,7 +282,8 @@ static void build_rhct(GArray *table_data,
>          num_rhct_nodes++;
>      }
>
> -    if (cpu->cfg.satp_mode.supported !=3D 0) {
> +    if (!rv32 && cpu->cfg.satp_mode.supported !=3D 0 &&
> +        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
>          num_rhct_nodes++;
>      }
>
> @@ -341,7 +343,8 @@ static void build_rhct(GArray *table_data,
>      }
>
>      /* MMU node structure */
> -    if (cpu->cfg.satp_mode.supported !=3D 0) {
> +    if (!rv32 && cpu->cfg.satp_mode.supported !=3D 0 &&
> +        (cpu->cfg.satp_mode.map & ~(1 << VM_1_10_MBARE))) {
>          satp_mode_max =3D satp_mode_max_from_map(cpu->cfg.satp_mode.map)=
;
>          mmu_offset =3D table_data->len - table.table_offset;
>          build_append_int_noprefix(table_data, 2, 2);    /* Type */
> @@ -356,7 +359,7 @@ static void build_rhct(GArray *table_data,
>          } else if (satp_mode_max =3D=3D VM_1_10_SV39) {
>              build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
>          } else {
> -            assert(1);
> +            g_assert_not_reached();
>          }
>      }
>
> --
> 2.48.1
>
>

