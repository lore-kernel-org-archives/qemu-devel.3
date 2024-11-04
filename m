Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADA9D1CA09
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 23:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t86DF-0007Js-MJ; Mon, 04 Nov 2024 18:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t86DD-0007JY-8b; Mon, 04 Nov 2024 18:10:19 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t86D8-0000YS-0s; Mon, 04 Nov 2024 18:10:19 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-84fe1bc5284so1657547241.0; 
 Mon, 04 Nov 2024 15:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730761812; x=1731366612; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4zwPEK5X5oFh4CQ14cbiT4FLOr3hw9OaMGbpgUQOYA=;
 b=H8Xpq/qQOuXHkqlutN0xW4gsX6LlOMP2GZu4pMcp4R0nbIIyjWk7R3ASbPA1ko0ll1
 SAMzzrN8zC5y8AtSHmdJ22S+s7NKwcSx6pZiS6ReeAKCCNzdlBezEjZHkIJ1szvQ4B5H
 obMEFNZRh0D65/n68QXiDYAcUu1TdsYfcEzaN6ko2S1AzpojNbiQj2XuLhaQ7AH2hoAc
 N+nMPqChrW/+y0C0UhUD5cZ6cK8lyfKf1tOjUGb4UuGebdmC3x3DjSAICaHP8ZnJtwZx
 ywVIkvGlCymAuL8HYnqPhUkfe+/d3jaV/0IidxZIl8tjJWRhyouBLEWcVNs6mdEfrFDv
 fJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761812; x=1731366612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4zwPEK5X5oFh4CQ14cbiT4FLOr3hw9OaMGbpgUQOYA=;
 b=Ba1M4UauJhcGCzHummm+uABO+1IcPfCv34U0bT5Oimnyv/qdkpoAYrD4sn88N098Z+
 QJpm5CZQMLEgKpPZr783gfn0DQQrAVL0f/2iW4q5QIJmbBAUAspUBa6VQwHZLgfInblN
 YnetmgVyN3XaUx1WFYvROpxY9mpGuT+hzMj7BgGPHxp0x0wMsFMy/w6nMATL6wbT3/17
 ZiCfI+uY5lPBatCTRKEjABpYyjgCFPzwZ1pSXFYfbaKXUolZnFOQ2ct721L6nvxZvI+e
 Ia9R18K9xYtShJ2FnbCrKuhnBH4f4zvMVos6tcg7YAj6Ct+ucJbS32zk+sw68d7cumCi
 jeXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjoN9dMfLPmM87sPmnrBjUvCia5m9mQLBdbvsTKu55P3Uh8MXt/HKOIeAxFQMGr88BuVUZ0Jt5rAOz@nongnu.org
X-Gm-Message-State: AOJu0YwguBqz3F3LYUfIWjMHnxdvMU07VmM4t7I9ztDIb02vqAVBOpjX
 cUHQ4XME2YNbQfTOGDM71m18bJ2Cc3UVcgWzaTTuTZs0RChuq6owngC0USZp4lVPs8KS+gYUMoU
 N0LK948bLfmPWZa4xx6Lnne+e5zk=
X-Google-Smtp-Source: AGHT+IFbWJV8hCRHdrECcrdzM4FT4Vjny4A8hhoi0WkSXC2BiEDCWDlZ2dS3qbO4iZqMbvxkLaIfYhOKUUtCY0tWc0Y=
X-Received: by 2002:a05:6102:3590:b0:4a7:49ca:4ba4 with SMTP id
 ada2fe7eead31-4a962f7e1f3mr10110145137.27.1730761812497; Mon, 04 Nov 2024
 15:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20241104123839.533442-1-dbarboza@ventanamicro.com>
 <20241104123839.533442-3-dbarboza@ventanamicro.com>
In-Reply-To: <20241104123839.533442-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 09:09:46 +1000
Message-ID: <CAKmqyKOQKw54zFWpAGWowR8i=7yR7avjdToy3ikNNEP8evsfhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/riscv-iommu: fix
 riscv_iommu_validate_process_ctx() check
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
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

On Mon, Nov 4, 2024 at 10:40=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> 'mode' will never be RISCV_IOMMU_CAP_SV32. We are erroring out in the
> 'switch' right before it if 'mode' isn't 0, 8, 9 or 10.
>
> 'mode' should be check with RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32.
>
> Reported by Coverity via a "DEADCODE" ticket.
>
> Resolves: Coverity CID 1564781
> Fixes: 0c54acb8243 ("hw/riscv: add RISC-V IOMMU base emulation")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 05341ad20b..dd102b3c70 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -803,7 +803,7 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOM=
MUState *s,
>      }
>
>      if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
> -        if (mode =3D=3D RISCV_IOMMU_CAP_SV32 &&
> +        if (mode =3D=3D RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 &&
>              !(s->cap & RISCV_IOMMU_CAP_SV32)) {
>                  return false;
>          }
> --
> 2.45.2
>
>

