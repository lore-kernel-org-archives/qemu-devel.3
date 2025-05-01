Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA9BC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHOZ-00031Q-9l; Wed, 30 Apr 2025 20:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHOX-000318-0n; Wed, 30 Apr 2025 20:03:17 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHOV-0001Sk-Eu; Wed, 30 Apr 2025 20:03:16 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-86d5e3ddb66so119419241.2; 
 Wed, 30 Apr 2025 17:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746057794; x=1746662594; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeDZ4zgx4i9xT9aNQjYrcxnuUXD42UeRaZx8Ytraw94=;
 b=Tx5AauFoyCIeV1L3Ui1o3XxTfafpCMvq2FxBtPlelL4PTDw1ZpSaURtXtwPMB/yYL5
 09m4DN697hpEZYTa93m5N1w86yEElH8D4zWFDdZz7gVTPFq2pN2NC6nZeuozyieuCFkB
 2C0/yP9ZDSkj0wDevQrc0sVY5Y2zoQvn5QDfpt4mkuQszFIEJqCdSVhcnA3yOEJLkJE4
 haDli6/6rjxWJO2rjzVBN/O5A+GtVBDYhfBv3llx8lyU3It8hf9JR0TaqfWqFEBvmWXJ
 bDwrw/LonByEdQw3jjZTouYFlW+RVi8WUXrJZ6WJkVRpQIk8rvtXnaT1v0UtvZSQz4VZ
 Deeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746057794; x=1746662594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeDZ4zgx4i9xT9aNQjYrcxnuUXD42UeRaZx8Ytraw94=;
 b=hKl7IwlRAV6G9mPRc7EYQGXRwCeNZjY8n01gN1MEk6zhJpjjcwt3EABh/1r9IdSERA
 H/3vpEYWBP6iJRiwmunZZIDoYaXt/BV2Xik77uFz7MLIqv5ygduq8o0B7e3EawhTaKDY
 ozByyrTSz1w9Zo5AllNPZgZUgUdBoqmponU9UOVhw+iSdzn3oVx3GBGOJQH3DWq2Ccix
 WP4rEx8D59l6hPxValpTQGU8fFfK6lZQGHLkx9YGwx72PYtfIQRYio/7zqQZ3lSS3+ds
 MMF9HrsBVLOMdPdg6A39PKk3ybLyadTthYxRbxTTlWhyIwVfHArJyRKQpskPoxWfKlJJ
 mWjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQRa+KnVTXMvOxZSTZk4gYl+SmOaxG7EEZ2BianTfzj6uIh/8e3EAvCjPrzD+fevZkf4lYt/Mdg92@nongnu.org
X-Gm-Message-State: AOJu0YwVsanhbCDFIFNSSqDAqFDCh6s8XfwBgkwx9IfPjakISYqgbRAp
 9rxIN4Pv3yS0e/2L+K/P3TP0ykS7vIVNsqvlAGSkPU704fX+WevyUXEpXMYYsLZp+Q5ZumPCoLJ
 0S7fAN8GHg7C4M0olvWBU/jfBBoo=
X-Gm-Gg: ASbGnctsNC5xLbBBctqEwzXjn2AgSizcCaUIaEcgMpR4M4bsppND2cxtPz00CLPj4MO
 40GLxMMt1x2jPJimIH/ePHSPg6cIvO1PiiDmOcjE0NOiqa/SYC+G78lcpqt6/3imBkfxhSsDHSC
 woj5tQVViOPoG00Roc8lrxou/ZR7m//lEpgMkkH9dPhFkbKvE0zsbW
X-Google-Smtp-Source: AGHT+IGxX5GdnED2DKgi5P8QZCYsPFlbKAHJB0gs8odTolq6Qbmd+wGzNAqy/sItjluYyKpHyyImf/gWKtpfvumpSVQ=
X-Received: by 2002:a05:6122:181b:b0:52a:93fc:e93d with SMTP id
 71dfb90a1353d-52ade328a53mr451491e0c.5.1746057793622; Wed, 30 Apr 2025
 17:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:02:47 +1000
X-Gm-Features: ATxdqUHyprxU8-LgbbFXtoVXtPHKW29AoYbB-0HoUrYKnVbI1jG8cZqDxDcNOB8
Message-ID: <CAKmqyKM23KrhqkEPjMvF_fLAmLQ1b0fqXBcVPfrTXuVeda9=zg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] hw/riscv/virt.c: use s->memmap in
 virt_machine_done()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Tue, Apr 29, 2025 at 10:59=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index b4a6916abb..f324777161 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1429,9 +1429,8 @@ static void virt_machine_done(Notifier *notifier, v=
oid *data)
>  {
>      RISCVVirtState *s =3D container_of(notifier, RISCVVirtState,
>                                       machine_done);
> -    const MemMapEntry *memmap =3D virt_memmap;
>      MachineState *machine =3D MACHINE(s);
> -    hwaddr start_addr =3D memmap[VIRT_DRAM].base;
> +    hwaddr start_addr =3D s->memmap[VIRT_DRAM].base;
>      target_ulong firmware_end_addr, kernel_start_addr;
>      const char *firmware_name =3D riscv_default_firmware_name(&s->soc[0]=
);
>      uint64_t fdt_load_addr;
> @@ -1475,14 +1474,14 @@ static void virt_machine_done(Notifier *notifier,=
 void *data)
>               * let's overwrite the address we jump to after reset to
>               * the base of the flash.
>               */
> -            start_addr =3D virt_memmap[VIRT_FLASH].base;
> +            start_addr =3D s->memmap[VIRT_FLASH].base;
>          } else {
>              /*
>               * Pflash was supplied but either KVM guest or bios is not n=
one.
>               * In this case, base of the flash would contain S-mode payl=
oad.
>               */
>              riscv_setup_firmware_boot(machine);
> -            kernel_entry =3D virt_memmap[VIRT_FLASH].base;
> +            kernel_entry =3D s->memmap[VIRT_FLASH].base;
>          }
>      }
>
> @@ -1496,15 +1495,15 @@ static void virt_machine_done(Notifier *notifier,=
 void *data)
>          kernel_entry =3D boot_info.image_low_addr;
>      }
>
> -    fdt_load_addr =3D riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
> -                                           memmap[VIRT_DRAM].size,
> +    fdt_load_addr =3D riscv_compute_fdt_addr(s->memmap[VIRT_DRAM].base,
> +                                           s->memmap[VIRT_DRAM].size,
>                                             machine, &boot_info);
>      riscv_load_fdt(fdt_load_addr, machine->fdt);
>
>      /* load the reset vector */
>      riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
> -                              virt_memmap[VIRT_MROM].base,
> -                              virt_memmap[VIRT_MROM].size, kernel_entry,
> +                              s->memmap[VIRT_MROM].base,
> +                              s->memmap[VIRT_MROM].size, kernel_entry,
>                                fdt_load_addr);
>
>      /*
> --
> 2.49.0
>
>

