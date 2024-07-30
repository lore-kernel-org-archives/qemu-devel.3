Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA303C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoKa-0008Gy-Vv; Tue, 30 Jul 2024 11:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYoKY-000898-0e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:00:02 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYoKN-0002Xp-P3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 10:59:53 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a15692b6f6so7411346a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722351589; x=1722956389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+YyCrckRX8H9pZEbUF5NNg6CdwLDaRPsarTOkvTLWE=;
 b=qZkhcjAmgbw4e+gU9Fbc/bQe0wCoBlX8itqbZ/ob6mO8HBbEHvDoB0tDchD9yjjaDe
 jdtZo1TKzZS1/mV3tl+CjGQDnYbj0+amLVKbqzS+eqFu5LAJ0TkT6Q2UhXNH/5SJrSyO
 JbihmiiB075cM75UepFNGJ5kUMy0ClmnYfmogT7LAOBuVqMHRyzZCA2WPj7p96D8jg/W
 aA4xvkz7iYxc7Jcf2ALglvHBJwvEFi35f8EAMqVmU70vuNRDfS2KGhioy/4BRWN+hn6q
 xJyk1Ip/cMUGigXi5+Jg9j2PZ2JMJVNCFjoRJ6sTTvfIGnQ/LWOpUWEjTJDJfsrC3+/g
 CQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722351589; x=1722956389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+YyCrckRX8H9pZEbUF5NNg6CdwLDaRPsarTOkvTLWE=;
 b=jZUUxrcvKPEULSAyUIybCvyf5PhEuF7fpGXkn0iotkgB3YPiLlmmXbLJROZYAUY2Fb
 dBSMS1JG8PRPrwpYYZbNlp0YQdwmJe1WIjdcNWMpiVAwd7n2euo56avWn89Ohl802KFM
 BaO65qNu0HzxC0Z2y/9V+QleBeBmAwgXOp+QimyrOOXQ2WOO499eZbh7LXuZMwQjhl8G
 HJDrNXjuRllaztO4GTNImjgbmflFwJ4LpMR4kx0pBzcGrq0gWEwIJc4qFL8vXIAbx3Z/
 0CDK/muyOVhHeAF/FspSX3hlO1AwkRq0p/aKl6NfK54i8VpfhlmbowbMeJhu6HM/u6S9
 hKuQ==
X-Gm-Message-State: AOJu0YzXPM4u80JpY6sL0WEc5wIExEoakTXzXW80Ec+C7BFAKalajk9T
 DVk0wOkfjuFZFrDEkU8ZBPA7luEhq1nz4u6URYcwnb5LkRX/xe58I+83EeAf9y2iAUKaib9HhPl
 W6fBwkAo5+4b42RY3RrSij+1NjOF7mHT51lkIwQ==
X-Google-Smtp-Source: AGHT+IGBd00lerOJqK4cG/pzyBjKY7Pwi4AcSJatZZt17O34mPtQi9bvrqsdeULgBHXIu/kisiDGqI+lLwq/1mltrEk=
X-Received: by 2002:a50:9501:0:b0:5a2:6350:75ac with SMTP id
 4fb4d7f45d1cf-5b020101fb1mr7229393a12.8.1722351589080; Tue, 30 Jul 2024
 07:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240729122553.2501133-1-peter.maydell@linaro.org>
 <CABgObfbBQsQjfktUmdECiC8mtrLdVK4R=3=bJTjZhqNh7EXvxw@mail.gmail.com>
In-Reply-To: <CABgObfbBQsQjfktUmdECiC8mtrLdVK4R=3=bJTjZhqNh7EXvxw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2024 15:59:37 +0100
Message-ID: <CAFEAcA_0FuP6Fh52=v9je858VHdgr5uN11Dn71hYFJW=o-OQ4w@mail.gmail.com>
Subject: Re: [RFC] pythondeps: Split sphinx_rtd_theme into its own group
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 30 Jul 2024 at 15:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Mon, Jul 29, 2024 at 2:26=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > Currently we have "sphinx" and "sphinx_rtd_theme" in a single
> > group in pythondeps.toml. This means that mkvenv will try to
> > install them both at once, which doesn't work if sphinx_rtd_theme
> > depends on a version of Sphinx which is newer than the system
> > one, even if the "sphinx" we're installing at the same time
> > would satisfy that dependency. For instance this:
> >
> >  sphinx =3D { accepted =3D ">=3D8.0.0rc1", installed =3D "8.0.0rc1", ca=
nary =3D "sphinx-build" }
> >  sphinx_rtd_theme =3D { accepted =3D ">=3D2.1.0rc1", installed =3D "2.1=
.0rc1" }
> >
> > fails like this:
> >
> > mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> > mkvenv: checking for meson>=3D1.1.0
> > mkvenv: installing meson=3D=3D1.2.3
> > mkvenv: checking for sphinx>=3D8.0.0rc1
> > mkvenv: checking for sphinx_rtd_theme>=3D2.1.0rc1
> > mkvenv: installing sphinx=3D=3D8.0.0rc1, sphinx_rtd_theme=3D=3D2.1.0rc1
> > ERROR: Cannot install sphinx-rtd-theme=3D=3D2.1.0rc1 and sphinx=3D=3D8.=
0.0rc1 because these package versions have conflicting dependencies.
> > ERROR: ResolutionImpossible: for help visit https://pip.pypa.io/en/late=
st/topics/dependency-resolution/#dealing-with-dependency-conflicts
> >
> > *** Ouch! ***
> >
> > Could not provide build dependency 'sphinx=3D=3D8.0.0rc1':
> >  =E2=80=A2 Python package 'sphinx' version '4.3.2' was found, but isn't=
 suitable.
> >  =E2=80=A2 A suitable version could not be obtained from PyPI.
> >
> > (where 4.3.2 is the system version of sphinx on my system).
>
> I think the error is a bit confusing, but the versions seem to be
> genuinely incompatibile. sphinx_rtd_theme is still incompatible with
> sphinx 8.0.0, and the error is correct:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ python -m venv testvenv
> $ cd testvenv
> $ pip install 'sphinx=3D=3D8.0.0rc1' 'sphinx_rtd_theme=3D=3D2.1.0rc1'
> Defaulting to user installation because normal site-packages is not write=
able
> Collecting sphinx=3D=3D8.0.0rc1
>   Downloading sphinx-8.0.0rc1-py3-none-any.whl.metadata (6.2 kB)
> Collecting sphinx_rtd_theme=3D=3D2.1.0rc1
>   Downloading sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl.metadata (4.=
4 kB)
> Collecting sphinxcontrib-applehelp (from sphinx=3D=3D8.0.0rc1)
>   Downloading sphinxcontrib_applehelp-2.0.0-py3-none-any.whl.metadata (2.=
3 kB)
> Requirement already satisfied: sphinxcontrib-devhelp in
> /usr/lib/python3.12/site-packages (from sphinx=3D=3D8.0.0rc1) (1.0.5)
> [more "requirement already satisfied" lines...]
> Requirement already satisfied: packaging>=3D23.0 in
> /usr/lib/python3.12/site-packages (from sphinx=3D=3D8.0.0rc1) (23.2)
> INFO: pip is looking at multiple versions of sphinx-rtd-theme to
> determine which version is compatible with other requirements. This
> could take a while.
> ERROR: Cannot install sphinx-rtd-theme=3D=3D2.1.0rc1 and sphinx=3D=3D8.0.=
0rc1
> because these package versions have conflicting dependencies.
>
> The conflict is caused by:
>     The user requested sphinx=3D=3D8.0.0rc1
>     sphinx-rtd-theme 2.1.0rc1 depends on sphinx<8 and >=3D5
> To fix this you could try to:
> 1. loosen the range of package versions you've specified
> 2. remove package versions to allow pip attempt to solve the dependency c=
onflict
>
> ERROR: ResolutionImpossible: for help visit
> https://pip.pypa.io/en/latest/topics/dependency-resolution/#dealing-with-=
dependency-conflicts
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The reason why your patch works is weird, and it's apparent when you
> run the "pip install" commands one by one:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> $ pip install 'sphinx_rtd_theme=3D=3D2.1.0rc1'
> Defaulting to user installation because normal site-packages is not write=
able
> Collecting sphinx_rtd_theme=3D=3D2.1.0rc1
>   Using cached sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl.metadata (4=
.4 kB)
> Collecting sphinx<8,>=3D5 (from sphinx_rtd_theme=3D=3D2.1.0rc1)
>   Downloading sphinx-7.4.7-py3-none-any.whl.metadata (6.1 kB)
> Requirement already satisfied: docutils<0.21 in
> /usr/lib/python3.12/site-packages (from sphinx_rtd_theme=3D=3D2.1.0rc1)
> (0.20.1)
> [more "requirement already satisfied" lines...]
> Downloading sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl (7.7 MB)
> Downloading sphinx-7.4.7-py3-none-any.whl (3.4 MB)
> Installing collected packages: sphinx, sphinx_rtd_theme
>   Attempting uninstall: sphinx
>     Found existing installation: Sphinx 8.0.0rc1
>     Uninstalling Sphinx-8.0.0rc1:
>       Successfully uninstalled Sphinx-8.0.0rc1
> Successfully installed sphinx-7.4.7 sphinx_rtd_theme-2.1.0rc1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> It doesn't install 8.0.0rc1 at all... :)

Aha. Is it possible to get mkvenv to produce these full
error messages rather than the truncated version?

thanks
-- PMM

