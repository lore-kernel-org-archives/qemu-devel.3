Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4740C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1ht-0002QJ-EK; Wed, 19 Jun 2024 16:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1hs-0002Kc-Fc
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1hp-0001ZM-KJ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:00 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42281d8cd2dso1443185e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718828095; x=1719432895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJCGCx+gpWdYwlfgmXFAFLEAdH80kI2N7Nyzb/IWJJM=;
 b=lSrILMqqBfJNR+vtQQOjUYc3CO2F6mLN68IDryWcz9QY06SHqZ5AGsQzrN/MNC5J25
 YFzPArFX/U81SAOrsOw78MNLyjE103pQpIxUJeWx/ib6lbWaHTE+69WrFbLVI96rLtYE
 yP7mar2eW8s6JAfn6D36cKYZVRisoW83436jkmEA50eXg330BrKJfjKhIcxsXrC0Efq7
 8FXJKpi5dosca66CnA99Js9nqOhch8SWgropV74nAcz8MgOcKvc0OO0GkbBI1b9oRgBm
 2eGNTXeREuGYCvnf+O46JQ0BoA8OeZxOiF+L4ayLJwrEUPGUBZonj6fe3PynSFe6v+5a
 WizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718828095; x=1719432895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJCGCx+gpWdYwlfgmXFAFLEAdH80kI2N7Nyzb/IWJJM=;
 b=V5QCwMvhUnBnrVAzu1Bzi3lamXbxLSNIwFP+zxGs7V3BYnTApl6Jg8yTM/Gz/08eIj
 J1VEUN7s/eWa0SWP+6nBAc5Q86Ox/QTAou9/KxeCVZzRmRp7PbqvLStWKuG+8zLODbIY
 JAGSw3EU9CBFN7wvoCflv5wjU5M3mU5kxSAXplUOvnNJp60n08p+REgoiOU0Zb3L2cfZ
 IclpLdAO6lG/mpGazidPMyfemBGLb232GgahCuACPwC9orfSg1jw5wnxtDy74B/tQa+L
 6EvWsqZHaFgjva5ynu8ihsITRxSmWqaiFZxtOAHxDbemZndKNSxL5jVTmCfSJl37GfCP
 NBww==
X-Gm-Message-State: AOJu0Yz3gAe6+UmElZb2oXhfS759d8O/ZeKxxMlr5A8WSOTbnNzISw9d
 v7c5d50z0AyvaljIx4eUgnhsb5XXkCF84P7JkyGKjpg9dv2riVrPxyzjQmLFyqYYKX4ENiPdjNq
 pOdE=
X-Google-Smtp-Source: AGHT+IEzPOMjVnzVb/1lMJL+Bl9WrlS+6APLHkF/UnIwpnrVdYSCSZtLSdTon+W7KDdTCjcEHRZ2Wg==
X-Received: by 2002:a05:600c:4f4d:b0:424:761f:eda7 with SMTP id
 5b1f17b1804b1-424761fee9amr22451145e9.3.1718828095351; 
 Wed, 19 Jun 2024 13:14:55 -0700 (PDT)
Received: from localhost.localdomain (adsl-103.37.6.162.tellas.gr.
 [37.6.162.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101aac6sm45623235e9.0.2024.06.19.13.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:14:55 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
Date: Wed, 19 Jun 2024 23:13:59 +0300
Message-ID: <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

Add mechanism to generate rust hw targets that depend on a custom
bindgen target for rust bindings to C.

This way bindings will be created before the rust crate is compiled.

The bindings will end up in BUILDDIR/{target}-generated.rs and have the same name
as a target:

ninja aarch64-softmmu-generated.rs

The way the bindings are generated is:

1. All required C headers are included in a single file, in our case
   rust/wrapper.h for convenience. Otherwise we'd have to provide a list
   of headers every time to the bindgen tool.

2. Meson creates a generated_rs target that runs bindgen making sure
   the architecture etc header dependencies are present.

3. The generated_rs target takes a list of files, type symbols,
   function symbols to block from being generated. This is not necessary
   for the bindings to work, but saves us time and space.

4. Meson creates rust hardware target dependencies from the rust_targets
   dictionary defined in rust/meson.build.

   Since we cannot declare a dependency on generated_rs before it is
   declared in meson.build, the rust crate targets must be defined after
   the generated_rs target for each target architecture is defined. This
   way meson sets up the dependency tree properly.

5. After compiling each rust crate with the cargo_wrapper.py script,
   its static library artifact is linked as a `whole-archive` with the
   final binary.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS              |   3 +
 meson.build              |  56 +++++++++++++++++
 rust/.gitignore          |   3 +
 rust/meson.build         | 129 +++++++++++++++++++++++++++++++++++++++
 rust/wrapper.h           |  39 ++++++++++++
 scripts/cargo_wrapper.py |  10 +++
 6 files changed, 240 insertions(+)
 create mode 100644 rust/.gitignore
 create mode 100644 rust/meson.build
 create mode 100644 rust/wrapper.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 431010ddbf..0f36bb3e9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4227,6 +4227,9 @@ Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: scripts/cargo_wrapper.py
+F: rust/meson.build
+F: rust/wrapper.h
+F: rust/.gitignore
 
 Miscellaneous
 -------------
diff --git a/meson.build b/meson.build
index 3533889852..2b305e745a 100644
--- a/meson.build
+++ b/meson.build
@@ -3876,6 +3876,62 @@ foreach target : target_dirs
     lib_deps += dep.partial_dependency(compile_args: true, includes: true)
   endforeach
 
+  if with_rust and target_type == 'system'
+       # FIXME:
+       # > WARNING: Project specifies a minimum meson_version '>=0.63.0' but
+       # > uses features which were added in newer versions:
+       # > * 0.64.0: {'fs.copyfile'}
+       # > * 1.0.0: {'dependencies arg in rust.bindgen', 'module rust as stable module'}
+      rust_bindgen = import('rust')
+
+      # We need one generated_rs target per target, so give them
+      # target-specific names.
+      copy = fs.copyfile('rust/wrapper.h',
+                         target + '_wrapper.h')
+      generated_rs = rust_bindgen.bindgen(
+        input: copy,
+        dependencies: arch_deps + lib_deps,
+        output: target + '-generated.rs',
+        include_directories: include_directories('.', 'include'),
+        args: [
+          '--ctypes-prefix', 'core::ffi',
+          '--formatter', 'rustfmt',
+          '--generate-block',
+          '--generate-cstr',
+          '--impl-debug',
+          '--merge-extern-blocks',
+          '--no-doc-comments',
+          '--no-include-path-detection',
+          '--use-core',
+          '--with-derive-default',
+          '--allowlist-file', meson.project_source_root() + '/include/.*',
+          '--allowlist-file', meson.project_source_root() + '/.*',
+          '--allowlist-file', meson.project_build_root() + '/.*'
+        ],
+      )
+
+      if target in rust_targets
+        rust_hw = ss.source_set()
+        foreach t: rust_targets[target]
+          rust_device_cargo = custom_target(t['name'],
+                                       output: t['output'],
+                                       depends: [generated_rs],
+                                       build_always_stale: true,
+                                       command: t['command'])
+          rust_dep = declare_dependency(link_args: [
+                                          '-Wl,--whole-archive',
+                                          t['output-path'],
+                                          '-Wl,--no-whole-archive'
+                                          ],
+                                          sources: [rust_device_cargo])
+          rust_hw.add(rust_dep)
+        endforeach
+        rust_hw_config = rust_hw.apply(config_target, strict: false)
+        arch_srcs += rust_hw_config.sources()
+        arch_deps += rust_hw_config.dependencies()
+      endif
+  endif
+
   lib = static_library('qemu-' + target,
                  sources: arch_srcs + genh,
                  dependencies: lib_deps,
diff --git a/rust/.gitignore b/rust/.gitignore
new file mode 100644
index 0000000000..1bf71b1f68
--- /dev/null
+++ b/rust/.gitignore
@@ -0,0 +1,3 @@
+# Ignore any cargo development build artifacts; for qemu-wide builds, all build
+# artifacts will go to the meson build directory.
+target
diff --git a/rust/meson.build b/rust/meson.build
new file mode 100644
index 0000000000..435abd3e1c
--- /dev/null
+++ b/rust/meson.build
@@ -0,0 +1,129 @@
+# Supported hosts
+rust_supported_oses = {
+  'linux': '-unknown-linux-gnu',
+  'darwin': '-apple-darwin',
+  'windows': '-pc-windows-gnu'
+}
+rust_supported_cpus = ['x86_64', 'aarch64']
+
+# Future-proof the above definitions against any change in the root meson.build file:
+foreach rust_os: rust_supported_oses.keys()
+  if not supported_oses.contains(rust_os)
+    message()
+    warning('UNSUPPORTED OS VALUES IN ' + meson.current_source_dir() + '/meson.build')
+    message()
+    message('This meson.build file claims OS `+' + rust_os + '` is supported but')
+    message('it is not included in the global supported OSes list in')
+    message(meson.global_source_root() + '/meson.build.')
+  endif
+endforeach
+foreach rust_cpu: rust_supported_cpus
+  if not supported_cpus.contains(rust_cpu)
+    message()
+    warning('UNSUPPORTED CPU VALUES IN ' + meson.current_source_dir() + '/meson.build')
+    message()
+    message('This meson.build file claims CPU `+' + rust_cpu + '` is supported but')
+    message('it is not included in the global supported CPUs list in')
+    message(meson.global_source_root() + '/meson.build.')
+  endif
+endforeach
+
+# FIXME: retrieve target triple from meson and construct rust_target_triple
+if meson.is_cross_build()
+  message()
+  error('QEMU does not support cross compiling with Rust enabled.')
+endif
+
+# FIXME: These are the latest stable versions, refine to actual minimum ones.
+msrv = {
+  'rustc': '1.79.0',
+  'cargo': '1.79.0',
+  'bindgen': '0.69.4',
+}
+
+# rustup = find_program('rustup', required: false)
+foreach bin_dep: msrv.keys()
+  bin = find_program(bin_dep, required: true)
+  if bin.version() < msrv[bin_dep]
+    if bin_dep == 'bindgen' and get_option('wrap_mode') != 'nodownload'
+      run_command(cargo, 'install', 'bindgen-cli', capture: true, check: true)
+      bin = find_program(bin_dep, required: true)
+      if bin.version() >= msrv[bin_dep]
+        continue
+      endif
+    endif
+    message()
+    error(bin_dep + ' version ' + bin.version() + ' is unsupported: Please upgrade to at least ' + msrv[bin_dep])
+  endif
+endforeach
+
+rust_target_triple = get_option('with_rust_target_triple')
+
+if rust_target_triple == ''
+  if not supported_oses.contains(host_os)
+    message()
+    error('QEMU does not support `' + host_os +'` as a Rust platform.')
+  elif not supported_cpus.contains(host_arch)
+    message()
+    error('QEMU does not support `' + host_arch +'` as a Rust architecture.')
+  endif
+  rust_target_triple = host_arch + rust_supported_oses[host_os]
+  if host_os == 'windows' and host_arch == 'aarch64'
+    rust_target_triple += 'llvm'
+  endif
+else
+  # verify rust_target_triple if given as an option
+  rustc = find_program('rustc', required: true)
+  rustc_targets = run_command(rustc, '--print', 'target-list', capture: true, check: true).stdout().strip().split()
+  if not rustc_targets.contains(rust_target_triple)
+    message()
+    error('Given rust_target_triple ' + rust_target_triple + ' is not listed in rustc --print target-list output')
+  endif
+endif
+
+
+rust_targets = {}
+
+cargo_wrapper = [
+  find_program(meson.global_source_root() / 'scripts/cargo_wrapper.py'),
+  '--config-headers', meson.project_build_root() / 'config-host.h',
+  '--meson-build-root', meson.project_build_root(),
+  '--meson-build-dir', meson.current_build_dir(),
+  '--meson-source-dir', meson.current_source_dir(),
+]
+
+if get_option('b_colorout') != 'never'
+  cargo_wrapper += ['--color', 'always']
+endif
+
+if get_option('optimization') in ['0', '1', 'g']
+  rs_build_type = 'debug'
+else
+  rs_build_type = 'release'
+endif
+
+# Collect metadata for each (crate,qemu-target,compiler-target) combination.
+# Rust meson targets cannot be defined a priori because they depend on bindgen
+# generation that is created for each emulation target separately. Thus Rust
+# meson targets will be defined for each target after the target-specific
+# bindgen dependency is declared.
+rust_hw_target_list = {}
+
+foreach rust_hw_target, rust_hws: rust_hw_target_list
+  foreach rust_hw_dev: rust_hws
+    output = meson.current_build_dir() / rust_target_triple / rs_build_type / rust_hw_dev['output']
+    crate_metadata = {
+      'name': rust_hw_dev['name'],
+      'output': [rust_hw_dev['output']],
+      'output-path': output,
+      'command': [cargo_wrapper,
+        '--crate-dir', meson.current_source_dir() / rust_hw_dev['dirname'],
+        '--profile', rs_build_type,
+        '--target-triple', rust_target_triple,
+        '--outdir', '@OUTDIR@',
+        'build-lib'
+        ]
+      }
+    rust_targets += { rust_hw_target: [crate_metadata] }
+  endforeach
+endforeach
diff --git a/rust/wrapper.h b/rust/wrapper.h
new file mode 100644
index 0000000000..bcf808c8d7
--- /dev/null
+++ b/rust/wrapper.h
@@ -0,0 +1,39 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2020 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu-io.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "exec/memory.h"
+#include "chardev/char-fe.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/irq.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "chardev/char-serial.h"
diff --git a/scripts/cargo_wrapper.py b/scripts/cargo_wrapper.py
index 927336f80e..833e0e55f8 100644
--- a/scripts/cargo_wrapper.py
+++ b/scripts/cargo_wrapper.py
@@ -111,6 +111,8 @@ def get_cargo_rustc(args: argparse.Namespace) -> tuple[Dict[str, Any], List[str]
 
     env = os.environ
     env["CARGO_ENCODED_RUSTFLAGS"] = cfg
+    env["MESON_BUILD_DIR"] = str(target_dir)
+    env["MESON_BUILD_ROOT"] = str(args.meson_build_root)
 
     return (env, cargo_cmd)
 
@@ -234,6 +236,14 @@ def main() -> None:
         required=True,
     )
     parser.add_argument(
+        "--meson-build-root",
+        metavar="BUILD_ROOT",
+        help="meson.project_build_root()",
+        type=Path,
+        dest="meson_build_root",
+        required=True,
+    )
+    parser.add_argument(
         "--meson-source-dir",
         metavar="SOURCE_DIR",
         help="meson.current_source_dir()",
-- 
γαῖα πυρί μιχθήτω


