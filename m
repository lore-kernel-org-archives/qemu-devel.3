Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D436CE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX877-0007FT-Sc; Sun, 12 Jan 2025 19:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX874-0007FA-DM; Sun, 12 Jan 2025 19:15:28 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX86z-0004D7-7L; Sun, 12 Jan 2025 19:15:26 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-518a861612eso2378677e0c.1; 
 Sun, 12 Jan 2025 16:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736727320; x=1737332120; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMCe+GpChOBzayGVH8WNUzIOPMixrKF5IIptUHvZZ0s=;
 b=K1F8OfXasHc4hM7+OUaHFGFxT6V5yqFKom2/TtmzOIF+zU8lZ1YHQ9v+tXIawCaRug
 z22Z4NnmL8011WCuso/B1inJ53h0+1f2ZrSptrY+eaWF5TyPm21Fh2eaJAiLV9uGymvt
 hsXtOvzLk3hgt5HpGlg7tU8cv41eUWg4nEmTJMcOf3yQ26Po5FWPvtemxBAK1MjoWhS2
 5iAcVcIi758dlU8L4E37NYSHYVM2HKwdOnFV/W9u6/6PSo24ZBDoUowgejnpiXMI0JkS
 V9kRveDj3XFXgo6IBum02YMsu/9hiTRLAiOkwvImkw+C+HiUjhdEJ3rdLZaGOYWXy5Pu
 VbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736727320; x=1737332120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMCe+GpChOBzayGVH8WNUzIOPMixrKF5IIptUHvZZ0s=;
 b=USW/rGBFU5C6qxvL5e+OsYWWnsSiu20MogJil9C/CYsZev0SiYIcH5XjDk0fNld0Y6
 E+dD6/G/5FngDvWTAuIVelfxUCjldFPIDf1prEmK6GgensN9cs3wwKqr5kMhcu2Vq014
 ojidjaFt3jIW97DuMx7tkVKGXuhoLgWjzqsWYu2hMRSunllJAO4sd6sh+OQZ6E+MMlga
 W02ZLs7bS3EOT7L5zt/Vc5IMYMn3zL6EMR8XAJ0yFL4ho019l1b5KW/Rp+UtWiPT9bXj
 88O5r/cyvQPouKy1imsJLUqfVzTIgcaGnhBCRd24opPWTGR7V4aUI06vM4PXnmLfFie9
 4WhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB37DSArK2ABYwPO96pZetDsg1fYc9Cehh4hu+kyelvRNc5/m8y8vQg5rJTRKFwvKmutp0rDVNz1UO@nongnu.org
X-Gm-Message-State: AOJu0Yxgx+ICx0Vt9NAnoIAfLrkLw+DPsSSPneCeG/p4Trnv3Fif0Xmh
 xHOCAICPMU37fH6cNHtNAzI2k9WvThntGwAprnck3Y+MGM1agA8x+2X6h8oYBJDjc0+sbJ5F24N
 CkUg5KSO04TUukq/Rp1/PEllgQTY=
X-Gm-Gg: ASbGncswMLipkG97rTtKb9quBnesJibsvYpELPhbVsAbJd80hqMHE+KeB3nqGDjquCz
 gu7OMJ8BktdCxcoxY1qki5EZfckKcNgjt2eD/r5ZDbeOfDxecbq/uXQkXglGuYSxzPtM=
X-Google-Smtp-Source: AGHT+IGI0AWetrCs60PKl75gn999JHVeCSfiQbhD3m/qngFxta1ku32Ehd50rBBNvwbIw8d+iXreE4fS3GYpyGFGM2I=
X-Received: by 2002:ac5:c20d:0:b0:515:20e6:7861 with SMTP id
 71dfb90a1353d-51c7c73f836mr10796963e0c.2.1736727319719; Sun, 12 Jan 2025
 16:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20250112231344.34632-1-philmd@linaro.org>
 <20250112231344.34632-3-philmd@linaro.org>
In-Reply-To: <20250112231344.34632-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 10:14:53 +1000
X-Gm-Features: AbW1kvaM2IOLaxTdT9FoUtATzcjN9ar0mQp9AIdezEldanr2wUxjaLGGe9ZWnzA
Message-ID: <CAKmqyKP=JyG56yxDVwAfJKuNWdEj2Se4ZmWTmvXnSTcaqBFzEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/virt: Remove unnecessary use of &first_cpu
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Mon, Jan 13, 2025 at 9:14=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> virt_machine_init() creates the HARTs vCPUs, then later
> virt_machine_done() calls create_fdt_sockets(), so the
> latter has access to the first vCPU via:
>
>   RISCVVirtState {
>     RISCVHartArrayState {
>       RISCVCPU *harts;
>       ...
>
>     } soc[VIRT_SOCKETS_MAX];
>     ...
>
>   } s;
>
> Directly use that instead of the &first_cpu global.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 9e8876be29b..241389d72f8 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -750,7 +750,7 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>      qemu_fdt_add_subnode(ms->fdt, "/cpus");
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
>                            kvm_enabled() ?
> -                          kvm_riscv_get_timebase_frequency(RISCV_CPU(fir=
st_cpu)) :
> +                          kvm_riscv_get_timebase_frequency(&s->soc->hart=
s[0]) :
>                            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> --
> 2.47.1
>
>

