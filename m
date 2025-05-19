Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777F6C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzos-0003Ss-L0; Mon, 19 May 2025 08:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzok-0003ST-E5
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:42:06 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzof-0007qb-Gs
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:42:04 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70dd2d35449so4377017b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747658517; x=1748263317; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpAEQ+3fHBuSMNstxy7RshkkB0muCYz8dzOHwYBiGOE=;
 b=g+dYPHsjJ8wa5ptwOnGeBVLMtd7bZm58fmDFBIujdjijl8VneWFYqPabiKj3Dvgraq
 zTQdkzttM0RW1YTHL0SbGneW8eh3KWZ3DtdOdAl/YF3bUb6pJ4aO+Fk8dPD+CtXk4CfQ
 nx+uN/CyI1DkShBLnchr3k+sVw2R2C1fmUH0DpV9g9ZuXRurGE+skLEU+RiJjnylL6Rk
 SleJpxRLcGt4XViFm4J5oqjeVoxlba7btmpgozRW8UzmSVi4kn3OXX/s6QQabd0FjaWj
 cWy6q6ooqst2vn4QTyl5HtGie6WECKxQG4WyaF3H8+U1K+T9MFR/vyBcaJe7Wvx52eUA
 R7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747658517; x=1748263317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpAEQ+3fHBuSMNstxy7RshkkB0muCYz8dzOHwYBiGOE=;
 b=H8gtxMzY4oqqFAS0xCzpr/LmnPWwRxQFL7YqotWReqaNr9ldKOlFuv7mJz0fp3ZAem
 Nh8TfedRKV99id9/3J3ciE/nTu/lyiUl4egGmx0Vu8sEb0fYIAJa8YBi+AJe4IBeh/R0
 jqW78uaYuHSoLk8Q41qE4Hz9+Z6blUcSR6eK+nJ/HppeNq74XrN5WbGdQmRxxgg0MMPq
 KKGReFk+VReVLGb0Ne2j+v9cDciHAUYWULXSsUAp3SXiyhAnnQ8La1IeTdezoe3SLNd9
 jB3E3s7CJfN3Nr9etcBKeRPD/wSdgJ0WgxtsJcIBhv0nk/cUX+v26jVga9mXuJ2xEyPN
 6w6Q==
X-Gm-Message-State: AOJu0YyRnIM4AmY+H1dnEfAvdOg20jSMFlhoY0OdLmL4Nhj9xvSSnV3T
 mbAWuWGdBTMLOd+VxEjkuttGk0lCYwGWOJT3wvY9sm4vttw29CIS4VjJ9DF7/teh8dwXvMD4Rmf
 e7TOxhkAHURWimHCmO/2tkhxKG161WYdIMpOE89TT/w==
X-Gm-Gg: ASbGnctHwChBhu/CjtOr9ejRkFjIaJqcestKfvLUU5cS6OIL28wNVHta1D9YLpYHlkh
 y6xpJv6ql5lEdzlEW5zPCd9huM99UzYiHBbFku0FpAqY1EKdA5c29s9CI1xohJoTDXEaCOi/YCl
 ARgN2nIFO9bZ3QauTC+B4tU+GMshQ9qfc1eg==
X-Google-Smtp-Source: AGHT+IFMa89T4Nqd5aCmJZ7AHRSjspGwtJyK2vvbYenZjqRTEPaOALbVV452hP/f5du4ltiCIGlL+dHfxvyXCu+Lg14=
X-Received: by 2002:a05:690c:39a:b0:708:cd31:88a9 with SMTP id
 00721157ae682-70cab0f40c1mr170154627b3.37.1747658517637; Mon, 19 May 2025
 05:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-10-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-10-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:41:44 +0100
X-Gm-Features: AX0GCFvfmuvPZZmvGS1N7WWIAfJpzqFGO5dG9F1EpXWs7tC4rrxn59qP53LYt1w
Message-ID: <CAFEAcA_fO3OmXOGVweNiCr4d_x2bg5Vk7+4m4YwWxnPcXLTqVA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] scripts/checkpatch: reject license boilerplate on
 new files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 15 May 2025 at 15:00, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The previous commit mandates use of SPDX-License-Identifier on common
> source files, and encourages it on all other files.
>
> Some contributors are none the less still also including the license
> boilerplate text. This is redundant and will potentially cause
> trouble if inconsistent with the SPDX declaration.
>
> Match common boilerplate text blurbs and report them as invalid,
> for newly added files.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 87050e6677..cb1942c021 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1496,6 +1496,13 @@ sub process_end_of_file {
>                              "' need 'SPDX-License-Identifier'?");
>                 }
>         }
> +       if ($fileinfo->{action} eq "new" &&
> +           !exists $fileinfo->{facts}->{sawboilerplate}) {
> +               ERROR("New file '" . $fileinfo->{filenew} . "' must " .
> +                     "not have license boilerplate header text unless " =
.
> +                     "this file is copied from existing code with such "=
 .
> +                     "text already present.");

Should we also say here
  The SPDX-License-Identifier line is sufficient.

(just to make it clear why we're not allowing the boilerplate text) ?

> +       }
>  }
>
>  sub process {
> @@ -1798,6 +1805,15 @@ sub process {
>                         &checkspdx($realfile, $1);
>                 }
>
> +               if ($rawline =3D~ /licensed under the terms of the GNU GP=
L/ ||
> +                   $rawline =3D~ /under the terms of the GNU General Pub=
lic License/ ||
> +                   $rawline =3D~ /under the terms of the GNU Lesser Gene=
ral Public/ ||
> +                   $rawline =3D~ /Permission is hereby granted, free of =
charge/ ||
> +                   $rawline =3D~ /GNU GPL, version 2 or later/ ||
> +                   $rawline =3D~ /See the COPYING file/) {
> +                       $fileinfo->{facts}->{sawboilerplate} =3D 1;
> +               }
> +

We could perhaps pull this out into a top level variable, similar
to how the script pre-defines some other long regexes it wants to
match against (untested code):

# Match text found in common license boilerplate comments:
# for new files the SPDX-License-Identifier line is sufficient.
our $LICENSE_BOILERPLATE =3D qr{
    licensed under the terms of the GNU GPL|
    under the terms of the GNU General Public License|
    under the terms of the GNU Lesser General Public|
    Permission is hereby granted, free of charge|
    GNU GPL, version 2 or later|
    See the COPYING file
}x;

and then
    if ($rawline =3D~ /$LICENSE_BOILERPLATE/) {

This seems to me a little better than having it all inline
in the already rather large process() function.

But either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

