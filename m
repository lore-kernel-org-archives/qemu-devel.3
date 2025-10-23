Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D5CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuKJ-0005PS-JM; Thu, 23 Oct 2025 08:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuGA-0001Hn-7W
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG5-0006Rv-4w
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N5GEA3030419;
 Thu, 23 Oct 2025 12:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+0H0Da
 7VdCvdfrj0RFNrEHQOMPnaTngWJ/qx5eIWKFQ=; b=AkeVGH2uzvUpAo/NGlXkYW
 iv44OmNl/gcQDlAJrMITL9RJmpw9lXEMfVxL+ugE3GWNuUbdQ3o8LX4L+/PjCXtx
 sqPN+TkOo/uUvmPBaGrVZlJmRikg5Z70gW21wqbdALGgyfjqoU8CtnNhJqZL1J4g
 d3Vjz8A//yeWqivChymon43XzaD25YVZUBKSOANhSLx4jrNDlahkvNrYOWjv40nz
 JDU+9QPNqqVhsMWtX6o7nDshh5moS+B4tun446ANc+tJVKDardw+fPHHO8A074O+
 GQRANyZR6ND288D4Evd2tsJ7eHa0RWQVWc5VHNfHQbOZKRmz/r1gzMS9iQF4eIyA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgp05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N94bRo014650;
 Thu, 23 Oct 2025 12:17:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdtu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHRqc49742198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAB8120043;
 Thu, 23 Oct 2025 12:17:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11E4A20040;
 Thu, 23 Oct 2025 12:17:26 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:25 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/32] hw/ppc/pegasos2: Move hardware specific parts out of
 machine reset
Date: Thu, 23 Oct 2025 17:46:39 +0530
Message-ID: <20251023121653.3686015-21-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mMgOvhBZXlU1NI7lFpdICaoAGBiqqnFY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2N+cE04tw4iD
 8Riga3vqWchgZHLc+j4PYlSU4FT7D+YwUQh2kvfag8I7G+WPWcr5xB22BtjP5oKmmS5xvVJIk1N
 IeLsCDvkyaC2VSj1QK++qG8icH/E0iW0SvWEStRqpcFhl143MoNjHvfFrpJnnn63yPe0kGko4W2
 tpBSuYbGHLEn03CxH/QTKKZOR7P2zxYUWcrhVDrFfpKhPbZw8FVk54AklrcW32L/dwL7RXMVi/M
 RN2Tes479wootE4qHpmnfbmwaWBd0yHR4pjnw/5O33WJFk2L60C8ZDNwA2kcSgXL2afiFKYsn7G
 mPjGdQ3tQpU1x+Kj8NLdaViU1dM2lOZ0qseArJ0iaoTFY3iP4uJSMf4sX1l4JfKZoUp8P6y4EDX
 0BYspP11PeZaVZMQf6+7oaPQCj3XGw==
X-Proofpoint-GUID: mMgOvhBZXlU1NI7lFpdICaoAGBiqqnFY
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa1cd9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=29-1D86bl-XE_ZHJWoEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

Move the pegasos2 specific chipset reset out from machine reset to a
separate function and move generic parts that are not pegasos2
specific from build_fdt to machine reset so now build_fdt only
contains pegasos2 specific parts and can be renamed accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 2f9bd3eac5..ed3070204b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -57,10 +57,6 @@
 
 #define BUS_FREQ_HZ 133333333
 
-#define PCI0_CFG_ADDR 0xcf8
-#define PCI1_CFG_ADDR 0xc78
-#define PCI1_IO_BASE  0xfe000000
-
 #define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
 OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
 
@@ -82,7 +78,7 @@ struct Pegasos2MachineState {
     uint64_t initrd_size;
 };
 
-static void *build_fdt(MachineState *machine, int *fdt_size);
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size);
 
 static void pegasos2_cpu_reset(void *opaque)
 {
@@ -284,6 +280,9 @@ static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
                                  MEMTXATTRS_UNSPECIFIED);
 }
 
+#define PCI0_CFG_ADDR 0xcf8
+#define PCI1_CFG_ADDR 0xc78
+
 static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
                                          uint32_t addr, uint32_t len)
 {
@@ -308,23 +307,12 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
 
 static void pegasos2_superio_write(uint8_t addr, uint8_t val)
 {
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
+    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
+    cpu_physical_memory_write(0xfe0003f1, &val, 1);
 }
 
-static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
-    void *fdt;
-    uint64_t d[2];
-    int sz;
-
-    qemu_devices_reset(type);
-    if (!pm->vof) {
-        return; /* Firmware should set up machine so nothing to do */
-    }
-
-    /* Otherwise, set up devices that board firmware would normally do */
     pegasos2_mv_reg_write(pm, 0, 4, 0x28020ff);
     pegasos2_mv_reg_write(pm, 0x278, 4, 0xa31fc);
     pegasos2_mv_reg_write(pm, 0xf300, 4, 0x11ff0400);
@@ -387,6 +375,23 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 6) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x309);
+}
+
+static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+{
+    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    void *fdt;
+    uint32_t c[2];
+    uint64_t d[2];
+    int sz;
+
+    qemu_devices_reset(type);
+    if (!pm->vof) {
+        return; /* Firmware should set up machine so nothing to do */
+    }
+
+    /* Otherwise, set up devices that board firmware would normally do */
+    pegasos2_chipset_reset(pm);
 
     /* Device tree and VOF set up */
     vof_init(pm->vof, machine->ram_size, &error_fatal);
@@ -405,10 +410,25 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
         exit(1);
     }
 
-    fdt = build_fdt(machine, &sz);
+    fdt = pegasos2_build_fdt(pm, &sz);
     if (!fdt) {
         exit(1);
     }
+
+    /* Set memory size */
+    c[0] = 0;
+    c[1] = cpu_to_be32(machine->ram_size);
+    qemu_fdt_setprop(fdt, "/memory@0", "reg", c, sizeof(c));
+
+    /* Boot parameters */
+    if (pm->initrd_addr && pm->initrd_size) {
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                              pm->initrd_addr + pm->initrd_size);
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                              pm->initrd_addr);
+    }
+    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
+                            machine->kernel_cmdline ?: "");
     /* FIXME: VOF assumes entry is same as load address */
     d[0] = cpu_to_be64(pm->kernel_entry);
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
@@ -827,12 +847,10 @@ static void *load_dtb(const char *filename, int *fdt_size)
     return fdt;
 }
 
-static void *build_fdt(MachineState *machine, int *fdt_size)
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
     FDTInfo fi;
     PCIBus *pci_bus;
-    uint32_t cells[2];
     void *fdt = load_dtb("pegasos2.dtb", fdt_size);
 
     if (!fdt) {
@@ -840,21 +858,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
 
-    /* Set memory size */
-    cells[0] = 0;
-    cells[1] = cpu_to_be32(machine->ram_size);
-    qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
-
-    /* Boot parameters */
-    if (pm->initrd_addr && pm->initrd_size) {
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
-                              pm->initrd_addr + pm->initrd_size);
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
-                              pm->initrd_addr);
-    }
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                            machine->kernel_cmdline ?: "");
-
     add_cpu_info(fdt, pm->cpu);
 
     fi.fdt = fdt;
-- 
2.43.5


