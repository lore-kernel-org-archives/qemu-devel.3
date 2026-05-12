Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55156CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuNx-00088L-2n; Tue, 12 May 2026 17:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuNj-0007uN-Ao; Tue, 12 May 2026 17:11:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuNh-0004Sd-FA; Tue, 12 May 2026 17:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=8O43rCGIV6dv6xRohmtlMa+2vnknZ11NjLXOq+nmMC0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RpaDO9NjOQ7laA4a3vUQk0ZuBUZCrxDS3YBKYTcO4yiQ7XEFlpSHQh3davMfEFk/p
 fczvOsWaK2yKP6oNsMCp9PQPKMTKSf4uuNs8HUyE5xSD9mccW0EBVcFiYS7cJ3dzBc
 elGnX69obkVAO/YOuSbROox/3jbK+JbD+969H8x/mpZPQIPCFPRMTcfiUXYHLv83XY
 wThdRaVuX6cwaa2VkNa/938nf2QfAyuSnEmB4ihnDKCk6sJ7stpxlCWTmpk9R0OFqX
 OwuMP9IiNv2i70o/48Kj9bFKmLyAQHldSZlarhdFALRwGY0sHYoZ3RgvsDT5rq3cqE
 wY7W/vCbeEQBQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F99C1AA371;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 387C23ABCE1;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 052/117] include: Don't include guest-host.h in
 cpu-ldst.h
Date: Tue, 12 May 2026 23:53:54 +0300
Message-ID: <20260512205503.361097-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Maydell <peter.maydell@linaro.org>

We currently include user/guest-host.h from accel/tcg/cpu-ldst.h.
However that file doesn't need anything from guest-host.h, since we
removed the uses of g2h() in commit 9b74d403b30e ("accel/tcg: Move
user-only tlb_vaddr_to_host out of line").

Move the include of guest-host.h to where it's actually needed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260330143123.1685142-2-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit ad7a005d672a657a5344575426642bfbea20e3e0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 93388e7c34..61c2e85177 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -27,6 +27,7 @@
 #include "user/abitypes.h"
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
+#include "user/guest-host.h"
 
 extern char **environ;
 
diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6..88c49a95d3 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -71,10 +71,6 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
-#if defined(CONFIG_USER_ONLY)
-#include "user/guest-host.h"
-#endif /* CONFIG_USER_ONLY */
-
 static inline uint32_t
 cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintptr_t ra)
 {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 85e68eff7b..cfe5f45fc4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -10,6 +10,7 @@
 #include "syscall_defs.h"
 #include "target_syscall.h"
 #include "accel/tcg/vcpu-state.h"
+#include "user/guest-host.h"
 
 /*
  * This is the size of the host kernel's sigset_t, needed where we make
-- 
2.47.3


