Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9F0CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 05:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEKCG-0004la-EY; Wed, 07 Oct 2026 01:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1xEFmY-0005jy-6G
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:45:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1xEFmB-0006SQ-Ty
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:45:04 -0400
Received: from localhost.localdomain (2.general.hector.uk.vpn [10.172.192.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7DF4A3FF14; 
 Tue,  6 Oct 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791328821;
 bh=1uhJdjSFcgA4dxKrKuLimx+yNQRi07FdBKHXW04K4NI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fg4JkFgExp3bpR/TZIaKAwBeRcDiIqORKMEXnD8UB6JfPmPt0IdopSRLbYIoum+sp
 D+iU8URcPtjMjZ32oOPHhSs2L8jL+dqYMlUQOnlNhnTn2OdO/Y8yLyibX80qOUqLq6
 KD7qqvQnAD/iCG6r30flAuI+nf5GLUtv1ZE3o+8mk5A27tERCzD6r7/l08zkIQ7JMr
 GRQPB7hL4wZHeXLtuHXoFSLiFMFqprVsYhs9b4DK3zLf+aFoAM0ca8hP5Yv8bW701u
 HK22i4h0T4im9s9Cfi67MmhruwjTR5i9zfVyxL3LNs92ZBocWUrmn7UuGAdMsjI3JD
 B2HP77hvDZ6zzK1ekbYP9Jowie/o6xxCsFectyDk2pu25k5YO0xStmPzhX6uPIdcNW
 LRFyZPiK7e4xLQAo94RCC2ZYlXx+uYml+6HbT41pd20lszpnS/V2Sj9Mn0T2aS8OOT
 fu5rqeASwqu2Dyjup+tHkJJs4WyKrDrkrPAC+6vpCZwWJlQhHJetZqxG/NmkCbKHBl
 yox+2O9GvC49QrHgy5gDolheJ9TOgmp79b3x8/JiL43Upbfs66Xy57DF1bCGRIM91/
 Fy8xV0aMLlRpYhfhSLG/cJvaMRfYgUKR4RhmzeDGqn6Ofmm3XEni1hNIfTNXqygTDr
 NWoA8lCyg7Oit7MkaC0T9oCk=
From: Hector Cao <hector.cao@canonical.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PATCH] util/coroutine: trim sysctl's max_map_count newline before
 parsing
Date: Wed,  7 Oct 2026 01:20:18 +0200
Message-ID: <20261006232018.211749-1-hector.cao@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.121;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-canonical-1.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Strip trailing whitespace from max_map_count before passing it to
qemu_strtoi(), allowing the strict full-string parse to succeed.
Otherwise, qemu_strtoi() fails to parse the string and returns -22,
making the global cache pool cap size set to UINT_MAX.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
---
 util/qemu-coroutine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585a..5af61995437 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -374,8 +374,12 @@ static unsigned int get_global_pool_hard_max_size(void)
      * VMAs.
      */
     if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL) &&
-        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+                            NULL)) {
+        /* contents has trailing newline, remove it before conversion */
+        g_strchomp(contents);
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
+            return UINT_MAX;
+        }
         /*
          * This is an upper bound that avoids exceeding max_map_count. Leave a
          * fixed amount for non-coroutine users like library dependencies,
-- 
2.43.0


