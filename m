Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF4F55107
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyxi9-00087p-S0; Sat, 07 Mar 2026 14:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxi8-00087Z-JI
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:16 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxi7-0008VW-23
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:53:16 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A71F43515;
 Sat,  7 Mar 2026 19:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66CEC19422;
 Sat,  7 Mar 2026 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772913194;
 bh=x2p9sfsUBTUAYtkqoTf6MRparRAy9QhO3P2K4BkAkCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T12hHsbfvCwnQbixu8gSulfU/29Ws6hUs/w6m7zhX+971RrvIUefIhJagc2C8qTjU
 x73gf/1NslIzl5TABZBDsdqvLjsUp9yksXCQWx3L8zpw5O5Do88sqpYqMZWpS/fomP
 2GbASiBJHrEvksq9mIuF+qFbGWzTBB7ulCjIAPN9Z7m3FeHi56d+crxQUCwNAr3TW9
 cCaQTwxVdL1TRyD8cnHaFUAIzTo2bcZm3CO/8dae+NhKoKasftX1pQ96dHPK/pnQEU
 gNUlypJ9FGzz68ttEZMT+U1mPeZJYxGn7uAClo298zbulLNGCf6o0RjO4uNu869PZ7
 jir8gw9+LNlFw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 10/12] tests/tcg/multiarch/test-mmap: Print more details
Date: Sat,  7 Mar 2026 20:52:41 +0100
Message-ID: <20260307195243.8813-11-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307195243.8813-1-deller@kernel.org>
References: <20260307195243.8813-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bingwu Zhang <xtex@astrafall.org>

Useful for debugging

Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 tests/tcg/multiarch/test-mmap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index e297f4b1e9..88f7a04101 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -442,19 +442,19 @@ void check_invalid_mmaps(void)
 
     /* Attempt to map a zero length page.  */
     addr = mmap(NULL, 0, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
+    fprintf(stdout, "%s addr=%p errno=%d\n", __func__, (void *)addr, errno);
     fail_unless(addr == MAP_FAILED);
     fail_unless(errno == EINVAL);
 
     /* Attempt to map a over length page.  */
     addr = mmap(NULL, -4, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
+    fprintf(stdout, "%s addr=%p errno=%d\n", __func__, (void *)addr, errno);
     fail_unless(addr == MAP_FAILED);
     fail_unless(errno == ENOMEM);
 
     /* Attempt to remap a region which exceeds the bounds of memory. */
     addr = mremap((void *)((uintptr_t)pagesize * 10), SIZE_MAX & ~(size_t)pagemask, pagesize, 0);
-    fprintf(stdout, "%s mremap addr=%p", __func__, (void *)addr);
+    fprintf(stdout, "%s mremap addr=%p errno=%d\n", __func__, (void *)addr, errno);
     fail_unless(addr == MAP_FAILED);
     fail_unless(errno == EFAULT);
 
@@ -465,8 +465,11 @@ void check_shrink_mmaps(void)
 {
     unsigned char *a, *b, *c;
     a = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    fprintf(stdout, "%s addr=%p errno=%d\n", __func__, (void *)a, errno);
     b = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    fprintf(stdout, "%s addr=%p errno=%d\n", __func__, (void *)b, errno);
     c = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    fprintf(stdout, "%s addr=%p errno=%d\n", __func__, (void *)c, errno);
 
     fail_unless(a != MAP_FAILED);
     fail_unless(b != MAP_FAILED);
@@ -479,6 +482,7 @@ void check_shrink_mmaps(void)
 
     /* Shrink the middle mapping in-place; the others should be unaffected */
     b = mremap(b, pagesize * 2, pagesize, 0);
+    fprintf(stdout, "%s mremap addr=%p errno=%d\n", __func__, (void *)b, errno);
     fail_unless(b != MAP_FAILED);
 
     /* Ensure we can still access all valid mappings */
@@ -489,6 +493,8 @@ void check_shrink_mmaps(void)
     munmap(a, 2 * pagesize);
     munmap(b, pagesize);
     munmap(c, 2 * pagesize);
+
+    fprintf(stdout, " passed\n");
 }
 
 int main(int argc, char **argv)
-- 
2.53.0


