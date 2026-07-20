Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5355C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllmD-0002th-Iv; Mon, 20 Jul 2026 07:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllmC-0002tV-Mt
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:03:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllmA-0002tY-MD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:03:12 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvXmT2421716
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DrbhwKdAuWk
 vVsmEmNdJDaB/bRIDM17cHjw4EXW+DtM=; b=N5trmxD7YcWIHExSQE+9M6sAne8
 iFCBwJ/gKvylcgmzP/u1t5fo8rZsJh5I/vEJ1pNltEziuxm8WTpAXDzJiPrAEhdi
 UweQWARVk5vnRVXR/mN+C7Uy4MbUp2v2Xpy3uHQjekaRyxd5ahO+n5eMNUmfz/69
 x7Ppq8xXdjGpBFY1PQqJ1/zw8oorHh7ZWuGZJ8BC1+SeAhHFO7HK6VL1MdX+UP88
 2aa70zRRNB6ZB2CrSQ8U1Y37ODd8vqeui7xZmbVk3/5UEuDtCwqSzAfxQSDGD0xA
 sboMFmHBXZ0BSvz+kJLJKKGpvmnhrzdTVYFkJdOo4wFX9LXJLxaUH600/2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfvxgssw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:03:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc620652bfso25502785ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545388; x=1785150188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DrbhwKdAuWkvVsmEmNdJDaB/bRIDM17cHjw4EXW+DtM=;
 b=UxZWKgmnnroVbdpaPr4/20bIid4qJ2fuX4uO7d5N+WKQENoWSS/0B56wxIVkJgx56D
 B9Ys+k2zzdZliBRIcfB/p+VExJzrSxzbAK2K2X729zVWydrJPacXj2EGKhIKL4tt7/Uw
 WA2oneR7qichvOyD5hBePqon3YvF1/mS2oboV4wGbelliVEfzDjnh9RhZL+yNICZmFwv
 E+BCYUDy3pSE27mNPQB18WbyhzhjUoLxy1k4N+ut3odkriz9OcM+V0vxFAU9zcSbRvfs
 Eh7XE4BZSxXDO898xUAlDXj+YIR/c+Y+ZiraZQnRtHxtebL9oJqsRM3YCWl5wwRTbd3b
 xeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545388; x=1785150188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DrbhwKdAuWkvVsmEmNdJDaB/bRIDM17cHjw4EXW+DtM=;
 b=G4OD4Vpu7bAL0z1GV0pCKYVEk4B/mVWWU+WO4xwe1ilfCiOp33KHTkWt73AMk8ZwE4
 vDlP1jIx6Eb5biZ9g6tOa/Bl2TiUjzcDHmpyfpqxV5BTWvzbKEMEUcGU0QRt/4APhIVP
 SeV4uQpT1+gUlK4nYzQl8gfYyIY64VnrlXL1qhkLYWFqJu7TPaM1kuSw28sYrB1+c05d
 EXjMx8CAsiWovSQRswfgdwse6KaXn1IkBarPCCZEmJPMFjd3OmoSd5v57JP9IHg+joR8
 ntFa7fCX8pUHOZsqBfYw+/lDXrML7gW4nuffiiZtoJi/vZppNATckzZ/OsQRPZwIZmj0
 q4eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHRxv71KJtPRn3fWcnw46qKBtAF1m1gMagq/0RUf5BdfVEx8m+xTCJvRWire0Elc4B6t3ghwSf6pC2@nongnu.org
X-Gm-Message-State: AOJu0YxYCJhVT7KcBVHFVgDi2EBBcLp90koLZC9/Hvrjeq3GND7zFjA3
 ks4qxt7CfmGw0zu+zsMI2aH+rNHRJQ40f4auRqiBkN/pzY8FmvPVnBdWdJNyzThjmrPHcTcGJUq
 V49lkjWD9MqGLoGfDIVb+GooVX88FWY6cLK1VcU9OnmhmHC8YGOIWevGwYA==
X-Gm-Gg: AR+sD11oIVCOsJZcDxD6exXgXg5puJdO0nZrlQkCYIDuzN7KV7IY9yt5f3LPdo3pvzE
 EZgympMYdN8I5ZE05JMB4OY+2avcooGxNGKVXvhf1ds4MsbbL2m/ozaUvQrvV7o71A9A5fHX8Tj
 NqkUqgELMEq0QHiFNDGiU+VMPHwYmN7r44ougkSa/OSAP7F+21JuGo0vAlUA4BqAcsjUSuV80q2
 Xiyiss4vUW0eQKb8oLqKFtEVJ2PsaTBH+k1xQk9k3rh2SyOrkih0hNQjd+Yn6Ze1Q7K0no8Tc34
 Ck1k6UYRWHjteear+tKUw5VPhhn4wodCmoCJ0kNLe9OuiFyPw9Bp/+GXK9odhoV0mebbW8Z0oMv
 2d2GPKlffTamGTUocN04bW8jkmVQp3aOp/cQFbFhd6s+HJlELnEq0iY/lyQLRs+QIXEC3SMpaYv
 6vnR71guKge1afL1gAYWlotQOvgvrCDXY=
X-Received: by 2002:a17:902:e74d:b0:2cc:7d4a:3f59 with SMTP id
 d9443c01a7336-2cf349d1353mr120632485ad.6.1784545387539; 
 Mon, 20 Jul 2026 04:03:07 -0700 (PDT)
X-Received: by 2002:a17:902:e74d:b0:2cc:7d4a:3f59 with SMTP id
 d9443c01a7336-2cf349d1353mr120632085ad.6.1784545387009; 
 Mon, 20 Jul 2026 04:03:07 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20b1f3sm34698566eec.26.2026.07.20.04.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:03:06 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v4 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Mon, 20 Jul 2026 16:32:27 +0530
Message-ID: <0652503b00cfe26e708a0a5e3527b1fee0ad3edc.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HKLz0Itv c=1 sm=1 tr=0 ts=6a5e006d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=UDgfl1FA6r1Qzf0Ob0MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMyBTYWx0ZWRfX0qTllAuypy0o
 To7pEekOOqJsnGGj3ZIkuxNv9vphGHscrmjsw8vVEX/7Fo1nPZQwXclZY8pPvuXauWtzeJpzuyW
 Gn1xeimmEEY8pdrqU0wEyTc9Zy1B/2E=
X-Proofpoint-GUID: BG3jYK4gA-XrLTrVkORcBIlTt6-OEvK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMyBTYWx0ZWRfX49pv6Gp0Z4X5
 Bl6AqVkEKYI9MnNalOjzSvFjbyRygEErHMXoxH5Zuyg4jsX1I2wa3AgV2rT3PQYefOymp8q2UYd
 Ewjy1EZ9v1TdpJl2Cp1cdqWwiNovsi+y/YmmlViwt/lsCrADm6YTUicj6VdFtlStLG/I1L7rb8w
 yxnzOOj4vZFAyVM1jC6JVY7/tW5CIgAAWKDi8Xn/fBVRdUgT3hrsl3CZv/OpD73olu2DNXq1STF
 npKJqJDOrvd2bMKyXdU4RTjATbV7O3Uucorj1MRUZXq4TPpKAtJ7OfPbh3tg4h4C4AY4pNv9HF3
 KyS9hRt/Q3Qzv7/QoYvr2g1ILssP0lv7J+s8PduogF7X1lxvvYse4qxeRjBsvpMSy4u30XJkXWH
 /IkrmgueM3Lkzla05orMh+gGgWKj4ENfbPyeSk7XA5pIXjKTu7WZpjPTF2X/cmeOpZz4bFsCJL2
 AUaj6zCS1Nq0nHXhuZg==
X-Proofpoint-ORIG-GUID: BG3jYK4gA-XrLTrVkORcBIlTt6-OEvK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200123
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add the virt machine rpmi=on/off option and wire the initial RPMI Base
transport into machine realization.

The option remains disabled by default and requires TCG plus librpmi.
Invalid accelerator/build combinations fail during machine
initialization. When enabled, virt allocates the RPMI shared-memory
transport, creates the RPMI device, configures Base service metadata,
and emits the corresponding device-tree nodes for firmware discovery.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/riscv/Kconfig             |  1 +
 hw/riscv/virt.c              | 96 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_rpmi.h |  9 ++++
 include/hw/riscv/virt.h      |  3 ++
 4 files changed, 109 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 54e41a6afc..4e25be113a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV_VIRT
     imply VIRTIO_VGA
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
+    imply RISCV_RPMI
     select DEVICE_TREE
     select RISCV_NUMA
     select GOLDFISH_RTC
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 33775a61fd..e52ccfae1f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -45,6 +45,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -97,6 +99,8 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_UART0] =        { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =       { 0x10001000,        0x1000 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -1002,6 +1006,40 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+
+static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
+                                        const uint32_t *hart_ids,
+                                        uint32_t hart_count)
+{
+    return (RiscvRpmiConfig) {
+        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
+        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
+        .shmem_size = s->memmap[VIRT_RPMI_SHMEM].size,
+        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
+        .platform_info = "QEMU RISC-V virt RPMI",
+        .hart_ids = hart_ids,
+        .hart_count = hart_count,
+    };
+}
+
+static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
+                            uint32_t msi_phandle)
+{
+    RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
+    uint32_t rpmi_mbox_handle;
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = rpmi_cfg.shmem_base,
+        .doorbell_base = rpmi_cfg.doorbell_base,
+        .a2p_req_size = rpmi_cfg.a2p_req_size,
+        .p2a_req_size = rpmi_cfg.p2a_req_size,
+        .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1021,6 +1059,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
+    }
+
     create_fdt_reset(s, &phandle);
 
     create_fdt_uart(s, irq_mmio_phandle);
@@ -1410,6 +1452,18 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
+
+    if (s->have_rpmi) {
+#ifndef CONFIG_LIBRPMI
+        error_report("RISC-V RPMI support is not compiled in");
+        exit(1);
+#else
+        if (kvm_enabled()) {
+            error_report("RISC-V RPMI support is not available with KVM");
+            exit(1);
+        }
+#endif
+    }
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -1552,6 +1606,25 @@ static void virt_machine_init(MachineState *machine)
     /* SiFive Test MMIO device */
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
+    if (s->have_rpmi) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
+        g_autofree uint32_t *rpmi_hart_ids =
+            g_new0(uint32_t, machine->smp.cpus);
+        RiscvRpmiConfig rpmi_cfg;
+        Error *local_err = NULL;
+
+        for (i = 0; i < machine->smp.cpus; i++) {
+            rpmi_hart_ids[i] = possible_cpus->cpus[i].arch_id;
+        }
+
+        rpmi_cfg = virt_rpmi_config(s, rpmi_hart_ids, machine->smp.cpus);
+        if (!riscv_rpmi_create(&rpmi_cfg, &local_err)) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
@@ -1636,6 +1709,7 @@ static void virt_machine_instance_init(Object *obj)
 
     s->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
+    s->have_rpmi = false;
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
 }
@@ -1710,6 +1784,21 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
+
+static bool virt_get_rpmi(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->have_rpmi;
+}
+
+static void virt_set_rpmi(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->have_rpmi = value;
+}
+
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s)
 {
     return s->iommu_sys == ON_OFF_AUTO_ON;
@@ -1831,6 +1920,13 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "enable/disable emulating "
                                           "ACLINT devices");
 
+
+    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
+                                   virt_set_rpmi);
+    object_class_property_set_description(oc, "rpmi",
+                                          "Set on/off to enable/disable "
+                                          "RISC-V RPMI devices");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index cb2658e57e..cbc3fe9153 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -85,6 +85,15 @@ struct RiscvRpmiState {
     bool has_shmem;
 };
 
+#ifdef CONFIG_LIBRPMI
 DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp);
+#else
+static inline DeviceState *riscv_rpmi_create(
+    const RiscvRpmiConfig *cfg G_GNUC_UNUSED,
+    Error **errp G_GNUC_UNUSED)
+{
+    return NULL;
+}
+#endif
 
 #endif
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..f7c48613bf 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -79,6 +80,8 @@ enum {
     VIRT_UART0,
     VIRT_VIRTIO,
     VIRT_FW_CFG,
+    VIRT_RPMI_SHMEM,
+    VIRT_RPMI_DOORBELL,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
     VIRT_FLASH,
-- 
2.43.0


