Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AA606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e3Xj4Z/G;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QJKiNCgJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTCT-0004fR-Et; Wed, 04 Nov 2026 00:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCQ-0004ZE-Gj
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCO-0002Bt-Fc
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:14 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40R25r1248035
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u2Qed8bktRK
 llKwFEC/Yl+Whk92hbfUNGOlH2d3s+ck=; b=e3Xj4Z/GwrSIi2G6JFVfE6VCiTy
 jgRMOaa6JttTtyJZxVl9bvqzzILbFTb/W6dcTzVME2nrG3Is5hiOMoNaH5vHHezp
 TBSv/KEanpDL7BiujG+zMLGqMsrRk0ev0moyC9a1Rp8WTcC3u5De21/wyKHvK/SA
 dXq+rVCkTHgAgCr1cx2LylB8UowmPhVxNyNY9r1J7rJuP0Y/x7Mj7xTQr5/+PN4M
 U3DafMpOK2bS9/Xo6Jt5CY+jxHrBQVuaW/Bwq1v7mWBPIrex/FziiIJAxUrqQlXT
 dkxsvXpbwABQzSeC6DwSAhsz4VAPvUcv1pDB2mWiWeew6FxW8+mc4vx5sbA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuv9kw0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a6f57c066so47118eec.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768770; x=1794373570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2Qed8bktRKllKwFEC/Yl+Whk92hbfUNGOlH2d3s+ck=;
 b=QJKiNCgJz4ul8cMKT/x41iE2iO2lB7rGz5jcx69dCeGMOJL7lhklIYrYI5yuIIWAwg
 BMyLjbnTWj4FuSPkkXBiQmXNE0X3z6/BUhaw/QWcvOv9aWbG/q15MBCSO6jvG+kRaI0U
 6b08G+vCFaaabNY6uT7vMZOa8Z5YzaJblZmh7YIH9WdDE0VqjIbd9L97HBm9EFbbo7cN
 2E4Qm+Qk6UArhaDdh52QQpCEMhcMKXRJ6N5A6miqcndGULhRrdyTRHDbGWEwwo0c4Uxm
 A8HO3f/r2rpEFsCJdtmFajFutEZT/jov3iE2vUTdOnNX/KiyGtLzIRAnmizozRGwt0kW
 3ZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768770; x=1794373570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u2Qed8bktRKllKwFEC/Yl+Whk92hbfUNGOlH2d3s+ck=;
 b=tsGCCv+S7IigA74RcdfOVipKDFsI5GsSBLTiB8RdWrZdtwqsZlMRlEj7Rwa+asVQcR
 XOGDyPEwnwJhfu7Vi7KpZp0tFhxZSIPg5qtHgXNoV+Btjnw18WYb5pRAiFdXguFcB4i8
 8PWXwchDl8laSosRgowcJDgDOz7rWkPcUYAhUDjd32yM4tFqKhbigexrHsf3iP0Y40gw
 K4fkIiLOoA3WGgKcKSTLd8ritz7DnAEIYXTiIT2s8v2OSl9jH6U0xmbJdLA4j/LxmWDd
 ppCxe1XbsMuSzPphpewqHUJl9cy2Z36Z4XSyxx+TW937mexzLOg0r7U2OhFF17qBHfI1
 Jgzw==
X-Gm-Message-State: APuU4Z+4YGaUSSByrwdD1MuHW4t84efyYd6IMkNkdbF4FYIKRdDsS7Dv
 ZT0J5nG1tM2WAhaeu26Hgyi5u5py67ZgGUQOEK0auQ03pXKux4Lbn+leNAAu1EMkYPmcO5/jw0M
 1rwVbHgSSk52Y1I8TUU1V6pQRKrh5Im6LWBJUaXFoUnEu5NcK6IQJpebp9kr7eeqC0g==
X-Gm-Gg: AYBFou0JpPXtycfktegOpSiV1fE8yuCgoMSoIoJO5s4/AJq9Gl5gPHSxIf/JeKKpEyu
 m4GnnzeFMfAAOI1JqmJ04pUQS41IBU4XE7x715wimt96tFy3peBFT+FcHgEBVSblBrV7leguXJp
 S+nhdRhjW/33bBGPdKRaEwhTJTFLOjmJl65HfKrmyctO+AIl2VDJRjxSv5dlm4ScBB+aC5AxxKF
 s98vIvrLUtevnzPIM5Tp5Se068+9wK9CDaAJkpTCVrCETThr+X6Ta4jklsIzloN8anbe8U3SacL
 tZ9GclViUijSFd+pqGkbrGQ7NnXYrB02A01B/I3XuQ908YK4ud3Of7cqAYdggwXmiAa5y2oJ683
 M+Vg9BMbd/hbduoQmfwV000X17xdp4v+qFVpFHiYizTe0JT5inmXDb97VD446MbIMqKu0IUoIPI
 t6A3fzz58o7gaZfgNoXe8P8iltbB5CuQ54B+7Y2Z/leACBNyG1FncavLAe4esrxl4n8cKlSUUmY
 U/qAWON
X-Received: by 2002:a05:7300:cb88:b0:36c:a1bc:6115 with SMTP id
 5a478bee46e88-36ca1bc6a73mr4486859eec.0.1793768770001; 
 Tue, 03 Nov 2026 21:06:10 -0800 (PST)
X-Received: by 2002:a05:7300:cb88:b0:36c:a1bc:6115 with SMTP id
 5a478bee46e88-36ca1bc6a73mr4486793eec.0.1793768769177; 
 Tue, 03 Nov 2026 21:06:09 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:08 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v14 03/10] hw/riscv: add RPMI FDT helpers
Date: Wed,  4 Nov 2026 10:33:16 +0530
Message-ID: <20261104050324.733555-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aeabd42 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=WNJofZAcfibaGo0vQRIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 1jWjzEnRoTAp6wn5AZqRJjNIdlI4OwH_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX6fs9t+a1Kfxb
 /txjGOrtT/L7qzVZGiuNyirAMLOGquVsn3a87aAickG6Rs7Z2G84AANS+SaRHmz6ZVXoLsWNbF3
 /Kq/Gf7eJ+wBEFI9pLBllas8LH+4q5w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX68JX2ArLTL82
 DeMAgfgXciNlOUhjFCRk2Rah4zAIoWLKbDdWqjqVpSKJY+pRciy5HH75C4WluCt7+igmEyQF4Ev
 VngTPT+B20QtEeJKYdmx97h6anNH95HIxtXzWbRZ4kZBMmMuvvwOZTqY/Fr3pCZIspkShuKDN4W
 ZGjihocGKHlVmIViIbQbyWj9WJfx5KmP47JVsl+F4aAQKZbMpLs9vELfLCkUc/ucxwSBkcJpbz1
 clJFlu7mJ//DgpOZCReIlvhZ+rqwDjMNAEmp9W0sYEjv2loOd+UFowbCxh11mVBLTid6aS2/LNS
 lLvp8NxzYZ1QMwYbFX0plnf4WIPuYLRHiJTana9bWO/tDAyvlo9wI3geqfeX2E2bI0gK6cd1ERP
 4c5tKXud0hvTVEJZqAD6vGmJ7wHQyzneDyaTQbWvHBmZ5nfcvZnSCu1ZEEgd1TXDVPwYbCjzPI3
 NlwsMMsl/Du/qHLFSug==
X-Proofpoint-GUID: 1jWjzEnRoTAp6wn5AZqRJjNIdlI4OwH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
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

