Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B682CA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDKcq-00045t-MC; Sun, 04 Oct 2026 07:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcp-00042y-4X
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:27 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xDKcn-000249-Le
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:43:26 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB6FF44794;
 Sun,  4 Oct 2026 11:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF621F000FF;
 Sun,  4 Oct 2026 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791114204;
 bh=j4Rnowfy8+a+Bec+gL8cU3IGcys3lV/+mIyMzWJPu5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UgfjqULTvsqT03U9rhq+i4JBdpPyjNB0SzX1G9e3ewnf1xNuOlFrPELhn/JxngPop
 zyxdq6y3P8H6/WJx9FDMmOYbu7QEDpZYRYuq3gzKvUwfIVMnCt63DcAGZLly7fGWqv
 98plfjZOnptvHh/AHwUu6c9LJ/5+UZ5U+klFDTNErEhx+Db0haiY+3WXyblSSe3pB/
 CdNzCPK2BGtd6Wpz6Yqvuy3D4j2dNK+mM58RCAm24rMMXQETR6ni0pAgIsKRxXmZjE
 4dNp4ThA88CsQQgo2+tyXZam8/vXClIpNpePnBVqWhzy34EcpPC4kzYjhrLipkr5kx
 NuJR9V+L9ydrg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 5/5] linux-user/mips: pick Loongson-3A4000 if a pre-r6 mips64
 binary needs nan2008
Date: Sun,  4 Oct 2026 13:43:10 +0200
Message-ID: <20261004114311.3874-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261004114311.3874-1-deller@kernel.org>
References: <20261004114311.3874-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Alex Rønne Petersen <alex@alexrp.com>

Before this patch, we'd pick MIPS64R2-generic which does not have 2008 mode, so
the binary would just fail to run without an explicit -cpu flag. Now it'll just
work as in the pre-r6 mips32 case.

Signed-off-by: Alex Rønne Petersen <alex@alexrp.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/mips/elfload.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
index 1d62ae0a4d..19850f4835 100644
--- a/linux-user/mips/elfload.c
+++ b/linux-user/mips/elfload.c
@@ -20,17 +20,19 @@ const char *get_elf_cpu_model(uint32_t eflags)
     case EF_MIPS_MACH_LS2F:
         return "Loongson-2F";
     case EF_MIPS_MACH_LS3A:
-        return "Loongson-3A1000";
+        return (eflags & EF_MIPS_NAN2008) ? "Loongson-3A4000"
+                                          : "Loongson-3A1000";
     default:
         break;
     }
-    switch (eflags & EF_MIPS_ARCH) {
-    case EF_MIPS_ARCH_64R6:
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
-    case EF_MIPS_ARCH_64R2:
+    }
+    if (eflags & EF_MIPS_NAN2008) {
+        return "Loongson-3A4000";
+    }
+    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R2) {
         return "MIPS64R2-generic";
-    default:
-        break;
     }
     return "5KEf";
 #else
-- 
2.54.0


