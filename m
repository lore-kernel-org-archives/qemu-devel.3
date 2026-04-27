Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B117EFF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT5a-0000Qp-Nv; Mon, 27 Apr 2026 17:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5T-0000GD-HR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:52 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wHT5P-0003UG-4D
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:01:50 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E4EC4099D;
 Mon, 27 Apr 2026 21:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0F4C2BCB5;
 Mon, 27 Apr 2026 21:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777323704;
 bh=SNBeEj5KSiWYkyqRyYX2gQdrt+ivR89RyfGpq4YmrsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QPz2s4XgJKOdLKh0y4lui14zYkrMp2F6Cs9GuPvry66VvD9DLXRFUOvU6t9sG3aHR
 HrluWiCTSoNV66JdadnK1xDKm8WtzFrTHzlCf/jcX+9luTkDwR70Syy42k+GVcLjUY
 LtNvTWwn2Gq86KksCpuW71GmD+iTb34INSB3Z292//EwoFyE8BiTrKLX10Q5jDKyv0
 7C9ooG1qXOxzVQBt1ZV4UghfRPkPd5nNGjyrJchZbJl/Hp2Gsx7mdWpkfY+Z9V2eG0
 BbWUY7bVst4QEmDH2rAloFq4Ayznjm2aExXrtLXofAxBkdZveWbDQvhPPGRGSwkGYO
 SjjNH/jKaGIuQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 04/15] linux-user: Don't define target_stat64 struct for
 loongarch64
Date: Mon, 27 Apr 2026 23:01:22 +0200
Message-ID: <20260427210133.6016-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427210133.6016-1-deller@kernel.org>
References: <20260427210133.6016-1-deller@kernel.org>
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
---
 linux-user/syscall_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.53.0


