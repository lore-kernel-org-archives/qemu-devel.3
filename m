Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BB3C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 04:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4uTI-0003ex-B9; Wed, 16 Apr 2025 00:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u4uTD-0003eY-Df; Wed, 16 Apr 2025 00:33:56 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u4uTB-0004tq-Fq; Wed, 16 Apr 2025 00:33:55 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5242f137a1eso2509078e0c.1; 
 Tue, 15 Apr 2025 21:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744778031; x=1745382831; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLKUQy5gYABgjaBL4u4hjmZvkq+rI+6O1nGmkPD98LM=;
 b=DQRNjlOI7Xfr1FXgGGwp/Qc1VcUVyhP/PvwOYd6pZKiJ31jjHAeV4YJ0ShU7755kYF
 ngTr4BwwhoS10XlUl6QRD+VFjXKcIJFnDw45jMGJGwSawN9MNQIUnQlsnRfRpFp1EhVf
 wP2ziH3AGMJkAtMkepndc/BSnz8v0PkvkMbA9g6/vTMch4ekDPHmFZiMrQ3vHOQy/LKm
 GUz7PvwHjwiYvO+KSMoU3jUxKN/pH9dSCo33wf8EaMoV/qw+xR62QrZzjQSr/Y7kXF1l
 uvB3kXLya7aaFwUfltgj6bt38uZGKgRJZJDkp9rVtC7eyFjZKyWC72BUDdODrPy5HTHu
 vR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744778031; x=1745382831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLKUQy5gYABgjaBL4u4hjmZvkq+rI+6O1nGmkPD98LM=;
 b=lKxf2BOhP8B0rdzEaLkV5DOxmeM8YIT1hmildrkUKQ62jRoFpQ9YQsGTREF0tdqzb+
 va1gT2i5blxnmT35Uq7xtQf6fWmA//uJ7PmludZ+wTKFZjdhIdcsJmV8lRkIleC+xnye
 HEsAdBMf61R2S1D/KYZXkvBD6nhelj3ciGTH7BdJkvM8mvoOrWoMEBvdoqqGE9qU3I4M
 FxF7f+V9N3151kXlZVFvXmOpIjoXtjXDHIkN4rafIbNzZKDVOLxwMC3jmPW11njr7sMa
 SnDV/N1SFOvSjME9lVM1g115yVa9jBl1YIvYTiP2U0SV1RdTVbSgVJ2QjsIlQRYTYb2p
 snNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyOP1F8+lOZBo7xO9own6jcocelEqovC4g7QmtHitZyuHM2Qus/u7bxAiWg17tNWsm1YF3r0Y07aiB8l8=@nongnu.org
X-Gm-Message-State: AOJu0YyY8A56+mBySARd6wbaZTMUF8nRy9i66bpDNRwJEXQ8UTasQqBU
 UzCrkCn+TGpO0lzRKEMAYel76rYnDWbLwR7Ogarog6fsxGwP4XxBUvRT1fxzJ2Ui0nzt7zStKoO
 oEWiFfBSUJKsefbyBOLM+3+U2ATQ=
X-Gm-Gg: ASbGncvIMBvI5TZMWzJMrOpsnbORhlp/WfpxIezKSiogRidnMs9m0YwvXDT/HfpJulw
 BzTDd+nbEQZyEt+JTy1U/g52A5fVO82G7cL4Vb4+eW/J2D+P7GRywpli+JVUL9W/9IXlABo8Skg
 tCSZmCVfDEyn8F+huM55W2gCREZETbMCOLnufYFc9tRiRAjVeBj8vcbnVhaOlA5kI=
X-Google-Smtp-Source: AGHT+IE/dY+bxQnCNah1uLfNqkpzxP9++maw29Xbx/usraZBNU7jquMrzOxGv1X/8orzPQ7naMIL8p0BoYLqAxRIhBY=
X-Received: by 2002:a05:6102:53cc:b0:4c1:86bc:f959 with SMTP id
 ada2fe7eead31-4cb591e0f5bmr69533137.8.1744778031522; Tue, 15 Apr 2025
 21:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250415080254.3667878-1-ziqiaokong@gmail.com>
 <20250415080254.3667878-2-ziqiaokong@gmail.com>
In-Reply-To: <20250415080254.3667878-2-ziqiaokong@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Apr 2025 14:33:25 +1000
X-Gm-Features: ATxdqUHQNpityw54OZ5D6s0DwH98W5i1bCXjjWqUDto6QZgf_5_1uAD856GwlXo
Message-ID: <CAKmqyKOyBb9wkkvjeVg76Qs+c-D4R13hJuQKQa2RRnw5rP3ZJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: Ziqiao Kong <ziqiaokong@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair.francis@wdc.com, 
 richard.henderson@linaro.org, philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Tue, Apr 15, 2025 at 6:06=E2=80=AFPM Ziqiao Kong <ziqiaokong@gmail.com> =
wrote:
>
> On big endian systems, pte and updated_pte hold big endian host data
> while pte_pa points to little endian target data. This means the branch
> at cpu_helper.c:1669 will be always satisfied and restart translation,
> causing an endless translation loop.
>
> The correctness of this patch can be deduced by:
>
> old_pte will hold value either from cpu_to_le32/64(pte) or
> cpu_to_le32/64(updated_pte), both of wich is litte endian. After that,
> an in-place conversion by le32/64_to_cpu(old_pte) ensures that old_pte
> now is in native endian, same with pte. Therefore, the endianness of the
> both side of if (old_pte !=3D pte) is correct.
>
> Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6c4391d96b..3233b66e7e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1662,9 +1662,11 @@ static int get_physical_address(CPURISCVState *env=
, hwaddr *physical,
>              target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_block, add=
r1);
>              target_ulong old_pte;
>              if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> -                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, pte, upd=
ated_pte);
> +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_l=
e32(pte), cpu_to_le32(updated_pte));
> +                old_pte =3D le32_to_cpu(old_pte);
>              } else {
> -                old_pte =3D qatomic_cmpxchg(pte_pa, pte, updated_pte);
> +                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cp=
u_to_le64(updated_pte));
> +                old_pte =3D le64_to_cpu(old_pte);
>              }
>              if (old_pte !=3D pte) {
>                  goto restart;
> --
> 2.34.1
>
>

