Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496CBCCF2D9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhm9D-0003ne-Li; Mon, 19 Jan 2026 05:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8y-0003eA-Ej
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8v-0005hg-Pn
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768817152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdqlrBgaxcfyg+Byb3hopUnhy39/SGqS+dfSl9EajS4=;
 b=gcfxR4lKyiiIWGRaaah0QyM2GIIG3fw+iQ2OSgL/zrcZ/8imXC/We6vJfrId2KtT70h1k9
 QDDmWuvfA+zKVcOCiDw7bYXPK96Zmv+ymG5WZqgAZmhBvMMM00c8Td3a2CjFJgRLgFipXJ
 NuQcD6wXwyH+YpRMhYcR4E2TVkSciUA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-FL0b16kGP4OASK-QkFRN7w-1; Mon,
 19 Jan 2026 05:05:45 -0500
X-MC-Unique: FL0b16kGP4OASK-QkFRN7w-1
X-Mimecast-MFC-AGG-ID: FL0b16kGP4OASK-QkFRN7w_1768817144
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03DEB18605D2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B430182E694
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DDD321E6932; Mon, 19 Jan 2026 11:05:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] Clean up header guards that don't match their file name
Date: Mon, 19 Jan 2026 11:05:34 +0100
Message-ID: <20260119100537.463312-3-armbru@redhat.com>
In-Reply-To: <20260119100537.463312-1-armbru@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Header guard symbols should match their file name to make guard
collisions less likely.

Cleaned up with scripts/clean-header-guards.pl, followed by some
renaming of new guard symbols picked by the script to better ones.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/accel-internal.h                    | 2 +-
 accel/tcg/tb-internal.h                   | 4 ++--
 crypto/tlscredsbox.h                      | 6 +++---
 hw/i386/tdvf-hob.h                        | 4 ++--
 hw/riscv/riscv-iommu.h                    | 4 ++--
 include/exec/page-protection.h            | 5 +++--
 include/exec/replay-core.h                | 4 ++--
 include/hw/acpi/ich9_tco.h                | 6 +++---
 include/hw/audio/virtio-snd.h             | 4 ++--
 include/hw/core/hw-error.h                | 4 ++--
 include/hw/core/qdev.h                    | 4 ++--
 include/hw/core/sysemu-cpu-ops.h          | 6 +++---
 include/hw/loongarch/virt.h               | 4 ++--
 include/hw/misc/sifive_e_aon.h            | 4 ++--
 include/hw/misc/xlnx-versal-cfu.h         | 5 +++--
 include/hw/net/xlnx-versal-canfd.h        | 4 ++--
 include/hw/pci-bridge/cxl_upstream_port.h | 7 ++++---
 include/hw/pci-host/fsl_imx8m_phy.h       | 4 ++--
 include/hw/ppc/pnv_nest_pervasive.h       | 6 +++---
 include/hw/ssi/pnv_spi_regs.h             | 4 ++--
 include/hw/virtio/vdpa-dev.h              | 5 +++--
 include/io/channel-null.h                 | 4 ++--
 include/qapi/qmp-registry.h               | 4 ++--
 include/qemu/target-info-qapi.h           | 4 ++--
 include/system/cpu-timers-internal.h      | 6 +++---
 include/system/dirtylimit.h               | 5 +++--
 include/system/spdm-socket.h              | 4 ++--
 include/user/tswap-target.h               | 5 +++--
 target/arm/cpu-features.h                 | 4 ++--
 target/arm/tcg/mte_helper.h               | 6 +++---
 target/i386/confidential-guest.h          | 5 +++--
 target/i386/emulate/x86.h                 | 4 ++--
 target/i386/emulate/x86_decode.h          | 4 ++--
 target/i386/emulate/x86_flags.h           | 6 +++---
 target/sparc/translate.h                  | 5 +++--
 target/xtensa/core-lx106/core-isa.h       | 7 +++----
 36 files changed, 88 insertions(+), 81 deletions(-)

diff --git a/accel/accel-internal.h b/accel/accel-internal.h
index d3a4422cbf..8db77fc0ba 100644
--- a/accel/accel-internal.h
+++ b/accel/accel-internal.h
@@ -14,4 +14,4 @@
 
 void accel_init_ops_interfaces(AccelClass *ac);
 
-#endif /* ACCEL_SYSTEM_H */
+#endif /* ACCEL_INTERNAL_H */
diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 40439f03c3..a1b30baa38 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef ACCEL_TCG_TB_INTERNAL_TARGET_H
-#define ACCEL_TCG_TB_INTERNAL_TARGET_H
+#ifndef ACCEL_TCG_TB_INTERNAL_H
+#define ACCEL_TCG_TB_INTERNAL_H
 
 #include "exec/translation-block.h"
 
diff --git a/crypto/tlscredsbox.h b/crypto/tlscredsbox.h
index eeb54d1eeb..179488dc3a 100644
--- a/crypto/tlscredsbox.h
+++ b/crypto/tlscredsbox.h
@@ -6,8 +6,8 @@
  * Copyright (c) 2025 Red Hat, Inc.
  */
 
-#ifndef QCRYPTO_TLSCREDS_BOX_H
-#define QCRYPTO_TLSCREDS_BOX_H
+#ifndef QCRYPTO_TLSCREDSBOX_H
+#define QCRYPTO_TLSCREDSBOX_H
 
 #include "qom/object.h"
 
@@ -47,4 +47,4 @@ void qcrypto_tls_creds_box_unref(QCryptoTLSCredsBox *credsbox);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsBox, qcrypto_tls_creds_box_unref);
 
-#endif /* QCRYPTO_TLSCREDS_BOX_H */
+#endif /* QCRYPTO_TLSCREDSBOX_H */
diff --git a/hw/i386/tdvf-hob.h b/hw/i386/tdvf-hob.h
index 4fc6a3740a..b712595df2 100644
--- a/hw/i386/tdvf-hob.h
+++ b/hw/i386/tdvf-hob.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-#ifndef HW_I386_TD_HOB_H
-#define HW_I386_TD_HOB_H
+#ifndef HW_I386_TDVF_HOB_H
+#define HW_I386_TDVF_HOB_H
 
 #include "hw/i386/tdvf.h"
 #include "target/i386/kvm/tdx.h"
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2dabd86941..286adacc13 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -16,8 +16,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_RISCV_IOMMU_STATE_H
-#define HW_RISCV_IOMMU_STATE_H
+#ifndef HW_RISCV_IOMMU_H
+#define HW_RISCV_IOMMU_H
 
 #include "qom/object.h"
 #include "hw/core/qdev-properties.h"
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index c50ce57d15..7cb11857af 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -5,8 +5,9 @@
  *
  * SPDX-License-Identifier: LGPL-2.1+
  */
-#ifndef EXEC_PAGE_PROT_COMMON_H
-#define EXEC_PAGE_PROT_COMMON_H
+
+#ifndef EXEC_PAGE_PROTECTION_H
+#define EXEC_PAGE_PROTECTION_H
 
 /* same as PROT_xxx */
 #define PAGE_READ      0x0001
diff --git a/include/exec/replay-core.h b/include/exec/replay-core.h
index 244c77acce..849d642b0b 100644
--- a/include/exec/replay-core.h
+++ b/include/exec/replay-core.h
@@ -8,8 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef EXEC_REPLAY_H
-#define EXEC_REPLAY_H
+#ifndef EXEC_REPLAY_CORE_H
+#define EXEC_REPLAY_CORE_H
 
 #include "qapi/qapi-types-replay.h"
 
diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index b3c3f69451..c1457a3cb2 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -7,8 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef HW_ACPI_TCO_H
-#define HW_ACPI_TCO_H
+#ifndef HW_ACPI_ICH9_TCO_H
+#define HW_ACPI_ICH9_TCO_H
 
 #include "system/memory.h"
 #include "migration/vmstate.h"
@@ -80,4 +80,4 @@ void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
 
 extern const VMStateDescription vmstate_tco_io_sts;
 
-#endif /* HW_ACPI_TCO_H */
+#endif /* HW_ACPI_ICH9_TCO_H */
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index c176066584..c4ca781769 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -13,8 +13,8 @@
  * top-level directory.
  */
 
-#ifndef QEMU_VIRTIO_SOUND_H
-#define QEMU_VIRTIO_SOUND_H
+#ifndef HW_AUDIO_VIRTIO_SND_H
+#define HW_AUDIO_VIRTIO_SND_H
 
 #include "hw/virtio/virtio.h"
 #include "qemu/audio.h"
diff --git a/include/hw/core/hw-error.h b/include/hw/core/hw-error.h
index 1b33d12b7f..ab9bb097ee 100644
--- a/include/hw/core/hw-error.h
+++ b/include/hw/core/hw-error.h
@@ -1,5 +1,5 @@
-#ifndef QEMU_HW_H
-#define QEMU_HW_H
+#ifndef HW_CORE_HW_ERROR_H
+#define HW_CORE_HW_ERROR_H
 
 G_NORETURN void hw_error(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 4b2730e9d8..8d8ec90f63 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1,5 +1,5 @@
-#ifndef QDEV_CORE_H
-#define QDEV_CORE_H
+#ifndef HW_CORE_QDEV_H
+#define HW_CORE_QDEV_H
 
 #include "qemu/atomic.h"
 #include "qemu/queue.h"
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 877892373f..6f95a59094 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -7,8 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef SYSTEM_CPU_OPS_H
-#define SYSTEM_CPU_OPS_H
+#ifndef HW_CORE_SYSEMU_CPU_OPS_H
+#define HW_CORE_SYSEMU_CPU_OPS_H
 
 #include "hw/core/cpu.h"
 
@@ -93,4 +93,4 @@ typedef struct SysemuCPUOps {
 
 } SysemuCPUOps;
 
-#endif /* SYSTEM_CPU_OPS_H */
+#endif /* HW_CORE_SYSEMU_CPU_OPS_H */
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d39a9bbf5d..8ada77b238 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -5,8 +5,8 @@
  * Copyright (C) 2021 Loongson Technology Corporation Limited
  */
 
-#ifndef HW_LOONGARCH_H
-#define HW_LOONGARCH_H
+#ifndef HW_LOONGARCH_VIRT_H
+#define HW_LOONGARCH_VIRT_H
 
 #include "hw/core/boards.h"
 #include "qemu/queue.h"
diff --git a/include/hw/misc/sifive_e_aon.h b/include/hw/misc/sifive_e_aon.h
index efa2c3023f..514b852417 100644
--- a/include/hw/misc/sifive_e_aon.h
+++ b/include/hw/misc/sifive_e_aon.h
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_SIFIVE_AON_H
-#define HW_SIFIVE_AON_H
+#ifndef HW_SIFIVE_E_AON_H
+#define HW_SIFIVE_E_AON_H
 
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index e4fefe43c0..8e3ba0bc99 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -14,8 +14,9 @@
  * [2] Versal ACAP Register Reference,
  *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/CFU_CSR-Module
  */
-#ifndef HW_MISC_XLNX_VERSAL_CFU_APB_H
-#define HW_MISC_XLNX_VERSAL_CFU_APB_H
+
+#ifndef HW_MISC_XLNX_VERSAL_CFU_H
+#define HW_MISC_XLNX_VERSAL_CFU_H
 
 #include "hw/core/sysbus.h"
 #include "hw/core/register.h"
diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
index 7cadf3123b..54667a344f 100644
--- a/include/hw/net/xlnx-versal-canfd.h
+++ b/include/hw/net/xlnx-versal-canfd.h
@@ -25,8 +25,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef HW_CANFD_XILINX_H
-#define HW_CANFD_XILINX_H
+#ifndef HW_NET_XLNX_VERSAL_CANFD_H
+#define HW_NET_XLNX_VERSAL_CANFD_H
 
 #include "hw/core/register.h"
 #include "hw/core/ptimer.h"
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index f208397ffe..4424b35eeb 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -1,6 +1,7 @@
 
-#ifndef CXL_USP_H
-#define CXL_USP_H
+#ifndef HW_PCI_BRIDGE_CXL_UPSTREAM_PORT_H
+#define HW_PCI_BRIDGE_CXL_UPSTREAM_PORT_H
+
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
@@ -20,4 +21,4 @@ typedef struct CXLUpstreamPort {
     uint64_t sn;
 } CXLUpstreamPort;
 
-#endif /* CXL_SUP_H */
+#endif /* HW_PCI_BRIDGE_CXL_UPSTREAM_PORT_H */
diff --git a/include/hw/pci-host/fsl_imx8m_phy.h b/include/hw/pci-host/fsl_imx8m_phy.h
index 5786534b0e..d19baa8cd2 100644
--- a/include/hw/pci-host/fsl_imx8m_phy.h
+++ b/include/hw/pci-host/fsl_imx8m_phy.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef HW_PCIHOST_FSLIMX8MPCIEPHY_H
-#define HW_PCIHOST_FSLIMX8MPCIEPHY_H
+#ifndef HW_PCI_HOST_FSL_IMX8M_PHY_H
+#define HW_PCI_HOST_FSL_IMX8M_PHY_H
 
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
diff --git a/include/hw/ppc/pnv_nest_pervasive.h b/include/hw/ppc/pnv_nest_pervasive.h
index 73cacf3823..f0132cd525 100644
--- a/include/hw/ppc/pnv_nest_pervasive.h
+++ b/include/hw/ppc/pnv_nest_pervasive.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef PPC_PNV_NEST_CHIPLET_PERVASIVE_H
-#define PPC_PNV_NEST_CHIPLET_PERVASIVE_H
+#ifndef HW_PPC_PNV_NEST_PERVASIVE_H
+#define HW_PPC_PNV_NEST_PERVASIVE_H
 
 #define TYPE_PNV_NEST_CHIPLET_PERVASIVE "pnv-nest-chiplet-pervasive"
 #define PNV_NEST_CHIPLET_PERVASIVE(obj) OBJECT_CHECK(PnvNestChipletPervasive, (obj), TYPE_PNV_NEST_CHIPLET_PERVASIVE)
@@ -29,4 +29,4 @@ typedef struct PnvNestChipletPervasive {
     PnvPervasiveCtrlRegs    control_regs;
 } PnvNestChipletPervasive;
 
-#endif /*PPC_PNV_NEST_CHIPLET_PERVASIVE_H */
+#endif /* HW_PPC_PNV_NEST_PERVASIVE_H */
diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h
index 596e2c1911..f26aeb5a0d 100644
--- a/include/hw/ssi/pnv_spi_regs.h
+++ b/include/hw/ssi/pnv_spi_regs.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef PNV_SPI_CONTROLLER_REGS_H
-#define PNV_SPI_CONTROLLER_REGS_H
+#ifndef HW_SSI_PNV_SPI_REGS_H
+#define HW_SSI_PNV_SPI_REGS_H
 
 /*
  * Macros from target/ppc/cpu.h
diff --git a/include/hw/virtio/vdpa-dev.h b/include/hw/virtio/vdpa-dev.h
index 4dbf98195c..a4e49bd34a 100644
--- a/include/hw/virtio/vdpa-dev.h
+++ b/include/hw/virtio/vdpa-dev.h
@@ -12,8 +12,9 @@
  * This work is licensed under the terms of the GNU LGPL, version 2 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
-#ifndef _VHOST_VDPA_DEVICE_H
-#define _VHOST_VDPA_DEVICE_H
+
+#ifndef HW_VIRTIO_VDPA_DEV_H
+#define HW_VIRTIO_VDPA_DEV_H
 
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-vdpa.h"
diff --git a/include/io/channel-null.h b/include/io/channel-null.h
index f6d54e63cf..062edbb1bb 100644
--- a/include/io/channel-null.h
+++ b/include/io/channel-null.h
@@ -18,8 +18,8 @@
  *
  */
 
-#ifndef QIO_CHANNEL_FILE_H
-#define QIO_CHANNEL_FILE_H
+#ifndef QIO_CHANNEL_NULL_H
+#define QIO_CHANNEL_NULL_H
 
 #include "io/channel.h"
 #include "qom/object.h"
diff --git a/include/qapi/qmp-registry.h b/include/qapi/qmp-registry.h
index e0ee1ad3ac..d53aa5f36c 100644
--- a/include/qapi/qmp-registry.h
+++ b/include/qapi/qmp-registry.h
@@ -11,8 +11,8 @@
  *
  */
 
-#ifndef QAPI_QMP_DISPATCH_H
-#define QAPI_QMP_DISPATCH_H
+#ifndef QAPI_QMP_REGISTRY_H
+#define QAPI_QMP_REGISTRY_H
 
 #include "monitor/monitor.h"
 #include "qemu/queue.h"
diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
index d5ce052323..c1fbc7e10b 100644
--- a/include/qemu/target-info-qapi.h
+++ b/include/qemu/target-info-qapi.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef QEMU_TARGET_INFO_EXTRA_H
-#define QEMU_TARGET_INFO_EXTRA_H
+#ifndef QEMU_TARGET_INFO_QAPI_H
+#define QEMU_TARGET_INFO_QAPI_H
 
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/include/system/cpu-timers-internal.h b/include/system/cpu-timers-internal.h
index 8c262ce139..126c81bcb4 100644
--- a/include/system/cpu-timers-internal.h
+++ b/include/system/cpu-timers-internal.h
@@ -22,8 +22,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef TIMERS_STATE_H
-#define TIMERS_STATE_H
+#ifndef SYSTEM_CPU_TIMERS_INTERNAL_H
+#define SYSTEM_CPU_TIMERS_INTERNAL_H
 
 /* timers state, for sharing between icount and cpu-timers */
 
@@ -68,4 +68,4 @@ extern TimersState timers_state;
  */
 int64_t cpu_get_clock_locked(void);
 
-#endif /* TIMERS_STATE_H */
+#endif /* SYSTEM_CPU_TIMERS_INTERNAL_H */
diff --git a/include/system/dirtylimit.h b/include/system/dirtylimit.h
index d11ebbbbdb..cc4619fef7 100644
--- a/include/system/dirtylimit.h
+++ b/include/system/dirtylimit.h
@@ -9,8 +9,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
-#ifndef QEMU_DIRTYRLIMIT_H
-#define QEMU_DIRTYRLIMIT_H
+
+#ifndef SYSTEM_DIRTYLIMIT_H
+#define SYSTEM_DIRTYLIMIT_H
 
 #define DIRTYLIMIT_CALC_TIME_MS         1000    /* 1000ms */
 
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 00cb0e97f3..2745588456 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -20,8 +20,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef SPDM_REQUESTER_H
-#define SPDM_REQUESTER_H
+#ifndef SYSTEM_SPDM_SOCKET_H
+#define SYSTEM_SPDM_SOCKET_H
 
 /**
  * spdm_socket_connect: connect to an external SPDM socket
diff --git a/include/user/tswap-target.h b/include/user/tswap-target.h
index 4719330dbb..4189d1fec1 100644
--- a/include/user/tswap-target.h
+++ b/include/user/tswap-target.h
@@ -5,8 +5,9 @@
  *
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
-#ifndef USER_TSWAP_H
-#define USER_TSWAP_H
+
+#ifndef USER_TSWAP_TARGET_H
+#define USER_TSWAP_TARGET_H
 
 #include "exec/cpu-defs.h"
 #include "exec/tswap.h"
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a7ca410dcb..5fbd3e6e03 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -17,8 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef TARGET_ARM_FEATURES_H
-#define TARGET_ARM_FEATURES_H
+#ifndef TARGET_ARM_CPU_FEATURES_H
+#define TARGET_ARM_CPU_FEATURES_H
 
 #include "hw/core/registerfields.h"
 #include "qemu/host-utils.h"
diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
index 1f471fb69b..0ae2b0ced1 100644
--- a/target/arm/tcg/mte_helper.h
+++ b/target/arm/tcg/mte_helper.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef TARGET_ARM_MTE_H
-#define TARGET_ARM_MTE_H
+#ifndef TARGET_ARM_TCG_MTE_HELPER_H
+#define TARGET_ARM_TCG_MTE_HELPER_H
 
 #include "exec/mmu-access-type.h"
 
@@ -63,4 +63,4 @@ int load_tag1(uint64_t ptr, uint8_t *mem);
  */
 void store_tag1(uint64_t ptr, uint8_t *mem, int tag);
 
-#endif /* TARGET_ARM_MTE_H */
+#endif /* TARGET_ARM_TCG_MTE_HELPER_H */
diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 48b88dbd31..7114cbf7d1 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -9,8 +9,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
-#ifndef TARGET_I386_CG_H
-#define TARGET_I386_CG_H
+
+#ifndef TARGET_I386_CONFIDENTIAL_GUEST_H
+#define TARGET_I386_CONFIDENTIAL_GUEST_H
 
 #include "qom/object.h"
 
diff --git a/target/i386/emulate/x86.h b/target/i386/emulate/x86.h
index 73edccfba0..46d6a60e92 100644
--- a/target/i386/emulate/x86.h
+++ b/target/i386/emulate/x86.h
@@ -16,8 +16,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef X86_EMU_DEFS_H
-#define X86_EMU_DEFS_H
+#ifndef TARGET_I386_EMULATE_X86_H
+#define TARGET_I386_EMULATE_X86_H
 
 typedef struct x86_register {
     union {
diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
index 1cadf3694f..adbff86164 100644
--- a/target/i386/emulate/x86_decode.h
+++ b/target/i386/emulate/x86_decode.h
@@ -15,8 +15,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef X86_EMU_DECODE_H
-#define X86_EMU_DECODE_H
+#ifndef TARGET_I386_EMULATE_X86_DECODE_H
+#define TARGET_I386_EMULATE_X86_DECODE_H
 
 #include "cpu.h"
 #include "x86.h"
diff --git a/target/i386/emulate/x86_flags.h b/target/i386/emulate/x86_flags.h
index a395c837a0..9f081fde4a 100644
--- a/target/i386/emulate/x86_flags.h
+++ b/target/i386/emulate/x86_flags.h
@@ -21,8 +21,8 @@
  * x86 eflags functions
  */
 
-#ifndef X86_EMU_FLAGS_H
-#define X86_EMU_FLAGS_H
+#ifndef TARGET_I386_EMULATE_X86_FLAGS_H
+#define TARGET_I386_EMULATE_X86_FLAGS_H
 
 #include "cpu.h"
 void lflags_to_rflags(CPUX86State *env);
@@ -68,4 +68,4 @@ void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
                              uint8_t diff);
 
-#endif /* X86_EMU_FLAGS_H */
+#endif /* TARGET_I386_EMULATE_X86_FLAGS_H */
diff --git a/target/sparc/translate.h b/target/sparc/translate.h
index a46fa4f124..06979c67ae 100644
--- a/target/sparc/translate.h
+++ b/target/sparc/translate.h
@@ -4,8 +4,9 @@
  * Copyright (c) 2024 Linaro, Ltd
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
-#ifndef SPARC_TRANSLATION_H
-#define SPARC_TRANSLATION_H
+
+#ifndef SPARC_TRANSLATE_H
+#define SPARC_TRANSLATE_H
 
 /* Dynamic PC, must exit to main loop. */
 #define DYNAMIC_PC         1
diff --git a/target/xtensa/core-lx106/core-isa.h b/target/xtensa/core-lx106/core-isa.h
index 86bcf1a5d6..6933f1a406 100644
--- a/target/xtensa/core-lx106/core-isa.h
+++ b/target/xtensa/core-lx106/core-isa.h
@@ -28,9 +28,8 @@
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  */
 
-#ifndef _XTENSA_CORE_CONFIGURATION_H
-#define _XTENSA_CORE_CONFIGURATION_H
-
+#ifndef XTENSA_CORE_LX106_CORE_ISA_H
+#define XTENSA_CORE_LX106_CORE_ISA_H
 
 /****************************************************************************
 	    Parameters Useful for Any Code, USER or PRIVILEGED
@@ -466,5 +465,5 @@
 #endif /* !XTENSA_HAL_NON_PRIVILEGED_ONLY */
 
 
-#endif /* _XTENSA_CORE_CONFIGURATION_H */
+#endif /* XTENSA_CORE_LX106_CORE_ISA_H */
 
-- 
2.52.0


