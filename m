Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49D606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3jEAkCS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOufa-0003DT-ND; Thu, 05 Nov 2026 05:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf5-0002so-JJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xOuf3-0004A7-05
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAfEuatci1dHiVvN5A9X9C5vcwub+GNy2q0HTBA89kY=;
 b=M3jEAkCS3NnVzItg4fso/YirkntxMZv3hCRurOX7vWUSYUI2yUWwVuZoBDuokWclVO3rq5
 B1XISbe8NiLQT/o2HBJaaDmp7nyMEvaSebVLGUmFr65h1tGrZoq2NLdeVNSe9lhYHsaA+t
 R57LcqWLGMbjaFgzu8IbDQzoDsUtxvs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-o3L5yvUDP4mSOEyshuiYkA-1; Thu,
 05 Nov 2026 05:25:34 -0500
X-MC-Unique: o3L5yvUDP4mSOEyshuiYkA-1
X-Mimecast-MFC-AGG-ID: o3L5yvUDP4mSOEyshuiYkA_1793874334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB3921956078
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7317E1956049
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 10:25:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0670921E6880; Thu, 05 Nov 2026 11:25:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v2 2/3] qdev: Remove unused DEFINE_PROP_ARRAY parameter
 _arraytype
Date: Thu,  5 Nov 2026 11:25:29 +0100
Message-ID: <20261105102530.1848823-3-armbru@redhat.com>
In-Reply-To: <20261105102530.1848823-1-armbru@redhat.com>
References: <20261105102530.1848823-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/block/block.h          |  2 +-
 include/hw/core/qdev-properties.h | 14 +++++---------
 hw/input/stellaris_gamepad.c      |  2 +-
 hw/intc/arm_gicv3_common.c        |  2 +-
 hw/intc/arm_gicv5_common.c        |  4 ++--
 hw/intc/rx_icu.c                  |  4 ++--
 hw/misc/arm_sysctl.c              |  4 ++--
 hw/misc/mps2-scc.c                |  2 +-
 hw/net/rocker/rocker.c            |  2 +-
 hw/net/virtio-net.c               |  2 +-
 hw/nvram/xlnx-efuse.c             |  2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c |  2 +-
 hw/riscv/riscv_hart.c             |  6 ++----
 hw/virtio/virtio-iommu-pci.c      |  2 +-
 tests/unit/test-qdev.c            |  2 +-
 hw/display/apple-gfx-mmio.m       |  2 +-
 hw/display/apple-gfx-pci.m        |  2 +-
 17 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index c0a8b84df1..4a4c5f9292 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -83,7 +83,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                             _conf.account_failed, ON_OFF_AUTO_AUTO),    \
     DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
                      _conf.num_stats_intervals, _conf.stats_intervals,  \
-                     qdev_prop_uint32, uint32_t)
+                     qdev_prop_uint32)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 36a448be20..7187df0216 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -144,17 +144,15 @@ extern const PropertyInfo qdev_prop_link_array;
  * @_name: name of the array
  * @_state: name of the device state structure type
  * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
- *               will point to the array
+ * @_arrayfield: field in @_state which will point to the array
  * @_arrayprop: PropertyInfo for the array elements (e.g. qdev_prop_uint32);
  *              a corresponding array PropertyInfo named @_arrayprop##_array
  *              must exist
- * @_arraytype: C type of the array elements
  *
  * Define device properties for a variable-length array _name.  The array is
  * represented as a list in the visitor interface.
  *
- * @_arraytype is required to be movable with memcpy().
+ * The element type must be movable with memcpy().
  *
  * When the array property is set, the @_field member of the device
  * struct is set to the array length, and @_arrayfield is set to point
@@ -164,7 +162,7 @@ extern const PropertyInfo qdev_prop_link_array;
  * @_arrayfield memory.
  */
 #define DEFINE_PROP_ARRAY(_name, _state, _field,                        \
-                          _arrayfield, _arrayprop, _arraytype)          \
+                          _arrayfield, _arrayprop)                      \
     DEFINE_PROP(_name, _state, _field, _arrayprop##_array, uint32_t,    \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
@@ -179,10 +177,8 @@ extern const PropertyInfo qdev_prop_link_array;
  * @_name: name of the array
  * @_state: name of the device state structure type
  * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
- *               will point to the array
+ * @_arrayfield: field in @_state which will point to the array
  * @_linktype: QOM type name of the link type
- * @_arraytype: C type of the array elements
  *
  * Define device properties for a variable-length array _name of links
  * (i.e. this is the array version of DEFINE_PROP_LINK).
@@ -191,7 +187,7 @@ extern const PropertyInfo qdev_prop_link_array;
  * where each string is the QOM path of the object to be linked.
  */
 #define DEFINE_PROP_LINK_ARRAY(_name, _state, _field, _arrayfield,      \
-                               _linktype, _arraytype)                   \
+                               _linktype)                               \
     DEFINE_PROP(_name, _state, _field, qdev_prop_link_array, uint32_t,  \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 376d91abad..20613f6499 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -80,7 +80,7 @@ static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 
 static const Property stellaris_gamepad_properties[] = {
     DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
-                      keycodes, qdev_prop_uint32, uint32_t),
+                      keycodes, qdev_prop_uint32),
 };
 
 static void stellaris_gamepad_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f7ba74e6d5..1298b6b735 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -615,7 +615,7 @@ static const Property arm_gicv3_common_properties[] = {
      */
     DEFINE_PROP_BOOL("force-8-bit-prio", GICv3State, force_8bit_prio, 0),
     DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
-                      redist_region_count, qdev_prop_uint32, uint32_t),
+                      redist_region_count, qdev_prop_uint32),
     DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx, 0),
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 2920b11cc3..40c1956a47 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -191,9 +191,9 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
 
 static const Property arm_gicv5_common_properties[] = {
     DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
-                           cpus, TYPE_ARM_CPU, ARMCPU *),
+                           cpus, TYPE_ARM_CPU),
     DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
-                      cpu_iaffids, qdev_prop_uint32, uint32_t),
+                      cpu_iaffids, qdev_prop_uint32),
     DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
     DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
     DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 992b069ae2..125a6dcb68 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -356,9 +356,9 @@ static const VMStateDescription vmstate_rxicu = {
 
 static const Property rxicu_properties[] = {
     DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
-                      qdev_prop_uint8, uint8_t),
+                      qdev_prop_uint8),
     DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
-                      qdev_prop_uint8, uint8_t),
+                      qdev_prop_uint8),
 };
 
 static void rxicu_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index ebc95b9bb5..1df85593a5 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -626,10 +626,10 @@ static const Property arm_sysctl_properties[] = {
     DEFINE_PROP_UINT32("proc_id", arm_sysctl_state, proc_id, 0),
     /* Daughterboard power supply voltages (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-voltage", arm_sysctl_state, db_num_vsensors,
-                      db_voltage, qdev_prop_uint32, uint32_t),
+                      db_voltage, qdev_prop_uint32),
     /* Daughterboard clock reset values (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-clock", arm_sysctl_state, db_num_clocks,
-                      db_clock_reset, qdev_prop_uint32, uint32_t),
+                      db_clock_reset, qdev_prop_uint32),
 };
 
 static void arm_sysctl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 554b504c72..32f9e166fe 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -464,7 +464,7 @@ static const Property mps2_scc_properties[] = {
      * motherboard configuration controller to suit the FPGA image.
      */
     DEFINE_PROP_ARRAY("oscclk", MPS2SCC, num_oscclk, oscclk_reset,
-                      qdev_prop_uint32, uint32_t),
+                      qdev_prop_uint32),
 };
 
 static void mps2_scc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 910dce901b..afbc32e99d 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1466,7 +1466,7 @@ static const Property rocker_properties[] = {
     DEFINE_PROP_UINT64("switch_id", Rocker,
                        switch_id, 0),
     DEFINE_PROP_ARRAY("ports", Rocker, fp_ports,
-                      fp_ports_peers, qdev_prop_netdev, NICPeers),
+                      fp_ports_peers, qdev_prop_netdev),
 };
 
 static const VMStateDescription rocker_vmsd = {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 54e42cfec9..0bdd5a005d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4380,7 +4380,7 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
     DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
-                      ebpf_rss_fds, qdev_prop_string, char*),
+                      ebpf_rss_fds, qdev_prop_string),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 7d2030f7aa..c75704662a 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -267,7 +267,7 @@ static const Property efuse_properties[] = {
     DEFINE_PROP_UINT32("efuse-size", XlnxEFuse, efuse_size, 64 * 32),
     DEFINE_PROP_BOOL("init-factory-tbits", XlnxEFuse, init_tbits, true),
     DEFINE_PROP_ARRAY("read-only", XlnxEFuse, ro_bits_cnt, ro_bits,
-                      qdev_prop_uint32, uint32_t),
+                      qdev_prop_uint32),
 };
 
 static void efuse_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index f5d5587cb6..101320b82f 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -740,7 +740,7 @@ static const Property efuse_ctrl_props[] = {
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
     DEFINE_PROP_ARRAY("pg0-lock",
                       XlnxVersalEFuseCtrl, extra_pg0_lock_n16,
-                      extra_pg0_lock_spec, qdev_prop_uint16, uint16_t),
+                      extra_pg0_lock_spec, qdev_prop_uint16),
 };
 
 static void efuse_ctrl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 32fd39737f..132cf87370 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -48,11 +48,9 @@ static const Property riscv_harts_props[] = {
      * defined by "rnmi-exception-vector".
      */
     DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
-                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
-                      uint64_t),
+                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64),
     DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
-                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
-                      uint64_t),
+                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64),
     DEFINE_PROP_LINK("memory", RISCVHartArrayState, memory,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 7b5ffddc1e..1f3a07c5d1 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -38,7 +38,7 @@ static const Property virtio_iommu_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
                       vdev.nr_prop_resv_regions, vdev.prop_resv_regions,
-                      qdev_prop_reserved_region, ReservedRegion),
+                      qdev_prop_reserved_region),
 };
 
 static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 77c3eee717..8cd004b1ef 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -23,7 +23,7 @@ static const Property my_dev_props[] = {
     DEFINE_PROP_UINT32("u32", MyDev, prop_u32, 100),
     DEFINE_PROP_STRING("string", MyDev, prop_string),
     DEFINE_PROP_ARRAY("array-u32", MyDev, prop_array_u32_nb, prop_array_u32,
-                     qdev_prop_uint32, uint32_t),
+                     qdev_prop_uint32),
 };
 
 static void my_dev_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f..dcd04617eb 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -258,7 +258,7 @@ static void apple_gfx_mmio_reset(Object *obj, ResetType type)
 static const Property apple_gfx_mmio_properties[] = {
     DEFINE_PROP_ARRAY("display-modes", AppleGFXMMIOState,
                       common.num_display_modes, common.display_modes,
-                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode),
 };
 
 static void apple_gfx_mmio_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index b0694f4cb8..74f79c8b15 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -118,7 +118,7 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
 static const Property apple_gfx_pci_properties[] = {
     DEFINE_PROP_ARRAY("display-modes", AppleGFXPCIState,
                       common.num_display_modes, common.display_modes,
-                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode),
 };
 
 static void apple_gfx_pci_class_init(ObjectClass *klass, const void *data)
-- 
2.55.0


