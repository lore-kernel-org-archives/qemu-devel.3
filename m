Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A529DC27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5hL-0001d5-Ob; Tue, 11 Jun 2024 13:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH5hK-0001cs-LH
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:54:18 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH5hI-0003dA-87
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:54:18 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so852666066b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718128454; x=1718733254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xut2gU7er7J+z0AnW5cENRLGbkl8J0glYhBxudJHCpg=;
 b=fqMA0Ds8lPs/PY8wrFsj0cGgX6ZoAqGUb1Ilt6hmuOmLmoKYubt4qG4fFIiY0NcWEa
 LmQZ/zP87KQ/tEuQhx06vh0xQqVBTvbmZ4pJk92k+Qj2HTzl7obmrjL31TCy3bc7wK9B
 a3bTKKBpAmOUB/YdlKZFzSxjrMgoP3wWE7V7cFB2RvPfiGhCbwjFaP17fF4D05b+hKJd
 UwoeRZjKcEzz5k5OlTDlw3KsUvWI6c2yWM5fTVNV4d8Q/JCIEA2FytBJTYynU33BrlV9
 9ttGhFsPM1K+JFO5pErag1IVlD8AS0C3GEOi8TAOl36q1mE339BUrCMaTCnZ4kLb9zfm
 XZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718128454; x=1718733254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xut2gU7er7J+z0AnW5cENRLGbkl8J0glYhBxudJHCpg=;
 b=ZYwR2qaZw76RZbLzIvkty2ueHuTdmvknO/x8HavdlTNWAuiL1IMf7SUbzXOsPdv+1w
 ATl8vtH4IwrFiMGRZujDUUwoHrS3e2uoaQJgrZd9j9tvyuj9qJoiZLe/uf3TrdwAoXnM
 zqVvAQDXZ/wSqFAy8M3ddoCt1V92ia2ByC2HUShWWtZpUXU8F3DlJqnRtuuX/EfNMAvA
 28QP45yIt1U9F8lc/MBn0vhdu9LvI+QvYFrp7IxhFpN43WhMpsVCvLUeRpAKz+CZ8B6L
 2WpinkFa8VxaQ68snrUOhOHAJXFAFUwSTBnooV3yl996fy1A6KbcoT+/Na65zCfP9pSu
 6ZZA==
X-Gm-Message-State: AOJu0Yy7A3/COJR5ttVRYNr9u3le59I6/yshRwwcXp2uzvtGVzY6ViKt
 tZBCrXOm0SzJo0VRbkWveFUVdjC3sl3hMDSYzb+m/VS9GAq7i00giYzaDfcfU9piIrFYOwrSQpa
 MxhHMqxNehPB6J24KP/aNeyv77d1EqYsWm0/FCQ==
X-Google-Smtp-Source: AGHT+IEzCpWOIzGl2v5eTn91W5BbtyR3shrscOIywKTrnvTv0r3O+tiyP3kjzcxQTpiYtnKttN9XTiagButgXdAakzw=
X-Received: by 2002:a17:906:b816:b0:a6f:392d:51a9 with SMTP id
 a640c23a62f3a-a6f392d52c2mr159918966b.14.1718128454361; Tue, 11 Jun 2024
 10:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <0933b669c8e47e1a78d21e56881e0933ef910461.1718040303.git.manos.pitsidianakis@linaro.org>
 <20240610192517.GA350256@fedora>
In-Reply-To: <20240610192517.GA350256@fedora>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 11 Jun 2024 20:53:58 +0300
Message-ID: <CAAjaMXZ9bBtNyrjhUy=ypFeVYuo7ctHbaro6VCKins7-3M9e=g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/6] build-sys: Add rust feature option
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 11 Jun 2024 at 17:05, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Jun 10, 2024 at 09:22:36PM +0300, Manos Pitsidianakis wrote:
> > Add options for Rust in meson_options.txt, meson.build, configure to
> > prepare for adding Rust code in the followup commits.
> >
> > `rust` is a reserved meson name, so we have to use an alternative.
> > `with_rust` was chosen.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> > The cargo wrapper script hardcodes some rust target triples. This is
> > just temporary.
> > ---
> >  .gitignore               |   2 +
> >  configure                |  12 +++
> >  meson.build              |  11 ++
> >  meson_options.txt        |   4 +
> >  scripts/cargo_wrapper.py | 211 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 240 insertions(+)
> >  create mode 100644 scripts/cargo_wrapper.py
> >
> > diff --git a/.gitignore b/.gitignore
> > index 61fa39967b..f42b0d937e 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -2,6 +2,8 @@
> >  /build/
> >  /.cache/
> >  /.vscode/
> > +/target/
> > +rust/**/target
>
> Are these necessary since the cargo build command-line below uses
> --target-dir <meson-build-dir>?
>
> Adding new build output directories outside build/ makes it harder to
> clean up the source tree and ensure no state from previous builds
> remains.

Agreed! These build directories would show up when using cargo
directly instead of through the cargo_wrapper.py script, i.e. during
development. I'd consider it an edge case, it won't happen much and if
it does it's better to gitignore them than accidentally checking them
in. Also, whatever artifacts are in a `target` directory won't be used
for compilation with qemu inside a build directory.


> >  *.pyc
> >  .sdk
> >  .stgit-*
> > diff --git a/configure b/configure
> > index 38ee257701..c195630771 100755
> > --- a/configure
> > +++ b/configure
> > @@ -302,6 +302,9 @@ else
> >    objcc=3D"${objcc-${cross_prefix}clang}"
> >  fi
> >
> > +with_rust=3D"auto"
> > +with_rust_target_triple=3D""
> > +
> >  ar=3D"${AR-${cross_prefix}ar}"
> >  as=3D"${AS-${cross_prefix}as}"
> >  ccas=3D"${CCAS-$cc}"
> > @@ -760,6 +763,12 @@ for opt do
> >    ;;
> >    --gdb=3D*) gdb_bin=3D"$optarg"
> >    ;;
> > +  --enable-rust) with_rust=3Denabled
> > +  ;;
> > +  --disable-rust) with_rust=3Ddisabled
> > +  ;;
> > +  --rust-target-triple=3D*) with_rust_target_triple=3D"$optarg"
> > +  ;;
> >    # everything else has the same name in configure and meson
> >    --*) meson_option_parse "$opt" "$optarg"
> >    ;;
> > @@ -1796,6 +1805,9 @@ if test "$skip_meson" =3D no; then
> >    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_e=
ngine=3D$LIB_FUZZING_ENGINE"
> >    test "$plugins" =3D yes && meson_option_add "-Dplugins=3Dtrue"
> >    test "$tcg" !=3D enabled && meson_option_add "-Dtcg=3D$tcg"
> > +  test "$with_rust" !=3D enabled && meson_option_add "-Dwith_rust=3D$w=
ith_rust"
> > +  test "$with_rust" !=3D enabled && meson_option_add "-Dwith_rust=3D$w=
ith_rust"
>
> Duplicate line.

Thanks!

>
> > +  test "$with_rust_target_triple" !=3D "" && meson_option_add "-Dwith_=
rust_target_triple=3D$with_rust_target_triple"
> >    run_meson() {
> >      NINJA=3D$ninja $meson setup "$@" "$PWD" "$source_path"
> >    }
> > diff --git a/meson.build b/meson.build
> > index a9de71d450..3533889852 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -290,6 +290,12 @@ foreach lang : all_languages
> >    endif
> >  endforeach
> >
> > +cargo =3D not_found
> > +if get_option('with_rust').allowed()
> > +  cargo =3D find_program('cargo', required: get_option('with_rust'))
> > +endif
> > +with_rust =3D cargo.found()
> > +
> >  # default flags for all hosts
> >  # We use -fwrapv to tell the compiler that we require a C dialect wher=
e
> >  # left shift of signed integers is well defined and has the expected
> > @@ -2066,6 +2072,7 @@ endif
> >
> >  config_host_data =3D configuration_data()
> >
> > +config_host_data.set('CONFIG_WITH_RUST', with_rust)
> >  audio_drivers_selected =3D []
> >  if have_system
> >    audio_drivers_available =3D {
> > @@ -4190,6 +4197,10 @@ if 'objc' in all_languages
> >  else
> >    summary_info +=3D {'Objective-C compiler': false}
> >  endif
> > +summary_info +=3D {'Rust support':      with_rust}
> > +if with_rust and get_option('with_rust_target_triple') !=3D ''
> > +  summary_info +=3D {'Rust target':     get_option('with_rust_target_t=
riple')}
> > +endif
> >  option_cflags =3D (get_option('debug') ? ['-g'] : [])
> >  if get_option('optimization') !=3D 'plain'
> >    option_cflags +=3D ['-O' + get_option('optimization')]
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 4c1583eb40..223491b731 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -366,3 +366,7 @@ option('qemu_ga_version', type: 'string', value: ''=
,
> >
> >  option('hexagon_idef_parser', type : 'boolean', value : true,
> >         description: 'use idef-parser to automatically generate TCG cod=
e for the Hexagon frontend')
> > +option('with_rust', type: 'feature', value: 'auto',
> > +       description: 'Enable Rust support')
> > +option('with_rust_target_triple', type : 'string', value: '',
> > +       description: 'Rust target triple')
> > diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
> > new file mode 100644
> > index 0000000000..d338effdaa
> > --- /dev/null
> > +++ b/scripts/cargo_wrapper.py
> > @@ -0,0 +1,211 @@
> > +#!/usr/bin/env python3
> > +# Copyright (c) 2020 Red Hat, Inc.
> > +# Copyright (c) 2023 Linaro Ltd.
> > +#
> > +# Authors:
> > +#  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > +#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +import argparse
> > +import configparser
> > +import distutils.file_util
> > +import json
> > +import logging
> > +import os
> > +import os.path
> > +import re
> > +import subprocess
> > +import sys
> > +import pathlib
> > +import shutil
> > +import tomllib
> > +
> > +from pathlib import Path
> > +from typing import Any, Dict, List, Tuple
> > +
> > +RUST_TARGET_TRIPLES =3D (
> > +    "aarch64-unknown-linux-gnu",
> > +    "x86_64-unknown-linux-gnu",
> > +    "x86_64-apple-darwin",
> > +    "aarch64-apple-darwin",
> > +)
>
> Is this hardcoded to avoid calling `rustc --print target-list`?
>
> Or is this the support matrix? In that case it would be interesting to
> figure out the target triples for all host OSes and CPUs that QEMU is
> supported on.

Yes, it's what I tested it on (the x86-64-apple-darwin part through rosetta=
).

Do you think running -print target-list would be a better choice here?
This is only for providing the valid choices for the target triplet
CLI argument in argparse.


>
> > +
> > +
> > +def cfg_name(name: str) -> str:
> > +    if (
> > +        name.startswith("CONFIG_")
> > +        or name.startswith("TARGET_")
> > +        or name.startswith("HAVE_")
> > +    ):
> > +        return name
> > +    return ""
> > +
> > +
> > +def generate_cfg_flags(header: str) -> List[str]:
> > +    with open(header, encoding=3D"utf-8") as cfg:
> > +        config =3D [l.split()[1:] for l in cfg if l.startswith("#defin=
e")]
> > +
> > +    cfg_list =3D []
> > +    for cfg in config:
> > +        name =3D cfg_name(cfg[0])
> > +        if not name:
> > +            continue
> > +        if len(cfg) >=3D 2 and cfg[1] !=3D "1":
> > +            continue
> > +        cfg_list.append("--cfg")
> > +        cfg_list.append(name)
> > +    return cfg_list
> > +
> > +
> > +def cargo_target_dir(args: argparse.Namespace) -> pathlib.Path:
> > +    return args.meson_build_dir
> > +
> > +
> > +def manifest_path(args: argparse.Namespace) -> pathlib.Path:
> > +    return args.crate_dir / "Cargo.toml"
> > +
> > +
> > +def get_cargo_rustc(args: argparse.Namespace) -> tuple[Dict[str, Any],=
 List[str]]:
> > +    # See https://doc.rust-lang.org/cargo/reference/environment-variab=
les.html
> > +    # Item `CARGO_ENCODED_RUSTFLAGS =E2=80=94 A list of custom flags s=
eparated by
> > +    # 0x1f (ASCII Unit Separator) to pass to all compiler invocations =
that Cargo
> > +    # performs`
> > +    cfg =3D chr(0x1F).join(
> > +        [c for h in args.config_headers for c in generate_cfg_flags(h)=
]
> > +    )
> > +    target_dir =3D cargo_target_dir(args)
> > +    cargo_path =3D manifest_path(args)
> > +
> > +    cargo_cmd =3D [
> > +        "cargo",
> > +        "build",
> > +        "--target-dir",
> > +        str(target_dir),
> > +        "--manifest-path",
> > +        str(cargo_path),
> > +    ]
> > +    if args.target_triple:
> > +        cargo_cmd +=3D ["--target", args.target_triple]
> > +    if args.profile =3D=3D "release":
> > +        cargo_cmd +=3D ["--release"]
> > +
> > +    env =3D os.environ
> > +    env["CARGO_ENCODED_RUSTFLAGS"] =3D cfg
> > +
> > +    return (env, cargo_cmd)
> > +
> > +
> > +def run_cargo(env: Dict[str, Any], cargo_cmd: List[str]) -> str:
> > +    envlog =3D " ".join(["{}=3D{}".format(k, v) for k, v in env.items(=
)])
> > +    cmdlog =3D " ".join(cargo_cmd)
> > +    logging.debug("Running %s %s", envlog, cmdlog)
> > +    try:
> > +        out =3D subprocess.check_output(
> > +            cargo_cmd,
> > +            env=3Ddict(os.environ, **env),
> > +            stderr=3Dsubprocess.STDOUT,
> > +            universal_newlines=3DTrue,
> > +        )
> > +    except subprocess.CalledProcessError as err:
> > +        print("Environment: " + envlog)
> > +        print("Command: " + cmdlog)
> > +        print(err.output)
> > +        sys.exit(1)
> > +
> > +    return out
> > +
> > +
> > +def build_lib(args: argparse.Namespace) -> None:
> > +    logging.debug("build-lib")
> > +    target_dir =3D cargo_target_dir(args)
> > +    cargo_toml_path =3D manifest_path(args)
> > +
> > +    with open(cargo_toml_path, "rb") as f:
> > +        config =3D tomllib.load(f)
> > +
> > +    package_name =3D config["package"]["name"].strip('"').replace("-",=
 "_")
> > +
> > +    liba_filename =3D "lib" + package_name + ".a"
> > +    liba =3D target_dir / args.target_triple / args.profile / liba_fil=
ename
> > +
> > +    env, cargo_cmd =3D get_cargo_rustc(args)
> > +    out =3D run_cargo(env, cargo_cmd)
> > +    logging.debug("cp %s %s", liba, args.outdir)
> > +    shutil.copy2(liba, args.outdir)
> > +
> > +
> > +def main() -> None:
> > +    parser =3D argparse.ArgumentParser()
> > +    parser.add_argument("-v", "--verbose", action=3D"store_true")
> > +    parser.add_argument(
> > +        "--color",
> > +        metavar=3D"WHEN",
> > +        choices=3D["auto", "always", "never"],
> > +        default=3D"auto",
> > +        help=3D"Coloring: auto, always, never",
> > +    )
> > +    parser.add_argument(
> > +        "--config-headers",
> > +        metavar=3D"CONFIG_HEADER",
> > +        action=3D"append",
> > +        dest=3D"config_headers",
> > +        required=3DFalse,
> > +        default=3D[],
> > +    )
> > +    parser.add_argument(
> > +        "--meson-build-dir",
> > +        metavar=3D"BUILD_DIR",
> > +        help=3D"meson.current_build_dir()",
> > +        type=3Dpathlib.Path,
> > +        dest=3D"meson_build_dir",
> > +        required=3DTrue,
> > +    )
> > +    parser.add_argument(
> > +        "--meson-source-dir",
> > +        metavar=3D"SOURCE_DIR",
> > +        help=3D"meson.current_source_dir()",
> > +        type=3Dpathlib.Path,
> > +        dest=3D"meson_source_dir",
> > +        required=3DTrue,
> > +    )
> > +    parser.add_argument(
> > +        "--crate-dir",
> > +        metavar=3D"CRATE_DIR",
> > +        type=3Dpathlib.Path,
> > +        dest=3D"crate_dir",
> > +        help=3D"Absolute path that contains the manifest file of the c=
rate to compile",
> > +        required=3DTrue,
> > +    )
> > +    parser.add_argument(
> > +        "--outdir",
> > +        metavar=3D"OUTDIR",
> > +        type=3Dpathlib.Path,
> > +        dest=3D"outdir",
> > +        help=3D"Path to copy compiled artifacts to for Meson to use.",
> > +        required=3DTrue,
> > +    )
> > +    parser.add_argument(
> > +        "--profile", type=3Dstr, choices=3D["release", "debug"], requi=
red=3DTrue
> > +    )
> > +    parser.add_argument(
> > +        "--target-triple", type=3Dstr, choices=3DRUST_TARGET_TRIPLES, =
required=3DTrue
> > +    )
> > +
> > +    subparsers =3D parser.add_subparsers()
> > +
> > +    buildlib =3D subparsers.add_parser("build-lib")
> > +    buildlib.set_defaults(func=3Dbuild_lib)
> > +
> > +    args =3D parser.parse_args()
> > +    if args.verbose:
> > +        logging.basicConfig(level=3Dlogging.DEBUG)
> > +    logging.debug("args: %s", args)
> > +
> > +    args.func(args)
> > +
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main()
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >

