Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEp-0006XY-Mg; Fri, 10 Jul 2026 08:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lP-0000O4-3o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lM-0004AS-TF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSD23848797
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qqexeTU5rC0
 F3XG2W/BVlfxGTL9faWmCVU3vE/quGCk=; b=ixksy8bzLJx14SFhgK/BvjzDvxo
 FIvU+am0aCG0i7XxnxmxJK677gMyVo5huMvW3m0dMGmAZ2FQTpz1sRNH+hBvQhFi
 Q8ms0XJdtljuuiEKnpFIQPoPYZASbehKBbzQQMcxueRvZK0qGaIWP8T/pwh/HoXt
 qJKb2MpP2lps/QU38jG9H4mCN8hsDtG4OOE1Cvj1BQQzAiN7KjMFxQasSje0tzK/
 1yiJgeoRGOYluNqZxgcq2fj+G2p68nTryQOVqQImcOFUBRGdZ/POMhedziBJLoQ3
 IDo7EzEBA7e7a+UsOcC7DPxQLe1pj2TDXQ+6vRRimOxMiXzgTmbdvEpakEg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeestu9w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cc98d6a88bso1721275ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661219; x=1784266019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qqexeTU5rC0F3XG2W/BVlfxGTL9faWmCVU3vE/quGCk=;
 b=jv5+ZtkxbNzC4K9tl+IQFT9RyzLGmC/kxMauQyT6seC9Ulq2Qv+o+lV7JtucTFikMg
 gFqi07NWaAQZjmKbrLldM8kDGwHR/VgCq4xCx8PTFggQyO6XWqlojmTx/QMPO6k0Gd7q
 4OmKwZMfXvoFWrbTyn2HD2K5zTgb0IZW/Kr8zRRsqzOkElswPRXxgdwjRVoDVDzL06um
 DXmOij5Upr2dXnLB2eYhcm379m/NhlNnC6xksDtha6r9g16MQQgaxQjaSYxdaN1QJWe9
 KXm7/SxB5ZB+UUC32pOIrUvIZomQ9J9n1l2k330HmCv430A63kOvy4E55GF9jhEIObFw
 vmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661219; x=1784266019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qqexeTU5rC0F3XG2W/BVlfxGTL9faWmCVU3vE/quGCk=;
 b=XXr5x1uuTrlquB7l+0ynn9gkVp4UfplN2H0+ux3rpEtFQhNrLAMTPGYyp5+rNoMy+P
 FYrmXSWy/OBGKt6T+ds8+J0XbNuABWsHcjIKKmA542FyuH47uhH6GmiI92666YWS3cF1
 8aVZV+iObl10A5OxLz74LKz18jPQKvBYoQziflY1AYbMRWBHnMShGeb+tpqcTktdBd+0
 g3SnEF3eYM8FlKM3YWTqTqK5h474S1n0eF7MWKzhJNYR9csy/voUYLiMjPWy3HgJLM+n
 iifmYx3nibzN6DwCpQQxvuvhmFrmBp5VQ1SXs9EBZDCCp0ZzIb/QbHOIB6c8kmVEkonL
 aixg==
X-Gm-Message-State: AOJu0YwD0J7iV+4XIwLSoEAc4csGw4tZ/2kNtUF47sH2WQbIXJ7a9wFm
 PX4nYmlZHJp8ZwvMdrqseAbpwZTnHC2GGcUvw4ucWcJWO++9wfQz2IPZ90lkTWKjP3dmt8/h9fc
 HkboJ2x+4lYxd2ZTdT2nTLQfVLPMfwSRFRHWWusj2+y5+zztjmxKIWxAS+uUgMcaj7g==
X-Gm-Gg: AfdE7cmoGSOV8/vRHUfFKxX3K017MQqlk7WGGHpan66OhGWy4CjpJgXLVTWrav9PyyT
 ozqGO+WazxJrfQUknf41q7s8gztfxNCnCyOchwM6Zy/05HpIpbagrDdhadqF3JY18GEtsnVDzKg
 ptbUFMrj0eHFSvLt69P1kGxauUsmCRo4mnbp2GuzlOFQSLiLDQmRYXgjFU01fwypMXeHak3r2dU
 nOHDbK0xEPme9w7kvs29L55d/o7zkMl6KkuAK+Q2v7qFwlme8X2CYSahyDO4GOdriyDcVHmWaUn
 A/wwcadJYmKxUE969isnIP/DCJreoJfsKnIGUfTte4oMfq7xu9LDSDMheKuttaJcnNF8Ja1Yhiv
 QPBMnukpSG8yFDqcVcIS5zU/FWcQITUOy4P/U1LfCF6d8HhPq7SEt2KboSej/XQ1/WIXR4GSR4h
 s165S1/I0QRa+9Ir042vFIoF3+AC+0NjsuclAWnqefbQ==
X-Received: by 2002:a17:903:244a:b0:2ca:d9ec:3217 with SMTP id
 d9443c01a7336-2ccff1b9995mr56856475ad.7.1783661218791; 
 Thu, 09 Jul 2026 22:26:58 -0700 (PDT)
X-Received: by 2002:a17:903:244a:b0:2ca:d9ec:3217 with SMTP id
 d9443c01a7336-2ccff1b9995mr56856215ad.7.1783661218156; 
 Thu, 09 Jul 2026 22:26:58 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.26.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:26:57 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/10] riscv: add RPMI system suspend service
Date: Fri, 10 Jul 2026 10:56:39 +0530
Message-ID: <1362f2b24fc65169cf916bd3be4ef107f8d0c000.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xNr_pmgtaYh72RqHOZzsTdySP9uEdPJA
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a5082a4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=YpNgDGc-obDsCk2VH-MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX/cUwcd4DDkfV
 93FojbTAcBf61EXOF3ST4VPpK4dohzkEq8aApWblj+VrbbFrBQReuntvz+UvDrMFjFnLdRbqDtr
 uJbu2qKt+7PJyzCMXHjQp4T3mbrL7sc=
X-Proofpoint-ORIG-GUID: xNr_pmgtaYh72RqHOZzsTdySP9uEdPJA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX4CsUJZRjK0Tc
 APyZd2sAcUk6sshsnSlrf6lHmyrANPf5qN2vfkYNHzIApg71aE/v1qgZTTnYpadY8Ccn03uyK3s
 1mdDCnD2zM+2OuulidZgoeitn52FOXGaXmpMKCOzzqQdxa7BkIxRvgHQm+64vRyjg9PLVOfJKkU
 xueliYVwchNfCc6kpNEEk7/4u/ErgGRe8YYdmNEiZosEgvBptL0z+bfcvAw1t9zgW5QOYBdKPbA
 xMd0ISLBcxmJsJ/Qc7fDrrHnG/Epbs59IS/WvIQv8xN+8xCyKofKFNZPlPCGgC7PjHxrrNHQolG
 NTVuiuN8X5MtN7AQtfd2aZIedMGIh5qMl96JyqTYxAZvuPbwwWyY4dCagUK86I3Q1Tt30L8SkGP
 I82fn2cK+vhbgUycCWMwuOy2XHSrMnKR3OPCGKBERiQsrCU7yhutDfR+RmzBNA6sBDCQziY8bGY
 Fs74cvBwcNLehZLhZzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
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

Add the RPMI System Suspend service group for RISC-V virt.

The service advertises suspend-to-RAM support through librpmi,
registers QEMU wakeup support, and routes the suspend finalize callback
to the machine suspend path. On wakeup it processes RPMI group events
and defers the HSM hart resume until vCPUs are ready to run again.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
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


