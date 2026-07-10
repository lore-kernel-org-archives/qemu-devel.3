Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDC2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAsD-0006r9-15; Fri, 10 Jul 2026 09:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiArH-00067v-1C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiArD-00061z-5h
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AAnFps616904
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qFuBB0Bw7YS
 tlxeNVzx+8nAmHvyJXWpNlRBHLBri/AU=; b=F6BVtdXuAfKJIqSN/gaUyvdeIDI
 0Oaf+MJiNsoCUkSmp6cfQFqStBodymtyCdabjdb+KypJu3YaCjw1FF8ryxVepaWu
 7rYGukqadEKdB8gbzhD8ygabbtrBhKxa5BfgGszCVeLhi3feTr9fjWU4uGkGewb6
 m7MFgDyW60JhhqjFrG9fbizx8pkIujUaoReLxJEHBeZ5MhDYxvkCIF3yNPtc0eZK
 mELOdpYmA8BDWatm0amD9JuNbUmBVi7Js1d6E4tcVK2rbNsnjnWtG6nzU3NfIbjv
 5dC+/flXry/n76SxmoD3RvogVgxvCG4rQz4dimCE6fVkC+R8UB4tEfSIafg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n1x96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37fec882754so242736a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783688489; x=1784293289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qFuBB0Bw7YStlxeNVzx+8nAmHvyJXWpNlRBHLBri/AU=;
 b=KwoRmXkKqiSOn97sHPlLwWa0XdgoA/zPwH06FUjotZOOskb9tu5iHDxFD6A7Snu74W
 6lfu/Qaf63d8HD5Nadio1AQ/k4zp41oD/cdpLk24DHiKRI1cpdtkl1zzq7ckg95d11p3
 igM92ZDnYdCEpoSw/r4gtb/hP6lYLOGfoDLEHzUJxqAbUVIluT0V0OB+vp+tpGpJMgFb
 6LxvEzTJ/scuI5Zyu3Ms2vJsl6kXIVdV6TeixGioP/Qbkh2OtnkIjGWn7o6u9+FkcUFe
 gL5aAgmKbJeWopwcg0OJ8looLJb9D6YEXtOLfjtG04eGRm1uDkOsl6jK4DVKz26W5rtT
 us0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783688489; x=1784293289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qFuBB0Bw7YStlxeNVzx+8nAmHvyJXWpNlRBHLBri/AU=;
 b=DVN3Oyf1/mnBWwuLFcx77CQfpMQIRMNNYho9TpU6gz5Cly7jfHoDROCtEVBJyDnfxT
 GjP+xUUgqoUn1G4AGoScBo+00DQFHpQ0ghvliOSWepBVHCjYANSEeOykLyKYlrQuRs2J
 32MIs+hOF4G6/G/fKdka7DxlwXIliokgYVOqWQtb7Oeh6TDeFsLnwJPuWVubX0WseeKM
 /XBO32z0yhL68l0Tccgf/F83B97bZPyl7vRqlOTbn/bAyc9OWIxENbtQXv7vzh8lw3D6
 ozV3ic0BYiFQZQrVs3ZEJuBXkiWNQcYyybOmEKIWZ4K106JOSnJg3pVrU9d2itHlq/40
 01Og==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOLeN2HBnvH6U0mIZstT1brz5+imO+6nsSzAF5d5+fpyXSULkC4JtrU1+YymAW/8jM1pNdR/1WJvMv@nongnu.org
X-Gm-Message-State: AOJu0Yy3KTtn5AkZpSZr4wvoSAPJPO+kiA9OE4Q6pZ57zT+5Rc6tEftX
 AiSAfsSgdhPsxlxQt26rz4d75Jt0n1STIdrCc5ifG5/aimo+p6cz/AdMEyAU4rwVcMlP1zZ2rmU
 wFqF66uXYRBrBw0Rr6A6xyX+NnLPkkyqsxRLWwl0Zlx0KE09GbaFrnfz9Tg==
X-Gm-Gg: AfdE7clnyQ1xAzy/ySuyr1GgFGjPqCguX+hedZ6VLOieV8gysveoYrtCI3xY9cds+j2
 eOCDLf9DQWrRrXa8uWiEB1+4eoWo+rMLrnJZGjx+qH3RYMJpu5So8aK6Co23MlEsv0wk+gWKEmh
 DONX0uTYZsYTOTPXrCjsMDtM4UA//p1GsKbFONZJOSTTBBiW6QyNFz2YdMaxUDrD76hjUcR5YYx
 euCDzC88PFzd2ptD5vrBjJwQrON5I/kfybqtOZHu2p2SWfSLmJ2DUCJaNF8z0dE/FjMfIbj5Sot
 0Mir1ayQwJlhbpLHGvBdstHWXq6ObPerfR3N2QUrdM/n9rgastpyQ7dx/qXrEQ6Af99YdN2rwMa
 EbFgECA/3l/rwpW4h7bfOHo6W9vz/frJ+R+7KNXGNah4OreTAJM/oVw2yPjRijiPShLrjGmHzAk
 +tSTauRm+dtJElExy+SeTNbfGb41zZ71vwfmETSzIX6Q==
X-Received: by 2002:a17:90b:53d0:b0:37f:ea8e:ab79 with SMTP id
 98e67ed59e1d1-38a1f1dd647mr7229415a91.2.1783688488968; 
 Fri, 10 Jul 2026 06:01:28 -0700 (PDT)
X-Received: by 2002:a17:90b:53d0:b0:37f:ea8e:ab79 with SMTP id
 98e67ed59e1d1-38a1f1dd647mr7229346a91.2.1783688488137; 
 Fri, 10 Jul 2026 06:01:28 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm9611839eec.6.2026.07.10.06.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:01:26 -0700 (PDT)
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
Subject: [PATCH 07/10] riscv: add RPMI system suspend service
Date: Fri, 10 Jul 2026 18:30:41 +0530
Message-ID: <1362f2b24fc65169cf916bd3be4ef107f8d0c000.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfX2pIQ//Mr3z5v
 46LK9QFryp6TJMcXiw0lidDE4TtZ+bhzY86aBWfsvu86U3EWdSb19stSTRKflO/nSCCj/BTfw90
 bAX3GYP4YUs88c3Q1VlHBFce8AKAcRA=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50ed2a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=YpNgDGc-obDsCk2VH-MA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: McnxlZDtysyG5BcLqpkLtFog81J2N6OL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfXzTpj1VzIw0BP
 k/Q/AryV0RB40LFnlUT4v3RUjICFyTGi853mvg5X92UYFb1PqzTbTpVVWs7yNpxmvy0RfIJIWt0
 dAYgNpYRqSOEOYUme/raZjvqn7FnJHmlbGELuNUITaS15owDuMfS+0LIkyvjE/VtKq/wvxA7yZL
 KFRUuNsYeJGq+eF5iQkriWQuX+/F0pqnnmiEq7hdCJzWkWa4k16yhM42a1GZ9OlQ2xaCpYnzdMm
 LWX5cox8gOXfOk5LNIaFy4hCaGdlTs1sAB3K5jkLCOw6VV2kuP0S3F10VS7xIDeu6yqXwo4SnW6
 0yILkRZhvAT2JrIt01b0BEX373yBcnyEF7zJtANWMTGpvWQ553hYof8y+/JpkxWLEcBMaVOKbre
 q/3VrJd+4BTST+MtH8FugLt1bLMhbBULA/sUwmqMw8Rg6OEdzzmydTGuyJeD7ZSdxdaiGjxI3Mz
 3D530AUXwFyfCSe8zDQ==
X-Proofpoint-GUID: McnxlZDtysyG5BcLqpkLtFog81J2N6OL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100129
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
Message-ID: <20260710130041.AaKUDggVCwJtrvt8Ez8D6ElcIjgwHsEFbt8C6vGXvvI@z>

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Add the RPMI System Suspend service group for RISC-V virt.

The service advertises suspend-to-RAM support through librpmi,
registers QEMU wakeup support, and routes the suspend finalize callback
to the machine suspend path. On wakeup it processes RPMI group events
and defers the HSM hart resume until vCPUs are ready to run again.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |   4 +
 hw/misc/riscv_rpmi_hsm.c      |   9 +-
 hw/misc/riscv_rpmi_internal.h |   5 +
 hw/misc/riscv_rpmi_syssusp.c  | 191 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |  25 +++++
 include/hw/misc/riscv_rpmi.h  |  11 ++
 7 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fc5b11ed57..cb093a8642 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -172,4 +172,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
   'riscv_rpmi_hsm.c',
+  'riscv_rpmi_syssusp.c',
 ), librpmi])
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 820b1d5d63..08691861b0 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -187,6 +187,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
         .kind = RISCV_RPMI_SERVICE_HSM,
         .add = riscv_rpmi_hsm_add,
         .remove = riscv_rpmi_hsm_remove,
+    }, {
+        .kind = RISCV_RPMI_SERVICE_SYSSUSP,
+        .add = riscv_rpmi_syssusp_add,
+        .remove = riscv_rpmi_syssusp_remove,
     },
 };
 
diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
index 9a9859b10c..bacdabcac6 100644
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
index 42a6708907..34cab35c32 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -33,5 +33,10 @@ void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
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
index 0000000000..d455e08163
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
+        s->machine_ops->register_wakeup_support(s->machine_opaque);
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
+        s->machine_ops->system_suspend(s->machine_opaque);
+    }
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_can_resume(void *priv,
+                                                 rpmi_uint32_t hart_index)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->system_can_resume) {
+        return s->machine_ops->system_can_resume(s->machine_opaque);
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
+        s->machine_ops->register_wakeup_support(s->machine_opaque);
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
index 2b5f367bdb..21c218a78d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -51,6 +51,7 @@
 #include "chardev/char.h"
 #include "system/device_tree.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/tpm.h"
@@ -1020,6 +1021,12 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
         .compatible = "riscv,rpmi-hsm",
         .service_group = RISCV_RPMI_SRVGRP_HSM,
     },
+    {
+        .kind = RISCV_RPMI_SERVICE_SYSSUSP,
+        .node_name = "suspend",
+        .compatible = "riscv,rpmi-system-suspend",
+        .service_group = RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND,
+    },
 };
 
 static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
@@ -1037,9 +1044,27 @@ static void virt_rpmi_system_shutdown(void *opaque)
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
+static void virt_rpmi_system_suspend(void *opaque)
+{
+    qemu_system_suspend_request();
+}
+
+static void virt_rpmi_register_wakeup_support(void *opaque)
+{
+    qemu_register_wakeup_support();
+}
+
+static bool virt_rpmi_system_can_resume(void *opaque)
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
index 37c56ea2e8..a4fe2aac63 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -29,6 +29,7 @@
 
 #define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
 #define RISCV_RPMI_SRVGRP_HSM            5
+#define RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND 4
 
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
@@ -43,11 +44,15 @@ typedef enum RiscvRpmiServiceKind {
     RISCV_RPMI_SERVICE_INVALID = 0,
     RISCV_RPMI_SERVICE_SYSRESET,
     RISCV_RPMI_SERVICE_HSM,
+    RISCV_RPMI_SERVICE_SYSSUSP,
 } RiscvRpmiServiceKind;
 
 typedef struct RiscvRpmiMachineOps {
     void (*system_reset)(void *opaque);
     void (*system_shutdown)(void *opaque);
+    void (*system_suspend)(void *opaque);
+    void (*register_wakeup_support)(void *opaque);
+    bool (*system_can_resume)(void *opaque);
 } RiscvRpmiMachineOps;
 typedef struct RiscvRpmiServiceConfig {
     RiscvRpmiServiceKind kind;
@@ -86,9 +91,15 @@ struct RiscvRpmiState {
     const RiscvRpmiMachineOps *machine_ops;
     void *machine_opaque;
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


