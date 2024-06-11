Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C394C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGypW-0003M2-5H; Tue, 11 Jun 2024 06:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGypS-0003LC-BL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGypP-0002l1-Ls
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42189d3c7efso20948155e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718102049; x=1718706849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXMzufTDFqExgudi0feoRnQwFcdrUAhlrudwhggWGTg=;
 b=v6xHMlCvquO4RRm4Bpzuhkfao6XmPDF37dKlm4dL8PQy6TfWRn0pz4j2h/zSvHDza7
 vdcoRpWpFNKWbbY2hmym2FfseadjbNKybHnRraeujpcCQo7tKEPYGvVN7hLIRSow2ZJt
 +8qkD1zqxJ39dssafy1MpA8cwj193ptBlK3JI/U8YHLQwoXkqaaC6A0D9bo4xi0zCCtP
 LwdPmveFx5JuF7GyHSlzt7IdpYqVwyo6uTUqFK8FBsb3R48msiad7aa1XcYu++wAQsPz
 w24fVe6Y3rdYeSO2APu8ZrIiljaRvEeL+xYVq1YAMp43Djiqnn+2XH/g2d9I/CoOmym4
 PKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718102049; x=1718706849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXMzufTDFqExgudi0feoRnQwFcdrUAhlrudwhggWGTg=;
 b=o+ImFMC66ChUxpK8SfB/f4uxa1QJM2PysRJOCKvMUlIuyMwoKvqSNy1JgNzQ+tEEwr
 bqle/WJC0GjZIz9qLAKT1JrUbhqdMNWIEnK04MjTL1L0twGXxVAYEOV+8AmZQb/cTNg4
 9w/b6tzKWPAKl40D6x3q3r4BOWogDAn3eg5n8unIr28R9VzINh/FGJNfFw2RYIBrOdoD
 oCc0x/i1p3o2vb1UmBedzoTPBupuO7fUIldhs1/4cn1QBtXKtlS85cd06J9CdgiYkMhE
 luZjm4SekOnH1Gu+VFn1+jO/L3xOhGpKRktPY/j8LH81Y9Bw8wpV/pcLlBFtaBiW6WI4
 cSdQ==
X-Gm-Message-State: AOJu0YwHGGoVgdgIvhF45iLki+KD7RavQtrrm3XKZ3jyMSJwnMW6sULw
 Jx/T4dSgTmC2TBI8m2AVA37E3vzCuZXgcUZ+k7BLnkTcEYOzhH/+m0hbmSesdJRd7r6bhWhzskU
 sIWE=
X-Google-Smtp-Source: AGHT+IHv0uiaQs7XiGq4cOXuqPiOMFxb9+M553N+iXAXbylwPF6NHvVn9odv+ZedSDnVsKcteCEJVw==
X-Received: by 2002:a05:600c:450c:b0:421:671b:586c with SMTP id
 5b1f17b1804b1-421671b5c03mr114346815e9.9.1718102049418; 
 Tue, 11 Jun 2024 03:34:09 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42232e71865sm30878795e9.46.2024.06.11.03.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:34:09 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 1/5] build-sys: Add rust feature option
Date: Tue, 11 Jun 2024 13:33:30 +0300
Message-ID: <89b7d4ae6c03cf16ce9fcc95d0406c20627fd444.1718101832.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

Add options for Rust in meson_options.txt, meson.build, configure to
prepare for adding Rust code in the followup commits.

`rust` is a reserved meson name, so we have to use an alternative.
`with_rust` was chosen.

A cargo_wrapper.py script is added that is heavily based on the work of
Marc-André Lureau from 2021.

https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitignore                    |   2 +
 MAINTAINERS                   |   5 +
 configure                     |  12 ++
 meson.build                   |  11 ++
 meson_options.txt             |   4 +
 scripts/cargo_wrapper.py      | 211 ++++++++++++++++++++++++++++++++++
 scripts/meson-buildoptions.sh |   6 +
 7 files changed, 251 insertions(+)
 create mode 100644 scripts/cargo_wrapper.py

diff --git a/.gitignore b/.gitignore
index 61fa39967b..f42b0d937e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,8 @@
 /build/
 /.cache/
 /.vscode/
+/target/
+rust/**/target
 *.pyc
 .sdk
 .stgit-*
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b79767d61..431010ddbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4223,6 +4223,11 @@ F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst
 
+Rust build system integration
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: scripts/cargo_wrapper.py
+
 Miscellaneous
 -------------
 Performance Tools and Tests
diff --git a/configure b/configure
index 38ee257701..6baa63b443 100755
--- a/configure
+++ b/configure
@@ -302,6 +302,9 @@ else
   objcc="${objcc-${cross_prefix}clang}"
 fi
 
+with_rust="auto"
+with_rust_target_triple=""
+
 ar="${AR-${cross_prefix}ar}"
 as="${AS-${cross_prefix}as}"
 ccas="${CCAS-$cc}"
@@ -760,6 +763,12 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-with-rust) with_rust=enabled
+  ;;
+  --disable-with-rust) with_rust=disabled
+  ;;
+  --with-rust-target-triple=*) with_rust_target_triple="$optarg"
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -1796,6 +1805,9 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
+  test "$with_rust" != enabled && meson_option_add "-Dwith_rust=$with_rust"
+  test "$with_rust" != enabled && meson_option_add "-Dwith_rust=$with_rust"
+  test "$with_rust_target_triple" != "" && meson_option_add "-Dwith_rust_target_triple=$with_rust_target_triple"
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
   }
diff --git a/meson.build b/meson.build
index a9de71d450..3533889852 100644
--- a/meson.build
+++ b/meson.build
@@ -290,6 +290,12 @@ foreach lang : all_languages
   endif
 endforeach
 
+cargo = not_found
+if get_option('with_rust').allowed()
+  cargo = find_program('cargo', required: get_option('with_rust'))
+endif
+with_rust = cargo.found()
+
 # default flags for all hosts
 # We use -fwrapv to tell the compiler that we require a C dialect where
 # left shift of signed integers is well defined and has the expected
@@ -2066,6 +2072,7 @@ endif
 
 config_host_data = configuration_data()
 
+config_host_data.set('CONFIG_WITH_RUST', with_rust)
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
@@ -4190,6 +4197,10 @@ if 'objc' in all_languages
 else
   summary_info += {'Objective-C compiler': false}
 endif
+summary_info += {'Rust support':      with_rust}
+if with_rust and get_option('with_rust_target_triple') != ''
+  summary_info += {'Rust target':     get_option('with_rust_target_triple')}
+endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
diff --git a/meson_options.txt b/meson_options.txt
index 4c1583eb40..223491b731 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -366,3 +366,7 @@ option('qemu_ga_version', type: 'string', value: '',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+option('with_rust', type: 'feature', value: 'auto',
+       description: 'Enable Rust support')
+option('with_rust_target_triple', type : 'string', value: '',
+       description: 'Rust target triple')
diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
new file mode 100644
index 0000000000..d338effdaa
--- /dev/null
+++ b/scripts/cargo_wrapper.py
@@ -0,0 +1,211 @@
+#!/usr/bin/env python3
+# Copyright (c) 2020 Red Hat, Inc.
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Authors:
+#  Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+#  Marc-André Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import argparse
+import configparser
+import distutils.file_util
+import json
+import logging
+import os
+import os.path
+import re
+import subprocess
+import sys
+import pathlib
+import shutil
+import tomllib
+
+from pathlib import Path
+from typing import Any, Dict, List, Tuple
+
+RUST_TARGET_TRIPLES = (
+    "aarch64-unknown-linux-gnu",
+    "x86_64-unknown-linux-gnu",
+    "x86_64-apple-darwin",
+    "aarch64-apple-darwin",
+)
+
+
+def cfg_name(name: str) -> str:
+    if (
+        name.startswith("CONFIG_")
+        or name.startswith("TARGET_")
+        or name.startswith("HAVE_")
+    ):
+        return name
+    return ""
+
+
+def generate_cfg_flags(header: str) -> List[str]:
+    with open(header, encoding="utf-8") as cfg:
+        config = [l.split()[1:] for l in cfg if l.startswith("#define")]
+
+    cfg_list = []
+    for cfg in config:
+        name = cfg_name(cfg[0])
+        if not name:
+            continue
+        if len(cfg) >= 2 and cfg[1] != "1":
+            continue
+        cfg_list.append("--cfg")
+        cfg_list.append(name)
+    return cfg_list
+
+
+def cargo_target_dir(args: argparse.Namespace) -> pathlib.Path:
+    return args.meson_build_dir
+
+
+def manifest_path(args: argparse.Namespace) -> pathlib.Path:
+    return args.crate_dir / "Cargo.toml"
+
+
+def get_cargo_rustc(args: argparse.Namespace) -> tuple[Dict[str, Any], List[str]]:
+    # See https://doc.rust-lang.org/cargo/reference/environment-variables.html
+    # Item `CARGO_ENCODED_RUSTFLAGS — A list of custom flags separated by
+    # 0x1f (ASCII Unit Separator) to pass to all compiler invocations that Cargo
+    # performs`
+    cfg = chr(0x1F).join(
+        [c for h in args.config_headers for c in generate_cfg_flags(h)]
+    )
+    target_dir = cargo_target_dir(args)
+    cargo_path = manifest_path(args)
+
+    cargo_cmd = [
+        "cargo",
+        "build",
+        "--target-dir",
+        str(target_dir),
+        "--manifest-path",
+        str(cargo_path),
+    ]
+    if args.target_triple:
+        cargo_cmd += ["--target", args.target_triple]
+    if args.profile == "release":
+        cargo_cmd += ["--release"]
+
+    env = os.environ
+    env["CARGO_ENCODED_RUSTFLAGS"] = cfg
+
+    return (env, cargo_cmd)
+
+
+def run_cargo(env: Dict[str, Any], cargo_cmd: List[str]) -> str:
+    envlog = " ".join(["{}={}".format(k, v) for k, v in env.items()])
+    cmdlog = " ".join(cargo_cmd)
+    logging.debug("Running %s %s", envlog, cmdlog)
+    try:
+        out = subprocess.check_output(
+            cargo_cmd,
+            env=dict(os.environ, **env),
+            stderr=subprocess.STDOUT,
+            universal_newlines=True,
+        )
+    except subprocess.CalledProcessError as err:
+        print("Environment: " + envlog)
+        print("Command: " + cmdlog)
+        print(err.output)
+        sys.exit(1)
+
+    return out
+
+
+def build_lib(args: argparse.Namespace) -> None:
+    logging.debug("build-lib")
+    target_dir = cargo_target_dir(args)
+    cargo_toml_path = manifest_path(args)
+
+    with open(cargo_toml_path, "rb") as f:
+        config = tomllib.load(f)
+
+    package_name = config["package"]["name"].strip('"').replace("-", "_")
+
+    liba_filename = "lib" + package_name + ".a"
+    liba = target_dir / args.target_triple / args.profile / liba_filename
+
+    env, cargo_cmd = get_cargo_rustc(args)
+    out = run_cargo(env, cargo_cmd)
+    logging.debug("cp %s %s", liba, args.outdir)
+    shutil.copy2(liba, args.outdir)
+
+
+def main() -> None:
+    parser = argparse.ArgumentParser()
+    parser.add_argument("-v", "--verbose", action="store_true")
+    parser.add_argument(
+        "--color",
+        metavar="WHEN",
+        choices=["auto", "always", "never"],
+        default="auto",
+        help="Coloring: auto, always, never",
+    )
+    parser.add_argument(
+        "--config-headers",
+        metavar="CONFIG_HEADER",
+        action="append",
+        dest="config_headers",
+        required=False,
+        default=[],
+    )
+    parser.add_argument(
+        "--meson-build-dir",
+        metavar="BUILD_DIR",
+        help="meson.current_build_dir()",
+        type=pathlib.Path,
+        dest="meson_build_dir",
+        required=True,
+    )
+    parser.add_argument(
+        "--meson-source-dir",
+        metavar="SOURCE_DIR",
+        help="meson.current_source_dir()",
+        type=pathlib.Path,
+        dest="meson_source_dir",
+        required=True,
+    )
+    parser.add_argument(
+        "--crate-dir",
+        metavar="CRATE_DIR",
+        type=pathlib.Path,
+        dest="crate_dir",
+        help="Absolute path that contains the manifest file of the crate to compile",
+        required=True,
+    )
+    parser.add_argument(
+        "--outdir",
+        metavar="OUTDIR",
+        type=pathlib.Path,
+        dest="outdir",
+        help="Path to copy compiled artifacts to for Meson to use.",
+        required=True,
+    )
+    parser.add_argument(
+        "--profile", type=str, choices=["release", "debug"], required=True
+    )
+    parser.add_argument(
+        "--target-triple", type=str, choices=RUST_TARGET_TRIPLES, required=True
+    )
+
+    subparsers = parser.add_subparsers()
+
+    buildlib = subparsers.add_parser("build-lib")
+    buildlib.set_defaults(func=build_lib)
+
+    args = parser.parse_args()
+    if args.verbose:
+        logging.basicConfig(level=logging.DEBUG)
+    logging.debug("args: %s", args)
+
+    args.func(args)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6ce5a8b72a..fdcf17129e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -79,6 +79,8 @@ meson_options_help() {
   printf "%s\n" '                           auto/sigaltstack/ucontext/windows)'
   printf "%s\n" '  --with-pkgversion=VALUE  use specified string as sub-version of the'
   printf "%s\n" '                           package'
+  printf "%s\n" '  --with-rust-target-triple=VALUE'
+  printf "%s\n" '                           Specify Rust host target triple'
   printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
   printf "%s\n" '                           (can be empty) [qemu]'
   printf "%s\n" '  --with-trace-file=VALUE  Trace file prefix for simple backend [trace]'
@@ -215,6 +217,7 @@ meson_options_help() {
   printf "%s\n" '  vvfat           vvfat image format support'
   printf "%s\n" '  werror          Treat warnings as errors'
   printf "%s\n" '  whpx            WHPX acceleration support'
+  printf "%s\n" '  with-rust       Enable Rust support'
   printf "%s\n" '  xen             Xen backend support'
   printf "%s\n" '  xen-pci-passthrough'
   printf "%s\n" '                  Xen PCI passthrough support'
@@ -550,6 +553,9 @@ _meson_option_parse() {
     --disable-werror) printf "%s" -Dwerror=false ;;
     --enable-whpx) printf "%s" -Dwhpx=enabled ;;
     --disable-whpx) printf "%s" -Dwhpx=disabled ;;
+    --enable-with-rust) printf "%s" -Dwith_rust=enabled ;;
+    --disable-with-rust) printf "%s" -Dwith_rust=disabled ;;
+    --with-rust-target-triple=*) quote_sh "-Dwith_rust_target_triple=$2" ;;
     --enable-xen) printf "%s" -Dxen=enabled ;;
     --disable-xen) printf "%s" -Dxen=disabled ;;
     --enable-xen-pci-passthrough) printf "%s" -Dxen_pci_passthrough=enabled ;;
-- 
γαῖα πυρί μιχθήτω


