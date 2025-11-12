Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50732CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIzOU-00064y-A7; Tue, 11 Nov 2025 20:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIzOR-000636-EM
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:11:27 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIzOP-0001Ga-T1
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 20:11:27 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-640ca678745so408475a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 17:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762909884; x=1763514684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7EAKxuRx5OnEU3aAvsBCTrhR08XsL3M1XTpwYL5Pjc=;
 b=lpxz1CE+cQE6zamu/icK1tkCX4Q0Rsp3F3FJj21mX01lUsYJvDs8QLrhEhxmacW8Lq
 OLU4TVr7rOun4tY2N8vUWZnjEox7rppWsKSc8k5MH4QBU1dawHw+EZatZQ9BO7ajJdfJ
 SdFV4sTULcyHqCmIfQMBZGIRMYruB8DaDxG7GLRGC2/IAhTdmdiq8Rd/vETL73Iu3Z3Y
 9yWr14PdcO3Xax0S04TESu5BV+0gaQkvHnH4kA6Pz0xxLedCigHx5/4zD0WfZml1EuN8
 uNQ5iFItpVzBB5o30jpfF8KvKy2XO8LgodfxVyus/EDk+2jnYAmUhZaFJDi5FIJGMMwz
 11zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762909884; x=1763514684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k7EAKxuRx5OnEU3aAvsBCTrhR08XsL3M1XTpwYL5Pjc=;
 b=vOKV/zFZUisAH6vsdDcrV0kl0pxjIqJy09JoCtHBo5Ql7GdH6D5AqY5w4Rtlons9kp
 31cU9JRohqOfvRq5l6PQf8ZXWHQRjUdINzHXIAADVi3fo1gmwiHznM6lQS8vfZVP28OX
 vYscL0Zha8UVajSUJRgpAE/gtliHXoJdOd/l7MvYVk8Jdeh4y+4O+v2AZhi84QbytEPl
 jOVm55NKK8g7ifuMpMnpxKqcU5AWbsy+fTMSqDIf4ZlLha3sJmImyC7P6LNHV5QK5Nli
 D1EsZQ2ZLGSIqIC+BwinnHcpDiYT19uSMhiZb1DUYnJ0vEipbIxVSwvgbT8fRWWE8jw8
 Y1hg==
X-Gm-Message-State: AOJu0YzC1bHBMvAvI+ocaZFSSEQCbLVjOST+zJZmOzr+5r8w/oIzYmMq
 okG8tw5gG5VVwoFh0zoCkrjhVaw7VnVrHrA6lX+sAeITRhPiY40bRaASdhjp9d87zfaOvcBsEHe
 2Sc7K+apYyoHeDXisg7DqqYmuoQ2h5L8=
X-Gm-Gg: ASbGnct07FVRx9u71gbCdevtFu0dgX47pFVmTtRSIzvOH+U6zFGm3mpJ8JOOmAV2ZxF
 wTvFcpVt5pDOoqCT5UcpfIjfNZwE8FUw6PE408cfAvdfOZrrv7X88yGXHvpRI+BBFuOpsE52jhc
 WTqCN+bZ60EFD8U1aJRGameDHGVKcNuaICwnwD7E5C2yTj+WX5XspGD9Sk0XHvQodOo3A+RppLM
 UE92EfaDP8/ABZiRurGBuz4PQ3JgL8X2ZLaLMifvTCaL8nC+w05sgA2V1f5p0NJfT6VLWACdxQV
 V5YUrCr0tck0VWw=
X-Google-Smtp-Source: AGHT+IEFwIMGiiUjWdrqllpbxp9SaxNejb9pESqNh50SDzUgwcI+UdR2ZKSFhLtdpkxoHe++m+4NsqzyMmqyn9VrFJ0=
X-Received: by 2002:a17:907:9409:b0:b6d:8d28:1687 with SMTP id
 a640c23a62f3a-b7331a81e9bmr126949166b.37.1762909884246; Tue, 11 Nov 2025
 17:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20251028085032.2053569-1-frank.chang@sifive.com>
In-Reply-To: <20251028085032.2053569-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 11:10:58 +1000
X-Gm-Features: AWmQ_bmvp3zuatO051lRp3Qntw3ipKBhhci9La7qh5Hq0xl2kVMxdOO3f8jjJUg
Message-ID: <CAKmqyKOap9CuuQWpm6ABiCWQ1_-1b-27m7bLWqRvuv0LkaToNg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>

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

