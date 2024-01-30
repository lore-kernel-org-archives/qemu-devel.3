Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EB2C47DB3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcEc-0003nR-U5; Mon, 29 Jan 2024 19:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcES-0003jS-OW; Mon, 29 Jan 2024 19:44:08 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcER-0002aN-3B; Mon, 29 Jan 2024 19:44:08 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-46b1cfd38feso495460137.0; 
 Mon, 29 Jan 2024 16:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706575445; x=1707180245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94jabcGHwtMHKpLXpnpRuzdMZgPpwf3Ll9WdFIs/pI8=;
 b=djZ5chLy8KBIy0yOkgIZXeiN/bN37kHvGZO+zxDxmNllBTk3NEuenLM5D7LAFi9sbb
 czHJ3f1IaLhuIuyDm/up9qlqGyOjUYEAjbyGqA27mjY3R0DZ1IWNzaEiyVJ0cH36aZVA
 TdXrkzPyOq6dgdECDAEDeaCUewimycos+7ux2opgRbZVs7nyKX3gWKfc/JVCc0O5kUNS
 qA2xugiQBX5A1WQUd2UY4zjEsH6dm4WrnE7VId9jl+MPGzP3+JK5T9ITtnYU6H5XF/Na
 6fEUta4rq7oLFhw2K66EL3sMtxqewXGIck7ZJqiFXxy8+M9UqwH84nOZNd70cECFMk14
 Rayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706575445; x=1707180245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94jabcGHwtMHKpLXpnpRuzdMZgPpwf3Ll9WdFIs/pI8=;
 b=Z6TGmvhp5zm1GD3OdS23OdI1oLltLlt8Tw29MCuWf2t/kCMyo9hi9MnhOMF//HEQ/A
 m0x77xMjvPN791tF/nBomCA/dO3zBEAh4tY88Kl9ZkFrBAJCwNHH89UWyk4+ohw1aaoU
 6CTpDil/XcOIo/4U3IVnbeCN/6rw9xcb/TEM+gagMGVd67Eh/3XzjzHkwoxJWNkP1Y+j
 NYKz/vpsvk9OAfU2z+9qDlK+DCYPC4P+YA/Nrw1C5j0JKudOmUs0OQbVaVWh9p0aPrO1
 y66ACQeELidfRhkGH1U6OGRbyxA8laGBjA1C4jTiogv1mriTEiJweEV8z0mM9gFqh7qL
 LltA==
X-Gm-Message-State: AOJu0Yz2a0RwcoR6zmbhIG9VH9u6VcEiotDcOUKAY/hMGd12O0wTIiZ5
 LnspQDaqQqBK9mEeJ/wEPmiZnT1fj6qezZ26eBCsfPABst/EbGH+ieQUcU+miNqTBYTRpwHASqI
 T9FcDm9GZJtn50tzssNc7GKQjyJs=
X-Google-Smtp-Source: AGHT+IE75ECynGQQO4ZCZ/6BlGPPumjYB2xzzme4Zwv5UxujhGRE/pliYK66SK6fGFhPU8me/XW7JiKVdisCBek9j74=
X-Received: by 2002:a67:e9d9:0:b0:46b:213c:af1d with SMTP id
 q25-20020a67e9d9000000b0046b213caf1dmr4444975vso.17.1706575445099; Mon, 29
 Jan 2024 16:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-10-peter.maydell@linaro.org>
In-Reply-To: <20240125163408.1595135-10-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:43:39 +1000
Message-ID: <CAKmqyKNd5ePr0auTp0KhvhVGo8mAf34OW_-f5t=X_1UPRubDzw@mail.gmail.com>
Subject: Re: [PATCH 09/10] riscv: Clean up includes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Fri, Jan 26, 2024 at 2:35=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git riscv target/riscv/*.[ch]
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
>  target/riscv/vector_internals.h | 1 -
>  target/riscv/vector_internals.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_intern=
als.h
> index 8133111e5f6..842765f6c16 100644
> --- a/target/riscv/vector_internals.h
> +++ b/target/riscv/vector_internals.h
> @@ -19,7 +19,6 @@
>  #ifndef TARGET_RISCV_VECTOR_INTERNALS_H
>  #define TARGET_RISCV_VECTOR_INTERNALS_H
>
> -#include "qemu/osdep.h"
>  #include "qemu/bitops.h"
>  #include "cpu.h"
>  #include "tcg/tcg-gvec-desc.h"
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_intern=
als.c
> index 9cf5c17cdea..12f5964fbbe 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -16,6 +16,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#include "qemu/osdep.h"
>  #include "vector_internals.h"
>
>  /* set agnostic elements to 1s */
> --
> 2.34.1
>
>

