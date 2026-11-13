Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17672606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H1e8NzvN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JHtWfV5C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmCO-0002nS-Ky; Fri, 13 Nov 2026 02:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCM-0002mw-Sv
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCJ-0000Du-T0
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:50 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD5ak6E3147310
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dAXX4um4Loq
 WW3ME/trj57kvCianPIWUKsGcOMHIvSE=; b=H1e8NzvNSwQoRwEnu8u2b4p+NIe
 rfuClqmGGCHNWcDfaNPv0MNQOz4SXxhJl1XDMWVZOaci6DbQjWIkBNk0Cmc3Sb1j
 J/ah/RE0GxWV6tHx9UxUT8eKJmw6mI7uhy3deCvc30u1935f7m+Ei6fu8VsaI1vz
 GqhuCfO1klOTeVBp+y4TfiLyKCSzpbj9ogtdDO1S66/yw1uRY/US2UDwB8WnlucP
 LPJDr7WfQhUmPI2ugmVRFZiB5zhGRy8oYGaplc9SFP3VMKozVNDNIYM18g2Hbqv9
 FN4c76qBRp6zz3zJhFpoXcZCwvwL6xZS/dOjVBhwDNFmbpij1jkVhRZpCuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvja8evj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36e61c89e2dso75082eec.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 23:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556786; x=1795161586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dAXX4um4LoqWW3ME/trj57kvCianPIWUKsGcOMHIvSE=;
 b=JHtWfV5CwyqSiGjqlQN2NVjEqLEt7PYNook3YxscUzjWzer2S9vH+xBnJOhezwbnW8
 jxVJMCJAMLLbiJ7atpKY18k35Oj7Kvz1H42TCmfB3xJ0ZSAreF1Lnaw/PbKCrbJHTVEQ
 f77v/egBuepB2eAJ0mabX6mWlRMFCp6127vlkYh9fsniXMgJ/RObvoYCwG9TIY9tsTA8
 MP/6Gr9PMADLElwxINASQXDSx7vhPPFNet4TDhp4MyEn3fl0mkkT+g5nfTuvrZJg6xc3
 4U0yq7hFYuEGxeUlXqVB91k4+zau+p1QzhWqwY4vGsBulXtkGn90qe4mHQjqL3zd6LJJ
 Zd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556786; x=1795161586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dAXX4um4LoqWW3ME/trj57kvCianPIWUKsGcOMHIvSE=;
 b=mqtdBVlJEJqsiWkidUSjVR6hod8xYjlpisnix/kItl+bTMs4BeNiXGHAIHoaT4/DKy
 9T83RdXeF+xA3DJ56q1P02ASz9UtmHTjx69f7BsyAycDPQuiXeILWhEI0D56Y7j237vI
 PgWprVFiWugOz5+E8+wj2qmwRotNCsSmxqkHqk+zSV8TBu0s31MXGLhapQeob790a1HT
 mITmGTQwnq6Hr4ztGTAq9n1D0Ti4rHQlS+8Z1QlTfCpJu1Tht2A8rXaDZxKPT661irVl
 Pe9IqjibMCCAa0pB92IGsh5cuelkIICSwcbaaGjahBQLTAx36Zi+7JxWut6aJQPjJSmR
 DgfA==
X-Gm-Message-State: APuU4Z9tGHXrBYz+taZYPVKK1Z9LGc6uEOH9qnQWvgLKOpFBbUuJrceh
 cUpvbXIx4tArsnDxh8Y1QGxamNHYuzH/yD1pBK3fh8x45hGbeJVoZu2zvTjoMoCOlqxxYw3hOGu
 lcoz0JKC9IdRk0I57fMj+SWZN2bydSvqL06YNfZzgvx2KqTkyiXN1WKAITmMXsiyldQ==
X-Gm-Gg: AYBFou3pBBi6mPIsdM0xU7YaVzrX1rqVspANaibJXmI7x1Fx9WjKLIc0HfTx8kNa+Rc
 chHMTuHSeoQHH17et52WL+07QeICwyxxZTFXr+r1NA0or9EWNx8c33o8kh3bAdawhS6tvbQpZE/
 StZL4oxid7K9TjE73vy6W0Njn05bQXX6QPQCFQt7nh9OuT/faP3La9TkdzYBdBls6u6lB1FJRTS
 xn289cnPCtfcUEK1bkqCMfLNQVS3T29E2iGaZlOsNM7R96noBS3AFF6mL+GUTFqzxU8MPBCLTTU
 hsJQYxM+treLlC73/Dvmd9Mmt8FydJaLgIdfJRsKooFyauUNewfKnmnqcoQAoXpWPPBd4cY9MF5
 FjxX2p3+KNq2mhoLB5AjQukC2/JlE0YtXv6477LX8rByZOL3kS5GnZPHIM+PfzPyclRE3D8pbSN
 G5kMWGc+PJHTbmFURWY5ZRBgCdapZsDn+qdcEPW93FHhO0yu9ZThRwxRsnyy+GeykzxcwzkYYEv
 FcPYZM=
X-Received: by 2002:a05:693c:20cd:10b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-379652f16f8mr2448686eec.2.1794556785383; 
 Thu, 12 Nov 2026 23:59:45 -0800 (PST)
X-Received: by 2002:a05:693c:20cd:10b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-379652f16f8mr2448650eec.2.1794556784777; 
 Thu, 12 Nov 2026 23:59:44 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm5213376eec.1.2026.11.12.23.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:59:44 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v16 05/10] riscv: add RPMI system reset service
Date: Fri, 13 Nov 2026 13:29:00 +0530
Message-ID: <20261113075906.715870-6-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: psN1NBOxSioOgFgvtvi2FzKid_Nh9VkN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX1trLWGqkfKSH
 TsR1tSPk15LHYvmfHkFLTGZnEvt0i/QtA4B42hMQ8nKKwXwgl3D7tK22AxFs5wNZEmBuo/vMFG4
 ccPsjxM1+Bkf2ZE+tLMUwQEaFWJCuwk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX2pyHSFlr+lik
 b/6qaNT+gJPd9bkwdJvpSKIWP4RZ/r66eAsBr+yKM/h+mRUazpfHBIiRHlyMJyyHVd5A/CZA+ju
 H/gGftw62B8OK6mpf82OuAESNX6+/d+jyAlRXtvgucg86y74GS4GBuwDRKU2q6DS3IaQ506bs4J
 7Mia0BUbZwIx5tIdyQBWpT28q66zqQ6qFnuWBeMYfqKKohI3F95fNsXmLzlgI89DZLL0/5gmxrI
 45nds9i9UL3131zAhZTtDJ5P/DUUPYwoyKLBrny4VpHG86x4w0FpAzSmklb0ts2cXjkm24O2AMa
 xBcszfNt5kUkdUqfpKzinXU6yHXCRZqbRO7WQSiYEHA70E7MZsdrLa6heCbBt4dYmM7w4XJNRs9
 4fhSwR0VZyeO6aLJzkbFnfUg9m6CrANTIOAMaCNGH6yFHa0OOBJhaEQ+RX5re+Nid0nWNnrp7Sh
 IsOfR4n1uNjrDDpbaWA==
X-Proofpoint-ORIG-GUID: psN1NBOxSioOgFgvtvi2FzKid_Nh9VkN
X-Authority-Analysis: v=2.4 cv=AoN7T+9P c=1 sm=1 tr=0 ts=6af6c372 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Q27P0EAC2tNmNk4ncAQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130031
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

The service advertises shutdown and cold reboot reset types, validates
guest requests, and dispatches accepted requests through machine reset and
shutdown callbacks. This lets firmware use RPMI reset commands while
keeping board-specific reset policy in the RISC-V machine.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build            |   1 +
 hw/misc/riscv_rpmi.c           |  68 ++++++++++++++-
 hw/misc/riscv_rpmi_internal.h  |   9 ++
 hw/misc/riscv_rpmi_sysreset.c  | 185 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/fdt-common.c          |   8 +-
 hw/riscv/server_platform_ref.c |   2 +-
 hw/riscv/virt.c                |  46 +++++++++-
 include/hw/misc/riscv_rpmi.h   |  10 ++-
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
index cbfea1f733..2c6e694ff0 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -201,10 +201,37 @@ static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
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
 
@@ -238,6 +265,10 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
 {
+    for (uint32_t i = ARRAY_SIZE(riscv_rpmi_service_ops); i > 0; i--) {
+        riscv_rpmi_service_ops[i - 1].remove(s);
+    }
+
     if (s->context) {
         rpmi_context_destroy(s->context);
         s->context = NULL;
@@ -280,6 +311,30 @@ void riscv_rpmi_context_process_a2p_request(RiscvRpmiState *s)
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
@@ -365,9 +420,16 @@ static bool riscv_rpmi_add_service_group(RiscvRpmiState *s,
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

