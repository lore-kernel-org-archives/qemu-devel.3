Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A72CCF9E5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 04:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEK01-00061Y-9U; Thu, 30 Oct 2025 00:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEJzy-00061Q-Dv
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 00:10:54 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEJzs-0004NV-Vq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 00:10:52 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-63d6ee383bdso1084383a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 21:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761797443; x=1762402243; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKd3OfVogN+Dj+gkdfx9dhx/UKUsz8IjoiyjQmmr/pE=;
 b=P7PwrmqsKkB1R+muHVfxHnu/0fKMHcapNgU7K39GDlE5vhp+RIvcuE1iOOyBqWmapi
 6rJ+H9tHAXPC+LkEm9pgJPoslkXwW4nzMJJnWpcUhG/ylkNyVugZtdAqu7qOJBvSqWnZ
 gQND4Iozhq8mmgYgiI/FEL/xkAEEnzcgCFOVp2CFkcwBpyq98I/eD8njT7Wco23ZNKiV
 Uu9Fikm702R+G8Qm80OAN1YRwIu2giyixMSRM7DhvR7gqPO8tT+ge7e7QnDWE02MRhNT
 MMgACcssAGY1f2nLU6W6bR4Q21kOxU+DtATdp8K162mkk8ZEDv0X+liCk21JFu/+Nayl
 JeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761797443; x=1762402243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FKd3OfVogN+Dj+gkdfx9dhx/UKUsz8IjoiyjQmmr/pE=;
 b=KvQQLw+OZeNPyV6lWNYSVb9DNWGQteCtn3XE7lHGWp4TAv9QBPfnGSgRtBC11Vdu3x
 Zt39C0VQWOLFgE0KHBWWKoNTA4QKW7N+H+Xv+tRBgjY/reD/ZSJxps95LEP9SYg2SXkA
 J2YO8W2osooSGdqZ5RT+Qzc5CGAbuofDOXByu8qJfIMIJWhrNbgszVeTG/rghPzMWbFS
 E7x8lGNf2z3IUF1lfKAAzdNGvZHnqg6jDI1DJDPUTl5qrckylJy2Tw4psXvwrYeJWTOx
 GWqUNNpSr+31ULRVM6btBBvUORhdu3pi1W+hP7gz3JxA1D3he/YjOoSQfO+3ioKZKHtD
 bPVA==
X-Gm-Message-State: AOJu0YxcOAjcL9fh/1TZtLM60ddeb9oJxsNYN23fxqb8UCk9dbLRCMWX
 IlMIDhbe9kGUMHkfWdOBeTDR9ygJGGtjJtbZVPyTjjRCAK1o5u9ZUSmd/F2IT0eGCsmz+QKrsZC
 gQG6L5shg8tc3IMHMsGuLCOPYRqgVJ1g=
X-Gm-Gg: ASbGnct/Sfy4DADvtC+n33VGiDf1mByEoq/FDxulTn1IXfEjbsfSO0hwbnPsl5zIzpx
 dLI6d4LZmJUBCTjgSyaPpMDqL1IgksE55UBZvS+m4ag/tbYqBJvfDkuifkIFF3/e7aFBs7dinoa
 ZI2nuFiGzfuW+/xjpQr0svofZA4Dx/ty4K/Hk/vU8elTqLDLEBAl9VN+xhopERYwRpBaP07/5TL
 AxiE0iXnbbcREhJe0YkimkjHRx1QAsuughvIO2MCCVyvyTt4p+LfOOnnXNjDgWamgNrRD5YFlN/
 WR/NTbNt9QI6iRykmbFlzHEydQ==
X-Google-Smtp-Source: AGHT+IEaRX3RaAmiYcD4Wvip5ZigO2K8FZNfdxmX0SDlRYGGIu5n85T99w1kYgQMjkyTvBMlDw2VQXIl24fRH+Mp040=
X-Received: by 2002:a05:6402:354a:b0:61c:8114:8832 with SMTP id
 4fb4d7f45d1cf-640441e5250mr4463748a12.16.1761797442939; Wed, 29 Oct 2025
 21:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
In-Reply-To: <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Oct 2025 14:10:16 +1000
X-Gm-Features: AWmQ_bnhXjfkfVX4c0blVGwLYAeACSjDtyjJd-biSY_z8Jg8ZJLP27kXONf4KEI
Message-ID: <CAKmqyKPSmfBtK_P66uhvLgg1PinCLJY9=++gMgLTS9kR9fasUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/riscv: Replace target_ulong uses
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
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

On Mon, Oct 27, 2025 at 10:35=E2=80=AFPM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 6 ++++--
>  hw/riscv/riscv_hart.c  | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b33c7fe325..f8656ec04b 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -26,6 +26,8 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qemu/timer.h"
> +#include "qemu/target-info.h"
> +#include "qemu/bitops.h"
>
>  #include "cpu_bits.h"
>  #include "riscv-iommu.h"
> @@ -391,9 +393,9 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, =
RISCVIOMMUContext *ctx,
>              const uint64_t va_mask =3D (1ULL << va_len) - 1;
>
>              if (pass =3D=3D S_STAGE && va_len > 32) {
> -                target_ulong mask, masked_msbs;
> +                uint64_t mask, masked_msbs;
>
> -                mask =3D (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
> +                mask =3D MAKE_64BIT_MASK(0, target_long_bits() - va_len =
+ 1);
>                  masked_msbs =3D (addr >> (va_len - 1)) & mask;
>
>                  if (masked_msbs !=3D 0 && masked_msbs !=3D mask) {
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index c7e98a4308..65d2c92018 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -93,7 +93,7 @@ static bool csr_qtest_callback(CharBackend *chr, gchar =
**words)
>          g_assert(rc =3D=3D 0);
>          csr_call(words[1], cpu, csr, &val);
>
> -        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
> +        qtest_sendf(chr, "OK 0 %"PRIx64"\n", val);
>
>          return true;
>      }
>
> --
> 2.51.0
>
>

