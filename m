Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63F3F506DA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29A0-000062-Gr; Mon, 16 Mar 2026 10:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w299z-00005C-AU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:43:11 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w299x-00008u-Hq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:43:11 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b941762394aso579167766b.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773672188; x=1774276988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EN1fJV37AEwDAMW+PxRH5eVecRrM5mLPs2qRgGzKvac=;
 b=jvWbmpUOba1MNEgv2nxzfHDT7zBRspKiGL62GTSV2EVRlcv2Q4NAir22DQTJ3z2K3o
 z3TTeAAkOQdo8RfxvV8XsIKjLKPTXaHRHkiKWCgMsYmOkVcp/J8y/sf3jj3E494YWQiU
 HHT6Q5x3qzGYWt7uxH65IEnjMGg35SILVXkv5gv1/srM86gQxtMW01RQ40oXqbZg15fI
 EZsosQA13iDViBC8vGjVhWavlH6/thdt1Z4tsBzBFhPN5i25Es9d0XNZC6ala+bbBtnd
 /hY8WpNjQAagbl8QJCrEBJiT69WsNUNLZ7mZ+bujbVCe5XG5mFwLdvm+FSEO/91eWIBG
 fyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773672188; x=1774276988;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EN1fJV37AEwDAMW+PxRH5eVecRrM5mLPs2qRgGzKvac=;
 b=mWQu9JVzDYucCp1oEmDuMPs7+l55Zk31qxHT++BkpweVPE1QkJr3cYfGjEKSDOhA6d
 qQ7fGNk8ZmC/GfRjVvIMY5qYhLw6xqRrQJeYvRi2y0FsdlSoyKFdO3o2NBKUU+HNeI1f
 785RqnlvLdRMbMGdvaddWiaQtGCrUXg3EDnfrVetJhTsJSjV/E+T5C9tOr3PMtawz47y
 Zb8RjTb1bcIMKFz2E+3kEx9BA988Dsh+20fafaM8ffuP4r+zxr0wE3N33UWcVii4dv22
 2pWRcCN9AD70d3y3TRt/ZozagUQIw/MPVZOgoT6rguqdbs0PrPkVSd3iSGTX8OoJuvdL
 hQOw==
X-Gm-Message-State: AOJu0YzEpO5Ogt4TG66V862cPTdJ4nPaBylb7JXVN1hFLRnD/HClPd31
 ncuKxeo0M2YAxQwHzIplC/dU/ce3ISjR+79Hm0pYVXhuuWF5uuKect0funi/1LOrJwM=
X-Gm-Gg: ATEYQzytIcuIG6D3qZJkB6vDQ4VgK+RMkDWJ8IMvLUm1eDhmm7+RHalGhEvjUfZ8qce
 Uou9Ipix8vtVHYiWy8w077oDCMlQSkeOdQbUDDixk5gkDpOvoAvuA5+G4ZO6UmSKc9ngy3oufnW
 PCdMTrrTfbxIT9iOKge7BLwHCV8YKZxcCtK81kjSUhim/mbflK3o5ddSxdQz86acGV/iAcbC9i7
 RD3qqH2somP+s1XZjTEyTYu7erCuACcOJvZmMKOo/fYxkBVN4CAAxhQoth9t0dO8DucFKPeMMus
 23KmKU6XqdRpB1LmtGWsPi9vpVgFGav0ULEsNeDf1QYGehYF46bbwlFTVwxRhPR9k1vyZTFxy9M
 fUpxtJRW3qjN73buWWBY2ejt/VJkNIeNk0OemdUcDFxMeJzWEZLSL/zdJReYzSLxtUOCZbt+ftT
 zxaTj9v1+96/T0LUMPK+kXtX8=
X-Received: by 2002:a17:907:3f27:b0:b97:7b94:a47d with SMTP id
 a640c23a62f3a-b977b94c34fmr631357966b.50.1773672187646; 
 Mon, 16 Mar 2026 07:43:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cc220basm572979166b.28.2026.03.16.07.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 07:43:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2AC095FA31;
 Mon, 16 Mar 2026 14:43:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/3] tests/lcitool: Update openSUSE to version 16
In-Reply-To: <20260316135407.209072-3-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 16 Mar 2026 14:54:06 +0100")
References: <20260316135407.209072-1-thuth@redhat.com>
 <20260316135407.209072-3-thuth@redhat.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 16 Mar 2026 14:43:06 +0000
Message-ID: <877brbomx1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The first version of openSUSE 15 has been released in 2018, and
> according to our support policy, we "support the most recent major
> version at all times for up to five years after its initial release."
>
> Since openSUSE 16 has been released a while ago, and openSUSE is
> clearly older than 5 years already, it's time to update to version 16
> now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure                  |  1 -
>  tests/lcitool/mappings.yml | 58 --------------------------------------
>  tests/lcitool/refresh      |  2 +-
>  3 files changed, 1 insertion(+), 60 deletions(-)
>
> diff --git a/configure b/configure
> index cd1dadd8bb2..f3603fd9160 100755
> --- a/configure
> +++ b/configure
> @@ -929,7 +929,6 @@ if ! check_py_version "$python"; then
>    error_exit "Cannot use '$python', Python >=3D 3.9 is required." \
>               "Use --python=3D/path/to/python to specify a supported Pyth=
on." \
>               "Maybe try:" \
> -             "  openSUSE Leap 15.3+: zypper install python39" \
>               "  CentOS: dnf install python3.12"
>  fi
>=20=20
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 60618971584..62fe60d047f 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -3,70 +3,17 @@ mappings:
>    bindgen:
>      Ubuntu2204:
>=20=20
> -  flake8:
> -    OpenSUSELeap15:
> -
>    meson:
> -    OpenSUSELeap15:
>      # Use Meson from PyPI wherever Rust is enabled
>      Debian:
>      Fedora:
>      Ubuntu:
>=20=20
> -  python3:
> -    OpenSUSELeap15: python311-base
> -
> -  python3-PyYAML:
> -    OpenSUSELeap15:
> -
> -  python3-devel:
> -    OpenSUSELeap15: python311-devel
> -
> -  python3-docutils:
> -    OpenSUSELeap15:
> -
> -  python3-numpy:
> -    OpenSUSELeap15:
> -
> -  python3-opencv:
> -    OpenSUSELeap15:
> -
> -  python3-pillow:
> -    OpenSUSELeap15:
> -
> -  python3-pip:
> -    OpenSUSELeap15: python311-pip
> -
> -  python3-pillow:
> -    OpenSUSELeap15:
> -
> -  python3-selinux:
> -    OpenSUSELeap15:
> -
> -  python3-setuptools:
> -    OpenSUSELeap15: python311-setuptools
> -
> -  python3-sphinx:
> -    OpenSUSELeap15:
> -
> -  python3-sphinx-rtd-theme:
> -    OpenSUSELeap15:
> -
> -  python3-sqlite3:
> -    OpenSUSELeap15: python311
> -
>    python3-tomli:
>      # test using tomllib
>      apk:
>      Fedora:
>      Debian12:
> -    OpenSUSELeap15:
> -
> -  python3-venv:
> -    OpenSUSELeap15: python311-base
> -
> -  python3-wheel:
> -    OpenSUSELeap15: python311-wheel
>=20=20
>    rust:
>      Debian12: rustc-web
> @@ -79,12 +26,7 @@ pypi_mappings:
>      default: meson=3D=3D1.8.1
>=20=20
>    # Drop packages that need devel headers
> -  python3-numpy:
> -    OpenSUSELeap15:
> -
> -  # see above
>    python3-tomli:
>      apk:
>      Fedora:
>      Debian12:
> -    OpenSUSELeap15:

I'm unsure about the mappings stuff just because I'm not sure what it is
for. Does it supplement the mappings in libvirt-ci itself?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index 259e6ea0729..79e0b6776c7 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -226,7 +226,7 @@ try:
>      generate_dockerfile("debian", "debian-13",
>                          trailer=3D"".join(debian13_extras))
>      generate_dockerfile("fedora", "fedora-43")
> -    generate_dockerfile("opensuse-leap", "opensuse-leap-15")
> +    generate_dockerfile("opensuse-leap", "opensuse-leap-16")
>      generate_dockerfile("ubuntu2204", "ubuntu-2204",
>                          trailer=3D"".join(ubuntu2204_rust_extras),
>                          # https://bugs.launchpad.net/ubuntu/+source/rust=
c-1.83/+bug/2120318

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

