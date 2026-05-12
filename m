Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EDDCD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuW5-0004kA-Hx; Tue, 12 May 2026 17:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuW2-0004St-Dj; Tue, 12 May 2026 17:19:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuW0-0008BR-Ry; Tue, 12 May 2026 17:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619498; bh=pE8FGCMUOa/KDw+pyOkBJnpHIlSPh7/CPIuMTng6qws=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a51Q6jligCITLbd9DszKKdXqowJLwVHA/jVRxzR8MPvUjekAbzjxjuLKS1R0fltf/
 TtfjWC0U8ZRT7wUV/UnhMBCG1UhZcfPGmJc6YNRRBWqu/qUxNPkiLhpp2vJd4oJaRr
 g1bv5EcsQ6StDnX7azpV/UCHr1gB44JHkin1TUJu4xtyR7rr9Jq74O0wLXqBwyiLWj
 X7tENbMxJZPiyG66ITekHNmml0g3EB+8HKymKsMs/OT1o8CZ5eVkdXzamgbQKGJZW5
 0hEg0fHxTRNntFUOaHb9fSfS1uaDK5DOwGhkLCHPNXmkx6esnmIeit6dQY1gXQtMNO
 +G28MMjbDUrQw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FB991AA3DE;
 Tue, 12 May 2026 23:58:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3A2753ABD36;
 Tue, 12 May 2026 23:58:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 19/58] linux-user: Don't define target_stat64 struct
 for loongarch64
Date: Tue, 12 May 2026 23:57:40 +0300
Message-ID: <20260512205820.361821-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
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
index 679af640c0..6967306be4 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2005,7 +2005,7 @@ struct target_stat {
     abi_uint __unused5;
 };
 
-#if !defined(TARGET_RISCV64)
+#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
 #define TARGET_HAS_STRUCT_STAT64
 struct target_stat64 {
     abi_ullong st_dev;
-- 
2.47.3


