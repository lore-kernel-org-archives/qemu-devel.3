Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F732C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEedy-0001OR-Pb; Tue, 04 Jun 2024 20:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEedw-0001Ju-Ua; Tue, 04 Jun 2024 20:36:44 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEedv-0005ra-27; Tue, 04 Jun 2024 20:36:44 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4eb0089b4a2so608863e0c.2; 
 Tue, 04 Jun 2024 17:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717547800; x=1718152600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EZ04c60HZkWwTOTASAKGAPRvkH82+UpvsxrCXveySg=;
 b=JDly1TYgJuSNt6C97PcQZ6VjQNWzy720YuC5uKKSsb/C0tGANTZF4CTc0ZPogFx0EW
 R1/VaLHtV9oPHfLcjMiP3WgLx+5K11cPfy6BQn11V1eJoI3CIh+STqsUcoTxp3Q4f1To
 tTkP8rTMks4Zb8g7GNQNGMLxMQnAsEM76Vno5v96j3RlYciZxpAesM34bANzR3qlVZAX
 gO8PfxmQNBofHM7jmuMZOBAfL3/mzD9wyv2MVL53lKiJ9wgWr2oCw2W11EcxHu8m3i7q
 8ZLpvGIUnAhfaYLrD1v5JsU7tuK0Gat5smQlggGRLSl/WI0qVPgKqoBEGzOW3emKX/Kn
 PgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717547800; x=1718152600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EZ04c60HZkWwTOTASAKGAPRvkH82+UpvsxrCXveySg=;
 b=Gmj+Dvo/pymTAhxBTrvfe0rYRbVftXGrJtuvTjL2HtZUbIhy7ITtx7jofc/SkddCAg
 S/EDgwds58O+vl80BevTR6vfR2v3DYTjzdOo6P+v28p5nI7hyVuUhukfbs3c/aIjrY9p
 DHKT1JQ7SmpubT8cTmrg9NWMroddHJiq6lfKBNvJeOz3qXX9yFF/zw29aL8FYHPJtQ4a
 5zakpQJsd/cBPov7jejo+803xDCrFhV0tSGmQNVvvc8gfGI+x9igEWxQPQnGJ/nNV8f9
 4cLSd86Q4PFOj01ED3rP1Wt+uwZwxGNtJpBqOgvxstPsQTCfajRya9+NB+pyzND8kvqY
 SMiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU5HgqLhCtx+FGiQUFh/bE0z6PTBYZXQeZ2gu0yVI/P/fJUw4feOHY+mypxHxnj3QuVb3VLkLwAbIie0Jn8MlXROJtbGA=
X-Gm-Message-State: AOJu0YwWza+QsSD2s3nj9ig4ExeKIA9qjwQIWP9bC8ZMsimbVVmB6DY4
 oD+ldHvLHO98T3C31dklp/Nspg45yrTPfr/h1Fo1/rqV1+QvLPEmSkrGPcHFZ40J3rgXJxUy1kR
 7lWt2lzq98xXPb4h2gXgnRmsdFfY=
X-Google-Smtp-Source: AGHT+IFWcemRNypBv57tHZtpu2+3Jx97obt7JU+ukRB1r+4YneDKhi/8OYJ4UCM3iXHQKqqnOXQhJR+pXQUaClNzacg=
X-Received: by 2002:a05:6122:1784:b0:4eb:a09:63df with SMTP id
 71dfb90a1353d-4eb3a40dcbcmr1437285e0c.7.1717547800117; Tue, 04 Jun 2024
 17:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-9-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:36:13 +1000
Message-ID: <CAKmqyKPSLt_ykvfbJdTzMQz=nFZAzmWwH6dZJp5URkAgdnS-0Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] hw/riscv/virt.c: imsics DT: add '#msi-cells'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jun 1, 2024 at 6:31=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The DT docs for riscv,imsics [1] requires a 'msi-cell' property. Add one
> and set it zero.
>
> [1] Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.y=
aml
>
> Reported-by: Conor Dooley <conor@kernel.org>
> Fixes: 28d8c281200f ("hw/riscv: virt: Add optional AIA IMSIC support to v=
irt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ac70993679..8675c3a7d1 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -552,6 +552,7 @@ static void create_fdt_one_imsic(RISCVVirtState *s, h=
waddr base_addr,
>                            FDT_IMSIC_INT_CELLS);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, =
0);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
>                       imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
> --
> 2.45.1
>
>

