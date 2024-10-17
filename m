Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B43D2F7E9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 04:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1HhF-0002tp-6A; Thu, 17 Oct 2024 00:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1HhC-0002tG-IY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 00:01:06 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t1Hh9-00018r-8D
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 00:01:04 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4a46d5aa949so145064137.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 21:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729137662; x=1729742462; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUMJVK+MIxRjz9bLb6xfDY69or/FSIuVzMjlqQpgsro=;
 b=BsjkghI5VtlxUsRc6MVBnWpQSQOn7kHu4wUiTjGJvF1WL53paSONl/HsHUd5Gq78GG
 5pefOg//lUR0SMDP+bcOWIS2C/7MQlW70etFyuG9oLWOBNxy3kkyVHD100t1UoZ/YK6Y
 5y+H60gN9cnqICj16AzIVr+TcrOaAkVuoFu8HxgRmnZWIFFThmKWWIVptTpVzx51/G5L
 /1wOG2aYStHKC/00DN+Fgla9o5ChTpbK3ZKpHvMmhvN9mZislIj+TEGz1horLPpXaky7
 PFw9Keo8TvSkdLNijyczm7os0Xln2VZ+oHf2xU6pzfAh5vH46AdlKUfuoqjWC96gFJOm
 UviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729137662; x=1729742462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUMJVK+MIxRjz9bLb6xfDY69or/FSIuVzMjlqQpgsro=;
 b=eVf5NxigRwRik+LbaRwUIO/NxaAey6xSaVg4DupWziIMJrLC8eqAiKKlEvcm7QtWCW
 05xfmZgl/z07Fvbmj+C5tPlY3eyBM+Skr9hnz8ds6j0oZpe0xFaV/zOxtFq1PJFbn5X/
 teJTmQMWoGZeI2/MJmtP+cwwV9oZ74FhSCrCK8jSm8hwThLmZ2my6AKaR15+jX2MYknq
 hMhJk7b+Z4R+6+aovZV1zbEPb62V8Wx0Gq/NQCDhJO9CV3QquXHtcudz6jpmgK+7Abo6
 ml0UJSLatEM6WuqPzXHYG4npcWhwjXZnpsn7aj4/Tfd6dumtrHUwgOPWM9pCW9v2uTw7
 r6nA==
X-Gm-Message-State: AOJu0Yy3wLjRKM1yM1KDnycH4OApfegXlvDij1wtLWRISZL3A2JTcTNY
 JUDe1MOduOfDW3GYArXNYNvGxJR42HZgFdsGDLURyI4ihZ8i4akSuq+k9Nk11XYUhu+dUb2j7wT
 o80eTTlquMbQurqhMKY6Pt79Tk6s=
X-Google-Smtp-Source: AGHT+IEOFp6MkCsLxJRLUsAYJNphG+aH6AmducQj1QvJn8wkO2GVMrA/HInIoad2pnT4eivLzh0jZu+TukSsv+Z3Ndo=
X-Received: by 2002:a05:6102:548d:b0:4a4:935b:590b with SMTP id
 ada2fe7eead31-4a5b59977e9mr5451381137.14.1729137662017; Wed, 16 Oct 2024
 21:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241016163439.1130168-1-htafreit@gmail.com>
In-Reply-To: <20241016163439.1130168-1-htafreit@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 17 Oct 2024 14:00:35 +1000
Message-ID: <CAKmqyKPUUgF1tLKCFF1FiT5HHEDDDg+=Yha2e38wSto4mKh_BA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Insert LibSPDM in QEMU enabling in-tree compilation
To: htafr <htafreit@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
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

On Thu, Oct 17, 2024 at 2:35=E2=80=AFAM htafr <htafreit@gmail.com> wrote:
>
> (I) Summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> This patch is the beginning of the support of the Security Protocol and
> Data Model (SPDM). There are some known issues (see II), but it's
> usable and not many users are going to use this functionality for now,
> but for those who will it may facilitate the development.
>
> There are some people working with LibSPDM to implement the SPDM on
> emulated devices, however current works that use QEMU compile LibSPDM
> out-of-tree [1][2][3]. This patch enables the compilation of LibSPDM when
> user pass the parameter '--enable-libspdm' to configure file, this option
> is disabled by default. The following parameters were also added:
>
>   --libspdm-crypto=3DCHOICE  set LibSPDM crypto algorithm [mbedtls] (choi=
ces:
>                            mbedtls/openssl)
>   --libspdm-toolchain=3DVALUE
>                            toolchain to use for LibSPDM compilation [GCC]
>
> In order to facilitate future code development using LibSPDM API, this
> patch also provides the definition of the macro 'CONFIG_LIBSPDM'.

We have talked about this before, see
https://patchew.org/QEMU/cover.1691509717.git.alistair.francis@wdc.com/

The general agreement seemed to be that it will be hard to do SPDM
configuration inside QEMU, hence the external library (like the QEMU
TPM support).

>
>
> (II) Known Limitations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> 1. This patch enables LibSPDM in-tree compilation for Linux systems only.
> 2. LibSPDM compilation uses CMake, so meson build system is making use
>    of the CMake module [4].
> 3. Some problems may occur when compiling LibSPDM with MbedTls such as:
>     error: "_GNU_SOURCE" redefined [-Werror]
>       10 | #define _GNU_SOURCE
>
>    It's possible to compile using --disable-werror.
>
> (III) Sample configuration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> ../configure \
>   --disable-werror \
>   --enable-libspdm \
>   --libspdm-crypto=3Dmbedtls \
>   --enable-gcov
>
> References:
> [1] riscv-spdm
>   Link: https://github.com/htafr/riscv-spdm
> [2] spdm-benchmark
>   Link: https://github.com/rcaalves/spdm-benchmark
> [3] qemu-spdm-emulation-guide
>   Link: https://github.com/twilfredo/qemu-spdm-emulation-guide

This one has been merged upstream and mainline QEMU supports it now:

https://www.qemu.org/docs/master/specs/spdm.html

Alistair

