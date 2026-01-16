Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA16D4A5FD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 04:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgbh2-0001SA-KJ; Thu, 15 Jan 2026 23:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vgbgy-0001Qz-QE
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 23:44:13 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vgbgx-0005bS-4w
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 23:44:12 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b876bf5277dso397648566b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 20:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768538649; x=1769143449; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHDFnGo8MiqX/X2KiGCwnz2zaMsTfov3EUbMbxzRRW0=;
 b=m1OP7SMZzk026u/z/jpAu3RZoHlOOv4qifhNbaAARsT37bcJUVPOH2pk77p7hlru8K
 a2cUtK+qzebwyBR9nnWJ6f3Z06jYODGDUngtKLBWN2yap01vW8P2Pn+uAbrq+JRKCyQK
 knDUF0XtrzyEy2VUfpJj0UtzZKxT/tFrGtCm8rGu1FThHuKZZScKMj0HxBsX/XUVZGTd
 UOrFv9F2NdqlqXrdNdUlIWvId4rCc2PTidV6vr3G5Rcns7ED5u9nkaEd0fI0dODtgGQu
 CUG0OZble8ZujDGb8pM1LaUvs5ofO67/OMDbSndWg3eLp7AcT1OqKUMHBQhDwKeCpXQp
 FEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768538649; x=1769143449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VHDFnGo8MiqX/X2KiGCwnz2zaMsTfov3EUbMbxzRRW0=;
 b=FJbpiFFFF8LlFGRAc370p+Y8NS/tmujYVRAR331ZdED63tuqxnqDyN5RBmaRDeZKcq
 bSJ2+BKONQQ1LeZRP5ktZMYEjET+MaELjmqTCwufFg6hvDk7/onD27ER+yga4xbuOAq5
 zgE8dn0TYvPVDkVq6RLt6nZ00mQWK9EyV90ZFF3U9M3kV7bbF356EveLsRN92SLADL6r
 9o1cjlvxlGRpyX+Ho/36USLgBhT9OpVDEZvWgLtJpGT4Pk+QVjsmI+t1et/l1MDNtMrR
 T4nJJhoTLtguZwZ/DecF9PZgOygWSzwdZcCFH8c2D3ghwGrBzIssD/91Hu+5R+XpagI6
 P0iA==
X-Gm-Message-State: AOJu0Yz+od/VQWDcyWaPeaWrq6xHmuLokABa5aI5CQyIr9HnoaP3fK0I
 Iz+Sk7bYWJvKIoJ7ffSyGyUgvwN0AnpWg6NT04mfzTpNUJPNqrV+WY1X7/lqTfU8chid+Q6Bw2Z
 gYTiKiEFk8ty6zS9rM0qy0mg05MiBjNc=
X-Gm-Gg: AY/fxX672VEiOIzy8IVtCwGYwu1wapOFiYMZCgcrlfDdEPzSWedkiNJGucCQ5D2sKUe
 aPE0R3xR1569sI8hYRpdA0f1XzhUlQwAajPwnEW3SdfzbKJenm6i69Pnm0hMThSgdEewVFbkCgy
 7MwQwIMFA6/i6CutokLZ7f66McNMzgq2ViAvbdR4zfq3K1TleoOz5PMUQcTVxYbsdL2/MkY6vMW
 9T/OffSzk8v1P1bcDE+Ho096AMo0CzJj5E3Jn/njpzkk0s80eAKe1QSspqHJOdMy17gdu3iy80X
 kVIOhXCd2dKILuz7mkcoNtn17Q==
X-Received: by 2002:a17:907:3d92:b0:b87:8c1:1ea8 with SMTP id
 a640c23a62f3a-b8793857ba6mr158463266b.7.1768538648443; Thu, 15 Jan 2026
 20:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
 <20260115130110.2825796-2-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260115130110.2825796-2-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Jan 2026 14:43:42 +1000
X-Gm-Features: AZwV_QjqlNV-rAgiM6TP-aylowCavb8PY3k6nYbBBht_tVg99OMkpL_2pGDBBl8
Message-ID: <CAKmqyKOqtJ+zjY4Opz3iD0b=VsuwKMAvebz6T9fMGa+AL5ZgCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hw/riscv: Fix integer overflow in cm_base
 calculation
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 15, 2026 at 11:01=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Ensure 64-bit arithmetic is used when computing cm_base,
> avoiding potential integer overflow.
>
> Resolves: Coverity CID 1644076
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/cps.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
> index f33fd7ac86..39029bca8f 100644
> --- a/include/hw/riscv/cps.h
> +++ b/include/hw/riscv/cps.h
> @@ -27,7 +27,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
>  /* The global CM base for the boston-aia model. */
>  #define GLOBAL_CM_BASE 0x16100000
>  /* The CM block is 512 KiB. */
> -#define CM_SIZE (1 << 19)
> +#define CM_SIZE (1ULL << 19)
>
>  /*
>   * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
> --
> 2.34.1

