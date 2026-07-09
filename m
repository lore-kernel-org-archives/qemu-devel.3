Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F474C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrSc-0005bN-V4; Thu, 09 Jul 2026 12:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whrSb-0005ao-J6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:18:49 -0400
Received: from sonic302-21.consmr.mail.gq1.yahoo.com ([98.137.68.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whrSY-0008IC-Lv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783613923; bh=NjzxgWYBhBDPccqwhPPakgGCHJbF/Oi59PNz/FTey5U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=PHuO18g/I5iYnOfQIVSRLWKyeo2iCMloTvx5+lXG2qV0bULcTAGOI4OmbCop+ztt1cRcMXUkCaw4F92WaYZ6skoYHBqkVBPhSTWQGuoYNGRqBnUA8Y3Jhrin8/38jaY+uctg2GGEfaCo4jGlghMwtD65+QBMIBSGVuQT7YakSj5WEaq408JZ12G+aNU7FNIs81OA//DO2Heockdg0U44MqTN6SzOjse6bo4LmxPUOczjhur8phInLkWOhTawJvGwCZLARMUK5ES57v7nSzxNlp8nZT2ISTdB85pt4MCTvH2mQCsrLcvo46trbPSIoCEIdjm1W7PFXz36wFu6U+Vykg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783613923; bh=Xl5UUP6heRHfJ8Onch0/iWYn1uKw2wGFHWxnlLcOHDy=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=bOMMEcUh9wmtbT18lfuP/P4Oenff5m9OfyHPwnCrye51v2jz/OsWRxc0Mwl5JrzBl3uVRUAHJT/FuexNMTg2I4dTgOMnd8nbgNs2gWoMJ3SOWoMQwZjK/+QH6inFgQ5QgHVE/UPEct0mfQDqyPfJoeYlobbhpi+MzcyGQEg85UOT6GAc/U4Gk+tUfJN4GR9BzLyOpZcZtwch9ZynVNQfuhiORb2N0il5gtlmtjt0ArU2Murn99xZJYHozoVcBtEmvIDict37Wgk7enOVeQNUu0+speWE1uRX3mBM63omRz5jy1pO4Kq9M6oh8zA+wrpWP5IiHZSZ3Lks7e+5crtKdw==
X-YMail-OSG: 3tIgTM0VM1miw.Bg87GxNRNIZzn9cSlNuAeqHdxBMPeyQy5imEcADUoBcuuqZCX
 5zBmO_GgpZLfDzpDLqzCoDU3vAFnYArJutpOkmFzxt1fcZxbU.3RXwT4hhOj_lHrIqrGXz4MaX81
 E9Al13md4pyIq7ag0QGfSuWQUaEMi3RS0haQk8a.zMV36EW.4B.BlMRYtqQwItY3UJXunxAmkiQ.
 SSFFRQdBduyKdtgcJjx67V2Jut61s2Dh5_CgwEEyvTuaNo8D49VRRTfaiieMQiUxKJEFWZpDxHgG
 ao_qtb.T7Am3PXA.2LTxxAYEQBciBIUDvfCzmQIcu.Q12VtAOLGTYl1bVnSyRXYeJpuO9s09B8Gz
 sCng6NUWZMmoTf1D67AILE8lk6Ui5ifGOsp4wsw1CRrfKbdOe.edKucYDrVyutq_0TB3YMZM.c_d
 CqnyNGFHiNa_7vV5jo3xWjTWr2a0DQCWF4XpOETaxL2JfEP4Aw4IdzBsYVASO1VROxXe590C_j4k
 ZiTlsfOh8OrELz48vCKp5L1kgpM7_hStlvern3hPxYQ5VzX3OgQiPar.NmSC4u5bPSdQ5Dx5SldX
 z.dPCnjN2b3uSY6lcvCLMms2OhscfCAAuA7io_4fPCYrbIl0QDC6GEB4BassCX8Oz2zimKPGLuYF
 d_c_pqpWzSwitZ79zCG1nzsI4FvK7zuOs5PPV963jvoXe4ocO_1BBjl.2.V471KC.hw42GNNGM7j
 HlCvnwp2fcLd1EFSxfIVENbqTR5TQUaL6oVjjzAUabk0UdliHJrWdqIrxt1OafhtO3aN4l9FvHL0
 iuxe3IwEh_wqK0B2TSd7aqfClxuynwfFuGGtZlL7v2OazH7Efb4OSFYbPEGH4KvmwslUQBUjtsUu
 vNuoFT42WbhzPAtClEmmcmMV6GOYrBX6G6pqA1rGiNhkikwg7j.7KBwhpOchU3_uM.VZR.hTivDz
 r7foOuX66QBECLloyT3_8HdnSVRlWFsF54FYcx0C.cF2jDHLsUoBkMQ2yyvzHP1Pk0r0nAOPWn__
 jGkDFM4928kljPAknpV6kLCJjsv8wBBd24GzNIjg3SLGQGE0p66mwsvdOy4gTgQ8q7t.egSRdRkj
 4JZxpKq0oB8XRHkpJ8l1yJr_BaiRTbmXiIYrtw9FYOWwrl2jT3hRLmUqgklRnbbdfFW21T9HWOgm
 1ORAroEFkqTz3NTP86v_ksyZWm.2oIY2.U7GR3QkWeczfNRSDkIa8Oh1eRn0io0p4JT0QV04tHqt
 ZFmRGQkb7doizInW6kiOEeoJStab0_TrUT1X_8TWEatZphieOrJjHyYg3dqYSR7uLfJ1Q0bZxnZz
 CfLRgi8UTx8WUutJJaleCXO6VemvNpIV9xU2sRna5JVlKjtBoyqNs9vGDUKIu7il3ulAgy.y06Ov
 Lu2yE7KefvztYOibRVCG_mE8k9ouP02TOZv3Fk7OTbWom0o6HUCBwEFLJtPyqvpRYdB73K9SlwTa
 EoJdUUiIeBJLGnoszHA5AVzcRmyUyPZeJLA.uiuMyu5.KiPXglYfJkRiRbSBducJLJbIInE_5k7E
 juakvPbVXNpVvO.Z08eLK9kyMEbPqggLEYGHFyLXEgb6N.MMaAjf1p4vfa4b_BKen_ZJ0x1HJLRt
 5nrP9XO_GPCpGM1LltX3gf.oSigI4oF5uLyAOvCaP7jpT6AZbDcR9KAYWmaEWcz7su3.JdUICMdr
 C9l12xw3hzYgDceYW7N5tW.lSsu_BAeCtk1qzXaWWjHg9HjLodMbg4R8mQWGfkgxPcgRimx44RAr
 AdcJp5VMnRkXEF0azSW8Up1DeSGyg5Lhy1mSCV17pUEUaKcFAX7K0t2FfS4gMGJZwDy8C2q198pQ
 FIDrb54I77XY262fywuIgRLOjqQEWig7sQn.pUsmuJNM6YNCoY7NDKtQABKcDKxEYhUiTVf8XrSf
 B55sBeennmKettCkvnCIglv2FM5nsUS3lmA8gNeG4VkNb6_yxwo_cIZNmXP5g9CcienYPljsedaU
 wp7CXsU.pR3kmHKQoFO_cgNQ4sB05fdI68ipOHGDkP4zI4bw.V7u8lpZzYviE8htqFP9FHZEsH9g
 qw2BAxn7NKgWtbyXFqgy_tnV7mYjpmHbo4gk6zBUCIzEMEu7GSCLyKWVJk8fhh9HZG5oWtsTtgs4
 AUK8SeO_277aLrjCNOa1.c9UfanPyi4GFgsBGH4fRlhy7N8WQeZyj35wsq03qpBqJU3cLqj1PzLF
 EMKPt8xrOZmytqLq0Liie6UHLMF4XpTGcyTLnI7O3
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: f78416a5-1708-4bda-9a80-a47dc8b7966b
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 16:18:43 +0000
Received: by hermes--production-ne1-7568ccb994-pgg8z (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID e91c25460b5bcef5e32390743f7fb9e1; 
 Thu, 09 Jul 2026 16:18:38 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 3/3] xen/igd: fixup device id before registering rom
Date: Thu,  9 Jul 2026 12:18:31 -0400
Message-ID: <20260709161831.17753-4-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709161831.17753-1-brchuckz@aol.com>
References: <20260709161831.17753-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.68.147; envelope-from=brchuckz@aol.com;
 helo=sonic302-21.consmr.mail.gq1.yahoo.com
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

Also, remove unused header hw/core/loader.h.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v2:
  - add a period to the end of the last sentence of the commit message
  - add stable to Cc list

 hw/xen/xen_pt_graphics.c |  3 +++
 hw/xen/xen_pt_load_rom.c | 18 ++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 2ef941e..aface0b 100644
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


