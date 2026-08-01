Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B17C55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxQY-0004la-Oo; Fri, 31 Jul 2026 20:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQF-0004j7-E8
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:54 -0400
Received: from sonic314-20.consmr.mail.gq1.yahoo.com ([98.137.69.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQD-0001Z3-5i
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785543466; bh=MtlsR1zLIBzo7DokWP/PBZ1CtP2Neyt/oQv1hSzEZAA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=l2NAnr2ZeOl00G7zLAfZYUgGGgl3bASj4jRKmAak+9N9/hG24pcUM/LzEn1xl4fJMjpfmcW4O10lvFpATFzfX9CpSfIxtRInzt+3HuBZgIclDqkLODwk2pyWHNVYX8+90vj2YMDizy7uAq4+8YT8E+L2LsbsA4zCApdIWya8uXQV7SXi6LiOzWpYAkul/mTRfIIfjducGFC2IwrAvlqgsviu77t5dtvaEjydWtiMDY/SFD10L5fq9wfzVPmpwSymGDgqyVAVC1NkefvikFb7qmsxJGz7dIwosXSVTfZz2nnjp2n1LIDoYf9SETOVXytPLvpYKgBL8ziU2Ib9lpG//A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785543466; bh=5ahFWUv8lvDNModk7E2uOFUzvRNOZLW3kzh0fNuw3rd=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=jO+g+4wGJ7JwN/G8/5y3TWUhOu2HKR7nJQIFCXXO393SFuJqbxDeBBqXBqrGsrFqwWdQOFyUupbAHB1smtjynyOEMHFUJDHF8fAi3ToXpWO1MWY2CfKSXylgzU80L2OjI5f5sf2I3iscHYz6y06UZ7q841cp9qKyA+xxUy4EDnCjOCmS9DSwOU6xwdg6lCzQbjxD3wWJAeJGryRhxTXUVF++gV8j8vAOBYDFKbMAbyQhB45w9AFcnBvkRNgtwPvtn/+TuRte86J35QG2Se41UmlkR5NxJOn92kuXBWh32mlbWr+ZSBjiSoae3gY1JjBsm7HQI1yfNsRLS342FASJtQ==
X-YMail-OSG: gT3lLSsVM1lm2IGDDEANNWhuhXhBu9oXnaJGyZ28aKnJKr8IBok0tFrcXySMacJ
 Wpy9JYTmVsUvpQ8aYqe2.J23IobED.xdg1MZV3gvbzI1KpvLzxoLL4mCVb4DKGv7KSXc8gnChmPu
 1lxcASxzyA0sPTMnFzfYpjWszTKVYJMFikJE8SgHKd8KjX4w8YrZNDSqOqqQhldD41rTH1WabT8k
 rAwvc5yDLXQrpLi3W6SmZIXE0vk_MKoeofkUxq.2lweeWKh0nPMHaNpaLWa_4Q454aeKTHcJfFpB
 ttWNOc8zROh4OpEcIpBnk8KUO15Wnrfh.mKGQygjM4OibeXITow7gQLMBCIFSE7HQ_qXThG27F1j
 nauoZnIdGYzGDbfiWn4_cXwiaY_pS1BlUdc.NXkxFKEaxNvr6K56RCTvbusyfCjb8dRTHf9OJ4_j
 cTFTLyl8Sqh0FkILwA6h_Vk2BsLfolO7GKt9ByLNiEMGbSvt_A3KjxK7kWIJYtCBu5GCGuosbIpN
 gmj53mxvsUy9W2DCTwZX34NhoFPd3eJHqngAz63f0Dr3BPSszz09c5IlJhwBAx9I2itH8IwCnRcv
 yZRMmBEc55yUd3EfmOI2VvY547FoZM78Z6zNrMrJKQUjIagiDwecjcJGzVt8eMvFw2m4aHYT1lyC
 aBJEGVA0Qjml7LbSX0yOh7sT_5posDSWxWXF0c9cip4UrBTHZl1WBWYobgSnMkoqtOQ24D7HWL3t
 1Om7bSfxfTR3yrQmcnfxJdgPsrRRxSTzbMf9sFtiIUJ_flzInYb8QkJPpoc7WIqoSBHVSsFVoqRo
 O2a0hT09iMgfD6MOpDRnUt4RPLL44TbKGk8XQuJkNRKeN799Nc_bVbjFLy5rKGMm_1Wh7RodGwxu
 rN1EyHu.rr8O1INZHiByuGvABdCX4vilBQoMv4vChG38Eq7lm6SYdGh2R13AqxZDI9Gx1DGXEdon
 hwd4LYsQdPd5dF_fpAyDNCVYFkWaPqafaU_Vz_wuWXelKMLenYKPOpD40Ja1tSibmKQE9ZIjZSW2
 FsapOInc3CvAZ2U2asC_5lZ1DWTR9DyWaUjXFz07U9_2EugKeWUhbgRHJCtorumWZ_KdYhTH4OYL
 .YbsxA9o2UNkf1.Y2ujdYftI9HXIjBYMwhB.C2KkrWP.KeC4DAoX1Gx1KndPHdBqnKal9w0KaS1I
 7pf4ci95rtbrbPZI7pZG.0nie7xzsqRiCz4INP9QZvuDPZ4v8f2ih2bvgF79UrJAGCJxtafsTqaB
 JD94VsldUt7F5vmmJ0iI9izuhKDIwz3Zkyd7Vpv8gy2kXa3MssR_ug5AZXejSTJgk4Pk1N3plAlA
 z9u4x7IkIBC7EegRl.Ui194iSJyTIPXbsHcwX5X_hgl8rXLXf0eBlsqyu4ImHJdHEXAP9Qpdkk17
 hVxhgafEeea9ezfJp_mg_ZMj816YlzYRy5q0HcNxE4eCEsvCVBafjwUntw57jRRnVN8UncBaUuK0
 Q6WlHBUf9mmdic4kMNsUeJp1jfyuGzBVRBTDBRgPsffORyY9bdULEzDk6gWp2UGEMZH13i.lBGn.
 YD_weV7zsyPqLvIRT5.OZlw1nJhsEMdW_INz6Ac84UfkDiLiWwOXJ.EQQDDVvFyE_ENEs3YeJ4jh
 PmSeGB5Mv7.Tk27.g5.3jifhDFqD.I_ZEXb7NOnhb1h1Y6cuK23b7UOFbKIOVPDV4.bctL3g1aS8
 2U.bHN12X78Dd9jJbRZPIDpk1CLbHct3s07fNRsstwCzM5xLi4UDq5MIhybwcbaEKyGJ7ymjLpNR
 uUCg3w_yavzfJhp093mXaYFc87rsElWqoHj1DVD9LIwVMjZgz8p7UUbiCzFmgt.Z.UNAN8Kf89Uy
 YVwu.jSF6yfBGNtT787dxQ.cQ1JnZQzp3rXVWg9QdV_HctWMub5SaxImA4P7Lu_KuNNoFCMjKMWR
 0y1ISuOnqP..R7qlIxm8epK5vevI6tTZAINDhOrYuCGyBB3TX1PlUT_v_a.HbbdT7ET2YQ64xHsO
 _4XrEdrpRwLGZ1fn75OR6fYIFKA2f7Thgg06Pd1DDCjZ_CWOOrRp8oFWal5HzwFoK4msQUpsf2H7
 u3dg03h1mBhoh4QCl5LhvdD6dSDTvZnGj3Q79HX63z28mbEbQTdO2o7WnE7d3uGv928dKV_xq95.
 UW6ecAcVE8OJPpxL5F46pheb8Y6wWfl3ZXqh5ujcRDNBhu6ZCsf6a2PyfWQf3R799tN1uKX9WNki
 oO2sif9h.FexmR388UyMb3axdpXNZg1WOlfx9F4KxaIgOlb8n
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 6e72e470-4730-41e5-b846-8856782acdd4
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 00:17:46 +0000
Received: by hermes--production-bf1-54b5569bdc-h5zdx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 655a093bcead2c5289eeab02aa189b76; 
 Sat, 01 Aug 2026 00:17:45 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 3/6] xen/igd: fixup device id before registering rom
Date: Fri, 31 Jul 2026 20:17:27 -0400
Message-ID: <20260801001737.16509-4-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801001737.16509-1-brchuckz@aol.com>
References: <20260801001737.16509-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.69.83; envelope-from=brchuckz@aol.com;
 helo=sonic314-20.consmr.mail.gq1.yahoo.com
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

Fixes: 881213f1b9c5 ("xen, gfx passthrough: retrieve VGA BIOS to work")
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v4:
  - Add a Fixes tag

 hw/xen/xen_pt_graphics.c |  3 +++
 hw/xen/xen_pt_load_rom.c | 18 ++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index b37f9b7..0ae95cc 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -223,6 +223,9 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
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


