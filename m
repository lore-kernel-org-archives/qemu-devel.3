Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4853C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtY27-00020o-AE; Mon, 10 Aug 2026 17:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtY25-00020g-RL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:59:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtY23-000251-Km
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:59:45 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47ffaa8ebbdso1896276f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786399182; x=1787003982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cAP0VU2N6KGIzkl9ksBfE7osvjif03UqtxnHqh+NYlo=;
 b=TVekPpL/dQvJ0vhx6JcNoyzrBRIKcHNPidGE6r8NI/LdTMrYT5sxo/cetu9QPSdFUo
 HpCocjmUypYUze/BGbsUQKdtKe5Vn5TViTpMyG8mDLuOhhvHCQ00HjJoPzkzaqm8pSYe
 T+j/CNkZ/r5bxAYifP5clxsiZ5wL2LNFyL+3LpBK+AmtXYExgOgTerVFLfdRaruHF9n7
 nJ/iFadaUrwjJuEGPRQwmahDZOi2nGV2fqwrWn0l3ljZFilD+hK/4e1ouQ2tnQUGqDUV
 ktIDBHuuVlJcZqr59Cl4XtnWmbt1nl4aNHmCfwBcOT4H+YqvhGC9eCxYTUXuhbG/ZopJ
 5R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399182; x=1787003982;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cAP0VU2N6KGIzkl9ksBfE7osvjif03UqtxnHqh+NYlo=;
 b=mrOleppPvXOqa5aHvCAs+iS0jyAfpuO0qrtUtG0cTOoQPJnb5/GSizzvJlJgVFZdMZ
 NP40m1SMMzxnmksseTRvptTXjZxqLVO7a8qtdOfgzmixMDKDc6W5OuLyWgma4M+5z09p
 182E/VZ1pZOo8J4KlhrheGx7VOr41jGH4FjOKFRErQ6cD+HLfhaSc9N4bG19RTqvdW+1
 4I6k6/wp01pDbc9TcpbXw9LowEMHYs/XTpm0tcyhpDqDrWrRQ3ZQzexLu7rWqJjtlU9w
 jfeyuqwgpT5pKNP4z6CRRRZx8jBufGye51xvY0BLSvRgBKmd9qnHpnm0Cfz8XnOFerS8
 Vvsw==
X-Gm-Message-State: AOJu0YwFwNrFHq33mIq907iusTISA08MiyMw2N3nVcMeV2x/hHGfmdEh
 VRQIhGYsZPPh9H55cH4eum1SMniG/DUPNJ9hkB5/AvkL2sBRIimvurEbdzh5JG8pfrU=
X-Gm-Gg: AR+sD13PijAKCCLJaQ5KSv1jwK7ewJzZfutD/ki0b8ySCXREJrixcUvLJ2VSWbCTR9+
 qJEQBkUlJ5FatXEpq9dVQeNGfacOWlHoHIg0d1C5sw9INAD5QRs9QQcMyduacLUEhMwYliMPVof
 ac9fmegnrdYb64I4fMYaXq3fmWc4Y/v68By0hbT7JEVHQZas5jptToZCN4YT2Pxb+n/jpg7Dyfx
 279ZWv3bEg4o4pYEuSpTX2o2OR/aOcWRtsUsgii0MhvqYrCZoRWLTGnMr4TXF7Sjmc4VFM1RT0q
 60Lpyqvv1fKntGTi99E3ryjhiiYJqmr+epRgxR13+yRGy0dGNAXr4FsSMauTurvOljjq1qPL51u
 TquM/oy20Wjgbconl7ko0PA7qp6NMmJwnyk1mFO33HtIyuJs8Pj/8YHo7FaCWjYXdeHwVABvN+d
 ME93WKXrsihqaah7Cs0CaM4TTs4CulQLHL/aTuy+2OpPGmWUISzoA46r/Ea9FB
X-Received: by 2002:a05:6000:41fa:b0:47f:fa17:ae0e with SMTP id
 ffacd0b85a97d-47ffa17ae68mr52725883f8f.11.1786399181771; 
 Mon, 10 Aug 2026 14:59:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f8f33sm43847178f8f.27.2026.08.10.14.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 14:59:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0E685F7F8;
 Mon, 10 Aug 2026 22:59:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 004/103] meson: bump minimal version to 1.6.0
In-Reply-To: <20260728044248.137626-5-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:41:08 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-5-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Mon, 10 Aug 2026 22:59:38 +0100
Message-ID: <87bjb93ad1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Without it, we'll get the following warning:
> WARNING: Project specifies a minimum meson_version '>=3D1.5.0' but uses f=
eatures which were added in newer versions:
>  * 1.6.0: {'test with external_program in args'}
>
> Which we require because of how we build iteratively our test command
> line.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  meson.build                                                   | 4 ++--
>  pythondeps.toml                                               | 2 +-
>  subprojects/packagefiles/anyhow-1-rs/meson.build              | 2 +-
>  subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 2 +-
>  subprojects/packagefiles/attrs-0.2-rs/meson.build             | 2 +-
>  subprojects/packagefiles/bilge-0.2-rs/meson.build             | 2 +-
>  subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
>  subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
>  subprojects/packagefiles/foreign-0.3-rs/meson.build           | 2 +-
>  subprojects/packagefiles/glib-sys-0.21-rs/meson.build         | 2 +-
>  subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
>  subprojects/packagefiles/libc-0.2-rs/meson.build              | 2 +-
>  subprojects/packagefiles/probe-0.5-rs/meson.build             | 2 +-
>  subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
>  .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
>  subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
>  subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
>  subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
>  subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 2 +-
>  19 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 49a5baf5b52..d59c86ab2bc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1,4 +1,4 @@
> -project('qemu', ['c'], meson_version: '>=3D1.5.0',
> +project('qemu', ['c'], meson_version: '>=3D1.6.0',
>          default_options: ['warning_level=3D1', 'c_std=3Dgnu11', 'cpp_std=
=3Dgnu++23', 'b_colorout=3Dauto',
>                            'b_staticpic=3Dfalse', 'stdsplit=3Dfalse', 'op=
timization=3D2', 'b_pie=3Dtrue'] +
>=20=20
> @@ -1385,7 +1385,7 @@ if not get_option('zstd').auto() or have_block
>  endif
>  qpl =3D not_found
>  if not get_option('qpl').auto() or have_system
> -  qpl =3D dependency('qpl', version: '>=3D1.5.0',
> +  qpl =3D dependency('qpl', version: '>=3D1.6.0',
>                      required: get_option('qpl'),
>                      method: 'pkg-config')

How is this a meson dependency?

>  endif
> diff --git a/pythondeps.toml b/pythondeps.toml
> index bef88d49a6e..e2ee450ba68 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -19,7 +19,7 @@
>=20=20
>  [meson]
>  # The install key should match the version in python/wheels/
> -meson =3D { accepted =3D ">=3D1.5.0", installed =3D "1.11.1", canary =3D=
 "meson" }
> +meson =3D { accepted =3D ">=3D1.6.0", installed =3D "1.11.1", canary =3D=
 "meson" }
>  pycotap =3D { accepted =3D ">=3D1.1.0", installed =3D "1.3.1" }
>=20=20
>  [meson-rust]
> diff --git a/subprojects/packagefiles/anyhow-1-rs/meson.build b/subprojec=
ts/packagefiles/anyhow-1-rs/meson.build
> index 348bab98b9f..e82b1f20bb4 100644
> --- a/subprojects/packagefiles/anyhow-1-rs/meson.build
> +++ b/subprojects/packagefiles/anyhow-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('anyhow-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.0.98',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/su=
bprojects/packagefiles/arbitrary-int-1-rs/meson.build
> index 00733d1faab..267357fa912 100644
> --- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> +++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('arbitrary-int-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.2.7',
>    license: 'MIT',
>    default_options: [])
> diff --git a/subprojects/packagefiles/attrs-0.2-rs/meson.build b/subproje=
cts/packagefiles/attrs-0.2-rs/meson.build
> index ee575476cb2..9b76fe0f73e 100644
> --- a/subprojects/packagefiles/attrs-0.2-rs/meson.build
> +++ b/subprojects/packagefiles/attrs-0.2-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('attrs-0.2-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '0.2.9',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subproje=
cts/packagefiles/bilge-0.2-rs/meson.build
> index ce13d0fe80f..4d4c9bde404 100644
> --- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
> +++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
> @@ -1,7 +1,7 @@
>  project(
>    'bilge-0.2-rs',
>    'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version : '0.2.0',
>    license : 'MIT or Apache-2.0',
>  )
> diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/sub=
projects/packagefiles/bilge-impl-0.2-rs/meson.build
> index 04617b875c5..57bdf30ba05 100644
> --- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> +++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('bilge-impl-0.2-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '0.2.0',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojec=
ts/packagefiles/either-1-rs/meson.build
> index 04c96cc5fb3..d869201e43e 100644
> --- a/subprojects/packagefiles/either-1-rs/meson.build
> +++ b/subprojects/packagefiles/either-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('either-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.12.0',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/foreign-0.3-rs/meson.build b/subpro=
jects/packagefiles/foreign-0.3-rs/meson.build
> index 0901c02c527..80e68967ab4 100644
> --- a/subprojects/packagefiles/foreign-0.3-rs/meson.build
> +++ b/subprojects/packagefiles/foreign-0.3-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('foreign-0.3-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '0.2.0',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build b/subp=
rojects/packagefiles/glib-sys-0.21-rs/meson.build
> index 8c5483311ed..b9ceb12463f 100644
> --- a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
> +++ b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('glib-sys-0.21-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '0.21.2',
>    license: 'MIT',
>    default_options: [])
> diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/sub=
projects/packagefiles/itertools-0.11-rs/meson.build
> index 2a3fbe9ee5a..3081639890b 100644
> --- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
> +++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('itertools-0.11-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '0.11.0',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/libc-0.2-rs/meson.build b/subprojec=
ts/packagefiles/libc-0.2-rs/meson.build
> index ac4f80dba98..d1a9da194da 100644
> --- a/subprojects/packagefiles/libc-0.2-rs/meson.build
> +++ b/subprojects/packagefiles/libc-0.2-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('libc-0.2-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '0.2.162',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/probe-0.5-rs/meson.build b/subproje=
cts/packagefiles/probe-0.5-rs/meson.build
> index e6ea69533b7..1d33800cde2 100644
> --- a/subprojects/packagefiles/probe-0.5-rs/meson.build
> +++ b/subprojects/packagefiles/probe-0.5-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('probe-0.5-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '0.5.2',
>    license: 'Apache-2.0 OR MIT',
>    default_options: [])
> diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b=
/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> index 8ba558e1330..523572173c7 100644
> --- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> +++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('proc-macro-error-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.0.4',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.bu=
ild b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> index a85d7c07143..85f190e56e0 100644
> --- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> +++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('proc-macro-error-attr-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.12.0',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subp=
rojects/packagefiles/proc-macro2-1-rs/meson.build
> index ba7de070292..7cb4f93bb08 100644
> --- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> +++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('proc-macro2-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.0.95',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subproject=
s/packagefiles/quote-1-rs/meson.build
> index bf41fad99bb..fdd549e7648 100644
> --- a/subprojects/packagefiles/quote-1-rs/meson.build
> +++ b/subprojects/packagefiles/quote-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('quote-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.12.0',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/=
packagefiles/syn-2-rs/meson.build
> index 3e6dc318a9c..a7baa6feff4 100644
> --- a/subprojects/packagefiles/syn-2-rs/meson.build
> +++ b/subprojects/packagefiles/syn-2-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('syn-2-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '2.0.104',
>    license: 'MIT OR Apache-2.0',
>    default_options: [])
> diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/su=
bprojects/packagefiles/unicode-ident-1-rs/meson.build
> index 11a5dab97df..ee483e13423 100644
> --- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
> +++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
> @@ -1,5 +1,5 @@
>  project('unicode-ident-1-rs', 'rust',
> -  meson_version: '>=3D1.5.0',
> +  meson_version: '>=3D1.6.0',
>    version: '1.0.12',
>    license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
>    default_options: [])

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

