Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D23FC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 04:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wujvY-0008Sm-Jt; Fri, 14 Aug 2026 00:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvX-0008SE-DS
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:53:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvU-0005Lc-Sd
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:53:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4Qd1s510050
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SrjNB2ZHbIE
 pI5L9AHRxq4ZFgeYnK2Rh+MSxl89lpXM=; b=n37JHogSEkApbEZkHXa7mBLIHOk
 yBHXwO0KuF5Srj9X21qegTwGJuy8PY2BS12/rKfJ+DLSkilwND+hFkcaNN5qY8if
 bMrjBgCqOjNGR9Ze1iDa1n/WkzRfQyUPH3yLCO2JD71i20qLZZn79GwkWd4wy71D
 EIffBnS9hfoibN+OE2XPyDL7gPr4dEOZvOo3RXvA1QaIwY4HXBl5cCCtYGNdhgu5
 ulc/CMA1DbM4brgKYoR2fItu2iOMO6ibaGs9UkLlJUkYmqFBLaLQ+QdlzGVd26PV
 5Y7DhyeqJnFyUCjqH4uxKpJc+KBOn+6VUqPstP3r1oU4r5UdRHX5hV6cvXQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1fg3u6e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38de4c60f0eso131017a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 21:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786683231; x=1787288031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SrjNB2ZHbIEpI5L9AHRxq4ZFgeYnK2Rh+MSxl89lpXM=;
 b=RQajvrjOuxwKwYXX/tj2BCGDfe9sX6WfRykdck0oqs8GqZrPB3SXBxf+Ob0W2z20Na
 eDWNHS+cZULwQfxrdBBLun/cmuZowoyx3YdBuQfWyB9u5FSnoZ+TJScrKlpZYZFMcIJX
 IPjOLmGU6l7ZKzrsJoRL674vUSxPCQoI38cCR+OfGKhqjDiBgSgrWVFSo5WMPW3ETNvd
 0opWr59jXre6OBnUtmkv5YFAZYwdHrKy56XRuXekVoTDLGPRcjpxJ3KJifm4yXrlQtQl
 Qm9LYMng4TYaU7lPtwKLEUaWa1mPCDXik7RUWDdVWBIww4IPp2VGUa0O0GBteNhH/nWW
 zugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786683231; x=1787288031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SrjNB2ZHbIEpI5L9AHRxq4ZFgeYnK2Rh+MSxl89lpXM=;
 b=VbtoWN9njRzb6DOeyCvT7QbSV28W4RPusiyWFvC5U3oLkQ72D/KrELrczrmM26O/W0
 UyLdRh9eftUbVlKMO0wDGu0c0rWcFu1KGgc+cWPb96+S280D0jpkkGqsdyiWN+3U3suX
 hIsBuiXZ0pDiR6CdKjoQNaQQALSUE0ij4d+r7HgO4GuHRQfIQdPdW+nFztTOzR3HNezU
 I/00XeiMieLuYRqwhas+7MHkc7kibzwuajetnFyo+hdEb+1wBDDv0VKAYmchEJGgvDB7
 VT0iSp5HTpOYaiFjE179gHbidwHirnTgRX0jY7PDNwGA3+nQIPxYKU/oC+McK0omr1ql
 1oJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RodehaCjoabMZQaQo4f+omzFR2xc5K2tje77bX0l8WhLSl2nIva2VYXEGhe+av+KQ94WwDWykErJWPc@nongnu.org
X-Gm-Message-State: AOJu0Yy2JYSnTTUNANNnUWVrpXbv43qB07Ez/id83pFLHuy2a4pMvkD+
 pSNICyOgvyYg+qyPOGCxfjweIlyynhasqGaIM8RcYJlC30Yn9aljZHlBczS0SqaPSfie9wHs5EV
 RA5pjsXGXRGReV90MRMH+7xWGCuYN865p1dnub9UtO80o0DIKORWbteAIMQ==
X-Gm-Gg: AR+sD121MCwtAkN1p2Xb+FEqAXdPnXjy/mo4n6/USGV331EP5GdcvmNERn+JEwTubVf
 AoUnsMRsLTTxA2wSfnu+CcbnW9nYKbMIzcv0S2JS9KB0+tmHBE4j1gjG5lD+Zna8rU2eppA98+f
 IyaB6HWNVw4SK32NUmeOGRJnz1wZtXQ6P3gTicipEZHCTskwN2TKoA9qajg5qMp4StiZhcI/lRa
 EglfWhBt/fo6aTZdkrn4JwWJh/lWLwpUOINkkk27TjK4Po08ZHxV1cJFUkzNiK9ZxXzGED2X9ag
 7/WUzOawHAFv3GojgRv+hA6WHh5YscjhFgzs/C6e/RUtofU6PxA5RzEiKEZzhW68fnA62s/CyQw
 kD8kFZA+aI9tluqOkNi4cbIHVo5YcDJBX+zd5eI0uKHhnqCDajedV0fWBbZimsBMVGmuFZ7SO8a
 M3hqyLJMGC4xsj7M0RIjMlNrMskNPMHMo=
X-Received: by 2002:a17:90b:4a89:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-3933b889d59mr2194752a91.2.1786683230690; 
 Thu, 13 Aug 2026 21:53:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4a89:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-3933b889d59mr2194721a91.2.1786683230109; 
 Thu, 13 Aug 2026 21:53:50 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f15063cd8sm10625665eec.9.2026.08.13.21.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 21:53:49 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v8 05/10] riscv: add RPMI system reset service
Date: Fri, 14 Aug 2026 10:23:09 +0530
Message-ID: <20260814045315.3416169-6-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NsfhtcdJ c=1 sm=1 tr=0 ts=6a7e9f5f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=99SOxnSlc15Quf5CO00A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX6/jAbM4z7uGc
 FruS2Eq2MClSfgI1xYpYFvL1UY13Fz7g/659hexhtvwkHQI2MSVFZpC/FX0Ur/LZ0cH+ifdCIGl
 uGtnOwNlzH9EihPs5CKtjlcJuNtjxcBKq3PstwdnOn7N1EUmcfIxmF91IUMvGpDTWMNR22NJY03
 Lem95kNjCim/hne2DZESehfPENGVyEjkPKNmTZRNh9+kDrvwUMoOZaQE1rBtHLCXnLriG4OuoZ0
 8erGcqoXxAxFogjCZSNpUw6v7UTl/V+JiBXBBwxEIDT19EJo9uaREhiEXae3O0XjRu35xshbeLe
 6by1nHMv+TXwARJhXqqXpPiBqLQu10vc5ZMzaCYR2blLfKc5oVP2pFuM/nMyGRCxRYQ8Ow6f3yR
 5y2+70j0OzYi8jfe/gg8MVxG1iClR8jahkXFe/tNKR1n3QqHUM1S8AXmYWVplGQgPtGl13u5AFF
 ruOBy/y4uYMDSk5R1lg==
X-Proofpoint-ORIG-GUID: P1Z5qUY10PsPwzA_7KPoKOZdZNjaawNj
X-Proofpoint-GUID: P1Z5qUY10PsPwzA_7KPoKOZdZNjaawNj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX/Q6uAoAQY1MN
 nAtsmeQphktdXfJ5kEQqzgmrToHUHd96oPzh1GLGWYimFDt3o2w3wJIiN4vk+1H8E2Lw7eE4dFt
 tu3ERRgS5rEi2MxesG95KHYQ5fFyvpM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140036
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

Add a QEMU implementation of the RPMI System Reset service group.

The service advertises shutdown and cold reboot reset types, validates
guest requests, and dispatches accepted requests through the machine
reset and shutdown callbacks. This lets firmware use RPMI reset commands
while keeping the board-specific reset policy in the RISC-V virt machine.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |  70 +++++++++++-
 hw/misc/riscv_rpmi_internal.h |  12 +-
 hw/misc/riscv_rpmi_sysreset.c | 206 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |  51 ++++++++-
 include/hw/misc/riscv_rpmi.h  |  15 +--
 include/hw/riscv/rpmi-fdt.h   |  11 ++
 7 files changed, 349 insertions(+), 17 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 92c9cd6064..482f56504e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -170,4 +170,5 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
+  'riscv_rpmi_sysreset.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 54a790fc7c..9575cd3a8d 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -171,10 +171,37 @@ static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
                                           s->a2p_req_size);
 }
 
+typedef struct RiscvRpmiServiceOps {
+    uint32_t service_group;
+    bool (*add)(RiscvRpmiState *s, Error **errp);
+    void (*remove)(RiscvRpmiState *s);
+} RiscvRpmiServiceOps;
+
+static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
+    {
+        .service_group = RISCV_RPMI_SRVGRP_SYSTEM_RESET,
+        .add = riscv_rpmi_sysreset_add,
+        .remove = riscv_rpmi_sysreset_remove,
+    },
+};
+
+static const RiscvRpmiServiceOps *riscv_rpmi_service_ops_by_group(
+    uint32_t service_group)
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
 
@@ -211,7 +238,9 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
 {
-
+    for (uint32_t i = ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) {
+        riscv_rpmi_service_ops[i - 1].remove(s);
+    }
 
     if (s->context) {
         rpmi_context_destroy(s->context);
@@ -234,12 +263,12 @@ static void riscv_rpmi_cleanup(RiscvRpmiState *s)
     }
 }
 
-bool riscv_rpmi_service_enabled(RiscvRpmiState *s, RiscvRpmiServiceKind kind)
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s, uint32_t service_group)
 {
     uint32_t i;
 
     for (i = 0; i < s->service_count; i++) {
-        if (s->services[i].kind == kind) {
+        if (s->services[i].service_group == service_group) {
             return true;
         }
     }
@@ -247,6 +276,30 @@ bool riscv_rpmi_service_enabled(RiscvRpmiState *s, RiscvRpmiServiceKind kind)
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
@@ -318,11 +371,16 @@ static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
                                          const RiscvRpmiServiceConfig *service,
                                          Error **errp)
 {
-    switch (service->kind) {
-    default:
-        error_setg(errp, "unsupported RPMI service kind %d", service->kind);
+    const RiscvRpmiServiceOps *ops;
+
+    ops = riscv_rpmi_service_ops_by_group(service->service_group);
+    if (!ops) {
+        error_setg(errp, "unsupported RPMI service group %u",
+                   service->service_group);
         return false;
     }
+
+    return ops->add(s, errp);
 }
 
 static bool riscv_rpmi_init_services(RiscvRpmiState *s, Error **errp)
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index c263033634..ca9838d256 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -18,7 +18,15 @@
 #define RPMI_PLAT_INFO "QEMU RISC-V RPMI"
 
 extern const struct rpmi_shmem_platform_ops rpmi_shmem_qemu_ops;
-bool riscv_rpmi_service_enabled(RiscvRpmiState *s,
-                                RiscvRpmiServiceKind kind);
+bool riscv_rpmi_service_enabled(RiscvRpmiState *s, uint32_t service_group);
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
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e52ccfae1f..26b1a61fec 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -794,7 +794,8 @@ static void create_fdt_pcie(RISCVVirtState *s,
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
-static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
+static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle,
+                             bool use_syscon_reset)
 {
     char *name;
     uint32_t test_phandle;
@@ -818,6 +819,14 @@ static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
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
@@ -1007,6 +1016,34 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
 }
 
 
+static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
+    {
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
@@ -1018,8 +1055,11 @@ static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
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
 
@@ -1028,6 +1068,7 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 {
     RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
     uint32_t rpmi_mbox_handle;
+    uint32_t i;
     RiscvRpmiFdtMboxConfig cfg = {
         .shmem_base = rpmi_cfg.shmem_base,
         .doorbell_base = rpmi_cfg.doorbell_base,
@@ -1038,6 +1079,12 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 
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
@@ -1063,7 +1110,7 @@ static void finalize_fdt(RISCVVirtState *s)
         create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
     }
 
-    create_fdt_reset(s, &phandle);
+    create_fdt_reset(s, &phandle, !s->have_rpmi);
 
     create_fdt_uart(s, irq_mmio_phandle);
 
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index f5fd1ee8c7..a9ccc950e9 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -27,6 +27,7 @@
 #define VIRT_RPMI_A2P_REQ_SIZE (16 * RPMI_QUEUE_SLOT_SIZE)
 #define VIRT_RPMI_P2A_REQ_SIZE 0
 
+#define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
 
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
@@ -36,12 +37,11 @@ struct rpmi_service_group;
 struct rpmi_shmem;
 struct rpmi_transport;
 
-typedef enum RiscvRpmiServiceKind {
-    RISCV_RPMI_SERVICE_INVALID = 0,
-} RiscvRpmiServiceKind;
-
+typedef struct RiscvRpmiMachineOps {
+    void (*system_reset)(void);
+    void (*system_shutdown)(void);
+} RiscvRpmiMachineOps;
 typedef struct RiscvRpmiServiceConfig {
-    RiscvRpmiServiceKind kind;
     const char *node_name;
     const char *compatible;
     uint32_t service_group;
@@ -56,7 +56,7 @@ typedef struct RiscvRpmiConfig {
     uint32_t a2p_req_size;
     uint32_t p2a_req_size;
     const char *platform_info;
-
+    const RiscvRpmiMachineOps *machine_ops;
     const uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
@@ -73,7 +73,8 @@ struct RiscvRpmiState {
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
index b157bda1d1..60c5df75d0 100644
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


