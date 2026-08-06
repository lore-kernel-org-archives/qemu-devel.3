Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F5FC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrmYG-00027w-15; Wed, 05 Aug 2026 21:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmY8-00023D-Oz
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:34 -0400
Received: from sonic304-22.consmr.mail.ne1.yahoo.com ([66.163.191.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmY1-0006Mz-Ie
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785978322; bh=evB25RMTSzQAfthgYsyzolI932AZpxXExd3y4km457k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=CGhAqESmK9usG95tKKWtvULiwhR46Cmj4l7Nr/fBR4x5IKPPJs6g38HCr2NM21HXJsUgAUJ8N6UWJ3eFdw9HzEchjDUGaIm4f8xt/2kvzrj+WFqJ3HywKjZ6P7wks6eMkEdDgcoK9EPjdQjRI9WPM++7WvzQj3ZXggg+bw86fE7eZWGkEF8U92+7krdc5x6ixZxk5oqhnFy50Jwt5TR0zxzQsp+4yHIm7Yrdxt2aUp1PoD12KMCqEcbz1yAnBsv4rxa4F7Bj2kERZSgLoXx5d20hd5PcASUj+J4eNybUcf2nGkLIK9cQfnVZnHuk5VFVUZ6Dn/VVwAMJETa2EKurgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785978322; bh=UoVOmCdCQ4BIcpmuzCu7GbBrf0XMwYbjqiL6WaXGwGX=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=q/VFzd9fSN+dkVHeetwvtfjDntAAUUfkPKWOACKE+YSrmkYhahKW7eT7a6nfZtDIcM/CR99Y3AqmyniaMKSJUYi+4RXDum1eq/BV284MZiaNzbBVgUOdjnRInHRNHQ521t8vD050DiqUmp/N1tjhxQu31YXPvkDcnpWVgguNt5eiyqDm0cILdPd12A0efbjx00kFha4ymiyWfpv+YPBZ6DwcsUGrZF3xNdgcatRfXKoEJXiDniM8gs1HRChibjD/QfQPxx8ptuOXpkFTacf2mk8jsrEY/07p/MYe3cahlwdYvcqxWUJPb89FrGPJxH1c1IgkOfKXKpKkAWEdrC92xw==
X-YMail-OSG: wKTvT74VM1l3.wJJxXa53Q_pbyAuRjVyoIJPGNVxZfNtF4hUodYF0AqMELrgeBi
 _sIDSjSMELVdo2CAcOMn9.eiXjo4r8w_VX4pguyV9XkDtXs4YdpH4NYJEnIijAuuSbyFSHwKRThY
 wyM5r_edXDMtcvauaZNwzgpxzyaqXd5bf1KWjcJH5sNkRcfp4RauVUG4xj0oItng9vkKZLrJjcFq
 IlxEay5ao8tNb4tEEM3BNN21FL17ax_wcsqu6PQjVPQSt7Fsvu.v27vmUrKRQx15pR68rB5qz66Z
 iVnXJ_BgeBEdfHG_yIJALoUt8zFRwn8ehHsyX1VzcvuT8Tli5IKmqfS6AsFcEGv4rrTi0oIagr54
 K_alXnfMNPBJEE3WjV3l_UAP31OKKgYg5KXelX4UlQ8jj3Pt_2fXZRr8IunNV.x477cMNx0Tf3q7
 HwgTSMXl6Cx2fsZkgaNw3yNtLO834M_vSgE7sZBICincNPBUeKx5.Ld.7BbY4ueQzoprYPUAIjH6
 AaP_KkvsvBwsGgnKX0b6.MdoGmR76RajBwHsZr0LZINLN6b9R0rCFD1Z96y4xU4ssOFciDF2zNxu
 mJ24dBI0Ngz9IzrvkE9aNG3BCM3EK2JPIZtSfIOrM9TTtUVX8i.XChs6l0kzQZYJAQKPZ9o4uZTT
 Ia80MuUls17e0_DJkvQL_OrskRdzuwXGhFJkwCgyUEvh3ikO4cslWpFMJTujEoYOHuKTWl5exuGO
 X1ttqpvlzukQWmx7XdZHBIbUFAF999nUsqgO4te_cNMd6wurJ9o7.i61n_Q3_Y4Jt948OsjdP8sB
 68iCOLZ4ygL55VywJSmM4G69ASSRs541BIV3D5jHhocPYxaOv7GASgMSdwaAmP3NLXHrNQpv3CUs
 AHIwXZabTe9T3IfeGkV9sfV1tcQu9hjKfm.Ob4YuBRSqbf5CbYg5h5I6Cz9t3fyqPNKHnqPVTSry
 r8Nb12mcHMJrNqg_8UxyZEbBjip0dj3VXMH4gSTUb.ixPig0kLDuLT9_JOS4X4NuS4syONJE2qel
 vQjaH4ENmBjpzA7HLPZEboIyLAztTspvzYV8VqlT0gAXgtZtqr6gzrcVO_qYg0BpaKfd4oTlm_1Q
 mU_IlTXLjCyXksDE3B_BibAAIHhYMv8V3j7BMATvCIuFxvfr8mXp5MKScNLBL8vSRq98BZjVXLdF
 w3e8psinkPI3k2Ve8v_Kj46l6JZke3l9dE39zx_YM7xxJdoKiENN01bZIOwdaB.g15W4gg4fvb6u
 iSNB69Z0LfQAxlith8Z7sqNyBWM7e3FByu9tdGj8tNUskVRerRLCALrg7_hDGeojtkbdZZRJbJlF
 xWfIewEfc_VzkgCJBx6zBbP0BVnCcW0TQYqLdXobVNzW_X2VAafQ1B8GoAOarcbkDAA8xxUVed2K
 svsZR8lwNSzuBGevM1oIR2nt_csErLLbwQM9cjYdw.D_dwwVrOJsUujRrWwaykrcuk0Eff8Ucii1
 FBzP5Pz8YEZNqEcu5J2fYyyIIqSEeLUlhXu_3dfWuncrN.zw_G3ZKK7aZs16Urh3gHCwWErlQOaQ
 vH7zzFaaOHpsEkkiTPkkeFVOnP8sBwQ3alydE85Jq0d2RbXD5fRFLVWEj5LHAxBuhC1G0y30dmfa
 EFfPkAwXmfpcIzQNbelQDUvuZUbZqqI.TrQwmFYbRVX5I59FLHCOYqToK8Mlp70kKy0JSvHgbiMd
 WRvuOgCYNXul_KU3eO4ha6NHilwDP_kBbtBQHdYtI59FU2xEmCKf_oVDsH0_dKYkMgXKqxED2qTx
 hkh4XL9CaL5cuoR5tpoX6mzW9VwGHaq_mIXaU3Kaua5.XIEXUaU5Dhk.DUKwiBb45c6gYevdW4Lh
 SDh0Le2Z.AihHQCYIvlRK4B7N9ocQq1_Py6JjJNfYJwy7yaW6jh9tUPuVd7x6gc9adogTBxiUx0j
 qWVQJIk3h5.eh51CdStywHJQJkmd8oZ_PU3Hrg9gQAsfcLO_VWuyP2vHeG1qewFpV234E0KCnHd_
 U2noFmL1g6ae.iV.kr4PtwQZSmWLDNakcws4CX3J0Vm9nDoX9z6RuHN6N.x.koGoITFtg3OXgBKF
 c8gsiZ7W53V0NQ3rHmGqjxwOs4w.F68jvUlGTJYrFAydsYLjTC.KvtMeDAzuakDINmvR0rm2TPXo
 FE74kE5q7P8OHqAoxHX2X9OLj_p9ucP2JTDNvT4mWRABeXyN6RnvWO_w5i.RgSz7CA87HmoVMvkI
 0oVzK6KX9x9Nbkxo9r5PZhXsZkDi3eiyI5O.49vrt
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: d6264233-3872-45c9-8ba3-4c440a588136
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 6 Aug 2026 01:05:22 +0000
Received: by hermes--production-bf1-54b5569bdc-xjdx5 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 734f0c8329adecc00a98ec91cc943adb; 
 Thu, 06 Aug 2026 01:05:18 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v5 5/6] xen/igd: implement support for extended VBT
Date: Wed,  5 Aug 2026 21:04:55 -0400
Message-ID: <20260806010506.492490-6-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806010506.492490-1-brchuckz@aol.com>
References: <20260806010506.492490-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.163.191.148; envelope-from=brchuckz@aol.com;
 helo=sonic304-22.consmr.mail.ne1.yahoo.com
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

Newer devices with versions of the OpRegion >= 2 require an
extended bios table (VBT) in some cases and also in some cases
require modifications to the OpRegion for proper operation in
the guest. This is in contrast to legacy devices in which the
VBT is always embedded within the OpRegion.

This makes the current approach of providing only the unmodified
host OpRegion to the guest with no guest access to the VBT
insufficient for proper support of devices with OpRegion version
2 or higher and an extended VBT.

Support for extended VBT also depends on compatible support in
hvmloader. If such support is lacking in hvmloader, fall back to
the current protocol that does not provide support for extended VBT.

To implement support for extended VBT:

Instead of configuring the guest with access to the unmodified
host OpRegion via hypervisor mapping of the OpRegion from
the host to the guest, temporarily map the host OpRegion and
VBT into the guest, allowing the guest (hvmloader) to get copies
of the host OpRegion and VBT which hvmloader can modify as needed
to support cases that require modifications to the OpRegion.

In xen_pt_unregister_vga_regions(), do not try to unmap the OpRegion
in cases when the OpRegion is not mapped during normal operation of
the guest, and replace the constant '3' with the macro
XEN_PCI_INTEL_OPREGION_PAGES which is defined to be 3.
To implement this:

Use 'done = true' to end further processing when the OpRegion does
not need to be unmapped in xen_pt_unregister_vga_regions(), and use
'guest_supports_opregion2 = false' to end further processing when the
OpRegion does need to be unmapped in xen_pt_unregister_vga_regions().

The OpRegion 2+ support that can be provided by this patch and a
compatible patch to hvmloader is required to fix code 43 errors in
Windows guests that have an Intel IGD with extended VBT passed
through to the guest.

Link: https://lore.kernel.org/kvm/20211012124855.52463-1-colin.xu@gmail.com/
Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v4:
  - v4 is the first version of the series that has this patch

Changes in v5:
  - fix style by adding braces to two if blocks and not initializing
    two static boolean variables to false
  - update the link to the companion patch for Xen hvmloader

The companion patch to hvmloader that is needed to make this patch take
effect is available here:

https://lore.kernel.org/qemu-devel/20260802050824.10554-1-brchuckz@aol.com/

 hw/xen/xen_pt_graphics.c | 233 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 225 insertions(+), 8 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index a124233..3d2a94c 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -12,7 +12,26 @@
 static unsigned long igd_guest_opregion;
 static unsigned long igd_host_opregion;
 
+/*
+ * These are true until they are set to false when the guest first
+ * accesses the OpRegion address register for a read or write,
+ * respectively.
+ */
+static bool first_guest_opregion_read = true;
+static bool first_guest_opregion_write = true;
+
+static uint32_t guest_opregion_extra_writes;
+static bool guest_supports_opregion2;
+static bool done;
+static unsigned long rvda; /* absolute host VBT address */
+static unsigned long vbt_guest_pgbase;
+static uint32_t vbt_nr_pages;
+
 #define XEN_PCI_INTEL_OPREGION_MASK 0xfff
+#define XEN_PCI_INTEL_OPREGION_PAGES 0x3
+#define XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED 0x1
+#define XEN_PCI_INTEL_OPREGION_DISABLE_ACCESS 0x0
+#define XEN_PCI_INTEL_OPREGION2_SUPPORT_MASK 0x1
 
 typedef struct VGARegion {
     int type;           /* Memory or port I/O */
@@ -117,11 +136,11 @@ int xen_pt_unregister_vga_regions(XenHostPCIDevice *dev)
         }
     }
 
-    if (igd_guest_opregion) {
+    if (!guest_supports_opregion2 && igd_guest_opregion) {
         ret = xc_domain_memory_mapping(xen_xc, xen_domid,
                 (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
                 (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-                3,
+                XEN_PCI_INTEL_OPREGION_PAGES,
                 DPCI_REMOVE_MAPPING);
         if (ret) {
             return ret;
@@ -239,7 +258,31 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
 {
+    if (!igd_host_opregion) {
+        /* We just work with LE. */
+        xen_host_pci_get_block(&s->real_device, XEN_PCI_INTEL_OPREGION,
+                               (uint8_t *)&igd_host_opregion, 4);
+    }
+
+    /*
+     * By returning igd_host_opregion here instead of 0, we can
+     * indicate to hvmloader that we support OpRegion 2.
+     *
+     * The conditions are there to prevent returning igd_host_opregion
+     * to guests that have a version of hvmloader that lacks support
+     * for OpRegion 2. We do this to maintain backward compatibility for
+     * guests with earlier versions of hvmloader that always expect us
+     * to return 0 instead of igd_host_opregion when igd_guest_opregion
+     * is not yet set to a non-zero value.
+     */
+    if (first_guest_opregion_read && !igd_guest_opregion &&
+        first_guest_opregion_write) {
+        first_guest_opregion_read = false;
+        return igd_host_opregion;
+    }
+
     uint32_t val = 0;
+    first_guest_opregion_read = false;
 
     if (!igd_guest_opregion) {
         return val;
@@ -251,21 +294,195 @@ uint32_t igd_read_opregion(XenPCIPassthroughState *s)
     return val;
 }
 
-#define XEN_PCI_INTEL_OPREGION_PAGES 0x3
-#define XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED 0x1
 void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
 {
     int ret;
 
-    if (igd_guest_opregion) {
+    /* hvmloader with OpRegion 2 support uses lsb of val to indicate support */
+    if ((val & XEN_PCI_INTEL_OPREGION2_SUPPORT_MASK) &&
+        first_guest_opregion_write) {
+        guest_supports_opregion2 = true;
+    } else if (first_guest_opregion_write) {
+        XEN_PT_LOG(&s->dev, "hvmloader lacks extended VBT support, "
+                   "continuing with legacy support only\n");
+    }
+
+    if ((!guest_supports_opregion2 && igd_guest_opregion) || done) {
         XEN_PT_LOG(&s->dev, "opregion register already been set, ignoring %x\n",
                    val);
         return;
     }
 
-    /* We just work with LE. */
-    xen_host_pci_get_block(&s->real_device, XEN_PCI_INTEL_OPREGION,
-            (uint8_t *)&igd_host_opregion, 4);
+    if (guest_supports_opregion2 && !first_guest_opregion_write) {
+        /*
+         * OpRegion 2 is supported and we are processing
+         * additional writes that the legacy protocol ignores.
+         *
+         * We should always return from this if block to prevent
+         * executing code below which is only for the first write
+         * when we map the host OpRegion into the guest.
+         */
+        guest_opregion_extra_writes++;
+        switch (guest_opregion_extra_writes) {
+        case 1:
+            /*
+             * Hvmloader expects us to store the value as the least
+             * significant DWORD of rvda.
+             */
+            rvda = (unsigned long)val;
+            break;
+        case 2:
+            /*
+             * Hvmloader expects us to store the value as the most
+             * significant DWORD of rvda and unmap the OpRegion if
+             * rvda is not equal to zero.
+             *
+             * If the unmapping fails, hvmloader will fall back to the
+             * behavior of older versions which simply map the OpRegion
+             * from the host to the guest without trying to configure
+             * the guest with OpRegion 2 with extended VBT support.
+             */
+            rvda |= (unsigned long)(val) << 32;
+            if (rvda) {
+                ret = xc_domain_memory_mapping(xen_xc, xen_domid,
+                                               (unsigned long)
+                                               (igd_guest_opregion >> XC_PAGE_SHIFT),
+                                               (unsigned long)
+                                               (igd_host_opregion >> XC_PAGE_SHIFT),
+                                               XEN_PCI_INTEL_OPREGION_PAGES,
+                                               DPCI_REMOVE_MAPPING);
+                if (ret) {
+                    XEN_PT_ERR(&s->dev, "[%d]:Can't unmap IGD host opregion:0x%lx"
+                               " from guest opregion:0x%lx.\n", ret,
+                               (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
+                               (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT));
+                    rvda = 0;
+                    guest_supports_opregion2 = false;
+                }
+                ret = xc_domain_iomem_permission(xen_xc, xen_domid,
+                                                 (unsigned long)
+                                                 (igd_host_opregion >> XC_PAGE_SHIFT),
+                                                 XEN_PCI_INTEL_OPREGION_PAGES,
+                                                 XEN_PCI_INTEL_OPREGION_DISABLE_ACCESS);
+                if (ret) {
+                    XEN_PT_WARN(&s->dev, "[%d]:Can't disable access to IGD host"
+                                " OpRegion: 0x%x.\n", ret,
+                                (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT));
+                }
+            } else {
+                guest_supports_opregion2 = false;
+            }
+            break;
+        case 3:
+            /*
+             * Hvmloader expects us to store the value as the address
+             * to map the VBT to in the guest and to map the VBT at the
+             * provided address in the guest. Hvmloader encodes the number
+             * of pages to map in the least significant 12 bits of the
+             * provided address.
+             *
+             * If VBT verification fails, hvmloader can't determine if the
+             * VBT is mapped but corrupted or unmapped, so it crashes the
+             * guest as an unrecoverable error.
+             */
+
+            /* address (gfn) to map VBT to in the guest */
+            vbt_guest_pgbase = val >> XC_PAGE_SHIFT;
+            vbt_nr_pages = val & XEN_PCI_INTEL_OPREGION_MASK;
+            ret = xc_domain_iomem_permission(xen_xc, xen_domid,
+                                             (unsigned long)(rvda >> XC_PAGE_SHIFT),
+                                             vbt_nr_pages,
+                                             XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED);
+            if (ret) {
+                XEN_PT_ERR(&s->dev, "[%d]:Can't enable access to IGD host VBT:"
+                           " 0x%lx.\n", ret,
+                           (unsigned long)(rvda >> XC_PAGE_SHIFT)),
+                rvda = 0;
+                vbt_guest_pgbase = 0;
+                vbt_nr_pages = 0;
+                done = true;
+                break;
+            }
+            ret = xc_domain_memory_mapping(xen_xc, xen_domid,
+                                           (unsigned long)vbt_guest_pgbase,
+                                           (unsigned long)(rvda >> XC_PAGE_SHIFT),
+                                           vbt_nr_pages, DPCI_ADD_MAPPING);
+            if (ret) {
+                XEN_PT_ERR(&s->dev, "[%d]:Can't map IGD host VBT:0x%lx to"
+                           " guest VBT:0x%lx.\n", ret,
+                           (unsigned long)(rvda >> XC_PAGE_SHIFT),
+                           (unsigned long)vbt_guest_pgbase);
+                rvda = 0;
+                vbt_guest_pgbase = 0;
+                vbt_nr_pages = 0;
+                done = true;
+                break;
+            }
+            XEN_PT_LOG(&s->dev, "Map VBT: 0x%lx -> 0x%lx\n",
+                       (unsigned long)(rvda >> XC_PAGE_SHIFT),
+                       (unsigned long)vbt_guest_pgbase);
+            XEN_PT_LOG(&s->dev, "VBT host address: 0x%lx\n", rvda);
+            break;
+        case 4:
+            /*
+             * Hvmloader expects us to store the given value as the
+             * final value for the register that stores the OpRegion
+             * address in the guest. We also unmap the VBT since the
+             * guest now has its own copy of both it and the OpRegion.
+             *
+             * If the unmapping fails the VBT will be mapped where
+             * hvmloader needs to place the OpRegion plus VBT in the
+             * guest E820 map. In this case, hvmloader will crash with
+             * BUG() rather than try to use the mapped VBT with the
+             * guest's copy of the OpRegion.
+             */
+            igd_guest_opregion = val;
+            ret = xc_domain_memory_mapping(xen_xc, xen_domid,
+                                           (unsigned long)vbt_guest_pgbase,
+                                           (unsigned long)(rvda >> XC_PAGE_SHIFT),
+                                           vbt_nr_pages, DPCI_REMOVE_MAPPING);
+            if (ret) {
+                XEN_PT_ERR(&s->dev, "[%d]:Can't unmap IGD host VBT:0x%lx from"
+                           " guest VBT:0x%lx.\n", ret,
+                           (unsigned long)(rvda >> XC_PAGE_SHIFT),
+                           (unsigned long)vbt_guest_pgbase);
+                rvda = 0;
+                done = true;
+                break;
+            }
+
+            ret = xc_domain_iomem_permission(xen_xc, xen_domid,
+                                             (unsigned long)(rvda >> XC_PAGE_SHIFT),
+                                             vbt_nr_pages,
+                                             XEN_PCI_INTEL_OPREGION_DISABLE_ACCESS);
+            if (ret) {
+                XEN_PT_WARN(&s->dev, "[%d]:Can't disable access to IGD host"
+                            " VBT: 0x%x.\n", ret,
+                            (unsigned long)(rvda >> XC_PAGE_SHIFT));
+            }
+
+            done = true;
+            break;
+        default:
+            break;
+        }
+        return;
+    }
+
+    /*
+     * This code handles the first write to the register from the guest.
+     * It maps the host OpRegion into the guest.
+     *
+     * Set first_guest_opregion_write to false to enable more writes
+     * if OpRegion 2 is supported.
+     */
+    first_guest_opregion_write = false;
+
+    if (!igd_host_opregion) {
+        /* We just work with LE. */
+        xen_host_pci_get_block(&s->real_device, XEN_PCI_INTEL_OPREGION,
+                               (uint8_t *)&igd_host_opregion, 4);
+    }
     igd_guest_opregion = (unsigned long)(val & ~XEN_PCI_INTEL_OPREGION_MASK)
                             | (igd_host_opregion & XEN_PCI_INTEL_OPREGION_MASK);
 
-- 
2.52.0


