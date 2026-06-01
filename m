Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF03CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 03:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTtnR-0007jh-PQ; Sun, 31 May 2026 23:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtnO-0007jE-D1
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:58:34 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtnM-0003Nk-F4
 for qemu-devel@nongnu.org; Sun, 31 May 2026 23:58:34 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68d232e119dso1627215a12.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 20:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780286310; cv=none;
 d=google.com; s=arc-20240605;
 b=SpINd4ChSy0hK/kWkZC7S2kfor89xAz58Zp1oaS+IRBL4RNi2m89AgQ/SBU8o8gDTM
 GP10tlG5RnNxim/O6TRkn3cb098JodPG1KpC9rb9f9d+h8aZ1qQMtCYtSwcboQ7p1KlP
 tSHnAMKX4qsXv87pM5fid4LZSS31fhgGPqmKIZ4lZ4UTB9mDAFbe7IA8ki9ULXDH5RKf
 e2FpGdjHmD0+C/8GKtBd/tDFwTIDXaGng5tIgzY7bnCGqLPjdYXAcZVYYy7cDTSxHRQZ
 BLIvqag6Vx1v328roRJtdaYTA12NWY4rQT3Xd0qlaRGdTX5d3/2PRn/Zj6rffxCByRyG
 zWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ql13wLhgmQQN7U1Q54tIvYXPKzQ0CPyTwIdqz9KD18Y=;
 fh=oXbwLIQ6D7eZBIAfdMwTNx3JbGXBw4Kr6QcethzQnTk=;
 b=K/8Xbp5sjsNsartkQAk7JC5Fg3kVAmllffocABQ8uxGz25Dn6J4+IFxxjr8/acfl5O
 O8DxpkE8tUAiGL/4/TzZDlh76U8xn/pyL4FriwExBoRXpCMEe547B8jNNvPReEdWJl9F
 LZJ3/YUoCH7T+sK14pwkEHQ19NhVAsY10C0dSYoYZWTgmb6eUiFBl9Od16TUQPh1Bo2/
 0Ti/4kbx1IJ8q5y2ZVS2x86WZz2+w5MQZP9O+sJt9HIZXSPBuAO1+h9kXHwHoRaKQYU6
 qas1GVC68e629DDxJ6ZvOBD2glZrv1XnJJajE7w4jll5zk12e+DCTUQRSpDA7rPQfAI5
 qJIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780286310; x=1780891110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ql13wLhgmQQN7U1Q54tIvYXPKzQ0CPyTwIdqz9KD18Y=;
 b=hDHBHbExBL0M93mluziVepG8UYB/nonuhqmrYTuEhCjDJEXbbbs5uGy5ug3mI+gu5J
 KCBtqA884g2aDmPPOChRSXZY2Upvd/GxOddzfXhguD3jQBENQmbsOqQAIIlNa/38X6eh
 UyQAT0N4wKCTODXLb4NSzYVj+BrCE08et7UY7XuI9f4aK/bowWXLJ1JRC5Xxn9c5Kf7P
 ak16N3xmMnkk5ckOz+nCVXZo5X9vy/tvXYXyPVUewN5VoP/eOT1Q7Uy6oAju7MTO7K3e
 Lse6dY9ioAL2uMmAdt4E18PFKryJJqJNN77cvMURqhiXiXGA+eCD129CIMMOGQv1oFy0
 tZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780286310; x=1780891110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ql13wLhgmQQN7U1Q54tIvYXPKzQ0CPyTwIdqz9KD18Y=;
 b=XMkcn5iAwMxN7MNXPMam3kdx6VY+rLPDbbeeQvVC4EtNbn5yWCfR4y3ck+bOLyQH2h
 Wzji0rNrBIzQrwj3+4lbx1AcmddYuXRGz0K22HxRPQZ/e6ETThFCApfIkmPdTnFlyG+C
 fguYFKCyg1nS9YHEa+nElH7PagwwqBMGOzP+gg1dFarTKFLNBgLRaSq0sLu35suuOKtS
 +VKx56Bq6Hmz1GzuF1+2NuOh/2ZrvzXJC3Jq9GywWTFodFI4ze7+peQB5StmamL6fQn0
 ZtUhnU9fGuEK9GSjX3ICIY6bTX8+15419d7d9tPtx2EVqNbBYSqoXZkcTAa0vacACkn4
 +aKA==
X-Gm-Message-State: AOJu0YyJQvF/i8EoaHrhjqiOnlb+JT8eH8IrCYsBYS0yS26A7rLRhLGK
 kPY5uynA84T6mVLi42Wu6Nzm8+vN3VqiggybTznU/6vMXsO4Zoofbmre6UT0LJNqVrYMxmd/UZt
 7NpGjsq5NQ0JRtiI6eaAsVlwBgG/luD8=
X-Gm-Gg: Acq92OHKLgR0b1/GCWPf1QgVZAkkfH+N/RNvnl0Pbzag4kJ/1sWpWQGOTj7FTZUrcL0
 cbGffFcr5+33TCoOxfuUcboVd1Sp9JVk/YrVILcv0bM3Wd2NHlM3eBu1KK5AnJTEjxcWnyV3YPA
 cpUn+l6fkMlPXm90dvxRyoUNgy78TD6Oqses97K6HkbkrK+nkTjpnr5ltgpIFEwZp7sykbNr6HC
 kJm8MTZr0kNQLrR9D9VMu/K1qBggzwM+/aPnEX4+pZ0xPDtENpxzaKKaSstYXKtiRnh7WyFIKNx
 v0w1Mxfr7MJFYmnxmgGjfaa4vZ1HmiiP4/FHvdD3jAfRTbrf
X-Received: by 2002:a17:907:d13:b0:bd9:a95f:961e with SMTP id
 a640c23a62f3a-beab0dd95c4mr544154966b.3.1780286310328; Sun, 31 May 2026
 20:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-8-philmd@linaro.org>
In-Reply-To: <20260527201348.29511-8-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:58:03 +1000
X-Gm-Features: AVHnY4I6mnhqEpR75R_MMXrvfyvKrTiHeZOGuDve-31ME87jUQEVDIMwtjVy49g
Message-ID: <CAKmqyKMgSJuj7z0hVhQcssqNjTHHRHuReEHp_NU8caAq8_5nNg@mail.gmail.com>
Subject: Re: [PATCH v11 07/12] hw/riscv/boot: Rewrite setup_rom_reset_vec()
 using load/store API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Thu, May 28, 2026 at 6:16=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> In order to make the following commits easier to review, do
> not pre-initialize the reset_vec[] array, fill each word one
> by one. Set the start and FDT load addresses using the load/
> store APIs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c | 53 ++++++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index ae2f86c7ceb..c6ab1cc8cfb 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -18,6 +18,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>  #include "qemu/datadir.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
> @@ -444,6 +445,9 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
ne,
>                             &address_space_memory);
>  }
>
> +#define CODE_WORDS 6
> +#define DATA_WORDS 4
> +
>  void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayStat=
e *harts,
>                                 hwaddr start_addr,
>                                 hwaddr rom_base, hwaddr rom_size,
> @@ -451,43 +455,34 @@ void riscv_setup_rom_reset_vec(MachineState *machin=
e, RISCVHartArrayState *harts
>                                 uint64_t fdt_load_addr)
>  {
>      int i;
> -    uint32_t start_addr_hi32 =3D 0x00000000;
> -    uint32_t fdt_load_addr_hi32 =3D 0x00000000;
> +    const bool rv32 =3D riscv_is_32bit(harts);
> +    uint32_t reset_vec[CODE_WORDS + DATA_WORDS];
>
> -    if (!riscv_is_32bit(harts)) {
> -        start_addr_hi32 =3D start_addr >> 32;
> -        fdt_load_addr_hi32 =3D fdt_load_addr >> 32;
> -    }
> -    /* reset vector */
> -    uint32_t reset_vec[10] =3D {
> -        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn)=
 */
> -        0x02828613,                  /*     addi   a2, t0, %pcrel_lo(1b)=
 */
> -        0xf1402573,                  /*     csrr   a0, mhartid  */
> -        0,
> -        0,
> -        0x00028067,                  /*     jr     t0 */
> -        start_addr,                  /* start: .dword */
> -        start_addr_hi32,
> -        fdt_load_addr,               /* fdt_laddr: .dword */
> -        fdt_load_addr_hi32,
> -                                     /* fw_dyn: */
> -    };
> -    if (riscv_is_32bit(harts)) {
> -        reset_vec[3] =3D 0x0202a583;   /*     lw     a1, 32(t0) */
> -        reset_vec[4] =3D 0x0182a283;   /*     lw     t0, 24(t0) */
> +    /* .text */
> +    reset_vec[0] =3D 0x00000297;                  /* 1:  auipc  t0, %pcr=
el_hi(fw_dyn) */
> +    reset_vec[1] =3D 0x02828613;                  /*     addi   a2, t0, =
%pcrel_lo(1b) */
> +    if (harts->harts[0].cfg.ext_zicsr) {
> +        reset_vec[2] =3D 0xf1402573;              /*     csrr   a0, mhar=
tid  */
>      } else {
> -        reset_vec[3] =3D 0x0202b583;   /*     ld     a1, 32(t0) */
> -        reset_vec[4] =3D 0x0182b283;   /*     ld     t0, 24(t0) */
> -    }
> -
> -    if (!harts->harts[0].cfg.ext_zicsr) {
>          /*
>           * The Zicsr extension has been disabled, so let's ensure we don=
't
>           * run the CSR instruction. Let's fill the address with a non
>           * compressed nop.
>           */
> -        reset_vec[2] =3D 0x00000013;   /*     addi   x0, x0, 0 */
> +        reset_vec[2] =3D 0x00000013;              /*     addi   x0, x0, =
0 */
>      }
> +    if (rv32) {
> +        reset_vec[3] =3D 0x0202a583;              /*     lw     a1, 32(t=
0) */
> +        reset_vec[4] =3D 0x0182a283;              /*     lw     t0, 24(t=
0) */
> +    } else {
> +        reset_vec[3] =3D 0x0202b583;              /*     ld     a1, 32(t=
0) */
> +        reset_vec[4] =3D 0x0182b283;              /*     ld     t0, 24(t=
0) */
> +    }
> +    reset_vec[5] =3D 0x00028067;                  /*     jr     t0 */
> +
> +    /* .data */
> +    stq_p(&reset_vec[6], start_addr);           /* start:       .dword *=
/
> +    stq_p(&reset_vec[8], fdt_load_addr);        /* fdt_laddr:   .dword *=
/
>
>      /* copy in the reset vector in little_endian byte order */
>      for (i =3D 0; i < ARRAY_SIZE(reset_vec); i++) {
> --
> 2.53.0
>
>

