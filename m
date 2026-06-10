Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB42CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXs-00084j-8U; Wed, 10 Jun 2026 12:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXZ-0007kh-Tt
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXX-0005Vv-Le
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so22254f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107946; x=1781712746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4uGAVZ/Kxewos7hP6gbWmF3IZw8G3tTldc9FPXvLwic=;
 b=Msqo60wlLZJkii3lRo2URmkldNgwDBJDbqFcWDa9zImkLmBuguMAaUtnYFp31MTAOi
 hnHWUCoMNXBVOZ6g8f4S79BtYuZgUmEABW6DCBY0wjRs87zR3L5OM+GFlka7E/El3VJu
 tAcWy3qPow3E+tdbgbm+PyiMtzVHyp2kw4txoYmp/isGDsF9junpdeHEfD+N31G+PuNZ
 Sng0AP+b2rZorGgBeG5yARFClULnyf+wFJ1f9J4mfffdfC9dr3ys14hgxyy3QRjLLfUe
 HbRlXozci1cvqm+9Ia/pPx4jrCXy2CZhd/LEZ1Rjh2X8IOR9AIwdznyDal7aSJkEQH2b
 v1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107946; x=1781712746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4uGAVZ/Kxewos7hP6gbWmF3IZw8G3tTldc9FPXvLwic=;
 b=RzvZHcA+8ua7I+QFr/KQgu2tzZBlMYykkznQX+/vGfUd3TmefxArdj6iyK4iMCUUy9
 WQd3YgLiKHRk8M25rQfTihvrQ6LBEdptVHGDlxSTR65rz3a/Ue3dG/VgIBq7dfmlAvlA
 rqv8RYTVGNs+U4wVGmCDlTG5qiqey3362Z3NHucDIPJu6pceT8PLW5gPcgzb88VleGOS
 su85KFfifbpKJdO/DsIhj9CPAJXEAHrBcXaMf5SBeOZwRnmq2mLt55/kwuUzB8iDYFS4
 QIGWB+NE+6cucwGyYXIdnusaMR2FHByOdA66A2GOLGgFOxya/mrRqcoH5YH/ZXhREqTd
 jP5g==
X-Gm-Message-State: AOJu0YyKryewJJ8DReJt+orEYg6lp94/BJaYNPJX5PuzXL0zFtU6PmSQ
 4eVG8MWGXf+U6+rmcConTpP8TB5kwpcXtDlpiHw7CkkgCVN1HCsocyF4dm//9H7DboYeu8Elndm
 +dzv8
X-Gm-Gg: Acq92OFZTwNxFNcYZoZh8GCgfAWLeS6dtqhQfYpJQ75GoaYISbWPCGWwtrdpwhXu4V/
 MVw3To9eyN1ba3xHnyRTlSG1zNMWyPGy1hZkA0c5h+T8GpA3rBVNoLol9rgey/cYtvcO7BhvxL/
 TpKDLFYZGN+KacsPeUTjuVWxXVQJS9jZEBNEd65VMyttKJR70fVo5SDY3uDI3qcufRFSaK7NP9L
 UTB7sESXj1ugvEhc/vMY9TBYIzQVW22zBRJP41xu4Ini7CA4jslDj+294mq/3PpNQfg8ZzDuE/o
 t4x+21lBJeGdTF1RF4EE6OepERwO9tZvZilQqZEmD9cAxJK9oZ5Ffn0S4WufK1AjWjdLCbLI2Ui
 h3gPWaiIcHh/b5Eq8j2La/UExmXUjliL6mFcG8Nsr3ZQt8lypUp5z7oWRttd1+1IheL5udI2OKe
 4r+wfCzhpa0XcDgWV3GEStTWF9InnUz+8EIHKoaAD9A7yPwZoi4WX+lMhR8NVZC45S/gQcgDjKo
 mua5EmDSnbLfFeRk+iOnGMDFnyM5BhPe50nLd7N0is=
X-Received: by 2002:a05:6000:220f:b0:45e:8526:7dcb with SMTP id
 ffacd0b85a97d-46032b7355amr36197238f8f.7.1781107946228; 
 Wed, 10 Jun 2026 09:12:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/71] tests/tcg: add test for MTE_STORE_ONLY
Date: Wed, 10 Jun 2026 17:11:07 +0100
Message-ID: <20260610161202.2235298-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

Added a test that checks that MTE checks are not performed on loads when
MTE_STORE_ONLY is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-15-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-10.c        | 49 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/mte.h           |  4 +--
 3 files changed, 52 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/aarch64/mte-10.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b491cfb5e1..6203ac9b51 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -64,7 +64,7 @@ AARCH64_TESTS += bti-2
 
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9
+AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9 mte-10
 mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
 endif
 
diff --git a/tests/tcg/aarch64/mte-10.c b/tests/tcg/aarch64/mte-10.c
new file mode 100644
index 0000000000..46d26fe97f
--- /dev/null
+++ b/tests/tcg/aarch64/mte-10.c
@@ -0,0 +1,49 @@
+/*
+ * Memory tagging, write-only tag checking
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "mte.h"
+
+void pass(int sig, siginfo_t *info, void *uc)
+{
+    exit(0);
+}
+
+int main(int ac, char **av)
+{
+    struct sigaction sa;
+    int *p0, *p1, *p2;
+    long excl = 1;
+
+    enable_mte(PR_MTE_TCF_SYNC | PR_MTE_STORE_ONLY);
+    p0 = alloc_mte_mem(sizeof(*p0));
+
+    /* Create two differently tagged pointers. */
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(excl));
+    asm("gmi %0,%1,%0" : "+r"(excl) : "r" (p1));
+    assert(excl != 1);
+    asm("irg %0,%1,%2" : "=r"(p2) : "r"(p0), "r"(excl));
+    assert(p1 != p2);
+
+    /* Store the tag from the first pointer.  */
+    asm("stg %0, [%0]" : : "r"(p1));
+
+    /*
+     * We write to p1 (stg above makes this check pass) and read from
+     * p2 (improperly tagged, but since it's a read, we don't care).
+     */
+    *p1 = *p2;
+
+    /* enable handler */
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = pass;
+    sa.sa_flags = SA_SIGINFO;
+    sigaction(SIGSEGV, &sa, NULL);
+
+    /* now we write to badly tagged p2, should fault. */
+    *p2 = 0;
+
+    abort();
+}
diff --git a/tests/tcg/aarch64/mte.h b/tests/tcg/aarch64/mte.h
index 17b932f3f1..7093b93dc7 100644
--- a/tests/tcg/aarch64/mte.h
+++ b/tests/tcg/aarch64/mte.h
@@ -40,10 +40,10 @@
 # define SEGV_MTESERR    9
 #endif
 
-static void enable_mte(int tcf)
+static void enable_mte(int flags)
 {
     int r = prctl(PR_SET_TAGGED_ADDR_CTRL,
-                  PR_TAGGED_ADDR_ENABLE | tcf | (0xfffe << PR_MTE_TAG_SHIFT),
+                  PR_TAGGED_ADDR_ENABLE | flags | (0xfffe << PR_MTE_TAG_SHIFT),
                   0, 0, 0);
     if (r < 0) {
         perror("PR_SET_TAGGED_ADDR_CTRL");
-- 
2.43.0


