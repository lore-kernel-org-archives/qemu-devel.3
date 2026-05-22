Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0223CD5BB9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXV-0001uu-8O; Fri, 22 May 2026 17:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWQ-0008M5-2u; Fri, 22 May 2026 17:35:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXWO-0007o1-7T; Fri, 22 May 2026 17:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485633; bh=HLstrD2yX5cos5Myq+2hfk0ettzVsUF35yppkgC4WsE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CXyoe5/ef/DIh5E5T1091AUEULQ2gfM99RJNfr5zXqlS468vupt+htjGeTKopOPoo
 hBwgil9u0uxfNSyjYeXdOZNYfT10PCt73mHHWZ3RNjR2rHwi+CVfUEdEgVHB8QAGge
 qHZa92uDQPXdJW0vFfOjZD/FAB/QiJAwxHkNMestcFpT628cBXqxZUNWdUJ10ltE8x
 cA8yfjnyPnO78Q+acykjD9HsmVWmq3OKScooP8vS4Xy1mXYnwFvM8nuuR8vOUaOIlT
 YYGx4XoMxDXYlJf531RA8CyQFYvNssUkUXzWqq1fdmnncutR74lnb5O+ljitU2andd
 AGGR5Ma77eEdA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4C9061AFAD9;
 Sat, 23 May 2026 00:33:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D3C73B715F;
 Sat, 23 May 2026 00:33:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 74/94] hw/remote/machine.c: Mark x-remote machine as
 OK for AArch64 and AArch32
Date: Sat, 23 May 2026 00:33:31 +0300
Message-ID: <20260522213356.806058-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
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

When we updated Arm and AArch64 board types to mark them for the
target_machine_typename() filter, we forgot about the "x-remote"
machine type, which meant that it disappeared from the set of board
types exposed on the qemu-system-arm and qemu-system-aarch64
binaries.  We didn't notice this, because although we have a
functional test for it, it requires the KVM accelerator and we don't
run the functional tests on an AArch64 host in CI.

Mark the machine as being OK to expose in qemu-system-arm and
qemu-system-aarch64, in the same way we do for the "none" machine
type. This fixes a check-functional failure on aarch64 host, where
it would otherwise fail with:
   qemu-system-aarch64: unsupported machine type: "x-remote"

Cc: qemu-stable@nongnu.org
Fixes: eb796c55513d9d39 ("hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260507194728.2034696-2-peter.maydell@linaro.org
(cherry picked from commit 4e8ac6857faab29f8d6e149f4d71aeb057884496)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index ced782f6a9..df08f64019 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -24,6 +24,7 @@
 #include "hw/core/qdev.h"
 #include "hw/remote/vfio-user-obj.h"
 #include "hw/pci/msi.h"
+#include "hw/arm/machines-qom.h"
 
 static void remote_machine_init(MachineState *machine)
 {
@@ -148,6 +149,8 @@ static const TypeInfo remote_machine = {
     .class_init = remote_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
+        { TYPE_TARGET_AARCH64_MACHINE },
+        { TYPE_TARGET_ARM_MACHINE },
         { }
     }
 };
-- 
2.47.3


