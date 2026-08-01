Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B31C5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxD0-0002Ho-M0; Fri, 31 Jul 2026 20:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxCz-0002HY-8z
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:04:09 -0400
Received: from sonic305-21.consmr.mail.gq1.yahoo.com ([98.137.64.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxCv-00085E-QA
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785542641; bh=ScxuLdCEEpt8xcvaZGVm8pblnaaeCXt2k3SUmUrCDDQ=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=BtZRziS2ygv2KGOSQFkP5aQBWo2876ju/GKwUxZmxJTPJzhXRwNiuHImAyZgXwr0xAKYD5SgYEx2SKUniLfHDuEPLuswLJCTtCpA2i0PkkN1YbiqxMgFRUe6uNN3bXxEnKaDsIHFIGBtHkvRLqpkyElptwGfyuJd0mrUHfnXUUum2hx5WYpn3bQSaVteWEtDq+wn8rmytq9M2Vf868PZ9j56hWV63DTEFHR4kyell+yDUqCjgXdFubYwUFQkwstPp1aB+/LzsUVWzKItZwT4yTzH077oVan8MvwF8yHMao5zvFqfvJC/zPA1hRrF9gxtfxCGthCf+aAANbBzTZtoYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785542641; bh=EgevDvieZTrS5c5/q5o0sA8ls7qQ9KS6Qjw0ldsYmTK=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=QUuOUFJzgLja2jgoY0vvNkPuDILYmIpoA6zBTStqTSto/kWhVNX5D+bDyPDneyzeprvmya4CFPG16NDKtATHvw50bgwwVglJQKP+WW5JwT43JLCrdf6B4lnpxQItjso2UxoW8XNiumXHIlK80Y0pFD8a9nUAH/c5yOBDlL4sjEl+GKFOCt7m5+VEpYCk4b4qQIy+a0VGNeTsZLiISJZkeOEFSsBxMX4eChN5SUYoDqNEX1Xly18Tem0RoZCrBWcdO+3PDgb1wxt21dPPzhJIJjuUTea8R6bm6xEwCFV7PMDZxuk7aJCQMc/kt7jkBPwSq7AfOLDNPpP5mMcFytORRQ==
X-YMail-OSG: NZZFObAVM1mQ8GuUv0FKMv9ixWb._8avAcvTzthF8BSuwGKlf2uXznS9QLs4qHu
 cNSuiCa1BGPlLlHPquwa8hkq.Svb8y21.sX5taYNKrwxdRfi1nMpGGeik8E3mDKIBrw5qm3yhp7N
 JwylAqzYZfc7.i67ygWf27FZ_BCi6BYNSENdrXEtrxfUmuFD2QGpCr2JhDDiS8IIEHBee4qBibkG
 qmeDyvAJou8JGl39oNojjw6tJ3oWma3PWSl8JsknF4HOd6hVmDBu8qznZlxGJdTvdwry4xssFuvz
 AMuv3jNMkOYxaXmaT1Jis1ANyveIEArGN_QvsMMaqKcSdTTuDwD.94C_2D1k9Xxt9zUXi5VT2hub
 XBmQceX6E6X4IEncTk3Lv7X246HrGPdeeu0BbVoSVnPoso_7xM_NsPrV1PTu5pZWZnnXX2nFuq2K
 8kRZfSfuBtK2vc4hIhu.rFOdrP50kZ0lAH8ieip29_Cwallgo5aHpabQUfpKf.WyhM4UQnFXiqTj
 GoZjF_S3eVSL9f4OBS3_JKiAOujJD6BVoY7AqaeQD8omDQMpT6klqGmQPT_3MCJ35ddSKLip0guO
 Ot6J2NDn4LqHt94gJX22A9cbAECN1NkgIB_l1zchHbPjmqTHxDxCQs0nVb3QUWDzwRvjrX3ytXYF
 nfOFmY2Jb8Nmd191LbSmUSRLe0tXxZZ915repd.4_pUUIW3SCN3tFKK2IwfxQQ_8XCJezkNLksFn
 TBu2AIgzCd22pMALioITJmEQQz_2xTlutcgdy.1w7XofZlI6pnlZxNmZR_psdJObbAKTB34gNqFz
 .TqzvO4R0NCvLps1zTV3PVVoV2hbUq69ezRuWYssjzlsnaE2a9r43Uk1on2aFUsBGd5a71mKFkXv
 81RoL20olZdxyX.Xq.5vpF68KIWifctNXs9ErAkakdLCJ911KeYSnlE8QPkP6QogBH3IU0VYwoIR
 bLaIDLI7p_wJU8cuAhl_PHq.6WW15baogYVq7.kjuvz7e4xevteZXJGXPPhn1NcZZL3d7he9EmX.
 VesxsFK.4X4MEFdU8fv27Cm4hqMXVRJK7a8mCxqxOd9UnUHkH_thy8HzVEnuCBc4FL90oBAx_7.F
 xtYFaMQvYRfdzxdFh0XR5L4lnQDc9__WC_uIZ9vg4R9KwDYLyssCAWbPzKTCOX5MyErv.KTGMAI7
 Ok8yrG9Lz5fdB3Qj.oZh.QqrUoS.5XnuQcM2.hiUnI8khOq9xuM5fJgEBhOlU2.Z3GmXmsCpRdcs
 G2T0o5YjXwcmNL7WN4_aHqdhp4sGgE4Ei_TzpQOf9wpio2kRJE8xOMPSNVMpfigE39tDuARi_l_I
 6vT.yFuugjxncpY_FFk3sftXGu5.pVfkhZWD9KN1PIJ.5NaQy898Qqf4OVlGrQ2PlgkXGdLWHNlt
 WCZ0CTk3ibM3qeDfnnYCuiIPoQKVnEpNXkEhSJFCrPoa6c2164tkOm58gyMgRTXSqAIvVupMj7i1
 5xkJtCW5r1k4NxY8qcW3zl_MPBlxNA98Df2Pttk8Q.oVXmuzUtqC04jFeVPjVXC7iFN50k1xIRr0
 4n0BoAs2HW7v5IY69MfAkGpscSvhj2BEv0ioCCSLH0msIeGmyVneSwUsvU7POwf1W9xt2LADJGIr
 RzFs16RbnydAQL39dDzo1bVqhsCqUjWRI5HbiOVOjG.8v5RjXbtqXsLPWRKvMdhboA96gcyCL3_r
 XOS4Z11jeCFvdl_gzMoO4NXDMux9sRVjOu1C3B3vlpSJDlSHTrCIbT..S7qZIsroYDQyjBW_na9q
 kOmjygO2ayYw6ReN1dP7U8ma3FW_jkAM1C.Q6tm622SOGSmA10y3vyhE6AQEwAIxZyIodwJiwzp0
 9JOElHyeWEp6AEb.1win1FYbiQSjxME6WC0ZBxGwcSy8lFty6uFmOMJyF59j8lIUcogCNF2nngDI
 .5Qe3fjO._cM.qwqWc84V1fZJ4qsJ04yFE.7.EAwmTn_OVkcCHZepP9se_nCGUkwxQOWKJlVsp4S
 Js05WxoHo2uFx4Whomomp7v1pQ8gfuL4mE58KgYEq2n4x0geIIt_dmuWTuPKVlp0rlOQbJUElHwy
 8R.UK8mhEfrHlf7fRmhL.0CMaWWiWdQIMvceRNyZ6e3Dr72hWv5VXdL7JqJFzK2SsQrgfm_amXSc
 l4po3C_DjBMPqC24wlaCc1XO4CqIQ6c9RrKu6LPHE.gyz291mZyCSD76NvNsqXQcyNXSpEkQbub9
 jQLAXPt4_E4mSjfoR9h22fhzeaEvMStYKbQs4hr1q
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 81e8e4b2-3141-45c8-9bab-4fa037b5cbfb
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 00:04:01 +0000
Received: by hermes--production-ne1-6f6bdbdd7c-rppmz (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c7608ec2cac0a95d3d8faa6ec551e65c; 
 Sat, 01 Aug 2026 00:03:55 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org, Jan Beulich <jbeulich@suse.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH] tools/hvmloader: implement Intel IGD extended VBT support
Date: Fri, 31 Jul 2026 20:03:45 -0400
Message-ID: <20260801000354.16446-1-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260801000354.16446-1-brchuckz.ref@aol.com>
Received-SPF: pass client-ip=98.137.64.84; envelope-from=brchuckz@aol.com;
 helo=sonic305-21.consmr.mail.gq1.yahoo.com
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
function opregion_setup() which is implemented in the new file
intel_opregion.c.

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
Later versions of this patch will provide a link to the compatible patch
for extended VBT support in the device model which will be posted to
the qemu-devel and xen-devel mailing lists and Cc'd to the appropriate
maintainers and reviewers soon.

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
+    /* Update the number of pages we need for the E820 map */
+    igd_opregion_e820_pages = pages_needed;
+
+    /*
+     * So far we have allocated vbt_pages_needed
+     * and we will likely need to allocate more
+     * pages to fully contain OpRegion + VBT.
+     */
+    if ( pages_needed > vbt_pages_needed )
+        igd_opregion_pgbase = mem_hole_alloc
+                              (pages_needed - vbt_pages_needed);
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


