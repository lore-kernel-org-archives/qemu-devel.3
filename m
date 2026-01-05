Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC02DC79FB7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp8d-00021Y-GG; Mon, 05 Jan 2026 13:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7T-00017P-Ol
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:57 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00037b-Eh
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:54 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-88a35a00506so1803356d6.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636943; x=1768241743; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lBg62OAX3E08F+RaLpGGmFy6a2bx4DIQS0r0gGCTy2k=;
 b=Oaxtex+uZmeiOPRD4ckzCxLMZ8DZpRF/3Ar8Lt6G2bYRxOFJtnuf03XI135oJdQRCh
 kxSG6qQ9wBaRH6gOincCdlAoehtGOIM+UuFsn+cGvpNL5O1zQBGb991g7HHAWOJFcjai
 7pmq1jM9fCO4XfnxJawEMTUw9zP+HkOksjZBKzQFggheePLjVrkMzC2gDtDwl0Q++Zpn
 lZS2GOFpQFcN8ZwVm+ar7ghQKxLsHQ0u0X1aGNL+IAaD+OqryHFI23T4x6jhCJo+HO7r
 Lwz9+9oz1IrXbpGtJKPW89szX4Ponvwj2rjMLMfURlzoPhbyWILIO8+vOQBI4Q0Kj70J
 2z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636943; x=1768241743;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lBg62OAX3E08F+RaLpGGmFy6a2bx4DIQS0r0gGCTy2k=;
 b=gRmA36N2E7pB1MTUz1m7K0FotuhYXScjKWPFvFzfJUv+SWZUng7+1yfumYXrtkI9ay
 91nP7UMlNaCsDEHZJRtNqiJsUQd73LC06I7DCGP6Iv8stNbRggIYCk6rOQGh8Ha2h5m4
 yxO25aDKabScckpuLEJxZdgZjm3Dc8ashgthUoguT84oF9lqXvyseZRiXrO3/Nl8Olcq
 SEKwGmKFt/O2Uo4ema6eZFseyuRaSeagr5FqWAV9qtVz9JYX/SaUaz9nVIC9jX2SQw5G
 bOk6uj0p5UPjCF6Fbj/kk0QIA1sjpHe3txHMWwzVUW+rMPAeyPMZ30w+EoCePJdfKJz7
 AKyw==
X-Gm-Message-State: AOJu0YwulcIz6hylTCGM0J1jLdbqhBJO7WzYqP01jwnBIh60i16vh+7f
 NsEiwoaH+5KYpuAgbayOcmuKlkPydG/Uy/AiPLZBlEX7Wvui9g7iPpip
X-Gm-Gg: AY/fxX5pqCNR/vKbaozm8qrL9av68qBg0r17bQoiOBoNDNgkIza+4vKPnh0BMt3qSGk
 SOHhbk4ofp1y4E56lpWBJpFkUngk8kDcyK1TX1tdJjGlonkPuW/7gYKVAAqlPVhmdXFYxHEN6nn
 p5aRvgsiaLSuGYcy5WvKEUtjcXTWXEzmcpv/sauNCivBaRcJrrW0PoR/XvpDWEnDlZafVRCZabk
 VLG7Eu4WMHwGNIolF7ThBhIn6spQobckmS6hsJjJG99OXnRip8sMqHkve7KOijy95QGtJN3WyhX
 DPFXVuAuM7OYnRg/qSL4qvpEKupDRrK8UEjFQBxIRaRsFVG8Z7Oyrf+suZMOZ2kTaUzzZ93edZa
 +iEV/YMjtDtxiHR7hu0NE2F8UByGi/RoUGPh+gkqhPWqoazoRZEkBX1u1oKrcyuJ3akFnPx4PV3
 9TyJ4rh6n4qVUsqInzbrOy3LPWFaN7MHE1++E=
X-Google-Smtp-Source: AGHT+IFSWUmtIxKZzzNjbqPG+nDQzGZsxjqb2s6uprhNZrL37pnDxgqdxVvNUQ6d9D755CvXg4LbZw==
X-Received: by 2002:a05:6214:212f:b0:888:4930:82ab with SMTP id
 6a1803df08f44-89075ef0f8amr6808826d6.71.1767636942550; 
 Mon, 05 Jan 2026 10:15:42 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:42 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:15:01 -0700
Subject: [PATCH RFC v3 12/12] tests/tcg: add test for MTE_STORE_ONLY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-12-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=3012;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=oP1ODAPtwy+eL+2EWDk5uY7d+uGhjgcod/Aq0fXi/cA=;
 b=a8vIto7Ubr6PS+0Ic34wh8gRwf+dBz5gqURjRVqu8iQ/nCVyvGVOlZr4JIzQHgLjLRXKeBOXj
 f2OB2HY3CjUCF0MpP2KiqpOzMyTK1sAG/YvK+2zRWXxguY4WtoPcJdS
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf33.google.com
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

Added a test that checks that MTE checks are not performed on loads when
MTE_STORE_ONLY is enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-10.c        | 49 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/mte.h           | 12 ++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

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
index 0000000000..a6495e4bf4
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
+    enable_mte_store_only(PR_MTE_TCF_SYNC);
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
diff --git a/tests/tcg/aarch64/mte.h b/tests/tcg/aarch64/mte.h
index 17b932f3f1..1d3ebf8696 100644
--- a/tests/tcg/aarch64/mte.h
+++ b/tests/tcg/aarch64/mte.h
@@ -51,6 +51,18 @@ static void enable_mte(int tcf)
     }
 }
 
+static void enable_mte_store_only(int tcf)
+{
+    int r = prctl(PR_SET_TAGGED_ADDR_CTRL,
+                  PR_TAGGED_ADDR_ENABLE | PR_MTE_STORE_ONLY | tcf |
+                  (0xfffe << PR_MTE_TAG_SHIFT),
+                  0, 0, 0);
+    if (r < 0) {
+        perror("PR_SET_TAGGED_ADDR_CTRL");
+        exit(2);
+    }
+}
+
 static void * alloc_mte_mem(size_t size) __attribute__((unused));
 static void * alloc_mte_mem(size_t size)
 {

-- 
2.52.0


