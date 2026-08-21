Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B76AC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKUM-0005db-BY; Fri, 21 Aug 2026 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wxKUI-0005bK-VJ; Fri, 21 Aug 2026 04:20:30 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wxKUE-0002fJ-K7; Fri, 21 Aug 2026 04:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787300404; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=PAihpO6EyZnd/ojCMpA8hnP9BuA2Ld83ERB9dbyhRYY=;
 b=c5XePg9v+WIg0h6x+56WczDHZYCoB1dnm+5gzCX4C1v4i1kzaKTzxY8qhLrlhfCVecwJ2meH3HqKP5nV3DDVk3wbthtWAarkJ3b/hwEndvML18h10BfScMbSHKCu3w6Kmy+BtB5/bG+dOlC6ExyqGSy8X2tmX9OI+DYdMY01wto=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0X9LmLts_1787300403; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9LmLts_1787300403 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 21 Aug 2026 16:20:03 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, jic23@kernel.org
Cc: pbonzini@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL
 host bridge dependency
Date: Fri, 21 Aug 2026 16:19:52 +0800
Message-ID: <20260821081954.1171-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

On RISC-V QEMU virt platform with CXL enabled, the probe ordering
of acpi_pci_root (ACPI0016) and cxl_acpi (ACPI0017) is not
guaranteed. If cxl_acpi probes before acpi_pci_root has attached
the CXL host bridges, the CXL port topology will be incomplete
because to_cxl_host_bridge() silently skips devices whose PCI root
is not yet ready.

Add a _DEP object to the ACPI0017 device in the DSDT, declaring
its dependency on the ACPI0016 CXL host bridge devices. This tells
the OS to defer ACPI0017 enumeration until all ACPI0016 devices
have been attached by acpi_pci_root.

This requires a corresponding kernel change to call
acpi_dev_clear_dependencies() in acpi_pci_root_add().

Note on kernel compatibility: this is a "new QEMU feature requires a
sufficiently new kernel" situation.  Kernels that process _DEP but
lack the acpi_dev_clear_dependencies() call will leave the CXLM device
deferred, so CXL memory is unusable there; kernels old enough to ignore
_DEP entirely behave exactly as before this change.  In neither case is
existing (non-CXL) PCIe affected.

The resulting DSDT fragment (iasl -d output) for a single CXL host
bridge at bus 0x01 looks like:

  Device (CXLM)
  {
      Name (_HID, "ACPI0017")
      Name (_DEP, Package (0x01)
      {
          \_SB.PC01
      })
      Method (_STA, 0, NotSerialized)
      {
          Return (0x0B)
      }
      ...
  }

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 3188cdc5bf..56292f04a7 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -521,6 +521,38 @@ static void build_dsdt(GArray *table_data,
     if (s->cxl_devices_state.is_enabled) {
         Aml *cxl_dev = aml_device("CXLM");
         aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+        /*
+         * Declare a _DEP on every ACPI0016 CXL host bridge so the OS
+         * defers ACPI0017 enumeration until acpi_pci_root has attached
+         * the CXL host bridges. Without this, cxl_acpi may probe before
+         * to_cxl_host_bridge() can resolve the PCI root and the CXL
+         * port topology comes up empty.
+         */
+        if (s->pci_bus) {
+            PCIBus *bus;
+            uint32_t num_cxl_hbs = 0;
+
+            QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
+                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
+                    num_cxl_hbs++;
+                }
+            }
+
+            if (num_cxl_hbs > 0) {
+                Aml *dep_pkg = aml_package(num_cxl_hbs);
+
+                QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
+                    if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
+                        aml_append(dep_pkg,
+                                   aml_name("\\_SB.PC%.02X",
+                                            pci_bus_num(bus)));
+                    }
+                }
+                aml_append(cxl_dev, aml_name_decl("_DEP", dep_pkg));
+            }
+        }
+
         Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
         aml_append(method, aml_return(aml_int(0x0B)));
         aml_append(cxl_dev, method);
-- 
2.50.1


