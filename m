Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0492AC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 04:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wujvd-0008UZ-4R; Fri, 14 Aug 2026 00:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvc-0008Tz-0W
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:54:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvZ-0005MM-Ji
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:53:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QTiF1172827
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6bxs8rh3wzn
 dNtUl/WtNWpU3a+41+rF4vOSWaL9Ob6g=; b=H2Bb+6EKC8U9N5pGH4XJKcTJK8J
 29VwJUot03pVburNFbSf1zmhyAEt4MclpflibxaEM4RT7ZLObyEJREvcVwwtgEKC
 xc2VkjxEdwx55lkBi8Dc/g6h2o8MUebMkbd2wXFNL5f6O+vTsAubYpkk9e5gSaLL
 uMGjPvftXws+JOmft9tpSkX7vLhOhZAnBh0FTqKjKL+b5ffacdjP0vJZ9/Fhfgyc
 nB4nrX7vi1r7oP8D9AhAi5LDMdfoKNvBFFoTg8oW1e6jRXh0cw35H13CsjRqvvr2
 QT/5o3M3P7F1N1OyaIXWtQDEl6Ng9a1qzSUPA8UJM1h4SJv/BA068rTLG0Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1nugs89m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:53:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca8aee882c4so94408a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 21:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786683234; x=1787288034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6bxs8rh3wzndNtUl/WtNWpU3a+41+rF4vOSWaL9Ob6g=;
 b=BVV7NUm2AAgAPyrtcY/gWQOvy80W6k7P4E/sxOKP9qWRQOzHXG4vqGcuAFMOb/ardM
 TDGz9M71PNLzID4N7yVonmBVK1Wv4YbDPDqs1j+zeOXq/np7EaLd4267kfRivLViCCbm
 BI8mqoTzQ+YN9UMt2xW0tA8OfkY9YJoOMISz9zbABe19Pf+v0pWtlynCE/UHUrOwUKbT
 85qmjmIgakc+SvvNtfmaQq2Gswe3wStgebhITqyf8HEsUrho4fk/J2GK192MciJCpl99
 xShz8PMGnGcB/FM9pYLbVcRJKQHwKraKLrdhHGWBOQuNAgSecmCJXamGcV2TkfXoz2gk
 1evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786683234; x=1787288034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6bxs8rh3wzndNtUl/WtNWpU3a+41+rF4vOSWaL9Ob6g=;
 b=KKsxSWK751Q0ENZzH9I3POJpmbdIpHTRS6yB2pTJv+34xcXE3EZGcAybjGmunMVHPe
 exWLHvJZxTyMySP5zMdzVgxxCxZ9NXyj/UDqobEzFjy/RhuVtxSOgtldlDCVr05+htvh
 n6f5I5Z6ZhpCUpEIJ3ciINawHyJGFeZB6cg4ICp6UihOXu/zkgRF0D/SfgPfu0I/ZK0T
 1Z3+LKuaj71tgDqkCvpQ6XOi5VYot7wJxNfhZHsBAfGTFYedqzwYsIILovTv3nPjW5YX
 9vD6J3xz0bWGG9J6s0Tn10aoHKOXOoIynFAT3B+trKftb15C6UwRVQq0+2UYYhV9141F
 Qj2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5BxBrsG1n007vIyaMJY8+yxNMehObhiRkf+PTZUbytSsvXG39hSvsSWI3BDjysumFqqqZCwz7C978@nongnu.org
X-Gm-Message-State: AOJu0YxloqXzM1t4r8jtSfIa8Nda1HmUenFcrCNtsWJz5ovGijFgNNYK
 B4rMsXYNXLB7RIWVkLv8WIsq0W18YFMxTWyBJtXA3e4opTY1CTufkzophQe4JRRzaclUQWUKz3i
 tpu7nZTFRYXXD+o7FQqJYxQUqYtWnvyzoXPpdiOb35+IMCRTLTbyRJp8eGA==
X-Gm-Gg: AR+sD11Ju4tLS5u4yZqyBxZOZWx+1cjjoIl+0BXr06V1Oi9pf4i7T9tlUHUMV2ykdD9
 E30feKBrP5jHcEL2d18YfEXdhNAxktNqeYDGnIysP4JElsg6mij4NNNF8yLpXuvGY96Mwo4aIni
 FU5duxoQOzaVZNBcOzJCVwe9EvnIOi9TIYBF32rWcqc6hH4IRg5ZWAJ0TVCDT39uvWuMyd9XvdR
 LiXVlneGsFuISMXwiAh9tsICtp+jjeuy6rgCe8PSKucNTSxQQnwPLYuxRiP/pJc/2df3xV48Vt3
 MpOhnP3jgFilvqXqKv6DQw3lpg3KpOSWWYdWsIZ92V533otdVjJ8oFuyp4F31hbiI6EOhz/yXoO
 h+0hQzgS/bdwL6/8dnYFcYy7AB/mNGnJwFXpsvRm/VWzspRD38AhKUyZQkijF3jLyRzGxLNXv5M
 wRJL1EegNVYo83Ed/wgoayAFGLtb+M5f8=
X-Received: by 2002:a17:902:c944:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d3b0e152e0mr25064685ad.2.1786683234379; 
 Thu, 13 Aug 2026 21:53:54 -0700 (PDT)
X-Received: by 2002:a17:902:c944:b0:2d2:a952:2628 with SMTP id
 d9443c01a7336-2d3b0e152e0mr25064355ad.2.1786683233844; 
 Thu, 13 Aug 2026 21:53:53 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f15063cd8sm10625665eec.9.2026.08.13.21.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 21:53:53 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v8 06/10] riscv: add RPMI HSM service
Date: Fri, 14 Aug 2026 10:23:10 +0530
Message-ID: <20260814045315.3416169-7-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX9Ni89lLgalh6
 gfAG6MctgBI0c9v/PxYf1rYRe8CoqnQp5hyK9L70zzB3ij1ufKWZO7+UzRiCYv+xEU3f9fdhiBY
 D0pWS3BraUEvqgeE8R2YKKZWuwHvmlskK8w/4c+dcPIBLl2QqcN7IVRRw5xTkNwZ68Ki2tGr99W
 bo41q6Gbpfh2ofLzoEdCdrFexTEGuY0KkLF2EjH2V6MCkONoPMY3p1ICM9nFGcjHWfKZaoHhVm7
 v1LlmRqhBQVGwdpHKSnhFbyAojwMEUsfGnOqwX9w3fnD8GHSA3axWKnBuZ+hGIFlNS2RKXTwy7y
 BzUTgSRL1OW2WTYaDGmhVfeWUMO9hxO4nT6FSo7xoiIzPi2tUIX6a2WA/plWI2vnuzcY6GUI3is
 CWx+k9KzQNzpTH3sCjvHo++ATbC9Px0PP5GGKhWbbn1lZLeZZoE/Mh9Y8eO3BKo2EK/crKyJ5a9
 wGhmc71ofytT2klFJoQ==
X-Authority-Analysis: v=2.4 cv=drfrzVg4 c=1 sm=1 tr=0 ts=6a7e9f63 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=itn9ZVZVmevHaGIKV1oA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: VbWsYK8P1AZ2Trn40AHLa2H4fQ95kcR0
X-Proofpoint-GUID: VbWsYK8P1AZ2Trn40AHLa2H4fQ95kcR0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX1z5pgSFaESqD
 xVwQmrtdvhZXRXvjDNOX82HSz+EFcRY1tOqohY/vrqcqaHNN0CKX4NClP0IWbMaINNnfl0jnBx4
 rFXy0eaVvzm/RdG21B3C905TweWEgOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140036
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

Add the RPMI Hart State Management service group for RISC-V virt.

The service exposes the configured virt hart IDs to librpmi and keeps
per-hart RPMI hardware state in the RPMI device. Start, stop, and
suspend requests update QEMU CPU halted state and resume/kick vCPUs as
needed so firmware can exercise RPMI HSM operations against the emulated
topology.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |   5 +
 hw/misc/riscv_rpmi_hsm.c      | 280 ++++++++++++++++++++++++++++++++++
 hw/misc/riscv_rpmi_internal.h |   4 +
 hw/riscv/virt.c               |   5 +
 include/hw/misc/riscv_rpmi.h  |   5 +
 6 files changed, 300 insertions(+)
 create mode 100644 hw/misc/riscv_rpmi_hsm.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 482f56504e..6c70d93358 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -171,4 +171,5 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
+  'riscv_rpmi_hsm.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 9575cd3a8d..2805598446 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -182,6 +182,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
         .service_group = RISCV_RPMI_SRVGRP_SYSTEM_RESET,
         .add = riscv_rpmi_sysreset_add,
         .remove = riscv_rpmi_sysreset_remove,
+    }, {
+        .service_group = RISCV_RPMI_SRVGRP_HSM,
+        .add = riscv_rpmi_hsm_add,
+        .remove = riscv_rpmi_hsm_remove,
     },
 };
 
@@ -234,6 +238,7 @@ static void riscv_rpmi_reset_hold(Object *obj, ResetType type)
         memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
     }
 
+    riscv_rpmi_hsm_reset(s);
 }
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
new file mode 100644
index 0000000000..006ddc3b5a
--- /dev/null
+++ b/hw/misc/riscv_rpmi_hsm.c
@@ -0,0 +1,280 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI HSM service.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "riscv_rpmi_internal.h"
+#include "hw/core/cpu.h"
+#include "librpmi_env.h"
+
+static const struct rpmi_hsm_suspend_type riscv_rpmi_hsm_suspend_types[] = {
+    {
+        .type = 0,
+        .info = {
+            .flags = 0,
+            .entry_latency_us = 0,
+            .exit_latency_us = 0,
+            .wakeup_latency_us = 0,
+            .min_residency_us = 0,
+        },
+    },
+};
+
+typedef struct RiscvRpmiHsmStateTransition {
+    enum rpmi_hart_hw_state state;
+    bool halted;
+    bool resume;
+} RiscvRpmiHsmStateTransition;
+
+static const RiscvRpmiHsmStateTransition riscv_rpmi_hsm_state_transitions[] = {
+    {
+        .state = RPMI_HART_HW_STATE_STARTED,
+        .halted = false,
+        .resume = true,
+    }, {
+        .state = RPMI_HART_HW_STATE_STOPPED,
+        .halted = true,
+        .resume = false,
+    }, {
+        .state = RPMI_HART_HW_STATE_SUSPENDED,
+        .halted = true,
+        .resume = false,
+    },
+};
+
+static const RiscvRpmiHsmStateTransition *riscv_rpmi_hsm_state_transition(
+    enum rpmi_hart_hw_state state)
+{
+    for (uint32_t index = 0;
+         index < ARRAY_SIZE(riscv_rpmi_hsm_state_transitions); index++) {
+        if (riscv_rpmi_hsm_state_transitions[index].state == state) {
+            return &riscv_rpmi_hsm_state_transitions[index];
+        }
+    }
+
+    return NULL;
+}
+
+static CPUState *riscv_rpmi_hart_cpu(RiscvRpmiState *s, uint32_t hart_index)
+{
+    if (hart_index >= s->hart_count || !s->hart_ids) {
+        return NULL;
+    }
+
+    return cpu_by_arch_id(s->hart_ids[hart_index]);
+}
+
+static void riscv_rpmi_hsm_set_hw_state(RiscvRpmiState *s,
+                                        uint32_t hart_index,
+                                        enum rpmi_hart_hw_state state)
+{
+    CPUState *cpu = riscv_rpmi_hart_cpu(s, hart_index);
+    const RiscvRpmiHsmStateTransition *transition;
+
+    if (hart_index >= s->hart_count || !s->hsm_hw_states) {
+        return;
+    }
+
+    s->hsm_hw_states[hart_index] = state;
+    if (!cpu) {
+        return;
+    }
+
+    transition = riscv_rpmi_hsm_state_transition(state);
+    if (!transition) {
+        return;
+    }
+
+    cpu->halted = transition->halted;
+    if (transition->resume) {
+        cpu_resume(cpu);
+    } else {
+        qemu_cpu_kick(cpu);
+    }
+}
+
+static enum rpmi_error riscv_rpmi_hsm_start_prepare(
+    void *priv, rpmi_uint32_t hart_index, rpmi_uint64_t start_addr)
+{
+    RiscvRpmiState *s = priv;
+    CPUState *cpu = riscv_rpmi_hart_cpu(s, hart_index);
+
+    if (!cpu) {
+        return RPMI_ERR_INVALID_PARAM;
+    }
+
+    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STARTED);
+    return RPMI_SUCCESS;
+}
+
+static void riscv_rpmi_hsm_start_finalize(void *priv,
+                                          rpmi_uint32_t hart_index,
+                                          rpmi_uint64_t start_addr)
+{
+}
+
+static enum rpmi_error riscv_rpmi_hsm_stop_prepare(void *priv,
+                                                   rpmi_uint32_t hart_index)
+{
+    RiscvRpmiState *s = priv;
+
+    if (!riscv_rpmi_hart_cpu(s, hart_index)) {
+        return RPMI_ERR_INVALID_PARAM;
+    }
+
+    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STOPPED);
+    return RPMI_SUCCESS;
+}
+
+static void riscv_rpmi_hsm_stop_finalize(void *priv, rpmi_uint32_t hart_index)
+{
+}
+
+static enum rpmi_error riscv_rpmi_hsm_suspend_prepare(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_hsm_suspend_type *suspend_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    if (!suspend_type || !riscv_rpmi_hart_cpu(s, hart_index)) {
+        return RPMI_ERR_INVALID_PARAM;
+    }
+
+    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_SUSPENDED);
+    return RPMI_SUCCESS;
+}
+
+static void riscv_rpmi_hsm_suspend_finalize(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_hsm_suspend_type *suspend_type,
+    rpmi_uint64_t resume_addr)
+{
+}
+
+static enum rpmi_hart_hw_state riscv_rpmi_hsm_get_hw_state(
+    void *priv, rpmi_uint32_t hart_index)
+{
+    RiscvRpmiState *s = priv;
+
+    if (hart_index >= s->hart_count || !s->hsm_hw_states) {
+        return RPMI_HART_HW_STATE_STOPPED;
+    }
+
+    return s->hsm_hw_states[hart_index];
+}
+
+static const struct rpmi_hsm_platform_ops riscv_rpmi_hsm_ops = {
+    .hart_get_hw_state = riscv_rpmi_hsm_get_hw_state,
+    .hart_start_prepare = riscv_rpmi_hsm_start_prepare,
+    .hart_start_finalize = riscv_rpmi_hsm_start_finalize,
+    .hart_stop_prepare = riscv_rpmi_hsm_stop_prepare,
+    .hart_stop_finalize = riscv_rpmi_hsm_stop_finalize,
+    .hart_suspend_prepare = riscv_rpmi_hsm_suspend_prepare,
+    .hart_suspend_finalize = riscv_rpmi_hsm_suspend_finalize,
+};
+
+static bool riscv_rpmi_hsm_create(RiscvRpmiState *s,
+                                  struct rpmi_service_group **group,
+                                  Error **errp)
+{
+    struct rpmi_hsm *hsm;
+
+    if (!s->hart_count || !s->hart_ids) {
+        error_setg(errp, "RPMI HSM service requires hart IDs");
+        return false;
+    }
+
+    s->hsm_hw_states = g_new0(uint32_t, s->hart_count);
+    for (uint32_t i = 0; i < s->hart_count; i++) {
+        s->hsm_hw_states[i] = RPMI_HART_HW_STATE_STARTED;
+    }
+
+    hsm = rpmi_hsm_create(s->hart_count, s->hart_ids,
+                          ARRAY_SIZE(riscv_rpmi_hsm_suspend_types),
+                          riscv_rpmi_hsm_suspend_types,
+                          &riscv_rpmi_hsm_ops, s);
+    if (!hsm) {
+        g_clear_pointer(&s->hsm_hw_states, g_free);
+        error_setg(errp, "failed to create RPMI HSM context");
+        return false;
+    }
+
+    *group = rpmi_service_group_hsm_create(hsm);
+    if (!*group) {
+        rpmi_hsm_destroy(hsm);
+        g_clear_pointer(&s->hsm_hw_states, g_free);
+        error_setg(errp, "failed to create RPMI HSM service group");
+        return false;
+    }
+
+    s->hsm = hsm;
+    return true;
+}
+
+static void riscv_rpmi_hsm_destroy(RiscvRpmiState *s)
+{
+    if (s->hsm_group) {
+        rpmi_env_free_lock(s->hsm_group->lock);
+        s->hsm_group->lock = NULL;
+        rpmi_service_group_hsm_destroy(s->hsm_group);
+        s->hsm_group = NULL;
+    }
+
+    if (s->hsm) {
+        rpmi_hsm_destroy(s->hsm);
+        s->hsm = NULL;
+    }
+
+    g_clear_pointer(&s->hsm_hw_states, g_free);
+}
+
+
+bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp)
+{
+    struct rpmi_service_group *group;
+
+    if (s->hsm_group) {
+        error_setg(errp, "duplicate RPMI HSM service descriptor");
+        return false;
+    }
+
+    if (!riscv_rpmi_hsm_create(s, &group, errp)) {
+        return false;
+    }
+
+    if (!riscv_rpmi_context_add_group(s, group, "HSM", errp)) {
+        s->hsm_group = group;
+        riscv_rpmi_hsm_destroy(s);
+        return false;
+    }
+
+    s->hsm_group = group;
+    return true;
+}
+
+void riscv_rpmi_hsm_remove(RiscvRpmiState *s)
+{
+    riscv_rpmi_context_remove_group(s, s->hsm_group);
+    riscv_rpmi_hsm_destroy(s);
+}
+
+void riscv_rpmi_hsm_reset(RiscvRpmiState *s)
+{
+    if (!s->hsm_hw_states) {
+        return;
+    }
+
+    for (uint32_t i = 0; i < s->hart_count; i++) {
+        s->hsm_hw_states[i] = RPMI_HART_HW_STATE_STARTED;
+    }
+    if (s->hsm) {
+        rpmi_hsm_process_state_changes(s->hsm);
+    }
+}
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index ca9838d256..3b8546a553 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -29,4 +29,8 @@ void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
 bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);
 void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
 
+bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
+void riscv_rpmi_hsm_reset(RiscvRpmiState *s);
+
 #endif
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 26b1a61fec..563ddc07fd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1022,6 +1022,11 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
         .compatible = "riscv,rpmi-system-reset",
         .service_group = RISCV_RPMI_SRVGRP_SYSTEM_RESET,
     },
+    {
+        .node_name = "hsm",
+        .compatible = "riscv,rpmi-hsm",
+        .service_group = RISCV_RPMI_SRVGRP_HSM,
+    },
 };
 
 static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index a9ccc950e9..13a058a062 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -28,6 +28,7 @@
 #define VIRT_RPMI_P2A_REQ_SIZE 0
 
 #define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
+#define RISCV_RPMI_SRVGRP_HSM            5
 
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
@@ -36,6 +37,7 @@ struct rpmi_context;
 struct rpmi_service_group;
 struct rpmi_shmem;
 struct rpmi_transport;
+struct rpmi_hsm;
 
 typedef struct RiscvRpmiMachineOps {
     void (*system_reset)(void);
@@ -75,6 +77,9 @@ struct RiscvRpmiState {
     char *platform_info;
     const RiscvRpmiMachineOps *machine_ops;
     struct rpmi_service_group *sysreset_group;
+    struct rpmi_hsm *hsm;
+    struct rpmi_service_group *hsm_group;
+    uint32_t *hsm_hw_states;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
-- 
2.43.0


