Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03F4C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycm-0003cT-BN; Tue, 25 Aug 2026 17:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycl-0003Zm-GU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycj-0002I7-5x
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:03 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9rX43099227
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Vm5RAtIsvyg
 P46EuGukx0Ed9N2TIajYAWhtbSzKTpiw=; b=F7i8SmnyiuT6ReoLQ3TPPdVmIty
 OesZZA6sOp1fy9RbHa8rpwJ55Qfoiye42XJlVXyN9Z7JabIvEOlpY7yo5AM3Izm6
 zTnmtx83RCaP7yfl34p1XQN1goO06zNrSuSzWBmyexii+xAogLnPZEm+cHfUApvA
 pZtmGRINwYltzh1f+mzNGToQcIocM/46m+1kmgQU2qgNSMZz96SdLFSukmNjF3Od
 MiD9/oO+lHS1WuY3FfvRn9S5Gj0FwofvFSuSLYFBl66NMXqfia4U1a9pOX5nP/pk
 xJgCfly6wRx+wbEZ9dMmfk6t6k7WhElGfzjcMW4VXKQeQgyGAJQaMw8PMWA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bkua1wb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90cc2b97f8fso5344366d6.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693039; x=1788297839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vm5RAtIsvygP46EuGukx0Ed9N2TIajYAWhtbSzKTpiw=;
 b=cWK8w/7iv8Vc3AswAQwANl+C40aUqU3cB6LEa1/JlBHk/TlP1G/J8WPkc+F1s15O5A
 w582Rebe9j8w0HylzpwK1QhSirMTYWLOWOGanneZlocQLutygLxCae1uXkvFqhM4X6+M
 0T6G1dP/ZDEfd6a0Bf16gPmgQ/YP46eJZEq1U3/Qv24kfLxKCyRflqmcAEa6VDaBextH
 p4Sz4aDOXUyg5gISrNYOP0jjaExOrE2E20yGGU0Jl+kmLdBm4yY9iR7rBP3xSyA3Vh7H
 rYGDB80+pYbZ16QDYyDoD3wrO8hyoGKKExlKROCG29O9OvlVyLaomwf8iFt9grwt/O9s
 AJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693039; x=1788297839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vm5RAtIsvygP46EuGukx0Ed9N2TIajYAWhtbSzKTpiw=;
 b=DpBGAMUMhc7zgxgtYdkKIY3PhSRbxWQl5oAv/newt092pbz/o09YrrrYn9Z5cD04a6
 A4/cydsjBd3OcMHGHqphBIOnUXa3AmBfvTT/c30zWbtXYF6yvd5FcDM2VGjpciPIZthk
 A/zLgNBDle72ieV1aU8ZCk3iNqbypFT67ytRlyFnCveave2iV6uFR6W1dZeKIcXjxTi8
 H4/nwRkRcOpmxYo6qh0L247Cd4kom2VGtWiYiBuqzBu422T630HGoCW0kky3AQtWP+xc
 b3raIZhXqu4DEFU9rm51SR/IQGKD24tQ9nugL0uDMBnRD9Iati6Ik7koKIo8OZxe4XkL
 g+FA==
X-Gm-Message-State: AFuF++kE5CixcB1DPklyIoUqPIAqsLmVfEg+O6Cq3l3uQT4vsD3bcKsp
 gDA4lbjXIAl9vN9uL4r3q0AQC/vvgxMdGlkIycWc5Bfc9cXW57MLtGXimKiIsemgKMzGP76/n/S
 xFjxkpmdMy0f6Yk5d6A8sVp1qn2c1n2vl2kPXSnDtk2dUJ0xxeJcXwkkYTFWOgO0VGw==
X-Gm-Gg: AR+sD10NgjiI123QjF4Qf+9L/jWujq3MwvPpYXxeoPw8T75ruaJwqZz/8jt3RhvjOv5
 mb47RHgKmFJsbh1UC3U/ZpbBcfdQzAdGtmZI7wzUCEvRi05Y86c8xaECbtGO5OOlzimDHZHB2YS
 na9338Qqm61WI8fPJ4rQhyZvrISHSn7lL1PQm34oazyp3pJ0kEBwqT57RSiLMRQJmjIalvfcQoN
 71/mRupPsk6yCmQTwyx922ilud0WeSTdDpRH57/cFy2vQPntxQ83y5E/CLkGOmzGf4tQvmWRIfz
 P6cAt98dQZSHcu6UKSTCdcspIPYQPHa9lWNda0hTh8YmTTbtdF+lM3L2ftQwCBsa9NzbUTRr93w
 T52/vbCSpVutO9IJvUcQf9Z/AOiJNaogEdVl6Cw==
X-Received: by 2002:a05:6214:dcb:b0:90a:927f:8a9b with SMTP id
 6a1803df08f44-90cc790a7e0mr19113796d6.7.1787693038667; 
 Tue, 25 Aug 2026 14:23:58 -0700 (PDT)
X-Received: by 2002:a05:6214:dcb:b0:90a:927f:8a9b with SMTP id
 6a1803df08f44-90cc790a7e0mr19113176d6.7.1787693038128; 
 Tue, 25 Aug 2026 14:23:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:23:57 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 06/13] hw/riscv/fdt_common,
 virt.c: add create_fdt_socket_aplic()
Date: Tue, 25 Aug 2026 18:23:18 -0300
Message-ID: <20260825212326.1907-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YBY9gX5bCVIUoIoiN84N4S_NOouhVDi9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX8gn7sdR3hJe/
 2Dr0X91Nbv6TP1Qqv/JP7KUU1pQ8fqi524hRxt7YP0YFZIy3E1XELr24kLJ1ZV3p/sLguvlIyPh
 ocdp30EoXbAa+9pBjb+U+9RWeipR4mQ=
X-Authority-Analysis: v=2.4 cv=TZGmcxQh c=1 sm=1 tr=0 ts=6a8e07ef cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=IageEFNgCMQ87KM8QjoA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: YBY9gX5bCVIUoIoiN84N4S_NOouhVDi9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX6Jemg5XcH8z7
 CoxTc9ZH37lF/pcyvlkYSVXv1m9VxWrGn1PPxeJiqaFYdJ02Uy6gXrkjGGBghgT0yMEljt2tL3Y
 JxXUYD36Uw2XqSeKs+7Y5wklZmce4OFv8ATyg+BbdyRp0TuvYC8fMjfQtqgDY0i7TgM+BZEqkIJ
 uyVCN6MpppUcYu+5mv5cVFzovkelumBI1Yo2CLWSsaMFI3y8hnuxUZTFIXnE/xI8SV2fNm3iuCg
 TOa5d5OlIsIv5Ox5cZGZjdlBxVg3XZ5VPoAvcBbvL53pY6ePNkmz4zhMhuY3IWXDHD6jsSVZ9Id
 i/78g5mK/yUQg6pYYiXvMO/eWtDdKo4kGl1ZXRnPNxhiMDLapQ7dAVAEYTyvpku5ynqFnHL/dlO
 QX/sO6bwWY6Ok1bg1FtX1ER4tcna0qlnObfcRGkuF7A+elyUtvjmgNX2wgFFKTSPlwTGOB17evm
 fKkh2LeF6xS/TsvQy6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250182
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Similar to what we did with 'imsic' in the previous patch, including
creating a helper struct to encapsulate the extra arguments required to
create the FDT.

TODO: I believe the tt-atlantis board can use this same helper too.  We
just need to verify how to map the phandles used by it and what the
helper is using (which was inherited by the 'virt' board).

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 106 +++++++++++++++++++++++++++
 hw/riscv/virt.c               | 132 +++++-----------------------------
 include/hw/riscv/fdt-common.h |  18 +++++
 3 files changed, 143 insertions(+), 113 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 6fa2543a2a..77168f5c4f 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -11,6 +11,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
+#include "hw/core/sysbus-fdt.h"
 #include "hw/riscv/fdt-common.h"
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
@@ -589,3 +590,108 @@ void create_fdt_imsic(void *fdt, IMSICFdtProps *props,
                          imsic_num_bits(props->aia_guests + 1));
 
 }
+
+/* Caller must free string after use */
+static char *fdt_get_aplic_nodename(hwaddr aplic_addr)
+{
+    return g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
+                           aplic_addr);
+}
+
+static void create_fdt_one_aplic(void *fdt, APLICFdtProps *props,
+                                 hwaddr aplic_addr, uint32_t aplic_size,
+                                 uint32_t msi_phandle,
+                                 uint32_t *intc_phandles,
+                                 uint32_t aplic_phandle,
+                                 uint32_t aplic_child_phandle,
+                                 bool m_mode)
+{
+    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, props->num_harts * 2);
+    static const char * const aplic_compat[2] = {
+        "qemu,aplic", "riscv,aplic"
+    };
+    int cpu;
+
+    for (cpu = 0; cpu < props->num_harts; cpu++) {
+        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
+    }
+
+    qemu_fdt_add_subnode(fdt, aplic_name);
+    qemu_fdt_setprop_string_array(fdt, aplic_name, "compatible",
+                                  (char **)&aplic_compat,
+                                  ARRAY_SIZE(aplic_compat));
+    qemu_fdt_setprop_cell(fdt, aplic_name, "#address-cells",
+                          FDT_APLIC_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, aplic_name,
+                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
+    qemu_fdt_setprop(fdt, aplic_name, "interrupt-controller", NULL, 0);
+
+    if (props->aia_type == AIA_TYPE_APLIC) {
+        qemu_fdt_setprop(fdt, aplic_name, "interrupts-extended",
+                         aplic_cells, props->num_harts * sizeof(uint32_t) * 2);
+    } else {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "msi-parent", msi_phandle);
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, aplic_name, "reg",
+                                 2, aplic_addr, 2, aplic_size);
+    qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,num-sources",
+                          props->irqchip_num_sources);
+
+    if (aplic_child_phandle) {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "riscv,children",
+                              aplic_child_phandle);
+        qemu_fdt_setprop_cells(fdt, aplic_name, "riscv,delegation",
+                               aplic_child_phandle, 0x1,
+                               props->irqchip_num_sources);
+    }
+
+    if (props->numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, aplic_name, "numa-node-id", props->socket);
+    }
+
+    qemu_fdt_setprop_cell(fdt, aplic_name, "phandle", aplic_phandle);
+}
+
+void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                             uint32_t msi_m_phandle,
+                             uint32_t msi_s_phandle,
+                             uint32_t *phandle,
+                             uint32_t *intc_phandles,
+                             uint32_t *aplic_phandles)
+{
+    uint32_t aplic_m_phandle, aplic_s_phandle;
+    hwaddr aplic_addr;
+
+    aplic_m_phandle = (*phandle)++;
+    aplic_s_phandle = (*phandle)++;
+
+    if (props->aplic_m) {
+        /* M-level APLIC node */
+        aplic_addr = props->aplic_m->base
+                     + (props->aplic_m->size * props->socket);
+        create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_m->size,
+                             msi_m_phandle, intc_phandles,
+                             aplic_m_phandle, aplic_s_phandle,
+                             true);
+    }
+
+    /* S-level APLIC node */
+    aplic_addr = props->aplic_s->base + (props->aplic_s->size * props->socket);
+    create_fdt_one_aplic(fdt, props, aplic_addr, props->aplic_s->size,
+                         msi_s_phandle, intc_phandles,
+                         aplic_s_phandle, 0,
+                         false);
+
+    if (!props->socket && props->platform_bus_irq) {
+        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
+        platform_bus_add_all_fdt_nodes(fdt, aplic_name,
+                                       props->platform_bus->base,
+                                       props->platform_bus->size,
+                                       props->platform_bus_irq);
+    }
+
+    aplic_phandles[props->socket] = aplic_s_phandle;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0ab91728d9..dd8f5d9d75 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -320,113 +320,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     }
 }
 
-/* Caller must free string after use */
-static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
-{
-    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
-}
-
-static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
-                                 unsigned long aplic_addr, uint32_t aplic_size,
-                                 uint32_t msi_phandle,
-                                 uint32_t *intc_phandles,
-                                 uint32_t aplic_phandle,
-                                 uint32_t aplic_child_phandle,
-                                 bool m_mode, int num_harts)
-{
-    int cpu;
-    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
-    MachineState *ms = MACHINE(s);
-    static const char * const aplic_compat[2] = {
-        "qemu,aplic", "riscv,aplic"
-    };
-
-    for (cpu = 0; cpu < num_harts; cpu++) {
-        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
-    }
-
-    qemu_fdt_add_subnode(ms->fdt, aplic_name);
-    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
-                                  (char **)&aplic_compat,
-                                  ARRAY_SIZE(aplic_compat));
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
-                          FDT_APLIC_ADDR_CELLS);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
-                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
-    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
-
-    if (s->aia_type == VIRT_AIA_TYPE_APLIC) {
-        qemu_fdt_setprop(ms->fdt, aplic_name, "interrupts-extended",
-                         aplic_cells, num_harts * sizeof(uint32_t) * 2);
-    } else {
-        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
-    }
-
-    qemu_fdt_setprop_sized_cells(ms->fdt, aplic_name, "reg",
-                                 2, aplic_addr, 2, aplic_size);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
-                          VIRT_IRQCHIP_NUM_SOURCES);
-
-    if (aplic_child_phandle) {
-        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
-                              aplic_child_phandle);
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
-                               aplic_child_phandle, 0x1,
-                               VIRT_IRQCHIP_NUM_SOURCES);
-    }
-
-    riscv_socket_fdt_write_id(ms, aplic_name, socket);
-    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle);
-}
-
-static void create_fdt_socket_aplic(RISCVVirtState *s,
-                                    int socket,
-                                    uint32_t msi_m_phandle,
-                                    uint32_t msi_s_phandle,
-                                    uint32_t *phandle,
-                                    uint32_t *intc_phandles,
-                                    uint32_t *aplic_phandles,
-                                    int num_harts)
-{
-    unsigned long aplic_addr;
-    MachineState *ms = MACHINE(s);
-    uint32_t aplic_m_phandle, aplic_s_phandle;
-
-    aplic_m_phandle = (*phandle)++;
-    aplic_s_phandle = (*phandle)++;
-
-    if (!kvm_enabled()) {
-        /* M-level APLIC node */
-        aplic_addr = s->memmap[VIRT_APLIC_M].base +
-                     (s->memmap[VIRT_APLIC_M].size * socket);
-        create_fdt_one_aplic(s, socket, aplic_addr,
-                             s->memmap[VIRT_APLIC_M].size,
-                             msi_m_phandle, intc_phandles,
-                             aplic_m_phandle, aplic_s_phandle,
-                             true, num_harts);
-    }
-
-    /* S-level APLIC node */
-    aplic_addr = s->memmap[VIRT_APLIC_S].base +
-                 (s->memmap[VIRT_APLIC_S].size * socket);
-    create_fdt_one_aplic(s, socket, aplic_addr, s->memmap[VIRT_APLIC_S].size,
-                         msi_s_phandle, intc_phandles,
-                         aplic_s_phandle, 0,
-                         false, num_harts);
-
-    if (!socket) {
-        g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
-        platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
-                                       s->memmap[VIRT_PLATFORM_BUS].base,
-                                       s->memmap[VIRT_PLATFORM_BUS].size,
-                                       VIRT_PLATFORM_BUS_IRQ);
-    }
-
-    aplic_phandles[socket] = aplic_s_phandle;
-}
-
 static void create_fdt_pmu(RISCVVirtState *s)
 {
     g_autofree char *pmu_name = g_strdup_printf("/pmu");
@@ -453,6 +346,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     int socket_count = riscv_socket_count(ms);
     bool numa_enabled = riscv_numa_enabled(ms);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
+    APLICFdtProps aplic_props;
 
     fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
@@ -508,15 +402,26 @@ static void create_fdt_sockets(RISCVVirtState *s,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
+    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
+        aplic_props.aplic_m = !kvm_enabled() ? &s->memmap[VIRT_APLIC_M] : NULL;
+        aplic_props.aplic_s = &s->memmap[VIRT_APLIC_S];
+        aplic_props.platform_bus = &s->memmap[VIRT_PLATFORM_BUS];
+        aplic_props.platform_bus_irq = VIRT_PLATFORM_BUS_IRQ;
+        aplic_props.socket = 0;
+        aplic_props.num_harts = ms->smp.cpus;
+        aplic_props.numa_enabled = numa_enabled;
+        aplic_props.irqchip_num_sources = VIRT_IRQCHIP_NUM_SOURCES;
+        aplic_props.aia_type = s->aia_type;
+    }
+
     /*
      * With KVM AIA aplic-imsic, using an irqchip without split
      * mode, we'll use only one APLIC instance.
      */
     if (!virt_use_emulated_aplic(s->aia_type)) {
-        create_fdt_socket_aplic(s, 0,
+        create_fdt_socket_aplic(ms->fdt, &aplic_props,
                                 msi_m_phandle, msi_s_phandle, phandle,
-                                &intc_phandles[0], xplic_phandles,
-                                ms->smp.cpus);
+                                &intc_phandles[0], xplic_phandles);
 
         *irq_mmio_phandle = xplic_phandles[0];
         *irq_virtio_phandle = xplic_phandles[0];
@@ -531,11 +436,12 @@ static void create_fdt_sockets(RISCVVirtState *s,
                                        &intc_phandles[phandle_pos],
                                        xplic_phandles);
             } else {
-                create_fdt_socket_aplic(s, socket,
+                aplic_props.socket = socket;
+                aplic_props.num_harts = s->soc[socket].num_harts;
+                create_fdt_socket_aplic(ms->fdt, &aplic_props,
                                         msi_m_phandle, msi_s_phandle, phandle,
                                         &intc_phandles[phandle_pos],
-                                        xplic_phandles,
-                                        s->soc[socket].num_harts);
+                                        xplic_phandles);
             }
         }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index ab77bbda12..7a7e3ad7af 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -12,6 +12,7 @@
 #include "target/riscv/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "exec/hwaddr.h"
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
@@ -50,6 +51,17 @@ typedef struct IMSICFdtProps {
     int aia_guests;
 } IMSICFdtProps;
 
+typedef struct APLICFdtProps {
+    const MemMapEntry *aplic_m;
+    const MemMapEntry *aplic_s;
+    const MemMapEntry *platform_bus;
+    int platform_bus_irq;
+    int socket;
+    int num_harts;
+    bool numa_enabled;
+    int irqchip_num_sources;
+    int aia_type;
+} APLICFdtProps;
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
@@ -94,4 +106,10 @@ void create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
 void create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
                       uint32_t *phandle, uint32_t *intc_phandles,
                       uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
+void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                             uint32_t msi_m_phandle,
+                             uint32_t msi_s_phandle,
+                             uint32_t *phandle,
+                             uint32_t *intc_phandles,
+                             uint32_t *aplic_phandles);
 #endif
-- 
2.43.0


