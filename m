Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B5C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzull-0001ok-II; Fri, 28 Aug 2026 07:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wzuli-0001nM-Cj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:29:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wzulg-0007d3-Da
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 07:29:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA7nVW3306724
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=c7RNdSqYVCA
 bHsYLsuQm5WluyL2z7ViFRVJaq8J+r9k=; b=AaCHdtNAOMssxu22H7AOgwi55n3
 l09dnammnZho8Tvu3CNPekfYzG8P9EkvJMiCIVqLl5ir7FPB3tzc19Tp2lry3EEl
 CjRwE9UvRIX7PJJBOMzT/bgEIdeZhWOO9wrPbGgo902hSVUIFRbqalb3W+hDI8Ii
 j2alAFoNoqXI26w7QY+OjcbtEC1xXsnFH768cVBhHb2laxVc9d6dEW7rin3cuE4P
 dm0pPJk3ZYQkkNvOkLppp57RmTJyNuTEPqm/mnhrQRoZeGR0pkRoJcorZN43XHv+
 CRiVJspxIBx8196MmxpnRoEwqhKUzIf9yh2e2fVyDAy/+Z5MMtF3+amFd8A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p9ck4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 11:29:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38105cc58e1so237707a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787916546; x=1788521346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c7RNdSqYVCAbHsYLsuQm5WluyL2z7ViFRVJaq8J+r9k=;
 b=j8fZUYkpSHwOq/2cI5h3J/IuP1IzOJKW01p8IPG7/xJ8KCK9YX5ncnegMHm0FFXaoG
 JQprhIGopqkLS+4I++Z6najsLVoARX+ZrDMYScvJf8KXAfewUU3P5ZirZGUjqrkzBsxh
 oGWGFFvVzTstBTx+Fr2rz62l7WuGoPxDUu7RiaNh0Q/gQGE6a1nJqxiM4oZVzcsccbko
 F+25eQLMhHctU66Wbka956rRsTCByu3NDB0qFF92rrQl7/P4zh/plQpnQjU7dp7/gqhQ
 n5ZuPpW56/r/YWDqkDo5mgsC3gXTpkOyecoLkQHmABayJV26448H6OR75AZV95Nh68kL
 PFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916546; x=1788521346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c7RNdSqYVCAbHsYLsuQm5WluyL2z7ViFRVJaq8J+r9k=;
 b=iNkI3gd5Z+4RrAHZb/Ogfhcirjbi/YKYj3fgmDcXGnCh7U3xMdxC8VKkznuuleHVNS
 BdicxG3TrSFbNNxM3Y/8runsRezigvPN/XKikyV4X8FyzpSvsc+x9tGqTunMPZIi7yNL
 CkZJUPd1bW5CV2WewVJLyJFMZo7UVM+U7AAtZLOb4l1cuQN4qZZ/KOFcz9+PDLkUPGP4
 lZaVTHcuGGgRAnOoo8CYw8C9h0+vWuI3IZd3lZn/Q3skAGmhkVrDkktY7wYuwZHNd/11
 egvMApoXkSeriQjDZmoUCNOmMdynsy93XzBJp1VXZWQdf7Rc4p6SOkt/ZhHNLU2K0Lwa
 ML9Q==
X-Gm-Message-State: AFuF++k5Zm/LRisdIB69JwxppuPIlUXYKKSMqweK5O11YtftWqkY8jtj
 vRoUm9PgDYnRjfTC5A0jyBPLnIxNRaJzVf1+rZKuGxYahJ0qNk1KFS4YMOAlD2rzG02xoMAMu+M
 iUos/3hAJdUamPKDXtW4znGXkTCQmoXnYetlCxT1hQaQ0UAn5/5XCv2lN/1ebKaAfiw==
X-Gm-Gg: AR+sD13wf7RSSIXBOCyLhEhcjkqXoKStUWXFgRYBjis45TdbbmaCioJzAc4IyCyLCEB
 8o5d8r5Nj+8y+rHC/fIfz2pPKiXIorOLK3yOfyT2lDOWq4UiFQDBesbAhPXmtaU3ZhAZMK4ODH9
 tX9WG/+27EAhSk+TUogh5u4S2s/rjjpisJBldyM61wXL4lBvZquIPW4SpnZPLWxfpsoyyI9y4O/
 UIRZ8z+y2UZ+sBevNOIu7TsqzxlEgDTPiCpB0giBTebYMHju7aJ5W915GUUnCtTrfMsHqNXIrXE
 V7a6Ap6c10IiCRCIDaqHpJz+pkHcKryCYJmoFDGbKMg35K6DTXflKj/V2V1Qlyb+tF8DCk0aNwA
 Ky5OXeyhXF4TRAezo/r9k5eYdB+zJpPe0qeqyH3bgI7nkOsrmnQR8y9/MoL+96/2wozYo4qfA7e
 hLlPR70FV+uaQjaVmKLvdyefX9YMBh2pI=
X-Received: by 2002:a17:90b:3c47:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-396d0ee934emr6311498a91.2.1787916546283; 
 Fri, 28 Aug 2026 04:29:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3c47:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-396d0ee934emr6311424a91.2.1787916545840; 
 Fri, 28 Aug 2026 04:29:05 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4d92sm4997320c88.13.2026.08.28.04.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:29:05 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v10 03/10] hw/riscv: add RPMI FDT helpers
Date: Fri, 28 Aug 2026 16:57:55 +0530
Message-ID: <20260828112803.86636-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k2LtmPqzp27HkQ_BbW8cpRhgoipBwlx6
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a917103 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=WNJofZAcfibaGo0vQRIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: k2LtmPqzp27HkQ_BbW8cpRhgoipBwlx6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OCBTYWx0ZWRfX7ZbDj9ER3N5f
 JCdLqMOCeYArKFsKJWJ62MS4+NiPnCawgy654PF1xdturzfkbUkuHgwR3kvj7yl4TKJaQYc8OXK
 Li4m+eVIQ8IjemyIPVAqDuauAa6HYdI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OCBTYWx0ZWRfX5Oj5YF58k6if
 uF7zIngfOiTHhPNE7tWdJUAe1+qmHvUJYhBeBUNEgMaby2AxHs0IRYpkKQcrzdLcIMVyELg2ii4
 iaOSwKxINL2Ik/wc5q2Rgm2/tiX2JzngOAFvz7A0H1csH3xYeoq8XZKq4f2omyjvlYWVbim7B8O
 QAlMLsIKou+IELbkUFbntk0IRXYMy67u3VrwLOtwR9S554zZ+jP97NvhVX4J2U2P9OSl4WLrDwV
 dIJcs6pX3wdvs1QThc/Porp8Xqu1KoY84zZwn7yZRZKJT5bNYXQRQ8t10ZmCRphaMiQZzPde3il
 /vIji0R7pPCe1KQc1gNaHLmz9Wfzydkdy+BfZ2Ty6lrDvRMvgv/UVUVbPkI9gqxPQKy8a1k3bzf
 EVhVMSumKmP+PjXwpcRgquVAjzNN9/HJR7JHw+HttwLc13obYLo2wxT+sFNp7kfpcSguHKCgF3D
 4jvW60xjOMN7u0epvJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Add helper routines for describing RPMI shared-memory mailbox transports
and service child nodes in the RISC-V virt device tree.

The helpers keep RPMI node construction in one place so the virt machine
can add service groups without open-coding compatible strings, channel
IDs, interrupts, and shared-memory references at each call site.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build        |   3 ++
 hw/riscv/rpmi-fdt-stub.c    |  16 ++++++
 hw/riscv/rpmi-fdt.c         | 103 ++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h |  30 +++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 hw/riscv/rpmi-fdt-stub.c
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/riscv/rpmi-fdt.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 0d82ceacc4..87601f8523 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -4,6 +4,9 @@ riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_RPMI',
+             if_true: files('rpmi-fdt.c'),
+             if_false: files('rpmi-fdt-stub.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
diff --git a/hw/riscv/rpmi-fdt-stub.c b/hw/riscv/rpmi-fdt-stub.c
new file mode 100644
index 0000000000..9866236ab3
--- /dev/null
+++ b/hw/riscv/rpmi-fdt-stub.c
@@ -0,0 +1,16 @@
+/*
+ * RISC-V RPMI device-tree helper stubs.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/riscv/rpmi-fdt.h"
+
+void riscv_rpmi_fdt_add_mbox(void *fdt G_GNUC_UNUSED,
+                             const RiscvRpmiFdtMboxConfig *cfg G_GNUC_UNUSED,
+                             uint32_t *phandle G_GNUC_UNUSED,
+                             uint32_t *mbox_handle G_GNUC_UNUSED)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
new file mode 100644
index 0000000000..439c91c894
--- /dev/null
+++ b/hw/riscv/rpmi-fdt.c
@@ -0,0 +1,103 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI device-tree helpers
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "hw/riscv/rpmi-fdt.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "system/device_tree.h"
+
+void riscv_rpmi_fdt_add_mbox(void *fdt,
+                             const RiscvRpmiFdtMboxConfig *cfg,
+                             uint32_t *phandle,
+                             uint32_t *mbox_handle)
+{
+    g_autofree char *name = NULL;
+    hwaddr a2p_req_base, p2a_ack_base, p2a_req_base, a2p_ack_base;
+    static const char * const regnames_all[RPMI_ALL_NUM_REGS] = {
+        "a2p-req", "p2a-ack", "p2a-req", "a2p-ack", "a2p-doorbell"
+    };
+    static const char * const regnames_a2p[RPMI_A2P_NUM_REGS] = {
+        "a2p-req", "p2a-ack", "a2p-doorbell"
+    };
+
+    a2p_req_base = cfg->shmem_base;
+    p2a_ack_base = a2p_req_base + cfg->a2p_req_size;
+    p2a_req_base = p2a_ack_base + cfg->a2p_req_size;
+    a2p_ack_base = p2a_req_base + cfg->p2a_req_size;
+
+    *mbox_handle = (*phandle)++;
+    name = g_strdup_printf("/soc/mailbox@%" HWADDR_PRIx, cfg->shmem_base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,rpmi-shmem-mbox");
+    qemu_fdt_setprop_cell(fdt, name, "riscv,slot-size", RPMI_QUEUE_SLOT_SIZE);
+    qemu_fdt_setprop_cell(fdt, name, "#mbox-cells", 1);
+
+    if (cfg->p2a_req_size) {
+        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
+                                      (char **)&regnames_all,
+                                      ARRAY_SIZE(regnames_all));
+        qemu_fdt_setprop_cells(fdt, name, "reg",
+            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_req_base >> 32), (uint32_t)p2a_req_base,
+            0x0, cfg->p2a_req_size,
+            (uint32_t)(a2p_ack_base >> 32), (uint32_t)a2p_ack_base,
+            0x0, cfg->p2a_req_size,
+            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
+            0x0, cfg->doorbell_size);
+    } else {
+        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
+                                      (char **)&regnames_a2p,
+                                      ARRAY_SIZE(regnames_a2p));
+        qemu_fdt_setprop_cells(fdt, name, "reg",
+            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
+            0x0, cfg->doorbell_size);
+    }
+
+    qemu_fdt_setprop_cells(fdt, name, "phandle", *mbox_handle);
+}
+
+void riscv_rpmi_fdt_add_service(void *fdt, hwaddr shmem_base,
+                                const char *node_name,
+                                const char *compatible,
+                                uint32_t mbox_handle,
+                                uint32_t service_group,
+                                bool has_mpxy_channel,
+                                uint32_t mpxy_channel)
+{
+    g_autofree char *name = g_strdup_printf("/soc/mailbox@%" HWADDR_PRIx "/%s",
+                                            shmem_base, node_name);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
+    qemu_fdt_setprop_cells(fdt, name, "mboxes", mbox_handle, service_group);
+    if (has_mpxy_channel) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,sbi-mpxy-channel-id",
+                              mpxy_channel);
+    }
+}
+
+void riscv_rpmi_fdt_add_service_node(void *fdt, hwaddr shmem_base,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle)
+{
+    riscv_rpmi_fdt_add_service(fdt, shmem_base, service->node_name,
+                               service->compatible, mbox_handle,
+                               service->service_group,
+                               service->has_mpxy_channel,
+                               service->mpxy_channel);
+}
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
new file mode 100644
index 0000000000..b157bda1d1
--- /dev/null
+++ b/include/hw/riscv/rpmi-fdt.h
@@ -0,0 +1,30 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI device-tree helpers
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef HW_RISCV_RPMI_FDT_H
+#define HW_RISCV_RPMI_FDT_H
+
+#include "exec/hwaddr.h"
+#include "hw/misc/riscv_rpmi.h"
+
+typedef struct RiscvRpmiFdtMboxConfig {
+    hwaddr shmem_base;
+    hwaddr doorbell_base;
+    uint32_t a2p_req_size;
+    uint32_t p2a_req_size;
+    uint32_t doorbell_size;
+} RiscvRpmiFdtMboxConfig;
+
+void riscv_rpmi_fdt_add_mbox(void *fdt,
+                             const RiscvRpmiFdtMboxConfig *cfg,
+                             uint32_t *phandle,
+                             uint32_t *mbox_handle);
+
+#endif
-- 
2.43.0


