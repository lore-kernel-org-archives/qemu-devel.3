Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EF2C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 01:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNSE-0003V3-He; Sun, 23 Feb 2025 20:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNSB-0003UQ-UW
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:40:15 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNS9-0002Eh-UN
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:40:15 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5209cd689fcso793354e0c.1
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 17:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740361213; x=1740966013; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33QiUAWSRU0WlWidW7Trjh1kAbJqvx3QwgGGd0s+x54=;
 b=Rjr5u8XFqz9Xxj8i3N4aHlx1snjSjteteuh5owUgt/Uikb4zr1RCUPTcJm6fKlV3PU
 3Ii4iLHu2/yYN8S8Gc1D3srBee07Y7zOsVrSoKMB095ayYCw2PBgRCZelO6PrJkp47/P
 DchzmjRlz5NiyYDJhnF/IabfoWB5HNiP7Isrl/ijF4BBEg4/QHphFpCufPqXq3mwPiVN
 PMj9ijkvw7x7++u3JYNFnj2DvIRINMP2gPZGQEcYs5l1tJJMd54RiIqRtLVDH08zyY4Z
 0wuxoKW1EPvF1AK/57QiRcaT2zFOqaHRiE4EiMeVLGDxP89XDGdOUODskvpbyhV1uQ12
 yO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740361213; x=1740966013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33QiUAWSRU0WlWidW7Trjh1kAbJqvx3QwgGGd0s+x54=;
 b=IDBdF0WzMG+I+2UKpadPamXGlygk61PTWhTaCJbWJDpgynCaW7SNgTODdQOusqrokx
 09aCnL7XuCKubfJb/58otTbREx46ayLQKLWqx3Kff8YryxfLlKthgrWOJlf+PuS/XyO9
 0yC1rjL3fsQvPyQnJTjuS/gZYZiIZHEscFmmaSNyJQ84TCnZ2KQFLUmRP8IvOUPvfUC4
 lz9FHmBYNorJsUWtRyBfZ+NCk5UA7PmCPwPOHK6RTTmUuhGSbK9uaw1hmUJjRBs/KhyY
 VrEyy4I+fRFfVsCEYT1NnzDZvYIdJJWeO61ZDgdlIfH02ELWp45HuB0LcnSIu+0Pd/Ny
 c+Cw==
X-Gm-Message-State: AOJu0YyHte6X2Akdd6CYwl7VMPe0IiDeucpO6Tq9ojx9FObFBostiLun
 fwjGLX1ruRTs2XpbqTYNELjGt2HoF3/NzIiQev/wFNoEgo6oDi8wsKUYw/a7OxQDwwGCYmctPxY
 tYkAaw1HMJb0p8IV952SSymI17PQ=
X-Gm-Gg: ASbGncsSzUATC/a8ADKAvaP1ox3Dy0lRgcBLqWhAutnXpfbBvVa6aMYogFbRAkN4JSX
 J05llShuglIN+qOHiqwIeqFDk9T11ZvchtnWa3puoXVdv+ne+tg9zMIutHk91mWc13U6LxqCQzB
 SN77D+Lpe7MmtObE33HKl1JVtqSP6eMEZSks7/
X-Google-Smtp-Source: AGHT+IFtCCG38m2JSb09RTMdyglAkqmxGJ/9c0gC9fwen5DMi1Nk5Q7x+xMhX6NBp8H3H1//bZog2b8YOzAK/LFmgxE=
X-Received: by 2002:a05:6122:4081:b0:520:64ea:c482 with SMTP id
 71dfb90a1353d-521efca3dbfmr4832483e0c.7.1740361212758; Sun, 23 Feb 2025
 17:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20250127182924.103510-1-abologna@redhat.com>
 <20250127182924.103510-3-abologna@redhat.com>
In-Reply-To: <20250127182924.103510-3-abologna@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 11:39:46 +1000
X-Gm-Features: AWEUYZnELHmMxE7Jk0BqSsFtZ3WNMEXiZIFlgjfSJawZk66OnLtLVABpnimTrKI
Message-ID: <CAKmqyKPJirY6YWOtTiKNwh7xM7kVuihVhnWe3UKWND1qX=p-gw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binfmt: Normalize host CPU architecture
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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
> Right now information regarding the family each CPU type belongs
> to is recorded in two places: the large data table at the top of
> the script, and the qemu_host_family() function.
>
> We can make things better by mapping host CPU architecture to
> QEMU target in the few cases where the two don't already match
> and then using the data table to look up the family, same as
> we're already doing for the guest CPU architecture.
>
> Being able to reason in terms of QEMU target regardless of
> whether we're looking at the host or guest CPU architecture will
> come in handy to implement upcoming changes.
>
> A couple of entries are dropped in the process: BePC and Power
> Macintosh. I'm quite certain neither of those have ever been
> reported as CPU architectures by Linux. I believe many more of
> the entries that are carried forward could be dropped as well,
> but I don't have the same level of confidence there so I
> decided to play it safe just in case.
>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
>
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 426f075e31..8d9136a29f 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -144,35 +144,35 @@ loongarch64_magic=3D'\x7fELF\x02\x01\x01\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x02\x
>  loongarch64_mask=3D'\xff\xff\xff\xff\xff\xff\xff\xfc\x00\xff\xff\xff\xff=
\xff\xff\xff\xfe\xff\xff\xff'
>  loongarch64_family=3Dloongarch
>
> -qemu_get_family() {
> -    cpu=3D${HOST_ARCH:-$(uname -m)}
> +# Converts the name of a host CPU architecture to the corresponding QEMU
> +# target.
> +#
> +# FIXME: This can probably be simplified a lot by dropping most entries.
> +#        Remember that the script is only used on Linux, so we only need=
 to
> +#        handle the strings Linux uses to report the host CPU architectu=
re.
> +qemu_normalize() {
> +    cpu=3D"$1"
>      case "$cpu" in
> -    amd64|i386|i486|i586|i686|i86pc|BePC|x86_64)
> +    i[3-6]86)
>          echo "i386"
>          ;;
> -    mips*)
> -        echo "mips"
> +    amd64)
> +        echo "x86_64"
>          ;;
> -    "Power Macintosh"|ppc64|powerpc|ppc)
> +    powerpc)
>          echo "ppc"
>          ;;
> -    ppc64el|ppc64le)
> -        echo "ppcle"
> +    ppc64el)
> +        echo "ppc64le"
>          ;;
> -    arm|armel|armhf|arm64|armv[4-9]*l|aarch64)
> +    armel|armhf|armv[4-9]*l)
>          echo "arm"
>          ;;
> -    armeb|armv[4-9]*b|aarch64_be)
> +    armv[4-9]*b)
>          echo "armeb"
>          ;;
> -    sparc*)
> -        echo "sparc"
> -        ;;
> -    riscv*)
> -        echo "riscv"
> -        ;;
> -    loongarch*)
> -        echo "loongarch"
> +    arm64)
> +        echo "aarch64"
>          ;;
>      *)
>          echo "$cpu"
> @@ -309,7 +309,13 @@ EOF
>
>  qemu_set_binfmts() {
>      # probe cpu type
> -    host_family=3D$(qemu_get_family)
> +    host_cpu=3D$(qemu_normalize ${HOST_ARCH:-$(uname -m)})
> +    host_family=3D$(eval echo \$${host_cpu}_family)
> +
> +    if [ "$host_family" =3D "" ] ; then
> +        echo "INTERNAL ERROR: unknown host cpu $host_cpu" 1>&2
> +        exit 1
> +    fi
>
>      # register the interpreter for each cpu except for the native one
>
> --
> 2.48.1
>

