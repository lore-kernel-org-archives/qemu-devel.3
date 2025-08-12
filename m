Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC573CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 23:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulyba-00067n-Db; Tue, 12 Aug 2025 19:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulybX-00066r-QZ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:40:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ulybQ-00084F-7M
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 19:40:31 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61592ff5ebbso9512544a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755042019; x=1755646819; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PcSxhknXkub4rgTpelRUYOIHFzIFOhkMt1Vbws1Sp8=;
 b=ayC04Qoc8eX5Lt/ktrVo+OQkUpfZZ0V4oQgXz9z4KUJtupedQKrlw1zjcaaB1VeEpP
 YhkoUacsER6fYBG0rtA4LI2nBnmOKi9cV3y57BoCmsdL0nFg6s4vYSla6g1xZBBQxpB/
 bl+QRZRJZ0wN9AXgwTHRvFjrXrWjlXuGZCMcj1w/3mbfUP+PxbjiokHHW7xSujhBBnSp
 YKx9KbGX42A5E+4veREv8C6xEITHfjsCLVk9nmII12EahjxcNAFT4oqNyLb4463f0o/4
 x26pPUPkYAEJoa+apeTm8qiqq6lW9JyE2OE5wb867z322QzIco0xYrhtaNRIR6WqUKO1
 cFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755042019; x=1755646819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PcSxhknXkub4rgTpelRUYOIHFzIFOhkMt1Vbws1Sp8=;
 b=AW2tiZcdwgAz2tVG2p6APTPKjzZGzIHDWCkxGSJZ35R1DcA0PNQ62gshv14608vnBy
 SOxu5pj8UKMbPf9G+pJcq12mmtGD8sZ1FA5QYnu2bCLcoJ5PcccUwJ2Hq/hB+HGwcEVs
 BFN2FhYeZkcgt/Z3Hjo8gGpOJNgLjorCwzCc8OPNahUZgHqgEVuVk6PovtEpbLAZp68k
 AftxuofZztJGZLMiLyqUcxOZP8OH6s8OkHu1kg6jpaV4pdgNF82qqA7sWWnVQv4lgPO5
 XEwGqqXue3BsOtMQzw7AJTwExCotzsxUWDpb1ZkVSdkY9ybOpcIfZbCEWuYS2eB8jDVH
 b1Ug==
X-Gm-Message-State: AOJu0Yyuid1bsVPMruiGNNj/1fc6ssExbiOCFWi0TfM6oaGwiGXDhWBt
 qo3C7CkApedqwnsgTcfJyk+26U/TtTysCZFXp57Si5p5nGbayOchFK2mY5Ffm2U1yP9wwEd+p0U
 TEXNW5KtM/a94ilSjSNF+15u3yauEJTA=
X-Gm-Gg: ASbGnct9ksNrr0AxsrJKku3v7znbUeMwv2/NeAwOcWNpo3e/op2b9BVex0GurR+ZDiA
 z9FPE/GYnfQYM17Z0YidQJSUUItoT1sgwToxrZmn6GO4+0S3eT+FomFwuB2TUbq6a6C/N8GKwCz
 UYxo3fl2KUR7QWvbDEN0PXtJZ7fKUSS0QdTbWzISAY8KWeSrnPqT3sJ5dZ1HSXe7gpPPsJlHbjN
 2Doiw==
X-Google-Smtp-Source: AGHT+IEAH5fSYDh+FhG1xbowJa80uPvD0Z5On+ACoOaR7EXOnAGzBCYt5WzYRUdH9a+fhYbS6gAzrLEpeSuXjacP7D0=
X-Received: by 2002:a05:6402:430f:b0:618:b:978d with SMTP id
 4fb4d7f45d1cf-6186bfd67cdmr558943a12.24.1755042019426; Tue, 12 Aug 2025
 16:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250811190159.237321-1-jsnow@redhat.com>
In-Reply-To: <20250811190159.237321-1-jsnow@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Aug 2025 19:40:07 -0400
X-Gm-Features: Ac12FXwEkxcqZRkY9ayOo6Er_RELU2UEPlW5TiHi1k4tlBlx8LOZJIwti-C-_Z4
Message-ID: <CAJSP0QVgbOo27iXfkLEtgsxqwZzueht=+AjQ78AYB+t8HxQ-Tw@mail.gmail.com>
Subject: Re: [PATCH] mkvenv: Support pip 25.2
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Sv. Lockal" <lockalsash@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 11, 2025 at 3:03=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> From: "Sv. Lockal" <lockalsash@gmail.com>
>
> Fix compilation with pip-25.2 due to missing distlib.version
>
> Bug: https://gitlab.com/qemu-project/qemu/-/issues/3062
>
> Signed-off-by: Sv. Lockal <lockalsash@gmail.com>
> [Edits: Type "safety" whackamole --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/scripts/mkvenv.py | 64 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 4 deletions(-)

Applied for QEMU v10.1.0-rc3. Thanks!

Stefan

> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index 8ac5b0b2a05..f102527c4de 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -84,6 +84,7 @@
>      Sequence,
>      Tuple,
>      Union,
> +    cast,
>  )
>  import venv
>
> @@ -94,17 +95,39 @@
>  HAVE_DISTLIB =3D True
>  try:
>      import distlib.scripts
> -    import distlib.version
>  except ImportError:
>      try:
>          # Reach into pip's cookie jar.  pylint and flake8 don't understa=
nd
>          # that these imports will be used via distlib.xxx.
>          from pip._vendor import distlib
>          import pip._vendor.distlib.scripts  # noqa, pylint: disable=3Dun=
used-import
> -        import pip._vendor.distlib.version  # noqa, pylint: disable=3Dun=
used-import
>      except ImportError:
>          HAVE_DISTLIB =3D False
>
> +# pip 25.2 does not vendor distlib.version, but it uses vendored
> +# packaging.version
> +HAVE_DISTLIB_VERSION =3D True
> +try:
> +    import distlib.version  # pylint: disable=3Dungrouped-imports
> +except ImportError:
> +    try:
> +        # pylint: disable=3Dunused-import,ungrouped-imports
> +        import pip._vendor.distlib.version  # noqa
> +    except ImportError:
> +        HAVE_DISTLIB_VERSION =3D False
> +
> +HAVE_PACKAGING_VERSION =3D True
> +try:
> +    # Do not bother importing non-vendored packaging, because it is not
> +    # in stdlib.
> +    from pip._vendor import packaging
> +    # pylint: disable=3Dunused-import
> +    import pip._vendor.packaging.requirements  # noqa
> +    import pip._vendor.packaging.version  # noqa
> +except ImportError:
> +    HAVE_PACKAGING_VERSION =3D False
> +
> +
>  # Try to load tomllib, with a fallback to tomli.
>  # HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not f=
ail
>  # outside the venv or before a potential call to ensurepip in checkpip()=
.
> @@ -133,6 +156,39 @@ class Ouch(RuntimeError):
>      """An Exception class we can't confuse with a builtin."""
>
>
> +class Matcher:
> +    """Compatibility appliance for version/requirement string parsing.""=
"
> +    def __init__(self, name_and_constraint: str):
> +        """Create a matcher from a requirement-like string."""
> +        if HAVE_DISTLIB_VERSION:
> +            self._m =3D distlib.version.LegacyMatcher(name_and_constrain=
t)
> +        elif HAVE_PACKAGING_VERSION:
> +            self._m =3D packaging.requirements.Requirement(name_and_cons=
traint)
> +        else:
> +            raise Ouch("found neither distlib.version nor packaging.vers=
ion")
> +        self.name =3D self._m.name
> +
> +    def match(self, version_str: str) -> bool:
> +        """Return True if `version` satisfies the stored constraint."""
> +        if HAVE_DISTLIB_VERSION:
> +            return cast(
> +                bool,
> +                self._m.match(distlib.version.LegacyVersion(version_str)=
)
> +            )
> +
> +        assert HAVE_PACKAGING_VERSION
> +        return cast(
> +            bool,
> +            self._m.specifier.contains(
> +                packaging.version.Version(version_str), prereleases=3DTr=
ue
> +            )
> +        )
> +
> +    def __repr__(self) -> str:
> +        """Stable debug representation delegated to the backend."""
> +        return repr(self._m)
> +
> +
>  class QemuEnvBuilder(venv.EnvBuilder):
>      """
>      An extension of venv.EnvBuilder for building QEMU's configure-time v=
env.
> @@ -669,7 +725,7 @@ def _do_ensure(
>      canary =3D None
>      for name, info in group.items():
>          constraint =3D _make_version_constraint(info, False)
> -        matcher =3D distlib.version.LegacyMatcher(name + constraint)
> +        matcher =3D Matcher(name + constraint)
>          print(f"mkvenv: checking for {matcher}", file=3Dsys.stderr)
>
>          dist: Optional[Distribution] =3D None
> @@ -683,7 +739,7 @@ def _do_ensure(
>              # Always pass installed package to pip, so that they can be
>              # updated if the requested version changes
>              or not _is_system_package(dist)
> -            or not matcher.match(distlib.version.LegacyVersion(dist.vers=
ion))
> +            or not matcher.match(dist.version)
>          ):
>              absent.append(name + _make_version_constraint(info, True))
>              if len(absent) =3D=3D 1:
> --
> 2.50.1
>
>

