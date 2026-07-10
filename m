Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517FFC4450C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEb-0006Tr-6j; Fri, 10 Jul 2026 08:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mk-0000Xe-Hk
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi6mg-0001rq-Cj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:40:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7eJaf141562
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IKyJmrjcSr9
 iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=; b=QmEf0HxtmwO1t6K08hbcdgXJmoJ
 UbVPxCT7NyQMuM7bsqaSea0hCTISiB+KKSHOhH9Dy6VPX/9IpwY8M3BKu1jhy1XK
 kmOelnDxdMH+0N+MjwEUjf7a4/I3ikuRe3AVm22sZBRcTrqbF76QpTa/N7wqur1R
 iHN10anAECRIqKHQ6gYu9tcv3G09pa5RuOcoElDSpzHoeFkzfT3BVLUOn+HZ8+Ti
 sewPlJsnAvXXIJpoi1d/9isfI10hyVSiddbX+/JHniJRWvpqk5JLo0kTXw93njv6
 2kI4XW83cPPAa7GeAHBAXNZ3mXi+PK42JVv+Cjj+DFqzuFtPDWPCKCAd3RA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mub7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:40:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so191810a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783672826; x=1784277626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IKyJmrjcSr9iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=;
 b=GqnGkBLSkA/eypl67uBp8FC/NFpmESaZsxp6UZNj+Ud3OipXTCT6nEd5GL/mmbp+nw
 8DbtumXQu+Xj2Yap4AeEjAEm4HkBiDC4BnHmeKtjNPJ4ln0tGS6CYOdZro6ju2WHZD/B
 FEnWRKPaYoCloNBqUMfa05hLFzUqEpTcSDt+6tTerfs0bLU6ozqIicdFfCdiDQQGg/VX
 bcKKj9K9z9C57SlD5UcF5dtHeCMmCbjGAjrCWj13jbQjw+MtNneh54+1VfQ4MU8ta7zk
 oAKdC3H0sqJ9WGIhZ1/koMhtM/kCeRkP5X8DuCa9z4kuknisUKTYmrJXsiRj5Ae9ULWR
 ityw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783672826; x=1784277626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IKyJmrjcSr9iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=;
 b=SMapH02+9SVxFSQsvgn3RESiFMmxajcqPB/Uw1ret9I0W9rRpd/IkSIsNMJMuRWgdt
 AZxGlLYtKU5q8OmOse7osTQTDHgyw/rflljlzzDD8OuxBXXPqtFimEJqETC0V0/NJuZX
 CzAX6C28K5J15NSakSzDEC2gFi2Mjx5XZFIShGlrsqHsxDoF2PoMd0bdWCJSgowQ/Guf
 F2kA3uB36UTpg7oKSLpurJotRGtIU25apO1i8v1XVUUfrB/j6cA19TiC8BurRiowpLV4
 OqOHdxYqqlPOvJ6HVeaYmal8Smv1/IpYy+CRELD4kA1g0UQQm8/sfKqVLskxcz2vCWwk
 NGIw==
X-Gm-Message-State: AOJu0YzzFMmrPVb3mycJfU1/Kl7P4TdbyWwN9GkJKQnV8b9v16JjgbLF
 eXGz3TCu3PoaFzelZd3Zv8A72WzS7F8eVHk0HPJLIrJ7mG+xRKDcy5l2qicn8HyzeI8fHrvWrOL
 XrdwUhz72eqFjwg/FxeSdF/tO6rebpbqb7w+Q4l3hNTyfScK4jhXnO94Mvg==
X-Gm-Gg: AfdE7cnrkfBh2GOgPZlv0L1kXH1tb+vj1KNvrDVL7Zt8jkJrpzFUJ5MT549a7PNA8t2
 qd0xET4+qWOC5Fo+Y5ECvWS7m/jlZWmMefoH97g1IcOceFfMZMkkGljPiBWkeEn8NSXm4TUR7bq
 tYkzddN/99PdfdwvZpOABi/YtIlBTU6IpLkFUf2pBA7GxbU+r0owt0gObr+Qi9u5OUx7pSHAbx0
 KhZ/kpm+VacTViN7Qkik7EAIaD2rGguw9QO22RfA0kGgbtaOZ3hSFtD7GSs+RsVaxaVjDnT17Lm
 ZNqNSIeOKRYjwT+p0zdeusqEcYXSOmNMHDB2D2UkNJW/Nuh5FTSJ0ljvfPKK69qda22A0itoJb1
 ld16WiLbuN0s/t4mRENTVCA1Pv9Kz9vj83cp9hl0OAygZDZkxaZIGL1TYAfTBwuQ0V432jEMMpm
 2L9ml5GIZw0YULprK7/ruILddNgxc2Q3ODZRwHnydVyQ==
X-Received: by 2002:a17:90b:33cb:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-389419cdeccmr7838900a91.4.1783672826244; 
 Fri, 10 Jul 2026 01:40:26 -0700 (PDT)
X-Received: by 2002:a17:90b:33cb:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-389419cdeccmr7838881a91.4.1783672825724; 
 Fri, 10 Jul 2026 01:40:25 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm29164925eec.20.2026.07.10.01.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 01:40:25 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, daniel.barboza@oss.qualcomm.com,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Subject: [PATCH v2 03/10] hw/riscv: add RPMI FDT helpers
Date: Fri, 10 Jul 2026 14:09:45 +0530
Message-ID: <0028254f03ea55c578dc6e79b7a8d9cbabaa201d.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ol95gbI1QoUghkEnmEWgD3At2vewX_pH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4MiBTYWx0ZWRfX+QkXoB3PAY5c
 TvzcDHFgHYFmgSP0IKtzc5ahhBphiOuchhNR8jBlBAFVF6lGih5e/8dRimwOuM/JjQBTXrj2R9c
 /cvPQus9RR4qGLVcgwdJXEM+M4mJ3rk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4MiBTYWx0ZWRfX0fumO1L+1QJP
 8WDxgr76Dbsz/0eYSdheVH7zlpilI1MEPHbgSQDIlThvI/wQp2g7kWbBKRhfVdr6HsXyYN8Bh6c
 /hpNwry1xnwiBGlkBm9NBCHigqw3WGVuUgiJyyQphOXkcv0avMhUNEr5Fu4jgmSX1l4/ka80CDj
 hF050hbHECG++Jf46P4iAEUEFnlz90u/H8K+v+J6tZ55oZOHg7bVD9JRZCCqnC4GaMBNtkW/QRU
 D4b5SVr8G52fzYAZrKIYTdD6SFqPPVSwdPq8FZxgsTvC40M7S70ZKesGadbnW3AfvnF/lmUk21x
 3SGW5pA/8g7grUMF77vb4GeU4Cls6yuooDrJj+7iJiZkXlnNtKduDWJ9PIhn1gurq4gyygTvQdd
 /4fQCqhYNBLnjGvVEVAvh8jPPNNCp0/ChYVzNiZ+59BKeGREXp5st5NuoJwxHW4Q8nOH3GJSqmR
 aEqiUKQuHPyE1QdWuOA==
X-Proofpoint-GUID: ol95gbI1QoUghkEnmEWgD3At2vewX_pH
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a50affb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

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


