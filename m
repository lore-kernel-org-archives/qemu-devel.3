Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0183FCAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23ZX-0000QA-EZ; Fri, 26 Sep 2025 04:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23ZV-0000OX-H7; Fri, 26 Sep 2025 04:12:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23ZI-0000e2-H9; Fri, 26 Sep 2025 04:12:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D889157D59;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1556F290C3D;
 Fri, 26 Sep 2025 11:10:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 17/60] elf: Add EF_MIPS_ARCH_ASE definitions
Date: Fri, 26 Sep 2025 11:09:45 +0300
Message-ID: <20250926081031.2214971-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Include MIPS ASE ELF definitions from binutils:
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=include/elf/mips.h;h=4fc190f404d828ded84e621bfcece5fa9f9c23c8;hb=HEAD#l210

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250814070650.78657-2-philmd@linaro.org>
(cherry picked from commit 14ab44b96d5bf761af81cc723314ef5ecf73ed17)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/elf.h b/include/elf.h
index e7259ec366..bbfac055de 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -56,6 +56,13 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ARCH_32R6     0x90000000      /* MIPS32r6 code.  */
 #define EF_MIPS_ARCH_64R6     0xa0000000      /* MIPS64r6 code.  */
 
+/* MIPS Architectural Extensions. */
+#define EF_MIPS_ARCH_ASE      0x0f000000
+
+#define EF_MIPS_ARCH_ASE_MICROMIPS 0x02000000
+#define EF_MIPS_ARCH_ASE_M16  0x04000000
+#define EF_MIPS_ARCH_ASE_MDMX 0x08000000
+
 /* The ABI of a file. */
 #define EF_MIPS_ABI_O32       0x00001000      /* O32 ABI.  */
 #define EF_MIPS_ABI_O64       0x00002000      /* O32 extended for 64 bit.  */
-- 
2.47.3


