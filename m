Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4281C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Mq-0007Oy-5O; Fri, 28 Aug 2026 16:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mo-0007OL-OA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x03Mm-0006Xk-FZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:40:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7c5X3331605
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ke9R/58Ze4h23ka0mdbmmjtY8J7DdKS77JkFVpG43AI=; b=oW6EkCn5K8dvtVCH
 E9+cyzicz15eBPHWZICFdOyJSA6oSVP5NmtpSIt6oi2GaBlU8dkk6P90LmycVxPo
 jU1rd1MA4nKF2DxpxNGw817ukkowP4OJxhFTD/wAldSmnQR/RzHB6tl8STWICIle
 ROCLxbYSaEgVSI96bhDKSPzrQn7sCrJhAoBAg/BmTLxFayO0jFwNolWo6nz8s3ae
 DWg5AYUdUmkrIpgHgUbc0qP46/ZVbfVWasN1OeUGMGoEpOAxRBxjIzLOzKdTZNWZ
 sIqnGGAYT1Sveu2mkoogBGbLI3m7fuRi53UxoJzBUz6fClZyGLj2YsGG9k2RvD4b
 ch9hjw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42rbeex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 20:39:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93771aa0379so348807185a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787949589; x=1788554389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ke9R/58Ze4h23ka0mdbmmjtY8J7DdKS77JkFVpG43AI=;
 b=XK5wcLg1ajsMtzQhez7JKJcbKzG6koQv1JnAc16fnnXkHUS+Who+BY6jN0p2jm6QT6
 THwZ5Y3Uw1BfsjizGrlhgLTWZ2K0qal0Ti3nAJcYpLgsS+W+oT6KLJ6RPrYE0FpF3JL6
 bYlhm1M1UcDumR28PksJ9Mj8lh8jSa2gyA1qpVlrpwhuE2skRrzfx8rIJuCCnE2hz6IM
 Y2hgfTN35fcU9WC2UGa8QE5fONRTnBPtdhnV27A5x6ztnSATx/bktt83w253Fwwk6pRb
 7Rr8xKUALzy0TDimYa+Aaj8JbIZVLP+eF1Ka8ZG8ta7T43iRu8MWrfeFHTz3H+BHMwol
 6H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949589; x=1788554389;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ke9R/58Ze4h23ka0mdbmmjtY8J7DdKS77JkFVpG43AI=;
 b=cKShFq2j6zvG/zVu2bvWa9Is1HkBRn8WYhD6uGrZde0O4w7cU+Fg9q4bOhD9p/ek7J
 58fVtoxR0FTyMH2pGtRQVyvOI3kNkNgLQIFBajKHBxsPg3Ce5fRueqk842jDwAm7Ew67
 a+/Bxndh5hAcY85N88vG3vuwJOJ3aQYjoczVqOaDtlKp7noqov7ipKZLxhYHF6pBiipJ
 IH6y2pgeNEYkky3Tn+S8wqfAsdMyVhPr8cVHbkewghexkbZQDibHRcfBpl9eLFFf78I/
 NjQhXQFYrK8zw9JZpM2dCmXRZ6Xxf7lTyEJSsWoQs33Ghr9B9ap9yhAWLQGOnmyCNKlF
 eHQA==
X-Gm-Message-State: AFuF++neEezIULXgg7kAr1SyTIl/Q+k+xVujV7L0R58xdizJwpQ4nE71
 +TGwON3V0AmQiXVLRtTdmo8kONgK1qylUKL2jvinOshcGgocP6OqoxfFEoZ9See5X9Sx+Of6Xc5
 0eo1RYLQA0ygt73pcxHVlfUve7JoKJW/Du2Z+mSMdBKhf338ICXunWrNqBshQ1K11Fw==
X-Gm-Gg: AR+sD132zUhjha6NOQ1Up5ZGyZkEuEMFE3D7OpAK+JeK8M+hYwh5jIrKx4CLs5oyTfa
 ZOeXQBPOkEszKd71QKOivAKvelDONs/GoLyMmmYoXY6NKVOEvUebDVjfMGoV+cBNMO8v2LGG7V/
 Zfk2x/DxHYeJIn0BzI4q6WAOWOVQHm+nRjnX6zJOJxCHZSpgIyfN3ZLAs5gx19zqFHf1zm6Yawq
 2OIMqj44pIxq5rpEt/hoLnJsr/2DnIFAN+G11Ces27Bou5CKZYrIz+PjSdyLpfxOkyWqzLS3cgc
 GyBc2ExvvnTBwvw3bCLSv5NYfodcIwTg33Z80alPoXp/XB+WB+3+Mf5KOPcviVSI6LznVw2yVjq
 a3aGMksrNAketP56ZH3mm1m0Us+PSLUEIb4I+bw==
X-Received: by 2002:a05:620a:a30a:b0:936:ef9d:2c74 with SMTP id
 af79cd13be357-939138cd144mr973451085a.30.1787949586881; 
 Fri, 28 Aug 2026 13:39:46 -0700 (PDT)
X-Received: by 2002:a05:620a:a30a:b0:936:ef9d:2c74 with SMTP id
 af79cd13be357-939138cd144mr973447285a.30.1787949586341; 
 Fri, 28 Aug 2026 13:39:46 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm218063985a.37.2026.08.28.13.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:39:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 07/15] hw/riscv/fdt_common,
 virt.c: add riscv_create_fdt_socket_aplic()
Date: Fri, 28 Aug 2026 17:39:09 -0300
Message-ID: <20260828203918.350131-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C-vHKR5Qg3N0MI4phTpoVeYkOtjgiOlE
X-Proofpoint-ORIG-GUID: C-vHKR5Qg3N0MI4phTpoVeYkOtjgiOlE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX76FW+SOxYkdF
 WRU+XyR4SH/mTdgxuXEr0MM90cO9pGtmYEyXPD1q+EVS4CSH603OBoNRs4isMxxLEgSn3izUzbC
 3LtbUodIR81G8aJM4LeHnlWlgpcmlnPl3xK8XdImm9TZt4B6QZcDxRhv1PL7Dcih19bfMf1G2rV
 uj/qGkrLJi9e7nJ7o74dwVQFAWK328lSfm1zDHTnh0358gBrMWCKBy0oHHX51In1ShfhdTvu2lv
 PLEumKK1cRlM7G7H5zugbNpfi2Wg6/KoFrB2dnbSXJxdZOQ88hdmmvHOwe3rvznSWOowQ844lth
 le0NMCpAkZwjD4BUFpKfY7QT1+GiKAOhxrUHtxT2GfoN5LftBCEqkOvQEKC76uq6zRsl+nh1DDQ
 w6h3XjvXEKclZxl9KL0LZi3gk98kGFFrEEEhY4I+BuQ/oEithBEiER0McSg2MiuxtSJq4MaPVsi
 lKT947VsQTOjs96L4/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3OSBTYWx0ZWRfX/QnzHHHTMVQ1
 zDcJhkkv+Aq5jHGwnxjjAD9BR5ig99jzhHxdFeC/C8/9znp4aELocjo9yeK+Mzw1UTGzWdFy675
 FAcWUbMIihaJ19IO3PyTEPpAfG/lmh0=
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=6a91f215 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=n_9SJqc2hf8O7kRhLXIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280179
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

Similar to what we did with 'imsic' in the previous patch, including
creating a helper struct to encapsulate the extra arguments required to
create the FDT.

TODO: I believe the tt-atlantis board can use this same helper too.  We
just need to verify how to map the phandles used by it and what the
helper is using (which was inherited by the 'virt' board).

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 109 ++++++++++++++++++++++++++
 hw/riscv/virt.c               | 139 ++++++----------------------------
 include/hw/riscv/fdt-common.h |  19 +++++
 3 files changed, 151 insertions(+), 116 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ae24ad0011..d815c5adff 100644
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
@@ -593,3 +594,111 @@ void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *props,
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
+
+    for (int cpu = 0; cpu < props->num_harts; cpu++) {
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
+void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                                   uint32_t msi_m_phandle,
+                                   uint32_t msi_s_phandle,
+                                   uint32_t *next_phandle,
+                                   uint32_t *intc_phandles,
+                                   uint32_t *aplic_phandles)
+{
+    uint32_t aplic_m_phandle, aplic_s_phandle;
+    hwaddr aplic_addr;
+
+    if (next_phandle) {
+        aplic_m_phandle = (*next_phandle)++;
+        aplic_s_phandle = (*next_phandle)++;
+    } else {
+        aplic_m_phandle = qemu_fdt_alloc_phandle(fdt);
+        aplic_s_phandle = qemu_fdt_alloc_phandle(fdt);
+    }
+
+    if (props->aplic_m) {
+        /* M-level APLIC node */
+        aplic_addr = props->aplic_m->base + (props->aplic_m->size * props->socket);
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
index 468ec90696..a6ec9def16 100644
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
 
     riscv_fdt_create_cpu_socket_subnode(ms->fdt,
         kvm_enabled() ? kvm_riscv_get_timebase_frequency(&s->soc->harts[0]) :
@@ -510,15 +404,26 @@ static void create_fdt_sockets(RISCVVirtState *s,
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
-                                msi_m_phandle, msi_s_phandle, phandle,
-                                &intc_phandles[0], xplic_phandles,
-                                ms->smp.cpus);
+        riscv_create_fdt_socket_aplic(ms->fdt, &aplic_props,
+                                      msi_m_phandle, msi_s_phandle, phandle,
+                                      &intc_phandles[0], xplic_phandles);
 
         *irq_mmio_phandle = xplic_phandles[0];
         *irq_virtio_phandle = xplic_phandles[0];
@@ -533,11 +438,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
                                        &intc_phandles[phandle_pos],
                                        xplic_phandles);
             } else {
-                create_fdt_socket_aplic(s, socket,
-                                        msi_m_phandle, msi_s_phandle, phandle,
-                                        &intc_phandles[phandle_pos],
-                                        xplic_phandles,
-                                        s->soc[socket].num_harts);
+                aplic_props.socket = socket;
+                aplic_props.num_harts = s->soc[socket].num_harts;
+                riscv_create_fdt_socket_aplic(ms->fdt, &aplic_props,
+                                              msi_m_phandle, msi_s_phandle,
+                                              phandle,
+                                              &intc_phandles[phandle_pos],
+                                              xplic_phandles);
             }
         }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 182c03d8ce..8207cfee7b 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -12,6 +12,7 @@
 #include "target/riscv/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/riscv_hart.h"
+#include "exec/hwaddr.h"
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
@@ -50,6 +51,18 @@ typedef struct IMSICFdtProps {
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
+
 void *riscv_create_board_device_tree(const char *model, const char *compatible,
                                      int *fdt_size);
 void riscv_create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
@@ -98,4 +111,10 @@ void riscv_create_fdt_pcie(void *fdt, int aia_type, bool has_iommu_sys,
 void riscv_create_fdt_imsic(void *fdt, IMSICFdtProps *fdt_props,
                             uint32_t *next_phandle, uint32_t *intc_phandles,
                             uint32_t *msi_m_phandle, uint32_t *msi_s_phandle);
+void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
+                                   uint32_t msi_m_phandle,
+                                   uint32_t msi_s_phandle,
+                                   uint32_t *next_phandle,
+                                   uint32_t *intc_phandles,
+                                   uint32_t *aplic_phandles);
 #endif
-- 
2.43.0


