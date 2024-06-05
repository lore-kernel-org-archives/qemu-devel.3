Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9D5C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEedf-00010r-PO; Tue, 04 Jun 2024 20:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEedb-0000k4-6V; Tue, 04 Jun 2024 20:36:25 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEedX-0005jb-1Z; Tue, 04 Jun 2024 20:36:21 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-48bd101a9c1so979208137.1; 
 Tue, 04 Jun 2024 17:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717547777; x=1718152577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SftFLeiz63fZGbvQLqKgkpnMe4zquwPZ4VdrT1Pu+as=;
 b=c6p0Ktq1rzFoUq0rF63RsXpUzsO8NU5jhE5qQ33VZSBFAp/cnDrSNHOGOjABc+p17t
 Dl9RpH92XMISzmbtdeGrRUAiAGzsGiYlIkR/JHAK6L4BPx+kqPwRzDK1XpiwDcCoGaFx
 B/Av+stNp0rt4lhCNyAQIhU3av1Rt7rfSbU2VdidVfA2D62YZ5ZDtQcyMeSLYe+wnXJP
 TJtzyW9Al0JdHvCMxDYGs9Wf925xoQ90ZVEVag1cxa/Rr62LBSBro4O8buZZQB//4SMv
 NKlWmjO9tdq6gZOgqvNMpjMqFW7wjkVyTZ+9hi80WG35uMvTIwy43qJxoqHKQh9XJ4Ku
 VZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717547777; x=1718152577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SftFLeiz63fZGbvQLqKgkpnMe4zquwPZ4VdrT1Pu+as=;
 b=UtRDzY1EHtc06vic79bpNAMY8egawo9NYSKZO+FbYzXb7Zcn17L8B3280rVjuUsLQm
 9dPzmw95IMjV6Yeb+ep3Qy+8wUExDNnEVzi4dAR/QdASBll9LTRZpNHgHIaTtxUNsaek
 SbGsrPLScT/eUQjOYfkXXmYQGd99fWW2EC8GBc4d6Ii6TIMEPmcfALXqOyng3AW8dFo5
 U9dG0xzoaL1Fbwx0DT19OanV24x9E1X7+iUxrYKQpgxe4SCP3CskAAhEhyICBU/DB554
 NI/CnkdxRRkQMaPAXaYyZzQpyhceha2PimP/ERkLI7jEi3IydKKpgA/qQbq3bCSAWopj
 UWzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUhG6ztb5JoMIeClhnS0lDNSwvD+kphlTb5nQcMLPix+vllEGRHUflV5wQgovXNr6fsd907doEewEZcN6z/vLwUZHTNiw=
X-Gm-Message-State: AOJu0Yyq99X3nxtj+1lbY/wHE8azDWjfafJ3s/lNwBkgJz8iyoZxgnC2
 kkw/cp9qLSfQHT5KcuvWiDtPaG1vGGtk9GYb6vvHLzsXi4pcRspBdnYL/4NpWdDUJjOtlc+nRuj
 PwVl7nR+h0f96c0QPbdPZn4Vsf78=
X-Google-Smtp-Source: AGHT+IHqMXzy3+N/l6iP0uAPkqTmbvvj/GWYzPqnxEVRFBWhLVVflhvek2h56la3EB0mQjWUhd/SAvvPWyZrsAldfGI=
X-Received: by 2002:a67:b109:0:b0:48b:bce7:a80 with SMTP id
 ada2fe7eead31-48c0493aea9mr1375468137.24.1717547776642; Tue, 04 Jun 2024
 17:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-8-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:35:50 +1000
Message-ID: <CAKmqyKPzTyE8Rnso7Si_6MseB11OROxZjQAAVb-vL27A1ypbGQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] hw/riscv/virt.c: imsics DT: add 'qemu,
 imsics' to 'compatible'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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
> The DT docs for riscv,imsics [1] predicts a 'qemu,imsics' enum in the
> 'compatible' property.
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
>  hw/riscv/virt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 56d7e945c6..ac70993679 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -515,6 +515,9 @@ static void create_fdt_one_imsic(RISCVVirtState *s, h=
waddr base_addr,
>      uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
>      g_autofree uint32_t *imsic_cells =3D NULL;
>      g_autofree uint32_t *imsic_regs =3D NULL;
> +    static const char * const imsic_compat[2] =3D {
> +        "qemu,imsics", "riscv,imsics"
> +    };
>
>      imsic_cells =3D g_new0(uint32_t, ms->smp.cpus * 2);
>      imsic_regs =3D g_new0(uint32_t, socket_count * 4);
> @@ -541,7 +544,10 @@ static void create_fdt_one_imsic(RISCVVirtState *s, =
hwaddr base_addr,
>      imsic_name =3D g_strdup_printf("/soc/interrupt-controller@%lx",
>                                   (unsigned long)base_addr);
>      qemu_fdt_add_subnode(ms->fdt, imsic_name);
> -    qemu_fdt_setprop_string(ms->fdt, imsic_name, "compatible", "riscv,im=
sics");
> +    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
> +                                  (char **)&imsic_compat,
> +                                  ARRAY_SIZE(imsic_compat));
> +
>      qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
>                            FDT_IMSIC_INT_CELLS);
>      qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, =
0);
> --
> 2.45.1
>
>

