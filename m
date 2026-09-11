Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5977FC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vdK-00088V-FB; Fri, 11 Sep 2026 03:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdH-00086y-VK
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:11 -0400
Received: from sonic305-19.consmr.mail.gq1.yahoo.com ([98.137.64.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1x4vdF-0008BX-3e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1789111507; bh=w67e4rO/vcswdR8q6gV9R4+pyFjhs0XSGCFwSqNmNQs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=W7dUzzwP7pE0RmixTMbaj3MuPTfDk6Ud0T3qI1s6hFs22CXloL04Jd+DGnVTPIeeuIoV30VMJLI+Qw/dpuwJv5zTkdf3Va3Xm5/nORd6kfJZZiDYI/bLs7iwn1hkP/WMyH0U2LU1jqp2TI4g17E4q84SZbkKt9Ia7G6S0Z5wbSLeMi6iY09GxhqgM26iNJCp2jEf6q5h5q0n5GBBwqmILMU0cAW37j17ugnc5+4nF92Mnvao4Q2N6u5K4/z/9nz+N6CgwrDlkaRlRn3IuSh2MGuXQt2f8UQ+OjxAn/KdaIU4whau6zgexRrY85XKurav8Zqb60z4bHdD/SrGygYHWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1789111507; bh=mP2MEXUlevjdjchDEDIedOgXWaSUBK4IxfoiGoyxx0l=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=gK/tvhqXhp8wFMSmrMJ/azT5HWtmHCA/pauNdSneDTJXBlfhhMlaRv84J+C0+hbuwhL5+hHj4hzC76h3HPb/wv54K0nTMOu+JCPYhyTAnMw/rHS/P4AtTmB5tcenAaKX6nq70d6ghLbCdHvEbmMPATrCB3vuA0o2uEYWGlgfZTtiobcYC2DBuG6OKiwqLWa6jX8QN6J0N5FelDTWUoMSuAoBFboacxC8J8UoqbGYsoMEegCnEFSuz0y0MoBRMdqQkqWAvPpMZ7/ukprU1BAZ+aoc+oYzApgwxeVeL+VXyJUia98D7yUgmoA2ilp5DJ/BkjTwHQl3mArVw3FnZ9h/Ew==
X-YMail-OSG: YetdfK0VM1l0HafXGOGqEu.ProfwvWjW5UX_NdbP78CPV8_oK_cses5Qy5UI1Xp
 Zp8Mawtec58Iys_PfKi70nayiRA9R48nCtc3_dqDBfGTHz3s1O_g4wPMcielcfT4ytDRY5pT45AL
 B0C1ZeCz3rOtNn17CcQfPtmE5wo7jFNrm_FhY4QiRniZkQxxD4xneBkFGGhOWmQ8Tjt13DkYM2kK
 gLoQROphnikDxOKC7Qy396Vs5droCxXvHrl2y3TA.98YZmdth0V0dZMkyANllDO9HtkLxtGgNf8o
 fOCTaiZ80d1dNjcZ1AxXJkw4FR8JmuVIq84pxI487SjH.8v5jrvQlvAdOYWnAUSMg16Plh8Uxfs4
 3w_sjB_WqKaOzjXOClG6uxSLZDKpqh35zDfQCqpkzau0hdYlmshmY.59E7viP5MhkKG9vcv6cnWl
 3Ohl3HtSoSlDGfOgM47igkv0g8WBkdpNhmx4rO5n_eVH0xwityWhaJ2YJ6C89X6AP0mhHZUbJzeY
 i1YDMFJL18jvotH2eC1NRTyNLOPWJrEvRhdP3lakj_GHT8C70FqkYMx1c1lCkXKAUwmbEILoV93O
 ocWWHJYmSN2zkY.lh6slfWDxu5usL14NnEnBFTIR5OLeLPRtJ6cAVvq6pTELDHgqQu4xuHjbDyeH
 _aG1RKXwEx2zc235Jwm5zkSlMEKHcTSIBi05GghZlrth86QX7z27hGUSpFXj..nACcn0SkF0z_XJ
 9GFVqqSPciqb_NoNjh3gMOXmXbgisKLaExCkStuOEhFPXnTRHt36ldO38MkCOBjhy9Pun4u_ZHyT
 q2PuECi2YK1yadPia4WBjZslyY7tYcXMrMlwkFFmvC36AYpl6rNuoag0Hh7nLSzW96wxTj4zK1jh
 G5FVo6T.0lSPUkIwDqwqQJLUbF.cWpOqtFZnlJgpnnO_TNPLS7NFcGjcrMzGtemGr5uDmBtIlXuU
 zt7VdRCCRHpKECd81scIODWSYZN6jhdaejTgjVc9OIKUYmGABoC9F_xh5JIxsrJRA8um_7briVjL
 La5jhLsYJCRPDTy_ElWx25eJBJcJy721v33gQTGd0JoS0dsxkPlR7wfK4CpIekVxnsxWMFJCVYAs
 U99I6RXric5AcSWM8lkdP5jaywKOhtPzaOlJi_WxLLDmMw8TSG.AwCszG3eNRXy5dp_pxpMg8f.J
 9Y5M0A8oEnhKlcTmCEvpTP_bjtFmlrUSp5Tq4sAKB5iUb20coqF5H49.CR_.S9Xxo0C40_33abLE
 WuFrR8yKl4lawFZOrnavRc4feaHaC2DGKncTuv8jdBBXOZvOgzG0N8KrZKPxbXFGOxJy1CASVphD
 cuV4U.L3r28wdEu7KFCw4hscIHjTqAzEnt7CGI2T8zQ5_AXbbc54FtX1vOHm1YSfZNYSC5Dovozj
 UHqIPjuBYOw0gpmQDdURm9p7yI8WXPdGq3v2AkVLUls2bhsNyctbNbE_K72A7k9wIRNRIzViYdPU
 pfxzx1E_d9VTxDuPKzzqa9ygqn9pKvkI058DQmoRpGxA3x_QZ6yjp3OHe5vv2NpMd7n7dXLMl56c
 CdKTDQ70kr6XPZu_SvZfcT4UK2Y9tikuynIP71klHjuY4aNoxPQdzeAZ7kxKyuI42GyFjJkISvTU
 zGTQ5f3VBlTxTM_BhTE.P0CQKzMvk_S4kz351gHffFDpQqC.VdVrK2du348cDb6MdEqZ1xaIMk2p
 m9ZfmaG.bfOqr8K.4N.LhscLPilkdXoeF_4g602n2FeQaJUeyGkysyIcaJnsuDwhgeTZt_8YiR9U
 gmbwVWnqxLVl4cEdZz.fdlJWHEIeQ9JAhD6my0oOThs2DT5YhUDwEfBUBPQWPZuYi.m6p0YI7pvK
 lazgg2TNoJF5qVQztyqdhHzLxffRmr5X11WsMV6r6D47xxwZNYSnZjNyQUptNhXeni7RAD8Rp4e5
 kv.3atdOFKCvIuSPFMY0BisNLLbicn9JlP9DRZCUhTq1hHaM6qEeQ_xifSSxheTIiBOjb8I9Wdef
 4aLoEh0dNM_aGCpkq6CvXukTSZci2oBpB8oB1sZWeHlmd8Hua6wTG8hNh919wuAqD0Qzn1Zcvifn
 0yRHWumJ5fN4iVEK3AujwAvgjqeOAatG5ir_fxAcJWb741fA0M2kqlUKWY7x8VVcpiFDFILnsMtX
 kGetZOB1sIRUO__dZuMUcH_by3bheC0cXU1MBPl3oJDnhOQvcSFHvWzqgYTDfFlOeb8SfzMPmaZB
 31KfApoBUUcRPfqUR37f6FW2.a6ZeNZPe2I6U
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 6a888ae9-c4d7-4342-8360-a9f4991ce3ac
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Sep 2026 07:25:07 +0000
Received: by hermes--production-bf1-54b5569bdc-fv65m (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c4451c0cd4386c4b1051306e68eb9ea1; 
 Fri, 11 Sep 2026 07:25:03 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v6 5/7] xen/igd: use igd header for IGD related definitions
Date: Fri, 11 Sep 2026 03:24:51 -0400
Message-ID: <20260911072453.46256-6-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911072453.46256-1-brchuckz@aol.com>
References: <20260911072453.46256-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.64.82; envelope-from=brchuckz@aol.com;
 helo=sonic305-19.consmr.mail.gq1.yahoo.com
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

The newly added mocro definitions will be used in a later patch that adds
support for an extended video bios table (VBT) and are mostly derived from
the Linux kernel vfio driver for the Intel IGD.

Also rename XEN_PCI_INTEL_* -> XEN_PCI_IGD_* to make the names of the
macros related to Intel IGD more consistent.

No functional change intended.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v6:
  - v6 is the first version of the series that has this patch

 hw/xen/xen_pt.h             |  9 ---------
 hw/xen/xen_pt_config_init.c |  8 ++++----
 hw/xen/xen_pt_graphics.c    | 16 ++++++----------
 include/hw/xen/xen_igd.h    | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 095a0f0..ef93ac7 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -87,15 +87,6 @@ typedef int (*xen_pt_conf_byte_read)
 
 #define XEN_PCI_CAP_MAX 48
 
-#define XEN_PCI_INTEL_OPREGION 0xfc
-
-#define XEN_PCI_IGD_DOMAIN 0
-#define XEN_PCI_IGD_BUS 0
-#define XEN_PCI_IGD_DEV 2
-#define XEN_PCI_IGD_FN 0
-#define XEN_PCI_IGD_SLOT_MASK \
-    (1UL << PCI_SLOT(PCI_DEVFN(XEN_PCI_IGD_DEV, XEN_PCI_IGD_FN)))
-
 typedef enum {
     XEN_PT_GRP_TYPE_HARDWIRED = 0,  /* 0 Hardwired reg group */
     XEN_PT_GRP_TYPE_EMU,            /* emul reg group */
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index bbc82a2..a708c82 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1808,7 +1808,7 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
     },
     /* Intel IGD Opregion group */
     {
-        .grp_id      = XEN_PCI_INTEL_OPREGION,
+        .grp_id      = XEN_PCI_IGD_OPREGION,
         .grp_type    = XEN_PT_GRP_TYPE_EMU,
         .grp_size    = 0x4,
         .size_init   = xen_pt_reg_grp_size_init,
@@ -2023,7 +2023,7 @@ void xen_pt_config_init(XenPCIPassthroughState *s, Error **errp)
         XenPTRegGroup *reg_grp_entry = NULL;
 
         if (xen_pt_emu_reg_grps[i].grp_id != 0xFF
-            && xen_pt_emu_reg_grps[i].grp_id != XEN_PCI_INTEL_OPREGION) {
+            && xen_pt_emu_reg_grps[i].grp_id != XEN_PCI_IGD_OPREGION) {
             if (xen_pt_hide_dev_cap(&s->real_device,
                                     xen_pt_emu_reg_grps[i].grp_id)) {
                 continue;
@@ -2036,7 +2036,7 @@ void xen_pt_config_init(XenPCIPassthroughState *s, Error **errp)
             }
         }
 
-        if (xen_pt_emu_reg_grps[i].grp_id == XEN_PCI_INTEL_OPREGION) {
+        if (xen_pt_emu_reg_grps[i].grp_id == XEN_PCI_IGD_OPREGION) {
             if (!is_igd_vga_passthrough(&s->real_device) ||
                 s->real_device.vendor_id != PCI_VENDOR_ID_INTEL) {
                 continue;
@@ -2046,7 +2046,7 @@ void xen_pt_config_init(XenPCIPassthroughState *s, Error **errp)
              * If an intel device is pass through we need to trap 0xfc,
              * therefore the size should be 0xff.
              */
-            reg_grp_offset = XEN_PCI_INTEL_OPREGION;
+            reg_grp_offset = XEN_PCI_IGD_OPREGION;
         }
 
         reg_grp_entry = g_new0(XenPTRegGroup, 1);
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index c5c2d47..be71989 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -12,8 +12,6 @@
 static unsigned long igd_guest_opregion;
 static unsigned long igd_host_opregion;
 
-#define XEN_PCI_INTEL_OPREGION_MASK 0xfff
-
 typedef struct VGARegion {
     int type;           /* Memory or port I/O */
     uint64_t guest_base_addr;
@@ -251,8 +249,6 @@ uint32_t igd_read_opregion(XenPCIPassthroughState *s)
     return val;
 }
 
-#define XEN_PCI_INTEL_OPREGION_PAGES 0x3
-#define XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED 0x1
 void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
 {
     int ret;
@@ -264,15 +260,15 @@ void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
     }
 
     /* We just work with LE. */
-    xen_host_pci_get_block(&s->real_device, XEN_PCI_INTEL_OPREGION,
+    xen_host_pci_get_block(&s->real_device, XEN_PCI_IGD_OPREGION,
             (uint8_t *)&igd_host_opregion, 4);
-    igd_guest_opregion = (unsigned long)(val & ~XEN_PCI_INTEL_OPREGION_MASK)
-                            | (igd_host_opregion & XEN_PCI_INTEL_OPREGION_MASK);
+    igd_guest_opregion = (unsigned long)(val & ~XEN_PCI_IGD_OPREGION_MASK)
+                            | (igd_host_opregion & XEN_PCI_IGD_OPREGION_MASK);
 
     ret = xc_domain_iomem_permission(xen_xc, xen_domid,
             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-            XEN_PCI_INTEL_OPREGION_PAGES,
-            XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED);
+            XEN_PCI_IGD_OPREGION_PAGES,
+            XEN_PCI_IGD_OPREGION_ENABLE_ACCESSED);
 
     if (ret) {
         XEN_PT_ERR(&s->dev, "[%d]:Can't enable to access IGD host opregion:"
@@ -285,7 +281,7 @@ void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
-            XEN_PCI_INTEL_OPREGION_PAGES,
+            XEN_PCI_IGD_OPREGION_PAGES,
             DPCI_ADD_MAPPING);
 
     if (ret) {
diff --git a/include/hw/xen/xen_igd.h b/include/hw/xen/xen_igd.h
index da51f09..469171c 100644
--- a/include/hw/xen/xen_igd.h
+++ b/include/hw/xen/xen_igd.h
@@ -11,6 +11,22 @@
 #ifndef XEN_IGD_H
 #define XEN_IGD_H
 
+#define XEN_PCI_IGD_OPREGION 0xfc
+#define XEN_PCI_IGD_OPREGION_MASK 0xfff
+#define XEN_PCI_IGD_OPREGION_PAGES 0x3
+#define XEN_PCI_IGD_OPREGION_ENABLE_ACCESSED 0x1
+#define XEN_PCI_IGD_OPREGION_SIGNATURE "IntelGraphicsMem"
+#define XEN_PCI_IGD_VBT_SIGNATURE "$VBT"
+#define XEN_PCI_IGD_OPREGION_RVDA 0x3ba
+#define XEN_PCI_IGD_OPREGION_RVDS 0x3c2
+#define XEN_PCI_IGD_OPREGION_VERSION 0x16
+#define XEN_PCI_IGD_DOMAIN 0
+#define XEN_PCI_IGD_BUS 0
+#define XEN_PCI_IGD_DEV 2
+#define XEN_PCI_IGD_FN 0
+#define XEN_PCI_IGD_SLOT_MASK \
+    (1UL << PCI_SLOT(PCI_DEVFN(XEN_PCI_IGD_DEV, XEN_PCI_IGD_FN)))
+
 #include "hw/xen/xen-host-pci-device.h"
 
 typedef struct XenPCIPassthroughState XenPCIPassthroughState;
-- 
2.52.0


