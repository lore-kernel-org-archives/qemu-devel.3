Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB55C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 04:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wujvP-0008Q6-PO; Fri, 14 Aug 2026 00:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvO-0008Pp-SI
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:53:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvN-0005Kp-5W
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:53:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4Qt213615498
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=82l3PjnXb0G
 ZlmKaawQ08Xl5HnrTAdtiJbEN8JRS2d0=; b=V51lIGRMLTeIZZnLCj7vIFE1wy+
 PJiWmhX6o9kHXztyXZDezaFh9uZCAuYIIa/Jh6iQWua6OREindyKmtNajAq5jxbL
 FRAaBflXykU9M0kfGC9lMjBYKBGYoeoUZxE4Bl9GBPRRcJh78mMtYHAeiJ5DBymt
 tqXJ6u9ebXtzZtHNJGn+EJdk1f1Go5P4nZAeuBA7Ubo8JsPhU2IXF2W8s6/7KqVg
 wWUA91G2cK52elVUmGBg9RNXdFl0hDUGPzNAA2B7maNGBUTLNfwGyVp7s47klidR
 52WMtseXWZVjZbx5pQwaNlEZEFzy3v6Al+0vkKemZpFCId+8hk4FQrt2faw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy2fh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38de4c60f0eso130986a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 21:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786683223; x=1787288023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82l3PjnXb0GZlmKaawQ08Xl5HnrTAdtiJbEN8JRS2d0=;
 b=QGbv6uOQ5HZ+Qj49C1YFJI+1PDfhCI5xZ5CIgs3gktES631D2iHqNa+oPDztzdr6U9
 wDnZIISSOGig6YnTXu2ac1ZmgxZLkhL0TaV+bmFDVCYTdtEQN+NivhhW2a2g7xnDvuvb
 saV7y26wo7c7NwgIlvSQH5C5P3lwVXbBTZZxYlpGc56TXNKmSq8kTLuApdFO+V6hyMqQ
 4hLXTjXfmqcjXmKjwnePknRYub5ZPUZdIsl7APogClh1Y43ARFK5agZV5TY4oCeSbafl
 dyJx/baYBjeqdfLryCzlcEC2suCOioJMWKMvdLvkh6GbS1J21E7rRDDG2HXadmITGlii
 2D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786683223; x=1787288023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=82l3PjnXb0GZlmKaawQ08Xl5HnrTAdtiJbEN8JRS2d0=;
 b=BIyJNTo3MBYQXBFnOxW6n2xtD78cGsaoGdEera1N0d1jbwM/n/LddErGppjck7PRWF
 JGd4dMt3S4gmrqMq38ElNKVgWz2u3a0qhk5QjMJUVxPxn1rgLXTCQfHD5oh7pRGDOFMM
 Ir4CqdnoGK8vG5vFqYjNc2wCtQN2X2ebL/zwlx4Pqj+41mfn5xWvKO7FnqQHWprCcIT/
 f7EweM3qbWa2rBUu+w28/32KnQKFFLb+x+vXhEH8k2De+t8xlLqS/9BU2pJ38Bh3oz1f
 2qprD4GqbXatiaRyHS45b7U35ZNxqFAzQAW/MDlxj7kO3o7rzVp5cgdoKnkHwfnGW/2d
 hh8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZCimWY1LG/Dq47rUAovEXrzGktEXo60TsZcWAU1ibh9KJdgcBKkO0oBO7VxBYjln0TCuulKu8bu3G@nongnu.org
X-Gm-Message-State: AOJu0Yz2FNHoxvDWedc6B2ihUH0IZgYp/GzZWH6goC2lREKWS6q5r0C2
 8Dhc2u1F0e9kqDJ+TtwSoZ7R53PdHrGKMBHVNacvBGWt2dqwoGnmTXxO0LtJgvNwFvi9L5qayTg
 i308UjPwWjdp8x+BSt1G4zAhWfroztuKSJ8IXgQQCk2aQxp6rPmx2gt9sifLcaW+Xew==
X-Gm-Gg: AR+sD13+ez15lu55bzCSePC5k6LBOj82+4dMM7Hp/0L2xjxyE2jU8rBOTPHs+Vp9cq5
 EJ19tlS6H/DS2W6uGrceNJNF2R25jdFcbapBP9kaNw7zIxKgygp2I1kCcjlHQWLhjdmdvJmQ/Ci
 hltPZ9TE8M8hNRh/aUae3iNSUnVULrMlMLMkWEDnOWPiMz1gxRKfMdzd/3wIV2/kAGby0UwtF9X
 68pH8aKPy/Y2AmKf1oZjFFbm3tNDMQPOZwWAjTEr4dyJmUjEEK22/h/7oX/7UROM1rGQGyIh3Fg
 MDnklJR7EC5C3xC+StPMZjErXC0ALAq/jv8Ifb2xJ8BjcD5hZhpONmfabo9F3BbEsupmz08yN6+
 Q0KDJZnE+8ynFgSNxL0mNIh8WghGBLcnoo0rhv20OtpNM+fBnV0Iy3MF/y73syB6IwVo+NfD0W1
 fPIgyaFw4k+DX6zMjP2v1x9tzNIGFJBzg=
X-Received: by 2002:a17:90b:5444:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3933b8e2befmr2423119a91.3.1786683222997; 
 Thu, 13 Aug 2026 21:53:42 -0700 (PDT)
X-Received: by 2002:a17:90b:5444:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3933b8e2befmr2423090a91.3.1786683222384; 
 Thu, 13 Aug 2026 21:53:42 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f15063cd8sm10625665eec.9.2026.08.13.21.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 21:53:42 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v8 03/10] hw/riscv: add RPMI FDT helpers
Date: Fri, 14 Aug 2026 10:23:07 +0530
Message-ID: <20260814045315.3416169-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX9hZYW9SbF2gQ
 X5Mjhh8MadZWlFxG7yo9Mm9xSwuFbKnt0enomC5gZSUB/t059r8Keykne+exwfGs6EQkPZApoKk
 haD5N7gwWxIkjoDoq0yesZdlRHd4NvjjR9kkP1AwzrKZPylkzyvPhZB0ZW30BsoiEUvtddmZ68T
 HLq/zr1lHjYgFMPEl9OeWe9DGXkuSJCrl050U7fvwmUG9vbke0waaSSwjjVEDRZ8Zx4tpNftcbX
 iS7D4OdgZ7sKGtk0ka+SuO52Do6X+3fQnUVGgPuzLnhjlh76o/zaEz4kcuo7ZD4rfif/iNbWZVk
 CfebrYU5I5jHFCYZUol2GDq034hSaD4C7ot1ATpe9RmFTGKPvB/vj3gsVE5cF03K1Rg7PneRjKd
 nw1s700GIjAvT5lLYQrIJVWw7Aev5JzrYsp4Mws//h9IGAskfH+y0mIoKklMr5SCBwbLWrWnl93
 82sf4H0yXak1eZvcJfg==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7e9f58 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: IBZNykSStEmF6ok_9IbiE-J4BkdA6_EF
X-Proofpoint-GUID: IBZNykSStEmF6ok_9IbiE-J4BkdA6_EF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX+Pq+xInXxAhL
 X6qlaE15Aly/rIx5anllqj77XPwMeFFus0kM/B74gjskkttZ+O37Uz42ckNf+DzbmgYvNh+tphx
 5JO819Zo5tniApMHQrOptwxvA5JI8uQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140036
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


