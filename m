Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEA2E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIx-0004hF-1F; Mon, 29 Dec 2025 13:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHO-0003i2-5d
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:49 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHL-0008FY-8G
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:41 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTId0eO3797792
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R/GWoUy7LJE
 VVqvZX97tTx8AeIjr/zUMQuH53icANjM=; b=jtrrl8NVDiu+BW76E1AhNpEW2KN
 /Aw1heyYouLHooB9onmOt36HZf3o3EmOfXuxH+JdYlA5cTc63qV7rGcix1k616HA
 dqQc8zFZjnZinxztpDk6odVr8W1FKIsaCYY4El/sL9ixWUu0PxFX8Y2QVvGZ0rEn
 qBwewxwhqqa9okAVJJyuN52idxJTuV8OraaR0nfEN6GO83yenx3Ee1JfPbJ3L5Lf
 2i05w9NYO4n16+Ce7HXhWtVQ8v8KI2105FdoL9/rS+p2GidV8lss408uBrrwS+/R
 xQYWrU8UbMsiKtuZTexyxmgw+Dj8J2T/kr5laXAMS2O8ZC3fkVAkpzDcuXQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bavrj3mg4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f8e6a5de4so127693155ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034056; x=1767638856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/GWoUy7LJEVVqvZX97tTx8AeIjr/zUMQuH53icANjM=;
 b=K+XIqZev3majGN9OLppddxlQ7Q69eZbqLEpTJq0TfjJWxVgtEqxAgADyeY8loF6Qbd
 vAJlqzTD4sAJycFxLOiS3p/yTmOlYdFSim2IKYHJyliKJQSVEHd8KXucBE37/zfuzXIw
 Q980BVsRP1hbCdgPfPd/ZmYCkxhthS0zdtpANfPJ41pKrKXRmSLw6B3rx0HMJ/CRB3nk
 ZMY1e3vWf8+GJGp3goKgEC1saWQ11Op+XDOf6GyFqfFLVoxpbVzvMePBglkg5nJkMCjE
 taL++LQP58G6xkex76aCqytc69VJ5IJNbXKjxB/vRrxobHQnw17YXRSE+OwrET+s5umz
 5sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034056; x=1767638856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R/GWoUy7LJEVVqvZX97tTx8AeIjr/zUMQuH53icANjM=;
 b=hWD+7DhlnXgbUDQ9tINZxO/nqgewy7sRRIgJl7Ci4cJ0QbQjbovfd4J8/vTaKMtnO3
 fT2Y374n85FBqzD4LCnDWgaX35iVmS+evlWGFYncBRenatytatSG63PziuMxjHTWQIRG
 LzLV6c6I+PDtpD1S5ar5Z1sE2ZoWT4/nAN3itnnPyrV3aU7LuDZU4pFjhAqffSx5czvE
 WFhGMxE4+rROVqX7lMjHRV+iTDh1rf6OVnPiJ8uR849XLttYaX2UJUcv/LDgjyLqMiOt
 /uJB4VEFvQphPdcxLhu9qCegO49vf2Y6WtpDt5Ntnss2EK19E7kBoScBXuFwb1Qp77SF
 jMbw==
X-Gm-Message-State: AOJu0Yy3b7CdHx1ttKob/ihQbZZPldT0w6yExoxfiPf+5zqHjpkT4cSN
 Lz+9+AYNCO0AEzpZOJRvAK8fCmDJlOYL5RCnFIXG7NTyrhBuCjhoPIztBgfhhTGGHiae/v0KibZ
 pHx1/y85+1X7ancfFObk0SRVKXkFwZ8fmviJLayacFOr0SyFQv40GrvFKsjIw3GkBpg==
X-Gm-Gg: AY/fxX4fffVOaT1BE28mvRcagAEyg3a3+kD+Pe6+wtYA9BJYTjBPFK1LwvyhSOIQjes
 cfIvm/dqb9N/uY7ci9F85Vcdlq7gzuamSCgdnbxheT7wsybmbB75vUY8Hk3WYd71/SIV7DtzwjG
 aRvV4fX/IHSduaTjnvtYOEt0kuwNs0knSvd6pHKv8quArVxoruziJ/7yO2QPduGcg6zC8JZ67gr
 e0PGlJwfflXNpi9k7YiwaF1ujYVWb1QViMkpbqB5eaVQHT9oXk9HS5TUOXXlaUeP9aat+bmL42U
 DjqxKXQj7C5zr7AaDnO9MlE6bf+edaMxW1Z8fHACojNY/16T9GVv3h4+I689K6m7BzURBD4iXdm
 JqwSA0qY5JP8LnBUd++Fwyq3J7Lhp1e2fRnOU5vzkpz+47GE=
X-Received: by 2002:a17:902:ced0:b0:2a3:1b33:ae30 with SMTP id
 d9443c01a7336-2a31b33af21mr207308475ad.51.1767034055483; 
 Mon, 29 Dec 2025 10:47:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpjBSQ45DO9xo7N18Kt8HnyR1+KUvgtTi3W7GcPzmZBfA1hf21k9a+6iqYBm3wwoswtKDRog==
X-Received: by 2002:a17:902:ced0:b0:2a3:1b33:ae30 with SMTP id
 d9443c01a7336-2a31b33af21mr207308335ad.51.1767034054950; 
 Mon, 29 Dec 2025 10:47:34 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:34 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 07/17] target/riscv: add initial trace instrumentation
Date: Mon, 29 Dec 2025 15:46:46 -0300
Message-ID: <20251229184656.2224369-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qiq4DLWVCErnGbK-SxtEmmYnUtm_tNAO
X-Proofpoint-GUID: qiq4DLWVCErnGbK-SxtEmmYnUtm_tNAO
X-Authority-Analysis: v=2.4 cv=coiWUl4i c=1 sm=1 tr=0 ts=6952ccc8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZZQmujYLDWRuECq2q14A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfXzzGIiZLlO9m9
 RZ8yn+v5p6j1VMdcMSjCg1b4Yp24wUM1w0rEo1D25Vmn6L1h2PJn9L04iZmUybOzVCvL2GROp0u
 nZRu+5H/6WSVJ9vfaoaLVxkOvwoRPBrZPKDvyxnom/dmBY1NgbUCvdrBxs9gg1GoNYuocsEShYq
 KwlJ2CVGRbPNWL8ioEFZPZFXX1cGbVLRvgETysHRAxhFaAwVbc9XjVSBj7DTpW8kU8DhGuT9f0e
 15u14nG3SrQ8ZH1pB9wKbS3EYTKuUFyBkqlPqQoYhynx0UFbdgn5cH26sZRjS3zgquUCKHbfQSb
 Ld8HKwaVMMNoaP57mxuBl2llCfusJBGPeANqwmPJ2JfcL88WYerb/FviESWzzTGTGkI29iqUci6
 vB+GGPqoQqLQFI52ttg3hotG4EtgY3DA/4GZ9Buk2k9xfRenZJzvmc5KdoOXbVSMNJuVkeG0a0C
 C1WN9nemBPCGtCK5gpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We'll have to instrument some RISC-V translations, as well as the start
of a translation block, communicating with the associated trace encoder
in case we're running a trace session. The trace encoder needs to report
the first insn of the session so we'll start with that.

Unfortunately we've run out of bits in tb_flags, meaning we can't use
riscv_tr_init_disas_context() and riscv_get_tb_cpu_state() to
communicate whether we're running a trace session. One alternative would
be to fold the "trace is running" logic in each trace helper. That would
make all code paths, regardless of even having a trace encoder
associated with the CPU, to check for trace encoder existence.

Another alternative, which is implemented here, is to add an additional
mirror flag 'trace_running' in CPURISCVState and turn it into a TCG
global 'cpu_trace_running'. Each trace helper call is gated via this
global, allowing us to skip calling trace helpers when we're not running
a trace session.

In case we end up increasing the size of tb_flags in the future we
should revisit this code and use tb_flags instead.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c    | 17 +++++++++++++++++
 hw/riscv/trace-encoder.h    |  4 ++++
 hw/riscv/trace-events       |  1 +
 target/riscv/cpu.h          |  2 ++
 target/riscv/helper.h       |  4 ++++
 target/riscv/meson.build    |  3 ++-
 target/riscv/trace_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 target/riscv/translate.c    | 10 ++++++++++
 8 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/trace_helper.c

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 37d882f66c..b6f0fc7e13 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -150,11 +150,15 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     uint32_t trTeEnable = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ENABLE);
     uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
                                                 INST_TRACING);
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
 
     if (!trTeActive) {
         te->enabled = false;
         te->trace_running = false;
         te->trace_next_insn = false;
+
+        env->trace_running = false;
         return;
     }
 
@@ -170,6 +174,7 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     }
 
     te->trace_running = trTeInstTracing ? true : false;
+    env->trace_running = te->trace_running;
 }
 
 static RegisterAccessInfo trencoder_regs_info[] = {
@@ -231,6 +236,8 @@ static const MemoryRegionOps trencoder_ops = {
 static void trencoder_reset(DeviceState *dev)
 {
     TraceEncoder *te = TRACE_ENCODER(dev);
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
 
     for (int i = 0; i < ARRAY_SIZE(te->regs_info); i++) {
         register_reset(&te->regs_info[i]);
@@ -239,6 +246,7 @@ static void trencoder_reset(DeviceState *dev)
     te->enabled = false;
     te->trace_running = false;
     te->trace_next_insn = false;
+    env->trace_running = false;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
@@ -266,6 +274,14 @@ static void trencoder_realize(DeviceState *dev, Error **errp)
     }
 }
 
+void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    trencoder->first_pc = pc;
+    trace_trencoder_first_trace_insn(pc);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
@@ -294,6 +310,7 @@ static const VMStateDescription vmstate_trencoder = {
         VMSTATE_UINT64(ramsink_ramstart, TraceEncoder),
         VMSTATE_UINT64(ramsink_ramlimit, TraceEncoder),
         VMSTATE_INT32(cpu_id, TraceEncoder),
+        VMSTATE_UINT64(first_pc, TraceEncoder),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 517675d062..2b3d9437ec 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -27,6 +27,8 @@ struct TraceEncoder {
     MemoryRegion reg_mem;
     uint32_t reg_mem_size;
 
+    uint64_t first_pc;
+
     hwaddr baseaddr;
     hwaddr dest_baseaddr;
     hwaddr ramsink_ramstart;
@@ -43,4 +45,6 @@ struct TraceEncoder {
 
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
 
+void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
+
 #endif
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 14e333fd9e..dc25377acf 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,6 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 # trace-encoder.c
 trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
 trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+trencoder_first_trace_insn(uint64_t pc) "pc 0x%" PRIx64
 
 # trace-ram-sink.c
 tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5ebf7f663e..372292f71f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -508,6 +508,8 @@ struct CPUArchState {
     uint64_t rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    bool trace_running;
 };
 
 /*
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..e80320ad16 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -128,6 +128,10 @@ DEF_HELPER_4(csrrw, tl, env, int, tl, tl)
 DEF_HELPER_2(csrr_i128, tl, env, int)
 DEF_HELPER_4(csrw_i128, void, env, int, tl, tl)
 DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
+
+/* Trace helpers (should be put inside ifdef) */
+DEF_HELPER_2(trace_insn, void, env, i64)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..564e2da5f2 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -26,7 +26,8 @@ riscv_ss.add(files(
   'm128_helper.c',
   'crypto_helper.c',
   'zce_helper.c',
-  'vcrypto_helper.c'
+  'vcrypto_helper.c',
+  'trace_helper.c'
 ))
 
 riscv_system_ss = ss.source_set()
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
new file mode 100644
index 0000000000..5a6d725f56
--- /dev/null
+++ b/target/riscv/trace_helper.c
@@ -0,0 +1,36 @@
+/*
+ * RISC-V Trace Support TCG helpers
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "trace.h"
+#include "exec/helper-proto.h"
+
+#ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+#endif
+
+#ifndef CONFIG_USER_ONLY
+void helper_trace_insn(CPURISCVState *env, uint64_t pc)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    if (te->trace_next_insn) {
+        trencoder_set_first_trace_insn(cpu->trencoder, pc);
+        te->trace_next_insn = false;
+    }
+}
+#else /* #ifndef CONFIG_USER_ONLY */
+void helper_trace_insn(CPURISCVState *env, uint64_t pc)
+{
+    return;
+}
+#endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 280ce48a1e..9dbc8649f0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -43,6 +43,9 @@ static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
 
+/* TODO: this should be a tb_flag instead of a global */
+static TCGv cpu_trace_running;
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
@@ -1341,6 +1344,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_insn(tcg_env, tcg_constant_i64(db->pc_first));
+    gen_set_label(skip);
 }
 
 static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
@@ -1465,4 +1473,6 @@ void riscv_translate_init(void)
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
                              "load_val");
+    cpu_trace_running = tcg_global_mem_new(tcg_env,
+                offsetof(CPURISCVState, trace_running), "trace_running");
 }
-- 
2.51.1


