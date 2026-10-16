Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C3ECC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhb8-000059-Lp; Fri, 16 Oct 2026 09:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHezE-0002rw-5V; Fri, 16 Oct 2026 06:16:28 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHez8-0002O5-8Y; Fri, 16 Oct 2026 06:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145770; bh=TYxreT4v8QNosSDK+OHXyXxaw2PCHbyqu1z4Eyi5cWc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vRCSvRFGXyQXFOfo3SqRfMXxNAQ5hpD6q8IuiZlrD9rJjDZsEyODbY0TO2eeazLg8
 yfyY7bKkl+huvJGTKSs7K+y9GNdazonuBl+xrjtRIAa44POqvHuc3Nt9z7hEW4P8xM
 hPvxCcwCvu8XSBnY1AVU9VKxqTyUyy2HQDrL8Hk8=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 4073A06A; Fri, 16 Oct 2026 18:16:07 +0800
X-QQ-mid: xmsmtpt1792145767tnuofolmi
Message-ID: <tencent_C40E52C43367C7292B3F69BC13A88845B708@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNzn7h2rLQk18/m/RrhCgwZztJk8q20Ukk1ctdaKy2eZ0AR1A+3q4a
 w5qwBRPdi2EetmXol8WzSVeE8B0ZZarmWpNqykKnUzN2SPazMWAwBXiCD6Dp30FJza8y89fDaDp8
 Ojpb0KAIQQc2uCfWnj5hD+1fbJtNuNJ/iV0tvNN8xaYm9EwAjGdbmY5/wSgSKvpbR071t6FA9NGW
 GpojpXs5Trz7OYTO7lRRywKS+AB5D4sSRMp6sFFdp7Alry1YZEHTNFECbk9aHg8ewYlogImKUqSY
 pVAh0Vg+KNKw7YIjxXjw9vN5dxNUY6lHVh9PEgUd517eMQdlwDHCJSLXJp43at2EoJxFOXQ10Zck
 Uz9LkcpFo3h5NDQ+FM99Aqu+HudytTFR1OPNdXlUj6rEwzhBBPtskE/9dDSQtf368pFJmBkE/Y5C
 lMKx9WGbbeZ0WlfAXTdq4VIVEmjpuqLIKoKCi9/e1Y5idh897EIPZwYcFsNxJSRjdTOX1FomNCwK
 MsiRB9G9QwhRQm1RFCecLFerA9yseWj7GWBMAXx/gYtv2IGiEESqpte7iR3prLbRDphGCvP4Vcpd
 wimSVGWqYCrWOPgYmSCE3CR8rQiBqAqaAuA75qXiTwPrbUT+6yYMgwiRfpgUirR7qVu2NjiKjMqW
 nIkBQ3P7H5QH2Ds/NC4SEKmE0bXbzSXiVpsy/sG0TnuCP65QY0pR+xGsqvP4W/BdivnlU/jpeO18
 q3jnyTJ630kKmoGwU0x0gQMVDuFwFWhozXNJN7lOY3bOO/79HeDL0v1zx/04MW2mluwMm+aYZC/G
 +GtWPTUem5vQQcgTXomodWA69COouooQU4aWxS5hJe3UX/D+o6of2YMGZRaOTQZ0jYeIbLi/vuKA
 Kcb8KQDZ60w9sk0uENJ6lZdS+ayBdyRUJznQhqidXRiBae6dDKOyHy+MywJQUE+I98q3gksFUYeI
 OVfOXxbZj1q3f4Ya16IISaafyrdbWwXdMSZNWU5t426UGlWqTRC7zn5bW/kMow7VOH4bQvqi9Cj3
 zVumtrQowUZVcu8Ze8sPsMns0kacEvPdKlYmWs6OWuOqGI5VWBYEvsb1iH0jVjtzvk9dF0tncfu/
 djXo9N
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 20/37] hw/arm/virt: Create memory-side MPAM MSCs
Date: Fri, 16 Oct 2026 18:10:40 +0800
X-OQ-MSGID: <20261016101058.1900808-6-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.87; envelope-from=2118537295@qq.com;
 helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:43 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

With mpam=on, create one mpam-msc-mem per NUMA node with memory
(256 request PARTIDs narrowed to 32 internal PARTIDs), or with
mpam-min-msc=on a single shared MSC with one RIS per memory node
and extreme narrowing (2 internal PARTIDs).  MSC creation requires
NUMA nodes to be specified.  Cache MSC creation arrives with the
next patch.

Based on an RFC series by Jonathan Cameron, adapted to the current
cache topology API (machine_get_cache_topo_level).

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3ad7de8..77942e7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2144,6 +2144,63 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
 #define MPAM_VIRT_NUM_PARTID     256
 #define MPAM_VIRT_NUM_INTPARTID  32
 
+static void create_mpam_msc(VirtMachineState *vms, Error **errp)
+{
+    MachineState *ms = MACHINE(vms);
+    DeviceState *dev;
+    int i, count = 0;
+    hwaddr base = vms->memmap[VIRT_MPAM_MSC].base;
+
+    if (ms->numa_state->num_nodes == 0) {
+        error_setg(errp,
+                   "MPAM support requires NUMA nodes to be specified");
+        return;
+    }
+    if (!vms->mpam_min_msc) {
+        for (i = 0; i < ms->numa_state->num_nodes; i++) {
+            /* at most 16 mem MSCs (4-bit selector space, SPI budget) */
+            if (ms->numa_state->nodes[i].node_mem > 0 && count < 16) {
+                dev = qdev_new(TYPE_MPAM_MSC_MEM);
+
+                object_property_set_uint(OBJECT(dev), "node", i,
+                                         &error_fatal);
+                object_property_set_uint(OBJECT(dev), "num-ris", 1,
+                                         &error_fatal);
+                object_property_set_uint(OBJECT(dev), "num-partid",
+                                         MPAM_VIRT_NUM_PARTID,
+                                         &error_fatal);
+                object_property_set_uint(OBJECT(dev), "num-int-partid",
+                                         MPAM_VIRT_NUM_INTPARTID,
+                                         &error_fatal);
+                sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+                sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+                base += MPAM_SIZE;
+                count++;
+            }
+        }
+    } else {
+        int count_with_mem = 0;
+
+        for (i = 0; i < ms->numa_state->num_nodes; i++) {
+            if (ms->numa_state->nodes[i].node_mem) {
+                count_with_mem++;
+            }
+        }
+        dev = qdev_new(TYPE_MPAM_MSC_MEM);
+        object_property_set_uint(OBJECT(dev), "num-ris", count_with_mem,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-partid",
+                                 MPAM_VIRT_NUM_PARTID, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-int-partid",
+                                 2, /* extreme narrowing */
+                                 &error_fatal);
+
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+        base += MPAM_SIZE;
+    }
+}
+
 static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
@@ -3216,6 +3273,10 @@ static void machvirt_init(MachineState *machine)
     create_pcie(vms);
     create_cxl_host_reg_region(vms);
 
+    if (vms->mpam) {
+        create_mpam_msc(vms, &error_fatal);
+    }
+
     if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
         vms->generic_error_notifier.notify = virt_generic_error_req;
-- 
2.43.0


