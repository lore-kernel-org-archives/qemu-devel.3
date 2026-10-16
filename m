Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0433CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaJ-0007Xf-1P; Fri, 16 Oct 2026 09:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeuD-0001Ne-N2; Fri, 16 Oct 2026 06:11:17 -0400
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHeu9-0001xu-Dc; Fri, 16 Oct 2026 06:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145463; bh=T2aVuixcbXg2L63BOa+6sJHS5UVg7DPyy+uwZi5T7tw=;
 h=From:To:Cc:Subject:Date;
 b=m8zu7lsQjRasg2JZv0cMoqgydKGKIOcxtZ5YQz3ZSBGj8LmTa5jGgXmFzilaO1dVe
 F133nHeLgLPztb8H/ZMNopFPQ0VDmD/DoceGtVvjWRFgz8Np4+/qrzMECKPpcUFIMC
 48J9lS/bL2CncnUgEN2C8ba4feVUIG48lWMLkYks=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 2C0284B1; Fri, 16 Oct 2026 18:11:00 +0800
X-QQ-mid: xmsmtpt1792145460tm1jwu9wu
Message-ID: <tencent_4A73E52B4D6BC21D11E7564A8A6EA6EF5805@qq.com>
X-QQ-XMAILINFO: NIcblQ53mXmRU7jMe/h99tZu6vaGF/hsDxYqX7mbb62Wrx4/E6yV6MT3HNuY3C
 qSFZB3iYN8m7kSRWCprmmuVrbSEKZYQ/CoPPdAmdRtjt8cGZ5EsI28SgjceifIwSudqrSd1vbFRt
 qykoERulsgRNKszc1tZXtdMgDj3KFzUIOWrzPXOxx3Hbf498v46TZww7gOJ6/wv1bsgDnYxj8M1L
 ByNSHhWosc8Wp4CHDxdvyfY8tZv5Qib38cV2eS/6sb94P/I5FQpp544NBrk2bax9xVucngTvpQ7z
 5o0pXfhIN3z19On+NzncjHorKxjF6vtJksmxgPjA7jGbMqKTGPTqXHqtDdZF0Wbx15cOTxR8WgIM
 uYa2NaZ+X35e8ROR7O3PUjHr8WmR2018etrbx/sxpsvlZqAIOrd61U9aD+VTThhVdh61mqSKaxBJ
 itoVLJoapcZ5m1GRJtxzfJARN0HZ8RYTNb9mL6oIn1Nl1O311ZJ4DBI/8d9ZyYRTkp9t/yAhN8wY
 85lxPNqQFqklagbD7O8X9ro7CfjFAlRMS5DDa/UJ7unJRfILoomzxdetsZC+hpt3w6Jm6XjsfcU1
 PNNhfysenXVheNAiut0qyP/+w3wl/65OXtMz0cuMUt4KX2Fk06V+Y4uUQ1V4IntwznMQWkTNPjVf
 8GuNTEGZ6bB60l7bd02bPsV/gh7ijbDsqE4A/1njkywMH7GHpMSQ4abpTHMMIPM6BjG9RZ20nROD
 qhKJ6IFEBQmyC4MWISYA2kMxWr5X9BfNjECUVpwvtIxxLRTnQruRPb+wCkPBX9Ib9MXrTN+S3C7H
 TO2jiaMiLXFRURXWf8UoEH3bwhDNjjl7mux3ggMm6b7RH7sW6mi5FdKBXr/E0xv6v/pwRmByfrEx
 NVZF1ePScmYhrpwjI49Gy7SvUr+hpVyUR8A8+Iye0cqwmuhL0AvCPvxK4YcoryZoOz9cI7oXZI0z
 xNQlsWRgH9i/qBTZcusJ6j1o2+BSWrs7+4odlceij/9RmG0PEs5EyjWQQlBXfgXtMV8T+Ty+DV5k
 CYGhoYziUwfXa400sSYCPU9cZhLtoHnL0OWUQKyaqtt+Afh1zCl/SDxnybyT63hp4qkleiJ6IKCv
 DBtV7OsOMxG1kTwgKjZrddJrXyC+xZCiJvgseOgzO88hp4OJk=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 17/37] hw/arm/virt: Add mpam and mpam-min-msc machine
 properties
Date: Fri, 16 Oct 2026 18:10:35 +0800
X-OQ-MSGID: <20261016101058.1900808-1-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.210; envelope-from=2118537295@qq.com;
 helo=out162-62-57-210.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:41 -0400
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

Add the two MPAM machine properties: mpam=on enables MSC emulation
for the virt board, and mpam-min-msc=on collapses the per-node
memory MSCs into a single MSC with one RIS per node.  The state
fields and the property accessors only; MSC creation arrives with
the later patches.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c         | 47 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d19251..aaadff6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2133,6 +2133,14 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
     }
 }
 
+/*
+ * Partitioning geometry for board-created MSCs: 256 request PARTIDs
+ * narrowed to 32 internal PARTIDs (enables HAS_PARTID_NRW, so resctrl
+ * reports num_closids=32).
+ */
+#define MPAM_VIRT_NUM_PARTID     256
+#define MPAM_VIRT_NUM_INTPARTID  32
+
 static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
@@ -3498,6 +3506,34 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
     vms->virtio_transports = transports;
 }
 
+static bool virt_get_mpam(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->mpam;
+}
+
+static void virt_set_mpam(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->mpam = value;
+}
+
+static bool virt_get_mpam_min_msc(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->mpam_min_msc;
+}
+
+static void virt_set_mpam_min_msc(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->mpam_min_msc = value;
+}
+
 static bool virt_get_dtb_randomness(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -4303,6 +4339,17 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "guest CPU which implements the ARM "
                                           "Memory Tagging Extension");
 
+    object_class_property_add_bool(oc, "mpam", virt_get_mpam, virt_set_mpam);
+    object_class_property_set_description(oc, "mpam",
+                                          "Set on/off to enable/disable "
+                                          "emulation of MPAM MSCs");
+
+    object_class_property_add_bool(oc, "mpam-min-msc", virt_get_mpam_min_msc,
+                                   virt_set_mpam_min_msc);
+    object_class_property_set_description(oc, "mpam-min-msc",
+                                          "Use RIS to reduce the number of "
+                                          "MSCs exposed");
+
     object_class_property_add_bool(oc, "its", virt_get_its,
                                    virt_set_its);
     object_class_property_set_description(oc, "its",
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1..c847136 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -177,6 +177,8 @@ struct VirtMachineState {
     bool ras;
     bool mte;
     bool dtb_randomness;
+    bool mpam;
+    bool mpam_min_msc;
     bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
-- 
2.43.0


