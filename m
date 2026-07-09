Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B380DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whh0p-0006l6-2W; Thu, 09 Jul 2026 01:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0n-0006kJ-S0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:25 -0400
Received: from sonic314-21.consmr.mail.gq1.yahoo.com ([98.137.69.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0l-0005mB-BZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783573760; bh=UmUmWH59zwDkMLLGuuGvz0xwapBoT1O8sVu7oXOskMA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=hGHrGkCZrQZCC7XLtuCMvJIdut61Pe/EmUDh0iLkCd/+jW65mcTW6JH0XjzA6jvabpZsVqk641YUUGNH39EU5YeFPCeapQB3t4JdY1Rct3CaNTqamO+JBrgBTNPbByTSaEnjnMgMObZZOa7xm2LDa3dN9QZikCwv8Kk7ACNiMQK9E4eO+DDeIh7+bH95LQ7C2splnR5CJp0YpkJNZ83ZoGhLS/cluKUChART3xYV63nJlVkoUkwGYWbX3q0duIpLgePeqZgdU57ZFJn19PHolewmNVHjTI+QdCnib38GOXoEEnS1MCf1lVpKyrNz+p2leiMb+TUPQF/HXHMdhJI1Qw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783573760; bh=9xClvDzp3a1vB5OzI9ZBLOxM/ZtVUMYTi9D1WxSqNGH=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=s2wHTm8b6Q9HGZDmxBeolGQ2/STF0XVsaH9gI2V5oPJJRKskqgwrFrjhFcyEDEpejw4+bNvJuzeQ4a6RRW3x195EwNLiDx8JwH/r/QWF7ZxXfeAo8jfK410urEhyjsBx2FAm5VOJOiX04Hb4D6qEy2P9ukoaNaDdTUuV/Je4XzLD/lLKX8Ze5uJJp/y2ImG/jpIccVU4j+cT42PrvzPerlVq6Z/bXXZJL9YukN4hpTY0SbqVWdiYelS6OxpkftqFHl9IuZOkyqCrqmiWxrbqFJtJNv1uIHXD/Gd2t48K4dgU2WE7LcweqOqRZuH8DpqH9FKj0YqX/GHowV6RX+MLiA==
X-YMail-OSG: M2AD1sEVM1n8ckvxeNh8b1S.UEC2tMUHrV5UUtXVp3HMLDkQ_7RGScJZvo1jjHS
 EfcWrN1N7dnF3zCvb0zBX5GW7.LZj5aYUaEIZyHGnV0njwihcIXuu.jyzgD7NEXSrPHAwlSKauUe
 dG8cvXDlYcAeDoIgiLLSfY6NKoUVPq9V9JsWcUOy_lZIPSGLufQm8QeOFTPE9RmKMv5j._GyKphp
 af5KHl7DqDB9FCu3Dp9Da_729wBsZ7PqfF0w65WiQ6sh6X6K9IUNUR7_cgE52M1uzABiSf7xDQqo
 Pw5ijPjRIukt.GOFWQdx_YcvTsPN_5194MdLclO3HW.XGKWXyA3A28.rw_0QjKcUOKH8omNK5GiW
 pd2mpKldi.bsotvIlXHzJ2bUvoqk9MiKvF_QpIKJgYW7aOyPlBIQkF3OkDK.h4ajiU_8Cw9.RtgW
 VFpYK6KZzIH3TQG9LM453gdE6wWL88B6S7pX5Wnwk1zxWzmGSg0gKy6wzMS9U2.bES_CPUEIvDJe
 rdAsk9aH0MgUkvXgvYP4Quqm9LRqDW2o7lnuIMIYS2sfu42Xnglr7GSPzwuODhUDgUVYlP5x4yi8
 Vc1e3wrbM9yDaZkrlx0qPgFbHSDwlk4p598CZaleRyybmMYfVQoYTvwb.fOk8PZMx0Ky0cUk8.YM
 4cSBPETMZLbNzzbuoTGRHaZ6qddca1yTh1J19z66PH4fBHTf3w7lrd5Zo.TmoUS07AKJnOpegRLE
 2zMfy3zxZn_0sRlXNl.b6V5Zdksk.D9dq9pCbw2EhHzEA4yx_yIXKvl3nrpjP8VNtJZHWOicVecG
 37g6pdMuM32l.fcpkzMqSVYWfGEMja1rP0gBOglfbKFK5w4AygzahleZQEsJxfVtLQ40B8kJtnQw
 6BqJLnkUnfKgUmNfz1W8kMxMDsJNYvI0LTZdTQQaWxhXYuyKHUaW4cFWlZiP5SDUxMnuU9NJ8es_
 WSbVUAhZtVCpOaw1V3mFgCzH2gm7aS9mkFwBCHsW3r_q0DgRNJsZNE0lODZQS1z0AtAivHH48sJI
 uwvE44Il5mV9EJ4bQXyb.9bSVH2ayQjGrpovFLJFanaWodUsWfUGSknEdJNCuTqKFeTw9IDSXSyJ
 eO98oqiQRkt1TOk1q7RVVeGxO4Z22nUCAyZmH3ZsMS46hoIuUXpLy0JJeKW4w_lSZhyFUz.xjYp3
 8k0mNsWx5Y.rQNmoFoSBhiRwkg94xNIFxXzF48agN9Ag9xMVtnlY3HnSSLqNKEPCpoEJiFPN5iFo
 AMojO0LOZit1N8FEVOsZ_HDUavMA6yWclKvBjp4pset97LUREWJXAvcsWNdD0y4BVybqWLDwuzs5
 .JromwszZQRmswsj9DWt191vbBuwXIJwym9WLSUZcPAbqutg9R5m.i2XbJbvSQEWiUYsreM_zOvc
 OaOLbsw9u0gUM_I0LJDKtJnMxTh7pmzDR0_Yvfoa1NvyzhJzTD0tL5XITV0qNizdZD03L.K7Ale7
 jL.oNyBvsWh40_U.eodZVPzLbwgXPKopfvXzAQhi_geuMWOFxMaJAJaNLhvyZaIAerKHsGHXCd1I
 rkSSuS3y7B1iKy06flwelHce0QrmujnOsN9zbLxSrboz9kbaxCCMrnhIwi7S3wqivwm.x.JPxOmV
 YWWUHxZ3k7V0T57nxVZyUDCCLRfDJmSZzN78tNvR4eRro.6H90GadGypP9jDL4w4n2_qZ9w17LJW
 Js8gKvxuZLC65uz8r.3q7fTjzc.8HaiH0FXy25ViX0v1EgS7Kcxe8vzJ63ceLS0dvBOgkaKechkl
 FzJcsIONxOpVg_PzLRMykYuCYCAsYVCTemyxGIxutTHZUrYEmTSI4c3y_iTgJuPal4B81oDqwgqa
 0Dksj.wVwUiNCQ4_lJ0mzeiObB0sm6IHIVpeI5JiWuEgZRr244fsinTP79cfAZftm0lzy3MqscEv
 jaVuTHPjX.c3jGEy5KsbPZQkkWj74g0.YrHFBEXDrY.HzSRhniqMpHpiyd_xQRq0Z3A7vt1QQe.H
 klVQGSK91OCdctFkP.athI26.gnWQWufh6Qy5GyfRXp0709_J8EZxKspyE10UL.UW.U5Aa4v1Cpc
 flIU0FlQVEU0Yut56zAl4E_WtMWG0mcmFYesn5oj9HM7_G2e27nxGw3JU4LTF.cVbAqpczSIdmm4
 1BWb7IfOOAUkQQorbZYYglwJS96nkZ._2ff3sWiB.hvxRftpxR2YpyZSDO0jzvh7hzDwX2byEShg
 5hhJ6zOmRP4t_x1s2jlkXQ8Fs5lCVL0LcAw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 95c2e078-b625-436e-bd84-c2e244a36491
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 05:09:20 +0000
Received: by hermes--production-ne1-7568ccb994-mqdhs (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID da73cafa7d25cff72b3b6899257e7b9a; 
 Thu, 09 Jul 2026 05:09:16 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 3/3] xen/igd: fixup device id before registering rom
Date: Thu,  9 Jul 2026 01:09:10 -0400
Message-ID: <20260709050910.8217-4-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709050910.8217-1-brchuckz@aol.com>
References: <20260709050910.8217-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.69.84; envelope-from=brchuckz@aol.com;
 helo=sonic314-21.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

With the current implementation, Seabios does not see the fixup of
the device id done here and consequently Seabios does not load the
VGA bios and the guest screen does not light up until the guest OS
graphics driver is loaded. So there is no VGA output from the passed
through Intel IGD from either Seabios or the guest bootloader with
the current implementation in cases when the device id needs fixing.

Fix this by waiting until after doing fixup of the device id before
registering the option ROM. With this patch, Seabios sees the fixup
done here and loads the VGA bios, and both Seabios and the guest
bootloader light up the guest screen in cases when fixup of the
device id is needed.

Also, remove unused header hw/core/loader.h

Fixes: 881213f ("xen, gfx passthrough: retrieve VGA BIOS to work")
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
 hw/xen/xen_pt_graphics.c |  3 +++
 hw/xen/xen_pt_load_rom.c | 18 ++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 54f0d54..9e9ab55 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -222,6 +222,9 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
         }
     }
 
+    pci_register_bar(&s->dev, PCI_ROM_SLOT, 0, &s->dev.rom);
+    s->dev.has_rom = true;
+
     /* Currently we fixed this address as a primary for legacy BIOS. */
     physical_memory_write(0xc0000, bios, bios_size);
 }
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 319efca..407b630 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -4,14 +4,22 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/core/loader.h"
 #include "hw/pci/pci.h"
 #include "xen_pt.h"
 
 /*
- * Scan the assigned devices for the devices that have an option ROM, and then
- * load the corresponding ROM data to RAM. If an error occurs while loading an
- * option ROM, we just ignore that option ROM and continue with the next one.
+ * Normally xen_pt_register_regions will handle loading the option ROM,
+ * but in some cases, such as for the Intel IGD, the option ROM might
+ * need to be modified.
+ *
+ * For such cases, use this function to get a pointer to the option ROM
+ * from sysfs. Caller has the responsibility to edit the option ROM as
+ * needed, call pci_register_bar to register the modified option ROM,
+ * and set has_rom to true for the PCI device.
+ *
+ * This function must be called before xen_pt_register_regions is called
+ * because if xen_pt_register_regions is called first, it will register
+ * the option ROM and any attempt to register it again will fail.
  */
 void *pci_assign_dev_load_option_rom(PCIDevice *dev,
                                      int *size, unsigned int domain,
@@ -76,8 +84,6 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
         goto close_rom;
     }
 
-    pci_register_bar(dev, PCI_ROM_SLOT, 0, &dev->rom);
-    dev->has_rom = true;
     *size = st.st_size;
 close_rom:
     /* Write "0" to disable ROM */
-- 
2.52.0


