Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C94BC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raU5M-0007uq-Kw; Thu, 15 Feb 2024 00:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raU5L-0007tO-NV; Thu, 15 Feb 2024 00:14:59 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raU5G-000467-MA; Thu, 15 Feb 2024 00:14:58 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4c01076b9faso259697e0c.2; 
 Wed, 14 Feb 2024 21:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707974090; x=1708578890; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEzXba9eh/+6G7C3DGoTuuJQPe4gcjO+MLaqxB9adwY=;
 b=MYVtUUGJMKZGfdmwAR/Ac1LY/rFIU3+84dp+yBtStIXz0eR7Ms+1TzpsB1zc3PlPEF
 g5DNJlrrDOlkei54AfmTE/E3HYVxWEL0lDx+xplmX3N5Ic1GiE6Y5hxdJGHMIy5u6ohQ
 wObenq1nq8eRLc/lwLyOxDIGLYsxPjin2j10zwNFjhVRsXlzSdarX1wATBZ+aqEo9Qq4
 wgcsCnSTBY+JtuQkpZ+VYOwQJFwFLUwzdmzRE9zQsMJDFhE4G85Mkbkgs+ciMVWikbXS
 nvQiXbY5wsnhMlilr6tHt2rNPQ0FaVjaDUbIY89QOlcznPVbwdIEZ5iMglwf5ylaMejc
 D+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707974090; x=1708578890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEzXba9eh/+6G7C3DGoTuuJQPe4gcjO+MLaqxB9adwY=;
 b=aSdDrXQmaPbir1kmV3bIdLRijmTvi+veqH5AuMRRiduYhOzeme1xbNz1loRPFV+/EC
 AbOvsb5hdQoYNplBDUeLaDJjifYC2fTQALIDp8ecio72b+l/d56CQ+xY6V5kF/EY75BG
 AjeRIcSCAa1Y61gFZu65vw+ggq7zBVhKMXQR6Z5DaIFu/P80tvP5rNmwhoqNWg4CqedQ
 bFxJhUvRK0A05DCEsf54NFZ36U+aHDsku9Ea+6WMQBCKn5pWPsPc61AqYpLWsOrdA0oF
 yRIK1J7uMkgENQQ7IwIomSEK1Wo/ECXc5emXly11j1Kk+69CbCdU0usM4FsVOEIahQ8n
 XInA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGWSK9PNwcN9AOimbrub8lx5gFQa9X+4ymWS2KSO9TLTzHHMkN0g/F+Eq7+6uo0JaLhjhA1AtGWr11dxiNWZad2JqdodA=
X-Gm-Message-State: AOJu0Yzg9wa1LVewmnsUAEyGXF5MKzWRqnm7mUxBcWqnVcVtT3GEzCFk
 jBj8oZ2wrjFzYoH4AzMBTD7A0gbMN4hKqYvQIv43qpiwqMfJhOGdAKXSpipcGg/GSltnz/KkF0B
 KVmH2tM6BWWDln5ZW87f7iKAryKM=
X-Google-Smtp-Source: AGHT+IHNgoO2SdxE10+IHuc0jhckEjf8sbZV760f0pAeTO9BW1oHsqsyvLxCamz+HTCvg79RECI+GqLaNfRvCdiCuWo=
X-Received: by 2002:a1f:d685:0:b0:4c0:6406:ee62 with SMTP id
 n127-20020a1fd685000000b004c06406ee62mr479902vkg.13.1707974090365; Wed, 14
 Feb 2024 21:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-6-dbarboza@ventanamicro.com>
In-Reply-To: <20240213191736.733334-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:14:24 +1000
Message-ID: <CAKmqyKNxjSAuA1j37qd05bajVjM5ZpnoqfoouyrarFn1r8jopg@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/riscv/virt.c: make aclint compatible with 'qtest'
 accel
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, ajones@ventanamicro.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Wed, Feb 14, 2024 at 5:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The 'virt' machine makes assumptions on the Advanced Core-Local
> Interruptor, or aclint, based on 'tcg_enabled()' conditionals.  This
> will impact MSI related tests support when adding a RISC-V 'virt' libqos
> machine. The accelerator used in that case, 'qtest', isn't being
> accounted for and we'll error out if we try to enable aclint.
>
> Create a new virt_aclint_allowed() helper to gate the aclint code
> considering both TCG and 'qtest' accelerators. The error message is
> left untouched, mentioning TCG only, because we don't expect the
> regular user to be aware of 'qtest'.
>
> We want to add 'qtest' support for aclint only, leaving the TCG specific
> bits out of it. This is done by changing the current format we use
> today:
>
> if (tcg_enabled()) {
>    if (s->have_aclint) { - aclint logic - }
>    else { - non-aclint, TCG logic - }
> }
>
> into:
>
> if (virt_aclint_allowed() && s->have_aclint) {
>  - aclint logic -
> } else if (tcg_enabled()) {
>  - non-aclint, TCG logic -
> }
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 52 +++++++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 54ad809b44..a094af97c3 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -48,6 +48,7 @@
>  #include "sysemu/tcg.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tpm.h"
> +#include "sysemu/qtest.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
> @@ -61,6 +62,11 @@ static bool virt_use_kvm_aia(RISCVVirtState *s)
>      return kvm_irqchip_in_kernel() && s->aia_type =3D=3D VIRT_AIA_TYPE_A=
PLIC_IMSIC;
>  }
>
> +static bool virt_aclint_allowed(void)
> +{
> +    return tcg_enabled() || qtest_enabled();
> +}
> +
>  static const MemMapEntry virt_memmap[] =3D {
>      [VIRT_DEBUG] =3D        {        0x0,         0x100 },
>      [VIRT_MROM] =3D         {     0x1000,        0xf000 },
> @@ -725,14 +731,12 @@ static void create_fdt_sockets(RISCVVirtState *s, c=
onst MemMapEntry *memmap,
>
>          create_fdt_socket_memory(s, memmap, socket);
>
> -        if (tcg_enabled()) {
> -            if (s->have_aclint) {
> -                create_fdt_socket_aclint(s, memmap, socket,
> -                    &intc_phandles[phandle_pos]);
> -            } else {
> -                create_fdt_socket_clint(s, memmap, socket,
> -                    &intc_phandles[phandle_pos]);
> -            }
> +        if (virt_aclint_allowed() && s->have_aclint) {
> +            create_fdt_socket_aclint(s, memmap, socket,
> +                                     &intc_phandles[phandle_pos]);
> +        } else if (tcg_enabled()) {
> +            create_fdt_socket_clint(s, memmap, socket,
> +                                    &intc_phandles[phandle_pos]);
>          }
>      }
>
> @@ -1409,7 +1413,7 @@ static void virt_machine_init(MachineState *machine=
)
>          exit(1);
>      }
>
> -    if (!tcg_enabled() && s->have_aclint) {
> +    if (!virt_aclint_allowed() && s->have_aclint) {
>          error_report("'aclint' is only available with TCG acceleration")=
;
>          exit(1);
>      }
> @@ -1446,23 +1450,22 @@ static void virt_machine_init(MachineState *machi=
ne)
>                                  hart_count, &error_abort);
>          sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
>
> -        if (tcg_enabled()) {
> -            if (s->have_aclint) {
> -                if (s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
> -                    /* Per-socket ACLINT MTIMER */
> -                    riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
> +        if (virt_aclint_allowed() && s->have_aclint) {
> +            if (s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
> +                /* Per-socket ACLINT MTIMER */
> +                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
>                              i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                          RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
>                          base_hartid, hart_count,
>                          RISCV_ACLINT_DEFAULT_MTIMECMP,
>                          RISCV_ACLINT_DEFAULT_MTIME,
>                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> -                } else {
> -                    /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
> -                    riscv_aclint_swi_create(memmap[VIRT_CLINT].base +
> +            } else {
> +                /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
> +                riscv_aclint_swi_create(memmap[VIRT_CLINT].base +
>                              i * memmap[VIRT_CLINT].size,
>                          base_hartid, hart_count, false);
> -                    riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
> +                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
>                              i * memmap[VIRT_CLINT].size +
>                              RISCV_ACLINT_SWI_SIZE,
>                          RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> @@ -1470,21 +1473,20 @@ static void virt_machine_init(MachineState *machi=
ne)
>                          RISCV_ACLINT_DEFAULT_MTIMECMP,
>                          RISCV_ACLINT_DEFAULT_MTIME,
>                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> -                    riscv_aclint_swi_create(memmap[VIRT_ACLINT_SSWI].bas=
e +
> +                riscv_aclint_swi_create(memmap[VIRT_ACLINT_SSWI].base +
>                              i * memmap[VIRT_ACLINT_SSWI].size,
>                          base_hartid, hart_count, true);
> -                }
> -            } else {
> -                /* Per-socket SiFive CLINT */
> -                riscv_aclint_swi_create(
> +            }
> +        } else if (tcg_enabled()) {
> +            /* Per-socket SiFive CLINT */
> +            riscv_aclint_swi_create(
>                      memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].siz=
e,
>                      base_hartid, hart_count, false);
> -                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
> +            riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
>                          i * memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_S=
IZE,
>                      RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_=
count,
>                      RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_=
MTIME,
>                      RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
> -            }
>          }
>
>          /* Per-socket interrupt controller */
> --
> 2.43.0
>
>

