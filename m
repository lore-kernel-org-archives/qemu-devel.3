Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875C8CF58E6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 07:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srYI4-0003qc-G1; Fri, 20 Sep 2024 03:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYHj-0001rQ-9s; Fri, 20 Sep 2024 03:42:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1srYHh-0000JL-GN; Fri, 20 Sep 2024 03:42:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B3E890866;
 Fri, 20 Sep 2024 10:41:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D24FC1409E9;
 Fri, 20 Sep 2024 10:41:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 16/22] target/hexagon: Rename macros.inc -> macros.h.inc
Date: Fri, 20 Sep 2024 10:41:28 +0300
Message-Id: <20240920074134.664961-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920074134.664961-1-mjt@tls.msk.ru>
References: <20240920074134.664961-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commits 139c1837db ("meson: rename included C source files
to .c.inc") and 0979ed017f ("meson: rename .inc.h files to .h.inc"),
EMU standard procedure for included header files is to use *.h.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename "macros.inc" as "macros.h.inc".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <bcain@quicinc.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/hexagon/gen_idef_parser_funcs.py                 | 2 +-
 target/hexagon/idef-parser/README.rst                   | 4 ++--
 target/hexagon/idef-parser/{macros.inc => macros.h.inc} | 0
 target/hexagon/meson.build                              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename target/hexagon/idef-parser/{macros.inc => macros.h.inc} (100%)

diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index eb494abba8..72f11c68ca 100644
--- a/target/hexagon/gen_idef_parser_funcs.py
+++ b/target/hexagon/gen_idef_parser_funcs.py
@@ -50,7 +50,7 @@ def main():
     tagimms = hex_common.get_tagimms()
 
     with open(sys.argv[-1], "w") as f:
-        f.write('#include "macros.inc"\n\n')
+        f.write('#include "macros.h.inc"\n\n')
 
         for tag in hex_common.tags:
             ## Skip the priv instructions
diff --git a/target/hexagon/idef-parser/README.rst b/target/hexagon/idef-parser/README.rst
index d0aa34309b..7199177ee3 100644
--- a/target/hexagon/idef-parser/README.rst
+++ b/target/hexagon/idef-parser/README.rst
@@ -138,7 +138,7 @@ we obtain the pseudo code
 with macros such as ``fJUMPR`` intact.
 
 The second step is to expand macros into a form suitable for our parser.
-These macros are defined in ``idef-parser/macros.inc`` and the step is
+These macros are defined in ``idef-parser/macros.h.inc`` and the step is
 carried out by the ``prepare`` script which runs the C preprocessor on
 ``idef_parser_input.h.inc`` to produce
 ``idef_parser_input.preprocessed.h.inc``.
@@ -266,7 +266,7 @@ in plain C is defined as
     #define fABS(A) (((A) < 0) ? (-(A)) : (A))
 
 and returns the absolute value of the argument ``A``. This macro is not included
-in ``idef-parser/macros.inc`` and as such is not expanded and kept as a "call"
+in ``idef-parser/macros.h.inc`` and as such is not expanded and kept as a "call"
 ``fABS(...)``. Reason being, that ``fABS`` is easier to match and map to
 ``tcg_gen_abs_<width>``, compared to the full ternary expression above. Loads of
 macros in ``macros.h`` are kept unexpanded to aid in parsing, as seen in the
diff --git a/target/hexagon/idef-parser/macros.inc b/target/hexagon/idef-parser/macros.h.inc
similarity index 100%
rename from target/hexagon/idef-parser/macros.inc
rename to target/hexagon/idef-parser/macros.h.inc
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 9ea1f4fc59..f1723778a6 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -284,7 +284,7 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
         'idef_parser_input.preprocessed.h.inc',
         output: 'idef_parser_input.preprocessed.h.inc',
         input: idef_parser_input_generated,
-        depend_files: [idef_parser_dir / 'macros.inc'],
+        depend_files: [idef_parser_dir / 'macros.h.inc'],
         command: [idef_parser_dir / 'prepare', '@INPUT@', '-I' + idef_parser_dir, '-o', '@OUTPUT@'],
     )
 
-- 
2.39.5


