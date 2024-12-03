Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F69E64A93
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tISv9-0003DN-Eg; Tue, 03 Dec 2024 08:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tISv6-0003Cw-Qx; Tue, 03 Dec 2024 08:26:29 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tISv5-00082e-9z; Tue, 03 Dec 2024 08:26:28 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4afa53874beso19217137.3; 
 Tue, 03 Dec 2024 05:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733232386; x=1733837186; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q87dO8RRG7w5S/b1b8HX20PymG1OnRpkoYVv5xlmZhI=;
 b=cmQ3dJmxAp9jgNZQR1a1Rbz9WAT2C3foF+Bsn7E7xtAvLMYUVShZwdLO+JGBOPqeMP
 +6rn38OyoahP7HFYEU9kEeL7Qi3AWNNkVGC3wgyuzYNUFxxawrduSuvmnEBAocKd+QjF
 ti7m7GFQil4hxyJrE3HsPk4vKEjSkP7UDYqSkPq0W6YssRdDPbqYYQEFsE7fyL4S9HIV
 zdsim8Li5wMLkgSJlwjOLuQWfliKL89pqc8g1d4vek9atywfDHs59pZ46NoaCJrYylSq
 1G5+3ihrYF34AS+jKKP96aSgEoXsrLTmf7SxKUFG8iB+AXEb3F5h8F2l4l1qo6okXyfL
 pRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733232386; x=1733837186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q87dO8RRG7w5S/b1b8HX20PymG1OnRpkoYVv5xlmZhI=;
 b=aJpbeTd5/ut+DJYfEtDqyla8BFELHPD3bUxh8ZRk3jvb7hY6y14EhVNIEa3aMFZkBb
 nRg9Zw0qQJdRZ/9S0R/SvQ0QkL5S0xH33exQEtSqtd2+CONfNl5AyMs39R87azLfO2ck
 jsp7erPEIkADVk1qPHDTsyeou0hSv0X8rTurJ0ni41jWWzZ5VlvQtwvYX/0/RabZV7xg
 dl3vu6iMp8Kmnb5QGvobJ/6k1uqZqF/8sBtKhYG1HQ1Eu+UfZcA3X6A5epud54PomvGr
 xvba0zvUSrS5SgxKqF/PTmdzpaDumDP/LRLG2NHzvzhyfCYV83ouROvO3/Z1T68FDXD2
 Z/fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOiJKVhU6MWE29wsTKRHNtEMZsZO58hxfQw40htzYSiEzIbjRfEgr9xZ0MfnwvNQhneJnQyv1jl0da/A==@nongnu.org
X-Gm-Message-State: AOJu0YyC6t3XQ4TOwNiUYm1ShkA3rYGWXBNoxLsxjsPW9mSg7GkzmnXD
 SrLS78Svbdbz2ahFksUiGwO7HIi8eYpboHxiA/CzdbMUV5H3DyDjr+6+vhGPuFlThLinvE/l0n5
 C+QPRtRf7/dPH/FD8VhB6NYQhQ4A=
X-Gm-Gg: ASbGnctY4f3JauYxTvQI/WtgfFGy/6VoDzSbZgq+leqvy425Gs255vLLKjNBupBdKsX
 9icX4uOSk9Q8nqsbipGaHb9xV9I/xQxlx
X-Google-Smtp-Source: AGHT+IHYCnFTF4S/85zmeh8MkFtgsWIgVpwRwFYya+PZkKzwdD9VDRDSQxKsvCxdSpy2yUhM+anR4oqaBDfDyDnYPcU=
X-Received: by 2002:a05:6122:4382:b0:50c:55f4:b529 with SMTP id
 71dfb90a1353d-515bf525a49mr3690065e0c.8.1733232385735; Tue, 03 Dec 2024
 05:26:25 -0800 (PST)
MIME-Version: 1.0
References: <20241203113140.63513-1-philmd@linaro.org>
 <20241203113140.63513-9-philmd@linaro.org>
In-Reply-To: <20241203113140.63513-9-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 22:25:59 +0900
Message-ID: <CAKmqyKPAVbh_3OXwtvax9MwNZXYvfNCuCu7jH6oCFjjdwzL9Fw@mail.gmail.com>
Subject: Re: [PULL 08/13] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Tue, Dec 3, 2024 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> From: Peter Maydell <peter.maydell@linaro.org>
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
> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ fi=
ltering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ f=
iltering support.")
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20241128103831.3452572-1-peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks! I was just about to prep this, thanks for beating me to it :)

qemu-stable@nongnu.org this should be backported where it applies

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
> 2.45.2
>
>

