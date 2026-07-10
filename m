Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF00C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEl-0006Wu-Dr; Fri, 10 Jul 2026 08:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lM-0000Ne-Na
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lJ-00049v-P7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSrX3803809
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iicBHwDC6ZK
 Ex55TqmOMP0bLP6MIfmn8Fv+QWMV91Ug=; b=ingt5gMOyGlmG2HwYZ18P4KLFcv
 FMd0RIil0UbUwnBg2xyHJeBGOHjB4iTevbSSq3c+3Yho2ueeCiMHrEsrvZ7julGB
 1AUR2MZCSLoo4hCOAwrGtLUkAUt37VdAPovCnc3geWekMLPyAMU+1YBcESgqZHvy
 BGPINztVspDQg2l6UvfOmk/OIByu/gyvwu3RqMgBYhDGDxt8s15vEVtlBmB5zLIL
 J+36RmRwDnL+ivuaetacNkc2d5KLVsXK7WMChHvm7WAmLHxjK3XdyyPZGB4gJ6Z4
 vYhp9mv9XAnRNrloDNPsYPtLD+H6Me8tnc0KLwj4fFnwQdaSwfiHCdmopjw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtm1a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:26:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc620652bfso1557525ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661215; x=1784266015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iicBHwDC6ZKEx55TqmOMP0bLP6MIfmn8Fv+QWMV91Ug=;
 b=N5sAS0RAXFwQSu/KHGuYEQEz/XskUmj7VkmPAEFOhaDc1brNyrmHRM5BsbbonFUj8w
 llp5r1sJjBVZ/ZaHmPkQkBnULIxyfIx4AdApc+xDQynr6rnHyTeq5Jy4kwofLI2mECmv
 yVPz0W5WzNgeN5PvxuMNhpq3qMhxmP87+s0YgESKFzOvXBk6yADBeEs42fKKI4w46oJc
 OZ7QQvQK35Y8ngFTgU7sy+o+TIiFCC7roLCVK81/bmVf5xA4Gn7SsDpcwt5HUBqKdvju
 vv7aI9YGWt3jD9wF/bbv3KJbqa+8YlaXt5QaAcMSAdVbn4dtMEiJVzyNPC6faVvR3NrY
 IE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661215; x=1784266015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iicBHwDC6ZKEx55TqmOMP0bLP6MIfmn8Fv+QWMV91Ug=;
 b=WNC7iX/xZNncAIs7xhO4/rcZdOJLj2sy+DWm1Cn0zpw0bToGw6zGMHxhlh1DNBBBCM
 swweqsUvCx2KmSVE0ZzG53L2+Mq6QBE/NfbQGYGRAdyhM5qlu40JYavJg3a1J6YJUr8Z
 Zn2TaYHRsyW/mZCN3JMYrqlrWD/taLpaBbDufD1+7SCoziabLRgThOaP8Su1n7FFoVY8
 MEWrdhfz4LSOSpbd7dK485Zh8SL7/8yDOkN1wsAdC9pGrW5alyo5+fcFnIDbGt+yF6//
 +xxWdKml0BEl0bM3ffcKearMfoep+Ejo4laceOmCMeyCWGc4ER3+SbiMc3eaa1k7eIKr
 bo6A==
X-Gm-Message-State: AOJu0Yzx5c4vwC/nm4YjzXdyY5d7jt7Sf4G0nFtYRW9bMGzNfc8tNmNK
 bRyX2G44or+AEUJuXIQHL/+xCwYW9ECGkpRwGr7S9m1bxACvhFa2uqOOQ8w+rDxf2vTfazXPpbn
 0K1HmOEB8cPTTlABpYoE8ohFs+n7m8MQePO2VR2reyKycqr1J484vz1fXke1Ndn0u6Q==
X-Gm-Gg: AfdE7clwd4hVWwqHYb+PEpcPcHo1Jwcpl2VKqJZEF+/7stBUV9tZzpOoB4ss1VDaUDD
 8wMm2OrQKTFxMTVcQRpVxZd+Hxt2HATQB5M1PuhYXaLWZ4Qmc30AaawkYl8PzMxtBx64r35aIt6
 Fm8AvJaTNDw7ZDzrQonvqTvPSP3HRz3Yo5fUTs1wS6xECfgYF4mk+M0aDRqDHss7dKSHsxHDI/w
 NbKZUtJW99yXMuu8bWnM4SK660fac189iBV8Bi54+rByktX8MB81LXBHylYe9kENoJ5IjBot8IK
 t8LSc2Bl1gcBIoV4CklP2y/Rqk+arebymVCjhj+RyrwMmAQvFgskQfjVkyY00WU2gTQWnhlEyVb
 itt6My6Lyk0Cr7O4mvP2wRyqhJYnHjbT/RsaQ4m57AVtdH1Pw6vxVhAnd88o5KqX527I+lpF9tH
 iTiotOC+wcL96gakGczi9uy76pM+Eiaknramcskmx0yw==
X-Received: by 2002:a17:902:e94d:b0:2cc:9d9:b8df with SMTP id
 d9443c01a7336-2ccff2d2fb5mr56383075ad.5.1783661215426; 
 Thu, 09 Jul 2026 22:26:55 -0700 (PDT)
X-Received: by 2002:a17:902:e94d:b0:2cc:9d9:b8df with SMTP id
 d9443c01a7336-2ccff2d2fb5mr56382815ad.5.1783661214738; 
 Thu, 09 Jul 2026 22:26:54 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.26.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:26:54 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] riscv: add RPMI system reset service
Date: Fri, 10 Jul 2026 10:56:37 +0530
Message-ID: <febceb0b735f4db2e9d5348c864f51ebedc30ee5.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: w0DuEgEZG304tfZDV0ZxtwDMaRXKB5jY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX69GTvsmKhgTF
 r7lW/ZBIjKIhJGYw2Ms05iN2AvosrJw1E9cVFqquRcF/HBw/dgp0fdbRborEQrnhtdo7XlBvZSq
 GBj0DphM23/7c4Zj/pDKB0K1f8i0Dak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX7Y/hM7XzbONH
 V0r9fS7uNLJzkb3scnsPzS6V9/y08pR6VBdIi9cnlD5+5jjbi9CpeBNDi2hbrYNNZNfUz5micG0
 dZMAlaKQmFOzd7pqXWPFw+3qjYTPIuzgiKFjzjCVO6vJAPoDd+AKkd/gIzh8R0Qm1uns67c5H1Y
 sx4nDKdCtsB82/9dueo3IbsYWKmA8yu27m4Ajx9CI8z9V9HG0FiUuLRsNL8oxANOXXh3Ky+SNJl
 uPSqsWOQiApR+3zV37hidKpCva97Qxgz3DiKHPNiB0BfCAfKKOxf/DN1U18QXaLLg7XARkbFgWg
 M9cogBYPJAdiT8xb2Yd8LyKAavxf5Z97TzbCExndXvqFDVRJwUGgd2ub57v9RlfFMc592TZOmAp
 RTohJ/Psp5nkgnm4rTEAsug3WCggcj0MSd2P3uFhXtHTgrFtx5/pQg3ARnpGTji3iohtNHDYwVW
 Ez7WKl6T2DqLSDaR3lw==
X-Proofpoint-GUID: w0DuEgEZG304tfZDV0ZxtwDMaRXKB5jY
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a5082a0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=blQ9iIGB7deKtsPWDqUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
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

Add a QEMU implementation of the RPMI System Reset service group.

The service advertises shutdown and cold reboot reset types, validates
guest requests, and dispatches accepted requests through the machine
reset and shutdown callbacks. This lets firmware use RPMI reset commands
while keeping the board-specific reset policy in the RISC-V virt machine.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |  38 ++++++-
 hw/misc/riscv_rpmi_internal.h |   9 ++
 hw/misc/riscv_rpmi_sysreset.c | 206 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |  40 +++++++
 include/hw/misc/riscv_rpmi.h  |  13 ++-
 include/hw/riscv/rpmi-fdt.h   |  11 ++
 7 files changed, 313 insertions(+), 5 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e7c2ebe28f..bca7819ee0 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -170,4 +170,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
+  'riscv_rpmi_sysreset.c',
 ), librpmi])
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index c4b115b659..7a3f570ee7 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -175,6 +175,8 @@ static void riscv_rpmi_configure_base(RiscvRpmiState *s,
                                       const RiscvRpmiConfig *cfg)
 {
     s->platform_info = g_strdup(cfg->platform_info);
+    s->machine_ops = cfg->machine_ops;
+    s->machine_opaque = cfg->machine_opaque;
     s->services = cfg->services;
     s->service_count = cfg->service_count;
 
@@ -211,7 +213,9 @@ static void riscv_rpmi_reset(DeviceState *dev)
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
 {
-
+    for (uint32_t i = ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) {
+        riscv_rpmi_service_ops[i - 1].remove(s);
+    }
 
     if (s->context) {
         rpmi_context_destroy(s->context);
@@ -247,6 +251,30 @@ bool riscv_rpmi_service_enabled(RiscvRpmiState *s, RiscvRpmiServiceKind kind)
     return false;
 }
 
+bool riscv_rpmi_context_add_group(RiscvRpmiState *s,
+                                  struct rpmi_service_group *group,
+                                  const char *name,
+                                  Error **errp)
+{
+    enum rpmi_error rc;
+
+    rc = rpmi_context_add_group(s->context, group);
+    if (rc != RPMI_SUCCESS) {
+        error_setg(errp, "failed to add RPMI %s service group: %d", name, rc);
+        return false;
+    }
+
+    return true;
+}
+
+void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
+                                     struct rpmi_service_group *group)
+{
+    if (s->context && group) {
+        rpmi_context_remove_group(s->context, group);
+    }
+}
+
 static bool riscv_rpmi_validate_config(RiscvRpmiState *s, Error **errp)
 {
     uint64_t queue_bytes;
@@ -318,11 +346,15 @@ static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
                                          const RiscvRpmiServiceConfig *service,
                                          Error **errp)
 {
-    switch (service->kind) {
-    default:
+    const RiscvRpmiServiceOps *ops;
+
+    ops = riscv_rpmi_service_ops_by_kind(service->kind);
+    if (!ops) {
         error_setg(errp, "unsupported RPMI service kind %d", service->kind);
         return false;
     }
+
+    return ops->add(s, errp);
 }
 
 static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index 447c0acb55..fe09804e69 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -20,5 +20,14 @@
 extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
 bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
                                 RiscvRpmiServiceKind kind);
+bool riscv_rpmi_context_add_group(RiscvRpmiState *s,
+                                  struct rpmi_service_group *group,
+                                  const char *name,
+                                  Error **errp);
+void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
+                                     struct rpmi_service_group *group);
+
+bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
 
 #endif
diff --git a/hw/misc/riscv_rpmi_sysreset.c b/hw/misc/riscv_rpmi_sysreset.c
new file mode 100644
index 0000000000..da6ef4c566
--- /dev/null
+++ b/hw/misc/riscv_rpmi_sysreset.c
@@ -0,0 +1,206 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI System Reset service.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "riscv_rpmi_internal.h"
+#include "qemu/log.h"
+#include "librpmi_env.h"
+
+typedef struct RiscvRpmiSysresetType {
+    uint32_t type;
+    void (*action)(RiscvRpmiState *s);
+} RiscvRpmiSysresetType;
+
+typedef struct RiscvRpmiSysresetGroup {
+    struct rpmi_service_group group;
+    struct rpmi_service services[RPMI_SYSRST_SRV_ID_MAX];
+    RiscvRpmiState *rpmi;
+} RiscvRpmiSysresetGroup;
+
+static void riscv_rpmi_sysreset_reboot(RiscvRpmiState *s)
+{
+    const RiscvRpmiMachineOps *ops = s->machine_ops;
+
+    if (ops && ops->system_reset) {
+        ops->system_reset(s->machine_opaque);
+    }
+}
+
+static void riscv_rpmi_sysreset_shutdown(RiscvRpmiState *s)
+{
+    const RiscvRpmiMachineOps *ops = s->machine_ops;
+
+    if (ops && ops->system_shutdown) {
+        ops->system_shutdown(s->machine_opaque);
+    }
+}
+
+static const RiscvRpmiSysresetType riscv_rpmi_sysreset_types[] = {
+    {
+        .type = RPMI_SYSRST_TYPE_SHUTDOWN,
+        .action = riscv_rpmi_sysreset_shutdown,
+    }, {
+        .type = RPMI_SYSRST_TYPE_COLD_REBOOT,
+        .action = riscv_rpmi_sysreset_reboot,
+    },
+};
+
+static const RiscvRpmiSysresetType *riscv_rpmi_sysreset_type_by_id(
+    uint32_t reset_type)
+{
+    for (uint32_t index = 0; index < ARRAY_SIZE(riscv_rpmi_sysreset_types);
+         index++) {
+        if (riscv_rpmi_sysreset_types[index].type == reset_type) {
+            return &riscv_rpmi_sysreset_types[index];
+        }
+    }
+
+    return NULL;
+}
+
+static void riscv_rpmi_do_system_reset(RiscvRpmiState *s,
+                                       rpmi_uint32_t reset_type)
+{
+    const RiscvRpmiSysresetType *type;
+
+    type = riscv_rpmi_sysreset_type_by_id(reset_type);
+    if (type) {
+        type->action(s);
+        return;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: unsupported reset type %u\n",
+                  __func__, reset_type);
+}
+
+static enum rpmi_error riscv_rpmi_sysreset_get_attributes(
+    struct rpmi_service_group *group, struct rpmi_service *service,
+    struct rpmi_transport *trans, rpmi_uint16_t request_data_len,
+    const rpmi_uint8_t *request_data, rpmi_uint16_t *response_data_len,
+    rpmi_uint8_t *response_data)
+{
+    uint32_t reset_type = ldl_le_p(request_data);
+    uint32_t *resp = (uint32_t *)response_data;
+
+    *response_data_len = 2 * sizeof(*resp);
+    stl_le_p(&resp[0], RPMI_SUCCESS);
+    stl_le_p(&resp[1], riscv_rpmi_sysreset_type_by_id(reset_type) ?
+             RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE : 0);
+
+    return RPMI_SUCCESS;
+}
+
+static enum rpmi_error riscv_rpmi_sysreset_do_reset(
+    struct rpmi_service_group *group, struct rpmi_service *service,
+    struct rpmi_transport *trans, rpmi_uint16_t request_data_len,
+    const rpmi_uint8_t *request_data, rpmi_uint16_t *response_data_len,
+    rpmi_uint8_t *response_data)
+{
+    RiscvRpmiSysresetGroup *sysreset = group->priv;
+    uint32_t reset_type = ldl_le_p(request_data);
+    uint32_t *resp = (uint32_t *)response_data;
+
+    *response_data_len = sizeof(*resp);
+
+    if (!riscv_rpmi_sysreset_type_by_id(reset_type)) {
+        stl_le_p(resp, (uint32_t)RPMI_ERR_INVALID_PARAM);
+        return RPMI_SUCCESS;
+    }
+
+    stl_le_p(resp, RPMI_SUCCESS);
+    riscv_rpmi_do_system_reset(sysreset->rpmi, reset_type);
+    return RPMI_SUCCESS;
+}
+
+static const struct rpmi_service riscv_rpmi_sysreset_services[] = {
+    [RPMI_SYSRST_SRV_ENABLE_NOTIFICATION] = {
+        .service_id = RPMI_SYSRST_SRV_ENABLE_NOTIFICATION,
+        .min_a2p_request_datalen = 8,
+    },
+    [RPMI_SYSRST_SRV_GET_ATTRIBUTES] = {
+        .service_id = RPMI_SYSRST_SRV_GET_ATTRIBUTES,
+        .min_a2p_request_datalen = 4,
+        .process_a2p_request = riscv_rpmi_sysreset_get_attributes,
+    },
+    [RPMI_SYSRST_SRV_SYSTEM_RESET] = {
+        .service_id = RPMI_SYSRST_SRV_SYSTEM_RESET,
+        .min_a2p_request_datalen = 4,
+        .process_a2p_request = riscv_rpmi_sysreset_do_reset,
+    },
+};
+
+static struct rpmi_service_group *riscv_rpmi_sysreset_create(RiscvRpmiState *s)
+{
+    RiscvRpmiSysresetGroup *sysreset;
+    struct rpmi_service_group *group;
+
+    sysreset = g_new0(RiscvRpmiSysresetGroup, 1);
+    sysreset->rpmi = s;
+    memcpy(sysreset->services, riscv_rpmi_sysreset_services,
+           sizeof(riscv_rpmi_sysreset_services));
+
+    group = &sysreset->group;
+    group->name = "sysreset";
+    group->servicegroup_id = RPMI_SRVGRP_SYSTEM_RESET;
+    group->max_service_id = RPMI_SYSRST_SRV_ID_MAX;
+    group->servicegroup_version =
+        RPMI_BASE_VERSION(RPMI_SPEC_VERSION_MAJOR, RPMI_SPEC_VERSION_MINOR);
+    group->privilege_level_bitmap = RPMI_PRIVILEGE_M_MODE_MASK;
+    group->services = sysreset->services;
+    group->lock = rpmi_env_alloc_lock();
+    group->priv = sysreset;
+
+    return group;
+}
+
+static void riscv_rpmi_sysreset_destroy(struct rpmi_service_group *group)
+{
+    if (!group) {
+        return;
+    }
+
+    rpmi_env_free_lock(group->lock);
+    g_free(group->priv);
+}
+
+bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp)
+{
+    struct rpmi_service_group *group;
+
+    if (s->sysreset_group) {
+        error_setg(errp, "duplicate RPMI sysreset service descriptor");
+        return false;
+    }
+
+    group = riscv_rpmi_sysreset_create(s);
+    if (!group) {
+        error_setg(errp, "failed to create RPMI sysreset service group");
+        return false;
+    }
+
+    if (!riscv_rpmi_context_add_group(s, group, "sysreset", errp)) {
+        riscv_rpmi_sysreset_destroy(group);
+        return false;
+    }
+
+    s->sysreset_group = group;
+    return true;
+}
+
+void riscv_rpmi_sysreset_remove(RiscvRpmiState *s)
+{
+    if (!s->sysreset_group) {
+        return;
+    }
+
+    riscv_rpmi_context_remove_group(s, s->sysreset_group);
+    riscv_rpmi_sysreset_destroy(s->sysreset_group);
+    s->sysreset_group = NULL;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e52ccfae1f..273a9aa04f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1007,6 +1007,35 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
 }
 
 
+static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
+    {
+        .kind = RISCV_RPMI_SERVICE_SYSRESET,
+        .node_name = "sysreset",
+        .compatible = "riscv,rpmi-system-reset",
+        .service_group = RISCV_RPMI_SRVGRP_SYSTEM_RESET,
+    },
+};
+
+static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
+{
+    return ARRAY_SIZE(virt_rpmi_services);
+}
+
+static void virt_rpmi_system_reset(void *opaque)
+{
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+static void virt_rpmi_system_shutdown(void *opaque)
+{
+    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+}
+
+static const RiscvRpmiMachineOps virt_rpmi_machine_ops = {
+    .system_reset = virt_rpmi_system_reset,
+    .system_shutdown = virt_rpmi_system_shutdown,
+};
+
 static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
                                         const uint32_t *hart_ids,
                                         uint32_t hart_count)
@@ -1018,8 +1047,12 @@ static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
         .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
         .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
         .platform_info = "QEMU RISC-V virt RPMI",
+        .machine_ops = &virt_rpmi_machine_ops,
+        .machine_opaque = s,
         .hart_ids = hart_ids,
         .hart_count = hart_count,
+        .services = virt_rpmi_services,
+        .service_count = virt_rpmi_service_count(s),
     };
 }
 
@@ -1028,6 +1061,7 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 {
     RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
     uint32_t rpmi_mbox_handle;
+    uint32_t i;
     RiscvRpmiFdtMboxConfig cfg = {
         .shmem_base = rpmi_cfg.shmem_base,
         .doorbell_base = rpmi_cfg.doorbell_base,
@@ -1038,6 +1072,12 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 
     riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
                             &rpmi_mbox_handle);
+
+    for (i = 0; i < rpmi_cfg.service_count; i++) {
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt, rpmi_cfg.shmem_base,
+                                        &rpmi_cfg.services[i],
+                                        rpmi_mbox_handle);
+    }
 }
 
 static void finalize_fdt(RISCVVirtState *s)
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index b5d8a32f9b..d11db87731 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -27,6 +27,7 @@
 #define VIRT_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
 #define VIRT_RPMI_P2A_REQ_SIZE 0
 
+#define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
 
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
@@ -38,8 +39,13 @@ struct rpmi_transport;
 
 typedef enum RiscvRpmiServiceKind {
     RISCV_RPMI_SERVICE_INVALID = 0,
+    RISCV_RPMI_SERVICE_SYSRESET,
 } RiscvRpmiServiceKind;
 
+typedef struct RiscvRpmiMachineOps {
+    void (*system_reset)(void *opaque);
+    void (*system_shutdown)(void *opaque);
+} RiscvRpmiMachineOps;
 typedef struct RiscvRpmiServiceConfig {
     RiscvRpmiServiceKind kind;
     const char *node_name;
@@ -56,7 +62,8 @@ typedef struct RiscvRpmiConfig {
     uint32_t a2p_req_size;
     uint32_t p2a_req_size;
     const char *platform_info;
-
+    const RiscvRpmiMachineOps *machine_ops;
+    void *machine_opaque;
     const uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
@@ -73,7 +80,9 @@ struct RiscvRpmiState {
     uint32_t a2p_req_size;
     uint32_t p2a_req_size;
     char *platform_info;
-
+    const RiscvRpmiMachineOps *machine_ops;
+    void *machine_opaque;
+    struct rpmi_service_group *sysreset_group;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
index f053ae5d57..af0e8a65ab 100644
--- a/include/hw/riscv/rpmi-fdt.h
+++ b/include/hw/riscv/rpmi-fdt.h
@@ -26,5 +26,16 @@ void riscv_rpmi_fdt_add_mbox(void *fdt,
                              const RiscvRpmiFdtMboxConfig *cfg,
                              uint32_t *phandle,
                              uint32_t *mbox_handle);
+void riscv_rpmi_fdt_add_service(void *fdt, hwaddr shmem_base,
+                                const char *node_name,
+                                const char *compatible,
+                                uint32_t mbox_handle,
+                                uint32_t service_group,
+                                bool has_mpxy_channel,
+                                uint32_t mpxy_channel);
+
+void riscv_rpmi_fdt_add_service_node(void *fdt, hwaddr shmem_base,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle);
 
 #endif
-- 
2.43.0


