Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F38C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03MT-0007JK-Tz; Fri, 28 Aug 2026 16:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03MS-0007Ic-QK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03MQ-0006UU-NM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:39:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7oWS3989422
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EF/HHtp2rvbcbWykXnApHPCp3cZe1I4jNoHX+KY8Hpg=; b=lgHJeIlcQp5DxCxJ
 PBxYtSm5GKT5ATeXF1IP1BTdZgfIOzbPrvqWvMKwpoYsGDr/p4PW+Sn0q84qhDvD
 Whi6Bkd2r1qCN0BHiBNyOPMOMZGj/xBppzViDs0Na0gcMZqyU8Dj2i+bi7yLqYJx
 P/ocCbmPIVU2kg3fEvqFZG3BkNfa4CShl7z1Fax8NsTMoW3w8ZK4uzfc9Qgzw/st
 8NWrr9Z5zA9a6JwOELxF+vQg6UWdFzCbHzY9M6a6yEsFmuRF9UNWUjeBzv1ew75c
 uOGReEclGzldqeeVne6d9mPk1Ds1su+Lf7k4XP6fkZW4AXcebA8aFikN10F1Datz
 WLfDMg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb62h2xce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so216470385a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949577; x=1788554377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EF/HHtp2rvbcbWykXnApHPCp3cZe1I4jNoHX+KY8Hpg=;
 b=PAPb2JckqneJ2NmrUWOo2bsJhlAHCz6ba3sn6G4vJleWiWyrsKDtu+aEyOMnTbnhtq
 2QWNPYpre/SMFqZHwcNeG0vP0zCNZ3/zYYhVt/Co0kYhmFvZs+FQAByjNeO+05CWPvou
 WNbaASlSrswembMZA1USfMC0aWJLl7t3WuXB/8M2Ocjsor6U48zyjmKTTNHbtB30yQDt
 8qsIbAl1VV/RiU+o0bS9KF+QQmpJkQC6VsCNkCOCuud+o5V2EnnMFUu/ZkPWUC5OQ5yi
 lYL1sdwv85/QtKmXRmsU0ZaD98/DZ3ChSHzIuNiNqqA+qIGl9CGu8Hwlg0GHlmjEI59C
 tKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949577; x=1788554377;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EF/HHtp2rvbcbWykXnApHPCp3cZe1I4jNoHX+KY8Hpg=;
 b=gXfba2RcEY/sfMcPFFN3wJ0C9dNztb6cK0MSl+fh5alKiVqnGpCCqsIvCgCpt2noxD
 3aUBxjRXSqU1KbZMq3LknQxfjpeFpSTIuYE75mxbS12CrMnTV9MFbnHda4yeWtMk9+u6
 lXl8exjxLKEVGSuMiWSBHBjCP6G2r7ZANPqItqK5IX9DXZYLNAFJPZjTyH/xYb9ebQxE
 BYJ0SOIDnAnIRaOuv58qzWWRRx7Y2kS7FIVNjBHD0stCsBw6cCHNP7LRcYD5ETUCMg48
 qFkqtY9zA8B3vpDK6Vue8oTfTdbM6weBL7YDjIw+sUv12e76JgT2JttygmAP0+SdwTpR
 uZ1Q==
X-Gm-Message-State: AFuF++l+sn1GfqcenjInG/wnnrR7kwKf3zR6BFcZ+m+aDnDQ0FWyjOV2
 oKW4iwq6N3gQrH4fgDU/ud42+TxUZA2QnX5mmDQ2jw0DA+W37i+asx+VueUhUyrjeThAbA57SVO
 GjN0ObEbajV0MQSkhINTNPOEooViLeyDxkfWgH0WVuhTx1nIel+3hlwgx60Mbj0zb4g==
X-Gm-Gg: AR+sD11ci0RRGFUvkpdCPbzb8bGxCOAR4IFblQ0j5PGUnvHEVdNChruGC2YZzGTx7fw
 Mwv1zZNVwoDMtrbgT8deKFWVvxmvrP25ULIYb07ECiraf+gDdbLf79qRy3DrZPe9Cu1zK6nzvh4
 Kw2BDXB8w1RmQ8dzFb36j2Lf+IozqN90vW/21f4lZX5LUb55S8QnI9+Q2zTgjHhvVy0ed2QLnzp
 JvwB8YQGZ1g3++7FMZrHjYX9KdLoLUrqpsT/KTbgDxZfCzxfc1a1+ZA81g/UMjnWwp6t0JAhlB6
 Nc52AXo5ujQi8yZHcRh46NcROUrn8MqUqM9JykIn24w0zFr2oxGI+LWVO8VdbnDcJB+xnykxpV/
 7zr5v31AGM7I129Dvo7F/kcq5SbUUq8PANqizng==
X-Received: by 2002:a05:620a:1b8a:b0:939:116c:284a with SMTP id
 af79cd13be357-939116c2f8amr1354425585a.14.1787949576620; 
 Fri, 28 Aug 2026 13:39:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1b8a:b0:939:116c:284a with SMTP id
 af79cd13be357-939116c2f8amr1354420585a.14.1787949576094; 
 Fri, 28 Aug 2026 13:39:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 03/15] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_syscon()
Date: Fri, 28 Aug 2026 17:39:05 -0300
Message-ID: <20260828203918.350131-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX+qDpNY8S+KQF
 BM9v0Q11Kb5aXqpy6qipmiBNrjspKxuPq/YmCPBZtQ9JyFv4hX13b0YoKvx0y+SYIOM7hezQ2bP
 AXaoPWmBXyAuvN/QoME3RzjmOxaqWVU=
X-Proofpoint-GUID: wB3GFhEkEc1f5X3zHWLCJJfvIvmyuxN2
X-Proofpoint-ORIG-GUID: wB3GFhEkEc1f5X3zHWLCJJfvIvmyuxN2
X-Authority-Analysis: v=2.4 cv=I5dVgtgg c=1 sm=1 tr=0 ts=6a91f209 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=4Tf7kDObtFz1SKwdFkIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX+cUySTSbRJZQ
 kxoWiXQWfOkojIqQAlQJHRVCq+izl7twwat0i2Td2fyizv0Rj59Zx/0nQrnF/SZo0185QcAhzWy
 oYiRRPxqh3PnbSMVwwW30mr74RqeakjgEMr9fHj9t5N7vZIe3bLQt/S4AO0fnEwwy8D71QchqzU
 /IJIEZMFif7XItQtIcC60b7IFfWmLtCF1zVk9XJR9+HQkKdXJ2ohaRfgJ6owu3ZvUVCefxL6Sc1
 tAqJGF3zALkmPV2cy3ehvCyJsP/hEqUN198sbq2Eu1yb1r1CkkmUtlV07h4k7HcU4JBxOpOGJmN
 Px74roHwk2d5zjSKF0cP3Ck5eWCR5kdCEddpsagl3TJpEQXczokeZ2yrX3Ft39b6D9l4VNGIdKo
 yeViCe8tQn9UnQYIEn3RJ8YrgVEJqmM1aJ0eVhg6VFyXyqQQTuPcYNDXXQn0ruEBmxk1wqeSMJ/
 pcIwmnhNwqQzwAJMnAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280179
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The soon to be added riscv-server-ref board will declare a syscon FDT
similar to what the 'virt' board already does.

It won't have a 'sifive,test0' and 'sifive,test1' compat string though,
hence we'll add a flag to enable/disable these additional properties.

The FDT is slightly changed: the subnode is now named 'soc/syscon' instead
of 'soc/test' to be compatible with the latest device-tree docs.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---
 hw/riscv/fdt-common.c         | 54 +++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 46 +++--------------------------
 include/hw/riscv/fdt-common.h |  4 +++
 3 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 6fcc1ce21f..eac5ca9322 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -295,3 +295,57 @@ void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
                                  2, flashbase + flashsize, 2, flashsize);
     qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
 }
+
+/*
+ * @sifive_test_compat is used to create a FDT that declares
+ * compat with "sifive,test1" and "sifive,test0".  This happens
+ * to be the case for the 'virt' machine that also creates a
+ * 'sifive_test' syscon device.
+ */
+void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
+                             hwaddr addr, hwaddr size,
+                             uint32_t reboot, uint32_t poweroff,
+                             bool sifive_test_compat)
+{
+    uint32_t syscon_phandle;
+    char *name;
+
+    name = g_strdup_printf("/soc/syscon@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, name);
+
+    if (sifive_test_compat) {
+        static const char * const compat[3] = {
+            "sifive,test1", "sifive,test0", "syscon"
+        };
+
+        qemu_fdt_setprop_string_array(fdt, name, "compatible",
+                                      (char **)&compat, ARRAY_SIZE(compat));
+    } else {
+        qemu_fdt_setprop_string(fdt, name, "compatible", "syscon");
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, addr,
+                                 2, size);
+
+    syscon_phandle = next_phandle ? (*next_phandle)++ : qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", syscon_phandle);
+
+    g_free(name);
+
+    name = g_strdup_printf("/reboot");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", reboot);
+    g_free(name);
+
+    name = g_strdup_printf("/poweroff");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
+    g_free(name);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e48337dfd9..ab6c53c78a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -768,47 +768,6 @@ static void create_fdt_pcie(RISCVVirtState *s,
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
-static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
-{
-    char *name;
-    uint32_t test_phandle;
-    MachineState *ms = MACHINE(s);
-
-    test_phandle = (*phandle)++;
-    name = g_strdup_printf("/soc/test@%"HWADDR_PRIx,
-                           s->memmap[VIRT_TEST].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    {
-        static const char * const compat[3] = {
-            "sifive,test1", "sifive,test0", "syscon"
-        };
-        qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
-                                      (char **)&compat, ARRAY_SIZE(compat));
-    }
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[VIRT_TEST].base,
-                                 2, s->memmap[VIRT_TEST].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
-    test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
-    g_free(name);
-
-    name = g_strdup_printf("/reboot");
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
-    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
-    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_RESET);
-    g_free(name);
-
-    name = g_strdup_printf("/poweroff");
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
-    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
-    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_PASS);
-    g_free(name);
-}
-
 static void create_fdt_uart(RISCVVirtState *s,
                             uint32_t irq_mmio_phandle, int memId, int irqNo)
 {
@@ -994,7 +953,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
-    create_fdt_reset(s, &phandle);
+    riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
+                            s->memmap[VIRT_TEST].base,
+                            s->memmap[VIRT_TEST].size,
+                            FINISHER_RESET, FINISHER_PASS, true);
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index b422da6aef..e377682b32 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -39,4 +39,8 @@ void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                            bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
+void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
+                             hwaddr addr, hwaddr size,
+                             uint32_t reboot, uint32_t poweroff,
+                             bool sifive_test_compat);
 #endif
-- 
2.43.0


