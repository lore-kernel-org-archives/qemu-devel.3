Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7164DD10F3B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqcp-0001U2-2x; Sun, 17 Nov 2024 20:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqck-0001Ro-KW; Sun, 17 Nov 2024 20:32:19 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqci-0001K9-Ec; Sun, 17 Nov 2024 20:32:18 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-8570010ee2dso271817241.3; 
 Sun, 17 Nov 2024 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731893535; x=1732498335; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPSXNylK1QB4wWDBzuCw8f7jAxQX+mI78Uyodj41t+0=;
 b=dRwLgj4sBzskORLn3teDwCAUuEoxkK5wrDorXPxL1IjphVcV0Xx4eZd7tiQbnNrTqt
 IciYlbxw/hVw76Q/jv7ikqJ5zkcehZlghBgXWrjACV0F4nmjO/B5hp20cbbKXGhs3GGX
 NW4o8ixb5B7VlfjRh/qx7dhc94KkMneppYFedyWT70O6WHaqyD7p7gXwwK6oX/7RtChb
 hovCwLcBxBjvl43DtMIQ3fU/c+dVxmQY1CJyyNVbtJcavIgDwuJiEIbIO6RlJGnkaXa2
 ZDhO7+sOS5W4rbnN+PrYBqRV+Ibq+OplS5m5bDjQPGCUyEBRvljSsahBQfYgj9mKI6pf
 8U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731893535; x=1732498335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPSXNylK1QB4wWDBzuCw8f7jAxQX+mI78Uyodj41t+0=;
 b=gN+/gp0rraZLFZZixpe1On5ejqjjwaxkUAcAUptBfSJ/u6fkq3gIL5r5tN3RuOXI2M
 2kbQNPYXLDKGROkZz2ta5ZwrD0FIU6kh7JlyK3SMs7Pz8V5FKMPLawrjDvXa4mUDJvP8
 7uOUUEtA+cn6LO6DZAZl94S+zkPmaMqhhAwuADYUtZ2nQj1Msotsqg3WavqPwqBu6eXB
 MKEKhWVj8Zk2GOHUo/q+TIiFi2YXwNFDEJT63Ek1D1n775aDCqzEYRYPdbFHv+juwa+U
 3TPrUOsjYoKhZfDdB+7zBw083fziLgLEPU1FzXw/YTK4L9jWQ3kwSSSlA/CPfZLAVi0G
 ZMsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdlbejr65CLEWPy23mJ3XrFTh/cdmuPX033sBiex/yI6k+pEog+aHNCrKq1bdk3KCZ0LpQSVZazLh5@nongnu.org
X-Gm-Message-State: AOJu0YzzPKqgS+xDQ/QS3gQHK03DboDyB+S4VJIr5uWysKsDLMG5XmPk
 sPwdUO+pVggvuLmQlvnAxyl6FxcvjrX5Ok1/+E4KFPDD6mVzTj+A+qVxWrsrcvxKY09euhMhonb
 P/yiJDOsfPa3DXYgPi4g3gXt6/GE=
X-Google-Smtp-Source: AGHT+IFDXwg/29Q4cFG0R0XYRVeZTvZX2iAXXjRMqmXrGhiFHabXN0UuZqtBJgj92xsNS3U4X3nt68Rpm+fWhcfPFbc=
X-Received: by 2002:a05:6102:32c2:b0:4a4:8a29:a8f8 with SMTP id
 ada2fe7eead31-4ad62af2785mr8067309137.2.1731893535069; Sun, 17 Nov 2024
 17:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-3-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 11:31:48 +1000
Message-ID: <CAKmqyKPzuv+F7yFU3NBM3z-mAa0bVEtCuf4-qNoHdNAY-2U=LQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Fri, Oct 11, 2024 at 5:04=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> In create_fdt_sockets() we have the following pattern:
>
>     if (kvm_enabled() && virt_use_kvm_aia(s)) {
>         (... do stuff ...)
>     } else {
>         (... do other stuff ...)
>     }
>     if (kvm_enabled() && virt_use_kvm_aia(s)) {
>         (... do more stuff ...)
>     } else {
>         (... do more other stuff)
>     }
>
> Do everything in a single if/else clause to reduce the usage of
> virt_use_kvm_aia() helper and to make the code a bit less repetitive.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ee3129f3b3..b5bdbb34e0 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -780,6 +780,10 @@ static void create_fdt_sockets(RISCVVirtState *s, co=
nst MemMapEntry *memmap,
>                                  msi_m_phandle, msi_s_phandle, phandle,
>                                  &intc_phandles[0], xplic_phandles,
>                                  ms->smp.cpus);
> +
> +        *irq_mmio_phandle =3D xplic_phandles[0];
> +        *irq_virtio_phandle =3D xplic_phandles[0];
> +        *irq_pcie_phandle =3D xplic_phandles[0];
>      } else {
>          phandle_pos =3D ms->smp.cpus;
>          for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
> @@ -797,13 +801,7 @@ static void create_fdt_sockets(RISCVVirtState *s, co=
nst MemMapEntry *memmap,
>                                          s->soc[socket].num_harts);
>              }
>          }
> -    }
>
> -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> -        *irq_mmio_phandle =3D xplic_phandles[0];
> -        *irq_virtio_phandle =3D xplic_phandles[0];
> -        *irq_pcie_phandle =3D xplic_phandles[0];
> -    } else {
>          for (socket =3D 0; socket < socket_count; socket++) {
>              if (socket =3D=3D 0) {
>                  *irq_mmio_phandle =3D xplic_phandles[socket];
> --
> 2.45.2
>
>

