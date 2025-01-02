Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D870E7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 00:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tT9BV-0004Y0-45; Wed, 01 Jan 2025 19:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tT9BT-0004XW-Ra; Wed, 01 Jan 2025 19:35:31 -0500
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tT9BS-0002q2-DK; Wed, 01 Jan 2025 19:35:31 -0500
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4afdf300d07so6033161137.3; 
 Wed, 01 Jan 2025 16:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735778128; x=1736382928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xNY1h6ZhL6Dr3oxjrX64RqJadsBtlw9qcp/m3TflRwI=;
 b=hQ4RjfwG/zpAdKWC+4ivJHpLuG1oFgE2E8d6qD1OhCKlL3qQ2iFwGjE/gFHyWkV68m
 klamgM8WZH1rXzVvBmZA3zk6KvHe/bMVUYvmgPOFTbQdCFpdMCMyMEo6EgstNbIdHQUX
 1RFNP8k6PuoD2ZcwMyM/A+pCcX/a9r24C3khPx9gY0ZBxmoY4VZMXjXLENhi4ZpZYvP4
 02S8p5aNBBeKNj4oS81WNKFnhFdqYGNjt9+O2SbZttmalqtmG0yLWl2iz1OrKNartyDL
 CpbquxzMnAJpujQBFigkNCxno3w3sgWX5V9u4Y3mB+Q1B8foatiil4Qk5SofpgSso1l+
 uJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735778128; x=1736382928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNY1h6ZhL6Dr3oxjrX64RqJadsBtlw9qcp/m3TflRwI=;
 b=NyioByq2ALdy1ji7HzkWGx2H6F3s6/ocCKPP1PqRp79J++MlJj/WhOB5Y0v087M81N
 wjSN5zAdN3NmKTAxxHgoQFVCWZUL6ahOlaDEDv0hMfn2vfSGPgVz1VG/ftLyFHy/GqJW
 zAJCnZbBo5jgsoVwr2+T/98SbXp1U/PP4IUkOK10nYDy8CyIwFdFIX405H+R1oHi83Gh
 8M5AKRQEkNsNvKfLKV4FfGZJ7Wl3SvBvSt51MYoJPpFN3kZRazjeJC1v6rxlr2w+i2fl
 FXo3WUVvMc+i9uwv+GZ9lgSGAEs1J6DxExo4PS5jesiAvQ9PxMRerLuHNtQR7fmSdVgc
 mRPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBorjR1zlnErhWNN9NoG6x5fdycgxEl8GmhMCmjgHmcn4RaFY7I2HhJHtXf3O32jzSNp+0tUeutSMHmOUt@nongnu.org,
 AJvYcCWhPopb0sG504OjYbDEs5BijuWhZ3ji44XneEk/nBivfpA7Qups8qyCxFqVPWs8IJLzoGruX+QVGOuP@nongnu.org
X-Gm-Message-State: AOJu0Yx4XTTZjN3YsGIDct9Xdnh2Y9+xDft++aCTnDtazbG+pQZqRwNl
 QYI/HZ99Zw9vSn3XYCdCGgU9GBFDisZM3Sr0ZAeTR4TmPoDNjKGKAVqA4nJm5/AjmnEyXUjZDZi
 FP/OijvvZWxGlHTg2canfb8vV6Q2/8w==
X-Gm-Gg: ASbGnct/RCu6rJT1ERwPqQgXZwBABe/LuwUfo9ZHTG28fw2pOT8+KlEI6h1GON5WNt/
 +CFs2mGJxTFqArBj4lleeL8LfYT54QBmXpfyF56VE3/lhHrkTquIdDHP08UHoU+cLcTOI
X-Google-Smtp-Source: AGHT+IEaSj768uR2KdSqgnIRz7Ckjqo6UWRwVDhY4/pOWcq3VB9AcXKvPh4aBHCjBnUOYHrk0h+3NyCxD/g1WRu4Pj8=
X-Received: by 2002:a05:6102:5127:b0:4b2:77df:4660 with SMTP id
 ada2fe7eead31-4b2cc3225demr34539689137.4.1735778128638; Wed, 01 Jan 2025
 16:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20241222214507.2173648-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241222214507.2173648-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jan 2025 10:35:02 +1000
Message-ID: <CAKmqyKNgvYVt9J6HXyH6NEuOF6wd6XzHNKcPAQtk+arB9A-dLw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu-sys.c: fix duplicated 'table_size'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, qemu-trivial@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Mon, Dec 23, 2024 at 7:46=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Trivial fix for the following ticket:
>
> CID 1568580:  Incorrect expression  (EVALUATION_ORDER)
> In "table_size =3D table_size =3D n_vectors * 16U",
>     "table_size" is written twice with the same value.
>
> Cc: qemu-trivial@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Resolves: Coverity CID 1568580
> Fixes: 01c1caa9d1 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support"=
)
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 28153f38da..65b24fb07d 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -121,7 +121,7 @@ static void riscv_iommu_sysdev_init_msi(RISCVIOMMUSta=
teSys *s,
>                                          uint32_t n_vectors)
>  {
>      RISCVIOMMUState *iommu =3D &s->iommu;
> -    uint32_t table_size =3D table_size =3D n_vectors * PCI_MSIX_ENTRY_SI=
ZE;
> +    uint32_t table_size =3D n_vectors * PCI_MSIX_ENTRY_SIZE;
>      uint32_t table_offset =3D RISCV_IOMMU_REG_MSI_CONFIG;
>      uint32_t pba_size =3D QEMU_ALIGN_UP(n_vectors, 64) / 8;
>      uint32_t pba_offset =3D RISCV_IOMMU_REG_MSI_CONFIG + 256;
> --
> 2.47.1
>
>

