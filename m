Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A5EC61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycj-0003Xy-QS; Tue, 25 Aug 2026 17:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyyci-0003WW-7f
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:24:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycg-0002Hb-5Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLALfa1925638
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9HLPfSMUYJC
 KZ2A/C3+MYzp9wV3VCXZuI833t5CdRfM=; b=mBCBRcGLUDE1jSH3/Oxr7ecOSWV
 J/PrDdQFxt6/Ep0359iHLRr+oARYtcSPQqaH/bpH8SG1vj62SdmiDBdPUJdQduLk
 MK32f5ScA1YdZgKmsXgSF6CJP0viDT1r7yIFFUoScAGxLlZrHcQHY657iBFZgOyC
 EJG8dqVVSN019ZYKDFoNNsC6fSPCsYIW2CvisvQ+ELvpZo7YnVdl2itH9g+aWyHR
 I1KQ0LtVlB/wCtNrUVkKip9ZsYOrOuSqRzD4FdXg32ZR1KIKA0JQWWLMQXTdnQnC
 MIkhBJUChnxLJYgD9/HLsaRePbUUXEfVfeL/YYAZtNcFwqnOduHbtKp7Xow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9f9urubu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d33c89a29so3909871cf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693036; x=1788297836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9HLPfSMUYJCKZ2A/C3+MYzp9wV3VCXZuI833t5CdRfM=;
 b=T1DmS/Mr/nuok79j0r7l9yu/ZyD1ddUQJfXXcHsuMZJhcY7/rsWpJzWOHcxjac2kOv
 DytKgXlgb5ANEG+Xy8sMa6oRpTEyVEM0rO8AINR02gL4ecuwC98C0zP7yK6y1HmToDUt
 NTjCaVhtts3zbfF7WkbhoVLz8lCecdsJ51c4/gZweYwL7uBKAKfNaQvVslPeRGNQALgE
 I2W4hoh4hwOBmtJktx1NssZyU9PCM55ATEI+XzD68KbsQn97JrmOQt07GzQvobeG/V1X
 sod2bBoVt2gZy6BZS+1JGRUEGcOBQI0l/ht3lccwK2dHMaXUumlJSsHVtUMUN+lP+BFm
 +W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693036; x=1788297836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9HLPfSMUYJCKZ2A/C3+MYzp9wV3VCXZuI833t5CdRfM=;
 b=aOsWOT5ERl9UspOMStnLmvNz/8aQSxpeR1qS/r9mtvONAfdBp5FmG+oHyvMPRiug0p
 mxa6UK85aNh2J2VEEiLKYjhE7Vf5HMhDFdKHJw9GE9gbPtzKPuaiJSN+UXCu75tI812n
 gtCHlmzFO0z0fFbvYkJMvm9U58st0g/1C9Yw4gsRrisjF58RZMi9+0KUcrCUtBribfPj
 N7MPkXy3sdHOPXjvCPN9DtBlCcYLr/Dd3YgA43VfQGrsnmeSkBiHr8xkI6+12CtO6bJH
 AQr5UMVV7AaVtOtjm0So7LdEorUS8Q9VSfJjplg9uEPfyYPC3P+Hz1j20LrchPNFQ+nY
 va5Q==
X-Gm-Message-State: AFuF++kmEMt4IUQvwGQNrGB8VCBB/FcpEAgATKDMrVwfyn+A2tqMeKuC
 QtdsL7YAcWKMSv/JPWZpGyyk3Y2DU9NQGPixDU7w2In4GuXgkiTpN+dRx+MRZv8iIgJn1V6LObN
 BCa5JiGNajYUrcElU7ysi89ZE62GKA7AC5RTe/39DQW9kKm4SemgRvLlpet/0XHaKlw==
X-Gm-Gg: AR+sD12/XJmiWJa03xHnDfXxGsnLLweH/JwgWYc6oRYg8iOvcyjcKjg+FyrR5Gz8+1e
 IjcbpnTzdbgE4QxA2eu39KZoxyzMDjQieyYr3Rs6AbHi8pNcECEnn/b6w5OEE/Tq7slNgt+u+EC
 hX0ZFcIP7LHlvIdCls1rb23JLo4d/cDz3XhsRdqWCYR3KmX8rWZFwMpmwts8dqRATZQMumxfRqd
 rIXBqVZOBTF7rATrYOen4s/RSDhzzvueKQJFc/kuvQ9P2xYVbkI0olbMFRdSS6IcX5kEQP/OiJk
 lsLQxjUUpnTsN7PZjNpyidZfj6NLhvf4rNPmLT/bb6/VNvya9K1AOE2m3Es2J6bRSPGBjmkd0qg
 VpngZ1+Ucg+YZtc60hjIy7eRLYCAV6ky70LPK3g==
X-Received: by 2002:a05:6214:5681:b0:8f3:cf36:15ca with SMTP id
 6a1803df08f44-90cc7986151mr19868916d6.9.1787693036199; 
 Tue, 25 Aug 2026 14:23:56 -0700 (PDT)
X-Received: by 2002:a05:6214:5681:b0:8f3:cf36:15ca with SMTP id
 6a1803df08f44-90cc7986151mr19868246d6.9.1787693035564; 
 Tue, 25 Aug 2026 14:23:55 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:23:55 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 05/13] hw/riscv/fdt_common, virt.c: add create_fdt_imsic()
Date: Tue, 25 Aug 2026 18:23:17 -0300
Message-ID: <20260825212326.1907-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
References: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M4ICch-s2CVpXKwgapJq9B_xEuricnIM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX/6NULu2QfKlq
 756zwkNafswI029UfkMFXNlleuyxZoAjadL4eLyjEfZQcYau7zDAKT+YnDLQF7AIPRKKLtDJyHs
 mm43FWzKOuBWwMeEFTq1VnhiVbsQoRGpvfCVzHprF4ZLTxZlZhluNnZaXoY6MSsnouKAWEPbPv4
 np4bJxlZAXEBjBRnM8LlMl7ftXHgi23vbSawVrOmoT/lh5Ic5P245v1VIYYokFQPXjNVexACR5C
 MiUzK506RgjLkWmAINWFk8KwSnODufY62Xjfbh0O92OzR6PW6VWwvm2fd5q3e+DJ80gVEPp4cXl
 KeoY+IlK9d8+2ZrLC2eHy8yRPZ10O6HRSM7dTFudhLUXpP4Auosj7lTxKMsR0D5EOkAiRzrx1rq
 aNbpsztiYvjR5NnDxbrZIESufyuIxs+HFOA9L3q58/rUTzWzYKroE6k15hUC1LSH0uhbttuzNro
 nP8o6aZmnDlE80pdPYA==
X-Authority-Analysis: v=2.4 cv=acNRWxot c=1 sm=1 tr=0 ts=6a8e07ed cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=leFpFR9-_kbXek5-2D0A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfXwlCbB3YAej81
 sO5Fn5hwv6BXDHlJhCigMs5PNUGdo5I42zkpalIx0Y3ZV9FrPqv++TkfXKwwstluGBwRCmLxdXd
 /L5oDzx+/rkkPiZ0gL0fbYO0M2m+bes=
X-Proofpoint-ORIG-GUID: M4ICch-s2CVpXKwgapJq9B_xEuricnIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250182
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

The FDT related to interrupt controllers should definitely be put into
helpers, even if only 'virt' benefits from it, due to the amount of code
that is relieved from the board alone.  We'll start with 'imsic'.

For this endeavor we're going to use a helper struct that will carry all
the extra FDT arguments in a human format.  The alternative would be to
add 8 more function arguments, on top of 4 phandle arguments that we're
passing around in all these controllers, and that's not only a poor
reading experience but it's quite error prone too.

We do not want to crowd the fdt-helper with non-FDT logic, hence we're
handling the !kvm_enabled() cond in virt.c using the imsic_m_base
argument.  This is a pattern that we'll fall back on in the next
patches too.

No FDT changes made.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         |  94 ++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 104 ++++------------------------------
 include/hw/riscv/fdt-common.h |  22 +++++++
 3 files changed, 128 insertions(+), 92 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 67a0a3d8f2..6fa2543a2a 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -15,8 +15,10 @@
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/iommu.h"
+#include "hw/intc/riscv_imsic.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
+#include "hw/riscv/aia.h"
 
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size)
@@ -495,3 +497,95 @@ void create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
 
     create_pcie_irq_map(fdt, name, irq_pcie_phandle, aia_type, pcie_irq);
 }
+
+static void create_fdt_one_imsic(void *fdt, IMSICFdtProps *props,
+                                 hwaddr base_addr,
+                                 uint32_t *intc_phandles, uint32_t msi_phandle,
+                                 bool m_mode, uint32_t imsic_guest_bits)
+{
+    RISCVHartArrayState *soc = (RISCVHartArrayState *)props->soc;
+    g_autofree char *imsic_name = NULL;
+    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
+    g_autofree uint32_t *imsic_cells = NULL;
+    g_autofree uint32_t *imsic_regs = NULL;
+    static const char * const imsic_compat[2] = {
+        "qemu,imsics", "riscv,imsics"
+    };
+    int cpu, socket;
+
+    imsic_cells = g_new0(uint32_t, props->smp_cpus * 2);
+    imsic_regs = g_new0(uint32_t, props->socket_count * 4);
+
+    for (cpu = 0; cpu < props->smp_cpus; cpu++) {
+        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        imsic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
+    }
+
+    imsic_max_hart_per_socket = 0;
+    for (socket = 0; socket < props->socket_count; socket++) {
+        imsic_addr = base_addr + socket * props->imsic_group_max_size;
+        imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
+                     soc[socket].num_harts;
+        imsic_regs[socket * 4 + 0] = 0;
+        imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
+        imsic_regs[socket * 4 + 2] = 0;
+        imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);
+        if (imsic_max_hart_per_socket < soc[socket].num_harts) {
+            imsic_max_hart_per_socket = soc[socket].num_harts;
+        }
+    }
+
+    imsic_name = g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRIx,
+                                 base_addr);
+    qemu_fdt_add_subnode(fdt, imsic_name);
+
+    qemu_fdt_setprop_string_array(fdt, imsic_name, "compatible",
+                                  (char **)&imsic_compat,
+                                  ARRAY_SIZE(imsic_compat));
+
+    qemu_fdt_setprop_cell(fdt, imsic_name, "#interrupt-cells",
+                          FDT_IMSIC_INT_CELLS);
+    qemu_fdt_setprop(fdt, imsic_name, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, imsic_name, "msi-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, imsic_name, "interrupts-extended",
+                     imsic_cells, props->smp_cpus * sizeof(uint32_t) * 2);
+    qemu_fdt_setprop(fdt, imsic_name, "reg", imsic_regs,
+                     props->socket_count * sizeof(uint32_t) * 4);
+    qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,num-ids",
+                          props->irqchip_num_msis);
+
+    if (imsic_guest_bits) {
+        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,guest-index-bits",
+                              imsic_guest_bits);
+    }
+
+    if (props->socket_count > 1) {
+        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,hart-index-bits",
+                              imsic_num_bits(imsic_max_hart_per_socket));
+        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,group-index-bits",
+                              imsic_num_bits(props->socket_count));
+        qemu_fdt_setprop_cell(fdt, imsic_name, "riscv,group-index-shift",
+                              IMSIC_MMIO_GROUP_MIN_SHIFT);
+    }
+    qemu_fdt_setprop_cell(fdt, imsic_name, "phandle", msi_phandle);
+}
+
+void create_fdt_imsic(void *fdt, IMSICFdtProps *props,
+                      uint32_t *phandle, uint32_t *intc_phandles,
+                      uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
+{
+    *msi_m_phandle = (*phandle)++;
+    *msi_s_phandle = (*phandle)++;
+
+    if (props->imsic_m_base) {
+        /* M-level IMSIC node */
+        create_fdt_one_imsic(fdt, props, props->imsic_m_base,
+                             intc_phandles, *msi_m_phandle, true, 0);
+    }
+
+    /* S-level IMSIC node */
+    create_fdt_one_imsic(fdt, props, props->imsic_s_base,
+                         intc_phandles, *msi_s_phandle, false,
+                         imsic_num_bits(props->aia_guests + 1));
+
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fc381a07f3..0ab91728d9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -320,97 +320,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
     }
 }
 
-static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
-                                 uint32_t *intc_phandles, uint32_t msi_phandle,
-                                 bool m_mode, uint32_t imsic_guest_bits)
-{
-    int cpu, socket;
-    g_autofree char *imsic_name = NULL;
-    MachineState *ms = MACHINE(s);
-    int socket_count = riscv_socket_count(ms);
-    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
-    g_autofree uint32_t *imsic_cells = NULL;
-    g_autofree uint32_t *imsic_regs = NULL;
-    static const char * const imsic_compat[2] = {
-        "qemu,imsics", "riscv,imsics"
-    };
-
-    imsic_cells = g_new0(uint32_t, ms->smp.cpus * 2);
-    imsic_regs = g_new0(uint32_t, socket_count * 4);
-
-    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        imsic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
-    }
-
-    imsic_max_hart_per_socket = 0;
-    for (socket = 0; socket < socket_count; socket++) {
-        imsic_addr = base_addr + socket * VIRT_IMSIC_GROUP_MAX_SIZE;
-        imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
-                     s->soc[socket].num_harts;
-        imsic_regs[socket * 4 + 0] = 0;
-        imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
-        imsic_regs[socket * 4 + 2] = 0;
-        imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);
-        if (imsic_max_hart_per_socket < s->soc[socket].num_harts) {
-            imsic_max_hart_per_socket = s->soc[socket].num_harts;
-        }
-    }
-
-    imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
-                                 (unsigned long)base_addr);
-    qemu_fdt_add_subnode(ms->fdt, imsic_name);
-    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
-                                  (char **)&imsic_compat,
-                                  ARRAY_SIZE(imsic_compat));
-
-    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
-                          FDT_IMSIC_INT_CELLS);
-    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
-    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
-                     imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
-    qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
-                     socket_count * sizeof(uint32_t) * 4);
-    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,num-ids",
-                     VIRT_IRQCHIP_NUM_MSIS);
-
-    if (imsic_guest_bits) {
-        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,guest-index-bits",
-                              imsic_guest_bits);
-    }
-
-    if (socket_count > 1) {
-        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,hart-index-bits",
-                              imsic_num_bits(imsic_max_hart_per_socket));
-        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-bits",
-                              imsic_num_bits(socket_count));
-        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-shift",
-                              IMSIC_MMIO_GROUP_MIN_SHIFT);
-    }
-    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
-}
-
-static void create_fdt_imsic(RISCVVirtState *s,
-                             uint32_t *phandle, uint32_t *intc_phandles,
-                             uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
-{
-    *msi_m_phandle = (*phandle)++;
-    *msi_s_phandle = (*phandle)++;
-
-    if (!kvm_enabled()) {
-        /* M-level IMSIC node */
-        create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_M].base, intc_phandles,
-                             *msi_m_phandle, true, 0);
-    }
-
-    /* S-level IMSIC node */
-    create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_S].base, intc_phandles,
-                         *msi_s_phandle, false,
-                         imsic_num_bits(s->aia_guests + 1));
-
-}
-
 /* Caller must free string after use */
 static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
 {
@@ -583,8 +492,19 @@ static void create_fdt_sockets(RISCVVirtState *s,
     }
 
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-        create_fdt_imsic(s, phandle, intc_phandles,
+        IMSICFdtProps props = {
+            .soc = &s->soc, .socket_count = riscv_socket_count(ms),
+            .smp_cpus = ms->smp.cpus,
+            .imsic_m_base = !kvm_enabled() ? s->memmap[VIRT_IMSIC_M].base : 0,
+            .imsic_s_base = s->memmap[VIRT_IMSIC_S].base,
+            .imsic_group_max_size = VIRT_IMSIC_GROUP_MAX_SIZE,
+            .irqchip_num_msis = VIRT_IRQCHIP_NUM_MSIS,
+            .aia_guests = s->aia_guests
+        };
+
+        create_fdt_imsic(ms->fdt, &props, phandle, intc_phandles,
                          &msi_m_phandle, &msi_s_phandle);
+
         *msi_pcie_phandle = msi_s_phandle;
     }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index bee8b85597..ab77bbda12 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -10,6 +10,8 @@
 #define RISCV_VIRT_FDT_H
 
 #include "target/riscv/cpu.h"
+#include "hw/core/boards.h"
+#include "hw/riscv/riscv_hart.h"
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
@@ -32,6 +34,23 @@ typedef enum RISCVAIAType {
     AIA_TYPE_APLIC_IMSIC,
 } RISCVAIAType;
 
+typedef struct IMSICFdtProps {
+    /*
+     * Machines will statically allocate RISCVHartArrayState[] pointer,
+     * e.g. "RISCVHartArrayState soc[VIRT_SOCKETS_MAX]".  We'll have
+     * to use a void* pointer to handle a soc with variable sizes.
+     */
+    void *soc;
+    hwaddr imsic_m_base;
+    hwaddr imsic_s_base;
+    int socket_count;
+    int smp_cpus;
+    int imsic_group_max_size;
+    int irqchip_num_msis;
+    int aia_guests;
+} IMSICFdtProps;
+
+
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
 void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -72,4 +91,7 @@ void create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
                      const MemMapEntry *pcie_mmio, const MemMapEntry *high_pcie,
                      uint32_t irq_pcie_phandle, uint32_t msi_pcie_phandle,
                      uint32_t iommu_sys_phandle, uint32_t pcie_irq);
+void create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
+                      uint32_t *phandle, uint32_t *intc_phandles,
+                      uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
 #endif
-- 
2.43.0


