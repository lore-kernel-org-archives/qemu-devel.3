Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BBDC55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpxQZ-0004lz-RQ; Fri, 31 Jul 2026 20:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQF-0004j8-F4
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:58 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com ([98.137.68.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wpxQD-0001Z6-5d
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 20:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785543466; bh=aPSDtc80QxBay9GHhGU8jyIiLkLfb59Aeoc3NEAiIBw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=odcmwXJKuXz0mR8QwvIHWS5CWZdlP4zmZcTbRTSPwnxtghiNAD6/TQex0uG1kZ6c87VlVa0VXjbadj8/iDFtpe6am+9BQCY6jN5mUEMv3s50T+5AhJWeLNjG1hZWpM0D7iYXuYsKvJkdVmMAejowRt3d2fAi/cRXbJC5B5AliX8vVu4fnumhfjXsP4Nk+/MxQwJaf1gchf77Pv+ncoOpGJD5hyhuIs7sy8pF7dkl6zZs9gNwEzz90cd3udKQxc/uZNP5sh7ONYhA/JqjTV0a0qESReB/8TRfHGLNu7msiJotCM9HBwgALv/mWip+ppAN6SfwFMkBhvNID11aZQ6M8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785543466; bh=g9vcxOFW9WO8GJRAE0inlaJ0qmxWPRXJTYNL6abXrOx=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=agPsYFLa4qHJiBe2k21l+dYlmkBwUxm3cth0vIKcnMgRADMnduqqybndvN3sbVV7rTsnaakIBjTg0ZH9f3DXHi3JwzXl7yVQrCGq2O6q4dJfr+K2cAaZEnY3nk4+47osWt8xfWk3xIH36lr6iJHMQcQPzaq7IvgSLioTr6eOoX3rZ4d7T4godBmJiaR4RxARMWDUMxbxqcoX96VcvZJUK9pfeUpGlGp6kP82m+oeH0fnfM2ez1oHpsz71N9SFYNMnTNuEneNkX9v2FS4C/2xlgUS6RaFZsIgorT8PPZZYw7bFXiqdBEcgu2AN1oyDM0wQAEBkRTSMdfbaYwNlPW8Dg==
X-YMail-OSG: CkDsvboVM1kpbg5Mpy3X92H1oMm50miAqVpeWOVcuRiuxh_RK79p5J0uCxvsOMJ
 lbN0Xkg_ZmQlffZEgrgyNzczcHf4ojzXZEIKIgXEHRFED5hbuPP8SWYc2ZVppvdPF9XQxWEK8iO8
 FTti4rEn_IsrYEcNIL3FuZSKUJwRwqol8LHse2H6cntOuDDeHekD6J.XRnkRnONzVvFQ6ebYvSLA
 TATGSvRF5.PATQtkaUET0OzuZHS2Mv5F5TcCqgB2lczBmaFxH3ssVTE_8t09utRPKXa_eqN1ubB2
 IOeD7nU6xYoIoO258hw4A_WJp1PXh.F7QyFeRgLllVAM6uIxtcoAF1tM6QXnQHHUA0ULM6bVs.OB
 zJc3Y_OdfORvvOJqEMfpcVyMVvrs5XOUjm3qmVO0kS_Q_0BBg2zZ8.ZziYJojLuh1Ij2jrwgt4i9
 kDh1ohA9yz03DbzRAfrwCuHoVVXrOrpNYapw6ejRLf_9xG6Ii0Qdwei43V0Nf0hWKzUbfCXUbU9Z
 Ef0HZYaZ3bPTQlkdwlzWiSB95SU.YeDS3EcSn9yLQdQsoBbDbG0JkSqQX81B0KwYdluNjOfwekDN
 GSjZZrgeS8kOaTYeTUwXT0Er5XH_5YGQJlG8htPCh4u_wWkIvf4irB23rH_zSBWKiNv22.0f7NHX
 YOVlx1up6bqbUG7kFpFbhUCgtw2nZomdClWU78utA2Cd2Sflnm3R7g8O8b42A2q8FVRAcvLHgy.i
 McxX9GlONL0urFahnON8lQuy_qUjfuAQUTDfDF_aPWRD9xIPQ6FUC9EwA54GWPW8ivHIlOfZEkZI
 Fcb6Bf4hhQ7mDoNv8m.O1LD3NFCZ00oAhcN2xTjgbzFwiQElHfR_v_Jl7jJPpuD_nHLh0r7_qPoG
 uybctR3S8aQYk8Rh08zqKzypkTMSqtatAiGW12lmqVePQYhyDtHDAGJ9CHHwg5ryBIVorc5osJ9V
 TBa2A8oyhEqMGXXMJr6tE8XArxfGRxj.qw6vezPcQ6gj8xl5udluiuuIgs3q74pIwQtzf8QJxixM
 l9phMgmnPB547YBFj392s7fW07rRzc_x2odOS49UyIWUFKhWR8ypZNdAB.b1A7_1d8e_fOM03s4d
 cpUW2h1l.Sy.CtQaWhTcfoaypOTYDssw5ahUSpIL05S.BFHLDZ__4gcs24fO6fdA2dOUS_3VlMJO
 qy.xLAHsoVktnlb8ZKBuwV2w8JiA2xKwyIpovXvKezptAsg4gAdjO80yCqPtiEsg.a7CnEIGwiXp
 S7.N2Rl6Bhl0uLGGo36ZoWD0yPuCK4xkiP6qBecZmBO_M4.MrZe5LBC_8BpoAFwBhhlshrgV4ieZ
 H.1pDRcSEp0pYMunfbk3nmOQw3zIbMiqL1SZDTpH0fH8TYC_bKTUaQ0JK88vzzPXKrgaY.Wgu1z7
 RsTkD00elxcuICbY6dSukKYGDA5vojeYFe8zLmYCIqfqnwK3V09eYQb9sxTPDV3K0UIc6empwZFy
 _lGfOBxlHdJgzpCeKkvLqXU03zqGrLQXqeA98m1uoPx1LFG9GSyA5UeZmWlN9Ij3QMmTVX_aHC86
 qA6sXis3XKVd2NssjA8VPLKCv.Ft_Tu5vhm6vZi5KgB4n8tTU_VHBnAW3sJNh44fI5lOteLoJWkM
 FD78mKumArUBLsW.sbiMqXmOytSgkbdKqrVK6XU0aygkaJFVMj7Igb2Fbn5UoCdRYhVJVrlOJCVU
 AxldNt56XZmnMBhixdaIyRWlGl018ishkFtbwoEIKAJ5a_2GoX51ETJcCnjE3LdJA8HHJZUS03WN
 tjJo4YxwUTSKFu8mE_zLT3KeZ6qVhQ7T4R96syRMQSB48R9qlLIz9naubkd55wThHWlYUCKYskIp
 pb1jafOcyykirr0hNpXJkKr82Pvezh5lsswAbaNENX7dFcNKFKGvyzOktOUOTymmxixGO0RFHsXc
 OMfwTGk3sU6_gs_PBmuurRxosChZkvb16bXNx3NXs1mo6HOsWSp_ZYzWewn5cSXdf50o20QUEbNo
 9_.BJhAXVrhI7cZtuhb9AC7IZNGx_X7.4zButAgEFLzVBnbpR.vj7lAvssDPohKsN11N2QmnSTsM
 YafAcaGuu0cYUoCZDC2OJstesALPInKyJwTG7QAxyzuK738Spt_zuXmk.KWA_fCCy6DasO2AxkUt
 wVNIXxvJbrp9bqROng.XPyyY3NFhkqLhPWlcEJ0L4B5p0l2HhEhcdrcyMt4TveGUKcS44WoJMDsF
 dfJ.VpvUc1CxkAX5_aHBtYgrRrhs_CJ_m3Y77ESLdUzBlOwFc
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 19268ac6-fb05-4394-9e7e-926ddebd28c2
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 00:17:46 +0000
Received: by hermes--production-bf1-54b5569bdc-h5zdx (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 655a093bcead2c5289eeab02aa189b76; 
 Sat, 01 Aug 2026 00:17:41 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 1/6] xen/igd: get PCH info from host sysfs
Date: Fri, 31 Jul 2026 20:17:25 -0400
Message-ID: <20260801001737.16509-2-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801001737.16509-1-brchuckz@aol.com>
References: <20260801001737.16509-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.68.206; envelope-from=brchuckz@aol.com;
 helo=sonic304-25.consmr.mail.gq1.yahoo.com
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

The igd_combo_id_infos[] data is out of date with many
devices missing from igd_combo_id_infos[]. For newer
devices not in igd_combo_id_infos[], get the infos from
the host sysfs. If logging is configured, print log
messages displaying the PCH info used for the guest.

Introduce helper function xen_pt_get_host_pch_info() to
facilitate getting the necessary information from sysfs.
Treat failure to get the host PCH device id as an unrecoverable
error that causes guest creation to fail. If access to the host
PCH device revision id fails, print a warning message and use
a default value of 0x1 in that case.

Also, use errp in xen_igd_passthrough_isa_bridge_create()
to set errors from xen_pt_get_host_pch_info() and cleanup
on error path with xen_host_pci_device_put(&s->real_device)
and object_unparent(OBJECT(&d->rom)) for errors when creating
creating the IGD PCH bridge.

Add cleanup with object_unparent(OBJECT(&d->rom)) for errors
when setting up VGA BIOS for GFX passthrough.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v4:
  - re-wrote xen_pt_get_host_pch_info() using functions from
    xen-host-pci-device.h
  - add more error handling to clean up better after if errors occur
  - don't consider failure to get the PCH device revision id a fatal
    error but instead print a warning message and use a default value
    of 0x1

 hw/xen/xen_pt.c          | 10 +++++++++-
 hw/xen/xen_pt_graphics.c | 39 +++++++++++++++++++++++++++++++++++++--
 include/hw/xen/xen_igd.h |  3 ++-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 0fe9c0a..c8f08b5 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -862,12 +862,20 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         if (*errp) {
             error_append_hint(errp, "Setup VGA BIOS of passthrough"
                               " GFX failed");
+            object_unparent(OBJECT(&d->rom));
             xen_host_pci_device_put(&s->real_device);
             return;
         }
 
         /* Register ISA bridge for passthrough GFX. */
-        xen_igd_passthrough_isa_bridge_create(s, &s->real_device);
+        xen_igd_passthrough_isa_bridge_create(s, &s->real_device, errp);
+        if (*errp) {
+            error_append_hint(errp, "Failed to create PCH bridge"
+                              " for passthrough GFX");
+            object_unparent(OBJECT(&d->rom));
+            xen_host_pci_device_put(&s->real_device);
+            return;
+        }
     }
 
     /* Handle real device's MMIO/PIO BARs */
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 7df9344..b37f9b7 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -2,6 +2,7 @@
  * graphics passthrough
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/xen/xen_pt.h"
 #include "hw/xen/xen_igd.h"
@@ -376,8 +377,33 @@ static void pt_graphics_register_types(void)
 }
 type_init(pt_graphics_register_types)
 
+static void xen_pt_get_host_pch_info(uint16_t *pch_dev_id, uint8_t *pch_rev_id,
+                                     Error **errp)
+{
+    g_autofree XenHostPCIDevice *pch_dev = g_new(XenHostPCIDevice, 1);
+
+    xen_host_pci_device_get(pch_dev, 0, 0, 0x1f, 0, errp);
+    if (*errp) {
+        goto error;
+    }
+
+    *pch_dev_id = pch_dev->device_id;
+
+    if (xen_host_pci_get_byte(pch_dev, PCI_REVISION_ID, pch_rev_id)) {
+        *pch_rev_id = 0x1;
+        warn_report("failed to get host PCH revision for Intel IGD, setting it to 0x1");
+    }
+
+    xen_host_pci_device_put(pch_dev);
+    return;
+
+error:
+    error_append_hint(errp, "failed to get host PCH device for Intel IGD");
+}
+
 void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
-                                           XenHostPCIDevice *dev)
+                                           XenHostPCIDevice *dev,
+                                           Error **errp)
 {
     PCIBus *bus = pci_get_bus(&s->dev);
     struct PCIDevice *bridge_dev;
@@ -394,7 +420,16 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
         }
     }
 
+    /* Newer devices get PCH infos from host sysfs */
+    if ((pch_dev_id == 0xffff) || !pch_rev_id) {
+        xen_pt_get_host_pch_info(&pch_dev_id, &pch_rev_id, errp);
+    }
+
+    XEN_PT_LOG(&s->dev, "PCH device id: 0x%x\n", pch_dev_id);
+    XEN_PT_LOG(&s->dev, "PCH revision: 0x%x\n", pch_rev_id);
+
     if (pch_dev_id == 0xffff) {
+        error_setg(errp, "failed to get PCH device id");
         return;
     }
 
@@ -406,7 +441,7 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
      * Note that vendor id is always PCI_VENDOR_ID_INTEL.
      */
     if (!bridge_dev) {
-        fprintf(stderr, "set igd-passthrough-isa-bridge failed!\n");
+        error_setg(errp, "set igd-passthrough-isa-bridge failed!");
         return;
     }
     pci_config_set_device_id(bridge_dev->config, pch_dev_id);
diff --git a/include/hw/xen/xen_igd.h b/include/hw/xen/xen_igd.h
index 7ffca06..da51f09 100644
--- a/include/hw/xen/xen_igd.h
+++ b/include/hw/xen/xen_igd.h
@@ -22,7 +22,8 @@ uint32_t igd_read_opregion(XenPCIPassthroughState *s);
 void xen_igd_reserve_slot(PCIBus *pci_bus);
 void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val);
 void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
-                                           XenHostPCIDevice *dev);
+                                           XenHostPCIDevice *dev,
+                                           Error **errp);
 
 static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
 {
-- 
2.52.0


