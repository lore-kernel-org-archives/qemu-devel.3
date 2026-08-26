Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E474C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLSj-0003Kd-3D; Wed, 26 Aug 2026 17:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSh-0003JL-H4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzLSf-0001Ml-DE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 17:47:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdiZg1787902
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oeAeqqeBK6wakIcsbhuK26bvlA6DkBClt/xUhhGHrAE=; b=jW7lbAWMX9FI4i7L
 VhB68AaqV0SlpXZB+v+0JqU8mL3CZnGV0UajBlfwJEb3Uen+UbM5otgsETtqUnSS
 tkq7nZ8Wdk0fDrmLGXRlbZNGbzceFb9oFLIE2TJhdYBbFhaLRT9WDUuPTZNyZfhv
 jj4Si/zV/RQG0+xOxyu+DooVUxkZVoOL/kE/UqItm5nddyAGA/el/ATvV50y+Cx4
 P3Mclz3wdA11GArvPXgCTzzFj7f6PaC2SsYBWt3RL7O0w2h+mEXADugo3rEuspS5
 CnrN9ELE0i/BjubAPioVGl7VjTDNjWA3xeY3/XJEWevI5ojUPHRpz0B9GR4yG0RK
 onmNbw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03aa4ad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:47:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90a91f4c6f1so8802646d6.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 14:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787780828; x=1788385628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oeAeqqeBK6wakIcsbhuK26bvlA6DkBClt/xUhhGHrAE=;
 b=KRq3mEZ1C5b8GY/QjdNEfiiHRnROFHLDZU25OC5DLkco/d4gkVkvC2/KKYuBYz+Sh9
 5XaTkQ5+yES9sAm1jUe1N5e5MUxKSZ3ouRgo/z9l47Fd09KrcbFzRxR+AmPnyK3yV5Hx
 HIGh1WcYkGSqXHRTuxuZyiFSLQchL0RgVMuemdCViMjtolukIHe67MOoy3cIeZ5CZwPj
 R/BDO2NKHfbpK+/c4CtHXb3pFtdTP5NOqocieyQoOlycTUlHV7DJhxkNFWYtiam4SMic
 Obw1+HfLECU8TEXxXG21HKzlL56CLEO09OpilW10Gm6ND9F/hvSb9KdChgonsS/vEQnL
 qB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780828; x=1788385628;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oeAeqqeBK6wakIcsbhuK26bvlA6DkBClt/xUhhGHrAE=;
 b=G7hAEoETnPygRpV29QLEfBxV+QqUq6Cd6T9f9OgnyuUtjq2u1iCYaH26lZV+4er5VQ
 GKZxTBTu5Q1/UKcpC8jQYB/ic9z6u/2RqC5aI4uJrrqQKsHHDXZiNioBW1loiy8YnpXy
 Gu6t2sbF/rARhmbVBWvYije/1SJwh42gYSCBp528GRuAoiPSugtoqhzFUF37eJdTowOr
 pRymlVXd2EsoVZYk+18qOKbFwnj1H8mjm4oOzFCGdg9KViQqOigbxqAtmPHqOsH2rFwb
 Wb8/hZIRZNpeiTwK0mmLGgds1/+rTsYLIoa8ct5z4fM2U1Hft2TLGTAAbEX9MgeimbJB
 xqBw==
X-Gm-Message-State: AFuF++kci3i/dd4o3Z+9/V7jhuyaPEPkJM/fS2CbHGqnORzYxAq2ztuA
 JIY8XY513qGKKKP7H75lQsk9/nCPopU1N9E8hkVbcgrEdzk9VQIftCw/aPm2GqvpZH4YRd2PAXF
 GR+Kh9uePDQ4PAiURy7rO1ys7YfgDjBI//2v27OouS7ovPqxTZecNrjwspbm0U/+EUg==
X-Gm-Gg: AR+sD129z0wY20LQh2+ls2EmRtIWDt2zD0vMB27YxUPVg9rjnUDpqTeeZvJp5oawzmn
 tJiFJvu1I5hr6rEAcXshYXYXG+P0ASKw9CtKx6UHEjkKzjCO7puaumcTQ3Q3SYNpXATthTGy7PP
 UDhvC8HGVvqOOHt/wc5UHDgtsDxdoAQmX8pwezta7OPsemC9J9eA40ES4B3xGkZr259+CTh+8xK
 6WJ8J2siK3IwFJpubQVX9WCRpxJcalFLgnQPLClZMqR2w1jZqBsVB6JsZqZyXE7RpnYyiu/2R7E
 pKxjSYQbyWcP0y85H2mIvtoPYmpVVksqzibFI46SHjLht56D7uDAsKVbFjJ45RP0T0FhWbfsCEp
 xH9Vby2H2c+zeaeRoNdWdOh9B/WEviHmcYyIWNw==
X-Received: by 2002:a05:6214:5bc1:b0:90c:bf49:cada with SMTP id
 6a1803df08f44-90cc78df457mr124006746d6.10.1787780827577; 
 Wed, 26 Aug 2026 14:47:07 -0700 (PDT)
X-Received: by 2002:a05:6214:5bc1:b0:90c:bf49:cada with SMTP id
 6a1803df08f44-90cc78df457mr124006226d6.10.1787780827059; 
 Wed, 26 Aug 2026 14:47:07 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e4117sm490916d6.24.2026.08.26.14.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:47:06 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 06/14] hw/riscv/fdt_common,
 virt.c: add riscv_create_fdt_imsic()
Date: Wed, 26 Aug 2026 18:46:34 -0300
Message-ID: <20260826214643.122728-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 34Vhq4TWEXG0xLRR_17wlNby3jWQqk33
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8f5edc cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BMLNMfnq-h6aLQoT45oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 34Vhq4TWEXG0xLRR_17wlNby3jWQqk33
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfXyP9lR3fnT0k8
 2a1T7ug9nvEgg4UoJb2OEnUqeToO7xajq7nfGm5CaS+wmaVyod7SCpopyiaJlgyfiSPv3VsUJoV
 zoQjFsPrO1A8F37zxL+EjvJx61/h7TT+N7480xQXQhhtr3m5dPWSd4JN+GfWHyzIVD//uNNqiML
 NQu77pqRvX3weHUWsMNhWnEM0vDIWcdFc1cQ0hIXx/JGwVMonfqQCd1QQEaFRzqF2RTuI0glQB/
 iWKbm/23+Ym674fNHewi7ms0OUr6PPl60+Y3gextjF4EkmJyqVXP6C7Q/a9d3IpCH3Jhthx7dby
 BOdLUJVbxAOXXQtFuMGj6AP6F5Kr0ug3g05JFA1ZFUpurSkORNBCfiw9Krvk7r9/zwJ/qbgtcYA
 W12s+glRvQrln5kVIlW9jG22P+PtVuxaRjACfxhyJAO7VR7+Eg1mr97fVlpeLt4tPYTX3ODAgi9
 rNEkcLB9ckGal1Kw1xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE4MyBTYWx0ZWRfX/j48deVaBSpK
 2rB6xokAk4bmVunW2+q05PdZybGuZYh5Xg2th6CpYUlD7sv1/E49nh9AKr0BPLfoGP4O42zJbWj
 lOMcSdd5WB7JOAEX+R6QFPBbMcYNC78=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260183
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         |  94 +++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 107 +++++-----------------------------
 include/hw/riscv/fdt-common.h |  21 +++++++
 3 files changed, 129 insertions(+), 93 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 54604d3158..62243434d8 100644
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
 
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size)
@@ -499,3 +501,95 @@ void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
 
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
+void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
+                            uint32_t *phandle, uint32_t *intc_phandles,
+                            uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
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
index 32d66a278c..1a461b7eeb 100644
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
@@ -584,8 +493,20 @@ static void create_fdt_sockets(RISCVVirtState *s,
     }
 
     if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-        create_fdt_imsic(s, phandle, intc_phandles,
-                         &msi_m_phandle, &msi_s_phandle);
+        IMSICFdtProps props = {
+            .soc = &s->soc,
+            .socket_count = riscv_socket_count(ms),
+            .smp_cpus = ms->smp.cpus,
+            .imsic_m_base = !kvm_enabled() ? s->memmap[VIRT_IMSIC_M].base : 0,
+            .imsic_s_base = s->memmap[VIRT_IMSIC_S].base,
+            .imsic_group_max_size = VIRT_IMSIC_GROUP_MAX_SIZE,
+            .irqchip_num_msis = VIRT_IRQCHIP_NUM_MSIS,
+            .aia_guests = s->aia_guests
+        };
+
+        riscv_create_fdt_imsic(ms->fdt, &props, phandle, intc_phandles,
+                               &msi_m_phandle, &msi_s_phandle);
+
         *msi_pcie_phandle = msi_s_phandle;
     }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 7517316a56..f0d24c26f5 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -10,6 +10,8 @@
 #define RISCV_VIRT_FDT_H
 
 #include "target/riscv/cpu.h"
+#include "hw/core/boards.h"
+#include "hw/riscv/riscv_hart.h"
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
@@ -32,6 +34,22 @@ typedef enum RISCVAIAType {
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
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size);
 void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -77,4 +95,7 @@ void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
                            uint32_t irq_pcie_phandle,
                            uint32_t msi_pcie_phandle,
                            uint32_t iommu_sys_phandle, uint32_t pcie_irq);
+void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
+                            uint32_t *phandle, uint32_t *intc_phandles,
+                            uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
 #endif
-- 
2.43.0


