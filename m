Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E064C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEl-0006Wo-75; Fri, 10 Jul 2026 08:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lI-0000N6-CZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:26:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lG-00049E-Ge
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:26:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nTeK3848810
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rwYttTklyBm
 b0/sgxTdmL/5MMEOv8D6OvnpWrhkNgjY=; b=CBKwbpIW9sxcFFxBXLAUfRa+9PZ
 Sdt5B+pR03qOBa4nz5r9nze3+B2qjbf15HB8fO8dh6I/qvHSdc9RIPO3fxEAt36+
 Cak55PNZ2LIQkbKYgYjjv6KZXcXryxy+4KC4AFvQkyZINRdKSD/00gXMrEWgFaoy
 SlGvGKgAr/Xk0ij8mctJIArGUvXXnNg+3WPOjrZu0mHMYes1tkGipqINUVvibNrI
 fRov7EolNa9b7J2RRx6WaGkOZFsXE15i7jyOiBcCdK3WrO2nuFZKBKJSozJd0ssM
 KnTe2MjoT1PZ+ZhnlxtRU+ETRD9LlGNWZxhfZByRdV3JRaUz2pxk9gT6CnA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeestu8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccbdbeffb9so1678505ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661212; x=1784266012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rwYttTklyBmb0/sgxTdmL/5MMEOv8D6OvnpWrhkNgjY=;
 b=P1Ya1UqYHTfz/quBvSkwIW707r64GE6Ro50baaLz7hyB/5p2Nx4WuWLnZSoGS1E0/G
 ecVzeukz2KB5+/PxQ5Voxh+q2lQ5J79TQp6d/OMTdB/glE9Hk1CRp3edjjrU9CSCFUQq
 kRd0cH+PQuepw9jqHCZAxYzzP/DbOgCp0adRd+b2WFxQ1jD1Q/cIoYGmPNoRKbRDJ2l6
 AX6aeoQmB01u5HcjcAAD5A66RYQ7jKqcGGuKM85hOx0i+XNaoF1WOYEoCEAjzsIM2tLk
 UMHMGoBogZtDF73970yAfXY+G3G87r5Yeh0iQCo13orIJk244xoKUcvjpfcYX1+RGV8I
 lcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661212; x=1784266012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rwYttTklyBmb0/sgxTdmL/5MMEOv8D6OvnpWrhkNgjY=;
 b=CshYZzgJ7beQ5552jpHNHfxI2B/5FhtgQrhu9+6MCuyV7z4IC/9DQcwWcjKUZfr5Lq
 +/ZLRrX2g016ofrlY0p+ibICQTFcCfZ1EWITnk2FGYfg0cHLw5AG+4l56xEHiqXyxUtS
 aCeDhV9rXcuADUPJ9zqd0a8/ohe4PWs6q6rTWhwxtmhohDxYtACQm4yNjHUTTZ8c2RhH
 FkO4PPGiK0ftz7l9x9XJj01r9i2eb8+gK078+8fLfxlGgMuOK2bs7UrT8cBkRp2jMaJx
 Glo1Fqabs1mjmzOGCWTYNXhs7UZndegseXZ99qqBZE3sYPweqCjImR8Um/Sm1DIdx60n
 2ZgQ==
X-Gm-Message-State: AOJu0YxSqtr6FH9rKAtz0QzDGBhrmOhBDkOxchvC0RvuBLj/Z+oyIHIL
 QJrPZVqvJtDd9rdAb9B7HVkIhXyAt7nMOHftX3Ss148i2TmemkjlSWrSWhgDb8hZBRkkTHba7O0
 H+m5ENtp8cwhfS11CU5m0iAknC2jQZo3sEdcnHV75svCRav9tf9nnm5VDBgFI3XlYAA==
X-Gm-Gg: AfdE7ckCcE9nnX4+hxzJ14TAJfW8r7Gi3+fsohL1dAgi2+OtnNvPN/+f6WwFp2ZZjv4
 0glDwXw/t8ReGLhO4iWPjh46KZlPFOLMuGv5uTtvmBTuPebPnIwkcXp3ghcGbUFrriWzs2B13iv
 ZAP6FdAf/QM+4E0OeQvxRVasYpvW83YBzR+BhjOD2gOVZGFcppclJOe5JuteJ0+PCqolubbpg6G
 uurVRi+BW43mhVqHiGjuxWKrfpxWX1Fl5c1B9WDIyDmY9+MyiMRooBJXZ4cKAkV1spthCjNmUOu
 rSs5Icwl8p7k+DtwSvQ3DShfNQeqfNptZwupyrIZZz6d7zheY9TsVNtrBOGa+pHeGV4Elg9csLV
 /302kFrfv/nk5uVwvPIy7wVGhiEGy/ccZnmboRPdqygIBnq7RTpeOxxaTMU2v2ld0s1dHvRwh4P
 oQv6pkXZdqK5wEgT1NtM7aLSf/9d20LRBQuft0tKoTzQ==
X-Received: by 2002:a17:902:ce85:b0:2c7:ef84:c58e with SMTP id
 d9443c01a7336-2ccfebc6ddbmr56537385ad.1.1783661211901; 
 Thu, 09 Jul 2026 22:26:51 -0700 (PDT)
X-Received: by 2002:a17:902:ce85:b0:2c7:ef84:c58e with SMTP id
 d9443c01a7336-2ccfebc6ddbmr56537105ad.1.1783661211235; 
 Thu, 09 Jul 2026 22:26:51 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.26.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:26:50 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] hw/riscv: add RPMI FDT helpers
Date: Fri, 10 Jul 2026 10:56:35 +0530
Message-ID: <0028254f03ea55c578dc6e79b7a8d9cbabaa201d.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u0rvnVlHe-5qlzYGjZ227vIN-dLtgJq5
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a50829c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX3abQvYxpBrcd
 qAH85l2EU6yyQZFkbJDOrsKsRtGLlbSHZ/QFqc4Wd+TfYqxxJNRViiZYMDYUIO5glPQJz8cIu0W
 MN4Gz30J0daZ1xo+IgjH+BmjpUrQL7s=
X-Proofpoint-ORIG-GUID: u0rvnVlHe-5qlzYGjZ227vIN-dLtgJq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX9nEG/h4mijKo
 VtOPDfe0Bn2DzhrChUdJyFlIY6pBID8SrjRBkglqLSoZjJlSI4bFUDFzo/bd/hqPhKaF/iPNzRD
 NjxODa6XGh2h+5Yed7eDpC1/WCqEhatrfO0d7ySVsQAZ7XRI1Q4qvxuaQ7ROUXMAVcLrCPS04uy
 hc9ONn6+LoeV4owW0WabSaj1v56vq0t1VWBB7lrX6Qy7LI9Fh6aFX1OwPej8EnGydM6jzMym5bE
 HQxTyYd35yheBaPdD0Z0wGh6Kt3rLZWaSnYz5VhIlhTXNoz+mVulqIPlmV5WxdLI1+aLQD6+OEh
 33TIemBOAxEoUy24Cg1f4f/xdoGOoh50B9zJlEJWcN4CXBBoj8K1u71W7ssFlKEXjjgIsS3dae8
 YGunnQXsyMwCLFOiGRK7K8dvuYJuBTw8nYYYWEvyCVzwk26KmKXB2CZXsF2o3OQxixtxmSTUbiC
 7bKc/0PtBooZoV+DjEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100048
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
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:33 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>

Add helper routines for describing RPMI shared-memory mailbox transports
and service child nodes in the RISC-V virt device tree.

The helpers keep RPMI node construction in one place so the virt machine
can add service groups without open-coding compatible strings, channel
IDs, interrupts, and shared-memory references at each call site.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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


