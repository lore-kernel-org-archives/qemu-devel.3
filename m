Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50837CAC587
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 01:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxyQo-0007Mm-4W; Sun, 14 Sep 2025 21:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxyQi-0007ET-5L
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 21:54:56 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxyQZ-0003c2-4f
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 21:54:55 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so554231366b.3
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757901279; x=1758506079; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wh35gwmePaTudZC9v7TbD45o+/CFAax/uaC0LPtvB+w=;
 b=NMfhGdTFz5O0A7pgCbFBBKixjSzq8JvlGx0/6Dayfr01p14fcBfOwZAFKKoNUOUh8V
 IiUwfVVwDoHarHf4FWkKoIn7q2OdIrfPgqtXdTjVoaORVjuTdIjocTkiWYoWxHzDYYcV
 Rd8c7bbsAveLb8VKXp3BEffW41O43BkVEJotJkpX2k8Rjua6VhxHcBV1MMAb6SFOipXP
 cvAAGFD4Cm6d/oAdWP3FXm5/0jEwILhJ/2GRjOX/aDWh0UFTqVWOg8ic5waPQaluoHVk
 zaVIWlzBpIq1iHsHjyDMYjyh03nfjUSBck2oqn0JRO+YA+0jmDYvJVHtRyzCvt5h4X7D
 NgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757901279; x=1758506079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wh35gwmePaTudZC9v7TbD45o+/CFAax/uaC0LPtvB+w=;
 b=Eqa9wTAWP2QwAyKr3hA9XcXMD8+eZcmd+R785V02E7Mt54I3nTHyhkxwLStvyKvpQO
 CeMJn2yrDBZoYst5NRkDHPDxuHkw4h2Q9pO4UuGe7QZq7KcLECbSfWO3t3TEraqP7SjP
 YJlMR3QBskMavcHxBIvW9obPiCVoJWQxUCdn7FB8tWYJ4UJb4T8jK+8c5mjzIlkllOqV
 +te0rLRAv0SFNOmyn2ZhgYAJUMGwx3eOYyMC3yA9zjRrgPwhEjAuITn0cC7Fgn2As8eW
 s026/Jdc7s0fRxq0fbbgG0zmlV33BExm8KquSIsRDqsroJaVO8Ld1e5bsYV7jreKGmP3
 g6Pg==
X-Gm-Message-State: AOJu0Ywi8lJwhBJD1sISePW4w+7C3ohu++X6nJsNT7+2gqPrlJiCeWp5
 8S0RNQ9Ff7KJ6cmv6yOo7qsNhO6HGTEkcV/E2NVBbyuf96EUuYAn7DKfWV9PzeKjaDapbwBVC6M
 uNKB5B96Abr6xVSnidWGctuPQ5LFWl30=
X-Gm-Gg: ASbGnctVvXeOPPYDpPKzKEty7yEY+gw1ofcQ3Hj01RmnqgEJlgZsO6k0XQIQfwtuwUS
 2FJTA4xATXQ40vaMDB7/K8zzEq29FTSclj8lRzg2Y2U6/CsBP7HRU7DQcbrhu/U1exbj7ng3zm5
 GZ3Nh0MMaRZHbGuKFtfSEH7nfU61S5OwiK6MPU4w7CVRT3SYW5j/cQhqVeIQR3YAn/HpXj4hg8r
 N3WLf6c2rvBj6/BmN5/Ub0vUlSk2w131G6nc3hB38joUNko
X-Google-Smtp-Source: AGHT+IHHhFE8mit4GABCpz+WIhIP3mTGk5t711eCNN4WnVkrcgy3BwYyiLDWhT5hlNTLQU2TzSTO3S9IhwpiT2bHkFE=
X-Received: by 2002:a17:907:3e1a:b0:b01:6e50:208c with SMTP id
 a640c23a62f3a-b07c3582d6amr1052572466b.22.1757901278587; Sun, 14 Sep 2025
 18:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250904132723.614507-2-ajones@ventanamicro.com>
In-Reply-To: <20250904132723.614507-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 11:54:12 +1000
X-Gm-Features: AS18NWCtTED248ft_V2kU4jhEn2xmvZcu2m95t_6Kx-DYH1dFOblDP5Zu8AS-DE
Message-ID: <CAKmqyKMoPeCQV9Ag-UK613GqUU1M+FcP+H08jTozNE4hH1hmzA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix MSI table size limit
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 4, 2025 at 11:29=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> The MSI table is not limited to 4k. The only constraint the table has
> is that its base address must be aligned to its size, ensuring no
> offsets of the table size will overrun when added to the base address
> (see "8.5. MSI page tables" of the AIA spec).
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 96a7fbdefcf3..155190d032dd 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -558,6 +558,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUSt=
ate *s,
>      MemTxResult res;
>      dma_addr_t addr;
>      uint64_t intn;
> +    size_t offset;
>      uint32_t n190;
>      uint64_t pte[2];
>      int fault_type =3D RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
> @@ -565,16 +566,18 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMU=
State *s,
>
>      /* Interrupt File Number */
>      intn =3D riscv_iommu_pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> -    if (intn >=3D 256) {
> -        /* Interrupt file number out of range */
> -        res =3D MEMTX_ACCESS_ERROR;
> -        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> -        goto err;
> -    }
> +    offset =3D intn * sizeof(pte);
>
>      /* fetch MSI PTE */
>      addr =3D PPN_PHYS(get_field(ctx->msiptp, RISCV_IOMMU_DC_MSIPTP_PPN))=
;
> -    addr =3D addr | (intn * sizeof(pte));
> +    if (addr & offset) {
> +        /* Interrupt file number out of range */
> +        res =3D MEMTX_ACCESS_ERROR;
> +        cause =3D RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
> +        goto err;
> +    }
> +
> +    addr |=3D offset;
>      res =3D dma_memory_read(s->target_as, addr, &pte, sizeof(pte),
>              MEMTXATTRS_UNSPECIFIED);
>      if (res !=3D MEMTX_OK) {
> --
> 2.49.0
>
>

