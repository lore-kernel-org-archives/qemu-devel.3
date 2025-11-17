Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E330CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 01:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKoF2-0002tx-HB; Sun, 16 Nov 2025 20:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEd-0002XA-Em
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:52 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEZ-0005y3-JO
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:49 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4ed66b5abf7so54100561cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 17:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763343646; x=1763948446; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1QKoUu8BlGHfDs3PD9C4DZ89TPN3YY4wK9WcP+sPaow=;
 b=W4ZJFSzYsaPbSoU5hTRNy5ddYlu8kswUP/xItK6hSsrLwO8fBaoDX4qDzB9jCVxvHq
 VCBmaKsz9zAwpyQynPfqzNgj2+q3PTRRcDrfrSO2HR5KWFj2DLQ72YNnvpxzBzU4p0cn
 mzW/eJzaKhH3x7wGAZBChyi+067QuT3/Hp2aVwj+e942Snx7wblictHJ4dAYKdNYgWCB
 jQIgD6dwHsCmO7uVXU+7El7YHvgw5frpIoMtKAV5ieRg2eoUCYIB77VWxJ9OtlNlVKxH
 8uRe7e1Srdw+E2rOrgF9da2xFJGySeM05DLxMfYiYkNjtadW2EzV/jwNsO0Ky/5VLq1K
 jw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763343646; x=1763948446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1QKoUu8BlGHfDs3PD9C4DZ89TPN3YY4wK9WcP+sPaow=;
 b=ggVYJ7KTXBs4szJcJdCgSplTMCubOj7YgxU9b/I64Ho4P42l9NJDzBe2k6Uv17xije
 rqiNVn/3mrz7+eD2eTB27VqXo/RrJVpkuRCpZ9S3N6bL+vgPk8sssK7bwDKe4RyWVWfp
 G1DDXXLBmw77bjYBWGc7/kC66Pg11ekqIoHDhhYw5pkAEQzfNlenTQXuwn9HkxigdGKi
 7t7GGjObpgv9yE0zud8NqsGI8hE+dS2b6QtgJQQE5cZy3R03/n6jWqo6pSN70sI4DmYE
 MaeviumzNCTGYVrwAoJN22anM8pu4iKGIiAqPPzAX0T9mHFrvz2VFizbwZnQIQQYpz6x
 P9Ng==
X-Gm-Message-State: AOJu0YwR9oaDYAZ+w+9QFMxU7OGgqJNWIAqhjTFN1W1CaOBfDhs5LDuJ
 2n5WkD/9JQIRWqqJWztcVila3jNjSjziuYz0XqUfL8W2t3lbp2onkoLk
X-Gm-Gg: ASbGncuP1eJKfawUbyyjMfECEU1M5uM2KQAcIIhouyxaoHsOHWbaVH4ZBuWNz4QEEPN
 40QOcechB3oW+HOjfPMM1/0qweO6DOqmNO+Rx+A7EpBsnTukY4d5deH2ltoAGXV/AGLoWvMAXCo
 vqqwDdIJtZ7E38hlt32mPpZrMX3ulYOKwLYb3BNHnXIde/9od7Nnk9c128vbbOmegfJp2/zeuS4
 JQks017+guhBlgMGEpt++uKC4rxCyY6+H8BVjNOjIX3+X15zBb3KBhQ1cEUKx5xhO90Bar0vP07
 FRo0CLOD4mf1va+G5f8popFwhwdU/GGqQxMVOoVL0zYXKOfVe/kgkfX+/SQM7vh3uLI4V7vrh9V
 M/PCMFoW64QMLj90shFEwB0Mq+ahNqumb1bphC843F7q5ta7CxZ1qY8drsQxZzuoAVBntOwVVKn
 oXsFzH9ZR9f7mL4cAYSFw=
X-Google-Smtp-Source: AGHT+IGtk+ku1IIDb8bDLAxmXk0SUFnCFIxPd4sHk3RUX/w6oKGfuNkxUuOrXA3tIMQibzAHkiA0NA==
X-Received: by 2002:a05:622a:1492:b0:4ed:b185:f49d with SMTP id
 d75a77b69052e-4edf206c97dmr140382211cf.1.1763343646529; 
 Sun, 16 Nov 2025 17:40:46 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm18246551cf.30.2025.11.16.17.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 17:40:45 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Sun, 16 Nov 2025 20:40:22 -0500
Subject: [PATCH RFC v2 05/10] tests/tcg: added test for MTE write-only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-feat-mte4-v2-5-9a7122b7fa76@gmail.com>
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
In-Reply-To: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763343639; l=2569;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=+MW5eKyHmFp9lQRa143T4qRhRjYlTU7oYxdQCpWyD18=;
 b=uq6fD+kwIaV7oIcJ/6+wobrRZ3ZDAit3vkKR+4CyEE3dVUnUzdHKyJYPOiWb6+WGm3DJU9Iu1
 suPPYK3TXXGD/pP2BKcd38STp/lE7osYumWOG3yElWxFbokONjUy6/1
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x832.google.com
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

This test cannot be run in user-mode because the control bit that
enables this feature is only writable at EL1.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-10.c        | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

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
index 0000000000..0fa3f97e1d
--- /dev/null
+++ b/tests/tcg/aarch64/mte-10.c
@@ -0,0 +1,55 @@
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
+    /*
+     * NOTE FOR REVIEWERS: to run this test locally, I modified
+     * enable_mte to also activate write-only tag checking by writing
+     * to ID_AA64PFR2_EL1. I am not sure how to modify the test so that
+     * it works without that modification. Input appreciated.
+     */
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
+    /* now we write to badly checked p2, should fault. */
+    *p2 = 0;
+
+    abort();
+}

-- 
2.51.2


