Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1301CD715D6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 08:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjZOg-00024h-I7; Sat, 24 Jan 2026 03:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOf-00023r-7j
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:33 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vjZOd-0002Tw-Rd
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 03:53:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 06F4B41AA3;
 Sat, 24 Jan 2026 08:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73171C116D0;
 Sat, 24 Jan 2026 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769244810;
 bh=Zlew345yXRVgAr6Uar4LjRiTWs09Vw/bnpXL9OCbrTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XRQZuTSO1GgkxTTL5hdaLFcFVaPr9lwopK1mrkq/cysIK8YQkQY6GyF7lyjuczaFH
 MBL0CVMsH6PBfutU3psmZehuxYuhW+XIvIzj7wbVWNNtZaaqCULpX1iF8prhEABCVe
 c/HLvUxN9JQvpVr4DVwKb8q9fvw5c/AvXgYX6tTPOc39fiYqXdUdsfcCzycmJfbKib
 rsNbkhG2YgRJGzUvJnJE1bTXs1WpQ5wDdy9wauAmLHTJ3M2VECzAj4+xXphVJzQrrM
 p7OweklsR6HFZEqn2U6f3thWRTf1kbPgi5501KGGHzPCRlu/eAPhDpajULDSrihXO6
 rbtrkVjqRpnDA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL v2 11/11] linux-user: Fix MADV_XXX constants on hppa target
Date: Sat, 24 Jan 2026 09:53:06 +0100
Message-ID: <20260124085306.3996-12-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124085306.3996-1-deller@kernel.org>
References: <20260124085306.3996-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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

From: Helge Deller <deller@gmx.de>

Older hppa binaries may still use the old MADV_XXX constants for the
madivise() syscall. Fix it up in the same manner as it's done in the
Linux kernel in the parisc_madvise() function.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 64a2f1cbb2..3944004568 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12922,6 +12922,22 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 
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
+        #ifdef MADV_COLLAPSE
+        case 73: arg3 = MADV_COLLAPSE;      break;
+        #endif
+        }
+#endif /* TARGET_HPPA */
         return target_madvise(arg1, arg2, arg3);
 #endif
 #ifdef TARGET_NR_fcntl64
-- 
2.52.0


