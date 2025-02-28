Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A97C282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 04:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnrwG-000124-Kt; Thu, 27 Feb 2025 23:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnrwB-000100-Mr
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 23:25:25 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tnrw8-0007au-92
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 23:25:23 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-51e902b58c0so1317169e0c.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 20:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740716718; x=1741321518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6iiqjs0b9zJ1D0jUaumhiJH40zl2+2yrOGKXJ7sNx0=;
 b=RrBT03+SOE+N/N1N7y+4Fh7/jBpeKSFm/VW0CqNvmJf4lINwvoBtt66z4fYETZ2fl8
 IwJCKrwy3x4clowc4ld5upyn7p5oA6o36JTFVYQ0R7OJOX7polKBqqj7FhZzaWAEfn8i
 vCcKF62yQlycEw8HDamhcrigG7eDn19JC5pe+S6dwC7Jv2vOvjWuFvqrvYrK6k6dTiTE
 hMLE0Uh9X7XsUBI9llPy3wBz0drZWRgQ/TUMy6t9g3J04IocuwA0OxVtoyp+IlO5aPOy
 Op3XoiIt5nfvP5Oup61CBPFZcn3g2LiMRUie5x0hDukxDnC18blaHj5adlCuYnNDkjTc
 W5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740716718; x=1741321518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c6iiqjs0b9zJ1D0jUaumhiJH40zl2+2yrOGKXJ7sNx0=;
 b=biQSJCq2Li/uEyPncTbpXtYre018cDJCFspllGwYBEeVuqJGxHTyDWwXioluF90PYR
 uZHHwpE8w4KnhgmwKwFLFbu54iZKfYHzM8mIYACCCs70awdTefKuguCBr9B48+hTveYW
 vRmkdCz3Pjva0EUtz9Eno4N5t3ge0jG6Od6SPTl/mLEMR0xzQ2gNsBlQ3CtiwUJJLQPg
 IBZBh/is3Y3EvF5rMx1uPU0FBgNT4/W4ToA0aM7ohd7d6l+DbiKJU/oxbOWIkNtxrOXQ
 uzHshPn6EqqSiSvs2K1PAJlvFcKfoDjyfiGEnqZfXH8FzniIRZhQKvgG6DhisLs1FX2b
 sR6w==
X-Gm-Message-State: AOJu0YzJsYejNSWfONHv2t/nI8yNtiuLD3/ifswh+grajpr1wiUNpajK
 c/cckonZ4lgbPDKuGJqFvMrczoZfye+VrQmUBjfDFrMv9UF+f0gpasSOQxJVMygs8sGoiBwiez8
 OHCdYbZNF0js9YGuqcxy80xPmEdE=
X-Gm-Gg: ASbGnctfkrs+QjBzU+DmhIvo2iLplTG+UGaEAMz42BUcabJksxPCKY9Bjey5vkn6tcd
 qyr4234cRWyEnGWIIkWU+O0H1RS9u9rNn2cJX+YGDNtik/YM3OUFZUjKpb28cIptx0nNTGnNBGh
 FqPMcpz6ecXokN+L4H9bU66bBQMOKlTQ3awtlt
X-Google-Smtp-Source: AGHT+IHHxZNoPLK0WQrBdCrYitZc4/LpWMIJbBKoM2HucHyABAUtiN8sOyBpu7ZiEHWnta2iihDdN/fnmE8FFwhGN50=
X-Received: by 2002:a05:6122:3908:b0:51f:3eee:89e7 with SMTP id
 71dfb90a1353d-5235bd672a7mr1074074e0c.11.1740716718535; Thu, 27 Feb 2025
 20:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20250127182924.103510-1-abologna@redhat.com>
 <20250127182924.103510-4-abologna@redhat.com>
In-Reply-To: <20250127182924.103510-4-abologna@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 14:24:52 +1000
X-Gm-Features: AQ5f1Jr1oppNTYg85YRL_4i-UDcF-QPiYSVUv68ACfoRDKL3a49T8uYQAyIn-vg
Message-ID: <CAKmqyKN7HtWpihKAyAzzXGiB6-DBe-HExCY130YaVAV6Wpu+4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] binfmt: Add --ignore-family option
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Tue, Jan 28, 2025 at 4:29=E2=80=AFAM Andrea Bolognani <abologna@redhat.c=
om> wrote:
>
> Until now, the script has worked under the assumption that a
> host CPU can run binaries targeting any CPU in the same family.
> That's a fair enough assumption when it comes to running i386
> binaries on x86_64, but it doesn't quite apply in the general
> case.
>
> For example, while riscv64 CPUs could theoretically run riscv32
> applications natively, in practice there exist few (if any?)
> CPUs that implement the necessary silicon; moreover, even if you
> had one such CPU, your host OS would most likely not have
> enabled the necessary kernel bits.
>
> This new option gives distro packagers the ability to opt out of
> the assumption, likely on a per-architecture basis, and make
> things work out of the box for a larger fraction of their user
> base.
>
> As an interesting side effect, this makes it possible to enable
> execution of 64-bit binaries on 32-bit CPUs of the same family,
> which is a perfectly valid use case that apparently hadn't been
> considered until now.
>
> Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
> Thanks: David Abdurachmanov <davidlt@rivosinc.com>
> Thanks: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  scripts/qemu-binfmt-conf.sh | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 8d9136a29f..5fd462b1d1 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -205,6 +205,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debia=
n][--systemd CPU]
>         --persistent:    if yes, the interpreter is loaded when binfmt is
>                          configured and remains in memory. All future use=
s
>                          are cloned from the open file.
> +       --ignore-family: if yes, it is assumed that the host CPU (e.g. ri=
scv64)
> +                        can't natively run programs targeting a CPU that=
 is
> +                        part of the same family (e.g. riscv32).
>         --preserve-argv0 preserve argv[0]
>
>      To import templates with update-binfmts, use :
> @@ -337,7 +340,12 @@ qemu_set_binfmts() {
>          fi
>
>          if [ "$host_family" =3D "$family" ] ; then
> -            continue
> +            # When --ignore-family is used, we have to generate rules ev=
en
> +            # for targets that are in the same family as the host CPU. T=
he
> +            # only exception is of course when the CPU types exactly mat=
ch
> +            if [ "$target" =3D "$host_cpu" ] || [ "$IGNORE_FAMILY" =3D "=
no" ] ; then
> +                continue
> +            fi
>          fi
>
>          $BINFMT_SET
> @@ -355,10 +363,11 @@ CREDENTIAL=3Dno
>  PERSISTENT=3Dno
>  PRESERVE_ARG0=3Dno
>  QEMU_SUFFIX=3D""
> +IGNORE_FAMILY=3Dno
>
>  _longopts=3D"debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,cre=
dential:,\
> -persistent:,preserve-argv0:"
> -options=3D$(getopt -o ds:Q:S:e:hc:p:g:F: -l ${_longopts} -- "$@")
> +persistent:,preserve-argv0:,ignore-family:"
> +options=3D$(getopt -o ds:Q:S:e:hc:p:g:F:i: -l ${_longopts} -- "$@")
>  eval set -- "$options"
>
>  while true ; do
> @@ -418,6 +427,10 @@ while true ; do
>          shift
>          PRESERVE_ARG0=3D"$1"
>          ;;
> +    -i|--ignore-family)
> +        shift
> +        IGNORE_FAMILY=3D"$1"
> +        ;;
>      *)
>          break
>          ;;
> --
> 2.48.1
>

