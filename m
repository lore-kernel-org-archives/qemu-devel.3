Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D01D58B23
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 12:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1kum-0002rE-8B; Sun, 15 Mar 2026 08:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raghavendraaadhya@gmail.com>)
 id 1w1kRF-0001lX-Qa
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 08:19:22 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raghavendraaadhya@gmail.com>)
 id 1w1kRB-0006BO-8D
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 08:19:19 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so1467537a12.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773577155; x=1774181955; darn=nongnu.org;
 h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9Vy6jOLBhvYLJujIXKQzGrxbfbf45embMxzkpUumuc=;
 b=Cu1eLfwdJPIqwbZIZvQsRnwEDTnH1rv8+JxFf2HDtO5iwzkYjcwg3sQdHkAMytrcSJ
 Y1fp/rsXIPeLK5P8IS2rmTkd+RCGSLZsZv+MecH7W/2qmX9pQ3yLBOFJG5MAf6GwgQB2
 xWgJ0M+RI4pIqn68l0dAD9SM50uAFKSKmYfqZiQTwfXUTvcP7Okz+Smbv6noihsXLxbI
 kXHsWZkGTkgJ5a+q0g+Vm+kUwC/9CEAaP4bg82gM8kHCtBzFI42OReyFTNNtuuI0qoo8
 sGYK0LEg8jQHr+sBX4zebOgjPuOvUEq/iZq+MFsKKOjCpazcQKgFk/LUtwWpU8jwfTk5
 R9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773577155; x=1774181955;
 h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y9Vy6jOLBhvYLJujIXKQzGrxbfbf45embMxzkpUumuc=;
 b=T8EQ4QVPNWOXa8VUPhW3EFQ3NOGibpPt4YMspta/kGvZsMK/RmdFhrk+JLWehj8ZwO
 nwo7QTEM1TXO5ee6MpsikF0x3eDx+Md1a+8PX9NMw/g8gKY3q76KYqmgP/js5Ufkzy9S
 Sqi9DJnBFpMlLO+tFptD+muQ/c6prAZ38SgQHW0HUJyhEHryjBsonIgOkwy51pQHzFcV
 LVRS5OcSaQF0nHsGiOtQ/FqPdnUaSnEeJcM2UwOxyKIwcYCrBVauPIxE4ytui/e4vVQm
 xP9QRxSoBIWBhLcymjA1PyzQXcaw30J49BoVrNkUk8s7RHjVUlf9KDNVphDO0SG3Rf1l
 tDIg==
X-Gm-Message-State: AOJu0YwA2n8yz1SY7tIHANb6jaLAwZPve/CxUwVqgPFpIxV24pQxI/gC
 8n1RGLRaoo6Cj5GiC8p2SDR7Ls+fcCq9QeV0J2YBzlHVaQHiKcYXWsuz
X-Gm-Gg: ATEYQzzqrfNDuZo1SN5QtQMEA12phUN1Z/H632CZNm40uY+l99w0E63Pk/Rmh00grs8
 lnuGNUxYZsIAR+eKa2M97l50cC2HVT5jLn2AIHPN0O6MnMtEF0muukeNnXSRjuExOpPeVoiT+lD
 dM6GfvdH7EPWaeRjf39g4wWoX3hp6gW+OAYuYijbcaJ/rzhPeSp7+jcDDcwH+UzngEmQpN2uh78
 OULxXQOl491y6bDYNFM0gtYHdEeXB0+d469Wmf6fPYOP+PK+drH+/gL//TnshFUk+mJnV2NdZX/
 YFJNPPLPZEOvmhUDxB0f4NZz4aPGn04ydSqc/sBXrI1eg9WB0IiemuD1o0bBa4yCCDaY2oE+xfb
 fnToo25qMzq5kzTmxgSck6961siNnw0O4xV81BxmwWyLkpGPWf2WiQddBNmxwyxzvXsAtXaJbDD
 rH+DLLsNYAyvG1Qt/BiPr2sLMQ0C4LnYm0RE7AVjZDfbAsBuxtx4HzG6ROpPJOzNnXcJIBj08Pw
 OwnF6IvH56nA9ROvHDgdUoF6w==
X-Received: by 2002:a05:6a21:687:b0:398:aaac:a079 with SMTP id
 adf61e73a8af0-398ecd38582mr8862962637.45.1773577155193; 
 Sun, 15 Mar 2026 05:19:15 -0700 (PDT)
Received: from Obsi.localdomain ([49.43.240.32])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73fc935ad4sm2323870a12.2.2026.03.15.05.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 05:19:14 -0700 (PDT)
Message-ID: <69b6a3c2.630a0220.b45bc.5ab2@mx.google.com>
From: Aadhya-R <raghavendraaadhya@gmail.com>
X-Google-Original-From: Aadhya-R <aadhyar.cs24@rvce.edu.in>
Date: Sun, 15 Mar 2026 12:16:49 +0000
Subject: [PATCH v1] disas/sparc: Fix integer overflow and convert to g_malloc
To: mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org,
    qemu-trivial@nongnu.org
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=raghavendraaadhya@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Mar 2026 08:49:48 -0400
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

Change '1 << i' to '1ul << i' to prevent undefined behavior. Also replace standard C allocators with GLib functions to safely handle out-of-memory aborts. Resolves SVACE warning and GitLab issue #1798.

Signed-off-by: Aadhya-R <aadhyar.cs24@rvce.edu.in>
---
 disas/sparc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/sparc.c b/disas/sparc.c
index e8f4dcba31..702409a118 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2623,7 +2623,7 @@ build_hash_table (const sparc_opcode **opcode_table,
   memset (hash_table, 0, HASH_SIZE * sizeof (hash_table[0]));
   memset (hash_count, 0, HASH_SIZE * sizeof (hash_count[0]));
   free(hash_buf);
-  hash_buf = g_malloc(sizeof (* hash_buf) * num_opcodes);
+  hash_buf = g_malloc(sizeof(*hash_buf) * num_opcodes);
   for (i = num_opcodes - 1; i >= 0; --i)
     {
       int hash = HASH_INSN (opcode_table[i]->match);
@@ -2685,7 +2685,7 @@ print_insn_sparc (bfd_vma memaddr, disassemble_info *info)
 
       if (!opcodes_initialized)
         sorted_opcodes =
-          g_malloc(sparc_num_opcodes * sizeof (sparc_opcode *));
+          g_malloc(sparc_num_opcodes * sizeof(sparc_opcode *));
       /* Reset the sorted table so we can resort it.  */
       for (i = 0; i < sparc_num_opcodes; ++i)
         sorted_opcodes[i] = &sparc_opcodes[i];
-- 
2.43.0



