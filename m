Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132AFC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTzf-0004K4-Cg; Thu, 15 Feb 2024 00:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTzd-0004Jp-SA; Thu, 15 Feb 2024 00:09:05 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTzc-0002hj-9F; Thu, 15 Feb 2024 00:09:05 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4c03b2ac77aso173060e0c.3; 
 Wed, 14 Feb 2024 21:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707973743; x=1708578543; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0QXOci5ojlbz67bh51lRYP/gmNXm+Dgsqdx6dXKu94=;
 b=OcaUoRL5XbYKxQqpI/BISoBuofp0XIDWg3lJUTrIO68yoyVUKGCcYbZFF1qM5D08DJ
 4RQdbrM0fCeyp9RnJZ+wS9LaM4C+L0lN53Yq4NP7rwuT3l0rxypMuV5dYk7tY/jjEWlr
 HPaWafia1CUHwPMjPzi6/jEAAJ1zYR/8mYdrNTfHjGneCpxE5hr65nBVFqIJT9bmNZfT
 yh8ZADke85PORF/PfD3W5aURkkzWjjLEU1c3f2znJnB+kt6zfXsqyNkIKaZf5GZcHXTM
 9n9aaQsuW/wWH0xLc3T5og6hvwrj/Nw5RSzeIiY/BBDv6KBgkG8vjdkvoarZd6FF6WbF
 dapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707973743; x=1708578543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0QXOci5ojlbz67bh51lRYP/gmNXm+Dgsqdx6dXKu94=;
 b=sYkeQcJP84vwGF5RO/8exW1T7Xo/az1+oJGfwFzrMrp2boxBp8jpBSE3JQBnD4gZ/y
 waeEO3B/Q/ylrgoILHHmS2ggiPQbS/LGdtz78MtLrOfJpwaFdCHpFJR2z/iYHGl52C1v
 mR9aaM1Ugu04QQ07NU08gLsufWc3D6PfmZ+buWNVm1pAmeyMHqz09wnuG6XdpLwZjyMx
 AAY8P5bYZgiUET6JubYp7PkU5BNKr0LrPbQ02IzHw2LPMO79gY0VfSG+x+4k7TGjnToP
 WxVOUiOCG9TkZAqfK8KS+BqY7zM5FQ0/JEuY2R1RGPGPgLyrao45umGJ4eaBH05l1Hza
 NliQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIAuTUu+YmgfM5RV9LrrPmrgLlgveucXZiBQEEDDMkjD9jTYxehA86bwu/rL6A2DC7FDAld5rPM1yBQn27YSZmF/dZ4OE=
X-Gm-Message-State: AOJu0Yx2xAxpiOMJ4D9k1cpYkMB6YQz4F570cdsaBeqVVaglrNReMFgf
 Pq3qCEvP2Y3WvxaD9DL6MvvcYRVruQ475v06Ah39GQTzVz3oOcyAgMoQCQiXrI0HkiVaym53RJy
 SHYbZdjSllA8fBoYr8EDgou3BqFc=
X-Google-Smtp-Source: AGHT+IEWgOWWsYIxX91hhlW07l096EM749G56N1fF/CjOfVS0qOBaPnWPIPr1tICyZzJ4tdXCAePhcDVq36q1e0kink=
X-Received: by 2002:a1f:4ac5:0:b0:4c0:37a4:dbbd with SMTP id
 x188-20020a1f4ac5000000b004c037a4dbbdmr397995vka.13.1707973742822; Wed, 14
 Feb 2024 21:09:02 -0800 (PST)
MIME-Version: 1.0
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240213191736.733334-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:08:36 +1000
Message-ID: <CAKmqyKONGMMv3sgxehteA94Lb3nHrsr1bJ5BkUrPprWC1Gdd8Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] hw/riscv/virt.c: create '/soc/pci@...' fdt node
 earlier
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, ajones@ventanamicro.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Wed, Feb 14, 2024 at 5:19=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hotplugged FDT nodes will attempt to write this node that, at this
> moment, is being created only in create_fdt_pcie() during
> finalize_fdt().
>
> Create it earlier.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fd35c74781..b540f4d3da 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -826,7 +826,6 @@ static void create_fdt_pcie(RISCVVirtState *s, const =
MemMapEntry *memmap,
>
>      name =3D g_strdup_printf("/soc/pci@%lx",
>          (long) memmap[VIRT_PCIE_ECAM].base);
> -    qemu_fdt_add_subnode(ms->fdt, name);
>      qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
>          FDT_PCI_ADDR_CELLS);
>      qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
> @@ -996,6 +995,7 @@ static void create_fdt(RISCVVirtState *s, const MemMa=
pEntry *memmap)
>  {
>      MachineState *ms =3D MACHINE(s);
>      uint8_t rng_seed[32];
> +    g_autofree char *name =3D NULL;
>
>      ms->fdt =3D create_device_tree(&s->fdt_size);
>      if (!ms->fdt) {
> @@ -1014,6 +1014,13 @@ static void create_fdt(RISCVVirtState *s, const Me=
mMapEntry *memmap)
>      qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
>
> +    /*
> +     * The "/soc/pci@..." node is needed for PCIE hotplugs
> +     * that might happen before finalize_fdt().
> +     */
> +    name =3D g_strdup_printf("/soc/pci@%lx", (long) memmap[VIRT_PCIE_ECA=
M].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +
>      qemu_fdt_add_subnode(ms->fdt, "/chosen");
>
>      /* Pass seed to RNG */
> --
> 2.43.0
>
>

