Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8BAD262A4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJDa-0001ET-Se; Tue, 20 Jan 2026 16:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tuan.phan@oss.qualcomm.com>)
 id 1viHaj-0001Ro-Aq
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 14:40:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tuan.phan@oss.qualcomm.com>)
 id 1viHah-0006MA-JT
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 14:40:41 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60KHBimH314500
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 19:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fJy4OKeqPYDiPbzMUrZAr72oAD9m00J6VLd
 3kuXJGs0=; b=USi3j+sCoWPN6V8ucb19tE1bFMw4AvHC0lFP6yYVIfmCWfqeBuz
 FmcQhE+fVH07ogelCiePfUALDDuS4JijRrmYBc6gIzZmfjEX+wbwu0OfHzU8b82b
 Ph4qCn4QjGu+I7ho4QKqknNqJ5Yo0y6emzkJDT07YBB08wWhfKBLTqsv2yRw2nGk
 ASuqIfGtm4kfCwyvwcwFkgbRMbOmNDEI1vuN1qxgiI1QFp5CQCWhVf7q5Ta9gbeW
 j936UdvXNM59+6MKS0iSoeuplJuyo52ECiAa7ScLBeVGbDZfJWgPL8ciO6Z60YHu
 4LMFGFYECKPxlGxgChir5s5biUIv2mBKYeg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btdw28j3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 19:40:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b704019c98so959080eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768938036; x=1769542836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fJy4OKeqPYDiPbzMUrZAr72oAD9m00J6VLd3kuXJGs0=;
 b=iNykuToiA2Sg4MqKNpsaS0wDMRqyEfXy/xHNMOWYQ3H45qOZqXJ8JqNpd/s3UQgPZQ
 dOIH/KJ4mDl3OafeHMoOSUtDTVbtnInX+RE1unFvcSM9ZMV1f5Mivy5pV8xBihsy+Fr3
 Zq77a13BqTBhYrMVfGuGRMAX8IUWSDAHv8FMkNpVXnkQf2pUqxjizHMC+Ko5PAM2xQWK
 xp5dg8nK2wjOFAAx2NnpXF3ON2pb6EigSY+hzz53EHAi2K6iIFDt1e+HwxdvfNYX4mmp
 +6bar5qi4LTmlqDf7nq/GKQPa2W6xkVAV/Jztrb37h4+PBgje/oFst1jRJ6+yZh/hmqq
 fXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938036; x=1769542836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJy4OKeqPYDiPbzMUrZAr72oAD9m00J6VLd3kuXJGs0=;
 b=IFk0ddd5KrS4sCcfYDqAHgFJJlAk/fML4TnKCZ8B1PoviqCRXKoC3vAPzO4eauPc09
 o4lLD3XWSg8HpYbrjxE3c4FUhz+vcUzOMal3RYvxeO3LPXuteF49u8OvwEsQ9Y5prbaX
 wdR9BMvgGqfvL6H0OLMF/TBD93h7195FnimYqVjKlcqp9d7xQWEGJZoVGM/1eeaXmPed
 qdkd1ybV4UXdi6jHq/M/xD1dR0vTEISYi5W9xC6jTUHdxySATEcg4bIKIXHFhV7rI069
 A7IgNKQLl5zslCDMPAlXiR/t8cZZfLIT6x9qgnp2/NH8wY/OrDKmclpGcyL66/DvcwlJ
 QyDQ==
X-Gm-Message-State: AOJu0YzJZksHDJTCGPHC76b8VIkDt1wjiTson6drAgq0ckVvvU8iACHm
 zm1RrlOr5gDhajTUq8Jbj+2P+6TANeu2Qp9J8ehpu6w/upJOGph5GOOik8QwwRnjunYPJv11uN7
 MCMXthcqzb25TI+yv5QxIm5B9YyTGFY20XTsIt2+nCZp5VDrGW0CkAq1paUHyFmsHpQ==
X-Gm-Gg: AY/fxX7HXCBbMh2pAa2p5Hxqr44z2G8nQQ8uBSOXXiR9sBI2PbOywjs5oUxrAPiHmsy
 L+Ssx4azbgQ1ipPbNIVLWMPWx3ShRcr5r4M6uKV3DWMX4R3azENb2kRh4nF+M2pBAuikME2ZA/L
 2P4A6oKaAtBLV8D13AoPGbH3qm50UqdaybtolyIKPW352uyJIKRclHuhJA1PeNDNN2ewNvx6Epq
 ZFNy/uFwhM4hj6bQSbJy6QTwvZReB1UGiph0k54PsLtIIJ6L4XOXi9Mav++dpJDH68ZjxTAaEkG
 gQrITS3kFbKSiupSmSpI8xJOLAVqpFlRczSmyPKI1gN9hzO4xtpIw/VgFMGPwejmTOFcdrKqAvg
 lZDM1Crqo4Ngs/00LiGILJwbQMcKRcPhrbVgOCdpCXj/w3WDeUwOjrOXEH7hZ
X-Received: by 2002:a05:7022:48e:b0:119:e569:f60d with SMTP id
 a92af1059eb24-1244b304b60mr13031650c88.6.1768938035890; 
 Tue, 20 Jan 2026 11:40:35 -0800 (PST)
X-Received: by 2002:a05:7022:48e:b0:119:e569:f60d with SMTP id
 a92af1059eb24-1244b304b60mr13031620c88.6.1768938035166; 
 Tue, 20 Jan 2026 11:40:35 -0800 (PST)
Received: from hu-tuanphan-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b710acfe04sm258479eec.30.2026.01.20.11.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:40:34 -0800 (PST)
From: Tuan Phan <tuan.phan@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Tuan Phan <tuan.phan@oss.qualcomm.com>
Subject: [PATCH] hw/riscv/virt-acpi-build.c: Add TPM2 device node and ACPI
 table support
Date: Tue, 20 Jan 2026 11:40:33 -0800
Message-ID: <20260120194033.4049570-1-tuan.phan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PHkFh3AcdF21I4mpRdcpc745F4r3cVyR
X-Proofpoint-GUID: PHkFh3AcdF21I4mpRdcpc745F4r3cVyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE2NCBTYWx0ZWRfX0L9Q3sh+rFof
 +LGn7Sa3AbVdRN8Er5lYnwRItARCsyY5vdY6pHeS3b7Ao8ltsXC8aV+6KWscexWffMHqyYoXDcw
 AIfwxVu+a4QCN6igDA2ZBhcH9lshxhuWp8lrMk564DvcKmR+pbjRLGxoMYaXDA3M3pucF/KyvIP
 D039TTwJmmA++p6Xjr0vETz6vlhYpVPvhJSF8p4WHYChd6G0ADrkbVR2b+qBB3npIoceE0M4JSb
 /FqgUULybT9l5IYV4JVeWNuSj7oRd0LCp460TcEVr0K2RITHd+/QHj2XVlEH9fe7OGesY8ylonJ
 QwWcRS8m4ueK6f+vsN5i4/oz/CqKtrp7LBLhNPVyqMOaLQW10EtxUsJRj27PAfZ0gaIkZb4wOui
 LFtiGffmx+a7mpUpGj0k+vXhFK6n0aVcNXq8WTEHKD/4P0u3FLkc37xdFvSm4+AUP8Sx0ojdrR5
 lG4yKVstKtN8EtpRqfg==
X-Authority-Analysis: v=2.4 cv=RqzI7SmK c=1 sm=1 tr=0 ts=696fda35 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bw0JMP8oQ6H-mC2jY9sA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_05,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=tuan.phan@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jan 2026 16:24:53 -0500
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

This patch enables TPM2 support in the RISC-V virt machine ACPI builder.

Signed-off-by: Tuan Phan <tuan.phan@oss.qualcomm.com>
---
 hw/riscv/virt-acpi-build.c | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index f1406cb683..b300492b2f 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -32,6 +32,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/core/platform-bus.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
 #include "hw/virtio/virtio-acpi.h"
@@ -39,6 +40,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
+#include "system/tpm.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
 #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
@@ -224,6 +226,44 @@ static void acpi_dsdt_add_iommu_sys(Aml *scope, const MemMapEntry *iommu_memmap,
     aml_append(scope, dev);
 }
 
+#ifdef CONFIG_TPM
+static void acpi_dsdt_add_tpm(Aml *scope, RISCVVirtState *s)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(s->platform_bus_dev);
+    hwaddr pbus_base = s->memmap[VIRT_PLATFORM_BUS].base;
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
+    MemoryRegion *sbdev_mr;
+    hwaddr tpm_base;
+
+    if (!sbdev) {
+        return;
+    }
+
+    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    if (tpm_base == -1) {
+        error_report("Failed to get TPM MMIO address");
+        exit(1);
+    }
+
+    tpm_base += pbus_base;
+
+    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
+
+    Aml *dev = aml_device("TPM0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
+    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs = aml_resource_template();
+    aml_append(crs,
+               aml_memory32_fixed(tpm_base,
+                                  (uint32_t)memory_region_size(sbdev_mr),
+                                  AML_READ_WRITE));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+#endif
+
 /*
  * Serial Port Console Redirection Table (SPCR)
  * Rev: 1.10
@@ -479,6 +519,10 @@ static void build_dsdt(GArray *table_data,
         acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU_SYS_IRQ);
     }
 
+#ifdef CONFIG_TPM
+    acpi_dsdt_add_tpm(scope, s);
+#endif
+
     if (socket_count == 1) {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
@@ -914,6 +958,16 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
         }
     }
 
+#ifdef CONFIG_TPM
+    /* TPM info */
+    if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
+        acpi_add_table(table_offsets, tables_blob);
+        build_tpm2(tables_blob, tables->linker,
+                   tables->tcpalog, s->oem_id,
+                   s->oem_table_id);
+    }
+#endif
+
     /* XSDT is pointed to by RSDP */
     xsdt = tables_blob->len;
     build_xsdt(tables_blob, tables->linker, table_offsets, s->oem_id,
@@ -1025,6 +1079,11 @@ void virt_acpi_setup(RISCVVirtState *s)
                                              build_state, tables.rsdp,
                                              ACPI_BUILD_RSDP_FILE);
 
+#ifdef CONFIG_TPM
+    fw_cfg_add_file(s->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
+                    acpi_data_len(tables.tcpalog));
+#endif
+
     qemu_register_reset(virt_acpi_build_reset, build_state);
     virt_acpi_build_reset(build_state);
     vmstate_register(NULL, 0, &vmstate_virt_acpi_build, build_state);
-- 
2.43.0


