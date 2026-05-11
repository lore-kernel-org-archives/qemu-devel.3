Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D7CD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRDR-0004OY-0f; Mon, 11 May 2026 10:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCQ-0003xt-PO
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCO-00068E-8h
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:34 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-42fdab683a9so3255889fac.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508090; x=1779112890; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i0UGA6W7acHfQzFgg07ojZd+ADYp8WlSjAFL26/Ip64=;
 b=jkTqgAqPShZo8x++EoXwpyJOXlofoyVxtKWVr7bqWBsa1/U5kxvdt2Tgz2t3eDxYDr
 LAGK5/LF5HbsQgeHYCLi9zi223H+52XyaJfkh7glvJ77USFxx+3i6FqbsJYodWgoGTYP
 VZG/Hw2ZdlkP7h5G+3i8slAkAWGGPZZAq+zn3Y4yBLJTMlR+Z3UCpRJDKEzmVt5rA8pQ
 XyD2DmU3mL4mm3JCOO37T7WBSYuVaMWI13ggaDHD4BGheK8aNNOe8jS6dGnLJ+H4C5Rx
 L+uGiwlDbBO1DqrZbzeR+tXeuhv6oyD2cqJrqYO0R7oYClGmYmF7R8mQXxTTsRap/0gZ
 ad0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508090; x=1779112890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i0UGA6W7acHfQzFgg07ojZd+ADYp8WlSjAFL26/Ip64=;
 b=KyjyC48o4ijj/hNEqVxtYR5XSbWkf3xgJbecrizj6YJWDGvCCKnKR0UO7lDcfwK3r2
 ZCaIlylmpAUW9kupVy15h8z2t5knc4hF+9FVfi8MA4UP8BEI/IvMDut8klA+QaoXzbw1
 PCZ19TJrv2yWHHTkqtSuRgeWV3Wf1E+q5JyeoOtULGJNNGeWvger0MH3qMiElrIiHbau
 TWrSNJ+8ExPbbagCvDTizffxaOyWFB3o685POgiESQDyG4sg27TFsCqeTQwVuJKLiIH1
 4xdY0CrPvk7P4IQIJn2CfQrEuEiW5eqdCDzzrGMxY5DcTba+fTuVPO+PXeWsbD5Yqddh
 7OYw==
X-Gm-Message-State: AOJu0YwAXRIO7S7iUUcS0aziGyMa9qN6EbMiU3mHtLKN18N74V12Lj/3
 63J1pBWQkFyyBxBqS8fPk2ZPTiJDfapQyUBdyMqYowTzFInb1kv2RsKg
X-Gm-Gg: Acq92OGgqJNwdFC8PK9zAM3Rqd1QNOmkP/e9OPj6xlWxmY1bqi8vLrX01utCj6B2bh5
 Galomo98luNY2tHICHGMwH0jgDAAopXsQZFARz2UFh2latF3cg5Ht/Bp6OPr5Iaf5H6Mxnt/MoL
 MsPXqL5WS+rOaKxJDRYYDq5f4M05sju5ZmQp0tKAAqItMwK7JtKCwQ61cDM8WasQSHoVILQAMPP
 mFG0Aw61KXaDfGbBc+TWhsqmmYnVTAAtzsJpWjQC6VdgL6YaSjo2yEVh8jGzUUMWk4qA/g0PBYz
 p2+SQ+fPe31OQCg+fLHPuaFsQXzcp3elGKTTC2wnGerN61TRZQPWv3BTSEe0D5N6v33XpnSO6R3
 cQiY6OkLTkERL2GdDYRZraC7GjANFyXORGjIuESYyO41sCZe/LyEHLyOln5a5oqUbxL5h7PdkV2
 iDFc1Z3F/SsvXhmlwolCAJ6vLYje6z3TYqHHzYvhBw
X-Received: by 2002:a05:6820:99a:b0:694:9f32:b with SMTP id
 006d021491bc7-69998c834a0mr12651716eaf.6.1778508090183; 
 Mon, 11 May 2026 07:01:30 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:29 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:01:12 -0400
Subject: [PATCH v6 14/15] tests/tcg: add test for MTE FAR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-14-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=2355;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=t9UKuOxOMkff21yBSwiqqFvgFWXDPNIeJTAexYT0IVc=;
 b=NriYzunSsNSBseoGW747LNEq11SNnkQzggStw8EU9AoPHAWCUhIl1EQ9S1xsPv3HSrlObGWuB
 2XR/6E9mbJoCuFTLWrD4byQqJ9DJ5xWzkD4DkC9/JVu4AGuwe+Uc77w
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oa1-x33.google.com
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

This functionality was previously enabled but not advertised or tested.
This commit adds a new test, mte-9, that tests the code for proper
full-address reporting. FEAT_MTE_TAGGED_FAR requires that FAR_ELx
report the full logical address, including tag bits.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-9.c         | 48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 9fa8687453..b491cfb5e1 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -64,7 +64,7 @@ AARCH64_TESTS += bti-2
 
 # MTE Tests
 ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8
+AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9
 mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
 endif
 
diff --git a/tests/tcg/aarch64/mte-9.c b/tests/tcg/aarch64/mte-9.c
new file mode 100644
index 0000000000..9626a90c13
--- /dev/null
+++ b/tests/tcg/aarch64/mte-9.c
@@ -0,0 +1,48 @@
+/*
+ * Memory tagging, full-address reporting.
+ *
+ * Copyright (c) 2021 Linaro Ltd
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "mte.h"
+
+static void *faulting_ptr;
+
+void pass(int sig, siginfo_t *info, void *uc)
+{
+    assert(faulting_ptr == info->si_addr);
+    exit(0);
+}
+
+int main(int ac, char **av)
+{
+    struct sigaction sa;
+    int *p0, *p1, *p2;
+    long excl = 1;
+
+    enable_mte(PR_MTE_TCF_SYNC);
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
+    *p1 = 0;
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = pass;
+    sa.sa_flags = SA_SIGINFO;
+    sigaction(SIGSEGV, &sa, NULL);
+
+    faulting_ptr = p2;
+    *p2 = 0;
+
+    abort();
+}

-- 
2.54.0


