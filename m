Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30F606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i+mJ2VpI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HWYoleA3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR1Rh-00083e-3o; Wed, 11 Nov 2026 01:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1Rf-00083K-Ry
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:04:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1Rd-0000Wm-FR
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:04:31 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KEau863510
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u2Qed8bktRK
 llKwFEC/Yl+Whk92hbfUNGOlH2d3s+ck=; b=i+mJ2VpIXQKuEn2j23XeIy/S+JU
 Yhr7PKawP2bHbbF5Md51uwhPdgiSrnYrKBHJzZ94f3Vw7/WZ7m22bB/rWiTtgD4y
 CqtEjBdFyqEyMrzGTin2b1xNUITAt8qQovybmD0VpWkPqdnVyW4FizwtHwCKmvWh
 mO8wlAJxKRL3bKagMQrxir9gAhzF+bp0tFcnHUE1CAN/rKzMF3KZ6c2Cs1LVf0of
 KPNvvZxK3hQqZFtdH09m/2Jr4lL1Kg6En7uoFixiGee76nTGrU1WYhV5dtLKWFWc
 M0qliXUQnujDM3aWcZLBlFYaSE1smgJHNrYoc1NRDF/F5p0SBSk0cAFMPWw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawgqn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:04:27 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-77f133855b9so7686137.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794377067; x=1794981867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2Qed8bktRKllKwFEC/Yl+Whk92hbfUNGOlH2d3s+ck=;
 b=HWYoleA3hFZuTjC1lgaa950MYHd1FQsNNslbDXiX8jYMH76tMn1b0n3XvEljUezaCr
 EYKptYB/GlcU8mrWogYLBa0gYeHj2eweduGz+s8VeEsqJaoHj4c6srqPfuiM2Hd82FjN
 AfVJ87fAaHxMrY0DK8+44QK/D9U3IC9M/bcc0pkuZ1SJphyL4xJ36bf+X6ITpeRAzAn0
 pTghcV0Wldw9/X/RIgA81UcR5elqMoJs7xJiCrlWyYuNbXJ8fY4eWxwbwAbTRbaV7kVy
 6MCFNx/F2Wsti28na0inz1rf/wAR96HTw1Ad3bnjWq1wTyiMGUWBYr4jyUhSjD0X6pdE
 oWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794377067; x=1794981867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u2Qed8bktRKllKwFEC/Yl+Whk92hbfUNGOlH2d3s+ck=;
 b=2KaqTRprGhSHebXB2MmfRIPD1eqVIRExko2NecjInctZU1JEar4TQsJt7LFxgc3f+l
 hj++HTNdMapnnKbwwJs91FBPsWRv6VabPQiM/PMbAuMLnul6dG5pBR1KgbkX8YNrHapb
 EYLIEDOHH0p6mPROIKuS8xjw2qF7MsxIfhZD+qMjFnDs+DJZxSF3fY5knGYMkCPfLXVv
 QlElic5KNiM+Tw5tszZOp3xpeWXzT2hW91zACsDOlrqaQYJ62gpsDB2eOxZJ2kvQ96UF
 i2RanFxxZmsX6FUZCZ+bIVsVlQQjDeM1UGg61A51hpVRYS/vVWzzgJgfBQcR78X7PmuW
 TUkw==
X-Gm-Message-State: APuU4Z8VtYfnPSxI3+QwNprXO4a7LMzOsWqELvVoKN1P0cqUzoQ0Adud
 x9M3SCiwBn6B5e5jIfz5gIp8/0OZpF5XOroWvpzwQ7I4wmhQxoEya1YHCyHG22R8mxvsn7yiH+t
 lggNeTejZC5BK67gyvwIbqU+setnVKEsKZKDGXb8a0g06MyXXj7n3ombgfze50XDlcg==
X-Gm-Gg: AYBFou3QRiZaZbYP9Ui8fwaThDZSDipKvK/iMQipkFT3jMI0DHhS+oj6BEXcnWu0Ftc
 dFz71TnvcRkM2d7NIdxEABHmenQB28sg7wMmjBpYR93nsbrNhfZCr9ScAq/tZODrDthRWuJCpqg
 HunQSZJr3JtSCrS/VFMGuZo0QohI0EXmT5M/srvcLNHLjZ/90AfsoQnKJl2Y9W5aMvzHTD/MAR3
 L7j2bbMR35j8qk6F7/pyoV4WpMVSKQSue3kmLUUMSV+rV1KdQVOU/rp2BdSmlqEnbiq+O86Bzh3
 iy6OE7Ty/D403acVo+aa1ByG4Krerm8LJ0EJXKG+XFqj5nH9RcEJl9NzUUUGb7ISm2Vm4g+mEM1
 WcoxsKiGA5qlJvL1IWZJv+rk4N1ST4vjd3/wYuB8NCydvTUrJvkNlD1J+pOWraWjPN6YjPzc8iT
 cy38cmyBLNrZWeKvDMKMrxtAV1FcTet8Yg43EZ6HeyPBPUOWzfYfMv3Mzbx3DeleC25ttyPe2y3
 199tsQ=
X-Received: by 2002:a05:6102:6218:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d4ede113d2mr457315137.1.1794377066646; 
 Tue, 10 Nov 2026 22:04:26 -0800 (PST)
X-Received: by 2002:a05:6102:6218:20b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7d4ede113d2mr457283137.1.1794377065918; 
 Tue, 10 Nov 2026 22:04:25 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b2ff3bsm15067990c88.11.2026.11.10.22.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:04:25 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v15 03/10] hw/riscv: add RPMI FDT helpers
Date: Wed, 11 Nov 2026 11:33:55 +0530
Message-ID: <20261111060403.3777501-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyMyBTYWx0ZWRfX2brJq8gg6pLZ
 1MxWDoWOtrMDQepBHkQ11FQUsrL8xyQIl7VDo03pHN+YUwzbJMDWGh3JadhhX43YUuIGN8JryTy
 LS9ypi4UQiBLYKwYLhYMdD4x9XfecXU=
X-Proofpoint-ORIG-GUID: VLSkgeJTB_Yvify4wPiCm2i90LfY1FIj
X-Proofpoint-GUID: VLSkgeJTB_Yvify4wPiCm2i90LfY1FIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyMyBTYWx0ZWRfX04N+lsFAOKbF
 LM4lhCIRveVNjSPxyvmNyVvzuHL/M/iO6Lb05q4KJD6lJ7uxiHiUoOuV3cQXdJS2Hv1KBfxfQU+
 oallvduah17+8ZU/QBaZ6yM6leQi9LS+NTG1WUICchZRK9N/XFIdDLrv8UjUPRMr50RPatdzSzU
 Ktur4jPf6xuxj6pGJt3ZZlinj5cFhWBFk80u++/7ue9HV6yeT4VhqVHg+pl33M9CRtHJTJI+VSq
 +QINJZE6R+UlePCVcRgyZ3DZtePO/T72s1XH7OkPJDmC46UJCHclsMxLQOWcniS5q700tTK2HBC
 QpjW4TglIM4x5qQIt8G3Kul/SJzN9dxL9InplqJWD30DE3SV2cLuEwpWfVbrlb24X6SUBg6hC0+
 Xut7sJZTQty8r7S+8YAELp+b4U5UA/Tmy/qf2gBxj4u7Fb03Z91JpMWpnrkA21aPekrYntc8UHF
 YE9yUgOuBWm/dT6/bxg==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4056b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=WNJofZAcfibaGo0vQRIA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110023
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
 hw/riscv/rpmi-fdt-stub.c    | 24 ++++++++++
 hw/riscv/rpmi-fdt.c         | 92 +++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h | 34 ++++++++++++++
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

