Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E03AD1CA0C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 23:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t86BU-0006VY-6e; Mon, 04 Nov 2024 18:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t86BT-0006VL-1p; Mon, 04 Nov 2024 18:08:31 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t86BR-0000DN-LW; Mon, 04 Nov 2024 18:08:30 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-851f5d3001fso1593494241.1; 
 Mon, 04 Nov 2024 15:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730761708; x=1731366508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnhmpQggdZ+78cX0KNI8tsSFl4U1Cnl27W5ZoCqJfac=;
 b=j51C3kntvrLL8zz+dTZoX5UClmzvb4unDCSQ/KK6aZKUEM+sFioKpDvHpCfbjS+fqA
 ObBm6Q4Uo7GOT8W66q117lGIX53yuWyjIzKJUHPxgHpkvZf+91gduli2vbBCRVSYTXxl
 RYW3dI3G2uUQbeGGj5uiZQvQ2IYVJbdmzTMSH+D91wTaBVaQhoCI5yNX+gdtksB4YF4t
 47jPetJ/m3aegWNxeE1vry5wpmuP5Is+Fzm7a8LIpUSJZL5+ZkMwA8+LS9ILAabB8YoE
 P/ae9bLOERJMAA2apr77UB6w9iyxeE1dzZ9i5xOeZOBbAuhfu4vO4p0Ego/q31cUSjyv
 GJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730761708; x=1731366508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnhmpQggdZ+78cX0KNI8tsSFl4U1Cnl27W5ZoCqJfac=;
 b=mgThNpH5WJd3jSiUukHKjE1tiv/NVNpJqVM/HF5tGparxe3Z0YszmzaBT/D3xXHR6Q
 opUQTMF7Dc7UL5nyz62frjwKAF221w/jbro5XH3YE57zJG5piqJ2Sd20r17juDjFGPZP
 VBMILGVCY14gfYG6GUrm0Y4U7oD8/Dzk96CGlXDDxPLOQJ4BVxiWj8X4ntntc/ij+Wxu
 sUI0n+sSsNflPfblre01F+ILpJMXFiA5qk2GiLFtgsvL5o/1A2+QmZDWgaMHo/oIVnSP
 ywBq/EO93yTuXaZhXmc6Lonsve0fZ7t6ak8g8ThmILJVuy5GJa1X5dVI+PuTb86DRWIz
 B4OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVumUc3MY67DotiB8VizGjw0bnQwPH/1bq9t3VJZm5bGrLDNmLS+grJewePo2T9HKuRBbOuNzaq6iSB@nongnu.org
X-Gm-Message-State: AOJu0YwrduU0PqDBUfvYoKEYfVHdtvcN1NN71dUMTyG9Biqv/dVysVTK
 6Q+TzuGPp+W/glKeGyCpCUXxYa47uM7COM+8lG33LZl0OwGVI/0uyqHlaoCN/+G92VKWoHRFzyG
 fB7L4+kVBr1y0MJpF0stuTQ+domL+Cg==
X-Google-Smtp-Source: AGHT+IGSxuBS5HSmHM+cwqd6tAMyqCkJyNmlQ9QvF4HLlq9H2hxKbaoULKomE/G0Yr+LQ3LTAIChI/qZWTnag3Ogsu0=
X-Received: by 2002:a05:6102:e06:b0:4a9:a3a8:91ec with SMTP id
 ada2fe7eead31-4a9a3a89260mr29942137.43.1730761708107; Mon, 04 Nov 2024
 15:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20241104123839.533442-1-dbarboza@ventanamicro.com>
 <20241104123839.533442-2-dbarboza@ventanamicro.com>
In-Reply-To: <20241104123839.533442-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 09:08:02 +1000
Message-ID: <CAKmqyKMyfubV1bd52rd978g780AF8XzS4LK-PaVT5FSwb0nH7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/riscv/riscv-iommu: change 'depth' to int
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Mon, Nov 4, 2024 at 10:41=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity reports an unsigned overflow when doing:
>
>     for (; depth-- > 0; ) {
>
> When depth =3D 0 inside riscv_iommu_ctx_fetch().
>
> Building it with a recent GCC the code doesn't actually break with depth
> =3D 0, i.e. the comparison "0-- > 0" will exit the loop instead of
> proceeding,  but 'depth' will retain the overflow value afterwards.
>
> This behavior can be compiler dependent, so change 'depth' to int to
> remove this potential ambiguity.
>
> Resolves: Coverity CID 1564783
> Fixes: 0c54acb8243 ("hw/riscv: add RISC-V IOMMU base emulation")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index feb650549a..05341ad20b 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -846,7 +846,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx)
>      /* Device Context format: 0: extended (64 bytes) | 1: base (32 bytes=
) */
>      const int dc_fmt =3D !s->enable_msi;
>      const size_t dc_len =3D sizeof(dc) >> dc_fmt;
> -    unsigned depth;
> +    int depth;
>      uint64_t de;
>
>      switch (mode) {
> --
> 2.45.2
>
>

