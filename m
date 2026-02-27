Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEED4FEFB70
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 17:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw1Sy-0004OA-8K; Fri, 27 Feb 2026 12:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw10L-0004DO-Ra
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:53 -0500
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw10K-0004QY-54
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:53 -0500
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id 60F061C00C2;
 Fri, 27 Feb 2026 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1772210870; bh=AROLPBhDF9Lks1DiDysG1fQ9oylykaxFVPNbxDr0Q9c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aW1arCjC4EYkkwlXDfRK5PxyNgYUFc60Y+lgHVuS7QgKUXMUsz7xlzGZwjAImNqbm
 AsEDnm/c2ivSqcPMiemQC89jNJzLZU4dDsDxoeKKpk1vUSNA6xTMExh461epltnGvA
 0kauIuBWiZN4cwlNB19H1okt01ZZdGd6Ems8KqtjSiB5adL3KTpiu9Ce2GVT2lse/I
 yM09oC+qndRqmic2vVr8TKxMZY9QB7whauuUeqQm0ScoJAo6XMK78jvphKg0c+NFpb
 JQV53d49Iabk4uaDaUZGNCQ+tBJ16yL+iyjG133g0qSj/3Tb/eeU+ty0VIOcIoSm7P
 hG9p0hsRfgXBjYg/voYLLLkYwoI5hD3hyOaSNc8p8DaD+fgv81FGF1fmAoYfj5n8O6
 jUUMKXLbV7xBYRfpvdGv7iyFUg3qIted5cYXatdWdjklUA/du3n2XoxDOzj/tIm6oI
 W2ODtDUD35fmKWbmG2gumxaN7uOy+9GR9Ui+aOH8+sfMrWfujzpBYPM+pV1wTAqBVa
 bxPmVopfiFzvNNfWcGoY8bahyOXGme305jOTxp6V/yCzy+A0V+F8cy3knWuCuFAMlu
 pEoKx+GYIL3Nd7ZlzxwtBwSIGtZwqwsanQCSj2Y6mOLWATi6iRpi36rF5rrHPCJwEp
 w+Z1l2xrDTZDSjWxO6VI43lQ=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id y4UHZOTxtZ0X; Fri, 27 Feb 2026 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [142.248.151.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Fri, 27 Feb 2026 16:47:43 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
Date: Sat, 28 Feb 2026 00:46:32 +0800
Subject: [PATCH 3/4] tests/tcg/multiarch/test-mmap: Print more details
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-abyss-mmap-relocation-v1-3-c8ec0476894b@astrafall.org>
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
In-Reply-To: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Bingwu Zhang <xtex@astrafall.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2765; i=xtex@astrafall.org;
 h=from:subject:message-id; bh=VBZ7OSO8iNQWFEeFysNod/fZxXwETdJ5gYcACxtEZfo=;
 b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDJkLT01VmHJNSSXGh4Hp5MuJ4tHLWLdMOrFcS/CHZdDk1
 hthycu2dExkYRDjYrAUU2QpMmzwZtVJ5xddVi4LM4eVCWSItEgDAwMDAwsDX25iXqmRjpGeqbah
 nqGhjpGOEQMXpwBMdTkLw19ZTn6H0w+9P9ifu9rEyiZ7bnv9TosfNz4n79thEa/DECLGyPDcTD/
 mbcrrprkzVMwXpL4zq78RvqpIWOzmqwyLd1tiXPgA
X-Developer-Key: i=xtex@astrafall.org; a=openpgp;
 fpr=7231804B052C670F15A6771DB918086ED8045B91
Received-SPF: pass client-ip=157.180.15.194; envelope-from=xtex@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Feb 2026 12:17:25 -0500
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
---
 tests/tcg/multiarch/test-mmap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index e297f4b1e932..88f7a04101a3 100644
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
2.52.0


