Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E9CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGs-0004PO-6C; Tue, 12 May 2026 17:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEp-0008Hr-Aq; Tue, 12 May 2026 17:02:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEk-0006dS-7Y; Tue, 12 May 2026 17:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=3zIB+O/5vKEtmBM8C9ZQISmeP/fCK2GT7YLJ0pvkpPc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HhdTUaMCPXdmElX8jZxPqPVfhwP4n8NbXUHwwOn+miaCzYEX+gIJjMsE7a5nOWYne
 kTYgtyKVvXGMsQujCIrNCOvnn1yKJMm0HtucjPIyU+nggLtKi3pwqJW/23Cq9Q6twp
 iaOv9VxXZFM2KPLkpVDNNR4u5ZVYBqOxDBQvRAuw7w150UgarXe2MqcSUtVrZQvkLW
 VEr46Dc6/eJqYoM4xknPJ0R6g2G5IIu3IQ3ILkHIVxB+cYzqkuGSMdWBQm6py9q2Gf
 xjT+z77ueHHbs0n5NYidapX/qpNzwmmNqpO8yxMLYsA4RrowaNvk/Luyv2D9GZEGR5
 MUSK3ZgpfkP2A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1CEE71AA313;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 271323ABC84;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 071/107] linux-user: Don't define target_stat64
 struct for loongarch64
Date: Tue, 12 May 2026 23:53:58 +0300
Message-ID: <20260512205437.360850-71-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>

The kernel defines 'struct stat64' only if
__BITS_PER_LONG != 64 || defined(__ARCH_WANT_STAT64).
loongarch64 doesn't set __ARCH_WANT_STAT64, and it isn't 32-bit,
so it won't get this struct.

QEMU incorrectly does define a target_stat64 struct. However this
isn't causing any guest-visible problems, because defining the
target_stat64 struct and TARGET_HAS_STRUCT_STAT64 affects these
syscalls:
 TARGET_NR_stat64
 TARGET_NR_lstat64
 TARGET_NR_fstat64
 TARGET_NR_fstatat64
 TARGET_NR_newfstatat

For loongarch64 the only one of those we provide is newfstatat,
and that is actually a separate QEMU bug, because the kernel does
not provide that syscall for this architecture. No real guest
code will be using a syscall that doesn't exist in the ABI.

(Some of these syscalls are present in the loongarch64 "ABI1.0",
but that ABI was never accepted in the upstream kernel, and
QEMU does not model that ABI, only the "ABI2.0".)

Stop defining TARGET_HAS_STRUCT_STAT64 anyway, for consistency
with the kernel and to avoid confusion.

Note:
Commit message suggested by Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 93484c768f2b66947a91d6372f408ae01c83e8c6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index b5a2ad3b2d..86bdf88be7 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2003,7 +2003,7 @@ struct target_stat {
     abi_uint __unused5;
 };
 
-#if !defined(TARGET_RISCV64)
+#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
     abi_ullong st_dev;
-- 
2.47.3


