Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D23606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K2gT4eVf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXvzTCSG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTCe-0004pN-GB; Wed, 04 Nov 2026 00:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCa-0004mt-3Q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCW-0002D6-LX
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:23 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40R1Ie3458487
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vPDz0xyXCYA
 WTwQ75srl+Okui8f5Y7xXM2D854TzN5c=; b=K2gT4eVfonZtUJDF2p63hNGEZWT
 6+9yFHMuCui5ALpFhqs4jqkv8h32B/8UjDXp78KSQi1bSs++bUgF43LIEcWZ2bKv
 KHbn5QefuxQSZ0Sl2IOuiPg3ub6RXCnP0PELHNSvayOEmmcI5LvcvmXmyC5pwzXQ
 LQZdYj8SHiBq7DUFfLRk/C4+wWP846/DWp87iewsgsgN/a7TH+7Fe6pQrjLAfnVv
 A2OiuPDF6qGeZn072u4da19cxSjV0dmHcl8zLzbrANw1wS1L7nOrA1DEmGmhY6I/
 xonM0RMlho8qkkrIXmSLD9ZYdzNpuZD7lqU1pibsnv0Goo2G8PlrxMkNIUA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bubnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a19435aeeso31926eec.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768778; x=1794373578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vPDz0xyXCYAWTwQ75srl+Okui8f5Y7xXM2D854TzN5c=;
 b=LXvzTCSG3BnTZsDascpr5mfHxdDS7enj+1xs6Y6c0CxGU1axPDB6dhJB62qOVWSCY8
 BOqjRnD7r+jVW+n/35M7QOdUMwYjuXDFQximxfrB48aeaSCB1c0AO/G62T4zaXE49lLH
 riCXUULkfPntx7Rz1MYQ+N7+h7Nn9lAW66peep3NaR37Ln4phowi2EP3aRMVtePMqU+C
 q3yf6ek8wZ4BBfeWQ40D7UFV+03pJjSmB1at/vng/ndHgIIis/fpMjUeVA8ov8IegR+8
 QI0ZKi3+mBt6ZpI4HQ+1SgkB9Vn3Ng2UkSP+HRNJ9os+3PSyIAut0uzaIYFyFlCAr2pH
 UzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768778; x=1794373578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vPDz0xyXCYAWTwQ75srl+Okui8f5Y7xXM2D854TzN5c=;
 b=oju33mlNCXuH4lOQelzIZk4LlEri0DLOrqfX9g61uvY/qikd6Hqh4sqECK64Qs1wsM
 HElCRA7YBf3UjNmZcoVngMe9z4a8Y5OABuAZAvsCxjKmbIiZWIJIKjpSYdoy1u3rwPRs
 YAnjIF53n0LcGng7JyDJb7ntMLw4avBFABCDsq5Ud58OM88IZWO3zxe9VR9j0KvawoEJ
 sDdRB6VmuAdK9X/aKCNUUBisO9+DN8sHfBLvq8RmD8L8dqMxk2mT3I02RL7IK4DDxwrT
 BFfydJCrufYpy4h/YTRYcThmLAx5NDphl9i/Xsp1AdyNTgySEHoE813o9+FVjd3x42xy
 tQtg==
X-Gm-Message-State: APuU4Z+aN65Aj6YebAY7MyilaLWS1mq8RN3y9klFIDfWSHY6JmitVfrm
 qTZQ3k34wa98BS6+xh03fUB6EAPbqzMj4SIO+JrpvCyU1QkK2ZC8Bsc4Rs1uySiDpMuIcaQ0jjr
 Fp8mHbO9OrTmH2NoVBwFoRthFkXj927MDB+OFL8hQj+qILqgITN5AlMqUMvLfMXBTWQ==
X-Gm-Gg: AYBFou3fN/OTggXrY5Ah2dUXE3+ULKVnXgTOZQR72XvrD2U5CtaiKImEImBK5D4OZpI
 emsBCJXH/JqoeX2uHqiUV1E06VNn/USRW6zh5vRNyC3H7adzijBVZG029pOYNHyzF7c/QhsYIX2
 o7TT1fjO7vukLOo5QEUftzL9rNX0oG69wERKq69erGDkmvGp56oaafwX1rYn60Kqn1gEIWl0FxS
 QQH4LAmLun2/obKqNuemkWwKnXnlyqMILwlhR29bKbWrygkjD1KxcurUSkxIyXgFeYhc17EpIP1
 hpi/M9jYnFa0+N5ECZuAhoo46cGSVESqCCpnn0FDoMv+Kbrmx58FP/J2Uk8eD8oQZCGmm3lhE6J
 RnN2ndFZ0OX21XYTD1ZxFg3CxiBP8NuXwttrlULRgc+qW+AeXxNPs7DJu1rHnU/zOQlkiHrlHoT
 N6KNEqC5roVo4I7Iet6KJiuH0NzUpDakQxQs0G61Z9AevyPu5/2YM3tabW9OazhiMxYXBHdgVVE
 Wv8pbwX
X-Received: by 2002:a05:7300:d082:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a4236a643mr29517925eec.2.1793768777632; 
 Tue, 03 Nov 2026 21:06:17 -0800 (PST)
X-Received: by 2002:a05:7300:d082:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a4236a643mr29517860eec.2.1793768776917; 
 Tue, 03 Nov 2026 21:06:16 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:16 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v14 05/10] riscv: add RPMI system reset service
Date: Wed,  4 Nov 2026 10:33:18 +0530
Message-ID: <20261104050324.733555-6-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfXz1HiQzNqexit
 D2xfUGAEF0ez21A1BU2ezGLxAMAzfFEkVuZK37GvE1rSSKnF6L5JrvWYFU8sk32GmyrMcaWt/vo
 wiUp1lP86h2rVn/R9R86d/E04oBHl9g=
X-Authority-Analysis: v=2.4 cv=AKV9GsJK c=1 sm=1 tr=0 ts=6aeabd4a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=HwIue_3DUM2RCVtF5-MA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: tNVeUjBk745qF2IolpTRHklOB3S07XUw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX00LK6dp8hPmw
 boCME9zyWNmC2SHx/9qUfHJ/j1TSq48PWT5FzUj2/BJSksGAo6rGKPrzeR/xK97CSQJKr7xLgRJ
 NwPvP0Mk16cQxmI2do3zVtYHag1Cx3iLpafaCnvkaEMla6Nd6y8vLdnBBqmm+fIkm14+KoFnDcm
 TBJEEiAE8YuHhFSMjmP2Es128bmvczEkfylIP6yCydtExTT9WIcV28zVoELCswYvBbN7gZGoLC1
 a66KSCN5wFmvXLqaAwbQkyaQtdq0S6P/5gItypAqllzHqCQAsAiQub7CZdZTzGdG4wBtVs22INK
 W3G2obbZa/LHGmgr54IBqEp8ROq/QAS/cBCYYpcDT9WgodJrHVIzjg9INSXWaeC4lZ2XFS9DvIt
 A8dOmXPUTuh7HGbVde8ysACGJKiNg8jqyZLNB4NU5VkTdI0IWPYtMp/9x6xL3zf6tmuKw25grJr
 WAsIfvC71wVSqrjlVdQ==
X-Proofpoint-GUID: tNVeUjBk745qF2IolpTRHklOB3S07XUw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
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

Add a QEMU implementation of the RPMI System Reset service group.

The service advertises shutdown and cold reboot reset types, validates guest requests, and dispatches accepted requests through machine reset and shutdown callbacks. This lets firmware use RPMI reset commands while keeping board-specific reset policy in the RISC-V machine.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build            |   1 +
 hw/misc/riscv_rpmi.c           |  68 +++++++++++-
 hw/misc/riscv_rpmi_internal.h  |   9 ++
 hw/misc/riscv_rpmi_sysreset.c  | 185 +++++++++++++++++++++++++++++++++
 hw/riscv/fdt-common.c          |   8 +-
 hw/riscv/server_platform_ref.c |   2 +-
 hw/riscv/virt.c                |  46 +++++++-
 include/hw/misc/riscv_rpmi.h   |  10 +-
 include/hw/riscv/fdt-common.h  |   3 +-
 9 files changed, 322 insertions(+), 10 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b755796170..a091d393a3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -185,4 +185,5 @@ system_ss.add(when: 'CONFIG_QCOM_QDSP6SS_CLK', if_true: files('qcom-qdsp6ss-clk.
 
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
+  'riscv_rpmi_sysreset.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 3a30d879aa..82a457241c 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -199,10 +199,37 @@ static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
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
 
@@ -236,6 +263,10 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
 {
+    for (uint32_t i = ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) {
+        riscv_rpmi_service_ops[i - 1].remove(s);
+    }
+
     if (s->context) {
         rpmi_context_destroy(s->context);
         s->context = NULL;
@@ -278,6 +309,30 @@ void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
     }
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
@@ -357,9 +412,16 @@ static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
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
index 95aa8dec14..e5880aebe2 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -21,5 +21,14 @@ extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
 bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
                                 enum rpmi_servicegroup_id service_group);
 void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s);
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
index 0000000000..825a74b2d9
--- /dev/null
+++ b/hw/misc/riscv_rpmi_sysreset.c
@@ -0,0 +1,185 @@
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
+static enum rpmi_error riscv_rpmi_sysreset_get_attributes(
+    struct rpmi_service_group *group, struct rpmi_service *service,
+    struct rpmi_transport *trans, rpmi_uint16_t request_data_len,
+    const rpmi_uint8_t *request_data, rpmi_uint16_t *response_data_len,
+    rpmi_uint8_t *response_data)
+{
+    uint32_t reset_type = ldl_le_p(request_data);
+    *response_data_len = 2 * sizeof(uint32_t);
+    stl_le_p(response_data, RPMI_SUCCESS);
+    stl_le_p(response_data + sizeof(uint32_t),
+             riscv_rpmi_sysreset_type_by_id(reset_type) ?
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
+    const RiscvRpmiSysresetType *type;
+    uint32_t reset_type = ldl_le_p(request_data);
+
+    *response_data_len = sizeof(uint32_t);
+    type = riscv_rpmi_sysreset_type_by_id(reset_type);
+
+    if (!type) {
+        stl_le_p(response_data, (uint32_t)RPMI_ERR_INVALID_PARAM);
+        return RPMI_SUCCESS;
+    }
+
+    stl_le_p(response_data, RPMI_SUCCESS);
+    type->action(sysreset->rpmi);
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
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ce2dcb43b4..8a378458da 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -315,7 +315,8 @@ void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
 void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
                              hwaddr addr, hwaddr size,
                              uint32_t reboot, uint32_t poweroff,
-                             bool sifive_test_compat)
+                             bool sifive_test_compat,
+                             bool create_reset_nodes)
 {
     uint32_t syscon_phandle;
     char *name;
@@ -343,6 +344,11 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
 
     g_free(name);
 
+    /* Some machines route reset and shutdown through another interface. */
+    if (!create_reset_nodes) {
+        return;
+    }
+
     name = g_strdup_printf("/reboot");
     qemu_fdt_add_subnode(fdt, name);
     qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-reboot");
diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index 5f485b1c79..d18550b48d 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -310,7 +310,7 @@ static void finalize_fdt(RISCVServerRefMachineState *s)
     riscv_create_fdt_syscon(ms->fdt, &phandle,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].base,
                             rvserver_ref_memmap[RVSERVER_RESET_SYSCON].size,
-                            SYSCON_RESET, SYSCON_POWEROFF, false);
+                            SYSCON_RESET, SYSCON_POWEROFF, false, true);
 
     riscv_create_fdt_uart(ms->fdt, &rvserver_ref_memmap[RVSERVER_UART0],
                           RVSERVER_UART0_IRQ, AIA_TYPE_APLIC_IMSIC,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8a2ed43029..1e313e078e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -52,6 +52,7 @@
 #include "chardev/char.h"
 #include "system/device_tree.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/tpm.h"
@@ -478,6 +479,34 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
+    {
+        .node_name = "sysreset",
+        .compatible = "riscv,rpmi-system-reset",
+        .service_group = RPMI_SRVGRP_SYSTEM_RESET,
+    },
+};
+
+static uint32_t virt_rpmi_service_count(void)
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
@@ -489,13 +518,18 @@ static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
         .a2p_req_size = VIRT_RPMI_A2P_REQ_SIZE,
         .p2a_req_size = VIRT_RPMI_P2A_REQ_SIZE,
         .platform_info = "QEMU RISC-V virt RPMI",
+        .machine_ops = &virt_rpmi_machine_ops,
         .hart_ids = hart_ids,
         .hart_count = hart_count,
+        .services = virt_rpmi_services,
+        .service_count = virt_rpmi_service_count(),
     };
 }
 
 static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle)
 {
+    uint32_t rpmi_mbox_handle;
+    uint32_t i;
     RiscvRpmiFdtMboxConfig cfg = {
         .shmem_base = s->memmap[VIRT_RPMI_SHMEM].base,
         .doorbell_base = s->memmap[VIRT_RPMI_DOORBELL].base,
@@ -504,7 +538,14 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle)
         .doorbell_size = s->memmap[VIRT_RPMI_DOORBELL].size,
     };
 
-    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle, NULL);
+    riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
+                            &rpmi_mbox_handle);
+
+    for (i = 0; i < virt_rpmi_service_count(); i++) {
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt,
+                                        &virt_rpmi_services[i],
+                                        rpmi_mbox_handle);
+    }
 }
 
 static void finalize_fdt(RISCVVirtState *s)
@@ -542,7 +583,8 @@ static void finalize_fdt(RISCVVirtState *s)
     riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
                             s->memmap[VIRT_TEST].base,
                             s->memmap[VIRT_TEST].size,
-                            FINISHER_RESET, FINISHER_PASS, true);
+                            FINISHER_RESET, FINISHER_PASS, true,
+                            !s->have_rpmi);
     if (s->have_rpmi) {
         create_fdt_rpmi(s, &phandle);
     }
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index c207501405..1ab648359d 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -43,6 +43,11 @@ struct rpmi_service_group;
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
@@ -58,7 +63,7 @@ typedef struct RiscvRpmiConfig {
     uint32_t a2p_req_size;
     uint32_t p2a_req_size;
     const char *platform_info;
-
+    const RiscvRpmiMachineOps *machine_ops;
     const uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
@@ -75,7 +80,8 @@ struct RiscvRpmiState {
     uint32_t a2p_req_size;
     uint32_t p2a_req_size;
     char *platform_info;
-
+    const RiscvRpmiMachineOps *machine_ops;
+    struct rpmi_service_group *sysreset_group;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index eb9db8278d..4d2b8a8059 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -103,7 +103,8 @@ void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
 void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
                              hwaddr addr, hwaddr size,
                              uint32_t reboot, uint32_t poweroff,
-                             bool sifive_test_compat);
+                             bool sifive_test_compat,
+                             bool create_reset_nodes);
 uint32_t riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
                                           uint32_t *next_phandle,
                                           uint32_t irq_chip,

