Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81C4C27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGypg-0003OG-Nq; Tue, 11 Jun 2024 06:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGype-0003Nc-Na
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGypc-0002lm-G7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4218180a122so6537135e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718102063; x=1718706863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3hGjPp4kpFClFx6XzFBUyWzYHXYbuTJw2gtRe9HROw=;
 b=DHzAn+iHNi11vhH8qJJnxkXP+heMWBrQorCDjwQ2xqUSNCas5OPBxIHieAbFwBneBO
 vdCODXO5UozcGU+GA9X43VkVxnDeguHiNXGvA/5iYDWCDUgWosi08pdCxa8VGV9gOLOH
 C9s9fuzkbwECLn9wZyvWY9F+5QwwE1jHXEvucTxbqorQ1GpeARcnVv3yWWfSI7dzZRSU
 SQWs7ir/QEDVSsQCkOzjahYMWUWpKK2cMHDFTdSaMpqa0bH5CbWYm2vVsjXgE3zi27Qq
 hya1ZuCGjpUKcAH2uvF723+jhazfCou012cRWrh8ws8gmtnhn/IrFK2X5J5UBzRt0qci
 9mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718102063; x=1718706863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3hGjPp4kpFClFx6XzFBUyWzYHXYbuTJw2gtRe9HROw=;
 b=i8hGsCgBsyz2OPgHdHew8XqEfDyztwmBD6zMXbhoWLn85ukDJQqs5Mj3Yj1ZPyCJMM
 gt/wIqL04Nu2pKebEWMkoRSvxOUuor5Qv1SXvOJFpO67RHQUfF82rtSISQ6G3B+xK+jQ
 FHlGs3THnu3mp2m9L1G+G23xbD7UPuAdHHQ9ExCUo0RD0TNdHsJPW6K/Z4WNAfb88MWh
 7wpOED0Er2RRyu0feXtmB/0Jp5d7LZJGKon/+1ohIha9bfeGNwI9NFy7/8LOENpDYYEx
 llBEd7V7C1WW2ItLpAEjEgTNf58wcj4CyDcTATJkIWZ9s3up1UqxT5dKPiFIK6x/MR6n
 0PRA==
X-Gm-Message-State: AOJu0YyAr10+UfKlBWmYgID9jQeORzddS0jS+wFv5hbapnH6uKSA0ko9
 V1S3QuHYNmq2eMvR5VGETxCdObFYn9OCVxBOFUQbjChXgS50KnMI67r0ZKc22x/Cs9tH8+7/TLb
 KfTE=
X-Google-Smtp-Source: AGHT+IG3jzg9Mx+11ZkKnlS+e/w/NRMlQct9hJmQEGaKUUwTTMDnIp0O1mmer2dciwRijiVyx4hKaQ==
X-Received: by 2002:a05:600c:1f86:b0:420:2cbe:7efd with SMTP id
 5b1f17b1804b1-42164a21ea7mr134363685e9.31.1718102062707; 
 Tue, 11 Jun 2024 03:34:22 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42232e71865sm30878795e9.46.2024.06.11.03.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:34:22 -0700 (PDT)
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
Subject: [RFC PATCH v2 2/5] rust: add bindgen step as a meson dependency
Date: Tue, 11 Jun 2024 13:33:31 +0300
Message-ID: <ef980fb29deb81d574a7301365d9b9db72c015eb.1718101832.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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
 MAINTAINERS              |  2 +
 meson.build              | 87 ++++++++++++++++++++++++++++++++++++++
 rust/meson.build         | 91 ++++++++++++++++++++++++++++++++++++++++
 rust/wrapper.h           | 39 +++++++++++++++++
 scripts/cargo_wrapper.py | 10 +++++
 5 files changed, 229 insertions(+)
 create mode 100644 rust/meson.build
 create mode 100644 rust/wrapper.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 431010ddbf..ff6117f41d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4227,6 +4227,8 @@ Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: scripts/cargo_wrapper.py
+F: rust/meson.build
+F: rust/wrapper.h
 
 Miscellaneous
 -------------
diff --git a/meson.build b/meson.build
index 3533889852..a08c975ef9 100644
--- a/meson.build
+++ b/meson.build
@@ -3876,6 +3876,93 @@ foreach target : target_dirs
     lib_deps += dep.partial_dependency(compile_args: true, includes: true)
   endforeach
 
+  if with_rust and target_type == 'system'
+      rust_bindgen = import('unstable-rust')
+      rust_bindgen_dep = declare_dependency(
+        dependencies: arch_deps + lib_deps,
+        include_directories: target_inc,
+        sources: arch_srcs + genh)
+
+      # We need one generated_rs target per target, so give them
+      # target-specific names
+      copy = fs.copyfile('rust/wrapper.h', target + '_wrapper.h')
+      generated_rs = rust_bindgen.bindgen(
+        input: copy,
+        dependencies: arch_deps + rust_bindgen_dep,
+        output: target + '-generated.rs',
+        include_directories: target_inc + include_directories('.') + include_directories('include'),
+        args: [
+          '--formatter',
+          'rustfmt',
+          '--no-doc-comments',
+          '--merge-extern-blocks',
+          '--generate-block',
+          '--generate-cstr',
+          '--impl-debug',
+          '--with-derive-default',
+          '--use-core',
+          '--ctypes-prefix',
+          'core::ffi',
+          '--blocklist-var',
+          'IPPORT_RESERVED',
+          '--blocklist-type',
+          '^.+_.*autoptr$',
+          '--blocklist-type',
+          'max_align_t',
+          '--blocklist-function',
+          'str*',
+          '--blocklist-function',
+          'ato*',
+          '--blocklist-function',
+          'p?select',
+          '--blocklist-file',
+          '.+inttypes.h$',
+          '--blocklist-file',
+          '.+limits.h$',
+          '--blocklist-file',
+          '.+ctype.h$',
+          '--blocklist-file',
+          '.+errno.h$',
+          '--blocklist-file',
+          '.+fcntl.h$',
+          '--blocklist-file',
+          '.+getopt.h$',
+          '--blocklist-file',
+          '.+assert.h$',
+          '--blocklist-file',
+          '.+stdbool.h$',
+          '--blocklist-file',
+          '.+stdio.h$',
+          '--blocklist-file',
+          '.+stdint.h$',
+          '--blocklist-file',
+          '.+stdalign.h$',
+        ],
+        c_args: c_args,
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
diff --git a/rust/meson.build b/rust/meson.build
new file mode 100644
index 0000000000..e9660a3045
--- /dev/null
+++ b/rust/meson.build
@@ -0,0 +1,91 @@
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
+rust_supported_oses = {'linux': '-unknown-linux-gnu', 'darwin': '-apple-darwin', 'windows': '-pc-windows-gnu'}
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
+    message(meson.source_root() + '/meson.build.')
+  endif
+endforeach
+foreach rust_cpu: rust_supported_cpus
+  if not supported_cpus.contains(rust_cpu)
+    message()
+    warning('UNSUPPORTED CPU VALUES IN ' + meson.current_source_dir() + '/meson.build')
+    message()
+    message('This meson.build file claims CPU `+' + rust_cpu + '` is supported but')
+    message('it is not included in the global supported CPUs list in')
+    message(meson.source_root() + '/meson.build.')
+  endif
+endforeach
+
+if meson.is_cross_build()
+  message()
+  error('QEMU does not support cross compiling with Rust enabled.')
+endif
+
+rust_target_triple = get_option('with_rust_target_triple')
+
+# TODO: verify rust_target_triple if given as an option
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
+endif
+
+if get_option('optimization') in ['0', '1', 'g']
+  rs_build_type = 'debug'
+else
+  rs_build_type = 'release'
+endif
+
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
+        '--crate-dir',
+        meson.current_source_dir() / rust_hw_dev['dirname'],
+        '--profile',
+        rs_build_type,
+        '--target-triple',
+        rust_target_triple,
+        '--outdir',
+        '@OUTDIR@',
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
index d338effdaa..a36a4fc86d 100644
--- a/scripts/cargo_wrapper.py
+++ b/scripts/cargo_wrapper.py
@@ -94,6 +94,8 @@ def get_cargo_rustc(args: argparse.Namespace) -> tuple[Dict[str, Any], List[str]
 
     env = os.environ
     env["CARGO_ENCODED_RUSTFLAGS"] = cfg
+    env["MESON_BUILD_DIR"] = str(target_dir)
+    env["MESON_BUILD_ROOT"] = str(args.meson_build_root)
 
     return (env, cargo_cmd)
 
@@ -164,6 +166,14 @@ def main() -> None:
         required=True,
     )
     parser.add_argument(
+        "--meson-build-root",
+        metavar="BUILD_ROOT",
+        help="meson.project_build_root()",
+        type=pathlib.Path,
+        dest="meson_build_root",
+        required=True,
+    )
+    parser.add_argument(
         "--meson-source-dir",
         metavar="SOURCE_DIR",
         help="meson.current_source_dir()",
-- 
γαῖα πυρί μιχθήτω


