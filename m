Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7E3C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3c6-0001rI-Ko; Mon, 19 May 2025 12:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH3bx-0001mn-F2
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:45:10 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH3bu-00076E-Su
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:45:09 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70c7b8794faso45740087b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747673104; x=1748277904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZguee6gdCJHN0fT5yf2J2t+zxmmT+8wVcZySPpLw6U=;
 b=oxBAQFFKhPdTQOZ21hZgogm0FlUNWlorqJ631MI+6CtPSYTHTAW/UrSrtPN9wSn5Te
 SkVr6kTFh7qeAzYCCj9DEojdSopqK11peBPgqVOCTGPy1qd3ByZPs2Tw7b9uxY5VbKfU
 +c/JlAjOKfaJTim5wQNhLDG2C4P0LUVhE89eO/fiKkA5OUKFP96hoqO1RKAbASPLb2/Q
 3WsL73RaUGOsncyPSaiCTUY3awd8h8lFjfaMbzzG7Rb4g1n7TIikpzi41P77KTrx2aec
 7bo3xrswBZCZE/irwJBDKJYPh5eb+pwillFvHqmqLfjfGPWZlHkPL8EaYxWYuiDmv+Fl
 C+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747673104; x=1748277904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZguee6gdCJHN0fT5yf2J2t+zxmmT+8wVcZySPpLw6U=;
 b=BwmaQwz313NqFoFaujNiCSWNXoYO8A44HpePRnRpBP/F/FgJSwBzhrVmN0PwqDnxhO
 mKxgOR2qfIiYTMYJGkf6tLoyTTNVdIHe6dHIyrGWBuZiHmMwp4LA8ABvosFvhdMorx6/
 v8M9I2yXzdV5Pa1/rHeMKGHYRkRpN4kQiQb+AxvO3nAjBmRCLPR54kjPfw/UIruFxUPi
 YoHvxcjd6kizMaQbNu25tqjgW2m3DgF9gY9j9BxNzb2hMKUeUqajHItebF9tykqyDPxa
 eksRTPypDcf/jdz//6AOpz+Po/9A7qjR/LkE8WZvvEocTMfJjEBavu8zOvI9VQ7dJIBX
 nYxw==
X-Gm-Message-State: AOJu0YypQt5L2t6GzYxqZF03fkyOWtZqPeQXZIdqxmm9ca15FhMScZCV
 yQdVquujPms27HIoVzLy5Grd1pQ50P1BkFnaBY4hzjHDNo7x3Du77qcCeaABJBdiCHhwvKHbVBn
 857AoFxkqV60Fj8Z55dhMx9hsM+mmfy1N99oCtcPqOw==
X-Gm-Gg: ASbGncuV7z2/42LuiDs7x8VofWLcfhj5N5lvQxqLgUzr2Nv9jS3As1ydCmDzGiNFT4E
 cXWx0Hp7YSamnGnD0cWlXFtH7+oqnaPOvSGRNEZ3iiPT7a07aJrCH78jiVUWy5XIOpFKx18ypWn
 PZ4ZfvYAdOMF1AlqyEtVr7c1Bkgu0XUB0jjQ==
X-Google-Smtp-Source: AGHT+IEvDyqnDlOAl4vuLHF0xf72+/HxxdD0v8d1WZhWcdHNBQd5Yj0CQP3O843Ivs1PLjHRVdCLFkdVPLLfMfeofOc=
X-Received: by 2002:a05:690c:350f:b0:6fe:b7ed:9715 with SMTP id
 00721157ae682-70ca79bf9c6mr182321247b3.11.1747673103876; Mon, 19 May 2025
 09:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250519163721.347322-1-berrange@redhat.com>
 <20250519163721.347322-10-berrange@redhat.com>
In-Reply-To: <20250519163721.347322-10-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 17:44:51 +0100
X-Gm-Features: AX0GCFssSeLjGeNgyPleijoDjh5oJZMkWzuyEp_FV-L9eGh1bEQZm1MRPpehpPk
Message-ID: <CAFEAcA8e4YN03Z7H5bCoWuk5vGXpxEstRqbjjiUSuVx8XZkzcQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] scripts/checkpatch: reject license boilerplate on
 new files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 19 May 2025 at 17:37, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
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
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index dc2c3e6aa1..691c267a8c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -365,6 +365,17 @@ our @typeList =3D (
>         qr{guintptr},
>  );
>
> +# Match text found in common license boilerplate comments:
> +# for new files the SPDX-License-Identifier line is sufficient.
> +our $LICENSE_BOILERPLATE =3D qr{
> +    licensed under the terms of the GNU GPL|
> +    under the terms of the GNU General Public License|
> +    under the terms of the GNU Lesser General Public|
> +    Permission is hereby granted, free of charge|
> +    GNU GPL, version 2 or later|
> +    See the COPYING file
> +}x;
> +
>  # Load common spelling mistakes and build regular expression list.
>  my $misspellings;
>  my %spelling_fix;
> @@ -1497,6 +1508,13 @@ sub process_end_of_file {
>                              "' need 'SPDX-License-Identifier'?");
>                 }
>         }
> +       if ($fileinfo->{action} eq "new" &&
> +           !exists $fileinfo->{facts}->{sawboilerplate}) {

Looks like you still forgot to remove the "!" ?

> +               ERROR("New file '" . $fileinfo->{filenew} . "' must " .
> +                     "not have license boilerplate header text, only " .
> +                     "the SPDX-License-Identifier, unless this file was =
" .
> +                     "copied from existing code already having such text=
.");
> +       }
>  }

thanks
-- PMM

