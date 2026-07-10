Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7DAC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAs7-0006Vm-ET; Fri, 10 Jul 2026 09:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiArF-00067d-GV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wiArB-00061d-5G
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:01:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AAnCtm570608
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3Zi3YOFyUx8
 7EoAznmuJNik04JSRbYxYi7RMXJIg/zc=; b=YEn29ifpjKpUw3xwnTPoUBBqaeS
 Bl7o7XEFUDgUt7L6ktL+s5S0iEVNQEGO4YKMIoZ6Ru4pIgFiGVskc+SA9R+uE2U6
 iJWst+aK3Q2TTRCzT40EVxhXLUka5OIvOJZD3t7oFCq4Br3mpLZNRoyA2rNCzRIR
 HZI+nQ1uQ1ksmIYwUTZ93fThgTdKh/VOk+z5E7sREl+igche9A0lJv53nGg7SSID
 giljMp+HVGEc9XxGVRJzfdadJgLYp0xRYTUFz+Tr4cenrr6r8XliX820uVla8+4n
 n07pup7TvlEiDUue9n3myf5nmf8UQHXcNqFumic4FyrL0ZemjC1ya7ydhUQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f8qnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:01:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so201160a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783688484; x=1784293284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Zi3YOFyUx87EoAznmuJNik04JSRbYxYi7RMXJIg/zc=;
 b=FyGCnpSEmZ3rgkamJpJHDvLIWEhCUl2ncliUKpqjHNP0aP74aDQMt2n7Asdgt0qy7G
 E57i/0IXNJpASP/iH38nqzGhx2Nh0PXQ5yIcT7JaJacd67MFuZAiKd8rssNIPtcbFozq
 HMIXiUPb4upACB4TlZtOnm+Qfysqt0DOFFy6gHL4AiBElxYlGn+ZzdPqwuglyB2op5LF
 J2Mi95HYpsDuU2RkkK16yLaXkmlB867rhMGli1PXcTWHSLEACSD60k4QRncQLzJCK+K/
 su4QH0thO4AESmDdh3b1gxyco0tYXg25aMbj24Fou1FyEqoL4LCQ5QTVI50x4qWPJvs7
 UTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783688484; x=1784293284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Zi3YOFyUx87EoAznmuJNik04JSRbYxYi7RMXJIg/zc=;
 b=ZL5QPwVJc8bua+CRWnULGrsfQXVc56l+CP/kPPLCreKXcJCaJg/2JJAv329k81VSXd
 xcbyGDHkdx0DjZjV59YD1R8MaKXryzOpXuUvDct3gq/VeRnMr9FZd4ihO1Y+N9JpZ8ik
 h6HLL3ygq9evq/AVNuDjqRnsjBeN5+h6VaSAcSHZ/U0Q39hwGUGhPOkN6X8GIbu11SDu
 LKjZBEbzDlPldZyGlKvuTxjGZQplmq5hpg3xMmxiFBrsqvGXJX51P6T0W4qW4WeWQ57I
 H31wdj9pdq2wEAcAoXnjHbzxFRPp/2Iwj0t4RFP0ZTBNAoOBwXiSCP9DwlZYGwU0Z80I
 72Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqpl3OLaRCFtsmOYqJrfzu4hsLvf73McrJqULbImKv6MWokWfUjCUGJ14oHxoiFuj0QGOagF87hqRnb@nongnu.org
X-Gm-Message-State: AOJu0Yy6De1pWtJAiJJYlI2EXf66lZaxpAOEVqdzAWEDnUHaHkjGXcPe
 gF4KjuP20DqiW8cv0ZP8TcPNJ1SkF2KFdH/PqEOYvHY9+DZDzob/k8LbTLyN5Ft9cK/srfikero
 6V7d7yRmQVqAkLPsKv6TJReTfSDUo1127AD2zfN8KXoBhr+GCMfm7Om5cQw==
X-Gm-Gg: AfdE7cls2v7monN+ndZBK3JPDYxFJcjl0fyZc32H70+ygjjTdsFwA9PE9DFei+Ti8vz
 Cs4VN7aMtIpSCSfEh22OS+JucORg6Q9KPFjjtsk8kLftjRt0Fy1XRWXKWs2tWgkkfKiw2jy08Ls
 EbuteUjLsLtrZUQK67MJ9hz2nHrH4xJXFWwNhA5Dt4UKnsSWyAALPYuim8qHI81KrDSa1eqJptK
 Pi/cmQLgPsR8O/45axZB6V1QektP4yGjB2blIalYuLXEMcPg5OYZfFOX7soghxQZAqL10pxEk4H
 LXBse5oVIP4al5aEQx3BkUyCrwweVysFX6mgEBWR3fINYNoVleOVzGSJ42VFIybPwHmHep7bDta
 2NNks3qjI+BrxkHUOkQMJbMEQOgk0NbybMPS61ziVBbHubOCZxIdXM0abiEbvjdFCAX4hHdLyjD
 BvJ5ipR1gU/2hJW3jQqmI+B6D9OhRBZuyIewExMGjrFw==
X-Received: by 2002:a17:90b:4b0b:b0:381:cef1:11b2 with SMTP id
 98e67ed59e1d1-38942798063mr8955229a91.7.1783688483676; 
 Fri, 10 Jul 2026 06:01:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0b:b0:381:cef1:11b2 with SMTP id
 98e67ed59e1d1-38942798063mr8955192a91.7.1783688483154; 
 Fri, 10 Jul 2026 06:01:23 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm9611839eec.6.2026.07.10.06.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:01:22 -0700 (PDT)
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
Subject: [PATCH 06/10] riscv: add RPMI HSM service
Date: Fri, 10 Jul 2026 18:30:40 +0530
Message-ID: <21b8264726d7d4a2dfc2c4446e980ffc18f9829e.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a50ed24 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=hCKTHIyopvcgo9YcQkoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: L1zG3wbvnXhilyVtkvwSROD9C1bhRWkS
X-Proofpoint-GUID: L1zG3wbvnXhilyVtkvwSROD9C1bhRWkS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfX1ej8M8SwYL0J
 6aOF/dLodrylWGP0BK/Dkkou1SJAwzUtvBLdbkUnDKi6W0/Ssjs22eJ5xZR4pENW4OdZPHfXu/O
 0IZwIzWoq8NKYjJSrEnRYP5SEEuh3d4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyOSBTYWx0ZWRfXziIOyt+ECWdY
 H15ABZ8erGtmVn3wLWwk/LVX0P/KSNiJ0CMuxh83yTyg9YpojTQnYzjpPg0ehuBsR/TJBzBDx3i
 MdXu9JBCQrXZ9XvhWy5ecnjIYVWi3aXIIOHgqvR6M5xNpAmV7rp3l1CSlXXkOhzqbXNoK1LA00M
 l66srW5plwEKO8+Vlor1juppfw1GWabTUq+NTUuLLq44BDFGfXiJAWptzb2iSzwgEgswZ7Ud068
 Db4DFrwzclpAsWgGL14sSKu5iTAodbGtitxWteMCO23PoZQYBt9S98ZdIH554GJt+xYRucGB4Pl
 1uJRciRKJrEHr/iOForaTSA6zhx1OaqdZ80+aV0rW0QPUbPn2CV+feT02/aweRYE9dKqAEbrdTU
 X2aOUh+dZt5eFhjduGeESEjkKHgmZmnWyh4VDc1bn77qjZG1aosTUhvwWT1gFe5lhoQnmkata/K
 aKa/VTsjMRO34F2Ctmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100129
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Message-ID: <20260710130040.zYlkrzbn64bNvTP2bhdbTwvR5SBhWrqpIEopUMy-6ro@z>

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Add the RPMI Hart State Management service group for RISC-V virt.

The service exposes the configured virt hart IDs to librpmi and keeps
per-hart RPMI hardware state in the RPMI device. Start, stop, and
suspend requests update QEMU CPU halted state and resume/kick vCPUs as
needed so firmware can exercise RPMI HSM operations against the emulated
topology.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |  46 ++++++
 hw/misc/riscv_rpmi_hsm.c      | 280 ++++++++++++++++++++++++++++++++++
 hw/misc/riscv_rpmi_internal.h |   4 +
 hw/riscv/virt.c               |   6 +
 include/hw/misc/riscv_rpmi.h  |   6 +
 6 files changed, 343 insertions(+)
 create mode 100644 hw/misc/riscv_rpmi_hsm.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index bca7819ee0..fc5b11ed57 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -171,4 +171,5 @@ system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
+  'riscv_rpmi_hsm.c',
 ), librpmi])
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 7a3f570ee7..820b1d5d63 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -171,6 +171,49 @@ static bool riscv_rpmi_transport_indices_valid(RiscvRpmiState *s)
                                           s->a2p_req_size);
 }
 
+typedef struct RiscvRpmiServiceOps {
+    RiscvRpmiServiceKind kind;
+    void (*configure)(RiscvRpmiState *s, const RiscvRpmiConfig *cfg);
+    bool (*add)(RiscvRpmiState *s, Error **errp);
+    void (*remove)(RiscvRpmiState *s);
+} RiscvRpmiServiceOps;
+
+static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
+    {
+        .kind = RISCV_RPMI_SERVICE_SYSRESET,
+        .add = riscv_rpmi_sysreset_add,
+        .remove = riscv_rpmi_sysreset_remove,
+    }, {
+        .kind = RISCV_RPMI_SERVICE_HSM,
+        .add = riscv_rpmi_hsm_add,
+        .remove = riscv_rpmi_hsm_remove,
+    },
+};
+
+static const RiscvRpmiServiceOps *riscv_rpmi_service_ops_by_kind(
+    RiscvRpmiServiceKind kind)
+{
+    for (uint32_t i = 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) {
+        if (riscv_rpmi_service_ops[i].kind == kind) {
+            return &riscv_rpmi_service_ops[i];
+        }
+    }
+
+    return NULL;
+}
+
+static void riscv_rpmi_configure_services(RiscvRpmiState *s,
+                                          const RiscvRpmiConfig *cfg)
+{
+    for (uint32_t i = 0; i < ARRAY_SIZE(riscv_rpmi_service_ops); i++) {
+        const RiscvRpmiServiceOps *ops = &riscv_rpmi_service_ops[i];
+
+        if (ops->configure && riscv_rpmi_service_enabled(s, ops->kind)) {
+            ops->configure(s, cfg);
+        }
+    }
+}
+
 static void riscv_rpmi_configure_base(RiscvRpmiState *s,
                                       const RiscvRpmiConfig *cfg)
 {
@@ -187,6 +230,8 @@ static void riscv_rpmi_configure_base(RiscvRpmiState *s,
                                     cfg->hart_count * sizeof(*cfg->hart_ids));
         }
     }
+
+    riscv_rpmi_configure_services(s, cfg);
 }
 
 static void riscv_rpmi_init(Object *obj)
@@ -209,6 +254,7 @@ static void riscv_rpmi_reset(DeviceState *dev)
         memory_region_set_dirty(&s->shmem, 0, s->shmem_size);
     }
 
+    riscv_rpmi_hsm_reset(s);
 }
 
 static void riscv_rpmi_cleanup(RiscvRpmiState *s)
diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
new file mode 100644
index 0000000000..9a9859b10c
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
index fe09804e69..42a6708907 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -30,4 +30,8 @@ void riscv_rpmi_context_remove_group(RiscvRpmiState *s,
 bool riscv_rpmi_sysreset_add(RiscvRpmiState *s, Error **errp);
 void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
 
+bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
+void riscv_rpmi_hsm_reset(RiscvRpmiState *s);
+
 #endif
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 273a9aa04f..2b5f367bdb 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1014,6 +1014,12 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
         .compatible = "riscv,rpmi-system-reset",
         .service_group = RISCV_RPMI_SRVGRP_SYSTEM_RESET,
     },
+    {
+        .kind = RISCV_RPMI_SERVICE_HSM,
+        .node_name = "hsm",
+        .compatible = "riscv,rpmi-hsm",
+        .service_group = RISCV_RPMI_SRVGRP_HSM,
+    },
 };
 
 static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index d11db87731..37c56ea2e8 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -28,6 +28,7 @@
 #define VIRT_RPMI_P2A_REQ_SIZE 0
 
 #define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
+#define RISCV_RPMI_SRVGRP_HSM            5
 
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
@@ -36,10 +37,12 @@ struct rpmi_context;
 struct rpmi_service_group;
 struct rpmi_shmem;
 struct rpmi_transport;
+struct rpmi_hsm;
 
 typedef enum RiscvRpmiServiceKind {
     RISCV_RPMI_SERVICE_INVALID = 0,
     RISCV_RPMI_SERVICE_SYSRESET,
+    RISCV_RPMI_SERVICE_HSM,
 } RiscvRpmiServiceKind;
 
 typedef struct RiscvRpmiMachineOps {
@@ -83,6 +86,9 @@ struct RiscvRpmiState {
     const RiscvRpmiMachineOps *machine_ops;
     void *machine_opaque;
     struct rpmi_service_group *sysreset_group;
+    struct rpmi_hsm *hsm;
+    struct rpmi_service_group *hsm_group;
+    uint32_t *hsm_hw_states;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
-- 
2.43.0


