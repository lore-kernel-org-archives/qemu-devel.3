Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDFDC55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 05:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqORC-0005EI-Ko; Sun, 02 Aug 2026 01:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wqORA-0005EA-F7
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 01:08:36 -0400
Received: from sonic315-8.consmr.mail.gq1.yahoo.com ([98.137.65.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wqOR7-0004Ja-CA
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 01:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785647308; bh=qI3cvxJkB0wST2pLg+kJk+H1/7OsJAYv2EoXvyMCIBI=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=dT0rXBUgs0mgBPCg8e+PeGnZbTqg7eRBYBxXIk10d911DXOTsGqOt4TVAEErMU3TKiNtcmSe/hmug7qGSBqMhId+lUbg1fhmYIOcKzTWw6jQfNuewFWvSLdc4rQe2Mk6lzIpkutmP0j3pxbydnUvXaxKdFO61ocJS9EGi3qnn6hb2o88hRQ18m1vHuxTT2o0AJ6SSVdjxas9OCj1ua8ajOp17zq18UIijLOnwZSkxZ1p2bXnbPsa01OIb8PqIMA3W6DNGn7eMNVsVZQLEFMH+eSnFQuNnSikHAnCB/k//h7Su8H/5YB9g8/EuhCuJ5SKJwNWbbols0a0LAw37sR+2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785647308; bh=55uMRXMxddGSCqkDCycETdUXDjoHOP1zl/jTH9nPnTt=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=BWVg2F3ISOn9a+MnZ7gd1DX/vCZGKt50+SzK17C4QUBrjBODaLUBSHqzdvGqMRwh0fnbnhqkjuxo8Duou9AeAJu3dwtbPOvxAiAPdc/T6dbDYFx8qWThgnUhMoF4A1HsN+SsZJWyfNYQnh6Durf3XwcS0zO2/RyQdubS+62U4T87tmO9h7vF7vkBGWcz9nwlS0yS47U/xlCD3H+eWsa+VL7ESTg++kgAK15YixDUxvNX8aBCvFBaOguX/SUxiWItc9wrbKCKw8qSdxsE9JD2VxBtn3P0Ix8jqb4rX2XlbHI+ghcH0I4v/dDqufOIsQy/BD4rf7l2Lp1YqrMkmoHnfA==
X-YMail-OSG: KwRT3NkVM1npbbUkdnGcr_aHoBT436ZNTELI4trj0hzZgfcNEtANa_UFL9s26Lj
 7fmfhx3YG6uGFZ2tShgSUBAjckUWfJzo8MXPckMbLGfzAUrpl60Kxy6fENxqUOOLrhFW7AzHGfAs
 nyfr30VnnVFwsyClZPVDhFQcCorqlkom_vpX9OSdFYtRQfOGBdSdTDHZat5NWUwd361HhcQRPtnK
 i3CK5VMOtqwhoLsIncOBUgpxPeoil_y2Pf9WRHNe7rAPLIn0QB4LIu94fLwhKntnGpL0Vlv.DD..
 3LmL2QrT.h_KIxXlq07ufwHYe6isKly654swXs4GCSdD9OxE_pgjUOf4hkA4fH5cefr_VoMTbHj0
 Esa9aydO8CrE52wVGSfRNX_QwgIuOqyYCbn.B9505U8Jq_1vNxQnPHXzlkgl.nAoadbfF0wn5dqK
 3nVmdRW0WrJG4ztjFNS5UWR7Cc5IRp3wSZd823N0uZK914Q6.8DZMNHGbmSfaOfXav6uAOJlGhZg
 0dvM3MQXobpcX6QpmWNrLYUuGJXvL6totqmqtghxH1MStD2C6zVGsmDbEJ_DLBhVv1TWz94dVUEJ
 _2_mCaXeh_CepKFIkh94hH2bGkyO25KaLUK6hp9zXHXoVTLP2NZ6SvUJAdiHCBJWhZqiH6YV1U98
 hd85CSdyZtMKfhQsPkSMZp8Dq1bmyxmnY7pAsFg.2PKZ8vBPugibTesKOEK5n153X6dDBd6Ytkm6
 .tTBu9sL3lMQWVO5h_DMtdnvC3kM84DAEnrl0sCg8nDn58XOk7o4cre_kiClCxyhLlAnT5a67rlD
 R9PoeXeh0Co_pzDKCWHugjob2asMQgoGI1qg4_pZmVKksAzAUGEE8l_ncdu.9npX4Cc5pSj5nfKx
 m8__ZhWVpDGfbwvt5zSZgWXzz7_syHU4kRZqW3P7gNeGY3x8l2dVRiKLRoEa.C0HkBbGyDEQVrSV
 x7JaYO9HVVRKG6qQHrUncL7NimDpjaz0hJk7qlBZUZBzh.xL5LF3uz0tnNf2vxRt6t.y0YjjwtQ1
 PYiaL8IaKxeUpc44wDydcDYh_0J6rX_DFCXMSU4Rk7O33jRxHBkuKWbV60bGCxBLM5lOe.P_wGIZ
 jVITAM1UnItQ2KOZFeDvjK7nR45S7_ZZWPBl4JW3kHdrfzDswjGQ8LbmlJZwb3ewLjtRzsikx3TW
 BCxjzN7M2.x.OvN2WYVxX8mtAWcPNF8e731Ob1ADKak29X_scdRWxxwGytfmhJvsK29nNDTayhlE
 4uuJVb.OfFRrTudknVNgT1L8jqDePs1jivsxui32zmtjUW9R9rT87FrKyJgeXUK3CyUi_OWEUV6c
 IOHu4Q4CDEC7a1NRvQ5Ifr0p7uAh_drMzHWUYECaOu4C894.h75huHzBYc969x5h128NahwGi9XD
 mS3DpOZ1EYK1UN5PmwHStXa6mi69FkcpWjWQRviMweXQxK4J_Ek3StkRiCFWiOUlE5747ItHF1hP
 ThKfH7mGCvhNxshxhfr7AlqL3Ngixkqa6xQpUQNvZWKU8bo3MxSd_s80tuJpsFimPKXtVbM2LgCG
 oNrRKChYqHepvX8SyZonU0jz.90ieAq.mU9yAL2q9gosx4UgsKk7BBiMrCHqvTwL3wnQHiVdUEVg
 knMdwcacNS0PI.f8APr4NGbBJhMuUgUr1m.yFMjA.mybqKHYqP8bzeEBuByV12K0ULqVnnq.AUoj
 1d25kHVN3IZ_CZcA0a6VcJUzkEbgt6NI.nYxyrL9Nx4CUW0a_yc_xMu4MFYshyoChyHEL8nuaBQX
 bLhJvwuWYFcowUxhP4MJcZ34R7z5FGquqgUJh7qzJyWNePo.Ey.JaNrtkH96XOvuM30OiWrb1Fvk
 csU8UxS6CYlLG896VmE6kk3deZHMq32g48JkF_TEvwaJXpPxgGiHS6m3VvLLoKrYPQu0hYKgyI.K
 ISDGQnwgKxREOIfFZfDRV4HVQJHntNG6SpWKlnOkZ1e.klDDdiRmNu7WpoPfMw5MsJOKpERfc4Dn
 EtOmj631iW_As7dXP_LrfOrt3ebAzPSu9QvgmtfcwwyCAaH10pOeAtloJf74ZkJjhLcLxX_9_JEk
 gR._XNKQ25kzUWLmh_XUx074ift5LfdhDj3RaE.WZlVWPzzyCGbarfVR.3tf4wK5CdHTSDm3cB9m
 L70llLWtuPn0MhQO9J2PfuG7.X23GeDMbsxkQLvDSb5Qbgq7oc5NRMWSzi5dwUMMjDG0ib1Im8Bo
 P4h1bsZgsK.Nx_PDuimzvrP3Bdav1xVmQl1xV9ZKFHIgpKw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 102b02d6-5502-4279-a553-a5f20c7f39e4
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Aug 2026 05:08:28 +0000
Received: by hermes--production-ne1-6f6bdbdd7c-6qsrs (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 38873ceacd7487424d36cd594a4ef84d; 
 Sun, 02 Aug 2026 05:08:26 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org, Jan Beulich <jbeulich@suse.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT support
Date: Sun,  2 Aug 2026 01:08:10 -0400
Message-ID: <20260802050824.10554-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
Received-SPF: pass client-ip=98.137.65.32; envelope-from=brchuckz@aol.com;
 helo=sonic315-8.consmr.mail.gq1.yahoo.com
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

Modern Intel IGD devices do not work well with the current
implementation of support for the Intel IGD in hvmloader because
it lacks support for an extended video bios table (VBT).

Code 43 errors in Windows guests and failure of the guest screen
to light up are some of the problems that occur with the
current implementation.

To address this problem, this patch implements support for
Intel IGD devices with an extended VBT and OpRegion version 2
and higher which is required for most modern Intel IGD devices.

This patch also depends on compatible support in the device
model. If hvmloader detects the device model lacks such support,
it will fall back to the currently implemented protocol for
configuring the OpRegion to provide backward compatibiltiy for
systems that lack a device model with support for an extended VBT.

Support for an extended VBT is implemented in the newly introduced
function intel_opregion_setup() which is implemented in the new
file intel_opregion.c.

Major differences between this implementation and the current
implemntation that only supports older devices without an
extended VBT:

1. The current implemntation reserves a constant number of
   pages (3) in the E820 map for the OpRegion which is set by
   the IGD_OPREGION_PAGES macro in the current implementation.
   With OpRegion 2 and higher, the OpRegion can have an
   extended VBT that must be provided to the guest with the
   OpRegion. This means the size of the region is not fixed,
   so in this new implementation the IGD_OPREGION_PAGES constant
   is changed to a variable in e820.c, igd_opregion_e820_pages,
   that is set to its proper value based on the the size of the
   VBT. In this new implemntation, the size of the ACPI NVS region
   reserved for the OpRegion in the E820 map is equal to the value
   of the igd_opregion_e820_pages variable instead of being set
   to the constant value determined by IGD_OPREGION_PAGES.

2. The current implemntation provides the guest with access
   to the unmodified OpRegion on the host via memory mapping
   from the host to the guest. This is insufficient for
   OpRegion 2 and higher because some devices will require
   modifications to the OpRegion for proper operation in the
   guest. So this new implementation provides hvmloader with a
   copy of the host's OpRegion that hvmloader can modify as
   needed for proper operation. Mapping the OpRegion from the
   host to the guest is only used temporarily during setup of
   the OpRegion by hvmloader and once hvmloader has a copy of
   the OpRegion and the extended VBT, the device model removes
   the host mapping and hvmloader configures the guest to use
   the guest's possibly modified copy of the OpRegion instead.

3. The current implementation lacks useful debugging information
   for the more recent devices. This new implementation provides
   useful debugging output from hvmloader, such as the detected
   host OpRegion version and address, the values for rvda, rvds,
   and the guest OpRegion address when the guest_loglvl is set
   to all/all.

Link: https://lore.kernel.org/kvm/20211012124855.52463-1-colin.xu@gmail.com/
Link: https://lore.kernel.org/kvm/20210325170953.24549-1-fred.gao@intel.com/
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
The companion patchset for the device model is available here:

https://lore.kernel.org/xen-devel/20260801001737.16509-1-brchuckz@aol.com/

There is an undocumented setting that works in the xl.cfg(5) domain
configuration file, firmware_override, that makes it possible to use
a patched version of hvmloader alongside an installation of unpatched
upstream Xen or a version of Xen packaged by a distro. So one can
download the source for one's installed version of Xen, apply this
patch and build just hvmloader and then install the patched version of
hvmloader with a different filename, such as hvmloader-igd-testing, into
the same directory where hvmloader is installed (usually something like
/usr/libexec/xen/boot) and then one can configure a guest to use the patched
version of hvmloader with one's installed version of Xen by adding a line
like this to the domain xl.cfg file:

firmware_override = 'hvmloader-igd-testing'

The compatible patch for the device model is part of a larger patchset
that fixes many of the problems that currently affect the feature of
Intel IGD passthrough to Xen HVM guests. This patch should be considered
as a companion patch to that patchset for the device model. Do not try
to test this patch with a real Intel IGD device without also applying
the patchset for the device model because without those patches, the
guest will most likely fail to start if an Intel IGD is passed through
to the guest.

There are different requirements to support OpRegion version 2.0
and OpRegion version 2.1+, with support for OpRegion 2 the more
difficult case because it always requires modifications to the OpRegion
for proper operation in the guest. For some details about OpRegion
2 and higher and the extended VBT, see the links in the commit message.

Changes in v2:
  - Correct the name of the new function in the commit message
    opregion_setup() -> intel_opregion_setup()

  - Add a link to the companion patchset for the device model

  - Describe how to use the firmware_override setting in xl.cfg(5)
    to simplify testing of this patch.

  - Correct a logical flaw that in case the size of the extended VBT
    is <= 2 pages, an extra, unnecessary page would be allocated in
    the memory hole. This correction is in the intel_opregion.c file.

    This code:

    /* Update the number of pages we need for the E820 map */
    igd_opregion_e820_pages = pages_needed;

    /*
     * So far we have allocated vbt_pages_needed
     * and we will likely need to allocate more
     * pages to fully contain OpRegion + VBT.
     */
    if ( pages_needed > vbt_pages_needed )
        igd_opregion_pgbase = mem_hole_alloc
                              (pages_needed - vbt_pages_needed);

    Is replaced with this code:

    /*
     * So far we have allocated igd_opregion_e820_pages
     * and we will likely need to allocate more
     * pages to fully contain OpRegion + VBT.
     */
    if ( pages_needed > igd_opregion_e820_pages )
        igd_opregion_pgbase = mem_hole_alloc
                              (pages_needed - igd_opregion_e820_pages);

    /* Update the number of pages we need for the E820 map */
    igd_opregion_e820_pages = pages_needed;

 tools/firmware/hvmloader/Makefile         |   1 +
 tools/firmware/hvmloader/config.h         |  15 +-
 tools/firmware/hvmloader/e820.c           |   4 +-
 tools/firmware/hvmloader/intel_opregion.c | 297 ++++++++++++++++++++++
 tools/firmware/hvmloader/pci.c            |  10 +-
 5 files changed, 313 insertions(+), 14 deletions(-)
 create mode 100644 tools/firmware/hvmloader/intel_opregion.c

diff --git a/tools/firmware/hvmloader/Makefile b/tools/firmware/hvmloader/Makefile
index 21de721..ed42915 100644
--- a/tools/firmware/hvmloader/Makefile
+++ b/tools/firmware/hvmloader/Makefile
@@ -35,6 +35,7 @@ OBJS += smp.o cacheattr.o xenbus.o vnuma.o
 OBJS += e820.o pci.o pir.o ctype.o
 OBJS += hvm_param.o
 OBJS += ovmf.o seabios.o
+OBJS += intel_opregion.o
 ifeq ($(debug),y)
 OBJS += tests.o
 endif
diff --git a/tools/firmware/hvmloader/config.h b/tools/firmware/hvmloader/config.h
index c159db3..bd3c0f9 100644
--- a/tools/firmware/hvmloader/config.h
+++ b/tools/firmware/hvmloader/config.h
@@ -7,9 +7,6 @@
 enum virtual_vga { VGA_none, VGA_std, VGA_cirrus, VGA_pt };
 extern enum virtual_vga virtual_vga;
 
-extern unsigned long igd_opregion_pgbase;
-#define IGD_OPREGION_PAGES 3
-
 struct bios_config {
     const char *name;
 
@@ -43,6 +40,18 @@ extern struct bios_config ovmf_config;
 
 #define PAGE_SHIFT 12
 #define PAGE_SIZE  (1ul << PAGE_SHIFT)
+#define IGD_OPREGION_PAGES 3
+#define IGD_OPREGION_SIZE ((IGD_OPREGION_PAGES - 1) << PAGE_SHIFT)
+#define IGD_OPREGION_RVDA 0x3ba
+#define IGD_OPREGION_RVDS 0x3c2
+#define IGD_OPREGION_VERSION 0x16
+#define IGD_OPREGION_MASK 0xfff
+#define IGD_OPREGION2_SUPPORT_MASK 0x1
+#define IGD_OPREGION_SIGNATURE "IntelGraphicsMem"
+#define IGD_VBT_SIGNATURE "$VBT"
+extern unsigned long igd_opregion_pgbase;
+extern uint32_t igd_opregion_e820_pages;
+void intel_opregion_setup(uint32_t vga_devfn);
 
 extern uint8_t ioapic_version;
 
diff --git a/tools/firmware/hvmloader/e820.c b/tools/firmware/hvmloader/e820.c
index 86d3954..97a234e 100644
--- a/tools/firmware/hvmloader/e820.c
+++ b/tools/firmware/hvmloader/e820.c
@@ -243,11 +243,11 @@ int build_e820_table(struct e820entry *e820,
         nr++;
 
         e820[nr].addr = igd_opregion_base;
-        e820[nr].size = IGD_OPREGION_PAGES * PAGE_SIZE;
+        e820[nr].size = igd_opregion_e820_pages * PAGE_SIZE;
         e820[nr].type = E820_NVS;
         nr++;
 
-        e820[nr].addr = igd_opregion_base + IGD_OPREGION_PAGES * PAGE_SIZE;
+        e820[nr].addr = igd_opregion_base + igd_opregion_e820_pages * PAGE_SIZE;
         e820[nr].size = (uint32_t)-e820[nr].addr;
         e820[nr].type = E820_RESERVED;
         nr++;
diff --git a/tools/firmware/hvmloader/intel_opregion.c b/tools/firmware/hvmloader/intel_opregion.c
new file mode 100644
index 0000000..59cb2c3
--- /dev/null
+++ b/tools/firmware/hvmloader/intel_opregion.c
@@ -0,0 +1,297 @@
+/*
+ * intel_opregion.c: HVM Intel OpRegion setup.
+ *
+ * Leendert van Doorn, leendert@watson.ibm.com
+ * Copyright (c) 2005, International Business Machines Corporation.
+ *
+ * Copyright (c) 2006, Keir Fraser, XenSource Inc.
+ *
+ * Copyright (c) 2026, Charles Zmudzinski.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "util.h"
+#include "config.h"
+#include "pci_regs.h"
+
+unsigned long igd_opregion_pgbase = 0;
+uint32_t igd_opregion_e820_pages = IGD_OPREGION_PAGES;
+
+static bool verify_opregion(const uint32_t addr)
+{
+    const char *opregion_signature = IGD_OPREGION_SIGNATURE;
+    if ( memcmp((const void *)addr, (const void *)opregion_signature, 16) )
+        return false;
+    return true;
+}
+
+static bool verify_vbt(const uint32_t addr)
+{
+    const char *vbt_signature = IGD_VBT_SIGNATURE;
+    if ( memcmp((const void *)addr, (const void *)vbt_signature, 4) )
+        return false;
+    return true;
+}
+
+void intel_opregion_setup(uint32_t vga_devfn)
+{
+    uint32_t igd_guest_opregion;
+    uint32_t pages_needed; /* for OpRegion + VBT */
+    void *opregion_scratch;
+    void *vbt_scratch;
+    void *vbt_source;
+    /*
+     * absolute value in the host/guest except
+     * as noted in the comments
+     */
+    static unsigned long rvda_host;
+    static unsigned long rvda_guest;
+
+    igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
+    /*
+     * Tentative value for the number of pages to reserve
+     * in the E820 map for the OpRegion and VBT.
+     *
+     * This will be the final value for the E820 map if
+     * the device model lacks support for OpRegion 2 or
+     * if the host OpRegion version is < 2 or if we never
+     * allocate more pages in the E820 map for the VBT.
+     */
+    igd_opregion_e820_pages = IGD_OPREGION_PAGES;
+
+    /*
+     * Read the value the device model is initialized with.
+     * If the device model supports OpRegion 2, it will
+     * return the host IGD OpRegion address. If not, it
+     * will return 0. If the device model does not support
+     * OpRegion 2, the device model expects us to give it
+     * the address to which it will map the OpRegion in the
+     * guest and then expects us to do nothing more to setup
+     * the OpRegion, so that is all we will do in that case.
+     */
+    const uint32_t igd_host_opregion = pci_readl(vga_devfn,
+                                                 PCI_INTEL_OPREGION);
+    if ( !igd_host_opregion ) {
+        printf("device model lacks extended VBT "
+               "support. Continuing with legacy support only\n");
+        /*
+         * Write the the OpRegion offset to give the OpRegion
+         * address to the device model. The device model will trap
+         * and map the OpRegion at the give address.
+         */
+        pci_writel(vga_devfn, PCI_INTEL_OPREGION,
+                   igd_opregion_pgbase << PAGE_SHIFT);
+        return;
+    } else {
+        printf("host OpRegion address: 0x%x\n",
+               igd_host_opregion);
+    }
+
+    const uint32_t igd_host_opregion_page_offset =
+                   igd_host_opregion & IGD_OPREGION_MASK;
+    igd_guest_opregion = (igd_opregion_pgbase << PAGE_SHIFT) |
+                          igd_host_opregion_page_offset;
+
+    /*
+     * We know at this point the device model supports
+     * OpRegion 2.
+     *
+     * Indicate to the device model that we support
+     * OpRegion 2 by setting the least significant bit
+     * of the address we give to the device model.
+     * The device model will notice this bit set and
+     * respond appropriately to our writes to the
+     * register where the OpRegion address is stored.
+     */
+    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
+               (igd_opregion_pgbase << PAGE_SHIFT) |
+                IGD_OPREGION2_SUPPORT_MASK);
+
+    printf("guest OpRegion tentative "
+           "address: 0x%x\n", igd_guest_opregion);
+
+    if ( !verify_opregion(igd_guest_opregion) ) {
+        printf("error: IGD OpRegion signature "
+               "not found.\n");
+        BUG();
+    }
+
+    opregion_scratch = scratch_alloc(IGD_OPREGION_SIZE, 0);
+    memcpy(opregion_scratch, (const void *)igd_guest_opregion,
+           IGD_OPREGION_SIZE);
+
+    /* Read OpRegion version, rvda_host, and rvds */
+    const uint16_t version = *(uint16_t *)(opregion_scratch +
+                                           IGD_OPREGION_VERSION);
+    printf("OpRegion version: 0x%x\n", version);
+    if ( version >= 0x0200 ) {
+        rvda_host = *(unsigned long *)(opregion_scratch +
+                                       IGD_OPREGION_RVDA);
+        /* It is convenient to make rvda_host absolute */
+        if ( version > 0x0200 )
+            rvda_host += igd_host_opregion;
+        printf("host VBT address: 0x%lx\n", rvda_host);
+    } else {
+        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
+        rvda_host = 0;
+    }
+    const uint32_t rvda_host_page_offset = rvda_host &
+                                           IGD_OPREGION_MASK;
+    const uint32_t rvds = *(uint32_t *)(opregion_scratch +
+                                        IGD_OPREGION_RVDS);
+    const uint32_t rvds_page_offset = rvds & IGD_OPREGION_MASK;
+    printf("VBT size: 0x%x\n", rvds);
+
+    if ( !rvds || !rvda_host ) {
+        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
+        rvda_host = 0;
+    }
+    /*
+     * Write rvda_host as 2 successive 32-bit values
+     * to communicate location of the VBT to the device
+     * model. If rvda_host is not 0, The device model
+     * unmaps the OpRegion and eventually maps the VBT
+     * after we also write the guest address where the
+     * VBT will be mapped.
+     *
+     * If we send rvda_host = 0 to the device model, it
+     * will assume we do not need OpRegion 2 support and
+     * it will not unmap the OpRegion.
+     */
+    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
+               (uint32_t)(rvda_host & 0xfffffffful));
+    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
+    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
+               (uint32_t)rvda_host_upper_32);
+
+    /* In this case, we use the mapped OpRegion */
+    if ( !rvda_host )
+        return;
+
+    /*
+     * Update the number of pages the device model
+     * needs to map for us to get a copy of the VBT.
+     *
+     * N.B.: Here, igd_opregion_pgbase is really the page
+     * base of the location where the device model will
+     * map the VBT.
+     */
+    uint32_t vbt_pages_needed = rvds >> PAGE_SHIFT;
+    if ( rvds & IGD_OPREGION_MASK )
+        vbt_pages_needed++;
+    if ( vbt_pages_needed > igd_opregion_e820_pages ) {
+        igd_opregion_pgbase = mem_hole_alloc
+                              (vbt_pages_needed - igd_opregion_e820_pages);
+        igd_opregion_e820_pages = vbt_pages_needed;
+    }
+
+    /*
+     * Write the location where the device model is to
+     * map the VBT in the guest with the 12 least
+     * significant bits encoded as the number of pages
+     * for the device model to map (vbt_pages_needed).
+     */
+    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
+               ((igd_opregion_pgbase << PAGE_SHIFT) | vbt_pages_needed));
+
+    /*
+     * When the VBT is mapped from the host, the page offset
+     * of the VBT will be the same as on the host
+     */
+    rvda_guest = (igd_opregion_pgbase << PAGE_SHIFT) |
+                  rvda_host_page_offset;
+    if ( !verify_vbt(rvda_guest) ) {
+        printf("error: VBT signature not found.\n");
+        BUG();
+    }
+
+    vbt_source = (void *)rvda_guest;
+    vbt_scratch = scratch_alloc(rvds, 0);
+    memcpy(vbt_scratch, vbt_source, rvds);
+
+    /* Compute how many pages we need for OpRegion + VBT */
+    pages_needed = (IGD_OPREGION_SIZE + rvds) >> PAGE_SHIFT;
+    if ( (IGD_OPREGION_SIZE + rvds) & IGD_OPREGION_MASK )
+        pages_needed++;
+
+    /*
+     * So far we have allocated igd_opregion_e820_pages
+     * and we will likely need to allocate more
+     * pages to fully contain OpRegion + VBT.
+     */
+    if ( pages_needed > igd_opregion_e820_pages )
+        igd_opregion_pgbase = mem_hole_alloc
+                              (pages_needed - igd_opregion_e820_pages);
+
+    /* Update the number of pages we need for the E820 map */
+    igd_opregion_e820_pages = pages_needed;
+
+    /*
+     * Compute the final igd_guest_opregion value and
+     * keep the same offset as on the host if doing so
+     * will not push us across another page boundary.
+     */
+    igd_guest_opregion = igd_opregion_pgbase << PAGE_SHIFT;
+    if ( (igd_host_opregion_page_offset + rvds_page_offset) <= PAGE_SIZE )
+        igd_guest_opregion |= igd_host_opregion_page_offset;
+    printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
+
+    /* The device model will unmap the VBT */
+    pci_writel(vga_devfn, PCI_INTEL_OPREGION, igd_guest_opregion);
+
+    /*
+     * After unmapping we need to populate the memory hole.
+     * If the unmapping failed this will crash the guest.
+     *
+     * We could try to use the mapped VBT with our copy of the
+     * OpRegion, but it is probably better to BUG() if the
+     * device model failed to unmap the VBT.
+     */
+    if ( verify_vbt(rvda_guest) )
+        BUG();
+    mem_hole_populate_ram(igd_opregion_pgbase,
+                          igd_opregion_e820_pages);
+
+    /*
+     * After unmapping we are free to shift the VBT by
+     * an arbitrary number of bytes. For efficient use
+     * of memory and to keep the memory map simple,
+     * place the VBT contiguous after the OpRegion.
+     */
+    rvda_guest = igd_guest_opregion + IGD_OPREGION_SIZE;
+    printf("guest VBT address: 0x%lx\n", rvda_guest);
+
+    /*
+     * Until now, rvda_guest has been an absolute address
+     * in the guest. We need to translate it to a relative
+     * address if OpRegion version > 0x0200 and in that case
+     * we also verify it is contiguous with the OpRegion.
+     */
+    if ( version > 0x0200 ) {
+        rvda_guest -= igd_guest_opregion;
+        printf("guest rvda (relative): 0x%lx\n", rvda_guest);
+        BUG_ON(rvda_guest != IGD_OPREGION_SIZE);
+    }
+
+    /*
+     * Write the correct rvda_guest value to the
+     * guest copy of the OpRegion and copy the scratch
+     * buffers to the correct address in our E820 region.
+     */
+    *(unsigned long *)(opregion_scratch + IGD_OPREGION_RVDA) = rvda_guest;
+    memcpy((void *)(igd_guest_opregion + IGD_OPREGION_SIZE),
+           (const void *)vbt_scratch, rvds);
+    memcpy((void *)igd_guest_opregion,
+           (const void *)opregion_scratch, IGD_OPREGION_SIZE);
+}
diff --git a/tools/firmware/hvmloader/pci.c b/tools/firmware/hvmloader/pci.c
index c41c8d9..07a37e5 100644
--- a/tools/firmware/hvmloader/pci.c
+++ b/tools/firmware/hvmloader/pci.c
@@ -43,7 +43,6 @@ uint64_t pci_hi_mem_start = 0, pci_hi_mem_end = 0;
 #define BAR_RELOC_THRESH GB(1)
 
 enum virtual_vga virtual_vga = VGA_none;
-unsigned long igd_opregion_pgbase = 0;
 
 /* Check if the specified range conflicts with any reserved device memory. */
 static bool check_overlap_all(uint64_t start, uint64_t size)
@@ -190,14 +189,7 @@ void pci_setup(void)
                 virtual_vga = VGA_pt;
                 if ( vendor_id == 0x8086 )
                 {
-                    igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
-                    /*
-                     * Write the the OpRegion offset to give the opregion
-                     * address to the device model. The device model will trap 
-                     * and map the OpRegion at the give address.
-                     */
-                    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
-                               igd_opregion_pgbase << PAGE_SHIFT);
+                    intel_opregion_setup(vga_devfn);
                 }
             }
             break;
-- 
2.52.0


