Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4962ECA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQDu-0000cr-QF; Wed, 07 Oct 2026 07:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQDc-0000QT-Tc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:56 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQDa-00080S-Nu
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:56 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-14fd9dafb0dso1437374c88.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791374033; x=1791978833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JXP1wwbglr7bwoFgVgWKmD4MWSpM8h/BGl1nK6lxUug=;
 b=VaTd4jn5XwjKKtnSMujrh+bFwlLGeYA/O5K+iUaQlvmUNphVGIiOBSjTP5g+VyXTwH
 LxN4iEWMSAlKBgtXK+3HR/fF3020Qq8YZjTxZOggPGKOBeW197DhX5hQG/iWlJi797Q1
 OO/0eorH6HuOma7/pSqIQoAm2HDQ07XD6eUyPX864v03st5oe+JeXEp4kBuVoDBMxKLZ
 LJfYsExBkMtdlTtJikWY0ILkJ76zstB3UPyX73/GqE4F48pOORdbRFR50AbOlgh1/IBp
 8F4Oo36sbji3ljpFxj0IcmpVIqGgJTrf0aEMX8OqPsPHPVeNhpUmJ0Xc1f85SQy5oPK6
 2nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374033; x=1791978833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JXP1wwbglr7bwoFgVgWKmD4MWSpM8h/BGl1nK6lxUug=;
 b=jMFbsKEbclE3BnGE8BsIh10mA0cKW7HwOgOLKrZToF+9ar+IiWmxuIwFSV4eS91cgt
 c5uncpzYgpeULcREyAVzcj5To/0oD7A8uzLamdjKUucbQZoyWRRfhMfgu2d7yktXB4qp
 Bs5wj9p0W6xcBOM6qtxhuPmOwGBAFD2RL31eBbh4mWSv1Sz5RMJnskp4LMH4hsUqJqAl
 jcyt6p1s994QmwqCpvGWl/lyMOGAB1s3pFDx0BTMc8L+meBH+B2S9e9+GMcWwpXqM3M9
 xg+68/5y/NIFVvHdTZPvfzCwEF0Z6DcwlNEAiVhqlgXNTMQzG6Kp6vcYwdViE6/nzr0x
 bWPg==
X-Gm-Message-State: AFuF++mWt8lpMqqHrzaPEcZyxPZ16Hv7VBoKoreBTeEOznvCYNngrBAD
 MWuGytha2qP8qXY9ngM4oy7DVNZlnUmt/TzT8co5kMpo0APD0APtmB7HxqV670sH
X-Gm-Gg: AYBFou19NiJq+YN02a4kuuR81q+2AaIViHBMqDfR+N8n7fb2cr5sfHxdaUGP6jXV3jS
 gwrIFcpt/ye15mlDMjsziMThMjKu7PTV5u54frgS+kJ60GazC8nD193L7925SxHjLEswGAqvI6p
 POfbkSTDU2xisiGHpA/1prvcw5g7BPgXAgtj46hgpCrEVKlWeseCNH84+4MPv6XR332tN0cQMNJ
 EyKVrqcXp9JpeIXGY/rLYgr+nOfUyDdlabmMKZstIptXvcVFoL9+t5QPKcBk/nZvHtbw8GXZmO3
 c33VybnK5igAMS/kk30GjYjPCmAl30L2ZTxBgtSXBrjoJd/4+JZ+vaYy50yC5XocksW1oqUiAUL
 5hZaOhuTKYDzTSTydkYwiBzcIaQMSJYncvjI7zMI4M9UXJZYbyFfoa9DfH0OT583USj4/+uKewW
 KDCimShaM8vtt5TNUIqkvU5+RZNUqNrxv40O0rhGP9IOCSkMkOD6+DLsR92OwYWiy/BpbOWlJVM
 5tnL3WvicYw975fDw==
X-Received: by 2002:a05:7022:69a9:b0:143:2984:6517 with SMTP id
 a92af1059eb24-1620966b83amr2987038c88.38.1791374033000; 
 Wed, 07 Oct 2026 04:53:53 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1616980c3b7sm6429520c88.16.2026.10.07.04.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:53:52 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 7/8] target-info: Replace handwritten architecture checks with
 generated code
Date: Wed,  7 Oct 2026 19:48:04 +0800
Message-ID: <20261007115253.328-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261007115253.328-1-luoyonggang@gmail.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add scripts/gen-target-info.py to generate declarations and definitions
for exact-target and base-family architecture checks from system target
names and their TARGET_BASE_ARCH values.

Provide target_is_<arch>() and target_is_base_<family>() checks for an
explicit TargetInfo. Retain target_<arch>() and target_base_<family>()
as wrappers using the current target.

Wire the generator into Meson using all system target definitions so
the available checks do not depend on --target-list.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 76 ++++-------------------------
 meson.build                | 16 ++++++
 scripts/gen-target-info.py | 99 ++++++++++++++++++++++++++++++++++++++
 target-info.c              | 62 +-----------------------
 4 files changed, 125 insertions(+), 128 deletions(-)
 create mode 100644 scripts/gen-target-info.py

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index d1928cecf84..88aa80e918c 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -51,74 +51,16 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
-/**
- * target_base_arm:
- *
- * Returns whether the target architecture is ARM or Aarch64.
- */
-bool target_base_arm(void);
-
-/**
- * target_arm:
- *
- * Returns whether the target architecture is ARM (32-bit, not Aarch64).
- */
-bool target_arm(void);
-
-/**
- * target_aarch64:
- *
- * Returns whether the target architecture is Aarch64.
- */
-bool target_aarch64(void);
-
-/**
- * target_m68k:
- *
- * Returns whether the target architecture is M68K.
- */
-bool target_m68k(void);
-
-/**
- * target_or1k:
- *
- * Returns whether the target architecture is OpenRISC 1000.
- */
-bool target_or1k(void);
-
-/**
- * target_base_ppc:
- *
- * Returns whether the target architecture is PowerPC 32-bit or 64-bit.
- */
-bool target_base_ppc(void);
-
-/**
- * target_ppc:
- *
- * Returns whether the target architecture is PowerPC 32-bit.
- */
-bool target_ppc(void);
-
-/**
- * target_ppc64:
- *
- * Returns whether the target architecture is PowerPC 64-bit.
- */
-bool target_ppc64(void);
-
-/**
- * target_s390x:
- *
- * Returns whether the target architecture is S390x.
- */
-bool target_s390x(void);
-
-/**
- * target_riscv64:
+/*
+ * Exact-target and base-family helpers, generated by
+ * scripts/gen-target-info.py from the TARGET_BASE_ARCH of every
+ * system target:
  *
- * Returns whether the target architecture is riscv64
+ *   bool target_is_<arch>(const TargetInfo *ti);
+ *   bool target_<arch>(void);
+ *   bool target_is_base_<family>(const TargetInfo *ti);
+ *   bool target_base_<family>(void);
  */
-bool target_riscv64(void);
+#include "target-info-gen.h"
 
 #endif
diff --git a/meson.build b/meson.build
index d070dafe2a9..8799b3f6d51 100644
--- a/meson.build
+++ b/meson.build
@@ -3581,6 +3581,22 @@ foreach d : hx_headers
 endforeach
 genh += hxdep
 
+# Use target_mak_all, not target_dirs, so the generated helpers do not
+# depend on --target-list.
+target_info_gen_args = []
+foreach target, mak : target_mak_all
+  if target.endswith('-softmmu')
+    target_info_gen_args += ['--target',
+      target.split('-')[0] + '=' + mak['TARGET_BASE_ARCH']]
+  endif
+endforeach
+target_info_gen = custom_target('target-info-gen',
+                      output: ['target-info-gen.h', 'target-info-gen.c.inc'],
+                      depend_files: files('scripts/qapi/common.py'),
+                      command: [python, files('scripts/gen-target-info.py'),
+                                target_info_gen_args, '@OUTDIR@'])
+genh += target_info_gen
+
 ###############
 # Trace files #
 ###############
diff --git a/scripts/gen-target-info.py b/scripts/gen-target-info.py
new file mode 100644
index 00000000000..a4c3474140f
--- /dev/null
+++ b/scripts/gen-target-info.py
@@ -0,0 +1,99 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""Generate TargetInfo target helpers and abstract machine parents.
+
+meson passes every system target with its TARGET_BASE_ARCH, independent
+of --target-list, as --target <name>=<base>.  <name> is a SysEmuTarget
+member; a target without one fails to compile.
+
+For every target <arch> and every base family <family>:
+    bool target_is_<arch>(const TargetInfo *ti);
+    bool target_<arch>(void);
+    bool target_is_base_<family>(const TargetInfo *ti);
+    bool target_base_<family>(void);
+    TYPE_TARGET_<ARCH>_MACHINE        "target-<arch>-machine"
+    TYPE_TARGET_BASE_<FAMILY>_MACHINE "target-base-<family>-machine"
+
+Machine parents are abstract and only registered when available.
+<arch> parents inherit their <family> parent, which inherits TYPE_MACHINE.
+"""
+
+import argparse
+import os
+import re
+import sys
+from typing import Dict, List
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+from qapi.common import c_enum_const, c_name
+
+HEADER = "/* Generated by scripts/gen-target-info.py. Do not edit. */"
+C_IDENT = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")
+
+
+def parse_targets(pairs: List[str]) -> Dict[str, List[str]]:
+    """Return {family: [target, ...]}, both sorted."""
+    seen = set()
+    families: Dict[str, List[str]] = {}
+    for pair in pairs:
+        name, _, family = pair.partition("=")
+        if not name or not C_IDENT.match(family) or name in seen:
+            sys.exit(f"{sys.argv[0]}: bad or duplicate --target '{pair}'")
+        seen.add(name)
+        families.setdefault(family, []).append(name)
+    return {f: sorted(t) for f, t in sorted(families.items())}
+
+
+def write(path: str, lines: List[str]) -> None:
+    with open(path, "w", encoding="utf-8", newline="\n") as fh:
+        fh.write("\n".join([HEADER, ""] + lines + [""]))
+
+
+def predicate(fn: str, cases: List[str]) -> List[str]:
+    body = (["    switch (ti->target_arch) {"]
+            + [f"    case {c}:" for c in cases]
+            + ["        return true;", "    default:",
+               "        return false;", "    }"])
+    return [f"bool target_is_{fn}(const TargetInfo *ti)", "{", *body, "}",
+            "", f"bool target_{fn}(void)", "{",
+            f"    return target_is_{fn}(target_info());", "}", ""]
+
+
+def main() -> None:
+    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
+    parser.add_argument("--target", action="append", required=True,
+                        metavar="NAME=TARGET_BASE_ARCH")
+    parser.add_argument("outdir")
+    args = parser.parse_args()
+    families = parse_targets(args.target)
+
+    # (helper suffix, QOM name, enum constants, parent macro or None)
+    entries = []
+    for family, targets in families.items():
+        consts = [c_enum_const("SysEmuTarget", t) for t in targets]
+        entries.append((f"base_{family}", f"target-base-{family}",
+                        consts, None))
+    for family, targets in families.items():
+        for t in targets:
+            entries.append((c_name(t, False), f"target-{t}",
+                            [c_enum_const("SysEmuTarget", t)],
+                            f"TYPE_TARGET_BASE_{family.upper()}_MACHINE"))
+
+    def macro(fn: str) -> str:
+        return f"TYPE_TARGET_{fn.upper()}_MACHINE"
+
+    header = ["#ifndef TARGET_INFO_GEN_H", "#define TARGET_INFO_GEN_H", "",
+              "typedef struct TargetInfo TargetInfo;", ""]
+    for fn, _, _, _ in entries:
+        header += [f"bool target_is_{fn}(const TargetInfo *ti);",
+                   f"bool target_{fn}(void);", ""]
+    write(os.path.join(args.outdir, "target-info-gen.h"),
+          header + ["#endif"])
+
+    source = []
+    for fn, _, consts, _ in entries:
+        source += predicate(fn, consts)
+    write(os.path.join(args.outdir, "target-info-gen.c.inc"), source)
+
+if __name__ == "__main__":
+    main()
diff --git a/target-info.c b/target-info.c
index 8ccb333e365..fec8ee7c08e 100644
--- a/target-info.c
+++ b/target-info.c
@@ -101,64 +101,4 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
-bool target_base_arm(void)
-{
-    switch (target_arch()) {
-    case SYS_EMU_TARGET_ARM:
-    case SYS_EMU_TARGET_AARCH64:
-        return true;
-    default:
-        return false;
-    }
-}
-
-bool target_arm(void)
-{
-    return target_arch() == SYS_EMU_TARGET_ARM;
-}
-
-bool target_aarch64(void)
-{
-    return target_arch() == SYS_EMU_TARGET_AARCH64;
-}
-
-bool target_m68k(void)
-{
-    return target_arch() == SYS_EMU_TARGET_M68K;
-}
-
-bool target_or1k(void)
-{
-    return target_arch() == SYS_EMU_TARGET_OR1K;
-}
-
-bool target_base_ppc(void)
-{
-    switch (target_arch()) {
-    case SYS_EMU_TARGET_PPC:
-    case SYS_EMU_TARGET_PPC64:
-        return true;
-    default:
-        return false;
-    }
-}
-
-bool target_ppc(void)
-{
-    return target_arch() == SYS_EMU_TARGET_PPC;
-}
-
-bool target_ppc64(void)
-{
-    return target_arch() == SYS_EMU_TARGET_PPC64;
-}
-
-bool target_s390x(void)
-{
-    return target_arch() == SYS_EMU_TARGET_S390X;
-}
-
-bool target_riscv64(void)
-{
-    return target_arch() == SYS_EMU_TARGET_RISCV64;
-}
+#include "target-info-gen.c.inc"
-- 
2.55.0.windows.3


