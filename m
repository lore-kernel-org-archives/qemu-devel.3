Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87801CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIzeD-0004qV-3z; Tue, 11 Nov 2025 20:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIzeA-0004pV-Uv
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:27:43 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIze9-0004nO-Ej
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:27:42 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-640ca678745so423381a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 17:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762910859; x=1763515659; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IoXp9EAnAlc629QhkHWsDQNfqx00ddTGnS7kAtTuKnE=;
 b=jQO3n10SLfS8CCJpDK732UIhKaE+PuvhSfXgG2pvSi4aI/TOsuAhoPc1nrJZhaxih8
 jDyQW85lCku3cMlieO9NpsSlRytJxCks0ikVOZKnISDvSsUrJd7qnRDwZfZiuKfpitrr
 zsQns9Bz6YO/28p/qRysH2NPp55R2xA2D62ghjBFNgRiCljlfTwXT3V7OtzEFO2MpVqM
 NVM6aNZzJR+UVbrB3xudmTx0a3R9Yu3485IhlPq9hZzEye67dJFKjB2S1VeBYoylVC0o
 dneK8xNgrQNhwrgnM6XK2acVrzsbKCOmoZ9IM3TvC76RriNFHwAqD4Fm36DRW+8wnZoZ
 i1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762910859; x=1763515659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IoXp9EAnAlc629QhkHWsDQNfqx00ddTGnS7kAtTuKnE=;
 b=U944Cnm3lgSAerkA5tDm3TGP2HTbMwsmLBJtEY6CwySzg9ksS88oe9TcKUKgyEVral
 FzolpLamvSP4hFxziJa0WqQ1Ep2FFxftJD+Mibi1xoGyp+zCyJaJCbooHTtIZV2tIZV6
 VLfRp9a40UYQQJZ0f3lRfV4Q9uholkL09FncuXp4GujuL7Wnzn8GPlqW2sO3v7yql5bk
 1ZE0z/riMkBP2he30FWsorjjULklmQQSReuqs/GaQi5mtXH3VUBjnhUZ4VuroLxbeQ73
 YlyKZ2FIprtlXltyYpkmBYYpxIXSN+GIt5jOa+tKrr+Dk6Oprciv4CjLHkaAVPdVJmyQ
 lw9w==
X-Gm-Message-State: AOJu0YxUVRaMKM+QT5HtYYX84TDrZYNmAlffHy4ASptaBQ8H1IgQQ8xP
 i+B/c7vyVgY5/z0n0U5rweSyDJ3AauqbxWwGDVNw6raFHH6p5GkN4ovYkU7p86GfsKBDR51dVtv
 Miou+riwQ+z8TndeUwSuqc0l39ImfMHI=
X-Gm-Gg: ASbGncsQSLYDOq2qO35s/Zs6x2mvyMs8LPs7FnLl0yqVxL4yFyfD7VOVcq5P9TS1a+N
 5ardMhqiLtu6MotPTNjbv+bGW11x3+o1MFK6HIlZvutD6FhCbf83xy3x6ynhG7tK16/9Zh5wbx4
 X+nb2JypY50/1JE31kkm/O5R8QuaG8nOyH4wgzuNI6PFotsb5E6OM+M/wjy85bWoJ311kTj2GZ8
 RTItA4ObZJi+3SZ9r/TxkKhojpTGNDRLrXl/GslJs0jj/Es0oRL6ujBgvA/IDhX9b19agC3fHu/
 MeegG/cHAJZhbWY=
X-Google-Smtp-Source: AGHT+IECeR4U3rNg+rcDucgFxtpjtw8tlOGvPejeCqwbAaI1b6qA0EZJ5KBNjG7gcQzB5QP1dvhKg3IZknTJLZu4e2s=
X-Received: by 2002:a17:906:dc8a:b0:aff:c306:de51 with SMTP id
 a640c23a62f3a-b7331970801mr132341666b.4.1762910858825; Tue, 11 Nov 2025
 17:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20251028085032.2053569-1-frank.chang@sifive.com>
In-Reply-To: <20251028085032.2053569-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 11:27:12 +1000
X-Gm-Features: AWmQ_bl9uSVDY-_SeoHip-a-hEHWLXFIHohx22I1PZYIUGzR9NHwUN8l3NqbHo8
Message-ID: <CAKmqyKMZyknHE68OegcpGHmauj6Z-4_vBewgAiB9RrkbK1oMVQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: riscv-iommu: Don't look up DDT cache in Off and
 Bare modes
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, Oct 28, 2025 at 6:54=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> According to the RISC-V IOMMU specification:
>
> * When ddtp.iommu_mode is set to Off, there is no DDT look-up, and an "Al=
l
>   inbound transactions disallowed" fault (cause =3D 256) is reported for =
any
>   inbound transaction.
>
> * When ddtp.iommu_mode is set to Bare, there is no DDT look-up, and the
>   translated address is the same as the IOVA, unless the transaction type
>   is disallowed (cause =3D 260).
>
> In the current implementation, the DDT cache is incorrectly looked up
> even when ddtp.iommu_mode is set to Off or Bare. This may result in
> unintended cache hits.
>
> Therefore, the DDT cache must not be looked up when ddtp.iommu_mode is
> set to Off or Bare. For other modes, software is required to issue cache
> invalidation commands before any inbound transactions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b33c7fe3259..95db811f125 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1290,13 +1290,18 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIO=
MMUState *s,
>          .devid =3D devid,
>          .process_id =3D process_id,
>      };
> +    unsigned mode =3D get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
>
>      ctx_cache =3D g_hash_table_ref(s->ctx_cache);
> -    ctx =3D g_hash_table_lookup(ctx_cache, &key);
>
> -    if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> -        *ref =3D ctx_cache;
> -        return ctx;
> +    if (mode !=3D RISCV_IOMMU_DDTP_MODE_OFF &&
> +        mode !=3D RISCV_IOMMU_DDTP_MODE_BARE) {
> +        ctx =3D g_hash_table_lookup(ctx_cache, &key);
> +
> +        if (ctx && (ctx->tc & RISCV_IOMMU_DC_TC_V)) {
> +            *ref =3D ctx_cache;
> +            return ctx;
> +        }
>      }
>
>      ctx =3D g_new0(RISCVIOMMUContext, 1);
> --
> 2.43.0
>
>

