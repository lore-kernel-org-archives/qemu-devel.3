Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A08C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtbD-0007uy-NJ; Thu, 09 Jul 2026 14:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whtau-0007rr-NN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:35:36 -0400
Received: from sonic308-55.consmr.mail.gq1.yahoo.com ([98.137.68.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whtap-0006OD-4Y
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783622124; bh=RWUWN1Khjj7dJNM0rQ3yGglWM1wDL1ijwxyNMLI6jYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=DqdgcDySsWQn3/hfhqx93w0tMHWTVlJYPc2ZhAOCQPfAMMIoP/uPvJ9TcMh1o2KSDl7zg5KTfN55CvOhskA0l1W7IEcOAJz5DV8P/EGSHkq2w1qAw5OJe5Lw3ZUgvhx1UbJh8oqXFLgz4NYWQvLpgeC6RKS6by8Ub6whBxQkXmc0SBrGsPJ9ep6IhsexQAtYmAhPCKuoWfc2CzvnBZNTCPBgRvyLRz/Kb+hFGsLLRg8F5Ex8oFeEnUTEllKyNFPdQthsMajmBPO4Tb/WF3IUx3X3qdBen7YVYEkZWMOHGWX779Uu5F8EdZ/X2SBmjFVQNO4Y5EEhOg1lyyB1MxZtgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783622124; bh=5qCBF6nm0C28qlJPoFBbn0E8KwxNV8yc5GrA4lxP5jX=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=oj6CFCXljEo5MSL5LpWL2CeqmwpowIrywm5/t97F5m1kSoATKqPVTPnz5n5X6DRxAqQ0yF49KB5OCDpZ/OHAONOqu1ZziIGhqsgB0RW9pWzs2dXbigBEDpZn1xvkyHkeV5WHpD6QpuNIDRKs20GxTqfSKGKggMDgS1Z92bH/7l1mj5dLu6/Wk5ADTzmKF5X/Qf49ZxsbqPEbVRlupr1v56fQiOO4RrP15pHynnZoFmt5I1UBm014shAbM1oJsTx1Fm3wW6L/qhNRJle2aaGRrXUc0TIkdp83FzghIiHcOEJSZYtNLi1I0zT4IwOLG5TORC54qUjLFffzJ3A4vQUrtQ==
X-YMail-OSG: L4MJRXUVM1kVp8VEtv0TmQ7TiWZogcFrMIf7kJDDTJoc.aD3bGM_FLa_204FUAs
 B6Gv4cVOakoVX_sRf03Z04sQ6w2kvCp5NXTEbU_oHO4W6euyUAvHjLKobrhDr1Q_QibA7.fpvJAj
 gEpLw5RdHx5JWh2sOYrF4fUXje9aF47i8D0sYFqgyh3hZTZCDuQebcRk3xB3e8RyCeaHHdnH.qOU
 5hzAGfD2M5.GXwf_hwklG7fi61plwdAMQcSMlmucxVWztU7CQ_cowAULQLSZmzITO3_G6a7MrszK
 fM4jjM1BVxvYLYb31eK992FJ3FLV1ctpaIFyA8oyZJnVir04xkEfcjjhHlzf32XW7XMG4ImtM.Gr
 mXnbiglz8tFkRFAn1tKPhOz1fdhloIrYSaNOipn18zjuTqZQxNvc9bYIwCuSGV0FcYDcQnqmYoxA
 BnUeWQYkdpEqHpMATznCq5OZwpuIZhFBvHAiiVhUbRwzKt4Azr0Qhi.pLaI3J_VRXtoaSwvv6lV0
 oSUmJvpGQUFFIvcuz2vVD3lhXYjXcf7P0oIcvyqwOk105ClfQb1k0eG.FWh.0qbZEnh9ODW2hdzk
 3e01D1u0UA1pfMqJDWsYBMoInDV0n_BKKrv0H5Fpycryp.eEeE8_V0qg83Hwmz5WreHRH0ccPZXJ
 ViHMtu_EaE0H4EI1ORsQFcPyKCDeBmioqPJ.S7cR.9I_6QQY1B8Z.e0BxDE.KNVCN2gVC.DXtGdA
 h61qeUpjTbb2OUPDpjJUR4FrIwDV1lzT_u7qDuPkVct1Rdx3D8wIK1SNbuh4HF0u.AXy3Ii1xYVN
 Q71qn9gduPxtY4CQuGWZXyb.oDXA0H8FhdsRMiZqSilyl.WvbyRXNkJtU.qg6.HUJ6LHXje7aMHG
 jju8ZkaU97x5s56YSB0_JEX4lkA6mOJgr2Dbpq_WiiqaItO.UwFkP8SSVmeWimfIbqis8vOjYRji
 ZngT_5M49Lrlg5ZzC9lf2yv_aqwGwV6IjjpgFIYwqSmc5o5J9myfOPGKp1dg3wdhkcOXvzBg0i31
 ZX1ifnVptpN.HQ6qKt.OK69Ib3gqty4sBM69atbKU_jZ0S9mFtK_CznWwgr.O13ovieijJqCmRc.
 CtRct.vennLz2h2udlPffW6S63ljA9FGOKJ69syHmGp6ZwGWcsiziGDSBSh43rJntCKnj5wGJ5.s
 8zzcpoT1pJMly_oearQMKEAftwYpQaBs4zCG_Sdksw5sjYgUFOAaOZGq0iFvs6XdJVO5hfOZ1Sel
 vccYSIxaZ42nVQBBGyQwaWl4Se2RRHQaXAgr21zNQqZfGcxLB6.Lugw9a2w6SSejA2RAvYAvUOPS
 YolWfFrFE4p3vjRhYrlGQJAilh_5mENmjeSmBw1i0M3qOgjJiB5YhVCGv2d2HceliK_OZyGgrewn
 H5jUxvtunbN97Lt1xyxr1hUAAcLXDtqaCBwaM1ZJwuTJQZjFs3RChHwZpcQ_4MVSsRzX9dJ0oKx9
 8ExgHNAiaArvOWDBBxlRI5w421XWY.my2G2NaJcZzc1HyaWme3SdNFvQ8mmQpgGR9Asj3F6R42ig
 zDcjyXN.Lpadm92Gf0IW9UKDyetiZMwdQVSS_lUZb9JG4fIeCx_9BN.YUJJUD3qwOAhKipB5xlaa
 LsHeYsmTP7Bz7JMTt537YOjPtYohyxpRfrVxGivTy.wFRLEWBxzjRc1jaOQqWf6yaJuJSeTSEBxw
 GB9nEMlmYkqKWWFQhJQYEi.hksmUoaHcpMIPCHmQXQikx3A4g85vWWnm9vPx0ZCHVwsrMsrWbPxH
 QNFX9mH8jDSHo3R9r_8h.sojbcDL3Ie65MuLmu8hjYJSiiEazCesmFIfiTJUd7pdyUDPximjDfiF
 _f9ngMsZteF5jSMLbQty6vLEslG6DUdfVWKEaVyCupJlvmfm5UukyA80KQY.WGLlD8kgzLuLegfE
 168HR46NsLD9x1.77_lOsXCAfKVJ3mdsv1SczGmXCNY2ifGbdmWfbAi_T7hHlzNHr77MbDYHjfHZ
 L1grRi8jhzl2zXyR4IeqPZyKijn4CjFOROUrCpef7ViO_3JmL9lx6FMUAUR8QEwd7D9e3B5m2a7o
 .pW26Q7WsiOkkWapCYMG5T0BsmP7OUX9ANCe_ZIL2BHPds2vUIE_MoAcWyU6nnE1FEpEf1OYDU5a
 o9b.ExeN.sS.grra_SWofdrAOZ0RDwZhan8NnNxgjnzDj0O54EFviAybg13DWxekJiYZQO9KLEsM
 VD7x1wllEcTAM1t7euqv6mh7p.cRSc1m8MkKZz.mY
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 5789bcb1-0729-48f7-807f-e36832099043
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 18:35:24 +0000
Received: by hermes--production-ne1-7568ccb994-fjmzg (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 910e3b4d72a347495c18993f77062a0e; 
 Thu, 09 Jul 2026 18:35:23 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 3/3] xen/igd: fixup device id before registering rom
Date: Thu,  9 Jul 2026 14:35:16 -0400
Message-ID: <20260709183517.25866-4-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709183517.25866-1-brchuckz@aol.com>
References: <20260709183517.25866-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.68.31; envelope-from=brchuckz@aol.com;
 helo=sonic308-55.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Changes in v3:
  - fix Cc address for qemu-stable

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


