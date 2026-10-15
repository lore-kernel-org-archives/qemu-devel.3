Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D28CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHFJb-0003pM-TP; Thu, 15 Oct 2026 02:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJZ-0003oB-Qo
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJY-0007kc-6N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F2K6Mt841683
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4DL+SBQ2Ss3
 ATMiGsknsh3lcVREWPyJVJydoWib4YtU=; b=dVYR7Aj3xCJMIOf9qVrgu9TyOxT
 KGEDnTCNfvvUWOxPj1wsHMDsqhV8sqEvF5hK8VZiqHnTHhhDaN9qVWX1FcVLmoOi
 jI/8pWJPZkX+gBVHlm8F6Pxpjx+3u7PxpgYDdAB3JQK4U90AWbaQpN/zAC1KY0ER
 e2eh7h85v0o86ryKIk3dKNg6eeLeyvJlS27xhHTf3Uy+D6IA42f4cyQpIMmgEQkm
 pXfdOnjVoFBtpU/8Rabjh2pYLLbVLk18+EGY7VDnyX3iL9GuAuL1uGBpAWJPNlU6
 MLFfaGcHEMFTSD6OOwwDwJc2TclTbbyX3nZ4f+GTwOtUGXaDCcy2eq/h2aw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wtk9n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:42 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so5719844c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792047102; x=1792651902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4DL+SBQ2Ss3ATMiGsknsh3lcVREWPyJVJydoWib4YtU=;
 b=N5Gs4mqSobLMqETjK4v4HA5bW0e4rPHxJmZn6q1MjEoKLqUD7bP6Qwzr4y7gJOrMbS
 sivYeV/8byNgzgGATQSjJLArDivBvJ20bCd48vENrxtlq8iZdnppZViixoXW0GvzTQyH
 6QmFJ6MfgtgVORlvs5J55AnmzBOtJVdvYhP785I3XZuC+5LKfgMDebE+EDM1o37FVSqE
 HL9L1G8bD8auAycid13Udff9yoUoUe7QPppu9r2j6rQgeuFK4C+49XOvrXgi7i3BQBqw
 aX9ST3rc80cnCL6/qtEj61vZDmaKBI2vrkNrHk7P2REkbl0IEM2mn2LJmaLkzfr6b7IP
 zoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792047102; x=1792651902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4DL+SBQ2Ss3ATMiGsknsh3lcVREWPyJVJydoWib4YtU=;
 b=za++YlSPcAlAnGqFqNR7FHZ8HXJoRVtQHmatvv9Z/v0e7ytqasUQPhfObKxlt9UJZY
 vJ6qJ3QPXSSxq7kdoKGWDfytNQupg330/tcFXSFzIJSLRKw79n270+siGIHtnCHL3CiA
 p05Kc4QCKoFb8gRx1IENf4X+J1HSro+A+/FZlyp4QeLgzwZ8JB5svTMc9YTD3BwCIj4c
 +PuyzUxkAKwXicN2UCyukti4FGeIV6yLd42FoIaVeHyB0pRD/7xvViiYjwUttBXlx429
 7BlBf87ef4SIoInmNUQongB9UC7dDQZuRhSx+2imx4HkxlWRynG0JF1TvcppEcvrLmqR
 54Lg==
X-Gm-Message-State: AFq9FYL2X4eCb/7eB4ifoH6ytKaBNVqtfpm2oas4lnMJY2El9NYxZuYb
 oxu9y0byRSKh9Gm8+X6WHbAcQl+W0cKhGiWwfFcI7SwEDpE9AwLo7U2b/IP8/HZtHwKj2EBgZ7L
 wSJ3GGO3SeW/8edurxLsEC1sUejD2qICqBwmv3QqyISX0pTNamOlWkSl6L++iRQqCHA==
X-Gm-Gg: AYBFou1p4bRM/nl/Lwe2yhX1TUPR8fWCqPJgcyaFOoNXxWGuOdRChIb78Ew/FAwOR1c
 cR5waoPG4+rkwCkwkqdfBIBi66Qq+kTigU9FtaYB78dMFiB3mE9rngtiomC/DQ0ZdJPkxpoKdIe
 /KE7YogiIJ6oK9LsXEaa6BpPPLwmC9s/iSK3z38OaYfR28q2ecVU6smB9ihGQTwm5vAqnjlmZ41
 ja2bBZGTXTEm6maAfruFlC0O2ZgGZIORikRDtjuskAjuWL0vGUdwXU3YIfkB5ef9DlScnZyYKvb
 +ZkCR71Pkvkb98ttBWQ2/j+RWKisCaLh87FscfsGwOZzidrI0SIyHahIgDa4sCNLPHPEE9z7jUe
 U0WwfBs6i50pa1+m4I9uUt3Q5s2b/6H096luegfM26n+CE/afZmr3+NY1ZcfUcqIg1Rx+5T8Ir2
 gMS/rRNnQRVeM=
X-Received: by 2002:a05:7022:1584:b0:143:4d12:396d with SMTP id
 a92af1059eb24-16a61a6def5mr33427291c88.26.1792047101728; 
 Wed, 14 Oct 2026 23:51:41 -0700 (PDT)
X-Received: by 2002:a05:7022:1584:b0:143:4d12:396d with SMTP id
 a92af1059eb24-16a61a6def5mr33427204c88.26.1792047100330; 
 Wed, 14 Oct 2026 23:51:40 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm67451789c88.16.2026.10.14.23.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 23:51:39 -0700 (PDT)
From: Sunil V L <sunilvl@oss.qualcomm.com>
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
 Drew Fustini <fustini@kernel.org>, Prajwal N <prajwal.n@oss.qualcomm.com>,
 Shankar C <shankar.c@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: [PATCH v2 2/4] hw/riscv/virt: Add ACPI PPTT table
Date: Thu, 15 Oct 2026 12:19:55 +0530
Message-ID: <20261015064957.4076464-3-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX0FrqsIAq/yyE
 jkhgsoIK9Oej3IlJe+97Ih3I0GLJKew64qoR9HRXRUUn5nz9fE6GeZeoW4nyt8yYrnDjwUo4aQR
 olhNFsXOR9Yx07+7kAfZq1sc25cwJZo=
X-Proofpoint-ORIG-GUID: 0PyUiSnezpyA66bpyf6cBLJeD0S88Pj6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfXxk+0EizRcX2e
 3L1bAAPCGp3TmLz5+/dwPiD3K0BHrJQtBkQasJbrplQsrG6IEfetDyEEnnugDHrtbyxMB0Q3hww
 266xynXyfbvSN06Pp0AOT9MaaTl2uLvE9eV+YuR8I4CRc943dSrsc4Xrk9Zy3aHqsO0PofntHKY
 OtwxVGzfnhd1QS3hojwf21n3+yvFsasVI98nxTFf+/KcOabWKMl4SshGMebbalQL9MHOststski
 FB+LxLDICtG6m/ElTtyinomPIX1P1VRBHh49awpQ7Q74EogCZ/rCQtFNh/ccOL5yB0FGtGQrH7E
 7FMNEWc24kvaChhIdMRsKOzLu9pCAakezVcd2WxZysxd2JUUh8FvEU5ilQMgN9rsb9SQr/SnXUq
 ccVoS9IogYspX0mBEMPmhIHKg64P0w8BX2N7eFqAtvTX3nQJ3wU3Mm0a9eI7zRxEaJfEqPKsXaR
 FYhOo7S4ZZgj321RhOQ==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad077fe cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Bq6zwJu1AAAA:8 a=bgGojp78X7_NmGY_0FYA:9 a=Fk4IpSoW4aLDllm1B1p-:22
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-GUID: 0PyUiSnezpyA66bpyf6cBLJeD0S88Pj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunilvl@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Generate the Processor Properties Topology Table (PPTT) for the RISC-V
virt machine.

Describe the machine using separate L1 data and instruction caches plus
unified L2 and L3 caches, and enable the corresponding cache and cluster
SMP properties.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/riscv/virt-acpi-build.c |  7 ++++++
 hw/riscv/virt.c            | 51 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  4 +++
 3 files changed, 62 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0475dcb5c601..8254f1294a72 100644
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
 
@@ -909,6 +912,10 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
         build_rimt(tables_blob, tables->linker, s);
     }
 
+    acpi_add_table(table_offsets, tables_blob);
+    build_pptt(tables_blob, tables->linker, ms, s->oem_id,
+               s->oem_table_id, num_caches, caches);
+
     acpi_add_table(table_offsets, tables_blob);
 
     if (ms->acpi_spcr_enabled) {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f60..c84b17a40125 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -109,6 +109,45 @@ static const MemMapEntry virt_memmap[] = {
     [VIRT_DRAM] =         { 0x80000000,           0x0 },
 };
 
+static CPUCoreCaches virt_caches[] = {
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
@@ -140,6 +179,12 @@ static void virt_flash_map(RISCVVirtState *s,
                          sysmem, VIRT_FLASH_SECTOR_SIZE);
 }
 
+unsigned int virt_get_caches(CPUCoreCaches *caches)
+{
+    memcpy(caches, virt_caches, sizeof(virt_caches));
+    return ARRAY_SIZE(virt_caches);
+}
+
 static void create_fdt_socket_plic(RISCVVirtState *s,
                                    int socket,
                                    uint32_t *phandle, uint32_t *intc_phandles,
@@ -1144,6 +1189,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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


