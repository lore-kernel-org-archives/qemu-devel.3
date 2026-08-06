Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D58AC55174
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrmYE-00025R-1P; Wed, 05 Aug 2026 21:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmXx-0001rT-0M
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:22 -0400
Received: from sonic313-10.consmr.mail.ne1.yahoo.com ([66.163.185.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmXu-0006M5-M1
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785978314; bh=u2ICDeT8EkzZPEkZ0GkRz/PZQjnhXux/kxcij9AaLW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=q/G2BOr7WloM0VHKXN2nwJ0rDbxjY+y04yBIggP1Mgn2Y7OR2CGFfBoeairu/dufh8WlbcUEY6Z2/sciIZ6dqFa/+SASV3ri2Ab+tEeIa+k8k+A3xeqGV8f12y8jlJAUoqWewX/z0ntm4hlnXNQtSovCU2URfCoKcOEezI0PoKQ6DwJI1P2KCxMIBj3Vnswja30kIwJlOF0P+1PULgbRPuA6KonN4yE4fnQ0O7DiI2f7BIHq29AnbTQK55MZXEGhtZMChFu7RHKC9zmTkYnRqPzYy+S6CRuWFsGNbHGMXaeFy4vl55P1YKouRuvu4TJ5Q72Ba4yBWEtYvNLwA57SSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785978314; bh=cHWT7ryeN9yIxVQ9xAUubGD/UkRKAGncO1k5XMUDO6e=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=O0rd0dKkVq4tpJT9hTf3se/kJZ17q2puZXxbjqBvuuSDBXUV+0IEKNPAHuRL5Y/E/mxOU4KPKwaFKCjZ2JeCGmQrD9OqOG5tdWDqI+CsR3wxIP4NuBq2DSOdeeJE/xCaFaiD+mnFriCGLbca39xSpYbP8F0pfhV772DaSSg9/EQtbQyJ5UdHX5OQtr3b+ARyBu/Z8/I8Lfv7/q+0f1XOzYYQXjdZt18FqlQxiLVX4nxPST3Mh3ngFf7MBWnmC5puHlvW6OPAa3NOZ+qFk2Uxy3qcSxol0EPAoozlUnwx+CMJSx1iUAGWx6Uc0Gjev00UyK7+/3iO3VasZMCAvTpHCw==
X-YMail-OSG: uHAyLrIVM1mZELM3QZA_rjjFjQeZhI7GIk5ir7ZwfpD8woO2tdFJd3oV32S4I9F
 K2XpvLxjyaHCsGm5lhkVt09Z9P7303YQT4Q5ZwRJHwntssS_K3ic2tbbHpOKBeoVQtyLiisy615E
 csDiHLsrQU8EtCmfHbVykC5UYKAOrjRfP2P5qk1VxbbKmvxHch.HIu9eASabKw3iMBBzXRlKvJrW
 mhQgJossJjKDdlntNwQJIWvSgLOhaAeaEBUbG0HomTQRXfq6PSXegaupD8itEACXgRvArIlV8LIf
 P_h9cEBc_ciT4ba64b6m486boLteuybUOpOZuYzjVUoeEq4ZxOoqGFDa2pQGywtEv3Y8YKey06Y5
 27yljMXpdI2eO0bo.ItreXOATlThMVr2jO5Px7dpFp28AsfIMw2OOi3K2Zss8orDSYaRhhNAVBtp
 tn0hsEsva7TF7gc8s.B.0XW223e9HiEel5_Upfh8lfP5mq7LVqJkXGTAzMB2gRzhEXkc0HiXYJRi
 grdExkne7VxFh21zuWy0u.soCIJ3ufsoNMpRbJvupc7.bwdE.CQ0lwLibfIWWamgcVwSo1fYFB0B
 SnI93oS4xdbQhmMfbUtYahifr1uW1SFE1_ekAkaxX8Wwza.5CrgPEdKCVn.D5f6HSp6G40zGZxJH
 tbPSecfhrVHOze4Y6wcV34.3up0tEAAsHMjcRMLP1SM0mBT7oaBcxtLliOEp5N6q2KL_2VMaprib
 iA1b7ydElQHUUyXxWXhWDPTSrLqEdlCsIxYt9dRLYC8qtljptTG05wBZM26OcNf56hLepRqvFR5A
 l1iPgWs5NWId1xUf9lkzhgsRcIQKa9sYSP2BidBQcO1Vs2uqd4cVzYK8DouYCK0rpTLyD2PzhkIr
 Ok8.xETvZL_NE1ZYj857hfYCFmFKzdYFP4BOKacRMfL7SOfN.a7ltErRM5_kZBzmP2m9jKxpOjWf
 k_j70SvhyGamQQN54hrIvygyjQZJ8giDp.Fw3SS_XFUf0sE7j0mAmZTZxZ_XiXUsSTx5dXylbINV
 bc5QjQm2IGVCi.62Eb96lwu9iFyWiy52amQ1L7UB0xswSlOakL3vC_SENQ9zXe_2xcySeX58d7lJ
 Soto98fB_2vcGdhXuRe9W3RkS7XgLKg1R1Dzofpy3AXrmvXuNNeOMDshs6TiLsL.Pueggk6kihu2
 bFxK2xGsKHxfyKQ.b1YYoZ7LvnfMml5PfyqXzjc7bsDFx2N4veUqCEvYm4rwMbN.rCvd7u60eQLo
 jRlgir.3sh8QzmV9o9cqCd5dAWqXEhEk3erKpt4qK1VjmDC8MHRaizo_lXxc0McNEOkack75ImY9
 up_6vHycvMTGkriXfLU7_hJFqHlgPKvISmpqNh4DgUzWmza1Ma7Ka3C5CWxV2BPB6zxQ6cU4b_b1
 wtF81xthkg8Y7FIWJO.5h99P3D8n3CZgbl_T9ZiSsK_6ep1QRnWxMJkGBPFjgTTKb6DGGUU_DfX4
 KtEdF6g6L1cHlaMQ3hSBQbac1a3E_TLk4v_RA7wl4UZIzYIKyJ.P9beAtfJvPKQP_dLg_7ARpMvz
 LyLCk_S.h3k.JP.gjKOVyuDRXW8kfLZLxOkIt9OND97EXP.16243DxddmeOXfs1UBdkUZVkM_At_
 lRZ1b1rw6uiVFCSpNWE.bSa8N1vfdgLbbUwbR6s3unJpaRU7vWNimmusMHdpV_FAof4aeXZDPEC_
 DwtlyamEGIpz0XvX5n8D2_GRAj_zpKfCp.vDNPb.IQix4qsjL0X76rGISbZnS6nLt7sSAAktgWEf
 pIN0gXy_dVekv2zE85l9.cKfQF0aj7GEABuAqYfN4HRWhcQOy3TxkP9OF.pBBau6u.sR7p79mTw2
 FhBpFvS81qjLLQF.3k9sPSxlxtvxo4O70k.G2Ih0d5d11lNpXgMOcMcDhYng1N3iPGXYmiCEKtsQ
 EpLhaIGkXIiA26Aho8HO8uV74fUuyaxgQyRzuGeqarMoJT4SZY0hpH.k7b9uj3wEp89l4pothTBq
 mE0eKkaD2KqgH75ZlUyolwwPIVWOWb.UbWxtkzUVw6zueIQdv3NYXtEqBYYI2VqIWfyUMYaefW0R
 fMcGHtJxOyMTtc4LZ9N31U5Ro9ullIbn1WmeTAJufFC_D2lTJBOiGP4ybsnDlqx38QYjAF2Qx8i0
 rkGJfGePAyZ3N7AGcjNUimxb2zhYj3ZsB5dfE.ItUDcLgSaCD7Csjck_J79W5itlfx0hZcGfa2Te
 VOOs9IVQcX0oDaJQ9axGTiCvllVH07pLyZ.56K5rz
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 3e58ec08-0dc8-4d98-83be-2a7e74387771
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 6 Aug 2026 01:05:14 +0000
Received: by hermes--production-bf1-54b5569bdc-xjdx5 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 734f0c8329adecc00a98ec91cc943adb; 
 Thu, 06 Aug 2026 01:05:10 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v5 1/6] xen/igd: get PCH info from host sysfs
Date: Wed,  5 Aug 2026 21:04:51 -0400
Message-ID: <20260806010506.492490-2-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806010506.492490-1-brchuckz@aol.com>
References: <20260806010506.492490-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.163.185.33; envelope-from=brchuckz@aol.com;
 helo=sonic313-10.consmr.mail.ne1.yahoo.com
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

Changes in v5:
  - Shorten warn_report message to resolve checkpatch line length warning

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
+        warn_report("IGD: failed to get host PCH revision, setting it to 0x1");
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


