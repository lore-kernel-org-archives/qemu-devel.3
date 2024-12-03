Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E058E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMRc-0000Bk-3I; Tue, 03 Dec 2024 01:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMRa-0000B1-IV; Tue, 03 Dec 2024 01:31:34 -0500
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMRZ-0008EX-1z; Tue, 03 Dec 2024 01:31:34 -0500
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4aefdbf8134so1197414137.2; 
 Mon, 02 Dec 2024 22:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733207491; x=1733812291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51e6sQVFtPJq/fpzqreSigR1j2ToG7DiQDj/JiDYmeE=;
 b=Uns72N7K78CRNpCQS6UXlG7lPkvK3ExCErVk/vUOWiggjj8qfeGmPdh27CpSSStJHg
 cn6XY6iHNUbLF+KMcI3loDqUkG9yx+EzQEHh5UGNft9q7h4eK+XaH4ziO2uIR6ZlMip/
 5uM7BWwQ42f7bi95RJaugGkXiY+wslEYGIGtK3PvTfUA+d8DK7LXUV567L5Ehuo9ejRR
 RhxfHo2k+b2XinNHB3H0uw0IdhCCwxLu+8hs5ZAiOvKrbkwraf0hLjSQTYyse6nCniUG
 5NG7usNn48nb5UCBMXqyeUmmIYCorXeZ1CWe9aLsyUGE6ENB7uBliksFaTjeDIacBnFv
 YvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733207491; x=1733812291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51e6sQVFtPJq/fpzqreSigR1j2ToG7DiQDj/JiDYmeE=;
 b=SgYkPS8PQrdmh9RyUn547ms2lJ/dX8P3IztcE9Ps6z8kcxw+STLa2ddJeqoftyYWbG
 1nBu4doUvFxN008VgxLH/CMjBn08GtF3JAG+btJFzy1ReLGpeOZ6/ZdTO8cBa92Kz7hG
 yd8JCCfuQbcll8rOP2eXoz7V8dLLhyAhQjz4QPZ3X1L5RHvPqVGPIILKgEIx1AeLvuxJ
 sqtHIJsgviMhUTQ9vmkwtQCsWWls5thoCVT7h+g3J3+MFc8IgZm6Xe7dXP6MxzXMLtPm
 E4xepcBhcML1rKpLXN3racODhtwLvICQ1obVxHredWYbcX1dm7GCX6SFWTQyMl2FbfFt
 /w6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWefAed4oketnSkktLkG1uEKMpjXdKP+WoUPN1HwGBl7ak+cgFRxoLwCeEwPUZIVq4dEi12SQ9Iv+rB@nongnu.org
X-Gm-Message-State: AOJu0YzNEAzug2L3qrrX8t9lSqNIsvpv6QLn6wL1QZDRw7AO+oq641gu
 v9pQnlIdQa5pZa4+RbR+kjOy1wD0y1IeZoG3jUil72Px7qWziUqV5s7Eecsp+KoVJKkV+eIanuY
 RuC2rtujZBzf6bMCeN6Z9EzGkDUA=
X-Gm-Gg: ASbGncvi1tHemRJcysB/E9Aj4DJcWpyRJS5LzMiJuky6nUxhcs+dI8FYiFW5fE7jWzR
 8ZIb148vG9LTAHbceCjd7BkfwnMd/HWel
X-Google-Smtp-Source: AGHT+IGtaq20FQ+nAGp+2AO8fkuENF7tv8k5U255kXq3on0N5HAQBvZu4Q151Hvz6z1UH6SlbOwvh0XLUudpqfHEEHU=
X-Received: by 2002:a05:6102:a4a:b0:4a3:a014:38aa with SMTP id
 ada2fe7eead31-4af9723815fmr2407407137.11.1733207491294; Mon, 02 Dec 2024
 22:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20241128103831.3452572-1-peter.maydell@linaro.org>
In-Reply-To: <20241128103831.3452572-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 15:31:05 +0900
Message-ID: <CAKmqyKOYjhdp1fNSnqGdhyFJF2Ywhi16q_h3+LaATFuFFqoHpg@mail.gmail.com>
Subject: Re: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
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

On Thu, Nov 28, 2024 at 7:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
> cs->exception as a shift value.  However this value can be larger
> than 31, which means that "1 << cause" is undefined behaviour,
> because we do the shift on an 'int' type.
>
> This causes the undefined behaviour sanitizer to complain
> on one of the check-tcg tests:
>
> $ UBSAN_OPTIONS=3Dprint_stacktrace=3D1:abort_on_error=3D1:halt_on_error=
=3D1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -=
device loader,file=3Dbuild/clang/tests/tcg/riscv64-softmmu/issue1060
> ../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63=
 is too large for 32-bit type 'int'
>     #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu=
-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
>     #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-f=
rom-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9
>
> In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.
>
> Use 1ULL instead to ensure that the shift is in range.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69eab..45806f5ab0f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1802,10 +1802,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      bool async =3D !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
>      target_ulong cause =3D cs->exception_index & RISCV_EXCP_INT_MASK;
>      uint64_t deleg =3D async ? env->mideleg : env->medeleg;
> -    bool s_injected =3D env->mvip & (1 << cause) & env->mvien &&
> -        !(env->mip & (1 << cause));
> -    bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
> -        !(env->mip & (1 << cause));
> +    bool s_injected =3D env->mvip & (1ULL << cause) & env->mvien &&
> +        !(env->mip & (1ULL << cause));
> +    bool vs_injected =3D env->hvip & (1ULL << cause) & env->hvien &&
> +        !(env->mip & (1ULL << cause));
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
> --
> 2.34.1
>
>

