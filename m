Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A03C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvv0i-0003nz-Rc; Mon, 17 Aug 2026 06:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0d-0003Q4-KF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:56:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wvv0a-0006Bd-3p
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:56:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dcve1466545
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4MQ7m/xnNTl
 mAd2yUWdE7VLPWFRjZ33tIbtXSHmhzQE=; b=Zw2nmo4DRb6ERKVbc9Dr0SFh/Kn
 UFietLkgGBH+OSSub3AwgAovZMTl9XzhfAzBm7LystFwX5GR0kPt1zIeV0llFwiN
 txOqAIOYq1JrXP74v+et3CBjLZkW2JKrTvVYklNI14k73/4ZXo1hD+VgaRWFYVXN
 MuGXqvBLwojmNmgudsPgOWYR5pe6Rcani8tTmO2IP6WipGukbss4bJRP3Ozi3cjX
 w+MoxnDmgnSLmp2XfjRiVgRqbrGKTLsBhYBdvzDsbaVkgT3wUR9quHBmXUHRqsEa
 ZDQFpTUPMILgoLHydLZM9FtMDX2VlwnP90Yzz6dJJywnm3YrWqcWgdSy0FA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xx7ggm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 10:55:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ced1ed870fso8255845ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786964157; x=1787568957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4MQ7m/xnNTlmAd2yUWdE7VLPWFRjZ33tIbtXSHmhzQE=;
 b=PyemcxzhRxgl2nq5wQcFEJ5CvS0BX2QCXHmPU0SfDuusdSqllYTHerbFV9eSqU+GWt
 rOJzEe77CTqXoMBZKNipncs2VioHZs3sAxKSJ9K5I/PmQ8whdcp8wHiD1u5sA/fRX/Er
 YT9FHGt/N61NX/gX5E4lc2UF36y3E1OPSgNOQKTJpNBZlRa7DBXd1SO0ve3vrjyIyKxe
 UR61pUqtNt47/2O7hipY7nwSEtxuXmkY9176/XsMvu3BrUgT9cfqRFxUavm4SX4JhIfD
 UnNZFWX7G/lud/0AzjnhvuQmWoK0s8VWJiusTk8kwARPK46RBB4OC9lZ3QLwfldkOYlS
 Mi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964157; x=1787568957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4MQ7m/xnNTlmAd2yUWdE7VLPWFRjZ33tIbtXSHmhzQE=;
 b=iirOCnJTTzVbwx1onSGUgo8PHet8FAQXE1BRZ2d+BFA7UZqiqunD2MleaU5Jbe4hpa
 39ESHbFEFVpsVJ9j4+u9jDY5iHC/nepWfZhoIN3U5rJCdQ2dwhQ782oRCy1juO8awuX3
 KeEU8HojlZjMZw6LsgIY+Dpz8t7ydJz6sBNo5MZBjmgdB7C77+osEgxkZbpz+JJtO0uU
 6twsN49unCWoU+dUmaH9YFmH8m5tNCgbbwbwUFoRAsn7IwdSUV9efm1RhFr6fy2tQh23
 +meFEQJiagUlcJnuYEZ2MyTOMR9HU47FnbuRRtdgLtkONMTWhAamas3PFJMnL7brLJBA
 mN3A==
X-Gm-Message-State: AOJu0YxJ35LSNKjo0BIdsebFfUFKEZNvpvl1zHKU+He2I50NburGDBpD
 /+DefcygGpxs9FcxR8l8SWZ3ON4pgXIccZHU0fsEj2Z6/0bqQeRpGyE+eQmScGM+79GxSSzUkF4
 3demv5HYcJcJ5kwSH397H96Dqys8CSKCh9+zl3Oh2Q0+1NKjRQ4EdzR6Oz9AaiuJ0wdRo
X-Gm-Gg: AR+sD12QHuD0rw2LVTcp6tQAiQNFWM3BhwVXljuTgO3wQpLOP2OXPMiQ44mvjygzANQ
 CbxNFbpuv+mT/Q2H+MlZbhnFp2Z90QH1/ru63r3+AFij/eepq8qhzjpG9lTUrN9ndrEMe9AxlEZ
 HfSfRkqdqV8LapSwJS6v0a9s4rfbeEsdmG0WCuhnhi7B+ypCTtfdQpB1gTJ+t6LoeRCDw3q/du9
 veGogO9+QnELjUujclatXUoiECQsxAscKyp3l2N/9gyblxjZMGpXEiBXTGg9jv5mub7HSrdhRwy
 WBs7+yK+kGYM5r/lTxpBb39hdFFb+d+muNt9YCsROL7c3V9L2N4IeA/suDD3FW0hkBb6d3WcwSD
 DcbEzT9LRwV3I20EHa+KV0YLMQZJFzw6ObI8iSknsoNSPIJBnk1e61sQBKcQUSDfXwDUBAVTGht
 ryLV4qC1RR2g2Jt4S0QhvOZN8b4qNbx9w=
X-Received: by 2002:a17:903:3847:b0:2cc:f4d4:29a0 with SMTP id
 d9443c01a7336-2d3b0c9938cmr215693745ad.3.1786964157373; 
 Mon, 17 Aug 2026 03:55:57 -0700 (PDT)
X-Received: by 2002:a17:903:3847:b0:2cc:f4d4:29a0 with SMTP id
 d9443c01a7336-2d3b0c9938cmr215693415ad.3.1786964156944; 
 Mon, 17 Aug 2026 03:55:56 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm5431136eec.23.2026.08.17.03.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:55:56 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v9 07/10] riscv: add RPMI system suspend service
Date: Mon, 17 Aug 2026 16:25:01 +0530
Message-ID: <20260817105505.2607506-8-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260817105505.2607506-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX5j0JJgKXkf95
 bwsu0CMh7x5a2Pz7PDTrenDGB1WbGp6VDlRnaiYwd3uU+bqUPBgjlPDBaV4jefhh6cd7V2F7DkI
 sIk2wGt48yaJ4f+UsfYcg0lMu5XCahE=
X-Authority-Analysis: v=2.4 cv=TK91jVla c=1 sm=1 tr=0 ts=6a82e8be cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=lod_E3DmNdtbfVLvUbsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: GIew3CczTA23052YeaVz7kz3uvcmPjP3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MSBTYWx0ZWRfX+SzbLxvDMnoo
 icU1JeYVGkw7qIekzejYWOB3UGDqzW9silPmSxjueMsKS9Mbj/wd5wFZ6Xi/VcxhOBWLcYqdtKV
 XkyxIte+JvALHUx/VEgWRlkT+6HQxEuFkfVx7Cn1FS0p6IQAb4lk5QfhYluubDsE2Hrhx70FxyF
 kSsxKq9ue5OVF2CNBekgu7IU3mI1PBmSFCD0Ez1XDs2LefhYcG+uvN7pn479uj/RJwGg0QoXpMw
 ZO4qMLb5MWRx7QcAb6ILV1qfCZV2UQIWV/z2/oFEL1AwUFOGs1tORG+hrUCEvsl2A272e5VyVxe
 AMkfmDEQqi1n5x++LRp7i9TN7nCx5+MsqQwQj7bQF7vRTPHmnG/pJhMruEIJkSUGhelgbbJ8xQB
 Ubj09TBGSKGH70jwinLGUMKEFevGGb7fyYRehKkEhWIAQyFn5lYiA4zuwDFONo59so2KuTsuN5L
 j/CdRb+LsgkcvFTl8dQ==
X-Proofpoint-ORIG-GUID: GIew3CczTA23052YeaVz7kz3uvcmPjP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170081
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the RPMI System Suspend service group for RISC-V virt.

The service advertises suspend-to-RAM support through librpmi,
registers QEMU wakeup support, and routes the suspend finalize callback
to the machine suspend path. On wakeup it processes RPMI group events
and defers the HSM hart resume until vCPUs are ready to run again.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |   4 +
 hw/misc/riscv_rpmi_hsm.c      |   9 +-
 hw/misc/riscv_rpmi_internal.h |   5 +
 hw/misc/riscv_rpmi_syssusp.c  | 191 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |  24 +++++
 include/hw/misc/riscv_rpmi.h  |  10 ++
 7 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a053242518..4ec78a34a1 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -175,4 +175,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
   'riscv_rpmi_hsm.c',
+  'riscv_rpmi_syssusp.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 01cc61d023..5b1e33c4a8 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -186,6 +186,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
         .service_group = RISCV_RPMI_SRVGRP_HSM,
         .add = riscv_rpmi_hsm_add,
         .remove = riscv_rpmi_hsm_remove,
+    }, {
+        .service_group = RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND,
+        .add = riscv_rpmi_syssusp_add,
+        .remove = riscv_rpmi_syssusp_remove,
     },
 };
 
diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
index 006ddc3b5a..037952dd22 100644
--- a/hw/misc/riscv_rpmi_hsm.c
+++ b/hw/misc/riscv_rpmi_hsm.c
@@ -235,7 +235,6 @@ static void riscv_rpmi_hsm_destroy(RiscvRpmiState *s)
     g_clear_pointer(&s->hsm_hw_states, g_free);
 }
 
-
 bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp)
 {
     struct rpmi_service_group *group;
@@ -278,3 +277,11 @@ void riscv_rpmi_hsm_reset(RiscvRpmiState *s)
         rpmi_hsm_process_state_changes(s->hsm);
     }
 }
+
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index)
+{
+    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STARTED);
+    if (s->hsm) {
+        rpmi_hsm_process_state_changes(s->hsm);
+    }
+}
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index 3b8546a553..56b46a66df 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -32,5 +32,10 @@ void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
 bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
 void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
 void riscv_rpmi_hsm_reset(RiscvRpmiState *s);
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index);
+
+bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_syssusp_remove(RiscvRpmiState *s);
+
 
 #endif
diff --git a/hw/misc/riscv_rpmi_syssusp.c b/hw/misc/riscv_rpmi_syssusp.c
new file mode 100644
index 0000000000..1773828757
--- /dev/null
+++ b/hw/misc/riscv_rpmi_syssusp.c
@@ -0,0 +1,191 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI System Suspend service.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "riscv_rpmi_internal.h"
+#include "qemu/timer.h"
+#include "system/runstate.h"
+
+static const struct rpmi_system_suspend_type riscv_rpmi_syssusp_types[] = {
+    {
+        .type = RPMI_SYSSUSP_TYPE_SUSPEND_TO_RAM,
+        .attr = RPMI_SYSSUSP_ATTRS_FLAGS_RESUMEADDR,
+    },
+};
+
+static enum rpmi_error riscv_rpmi_syssusp_prepare(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->register_wakeup_support) {
+        s->machine_ops->register_wakeup_support();
+    }
+    return RPMI_SUCCESS;
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_ready(void *priv,
+                                            rpmi_uint32_t hart_index)
+{
+    return true;
+}
+
+static void riscv_rpmi_syssusp_finalize(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->system_suspend) {
+        s->machine_ops->system_suspend();
+    }
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_can_resume(void *priv,
+                                                 rpmi_uint32_t hart_index)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->system_can_resume) {
+        return s->machine_ops->system_can_resume();
+    }
+
+    return true;
+}
+
+static enum rpmi_error riscv_rpmi_syssusp_resume(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    s->syssusp_resume_hart_index = hart_index;
+    s->syssusp_resume_pending = true;
+    return RPMI_SUCCESS;
+}
+
+static const struct rpmi_syssusp_platform_ops riscv_rpmi_syssusp_ops = {
+    .system_suspend_prepare = riscv_rpmi_syssusp_prepare,
+    .system_suspend_ready = riscv_rpmi_syssusp_ready,
+    .system_suspend_finalize = riscv_rpmi_syssusp_finalize,
+    .system_suspend_can_resume = riscv_rpmi_syssusp_can_resume,
+    .system_suspend_resume = riscv_rpmi_syssusp_resume,
+};
+
+static void riscv_rpmi_wakeup_timer(void *opaque)
+{
+    RiscvRpmiState *s = opaque;
+
+    if (s->syssusp_resume_pending) {
+        riscv_rpmi_hsm_resume(s, s->syssusp_resume_hart_index);
+        s->syssusp_resume_pending = false;
+    }
+}
+
+static void riscv_rpmi_wakeup_notify(Notifier *notifier, void *data)
+{
+    RiscvRpmiState *s = container_of(notifier, RiscvRpmiState,
+                                     wakeup_notifier);
+
+    if (s->context) {
+        rpmi_context_process_group_events(s->context,
+                                          RPMI_SRVGRP_SYSTEM_SUSPEND);
+    }
+    if (s->wakeup_timer) {
+        /*
+         * Wakeup notifiers run before vCPUs resume. Defer the HSM
+         * kick so OpenSBI can leave WFI after QEMU restarts execution.
+         */
+        timer_mod(s->wakeup_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 10);
+    }
+}
+
+static bool riscv_rpmi_syssusp_create(RiscvRpmiState *s,
+                                      struct rpmi_service_group **group,
+                                      Error **errp)
+{
+    if (!s->hsm) {
+        error_setg(errp, "RPMI system suspend service requires HSM service");
+        return false;
+    }
+
+    if (s->machine_ops && s->machine_ops->register_wakeup_support) {
+        s->machine_ops->register_wakeup_support();
+    }
+    if (!s->wakeup_timer) {
+        s->wakeup_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                       riscv_rpmi_wakeup_timer, s);
+    }
+    if (!s->wakeup_notifier_registered) {
+        s->wakeup_notifier.notify = riscv_rpmi_wakeup_notify;
+        qemu_register_wakeup_notifier(&s->wakeup_notifier);
+        s->wakeup_notifier_registered = true;
+    }
+
+    *group = rpmi_service_group_syssusp_create(
+        s->hsm, ARRAY_SIZE(riscv_rpmi_syssusp_types),
+        riscv_rpmi_syssusp_types, &riscv_rpmi_syssusp_ops, s);
+    if (!*group) {
+        error_setg(errp, "failed to create RPMI system suspend service group");
+        return false;
+    }
+
+    return true;
+}
+
+static void riscv_rpmi_syssusp_destroy(RiscvRpmiState *s)
+{
+    if (s->wakeup_notifier_registered) {
+        notifier_remove(&s->wakeup_notifier);
+        s->wakeup_notifier_registered = false;
+    }
+    if (s->wakeup_timer) {
+        timer_free(s->wakeup_timer);
+        s->wakeup_timer = NULL;
+    }
+
+    if (s->syssusp_group) {
+        rpmi_service_group_syssusp_destroy(s->syssusp_group);
+        s->syssusp_group = NULL;
+    }
+}
+
+bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp)
+{
+    struct rpmi_service_group *group;
+
+    if (s->syssusp_group) {
+        error_setg(errp, "duplicate RPMI system suspend descriptor");
+        return false;
+    }
+
+    if (!riscv_rpmi_syssusp_create(s, &group, errp)) {
+        return false;
+    }
+
+    if (!riscv_rpmi_context_add_group(s, group, "system suspend", errp)) {
+        s->syssusp_group = group;
+        riscv_rpmi_syssusp_destroy(s);
+        return false;
+    }
+
+    s->syssusp_group = group;
+    return true;
+}
+
+void riscv_rpmi_syssusp_remove(RiscvRpmiState *s)
+{
+    riscv_rpmi_context_remove_group(s, s->syssusp_group);
+    riscv_rpmi_syssusp_destroy(s);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e0c9ca4f5f..b92945f072 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -50,6 +50,7 @@
 #include "chardev/char.h"
 #include "system/device_tree.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/tpm.h"
@@ -1000,6 +1001,11 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
         .compatible = "riscv,rpmi-hsm",
         .service_group = RISCV_RPMI_SRVGRP_HSM,
     },
+    {
+        .node_name = "suspend",
+        .compatible = "riscv,rpmi-system-suspend",
+        .service_group = RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND,
+    },
 };
 
 static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
@@ -1017,9 +1023,27 @@ static void virt_rpmi_system_shutdown(void)
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
+static void virt_rpmi_system_suspend(void)
+{
+    qemu_system_suspend_request();
+}
+
+static void virt_rpmi_register_wakeup_support(void)
+{
+    qemu_register_wakeup_support();
+}
+
+static bool virt_rpmi_system_can_resume(void)
+{
+    return runstate_check(RUN_STATE_RUNNING);
+}
+
 static const RiscvRpmiMachineOps virt_rpmi_machine_ops = {
     .system_reset = virt_rpmi_system_reset,
     .system_shutdown = virt_rpmi_system_shutdown,
+    .system_suspend = virt_rpmi_system_suspend,
+    .register_wakeup_support = virt_rpmi_register_wakeup_support,
+    .system_can_resume = virt_rpmi_system_can_resume,
 };
 
 static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index 13a058a062..cb4f208ee8 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -29,6 +29,7 @@
 
 #define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
 #define RISCV_RPMI_SRVGRP_HSM            5
+#define RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND 4
 
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
@@ -42,6 +43,9 @@ struct rpmi_hsm;
 typedef struct RiscvRpmiMachineOps {
     void (*system_reset)(void);
     void (*system_shutdown)(void);
+    void (*system_suspend)(void);
+    void (*register_wakeup_support)(void);
+    bool (*system_can_resume)(void);
 } RiscvRpmiMachineOps;
 typedef struct RiscvRpmiServiceConfig {
     const char *node_name;
@@ -77,9 +81,15 @@ struct RiscvRpmiState {
     char *platform_info;
     const RiscvRpmiMachineOps *machine_ops;
     struct rpmi_service_group *sysreset_group;
+    struct rpmi_service_group *syssusp_group;
     struct rpmi_hsm *hsm;
     struct rpmi_service_group *hsm_group;
     uint32_t *hsm_hw_states;
+    Notifier wakeup_notifier;
+    bool wakeup_notifier_registered;
+    QEMUTimer *wakeup_timer;
+    bool syssusp_resume_pending;
+    uint32_t syssusp_resume_hart_index;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
-- 
2.43.0


