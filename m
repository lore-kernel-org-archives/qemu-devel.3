Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C680C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY1z-0002cK-4D; Tue, 14 Jul 2026 03:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY1x-0002bG-79
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY1v-0003cn-FF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6Sdcu3887372
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t/dI1VfWuJF
 ajZGo+WFTvhVv1OsA555jVxCPqXs1+04=; b=GOHp72ADLTaKTBATHEa/HaCST4K
 G/3qq+SZno6iUeszy8WMBXXiLJBpaPjI4waWhZvETeFC83acMKlgFOhyGk/5O139
 TXZEDuoV+1KalhYMF4L57Kykr4h1f5moqit7FDZZRcfxIFFl6oMsmprMhWNUg1iE
 7BeqZiqaYTEtW9RGQeQM71gpM4mHW67nqVlR+2Zo4hbRaeAWNh6MECOlTBhKOfo4
 Nudy76BCW2yJmEz7Zb4aqxPtUndYaLI8mxgBlNKvKCua0lmdXPrahzbhpWAR36xu
 58eARpf4Kn9qOzH+47jkbiD5XtC88keTap5f+OK3H83A3rJ4umMw6Wt3RtA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr4982j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3811d5ecf66so1443176a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784015893; x=1784620693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/dI1VfWuJFajZGo+WFTvhVv1OsA555jVxCPqXs1+04=;
 b=VuUW4QxgaGsOLTOtxYnJCHbKimY0Y6QXCj4k5JK7fAhADoLudnDFnadUJmQgVtgdKo
 3Q9EFXhDbrjFqIe3V6DFvFSR2lYdIT1+e6AEckt8ppInm0CbSC4XFzhiGN6KiK7y1/FY
 VP83JWvt4M1K9QUk9WDZC2r3BDMW9hk0Zq29/IRkjXebr/IBWLT6+A1f08FB4Qf7WBd5
 r2Pxd1EIsJ7im+HQ8C3aJkwVLA6xV0VrERgZEl5xTrtbGodaI0WADW3lYcSq/I3vLe+P
 TI3O8UP2uISUYz33z3xq7X8kb+uNA6MF8HsH6CO6cDU99OhxW1VonrgApF+L/bUNr4/Q
 e6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015893; x=1784620693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/dI1VfWuJFajZGo+WFTvhVv1OsA555jVxCPqXs1+04=;
 b=oSBn0nbQoRuayioK58qwET9eCJIwLbJNwbpbJFZSHPFxkucx8YmjItQj22LsiiiU0n
 K38I6KP1LwHbA64f/+fHhQJ2FhQEJJm+yGd7E5CuZu/xpjWMDDjaLlCZTX5or50tkucP
 zeEgU9J1IP9hXXhzyf73/MME+hAEQ+7g3oGsCRgsVm0+zux0NFtQnamEO8InRQ0YqL9/
 gJ+EcIOalcJ//F0cFAdKnkbeHd0IYQQ1MXX/icWr1a7zbVtiumcky40g42FNpKEl9XIb
 fp6/tvb68G1+0/hdtXIOzGeOYhiPS37HHdhbnefZvtPNFEvwHoHGaTx24AFc63rqCZPT
 6lXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTZYjwNQbiAL9J1tJd00rpheXU+LSFwIzVB1ogVkZUxpV8GZiGkgSIt+03XzpKVaWnp82JmZK2Ejwr@nongnu.org
X-Gm-Message-State: AOJu0YzZZ5Nz9Cl4HCFLmc7M01oqCgRb1ZgvBgXp1gtk7U6DWGv5MKEJ
 RzrGiFGI1n3O5Xsfl2Vs1XjRpjXmjEe92xBeUBQLPuUndId9q5OrYTcWfRgMzxRiklus8F2mZp1
 aCTXvhUur7b3qe1QgPgrJqdJn5HG+CmliAUIm23mOsH6hoSyySeeibX3DEg==
X-Gm-Gg: AfdE7ckkl67DxDGSp34pL0iHG7MQE44nEdbKLDCBkiWfvi1Q994IaLkGhMBd7Rz7nii
 HWS9HLAdg7Je7W94vxGWMVyWj5bGNI/FhG7hjms8B/JdfVZ2iR5HzMMKksISeWmfzuPaqRDhfMD
 mY+7XsCsprbbF8zzgeV26rTD5AqEm6fzfq1NIXT7vz57utmA0+5GIZqYlwiNkAj/rU6Y5ylMyUM
 KAtYBvvBy7XbOyp6jNeZ1Pk5w+2uXy3xUxBP2di2BS08anPcedoM5XwX2kY0LS8FfLdRxiIyns+
 gOGWt6c/ubPoh7S355K+AXmUJDrir1uD/d/WTexoo2wFWLp9WaUneap4vsVPs3xg3+CQ1dgmc6g
 HEG3H4X2/l8RbR5vQTV1W/eqQBpug4s4gkNAH0tX0CkzhkTpcCbySqC1rBKxw7hgwGNdbLlvJwX
 or/Ak5jmIfKq1T+Iac1maws3oGPfcP+FUrkMpiIQFoCg==
X-Received: by 2002:a17:90b:2f8f:b0:38e:1058:6699 with SMTP id
 98e67ed59e1d1-38e10586728mr3281658a91.8.1784015893260; 
 Tue, 14 Jul 2026 00:58:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2f8f:b0:38e:1058:6699 with SMTP id
 98e67ed59e1d1-38e10586728mr3281639a91.8.1784015892678; 
 Tue, 14 Jul 2026 00:58:12 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm55606355eec.8.2026.07.14.00.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:58:12 -0700 (PDT)
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
Subject: [PATCH v3 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Tue, 14 Jul 2026 13:26:53 +0530
Message-ID: <20260714075659.2258023-5-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BOlWP94cH3MSuf3RoZx5lLsLj2iDre1P
X-Proofpoint-ORIG-GUID: BOlWP94cH3MSuf3RoZx5lLsLj2iDre1P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfXwQ+0e71+u6Us
 HzSez3GNSUjq4wJVZyPm222WM0Lo7hzu8KvbfPmZLethjZbPLybKIPLm6XbyyvZ481AQxeH5D3d
 YPz5uoDCTN39x0aBeL2IptuIVD/LZzO4ZJyyKSKYkdTLvW+VTJQ7zBRHXwtAksbbS5T8iPUFeX8
 eT+XDCn8T+ikmma/9K+JdXdPMg13gvBJpss3qX72uRxB+wVsiDdY4nlEe6p4xZhx6+kTBNFvtW2
 XEMjQ7+JVPQhgXcg6uz0rORaJAmugQe/c6crzjgYk4+tU+LjoT57B84vAkRbzecUaKZyTwwvqRP
 +RUItTEQlWLBwWqH3irf6PvcDdOdpM41owx2s0bP8J1JPaC242NfPGBzH7KbgfmCovnl2/2O2FR
 kwbC1XW8yBCL3dHcBRxFJbk1XCAtUJAvrjY/1fKuOigjKyGwzcmIaLhfbOGsSeYLyQIDAsApqtF
 GzRCKzcKABlU9xkFvOA==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a55ec16 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=05Ebmxi2lX8wMp8bXs4A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX4x5eOanUsL0Y
 FVaJaiuuPjqImsyTq7NXKNAqbh+0b5oWcWkietdc9uZtxCPFn0G3/sJlYAuNzPh8dJIxWYf8Z+D
 fQ79kFf733wPGBLaGmBZ2gkrAgVbopE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
 include/hw/misc/riscv_rpmi.h | 10 ++++
 include/hw/riscv/virt.h      |  3 ++
 4 files changed, 110 insertions(+)

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
index cb2658e57e..b5d8a32f9b 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -85,6 +85,16 @@ struct RiscvRpmiState {
     bool has_shmem;
 };
 
+#ifdef CONFIG_LIBRPMI
 DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg, Error **errp);
+#else
+static inline DeviceState *riscv_rpmi_create(const RiscvRpmiConfig *cfg,
+                                             Error **errp)
+{
+    (void)cfg;
+    (void)errp;
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


