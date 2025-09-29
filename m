Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1472CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3MSb-0001mi-BS; Mon, 29 Sep 2025 18:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3MSX-0001mZ-Cw
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 18:35:06 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3MST-0003Px-St
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 18:35:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-62fb48315ddso9418760a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759185297; x=1759790097; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jtr24F54A7vAg6tDCIn3Tg59LbtqoA7RE5vVwINhI7M=;
 b=Ih03sHsWKsq2JJFgjUQwY6PotahvS7EVfCiIejRFO6mJpjc258SQ0kMtVk441OmnwI
 plPVJzA24aKHg22JEdqbrehzTVXqRQU7ZAHhG2MLNNMQgZVJ1PVfZJ3rRzWlqX/A4ycY
 Blc8RN+6mzxVmTEAt2UXkNtPuCjqqbfOeg51Hgqn3ME+iVi3jZwTfNyFkpKYK1Su9boh
 kHGG18BJrrlGRk45lHlwCpf/qkAYEEE+a1eRBjGshfrqaRFV/q1mf94A5IYN45c+TO7s
 giDelCFq9Zfkde+HrUB+EuhrQJBKqZZWjVo15rkop6SVUXU5oi4P/SmKybCAHQCGJkXW
 Yj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759185297; x=1759790097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jtr24F54A7vAg6tDCIn3Tg59LbtqoA7RE5vVwINhI7M=;
 b=YuG5+qOfMs7hAlGIMsZyxf/0tNr2kPQgXFr8U+sl8tOzk0EO3ukTkIEVOj/05ND9ws
 71kh0TOETG+YcLgoE5JFGhpltB/BSxHbMZelMPDVt68C7MKD+jqRXInjaHH8Vuy0bppo
 RCD+qKWT1cv1cAS6Dghalgd5199zR5eIy4gQjeyrFOpjyhiqgQk/LxtdNHnVqt1Dlvc6
 tTwWGGVUp7tKRYLMxtaKev7hWwl6lMzbfdMCu8niLoX317IbRb1Reln9QPtkjUkFxQeR
 HUFHYKJF3TmxIxz/gN4OK6SJEdt6XCYUFcPu3tZZMGywWg0Gg4Xz4CsnOcTo28qIJQyZ
 lT8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwz3dlFa/YBit/ZGNqi5LfL5QrWmDtH3TtYhGbW0nyg8V84vr05l9drY8fECyBk74JO6YFhrrbsV6B@nongnu.org
X-Gm-Message-State: AOJu0YxNquvGUAcw5VywOrCVbF95oAh+RPzwBLUvnsZ6+nhGiionkeMo
 Fp69icuB7A8BAKbJkM2PU9lwu1IYFSquDWewjfKdw5z9HJ6Gc0vOCQzBvYGPhj0Q0a823Ky6TWx
 8yvuMMUYYOtRd8ca194FrBNScIODVvqg=
X-Gm-Gg: ASbGncuT64nvBHQsnn14n6DRwHuvE3GPs5yhmN9XNpp3d155d3Fg6SuXM6478o4vZUp
 6nNdLQ4g0L5OMW5CWFdcqw/dgtnWDXziqYSuiVn/1U5WSON+zXmE/LcGHAmLloNx6Q/dQY4e/KE
 EGKMf8LZ1pCRHQQfymNDUu+7xQRib4qwgDLVpySxxeJ31XnVfEziwhbS+ydXtaGgIQbGUAZL2OC
 UdEKFcj1xjNJDztEr/Q4scTbs6TmtV/jb/HCZWc80V7hXWM
X-Google-Smtp-Source: AGHT+IEEHNvUYHuehQKhkrw6kVKqMbGDXcfldvPoSyKSI6ViEv61yLp3J4mj+KKUDFONWU9J5R5r4JaRAgtYvJCiX7Y=
X-Received: by 2002:a17:906:f049:b0:b40:b6a9:f704 with SMTP id
 a640c23a62f3a-b40b6a9fbbfmr303363566b.7.1759185296332; Mon, 29 Sep 2025
 15:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250811034454.189208-1-z_bajeer@yeah.net>
In-Reply-To: <20250811034454.189208-1-z_bajeer@yeah.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 08:34:30 +1000
X-Gm-Features: AS18NWDaqr6FiesPZK7c1z0Bv2ZO-poCfekApkDTmh4kr4qJK32swlpZ7bzhkKM
Message-ID: <CAKmqyKN_asnf6Au8xN0XTdAgEGhUxR6Mi_CUopzDhTkeLYdO+g@mail.gmail.com>
Subject: Re: [PATCH v2] aplic: fix mask for smsiaddrcfgh
To: Yang Jialong <z_bajeer@yeah.net>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, yangjialong@rvcore.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Mon, Aug 11, 2025 at 1:59=E2=80=AFPM Yang Jialong <z_bajeer@yeah.net> wr=
ote:
>
> 4.5.4. Supervisor MSI address configuration (smsiaddrcfg and
>   smsiaddrcfgh)
> smsiaddrcfgh:
>         bits 22:20 LHXS(WARL)
>         bits 11:0  High Base PPN(WARL)
>
> Signed-off-by: Yang Jialong <z_bajeer@yeah.net>

This fails to build as there is still a APLIC_xMSICFGADDRH_VALID_MASK user

../hw/intc/riscv_aplic.c: In function =E2=80=98riscv_aplic_set_kvm_msicfgad=
dr=E2=80=99:
../hw/intc/riscv_aplic.c:191:34: error:
=E2=80=98APLIC_xMSICFGADDRH_VALID_MASK=E2=80=99 undeclared (first use in th=
is
function); did you mean =E2=80=98APLIC_MMSICFGADDRH_VALID_MASK=E2=80=99?
191 | APLIC_xMSICFGADDRH_VALID_MASK;
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| APLIC_MMSICFGADDRH_VALID_MASK
../hw/intc/riscv_aplic.c:191:34: note: each undeclared identifier is
reported only once for each function it appears in

https://gitlab.com/alistair23/qemu/-/jobs/11528885170

Alistair

> ---
>  hw/intc/riscv_aplic.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> v1 --> v2:
> - fix calculation of MSI address.
> - In Supervisor mode, lhxw/hhxs/hhxw fields are in mmsiaddrcfgh register.
> - And lhxs field is in smsiaddrcfgh.
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index a1d9fa5085..2dd54cafaa 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -96,7 +96,7 @@
>      (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
>       APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
>
> -#define APLIC_xMSICFGADDRH_VALID_MASK   \
> +#define APLIC_MMSICFGADDRH_VALID_MASK   \
>      (APLIC_xMSICFGADDRH_L | \
>       (APLIC_xMSICFGADDRH_HHXS_MASK << APLIC_xMSICFGADDRH_HHXS_SHIFT) | \
>       (APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
> @@ -104,6 +104,10 @@
>       (APLIC_xMSICFGADDRH_LHXW_MASK << APLIC_xMSICFGADDRH_LHXW_SHIFT) | \
>       APLIC_xMSICFGADDRH_BAPPN_MASK)
>
> +#define APLIC_SMSICFGADDRH_VALID_MASK   \
> +    ((APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
> +     APLIC_xMSICFGADDRH_BAPPN_MASK)
> +
>  #define APLIC_SETIP_BASE               0x1c00
>  #define APLIC_SETIPNUM                 0x1cdc
>
> @@ -409,13 +413,8 @@ static void riscv_aplic_msi_send(RISCVAPLICState *ap=
lic,
>          msicfgaddr =3D aplic->kvm_msicfgaddr;
>          msicfgaddrH =3D ((uint64_t)aplic->kvm_msicfgaddrH << 32);
>      } else {
> -        if (aplic->mmode) {
> -            msicfgaddr =3D aplic_m->mmsicfgaddr;
> -            msicfgaddrH =3D aplic_m->mmsicfgaddrH;
> -        } else {
> -            msicfgaddr =3D aplic_m->smsicfgaddr;
> -            msicfgaddrH =3D aplic_m->smsicfgaddrH;
> -        }
> +        msicfgaddr =3D aplic_m->mmsicfgaddr;
> +        msicfgaddrH =3D aplic_m->mmsicfgaddrH;
>      }
>
>      lhxs =3D (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
> @@ -427,6 +426,14 @@ static void riscv_aplic_msi_send(RISCVAPLICState *ap=
lic,
>      hhxw =3D (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
>              APLIC_xMSICFGADDRH_HHXW_MASK;
>
> +    if (!aplic->kvm_splitmode && !aplic->mmode) {
> +        msicfgaddrH =3D aplic_m->smsicfgaddrH;
> +        msicfgaddr =3D aplic_m->smsicfgaddr;
> +
> +        lhxs =3D (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
> +            APLIC_xMSICFGADDRH_LHXS_MASK;
> +    }
> +
>      group_idx =3D hart_idx >> lhxw;
>
>      addr =3D msicfgaddr;
> @@ -771,7 +778,7 @@ static void riscv_aplic_write(void *opaque, hwaddr ad=
dr, uint64_t value,
>      } else if (aplic->mmode && aplic->msimode &&
>                 (addr =3D=3D APLIC_MMSICFGADDRH)) {
>          if (!(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
> -            aplic->mmsicfgaddrH =3D value & APLIC_xMSICFGADDRH_VALID_MAS=
K;
> +            aplic->mmsicfgaddrH =3D value & APLIC_MMSICFGADDRH_VALID_MAS=
K;
>          }
>      } else if (aplic->mmode && aplic->msimode &&
>                 (addr =3D=3D APLIC_SMSICFGADDR)) {
> @@ -792,7 +799,7 @@ static void riscv_aplic_write(void *opaque, hwaddr ad=
dr, uint64_t value,
>                 (addr =3D=3D APLIC_SMSICFGADDRH)) {
>          if (aplic->num_children &&
>              !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
> -            aplic->smsicfgaddrH =3D value & APLIC_xMSICFGADDRH_VALID_MAS=
K;
> +            aplic->smsicfgaddrH =3D value & APLIC_SMSICFGADDRH_VALID_MAS=
K;
>          }
>      } else if ((APLIC_SETIP_BASE <=3D addr) &&
>              (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
> --
> 2.34.1
>
>

