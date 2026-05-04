Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02300CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJva3-00014U-GH; Mon, 04 May 2026 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJva1-00012c-Cw
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:33 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZz-0006GN-OX
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:33 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-900fa9f178dso191366485a.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909890; x=1778514690; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i0UGA6W7acHfQzFgg07ojZd+ADYp8WlSjAFL26/Ip64=;
 b=fO3m9a+t/HLeev320Hpgi63nhC672ysBTnDAjBA6qvNix/PVpFgTMA1Bp7kZ5v2dSv
 1/MXmo3j59xir6gPT/kVC7WQAM7f1TOcZVw/YJ8z7D8hccccFnkEaCAkvNAL6N97AT5o
 O1K6k9hvx6Q/9ihK92kPQ8clHzIHOmQ07bef8grMqAcOUfzROjQbbau8jOqzhAFyfOc1
 B+MEqiTgzlOjK3VuRJzUAN+yiVKievTf1Ul8iqSMEmEiOxuNVSK+c/rPY9pDxIbx9l8G
 Pl5KKaav50ed/gRslk0uGPTZYO/mqFsyPsOINV9qyoCpACiF5NQtV9uk6hvtQRfI3zAU
 tMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909890; x=1778514690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i0UGA6W7acHfQzFgg07ojZd+ADYp8WlSjAFL26/Ip64=;
 b=Bv0V/5s7Zg43Pg0/iXi0J+qsvcpdPOzpHUaJWe8YgUgarYWztC+OGvIttSWG+ubmiH
 wPundfTJvinW+/rC8F0ZcfPTYUHP7xuOwNU5D+muV2R+9ocOG/RYNbChDTD/yTrt+Ea4
 hJBAdHTXHz4E8rxKUFc1T90R7eXhHKh91NO+7jyKPRJDmWPzFgv69ynIbwsC+8owrZUy
 FKVbRkkmIvgRKVWEMGoMsIhDmOANnJenbKaHYd4QAGqlvjmQ5Tv3pz2/ohKbcfnyOx/z
 Byxe3GM2ubq4OTDz6AiSFvZ925kPqav2IvC156RnjlDQ20kd7bCu0Pj3rmzIJ+/147rU
 F2uQ==
X-Gm-Message-State: AOJu0YyK9HlwSIHevygNJ/gcvkS4rcsuuf5kSJt0gwNa+73S1wrVFDum
 hu15eMIEdAw53Uy2EU2JC9hBhB1OHnAAySDoKlojh3I5VLJf3MgrKXuvILa8tjiA
X-Gm-Gg: AeBDietq+uhTuXnIRS5Bf3KH3KDF9SjT4ISfIu96ggUvJNqaCNpJrrl5b3pHiRYlZ5M
 wq22oLMWn2RKZzQJEm6UV4LYabrlqhE87Bg4XuLy8rqojhI3Ya84r4AyJMsiXxes8h2ovhPMoNd
 roQ5WGwxBrCj3aaUeOKuwR4HSUJMl8IHGoiBV5dKwC8UO3Tqyexq7xwPXFt4+s5Fa/9sop1PWv0
 6u8crPh2vNHL3DvxDiqJ2Ca4yfOMeSecFa+q8FgRa7j8kwPd6N9Q6WrSujZXQ1A7B3yHN3gacs2
 CFhrK4+2Q7QMeAniYXhF3kQRgL1PPFmhkkF7IrEPQrOmsGpn3OjRAJU7ZBZa2NfbEoUeP1i0txE
 htd3i/PvfXikev7JG6d3u0BpRmfguwrwujsSkqL4PAa3dnF2kfQ+5jKJZjj9YvhEVUlhvmVExB+
 lyrG/bCaV2WE9vgQgC/fv7reIA3bStvVLhppcCet5amkeRdgr4i/Q=
X-Received: by 2002:a05:622a:30a:b0:50e:5c31:5d56 with SMTP id
 d75a77b69052e-5104bde5513mr149947601cf.6.1777909890237; 
 Mon, 04 May 2026 08:51:30 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:29 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:47 -0400
Subject: [PATCH v5 14/15] tests/tcg: add test for MTE FAR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-14-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=2355;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=t9UKuOxOMkff21yBSwiqqFvgFWXDPNIeJTAexYT0IVc=;
 b=VvH0Dw+EA0dM1al44fe87BzYHM1c7TEalnO+8csbUNT90B88V4p/ES2x2ERnZPMq6TF4JfASw
 4U72rhH18ycB7pUM2h8Mv4ya+L96lnMn5ruW5B0W37hmyCyGx2Ir9Zm
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


