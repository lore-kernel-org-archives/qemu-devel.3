Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A6BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYCb-0006jr-18; Fri, 23 Feb 2024 11:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rdXvq-0000rq-IJ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:57:52 -0500
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rdXvo-0000TV-7I
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:57:50 -0500
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M7JnA-1rY4oO09KW-007iyC; Fri, 23
 Feb 2024 16:57:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] virt: set the CPU type in BOOTINFO
Date: Fri, 23 Feb 2024 16:57:42 +0100
Message-ID: <20240223155742.2790252-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EdHFFzEu41HgvTU+9yKUk1XcB4hzpwDVxhHSNXb8MTM8dTRbYW1
 V86l3tEJjkfxGf3EcsfIr61cJklSepXT8dqxUjaJtpXKUOFc06wr0iLLXdCDu9DGKeBOIEO
 IlSEcYGD56BCP58Nw9hO5hL8J2XMYRfWBQho7Spk9JhWqnb90tfvZKPCqTX0iDPKjtJ1bA4
 AK8utyP9hB7yqr75eIwBQ==
UI-OutboundReport: notjunk:1;M01:P0:RYN9RQ7XgMk=;X/BZjWzrXkuxeBt6u897jqQo0MX
 iECa2EBix2NmR81W/g4Y2ilV5XkJjeed5KEPPqAQgxebVcKV+kB8Fq/YVzEATC7vimQqNV4kV
 xTae00xcJtu8twYpCm/UKkHLx1D9G6JdswB5U0n2okMBKn+N4E8Q8CvrjrPo2udLdA2OplSYQ
 tJk/IYXcS7JD7HSPntADw+LLAH2gE4lh+zaHPQMzeC/e+o3jnzB636AyUrG+0dRUWU4zMyjuv
 dF/CmNK1FrdzwGe33HJQSpnl2qXFdhkjh5cIvekY+0U3UaVjPyCp1sKpEH9szMIVUOoVprB4y
 BHpfEoBujADDT6Vt15bEiBsUxn7wFo0CtPjhvHdfj2y4ZAOdmWzBxrF+Sxpxl1ASSrJaAvVZL
 kyRNerx/SVqzMN8zPnpA8vMMMHa7IGAf8H6V9DIpm3BsfbfYzJIpN9dX7LgE6EIkLy2Of/kPE
 WTBzkfjWlZYKzGeCL7uKFTWGd+WhzL0k/BEDETTWQBPKwShqic4iK1BNKertbAP/suf5w15j0
 I9mh/ZiM3vUTmdSL5XpRjEDjSDAi2kVqzoacygM8jBUqREkRBQHqEvUQIMb8tv9UiXtw2jGfv
 OUC7X2EjsbQcYgvAoYypfn5MnL3MiABqqlC6jKto3zg9zfDR4lEkXCi0izRX7GhndMUHRdDGL
 66WZzreTGZQnozStTGYq1BeKwWRrRaVP5l6HEfOVRNWTBJ9vdfe7W/mNIa3N1CYIJlduJ0HdN
 sQNfDTLOPOMF7GPiQsOEpgR2KNbR8dtYrZEKUhcHOC6sLxmIdcs52o=
Received-SPF: pass client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BI_CPUTYPE/BI_MMUTYPE/BI_FPUTYPE were statically assigned to the
68040 information.
This patch changes the code to set in bootinfo the information
provided by the command line '-cpu' parameter.

Bug: https://gitlab.com/qemu-project/qemu/-/issues/2091
Reported-by: Daniel Palmer <daniel@0x0f.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/virt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e2792ef46d93..b8e5e102e6b9 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -239,9 +239,20 @@ static void virt_init(MachineState *machine)
         param_ptr = param_blob;
 
         BOOTINFO1(param_ptr, BI_MACHTYPE, MACH_VIRT);
-        BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68040);
-        BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68040);
-        BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68040);
+        if (m68k_feature(&cpu->env, M68K_FEATURE_M68020)) {
+            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68020);
+        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68030)) {
+            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68030);
+            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68030);
+        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68040)) {
+            BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68040);
+            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68040);
+            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68040);
+        } else if (m68k_feature(&cpu->env, M68K_FEATURE_M68060)) {
+            BOOTINFO1(param_ptr, BI_FPUTYPE, FPU_68060);
+            BOOTINFO1(param_ptr, BI_MMUTYPE, MMU_68060);
+            BOOTINFO1(param_ptr, BI_CPUTYPE, CPU_68060);
+        }
         BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
 
         BOOTINFO1(param_ptr, BI_VIRT_QEMU_VERSION,
-- 
2.43.0


