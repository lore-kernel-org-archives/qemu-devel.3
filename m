Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83B8C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksB-0006Vw-Bz; Sun, 27 Sep 2026 05:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqK-0001Ub-DG; Sun, 27 Sep 2026 05:06:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAkqI-0008AX-A9; Sun, 27 Sep 2026 05:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790499961; bh=7BhEayz5r078dP7gCjHeryKaCB8U5aJ6d6jOXU5aBCo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rOtatGFNIQFYUVPppePbZ146tdsPt2o7nu2nH/+3Tqaf+K7gCdy0FHaXCSLHFgAcn
 hGu+u7anMB4DIoXIb5UsryCaNc3aCsOry0Ffe7+3FIJiogzoQipqb0Ve4/hPG3fdK3
 0hUAj4K1MXf6wJzeocIWftWZEuu+ghhuR1ESQXsI7rGEymJVi15PfcUSseAI3KjX1I
 exdlWNjXv1w0H6zcFiegza4Db6ek4bFXfgESjezzXB1XgWByNVSywz9trsHASGmOUu
 0yr0QvvAImaa8ivKWmApz60ywgg2qizkzDqbojFzawJX/mN1O5m/TR/lPEREHpP/Ho
 w1foC7zv5fAig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 03B4B1D8B19;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 00B2F4320D2;
 Sun, 27 Sep 2026 12:06:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CAE505E663; Sun, 27 Sep 2026 12:06:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 v2 72/86] tests/tcg/s390x: Add regression test for
 #4449
Date: Sun, 27 Sep 2026 12:05:19 +0300
Message-ID: <20260927090540.102811-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260927120511@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit c66fe5b04d643d013e97cbbede5b736b56a667d4)
(Mjt: adjust across make=>meson conversion in tcg tests)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 97c0f021902..118eaf7896a 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -51,6 +51,7 @@ TESTS+=ts
 TESTS+=ex-smc
 TESTS+=divide-to-integer
 TESTS+=stckf
+TESTS+=issue4449
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/issue4449.c b/tests/tcg/s390x/issue4449.c
new file mode 100644
index 00000000000..0c9c80e8cac
--- /dev/null
+++ b/tests/tcg/s390x/issue4449.c
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+
+#define CASE(name, old, cst, sh)                                        \
+    static void __attribute__((noinline)) case_##name(void) {           \
+        unsigned long t1, got;                                          \
+        __asm__("lhi  %0," #cst "\n\t"   /* low 32 known, high not */   \
+                "lghi %1," #old "\n\t"   /* whole register constant */  \
+                "sllk %1,%0," #sh "\n\t" /* 32-bit write = deposit */   \
+                "brc 15,1f\n\t"          /* ends the translation block */ \
+                "nop\n"                                                 \
+                "1:"                                                    \
+                : "=r"(t1), "=r"(got) : : );                            \
+        unsigned long want = (unsigned)(cst) << (sh);                   \
+        assert(got == want);                                            \
+    }
+
+CASE(a, 256, 128, 1);
+CASE(b, 128, 128, 0);
+CASE(c, 512, 128, 2);
+CASE(d,   2,   1, 1);
+
+int main()
+{
+    case_a();
+    case_b();
+    case_c();
+    case_d();
+    return 0;
+}
-- 
2.47.3


