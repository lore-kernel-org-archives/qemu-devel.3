Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2898FC61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGo4-0006Hz-F5; Wed, 26 Aug 2026 12:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGo1-0006CK-Qq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnz-0000uC-Gw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDut9B1461922
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LoDaM/9hyCV
 yH/OGkL8dS2L29acFOpKSFw1j7Ys5DgA=; b=B2lUj/dpMWm1OwLNlAEQJQl9wky
 Ss/e9+PJiqp4FukRkvPzdtIAdC2+kQ+3Yl66Jt+f6t2Huvizv8zNkhoj82cztIeK
 fJIQKUcTmZnDCiTMOZUMW9nO2yE/zhKDNdCdnVP456aODFffTFgtr/u5NxygfiZl
 jVm+PmTj1U4EjnXKfWrIbLHi9x/trzCbrJc43r/HsZmwWQqN2XKDsj6Px5HsGAWj
 2KIUhLlB3DXhZhbsCz9fBPLDEbUSnpFe6jhU++DQO9JGU2KmahpF8/y70kwMd2Tg
 HVb+vZZ9fPZieoXbQmQZtG+1NDNwBM6ayEdxq6cSmijdI5yb53MmQcMxz3g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gk3jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ef04756caso5880551cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762920; x=1788367720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LoDaM/9hyCVyH/OGkL8dS2L29acFOpKSFw1j7Ys5DgA=;
 b=ZPPGnEWpeTuX2eP7bU/9WvRBDIZXqluIwK9RYHVghp5zR8qtTJPUDX7BUsVG/eCzN1
 PVNwSLFC3vaNLPKf0FDi7Sjz/wO/DzaY4Ez9YxThtLbP0qy8L95/LTYQZATiFYNVuePK
 HKCDAi6cMkdKgdJvtM/AGbJb6zm3s/9gJK+e+unXU/O4+UpGzgnkQ/LlrUma64ddNIAk
 yJelDyPuMUvsYZqfKY5/UKRXfTtGZTKI4LUCi+XRge6Jzb0HOG1lcweNvbY3O8ozDYIq
 EPdgosRRsaR5LmNNwYFCNjYX6HaYDP7/wjOp+AO8lBchzfNqilIcmKkDbQmCFw1An9Zt
 T+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762920; x=1788367720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LoDaM/9hyCVyH/OGkL8dS2L29acFOpKSFw1j7Ys5DgA=;
 b=ORG7efCqMGpZICCjgxhOLTM2ybUEfiPTubrYLqx46Qe6b8k0vnqVXwXVM0L3E7Ii2Z
 jJhOuAmYD+7kLPTEBL2sFr2jMj3+q26M6y+rAltsK54ET3LIOOC3kIPZtcN+4dCG7IOP
 7TVWeCIDcGXnyR+vYIYQTju8e72p4TNVjmM/JQ7azmwUt5cDXfUaE9kr+6hLgWeZf89b
 AvMBg+GJmxDd8mdvyup9auHUREYMpn6x+60DtGEwsRTZ7VxCjRPFgrI8B9ut/jE9KCJw
 SDnPHt4I7zfpF62kg28nxahulCvNG7mEpI+k3l0fzgWgbdkMuTf8LAQci+MU48gNlXyS
 T2aA==
X-Gm-Message-State: AFuF++nEdkY3PpXJgs7XA0S0Z5+VYwjRV/yHNAyBbmh3h0MFVeIZrFSl
 VL5NG8wiQRKCkK9Dhv8lP9RU1AVvx/8dMtDf4X4E2h5wv27MvbTHFbrG0JiDBanZfuywYUQ64wA
 vo3eMr5ir1LixLctQEtrKmSg8NqkwmKYvS1IEOZRXlQ7Cw0eqZUQ9FUoQncY7qC2p/A==
X-Gm-Gg: AR+sD10as4NqL8FkPBp/C5YrWhekj1qA47UVIAjU93iLwu+cCzmzHuhUormfacLs036
 cglIoeE9g8IMq5ELR5B86aD3L/X2pGwyHqIosUYNJEiUDgGly0ZPkrgmdDDcE6Z+UGmMpRuhQ5D
 gST1uGGFpV5RLXr6dp3+neqpX9Mek+pbhWVkBJGxOEheGq6LnBxaHBdAk105NvwPb4332iRdce7
 uoSRT4gQVM6GYF2VhwleYa3JUJ5V/v8K7SYNtrLpOenK31TJhq1AQfrcZFtClx5YGvEsEnagxcN
 jJZf2RT57JPo3WQRWMfv0YSuvsL7pntCX/ntTct/powlAvgqGEGHpm00VLTp/MrrhmOAp/xSYfr
 jMOBv3w/jvDigxgFY14hSDRu9Q7ym92T8FSdeow==
X-Received: by 2002:a05:622a:30c:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-52e4231aba3mr75600651cf.27.1787762919494; 
 Wed, 26 Aug 2026 09:48:39 -0700 (PDT)
X-Received: by 2002:a05:622a:30c:b0:51c:14f5:8f9c with SMTP id
 d75a77b69052e-52e4231aba3mr75599831cf.27.1787762918776; 
 Wed, 26 Aug 2026 09:48:38 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:38 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 07/13] hw/riscv/fdt-common,
 virt.c: add create_fdt_socket_aclint()
Date: Wed, 26 Aug 2026 13:48:07 -0300
Message-ID: <20260826164814.44335-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F2nS8kQ6KTzVhIHKir8CdV_Ct5W99VcY
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8f18e8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=7Bblaz4JstUzMt5rO2kA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX3XOzpIc8F2iw
 sRMiomH0NNf8uShm4rFauwGT8BpW4omh7VB1j4dUMS6HEIHMFl9H2oramvuhEkaIihL0dM8/oal
 FCcWQ+Gtn+dRQkWj0Ce0N/plRvxczVg=
X-Proofpoint-ORIG-GUID: F2nS8kQ6KTzVhIHKir8CdV_Ct5W99VcY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX5h7bFnTuLbnV
 FD8Vfpc8hPeX27h4FoDv2UOPg9LkBkDz596bPr5gV+LK9YK9z+c7RxpYF08qCDD9HaKy779XTu3
 8MkLBAacz6wwyBSQW92KskZ/c2uaBkk72Y9Bu4vodUWrI30PNvW+DR/FrHk3ftEs65Fv5vF4L8K
 fErYQNouMqytEFtoBOk2boQaPRbVt7rPBJi0drl2hAzkVE3v9j0MDNTGq4XuhYhQojBfdqsqBKz
 UlayhAt7P0ua4JZ2pOxP+ycMb9EGyA8/n/YJvIvHkcIQmXj7Pz9xm3HuQvP+XRifNljRvU/Z9+C
 4/hGqEfHyxXdYoBN0MpG5xumm3gIsKpxHk7qC/CXg1642s08veYGv9F8iR7y6Lai6n5CPCKPPAv
 W+k5rdOJChzavnSFtuh4/El00l6AjoXPClVwRwGyL7iVVgf1RkWN/dAHxPxOa49h4VgccTgor6v
 C7+64uZdEF2YRR4B4xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260140
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

Yet another FDT that we want to move to a helper to avoid copy/pasting
code to other boards that will use a mtimer.  In particular the future
'riscv-server-ref' board.

No FDT changes made.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 96 +++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 99 ++++-------------------------------
 include/hw/riscv/fdt-common.h | 11 ++++
 3 files changed, 118 insertions(+), 88 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 77168f5c4f..f31cc9d3cc 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -16,6 +16,7 @@
 #include "target/riscv/cpu_bits.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/iommu.h"
+#include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_imsic.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
@@ -695,3 +696,98 @@ void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
 
     aplic_phandles[props->socket] = aplic_s_phandle;
 }
+
+void create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
+                              uint32_t *intc_phandles)
+{
+    uint32_t aclint_cells_size = props->num_harts * sizeof(uint32_t) * 2;
+    g_autofree uint32_t *aclint_mswi_cells = NULL;
+    g_autofree uint32_t *aclint_sswi_cells = NULL;
+    g_autofree uint32_t *aclint_mtimer_cells = NULL;
+    hwaddr addr, size;
+    char *name;
+    int cpu;
+
+    aclint_mswi_cells = g_new0(uint32_t, props->num_harts * 2);
+    aclint_mtimer_cells = g_new0(uint32_t, props->num_harts * 2);
+    aclint_sswi_cells = g_new0(uint32_t, props->num_harts * 2);
+
+    for (cpu = 0; cpu < props->num_harts; cpu++) {
+        aclint_mswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aclint_mswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_SOFT);
+        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
+        aclint_sswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
+        aclint_sswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_SOFT);
+    }
+
+    if (props->aia_type != AIA_TYPE_APLIC_IMSIC) {
+        addr = props->clint->base + (props->clint->size * props->socket);
+        name = g_strdup_printf("/soc/mswi@%"HWADDR_PRIx, addr);
+
+        qemu_fdt_add_subnode(fdt, name);
+        qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mswi");
+        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                     2, addr, 2, RISCV_ACLINT_SWI_SIZE);
+        qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                         aclint_mswi_cells, aclint_cells_size);
+        qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
+        qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
+
+        if (props->numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
+        }
+
+        g_free(name);
+    }
+
+    if (props->aia_type == AIA_TYPE_APLIC_IMSIC) {
+        addr = props->clint->base +
+               (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * props->socket);
+        size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
+    } else {
+        addr = props->clint->base + RISCV_ACLINT_SWI_SIZE +
+               (props->clint->size * props->socket);
+        size = props->clint->size - RISCV_ACLINT_SWI_SIZE;
+    }
+
+    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible",
+                            "riscv,aclint-mtimer");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+        2, addr,
+        2, size - RISCV_ACLINT_DEFAULT_MTIME,
+        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
+        2, RISCV_ACLINT_DEFAULT_MTIME);
+    qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                     aclint_mtimer_cells, aclint_cells_size);
+
+    if (props->numa_enabled) {
+        qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
+    }
+
+    g_free(name);
+
+    if (props->aia_type != AIA_TYPE_APLIC_IMSIC) {
+        addr = props->aclint_sswi->base
+               + (props->aclint_sswi->size * props->socket);
+
+        name = g_strdup_printf("/soc/sswi@%"HWADDR_PRIx, addr);
+        qemu_fdt_add_subnode(fdt, name);
+        qemu_fdt_setprop_string(fdt, name, "compatible",
+            "riscv,aclint-sswi");
+        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                     2, addr, 2, props->aclint_sswi->size);
+        qemu_fdt_setprop(fdt, name, "interrupts-extended",
+                         aclint_sswi_cells, aclint_cells_size);
+        qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
+        qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
+
+        if (props->numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
+        }
+
+        g_free(name);
+    }
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dd8f5d9d75..ef2670f20e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -180,93 +180,6 @@ static void virt_flash_map(RISCVVirtState *s,
                     sysmem);
 }
 
-static void create_fdt_socket_aclint(RISCVVirtState *s,
-                                     int socket,
-                                     uint32_t *intc_phandles)
-{
-    int cpu;
-    char *name;
-    unsigned long addr, size;
-    uint32_t aclint_cells_size;
-    g_autofree uint32_t *aclint_mswi_cells = NULL;
-    g_autofree uint32_t *aclint_sswi_cells = NULL;
-    g_autofree uint32_t *aclint_mtimer_cells = NULL;
-    MachineState *ms = MACHINE(s);
-
-    aclint_mswi_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
-    aclint_mtimer_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
-    aclint_sswi_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
-
-    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
-        aclint_mswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        aclint_mswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
-        aclint_sswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
-        aclint_sswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_SOFT);
-    }
-    aclint_cells_size = s->soc[socket].num_harts * sizeof(uint32_t) * 2;
-
-    if (s->aia_type != VIRT_AIA_TYPE_APLIC_IMSIC) {
-        addr = s->memmap[VIRT_CLINT].base +
-               (s->memmap[VIRT_CLINT].size * socket);
-        name = g_strdup_printf("/soc/mswi@%lx", addr);
-
-        qemu_fdt_add_subnode(ms->fdt, name);
-        qemu_fdt_setprop_string(ms->fdt, name, "compatible",
-            "riscv,aclint-mswi");
-        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-            2, addr, 2, RISCV_ACLINT_SWI_SIZE);
-        qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
-            aclint_mswi_cells, aclint_cells_size);
-        qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells", 0);
-        riscv_socket_fdt_write_id(ms, name, socket);
-        g_free(name);
-    }
-
-    if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-        addr = s->memmap[VIRT_CLINT].base +
-               (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket);
-        size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
-    } else {
-        addr = s->memmap[VIRT_CLINT].base + RISCV_ACLINT_SWI_SIZE +
-               (s->memmap[VIRT_CLINT].size * socket);
-        size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
-    }
-    name = g_strdup_printf("/soc/mtimer@%lx", addr);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
-        "riscv,aclint-mtimer");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
-        2, size - RISCV_ACLINT_DEFAULT_MTIME,
-        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
-        2, RISCV_ACLINT_DEFAULT_MTIME);
-    qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
-        aclint_mtimer_cells, aclint_cells_size);
-    riscv_socket_fdt_write_id(ms, name, socket);
-    g_free(name);
-
-    if (s->aia_type != VIRT_AIA_TYPE_APLIC_IMSIC) {
-        addr = s->memmap[VIRT_ACLINT_SSWI].base +
-               (s->memmap[VIRT_ACLINT_SSWI].size * socket);
-
-        name = g_strdup_printf("/soc/sswi@%lx", addr);
-        qemu_fdt_add_subnode(ms->fdt, name);
-        qemu_fdt_setprop_string(ms->fdt, name, "compatible",
-            "riscv,aclint-sswi");
-        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-            2, addr, 2, s->memmap[VIRT_ACLINT_SSWI].size);
-        qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
-            aclint_sswi_cells, aclint_cells_size);
-        qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells", 0);
-        riscv_socket_fdt_write_id(ms, name, socket);
-        g_free(name);
-    }
-}
-
 static void create_fdt_socket_plic(RISCVVirtState *s,
                                    int socket,
                                    uint32_t *phandle, uint32_t *intc_phandles,
@@ -347,6 +260,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
     bool numa_enabled = riscv_numa_enabled(ms);
     bool is_32_bit = riscv_is_32bit(&s->soc[0]);
     APLICFdtProps aplic_props;
+    ACLINTFdtProps aclint_props;
 
     fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
@@ -354,6 +268,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
 
     intc_phandles = g_new0(uint32_t, ms->smp.cpus);
 
+    if (virt_aclint_allowed() && s->have_aclint) {
+        aclint_props.clint = &s->memmap[VIRT_CLINT];
+        aclint_props.aclint_sswi = &s->memmap[VIRT_ACLINT_SSWI];
+        aclint_props.aia_type = s->aia_type;
+        aclint_props.numa_enabled = numa_enabled;
+    }
+
     phandle_pos = ms->smp.cpus;
     for (socket = (socket_count - 1); socket >= 0; socket--) {
         hwaddr memaddr = s->memmap[VIRT_DRAM].base +
@@ -372,7 +293,9 @@ static void create_fdt_sockets(RISCVVirtState *s,
                                  socket, riscv_numa_enabled(ms));
 
         if (virt_aclint_allowed() && s->have_aclint) {
-            create_fdt_socket_aclint(s, socket,
+            aclint_props.socket = socket;
+            aclint_props.num_harts = s->soc[socket].num_harts;
+            create_fdt_socket_aclint(ms->fdt, &aclint_props,
                                      &intc_phandles[phandle_pos]);
         } else if (tcg_enabled()) {
             hwaddr clintaddr = s->memmap[VIRT_CLINT].base +
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 7a7e3ad7af..fbcf9aaffb 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -63,6 +63,15 @@ typedef struct APLICFdtProps {
     int aia_type;
 } APLICFdtProps;
 
+typedef struct ACLINTFdtProps {
+    const MemMapEntry *clint;
+    const MemMapEntry *aclint_sswi;
+    int socket;
+    int num_harts;
+    int aia_type;
+    bool numa_enabled;
+} ACLINTFdtProps;
+
 void *create_board_device_tree(const char *model, const char *compatible,
                                int *fdt_size);
 void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -112,4 +121,6 @@ void create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
                              uint32_t *phandle,
                              uint32_t *intc_phandles,
                              uint32_t *aplic_phandles);
+void create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
+                              uint32_t *intc_phandles);
 #endif
-- 
2.43.0


