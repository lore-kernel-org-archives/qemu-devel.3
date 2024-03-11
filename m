Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887F2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjrd-0001g2-HT; Mon, 11 Mar 2024 13:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rjjrQ-0001bz-QY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:54:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1rjjrM-0001GC-L4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:54:52 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MdeKd-1rAP2Z3Ah7-00ZeQq; Mon, 11
 Mar 2024 18:54:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Daniel Palmer <daniel@0x0f.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 1/1] virt: set the CPU type in BOOTINFO
Date: Mon, 11 Mar 2024 18:54:40 +0100
Message-ID: <20240311175440.305912-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311175440.305912-1-laurent@vivier.eu>
References: <20240311175440.305912-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sIypDfsU2Q1A68rSltQe1d6u1RkwrEZG4NSsTRy3yNYtPaMwKvq
 9jW07FXkXPFdOcRzivd8H1PuC9kg1RoePuqcnRzoK6/5yVQhfHGAM+5eW6Dk8uqOGN7W2Vd
 JmYswFoBcwF3wJFqfYOz2D7V4ctEfbuLlYBnCuxE/itn3j5tu+1pcd+cS2ka3w/MgYP3KiI
 b+P71VNFnS0pk7tNIl55w==
UI-OutboundReport: notjunk:1;M01:P0:R+nmviD4gQc=;nQ1dHwIorWIdUAALSNj0GcgEUFA
 Kh376QrSQWEqHZIUn0uQh39vOCsr7rAH177bW1PjtLPe1uOW5RZZylpQcy90pOGO7e3Iomsgo
 otFZqp1zh53zVqR9M/FmOuEnN8ig4xP39sKeH5aQfxMySTkayJE2Ts/k0rPOqJTlArwZJzX37
 /ydhA1oQ9bdQv1p2vCnV3+s1FYi+ob4iqpy7l9VKmwSmWsXJlgAoVlMMSqCNeAMZiv+TpEGxZ
 WR8QpOjRINIF7OOfEcXbK2dDCp99eEueSqekiv3oPKbH+AhThBUFjGaCLGET4NKQmkTEZWN2a
 FpgTWOgsIzF63+Jc/DIi+3a6XgRJtrF8dXhZihqMRdlz8/3y7i+SAOgNlggEglKqwr1nAWWbm
 SsbQGD7ZcKuRl3x1QeXyOnTF7WtI9lNa1QVrg/cXtqHsSSEkx1W1mcsQKs4RJagE5WAEkwhbL
 qG1JHzMsqaoMYwvSHXBp9kEGxbvSCmWfvNPXKXLjBax4B9BgegoFD6WbQbAtNVaLSxse4J+jy
 4t33mtjM6y5IO6fLITV7c+0iZOpfpYwQ/zMNwnm/tCn7butYmZg5iIjX9iiuMyabfBDVEYLpL
 EIqrBfOCjPMCAr9DuC8sc5G4F1WlyDDpCK5LuFcgSFX7NQkBbt15O3DUC+Z2RMS/fFQHQSoGs
 LlLvcQq1xs/TzptR5eMVwlTx1okX8sCu8ntqZ8H5a+isajmccnJC/oM47spj93rM4rIZ+dBKk
 qiV0/APYbG4XVWUAo10WxYq+f7XwuYM291gg3uKWm5X4NbYBN9jYt8=
Received-SPF: pass client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20240223155742.2790252-1-laurent@vivier.eu>
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
2.43.2


