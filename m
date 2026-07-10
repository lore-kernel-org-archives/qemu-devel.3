Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16659C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiArf-0006C3-Vd; Fri, 10 Jul 2026 09:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiAr1-00065O-M1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiAqz-00060M-Pn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:19 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AAmUvw615086
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IKyJmrjcSr9
 iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=; b=e1DlrWmf9qvHQOtyfeZgbW1i8pZ
 46j/1CgGQ9aqiBv2R8UjWaC+3q64ZUG2EdxDiTYK6j7MCZ2xaFXaeY6ehsfyjOa/
 SL+WpTrTRVoF3gRNlD2Dd/1ZaFSqiyj8q84UDCDcGiougsO6CY+ETWfWA0/CedKg
 ZqJccNBKcYSl7sTCjkLj+LnDfU4um0doPCotPG+mM1gLPPciA84Uyn2Fk1u8p5d3
 H8f27TDmeOCN5BD2Pfxq/REN31aNtac7+6AGZVW75gifpOJsSfgtp+49rVruG7DM
 ZCkrpl8PXDbvpnt2OadFBrKoxphwDhKb0S2FaG0e2ChoKO6XhGALLB5SGrw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte35kj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37f5ea6097cso220498a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783688475; x=1784293275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IKyJmrjcSr9iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=;
 b=OpUpG9RddAiKzO6Dr8VJR0EP18ChOsCRLP0IqWKOzIoqGafQC0L/LNgtzbTz9gWplI
 aSkfNO4MFK/rZYksQqY8XXgdoUgh99uYirk95pXpP0vhxPzkqc9r1yWQZbPgEm9IN9pO
 f/qL2mCwd8U8NW0FRpcw4BPRRAGIMxrDCDiRB0NwgVwg7eqnmgmedlmE3F+T29OzDG5g
 s+uNuDoawmDBTUGgaQE9H9ssRoNCAL7b17jTB0zl3K6Hk1mtGbZO3+EXsD1jo149ap+b
 nsKhyb/VWpgWz6G8QBYjmdXdLFMNg2Ry8czmYqLddRDpCXjRUpFXT+TXMD0fGJ9osSgE
 ZigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783688475; x=1784293275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IKyJmrjcSr9iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=;
 b=oyQY9Ow55knK5ll9OfHTmcSfw4ESpBKjB9ViUy2nV22h63tEtPd1R/Jt/nDezJ3tvr
 NO+yef6Vs6QL1zPBdsAxtiS0MPoko9WBipATtiGLF2wXSw6pYatDurwtqvtKKwuQTLtR
 lQBSb/mKDhIfUPdtU3qUijnsyXFblAcgQCrQeNgZHDX0iWCe83Noydqbz3SZblpl9l6a
 7Hs9xQrBS5I4BxB2DB4kz6uOXQ1IS89wBfhaZNKQaTTXb6uzOp7jmZk28TzPm9RggeD0
 2ptZxJqWtJhqqPH9mrWaoKsHi/NYfCFJgLGyLksNes653fxwHHZWhNukQhCAQPCY0SoT
 hh7A==
X-Forwarded-Encrypted: i=1;
 AHgh+RowLYG6ouXmvEQsm2EQn/pNBQavREez/jz0xiYsOmrQhbQvxAxbmUmmVtYRvNjgR8kbLaXEfFoCYGo9@nongnu.org
X-Gm-Message-State: AOJu0Yw8CWeVD8go7Hia1tGii7aGVf9Vn7O4SOyzVI7yjmRB2JgZncZs
 Vzkh6J/UR4tQtXfsa6oXZZzr9QAt3sqeHBKz1Z6Woc8QFPkNkW+E5Ltv7oTR38I7SWMNxJL74zU
 Pxw8BcpmzsUcaZrpDf5K3wxTvWCZjuuIneDHZfj5jrZ20LPqHYZ+DpX2pCw==
X-Gm-Gg: AfdE7cn+xjaOLs9UKZnuzO2Zwu3DtYFZQ8kmAgPqwB0DnFAy2O8oKKjA79kxF1H2jGL
 JnX1Q22LQC7hAudeFOY38MufrLKaFFKodI4cA17xk9nLqRlXxmM8reBLWfLk8OCjrDeQeNOqVJL
 jFpULpk2Ey996b+3Ra5Eb5JWtrU11K9hiXevZsglH8uEqZXa6vsFgzNYnx6rLd3askhw+ETySaE
 4iNw3+5YreV6LfNrZD9jKDENnM5OHfSxutwEq2tKCiDuLFzqaPU638RscpWqDR37/zx/Hmq0ksu
 TYFCSSJdTQMNq5yJrOWzFMZKp0sMwMUi6H/OtkxA/f7XJWoH51qJbsvjNjkfTMqj2u416IBQGui
 i6zIgqqw9l/rW0FRympntXogyu3Q8nXVmt+zUryu/yvnnBYizH3Vfy2yyc4PPZ6g7LTYXizDnwv
 KLjawKqF1C7dYsfwfZ9t8LgVUR4whpswa1QRrQdIhcZg==
X-Received: by 2002:a17:90b:2d0e:b0:368:b002:bdad with SMTP id
 98e67ed59e1d1-389421ac44dmr9435936a91.5.1783688475375; 
 Fri, 10 Jul 2026 06:01:15 -0700 (PDT)
X-Received: by 2002:a17:90b:2d0e:b0:368:b002:bdad with SMTP id
 98e67ed59e1d1-389421ac44dmr9435634a91.5.1783688470165; 
 Fri, 10 Jul 2026 06:01:10 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm9611839eec.6.2026.07.10.06.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:01:09 -0700 (PDT)
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
Subject: [PATCH 03/10] hw/riscv: add RPMI FDT helpers
Date: Fri, 10 Jul 2026 18:30:37 +0530
Message-ID: <0028254f03ea55c578dc6e79b7a8d9cbabaa201d.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7KmMZkl0F49WeZ5e6e7sYwwg07owm1me
X-Proofpoint-ORIG-GUID: 7KmMZkl0F49WeZ5e6e7sYwwg07owm1me
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfX0wwsPghntybs
 iWRU1ohT1I6T5yaEX4YyWTBvaAJHld4QuiXuXPx05BCJQsws9Lbsz2eFuCS43CF/9JxmrJYRepz
 zuzT0qk4d30Tc/lKVyvZbOejCQTRlsd07LQgrHYcfDHYW7K8E9KBjjqw/zr9H8LF9HYYfwHrUHs
 chlbDyNRcp+WwkbGm/vfqYltGNhvRbpEXaxbRUsdXnGCXhHOBdGEZV8aiyzZNWMyT/+Jxv+lNqp
 FZJ5BxC4Ni92V2E5XZry0TfMSOlNkqPXRe/5b8Bwak2zYEU3PLw3chI4+ITnecrroKIUqy9gjM/
 i/AqUJ0w+pB3byk2nHKe5D695rc2CFqF3RVXpTGUqzZ0pp4kQWS0nYfYdJQUw+Ne5pzfV2flYPA
 BbFq+fgxfBkj6IW0rnX+0wfWRhd3qAYSYbaKfWrP4Cz8ooVnAnoyx7+b+enz90cUkheX4/C2Zlc
 MudA266cMF61nDj0eZQ==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50ed1c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfX6HRSwdxh6+Hl
 NK/+MyJkmzoqL6JDfXPBGpCc/OuWaN8qCBkx4/Lzs0ss2ICa82Dl/bA1QbMLqQ+gdX4lgusEufn
 HMVWzHUzdESIjFABsPHN4uMGLlpOS50=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100129
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
Message-ID: <20260710130037.6vXWTObFxPsidpOGjkSVw9mQrpJDK2lDbbTdDnkVfrg@z>

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


