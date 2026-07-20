Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB101C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllmA-0002rG-D2; Mon, 20 Jul 2026 07:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllm8-0002qi-Vv
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:03:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllm6-0002st-MS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:03:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvV3M2162169
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u2inny1kyHj
 ix+ilOuGF76rFjWqbyjoEgMiN6LdTVuU=; b=h53QDa4cp8Sm3n0l1DO18qeXMsu
 6piejxjXWpRts72ykZ7bwt5euRpVIeQg/Q4ZixkMwOcpHpnrJ8v0490GWNJ3U5kK
 kg0JG+N4RgbUV+TWs2OB4Elv/CtRqS7+3XAx/7FEzDUYh/r5WlVkKlusWbggvOW7
 M4bjYoEDXqS0LT6APGDDoEFOPIpRPJcTInNnsczRDBJqndKwhWiGPWCPB8eR3sLF
 FlEHTFY98pAp2x6YowAZmr8aMv+GJTpqO3zCHS7tUn7xtTCaIe2zd6BfhWVHyT70
 eB8IgG1ENlolgFLEa9bQ9mPeVWBRfuKiCl7banjKrHppBJe1Lcr6fm4R1cA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgs00fc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:03:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc98d6a88bso33989585ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545383; x=1785150183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2inny1kyHjix+ilOuGF76rFjWqbyjoEgMiN6LdTVuU=;
 b=iYD2gzFmsVaclEH3wKS57KJK2bAF1kclxzqUeYuHsBNOnnghT8toxswlK7QKyx8xKS
 pl+GOY29ui7d8Z7g7zl2TSlwtGlyOxe62LzZCpfJAurS0W9ZnpbjAAjtSLcGNslQlFEs
 K8oMAXdIAWASI+0p9vMJDq7pWatqwuzHIH1aVoMD83pMTiGjmaLC9/qMqPcCWdPA0k+T
 BQsNVBK3r4NsQwVivifuiGspiDst42TMQAfay4zdCkKI2bGVCdKrad6P1wIGkT8XtV/Y
 /bhC6iUa4hAWs3Z6z8uudfpQcRD1wjINnSRiCIcIovl2z1M9Cg8nz9FSH30D7vkvJAgL
 E2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545383; x=1785150183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u2inny1kyHjix+ilOuGF76rFjWqbyjoEgMiN6LdTVuU=;
 b=mfua04ZPD22CCvpMBefneNL6p4U0fqf1YA0lnlUatIJ3yUpv5PRvnaByeSmLl2lozx
 Eg/f0/q45tpVjbBu1CUGxybOE0jhc/7jrPf2YTvBnnixxR5w8jYY0u/gndI656PYuzQq
 sKlrtqNG09b4oC6hyJPEry9/cZKzizwYMC3xjVaVuJy98rTu9u+iooBhCdEENn4c+BjZ
 mQA2njyTW7R6mY9UZX1qUFyu75eyu0gA5L6Ch3174G7HJ/8KnLQMkApq86W7dMym7opk
 C1E/Ry+Pizoz8UmPWGXURqs7IQ3AZjb9iUQvC53l/9pL4cSo6en2taqPgEJaTRPcBhxG
 pxZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtYWOGkbjpPlw/ca30Rz8SztJv/zXsDscx/IqHDIaOsJE7iwc5Seoj3Gi9aBl1sLcpAgudkFkcLjrd@nongnu.org
X-Gm-Message-State: AOJu0Yzkaxq2cANY8BESncSpyLtb/FrIiJ6YRoO3sXOq4kwicC6TTm9m
 m3M4gscUjDXwOBFyeANzolOmd2IVYcdz/YEf6lApRlGuAIb4rHCQEAltEAVjhppGJkwQXIRho8T
 UlO0/D9WNSjCUN3zW8UUzf9cY6/QnIik4QKmaAGIJmKiXB/dfkLVw8/S0jA==
X-Gm-Gg: AR+sD13JGM8pJ7ZlqOOTBkO0qIVEA5q22pN5fFOSC58bfoZDrefCHhDDZVA4YOLI+V8
 gbOfBRUmLQIKPJhFo1YpWKIP7yn66Mobhj39fIR5xcsTrZ/7lzQD7M2O8usweNYZ4c+dDtza9pE
 XpdvT3btG1oPu3sEJvXBGKQhP8P6k3nL/AVYfjkhlk1LiEmjrjnHQ4B9LcvxxGmwaEtLgGd58CJ
 IcAIPR1bcN1WjSv7XawaJw9PvWaiYVMweIhbCdhirjQGc/GlpP+gO1QxsnuvagPuWHVxzb5nnvp
 fQs7lpcT5tUh7WRPOYXqwLZw+QVoWWekvwIFFQzKMP079pgRbhAM1IGZAIMJVpsEOa2gmUFWJ4h
 Qo6F/VVUPgUBN01kDhB1qvLcgDw9nQtN2NE7Vu02WlNoHRfoRLt6Fa5gcLewhARGluUXNlKxpm3
 EZY6OqmBej1G6vxTU5C8e+EMGbgiQsCPo=
X-Received: by 2002:a17:903:2d1:b0:2c9:99be:f011 with SMTP id
 d9443c01a7336-2cf34988a8dmr98692735ad.6.1784545383153; 
 Mon, 20 Jul 2026 04:03:03 -0700 (PDT)
X-Received: by 2002:a17:903:2d1:b0:2c9:99be:f011 with SMTP id
 d9443c01a7336-2cf34988a8dmr98692435ad.6.1784545382660; 
 Mon, 20 Jul 2026 04:03:02 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20b1f3sm34698566eec.26.2026.07.20.04.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:03:01 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v4 03/10] hw/riscv: add RPMI FDT helpers
Date: Mon, 20 Jul 2026 16:32:26 +0530
Message-ID: <025da435c6b7097161342724a6e1ba7e85b64258.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMyBTYWx0ZWRfX+1ec8WzRJAlO
 vgZorBY/V5HkReRPST0XKOEKE7LN8n/lIAfXPlV52F/XTMsixXwWsKnQOWHxj49gagshqX7wjqq
 QfpdwUZL200KJT+J1Dcn9AdbF8mF+FI=
X-Proofpoint-ORIG-GUID: HYY5H8DgDrHDPGUqz8zfj3Ovg1BWNCw1
X-Authority-Analysis: v=2.4 cv=DMS/JSNb c=1 sm=1 tr=0 ts=6a5e0068 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: HYY5H8DgDrHDPGUqz8zfj3Ovg1BWNCw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMyBTYWx0ZWRfX0FVfXLkKkAPd
 hWToRPDRA56VR9j78c5ESHigM3jBZY6UuqAVdSW9CmsHQqKaF4vHBXz0QxY3bq2mIQHJQuXPkAv
 5w3KRdBTJjpRurNmBVLjeAbyJYSCEojPXHybnCZdrmj9EGbMMbP2UGnCWLVS55eZFhmyldNpO/p
 np6xIDMk2mTFWnYHUfxgaXPZ6Ap51jc0sVKdYHjROlnWoynlV8Ds8s082itB/PWRKbFUxQSYbsr
 Mtvy2KfA5MtPDDr8+sp8iGfS1VKpWVdgRvFOFdLZxVVmPCewSlUt28xCCeQDNPSiJxmbiZLo1sn
 7zUs/pWunPhRYvCIyCYzV/ThSux6sFs6+s+SQnf6//BB0Uuf8EKSSGuVfkzcytwADSQ8LKoq1J6
 qdEplRoKH/OUK0zKgWk9/ePPqD2MJIofFFKg7DS+UsBn9X9laamFJZ2oMy5aD5TvQz4zx1eYxGj
 PsHp3xEI8SMvDBmCaxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200123
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


