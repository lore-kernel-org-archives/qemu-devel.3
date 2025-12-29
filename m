Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46BBE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIy-0004sa-Op; Mon, 29 Dec 2025 13:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHG-0003fu-0i
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHE-0008EK-Ao
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:33 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTAQIET2990007
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Usd8KjL1nKa
 Unlu6+YZAiUOALwzrj0rfFjwHgLC0dHs=; b=nmJNaE4+EYB4v2yMNv6+Op2MPBI
 C+ypI9PXNzKeEdZADJteoQyFSbVKMK7p0R4MrpnR2PE8CdkScVRRNF4GZ9AD3w1u
 nzaLvgkqSgQRpjAzR6HUKgk0lEaVmZDqJ46VkHCP9BC/etAmNeDpFqc/q0LCHMz8
 hLz4BsIqMUD0tt3hH0chDxP/KqYe/ZdoBVm7ldDeipZkbSOKedvZRlH+x3MKvlgd
 xaLk59I8s+oYcSAaDC3VdK8O47EZ8/BYcbH8aGBl65p+t6nPN9qLTGCrDuCSz2lF
 N742g/+sjZPMpdBFJ3SwFoPYtAUuUPg5FBxqO4N0o8o1UD8Cce2vOcB/6Xg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8r6d38d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a08cbeb87eso155586905ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034050; x=1767638850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Usd8KjL1nKaUnlu6+YZAiUOALwzrj0rfFjwHgLC0dHs=;
 b=LzbnDTwsN6EgQDS4twlvzlqB8QXWmavJiQY8kIOzYYSetBOLMP9CMnIN5KIqJ6L01I
 PEnrJPwToPTDd03RLXzDPo0LmPjihcO523E/w0q2l+msQR6qIm5hzBIOyEN7Vn3nY+AZ
 kx4eTUMXtP6EvldWapoDip3Ogv6tKZS8mh6TnkPPF2Z2Rzwsh2CUAf8ER1dP/bV72m6A
 Q9O3JmP/uhHr+qaeF2AugwTP2A81wbqqhaTe5XKJjLpW85l5+JxcxzaYkMWIWEh7I+f7
 VYxxwa+xtfourH2qWFQ2I74dQ1Qc3WlH6a9SRkuZ45At4gGcNgrwOkvKz9CwYKFXtliR
 j5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034050; x=1767638850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Usd8KjL1nKaUnlu6+YZAiUOALwzrj0rfFjwHgLC0dHs=;
 b=Ho9Jyz25ucZsxbZeu84JjE+J66MCS5rQ+hqwWi0wAxD8+qENU1y8I/N33rTPSjEQBw
 4zxoDogiqdxnBnnu54iyOmhYt1QSxqINkPZlwLMxE+CVUooAFXoFMMpfKdnncJ7M7fUA
 GeXHE8DpK0uekNYGbehwVlKmFJw0w3GnV6X7pQbsWC9PeRPc8Aj3Fi5HNq7Lt32k2GWB
 3ubZ/eXtDp90RpQTcoTwbCfNQNVE57UMUvKDnfMi7yQ+d8X7X5A9uvpJAaujuyMRRp5o
 tYRFE2LHUQl6UCdCO2uuRg+qsfQeb4w1cbdhtyoWCOQiFPsD6fT91/crs1fPkd9gryZz
 0BlA==
X-Gm-Message-State: AOJu0YxASsk3SviLJWEl7VDKGDfUZewqpBS3cphLVFfsW54LFNt66PA5
 G9ZUuePBOkKsojIPKldWWx+Q5vuRW3d+xlDtwwRHq+/YIqGDABOlK7WPmytnnqsVqXtee63GM6j
 0t5eyYkOuPV1OoScfldwYTQJM9xEPgR69GhrEabmke/QX/o5KTiPNpvXOuErjEdGRsw==
X-Gm-Gg: AY/fxX4paH4+1XwyTPX7+UNBlD6FOL10C9wE4/gAVMfShXYIloq69O79/wPeOJAzkOq
 929Iy3+sPQWkPJo6P3Gr4SL4oYD02dgMvVgf8adWTFhM5LhzhzH09kZIJXizc4j/l5oDU39GfNK
 fUynSCm2Qt+5vziG2CfrTPdU10ytFKJo4mpEkv7p2f2mEMiBpiNgdHJohOT/iFFb7m+ck5NcAsb
 PJ6L68tMw2jURAffMlvX31yj6h4jXKMDnGksyvxCPqUqI4sX1+5FMjpDMUlrGLyxodCU9V5wWam
 IcE6gdHQclNWlOtyNfbQdazBAod44XQ/8RqSRUNKYKMvqRCAENskHmLNVzfg25b7uuFSIuHfyxo
 Rvi7+J1niK3UESPlK2RYoVZXiGDBGfVln2kxtLLnzX7JFvZA=
X-Received: by 2002:a17:903:228b:b0:2a0:f0e2:94b7 with SMTP id
 d9443c01a7336-2a2f2735298mr284160505ad.30.1767034049885; 
 Mon, 29 Dec 2025 10:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmmmLWZQ4QsqVeZMMTsA9Rpdzc3glu04ipr2sb5OYIFJp6gjk3TXl1CnQkvPnULteHNmQR7Q==
X-Received: by 2002:a17:903:228b:b0:2a0:f0e2:94b7 with SMTP id
 d9443c01a7336-2a2f2735298mr284160365ad.30.1767034049369; 
 Mon, 29 Dec 2025 10:47:29 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:28 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 05/17] hw/riscv/virt.c add trace encoder and ramsink fdt
 nodes
Date: Mon, 29 Dec 2025 15:46:44 -0300
Message-ID: <20251229184656.2224369-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Raidyltv c=1 sm=1 tr=0 ts=6952ccc2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WNqyVGXcZDAH5E2kEWIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: fR4R4EvhzrmtYOi_TweNCC-WPP9wVKnI
X-Proofpoint-GUID: fR4R4EvhzrmtYOi_TweNCC-WPP9wVKnI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfXw4JV2dLRyhek
 itjPo1uLR/DrMGyWXUVEQtvrlUfKlru5V2iBnmyGrA2EXtKun7jcavYRQP3JIHhFT5NvGmsuIef
 fOpZcUFSez+/8LizVNNSahwBBmH9eVn0w3+HkcR9J/aipdhQ8//8sIzSJOGZ7zXDzw18OrPDnXk
 /MNsX8MhftXErNUE4lFLLwwpL6dPIWsjakXVMonuRMaoPDtZOVIZBXcMDllxSxWFDYSidarUOxg
 6bVE0x89olU2DFZ89PZAEeOLi9kOb8gLx7zWTYGfD9iqmSqiwCH3KxeL45ZW3TDhVh8rL3d7THs
 WSvB4kO+LtrMf/CYi/ytM2q8vf51LrgUwLf6ojzmc6/w5gM7EGhtP/84KURZUbOobQOW/22HEkl
 fYsICdrjKibgNMvE62CL8ZHif0d8UETfrldv7skWSpdAW02Vt1A+GZHyqFeimnOmFe+eHqwxCQU
 OmOCEX6A7n6Yk8hGySg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>

The trace encoder and trace ramsink nodes should confirm to the bindings
described in "riscv,trace-component.yaml" in the Linux kernel. That way,
encoder and ramsink devices get populated on the rvtrace bus and perf
record is able to capture the trace data in the auxtrace section as
expected.

Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/virt.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b1a4d63efd..30e89a6c5a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1142,6 +1142,62 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+static void create_fdt_rvtrace(RISCVVirtState *s)
+{
+    static const char * const tr_compat[2] = { "qemu,trace-component",
+                                               "riscv,trace-component" };
+    g_autofree char *cpu_name = NULL, *ram_sink_name = NULL,
+                    *trencoder_name = NULL, *ep = NULL;
+    MachineState *ms = MACHINE(s);
+    int socket_count = riscv_socket_count(ms), i;
+    uint64_t addr, size = 0x100;
+    uint32_t rs_phandle;
+    RISCVCPU *cpu_ptr;
+
+
+    for (i = 0; i < socket_count; i++) {
+        for (int cpu = 0; cpu < s->soc[i].num_harts; cpu++) {
+            cpu_ptr = &s->soc[i].harts[cpu];
+            if (!cpu_ptr->trencoder) {
+                continue;
+            }
+            cpu_name = g_strdup_printf("/cpus/cpu@%d",
+                                       s->soc[i].hartid_base + cpu);
+            ram_sink_name = g_strdup_printf("/soc/ramsink@%d",
+                                            s->soc[i].hartid_base + cpu);
+            qemu_fdt_add_subnode(ms->fdt, ram_sink_name);
+            addr = object_property_get_uint(cpu_ptr->trencoder, "dest-baseaddr",
+                                            &error_abort);
+            qemu_fdt_setprop_sized_cells(ms->fdt, ram_sink_name, "reg", 2, addr,
+                                         2, size);
+            qemu_fdt_setprop_string_array(ms->fdt, ram_sink_name, "compatible",
+                                          (char **)&tr_compat,
+                                          ARRAY_SIZE(tr_compat));
+            qemu_fdt_setprop_phandle(ms->fdt, ram_sink_name, "cpu", cpu_name);
+            ep = g_strdup_printf("%s/in-ports/port/endpoint", ram_sink_name);
+            qemu_fdt_add_path(ms->fdt, ep);
+            rs_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+            qemu_fdt_setprop_cell(ms->fdt, ep, "phandle", rs_phandle);
+
+
+            trencoder_name = g_strdup_printf("/soc/encoder@%d",
+                                             s->soc[i].hartid_base + cpu);
+            qemu_fdt_add_subnode(ms->fdt, trencoder_name);
+            addr = object_property_get_uint(cpu_ptr->trencoder, "baseaddr",
+                                            &error_abort);
+            qemu_fdt_setprop_sized_cells(ms->fdt, trencoder_name, "reg", 2,
+                                         addr, 2, size);
+            qemu_fdt_setprop_string_array(ms->fdt, trencoder_name, "compatible",
+                                          (char **)&tr_compat,
+                                          ARRAY_SIZE(tr_compat));
+            qemu_fdt_setprop_phandle(ms->fdt, trencoder_name, "cpus", cpu_name);
+            ep = g_strdup_printf("%s/out-ports/port/endpoint", trencoder_name);
+            qemu_fdt_add_path(ms->fdt, ep);
+            qemu_fdt_setprop_cell(ms->fdt, ep, "remote-endpoint", rs_phandle);
+        }
+    }
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -1166,6 +1222,8 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_uart(s, irq_mmio_phandle);
 
     create_fdt_rtc(s, irq_mmio_phandle);
+
+    create_fdt_rvtrace(s);
 }
 
 static void create_fdt(RISCVVirtState *s)
-- 
2.51.1


