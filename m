Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835FDCE7AA5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 00:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smNEn-0000VX-Gz; Thu, 05 Sep 2024 20:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smNEl-0000Uv-B7
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 20:54:07 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smNEj-0004zL-SZ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 20:54:07 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-49bc12c0041so434863137.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725584045; x=1726188845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49Zg6FvFBKo79DgdZMAEW5DBhmhmQC1e8TeNDvi778U=;
 b=dMZSVZZHREIZUMh2os7tQuoIkUdpzjNn1RcbQRpFh3qRWFeSmxbDj9I/ba+M7df9WM
 eq+dwEF26Ii4fH96ZAlNjEio+GX83UD+otKpE19QmqpzCI/Ay7OiCJ5RhC/gglYNd2W8
 7PoCq17EdOJkYqeWln0PhN7s+17vzHfsHGDrus2tHn/3XOxaH7PNhtQIwZPYonauNAaD
 Z4hkSSg32ODRXb3D+72eVGwHJNnaId8PAj3ycRXIcUmG73f59KPq5yyezhIDHHuW7lHW
 yr26euZ/BtQ8GYIAM04jFQtRq6j731OCnz5hbk3+zarVT3OMicM6kcncyM7XCsMZyz+l
 M9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725584045; x=1726188845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49Zg6FvFBKo79DgdZMAEW5DBhmhmQC1e8TeNDvi778U=;
 b=SvFX1hBij1pDt2HjPOOl1ql4hW/YTkveJP3RsRkliZp4vou7VQzUe3lAGCQFoMbj5P
 ew+A6KRO+srQ6xJonYzbcNa56JpLRbGElx6BbfYl+FgHM5w5QWNP6lgardNkw6kOhECE
 Q4az9j+3CjD4xVTyUrIj3K68OhUz1+SumORjHeW1qftKnWJPAeXDN9Vk+rgVKBLjxy0f
 bmY7+YIY1Fvg0cgMOI9TKZkCCSMbff0+mhqGjb73GqWc61/OkGcrKikz8SoauGzlMku/
 ZRRbtsrki1VrD/4sfBaYt2LlOyPEu09DigQzrKQxLnzTrB0+qNxXV/441nQ81R5XbjR1
 RMdA==
X-Gm-Message-State: AOJu0Yzepr1Ya+CSBi6kiQeycGI6xV+p6g5bZ2+7UagqjkezN15LS6Xc
 bRemu5VpChX0g6XxfdyiU7OveCG5vTcDRyz+0qN2aWI1P/CCXHcVy9TLyjurXIrDlcksaWeyh+E
 cqrJXzKISSGBCkGc3jsmjdQVxqzUmZ2x8
X-Google-Smtp-Source: AGHT+IFT206v7zPmm6aYdoxtNz47Q1uk+MyJTHZRvMSu5B6lgFriiJSDnR8ptHXK8O/pNHpwAU2maG9xEk3ilQjUX9w=
X-Received: by 2002:a05:6102:419f:b0:498:d3b7:be37 with SMTP id
 ada2fe7eead31-49bde1469admr1150011137.3.1725584044521; Thu, 05 Sep 2024
 17:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240905150702.2484-1-mps@arvanta.net>
In-Reply-To: <20240905150702.2484-1-mps@arvanta.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 10:53:38 +1000
Message-ID: <CAKmqyKOrac9v9Zg3i87N24eg6AmHGTUfRnU9DjUNFYfp+pn0ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] util/util/cpuinfo-riscv.c: fix riscv64 build on
 musl libc
To: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Fri, Sep 6, 2024 at 1:08=E2=80=AFAM Milan P. Stani=C4=87 <mps@arvanta.ne=
t> wrote:
>
> build fails on musl libc (alpine linux) with this error:
>
> ../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
> ../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (fi=
rst use in this function); did you mean 'riscv_hwprobe'?
>    63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) =3D=
=3D 0
>       |                     ^~~~~~~~~~~~~~~~~~
>       |                     riscv_hwprobe
> ../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is report=
ed only once for each function it appears in
> ninja: subcommand failed
>
> add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build
>
> Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  util/cpuinfo-riscv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> index 497ce12680..8cacc67645 100644
> --- a/util/cpuinfo-riscv.c
> +++ b/util/cpuinfo-riscv.c
> @@ -9,6 +9,7 @@
>  #ifdef CONFIG_ASM_HWPROBE_H
>  #include <asm/hwprobe.h>
>  #include <sys/syscall.h>
> +#include <asm/unistd.h>
>  #endif
>
>  unsigned cpuinfo;
> --
> 2.46.0
>
>

