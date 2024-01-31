Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B8EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 23:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVKFa-00033y-Gx; Wed, 31 Jan 2024 18:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKFY-00033j-Kc; Wed, 31 Jan 2024 18:44:12 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVKFW-00080T-1U; Wed, 31 Jan 2024 18:44:11 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4bd84b96feeso151034e0c.1; 
 Wed, 31 Jan 2024 15:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706744648; x=1707349448; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jezQDAOCtIA5TmKzFts6SW82UAeX4TlzZL8oQ9OuP7w=;
 b=c6+vuPSv1I4LZCWP9rV1iKeht8bfp91XvhU7QzL1XkRHuI7WjozK5b3iIdnlUmyWqY
 jZPgGRlNkziW7CwcViq16GRpM5YWnE2B/pol+/clZtknacBiO+wOQvqdBbPuD9TXElW+
 CxezwQfG5N63OOpT/BK4zql0YSZ3HW2rU3LSRza1X3q8CNCwNH9PSkYhBBloSfM4Bv5u
 KHTR4LKL7+triC9iKU6cQ9vR2THYo5zdil+6IBgGlGLQEC9LRVuvF4eIrYLxSAcSl8TZ
 0jXOf4vFrOhtO+1BfpLkouMNV8Eg5EtdcUzJOJUeAscplJV+khaDwwQotOuF4c0r+CYJ
 bzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706744648; x=1707349448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jezQDAOCtIA5TmKzFts6SW82UAeX4TlzZL8oQ9OuP7w=;
 b=Qvz5PUIhnNpP+RHnkE/Xm+6ORRzPdT7TOwj/rpQjMuveVl8fpq4t4HVvTCaTknWH6L
 4qxrPxROAK77qfIcKMkujskEeE1Hc1mIS8FUutrPQ5OZXklgxoFULUULLRALKXHn3qHn
 1FIFXnqVaazG0eiWYud20GhowuGo/uxhMhF97werdeSCKox6clGwS6EL2zjs3KSPFKiK
 z1ce9L+svQuh0St8t01xcsqnqzmy+H1h+8M1V9/ozIxi9Q1g/Z4uaGutR+pc3KPvcCr4
 YyO78znIkO9WfuXdl3X5h/FNnIdY8BlYuaOkB8+ET1mRPDAtsy5sDeYm9Z+u3zNn5hho
 VqlQ==
X-Gm-Message-State: AOJu0YxJmhRZhvOD0gs1KUpL7WF0Cj+6ZMpRE5ZwAiVqkbIm3U4nN4k0
 SdKilDm2FGLwImKQEN3Rf8ldN96C2Rpn8W4iWOruoF9axZ3wXQi+MeUdrPqvrx8jxamqoNty4Vb
 dcEBV9y59zx5htF/MgOHQzicJgPE=
X-Google-Smtp-Source: AGHT+IHtCdSCZBbHFJTmDNK9FB0RFtLXPFh1OgGrYaMTKcE2gzX+pfBykKSDjbv+Y1pUVueqq2G9bUlOtGhUccXh0UU=
X-Received: by 2002:ac5:cc58:0:b0:4bd:4ae3:dfce with SMTP id
 l24-20020ac5cc58000000b004bd4ae3dfcemr2867299vkm.0.1706744648101; Wed, 31 Jan
 2024 15:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-4-peter.maydell@linaro.org>
In-Reply-To: <20240125163408.1595135-4-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 Feb 2024 09:43:41 +1000
Message-ID: <CAKmqyKNhLyA=WR3sH0J9x+2kDcM8KjVajcRoBSA6nUV7X3dBeg@mail.gmail.com>
Subject: Re: [PATCH 03/10] disas/riscv: Clean up includes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 26, 2024 at 4:04=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git disas/riscv disas/riscv*[ch]
>
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
>
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>   it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>   Drop these, too.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.h          | 1 -
>  disas/riscv-xthead.c   | 1 +
>  disas/riscv-xventana.c | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 19e5ed2ce63..16a08e4895c 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -7,7 +7,6 @@
>  #ifndef DISAS_RISCV_H
>  #define DISAS_RISCV_H
>
> -#include "qemu/osdep.h"
>  #include "target/riscv/cpu_cfg.h"
>
>  /* types */
> diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
> index 99da679d16c..fcca326d1c3 100644
> --- a/disas/riscv-xthead.c
> +++ b/disas/riscv-xthead.c
> @@ -4,6 +4,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> +#include "qemu/osdep.h"
>  #include "disas/riscv.h"
>  #include "disas/riscv-xthead.h"
>
> diff --git a/disas/riscv-xventana.c b/disas/riscv-xventana.c
> index a0224d1fb31..cd694f15f32 100644
> --- a/disas/riscv-xventana.c
> +++ b/disas/riscv-xventana.c
> @@ -4,6 +4,7 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>
> +#include "qemu/osdep.h"
>  #include "disas/riscv.h"
>  #include "disas/riscv-xventana.h"
>
> --
> 2.34.1
>
>

