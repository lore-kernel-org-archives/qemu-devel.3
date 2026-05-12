Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5609CCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnWl-0005Cn-6s; Tue, 12 May 2026 09:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antercreeper@gmail.com>)
 id 1wMhft-0001xO-O6
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:37:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antercreeper@gmail.com>)
 id 1wMhfs-0000Wd-45
 for qemu-devel@nongnu.org; Tue, 12 May 2026 03:37:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so31898015ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778571422; x=1779176222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xz0e648EZjPOzfU36bsIktA7MSSiUSIKUjdvRSxBW3U=;
 b=RP8dyC2lbRn5nMOdYqEThvotBfKBBe+Mkd57yFsqGLkYItAM5qM6RKQz+F2+9kfKDL
 Om0rAtIpd56CC9EHd64/jkzR99R0sOb8o8u5Ch7B6FK4X/d0/K9H6myYWmkLi+rh263C
 7Ga1++Y1/t9lIXggeN6TA1j/2oPLx5S7/rRcflBh6Qa7TNsrPvbqVfAu8aWs14scTJE0
 zuybzVaXwMF+XqBWqa3NoOxEJ3N+A2thUAbLRlBvd4+Vu/wj71KdFSEWo/PbbpDZI/mo
 ifluuDIi1mwm2ZcIbT6a9H9zwJ/J5mhcpPjcymNMogiCUmFv/ShP81lmxPL+5Fp46TFl
 oRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778571422; x=1779176222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xz0e648EZjPOzfU36bsIktA7MSSiUSIKUjdvRSxBW3U=;
 b=dGD3t0o+8/5YyNDO0DYLJk96fawEQV13WQF7IFWonTvHpeWb1HweEGSfCH+ZMu3Jku
 xaICu0g0w5NMu9tB+X4JPYvclL1F84uUqHitd0P5tYTn9tM7jeYEkRHrBFc3cqznM9+4
 mVoj+GTkxhRfwGYymvQjVxHlqAeaA7BmG/+mgx1BX1a7kYw/4qKDeHkgiBjMMBhh6+Ai
 LYfDi0q8La5BYRqM48F5aATvoWdcrpmcapg0oNVAeMuWOImV3Z2cm5dyW0EZvvPOqAnu
 bsThz2czoVbLv7BT6fkt9+99KSbDFPVgrupT+Hez/OPHp4jAUFxFbfK6JZTlysbw+Xgd
 UhGw==
X-Gm-Message-State: AOJu0YxsGynlTO3djUFEg69jqFDRYJspn1VVTwtLSgU77n9BjO8XInzl
 MyyxcOrCRta5UTK+6LLv39JP3GHbFe/412WRB18bP6VsHee1VB+D3vG3Het6QCq2UhQC0A==
X-Gm-Gg: Acq92OFmHKXyaE2vfGv/XHZPZP/4gIcqe8MDf7wg4oFjGDWHHozl+Y+Emxu2J0O7eVD
 tOcbkgr9TafSzmdtsOW/QMkdt+8R88l6QxG4204qyB1YYpa7B/E2AoNKgclXwxmCY8h2YR7i630
 yq99tF19v467LAhHNxNRiGVURcJHDp4DXlYQDeSF3rE+WAYmjxvJzaOZpqa1qipefWOmYtkL4Av
 PatWOccj0TlZYJu7qVrvIXh6Yn2DpUEDKs9857W6jTFpfXvue/B4s0Al+dDlTIeGCQEvvltuMsh
 0Vj7m0HSaIFE9TaB9oaz4A58haRokbBjSuQobcr1mjyMFtRBKAhjQJzD4uoFOcZUUaPFVuqjGNh
 nfgoK9LCmz2aba+pSwxdGAnpkPp37eVGyMK+LMgFVA56Kt+Z5HgkiXAR75cgGbmdRgzEHSDyyBC
 lvCnzUVpHuvGEen88OUsNRKyrpMls/FU7ykz/RpwknrA==
X-Received: by 2002:a17:903:1aa4:b0:2ba:bfc:76a7 with SMTP id
 d9443c01a7336-2bd012d5fb4mr22908155ad.23.1778571422254; 
 Tue, 12 May 2026 00:37:02 -0700 (PDT)
Received: from silicon.tail3bd2b.ts.net ([124.127.234.227])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e36c65sm127915435ad.40.2026.05.12.00.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 00:37:02 -0700 (PDT)
From: antercreeper@gmail.com
X-Google-Original-From: wangzhihao9@hotmail.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 Zhihao Wang <wangzhihao9@hotmail.com>
Subject: [PATCH 1/1] accel/tcg: allow unaligned access for SPARC Solaris
 user-mode
Date: Tue, 12 May 2026 15:36:54 +0800
Message-ID: <20260512073654.80315-1-wangzhihao9@hotmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=antercreeper@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2026 09:50:50 -0400
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

From: Zhihao Wang <wangzhihao9@hotmail.com>

SPARC Solaris user-mode binaries may rely on the Solaris kernel
emulating unaligned integer loads and stores.  Add an opt-in compat
mode, controlled by the QEMU_SPARC_SOLARIS_UNALIGNED environment
variable, that skips the alignment enforcement in linux-user mode.

Signed-off-by: Zhihao Wang <wangzhihao9@hotmail.com>
---
 accel/tcg/user-exec.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d283d3cc72..d87391a7d3 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -927,14 +927,39 @@ void *page_get_target_data(vaddr address, size_t size)
 
 /* The system-mode versions of these helpers are in cputlb.c.  */
 
+#if defined(TARGET_SPARC) || defined(TARGET_SPARC64)
+static bool sparc_user_solaris_unaligned_enabled(void)
+{
+    static int enabled = -1;
+
+    if (unlikely(enabled < 0)) {
+        const char *env = getenv("QEMU_SPARC_SOLARIS_UNALIGNED");
+        enabled = env && env[0] != '\0' && env[0] != '0';
+    }
+    return enabled;
+}
+#else
+static bool sparc_user_solaris_unaligned_enabled(void)
+{
+    return false;
+}
+#endif
+
 static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
                             MemOp mop, uintptr_t ra, MMUAccessType type)
 {
     int a_bits = memop_alignment_bits(mop);
     void *ret;
 
-    /* Enforce guest required alignment.  */
-    if (unlikely(addr & ((1 << a_bits) - 1))) {
+    /*
+     * Enforce guest-required alignment by default.  Solaris/SPARC user-mode
+     * binaries may rely on the Solaris kernel emulating unaligned integer
+     * loads/stores, so allow an opt-in linux-user compatibility mode for that
+     * case.  This file is user-mode only; system-mode keeps using cputlb.c and
+     * the target do_unaligned_access hook.
+     */
+    if (!sparc_user_solaris_unaligned_enabled() &&
+        unlikely(addr & ((1 << a_bits) - 1))) {
         cpu_loop_exit_sigbus(cpu, addr, type, ra);
     }
 
-- 
2.47.3


