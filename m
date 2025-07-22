Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37220C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueC7U-0001Uy-C4; Tue, 22 Jul 2025 08:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueC7O-0001RW-7f
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:29:14 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ueC7I-0001Rs-SK
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 08:29:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so9303185a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753187346; x=1753792146; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dU5Vuu2RbHdWWGd+esiFCg0Vx8GarEZq9jusKs2nt2Q=;
 b=WtMAzV3XgI/vMvjhOrWwccSWElAV/ozoSgttV2YARV25E22+94XzWOFgJwGzWnyCjO
 nZpVbWPV8ZiqdRCf2eN80Z4yf3AezpALgMgByJ7KVQOi9MouXkevWXkN/r/F+kawVcZx
 JI5KbWoKdMi0qAjuQqft+Rxy4sqsVTlIMcTyKxWTeP3H+ZRsnYn24DCvUpB/98duKcTv
 YRYS1y10HfzU/rWtivPSGqIb8+nJvjMFw/dFcb8fgcGn9c8ME92/XeBd/COObMEC6Zow
 bA4c2Rcu0u6GPomouWEXtjq/ikX0lryqrFOf9nWMpH1V6uhJdoS0XedG8oTO7PzL6Jot
 BKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753187346; x=1753792146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dU5Vuu2RbHdWWGd+esiFCg0Vx8GarEZq9jusKs2nt2Q=;
 b=nPYWuKp9K13i2ZCBy8yNAZF+36sE5uhgZcpdjqRBaMRzU0w3TdNtvYlnysxtVSIKkH
 USJHjfsq9mcFF/+30IDogjfoyZmV3kR/VDSi6bkr3vQyIpPlquHcB7n6h1uwVcPZ+Qz3
 qy7odsJ/Ixtqtjd8U00QCz9wjWCBCHJa+bD9/dKTwmJg97C5TW8ZAUrhJsyb5CghfMVx
 +o2Pt+USGOnTf4Ko9mqUXxAJniv/v40PStwmNC0olqJ4FWYIyEgUWsCBroE6TRoTyf2u
 /H2g214Z8L0U8NC/pVsSITQXe0wKMUXYp5y7TfBCU6IikOCOxkulmSeClbxToB0WluEz
 w8wg==
X-Gm-Message-State: AOJu0YykrGPeyRHZsJU/g/OcYf/TWkc5aq9sXFCK8yJUo2i65/cSmZ+Q
 RBwTSfoEIK5aQ+fWVxUC4v7KC0NtqAoO+KFpOyhVb4Xi9TIBMoLpRsMKoA157jS6mIXmRuWkqiK
 7c3ef66Idi1FdO9ixStCtP7gK5dS/ksccGJ56pJW9/Q==
X-Gm-Gg: ASbGncsk/h9+KJAPub93k4sO3WOI8Pn8x/K6E0L/THKJLa7k171dH8Nm9hlKdel9//y
 tXt1qcWYVUmgJDCntAy36JjWsnlXf4Dq1UeHSxGSA9lFstRiqLxBLkMoy6+JTH8Dv+RQOvyD8YH
 3YigCt1cq/Cg+jjAJH7doGFxqZnQ66za7pHDAA1w8YYPsLN7Rfpv/iLLbEVefi4HHP//1c61wP8
 xs4Pw==
X-Google-Smtp-Source: AGHT+IHePfySFLH2TTpEZl6cGZKtFCmmu+kUzfqT2d31uzQFzvruq+jVsbw5ekj9m0jcB0g/MUS+EQCDhOQMoSHERAc=
X-Received: by 2002:a50:cd4e:0:b0:612:a524:2b31 with SMTP id
 4fb4d7f45d1cf-612a52432demr14021192a12.25.1753187345847; Tue, 22 Jul 2025
 05:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250722083507.678542-1-pbonzini@redhat.com>
In-Reply-To: <20250722083507.678542-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 22 Jul 2025 15:28:39 +0300
X-Gm-Features: Ac12FXxqk7gGztfIdI9ISyH8gEuAM5tiEwlLdSXgcbO1Yacw5Luyz7Exa_-7VHE
Message-ID: <CAAjaMXagtnr-r6ou8Nfh4+x_TSt4BTUT_4RM7tMnjX7bU_ohAA@mail.gmail.com>
Subject: Re: [PATCH] scripts: add script to help distro use global Rust
 packages
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, berrange@redhat.com, 
 ngompa@fedoraproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, Jul 22, 2025 at 11:36=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Some distros prefer to avoid vendored crate sources, and instead use
> local sources from e.g. ``/usr/share/cargo/registry``.  Add a
> script, inspired by the Mesa spec file(*), that automatically
> performs this task.  The script is meant to be invoked after unpacking
> the QEMU tarball.
>
> (*) This is the hack that Mesa uses:
>
>     export MESON_PACKAGE_CACHE_DIR=3D"%{cargo_registry}/"
>     %define inst_crate_nameversion() %(basename %{cargo_registry}/%{1}-*)
>     %define rewrite_wrap_file() sed -e "/source.*/d" -e "s/%{1}-.*/%{inst=
_crate_nameversion %{1}}/" -i subprojects/%{1}.wrap
>     %rewrite_wrap_file proc-macro2
>     ... more %rewrite_wrap_file invocations follow ...
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/build-platforms.rst           |   8 +
>  scripts/get-wraps-from-cargo-registry.py | 191 +++++++++++++++++++++++
>  2 files changed, 199 insertions(+)
>  create mode 100755 scripts/get-wraps-from-cargo-registry.py
>
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.=
rst
> index 8ecbd6b26f7..8671c3be9cd 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -127,6 +127,14 @@ Rust build dependencies
>    (or newer) package.  The path to ``rustc`` and ``rustdoc`` must be
>    provided manually to the configure script.
>
> +  Some distros prefer to avoid vendored crate sources, and instead use
> +  local sources from e.g. ``/usr/share/cargo/registry``.  QEMU includes =
a
> +  script, ``scripts/get-wraps-from-cargo-registry.py``, that automatical=
ly
> +  performs this task.  The script is meant to be invoked after unpacking
> +  the QEMU tarball.  QEMU also includes ``rust/Cargo.toml`` and
> +  ``rust/Cargo.lock`` files that can be used to compute QEMU's build
> +  dependencies, e.g. using ``cargo2rpm -p rust/Cargo.toml buildrequires`=
`.
> +
>  Optional build dependencies
>    Build components whose absence does not affect the ability to build QE=
MU
>    may not be available in distros, or may be too old for our requirement=
s.
> diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps=
-from-cargo-registry.py
> new file mode 100755
> index 00000000000..6b76d00a6d9
> --- /dev/null
> +++ b/scripts/get-wraps-from-cargo-registry.py
> @@ -0,0 +1,191 @@
> +#!/usr/bin/env python3
> +
> +"""
> +get-wraps-from-cargo-registry.py - Update Meson subprojects from a globa=
l registry
> +"""
> +
> +# Copyright (C) 2025 Red Hat, Inc.
> +#
> +# Author: Paolo Bonzini <pbonzini@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +

Nit, missing:

# SPDX-License-Identifier:

> +import argparse
> +import configparser
> +import filecmp
> +import glob
> +import os
> +import subprocess
> +import sys
> +
> +
> +def get_name_and_semver(namever: str) -> tuple[str, str]:
> +    """Split a subproject name into its name and semantic version parts"=
""
> +    parts =3D namever.rsplit("-", 1)
> +    if len(parts) !=3D 2:
> +        return namever, ""
> +
> +    return parts[0], parts[1]
> +
> +
> +class UpdateSubprojects:
> +    cargo_registry: str
> +    top_srcdir: str
> +    dry_run: bool
> +    changes: int =3D 0
> +
> +    def find_installed_crate(self, namever: str) -> str | None:
> +        """Find installed crate matching name and semver prefix"""
> +        name, semver =3D get_name_and_semver(namever)
> +
> +        # exact version match
> +        path =3D os.path.join(self.cargo_registry, f"{name}-{semver}")
> +        if os.path.exists(path):
> +            return f"{name}-{semver}"
> +
> +        # semver match
> +        matches =3D sorted(glob.glob(f"{path}.*"))
> +        return os.path.basename(matches[0]) if matches else None
> +
> +    def compare_build_rs(self, orig_dir: str, registry_namever: str) -> =
None:
> +        """Warn if the build.rs in the original directory differs from t=
he registry version."""
> +        orig_build_rs =3D os.path.join(orig_dir, "build.rs")
> +        new_build_rs =3D os.path.join(self.cargo_registry, registry_name=
ver, "build.rs")
> +
> +        msg =3D None
> +        if os.path.isfile(orig_build_rs) !=3D os.path.isfile(new_build_r=
s):
> +            if os.path.isfile(orig_build_rs):
> +                msg =3D f"build.rs removed in {registry_namever}"
> +            if os.path.isfile(new_build_rs):
> +                msg =3D f"build.rs added in {registry_namever}"
> +
> +        elif os.path.isfile(orig_build_rs) and not filecmp.cmp(orig_buil=
d_rs, new_build_rs):
> +            msg =3D f"build.rs changed from {orig_dir} to {registry_name=
ver}"
> +
> +        if msg:
> +            print(f"=E2=9A=A0=EF=B8=8F  Warning: {msg}")
> +            print("   This may affect the build process - please review =
the differences.")
> +
> +    def update_subproject(self, wrap_file: str, registry_namever: str) -=
> None:
> +        """Modify [wrap-file] section to point to self.cargo_registry.""=
"
> +        assert wrap_file.endswith("-rs.wrap")
> +        wrap_name =3D wrap_file[:-5]
> +
> +        env =3D os.environ.copy()
> +        env["MESON_PACKAGE_CACHE_DIR"] =3D self.cargo_registry
> +
> +        config =3D configparser.ConfigParser()
> +        config.read(wrap_file)
> +        if "wrap-file" not in config:
> +            return
> +
> +        # do not download the wrap, always use the local copy
> +        orig_dir =3D config["wrap-file"]["directory"]
> +        if os.path.exists(orig_dir) and orig_dir !=3D registry_namever:
> +            self.compare_build_rs(orig_dir, registry_namever)
> +        if self.dry_run:
> +            if orig_dir =3D=3D registry_namever:
> +                print(f"Will install {orig_dir} from registry.")
> +            else:
> +                print(f"Will replace {orig_dir} with {registry_namever}.=
")
> +            self.changes +=3D 1
> +            return
> +
> +        config["wrap-file"]["directory"] =3D registry_namever
> +        for key in list(config["wrap-file"].keys()):
> +            if key.startswith("source"):
> +                del config["wrap-file"][key]
> +
> +        # replace existing directory with installed version
> +        if os.path.exists(orig_dir):
> +            subprocess.run(
> +                ["meson", "subprojects", "purge", "--confirm", wrap_name=
],
> +                cwd=3Dself.top_srcdir,
> +                env=3Denv,
> +                check=3DTrue,
> +            )
> +
> +        with open(wrap_file, "w") as f:
> +            config.write(f)
> +
> +        if orig_dir =3D=3D registry_namever:
> +            print(f"Installing {orig_dir} from registry.")
> +        else:
> +            print(f"Replacing {orig_dir} with {registry_namever}.")
> +
> +        if orig_dir !=3D registry_namever:
> +            patch_dir =3D config["wrap-file"]["patch_directory"]
> +            patch_dir =3D os.path.join("packagefiles", patch_dir)
> +            _, ver =3D registry_namever.rsplit("-", 1)
> +            subprocess.run(
> +                ["meson", "rewrite", "kwargs", "set", "project", "/", "v=
ersion", ver],
> +                cwd=3Dpatch_dir,
> +                env=3Denv,
> +                check=3DTrue,
> +            )
> +
> +        subprocess.run(
> +            ["meson", "subprojects", "download", wrap_name],
> +            cwd=3Dself.top_srcdir,
> +            env=3Denv,
> +            check=3DTrue,
> +        )
> +
> +    @staticmethod
> +    def parse_cmdline() -> argparse.Namespace:
> +        parser =3D argparse.ArgumentParser(
> +            description=3D"Replace Meson subprojects with packages in a =
Cargo registry"
> +        )
> +        parser.add_argument(
> +            "--cargo-registry",
> +            default=3Dos.environ.get("CARGO_REGISTRY"),
> +            help=3D"Path to Cargo registry (default: CARGO_REGISTRY env =
var)",
> +        )
> +        parser.add_argument(
> +            "--dry-run",
> +            action=3D"store_true",
> +            default=3DFalse,
> +            help=3D"Do not actually replace anything",
> +        )
> +
> +        args =3D parser.parse_args()
> +        if not args.cargo_registry:
> +            print("error: CARGO_REGISTRY environment variable not set an=
d --cargo-registry not provided")
> +            sys.exit(1)
> +
> +        return args
> +
> +    def __init__(self, args: argparse.Namespace):
> +        self.cargo_registry =3D args.cargo_registry
> +        self.dry_run =3D args.dry_run
> +        self.top_srcdir =3D os.getcwd()
> +
> +    def main(self) -> None:
> +        if not os.path.exists("subprojects"):
> +            print("'subprojects' directory not found, nothing to do.")
> +            return
> +
> +        os.chdir("subprojects")
> +        for wrap_file in sorted(glob.glob("*-rs.wrap")):
> +            namever =3D wrap_file[:-8]  # Remove '-rs.wrap'
> +
> +            registry_namever =3D self.find_installed_crate(namever)
> +            if not registry_namever:
> +                print(f"No installed crate found for {wrap_file}")
> +                continue
> +
> +            self.update_subproject(wrap_file, registry_namever)
> +
> +        if self.changes:
> +            if self.dry_run:
> +                print("Rerun without --dry-run to apply changes.")
> +            else:
> +                print(f"=E2=9C=A8 {self.changes} subproject(s) updated!"=
)
> +        else:
> +            print("No changes.")
> +
> +
> +if __name__ =3D=3D "__main__":
> +    args =3D UpdateSubprojects.parse_cmdline()
> +    UpdateSubprojects(args).main()
> --
> 2.50.1
>
>

