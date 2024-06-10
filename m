Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBEBC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH27h-00068m-Vb; Tue, 11 Jun 2024 10:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sH27g-00064B-6N
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sH27d-0001h7-CX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718114712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2M+dHD96/lMWIWyGASaHaR6zpBSFaWqoiFch//LoSQ=;
 b=RTxVjoczFb8RiaeL9XY5PmNbQqavVUtfDCJ1EHQSSxfZBDLgCaTigQAz1jjnWG01LpIznb
 /mQfR0mDlDvwPNAEQoATavzBfGTK/7nM6njP+OzGH18pC6ZXcqdFR0wZ/W1QJm7UmHyq37
 bIhPOfoLfde9NyOcVisOKHlTPqrAGnI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-FBqLOHc4NDKRdCCcr4X9_Q-1; Tue,
 11 Jun 2024 10:05:09 -0400
X-MC-Unique: FBqLOHc4NDKRdCCcr4X9_Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8BAB1954B09; Tue, 11 Jun 2024 14:05:05 +0000 (UTC)
Received: from localhost (unknown [10.39.193.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1489F1954B15; Tue, 11 Jun 2024 14:05:01 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:25:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v1 1/6] build-sys: Add rust feature option
Message-ID: <20240610192517.GA350256@fedora>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <0933b669c8e47e1a78d21e56881e0933ef910461.1718040303.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mK4Fl3jW8aqeMJI1"
Content-Disposition: inline
In-Reply-To: <0933b669c8e47e1a78d21e56881e0933ef910461.1718040303.git.manos.pitsidianakis@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 21
X-Spam_score: 2.1
X-Spam_bar: ++
X-Spam_report: (2.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.141, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--mK4Fl3jW8aqeMJI1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 09:22:36PM +0300, Manos Pitsidianakis wrote:
> Add options for Rust in meson_options.txt, meson.build, configure to
> prepare for adding Rust code in the followup commits.
>=20
> `rust` is a reserved meson name, so we have to use an alternative.
> `with_rust` was chosen.
>=20
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> The cargo wrapper script hardcodes some rust target triples. This is=20
> just temporary.
> ---
>  .gitignore               |   2 +
>  configure                |  12 +++
>  meson.build              |  11 ++
>  meson_options.txt        |   4 +
>  scripts/cargo_wrapper.py | 211 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 240 insertions(+)
>  create mode 100644 scripts/cargo_wrapper.py
>=20
> diff --git a/.gitignore b/.gitignore
> index 61fa39967b..f42b0d937e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,6 +2,8 @@
>  /build/
>  /.cache/
>  /.vscode/
> +/target/
> +rust/**/target

Are these necessary since the cargo build command-line below uses
--target-dir <meson-build-dir>?

Adding new build output directories outside build/ makes it harder to
clean up the source tree and ensure no state from previous builds
remains.

>  *.pyc
>  .sdk
>  .stgit-*
> diff --git a/configure b/configure
> index 38ee257701..c195630771 100755
> --- a/configure
> +++ b/configure
> @@ -302,6 +302,9 @@ else
>    objcc=3D"${objcc-${cross_prefix}clang}"
>  fi
> =20
> +with_rust=3D"auto"
> +with_rust_target_triple=3D""
> +
>  ar=3D"${AR-${cross_prefix}ar}"
>  as=3D"${AS-${cross_prefix}as}"
>  ccas=3D"${CCAS-$cc}"
> @@ -760,6 +763,12 @@ for opt do
>    ;;
>    --gdb=3D*) gdb_bin=3D"$optarg"
>    ;;
> +  --enable-rust) with_rust=3Denabled
> +  ;;
> +  --disable-rust) with_rust=3Ddisabled
> +  ;;
> +  --rust-target-triple=3D*) with_rust_target_triple=3D"$optarg"
> +  ;;
>    # everything else has the same name in configure and meson
>    --*) meson_option_parse "$opt" "$optarg"
>    ;;
> @@ -1796,6 +1805,9 @@ if test "$skip_meson" =3D no; then
>    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_eng=
ine=3D$LIB_FUZZING_ENGINE"
>    test "$plugins" =3D yes && meson_option_add "-Dplugins=3Dtrue"
>    test "$tcg" !=3D enabled && meson_option_add "-Dtcg=3D$tcg"
> +  test "$with_rust" !=3D enabled && meson_option_add "-Dwith_rust=3D$wit=
h_rust"
> +  test "$with_rust" !=3D enabled && meson_option_add "-Dwith_rust=3D$wit=
h_rust"

Duplicate line.

> +  test "$with_rust_target_triple" !=3D "" && meson_option_add "-Dwith_ru=
st_target_triple=3D$with_rust_target_triple"
>    run_meson() {
>      NINJA=3D$ninja $meson setup "$@" "$PWD" "$source_path"
>    }
> diff --git a/meson.build b/meson.build
> index a9de71d450..3533889852 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -290,6 +290,12 @@ foreach lang : all_languages
>    endif
>  endforeach
> =20
> +cargo =3D not_found
> +if get_option('with_rust').allowed()
> +  cargo =3D find_program('cargo', required: get_option('with_rust'))
> +endif
> +with_rust =3D cargo.found()
> +
>  # default flags for all hosts
>  # We use -fwrapv to tell the compiler that we require a C dialect where
>  # left shift of signed integers is well defined and has the expected
> @@ -2066,6 +2072,7 @@ endif
> =20
>  config_host_data =3D configuration_data()
> =20
> +config_host_data.set('CONFIG_WITH_RUST', with_rust)
>  audio_drivers_selected =3D []
>  if have_system
>    audio_drivers_available =3D {
> @@ -4190,6 +4197,10 @@ if 'objc' in all_languages
>  else
>    summary_info +=3D {'Objective-C compiler': false}
>  endif
> +summary_info +=3D {'Rust support':      with_rust}
> +if with_rust and get_option('with_rust_target_triple') !=3D ''
> +  summary_info +=3D {'Rust target':     get_option('with_rust_target_tri=
ple')}
> +endif
>  option_cflags =3D (get_option('debug') ? ['-g'] : [])
>  if get_option('optimization') !=3D 'plain'
>    option_cflags +=3D ['-O' + get_option('optimization')]
> diff --git a/meson_options.txt b/meson_options.txt
> index 4c1583eb40..223491b731 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -366,3 +366,7 @@ option('qemu_ga_version', type: 'string', value: '',
> =20
>  option('hexagon_idef_parser', type : 'boolean', value : true,
>         description: 'use idef-parser to automatically generate TCG code =
for the Hexagon frontend')
> +option('with_rust', type: 'feature', value: 'auto',
> +       description: 'Enable Rust support')
> +option('with_rust_target_triple', type : 'string', value: '',
> +       description: 'Rust target triple')
> diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
> new file mode 100644
> index 0000000000..d338effdaa
> --- /dev/null
> +++ b/scripts/cargo_wrapper.py
> @@ -0,0 +1,211 @@
> +#!/usr/bin/env python3
> +# Copyright (c) 2020 Red Hat, Inc.
> +# Copyright (c) 2023 Linaro Ltd.
> +#
> +# Authors:
> +#  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import argparse
> +import configparser
> +import distutils.file_util
> +import json
> +import logging
> +import os
> +import os.path
> +import re
> +import subprocess
> +import sys
> +import pathlib
> +import shutil
> +import tomllib
> +
> +from pathlib import Path
> +from typing import Any, Dict, List, Tuple
> +
> +RUST_TARGET_TRIPLES =3D (
> +    "aarch64-unknown-linux-gnu",
> +    "x86_64-unknown-linux-gnu",
> +    "x86_64-apple-darwin",
> +    "aarch64-apple-darwin",
> +)

Is this hardcoded to avoid calling `rustc --print target-list`?

Or is this the support matrix? In that case it would be interesting to
figure out the target triples for all host OSes and CPUs that QEMU is
supported on.

> +
> +
> +def cfg_name(name: str) -> str:
> +    if (
> +        name.startswith("CONFIG_")
> +        or name.startswith("TARGET_")
> +        or name.startswith("HAVE_")
> +    ):
> +        return name
> +    return ""
> +
> +
> +def generate_cfg_flags(header: str) -> List[str]:
> +    with open(header, encoding=3D"utf-8") as cfg:
> +        config =3D [l.split()[1:] for l in cfg if l.startswith("#define"=
)]
> +
> +    cfg_list =3D []
> +    for cfg in config:
> +        name =3D cfg_name(cfg[0])
> +        if not name:
> +            continue
> +        if len(cfg) >=3D 2 and cfg[1] !=3D "1":
> +            continue
> +        cfg_list.append("--cfg")
> +        cfg_list.append(name)
> +    return cfg_list
> +
> +
> +def cargo_target_dir(args: argparse.Namespace) -> pathlib.Path:
> +    return args.meson_build_dir
> +
> +
> +def manifest_path(args: argparse.Namespace) -> pathlib.Path:
> +    return args.crate_dir / "Cargo.toml"
> +
> +
> +def get_cargo_rustc(args: argparse.Namespace) -> tuple[Dict[str, Any], L=
ist[str]]:
> +    # See https://doc.rust-lang.org/cargo/reference/environment-variable=
s.html
> +    # Item `CARGO_ENCODED_RUSTFLAGS =E2=80=94 A list of custom flags sep=
arated by
> +    # 0x1f (ASCII Unit Separator) to pass to all compiler invocations th=
at Cargo
> +    # performs`
> +    cfg =3D chr(0x1F).join(
> +        [c for h in args.config_headers for c in generate_cfg_flags(h)]
> +    )
> +    target_dir =3D cargo_target_dir(args)
> +    cargo_path =3D manifest_path(args)
> +
> +    cargo_cmd =3D [
> +        "cargo",
> +        "build",
> +        "--target-dir",
> +        str(target_dir),
> +        "--manifest-path",
> +        str(cargo_path),
> +    ]
> +    if args.target_triple:
> +        cargo_cmd +=3D ["--target", args.target_triple]
> +    if args.profile =3D=3D "release":
> +        cargo_cmd +=3D ["--release"]
> +
> +    env =3D os.environ
> +    env["CARGO_ENCODED_RUSTFLAGS"] =3D cfg
> +
> +    return (env, cargo_cmd)
> +
> +
> +def run_cargo(env: Dict[str, Any], cargo_cmd: List[str]) -> str:
> +    envlog =3D " ".join(["{}=3D{}".format(k, v) for k, v in env.items()])
> +    cmdlog =3D " ".join(cargo_cmd)
> +    logging.debug("Running %s %s", envlog, cmdlog)
> +    try:
> +        out =3D subprocess.check_output(
> +            cargo_cmd,
> +            env=3Ddict(os.environ, **env),
> +            stderr=3Dsubprocess.STDOUT,
> +            universal_newlines=3DTrue,
> +        )
> +    except subprocess.CalledProcessError as err:
> +        print("Environment: " + envlog)
> +        print("Command: " + cmdlog)
> +        print(err.output)
> +        sys.exit(1)
> +
> +    return out
> +
> +
> +def build_lib(args: argparse.Namespace) -> None:
> +    logging.debug("build-lib")
> +    target_dir =3D cargo_target_dir(args)
> +    cargo_toml_path =3D manifest_path(args)
> +
> +    with open(cargo_toml_path, "rb") as f:
> +        config =3D tomllib.load(f)
> +
> +    package_name =3D config["package"]["name"].strip('"').replace("-", "=
_")
> +
> +    liba_filename =3D "lib" + package_name + ".a"
> +    liba =3D target_dir / args.target_triple / args.profile / liba_filen=
ame
> +
> +    env, cargo_cmd =3D get_cargo_rustc(args)
> +    out =3D run_cargo(env, cargo_cmd)
> +    logging.debug("cp %s %s", liba, args.outdir)
> +    shutil.copy2(liba, args.outdir)
> +
> +
> +def main() -> None:
> +    parser =3D argparse.ArgumentParser()
> +    parser.add_argument("-v", "--verbose", action=3D"store_true")
> +    parser.add_argument(
> +        "--color",
> +        metavar=3D"WHEN",
> +        choices=3D["auto", "always", "never"],
> +        default=3D"auto",
> +        help=3D"Coloring: auto, always, never",
> +    )
> +    parser.add_argument(
> +        "--config-headers",
> +        metavar=3D"CONFIG_HEADER",
> +        action=3D"append",
> +        dest=3D"config_headers",
> +        required=3DFalse,
> +        default=3D[],
> +    )
> +    parser.add_argument(
> +        "--meson-build-dir",
> +        metavar=3D"BUILD_DIR",
> +        help=3D"meson.current_build_dir()",
> +        type=3Dpathlib.Path,
> +        dest=3D"meson_build_dir",
> +        required=3DTrue,
> +    )
> +    parser.add_argument(
> +        "--meson-source-dir",
> +        metavar=3D"SOURCE_DIR",
> +        help=3D"meson.current_source_dir()",
> +        type=3Dpathlib.Path,
> +        dest=3D"meson_source_dir",
> +        required=3DTrue,
> +    )
> +    parser.add_argument(
> +        "--crate-dir",
> +        metavar=3D"CRATE_DIR",
> +        type=3Dpathlib.Path,
> +        dest=3D"crate_dir",
> +        help=3D"Absolute path that contains the manifest file of the cra=
te to compile",
> +        required=3DTrue,
> +    )
> +    parser.add_argument(
> +        "--outdir",
> +        metavar=3D"OUTDIR",
> +        type=3Dpathlib.Path,
> +        dest=3D"outdir",
> +        help=3D"Path to copy compiled artifacts to for Meson to use.",
> +        required=3DTrue,
> +    )
> +    parser.add_argument(
> +        "--profile", type=3Dstr, choices=3D["release", "debug"], require=
d=3DTrue
> +    )
> +    parser.add_argument(
> +        "--target-triple", type=3Dstr, choices=3DRUST_TARGET_TRIPLES, re=
quired=3DTrue
> +    )
> +
> +    subparsers =3D parser.add_subparsers()
> +
> +    buildlib =3D subparsers.add_parser("build-lib")
> +    buildlib.set_defaults(func=3Dbuild_lib)
> +
> +    args =3D parser.parse_args()
> +    if args.verbose:
> +        logging.basicConfig(level=3Dlogging.DEBUG)
> +    logging.debug("args: %s", args)
> +
> +    args.func(args)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> --=20
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>=20

--mK4Fl3jW8aqeMJI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmZnUx0ACgkQnKSrs4Gr
c8iABwf/T4Lo2FCF+bj4WNWAGktzNQlLEYg7cv7SFOeU77+WlkrBQcTGMFPQ2UD+
Nh73PrEkWXxi/mh1Xk2RyAQm57+s94z1bsSd6/h0MCNTs32Q7/+18k++pagiX9v6
3r9TN4lIa4rrpnnMlG66r+9mUpuELY+lLguqzNXC+MUfuK28zl8KTXEa/WGeWdLd
g9lesIhRByxHLwcQwwtGdwdXbcS05WG68DD6Q3HbifzIECO86+e4BK9hZQVW+uQP
0/0VmrsGTiQ95DmsL2QubTCQKDV9eOoLfXyfNx4SPqW2718LITyy5XD8chHcS60Q
93YhwQ1ZGGsw9bx4RdlCSG7bxltObg==
=KMbq
-----END PGP SIGNATURE-----

--mK4Fl3jW8aqeMJI1--


