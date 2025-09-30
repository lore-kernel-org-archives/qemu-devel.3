Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D1CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Olc-0001QX-3Y; Mon, 29 Sep 2025 21:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3OlY-0001PM-Pl
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:02:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v3OlT-0002F1-3Q
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 21:02:51 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b3f5e0e2bf7so268444266b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759194161; x=1759798961; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhvAyZQ5ERnD8oAE8ihzrG/np29LdGY1xxujKzDU4Z8=;
 b=KN+T5hlTy3tCBLmiJ5zd84IQXrYjRagB08giVLuIzZ0CQi7i9cTyCWG2+UAsOJbYVs
 BYnOvkfmfcVTyAnRcMCb5F8LEXlyAW8BUZBcIf0SijpLIpS+QkjyKfQDoU+C+u2Asskc
 DFqNX7MeqMWNyAK82855OekMZLQjpzWH3jqdJT9r5UdD2LfS4V8IO3qi4LjpnhpZ+f0G
 1LWcg8EP42OsYCsKI3fn80w448M6nJ6HAjb8mLXyJ31RgZHwdhsny0OKPei0Sh2GYPxg
 8A/j5+BI+S5Cxr80liTJviSqJi0fYiNfRtyNgUjxPMRFLo+5LqnFIBzwKhTUrQnBZVGN
 9OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759194161; x=1759798961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhvAyZQ5ERnD8oAE8ihzrG/np29LdGY1xxujKzDU4Z8=;
 b=QcM5YXAlq1dmq3pFodSpSKudWpOfUCz4b2OXRhQODCFzzYVBrH93Tl6PbyBuihbPXm
 RkLhcDuH2xjfGKEoOlpLMMtSXue/uS6i1QKEmd4UQpT//DdN9fTPn95ZQRmju+hT6LS6
 u8HIUoMtP4KXHqcbJI+2MzYmYMv7Tcf695gvAFBXdWZVL6uMky+eE8C64PnvWzWBvz59
 7KCCkz2qjjpHZyDcWyG+0XJsAN6MI4YeCb2gYDkmbnffQdnKfeASgWGwGhWL7Us5oZ67
 kbRqdYBLwzHVgMO6yne2IkLZ3WV7cBMclTZhAY2Us+GcuysCR0/CJFHNOM72f7N8RZU8
 x9qw==
X-Gm-Message-State: AOJu0Yzuc7r0+4RR3G0nUsxjQsXE/Q399ulcFlg+pSQt+wPTHu19t5LH
 jBNOF1pfndb4cdFEi5+3kaUMmz9zxXq/MHb8lMYjQM0E32S4bcCL9Yesst9dTeMUx8/zi5WekXY
 VvfDAh3aTBWc1AnrlIGTUVe/LWbb98Gs=
X-Gm-Gg: ASbGncuTDAzcsfjlX4BwRRbJFmMfrVGkDxF75n8NDh0MAWSvJrTzU5iNpGwubblELSy
 OSGuPwevELHRojRVJyCaYM4HZahxlVGhAlGYoIS3tOPde06Aql/x7ZKD91TdSBM1H4LOoeuv69G
 PzGfmW73Zlyp71f2jQsqdWL2jpSsIsAvlXZihEFTPbXGcZzbWtalcXj2e/8Pwym6mDh8hEcOqdC
 0su40cnXVhS7qvncexG8bio301M7SHksSwhUL93A4qnNZFO
X-Google-Smtp-Source: AGHT+IE7xJEk6h5qpBcAa90MPC1Lo4UaKO3hTwXrP8Omb0C0J/z9Ths3oa9wCR0JtYLZvE+wLuOk7eDlMhFlxtaZSiY=
X-Received: by 2002:a17:907:3d93:b0:b3f:d9e9:baab with SMTP id
 a640c23a62f3a-b3fd9e9cc5dmr535007666b.27.1759194161041; Mon, 29 Sep 2025
 18:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
 <20250924091746.1882125-2-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-2-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Sep 2025 11:02:14 +1000
X-Gm-Features: AS18NWCR6IwXZ-P_1TZtmlnTHNM_c5IAqUYOKcmbEFQeqZ7Q1CZCmzev3eYTpww
Message-ID: <CAKmqyKPZFWWKPvvGVMN6_A3pt-3wYWBDZiPyj-5T7JtxDB=U6Q@mail.gmail.com>
Subject: Re: [PATCH v8 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Wed, Sep 24, 2025 at 7:19=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> This is needed for riscv based CPUs by MIPS since those may have
> sparse hart-ID layouts. ACLINT and APLIC still assume a dense
> range, and if a hart is missing, this causes NULL derefs.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
>  hw/intc/riscv_aplic.c  | 13 ++++++++++---
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index 4623cfa029..e3e019e605 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState =
*dev, Error **errp)
>      s->timecmp =3D g_new0(uint64_t, s->num_harts);
>      /* Claim timer interrupt bits */
>      for (i =3D 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
> +        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
> +        if (cpu_by_hartid =3D=3D NULL) {
> +            /* Valid for sparse hart layouts - skip this hart ID */
> +            continue;
> +        }
> +        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
>          if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
>              error_report("MTIP already claimed");
>              exit(1);
> @@ -486,7 +491,12 @@ static void riscv_aclint_swi_realize(DeviceState *de=
v, Error **errp)
>
>      /* Claim software interrupt bits */
>      for (i =3D 0; i < swi->num_harts; i++) {
> -        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
> +        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i)=
;
> +        if (cpu_by_hartid =3D=3D NULL) {
> +            /* Valid for sparse hart layouts - skip this hart ID */
> +            continue;
> +        }
> +        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
>          /* We don't claim mip.SSIP because it is writable by software */
>          if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < =
0) {
>              error_report("MSIP already claimed");
> @@ -550,6 +560,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, ui=
nt32_t hartid_base,
>
>      for (i =3D 0; i < num_harts; i++) {
>          CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
> +        if (cpu =3D=3D NULL) {
> +            /* Valid for sparse hart layouts - skip this hart ID */
> +            continue;
> +        }
>          RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
>
>          qdev_connect_gpio_out(dev, i,
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index a1d9fa5085..77cec8ece9 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -903,9 +903,12 @@ static void riscv_aplic_realize(DeviceState *dev, Er=
ror **errp)
>          if (!aplic->msimode) {
>              /* Claim the CPU interrupt to be triggered by this APLIC */
>              for (i =3D 0; i < aplic->num_harts; i++) {
> -                RISCVCPU *cpu;
> -
> -                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i)=
);
> +                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i=
);
> +                if (temp =3D=3D NULL) {
> +                    /* Valid for sparse hart layouts - skip this hart ID=
 */
> +                    continue;
> +                }
> +                RISCVCPU *cpu =3D RISCV_CPU(temp);
>                  if (riscv_cpu_claim_interrupts(cpu,
>                      (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
>                      error_report("%s already claimed",
> @@ -1088,6 +1091,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwadd=
r size,
>          if (!msimode) {
>              for (i =3D 0; i < num_harts; i++) {
>                  CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
> +                if (cpu =3D=3D NULL) {
> +                    /* Valid for sparse hart layouts - skip this hart ID=
 */
> +                    continue;
> +                }
>
>                  qdev_connect_gpio_out_named(dev, NULL, i,
>                                              qdev_get_gpio_in(DEVICE(cpu)=
,
> --
> 2.34.1
>

