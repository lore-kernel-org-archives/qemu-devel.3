Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B9DC5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxVe-0003FU-1C; Mon, 17 Aug 2026 09:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVS-000375-7n; Mon, 17 Aug 2026 09:36:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVQ-0007K7-MR; Mon, 17 Aug 2026 09:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=mOtCXnAeH1Fll/qjHPYWZ7OaP8aGrGDfZUMNX7SqHfw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nx7zgzFajlEDa2t831D01/2bX9DwOQurFMR05Vuog0WNXHtSlrrrPwYyzGZ+M5it9
 l1D6eCjsIzQ2SDopsAOWf4Iy+4CJt+CJkuYraEGTOEEGblKDazvk7BbF+WNwyt9dht
 x6XFZipJHjCelnGDyDEbJrPJKB45sOVHmMwpd+yw5p6TC0uk9Jd81JAUudS2jnTIBq
 OFeB4E5rxNqSPDCsN07YdV2AFYHBJOcKMKEPjHvb1D2JfNE/LOR4/kClT/PNiWXYXc
 Txlqnwe3q41LToqPE9PFdzd3VHE9fuuLRbJyqvuvZs6LN+1dxekY1CneQtgrQqESVN
 qHnC+jGyAbdkg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C7521CBCBC;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 574CC40D419;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9B11530F82; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 109/135] tests/tcg/s390x: Test DR overflow
 (INT64_MIN / -1)
Date: Mon, 17 Aug 2026 16:34:19 +0300
Message-ID: <20260817133451.2384630-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Check that DR with a non-representable quotient raises SIGFPE rather than
crashing the emulator.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260714190351.337923-3-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit aa5d03bc93514ceed8d94f38dbdf951f6cb19d23)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/div.c b/tests/tcg/s390x/div.c
index 6ad9900e082..124c9ecc339 100644
--- a/tests/tcg/s390x/div.c
+++ b/tests/tcg/s390x/div.c
@@ -1,6 +1,15 @@
 #include <assert.h>
+#include <signal.h>
 #include <stdint.h>
 
+/* Set asynchronously by the signal handler. */
+static volatile int signum;
+
+static void signal_handler(int n)
+{
+    signum = n;
+}
+
 static void test_dr(void)
 {
     register int32_t r0 asm("r0") = -1;
@@ -65,11 +74,39 @@ static void test_dlgr(void)
     assert(r == 1);
 }
 
+/*
+ * The most negative dividend divided by -1 yields a quotient that does not
+ * fit into 32 bits, so DR must raise a fixed-point-divide exception.
+ */
+static void test_dr_overflow(void)
+{
+    struct sigaction act = { .sa_handler = signal_handler };
+    register int32_t r0 asm("r0");
+    register int32_t r1 asm("r1");
+    int32_t b = -1;
+    int err;
+
+    err = sigaction(SIGFPE, &act, NULL);
+    assert(err == 0);
+    signum = -1;
+
+    r0 = 0x80000000;
+    r1 = 0;
+    asm volatile("dr %[r0],%[b]"
+                 : [r0] "+r" (r0), [r1] "+r" (r1)
+                 : [b] "r" (b)
+                 : "cc");
+    assert(signum == SIGFPE);
+
+    signal(SIGFPE, SIG_DFL);
+}
+
 int main(void)
 {
     test_dr();
     test_dlr();
     test_dsgr();
     test_dlgr();
+    test_dr_overflow();
     return 0;
 }
-- 
2.47.3


