Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA98F36B8D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 23:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAyWw-0004yn-Nu; Thu, 09 Apr 2026 19:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAyWt-0004yL-2B
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 19:11:19 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAyWl-00062z-6h
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 19:11:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so194270766b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 16:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775776268; cv=none;
 d=google.com; s=arc-20240605;
 b=af0bXdrFHc+o1sh8sL8iZKuOl4JsRbzHbXnBnlkTbhTlVS8JUuubVliyFbk/spe5tE
 kOhadgfY3Y6JCoA611uW606KxHzhbPwTy/ygaK+7gXJ4RzX3a6nCxCu/OdrOl+0bjS/7
 LMjQX4JAHmJ6Br+tV71dpJymxjKlgPEYg1JXHEiRwPGjjAmS7dMbZt825V8qTl6CyzKU
 WwNmBeX70SCDtPfYs/K10iJiVEfGEf6RFGuWLpcHF6TxYtZGkUMzdfCwEnECKSKhRD/O
 /Jb/f2HhQffjcvo7JUPBm4U/OuCKfdf6XBXQ3nlO0IQ4mPw2FP90JgmGOIK7683XqA6c
 X7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/KR+60lP4zq7vXYcivRUWvNT63Pne3rX1vPM0BghTmw=;
 fh=xvOUwrcwxtg+VZcGdo9zS5Ms/Ss2nmX2J2qzOxbT/C8=;
 b=jAe3Pjg3lTp8GxssO5DZRQRMOorFw6/blz2Xpi/tkIQdgqwoccdIpHt3oWHdmMIcUk
 Q/ZNKhnoUuvUjT6Y7PialpZCh2NJgJxsGQOEkUBoy2iM5+rO7gC74If97hFPJnLfsR6p
 lvCYYm6d3IC2wNhzqFUxgjtEe22uZgJN3lKTz7qJ6CdvFSQJXWcvBChe2wn3CnBvYJuH
 K5kM+lCwhYfzgIHCq9cO01867CLdsSbWwcsyBGkw54FWtUVsKuEOtDYCvH7ASzjNqQlE
 nwMc7CiyTlqP8jhImPQ+H5lF3HxthqaGdo23s8KODBUa1JHVnbXfzBR/INvgFIcHnvSP
 j3/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775776268; x=1776381068; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KR+60lP4zq7vXYcivRUWvNT63Pne3rX1vPM0BghTmw=;
 b=Tu289g1wHpKBb6ioud9lBSN3QscAeQIbvYXx6Qe1Tzsd/LHsTpLcsFDJDO/VoImLJU
 u8oINkN6JWRrbA8w4vCIyxO5eHMO5UBk+dxPIWwXjL/jE9LX30fPyFgeDNJrhAhdlNa8
 l/vlZSOLl+8kh80Cif7exJ2OPSbePgzU/Ujm4p9ol7DAIMCkgCJFXyd8C/AjvUSpuIIu
 iZQpEcj1ns+Yj0KHQe/gfYDmb9l7HTs3Z3K6Jl4ZLBJgE8BjxgS+jmWeljJSejZq0nYK
 KM46FpST7BtHfxbiDt1C8Z/92yL6CIGOzX62mMQ6uaU0kF1t42q0BZ0WOHXSKtA86N7P
 ggJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775776268; x=1776381068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/KR+60lP4zq7vXYcivRUWvNT63Pne3rX1vPM0BghTmw=;
 b=Mn/xKxgZWo3aWxkYy6VS5sOOvU01OchtzH8c5NC0Y/jgF87D4IODeLRXJhUltbz1Sa
 cBW6fSFsoe09W4dA5ooZ1o/No+vNnczqwHIbl8flonbxWk7wlxABQ8fCf48C6iPmS7Pb
 iaVjjHiJc1KezB9gSjP9rCX3K1xDUQFYhDlh2JPrgz2hgxptK/nIxaHpurbQokBnGPoK
 uHQoTlHP6jsNbBxEqyFOcEKWw6gVxt1IldLmaeC8pv5+ndSG7iRQLw8qnFBj/m8zEobV
 BPkq2HxVKEVDOXqi6/E1sUKJCAWweRYMjaGCC9hMfE59mKji0foUFvr6Cy9Svn4XhXZX
 JWvA==
X-Gm-Message-State: AOJu0Yx4QgPb86ad1t0WNQPCT3n6BSVebin+Ug9nfnOcFuQPVrNDh9Cd
 MzhrZ7ygZlFX8bX4xt4pFVOLvrova1WhTgffsC45idsqoZqG6jNCcUCSVNV1ZUlPIO3mDZ9W8RG
 xpZ6mJngg7oxRZ5ilNlq4ooiHife2ffI=
X-Gm-Gg: AeBDievyN4kCKUY/DAV6/RnCdtYTFvWr4wzIAkavCJAHa+TjrcfwqNKvdsEiZVTHUZH
 5REzNWCpLx/L0/BtV4vzMYoLGWzJbwCd7ElN4Beb3hh8zEOOm21iTMdUDHwYhEMgjmNjaRWJEi/
 AaHW4KiSoXHUwk9gpmTJi/UcmagGmmnm29vPykAoQbh5JchaTZHHeqws0GgVLXYcFKI2EKS+GLL
 1qs5oBOXW4ehoqJTyVvJVJLrR7byfTde52Y/LI+JAmDihri5rxutEpd2RHrjOIPMSlhd+5LjsSU
 rUufckra/Wb0RhsYPlc=
X-Received: by 2002:a17:907:9608:b0:b9c:b88c:6364 with SMTP id
 a640c23a62f3a-b9d7249921cmr61420666b.22.1775776267420; Thu, 09 Apr 2026
 16:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-5-946840930af2@iscas.ac.cn>
In-Reply-To: <20260409-fix-unit-address-v1-5-946840930af2@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 09:10:40 +1000
X-Gm-Features: AQROBzDXAHNGs9bJ86tYCUcUqXcY2fo0XK7RCn50bqQwvzx_rhA2w66un2AP4tE
Message-ID: <CAKmqyKPO8HjaoLdC61rTiNkawFfwb6e9YtAq0c2YBcA-fTtXjQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/riscv: Use hex unit addresses in FDT CPU nodes
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 9, 2026 at 4:42=E2=80=AFPM Vivian Wang <wangruikang@iscas.ac.cn=
> wrote:
>
> These unit addresses should have been in hex, not decimal, as per de
> facto convention [1]. Fix them.
>
> Link: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+s=
psowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/ # [1]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 9 +++++----
>  hw/riscv/spike.c    | 4 ++--
>  hw/riscv/virt.c     | 4 ++--
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 7ec67b2565..54f3bcc3b2 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -168,8 +168,9 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>
>      for (cpu =3D ms->smp.cpus - 1; cpu >=3D 0; cpu--) {
>          int cpu_phandle =3D phandle++;
> -        nodename =3D g_strdup_printf("/cpus/cpu@%d", cpu);
> -        char *intc =3D g_strdup_printf("/cpus/cpu@%d/interrupt-controlle=
r", cpu);
> +        nodename =3D g_strdup_printf("/cpus/cpu@%x", (unsigned)cpu);
> +        char *intc =3D g_strdup_printf("/cpus/cpu@%x/interrupt-controlle=
r",
> +                                     (unsigned)cpu);
>          qemu_fdt_add_subnode(fdt, nodename);
>          /* cpu 0 is the management hart that does not have mmu */
>          if (cpu !=3D 0) {
> @@ -198,7 +199,7 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>      cells =3D  g_new0(uint32_t, ms->smp.cpus * 4);
>      for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
>          nodename =3D
> -            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> +            g_strdup_printf("/cpus/cpu@%x/interrupt-controller", (unsign=
ed)cpu);
>          uint32_t intc_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
>          cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandle);
>          cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_M_SOFT);
> @@ -249,7 +250,7 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>      cells =3D  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
>      for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
>          nodename =3D
> -            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
> +            g_strdup_printf("/cpus/cpu@%x/interrupt-controller", (unsign=
ed)cpu);
>          uint32_t intc_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
>          /* cpu 0 is the management hart that does not have S-mode */
>          if (cpu =3D=3D 0) {
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 35c696f891..cac01ea1ff 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -105,8 +105,8 @@ static void create_fdt(SpikeState *s, const MemMapEnt=
ry *memmap,
>          for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--) {
>              cpu_phandle =3D phandle++;
>
> -            cpu_name =3D g_strdup_printf("/cpus/cpu@%d",
> -                s->soc[socket].hartid_base + cpu);
> +            cpu_name =3D g_strdup_printf("/cpus/cpu@%" PRIx32,
> +                s->soc[socket].hartid_base + (uint32_t)cpu);
>              qemu_fdt_add_subnode(fdt, cpu_name);
>              if (is_32_bit) {
>                  qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "risc=
v,sv32");
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a1c323e66d..42a83dd829 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -248,8 +248,8 @@ static void create_fdt_socket_cpus(RISCVVirtState *s,=
 int socket,
>
>          cpu_phandle =3D (*phandle)++;
>
> -        cpu_name =3D g_strdup_printf("/cpus/cpu@%d",
> -            s->soc[socket].hartid_base + cpu);
> +        cpu_name =3D g_strdup_printf("/cpus/cpu@%" PRIx32,
> +            s->soc[socket].hartid_base + (uint32_t)cpu);
>          qemu_fdt_add_subnode(ms->fdt, cpu_name);
>
>          if (satp_mode_max !=3D -1) {
>
> --
> 2.53.0
>
>

