Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317B8D1CA0E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 02:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t89SP-0006E4-0B; Mon, 04 Nov 2024 21:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t89SN-0006Dq-O7; Mon, 04 Nov 2024 21:38:11 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t89SL-0003Ay-RF; Mon, 04 Nov 2024 21:38:11 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-855eeff6448so1194281241.0; 
 Mon, 04 Nov 2024 18:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730774288; x=1731379088; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AgKkBAYEllDHZ4fEdXNHHFGNktGlV7Q4fIKqD1YtRs=;
 b=k38cxPBq84zhzqPhgqfZp19H2H3n3cmvtd41+cbvEfRqZx5I/HIi1oxse02cTulkA3
 o8YyJrEVPfYmZ2GRfPyJbVzbQ7w8OTVMgZSnqMkAialHUEzD4Txnm7101xBHDitc6VZR
 Y4vgwE4wMKC3WlUmoKiAZ/G/UfwmDu8FiQROqN6O3cJFV0agdtlj3wyCt/DTZ/3kvFJy
 E8LAZahy4gnc8DOsWPiPl2JnSfSD+9r310faKrXYVmdzqMgHz+eAJk60+zguTlcYZaqg
 ex+QAFRVB+Zpfs5by2xzxSZOfmquvEm6XiAhtI1wyLkAbA8u+gOuLp5CyUxBwOIz8sRM
 LZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730774288; x=1731379088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AgKkBAYEllDHZ4fEdXNHHFGNktGlV7Q4fIKqD1YtRs=;
 b=ra+bDZjUTNgxn97eHJ9ar+SoU5N6bGCSHgjF9e3G4yJuW99PIlojdfntLZ7X4ySme5
 YUTBBmWPI7HN+T4vgCSv3luVhqP1q0t5e3wGGgJZz3w1vxNAenWjgPW8qrD2NV68o9Y7
 MU0HvuzurfzvjJO7+Pa+BBdYEr5GnpiL2unDD7/fdozeEAls6xRySX0urfPhz9mAFOVp
 yvGa+x1olf0FKuA4kI4dIwrrcZLv7sDOI6GMUsPJKXrcIqmQ/PhmS2uYzHMcjmeqDjRp
 JKhtXSwIBkUqnTDUvLPetuq0EI8T+QEiayt+KimQrf8xlBp5E3MAfqruhtZqpdEOFhIg
 wIYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVf2XwQmb/vLp66atlxa48ES7uXxh7k1qxfCn3s4E8UL1CuFDTgJMEQT4q8F4hGIE0eXAqRXLFV5Aw@nongnu.org
X-Gm-Message-State: AOJu0YwsOZhsfYNHy7Ky+toS1LlK6DEo4mKbZvU2/SXYnpNSYxHpblVF
 Ye9EkPBcyLykg+eUcQ7Ltr5FXBE7JV5zu3Vo/mE+yTCMCSYjj/9OU62eK/qhbZnTaWWyjhShhHi
 HEKocoYIMW278T7tVvp94fQKTwtQ=
X-Google-Smtp-Source: AGHT+IHsGazR7xi0Xlxf6yoQag0WzQRTnOdzCzqDse+eOtB3ojHPuay7Y7UtQniFrjkncIG6lUgGiNsTit29erL/htU=
X-Received: by 2002:a05:6102:440e:b0:4a3:a014:38aa with SMTP id
 ada2fe7eead31-4a962de10b0mr12463029137.11.1730774288350; Mon, 04 Nov 2024
 18:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20241104222225.1523751-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20241104222225.1523751-1-pierrick.bouvier@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 12:37:42 +1000
Message-ID: <CAKmqyKN+mYMRqA7=Tb+-qNr_b7TQ8rapaB_YDPqjgKWAggeygA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: fix build error with clang
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>, 
 Bin Meng <bmeng.cn@gmail.com>, tjeznach@rivosinc.com, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, pbonzini@redhat.com, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, peter.maydell@linaro.org, 
 Cameron Esfahani <dirty@apple.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Tue, Nov 5, 2024 at 8:23=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>
> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>
>   187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>
>       |                 ^
>
> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: =
previous definition is here
>
>   217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>
>       | ^
>
> After a conversation on the mailing list, it was decided to rename and
> add a comment for this function.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index feb650549ac..12f01a75f5d 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -183,8 +183,25 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>      }
>  }
>
> -/* Portable implementation of pext_u64, bit-mask extraction. */
> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
> +/*
> + * Discards all bits from 'val' whose matching bits in the same
> + * positions in the mask 'ext' are zeros, and packs the remaining
> + * bits from 'val' contiguously at the least-significant end of the
> + * result, keeping the same bit order as 'val' and filling any
> + * other bits at the most-significant end of the result with zeros.
> + *
> + * For example, for the following 'val' and 'ext', the return 'ret'
> + * will be:
> + *
> + * val =3D a b c d e f g h
> + * ext =3D 1 0 1 0 0 1 1 0
> + * ret =3D 0 0 0 0 a c f g
> + *
> + * This function, taken from the riscv-iommu 1.0 spec, section 2.3.3
> + * "Process to translate addresses of MSIs", is similar to bit manip
> + * function PEXT (Parallel bits extract) from x86.
> + */
> +static uint64_t riscv_iommu_pext_u64(uint64_t val, uint64_t ext)
>  {
>      uint64_t ret =3D 0;
>      uint64_t rot =3D 1;
> @@ -528,7 +545,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUSt=
ate *s,
>      int cause;
>
>      /* Interrupt File Number */
> -    intn =3D _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
> +    intn =3D riscv_iommu_pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>      if (intn >=3D 256) {
>          /* Interrupt file number out of range */
>          res =3D MEMTX_ACCESS_ERROR;
> --
> 2.39.5
>
>

