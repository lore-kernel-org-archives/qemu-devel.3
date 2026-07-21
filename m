Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE6BC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm46W-0002Wa-8v; Tue, 21 Jul 2026 02:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wm46A-0002Dk-CB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:37:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wm468-0004RZ-Hs
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:37:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L6GQgY3980888
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 06:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u2inny1kyHj
 ix+ilOuGF76rFjWqbyjoEgMiN6LdTVuU=; b=m8A+BFKsd+52lCLVpBXCc1nTdGw
 2h8EhYGNrXf+VnbGLHXLEksPaiWpF5HDeDT8SXvGAD4gI38+raO8xcK4csfsWLtn
 VSGPc19yh1p5KpjQgLrSuXsw9lL/qm1Rdv6DhKt9lp97g4k76Syw1jYVHdNHAyW8
 TxOGwwO0T7sFk0zFdpsrDI+SeI6b1YZjMIU9VzWoaB8GxJO6McKPYp3js8LKIZW/
 8TY1mOsAs6pRjqLM62Yop5qUZe5YdoxRBaPYMUPQlpJxmGmpLrJ71QXIVThxkkXy
 ewFU3W/g0FRO0iFbzTq0NbgMVa/VXuTJm+k8G/W6yJlNBynRvgkJFj81B6w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv42t0q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 06:36:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ce756aa72eso52783925ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784615818; x=1785220618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2inny1kyHjix+ilOuGF76rFjWqbyjoEgMiN6LdTVuU=;
 b=jyfL24lZNC9dU8/fhv7+Vu6ZBCox3Abq0p35zQtvpHjv1WqnXU+lCt6ZE9GHc4XCG3
 h9cuSKKvtxH1GtMWVtjCuzgGQyolCdbgiqUVfXzssKkSoZvjmtR2F+sgesCxs6xUDMhw
 O68SvOejbE2igvdYlxhcn1jYSlA4uP/ynxHi8CHOAlBecFn/iA4Wt97KgYQtY6kk3cgH
 Bm9OsHN4jIVHydJDbdDo2ioM7BKG90UVjmOPn6F2+Vbp8PmuicBOB81humzW1kfDEPLW
 jNSEDvgStNgMysq18wP86IW+fNANXmnVf7q4aYZ1/0uMMLbOFjKVt7rQfTZ/85NC860+
 b+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784615818; x=1785220618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u2inny1kyHjix+ilOuGF76rFjWqbyjoEgMiN6LdTVuU=;
 b=aHG/iV2AJ1xXcB90S0hmo2LUqOC/GQ6bgTuI7LZ5As/tIUB3ClpbjwhyCZx1oQcU1U
 EMGn/i8fNgYCqDkwKTjspYmOYEGa6hl4CmMh/bu/nzziNK+Kr0EJnEJwbfvTHVkpC1DU
 2oLo0jHvUcuGTuPGWCjBi9FX0GMy8Z1SbeEclE1nIMvCuLdCYIpPQfQ1s6UayUJ5L2cc
 oIwOsKV70PPedvpyjYUOWCxh2UvwB6TjetDN8jVIy+CD4+vncdu0lsxcDVbRj3/IjLza
 NKci8LGwblpujq43bhhEhBkHbdDLLvA3CTgLaIwn/k3Fc8cJoRSjfERcFMdAnDO0+0WZ
 LJEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RowEioDqFKxVzGK+2f5WUsCviT5X/1Amza+vEukwU1B6ckKdpyqRz4F3vA6TtnyE1FpM4cT7UZFU9F/@nongnu.org
X-Gm-Message-State: AOJu0YxxUSo5yDoRX/q1vDsFZ0N0z7wPA+HY83RPUaUaGdBLvReWtcOW
 UebcIZrYTH5nfcxyHhrix9R6tSOoX5lotJa1JS8bYgVZJ+CfvZ0p+2trfeBaeXGeK8d34BxVTUF
 ElbOOWMT+xzKiEEqXO3T02RrRvNm66KJxulBaAeXP2f6uWAQI1vn1yF93hg==
X-Gm-Gg: AR+sD11PMtXFhWNBGamz7OTFyZi7eIqjg5lWCVIyy6gNS1mYPc+XPUGT2jYSE4OwAMY
 iV+YgeVJcm2Rmmmk3fzDPfz0a4b86M9dtrmWSEYBC4M2fOTN4MVSH94chO7StT8PZdhFV0ARit7
 QcAL8afR+HmHxUhzvCxVupjF1tmZ9q6FlcvHRPzkjK0Y69LfuejajpfrcdmVs1BB2P6rdaUe6pQ
 LHD2T/0JXXfZuZwJFZPi+wbrWavcWI//JnE0VeD6X7s1XnGAP4GAQmOQr2SLDrICTJtVDEvB1sx
 AilB2GVJ3NwGjUg1DG/6adbmbQnqsQp5/WYpGuhsisYGn2S4sskpjrrGfhUZlksuD1ep8VJ3tzT
 ocjlYgF6AAbYga/nb/9nYm1xvkgEtyhCH33NMDjOHfFu2TDAtCWFZbA+Ur40uctIE6ryqFeuxqH
 Aup3RhgeOn/Qt0XoaZDCv5hQ1IK/EkfmQ=
X-Received: by 2002:a17:903:230d:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2cf8017d572mr16453875ad.0.1784615818502; 
 Mon, 20 Jul 2026 23:36:58 -0700 (PDT)
X-Received: by 2002:a17:903:230d:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2cf8017d572mr16453625ad.0.1784615818086; 
 Mon, 20 Jul 2026 23:36:58 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb8a4sm47161380eec.14.2026.07.20.23.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:36:57 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v5 03/10] hw/riscv: add RPMI FDT helpers
Date: Tue, 21 Jul 2026 12:06:29 +0530
Message-ID: <025da435c6b7097161342724a6e1ba7e85b64258.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WhAjiZrr2rtFRFm4PT9-uGglfDYRL-Oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NyBTYWx0ZWRfXy5rX2ABuutuu
 FNWhW04TrmrzSrEf5ECF1PBR3yPOTqhIL3H84rLina4/bzoxnF1pYVV83M7QVe4xpyyM7AEDg+0
 D5HUQS5C78nz2tzA7ooB1Trb+NXOfy5WFADrsh9Xwh6ysAhf6QgQcNTtkJN33ppC70VZf087k6j
 37x1yhP1pRhqd3bPlw5ouGqOc41JVMCB60j/F6JzndmGWZosV+iItJXDyaBZe1/Th1rGVx2DCCI
 BVrqJGjR62d4zFkge1obyjCUCqNrMLBm4735ObjlxCWfrVjVmZjbjTQ4LgokTgtc5+cgmVq2ozR
 bj7nNTyLnbijbZCqTN6AHZwpes4bwftJFuMBeiyOmLdiemiE7EuHX9gElbxnHRjB2yn5wbZE8iM
 waFMrtgd+zVwbG5XiWls64isrDF7spdm9PqREwRR8QNXv56BPXtwuF0qy2NSvxQbXo3v5DXCdo5
 gvWMM164XLZ+Y7foG7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NyBTYWx0ZWRfXzgv+OVt1Yfrk
 5/M+/3mE2ePOsZJeF7Ei5Wn0GPRoJNUPzyYGqSRbAy3yIOOjERcdf+fHtxC1F+DdcwQIvHsrv0V
 YDX9elrmsKjZHOoombJ//2BNYsuXMT4=
X-Authority-Analysis: v=2.4 cv=daawG3Xe c=1 sm=1 tr=0 ts=6a5f138b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: WhAjiZrr2rtFRFm4PT9-uGglfDYRL-Oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Add helper routines for describing RPMI shared-memory mailbox transports
and service child nodes in the RISC-V virt device tree.

The helpers keep RPMI node construction in one place so the virt machine
can add service groups without open-coding compatible strings, channel
IDs, interrupts, and shared-memory references at each call site.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build        |   1 +
 hw/riscv/rpmi-fdt.c         | 103 ++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h |  30 +++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/riscv/rpmi-fdt.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b70a054579..ae69426eb1 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -3,6 +3,7 @@ riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: files('rpmi-fdt.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
new file mode 100644
index 0000000000..b2b3daea1c
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
index 0000000000..f053ae5d57
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


