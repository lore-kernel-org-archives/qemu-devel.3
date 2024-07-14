Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC55C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 23:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT8FT-0006Se-Bu; Sun, 14 Jul 2024 19:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT8FN-0006Rg-Rh; Sun, 14 Jul 2024 19:03:15 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT8FL-0004CG-Or; Sun, 14 Jul 2024 19:03:13 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-48ffd139a9cso1335738137.0; 
 Sun, 14 Jul 2024 16:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720998190; x=1721602990; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfS3jlahVyofZxw3UoCF8Zk5oM7UNlHv1X4r4bTqaIQ=;
 b=Xh/uIH2RfhuuhA/pN46CefQ255G6zL8WzJN+C+5LCEjDJFABmwjRWu8ngKn5PG9ynj
 1Vg7oA13u/Y1wzzSoB6xa7lFYpnEy7hQU0vjS8SxQMFFgnE8DW19XJ4PNDP2gFXQSooU
 /qHllEqtYKYvBL5QQlAcxyTdG6BA6dSxxMk/OpVAJOlmfI7Y/fNGDw9pdH1kIa891ugS
 DiSHY4doQzNaLmAmOiA3gmVHNlcs7YezcBV2UrInNc48/RlYnR977+HhO0srUlp3oO8/
 X6Dw67P7kAMjFg4KNPQ31s1NLoCnX+7IZlO35skT1e26lBeSQck9JzFjfC5PW5QFiDWY
 AALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720998190; x=1721602990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfS3jlahVyofZxw3UoCF8Zk5oM7UNlHv1X4r4bTqaIQ=;
 b=RcwO1knCZswno30xn4SDOZDQ+ZikUiT38ctqXImUOD5ODoXOENTs0VyNxAHQFTZhbb
 8Odt3PSXKSGVKdmesiHE/YExTppX8aNrPCGtF3TFfpTn5+8KUOawMUx3KsN+UF3+4tZj
 r8PwBkdwUUvBcmUseCRC7eKBiFJNZoF3IvpHQpmLFn6dCXKw2gUbWQE7+ejEaN5oTSek
 W6N5/GgO8++mpUdhB5qY0bzT/jZMrLkgUaXxYBj9HWCGYiuImOIxO6WQRV8TTF4VHun/
 O4L6GHHGLs1fX826ZEWAzI8FCntwqiEIIXo/cFWPBxjM2DqOVrR+8+QX5NLs70QFXQ1j
 XHMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxFzynxfKJKKvGvOcvCcLmU0mldDeHKUkZUtHmoCssh32WleGSd7gFQkVfkPz/4iz1oqI6idIXZ8GdAPDt8aTNIxYYWgA=
X-Gm-Message-State: AOJu0YwXEzP9nK530uk6i8aBQl95izMRRSQJRQpdimOyHg3nrGoO35V5
 bt2dz3k+CWd/Ud/R2RKRVKYcvtYkaxqGfEBnqjATMTjy/5z4mYJH4Xdlu/CntE3vwbdZAaXqkac
 nVGa2rJBEIbXoJAQ6lLb7nXwHkdY=
X-Google-Smtp-Source: AGHT+IGSwZ0oK3rWXsm/cFVjMszM+IL9fgxc3Xt7zmv6NQ67Kiz9BBPpM613LBSrmiRmPcc3F94jaA6O1LnOEBeI4KE=
X-Received: by 2002:a05:6102:3593:b0:48f:6009:a924 with SMTP id
 ada2fe7eead31-49032153f59mr22670583137.17.1720998189749; Sun, 14 Jul 2024
 16:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240713174325.107685-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240713174325.107685-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jul 2024 09:02:43 +1000
Message-ID: <CAKmqyKOCSvX-wB4RrPmaUxZ3Dve34ZQHhay9iwb2Q=je1L3kvQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt.c: re-insert and deprecate 'riscv, delegate'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Conor Dooley <conor@kernel.org>, 
 Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Sun, Jul 14, 2024 at 3:44=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit b1f1e9dcfa renamed 'riscv,delegate' to 'riscv,delegation' since
> it is the correct name as per dt-bindings, and the absence of the
> correct name will result in validation fails when dumping the dtb and
> using dt-validate.
>
> But this change has a side-effect: every other firmware available that
> is AIA capable is using 'riscv,delegate', and it will fault/misbehave if
> this property isn't present. The property was added back in QEMU 7.0,
> meaning we have 2 years of firmware development using the wrong
> property.
>
> Re-introducing 'riscv,delegate' while keeping 'riscv,delegation' will
> make current firmwares to keep booting with the 'virt' machine and
> dt-validate won't complain about it since we're still using the expected
> property 'riscv,delegation'. 'riscv,delegate' is then marked for future
> deprecation and its use is being discouraged.
>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Fixes: b1f1e9dcfa ("hw/riscv/virt.c: aplic DT: rename prop to 'riscv, del=
egation'")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/about/deprecated.rst | 11 +++++++++++
>  hw/riscv/virt.c           |  9 +++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 20b7a17cf0..88f0f03786 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -479,6 +479,17 @@ versions, aliases will point to newer CPU model vers=
ions
>  depending on the machine type, so management software must
>  resolve CPU model aliases before starting a virtual machine.
>
> +RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> +the AIA APLIC support.  The property changed name during the review
> +process in Linux and the correct name ended up being
> +"riscv,delegation".  Changing the DT property name will break all
> +available firmwares that are using the current (wrong) name.  The
> +property is kept as is in 9.1, together with "riscv,delegation", to
> +give more time for firmware developers to change their code.
> +
>  Migration
>  ---------
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bc0893e087..9981e0f6c9 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -651,6 +651,15 @@ static void create_fdt_one_aplic(RISCVVirtState *s, =
int socket,
>          qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
>                                 aplic_child_phandle, 0x1,
>                                 VIRT_IRQCHIP_NUM_SOURCES);
> +        /*
> +         * DEPRECATED_9.1: Compat property kept temporarily
> +         * to allow old firmwares to work with AIA. Do *not*
> +         * use 'riscv,delegate' in new code: use
> +         * 'riscv,delegation' instead.
> +         */
> +        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> +                               aplic_child_phandle, 0x1,
> +                               VIRT_IRQCHIP_NUM_SOURCES);
>      }
>
>      riscv_socket_fdt_write_id(ms, aplic_name, socket);
> --
> 2.45.2
>
>

