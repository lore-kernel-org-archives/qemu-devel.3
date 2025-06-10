Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FC7C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxMm-0006hA-KW; Tue, 10 Jun 2025 07:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxMj-0006gV-2N; Tue, 10 Jun 2025 07:42:05 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxMc-0001LM-Mb; Tue, 10 Jun 2025 07:42:04 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-86dc3482b3dso4727201241.0; 
 Tue, 10 Jun 2025 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749555714; x=1750160514; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEdcmlrm9ckPisfc6n4cgVimYjbQhyxN90i/poVHvSU=;
 b=VUwRAsJIJHGAd3r4BvAuSZw448eUMpLnRgODEnDiDGQ9rDOEXqpfrJTxkSxXJsY7mD
 Nar/isB+zQur9wCRmyZVhtSVGZpI02BjVDD+9BGRz0zgjjmTdd8mMYnZvOfzvCOMcJMd
 JVfn7zghDp49d83J1qen4aZaNwGslUEDDshKNnu049ZpUtMAY/2Mso1v7Mdv0UbOVhXj
 B2hPALXGi/lHWpxvzkhu0MaoCJWlwIh2HU7+9KCKWEab57eWEbAsvczvW8UJ8xee+YyO
 ArTFOWn2R0z9BBbAlT25BzXhWRbIffh7HGEqI2NL4QXsepoT+J321VZZe+NaDDsjUHyH
 k+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749555714; x=1750160514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEdcmlrm9ckPisfc6n4cgVimYjbQhyxN90i/poVHvSU=;
 b=Bx/H2otj7qEZDFHARwIt3gAzZSEaIpi9oDobTjUKDjtiAXe+WiUYaFZvwUvJ1e45S5
 KBZpeFskvi/9CyQpxSAmE/TSZsQxFAFCje/8248nV3xouls6bb+gnfp8Ed7Npt+fPyyQ
 v5UoQ0SbTbQNoP8PGFb8UzXUtTXHrRBv3UxORmtdDkpAP6HqGxpAMC6XNg9HRK+GVVuH
 9VNuNIr8nXXWER35Ez9MRHV3sVCC3igyZMUHYizYm2jmFnkkG9qdmBKf653kw9wO9la4
 G0p9rrwJPT9T3oCJtXuYKvlfTPc+GKpIxS8pvfzZCwYeDDjxX7DXAVrHwaVvqwOUPn+n
 MCSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/2/V/vwRg/5lgxEC3z4lBTRTIAMzwYsxzb0kZbZx9LR4KKSJK85qZHX5VksGB1JaKR+J9oa1xVGOC@nongnu.org
X-Gm-Message-State: AOJu0Yz2FlOvcY8MzbubSWjqBCJ7zRC66Bmq47k5ha1cehspwp/dKQoz
 2cx5FywCm7jSU/yjb2ked5AUgAvByFkuT0wowtuThMRkdEw51lhQT6YZbgNuAv1NpcOZeBx4dZJ
 qcRINNiy4wfx/uZdyvhuXWqaXG2j0xZs=
X-Gm-Gg: ASbGncu3gU9LsIV8w8k+hLLO/AM8JSnUf5tGditNUlOijzOKr+0HtCTOOcRHqD+ESOw
 FPNmxpFIV0LP2nc0Y4vg17QftfN9tt9lLer3YiZtzRCkthZ1Ni6ufKgIfJ0ePwWigmxMOlsjuQC
 E9e022x5rwUfuK+AeZjvTAppIo8FZQHND5PkBl0aGS8XVE6K92BXpNL0fDH3T28Mm39XvZq5O0f
 g==
X-Google-Smtp-Source: AGHT+IGC28ABDkIdWrm9j7ECk0kHIYjSTg+NC32s3xzKNaqKbqRTc+pd3uozhnwhqQScPSUDUrBIDSMCbgltCjTwcBU=
X-Received: by 2002:a05:6102:4187:b0:4e2:a235:24d1 with SMTP id
 ada2fe7eead31-4e7a5d45d3dmr2235262137.4.1749555713749; Tue, 10 Jun 2025
 04:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-10-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-10-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 21:41:27 +1000
X-Gm-Features: AX0GCFvDOzGT92WJY1NXA6GH1dnZAV22Qw1Gi0JhJxTTCZ4lU7FJ00Kd4ihDGWw
Message-ID: <CAKmqyKOo26Ji7B8=BhJJTD9q9njyHExx3FURR2+Tug-FEoTc0w@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] hw/riscv: Add a network device e1000e to the
 boston-aia
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Mon, Jun 2, 2025 at 11:13=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add a network device e1000e to the boston-aia board model.
> There is no pch_gbe emulation, so we add e1000e in slot 0 func 1,
> instead. We need to pass func to call pci_parse_devaddr to find
> out slot and func.
>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  hw/pci/pci.c          | 15 +++++++++------
>  hw/riscv/boston-aia.c |  5 +++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index f5ab510697..23f7f02837 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -974,14 +974,15 @@ static int pci_parse_devaddr(const char *addr, int =
*domp, int *busp,
>
>      slot =3D val;
>
> -    if (funcp !=3D NULL) {
> -        if (*e !=3D '.')
> +    if (funcp !=3D NULL && *e !=3D 0) {
> +        if (*e !=3D '.') {
>              return -1;
> -
> +        }
>          p =3D e + 1;
>          val =3D strtoul(p, &e, 16);
> -        if (e =3D=3D p)
> +        if (e =3D=3D p) {
>              return -1;
> +        }
>
>          func =3D val;
>      }
> @@ -2045,13 +2046,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const =
char *model,
>      int dom, busnr, devfn;
>      PCIDevice *pci_dev;
>      unsigned slot;
> +
>      PCIBus *bus;
>
>      if (!nd) {
>          return false;
>      }
>
> -    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL=
) < 0) {
> +    unsigned func;
> +    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &fun=
c) < 0) {
>          error_report("Invalid PCI device address %s for device %s",
>                       devaddr, model);
>          exit(1);
> @@ -2062,7 +2065,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const ch=
ar *model,
>          exit(1);
>      }
>
> -    devfn =3D PCI_DEVFN(slot, 0);
> +    devfn =3D PCI_DEVFN(slot, func);

These core pci changes should be split out into their own patch and
will need a bit more justification

Alistair

>
>      bus =3D pci_find_bus_nr(rootbus, busnr);
>      if (!bus) {
> diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
> index 6ed5c636cc..34cc0abe79 100644
> --- a/hw/riscv/boston-aia.c
> +++ b/hw/riscv/boston-aia.c
> @@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
>      ide_drive_get(hd, ich9->ahci.ports);
>      ahci_ide_create_devs(&ich9->ahci, hd);
>
> +    /* Create e1000e using slot 0 func 1 */
> +    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", N=
ULL,
> +                         "00.1");
> +    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
> +
>      if (machine->firmware) {
>          fw_size =3D load_image_targphys(machine->firmware,
>                                        0x1fc00000, 4 * MiB);
> --
> 2.34.1
>

