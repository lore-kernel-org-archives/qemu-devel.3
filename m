Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D9606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a8H9fFR0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GjKvQe+w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKg1-0001Wi-0P; Mon, 26 Oct 2026 09:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKfx-0001Vd-Mt
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xLKft-0005Ff-GA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:23:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt1VY2732889
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8gBI37r+YwK
 T1ipjpv7BdiLSDymv5LJMOQBb8QmlPpA=; b=a8H9fFR0Y1KuIjmMZjjVTCdyXHw
 aYl3MeKU4Diz4rJJSnphyHNz6YUAXYDh5rNgeAEZfoA5qIMFf68AY5He9aIHDH4u
 K1WHW0pYB+bhczFEgn9Gj9n1p7uf0BtXZuvN0rSDaFe+a3VqTd3ZCrJCxr2lSFrP
 W1iA9ICQLKLS2ZMJrXhaOOR5Iv25bO33vaJ65cpguSac6NWPZBC3RoPWMckWZogh
 0lyWx2kWkCTEl0p8N6FuRsgD0CkKqtkgYnNsi7LCaAHblzu1DN3YjB9ELosLw4O3
 gtbZSp5wP+36rcLwX1APtSuVMsMY2fN5zMN+VLG3iWrg7EXV3VvOfCAh0dg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp8uk2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 13:23:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3663d3547a0so329970eec.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793021019; x=1793625819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8gBI37r+YwKT1ipjpv7BdiLSDymv5LJMOQBb8QmlPpA=;
 b=GjKvQe+w5TBbLPUz2oubu1T+x0Z3CJZmEDbjDzXxzp4ndhYB5SAx3vPVK96daLzrFS
 bdMzXoPlV7c9Kxd+jSoiksp27L17klEdsiiucZyoNC7v1h79jgWx47TLNV66KIrZD1OW
 LlGh+XKMRBStRnwvEaEntD6mj33zqsSTo/mmPlS0TfuYxZ884Fs4KRE44c3tkM59IbNf
 CTP40dIXTRBu2F5jv8AEgMhztRLKuzG2WOvorCKDUyjFrZueZ9n2J5/xasAbLAvXm/YY
 gE9J0Qd6nfctEbznFvVLE4loTs9dgfZaNu53QsDJELr/dL/o9Y/1LIa19+UUgkgJTqLU
 rpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793021019; x=1793625819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8gBI37r+YwKT1ipjpv7BdiLSDymv5LJMOQBb8QmlPpA=;
 b=iIJCmlWwYMPKA6u6dpk9cOY3vt2lbe+aWcPj/Jg8WeZtyPATL7bmuwyc48ybSQalAq
 JrOExHValJ4QUB3eQxv1SWeSzIHN+RhdCwa3k3P/FCNSbqZYZPXI7JK1BWLLdTmsiTK5
 k2jgKjgaoULpuqJ1CNm/HXDCnmegeEjq3mBQy0MwocGJ7IS4Xj3HpxJX3/ayAZtYEOBM
 h3XhAquktonYcFI8g1+NjtmUlFhCg0HrFYLxzSAWSU089WAbzF4XZkfzXitk2NatqD3i
 6D/b97QdJjDDaR+Aplid2jULtb/zTcVJvlYvLYQ81N8d+p4wLRlkP6tQ4Rhx49AC5a82
 51Kg==
X-Gm-Message-State: AFq9FYIaLyvj9QXOUxXtpcAYEozF2bDNQxnHNsWsNV6aZZCkR26N1xD2
 kQfvtCKZWE9QFiGudF+4sGoaqpfIjwjmDf9eAPDDoJC9rCUYuEn0oKiiX+O64XRpteR27Qk9Scr
 wBn0osr0z430+KnrRty1MQv1PZpwGDw34KYlquhWDDBJ9w37y2jMTMnIV3n9qNzqO4w==
X-Gm-Gg: AYBFou1gLuJPs2Kfw6aYZ518N2Obn88/N6TugdcUGPOJvFVqvbhHsItE6kM7ppebvu/
 WkNnYWwAQ8QlFToCXCEpos0E09zP66X7Jw5jZ6LuwWlMYJbbSJhkvG4m8q6Nr+PYuJl+EQGN+an
 VWENWWIOzr+QE2honHqi8AIS2VQ8OJ18KIQIlgEq5W27+WuAMSOn/qy6+AFpBe/x8VaC1o++L4/
 jUEFY8hLmJF9tBNtP2QM2mJZVc4PFoJiA9VEGPLcnQEfPYCpZsQx22tmyJcscxo38+qyF0U4Vxj
 LfC2nbrjNdYXrtplyfDnG2+fMmzDHJv5FLsyDZo6uQ8WImYIBlg/dORjxtjflK0M878FTKFQzfm
 gR89JXwD+zCepLUpdauehgnvPwvQQ/JzAqaBjGk4TH9BSkd+POE/wTBcWcXqImGebUzo8PKW6jZ
 71vRz+mSeKXHMYlBf5UXBDREadTz2svw4=
X-Received: by 2002:a05:7022:488:b0:127:def:dd72 with SMTP id
 a92af1059eb24-19933f05929mr20569052c88.2.1793021018162; 
 Mon, 26 Oct 2026 06:23:38 -0700 (PDT)
X-Received: by 2002:a05:7022:488:b0:127:def:dd72 with SMTP id
 a92af1059eb24-19933f05929mr20568959c88.2.1793021017390; 
 Mon, 26 Oct 2026 06:23:37 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a21bc6cbsm24360931c88.16.2026.10.26.06.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:23:36 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v12 05/10] riscv: add RPMI system reset service
Date: Mon, 26 Oct 2026 18:52:48 +0530
Message-ID: <20261026132254.2652399-6-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026132254.2652399-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261026132254.2652399-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX4YDSMt5Nk31a
 dIUOMu38iK1aJQ2fZ1TrIGZFcatQUWou9zW0hHBYZ5uMi1/5eilmhpO6Ybh0pSKNIROUgNMhawd
 6MXS6eq+Ml5LztnoqcwroaYtAg2PMlwL5c8aXJ5UiHumQzcJZ2siaNFfVnTvBMW7KrFfwp2V3+h
 VsDwgI/JoqYDIE/weaDKncasAXrmRe7K7mfrYsNYJRnhYR/up+gbiGZcpdUp15qmYGjAV9VfMKE
 hSDeM8m+6O9QCAa4Rnrv725ENArO7KhA73yalw8Z1+CyCvJoHJNDuJ47vebkk7Yq/x0UyS6mwcQ
 ZXkVhj8GHHORY9zhGie0L1pm5Ojm/V+gCFTdOj1E406gNIvLbzU8NwbzALai05QkZTaEJ44LwCC
 8daV0UIK+2/nChBuxKwpuZkldTLdinlgTUtJeoHF7P8T9+Vs6UYDzvRyMD2PgNkPekJxHAoV6JC
 qUPbUG66gpwwHn6TbeA==
X-Proofpoint-GUID: Kj_9E_le56hX-p1HJ6NtWqoyfNnJkafA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MyBTYWx0ZWRfX81L4oTMbIHbS
 4mhoWUB3JjwwLIf+dw5uHIckLh0vwTgcAfnAQ5dg5E/9URmzF+pS/VcJUhFuX1mc+3Gm6AO87i/
 LLAFrCoiJHH32Zc4Pw1HDVJxFgkqkn4=
X-Proofpoint-ORIG-GUID: Kj_9E_le56hX-p1HJ6NtWqoyfNnJkafA
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf545b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=arUmSIHHDxOh6OzMZbEA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The service advertises shutdown and cold reboot reset types, validates
guest requests, and dispatches accepted requests through the machine
reset and shutdown callbacks. This lets firmware use RPMI reset commands
while keeping the board-specific reset policy in the RISC-V virt machine.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build            |   1 +
 hw/misc/riscv_rpmi.c           |  68 ++++++++++-
 hw/misc/riscv_rpmi_internal.h  |   9 ++
 hw/misc/riscv_rpmi_sysreset.c  | 206 +++++++++++++++++++++++++++++++++
 hw/riscv/fdt-common.c          |   8 +-
 hw/riscv/rpmi-fdt.c            |   2 +-
 hw/riscv/server_platform_ref.c |   2 +-
 hw/riscv/virt.c                |  42 ++++++-
 include/hw/misc/riscv_rpmi.h   |  11 +-
 include/hw/riscv/fdt-common.h  |   3 +-
 10 files changed, 338 insertions(+), 14 deletions(-)
 create mode 100644 hw/misc/riscv_rpmi_sysreset.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 3e298a74c8..87ea363199 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -183,4 +183,5 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
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
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
index 2110d4457e..c9cd3cad68 100644
--- a/hw/riscv/rpmi-fdt.c
+++ b/hw/riscv/rpmi-fdt.c
@@ -74,7 +74,7 @@ void riscv_rpmi_fdt_add_mbox(void *fdt,
 void riscv_rpmi_fdt_add_service(void *fdt, const char *node_name,
                                 const char *compatible,
                                 uint32_t mbox_handle,
-                                uint32_t service_group,
+                                enum rpmi_servicegroup_id service_group,
                                 bool has_mpxy_channel,
                                 uint32_t mpxy_channel)
 {
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
index 3209e09e00..6e3d143a0b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -469,6 +469,34 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
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
@@ -480,8 +508,11 @@ static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
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
 
@@ -490,6 +521,7 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 {
     RiscvRpmiConfig rpmi_cfg = virt_rpmi_config(s, NULL, 0);
     uint32_t rpmi_mbox_handle;
+    uint32_t i;
     RiscvRpmiFdtMboxConfig cfg = {
         .shmem_base = rpmi_cfg.shmem_base,
         .doorbell_base = rpmi_cfg.doorbell_base,
@@ -500,6 +532,11 @@ static void create_fdt_rpmi(RISCVVirtState *s, uint32_t *phandle,
 
     riscv_rpmi_fdt_add_mbox(MACHINE(s)->fdt, &cfg, phandle,
                             &rpmi_mbox_handle);
+
+    for (i = 0; i < rpmi_cfg.service_count; i++) {
+        riscv_rpmi_fdt_add_service_node(MACHINE(s)->fdt, &rpmi_cfg.services[i],
+                                        rpmi_mbox_handle);
+    }
 }
 
 static void finalize_fdt(RISCVVirtState *s)
@@ -537,11 +574,10 @@ static void finalize_fdt(RISCVVirtState *s)
     riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
                             s->memmap[VIRT_TEST].base,
                             s->memmap[VIRT_TEST].size,
-                            FINISHER_RESET, FINISHER_PASS, true);
+                            FINISHER_RESET, FINISHER_PASS, true,
+                            !s->have_rpmi);
     if (s->have_rpmi) {
         create_fdt_rpmi(s, &phandle, msi_pcie_phandle);
-    } else {
-        create_fdt_reset(s, &phandle);
     }
 
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
-- 
2.43.0


