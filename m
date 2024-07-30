Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E619EC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoBf-0008Fh-5z; Tue, 30 Jul 2024 10:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYoBd-0008F7-5j
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYoBb-0000RY-6N
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722351043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbxSbKA0/v6Kfhk35rGqQxZ1h/RS7edIrdm5r5TJpi8=;
 b=B5Dby6RwctFM0yxmRWF7u+iUeUzNMH6TM7KuRpdQoqcVzJhjyVGbUDYYi8zQeoDE08NCpz
 PzFLZrtSX6j4aZYW4B7s+4Q/3ja2iuRKzJZJ0Xb+Oq81312LW/FMQPwjKlFYZXKSrT+Klz
 3MI01Dyl9LOEArmp6+ZtIqRZMboASUU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-WvmSNtfdNFC5R46f1a5Shw-1; Tue, 30 Jul 2024 10:50:41 -0400
X-MC-Unique: WvmSNtfdNFC5R46f1a5Shw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280e1852f3so29839065e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 07:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722351040; x=1722955840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbxSbKA0/v6Kfhk35rGqQxZ1h/RS7edIrdm5r5TJpi8=;
 b=IKv1mBpkptAS4zQmzn2fUxUrB/sT1hz+sdJXZG63x7xCoPENqlsNgI0F66EpMc2I6y
 n8aymEGpN5hJkm7IroW70UONKkrospQC9NRuAD4Aql6ywznaZV1xK0ZQrv66l6YN5pXs
 Mfbj52qYQTZ/HCzggG0i9A230nOn4Ya+SkNaAEgfIcLPurcgmxUVT1Nwbcdc+Z6WIpzY
 fL3tkRAcymk2e7hySq3pT1cV0HoQLcENuNDliZeMiwAZY1mBr5VvR2mTkv1gX+FN9QWA
 cBe725FqjY0/oJ39exA7AOp1+Kpn7lZOIMQ/jOhri4kE8As+S0O9NY9wwxUzM+B7T8p6
 glTg==
X-Gm-Message-State: AOJu0YxDE1mIWDm8fVk1n6HyJL8zc7InIVo7C8bm8aEyjd02q1dzb+FL
 uLnwhRP2AQApnMpNy3ZzmCNpEMu/cAp0itMoYkaGBIicZaIRUYnGIuTDYpblPxoWxViJnPdyTfk
 ZMQB4qfuHZ7NaOV30kXLDBwyNOhHVKgAX6GsHcIdMJxsWpLbTjoWiD12QPdHY7MpY7EVi9Vtn3s
 Nwr2OBQEg5qTmC/Ro6y1SfqvsJ05Vjs80ppdFwTg==
X-Received: by 2002:a05:6000:1884:b0:366:e991:b9ac with SMTP id
 ffacd0b85a97d-36b5cef8f6bmr8431066f8f.14.1722351039892; 
 Tue, 30 Jul 2024 07:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYTCB3hd50kHEpO0VDlUjgRoFoam2z+llf+zlSv0m8KMoYZIq8Z9mmBmnjKaZSn5lSxkEQkoV4r8imMSqp5uE=
X-Received: by 2002:a05:6000:1884:b0:366:e991:b9ac with SMTP id
 ffacd0b85a97d-36b5cef8f6bmr8431042f8f.14.1722351039477; Tue, 30 Jul 2024
 07:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240729122553.2501133-1-peter.maydell@linaro.org>
In-Reply-To: <20240729122553.2501133-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Jul 2024 16:50:28 +0200
Message-ID: <CABgObfbBQsQjfktUmdECiC8mtrLdVK4R=3=bJTjZhqNh7EXvxw@mail.gmail.com>
Subject: Re: [RFC] pythondeps: Split sphinx_rtd_theme into its own group
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 29, 2024 at 2:26=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Currently we have "sphinx" and "sphinx_rtd_theme" in a single
> group in pythondeps.toml. This means that mkvenv will try to
> install them both at once, which doesn't work if sphinx_rtd_theme
> depends on a version of Sphinx which is newer than the system
> one, even if the "sphinx" we're installing at the same time
> would satisfy that dependency. For instance this:
>
>  sphinx =3D { accepted =3D ">=3D8.0.0rc1", installed =3D "8.0.0rc1", cana=
ry =3D "sphinx-build" }
>  sphinx_rtd_theme =3D { accepted =3D ">=3D2.1.0rc1", installed =3D "2.1.0=
rc1" }
>
> fails like this:
>
> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> mkvenv: checking for meson>=3D1.1.0
> mkvenv: installing meson=3D=3D1.2.3
> mkvenv: checking for sphinx>=3D8.0.0rc1
> mkvenv: checking for sphinx_rtd_theme>=3D2.1.0rc1
> mkvenv: installing sphinx=3D=3D8.0.0rc1, sphinx_rtd_theme=3D=3D2.1.0rc1
> ERROR: Cannot install sphinx-rtd-theme=3D=3D2.1.0rc1 and sphinx=3D=3D8.0.=
0rc1 because these package versions have conflicting dependencies.
> ERROR: ResolutionImpossible: for help visit https://pip.pypa.io/en/latest=
/topics/dependency-resolution/#dealing-with-dependency-conflicts
>
> *** Ouch! ***
>
> Could not provide build dependency 'sphinx=3D=3D8.0.0rc1':
>  =E2=80=A2 Python package 'sphinx' version '4.3.2' was found, but isn't s=
uitable.
>  =E2=80=A2 A suitable version could not be obtained from PyPI.
>
> (where 4.3.2 is the system version of sphinx on my system).

I think the error is a bit confusing, but the versions seem to be
genuinely incompatibile. sphinx_rtd_theme is still incompatible with
sphinx 8.0.0, and the error is correct:

=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ python -m venv testvenv
$ cd testvenv
$ pip install 'sphinx=3D=3D8.0.0rc1' 'sphinx_rtd_theme=3D=3D2.1.0rc1'
Defaulting to user installation because normal site-packages is not writeab=
le
Collecting sphinx=3D=3D8.0.0rc1
  Downloading sphinx-8.0.0rc1-py3-none-any.whl.metadata (6.2 kB)
Collecting sphinx_rtd_theme=3D=3D2.1.0rc1
  Downloading sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl.metadata (4.4 =
kB)
Collecting sphinxcontrib-applehelp (from sphinx=3D=3D8.0.0rc1)
  Downloading sphinxcontrib_applehelp-2.0.0-py3-none-any.whl.metadata (2.3 =
kB)
Requirement already satisfied: sphinxcontrib-devhelp in
/usr/lib/python3.12/site-packages (from sphinx=3D=3D8.0.0rc1) (1.0.5)
[more "requirement already satisfied" lines...]
Requirement already satisfied: packaging>=3D23.0 in
/usr/lib/python3.12/site-packages (from sphinx=3D=3D8.0.0rc1) (23.2)
INFO: pip is looking at multiple versions of sphinx-rtd-theme to
determine which version is compatible with other requirements. This
could take a while.
ERROR: Cannot install sphinx-rtd-theme=3D=3D2.1.0rc1 and sphinx=3D=3D8.0.0r=
c1
because these package versions have conflicting dependencies.

The conflict is caused by:
    The user requested sphinx=3D=3D8.0.0rc1
    sphinx-rtd-theme 2.1.0rc1 depends on sphinx<8 and >=3D5
To fix this you could try to:
1. loosen the range of package versions you've specified
2. remove package versions to allow pip attempt to solve the dependency con=
flict

ERROR: ResolutionImpossible: for help visit
https://pip.pypa.io/en/latest/topics/dependency-resolution/#dealing-with-de=
pendency-conflicts
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The reason why your patch works is weird, and it's apparent when you
run the "pip install" commands one by one:

=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ pip install 'sphinx_rtd_theme=3D=3D2.1.0rc1'
Defaulting to user installation because normal site-packages is not writeab=
le
Collecting sphinx_rtd_theme=3D=3D2.1.0rc1
  Using cached sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl.metadata (4.4=
 kB)
Collecting sphinx<8,>=3D5 (from sphinx_rtd_theme=3D=3D2.1.0rc1)
  Downloading sphinx-7.4.7-py3-none-any.whl.metadata (6.1 kB)
Requirement already satisfied: docutils<0.21 in
/usr/lib/python3.12/site-packages (from sphinx_rtd_theme=3D=3D2.1.0rc1)
(0.20.1)
[more "requirement already satisfied" lines...]
Downloading sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl (7.7 MB)
Downloading sphinx-7.4.7-py3-none-any.whl (3.4 MB)
Installing collected packages: sphinx, sphinx_rtd_theme
  Attempting uninstall: sphinx
    Found existing installation: Sphinx 8.0.0rc1
    Uninstalling Sphinx-8.0.0rc1:
      Successfully uninstalled Sphinx-8.0.0rc1
Successfully installed sphinx-7.4.7 sphinx_rtd_theme-2.1.0rc1
=3D=3D=3D=3D=3D=3D=3D=3D=3D

It doesn't install 8.0.0rc1 at all... :)

Paolo


