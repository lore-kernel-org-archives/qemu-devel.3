Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A386606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OMXNqaH4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DVct3qcX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTCY-0004lv-QT; Wed, 04 Nov 2026 00:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCU-0004h1-Ob
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:18 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCS-0002CZ-OH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:18 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40RKDY1191425
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WIoo5ELzUL+
 vFgYLKtvV6sBmfMdz6DfJgI0tbx2TvS4=; b=OMXNqaH4kRTwXk5z4w+R7T1+ucC
 az9UcNNKCnqoOs1fnfVNW5v6WX2w3mBUaoxHR5KSjO9y+mPCuxqEtJcvR50zo52G
 2WyZwy8v0E3bEKVm0Y0LHAJL70ddq2ZtHrQnGzPcwLomTrN8depsN2bjekckRc9G
 DjCbjX4WQoMclm2AjdVF91MmKuzZw9ma7NUWwrzq8inMfsrE87Ym8lqipaHC3gNK
 +9OPQortapwLk7xKGkdPHrv0I93gM0sLaCfj9ezA1JZGAtX2JVAX+MnstojKVUJ5
 6yLnRlV8JdFiKCW50Ow47UohmqxHHdYf2vsrhYPs0MAk9sMf1h3SZ5hNSBA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pjbgq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36ca34c12a6so23180eec.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768774; x=1794373574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WIoo5ELzUL+vFgYLKtvV6sBmfMdz6DfJgI0tbx2TvS4=;
 b=DVct3qcXAP0/5sAc1Utb86wtZFRqdQ6OqHHlYiAoYOa8QXo5mM4Be0z9gWj4Dc3Wjo
 HgPx0nHr2mw756sVXvumN5Urg9tRdDSM1cYcwVspr40LYlmSz34EjkiHJInSAKucNrIG
 8A9ymCgvqsBQ2x+6HE9P8VXEmBlU9sRxUmKK6/qHhvASmjtt9sDgvvxBycWptnM9O9J+
 S+HjF1+0R6fDOtTRDF33g3duVwj4wUQTBaKoQkrRh55BTeP1IOZrJn7gshojSGH8tQNd
 AZqngfqajSw8eMHaY2P7UY2eebQAMF2OazVuUaDzm6bepqiLM9XMGxY23uZzt8Z76txh
 5SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768774; x=1794373574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WIoo5ELzUL+vFgYLKtvV6sBmfMdz6DfJgI0tbx2TvS4=;
 b=q9jqxRiDBiRzeBJyOGZHiXXhXtbkrL779APFEqd2hZFhiPev4m1jybQd1x+T0Y8Uz1
 KhCwOX+3BBz0SY9LmzfkmwktABbx8q5Uvs/Xrs3WVx1jnja8sEf9au1Csbk93AJ4UvSR
 ciflMguubRCeAbFZObGIhbHRRT2Q3htlM0E0c/jHdq61KOawT10vI8IcIDWPhopRRJkj
 xAzzPgCs6yGh5TcUExYJkq+ATyYZIYqLkf/crQx/XCIUm0EcCoqNLe08E2Hlqyhrufbs
 1+hRfNH66NfjnQxyEKp+9ST4D6QuX+tdAS0GoKpta5hQ9DdUv8MqFl2IaxBv533JrAur
 sANw==
X-Gm-Message-State: APuU4Z8ubcyRFZ7GymBDsO0c+yMu/3769FMxJUBd8oaC3affrYbR3Wz7
 2jzGubT483uneKzn3FeI5O+lc5y3KrPLsZwscydKGTgzpxOUyhcqOrrFf2Uh7D6jQoFh3H39ZNP
 QVK9K8wNS5znRkNJC16oSHkfoxGP8TvJi+sSjgt87wCLjF3nESRDWPTMvE7fxF3mUdw==
X-Gm-Gg: AYBFou1ty6EBnkHM7R31PNNxiyef8QnohcvF4S1dKp9QblzWlYfAhqA+Y/6tN6NwOUh
 nhPcr2HuiuP1xlZmm9HE1jj1uKBNqIM7ztT0nZLkcw0yJO/pJqz8xjfnP4tleK8aItiO2qL7sAc
 VXlgY71n7kxa+P5SM6iRJdBwYQn8ydb8iWT4zHb3HzAbGfeN5X773yFnLhF9EQGcO5HGGeeZCca
 WxIzXOXMOEHbG2TYWeHmUFNUErGUbzp1OCqZeMxh9OpzlNBASi0H0krtNW3Z+t1a4oPxQinD8hF
 +EvJyKrk1Eyn4M7BbNgD5H+GP1mzu/H180IqhixWugbZxINILaiK2iIGE6xwIrKnZ1RIW5w2hzq
 L/3vJNSm22cfGxujG8fLI8KXE4HSGK1F1KpyPZ9ngswTWpIHEaGyeESqVN2G7cuZjbJxqVSS9EI
 MNFnkQVquRaZy9FvKNE3Fz+btLHA+dDkKufKS5O0pSh2lcVGdhdVQ0SaLPzae/cFCcau8Mm+9A9
 Amy2cP+
X-Received: by 2002:a05:693c:8099:b0:35f:ea17:d171 with SMTP id
 5a478bee46e88-36a42236aa1mr33976094eec.2.1793768773812; 
 Tue, 03 Nov 2026 21:06:13 -0800 (PST)
X-Received: by 2002:a05:693c:8099:b0:35f:ea17:d171 with SMTP id
 5a478bee46e88-36a42236aa1mr33976003eec.2.1793768773101; 
 Tue, 03 Nov 2026 21:06:13 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:12 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v14 04/10] hw/riscv/virt: add opt-in RPMI base support
Date: Wed,  4 Nov 2026 10:33:17 +0530
Message-ID: <20261104050324.733555-5-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX3bb60B2wBI8Q
 skdfPuD8PJAgjnpeepR4HpPXKE2jkdb1eXC7c3LSl2DzC6erSREF40xNXUcHEp+bVZmHufuvs9C
 zTnRo7wv+4fCDNI0ORVkPFpU5pBG7h8VEcNNlBBxYTk0HZMw5Z5lYEJkbw93K7jfR0+exyG7eIg
 5zcUotfIs5IkYEINwmVss2MCJGyzaE6xho8rEl5hiygH+o+OLwxUTiBgQTJI9VZlYPF6PuvYe/W
 +Zj2K32lJB4kepDdRplBmZWC6dwNc+DedpKiM94OaVntD/+nb46pRXT1X573uLX4IbUk5xTu8Fz
 OLtZ2v4QaG4LnCeMmbZFloOmqNow6axRABuT41PJH6Qsgdf+HNYudeL/C7WYbJZ8cNSAcjWzfQz
 IvWzdlKgIYRUJ9QXZB3pFsuUYhd+RIUQ2828SOcPrMcU2FrVcUndde/UZlsdJ7bZutNaKZiDtQV
 E4LwfWeFoGDaFr8HkUg==
X-Proofpoint-GUID: 0TFk1PFzl4afGHupAWLeNSu0bYReEm0Y
X-Proofpoint-ORIG-GUID: 0TFk1PFzl4afGHupAWLeNSu0bYReEm0Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX/NYTIwis0NUN
 fTqGeLmyuy+ZcWT5S5BxNUIhY3KTco/TlGkF1vaYGT1H8vAAEg1TFMzQyyn8SRXfcN8+8rgzeC3
 Q/a9/kNDLkL1Si0ch9i9xOMOSvEnw40=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeabd46 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=HmRiOy3tFSfIY13RnpAA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040020
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the virt machine rpmi=on/off option and wire the initial RPMI
Base transport into machine realization for firmware clients that use RPMI
platform management.

The option remains disabled by default. Enabling it requires a
librpmi-enabled TCG build; KVM and builds without librpmi reject the
configuration. The RPMI mailbox node is emitted when enabled, while the
legacy reset and poweroff nodes remain available until the later service
patches select the RPMI reset path.

Size each A2P queue from one quarter of shared memory after
reserving 8 KiB: 30 KiB per queue on virt.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 90 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  3 ++
 3 files changed, 94 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index d89fdfcc86..28d108faf8 100644
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
index de1c92463a..8a2ed43029 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -46,6 +46,8 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "hw/riscv/rpmi-fdt.h"
 #include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
@@ -107,6 +109,8 @@ static const MemMapEntry virt_memmap[] = {
     /* UART1 supports page isolation from UART0 */
     [VIRT_UART1] =        { 0x1000a000,         0x100 },
     [VIRT_FW_CFG] =       { 0x10100000,          0x18 },
+    [VIRT_RPMI_SHMEM] =   { 0x10200000,       0x20000 },
+    [VIRT_RPMI_DOORBELL] = { 0x10230000,        0x1000 },
     [VIRT_FLASH] =        { 0x20000000,     0x4000000 },
     [VIRT_IMSIC_M] =      { 0x24000000, VIRT_IMSIC_MAX_SIZE },
     [VIRT_IMSIC_S] =      { 0x28000000, VIRT_IMSIC_MAX_SIZE },
@@ -115,6 +119,10 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_DRAM] =         { 0x80000000,           0x0 },
 };
 
+#define VIRT_RPMI_A2P_REQ_SIZE \
+    ((virt_memmap[VIRT_RPMI_SHMEM].size - 0x2000) / 4)
+#define VIRT_RPMI_P2A_REQ_SIZE 0
+
 /* PCIe high mmio is fixed for RV32 */
 #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
 #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
@@ -470,6 +478,35 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
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
+static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle)
+{
+    RiscvRpmiFdtMboxConfig cfg = {
+        .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
+        .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
+        .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
+        .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
+        .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
+    };
+
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle, NULL);
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -506,6 +543,9 @@ static void finalize_fdt(RISCVVirtState *s)
                             s->memmap[VIRT_TEST].base,
                             s->memmap[VIRT_TEST].size,
                             FINISHER_RESET, FINISHER_PASS, true);
+    if (s->have_rpmi) {
+        create_fdt_rpmi(s, &phandle);
+    }
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
@@ -739,6 +779,18 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
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
+
     /* Initialize sockets */
     mmio_irqchip = virtio_irqchip = pcie_irqchip = NULL;
     for (i = 0; i < socket_count; i++) {
@@ -897,6 +949,21 @@ static void virt_machine_init(MachineState *machine)
     /* SiFive Test MMIO device */
     sifive_test_create(s->memmap[VIRT_TEST].base);
 
+    if (s->have_rpmi) {
+        MachineClass *mc = MACHINE_GET_CLASS(machine);
+        const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
+        g_autofree uint32_t *rpmi_hart_ids =
+            g_new0(uint32_t, machine->smp.cpus);
+        RiscvRpmiConfig rpmi_cfg;
+
+        for (i = 0; i < machine->smp.cpus; i++) {
+            rpmi_hart_ids[i] = possible_cpus->cpus[i].arch_id;
+        }
+
+        rpmi_cfg = virt_rpmi_config(s, rpmi_hart_ids, machine->smp.cpus);
+        riscv_rpmi_create(&rpmi_cfg, &error_fatal);
+    }
+
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
@@ -1050,6 +1117,20 @@ static void virt_set_aclint(Object *obj, bool value, Error **errp)
     s->have_aclint = value;
 }
 
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
@@ -1166,6 +1247,15 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "enable/disable emulating "
                                           "ACLINT devices");
 
+
+    object_class_property_add_bool(oc, "rpmi", virt_get_rpmi,
+                                   virt_set_rpmi);
+    object_class_property_set_description(oc, "rpmi",
+                                          "Set on/off to enable/disable "
+                                          "RISC-V RPMI devices; requires "
+                                          "librpmi and is unavailable with "
+                                          "KVM");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 6e4fbf4b64..c9fb118fc8 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,7 @@ struct RISCVVirtState {
 
     int fdt_size;
     bool have_aclint;
+    bool have_rpmi;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -82,6 +83,8 @@ enum {
     VIRT_VIRTIO,
     VIRT_UART1,
     VIRT_FW_CFG,
+    VIRT_RPMI_SHMEM,
+    VIRT_RPMI_DOORBELL,
     VIRT_IMSIC_M,
     VIRT_IMSIC_S,
     VIRT_FLASH,

