Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E3D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9Us-0008Mk-B9; Mon, 02 Dec 2024 11:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9Uq-0008MP-Rp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:42:04 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9Un-0004CM-QK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:42:04 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53de84e4005so5093423e87.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733157720; x=1733762520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niCxHgrW547P+DwWlzcdEfanGs/sn3sh4I4rrLd0AnI=;
 b=Uud6hWG97bO8Jh89iSKdnG+dR0yI/DqQ4nGWk8tCMoi89qgV3F75/jpO+ev/mR366V
 o5/X5nCTgWw53HScyfD6XOAehfFttOC62sdRQtFeU0x9A14i4lgklnAmpvJx6F0X5lmt
 o1gC7BUYFxB9qvGIXoiEIn1S25W3ppx7MMfGstHGdzA/3NVAD3q1hgq+I/y8mPaNqHhD
 MT/43CR/1rywU0JFKAAKHamsVkk6Ov9Na0pTimZDnpx1wDhPfua9vRnE7GbL9ls6QG7Z
 26QeH9noORyonHph8q30VXaqeDGCBdo1TsgjRWKHbG6LCtICqrjJJYPaz1KrPUd448Fp
 g3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733157720; x=1733762520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niCxHgrW547P+DwWlzcdEfanGs/sn3sh4I4rrLd0AnI=;
 b=KS4HHX9wFEPJDUbdG46Hhu+B8FB4JyH2ap0qaeU5hPR8cVxrZ4V2auoFgk9IAQRaBH
 xtiaoy89hMD2DsEskccIuLemrFlEf3LfibviUHcFKzUV4QckeRG4GukbUpC21tnJHie9
 Lffbj/WsGiBdOh/LSNR/UcymQMzAuF/PzHFrnsBifas/SPqVcP8l8ortjPikpqkQrz1j
 c1QJGQgG1I7KQ1TyEOZx1/tah1mOYaX0hHdduIEaHbRv7bRQGAB8EoYRA+nUEDikyRqF
 YZfp8V3fkZ6afYl8tae1NbMlJbNqnTviIbDtOzE4A+EqaHPBeNPS+Z0bQIR6GpViJP+b
 udXw==
X-Gm-Message-State: AOJu0YzhnRYo2JRlUeg+icUM1OONsKpQIRRaxZ5nMESeya8O3FKdH7LB
 Ji5e63Es4POWcoinZhNyCJrO9LEqher/pof68x9ySdp3ZlNC8T+M7+nppzijVfaU6sWgFAMtq98
 FTLmbfYkjKThcAY7h1/zHA0dhPMzVr3MyHg2hqA==
X-Gm-Gg: ASbGncu2MOvhdZPxojOhYgT4Wh1hWqhU9sEZJx2OLdpRNkaAixJQxJOoVQK+82zcNrx
 v1j5l0SN57NpRXwowJ06vE2V5P4Z+EY1d
X-Google-Smtp-Source: AGHT+IE6WpPqH+qVCHLDVYdFwYMi6opljVcWWZdsVHdAYiflF2n+OHYk/xg+2cOc0zBhDOL0IBlGfFb9BHTBK/e5W8Q=
X-Received: by 2002:a05:6512:b15:b0:539:e317:b05f with SMTP id
 2adb3069b0e04-53df00de3a9mr13537385e87.28.1733157719524; Mon, 02 Dec 2024
 08:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20241119112903.1010350-1-berrange@redhat.com>
 <20241119112903.1010350-3-berrange@redhat.com>
In-Reply-To: <20241119112903.1010350-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 16:41:48 +0000
Message-ID: <CAFEAcA9osyiBuFNz6i=WwbJqgg_Gby3OALCvXdhoG1tJJnZLLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] scripts: validate SPDX license choices
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 19 Nov 2024 at 11:29, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> We expect all new code to be contributed with the "GPL-2.0-or-later"
> license tag. Divergance is permitted if the new file is derived from

"divergence"

> pre-existing code under a different license, whether from elsewhere
> in QEMU codebase, or outside.
>
> Issue a warning if the declared license is not "GPL-2.0-or-later",
> and an error if the license is not one of the handful of the
> expected licenses to prevent unintended proliferation. The warning
> asks users to explain their unusual choice of license in the commit
> message.

Should we update LICENSE (or something under docs/devel ?) to
state our policy ?

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 68 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d946121b8e..b507da8e2b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1353,6 +1353,69 @@ sub checkfilename {
>         }
>  }
>
> +sub checkspdx {
> +    my ($file, $expr) =3D @_;
> +
> +    # Imported Linux headers probably have SPDX tags, but if they
> +    # don't we're not requiring contributors to fix this, as these
> +    # files are not expected to be modified locally in QEMU
> +    if ($file =3D~ m,include/standard-headers, ||
> +       $file =3D~ m,linux-headers,) {
> +       return;
> +    }
> +
> +    my $origexpr =3D $expr;
> +
> +    # Flatten sub-expressions
> +    $expr =3D~ s/\(|\)/ /g;
> +    $expr =3D~ s/OR|AND/ /g;
> +
> +    # Merge WITH exceptions to the license
> +    $expr =3D~ s/\s+WITH\s+/-WITH-/g;
> +
> +    # Cull more leading/trailing whitespace
> +    $expr =3D~ s/^\s*//g;
> +    $expr =3D~ s/\s*$//g;
> +
> +    my @bits =3D split / +/, $expr;
> +
> +    my $prefer =3D "GPL-2.0-or-later";
> +    my @valid =3D qw(
> +       LGPL-2.0-or-later
> +       LGPL-2.1-or-later
> +       GPL-2.0-only
> +       LGPL-2.0-only
> +       LGPL-2.0-only

Lists LGPL-2.0-only twice ? I'm guessing the second should be 2.1.

I'm not sure we really want to allow more LGPL-2.0-only
code...we don't have a reason like we do with GPL-2.0-only
where the reason is "code from the kernel", and I feel like
LGPL-2.0-only is quite rare anyway, and at least sometimes
a mistake where the author meant LGPL-2.1-only or GPL-2.0-only.
But maybe this list should be generous enough to only warn,
not error, for code copied within QEMU.

AFAICT the only code we have that is LGPL-2.0-only is
util/error.c. But that also refers to our COPYING.LIB,
which is LGPL2.1. In 2011, 12 years after the publication
of LGPL2.1, did Anthony Liguori *really* mean to use
LGPL2.0 only? Answers on a postcard :-)

> +       BSD-2-Clause
> +       BSD-3-Clause
> +       MIT
> +       );
> +
> +    my $nonpreferred =3D 0;
> +    my @unknown =3D ();
> +    foreach my $bit (@bits) {
> +       if ($bit eq $prefer) {
> +           next;
> +       }
> +       if (grep /^$bit$/, @valid) {
> +           $nonpreferred =3D 1;
> +       } else {
> +           push @unknown, $bit;
> +       }
> +    }
> +    if (@unknown) {
> +       ERROR("Saw unacceptable licenses '" . join(',', @unknown) .
> +             "', valid choices for QEMU are:\n" . join("\n", $prefer, @v=
alid));
> +    }
> +
> +    if ($nonpreferred) {
> +       WARN("Saw acceptable license '$origexpr' but note '$prefer' is pr=
eferred " .
> +            "for new files unless the code is derived from a source with=
 an " .
> +            "existed declared license that must be followed. Please expl=
ain " .
> +            "license choice in the commit message");
> +    }
> +}
> +
>  sub process {
>         my $filename =3D shift;
>
> @@ -1641,6 +1704,11 @@ sub process {
>                     }
>                 }
>
> +# Check SPDX-License-Identifier references a permitted license
> +               if ($rawline =3D~ m,SPDX-License-Identifier: (.*?)(\*/)?\=
s*$,) {
> +                   &checkspdx($realfile, $1);
> +               }
> +

The code changes look OK to me.

thanks
-- PMM

