Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB06C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY1u-0002aK-Oj; Tue, 14 Jul 2026 03:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY1t-0002Zb-5t
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY1r-0003c9-At
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E7YGGM4101711
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tR7Hnu4ouM3
 whMRJ8HksXJ0KwuYzLO9YLeNEosavEDA=; b=gG5xDzhbOKzp+jgDt21f0MgZxp6
 cH50c0y50jHk+/BGmU0GYJBe+8ezIRkke7Doknac5gB+6PaszWziGFhv+ICYi0YU
 QZEBOCueNDuYAbK0bvNUOsaoP0EW+i85bghtsbXtGbPpLvTGUegMpiuZGcM3tOJj
 4Y8rAZx7Iql/LFtRRufRt1yP3PpcmfcWa8YNSRkijLnU2UIsAJdtHwI02lrbLGca
 xVTBaLSJktHI0ozypSWe5tx+ZVMs7XdzBJRXh286/Bl+AUxSBHAi5Ggz0vDeW9wL
 4Tlk2FzUhmpkMJ/AL2A9BF4qszRKkOReK3Jl1LmiyQwU01QQ2O5Kk3mmSCA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudg301-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3883dc4ad23so1484928a91.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784015889; x=1784620689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tR7Hnu4ouM3whMRJ8HksXJ0KwuYzLO9YLeNEosavEDA=;
 b=SPNwYvQZ2Vq0R5iml5Ue7X51C12OkTPZEhXdl9ILYzVgAYvWH4v/6OgHMc55Fl2BFQ
 WUCd881Ox37N9zKVGqqoPGy8Cf85+t+jebuyuwK/BwkUZLcidl7mWOk9O/P3tLElmzQN
 mlD1xtWVeC/nz/BLgNdMA4CE9qnjQs8NP5MGxBCH31HYBjEJQtOpOJMjPytO83tnERg9
 qggQCVbOJM/bTxTvUYRHYZ7MqCZN60CCV3W+VdF7VPSIdc6cVmlLzFpXeYdIQd0/OSEC
 O+uy2ja+Qq5MaaoUL+pymokOvIea7Uk3V+HZCu84UuBJJgnPeWpTs4ED5LRaoCTSsaTg
 9f5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015889; x=1784620689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tR7Hnu4ouM3whMRJ8HksXJ0KwuYzLO9YLeNEosavEDA=;
 b=qNRdi+gbWRElYFA7r6w17X7nEkdFjyJ7nx+fxGYA1IRn5ZdrLm2U+un9zKb3Btcg1i
 PmzAF9zeZ8NnIPlfVFsAxk5GKOy9qZ/1VIWK1UYIy+CsL6qP8binS9jrpAlfLkxLot9t
 v6aIYvtN4J//HS8gM70YNtCKK7pXgbtnNRfJSfqbZv8mamUMUjS8iHvleGcEJo0hcyak
 NvzqPmE2gmiq4tKBQ92P/pVzWrznnl5DCK9H4n4g2sF6o1oNKxGK294+70U93EyDlk7R
 BTWmVhgno6tu5kD7tAAEwPfwIChLE0P7lc9EE7eqw0qLoCiy3aA8x7Cm4BSmgNnyNbS6
 NDfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBgkhpX/IpL81YjMwb/yQZ6vVm2oF2IuaLJCySjm1QT8AboYdfLSjLuhcRP+USZKf8/u6w/Fq/XW1+@nongnu.org
X-Gm-Message-State: AOJu0YyJ0e0q9DXmnIgWYLAP74DAgr/AVffSgVJVFH45xnCH2vn03Cpn
 4M4NpmILztwZ2/I6ovp4CIaLlR++T6ACk+0VbPbceMxNBtJ6e8PLn9z3vzGpRkfxbwkO6ZNkhCq
 K2Veln+T+rEcVcjMxjnvDbFvR2uJCib5TrD6vixd7SXdvyaxwo5OgTjkMWw==
X-Gm-Gg: AfdE7clF5SYBGSgY8JKVCT8Kr1vfn5nVaLIAGDTiMzdA/6A/dlwn4t8F8DDcXkaZQki
 HR1hFUJHqvY7Om9ruTZnEdFJNHdMtUWI8wOzl4Pak1tEEVz0TaiMNg0RwnhlyBLHnpTjXizAYr4
 VYcuL6odD5493rGZaHCDOlmFezgN4R/VnykIY/0+LrwIX02FU51pqwDe6GrAyaJ9TfFU/lqZmRe
 5sYBDQWp9M/cteWHCTk3jiikci+caI7+I/hdMH8sbr/7mAkQDMTQb9s5NgGp4kZGw2lHuQZfzoc
 kB4opoaE6m+SoTlzjEeyB6rTLoJeOYM2R0mM+vEBELy258aYis71XQ8q66TdsxapNXIbeB3DQGH
 uTKaabBVFOaMzFSNNs5xgsTY3sSyD4ytLF+iQ2qMJI3Y1OnKf5Ub9fxUrzxN/sA7dcOGYmPU6wr
 th026C/280A+qFaLSg2xdIkw8UgdxWLN86V0Jz1oANvA==
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38dc760604fmr8906827a91.0.1784015889325; 
 Tue, 14 Jul 2026 00:58:09 -0700 (PDT)
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38dc760604fmr8906814a91.0.1784015888829; 
 Tue, 14 Jul 2026 00:58:08 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm55606355eec.8.2026.07.14.00.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:58:08 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v3 03/10] hw/riscv: add RPMI FDT helpers
Date: Tue, 14 Jul 2026 13:26:52 +0530
Message-ID: <20260714075659.2258023-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o_C6nX27AROKEb3-ZZLUwZZ_AE3vxWxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MSBTYWx0ZWRfX/7c3Dmhmu6w1
 MGSozVW7v7lwZozgacboXvM0g1bT0nEEVPjcoQBhVn6run+jxX/sQ/FVWbScQZAoo19bmRjri1G
 yrQ4lOtlVQpVx3pvdND4va8iEo6NYxlPrRcRbiiYjYhJADk2GLobm1H8ipTYfBZYRtkNNDZeU50
 Z3w/Gpz2tO5NEWMFvR7+LL9Ba8uXAHjv+ekCCjwkskF3Is/ipZADFiqMGf8GJ8W5ktCes7bburx
 9hvBIkpt1KqVnsTkOF/VjXD8Ns8JBm3Qc62xJXbXQ/s95uJqfD6wjf+BTJaQV1JJsyN/0gjWY2B
 BvqrRyQcTpkgyBWHYFz7HOLDtyXpVHY+j10lWxScaqtLgI/x9nHR9H6Gwm9vcNpoUOnnbswb+kC
 1FfD8XlzZEpBzxQ9iGlunlCrOLBZL+/X016MgRSSuSMa/HPwUxgpq3n/y/C2qqYGPuB94qnJ54d
 BtPJIYVTzPBG3fltsaw==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a55ec12 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MSBTYWx0ZWRfXzGINx5bSbzai
 7Hn94INpkpo9rhlPOyB1TpkeIGHiyNP34iyE9yfQi8wn2+Vop8ojwOxgf2SepHmQV4pY+wM2GSv
 +fnYt/1QOGV51lsMTGR6VJrAUSCv+ZM=
X-Proofpoint-ORIG-GUID: o_C6nX27AROKEb3-ZZLUwZZ_AE3vxWxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140081
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
---
 hw/riscv/meson.build        |   1 +
 hw/riscv/rpmi-fdt.c         | 103 ++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h |  30 +++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/riscv/rpmi-fdt.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b70a054579..529ec273fd 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -3,6 +3,7 @@ riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(files('rpmi-fdt.c'))
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


