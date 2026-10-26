Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E63606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ngE0zPeg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cxCrSwjn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKfp-0001SL-SJ; Mon, 26 Oct 2026 09:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKfn-0001RQ-9m
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKfl-0005EI-4G
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt42Q3633158
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zf8SXWPwTle
 7JSE8aHa6ven2gctQeVgaW9MEcdAKbxE=; b=ngE0zPegl50D+ymev/GzeC23rlR
 pIqD0R51xLs5j7Uwn4Ja6o7iHm4w+VlrZR0QtT4qR2szk9rB5cIGLZBh5MXxXEU7
 taPFHD+4njPn6cKSF2ymeFARuNEiHnYYcFvJzYqNl727Txfxu5Q253f1Klb5lZp4
 gmhmJmIs2JuMs+PX+ljXk+sAhUqxMVuess2AMjKaFabX975lMhQCXUNLSoCFPhLC
 TaMemmVuHY6fpB3fUAxgy0KfkSWKIZVVTFCc+omko3qmhIdA1KUgv31G70FfSzcS
 dYIehDS15Fmmc7qX/kGjbKGiAW/eocssYWMIuM3Pxm+hA8yB0QECh5nkwDQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf0qbf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-313c7315becso550446eec.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793021010; x=1793625810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zf8SXWPwTle7JSE8aHa6ven2gctQeVgaW9MEcdAKbxE=;
 b=cxCrSwjngy+Y+AtDTrEx56NDRokVsXEC6TgaLCh0CqQeRVggHi0k/JdLmmqYIDRO2u
 Qpf6c+1yVMMyOXMVfztodAB18Q3RFW6gL+auSas7547xJtEpBsojsfSKxE0oJ0nHTz8K
 8+fepwQgh6ChHRd6CafGL0Ar7XWNwhpsiHTofMY2+1dViSXw1i4cG2+DykMY4vrRPMDY
 harBUpY1+lDGA7Zd9/ZLS+yeE26TiOHIogq9d9eI3rfXfj5vFTmWX/h6MnjEhgIp4sx/
 zNOfjKHEKew4Tjqv4aj0m3ts0dGuytCGfI9BlG/nHyay4KXNLSO/1P0T7wNzRTBTZW52
 dmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793021010; x=1793625810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zf8SXWPwTle7JSE8aHa6ven2gctQeVgaW9MEcdAKbxE=;
 b=aC/7Hway7G4Iw+xsdq9ANNkAyU6E4AL+nZDNTkYGL/sqdtcdT3vk6ZgN5sht1ENCzf
 uXwR1vq3z5GI4HlFA6yUfCgLzR9W9/P5nmE7gDuIKMaRqFdp3qBase/yWeazUOvqN/Ll
 s4oAsVSk9KA2xPptzzS8uit3SPHR0w1Jr6w++4WNKBXmQF7V9SxsLis9pxkpcKFO0FLO
 mr+6MMr27SR570Zc4MOXYfiKONgaANIV1Q3Ef2KYmiU0N8/lmRTpX89uAE7HuOo15gto
 THhA2L3m43GD2DlBWzyM+AWmmQ/SM/mxRZMfeIKgyYsnI9HTutI5HwjkgEj1fwYyzuan
 5YjA==
X-Gm-Message-State: AFq9FYLEkfJFCOGrz8hzAwYayucFDTPR1Y5I/vzvkK8ji1s0ioGUBTw+
 IoP1Mhqqmxjt4hTyhkU++6onUgSJnVijaNGC+wfnbJ7UDMcPMZs7IVZMu0xFz2bmQBStcFz3U+F
 ZckDwpXoLpdSjt46icozASwdHHxDG9di7Bdkji8EOM2Tu5a+CILcFfKYxxsu5e7VDKw==
X-Gm-Gg: AYBFou1SiqoiG8B4+7lxRWRUdcMxNEUifFUtAUAXfI+BwrrJC3YDgCGSAhPdzR/pj3f
 qBV19NUTwyMes1INw7DBK+ULWepb8RedyLdV0UKwNUy1OnrT/J/U/Hu8dR/arD8SX1MPzpb8S6Z
 dtwt/u7haRTqAimiPOi8PbhaO9JXp1kjOZYaQ1fZQpDDD1egaEQGFWnTgWnv2uDxG3wByDOqp2h
 HLqLiWCvXAoM2Ua4lqm9otuBuaNWZvhVhAQyj4VJ9HczLd5/IKYwAe6F6rue8uxpgISS51L0EqY
 javb5GeASfiL1gksp4FGu767VUk4aGWK5QDroJjyugmaidkCfh1rB8bfXDyrFYzq86eSw9spQiB
 PeoAQrO/pMz3CRI1pZ1dgDJZycrENK0mTG1qe1oduS+fl/NwUsZPVHImuKPfgGB6O52iyyNdjWH
 1XosYwH/EdyPjI9lUvvxlPlKVlwQhjQqY=
X-Received: by 2002:a05:7022:7e0e:b0:183:d275:cf76 with SMTP id
 a92af1059eb24-19934a9266cmr17464661c88.2.1793021009685; 
 Mon, 26 Oct 2026 06:23:29 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0e:b0:183:d275:cf76 with SMTP id
 a92af1059eb24-19934a9266cmr17464595c88.2.1793021009074; 
 Mon, 26 Oct 2026 06:23:29 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a21bc6cbsm24360931c88.16.2026.10.26.06.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:23:28 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v12 03/10] hw/riscv: add RPMI FDT helpers
Date: Mon, 26 Oct 2026 18:52:46 +0530
Message-ID: <20261026132254.2652399-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026132254.2652399-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261026132254.2652399-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX88GLPK1Dat3X
 Jh1TQ1Blx1mTJOhG6LCyl3LnEGGUcxvDcTb/eyKP/2lqQRDvJ/j4a3Ee2yEN3AkTo1xtH4UGcVr
 6UJ/1tutlYAIE5MBxSs7Iwi75xVnP5g=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf5453 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=A4YYoHtc6PVOd8TWIokA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: SgDXlYSPEqAiOK1nOhCcuXE4N8HtrKRx
X-Proofpoint-ORIG-GUID: SgDXlYSPEqAiOK1nOhCcuXE4N8HtrKRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX6LIUKGuhlw+7
 0ZpXs8botsQt9Ha8jWdVBaXIrdRgLZpRafD5Ngn6o29kNtglAJc8F3AkBiSWGKFzwP7blTMb/hb
 6Wt3NTgKP9B8lZCwhcpZjcu2P1Aby8f/oLYqFLdH5ZuuUVVH1YgThb026OZ6ATOJcMaAwegK0lF
 iB/RAuF7MjpUTuWS3SneGgeGC3N/zrkJX8yI3NrfKJ+rhE2+dYBdqHH74b007EaGjNOyGbUe7/k
 JEF8aEoxc5q6DMbME38Qm3HEJam79og1baHQ4eENobXL9P5VVoOwHx9nyDEx+YQJ682y0C+J8DF
 eEpLMxCl2eY6Jk+FLXqwMOUjxZE3UvUivpqYovynJbiC5wCXDvwwcpdodUg0yH+rQdzSRQq01r7
 9CtpZEI+PEwcKthxJhJWmqerFIkq8PnjWmIQaqjqjt2XOmDXj0E1P95XoTBqYMmt8HPqwXnSZBY
 TXzBiHqRsb+2RhXtxlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260053
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
 hw/riscv/meson.build        |   3 ++
 hw/riscv/rpmi-fdt-stub.c    |  36 +++++++++++++
 hw/riscv/rpmi-fdt.c         | 101 ++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h |  40 ++++++++++++++
 4 files changed, 180 insertions(+)
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
index 0000000000..77995f88ea
--- /dev/null
+++ b/hw/riscv/rpmi-fdt-stub.c
@@ -0,0 +1,36 @@
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
+void riscv_rpmi_fdt_add_service(void *fdt G_GNUC_UNUSED,
+                                const char *node_name G_GNUC_UNUSED,
+                                const char *compatible G_GNUC_UNUSED,
+                                uint32_t mbox_handle G_GNUC_UNUSED,
+                                enum rpmi_servicegroup_id service_group
+                                G_GNUC_UNUSED,
+                                bool has_mpxy_channel G_GNUC_UNUSED,
+                                uint32_t mpxy_channel G_GNUC_UNUSED)
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
index 0000000000..2110d4457e
--- /dev/null
+++ b/hw/riscv/rpmi-fdt.c
@@ -0,0 +1,101 @@
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
+void riscv_rpmi_fdt_add_service(void *fdt, const char *node_name,
+                                const char *compatible,
+                                uint32_t mbox_handle,
+                                uint32_t service_group,
+                                bool has_mpxy_channel,
+                                uint32_t mpxy_channel)
+{
+    g_autofree char *name = g_strdup_printf("/soc/%s", node_name);
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
+void riscv_rpmi_fdt_add_service_node(void *fdt,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle)
+{
+    riscv_rpmi_fdt_add_service(fdt, service->node_name,
+                               service->compatible, mbox_handle,
+                               service->service_group,
+                               service->has_mpxy_channel,
+                               service->mpxy_channel);
+}
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
new file mode 100644
index 0000000000..5b8c44ad20
--- /dev/null
+++ b/include/hw/riscv/rpmi-fdt.h
@@ -0,0 +1,40 @@
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
+void riscv_rpmi_fdt_add_service(void *fdt, const char *node_name,
+                                const char *compatible,
+                                uint32_t mbox_handle,
+                                enum rpmi_servicegroup_id service_group,
+                                bool has_mpxy_channel,
+                                uint32_t mpxy_channel);
+
+void riscv_rpmi_fdt_add_service_node(void *fdt,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle);
+
+#endif
-- 
2.43.0


