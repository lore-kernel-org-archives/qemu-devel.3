Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AjC6u4Sy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EDEOEFju
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmCI-0002lX-PX; Fri, 13 Nov 2026 02:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCD-0002jZ-Ja
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCB-0000Ca-OL
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:41 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD57f2C3120446
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+RI08oxs8WS
 znS4O0TxolmEOUBBksBccu2yfjOuYCcQ=; b=AjC6u4SytKK8n+8PgeVCMYVHCxy
 CeAy14GB8hOPGLSxg4MAPMBfojWQgUiGpBR6ijCMVPGkPmNwfnvcU97z5icidRCP
 doJ2s/LFTHqtrnX/F4Pk9+eeTGkydJY4VhMtyjUR+RasFkkVwJAYE9w09Pwbnbec
 E/w/phMvJYLzrVibpZYF5G48UNfSEOPp4d5wwXJ1fsm3ery329F2NgOTXfB2OVeS
 1u+CfZyBCCM0ld6X8nRhCNa8jz1q9mLc0yNs76X4gfPGpGZ5EaRCwOka28HNzbRl
 cFeZaUVrPLj5T0tPNbJXX7WCnYNiLQad8NdFbZ4pX0OSCf0EWHughJr5o1Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwa3cv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-339628f2bbaso90345eec.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 23:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556778; x=1795161578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+RI08oxs8WSznS4O0TxolmEOUBBksBccu2yfjOuYCcQ=;
 b=EDEOEFjuAWREgvsZ5l4lzD6HjFG47h7bCqSruNlxNdb6pZGalpG3QqYUhlsZ9BTJgt
 e/zGstsZXzZs0U12L/eAOIx/K2b6+1p6sjuyvFT2x6FD3+YX1GY2UfwYHXRmZ/A4wrpv
 8IrbLP4NUecaBa1d+wGkZv5PluV6g8vlY8Ppjru99P9nSy2dG2w4o+H5vnLHbqnnh+Yx
 a206dR0HoC+Y1XGzCcYEX4uqQ1WM7shdlNjZJjp4C4BJjdhkJQ2cThJs/X/xPVDZj2e3
 vPs8buCNIidlCkQGCtQsgDpz0e53L+P0V1+MFKv02tAvvHSHtIK89gSsW47/PrLY6El4
 Rs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556778; x=1795161578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+RI08oxs8WSznS4O0TxolmEOUBBksBccu2yfjOuYCcQ=;
 b=eU6f7c20aqQMSdnTMCuL5v+GCW9RLU0+YyH+3CVQenrPWQbdk7gAjPKKuW3pRKX5yY
 S9UrsE5fYg451mpkZCLHwHnSZfqxIkeS7zOs+FevDsQuj+AOdEnhHMXIMekhDII0JpDz
 ruRmzQAPBWQnwLHMBa47P6TAR0nHxv34X2vCvDmAdVjpk0/T+INcpiVsBdtkS8kXEjHw
 0uVi14UMFDrbUcBqaooQtvqJSB3DqwNdCIa7UnVhVzHGh2qqrSetVB27jFf5EGnsevs7
 5BQ7et6EHINbvqdQQc6ptzB6nl3A6h1WduH9Z+K9NPsVVS58znCW+72M4NCv6CvNqR/D
 4NjQ==
X-Gm-Message-State: APuU4Z+yrkhApHXUCCUN5xLXDj+5fWsu4U/r4yYMMKSZ4OpJKAI7s1ox
 0QQDpmbGxsdQtGYDjF3atjZ/gtERMspP2DQHlazX/f/Hh/+CQ86LKn6ZkDb4zxXj6abcl5CLXmH
 oCIISaHvecu0vwjRBIDDSs5OIoNFVNtU+tSAItQMmHMeyHG+SHzcHUl6JV356PdOXzg==
X-Gm-Gg: AYBFou1fVzjpvL5cVTTEOgQwkHglUncHPPsial84R5oGWJTkNwQAl3q0jupl9wdQ2Fi
 WOKe0udLwL31hZJVdY6PCYryEbkcnbuZ1i6rLTr83Ja+4QuNOhHtXQUGiPz4J66kM0dpgPKekV1
 uLjrSzG61XuZ2FsgQnAC1KxfITEAW4x8RhgTDqxaU2ddleZUrscaZw9WmmZzkKBA9Jzx6KKsP3K
 XUsmz2g/LZC/PExOrkEUgkajCKex0F8n+wO0b8bmHYsGVrtp/QMfmVRq5zBoBrgkN59vJfHfc3a
 zQWFyo6gRfB2IYozJ+bmrhehpnuMgpphUCToZkmCO0eh+2e0vbDAlJzNnQhj5WZBxV38csRdk0I
 4srkzFay28G5Sa3T/q7gFZ65/oaNmtL61RMo6/M0igB29a7umNH0KG3iALUwp9MX6R3azqEyqHC
 0VXvH1cVT61Ph48wvRq2TbsswHcv0P2VTXfavP3/PooMFHBwNG5pwEm4+8IhDxqjjdiQ3Ta8yFP
 KeztLY=
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-3796038259fmr2344637eec.0.1794556777449; 
 Thu, 12 Nov 2026 23:59:37 -0800 (PST)
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-3796038259fmr2344610eec.0.1794556776755; 
 Thu, 12 Nov 2026 23:59:36 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm5213376eec.1.2026.11.12.23.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:59:36 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v16 03/10] hw/riscv: add RPMI FDT helpers
Date: Fri, 13 Nov 2026 13:28:58 +0530
Message-ID: <20261113075906.715870-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af6c36a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WNJofZAcfibaGo0vQRIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: X629cler_g081LzU7wTvSyQ18vuOVG6-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX+S2rVvH9IXw5
 QOd/yQdLqPbyrOBlH33OjHLL6PfYxbWooAYk4NPvaFqmOhtYU63OSxeLmNlI7rQTOcXOg0EdPUq
 +oUCmAhG1EghkC51fbK6jEXa2wSGzX7QtZYnIxqgVAaVYs5FBMrGnbZ82m5wVigZpS2OWnKR4FE
 MX291kTbKmvwBcFM3zCvDeysSB+xN7bUr2EzvZJHCLZnm9pmGV+g291koV2S7WdsWBx7zOrBye7
 jZzDWI97PDcYJm1NM72BMLk3lB5HMgoFu0m6YzotqYMJXZvKJtA2E7OOUHjhknKCJGOoqku/vf4
 P72O0C3Vv6Sgwx6sXBXm3RXZ3jnbb2sx1HlTCos5twIkqG5QZoAjyyv8/ojlrs8YDyg4GUm00Xh
 LhWrQhcFcKWShAVrRspw/7geUyUwv2J0Q3JZSNkR5Syj50OjyPK4VvZW4lMqGRbXL7jzInfK92z
 byPbEaLe7sWPisLdehA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX9Bpsp88UlOP2
 utFcTO5yumv+wD4S3j4PlepYIlSY3OXEIklB5u8zSp4orlpCAsi0DnxXqi5Ntlx8t1Cu8HGrcfW
 u747XvhhDhgl3xQWecCILnFd459qkDE=
X-Proofpoint-GUID: X629cler_g081LzU7wTvSyQ18vuOVG6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add helper routines for describing RPMI shared-memory mailbox transports
and sibling service nodes in the RISC-V virt device tree.

The helpers keep RPMI node construction in one place so the virt machine
can add service groups without open-coding compatible strings, channel
IDs, interrupts, and shared-memory references at each call site.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build        |  3 ++
 hw/riscv/rpmi-fdt-stub.c    | 24 ++++++++++++
 hw/riscv/rpmi-fdt.c         | 92 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h | 34 +++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 hw/riscv/rpmi-fdt-stub.c
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/riscv/rpmi-fdt.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 6bdabb9544..806ba41e42 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -5,6 +5,9 @@ riscv_ss.add(files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_RPMI',
+             if_true: files('rpmi-fdt.c'),
+             if_false: files('rpmi-fdt-stub.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
diff --git a/hw/riscv/rpmi-fdt-stub.c b/hw/riscv/rpmi-fdt-stub.c
new file mode 100644
index 0000000000..0de006bd47
--- /dev/null
+++ b/hw/riscv/rpmi-fdt-stub.c
@@ -0,0 +1,24 @@
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
+
+void riscv_rpmi_fdt_add_service_node(void *fdt G_GNUC_UNUSED,
+                                     const RiscvRpmiServiceConfig *service
+                                     G_GNUC_UNUSED,
+                                     uint32_t mbox_handle G_GNUC_UNUSED)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
new file mode 100644
index 0000000000..0ca1f69546
--- /dev/null
+++ b/hw/riscv/rpmi-fdt.c
@@ -0,0 +1,92 @@
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
+    uint32_t handle;
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
+    handle = (*phandle)++;
+
+    if (mbox_handle) {
+        *mbox_handle = handle;
+    }
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
+    qemu_fdt_setprop_cells(fdt, name, "phandle", handle);
+}
+
+void riscv_rpmi_fdt_add_service_node(void *fdt,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle)
+{
+    g_autofree char *name = g_strdup_printf("/soc/%s", service->node_name);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", service->compatible);
+    qemu_fdt_setprop_cells(fdt, name, "mboxes", mbox_handle,
+                           service->service_group);
+    if (service->has_mpxy_channel) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,sbi-mpxy-channel-id",
+                              service->mpxy_channel);
+    }
+}
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
new file mode 100644
index 0000000000..e74115108e
--- /dev/null
+++ b/include/hw/riscv/rpmi-fdt.h
@@ -0,0 +1,34 @@
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
+
+typedef struct RiscvRpmiServiceConfig RiscvRpmiServiceConfig;
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
+void riscv_rpmi_fdt_add_service_node(void *fdt,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle);
+
+#endif

