Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39596CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gm-0005eB-FH; Fri, 29 May 2026 15:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3Gg-00057a-5n
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:19 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3Ge-0005dE-Bb
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:17 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69de16f5e80so1744865eaf.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084395; x=1780689195; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=foXIRPjA5gS3G5f+1cVTKO/YSOx+Ynfsprdlu+eUN/8=;
 b=HHmkrOkBrcTks/IkabWW4KsGC4aV6ee1wbEl+RABifJ85Y/Kas2IyVaKrVan/Ge1nc
 tmzPxuJ1M29aJ4ZDsL/Ar0SDwRbnp3wGjhwiNd/DcXftlivRItDYuaAICZsC5DWLm0Lu
 uNi8iiLIFTxItwnXRxc6ELCCoMTUztG2TrcFgzj7wzAf7mxtS8B295PYSN39PT44ehuP
 nC6AxGTP9Kff8e7Aj/Tnkwp84ry22cDa9Mcr8sZ/z5xRKtESWXdQtRT76dce4629gduu
 uhJZJZGa/qXFSXQbaVzTGvD3qarjzJSjGsM4+q2hu0uo2awxhHdvipiQBhUWum7LDr5j
 WPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084395; x=1780689195;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=foXIRPjA5gS3G5f+1cVTKO/YSOx+Ynfsprdlu+eUN/8=;
 b=r+u1TunszwBFhlJADtvNiAhuErpkeAovfpr9vtcr9b0oDk2cv+KrjlMDLApvZeF7J9
 F8SqEbRxcvp4v8o3jbmK45zmz/nt8pbvq2RnMZaTk0kGcH/mZNC6WsAXghPUR6Z57Eqo
 m0pfc5p5VLDc43n5nz18VTByt3SOpBl1Uvnsr5GHlrz1d7q8JaHT1+uKnpf+HZXUjO+N
 AfQVczI6mHqMlP6Ym4lWC0fTJBCWN4sG7VLur02vKDKmSDYhJ/vEDXajDo+1e8XqncEU
 zbmOzDujdeTX6o+RP+OHgKufdx+2Bx9NYRZBosnKI48TfwIc7/GE4Z0AIyA75l2ZvLU5
 mjKw==
X-Gm-Message-State: AOJu0Yzjmeb7rmNPJp9qcqqZ+pvv/iVRtaenS3//O/42n0kXM9XOns6r
 fVEaMNIqORyneNJD4c7iQQUI6q8P40hZW/H2aGEsoRgwXsZk91XJO5Yr
X-Gm-Gg: Acq92OHm7OVzRRJ9JF641Dt5NVrAOxp+B0gEIXqzVz9j+/PH0MSVILi5JevVhnE5EsO
 RnuKOhwLZXOgu8fMizc2yf+WCqEeEpT7gqZ+dhRxs1GkB00xvvxkg+dI69i3y3T+NY+U2z1rc1w
 KAsOe8OCE/VDPEnBf+cQfgOIrmf//xL4A6rGIhYGC8L8rXD3fGUP5tWNyntJZuh2F7GRafWxg9z
 NiyV7YvKsGkQ5jcfqZ/yoAGOkh/nIxRHX3BQcfKQQi6/pyIPPA/rHBxvXzQQEyGfxLlHhkfKck8
 2l7zClqo/gMoz1cmRoB1p7UrbbTQTxPYIlvtXaw9ZWwGoKYwmUw7nNJ9MePnrn2B0Fgrd2x1JrB
 lk93JUJFIF0xhPug6VwAbMqQ8XjXWEQg8gfe16kRSvQ+20nFm0tE+B0aSyzeN+S9bhkL87A0fzy
 y/eEbKicBO6xUuPfOUgrY7SpqUkUzTf0Yck0/nZELiUPQ=
X-Received: by 2002:a05:6820:827:b0:696:8ccc:5588 with SMTP id
 006d021491bc7-69e103cc45bmr388456eaf.42.1780084395206; 
 Fri, 29 May 2026 12:53:15 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:53:14 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:55 -0700
Subject: [PATCH v7 15/15] tests/tcg: add test for MTE_STORE_ONLY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-15-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=2991;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=mAwPuGJQelulccRrIcbbltCeg9NHZ8EE7GZcbX8aqAw=;
 b=3JpN1NWhlsn+xZKv7pYxFrPc/dCM75WHtfx+BtUY8UlprEmsG6bf517qrCKRKFEkb7YjRLXq+
 g4erT6/54WnCP+5+NMQ4mwYUBWY8xz3kZb90ZhiDl8Mee0yvwg68hTj
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc2d.google.com
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

Added a test that checks that MTE checks are not performed on loads when
MTE_STORE_ONLY is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-10.c        | 49 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/mte.h           |  4 ++--
 3 files changed, 52 insertions(+), 3 deletions(-)

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
2.54.0


