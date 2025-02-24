Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1F5C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 01:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNPS-0002Xz-Ph; Sun, 23 Feb 2025 20:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNPM-0002Vn-NA
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:37:21 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNPL-0001mg-6t
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:37:20 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-868da0af0fcso1263341241.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 17:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740361036; x=1740965836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUYh9KhRtNaUZSOgKke09npKNyubjr0X823c7h/KvYA=;
 b=HQbpk6pk7ru+25RvxOIfB37eIcnnCIa/LG2HfKTJwFLwqTik/HtoZVUTGKmxGeyKYh
 8CftyqesScxHxoKA1u/l+v4VBF+Pr0cpG31HQ0nLXMhbPjp9TOTY/ecgh5DDnJ9+6SW+
 HCzVRcVyQofJalaHXoGJQdTDPM/iZ8NsQZQwJmxjvdcUe4Ic7M5MdG9EySoSXC1In/wh
 J+uUaUUi656F9x3KLaLbQBn8A6+7byHLiQNnK7bYE9DQ/kIBaPPVSw2iAAqIRN7Tjs3V
 m6NTzpICvZFVTgsRlCTd9ZmjwRPms6olbl0e6puHgX5VuImVg3vMQ+wnuUCRr7AuiIW+
 a62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740361036; x=1740965836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUYh9KhRtNaUZSOgKke09npKNyubjr0X823c7h/KvYA=;
 b=ZXJyaaSrXzWyv1SjwmKIKq4y6mPSCk6JYW0/NHFcbGSQI5CiP3MfqiztOJIZyAy9b5
 1ksYzU0J+lARByWq4kQF0PlHWPGA9lqYI53IG9TLZ4hEpvUcgQUZ6sLqIbCxhMmEQXEU
 35SlsRQ1ayTvJLwJyDIun19Cu4ZgaQGr5nmkDNGFggl98CDqSI6wfUwdJD+t1/kSgUyX
 MQbYgw4UwfMzmHAMFGcpl7HnIW02Srpxt0G6nxgb5x2+B/5S3OkAjR3wOe/gd7YIXQvw
 aUtkI2YFuwxzRWFstf0VZI56BeoNWFZmlcaOpHnPqmG7aEVsf4qBOH8gv/ZsPjhCDraD
 ZSJA==
X-Gm-Message-State: AOJu0YxVwt32tgjToj5VwJpR3oPcgLHUsgIu2OZ/ybrMwkl/3i+nXhCZ
 5BkfedfhmKB/oEHMt1aPmrZxnmD2kt3tsSzFlJ7yXYJMpsHGZAICihkaP8FedL6w0A1FFSzRm2P
 2XyLi0zR6QKkrrje9W56Mc7GvtWc=
X-Gm-Gg: ASbGncucxCWhab4NIcTK4egF80bZWBnuiN8S38cKvgv2xCbSOExtElo0oiMtHqUbWKI
 ANxoM+xIT7PMbPALVUoMpGKFv+olluJLYyPtPz32RPaUSdH4JYzCTCpU5bP3tWKG3yuFpShP2Br
 NskwPgL57ObvhGeBpGBdUAyXWPkxTTvunqNinO
X-Google-Smtp-Source: AGHT+IFMGLMPhk3gUPW9Jk6C+iMPUFeizF/VgWaXHr3nqedg8cG6QEhvf7jRRcucsub/HQP3wMQ6NVd8bsD9iVP1Rh0=
X-Received: by 2002:a05:6102:2ac1:b0:4bb:f1f0:1b34 with SMTP id
 ada2fe7eead31-4bfc003d79amr6286278137.2.1740361036266; Sun, 23 Feb 2025
 17:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20250127182924.103510-1-abologna@redhat.com>
 <20250127182924.103510-2-abologna@redhat.com>
In-Reply-To: <20250127182924.103510-2-abologna@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 11:36:50 +1000
X-Gm-Features: AWEUYZm4MJ7GAd6id8VHkocnsxg_iYLeBuT1RvhfW5BRey0HX1BuK2t4sSWcKRE
Message-ID: <CAKmqyKP9XC9evZP+6RHgV9Nq_pfc+B10mXOH_mjsdirJ+AFGxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binfmt: Shuffle things around
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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
> This should make no difference from the functional point of
> view and it's just preparation for upcoming changes.
>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  scripts/qemu-binfmt-conf.sh | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 6ef9f118d9..426f075e31 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -318,20 +318,23 @@ qemu_set_binfmts() {
>          mask=3D$(eval echo \$${cpu}_mask)
>          family=3D$(eval echo \$${cpu}_family)
>
> +        target=3D"$cpu"
> +        if [ "$cpu" =3D "i486" ] ; then
> +            target=3D"i386"
> +        fi
> +
> +        qemu=3D"$QEMU_PATH/qemu-$target$QEMU_SUFFIX"
> +
>          if [ "$magic" =3D "" ] || [ "$mask" =3D "" ] || [ "$family" =3D =
"" ] ; then
>              echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
>              continue
>          fi
>
> -        qemu=3D"$QEMU_PATH/qemu-$cpu"
> -        if [ "$cpu" =3D "i486" ] ; then
> -            qemu=3D"$QEMU_PATH/qemu-i386"
> +        if [ "$host_family" =3D "$family" ] ; then
> +            continue
>          fi
>
> -        qemu=3D"$qemu$QEMU_SUFFIX"
> -        if [ "$host_family" !=3D "$family" ] ; then
> -            $BINFMT_SET
> -        fi
> +        $BINFMT_SET
>      done
>  }
>
> --
> 2.48.1
>

