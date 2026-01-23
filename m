Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD72D778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 20:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjO9K-0000fa-D8; Fri, 23 Jan 2026 15:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO9I-0000cm-QH
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:56 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjO9H-00070E-Ew
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 15:52:56 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D8D6660053;
 Fri, 23 Jan 2026 20:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25416C4CEF1;
 Fri, 23 Jan 2026 20:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769201574;
 bh=wVwps3TGs3ZrzaTKJJaOJuI41dBU062p7tSOpLWO/UM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cKxi++CJPQ764r2cR8BlARtiARQKgBzUsBSLTFgn6VmkNlVmOO41dH95ZxyuNveud
 1TK1JvPVGXnJlpF7zGpCRw98SPGY1XI62eixyNHuK1yBAUCbK5t/rKolncP9Sw0S0G
 JuXHtPyocAmwsWyc3Bgnz3HqoBVNcsyVHtEhTQvJzzpmTj39HZtLBvIaoJTFHls/Cb
 aqkKE5VkJfckroRuTLqm9iLZG776xFzz9ztXzkxAxDvvWcieNz3kdqowNxErfnAJyU
 UaL5ZfjWTwBUlna2tHw0Q7EYZ9TCXPUKAAvdScH1sBtr/XEMTfApbX0MkZQSOvkfa8
 zWKw+Vl/z7iFg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/11] linux-user: Fix MADV_XXX constants on hppa target
Date: Fri, 23 Jan 2026 21:52:30 +0100
Message-ID: <20260123205230.33541-12-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123205230.33541-1-deller@kernel.org>
References: <20260123205230.33541-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Helge Deller <deller@gmx.de>

Older hppa binaries may still use the old MADV_XXX constants for the
madivise() syscall. Fix it up in the same manner as it's done in the
Linux kernel in the parisc_madvise() function.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 64a2f1cbb2..2788c3239e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12922,6 +12922,20 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_madvise
     case TARGET_NR_madvise:
+#ifdef TARGET_HPPA
+        /* Emulate old hppa mapping of MADV_xxx constants. */
+        switch (arg3) {
+        case 65: arg3 = MADV_MERGEABLE;     break;
+        case 66: arg3 = MADV_UNMERGEABLE;   break;
+        case 67: arg3 = MADV_HUGEPAGE;      break;
+        case 68: arg3 = MADV_NOHUGEPAGE;    break;
+        case 69: arg3 = MADV_DONTDUMP;      break;
+        case 70: arg3 = MADV_DODUMP;        break;
+        case 71: arg3 = MADV_WIPEONFORK;    break;
+        case 72: arg3 = MADV_KEEPONFORK;    break;
+        case 73: arg3 = MADV_COLLAPSE;      break;
+        }
+#endif /* TARGET_HPPA */
         return target_madvise(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_fcntl64
-- 
2.52.0


