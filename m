Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBD0CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFyFa-000321-GL; Sun, 11 Oct 2026 14:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFT-0002yP-9V
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFR-0008T2-Cs
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:14 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69BILP51420170
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:sender:subject:to; s=qcppdkim1; bh=m6oF
 uiTVb24CD7SBzXo9f+RpEjr4Z1iVgWhANPx/q8M=; b=o7A5xUV8JUXWlaouRwY4
 3/ViNRDfxZtmeIuQDCXrSmAYepNA9RPYF6UiaHNIWPamk0cDZbMFC6/qWFtOd1D9
 hrMGl/tWKNi+TSBLtwFr6mSWWuInJotyvBUrTMpOqfBvKqB8+Z3pinSn3o+X856M
 g+EYMnigrFJjLYMlBzTMyvc7XUGRZ5VtLCP3D1k7BourLoGt0VdMhZgwQ0cgSIkn
 LfJe57n1UoatBpghcY/KOLUQACNYvsk80VGTiH3P44sPk8t6VuJBwMpkJ4pJrzu7
 DDsdOsErUWX0E3v1wDPN2PL6LLDj4Tort1ZB8RUPf7zWGNoBF6+/94E6s2sytkSM
 CQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cc6bpy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so3045345eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791743171; x=1792347971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m6oFuiTVb24CD7SBzXo9f+RpEjr4Z1iVgWhANPx/q8M=;
 b=PjE/giA8Uady6jZW8iMyd6wnuBMbeA+Q9RmFeyTqKtQ66BiNKXCG85s4I4W3h4y1Gw
 feMhflM0bgxjVgGR1W/kZmBr7lctAncjoKDAZ3q22uhJZSzs5mlyknuEKOxy7iKzaA+o
 FnjH3MRGGtlEAewDWgAe69qt5QPMy7NeORv67sckNCkpsKfuuuPD0KfgUSmsS/YIn5le
 6FmTIi3ZB9FRPJ2KKFla/iBPMwEp/n12zCR9RJA3wadP0sHDKTN8wNm22oAWdWhdLRFF
 MT62MUhJz+4zhBGd8B+NL/0ibzkwRQgJUK3zIwX+pTg3DgPuIjGkSKACV03pRwflq5Zh
 TGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791743171; x=1792347971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m6oFuiTVb24CD7SBzXo9f+RpEjr4Z1iVgWhANPx/q8M=;
 b=1fst3claOcKndu/PUzMKgjJKfIkRs6/kDug1hr5omVtadVFAolHwSTbXpFGV9JVDwl
 r6skoDqZn8S8xGIWJxSRFo5b7To3+cKJXZlXvmGP+g20u7bHtIfvvFxXU8UQKIzPz+UC
 qBe2xsZ/WaufMnJ8bkTSmEQgaVVInAp67roMzhdrGCBdki7r16t+xHC32aXoXf8VGwiP
 oOnDNuP9DT317zlaO7hEeNVzJ4OLpZcAxz6HFqUI4gDyfOPetdAxxRqnuY09nZKaFl0I
 aUOGYDfcY54M/babk8PvgxtUakPCkujH1+4yCUeGQ/pfEUOqq5gua2zfaQ+M1EPUHJZL
 n0fg==
X-Gm-Message-State: AFq9FYLclflr0PELyJICAxdDhSUmnx/8C+rF+kKuGZQ5GxyRozstN1wM
 43PQvOxL6thJK9Z8Xpu4XHDQ/u0hrV1tnBfa4BrgidDo89M9v4nIKVcTTo1MFcT6lvj04jSkeW7
 l7LnbFZDBlwRnLkuWHvuMH26Wpu5XrVB8OPR/n81GshhJayLu11tpLQqyvMXI3fEOGg==
X-Gm-Gg: AYBFou0ePZsh4r2646lPveMMHSxigwbWgBOoQtI1QMngjvXNKJB2viPK4PM2ydCDetB
 nRpiF5V4k+rNrCu1Ihc7jLE1Kfbkb5fATyQo4OHSlYUlwBiwefgbyRVsh0YGZaiZXgGWh/Ar4/l
 B7XgmVKhlFCyS0ubgTAgd1HZAl1fGDhNIeVQ+lbVwI2eWG3BzrB9+VkWlTs0s6VY4YNIw7p3Cl7
 bewJOxT3QD0oy9X4ND5XD0QkjaQLesWXPIwQWQn8grnEiVAmdKo1lPUnoGaDaEeZK384J9R591o
 6HsdJ/Xbe2Mi9IIng3CdD5IuME97YAygr6M5TaWaq8abULuYlaQ3RPOdFxwskPiSewQddfdIKke
 i8vUdd0Re/I4RqVeR2J3zm09MXBFjsEj7ncfiimGwUmucRZQBvBPr1Lk=
X-Received: by 2002:a05:701b:4508:10b0:154:fa0b:6df1 with SMTP id
 a92af1059eb24-16a5e49d6c9mr9218483c88.37.1791743170949; 
 Sun, 11 Oct 2026 11:26:10 -0700 (PDT)
X-Received: by 2002:a05:701b:4508:10b0:154:fa0b:6df1 with SMTP id
 a92af1059eb24-16a5e49d6c9mr9218444c88.37.1791743170328; 
 Sun, 11 Oct 2026 11:26:10 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm22505284c88.22.2026.10.11.11.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:26:09 -0700 (PDT)
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>, Sunil V L <sunilvl@oss.qualcomm.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: [PATCH 2/4] hw/riscv/virt: Add ACPI PPTT table
Date: Sun, 11 Oct 2026 23:55:50 +0530
Message-ID: <20261011182552.1071742-3-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CiSgojXSnJ9oDYdG0uF9-ue1Qmg1L7PZ
X-Authority-Analysis: v=2.4 cv=XdQcX455 c=1 sm=1 tr=0 ts=6acbd4c4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Bq6zwJu1AAAA:8 a=bgGojp78X7_NmGY_0FYA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfXyMtDGjymnWBd
 T/aazgChUJG8OUpij7chrcs1FCt5fRNev5ykY/mZKzDAu8S5JGLpCI13EZRyHGEB+JkYLOWDtgB
 Nlo3lf+zwNZrfwmZXRNcZjV6Uuq5ZoGVAz/3N/XKh3S1lK3AT5pc5L+H0QJ4jZuBk0LWRpI3r+C
 AwBExDbj0oqb/9mIcmMvLS5c7hLxKiqZHhXZp+E2voe6zGZFlqOtSBeOhprhUOp71hMOjQ+xKUj
 OVa32tEOvq1VsU6FBgx8uWgxUz1PXk+skMsXHrGyxB9/UXHYgTyybXHWnmB7F7YDOVPXrGBGHe4
 qlT1hut59VnSorRSitE6DYgvHJXfwbSpCuWTIZNBCVlgF+04/W3Fk107nv6Dsx/FQwei/TK3qXp
 YHZVMJSCBRaI9Tivmt73EB3ql6cQOWtFskPF/vlugKF+EOMmaP99bvqG8jwXUmX2lrmzwHBNOQZ
 zuiXACP4d3qP+mcIp4g==
X-Proofpoint-ORIG-GUID: CiSgojXSnJ9oDYdG0uF9-ue1Qmg1L7PZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfXwCTBt+PfErPU
 Okzwt3T4+VrcbZ/fPdcICwG30FPru+L+6L8rPoIQP/O9YcwryxQnsWVno4Xs4FTlE8gTyPYkwrj
 jlFQab3ygnsZc8nKJh6KsWUpOisjLys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-to:  Sunil V L <sunilvl@oss.qualcomm.com>
From:  Sunil V L via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sunil V L <sunilvl@oss.qualcomm.com>

Generate the Processor Properties Topology Table (PPTT) for the RISC-V
virt machine.

Describe the machine using separate L1 data and instruction caches plus
unified L2 and L3 caches, and enable the corresponding cache and cluster
SMP properties.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/riscv/virt-acpi-build.c |  7 +++++
 hw/riscv/virt.c            | 54 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  4 +++
 3 files changed, 65 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0475dcb5c601..3c72a03dadb6 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -882,7 +882,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
     unsigned dsdt, xsdt;
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(s);
+    CPUCoreCaches caches[CPU_MAX_CACHES];
+    unsigned int num_caches;
 
+    num_caches = virt_get_caches(caches);
     table_offsets = g_array_new(false, true,
                                 sizeof(uint32_t));
 
@@ -915,6 +918,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
         spcr_setup(tables_blob, tables->linker, s);
     }
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_pptt(tables_blob, tables->linker, ms, s->oem_id,
+               s->oem_table_id, num_caches, caches);
+
     acpi_add_table(table_offsets, tables_blob);
     {
         AcpiMcfgInfo mcfg = {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f60..245651fbbd13 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -109,6 +109,45 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_DRAM] =         { 0x80000000,           0x0 },
 };
 
+CPUCoreCaches virt_caches[] = {
+    {
+        .type = DATA_CACHE,
+        .sets = 256,
+        .size = 64 * KiB,
+        .level = 1,
+        .linesize = 64,
+        .attributes = 0x0,
+        .associativity = 4,
+    },
+    {
+        .type = INSTRUCTION_CACHE,
+        .sets = 256,
+        .size = 64 * KiB,
+        .level = 1,
+        .linesize = 64,
+        .attributes = 0x0,
+        .associativity = 4,
+    },
+    {
+        .type = UNIFIED_CACHE,
+        .sets = 4096,
+        .size = 2048 * KiB,
+        .level = 2,
+        .linesize = 64,
+        .attributes = 0x0,
+        .associativity = 8,
+    },
+    {
+        .type = UNIFIED_CACHE,
+        .sets = 8192,
+        .size = 4096 * KiB,
+        .level = 3,
+        .linesize = 64,
+        .attributes = 0x0,
+        .associativity = 8,
+    },
+};
+
 /* PCIe high mmio is fixed for RV32 */
 #define VIRT32_HIGH_PCIE_MMIO_BASE  0x300000000ULL
 #define VIRT32_HIGH_PCIE_MMIO_SIZE  (4 * GiB)
@@ -140,6 +179,15 @@ static void virt_flash_map(RISCVVirtState *s,
                          sysmem, VIRT_FLASH_SECTOR_SIZE);
 }
 
+unsigned int virt_get_caches(CPUCoreCaches *caches)
+{
+    for (int i = 0; i < ARRAY_SIZE(virt_caches); i++) {
+        caches[i] = virt_caches[i];
+    }
+
+    return ARRAY_SIZE(virt_caches);
+}
+
 static void create_fdt_socket_plic(RISCVVirtState *s,
                                    int socket,
                                    uint32_t *phandle, uint32_t *intc_phandles,
@@ -1144,6 +1192,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
     mc->numa_mem_supported = true;
+    mc->smp_props.clusters_supported = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
+
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv_virt_board.ram";
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad9..1e498a4f5f6e 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -121,10 +121,14 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
+#define CPU_MAX_CACHES 16
+
 bool virt_is_acpi_enabled(RISCVVirtState *s);
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
 void virt_acpi_setup(RISCVVirtState *vms);
 
+unsigned int virt_get_caches(CPUCoreCaches *caches);
+
 /*
  * The virt machine physical address space used by some of the devices
  * namely ACLINT, PLIC, APLIC, and IMSIC depend on number of Sockets,
-- 
2.43.0


