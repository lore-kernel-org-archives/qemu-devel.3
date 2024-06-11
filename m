Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F27FC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2M4-000500-Kv; Tue, 11 Jun 2024 10:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sH2M2-0004zb-Lx
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:20:06 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sH2M0-0004kO-5I
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:20:06 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57a31d63b6bso8581157a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718115601; x=1718720401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Ppgpu5RYhgWHFWGwHycTcGnXJAtSUmsDFAbtAkdBUs=;
 b=NK6NZk3/OGHAzqUsU/qs1/kZSr9Cb1dlVpSbmkdNhXtSZT/B6wXibiQnZnQJiHr8iX
 X/eicOOPcpgqc+TchURTX7zSC1dRSRei7OPdDhtL9HwcNL4szbfGzVxpc9WYXZAh2bpV
 KCc9uZDjL2HlndXTRpTOiQia9ZlYKLAesXci8ZmTq0qlzQ5S1MQPZPA7uwPNLwysroqm
 MJZ/TYKbJN4YJsu2vJG5oO4nqKvy+rC7bDcid7I7nVm6kdOvdj29NQoelUIemH1jFpK0
 /NbfNnaj8UKoqtqgYXKhFVASEdubNYtAduA7oDjZrMQrw6uay0dkqMs5XVN+oTXETlkX
 1cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115601; x=1718720401;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Ppgpu5RYhgWHFWGwHycTcGnXJAtSUmsDFAbtAkdBUs=;
 b=E3681ithDHkGBTMNYyjXQut4Epa7tjEohiHgLxlRjw17WCpEMm7kFDVEHSZ24vWp3m
 zCL1f7i2ycvc9U58XQMRzni/Xd577BE8Ai0Q/F4bgB5JRgMZhMEoZUkDPg9NR67LEMuX
 3KV6Ptcs886ugbfjuMPBur0b0kDnJe5wm15ALCUbyMWQfFOFrO2V2EAMQDUepmoF1dZw
 32PBgHzajbtTwF3k09uDgKul6+VWAPd6ac2Gssk9emiZ84xeqg4FlxQa8WakU5ZVwmDm
 yDhbFQHHEnnn/75fPA8e3Xk8SNiLaad2wQB+G+FhIBpCWyBrf8HSLB9BOPfJ4cLqiuaa
 Atrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwljF2NnpP9U2lc1pOj3EBdW3fpJZnCxa7gg6PpMNi1fWb4/YUKtGD7M/SV+jDWs46pfnGq1XOy/Ka9waICYw4/GQegfE=
X-Gm-Message-State: AOJu0YyVrPvuXR04XdRE351qmWEAHY2a3aiiNXz/pOzUMkOiJLqlMqqK
 09o5arpbSPPfBuZskGZsAE9KI7fd9gFWTlqLr1rq0oc2cNXhgZP9NagqeqvQtMw=
X-Google-Smtp-Source: AGHT+IFsoJSpHaJsX9Xi8K+u0b819Q0og2dJFX4x96d0RPwdbtRvUrZBnPZ4k6k3c7z2St6Z7iAStg==
X-Received: by 2002:a50:d4d2:0:b0:579:edac:df13 with SMTP id
 4fb4d7f45d1cf-57c50882422mr7708605a12.8.1718115600823; 
 Tue, 11 Jun 2024 07:20:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae20243esm9355435a12.68.2024.06.11.07.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:20:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6CED5F898;
 Tue, 11 Jun 2024 15:19:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>
Subject: Re: [RFC PATCH v1 1/6] build-sys: Add rust feature option
In-Reply-To: <20240610192517.GA350256@fedora> (Stefan Hajnoczi's message of
 "Mon, 10 Jun 2024 15:25:17 -0400")
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <0933b669c8e47e1a78d21e56881e0933ef910461.1718040303.git.manos.pitsidianakis@linaro.org>
 <20240610192517.GA350256@fedora>
Date: Tue, 11 Jun 2024 15:19:59 +0100
Message-ID: <87wmmvy31s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Mon, Jun 10, 2024 at 09:22:36PM +0300, Manos Pitsidianakis wrote:
>> Add options for Rust in meson_options.txt, meson.build, configure to
>> prepare for adding Rust code in the followup commits.
>>=20
>> `rust` is a reserved meson name, so we have to use an alternative.
>> `with_rust` was chosen.
>>=20
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>> The cargo wrapper script hardcodes some rust target triples. This is=20
>> just temporary.
>> ---
>>  .gitignore               |   2 +
>>  configure                |  12 +++
>>  meson.build              |  11 ++
>>  meson_options.txt        |   4 +
>>  scripts/cargo_wrapper.py | 211 +++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 240 insertions(+)
>>  create mode 100644 scripts/cargo_wrapper.py
>>=20
>> diff --git a/.gitignore b/.gitignore
>> index 61fa39967b..f42b0d937e 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -2,6 +2,8 @@
>>  /build/
>>  /.cache/
>>  /.vscode/
>> +/target/
>> +rust/**/target
>
> Are these necessary since the cargo build command-line below uses
> --target-dir <meson-build-dir>?
>
> Adding new build output directories outside build/ makes it harder to
> clean up the source tree and ensure no state from previous builds
> remains.

Indeed my tree looks like:

 $SRC
   /builds
     /buildA
     /buildB

etc. So I would expect the rust build stuff to be in the builddir
because I have multiple configurations.

>
>>  *.pyc
>>  .sdk
>>  .stgit-*
>> diff --git a/configure b/configure
>> index 38ee257701..c195630771 100755
>> --- a/configure
>> +++ b/configure
>> @@ -302,6 +302,9 @@ else
>>    objcc=3D"${objcc-${cross_prefix}clang}"
>>  fi
>>=20=20
>> +with_rust=3D"auto"
>> +with_rust_target_triple=3D""
>> +
>>  ar=3D"${AR-${cross_prefix}ar}"
>>  as=3D"${AS-${cross_prefix}as}"
>>  ccas=3D"${CCAS-$cc}"
>> @@ -760,6 +763,12 @@ for opt do
>>    ;;
>>    --gdb=3D*) gdb_bin=3D"$optarg"
>>    ;;
>> +  --enable-rust) with_rust=3Denabled
>> +  ;;
>> +  --disable-rust) with_rust=3Ddisabled
>> +  ;;
>> +  --rust-target-triple=3D*) with_rust_target_triple=3D"$optarg"
>> +  ;;
>>    # everything else has the same name in configure and meson
>>    --*) meson_option_parse "$opt" "$optarg"
>>    ;;
>> @@ -1796,6 +1805,9 @@ if test "$skip_meson" =3D no; then
>>    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_en=
gine=3D$LIB_FUZZING_ENGINE"
>>    test "$plugins" =3D yes && meson_option_add "-Dplugins=3Dtrue"
>>    test "$tcg" !=3D enabled && meson_option_add "-Dtcg=3D$tcg"
>> +  test "$with_rust" !=3D enabled && meson_option_add "-Dwith_rust=3D$wi=
th_rust"
>> +  test "$with_rust" !=3D enabled && meson_option_add "-Dwith_rust=3D$wi=
th_rust"
>
> Duplicate line.
>
>> +  test "$with_rust_target_triple" !=3D "" && meson_option_add "-Dwith_r=
ust_target_triple=3D$with_rust_target_triple"
>>    run_meson() {
>>      NINJA=3D$ninja $meson setup "$@" "$PWD" "$source_path"
>>    }
>> diff --git a/meson.build b/meson.build
>> index a9de71d450..3533889852 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -290,6 +290,12 @@ foreach lang : all_languages
>>    endif
>>  endforeach
>>=20=20
>> +cargo =3D not_found
>> +if get_option('with_rust').allowed()
>> +  cargo =3D find_program('cargo', required: get_option('with_rust'))
>> +endif
>> +with_rust =3D cargo.found()
>> +
>>  # default flags for all hosts
>>  # We use -fwrapv to tell the compiler that we require a C dialect where
>>  # left shift of signed integers is well defined and has the expected
>> @@ -2066,6 +2072,7 @@ endif
>>=20=20
>>  config_host_data =3D configuration_data()
>>=20=20
>> +config_host_data.set('CONFIG_WITH_RUST', with_rust)
>>  audio_drivers_selected =3D []
>>  if have_system
>>    audio_drivers_available =3D {
>> @@ -4190,6 +4197,10 @@ if 'objc' in all_languages
>>  else
>>    summary_info +=3D {'Objective-C compiler': false}
>>  endif
>> +summary_info +=3D {'Rust support':      with_rust}
>> +if with_rust and get_option('with_rust_target_triple') !=3D ''
>> +  summary_info +=3D {'Rust target':     get_option('with_rust_target_tr=
iple')}
>> +endif
>>  option_cflags =3D (get_option('debug') ? ['-g'] : [])
>>  if get_option('optimization') !=3D 'plain'
>>    option_cflags +=3D ['-O' + get_option('optimization')]
>> diff --git a/meson_options.txt b/meson_options.txt
>> index 4c1583eb40..223491b731 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -366,3 +366,7 @@ option('qemu_ga_version', type: 'string', value: '',
>>=20=20
>>  option('hexagon_idef_parser', type : 'boolean', value : true,
>>         description: 'use idef-parser to automatically generate TCG code=
 for the Hexagon frontend')
>> +option('with_rust', type: 'feature', value: 'auto',
>> +       description: 'Enable Rust support')
>> +option('with_rust_target_triple', type : 'string', value: '',
>> +       description: 'Rust target triple')
>> diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
>> new file mode 100644
>> index 0000000000..d338effdaa
>> --- /dev/null
>> +++ b/scripts/cargo_wrapper.py
>> @@ -0,0 +1,211 @@
>> +#!/usr/bin/env python3
>> +# Copyright (c) 2020 Red Hat, Inc.
>> +# Copyright (c) 2023 Linaro Ltd.
>> +#
>> +# Authors:
>> +#  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> +#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import argparse
>> +import configparser
>> +import distutils.file_util
>> +import json
>> +import logging
>> +import os
>> +import os.path
>> +import re
>> +import subprocess
>> +import sys
>> +import pathlib
>> +import shutil
>> +import tomllib
>> +
>> +from pathlib import Path
>> +from typing import Any, Dict, List, Tuple
>> +
>> +RUST_TARGET_TRIPLES =3D (
>> +    "aarch64-unknown-linux-gnu",
>> +    "x86_64-unknown-linux-gnu",
>> +    "x86_64-apple-darwin",
>> +    "aarch64-apple-darwin",
>> +)
>
> Is this hardcoded to avoid calling `rustc --print target-list`?
>
> Or is this the support matrix? In that case it would be interesting to
> figure out the target triples for all host OSes and CPUs that QEMU is
> supported on.
>
>> +
>> +
>> +def cfg_name(name: str) -> str:
>> +    if (
>> +        name.startswith("CONFIG_")
>> +        or name.startswith("TARGET_")
>> +        or name.startswith("HAVE_")
>> +    ):
>> +        return name
>> +    return ""
>> +
>> +
>> +def generate_cfg_flags(header: str) -> List[str]:
>> +    with open(header, encoding=3D"utf-8") as cfg:
>> +        config =3D [l.split()[1:] for l in cfg if l.startswith("#define=
")]
>> +
>> +    cfg_list =3D []
>> +    for cfg in config:
>> +        name =3D cfg_name(cfg[0])
>> +        if not name:
>> +            continue
>> +        if len(cfg) >=3D 2 and cfg[1] !=3D "1":
>> +            continue
>> +        cfg_list.append("--cfg")
>> +        cfg_list.append(name)
>> +    return cfg_list
>> +
>> +
>> +def cargo_target_dir(args: argparse.Namespace) -> pathlib.Path:
>> +    return args.meson_build_dir
>> +
>> +
>> +def manifest_path(args: argparse.Namespace) -> pathlib.Path:
>> +    return args.crate_dir / "Cargo.toml"
>> +
>> +
>> +def get_cargo_rustc(args: argparse.Namespace) -> tuple[Dict[str, Any], =
List[str]]:
>> +    # See https://doc.rust-lang.org/cargo/reference/environment-variabl=
es.html
>> +    # Item `CARGO_ENCODED_RUSTFLAGS =E2=80=94 A list of custom flags se=
parated by
>> +    # 0x1f (ASCII Unit Separator) to pass to all compiler invocations t=
hat Cargo
>> +    # performs`
>> +    cfg =3D chr(0x1F).join(
>> +        [c for h in args.config_headers for c in generate_cfg_flags(h)]
>> +    )
>> +    target_dir =3D cargo_target_dir(args)
>> +    cargo_path =3D manifest_path(args)
>> +
>> +    cargo_cmd =3D [
>> +        "cargo",
>> +        "build",
>> +        "--target-dir",
>> +        str(target_dir),
>> +        "--manifest-path",
>> +        str(cargo_path),
>> +    ]
>> +    if args.target_triple:
>> +        cargo_cmd +=3D ["--target", args.target_triple]
>> +    if args.profile =3D=3D "release":
>> +        cargo_cmd +=3D ["--release"]
>> +
>> +    env =3D os.environ
>> +    env["CARGO_ENCODED_RUSTFLAGS"] =3D cfg
>> +
>> +    return (env, cargo_cmd)
>> +
>> +
>> +def run_cargo(env: Dict[str, Any], cargo_cmd: List[str]) -> str:
>> +    envlog =3D " ".join(["{}=3D{}".format(k, v) for k, v in env.items()=
])
>> +    cmdlog =3D " ".join(cargo_cmd)
>> +    logging.debug("Running %s %s", envlog, cmdlog)
>> +    try:
>> +        out =3D subprocess.check_output(
>> +            cargo_cmd,
>> +            env=3Ddict(os.environ, **env),
>> +            stderr=3Dsubprocess.STDOUT,
>> +            universal_newlines=3DTrue,
>> +        )
>> +    except subprocess.CalledProcessError as err:
>> +        print("Environment: " + envlog)
>> +        print("Command: " + cmdlog)
>> +        print(err.output)
>> +        sys.exit(1)
>> +
>> +    return out
>> +
>> +
>> +def build_lib(args: argparse.Namespace) -> None:
>> +    logging.debug("build-lib")
>> +    target_dir =3D cargo_target_dir(args)
>> +    cargo_toml_path =3D manifest_path(args)
>> +
>> +    with open(cargo_toml_path, "rb") as f:
>> +        config =3D tomllib.load(f)
>> +
>> +    package_name =3D config["package"]["name"].strip('"').replace("-", =
"_")
>> +
>> +    liba_filename =3D "lib" + package_name + ".a"
>> +    liba =3D target_dir / args.target_triple / args.profile / liba_file=
name
>> +
>> +    env, cargo_cmd =3D get_cargo_rustc(args)
>> +    out =3D run_cargo(env, cargo_cmd)
>> +    logging.debug("cp %s %s", liba, args.outdir)
>> +    shutil.copy2(liba, args.outdir)
>> +
>> +
>> +def main() -> None:
>> +    parser =3D argparse.ArgumentParser()
>> +    parser.add_argument("-v", "--verbose", action=3D"store_true")
>> +    parser.add_argument(
>> +        "--color",
>> +        metavar=3D"WHEN",
>> +        choices=3D["auto", "always", "never"],
>> +        default=3D"auto",
>> +        help=3D"Coloring: auto, always, never",
>> +    )
>> +    parser.add_argument(
>> +        "--config-headers",
>> +        metavar=3D"CONFIG_HEADER",
>> +        action=3D"append",
>> +        dest=3D"config_headers",
>> +        required=3DFalse,
>> +        default=3D[],
>> +    )
>> +    parser.add_argument(
>> +        "--meson-build-dir",
>> +        metavar=3D"BUILD_DIR",
>> +        help=3D"meson.current_build_dir()",
>> +        type=3Dpathlib.Path,
>> +        dest=3D"meson_build_dir",
>> +        required=3DTrue,
>> +    )
>> +    parser.add_argument(
>> +        "--meson-source-dir",
>> +        metavar=3D"SOURCE_DIR",
>> +        help=3D"meson.current_source_dir()",
>> +        type=3Dpathlib.Path,
>> +        dest=3D"meson_source_dir",
>> +        required=3DTrue,
>> +    )
>> +    parser.add_argument(
>> +        "--crate-dir",
>> +        metavar=3D"CRATE_DIR",
>> +        type=3Dpathlib.Path,
>> +        dest=3D"crate_dir",
>> +        help=3D"Absolute path that contains the manifest file of the cr=
ate to compile",
>> +        required=3DTrue,
>> +    )
>> +    parser.add_argument(
>> +        "--outdir",
>> +        metavar=3D"OUTDIR",
>> +        type=3Dpathlib.Path,
>> +        dest=3D"outdir",
>> +        help=3D"Path to copy compiled artifacts to for Meson to use.",
>> +        required=3DTrue,
>> +    )
>> +    parser.add_argument(
>> +        "--profile", type=3Dstr, choices=3D["release", "debug"], requir=
ed=3DTrue
>> +    )
>> +    parser.add_argument(
>> +        "--target-triple", type=3Dstr, choices=3DRUST_TARGET_TRIPLES, r=
equired=3DTrue
>> +    )
>> +
>> +    subparsers =3D parser.add_subparsers()
>> +
>> +    buildlib =3D subparsers.add_parser("build-lib")
>> +    buildlib.set_defaults(func=3Dbuild_lib)
>> +
>> +    args =3D parser.parse_args()
>> +    if args.verbose:
>> +        logging.basicConfig(level=3Dlogging.DEBUG)
>> +    logging.debug("args: %s", args)
>> +
>> +    args.func(args)
>> +
>> +
>> +if __name__ =3D=3D "__main__":
>> +    main()
>> --=20
>> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

