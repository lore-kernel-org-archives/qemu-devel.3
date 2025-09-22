Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B0ACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 05:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ZMb-00086D-1v; Mon, 22 Sep 2025 01:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v0ZMX-00083d-OT
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:45:21 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v0ZMT-0004vN-M0
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 01:45:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-25669596955so36105145ad.0
 for <qemu-devel@nongnu.org>; Sun, 21 Sep 2025 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758519912; x=1759124712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51lPqiebpu5zL2+dy3jcywPPraPkvqTAkxbf02qUiQA=;
 b=RAjmBSgitotc+Hj5B9bhIctzGybJIflv0YCucFlS7T2wO0FEPxlDeCkVO69QSbtets
 Bq/Ti67AZakyPl5eU7+AnNQVOVGw2g2q3Fj1i/v6c423afLFaTVd+46WkX+3C9mijO2Y
 v7yi8qFkJlSu0t//IBqUZWlU1ma+6mg2/Af349icWVVbmb617oqCK0MoN+4pFOQCKOJe
 5Ir3w0lyAh7Zr5byg9Cu5e8oDWRwiOhU3sNmO3NScDm/dR1V4xAV2UwUaSCcQMlAaZA7
 Rics70PSMqodNbR94upPDoNSgF4hzyWWHn3LABtRfLq5EfBRoE4XmQbbp3eaDmH2MzO4
 2+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758519912; x=1759124712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51lPqiebpu5zL2+dy3jcywPPraPkvqTAkxbf02qUiQA=;
 b=KcG/9xz9yp2RaHEZLS4MeYS/cgl21LNoED5A31ySt74b/iYb7owHKIw9NuCrrkO7gh
 779BxfgBzQ5js7rOwX2rxV3xIDuVUwFV2Ao18s2meLf2I2x7tk0r99ztTjTPG3jDsLlO
 jtFrGD34Tv9l97ckYsC8UceF5CNJh66w2J+0dcKh47yr6bFlZlUogQkcSsyn6o1fK2Pk
 fL/C2f2xj75kUdc+nuwpoxUuBavaTJm4d9ATFxU0MF/YXgcZDlWeEodiMQ/qTxP4YwT9
 hnkxdqrzGLGNIPFIIK1iPBP1hZFLcEjwui0c3viPIpoc7qDoWZQh90bn1k8KE1FBfEb0
 jvrQ==
X-Gm-Message-State: AOJu0YyHP2ZBCRdNQyQM6X3udwqwn3q2x+JxeRu/UP4EeuGya+FQjh4M
 TAC7u4WbmwM6tdIVANC1k+ZG/qbxsvYngQlYZ8pvDXHR8BPRrTpUg2ATV6432ipAX5c4ELHOHgT
 6wlbL
X-Gm-Gg: ASbGnctG/h7ai98Mx8FoMXXIfdlChQAUFL9398rNkZHalZbc0mHxREmvCr3PTkUSMtf
 PTt26Dc7Lshb1Jrfj5VG3rF8V6ud1PB4ggkPPHyoc3OeeJBB/Xmzj6sNidRzqIDEt48M/+4Jqv5
 be4r8k0Oi2qQqdFydvshpTouQzdkUSpN0RC+oIL+OcRno4UYqGacL5KuWn9DC4rrI407yu+5nBl
 2/bQt5o78vO/pYQejCU93ymaFjDfC0Z6tKsdba5ZC5in6Fdlzw6RIswfIratTTzpRyQZok2vh4z
 CEdVBsRocO4p0ILDMvQAXhOn5l4yx5ilonNG6P7WKrNXccVQZzL9WXbD3RsI2V+eGhUhfdWYbbk
 4/n7oJU/LZy57UZd/Ws7HZTkUzSK+Y+3bx0gfaoqrrQsdHZ9bis4gBjGJmSJlLViMX1xRLu5M
X-Google-Smtp-Source: AGHT+IEHJhfrMzTumGa4LxUTFUsaVLT+ZBq0rsm/EQTIMJA3R24yC3wRxIbTgvQyS035IHtfYUzjeQ==
X-Received: by 2002:a17:903:4b04:b0:24f:dbe7:73a2 with SMTP id
 d9443c01a7336-269ba514490mr130608025ad.31.1758519912135; 
 Sun, 21 Sep 2025 22:45:12 -0700 (PDT)
Received: from gromero0.. (200-162-224-93.static-corp.ajato.com.br.
 [200.162.224.93]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b551c279cd5sm7691377a12.3.2025.09.21.22.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 22:45:11 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v3 4/4] tests/functional: Adapt arches to reverse_debugging
 w/o Avocado
Date: Mon, 22 Sep 2025 05:43:51 +0000
Message-Id: <20250922054351.14289-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922054351.14289-1-gustavo.romero@linaro.org>
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

reverse_debugging no longer depends on Avocado, so remove the import
checks for Avocado, the per-arch endianness tweaks, and the per-arch
register settings. All of these are now handled in the ReverseDebugging
class.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 .../functional/aarch64/test_reverse_debug.py  | 13 +++++--------
 tests/functional/ppc64/test_reverse_debug.py  | 15 +++++----------
 tests/functional/x86_64/test_reverse_debug.py | 19 ++++++-------------
 3 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
index 8bc91ccfde..7f816025a9 100755
--- a/tests/functional/aarch64/test_reverse_debug.py
+++ b/tests/functional/aarch64/test_reverse_debug.py
@@ -1,26 +1,23 @@
-#!/usr/bin/env python3
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for aarch64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
+from qemu_test import Asset, skipFlakyTest
 from reverse_debugging import ReverseDebugging
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_AArch64(ReverseDebugging):
 
-    REG_PC = 32
-
     ASSET_KERNEL = Asset(
         ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
@@ -35,4 +32,4 @@ def test_aarch64_virt(self):
 
 
 if __name__ == '__main__':
-    ReverseDebugging.main()
+    ReverseDebugging_AArch64.main()
diff --git a/tests/functional/ppc64/test_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
index 5931adef5a..2b7b18e9a8 100755
--- a/tests/functional/ppc64/test_reverse_debug.py
+++ b/tests/functional/ppc64/test_reverse_debug.py
@@ -1,41 +1,36 @@
-#!/usr/bin/env python3
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for ppc64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import skipIfMissingImports, skipFlakyTest
+from qemu_test import skipFlakyTest
 from reverse_debugging import ReverseDebugging
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_ppc64(ReverseDebugging):
 
-    REG_PC = 0x40
-
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
     def test_ppc64_pseries(self):
         self.set_machine('pseries')
         # SLOF branches back to its entry point, which causes this test
         # to take the 'hit a breakpoint again' path. That's not a problem,
         # just slightly different than the other machines.
-        self.endian_is_le = False
         self.reverse_debugging()
 
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")
     def test_ppc64_powernv(self):
         self.set_machine('powernv')
-        self.endian_is_le = False
         self.reverse_debugging()
 
 
 if __name__ == '__main__':
-    ReverseDebugging.main()
+    ReverseDebugging_ppc64.main()
diff --git a/tests/functional/x86_64/test_reverse_debug.py b/tests/functional/x86_64/test_reverse_debug.py
index d713e91e14..408e5d1f48 100755
--- a/tests/functional/x86_64/test_reverse_debug.py
+++ b/tests/functional/x86_64/test_reverse_debug.py
@@ -1,36 +1,29 @@
-#!/usr/bin/env python3
-#
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-# Reverse debugging test
+# Reverse debugging test for x86_64
 #
 # Copyright (c) 2020 ISP RAS
+# Copyright (c) 2025 Linaro Limited
 #
 # Author:
 #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
+#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from qemu_test import skipIfMissingImports, skipFlakyTest
+from qemu_test import skipFlakyTest
 from reverse_debugging import ReverseDebugging
 
 
-@skipIfMissingImports('avocado.utils')
 class ReverseDebugging_X86_64(ReverseDebugging):
 
-    REG_PC = 0x10
-    REG_CS = 0x12
-    def get_pc(self, g):
-        return self.get_reg_le(g, self.REG_PC) \
-            + self.get_reg_le(g, self.REG_CS) * 0x10
-
     @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
     def test_x86_64_pc(self):
         self.set_machine('pc')
-        # start with BIOS only
+        # Start with BIOS only
         self.reverse_debugging()
 
 
 if __name__ == '__main__':
-    ReverseDebugging.main()
+    ReverseDebugging_X86_64.main()
-- 
2.34.1


