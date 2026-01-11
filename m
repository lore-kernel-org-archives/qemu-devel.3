Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA53CD2502E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf3Sa-0005Qu-DM; Sun, 11 Jan 2026 16:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SZ-0005Pk-56
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:55 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vf3SX-0003tf-Ex
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 16:58:54 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso38405115ad.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 13:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768168732; x=1768773532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbrAaN7JsAz6eZwl17xTGDw3px0xTVunNGwx3Itrcys=;
 b=Qh5rVa75kLsAcio5TFG6EuBC2pGuNbUeG6h4yG58EJ4HgpG10LAWCHDZ3SgjV6B63O
 kkGolOg+kT3f02gmSmfAT4AzSsOsRqbOdRWsi6xvAKfZb7u6xIwIAO7GLFEbcZFvrQYd
 gNK1Fm+CykKQggGVjkrfJ3Nv/pKqmgcKVYp4rvk1IUmo5lGgCJSaKfIU3aBO7qKqSNcK
 9m0fV/e6kGLTjTImA3aF1dtXQztiFCm44tC9JgEpVtwNV+ojSwxmA3lzw4BfwMYnVmZi
 1x2cvVUylSTvCml9srS338aG8TQXX+Nxsh7zcpc2a8ODfow5lq9dpb2pq60HwwANN/1y
 SDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768168732; x=1768773532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NbrAaN7JsAz6eZwl17xTGDw3px0xTVunNGwx3Itrcys=;
 b=N+AKydqG/VgAoJYwJwLnIwNWFeoJ8kU6nEl31Yh1gaWz/Pb+QzKsyB7nPbYVlR4HZv
 Q9DpBbEIO65hXdfTJpqV2RufQdhyjEIUIy4H5ivDpf0/iu+bsdcoXtWT+8OIzUgWyMf7
 Ogy+pbbqpLy0dghVRZp3lhZ/75OsSrJyuwUFRRgLLDf0fDJ+2q4GjD6OSK/3cBqfkpHw
 SAaEmx1pHBUI4wjkC8VgA/kf07s0qG/9zM9QjfQLM2haAw5DAJv+wn9ql3Wa3vej03Er
 pnn9JsOnvFutGSKDusND8qGXAfGQu4q1FPmy7fb9vXsmRmbCtJFiOFdJIxKiPHtwDvig
 gntw==
X-Gm-Message-State: AOJu0YxxQKDaLcOH4RJvAdxUODn2pYdpeyDMm62/bbyY79yaIR8+EGSm
 PtIiqMm77ygQy9h77bIyYSSVsX/LbGWz4ZLaORQrocd31s5J6VCSu2MDZNdisA9xfsv3Nyb/8NL
 1IeQgx5A=
X-Gm-Gg: AY/fxX5GLfz4LkVKqNdxwHHYpv0nbWSXK4YuQyIQ7fi/PQ9Z0wxoka8OUw/SWIG8Qwe
 xv7Yf0dZMeiqXTHt6NYBhjX8/VCENj1p6tmskZdf4U2s60tckS/m7vt1xrHMBuncJu0zrXHXiDH
 pjdyWRkq9Vou5IU6sSaJAYx0H2iD0T/vIt/IiUrAL/DO175crSqXx5XNEa4Cymb2vJztvMYFnyO
 NUg1plqxPS1a9QeReEg31qRrpAh4r3tMrVk1BlnAzhnmCXFMOvQZU/9tNf1AaI2oJU7JSYk15tV
 qIE1BMm7fqe11n0NtKGCBdUuFTjSf8uFgN0ZrTsilppM4RqUi7uwnFS2+yEGC9m9Afi9L5nXx3j
 ZGBp8TwGwlC31408mZheDjOMbGvW9fjeMkI0xTqGlzvYWe01qdxHh/jTAKT6mGQSnQLDtJJ3dCs
 EC+JLXAbaVZjdME4Q=
X-Google-Smtp-Source: AGHT+IGllwwYTpnXu5ywVxVF16g48vFl5wgBXng81h81rY2T94jKtuu6wfABH7ci0/5jUVIvj/dPmw==
X-Received: by 2002:a17:903:1252:b0:2a0:fb1c:143d with SMTP id
 d9443c01a7336-2a3ee40ec42mr145897305ad.1.1768168731996; 
 Sun, 11 Jan 2026 13:58:51 -0800 (PST)
Received: from stoup.. ([202.86.209.61]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a31dsm155272365ad.9.2026.01.11.13.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 13:58:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PULL 10/13] tests: add tcg coverage for fixed mremap bugs
Date: Mon, 12 Jan 2026 08:58:15 +1100
Message-ID: <20260111215819.569209-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111215819.569209-1-richard.henderson@linaro.org>
References: <20260111215819.569209-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Matthew Lugg <mlugg@mlugg.co.uk>

These tests cover the first two fixes in this patch series. The final
patch is not covered because the bug it fixes is not easily observable
by the guest.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-5-mlugg@mlugg.co.uk>
---
 tests/tcg/multiarch/test-mmap.c | 42 +++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 96257f8ebe..e297f4b1e9 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -22,6 +22,7 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -41,7 +42,7 @@ do                                                             \
   }                                                            \
 } while (0)
 
-unsigned char *dummybuf;
+unsigned char *dummybuf; /* length is 2*pagesize */
 static unsigned int pagesize;
 static unsigned int pagemask;
 int test_fd;
@@ -451,9 +452,45 @@ void check_invalid_mmaps(void)
     fail_unless(addr == MAP_FAILED);
     fail_unless(errno == ENOMEM);
 
+    /* Attempt to remap a region which exceeds the bounds of memory. */
+    addr = mremap((void *)((uintptr_t)pagesize * 10), SIZE_MAX & ~(size_t)pagemask, pagesize, 0);
+    fprintf(stdout, "%s mremap addr=%p", __func__, (void *)addr);
+    fail_unless(addr == MAP_FAILED);
+    fail_unless(errno == EFAULT);
+
     fprintf(stdout, " passed\n");
 }
 
+void check_shrink_mmaps(void)
+{
+    unsigned char *a, *b, *c;
+    a = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    b = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    c = mmap(NULL, pagesize * 2, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+    fail_unless(a != MAP_FAILED);
+    fail_unless(b != MAP_FAILED);
+    fail_unless(c != MAP_FAILED);
+
+    /* Ensure we can read the full mappings */
+    memcpy(dummybuf, a, 2 * pagesize);
+    memcpy(dummybuf, b, 2 * pagesize);
+    memcpy(dummybuf, c, 2 * pagesize);
+
+    /* Shrink the middle mapping in-place; the others should be unaffected */
+    b = mremap(b, pagesize * 2, pagesize, 0);
+    fail_unless(b != MAP_FAILED);
+
+    /* Ensure we can still access all valid mappings */
+    memcpy(dummybuf, a, 2 * pagesize);
+    memcpy(dummybuf, b, pagesize);
+    memcpy(dummybuf, c, 2 * pagesize);
+
+    munmap(a, 2 * pagesize);
+    munmap(b, pagesize);
+    munmap(c, 2 * pagesize);
+}
+
 int main(int argc, char **argv)
 {
 	char tempname[] = "/tmp/.cmmapXXXXXX";
@@ -468,7 +505,7 @@ int main(int argc, char **argv)
 
 	/* Assume pagesize is a power of two.  */
 	pagemask = pagesize - 1;
-	dummybuf = malloc (pagesize);
+	dummybuf = malloc (pagesize * 2);
 	printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
 
 	test_fd = mkstemp(tempname);
@@ -496,6 +533,7 @@ int main(int argc, char **argv)
 	check_file_fixed_eof_mmaps();
 	check_file_unfixed_eof_mmaps();
 	check_invalid_mmaps();
+    check_shrink_mmaps();
 
 	/* Fails at the moment.  */
 	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
-- 
2.43.0


