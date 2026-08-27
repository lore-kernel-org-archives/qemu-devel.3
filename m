Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D3C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziYR-0005Hh-Rm; Thu, 27 Aug 2026 18:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYP-0005G8-CU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wziYK-0001Bj-R8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:26:37 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM7au795471
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mglMR9sepCnq/72agFm/d/CeSPJGeqMbwg073MKOW7c=; b=PEqsjnHSzA2MJ5c9
 9ZR9Wbv/aYZEN8WSASmRtCcX2jxL74QY58XA1+1M8JOzPB/ASTDiDDGM4K4L9XQw
 bRsUqlyXzgpNITzzw21Dhk8j/9zPpcBdEaPFhrJp9+gcLnphERlpxMj7cjrlx1YB
 UpRAGwd+ZsIt/OjLQ1QTczl/vqsgFL8GWjod4ju2AYvVHWxKj8n+Ye/Mo+oOeYMQ
 brjlB0tQ7wt+dPDpWrYEct0xboL2rFZ1y3Bm7Wvk5PZiF8eG9yS7PR+yH99IYSAP
 MLfZYTSu29Jd1aVdQFFJU5t3WJ5S2yjLrEtpbJBqY+MoMF51CNTXOWrZMcETtO5c
 L3hSeA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjp4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:26:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so45012285a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869589; x=1788474389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mglMR9sepCnq/72agFm/d/CeSPJGeqMbwg073MKOW7c=;
 b=GuhIY9Wt5vmo7ddaDDwzml0odu2yIoLuu5dKodgquQ89mZqYlRNGMhJhMi09OIpkug
 blEncyhcWoICmSpB3NbLznhpd6dnVQqy5KQ10MM8VsGmrpmyVHoX8uvm6WJnYxCZwyVY
 L3IiCuf7OweDI5om1xgtKs3Nu6UsR8Cjq6z0KUXP4/BIttfK0ODedJ+iJ7qn2K22DIdV
 qojlrA1oz6kKrVrdhQFi9y1eDnYe1cGg2IP4D+JMytHcR9f5Fmhiw0WZL/iREb+OMZyc
 YANffBOL0bQMkfDFtr/7/Eviwy+fHSR4hB6gScL0Cy2tItvM4KwxYQAPxe3DyWld0Q5v
 uuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869589; x=1788474389;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mglMR9sepCnq/72agFm/d/CeSPJGeqMbwg073MKOW7c=;
 b=obDi3MWNbLCl9nA5jHgPO6HWrulVqEacLY61zmFWB0Qbf+zyx5HxXYhh1dDpwier87
 7HvoHv8WNrAeaCmqY5Sw6Np9YQrrxLZvOYsxQcuxNLMpevI+YJmRmdDWLpJYPVJ8TTtz
 ygy9L/zngfwOsparjpVrGpUmZ9tVts/SwRdTbcecaSfJnnxMRdwySNNqvOcx6G43nrmC
 rv0Ye6VGdBBPuuTLls5H3j/sFoOiI5AJWJ4kzQvlvGI5dMFkJVaeW1pX9efnICOma6o0
 vTMADwI4eMdOgeSkqc1FQc5LN3XRygjS52f7KbCA6E8ZXMg0B3RcbuxY3FeXIFSzg67q
 t1LA==
X-Gm-Message-State: AFuF++kl9buGna0dQNSYREVJqSkUouv5UgN7n/OnoJvETN+WRXMlFbvD
 6g07CcfPSdxNXFMVjNK43d1QulKYoJyNBIBxS3QNz1b75Q5Odhm4Z65amZhfiLLLicf1g/HzEQs
 J/EK3jh+hDDy3004MF25pB3CJBDeg/rzH9clNZlgMShkk/IhYUZ0jTQHHj42b+ivBVg==
X-Gm-Gg: AR+sD13Pk6vMWVu2HZVj3ibQvXv80bdDBGWFTCp5WUJRCIkOc8kpkI3Lix6lz6hob1m
 tRq8/BYQ5XUFIjVp1jJ2HvyHHFxvRRTzBvtIKotHvgIc7PEztZKoWbSJUlP4gg+mNJxMOFGaYrp
 kssklKD0BmHAH8m+j1zHm4L5UxzWAYv/VOPXLExJaJS/VTstG6ZNwy19ub5sNRzTNrtMHKNM533
 nn9yNjp2C6OkOYWJvrQlFIvWDGfYsiJP4KpIVSUNf3WHBrKJz3BeBT9cnFvo1VjDLX3Qyc3xbSg
 COcqJ530L0Z6PqLtsSWC44o637XSAL0yjDECfEGiMkiiEux/6dnM7puOndlUlqr8024RrkLpSFR
 f+EZn97uw3NgP7GMaVLvZhmZZbndziPWxIMEoYw==
X-Received: by 2002:a05:620a:2101:b0:916:14f5:8866 with SMTP id
 af79cd13be357-939137df729mr192611785a.16.1787869589276; 
 Thu, 27 Aug 2026 15:26:29 -0700 (PDT)
X-Received: by 2002:a05:620a:2101:b0:916:14f5:8866 with SMTP id
 af79cd13be357-939137df729mr192608785a.16.1787869588777; 
 Thu, 27 Aug 2026 15:26:28 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173a734dsm8924985a.26.2026.08.27.15.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:26:28 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 03/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_syscon()
Date: Thu, 27 Aug 2026 19:25:56 -0300
Message-ID: <20260827222608.329788-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX2r/NkuOtS5QH
 R/bOGVrvkjgWPequQqlItHADcbwjls3J9XfGhvXErKH4S7G3mQFdSIOltI8Yyu46zySkmrc1QkV
 mrNeuhwnzIA4/jsiawTTbeTc0bhrt2E=
X-Proofpoint-GUID: QyFuapIiJIVyicNEo5IgNoddfFKKV72i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX2e6wA28dDNkC
 6kRsEeSJRjqdx7VKLayE1tlnBu4aa+PY58JNWGyW5RJDCz0kYiLQfVHghuwD8sR5MylfEscLhRw
 8ymGgFgR91F63Cqgv7mooiDi7QvQa0tUVo3OSrXMxsiZrJmPJ6MX4VG2RFulMvUro01fxel74VS
 nXGjFuLfpu4BPvkPne7dphQIybbuGt9RozjUgQmHVtseLlPnfxLL1X3bGbmcTkNayjzjX9jRXEX
 azynzNuLpdLGiqJxJMDNIU6Q2yw+hPxomVIYFwH3soSoyWLJQEs1vPnUokqCKpMquNsoiI3yvNr
 c6Vnzz+FrDM8LE69oreBPY1J8pAa/cTBFitCMALfii544CSOdKA4tTduSNTJBh5VQSM1t5n9Ueg
 1xXJ013Khg0U9LZ4oH0rU0hHHWWnd5Cei+0ySZKbbxMwV8W0DVepEbqk+0XPEqWHKS8GihxQtVk
 3gAarxhYa2MNT3FY3Ug==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b996 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=AqYGxfEHplewfouIbmYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: QyFuapIiJIVyicNEo5IgNoddfFKKV72i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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


