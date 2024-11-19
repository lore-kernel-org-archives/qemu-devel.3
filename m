Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CBED60D05
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 01:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDCqi-0004KM-4w; Mon, 18 Nov 2024 20:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCqe-0004K2-BH; Mon, 18 Nov 2024 20:16:08 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCqc-0003W0-Nb; Mon, 18 Nov 2024 20:16:08 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-50fc0345155so3720249e0c.1; 
 Mon, 18 Nov 2024 17:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731978964; x=1732583764; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vU3XjETc+r9iseHa32XfHTVSPi3ZWP6DLLAErVQQHko=;
 b=MaWjGzbZ4CCWi4h8ndydGm5lTMh/xobot3zlX+RnMnmn9tW+Vf02hfifKTellWRhtf
 FTUY30v66Gn2LPz/eFCBRVhxKyEFVBsAJFzkN5v7NS9PBTEA4ZFhqCP0PdfMN9kJKPln
 nj8Qi1izAdlUNwIYVy2UvgZ6RhUM2s4k3auWcceqE/Y71Qe62DYHpFvhAoLVpg7bBSh+
 G5wYWmbIaKJ3UrV2eP7YjkszPHSRgNUWCTvFmUXXrVbOKlYmwGBxowNPE7FC4J5+GWtv
 FcyrO42b6KUmMmSKFzNScPkXQXrGX6XwdOQTnM9NpMArF0Geb0Ou/L9ZjfkGZ54j3u36
 DU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731978964; x=1732583764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vU3XjETc+r9iseHa32XfHTVSPi3ZWP6DLLAErVQQHko=;
 b=R90zD88PzHiAzKKShhRkM/7NjQlEm3SIWDclexO03SVZbWDbjabVkcNGqQu1bh9uKH
 nw8nX2w+H6/KTvB499ckssXa/F/DvQp1uE2N+9aL0wnSFCVAJTmvDz+7oHFAs7S1r8CG
 20duZfZMyM36taIl4Ldr8bzXOao+BvrQ4noXSQ+sst96m24ZBCBEMVbiW/iVGjcaHnhO
 TV/KTA4U2Kv89tq4C/zNS5Xb3+3gI/u52asiSynoxLOGOnfKmcgKhJ8+9uSGUbcIckVz
 ROf7eTAUxGN+I7pEXHlcn4PeAgB8cCASqEQzz+JcVtNdhlbI6ckQqZ0+h4FlNMzTa/QC
 K3Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYq670yB/MiQHogbYl2mpt6dGmajKeVEoBdR8snwu5w3wNANf4M+DoczNjHyQft/EgCAGZNNizgEdm@nongnu.org
X-Gm-Message-State: AOJu0Yx72r0pBqhhvF7iGGUigH8iweqmb6Oe8xN5ZLPznpeaZ5l3PAuR
 ufTogzYq86vKDEBEwEOCrPfroQmY4ouhXSaqEulIqm7S8fohKqWtSYiy0TMeuCyxK+XawEsgfJ0
 9o3KvkorK1X/0Dg0pZZTkjDUmDdQ=
X-Google-Smtp-Source: AGHT+IG3VSKmZSJsiUHjrLb2Hckx2HvdKCx11mvPpiNhOEUee2QOPxe9/+ESBDvAAwVY6itFVkuKiehrBcl7IdaURkU=
X-Received: by 2002:a05:6122:328e:b0:510:6b24:c2ca with SMTP id
 71dfb90a1353d-514be0ec48fmr1751133e0c.3.1731978964287; Mon, 18 Nov 2024
 17:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20241114065617.25133-1-jason.chien@sifive.com>
In-Reply-To: <20241114065617.25133-1-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 11:15:38 +1000
Message-ID: <CAKmqyKPejvg+22WQXpMw=q+x5WNNuA_Sz7=VOrr25JbDZkDL-w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu.c: Correct the validness check of
 iova
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Thu, Nov 14, 2024 at 4:57=E2=80=AFPM Jason Chien <jason.chien@sifive.com=
> wrote:
>
> From RISCV IOMMU spec section 2.1.3:
> When SXL is 1, the following rules apply:
> - If the first-stage is not Bare, then a page fault corresponding to the
> original access type occurs if the IOVA has bits beyond bit 31 set to 1.
> - If the second-stage is not Bare, then a guest page fault corresponding
> to the original access type occurs if the incoming GPA has bits beyond bi=
t
> 33 set to 1.
>
> From RISCV IOMMU spec section 2.3 step 17:
> Use the process specified in Section "Two-Stage Address Translation" of
> the RISC-V Privileged specification to determine the GPA accessed by the
> transaction.
>
> From RISCV IOMMU spec section 2.3 step 19:
> Use the second-stage address translation process specified in Section
> "Two-Stage Address Translation" of the RISC-V Privileged specification
> to translate the GPA A to determine the SPA accessed by the transaction.
>
> This commit adds the iova check with the following rules:
> - For Sv32, Sv32x4, Sv39x4, Sv48x4 and Sv57x4, the iova must be zero
> extended.
> - For Sv39, Sv48 and Sv57, the iova must be signed extended with most
> significant bit.
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index bbc95425b3..ff9deefe37 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -392,9 +392,26 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>
>          /* Address range check before first level lookup */
>          if (!sc[pass].step) {
> -            const uint64_t va_mask =3D (1ULL << (va_skip + va_bits)) - 1=
;
> -            if ((addr & va_mask) !=3D addr) {
> -                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
> +            const uint64_t va_len =3D va_skip + va_bits;
> +            const uint64_t va_mask =3D (1ULL << va_len) - 1;
> +
> +            if (pass =3D=3D S_STAGE && va_len > 32) {
> +                target_ulong mask, masked_msbs;
> +
> +                mask =3D (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
> +                masked_msbs =3D (addr >> (va_len - 1)) & mask;
> +
> +                if (masked_msbs !=3D 0 && masked_msbs !=3D mask) {
> +                    return (iotlb->perm & IOMMU_WO) ?
> +                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
> +                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
> +                }
> +            } else {
> +                if ((addr & va_mask) !=3D addr) {
> +                    return (iotlb->perm & IOMMU_WO) ?
> +                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> +                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
> +                }
>              }
>          }
>
> --
> 2.43.2
>
>

