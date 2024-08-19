Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868D8C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 01:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfr4E-0006Yn-23; Sun, 18 Aug 2024 21:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfr4D-0006XW-13; Sun, 18 Aug 2024 21:20:17 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sfr47-0004vI-0f; Sun, 18 Aug 2024 21:20:16 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-842eee4ad03so984376241.0; 
 Sun, 18 Aug 2024 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724030409; x=1724635209; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVHQIodYJ5rk5tET5KQz0WWR2xyxiH6rEy6/9PtCvKQ=;
 b=DjrmWgbTo/jC7wZfjC3IEsygslnrzsmnlYrS10Quutw6IcwdW5fplA0VMZM960HzJT
 x41miHyEHtQTDQHYwNPS/3fDTBGD9zonP11I8PcWxyKM2EbHJ+tain8qQrbplgN23WcV
 iWc4THRoazF/ssD/jTJIS2axiSWWXfpdIf/jluKp5fu8+nSZ4fmwTzAAnkBNVk5Uy+hI
 y529EXfbYG70a6gXF1hDFkhq1bj1zVY4nZaVzb5fQpqFdKxRajDyzQti06P09ahtxowE
 a64jx8IGskEd/GCbWHEB2LPX3Y+6DaTiF4338g4sdM1UiaTsFLUNvTnVq/hnT4CcZmdk
 NARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724030409; x=1724635209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVHQIodYJ5rk5tET5KQz0WWR2xyxiH6rEy6/9PtCvKQ=;
 b=bOyNyDKf+bfb44lGeifhMtRq7S7xkt7F3iqtzMk0QMCO4fODtFWeMNndieXjdcRcGB
 xqmPOCgszDcyA7lQe7dls1yhf9kHI8bJ/s0UjKN9HXOn6SYoUCtKpNiu0qpyJ6YJBHw0
 yZ8+Iy3A671xAYImOSl6mRjjGhwiXJNVXZjpdSP6sfZXJfZ559C821gOiGQCtM0IYJeq
 ULMib7514vbD9+DEo6RUnfXzilom2URKUsNjKsXM8+G/HKTjvgP6YPJ2xdgIeb+HXNgm
 ce3/2Gk3quKfDQ9ZBFJoYAOudkGhfqUR651/7tdHd61pxgCS6tUBH2k1AQpmWFRXZ5KD
 VhgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHO6Chs7LID+LWQZv+kEJCSdTmSeyyVCQRp6maWPWqeWeWJsBXYo/BMKUAiuIfdPJ/nJ7ZioMstjXEOSrRizmkj+Um0Fw=
X-Gm-Message-State: AOJu0Yx+n48xwhMUjYzBovbxt/tDCTOUO2570M/GctYhYXZ9LQii27kr
 0u4anJ5dd24jnSRGu8DC1abY8VuEAeEP0ft7lKag49SaynFdtJ+0X/pxu7Fbg1LDuOPlchlCCNM
 2P9dNUqN7Y7AvKPX2qmLR2uTFFYM=
X-Google-Smtp-Source: AGHT+IGvuOjZAes7HE4pee0GISs+116fbgMDiWRinj2f+sKw1EizaJnH4uYZcx17OfF4i8v2DfEX2z1iNaF6/ezKc3M=
X-Received: by 2002:a05:6102:e0c:b0:493:b06d:eea2 with SMTP id
 ada2fe7eead31-497799dc5cbmr5342950137.31.1724030409188; Sun, 18 Aug 2024
 18:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-5-ajones@ventanamicro.com>
In-Reply-To: <20240816160743.220374-5-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 11:19:43 +1000
Message-ID: <CAKmqyKNp8UG20-KJou64EqGg56Ta7y78EMMHyS97=E0Z0kJ_-Q@mail.gmail.com>
Subject: Re: [PATCH for-9.1 1/2] Revert "hw/riscv/virt.c: imsics DT: add
 '#msi-cells'"
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, Aug 17, 2024 at 2:08=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> This reverts commit f42cdf2ea5b3a1dc369792d7acbf9cd3e5c90815.
>
> Linux does not properly handle '#msi-cells=3D<0>' when searching for
> MSI controllers for PCI devices which results in the devices being
> unable to use MSIs. A patch for Linux has been sent[1] but until it,
> or something like it, is merged and in distro kernels we should stop
> adding the property. It's harmless to stop adding it since the
> absence of the property and a value of zero for the property mean
> the same thing according to the DT binding definition.
>
> Link: https://lore.kernel.org/all/20240816124957.130017-2-ajones@ventanam=
icro.com/ # 1
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/virt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 9981e0f6c9b9..cef41c150aaf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -552,7 +552,6 @@ static void create_fdt_one_imsic(RISCVVirtState *s, h=
waddr base_addr,
>                            FDT_IMSIC_INT_CELLS);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, =
0);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> -    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
>                       imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
> --
> 2.45.2
>
>

