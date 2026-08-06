Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54963C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrmYE-00026B-IR; Wed, 05 Aug 2026 21:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmY1-0001sA-P3
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:27 -0400
Received: from sonic302-20.consmr.mail.ne1.yahoo.com ([66.163.186.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmXw-0006ML-GN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785978316; bh=obmks52YmrFX3M/nOgH2+nRuVRmljJ9a96OvnoWzDN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=kh8tfiI5X2mLkXTltEf1/TcNAbw9dHgs2OXe6/Cx4f4Q2W6aW63BXJmSVUGkINreNcBD6FfkTh+LU/PZ/9ev/PPDIhFXlLEd5DF9qRH0ZT133j+EbvArqqLxdVG+CIYuBgZk87zNSAMfhBXeGs7TSvU4iQ0b4yTmxYhJCWMf35Xml1JursLU3YArBNZcnq06L792aANSeBpwycj45QA+42ABhE6pKl2XJwrrvkIHk/+NChuo4QrpzNRevFVwGoi2dY/qKiLP/Fg0A01edPoGhgAltg5IklPjIt6jt0yDOfQIw6DvU+RedQcECB3yfm/w+fbWJHmTkposNbKtQ7sIbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785978316; bh=ck6kJNsZA5u6QunEVrirntyEJVzU70IKy2/Lw3IfRxB=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=seq5ZWIU5B6NV56rwGUzNRaiukH2pxkuBSHwIm5hFen4SIbMRS3ENPc4ZC5HG2zFkyDfYw+7H8SgJRr8ppyKspt5c+Xix+nMCLvw28oKcc+qUOMrrHWN09oRUtkmmAJnd/XsJ3R1cMJfqpVOSod/yacHuvYk/tzdQjxo6eU3r8djSoeeqOafayIiIcOgA8ANaGsxDIXI7j/YROY1dwuE/R040usL+uXjv6LQw5SXXEj1WHC0RVMJsA+ywcVHL5/YauFFy0VhTSVoYoM0OWCoRj4+bTfpDPzi1OzLla8XfeEAJuA6vARajc7CRv8mjST5gyrGsM6n7OYcR9pwZ77J5A==
X-YMail-OSG: xe.__RgVM1l_hd0jAUIpXgp5HdcGo.Fg7qzC5hEqyLrEB6dmqcjtO7EnO83gYOE
 GdoUZIRcPl4682QnmcoLQDxFV1YiOxV7z10s9oiJciW3.BpnQ.xl6Lgs.cKFe9DEntPnhVV1Gflh
 R_vv_v5VsgTOgQTjb02wbhR7BaicgKG4m_5NYp0e7azVnegtsv2qznQfIXSZ49zCpPeVnSGepg7O
 fmpu1czhJ_Biamcu7HWQvW1Mtd.8RJGlHchC605NeDSR9t5VDe3vg1HrWv6DLy.3QmnAd39n07A8
 .lKFqgozDDtOnri_pthmomKAXEiyEMQ8YkuspAETr67CtZR3EPi4SFc1msSD_8jcVPmqbtmDfIph
 7b9_3yAdy6DCPrEfW4w9UN4MmRDCN7KcczKHG00eYBhCiBxrMlqEJ9sK0kt1tnO3XlKQeGtgSIIN
 wxAeuf49eyyqYUk.OHveIgmW_6luLMJOVxafp6gmx4XMS0Vlguc1Xwm.Z.xs._NrbIEU2q2mKpCs
 y6seMDNYU.ktsDUDJfy.ceAatpCRknL5pwf_0R_p.btzXt43FIgg5e6RMFfWfKgwKRgUPlgIby3y
 tgI0QlPDRbyRsnRDa.kY.iPAvTPehxuTQaaBGkIL6hiLSI72.0tcgw6x4Jr.LWK18RS.GBg5OnMQ
 6JkXFbN3o.3YnKpKn2dioejzpgeRynZjC2o7y7Dl92drO.vdx6CHRQcEbVd8drtKjm16la502FUT
 xpAHW5IV9UCFOnyHi.MgIPUWKe1umqDPnbR3G31N1_nkIfSOqq7vKk5ke0EOOl4boXYe4gEPtLK.
 qcKeaSTJ4c_09WnQ9MC7R4DvUNJnqiXVMnJhncNhtZmdqvimtpw1kylQWUI4F7Lh1WlDHZdVVN6h
 pIO4ToiY3hi6msThigvzwkitiS5EfbihvX.ZRiVtw_OiLHQMtiAn6mpAsAjdHpPnNhClY8yOfUzu
 DzJZpcZvl0_N9QI0lTTfHoScNd08JMLERtnCJRwnR0UhIPQkVYRlRaL1iEBQjuDnjx4ehaCKgmky
 q.Vkq1.5lZAzuA0ERmMyV_YpQHn2h5qnNW.B4Jx4RaKF6g2JTqaMmgn.tW4nus77.m.PNufImZ.T
 UoYvMrVqEJfEWHgS_B6Vh8d0OJAPWHz24XFfojnZzjNai1NMg22qc7TWVkA8uliZFJ2_Lz6vNSb2
 o1eMIYhugUrWwtaTUp78PY_BMTNclTpUHZLbIuF.XTz6Y6jrtZRjJaGcykPoBaHBWUzrIer0hxng
 9Ob7D237hExdRe9MHXd6bofsbaTlAiX4LzcRY6lGqp7JTAJDgQhpSeAtBE11UbMV7F2dLYKjdCB8
 kWEca00akBqg1IRbrp5MrzWZnrBKo7uqOH5vq6bjI_3RpnAycNPN11y02fmTv1Lzy6UuOMzeyuzR
 VzhkyxTLEMcNW3YqSZ3ZUTO5g6soWx0qu8CyL08K3.NvQTtDp8SBA9xRNJsunYksk6BEj0et1cRo
 dAzA739pPjyaG_oe9GgxB51kGjsfsgKNSkbM7eVQUMVmaIXToUsod553kFtJeIF2cLI1ZxtIrbpx
 rFtcrTKYuIbgmUfzxhstYUPtwFc.WIwNpFeBxzmsrikanf6LgzEakFK0sOn0u74SKYVyo4hvx1No
 eJZZ02NuN6jTEhvLoeTGPcLXcIVuueouRMUmOtUTRl9DFWvxpXahWS_hFhG1DRv4Ocycdp76Ywoe
 yVrQFO4OgRA_hewDljdN2taq7UP0CdkUirC7viQW9zPqdselF2hmN5zVP4boYIQz4tNufX_6FiBW
 vAP3XMiAnLXmXKBfU76WWUnbXrweMe4p_1TbsRcLodTHM8mrTor08pcS1.CyeclPwZZNe4Yx28Yg
 nyYk.DXoWZVX.FK9180XjYglAsD9HADqsiFeEVeQRqwuRTvYusctUptH_QxFWqMWG4l3FylIGUxq
 Ix4YdzqAbQOYT3i6YzrJygMfnKTskv7P4c.or6wbvNx8sXcVGQ5JHXweXIofznjQV_cdPh4Xo5hb
 YoYPZOOYmlxpFqCHO8QLyTGnCLSb5vgSjfQSHv6JW4cfmxMckt0B9Q8my7dPlHWYlbClCrUtZEBx
 PPY5Qk.SqfKiJCeGurO3y9X_Kln0_kUTQjRdaW14c2zavvGsmIA3bFBeDSNAJvaDRV1DRBUEqgDh
 h4afNOjFn7Oc5rmYt9ev15A3dYURu_esAZ9nUCCyBYkrEQ7at0wsBmIx0Zpelci_jnqmVAwxWS._
 dFPtE9kCgzMSlHNYsqg9FDG2Odjjyg8YUroeIQb8-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 446e3e3e-5ba5-48e7-8e09-de07860e2ac3
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 6 Aug 2026 01:05:16 +0000
Received: by hermes--production-bf1-54b5569bdc-xjdx5 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 734f0c8329adecc00a98ec91cc943adb; 
 Thu, 06 Aug 2026 01:05:14 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v5 3/6] xen/igd: fixup device id before registering rom
Date: Wed,  5 Aug 2026 21:04:53 -0400
Message-ID: <20260806010506.492490-4-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806010506.492490-1-brchuckz@aol.com>
References: <20260806010506.492490-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.163.186.146; envelope-from=brchuckz@aol.com;
 helo=sonic302-20.consmr.mail.ne1.yahoo.com
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

Fixes: 881213f1b9c5 ("xen, gfx passthrough: retrieve VGA BIOS to work")
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v4:
  - Add a Fixes tag

Changes in v5:
  - No changes to this patch

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


