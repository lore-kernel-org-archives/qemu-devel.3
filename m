Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=S3KtH2Ve
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJiY-00062m-4H; Thu, 29 Oct 2026 02:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xMJiH-0005x3-4f
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:34:14 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xMJiF-0004ke-Ip
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:34:12 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jFZFQ5lzbz8PbY;
 Thu, 29 Oct 2026 02:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=cs6aOWoSVHyyg2iG3RIOB2nPeN/8jJxc13ujd9NchrE=; b=S3Kt
 H2VeINgiW7nVFQqK74tezmWtKgJJoMyFeOxAhsVxlWnx3QkJqio7965+uxG5madA
 dE8VAcnuBBP4LaD3sBz0M6yUQRiMDqTh5ObTsyyB40qwNBCG25HkT84Qj0rBBc4o
 CgbUy6X6ApgC0NKu1Ezqw2bjQumRY4rp8xj9tLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=hcvFknTi4EXxtVcXMNF7cmNhckTG+jIjacejVHYJXD+pHDgNQkfOf
 uImN6vXbdgs80S/GkYKLsahLrUQnXynyt9C1FVNPqZXN0cTTFxx2xmrNlXlNoqAC
 zO7RJPiFoAYJukmYDZJIt1X6VoRQAXC+pdXIRzQf6Hab6Jcsss6JvM=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:5bf7:2fb2:2e98:8fce])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jFZFQ58b1z8PbW;
 Thu, 29 Oct 2026 02:34:02 -0400 (EDT)
Date: Thu, 29 Oct 2026 02:34:01 -0400
From: Brad Smith <brad@comstyle.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util/cpuinfo: Remove obsolete OpenBSD/aarch64 CPU detection
Message-ID: <auLo2X1RwG96lPmu@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

util/cpuinfo: Remove obsolete OpenBSD/aarch64 CPU detection

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 util/cpuinfo-aarch64.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index e344676214..85df16ba5f 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -26,11 +26,6 @@
 #ifdef CONFIG_DARWIN
 # include <sys/sysctl.h>
 #endif
-#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
-# include <machine/armreg.h>
-# include <machine/cpu.h>
-# include <sys/sysctl.h>
-#endif
 
 unsigned cpuinfo;
 
@@ -85,36 +80,6 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_CSSC") * CPUINFO_CSSC;
 #endif
-#if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
-    int mib[2];
-    uint64_t isar0;
-    uint64_t pfr1;
-    size_t len;
-
-    mib[0] = CTL_MACHDEP;
-    mib[1] = CPU_ID_AA64ISAR0;
-    len = sizeof(isar0);
-    if (sysctl(mib, 2, &isar0, &len, NULL, 0) != -1) {
-        if (ID_AA64ISAR0_ATOMIC(isar0) >= ID_AA64ISAR0_ATOMIC_IMPL) {
-            info |= CPUINFO_LSE;
-        }
-        if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_BASE) {
-            info |= CPUINFO_AES;
-        }
-        if (ID_AA64ISAR0_AES(isar0) >= ID_AA64ISAR0_AES_PMULL) {
-            info |= CPUINFO_PMULL;
-        }
-    }
-
-    mib[0] = CTL_MACHDEP;
-    mib[1] = CPU_ID_AA64PFR1;
-    len = sizeof(pfr1);
-    if (sysctl(mib, 2, &pfr1, &len, NULL, 0) != -1) {
-        if (ID_AA64PFR1_BT(pfr1) >= ID_AA64PFR1_BT_IMPL) {
-            info |= CPUINFO_BTI;
-        }
-    }
-#endif
 
     cpuinfo = info;
     return info;
-- 
2.56.0


