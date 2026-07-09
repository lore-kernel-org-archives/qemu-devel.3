Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtbC-0007up-5e; Thu, 09 Jul 2026 14:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whtau-0007rp-IY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:35:36 -0400
Received: from sonic314-20.consmr.mail.gq1.yahoo.com ([98.137.69.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whtap-0006OF-91
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 14:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783622124; bh=/ZDT7ysuptrZOTrmM1Jhx5Il0BS4A6/u6DfM5qxpPIE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=SjE4FCKa1O/xDTknG9trKJupPqVawogNk+2Bl1sjj7XuVOkjI3J37D5tyS77nfjdwUhGqT3x9N+c4BSLszAy4E2U5D1olbogZSJHQB7nWvpxJZu76jy8JLzTgWZ5j+Tf0Zah/Ymozc63/9tP/WX8whvtnkvTk6+y2/qGAPUAOPDB7wUrsmqEOZeWv8/XcRKXiHZj1OLuRnIbrN88E9Ww9jIXnZjj8LiW0BwnDMypsFwTjQ7Kq8LYFdSaZYD2yFa5mEuN7yjyEEVUJT+2xlA6BM/7BPKoL92iqX2ZMQb+rA9cdbpQgXvJo+7Ox9/WQM4XDir2O/Gxv5GTy3Yba+Qv2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783622124; bh=BQd1aEnETDWDhVMq1/G+QSZWd6nNIAWzejkvBel8vsx=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=mXqwNYZF9w8gqo3DkhBFQnmd+nRI8w2eVnOYFGgFjykKUemBMR1wr6mO9aRM0/3XjapGDCyrTGWqkp/9U1sTvZJZrqOXaaT6+E1B/yODldL0Mqg0m12Eu7NjDOGl7zdenxYlqcpYHe88wPS/AzCsaSgi/awLSaZ1BKebxXCnHHhBTPje2njpjNxfGjhgtq32z0OMDn1E40xQ+kYOusUU3BJ7Ud0f01lhAVxRQMuLbhBY0VzgWfqbhhgWv7V15Cdsq0wSdusYJR/kP0RmlWpIdc24huCCnPA471euSY2nTzKAUtA6SzcaXsKhZz/Rs/M55mRg7tfxsw0/YPmIWvUnYg==
X-YMail-OSG: 9HSo6PkVM1ls4sRtIaK5FEUYqKHGUe7XaRuPpUX8y1KwW1MyZHwMqJZuyklz2wX
 XVOWFtGV0N6mWcARxCf.8adcc4Jn3ORWarzkNO3Wk1AO2sKfVF7crPEQK25JMng3Y3gT1Nhf36df
 fecctlBFWswhHBp8W1taXL5qR0z9L6DWvf7TOXiYbx6JDq1ZCoGA5P53ALINeYFKoSB.tz4SkS7l
 103S4hefhjeBIUxwbeAIy9ufDwUxYC8eGLfjYpvQ9rWtfhQgwOYOoG7DNM9auWwy7AFXqJtVmF.o
 KkFfWWNklFKP90.Y3WMyp0IfZjKxie2BDeOcp.t3s0zUw8GGa8AfysYijKVfKQC_fKQ7viyGxM9B
 T1lxSlbh3Xe4b4fh5KZnwDDIf4v0NAx.RlrHYXvT1eY7KjOPYcmzpqhKZjCfXTktQXW_qhQNdLRD
 Dh2dy_uFXkWfUiWiqR8EqCqwxLwF3VFO73unl5rJfsQxtL8n_Nch0NkfkqfGPLFKd0nhkoRxuTDb
 WaJc9nNpz53saGcliLosfR3Jz5xkD4XuH807IwX5d2yLpMLPrOzh88x8cSi2kLztB0t6uHA_vSiw
 Drq.t629.ski6Jt0KUq1MMYHCtgnBduz7W9b95wYeXd1WhBLeQv.gZ09Rpc0NZCvXUAQ8fmocpx1
 BPv5pCrzGs185ol9LUVMpC12Yyy4hBDHgoD2mBY04krnBJJCsVxOI1cmd23WnIP5obNMMxhjTzoE
 N0ZsqJ3U9w.CTHwIEfA5ZJcq9Xd5PNJxbw5iuE48caFAq6spM8FTbvComP_p9f_e.YErUCYLpOKA
 l1_QN3K50sn9syRTzp_FvQqzZ_noFAZKOjvHs1O2vfIpqo0e1ugqnhrJgRXaQvVVj8TWm10TyJL0
 PWYTr_ABc_5jKrY0XxSQtmM39x8Euu3K3fYSIITYwDmXa64MWm2WQceuuIJlS_4PqIa0Z97xoJJg
 9xTrCyZttey593cyCEt2m8KuG.80WJQEe5c8DnkWDs9HUh59OGkY_FtOAQnBu7UXw_3cqFB4aqeK
 QNtDZGqZEq3PM_p49YGOd_Jd4sAgxkIYVd_.tVdytqVlDYsU0q_3tMhSLqC87_qpw_QH.odw11NF
 NIOFUOJZNOYEQGsAnvL9IyrJdr3cqYqY3_CoQA6FHji8MOU45.lhWY9qIhBeywhYgUTPnlrml169
 vrGIyrszPmQPfJdT0QZEWPdgQIiMpBBw8n1q_kmrrtI6_hjN_oP5zbyUQWj0Yo6fNpJu2x.8dsnO
 UNgI_sLnsoZewXW0nsRJnLwI3akuPU3OYLuBcKE7lW5weECNoYWXh1k9NMgV5vZJ6L6GBdBgfO6w
 G_ZjEi8dxn3IdiNB78n4l5V1M0_tE9oNaYDgOQkHSQIZDSKq4WehZj7zoBC0GDACOTJSMvcvsuFG
 PAdj1qwjo0UOpjzvxAQz2poVbEXKaRerJVbl4.HCScXqCpUFtI11mX92uPzaXw9yGwsqSSMi.d1D
 aLIj71LqPl0Wi5g0L5xGuTSnUux.PjPXxSFiDKNFLUn_lOLdcV49PMgeq7S5Se.l6l6xaK6O0.I5
 N.TUUpa1P.pw38OAFSJIruIpj3EzJDkOkRJw_Qh5TfveDjlY06OPWT.1wZp.GcsUCCGFzO9xt37H
 jKEv8o2MQJRyarF49JOv6xopCp96.WzRrwjtLwkJZNdkBZxTfKlsG2u0Il5cLqH0xhEUf3rD3zV.
 Nk7BTOcTnYv.MEamD3UG57lkovdcWvp92UUAV9rTXULHXLA5yafqmBpjsEzmps1DIXg224cO62ee
 vv_7Y_zJaGNgslC2goKVkzkUJ5FmsxlL2Vrl55TRDXm.hdWvkVd4BMP.iBDeFoD.RgrYuurLTG.t
 wPLndfwPOB.RlIV_Uv_dQsCjLuRt._YOIbCtNcEUXabxImLJBIefg5UhldFZlAofPlg1sKOvtgN6
 qirFlJaE7TP1gGC_fpMOAygsEpFMcoImhpqLk9yn0wBOu6Su2_w7qe_NO0X3fmJ6El9Zw89ewiGG
 uwzZjHPWIUoLyqWVSm7O1GulS9Ih6L4xf6KWtrTSoMyh.ekxbwYjlEX7pq4uNnfxyHHASs2pXlT1
 rRClJ1Q1Pt4E1omYplYbMIrO.tmIlvBis6_Nd7maBoUfH3CPc6yvT67ktR6Cd4T2GrFWaPMt5oKU
 RjJjK34SWU9GWuMTOlXziIDyA4i3ZwL2ARTJGLBxPK3o9hHhLWP1sFHCFCY_172HG2DIwmt9EHJh
 bP0OqiSZapZXW.SWrF6m43DWZgoVDVOm3EqS47A--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: f0f93a08-abbd-4926-a83f-f5164795b146
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 18:35:24 +0000
Received: by hermes--production-ne1-7568ccb994-fjmzg (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 910e3b4d72a347495c18993f77062a0e; 
 Thu, 09 Jul 2026 18:35:20 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v3 1/3] xen/igd: get PCH info from host sysfs
Date: Thu,  9 Jul 2026 14:35:14 -0400
Message-ID: <20260709183517.25866-2-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709183517.25866-1-brchuckz@aol.com>
References: <20260709183517.25866-1-brchuckz@aol.com>
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

The igd_combo_id_infos[] data is more than 10 years
out of date with many Intel IGD devices missing from
igd_combo_id_infos[]. This means that many devices
that could be supported will not work with the
current implementation.

For newer devices not listed in igd_combo_id_infos[],
get infos from the host sysfs to enable support for the
newer devices not listed in igd_combo_id_infos[].

Introduce the helper function xen_pt_get_host_pch_info
to facilitate getting the necessary information from
sysfs.

Also, use errp in xen_igd_passthrough_isa_bridge_create
to set errors from xen_pt_get_host_pch_info.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v2:
  - call error_setg* after closing files instead of before closing
    files
  - in last line of commit message change "to propagate errors" to
    "to set errors"
  - add stable to Cc list

Changes in v3:
  - whitespace fix at line 380 of xen_pt_graphics.c
  - fix Cc address for qemu-stable

 hw/xen/xen_pt.c          |  2 +-
 hw/xen/xen_pt_graphics.c | 82 ++++++++++++++++++++++++++++++++++++++--
 include/hw/xen/xen_igd.h |  3 +-
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 0fe9c0a..474606e 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -867,7 +867,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         }
 
         /* Register ISA bridge for passthrough GFX. */
-        xen_igd_passthrough_isa_bridge_create(s, &s->real_device);
+        xen_igd_passthrough_isa_bridge_create(s, &s->real_device, errp);
     }
 
     /* Handle real device's MMIO/PIO BARs */
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 7df9344..2ef941e 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -376,8 +376,75 @@ static void pt_graphics_register_types(void)
 }
 type_init(pt_graphics_register_types)
 
+static void xen_pt_get_host_pch_info(PCIDevice *dev, uint16_t *pch_dev_id,
+                                     uint8_t *pch_rev_id, Error **errp)
+{
+    FILE *fp1, *fp2;
+    char *endptr;
+    char device_id[7], rev[5];
+    size_t len;
+    const char *device = "/sys/bus/pci/devices/0000:00:1f.0/device";
+    const char *revision = "/sys/bus/pci/devices/0000:00:1f.0/revision";
+    unsigned long val;
+
+    fp1 = fopen(device, "r");
+    if (fp1 == NULL) {
+        error_setg_errno(errp, errno, "Cannot open %s", device);
+        return;
+    }
+    fp2 = fopen(revision, "r");
+    if (fp2 == NULL) {
+        fclose(fp1);
+        error_setg_errno(errp, errno, "Cannot open %s", revision);
+        return;
+    }
+
+    len = fread(device_id, 1, 7, fp1);
+    if (!len) {
+        fclose(fp1);
+        fclose(fp2);
+        error_setg(errp, "Cannot read %s", device);
+        return;
+    }
+    len = fread(rev, 1, 5, fp2);
+    if (!len) {
+        fclose(fp1);
+        fclose(fp2);
+        error_setg(errp, "Cannot read %s", revision);
+        return;
+    }
+    fclose(fp1);
+    fclose(fp2);
+
+    val = strtoul(device_id, &endptr, 16);
+    if (val > 0xffff) {
+        error_setg(errp, "PCH device id is out of range: 0x%lx", val);
+        return;
+    }
+    if ((endptr > device_id) && (errno != ERANGE) &&
+        (errno != EINVAL)) {
+        *pch_dev_id = (uint16_t)val;
+    } else {
+        error_setg_errno(errp, errno, "device id strtoul "
+                                      "conversion failed");
+        return;
+    }
+    val = strtoul(rev, &endptr, 16);
+    if (val > 0xff) {
+        error_setg(errp, "PCH revision is out of range: 0x%lx", val);
+        return;
+    }
+    if ((endptr > rev) && (errno != ERANGE) && (errno != EINVAL)) {
+        *pch_rev_id = (uint8_t)val;
+    } else {
+        error_setg_errno(errp, errno, "revision strtoul "
+                                      "conversion failed");
+    }
+}
+
 void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
-                                           XenHostPCIDevice *dev)
+                                           XenHostPCIDevice *dev,
+                                           Error **errp)
 {
     PCIBus *bus = pci_get_bus(&s->dev);
     struct PCIDevice *bridge_dev;
@@ -394,7 +461,16 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
         }
     }
 
-    if (pch_dev_id == 0xffff) {
+    /* Newer devices get PCH infos from host sysfs */
+    if ((pch_dev_id == 0xffff) || !pch_rev_id) {
+        xen_pt_get_host_pch_info(&s->dev, &pch_dev_id, &pch_rev_id, errp);
+    }
+
+    XEN_PT_LOG(&s->dev, "PCH device id: 0x%x\n", pch_dev_id);
+    XEN_PT_LOG(&s->dev, "PCH revision: 0x%x\n", pch_rev_id);
+
+    if ((pch_dev_id == 0xffff) || !pch_rev_id) {
+        error_setg(errp, "failed to get PCH device id or revision");
         return;
     }
 
@@ -406,7 +482,7 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
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


