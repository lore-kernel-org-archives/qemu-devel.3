Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533B8C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x74bA-0007mA-8M; Thu, 17 Sep 2026 01:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74b2-0007kj-HJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74ax-00040k-N4
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:42 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GMd3oY2600437
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HsBbAff4Hts
 nrzEML3Mfrtf5gNE16+y8G6VT1f14rAo=; b=hCsSDoP2Wwv/oKxr7ug3AE0PkvC
 vxDvp97tkn7csPdYnc+EP/ZLnDezqHR++qNlqKT5S79trsp1SJpcAFvT+Drxu8gt
 CfH4EBJu6JZpwzOcQDpj4ryhFpZ1VTjKcPu/FTEPWvZa8wI940/w7h9jMi+6N6Tr
 m/uNz175BKObWnf8Co/aBxo1POP+g9xr9E9mXYGmnMgdbthd6851r72btUYdHwJs
 +ylL+oNGX8bVVmSh8HQ+r+qo6ls9yem6sdYN60wnHVkeRrDDLPPk+w76uEPm61mj
 ZPdoTLKFr8kheUh+0uJzNv6P7GLkb3kU1EJuyFHJ7KkffFMjXXn+RHNdOUA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb3ny9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398bb9a6408so122365a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 22:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789622617; x=1790227417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HsBbAff4HtsnrzEML3Mfrtf5gNE16+y8G6VT1f14rAo=;
 b=NRTg9VZVNpluNpbAYCM5jqcFkUJLOeNQzOovujQyVcuMbPnveL3gjqmJS1JojOP1Pt
 wxdJoDQDyXzjfoeWBPdMOgGMiiySMAG76KDiwqTtaqWuzNXmADU5yMhoKG689vhKe55k
 WJ0DdShFeTfu2zaOn79fz12xrTxIE3B7JQHzvYSd8702st4ZjQja/27+K8iKG+KcJS62
 C+ehU5TaPRrg5RNcvI+PN7OO9VxN1vEGG2nhqRg/o+Fea0+C02N+4uQX4Hwc0iCMyPL6
 XwjcKlnsJqkXFfmmczNf++d+2hWKtw91SudGMtIoZaFUxeWPTvQrogR7+CrCmnmFNVSL
 rmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789622617; x=1790227417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HsBbAff4HtsnrzEML3Mfrtf5gNE16+y8G6VT1f14rAo=;
 b=rDi7+bjwgdCG5OQwU8ovgiI+aoUhrBxZ4k3u492ybkVEx9KNsFCbNK2BTUcbxhGsEC
 Oz1+gBuV4lSNujCuLz7RO2RP2CtR1KJWnGRGP8btOMTBt6mpq8sYSW4iN7KW/QO9mSRv
 14+W+4VhZEUnu3inu/QaqFa6HkwYAwWoOwmVyhgSsV57fv+f5cn0PR/82XCeNDS74xxl
 FaEHAX6q0RZRVBpCTCl3nzEkWomRHazjOE92HTCoru9xmIgtIi4vDEsjqp0rAN+KH1Wm
 X+NnxFa/h9iSKrC92kDmi9Kw2uT4xgKUmNWIk2q5SX6qq1yj2/+hPnQOUlITVlrft5Si
 hQtA==
X-Gm-Message-State: AFuF++nQ7CgM6i8YR1eLdPXGqAVNL19Db3r+gbMDE+0PiRNufqjak1pj
 p2XOfmad8uHgc/QkqqfwbY1YLnFwR20R0ZKzew7znCbfnhFBLmEunXGokrHg6eNkxgu/xqVqavU
 JJSVduddZhUeT1rfDJinWrIcAtPjtPyq0d2hDuvnxN6blz0QNXeoAIwnxKokQkho39A==
X-Gm-Gg: AYBFou06WCHjY7VJ1/Aki9tJ/7CiWmvy033ABVY2pZPI3ByLE+yH9jEvyQQwDVW4hFw
 0fOETmoANjqSt0qCQj17gpjbjuLKX0egCH9ApzFow4JevtzdPZWEDRqZEmEpim05Nt6Mr2L55S1
 w9rPQ1ajX6V5/Fc1NYxaEz+GUsn7ZvIZacGmrrfOkJ5NlJieBQAAWXLpUpjqeuEyRNzkQVdE6tr
 8Y1fUjqe3SU7JAQveHPi7U3ifEho7UUlvz8KSy93hTgp2iP7P8h0J4MnrfwqJVU9UEhTC0bV7hf
 KjSGH8CiK/LP7IkXSdtRrlMLYcBwnIVPgH176XhePrHtmUlCk2+7cl2Ip6AnRd6B/8XU5HhyypV
 ZwlTywt6ep2F/aKqs7c8wEBWopiod1FTiDkqnfagT9DdWnJxMCqgPnCF3lDLqq/M+Yg5ENHJHO0
 kRnRhXzXRDbFk8b6DBV4x1Cxinz1mVb00=
X-Received: by 2002:a17:90b:3985:b0:398:bad2:c10 with SMTP id
 98e67ed59e1d1-39e1e5b05c4mr7706880a91.6.1789622617333; 
 Wed, 16 Sep 2026 22:23:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3985:b0:398:bad2:c10 with SMTP id
 98e67ed59e1d1-39e1e5b05c4mr7706852a91.6.1789622616793; 
 Wed, 16 Sep 2026 22:23:36 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm14256187eec.24.2026.09.16.22.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 22:23:36 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v11 05/10] riscv: add RPMI system reset service
Date: Thu, 17 Sep 2026 10:52:44 +0530
Message-ID: <20260917052250.1041262-6-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aab795a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1ciSe8lxFlYQ8NbV_SwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: sCV9sotfxJaG6mp8rWe0z0icf3cPtuEb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX3vk3pkoRQYS1
 VecL13ITD9NOl8CwAGGBaafH5VyR4PVpgPw+Jfu8cIWPXULlHkWmbVpgcJJPTY+flGdgmo2D/YP
 Ro8SPGCpq00/PAZ5ol9uZ1An8g9LW9k3bzTHQIyKLhfhOHgKuuQiuS69dAiVb/XvgZeLOzrP0Lg
 /dhnwg9b4v+QFPzjNTjo3bSaCmBPX+5RUQccRXv9R8V9LODoNWYZHCKUX0g8mLrkSOZHQQ8UL9/
 g/UGXWnsBPV9YzRa9y+TqCvG2LS83to2moDG4SjuYBVV4MubphwuTxwKTy2xD32i98asHgcMJet
 L2JpG7e1PS07jA36lu/F8pLiFvHdahEnw8Hl32gGU9VD6iYVkbf+jIv/CJbNUguznUkXxt3EYII
 3AG6TGBt1JsbxFghUXJj+6fx0J02eCNFzGB2nmiuwlFQDRE1dDzUoiuhCD2Cu/r/UM8x30Xghhc
 eeUs8igvb2VJjKIiCnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfX4zux8MQbIKNg
 VwinFOKPVMBAyfcHnOEeUC5MNS6bsiVdP7L4NY9fUYNgkfKHXHVMRprCxUBF7Rbta++k89nXnvR
 Nn2bHXfXwJgZ46DwUvWs/B0q20jlEWA=
X-Proofpoint-ORIG-GUID: sCV9sotfxJaG6mp8rWe0z0icf3cPtuEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170068
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

Add a QEMU implementation of the RPMI System Reset service group.

The service advertises shutdown and cold reboot reset types, validates
guest requests, and dispatches accepted requests through the machine
reset and shutdown callbacks. This lets firmware use RPMI reset commands
while keeping the board-specific reset policy in the RISC-V virt machine.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |  68 ++++++++++-
 hw/misc/riscv_rpmi_internal.h |   9 ++
 hw/misc/riscv_rpmi_sysreset.c | 206 ++++++++++++++++++++++++++++++++++
 hw/riscv/rpmi-fdt-stub.c      |  22 ++++
 hw/riscv/rpmi-fdt.c           |   2 +-
 hw/riscv/virt.c               |  51 ++++++++-
 include/hw/misc/riscv_rpmi.h  |  11 +-
 include/hw/riscv/rpmi-fdt.h   |  11 ++
 9 files changed, 371 insertions(+), 10 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 1b8220c6be..25916c93ed 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -178,4 +178,5 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_AXIADO_CLK', if_true: files('axiado_clk.c'))
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
+  'riscv_rpmi_sysreset.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index c73408714a..7d55215fa0 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -200,10 +200,37 @@ static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
                                           s->a2p_req_size);
 }
 
+typedef struct RiscvRpmiServiceOps {
+    enum rpmi_servicegroup_id service_group;
+    bool (*add)(RiscvRpmiState *s, Error **errp);
+    void (*remove)(RiscvRpmiState *s);
+} RiscvRpmiServiceOps;
+
+static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
+    {
+        .service_group = RPMI_SRVGRP_SYSTEM_RESET,
+        .add = riscv_rpmi_sysreset_add,
+        .remove = riscv_rpmi_sysreset_remove,
+    },
+};
+
+static const RiscvRpmiServiceOps *riscv_rpmi_service_ops_by_group(
+    enum rpmi_servicegroup_id service_group)
+{
+    for (uint32_t i = 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) {
+        if (riscv_rpmi_service_ops[i].service_group == service_group) {
+            return &riscv_rpmi_service_ops[i];
+        }
+    }
+
+    return NULL;
+}
+
 static void riscv_rpmi_configure_base(RiscvRpmiState *s,
                                       const RiscvRpmiConfig *cfg)
 {
     s->platform_info = g_strdup(cfg->platform_info);
+    s->machine_ops = cfg->machine_ops;
     s->services = cfg->services;
     s->service_count = cfg->service_count;
 
@@ -240,7 +267,9 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
 {
-
+    for (uint32_t i = ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) {
+        riscv_rpmi_service_ops[i - 1].remove(s);
+    }
 
     if (s->context) {
         rpmi_context_destroy(s->context);
@@ -277,6 +306,30 @@ bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
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
@@ -348,9 +401,16 @@ static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
                                          const RiscvRpmiServiceConfig *service,
                                          Error **errp)
 {
-    error_setg(errp, "unsupported RPMI service group %u",
-               service->service_group);
-    return false;
+    const RiscvRpmiServiceOps *ops;
+
+    ops = riscv_rpmi_service_ops_by_group(service->service_group);
+    if (!ops) {
+        error_setg(errp, "unsupported RPMI service group %u",
+                   service->service_group);
+        return false;
+    }
+
+    return ops->add(s, errp);
 }
 
 static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index c0cb1b64e6..1d7445b2d1 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -20,5 +20,14 @@
 extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
 bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
                                 enum rpmi_servicegroup_id service_group);
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
index 0000000000..775eb5483f
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
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
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
+        ops->system_reset();
+    }
+}
+
+static void riscv_rpmi_sysreset_shutdown(RiscvRpmiState *s)
+{
+    const RiscvRpmiMachineOps *ops = s->machine_ops;
+
+    if (ops && ops->system_shutdown) {
+        ops->system_shutdown();
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
diff --git a/hw/riscv/rpmi-fdt-stub.c b/hw/riscv/rpmi-fdt-stub.c
index 9866236ab3..439a053c62 100644
--- a/hw/riscv/rpmi-fdt-stub.c
+++ b/hw/riscv/rpmi-fdt-stub.c
@@ -14,3 +14,25 @@ void riscv_rpmi_fdt_add_mbox(void *fdt G_GNUC_UNUSED,
 {
     g_assert_not_reached();
 }
+
+void riscv_rpmi_fdt_add_service(void *fdt G_GNUC_UNUSED,
+                                hwaddr shmem_base G_GNUC_UNUSED,
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
+                                     hwaddr shmem_base G_GNUC_UNUSED,
+                                     const RiscvRpmiServiceConfig *service
+                                     G_GNUC_UNUSED,
+                                     uint32_t mbox_handle G_GNUC_UNUSED)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
index 439c91c894..506be5d43b 100644
--- a/hw/riscv/rpmi-fdt.c
+++ b/hw/riscv/rpmi-fdt.c
@@ -75,7 +75,7 @@ void riscv_rpmi_fdt_add_service(void *fdt, hwaddr shmem_base,
                                 const char *node_name,
                                 const char *compatible,
                                 uint32_t mbox_handle,
-                                uint32_t service_group,
+                                enum rpmi_servicegroup_id service_group,
                                 bool has_mpxy_channel,
                                 uint32_t mpxy_channel)
 {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c822cc15ca..7a97dfcf89 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -770,7 +770,8 @@ static void create_fdt_pcie(RISCVVirtState *s,
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
-static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
+static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle,
+                             bool use_syscon_reset)
 {
     char *name;
     uint32_t test_phandle;
@@ -794,6 +795,14 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
     test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
     g_free(name);
 
+    /*
+     * When RPMI is enabled, advertise reset and shutdown through RPMI so
+     * firmware routes these operations through the RPMI system reset service.
+     */
+    if (!use_syscon_reset) {
+        return;
+    }
+
     name = g_strdup_printf("/reboot");
     qemu_fdt_add_subnode(ms->fdt, name);
     qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
@@ -993,6 +1002,34 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
 }
 
 
+static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
+    {
+        .node_name = "sysreset",
+        .compatible = "riscv,rpmi-system-reset",
+        .service_group = RPMI_SRVGRP_SYSTEM_RESET,
+    },
+};
+
+static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
+{
+    return ARRAY_SIZE(virt_rpmi_services);
+}
+
+static void virt_rpmi_system_reset(void)
+{
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
+
+static void virt_rpmi_system_shutdown(void)
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
@@ -1004,8 +1041,11 @@ static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
         .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
         .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
         .platform_info = "QEMU RISC-V virt RPMI",
+        .machine_ops = &virt_rpmi_machine_ops,
         .hart_ids = hart_ids,
         .hart_count = hart_count,
+        .services = virt_rpmi_services,
+        .service_count = virt_rpmi_service_count(s),
     };
 }
 
@@ -1014,6 +1054,7 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 {
     RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
     uint32_t rpmi_mbox_handle;
+    uint32_t i;
     RiscvRpmiFdtMboxConfig cfg = {
         .shmem_base = rpmi_cfg.shmem_base,
         .doorbell_base = rpmi_cfg.doorbell_base,
@@ -1024,6 +1065,12 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 
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
@@ -1049,7 +1096,7 @@ static void finalize_fdt(RISCVVirtState *s)
         create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
     }
 
-    create_fdt_reset(s, &phandle);
+    create_fdt_reset(s, &phandle, !s->have_rpmi);
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index 93d128f2e2..1500ff1b8b 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -37,7 +37,6 @@ enum rpmi_servicegroup_id {
 #define VIRT_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
 #define VIRT_RPMI_P2A_REQ_SIZE 0
 
-
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
 
@@ -46,6 +45,11 @@ struct rpmi_service_group;
 struct rpmi_shmem;
 struct rpmi_transport;
 
+typedef struct RiscvRpmiMachineOps {
+    void (*system_reset)(void);
+    void (*system_shutdown)(void);
+} RiscvRpmiMachineOps;
+
 typedef struct RiscvRpmiServiceConfig {
     const char *node_name;
     const char *compatible;
@@ -61,7 +65,7 @@ typedef struct RiscvRpmiConfig {
     uint32_t a2p_req_size;
     uint32_t p2a_req_size;
     const char *platform_info;
-
+    const RiscvRpmiMachineOps *machine_ops;
     const uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
@@ -78,7 +82,8 @@ struct RiscvRpmiState {
     uint32_t a2p_req_size;
     uint32_t p2a_req_size;
     char *platform_info;
-
+    const RiscvRpmiMachineOps *machine_ops;
+    struct rpmi_service_group *sysreset_group;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
index b157bda1d1..d96c9c37e4 100644
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
+                                enum rpmi_servicegroup_id service_group,
+                                bool has_mpxy_channel,
+                                uint32_t mpxy_channel);
+
+void riscv_rpmi_fdt_add_service_node(void *fdt, hwaddr shmem_base,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle);
 
 #endif

